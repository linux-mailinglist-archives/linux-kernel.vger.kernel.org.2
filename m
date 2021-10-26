Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E7443BDBE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 01:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbhJZXWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 19:22:49 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:43579 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhJZXWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 19:22:39 -0400
Received: by mail-ot1-f44.google.com with SMTP id y15-20020a9d460f000000b0055337e17a55so961097ote.10;
        Tue, 26 Oct 2021 16:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GgApLoxzfDo36zMw0fwuP9MEZGeeBiA63Das3gCl00Q=;
        b=dGLG1+fwfJCvHRdUFQ8cLRw0vXwroZ/Be/MZLbtf0TGMETgoQ73yIeePGSHaIbG4Ci
         paqIGuAUa3ZZa0fl9zBTd1PcyWnhu8BR34jwHRPPIRdy9zjFYI5nd+xGEkCdyBRWr9tp
         TBWxzTrSVKEE5eSgDho6LByMH3ZPEi2CDvDGmBZU1nFzIANZcoUuNC+PZYwkO2JpI34G
         8qGHIlfpJNGve9KUms4mI3Ep27kQTSo7fQXSvnPB/D6fsfJFRTQNCw8uY7QTa0uJlApE
         siEC5krmfqXbuBwOiZj22zju/mCpyrv8VuEkBIHZWwZvQ04PK3cGj60lR8cjJENHfY8p
         8Fww==
X-Gm-Message-State: AOAM532yOcQYxmVVos5l5nUkxs7l/+IlGslsgFwbd6IBz6kDfNZIy90z
        5nG+ci6gj1k8Bw5vKy9A0eOhbMB/nA==
X-Google-Smtp-Source: ABdhPJwR17hUwZQH4tGPyMzmf+w3kLDb599VGEDD71JrIEZ0o1tGb66W2AI2k2/qQ59llSF6BSv90w==
X-Received: by 2002:a9d:6081:: with SMTP id m1mr22728370otj.262.1635290415040;
        Tue, 26 Oct 2021 16:20:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j16sm5138612oig.29.2021.10.26.16.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:20:14 -0700 (PDT)
Received: (nullmailer pid 3502213 invoked by uid 1000);
        Tue, 26 Oct 2021 23:20:13 -0000
Date:   Tue, 26 Oct 2021 18:20:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, list@opendingux.net,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: Rename Ingenic CGU headers to
 ingenic,*.h
Message-ID: <YXiNLZ9ne8D8uv82@robh.at.kernel.org>
References: <20211016133322.40771-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016133322.40771-1-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 02:33:21PM +0100, Paul Cercueil wrote:
> Tidy up a bit the tree, by prefixing all include/dt-bindings/clock/ files
> related to Ingenic SoCs with 'ingenic,'.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2: Fix x1000-cgu.h and x1830-cgu.h incorrectly renamed to
>         x1000.h / x1830.h
> 
>  Documentation/devicetree/bindings/clock/ingenic,cgu.yaml      | 2 +-
>  Documentation/devicetree/bindings/display/ingenic,ipu.yaml    | 2 +-
>  Documentation/devicetree/bindings/display/ingenic,lcd.yaml    | 4 ++--
>  Documentation/devicetree/bindings/dma/ingenic,dma.yaml        | 2 +-
>  Documentation/devicetree/bindings/i2c/ingenic,i2c.yaml        | 2 +-
>  Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml    | 2 +-
>  .../devicetree/bindings/memory-controllers/ingenic,nemc.yaml  | 2 +-
>  .../devicetree/bindings/mips/ingenic/ingenic,cpu.yaml         | 2 +-
>  Documentation/devicetree/bindings/mmc/ingenic,mmc.yaml        | 2 +-
>  Documentation/devicetree/bindings/mtd/ingenic,nand.yaml       | 2 +-
>  Documentation/devicetree/bindings/net/ingenic,mac.yaml        | 2 +-
>  .../devicetree/bindings/nvmem/ingenic,jz4780-efuse.yaml       | 2 +-
>  Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml    | 2 +-
>  Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml | 2 +-
>  Documentation/devicetree/bindings/rng/ingenic,trng.yaml       | 2 +-
>  Documentation/devicetree/bindings/rtc/ingenic,rtc.yaml        | 2 +-
>  Documentation/devicetree/bindings/serial/ingenic,uart.yaml    | 2 +-
>  Documentation/devicetree/bindings/sound/ingenic,aic.yaml      | 2 +-
>  Documentation/devicetree/bindings/sound/ingenic,codec.yaml    | 2 +-
>  Documentation/devicetree/bindings/timer/ingenic,sysost.yaml   | 2 +-
>  Documentation/devicetree/bindings/timer/ingenic,tcu.yaml      | 2 +-
>  Documentation/devicetree/bindings/usb/ingenic,musb.yaml       | 2 +-
>  arch/mips/boot/dts/ingenic/jz4725b.dtsi                       | 2 +-
>  arch/mips/boot/dts/ingenic/jz4740.dtsi                        | 2 +-
>  arch/mips/boot/dts/ingenic/jz4770.dtsi                        | 2 +-
>  arch/mips/boot/dts/ingenic/jz4780.dtsi                        | 2 +-
>  arch/mips/boot/dts/ingenic/x1000.dtsi                         | 2 +-
>  arch/mips/boot/dts/ingenic/x1830.dtsi                         | 2 +-
>  drivers/clk/ingenic/jz4725b-cgu.c                             | 2 +-
>  drivers/clk/ingenic/jz4740-cgu.c                              | 2 +-
>  drivers/clk/ingenic/jz4760-cgu.c                              | 2 +-
>  drivers/clk/ingenic/jz4770-cgu.c                              | 2 +-
>  drivers/clk/ingenic/jz4780-cgu.c                              | 2 +-
>  drivers/clk/ingenic/x1000-cgu.c                               | 2 +-
>  drivers/clk/ingenic/x1830-cgu.c                               | 2 +-
>  .../clock/{jz4725b-cgu.h => ingenic,jz4725b-cgu.h}            | 0
>  .../dt-bindings/clock/{jz4740-cgu.h => ingenic,jz4740-cgu.h}  | 0
>  .../dt-bindings/clock/{jz4760-cgu.h => ingenic,jz4760-cgu.h}  | 0
>  .../dt-bindings/clock/{jz4770-cgu.h => ingenic,jz4770-cgu.h}  | 0
>  .../dt-bindings/clock/{jz4780-cgu.h => ingenic,jz4780-cgu.h}  | 0
>  .../dt-bindings/clock/{x1000-cgu.h => ingenic,x1000-cgu.h}    | 0
>  .../dt-bindings/clock/{x1830-cgu.h => ingenic,x1830-cgu.h}    | 0
>  42 files changed, 36 insertions(+), 36 deletions(-)
>  rename include/dt-bindings/clock/{jz4725b-cgu.h => ingenic,jz4725b-cgu.h} (100%)
>  rename include/dt-bindings/clock/{jz4740-cgu.h => ingenic,jz4740-cgu.h} (100%)
>  rename include/dt-bindings/clock/{jz4760-cgu.h => ingenic,jz4760-cgu.h} (100%)
>  rename include/dt-bindings/clock/{jz4770-cgu.h => ingenic,jz4770-cgu.h} (100%)
>  rename include/dt-bindings/clock/{jz4780-cgu.h => ingenic,jz4780-cgu.h} (100%)
>  rename include/dt-bindings/clock/{x1000-cgu.h => ingenic,x1000-cgu.h} (100%)
>  rename include/dt-bindings/clock/{x1830-cgu.h => ingenic,x1830-cgu.h} (100%)

Acked-by: Rob Herring <robh@kernel.org>

However, this will be a pain to merge if there are any new users coming 
in during the merge window. If not, then Stephen can just take this. If 
there are, then at the end of the merge window is the best time. For 
that to work, you need to track when all dependent changes are merged 
and we need to agree who will pick this up. I usually have fixes from 
breakages in the merge window anyways.

Rob
