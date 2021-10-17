Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D364F430A0E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 17:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343978AbhJQPb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 11:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343951AbhJQPbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 11:31:55 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3342C061769;
        Sun, 17 Oct 2021 08:29:45 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id l7so13259429qkk.0;
        Sun, 17 Oct 2021 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aLWe12uJoW6Tr5t0/eOb90iUkYk4LWBq+lz5QePH0ZA=;
        b=lW5kUj1LCQPu2V3bcYvjd95sC8TGGgImzX4v4V/tyjO5APgC38CtSXtQ+XU/JT2jss
         HWelOjDgxa7CnQvveWUOzL+8H/nSbMN7f4ej9CANeej3XhT5s5wagSev5IIv0ViVF9+b
         nV9Fk/RBIpp12PD/bOZPaKj4V9VEYp7Njq4O4Ehc1fk3EWBrr7NbGmqVMu5mSbpld32i
         /8SWYp/EglZ4eChS07/GNIrZK55lJxXmmPK9WlAcqQuOysP4Xx4zrtFAXAHXqWR/nY+a
         bZbatphFvicregPmC5JCOvLmO8Xk4QLBGSyE0tn/xK9AEfsQ8x/cQmnIKdsuXprXaW6u
         swDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aLWe12uJoW6Tr5t0/eOb90iUkYk4LWBq+lz5QePH0ZA=;
        b=kQDSDlT0RjJkurLOh0deiCFvpHkuSEs/kfB0xKi7s9it86ygFTTf9tmoOTpyc2W/ug
         pzXgmJIkMC1D8nb7JDimC3Sor+P1feStxd45T7tp0ERhiFZ9s8GgWUzLNmAm9Kx7kdHZ
         WJ4XrIeVG+2mG1gcM136cFlcp00/lmcHIr98OueLCJ7+vF487p5p/pvHHmQaLBw0GBVL
         7ebBXtUCtq9yd36lnbqkYLEMqofzmt89c9+g8lnyS3fXVSULMNR1Z9Z4ZvogNoCK5DnY
         AokmWTZmMaDXPRGmXJ8OAU1vCU2nwgyoFfGOV3clxYQpzdqUu7NTGwlrgpOO/LcAHzni
         8HcQ==
X-Gm-Message-State: AOAM5300UPtNFI3VA0SCJgmZtIlQnMV990sh4wNR+4MHkkmjTiisqaAt
        CoS25a9DvC+6IekifBoUgIt/hjTXgKo=
X-Google-Smtp-Source: ABdhPJxqdMeMcw+CKtvbbjwvd/DudRlYdHzlDWFzGekL9ySOs+WuDB4kjdWIfextDpic29N24Hx0nQ==
X-Received: by 2002:a37:ae43:: with SMTP id x64mr18843402qke.55.1634484584758;
        Sun, 17 Oct 2021 08:29:44 -0700 (PDT)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id o130sm5256949qke.123.2021.10.17.08.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 08:29:44 -0700 (PDT)
Date:   Sun, 17 Oct 2021 11:29:41 -0400
From:   Trevor Woerner <twoerner@gmail.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
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
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: dts: rk3328: add gpu opp table
Message-ID: <20211017152941.GA33697@localhost>
References: <20211016154548.29555-1-twoerner@gmail.com>
 <67c7c3c6-b946-a6bc-24fd-85f56bcec7f3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67c7c3c6-b946-a6bc-24fd-85f56bcec7f3@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2021-10-16 @ 10:45:04 PM, Johan Jonker wrote:
> On 10/16/21 5:45 PM, Trevor Woerner wrote:
> > Add an operating-points table and cooling entry to the GPU on the
> > RK3328 SoC to improve its performance. According to its datasheet[1]
> > the maximum frequency of the Mali-450 MP2 GPU found on the RK3328 SoC
> > is 500MHz.
> > 
> > On my rock64 device, under x11, glmark2-es2 performance increased from
> > around 60 to just over 100. Same device running glmark2-es2 under
> > wayland/weston improved from just over 100 to just over 200.
> > 
> > [1] https://rockchip.fr/RK3328%20datasheet%20V1.2.pdf
> > 
> > Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3328.dtsi | 26 +++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> > index 8c821acb21ff..5e1dcf71e414 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> > +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> > @@ -532,7 +532,8 @@ map0 {
> >  					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >  							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >  							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > -							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > +							 <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >  					contribution = <4096>;
> >  				};
> >  			};
> > @@ -617,6 +618,29 @@ gpu: gpu@ff300000 {
> >  		clocks = <&cru ACLK_GPU>, <&cru ACLK_GPU>;
> >  		clock-names = "bus", "core";
> >  		resets = <&cru SRST_GPU_A>;
> > +		operating-points-v2 = <&gpu_opp_table>;
> > +		#cooling-cells = <2>;
> > +	};
> > +
> 
> > +	gpu_opp_table: gpu-opp-table {
> 
> After the conversion to YAML of the Operating Performance Points(OPP)
> binding the operating-points-v2 property expects the nodename to have
> the '^opp-table(-[a-z0-9]+)?$' format.
> 
> make ARCH=arm64 dtbs_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/opp/opp-v2.yaml

Thanks, I wasn't aware.

> > +		compatible = "operating-points-v2";
> > +
> > +		opp-200000000 {
> > +			opp-hz = /bits/ 64 <200000000>;
> > +			opp-microvolt = <1100000>;
> > +		};
> > +		opp-300000000 {
> > +			opp-hz = /bits/ 64 <300000000>;
> > +			opp-microvolt = <1100000>;
> > +		};
> > +		opp-400000000 {
> > +			opp-hz = /bits/ 64 <400000000>;
> > +			opp-microvolt = <1100000>;
> > +		};
> > +		opp-500000000 {
> > +			opp-hz = /bits/ 64 <500000000>;
> > +			opp-microvolt = <1100000>;
> > +		};
> >  	};
> 
> opp-microvolt has the same value for every node vs. table below?

On page 1 of the schematic for the rock64
https://files.pine64.org/doc/rock64/ROCK64_Schematic_v3.0_20181105.pdf is a
table ("Power Timing") showing BUCK1 at 1.1V. I interpreted this to mean that
VDD_LOG should always be at 1.1V, regardless of frequency.

> See also previous discussion:
> 
> https://lore.kernel.org/linux-rockchip/3c95c29b-6c07-5945-ac22-d683997e1ca0@arm.com/
> 
> Is that now fixed/checked?

I wasn't aware of the previous/on-going discussion regarding a gpu opp table
for this SoC. Perhaps that explains my suspicions? I couldn't help wonder why
the frequency is always reported as 163840000 even when I have an opp table
that only has the 500MHz entry?

I'll investigate whether I can prove or disprove the scaling is actually
occurring?

Best regards,
	Trevor
