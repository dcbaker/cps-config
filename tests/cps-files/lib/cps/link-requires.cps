{
    "name": "link-requires",
    "cps_version": "0.12.0",
    "version": "1.0.0",
    "requires": {
        "full": null,
        "multiple-components": null
    },
    "components": {
        "default": {
            "type": "interface",
            "link_requires": [
                "full"
            ]
        },
        "nested": {
            "type": "interface",
            "link_requires": [
                "multiple-components:link-requires"
            ]
        }
    },
    "default_components": [
        "default"
    ]
}
