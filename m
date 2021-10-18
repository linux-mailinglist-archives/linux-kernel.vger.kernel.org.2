Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B04043251A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 19:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbhJRRey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 13:34:54 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:41482 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbhJRRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 13:34:51 -0400
Received: by mail-ot1-f43.google.com with SMTP id v2-20020a05683018c200b0054e3acddd91so737494ote.8;
        Mon, 18 Oct 2021 10:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2U8hBROJcAqw7cvJsslFtgA/mHZAvox2fIGmr8/9UKc=;
        b=gWXWqH+BO+vEiSsONPvHYwL1SSld5R0tfQxgvsztcb+WHD5fhxBfvjrmpz228dii55
         SlO82qLKvzsUrUuMgRFnEA945LkD+aY6Vuu+aoD0DuWyZz0o3KOgEqno2olNbVeDPlmx
         0qnwqAbfFbVlL/UGxp8Tg3/HlztBEeAZBYaimVboHNZHgL3Rvoc8na/leU6jQg+3GHI3
         UIG9r18d3LxjZZrvnyabqLQMg1BYTg7l3xPHjmjnNF1sJ+irAlctUud90sdkvNfdYcW7
         BoHa5MQKn85vSFz1Ibax/zyMfrWqlcb926Sx8jyUYJDbqZpQiBnYVQ6mFtVn/T/ICy/F
         D2mg==
X-Gm-Message-State: AOAM531L3OyoO8Lr15csq+8sQjJowmPi9rY+u604t3OyaBv+dGPRb4ak
        QOzu7F8T07klpS4ypMu1mQ==
X-Google-Smtp-Source: ABdhPJyRN4OujdXL5CfZdoqzic+ABwBDXCL5MO8pWWd5f8xybeyhVcEjN/oNd+bSkL/32ctN/iwwiw==
X-Received: by 2002:a9d:4113:: with SMTP id o19mr1013451ote.228.1634578360032;
        Mon, 18 Oct 2021 10:32:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r4sm3129771oti.27.2021.10.18.10.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 10:32:39 -0700 (PDT)
Received: (nullmailer pid 2612840 invoked by uid 1000);
        Mon, 18 Oct 2021 17:32:38 -0000
From:   Rob Herring <robh@kernel.org>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org
In-Reply-To: <20211018114046.25571-1-etienne.carriere@linaro.org>
References: <20211018114046.25571-1-etienne.carriere@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: Add OP-TEE transport for SCMI
Date:   Mon, 18 Oct 2021 12:32:38 -0500
Message-Id: <1634578358.516648.2612839.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021 13:40:45 +0200, Etienne Carriere wrote:
> Introduce compatible "linaro,scmi-optee" for SCMI transport channel
> based on an OP-TEE service invocation. The compatible mandates a
> channel ID defined with property "linaro,optee-channel-id".
> 
> Cc: devicetree@vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v2:
>  - Define mandatory property linaro,optee-channel-id
>  - Rebased on yaml description file
> 
> Changes since v1:
>  - Removed modification regarding mboxes property description.
> ---
>  .../bindings/firmware/arm,scmi.yaml           | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.yaml: patternProperties:^protocol@[0-9a-f]+$:properties:linaro,optee-channel-id: 'description' is a required property
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.yaml: patternProperties:^protocol@[0-9a-f]+$:properties:linaro,optee-channel-id: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('maxItems' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.yaml: patternProperties:^protocol@[0-9a-f]+$:properties:linaro,optee-channel-id: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.yaml: patternProperties:^protocol@[0-9a-f]+$:properties:linaro,optee-channel-id: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi.yaml: ignoring, error in schema: patternProperties: ^protocol@[0-9a-f]+$: properties: linaro,optee-channel-id
warning: no schema found in file: ./Documentation/devicetree/bindings/firmware/arm,scmi.yaml
Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml:0:0: /example-1/firmware/scmi: failed to match any schema with compatible: ['arm,scmi']
Documentation/devicetree/bindings/firmware/arm,scmi.example.dts:175.39-178.19: ERROR (duplicate_label): /example-2/firmware/scmi/protocol@14: Duplicate label 'scmi_clk' on /example-2/firmware/scmi/protocol@14 and /example-0/firmware/scmi/protocol@14
Documentation/devicetree/bindings/firmware/arm,scmi.example.dts:180.40-186.19: ERROR (duplicate_label): /example-2/firmware/scmi/protocol@13: Duplicate label 'scmi_dvfs' on /example-2/firmware/scmi/protocol@13 and /example-0/firmware/scmi/protocol@13
ERROR: Input tree has errors, aborting (use -f to force output)
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/firmware/arm,scmi.example.dt.yaml] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1542547

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

