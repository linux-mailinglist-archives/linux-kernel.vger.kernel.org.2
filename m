Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB510433BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhJSQV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhJSQVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:21:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CD3C06161C;
        Tue, 19 Oct 2021 09:19:12 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j21so8845054lfe.0;
        Tue, 19 Oct 2021 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y/ir8B+CRjd7AbSm8xRiASD6VJaRvehWpboSeQHSKr0=;
        b=lDzUnE6R4ShOTmwd7+5L6htw4nTAhGpC0cd5bWY7sN+bsu/JAeJuFfcAb7Gf3wTSAh
         rHSQkgrvoBeDJmrcZozfmSpdUuTHCfBio/Nqr5hYuHqBZ6t0kG1bNIQ8Ndr3nwigHdOA
         4E/uXzEiDmjl0xBByI4RAclePvKwF8IKDWph9QDxcjjdRhan6NLKtdU4VjKlAwTsZH0H
         VOSulbosmdVsxQysWp+aPne9epy3FtIbaQhVb6HJ5Te5qdGo9kXIeQjmdclLXipBc5di
         Lp+JJOBf1qJbylh71cn9pgh3g9aukLvIw53GWDXq3nKzhfzLJdX8KRYjfGgm/eo75QqV
         pACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/ir8B+CRjd7AbSm8xRiASD6VJaRvehWpboSeQHSKr0=;
        b=MFfHptKK6mI3t40MHACLuy0CnvmjUUC6uVbXH5tGETKbg7UzPsN8l8hdlWlnLEyesR
         /zaHjppdAQqSHK/oGWE3GhWlCrp4mDh8KgTygXdf/ASDqPjWY5oznmguq7rvRLUfzwkA
         /tlbgDaf704VWQ7fPXtrZ/qyNvc4B0KoiztNzunUfsmWLh5zvLDNHNDVxfdv+EMLBmzd
         0sGmrIfTzvoZILjhrpOE666UchowbrlQiZz92x6nfxrgNCOfGTsasXu46MttlOI0ZaJK
         VKjMGug3DkFiQoiiVM0KNLJvYPtBSofMgXDav7b3L1EsC9IrPNZEt87AxvYjcgv7b7tu
         BiTQ==
X-Gm-Message-State: AOAM530QNkRVZ533X6q0mCAfCDk2SeMyT/LUW6kEZ6l+/u/+Jc+WxclG
        JK+nGKn+/Usozy00eUcqJ2h7nAF577s=
X-Google-Smtp-Source: ABdhPJzaRZbIea0EpRKCfnXRs315sDhS9xgp2ZkNCyeepbohG9WUcKgb1KHDVnnOVqLetH1FZpxI9w==
X-Received: by 2002:a05:6512:228d:: with SMTP id f13mr6942682lfu.610.1634660350680;
        Tue, 19 Oct 2021 09:19:10 -0700 (PDT)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id w26sm2114545ljh.18.2021.10.19.09.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 09:19:10 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Alex Bee <knaerzche@gmail.com>
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
        Trevor Woerner <twoerner@gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: rk3328: add gpu opp table
Date:   Tue, 19 Oct 2021 18:19:08 +0200
Message-ID: <4362028.GryP8xLggj@archbook>
In-Reply-To: <5a667361-940e-4653-ac3e-ae26a70255a2@gmail.com>
References: <20211016154548.29555-1-twoerner@gmail.com> <3352474.ljgn2FL0hr@archbook> <5a667361-940e-4653-ac3e-ae26a70255a2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 19. Oktober 2021 17:52:05 CEST Alex Bee wrote:
> Am 18.10.21 um 18:49 schrieb Nicolas Frattaroli:
> > On Samstag, 16. Oktober 2021 17:45:44 CEST Trevor Woerner wrote:
> >> Add an operating-points table and cooling entry to the GPU on the
> >> RK3328 SoC to improve its performance. According to its datasheet[1]
> >> the maximum frequency of the Mali-450 MP2 GPU found on the RK3328 SoC
> >> is 500MHz.
> >>
> >> On my rock64 device, under x11, glmark2-es2 performance increased from
> >> around 60 to just over 100. Same device running glmark2-es2 under
> >> wayland/weston improved from just over 100 to just over 200.
> >>
> >> [1] https://rockchip.fr/RK3328%20datasheet%20V1.2.pdf
> >>
> >> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> >> ---
> >>   arch/arm64/boot/dts/rockchip/rk3328.dtsi | 26 ++++++++++++++++++++++=
+-
> >>   1 file changed, 25 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> >> b/arch/arm64/boot/dts/rockchip/rk3328.dtsi index 8c821acb21ff..5e1dcf7=
1e414
> >> 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
> >> @@ -532,7 +532,8 @@ map0 {
> >>   					cooling-device =3D <&cpu0
> > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >>   							 <&cpu1
> > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >>   							 <&cpu2
> > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> -							 <&cpu3
> > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >> +							 <&cpu3
> > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> >> +							 <&gpu
> > THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> >>   					contribution =3D <4096>;
> >>   				};
> >>   			};
> >> @@ -617,6 +618,29 @@ gpu: gpu@ff300000 {
> >>   		clocks =3D <&cru ACLK_GPU>, <&cru ACLK_GPU>;
> >>   		clock-names =3D "bus", "core";
> >>   		resets =3D <&cru SRST_GPU_A>;
> >> +		operating-points-v2 =3D <&gpu_opp_table>;
> >> +		#cooling-cells =3D <2>;
> >> +	};
> >> +
> >> +	gpu_opp_table: gpu-opp-table {
> >> +		compatible =3D "operating-points-v2";
> >> +
> >> +		opp-200000000 {
> >> +			opp-hz =3D /bits/ 64 <200000000>;
> >> +			opp-microvolt =3D <1100000>;
> >> +		};
> >> +		opp-300000000 {
> >> +			opp-hz =3D /bits/ 64 <300000000>;
> >> +			opp-microvolt =3D <1100000>;
> >> +		};
> >> +		opp-400000000 {
> >> +			opp-hz =3D /bits/ 64 <400000000>;
> >> +			opp-microvolt =3D <1100000>;
> >> +		};
> >> +		opp-500000000 {
> >> +			opp-hz =3D /bits/ 64 <500000000>;
> >> +			opp-microvolt =3D <1100000>;
> >> +		};
> >>   	};
> >>
> >>   	h265e_mmu: iommu@ff330200 {
> >=20
> > As for whether this works as described on a ROCK64 for glmark2-es2-wayl=
and:
>=20
> The probably most "convenient" and also future-proof solution upstream=20
> for that is to define voltage ranges =E1 la
>=20
>=20
>=20
> opp-200000000 {
>=20
> 		opp-hz =3D /bits/ 64 <200000000>;
>=20
> 		opp-microvolt =3D <950000 950000 1150000>;
>=20
>=20
>=20
> };
>=20
> and so on.
>=20
> And then adapt the regulator-min-microvolt of the logic regulator like
>=20
> vdd_logic: DCDC_REG1 {
>=20
> 	regulator-name =3D "vdd_logic";
>=20
> 	regulator-min-microvolt =3D <1050000>;
>=20
> ...
> };
>=20
> That way all opp-points will be taken, but its ensured, that vdd_log=20
> never goes below 1.05 V
>=20
> >=20
> > Tested-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> >=20
> > There is some stuff worth noting that LibreELEC does on this SoC[1]:
> >=20
> > 1. they use 1.05V for all OPPs up to and including 400 MHz
> > 2. they run 500 MHz at 1.15V instead (though 1.10V seemed to work for b=
oth of
> > us)
>=20
> That might be true for your boards, but note that the required voltage=20
> is per "leakage level" defined in efuse bits - something we do not=20
> support for Rockchip upstream currently - see [1]

Thank you for the insight.

If we had the efuse bits, is there an already existing mechanism to only
enable the 500 MHz OPP if the chip happens to be one of those able to do
it at 1.10V?

Something like only having opp-microvolt-L1 defined and having the opp
be ignored if we're not an L1 chip.

>=20
> > 3. they disable 500 MHz because 1.15V was apparently too high for rkvde=
c.
> >=20
> > 3 is currently not very relevant because mainline Linux has no rkvdec n=
ode in
> > the rk3328 dtsi, and we're not running at 1.15V.
> >=20
> > I've decided to add their rkvdec dtsi patch[2] on top anyway, and saw no
> > complaints from the rkvdec module while glmark2-es2-drm was running. Ho=
wever,
> > it's not like I tried to actually hardware decode video while it was ru=
nning
> > because the userspace situation still won't let me without compiling en=
tirely
> > too much stuff from git. Though the rkvdec module was loaded and presen=
t.
> You will see no complaints from the module , but you will see the SoC=20
> crashing if both is running at the same time - see rkvdec-opp-table=20
> downstream [2]

I did end up finding an old arm64 build I had of a patched ffmpeg that works
for the current kernel, and

  ffmpeg -hwaccel drm -i file -f null -

was running stably with glmark2-es2-drm running at the same time, though I
also did not have an rkvdec OPP table.

Either way, thank you for clearing things up. I guess the easiest way to
get more useful clocks on mainline right now is to disable the 500 MHz
OPP and define them all in the way you've suggested.

Regards,
Nicolas Frattaroli

>=20
> [1]=20
> https://github.com/rockchip-linux/kernel/blob/develop-4.4/arch/arm64/boot=
/dts/rockchip/rk3328.dtsi#L750-L751
>=20
> [2]=20
> https://github.com/rockchip-linux/kernel/blob/develop-4.4/arch/arm64/boot=
/dts/rockchip/rk3328.dtsi#L840-L867
>=20
> Alex
>=20
> > [1]: https://github.com/LibreELEC/LibreELEC.tv/commit/
> > 9a6be0d36ba7ff3c3d5df798682d47a1de594ac0
> > [2]: https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Roc=
kchip/
> > patches/linux/default/linux-1001-v4l2-rockchip.patch#L860-L935
> >=20
> >=20
> >=20
> >=20
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> >=20
>=20
>=20




