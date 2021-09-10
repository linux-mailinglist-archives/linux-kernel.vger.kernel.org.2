Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD40B4072CA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 23:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbhIJVEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 17:04:55 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:39788 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhIJVEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 17:04:53 -0400
Received: by mail-oi1-f176.google.com with SMTP id v2so4753261oie.6;
        Fri, 10 Sep 2021 14:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=93MTRoNLekpPYpdVTnaXdlw7Z2oeG1fPoIGkCvvG1zk=;
        b=T1x0P/8r+DTLbJbfMJZLgyThjW5jN1vvhZKVcyEx758GYusAISMoGYLfMOLo0cenHX
         89CoDakHKNJP5/T1YPhQuPr3ZYaO2F50YrSZpyaPHpuNlmIlrqOWJA6nutnH9UI/HNEY
         gWVeyQgqsb7z1Kx+MR90bEXhgcks4lGYFnFz1JuhEABBi/II92B3rrs83DiTemGQEajz
         pxDCV+7ui9HRKUgLXNQex83m07FcwM58oTw8nuIAhEQbk/1WMvOEHRk9W4vzobVTYxUe
         qU9d+q0UV35ou8mv5xeubOUWT56qkANevNjlO5Wx/oe0Ptne8PNtt7eDfmYM1eDEffWD
         Ku2w==
X-Gm-Message-State: AOAM532oYL88tYHKeLYHFI1ziQ7m7P1vzYzQCR4HZmujFRMvH8JlRPcU
        a5ZUzQSJOGa635/sx/YsRgyz/AhSHw==
X-Google-Smtp-Source: ABdhPJwDnTZxh9BtBOWryNxOzuJ0wKs7zxT57XESsLdt0lVfTNBKekkc0rljzNNpDbrR6fAdFsH8Sg==
X-Received: by 2002:aca:4e08:: with SMTP id c8mr5914242oib.79.1631307822009;
        Fri, 10 Sep 2021 14:03:42 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h19sm1500061otr.75.2021.09.10.14.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 14:03:41 -0700 (PDT)
Received: (nullmailer pid 3377646 invoked by uid 1000);
        Fri, 10 Sep 2021 21:03:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     Oskar Senft <osk@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
In-Reply-To: <20210910130337.2025426-1-osk@google.com>
References: <20210910130337.2025426-1-osk@google.com>
Subject: Re: [PATCH] dt-bindings: hwmon: Add nct7802 bindings
Date:   Fri, 10 Sep 2021 16:03:40 -0500
Message-Id: <1631307820.617689.3377645.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2021 09:03:37 -0400, Oskar Senft wrote:
> Document bindings for the Nuvoton NCT7802Y driver.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> ---
>  .../bindings/hwmon/nuvoton,nct7802.yaml       | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml: properties:nuvoton,rtd-modes:type: 'anyOf' conditional failed, one must be fixed:
	'stringlist' is not one of ['array', 'boolean', 'integer', 'null', 'number', 'object', 'string']
	'stringlist' is not of type 'array'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml: properties:nuvoton,rtd-modes:type: 'stringlist' is not one of ['boolean', 'object']
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml: properties:nuvoton,rtd-modes: 'oneOf' conditional failed, one must be fixed:
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml: properties:nuvoton,rtd-modes: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	Additional properties are not allowed ('type' was unexpected)
		hint: A vendor string property with exact values has an implicit type
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml: properties:nuvoton,rtd-modes: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	'boolean' was expected
		hint: A vendor boolean property can use "type: boolean"
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml: ignoring, error in schema: properties: nuvoton,rtd-modes: type
warning: no schema found in file: ./Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.yaml
Documentation/devicetree/bindings/hwmon/nuvoton,nct7802.example.dt.yaml:0:0: /example-0/i2c/nct7802@28: failed to match any schema with compatible: ['nuvoton,nct7802']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1526504

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

