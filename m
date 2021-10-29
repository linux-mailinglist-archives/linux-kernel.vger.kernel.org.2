Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3110C4404B6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 23:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhJ2VRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 17:17:47 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:39616 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbhJ2VRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 17:17:43 -0400
Received: by mail-oi1-f171.google.com with SMTP id n11so7060391oig.6;
        Fri, 29 Oct 2021 14:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=sgH+xfQQun/T1q5TEyK5JVkL2nNXV/yTPlo0T/9exOo=;
        b=2U2lDAD6dkysDu+rsw4IxGE+h6nx1qppCB+4cTJwOWi+IW6vif/vHIHDaO8WmsWCj4
         XLu1nZkeheweP1J9cbyZUjUFCR8NVdoFz8EtuOBv1QOTzPDzs3uaWQUjTVh30rH5ZaUS
         3Lix47grFxW+wQ+1ycUi8pnrr1SsGF9ZNo7ukHFcPmkseSHrQZJMjqhxM/oOiZv9clM+
         3dWVjjfiXdj2HOQw4ilWZFWWF3MK++2xHgMRapHNB+j1CftTfcJf4ZjC9qafS0PuUJQ4
         eZBkLWJbZrViYUg5ovrsMZ14Vmn36NPYkQ68tVOEFlaLPOzYpl72d+LNNvRqGoDJFRRP
         8/yw==
X-Gm-Message-State: AOAM530KYTeNGFy1G2zq/9C6ONSGe5zLTR/I+PYTRZVLhDL6mTEgSyJ9
        x67rn0c11Lagu9pP7wdVFg==
X-Google-Smtp-Source: ABdhPJw6XFkSbvjRrn148G/ujZSxZmSDgqGMI/0mCVkDsmKEVLTZFos8weawXD1ekMeBj89OF7QlNQ==
X-Received: by 2002:aca:aacc:: with SMTP id t195mr15715685oie.118.1635542114218;
        Fri, 29 Oct 2021 14:15:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a71sm2144955ooc.10.2021.10.29.14.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 14:15:13 -0700 (PDT)
Received: (nullmailer pid 3221285 invoked by uid 1000);
        Fri, 29 Oct 2021 21:15:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     ~okias/devicetree@lists.sr.ht, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        angus@akkea.ca, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20211029175418.83899-1-david@ixit.cz>
References: <20211029175418.83899-1-david@ixit.cz>
Subject: Re: [PATCH] dt-bindings: sound: gtm601: convert to YAML
Date:   Fri, 29 Oct 2021 16:15:10 -0500
Message-Id: <1635542110.119595.3221284.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 19:54:17 +0200, David Heidelberg wrote:
> Convert GTM601 binding to the YAML format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/sound/gtm601.txt      | 19 -----------
>  .../devicetree/bindings/sound/gtm601.yaml     | 33 +++++++++++++++++++
>  2 files changed, 33 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/gtm601.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/gtm601.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1548195


gsm_codec: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/omap3-gta04a3.dt.yaml
	arch/arm/boot/dts/omap3-gta04a4.dt.yaml
	arch/arm/boot/dts/omap3-gta04a5.dt.yaml
	arch/arm/boot/dts/omap3-gta04a5one.dt.yaml

sound-wwan-codec: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dt.yaml
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dt.yaml
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dt.yaml

