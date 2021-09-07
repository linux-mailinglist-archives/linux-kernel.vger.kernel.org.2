Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58534029E0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 15:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344746AbhIGNlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 09:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344513AbhIGNlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 09:41:14 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C1FC061575;
        Tue,  7 Sep 2021 06:40:08 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso12814946otp.1;
        Tue, 07 Sep 2021 06:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8rny3XFWF7pa2pDSX8KlfgiSTf4jqiy1msfwyRKNEMM=;
        b=joh0VySyNJjTMMEvpPuW2/4SKp85ZFLjn3UdYj1LXDN2u4E4/OSR2j0IsPngnGDcPB
         KQRx4pfeTZxXD/26Jm+pM3myPqWGfXSNxeinqnwYqBbW8qiwmV5XD5zzpI4cT96hTUPq
         /r29AB2NGz+0P82YP3Cj/ReooNbqcgs0+6yF1KlnYPa8ZgowQ9TCWcJ+1Z9vCMCJdPUJ
         NjnXoOacDkKPwHLZBGEeSYkv/vGasYDR/Hp5pf2LI23QuJAxSebBXB8cgjGuwWrc8wL3
         0UwEhLyG/z0gOYel6s/q14kdBFKheKHcGhcoQQH5dHWQLhZdtcosY9HlHHclQ01znwzT
         nCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8rny3XFWF7pa2pDSX8KlfgiSTf4jqiy1msfwyRKNEMM=;
        b=e4Pw+jONekJ7oTpMbbZW28OVYbrEErBpeziteUPQIkDfjDC6opihQ30CrZSOpTrmog
         oam7o1htWxtlnaKYheqF+x8Q6wuQhtDLX0DxcZ9tnN+uYBHLtIBbG9XU2luSCpqk/njR
         9rI1P9UKCrVvmxmfIqqpGreD4DGApf+HCnaUlT80uk8UB8NesYBl8pRzGoVvcfz+C1mQ
         J6X/23CyZJ2RU44ztYzTKMFB4VKJjsxatQ5Nu+YqA8ua4vriMRgSadEF/+DXzIeviwqm
         vp71Fw66ZGrKn5KfST2Q5NHlCdJy5mstmhi+xEFrIk8gsEw8SyPsJNA1IXe0DdL1Afqv
         QQGA==
X-Gm-Message-State: AOAM530fB13c01hCd4Ai+3/LrfORLY4I9UcX8kXWcJl+VEP0Cg456SYO
        mEiTO6bdggYDYcWcrFyrY84=
X-Google-Smtp-Source: ABdhPJwXKdBRiNy5D6vxkacdqM/AZTpB7wFh5IkbkrOKUTkniJTNBs2hnoaCEAhPHhWua+2EVA9mFw==
X-Received: by 2002:a9d:6c04:: with SMTP id f4mr14788360otq.185.1631022007366;
        Tue, 07 Sep 2021 06:40:07 -0700 (PDT)
Received: from wintermute.localdomain (cpe-76-183-134-35.tx.res.rr.com. [76.183.134.35])
        by smtp.gmail.com with ESMTPSA id y14sm564180oti.69.2021.09.07.06.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 06:40:06 -0700 (PDT)
Date:   Tue, 7 Sep 2021 08:40:06 -0500
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] arm64: dts: rockchip: add analog audio on Quartz64
Message-ID: <20210907134006.GA11287@wintermute.localdomain>
References: <20210903231536.225540-1-frattaroli.nicolas@gmail.com>
 <20210903231536.225540-5-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903231536.225540-5-frattaroli.nicolas@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2021 at 01:15:36AM +0200, Nicolas Frattaroli wrote:
> On the Quartz64 Model A, the I2S1 TDM controller is connected
> to the rk817 codec in I2S mode. Enabling it and adding the
> necessary simple-sound-card and codec nodes allows for analog
> audio output on the PINE64 Quartz64 Model A SBC.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> ---
>  .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 35 ++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> index a244f7b87e38..3a87c0240b30 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> @@ -58,6 +58,20 @@ led-diy {
>  		};
>  	};
>  
> +	rk817-sound {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,format = "i2s";
> +		simple-audio-card,name = "Analog RK817";
> +		simple-audio-card,mclk-fs = <256>;
> +
> +		simple-audio-card,cpu {
> +			sound-dai = <&i2s1_8ch>;
> +		};
> +		simple-audio-card,codec {
> +			sound-dai = <&rk817>;
> +		};
> +	};
> +
>  	vcc12v_dcin: vcc12v_dcin {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc12v_dcin";
> @@ -199,8 +213,13 @@ rk817: pmic@20 {
>  		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
>  		clock-output-names = "rk808-clkout1", "rk808-clkout2";
>  
> +		#sound-dai-cells = <0>;
> +		clock-names = "mclk";
> +		clocks = <&cru I2S1_MCLKOUT_TX>;
> +		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
> +		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
>  		pinctrl-names = "default";
> -		pinctrl-0 = <&pmic_int_l>;
> +		pinctrl-0 = <&pmic_int_l>, <&i2s1m0_mclk>;
>  		rockchip,system-power-controller;
>  		wakeup-source;
>  		#clock-cells = <1>;
> @@ -389,9 +408,23 @@ regulator-state-mem {
>  				};
>  			};
>  		};
> +
> +		rk817_codec: codec {

This node should be optional and can probably be removed. It's only
used when there are extra parameters to pass to the codec (such as 
rockchip,mic-in-differential). Leaving it in shouldn't hurt anything
though.

> +		};
> +
>  	};
>  };
>  
> +&i2s1_8ch {
> +	status = "okay";
> +	rockchip,trcm-sync-tx-only;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&i2s1m0_sclktx
> +		     &i2s1m0_lrcktx
> +		     &i2s1m0_sdi0
> +		     &i2s1m0_sdo0>;
> +};
> +
>  &mdio1 {
>  	rgmii_phy1: ethernet-phy@0 {
>  		compatible = "ethernet-phy-ieee802.3-c22";
> -- 
> 2.33.0
> 
