Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA02401165
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 21:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbhIETl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 15:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhIETl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 15:41:57 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ED0C061575;
        Sun,  5 Sep 2021 12:40:53 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bt14so8972959ejb.3;
        Sun, 05 Sep 2021 12:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktfu/1dI5EriLXE5SDDhbia+REVwP853qU4CVNxHqiI=;
        b=Rxqu+vGpTbt09JrFUNrJ30s3AmbCiII568kBUn+HM9TNaW3Nup6GeXNLCRvBVD85AV
         uHOfgUPXJL/wvBjFiuGcTIrmKZyJ+R6pw5IKhP9gSOEDs+glsWckJ6NsGbH9w5mEu5Ir
         w8bdZ8EU2f4eHWxa/nLSHjIWYyKKr25er9bV38pGOY9QdIGNESJQyHdpIsdoFM9kRVBM
         RFVYf43E8HRO0i8oHWVEr9KxpUCkvN+6xqbQWqNZgE2JCj5gVYrwCOh3ThJnabAHcY+B
         Z2QZAyFg+V8WIqV8TtBhcLiTiTdUipy+THlZ3so7j8lP+hlaDCAGFeclPeBGDLLe98jp
         km7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktfu/1dI5EriLXE5SDDhbia+REVwP853qU4CVNxHqiI=;
        b=CmC2Fige5fM0YoKz6b3t3Y9NYLItgc0y3WDkgAtmjy0pNIIkR/aShWc1EZNnPLE9Gd
         jyu9GiK7CTr/MFq3n4S5vfGrP+HM7oIoPFsB5qGOSIbC75cVJVHB9KOfsUW6mzOEgydZ
         HWmx3DY4KDPso0HBiu1/EHmjuoh+gUJvJ9Aa3xfIJ8UoUivWoPSupHE7h7/Yfcg1el/P
         P0XEJ6oLM8Z6ZnCr8rLSIW5Jl+59tVySO2yqP1TDw0Cgv7ZCXBhHNIaao0eegqa4bYr7
         hLRdlva6xpyyJrqWNM6sbfaP5DQadx3eZQPLjWzdiooOoxq6leeIo7S7ovly36FRfKLM
         EhWg==
X-Gm-Message-State: AOAM530KBueygfPN31XigyoXp6h/HGW4m6he8vwo+0gxdx9sKzV0owrB
        D8NfuHvXbEPMHp7ly+k1U5I=
X-Google-Smtp-Source: ABdhPJx9zcPWC1IOubNX+p+CD/pSo0c5XPiVDRow8ByiiVq9DoQW/HLDz1WVsBR2IX2OinBEA9EdJQ==
X-Received: by 2002:a17:906:1615:: with SMTP id m21mr10662315ejd.279.1630870852109;
        Sun, 05 Sep 2021 12:40:52 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id o19sm3263530edr.18.2021.09.05.12.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Sep 2021 12:40:51 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, codekipper@gmail.com, peron.clem@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: dts: sunxi: h3/h5: Fix I2S2 node
Date:   Sun, 05 Sep 2021 21:40:50 +0200
Message-ID: <4281589.rpS0U0bY3j@kista>
In-Reply-To: <20210905192628.206061-1-jernej.skrabec@gmail.com>
References: <20210905192628.206061-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Dne nedelja, 05. september 2021 ob 21:26:28 CEST je Jernej Skrabec napisal(a):
> I2S2 controller has RX DMA channel according to documentation.
> 

Sorry for mistake. This is not true. Documentation doesn't have RX DMA 
documented (I2S2 is connected to HDMI).

Marcus, do you remember if loopback mode actually works on H3, with DMA 
enabled? Maybe DMA is there, just undocumented. Some SoCs (H6, R40) have RX 
DMA channel documented, even though it's used for HDMI TX only, and others 
don't (A64, H3, H5).

Anyway, I got report that I2S driver from 5.14 onwards can't register 
controller anymore due to missing RX DMA channel. So either driver or DT has 
to be fixed.

Please disregard this patch for now.

Best regards,
Jernej

> Add it.
> 
> Fixes: cd7c897821a0 ("arm: dts: sunxi: h3/h5: Add I2S2 node")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-
h5.dtsi
> index c7428df9469e..bd26f2059220 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -670,9 +670,9 @@ i2s2: i2s@1c22800 {
>  			interrupts = <GIC_SPI 15 
IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&ccu CLK_BUS_I2S2>, <&ccu 
CLK_I2S2>;
>  			clock-names = "apb", "mod";
> -			dmas = <&dma 27>;
> +			dmas = <&dma 27>, <&dma 27>;
>  			resets = <&ccu RST_BUS_I2S2>;
> -			dma-names = "tx";
> +			dma-names = "tx", "rx";
>  			status = "disabled";
>  		};
>  
> -- 
> 2.33.0
> 
> 


