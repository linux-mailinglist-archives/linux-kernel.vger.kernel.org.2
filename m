Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECC6432421
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 18:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbhJRQvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 12:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbhJRQvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 12:51:25 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42C7C06176A;
        Mon, 18 Oct 2021 09:49:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x27so1073920lfu.5;
        Mon, 18 Oct 2021 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SH0kHI8q3C1h2KdyVaYHMPS3/G5O58tP5UqzMH9EraU=;
        b=Eo1YvWYvah4YBUTfa9fZS9I5YsX6WULFGARs9Szh/UiAoIktedhxl07McLaAjTp93h
         QGSSMJhNPl70xrmINq9T1rO+IvppGW+XWLFVhJaYc7wZhD3dGXYo8jvuJ4GH2NFD+LlK
         TAxj45c3VHqomjxZggSgM1fvjFMBUyAXqUeoEFVBnrBvUobeeNdqnIlUFUPoIq7AJPb/
         r7m74Za5dNMs3B/EiIkK2un9BdsbDec5EMhu9dc5EoZvibN6Oiquc4CyII24ZVFu1j6a
         zAqesXip+V+4F6lq06aSipK9/XfRZat1IFMQGBFuSLWSOWQ50qyHGYMLpyiiIYT2XiB2
         vCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SH0kHI8q3C1h2KdyVaYHMPS3/G5O58tP5UqzMH9EraU=;
        b=67F43igg8qMOi0wizUf7VNYNu9kHaAEa2Cnc6NPX1E41S/KWigg/d+Xr/4p/iizVjO
         BRgErfPzoDGBVLIUYyF1fgLDXQzZuEXNHN46pjVxn2O2AreFBJX/J0WAuoSZ5/HYC8WB
         sv6gR4zd4WEXbRkhjFxf7j41+jG1Y0rWaTCjoT5HhNHvcBgDzulriI/J++flAjFCLxgU
         vwTiBkYoWGFKvtVi03oqqdKDzTXgYXT8W++CO8qSKQxe9GOz7FfUswaypko8z70Yo4LC
         Auc73fHURUe7HrVuke9BiAQl/uSsJkVxWsw98hXV214YuWfaqfMsYaHoO8fK0jBzzciq
         shzw==
X-Gm-Message-State: AOAM533raQ1hupWl9Vg0Crw22w3K0MdtpJm3gGZwcekbqu/0o+3Z+xeJ
        WunRyy5mHYEMnw3tvfD0swTXdqH1lqs=
X-Google-Smtp-Source: ABdhPJw4/WfZL1h2TWZmw+Hog8tO0U9Q77OHUMcEIva5sYFlT867+XKGpU1XH6ZIr+kTks78S378gQ==
X-Received: by 2002:ac2:4f02:: with SMTP id k2mr778622lfr.455.1634575752192;
        Mon, 18 Oct 2021 09:49:12 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id r17sm1444035lfe.107.2021.10.18.09.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 09:49:11 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        David Wu <david.wu@rock-chips.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Cameron Nemo <cnemo@tutanota.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        Trevor Woerner <twoerner@gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: rk3328: add gpu opp table
Date:   Mon, 18 Oct 2021 18:49:09 +0200
Message-ID: <3352474.ljgn2FL0hr@archbook>
In-Reply-To: <20211016154548.29555-1-twoerner@gmail.com>
References: <20211016154548.29555-1-twoerner@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Samstag, 16. Oktober 2021 17:45:44 CEST Trevor Woerner wrote:
> Add an operating-points table and cooling entry to the GPU on the
> RK3328 SoC to improve its performance. According to its datasheet[1]
> the maximum frequency of the Mali-450 MP2 GPU found on the RK3328 SoC
> is 500MHz.
> 
> On my rock64 device, under x11, glmark2-es2 performance increased from
> around 60 to just over 100. Same device running glmark2-es2 under
> wayland/weston improved from just over 100 to just over 200.
> 
> [1] https://rockchip.fr/RK3328%20datasheet%20V1.2.pdf
> 
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 26 +++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> b/arch/arm64/boot/dts/rockchip/rk3328.dtsi index 8c821acb21ff..5e1dcf71e414
> 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> @@ -532,7 +532,8 @@ map0 {
>  					cooling-device = <&cpu0 
THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>  							 <&cpu1 
THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>  							 <&cpu2 
THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> -							 <&cpu3 
THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +							 <&cpu3 
THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&gpu 
THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>  					contribution = <4096>;
>  				};
>  			};
> @@ -617,6 +618,29 @@ gpu: gpu@ff300000 {
>  		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
>  		clock-names = "bus", "core";
>  		resets = <&cru SRST_GPU_A>;
> +		operating-points-v2 = <&gpu_opp_table>;
> +		#cooling-cells = <2>;
> +	};
> +
> +	gpu_opp_table: gpu-opp-table {
> +		compatible = "operating-points-v2";
> +
> +		opp-200000000 {
> +			opp-hz = /bits/ 64 <200000000>;
> +			opp-microvolt = <1100000>;
> +		};
> +		opp-300000000 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			opp-microvolt = <1100000>;
> +		};
> +		opp-400000000 {
> +			opp-hz = /bits/ 64 <400000000>;
> +			opp-microvolt = <1100000>;
> +		};
> +		opp-500000000 {
> +			opp-hz = /bits/ 64 <500000000>;
> +			opp-microvolt = <1100000>;
> +		};
>  	};
> 
>  	h265e_mmu: iommu@ff330200 {

As for whether this works as described on a ROCK64 for glmark2-es2-wayland:

Tested-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

There is some stuff worth noting that LibreELEC does on this SoC[1]:

1. they use 1.05V for all OPPs up to and including 400 MHz
2. they run 500 MHz at 1.15V instead (though 1.10V seemed to work for both of 
us)
3. they disable 500 MHz because 1.15V was apparently too high for rkvdec.

3 is currently not very relevant because mainline Linux has no rkvdec node in 
the rk3328 dtsi, and we're not running at 1.15V.

I've decided to add their rkvdec dtsi patch[2] on top anyway, and saw no 
complaints from the rkvdec module while glmark2-es2-drm was running. However, 
it's not like I tried to actually hardware decode video while it was running 
because the userspace situation still won't let me without compiling entirely 
too much stuff from git. Though the rkvdec module was loaded and present.

[1]: https://github.com/LibreELEC/LibreELEC.tv/commit/
9a6be0d36ba7ff3c3d5df798682d47a1de594ac0
[2]: https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Rockchip/
patches/linux/default/linux-1001-v4l2-rockchip.patch#L860-L935



