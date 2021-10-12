Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4CF42A55C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbhJLNVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:21:42 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:34443 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbhJLNUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:20:33 -0400
Received: by mail-oi1-f180.google.com with SMTP id z11so29054362oih.1;
        Tue, 12 Oct 2021 06:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=XPmmclCS7vZ6DokRzDb336rjZzihsBvWwNeGDGl5d50=;
        b=JAazxbAiG10po5ofY2PRC4frt2izlss8h072wX0ntSR3UCS76jaUlyDmLi+pjStuV4
         VuJtXE9VTTPGhTcp04WJjsKimIhQqdJxZAqlS5/Z5/4YMPVRA7JpHoOJRG5MCKoMWMWE
         FWdpWsOVOjHdWT0xd/+HY8m7EklpDHaSsaNJ6cbDobG0kr4reGETEZ/JwD2nweUrVZH4
         nUFeDtafwHD9kEV6YF7lXWSKIaCMBi8J5o+2c0W45o7/6ggR1k5K682QFbytplRaP3u5
         F6dEiEtBKlA3Gvh3t5Gs8cYjJIXpuAUa/3dvkk8PKvbLCG0TRdwv9IuUVvkv9yTPnPPC
         Gx+Q==
X-Gm-Message-State: AOAM530W9p2cyM0bvm+6YoF2S7qJd3S4+sjjC3hAeLPhE2IfY0XO6ADX
        ZrrA0aHYCciD4y2KIJtoQA==
X-Google-Smtp-Source: ABdhPJys0d+0o8rxci0ZomJH/ChF9hDpAJ4YAfswM6BilnElES9fYjqV9AjrxvmQtIuSc+Q3g4fPzw==
X-Received: by 2002:aca:ac0b:: with SMTP id v11mr3481527oie.155.1634044710555;
        Tue, 12 Oct 2021 06:18:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s10sm2326572oib.58.2021.10.12.06.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:18:29 -0700 (PDT)
Received: (nullmailer pid 2661234 invoked by uid 1000);
        Tue, 12 Oct 2021 13:18:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     shawnguo@kernel.org, linux-phy@lists.infradead.org,
        galak@kernel.crashing.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, tharvey@gateworks.com, kishon@ti.com,
        linux-imx@nxp.com, l.stach@pengutronix.de, vkoul@kernel.org
In-Reply-To: <1634028078-2387-3-git-send-email-hongxing.zhu@nxp.com>
References: <1634028078-2387-1-git-send-email-hongxing.zhu@nxp.com> <1634028078-2387-3-git-send-email-hongxing.zhu@nxp.com>
Subject: Re: [PATCH v3 2/9] dt-bindings: phy: add imx8 pcie phy driver support
Date:   Tue, 12 Oct 2021 08:18:29 -0500
Message-Id: <1634044709.029189.2661233.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 16:41:11 +0800, Richard Zhu wrote:
> Add dt-binding for the standalone i.MX8 PCIe PHY driver.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../bindings/phy/fsl,imx8-pcie-phy.yaml       | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.example.dts:30.32-33 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:385: Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1441: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1539660

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

