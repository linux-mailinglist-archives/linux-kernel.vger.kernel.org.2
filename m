Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB4043CBB7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242437AbhJ0OO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:14:59 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:40545 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242406AbhJ0OO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:14:57 -0400
Received: by mail-oi1-f169.google.com with SMTP id n63so3610817oif.7;
        Wed, 27 Oct 2021 07:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=vfM2rth3vQBvi54BPZNfTBIvZz8fdXl3sKPEL8Q3JAA=;
        b=Uy8w/eB6eaUrCyb54E6DujTAisy/P54RT6YWm2KHgw1IGiT29iroYITmPDV52K08+J
         Ie4MhBa1j8wZCtCjp9Um+00PX0OQ42wpCVHYV2Ws0+2tb+gF1WcB0JpQHusPyud9avdz
         UldFkzZTSnjOWPjHDUpWErPA3ZaIiNyP4K96yDcfaNfQCqjlIObcvc51wq8dANrmSIxw
         o2DMtGztW+O7BKXX1JQ9fxuJm+3xkd68rVSMlIV0B2nwIB7uAXEzlhfiqpNoSQvc/Snj
         QFApZBMEXFlj0MW6ICi0JIdKDLlDvolmERl1xr8weErgdCzRAuYuOm1khfu00p/DeiUw
         YAyw==
X-Gm-Message-State: AOAM531JkA4t0us7Xx8I2vZyalF7mGtD6NU/Ya32GAlpy1nzCmUO1eWV
        16f/MwhQQUjcjo1UQjO4f7RxZz8sDQ==
X-Google-Smtp-Source: ABdhPJwPCdmnTBRsRL+SPwp3S47duSdyQhf973QacpbBr22I+oVye5RueNfagxE+iyIwYk9wGrav/g==
X-Received: by 2002:a54:4f1d:: with SMTP id e29mr3785660oiy.179.1635343951319;
        Wed, 27 Oct 2021 07:12:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f14sm16805ots.51.2021.10.27.07.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:12:30 -0700 (PDT)
Received: (nullmailer pid 862173 invoked by uid 1000);
        Wed, 27 Oct 2021 14:12:28 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     Nathan Rossi <nathan.rossi@digi.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211027074212.690611-2-nathan@nathanrossi.com>
References: <20211027074212.690611-0-nathan@nathanrossi.com> <20211027074212.690611-2-nathan@nathanrossi.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: hwmon: ti,ina2xx: Add ti,shunt-gain property
Date:   Wed, 27 Oct 2021 09:12:28 -0500
Message-Id: <1635343948.059457.862172.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 07:42:12 +0000, Nathan Rossi wrote:
> From: Nathan Rossi <nathan.rossi@digi.com>
> 
> Add a property to the binding to define the selected shunt voltage gain.
> This specifies the range and accuracy that applies to the shunt circuit.
> This property only applies to devices that have a selectable shunt
> voltage range via PGA or ADCRANGE register configuration.
> 
> Signed-off-by: Nathan Rossi <nathan.rossi@digi.com>
> ---
> Changes in v2:
> - Added binding for shunt-gain
> ---
>  Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml: properties:ti,shunt-gain: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('enum' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml: properties:ti,shunt-gain: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	1 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	2 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	4 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	8 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml: ignoring, error in schema: properties: ti,shunt-gain
warning: no schema found in file: ./Documentation/devicetree/bindings/hwmon/ti,ina2xx.yaml
Documentation/devicetree/bindings/hwmon/ti,ina2xx.example.dt.yaml:0:0: /example-0/i2c/power-sensor@44: failed to match any schema with compatible: ['ti,ina220']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1546789

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

