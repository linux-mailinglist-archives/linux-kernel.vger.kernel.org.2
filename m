Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0413B4322
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhFYMbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:31:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:52903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhFYMbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624624112;
        bh=OSQyckPbw3HSVrcza1qfbGitHxWf8m8/W3YNrW4Ri7c=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Lumec2k3Atjmeyg0Xtc35ID9/eM0wr4cQc1xgM1rx1ts10cp/VzkYZqMPlsuAfGrY
         wNvExspkTaaSSeStaT90WpeBolFAGzQh1L4nma/OHPRVa9asx11EEySQ4T0l9/WW7Z
         YT9/IdK2peJ5TAwUoStOKRi83r45IN6MSQ7ab0xI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.157.219] ([217.61.157.219]) by web-mail.gmx.net
 (3c-app-gmx-bs66.server.lan [172.19.170.210]) (via HTTP); Fri, 25 Jun 2021
 14:28:32 +0200
MIME-Version: 1.0
Message-ID: <trinity-59bd4461-3429-4382-9754-90cf20287cad-1624624111998@3c-app-gmx-bs66>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Eric Woudstra <ericwouds@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Aw: Re:  Re: Re: [PATCH] Fix mt7622.dtsi thermal cpu
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Jun 2021 14:28:32 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <915b101a-6bea-ae96-78ed-d27fa5bfce3a@linaro.org>
References: <20210619121927.32699-1-ericwouds@gmail.com>
 <e30a2d01-a200-80cb-88d9-6aea62dd49f1@linaro.org>
 <56fb5540-fb86-4e6a-a596-1276026b37e5@gmail.com>
 <a4e41929-6ab4-fabb-741e-f25a5fd14e3b@linaro.org>
 <47261865-00e3-41eb-bb36-2b939f81f1e8@gmail.com>
 <fb633034-96e5-6165-b43f-290ae1a65cfd@linaro.org>
 <189b52d5-b103-43e1-a64f-1e627fbc75af@gmail.com>
 <173e6bab-9d21-eb28-9b91-a5f80c01fd03@linaro.org>
 <3dd22cf2-1186-4870-aa49-e5cddc18c6e9@gmail.com>
 <trinity-7580d955-3187-41e5-9297-1ac8f628a9d5-1624609003739@3c-app-gmx-bs66>
 <8b27246b-721e-fa0e-5c2b-b1b4b4d6fdd3@linaro.org>
 <trinity-2eb7c0ac-d9dc-446c-8907-69b5f4df6838-1624618996538@3c-app-gmx-bs66>
 <915b101a-6bea-ae96-78ed-d27fa5bfce3a@linaro.org>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:od0scxwbJ1nSJhIAUYPE2trywtLcZeB6ouz/UKD7WmKyMhXo6bKsskeKCb01sRHMI4NVM
 80RQFPsgXQFcaurpT5/Q+yWRD2Wy+g2vRu7Njs3I8rKk3KwxuEFeQ6bK5IF+sII9P3o4R0zTWaz3
 oBsUNXA4FS+kcqBNGUN6BX9uQyNreIgPu5NDmYs1vSF8HAOA587d2ZfQt6/VrfusmvDdoZyncRkB
 YXLs/gJ3ULx69KCAxsnlkVSpuT42Qs3yu2TOHrJhzBje8+0XKI52AewxkJnq8ysmaV+HiuGQ4f/r
 IE=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AvEMWffUDa4=:5Qe6+hxNliYMnd53d0bxNd
 RmiMDlmgGfPhgEbexzdxoIcXq2Iz6243smb0UmLokG5VUQhr2O2XChyXkaCok6wx+Xe/LOwJJ
 aGU/ZHtusv1AAhUnCoioqxjcpXvNeY9SCS6oR5Clq10ccCuE+L5Udw0NT9LRl3VHIJ+ay+s9I
 IC55+vL2/ixzw+wZ9aVC9d/XLIkBtUxUdDqTZ8Bo4gOz8mDb/leWLS39G3Ilbkih0A+7Blbuh
 Ek0ez9cUAN1lkCaS2DaffyxCrvkxiZLwVDWaf34at6IWQAPQDigDdIxzNGPtLOEg5itub84ix
 XmloSsSJGLLpz6JaK9dlWY2/NtOiPJ30WkfEgNCH4AekKWv8O0daQy3cd9+L3y0279iCnqfZ6
 hBQkaQOJzdv5N3wYQPeVJgLOYe1+G7qazooH1Lq64iD0wbUutcDpWHDzc5AFL4aj8C2gfgK29
 ZX8yYr3fVFV1k9QfSqCDkhbQ7GEXgdy3K2vpQJmMoImJBUGmzMBC2Bsiwi8llQwfedD0Lo4P6
 ZjeANm9/+DgTkJhnoI+/VpyB/MB7xY8I9Tv/hU46UvpEEOCfF4Hp/zZukyg+VzML+A/gGaPFO
 y8Vxm7vvFGdLyqv9iaTQGZKJDQyQTLS3RYZmlskOr2qewDoJfZD2LGJwgVVhAi4Rt5RVi2TJD
 gew1as39uC68Mqb3PLNrwvmJLsMtTnDRCznOnbWVp0MopBU2St6hgkp/IktbM+lJhGN0AmtPf
 NNHAkjnfMlulHtfI0DL0YVpwzdtDnNN+7ANiHU9YsS2yZnUYe4AwwsVQYJBnIeRscqXn2aZvd
 C4P1Fu3KyznNn+yxkuhS3kcOz58hduhCtHoWlEk2I/qgOD9lXk=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Freitag, 25=2E Juni 2021 um 13:47 Uhr
> Von: "Daniel Lezcano" <daniel=2Elezcano@linaro=2Eorg>

> > but we need to disable the passive trip as cpu-trotteling starts there=
=2E=2E=2Ethe higher temperature trips are currently not reached
>=20
> Sorry, can you rephrase it ? I'm not getting the point=2E

the problem currently is that passive is at 47degress Celsius and trottles=
 cpu, active (67=C2=B0C) and hot points are never reached this way=2E so at=
 least we need to change temperatures in dtsi, and maybe disable cpu-trotte=
ling on passive trip=2E imho fan will never start if it is in active and cp=
u is trottled before in passive

> > summary
> >=20
> > moving fan and cpu_thermal-override to bananapi-r64=2Edts
> >=20
> > passive-trip: cooling-device =3D <&cpu0/1 0 0> as in erics Patch
> > active trip: cooling-device =3D <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIM=
IT>;
> > the other 2 unchanged
> >=20
> > but i suggest changing the temperature points in mt7622 dtsi as this i=
s SoC specific
> >=20
> > so basicly:
> >=20
> > --- a/arch/arm64/boot/dts/mediatek/mt7622=2Edtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt7622=2Edtsi
> > @@ -143,13 +143,13 @@ cpu_thermal: cpu-thermal {
> >=20
> >                         trips {
> >                                 cpu_passive: cpu-passive {
> > -                                       temperature =3D <47000>;
> > +                                       temperature =3D <70000>;
>=20
> May be increase the passive temp to 75=C2=B0C=2E
>=20
> >                                         hysteresis =3D <2000>;
> >                                         type =3D "passive";
> >                                 };
> >=20
> >                                 cpu_active: cpu-active {
> > -                                       temperature =3D <67000>;
> > +                                       temperature =3D <80000>;
> >                                         hysteresis =3D <2000>;
> >                                         type =3D "active";
> >                                 };
>=20
> Move the active trip 'cpu_active' to mt7622-bananapi-bpi-r64=2Edts=2E an=
d
> set it to 70=C2=B0C in the mt7622-bananapi-bpi-r64=2Edts, so the fan wil=
l act
> before the cpu throttling=2E
>=20
> The behavior should be the following: The temperature reaches 70=C2=B0C,=
 the
> fan will start, if the temperature continues to increase, it will
> increase the speed=2E If the temperature reaches 75=C2=B0C, the fan is s=
till
> rotating at full speed but the cpu begins to be throttled=2E

passive to 75 and active lower to 70? is this as intended that active come=
s before passive?

mt7622-bananapi-bpi-r64=2Edts:

&cpu_thermal {
	trips {
		cpu_passive: cpu-passive {
			temperature =3D <75000>;
			hysteresis =3D <2000>;
			type =3D "passive";
		};

		cpu_active: cpu-active {
			temperature =3D <70000>;
			hysteresis =3D <2000>;
			type =3D "active";
		};
	};

	cooling-maps {
		map1 {
			trip =3D <&cpu_active>;
			cooling-device =3D <&fan0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
		};
	};
};


> AFAIU, it is a Cortex-A53 running @1=2E35GH, so except the board is in a
> black metal box under the sun, I don't see how we can reach this thermal
> limits=2E
>=20
> > @@ -170,8 +170,8 @@ cpu-crit {
> >                         cooling-maps {
> >                                 map0 {
> >                                         trip =3D <&cpu_passive>;
> > -                                       cooling-device =3D <&cpu0 THER=
MAL_NO_LIMIT THERMAL_NO_LIMIT>,
> > -                                                        <&cpu1 THERMA=
L_NO_LIMIT THERMAL_NO_LIMIT>;
> > +                                       cooling-device =3D <&cpu0 0 0>=
,
> > +                                                        <&cpu1 0 0>;
>=20
> You should keep it untouched=2E

then cpu is trottled at passive point (currently 47=C2=B0C) and imho fan d=
oes not start at active

> >                                 };

