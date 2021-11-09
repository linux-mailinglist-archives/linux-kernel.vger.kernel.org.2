Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E8B44B21B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 18:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241187AbhKIRqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 12:46:32 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:38823 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbhKIRqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:46:31 -0500
Received: by mail-oi1-f180.google.com with SMTP id r26so49025oiw.5;
        Tue, 09 Nov 2021 09:43:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=glkbpFZ64hsjBoehP9NBMZRV0DOCh6wrOfQ/SiMCrhU=;
        b=B/QDXLraPIJAGBRtaKfdFIHshHAR76AaXyX5SmhYVoPbGHXjDokisf4NaJSCExvL8N
         8bsklXwzUifCkKkS+MAGP1UgkwQNYkh71Ny6SSiwm6c2njeKiqZbNVDWF1LEIB0tHx4X
         qYwvnBk3D70dnq2u8/Pyf52orz94oV1ceR7YZWDwHx619xrC73lzeKsWWzE0VF3nNP1R
         PWdiMV+EyMXTbvSqjIgMgaHobp03L6rjamSNepnCaiWG8W7gi0OPCa6HEeeP5YgZyVMj
         Z+EYZOok8+VHyt2mrMBoDVqr9jMNedwWUXYSXKHkSLBCapUcnCTpHzbD5yZraIO8kwYQ
         kxGA==
X-Gm-Message-State: AOAM533GfbgCxSdFcxB5nFPFQDihgH9Wy1oiaxNRxNte9YwGrNovaTu+
        uSLvEZByH+J0QESgoHXHqg==
X-Google-Smtp-Source: ABdhPJxU4oV+8lwp0rYXCMUWKjd7BX9+2N+Jgwop8dtuEJ6dEY2c7KaI0A0OaOlINe6n3R6pdeSHTA==
X-Received: by 2002:a05:6808:3027:: with SMTP id ay39mr7427095oib.39.1636479825226;
        Tue, 09 Nov 2021 09:43:45 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y203sm7623790oia.1.2021.11.09.09.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 09:43:43 -0800 (PST)
Received: (nullmailer pid 2328639 invoked by uid 1000);
        Tue, 09 Nov 2021 17:43:43 -0000
Date:   Tue, 9 Nov 2021 11:43:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-kernel@vger.kernel.org, list@opendingux.net,
        devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: Rename Ingenic CGU headers to
 ingenic,*.h
Message-ID: <YYqzT6ZjyQPMisXE@robh.at.kernel.org>
References: <20211016133322.40771-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016133322.40771-1-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Oct 2021 14:33:21 +0100, Paul Cercueil wrote:
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
> 

Applied, thanks!

I'll let Stephen take patch 2 after rc1.

Rob
