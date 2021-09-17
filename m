Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 939DA40FFF7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 21:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344515AbhIQTvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 15:51:16 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:36522 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbhIQTuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 15:50:19 -0400
Received: by mail-ot1-f53.google.com with SMTP id n2-20020a9d6f02000000b0054455dae485so9094874otq.3;
        Fri, 17 Sep 2021 12:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=3gQjKHWGeSaNy0zNHDDdRtrkC55mNwG/C1oDpHceP3I=;
        b=CPrhuDOkqF1V/yd3s/pbYJR2Qd8LJ5wKOP5dfG/ezSjHVg0RwqAGl2fCxDBvgzNY8/
         +jEP1PwnlWH0MPIDCbkT7seJjDJJOv0Mnxw9UckyhsmiXWStTHXWfr55YnE93FcELrG7
         +UBysiXafQ/0vz6+KtscOshQnEKH64X5X6oF5Zs9qjFlEuvZ4ScMdbExGt6+NcJnFLtY
         fEJLaVoKrlmasd/ofF78DJ6840yG88C1QaNfW5reLRaQ1YI0jiG21jd1JgeEQoI5H+DG
         2bplz3LhX4AphuMzpiBSd88mgmH9J3JbUT5uJ+Y7MyXm5hQkvs/unO8++LsunoPPYgd/
         L0aQ==
X-Gm-Message-State: AOAM533IJijQraokX30otCckx8LnXR17BPBrZdBKyj6YFbO0LiPIQR1/
        9At7SkoK8MwlL1DV7zp58g==
X-Google-Smtp-Source: ABdhPJy5+oo+xYyHM4w2v8HzUSH8bMucIspozMZvm12g4qt941b2U46m/yQ/lBUldmpITyvyem7xPA==
X-Received: by 2002:a9d:6506:: with SMTP id i6mr11103575otl.207.1631908136365;
        Fri, 17 Sep 2021 12:48:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b3sm1743581oie.1.2021.09.17.12.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 12:48:55 -0700 (PDT)
Received: (nullmailer pid 2025326 invoked by uid 1000);
        Fri, 17 Sep 2021 19:48:54 -0000
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     linux-imx@nxp.com, linux-phy@lists.infradead.org,
        l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, kishon@ti.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, shawnguo@kernel.org, devicetree@vger.kernel.org,
        galak@kernel.crashing.org
In-Reply-To: <1631845863-24249-3-git-send-email-hongxing.zhu@nxp.com>
References: <1631845863-24249-1-git-send-email-hongxing.zhu@nxp.com> <1631845863-24249-3-git-send-email-hongxing.zhu@nxp.com>
Subject: Re: [PATCH 2/4] dt-bindings: phy: add imx8 pcie phy driver support
Date:   Fri, 17 Sep 2021 14:48:54 -0500
Message-Id: <1631908134.299718.2025325.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2021 10:31:01 +0800, Richard Zhu wrote:
> Add dt-binding for the standalone i.MX8 PCIe PHY driver.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/phy/fsl,imx8-pcie-phy.yaml       | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml: properties:fsl,refclk-pad-mode: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	Additional properties are not allowed ('enum' was unexpected)
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml: properties:fsl,refclk-pad-mode: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	0 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	1 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	2 is not of type 'string'
		hint: A vendor string property with exact values has an implicit type
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml: ignoring, error in schema: properties: fsl,refclk-pad-mode
warning: no schema found in file: ./Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.example.dt.yaml:0:0: /example-0/pcie-phy@32f00000: failed to match any schema with compatible: ['fsl,imx8mm-pcie-phy']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1529140

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

