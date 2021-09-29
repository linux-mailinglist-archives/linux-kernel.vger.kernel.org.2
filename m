Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53B8441C5F9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 15:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344321AbhI2NsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 09:48:19 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:34753 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344314AbhI2NsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 09:48:12 -0400
Received: by mail-ot1-f41.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so2929058otb.1;
        Wed, 29 Sep 2021 06:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=nMzKG9wRHnCRIa2M2qYDKtvL+zIQ3mmyPkGjzNoJMEY=;
        b=P0V0xaUI+NLbaQeqfueotrdveje5qT8ATpB8H3+ExzlnHU7SQFjoyym3L+KJ4DYng6
         rNdqPi7p0vxDwi1D7D5f0E3dvgZX/B/ZjlUFLCGijcprcLd+Tk1eUUpJuEoIlM/B8DCn
         wkotSOJVdqSxDANIBIRX5vYXuCg61FEAYBv0Qk4c+xDcMkKr5UApMQhaSh+eVgnNP2nz
         nziUStT3U6STrBMR6NG2Shmtn5WpzNmh2XfqNI5/QD+I7aB9Ynsg/ppkYzb2mP0CVHh/
         zw208WgT0PJrU2O2kox8tOhm5fF0PEDLzVXqB1t7MWV1kL586LxDsMt63Oszx027X5qJ
         x4XA==
X-Gm-Message-State: AOAM530NMRMWPo5IAdVSFdhZJcYuRNQ+BO7T3CcGUmyhPUFmxx4wTDxR
        UTRYm39kNEV9YCqHcTZLtA==
X-Google-Smtp-Source: ABdhPJwVxiefCTq42d5W8ok1vkxISQY/+VWRBykU2H3mzEKdwIgUf/W8FyAaSeigWhE5bEgZhRWXXA==
X-Received: by 2002:a9d:4e08:: with SMTP id p8mr94193otf.152.1632923190864;
        Wed, 29 Sep 2021 06:46:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y12sm452768otu.11.2021.09.29.06.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 06:46:30 -0700 (PDT)
Received: (nullmailer pid 3674447 invoked by uid 1000);
        Wed, 29 Sep 2021 13:46:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     chunkuang.hu@kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, p.zabel@pengutronix.de,
        linux-mediatek@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        devicetree@vger.kernel.org
In-Reply-To: <20210929094425.745-2-granquet@baylibre.com>
References: <20210929094425.745-1-granquet@baylibre.com> <20210929094425.745-2-granquet@baylibre.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: phy: Add binding for Mediatek MT8195 HDMI PHY
Date:   Wed, 29 Sep 2021 08:46:25 -0500
Message-Id: <1632923185.732480.3674446.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2021 11:44:22 +0200, Guillaume Ranquet wrote:
> Add bindings to describe Mediatek MT8195 HDMI PHY
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  .../phy/mediatek,mtk8195-hdmi-phy.yaml        | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-phy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-phy.yaml: properties:compatible: [{'const': 'mediatek,mt8195-hdmi-phy'}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
./Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-phy.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/phy/mediatek,mtk8195-hdmi-phy.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-phy.yaml: ignoring, error in schema: properties: compatible
warning: no schema found in file: ./Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-phy.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-phy.example.dt.yaml: example-0: hdmi-phy@11d5f000:reg:0: [0, 299233280, 0, 256] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml
Documentation/devicetree/bindings/phy/mediatek,mtk8195-hdmi-phy.example.dt.yaml:0:0: /example-0/hdmi-phy@11d5f000: failed to match any schema with compatible: ['mediatek,mt8195-hdmi-phy']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1534286

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

