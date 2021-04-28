Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DC436D429
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbhD1Iov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:44:51 -0400
Received: from mout.web.de ([217.72.192.78]:32805 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhD1Ios (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1619599419;
        bh=6oyXuRc/HyaQOUAoGH4BzDn08qL8+bPGEAEzFtgQee8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=PSe8w6+iPdNb9pSML6dkoGWEONTrwTkVhRTNHqSXhblL2u2IBifLvn9TUzZ1rzZa2
         gh5CE8fl/DCFtLiRU2E8wBh/cF8UB1Ao9IDL76ghRo7v+MaZunECFBxUYtRP4ws3HP
         bf6iumkBTgUB00UZGGL8eGfW1aLDHpTyLcWhbYRw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.70.1] ([46.114.137.249]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgibW-1l5wXP28dQ-00h9An; Wed, 28
 Apr 2021 10:43:39 +0200
Subject: Re: [PATCH] arm64: dts: rockchip: include uhs support for rockpro64
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "jbx6244@gmail.com" <jbx6244@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CWXP265MB2680938B222248792AC205F9C4419@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <97bcbcde-9ccf-f9cc-ef10-36cbd582825a@web.de>
 <CWXP265MB2680159B5F44B014FA544E89C4409@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
From:   Soeren Moch <smoch@web.de>
Message-ID: <8466ba81-7334-d23c-8496-b3d11adcd595@web.de>
Date:   Wed, 28 Apr 2021 10:43:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CWXP265MB2680159B5F44B014FA544E89C4409@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:rI5NXxMS8vc1KqOWBuSEaRYXQILgcVXz4XXWfSf7usOe+o2UYL/
 32svAj4SutZK2NxYNKw1sudZOr7ZxroEgtTHyl7Tqn/0ui1PbL/UFv7SVuvXxF3jaDZM2S+
 BOQV/C+lyJ8SyZisVPBFSz4nt0YTtlgHLXAvxWflWskCjndUjw2ynMaYEjwKJXWdkAtfBuD
 MAU0eS0O+TDZxkcbvednQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xjfoxz2hrlU=:NMfVgpSc3Ihcp8cpoROheQ
 lZyJMrT9pvTsMigU48ZOJWkDkyH35UxgribY2Wd0KVLIHsu821/cy5EFPPpa1Cm0LjlwUpw6U
 le88EZNz2UytA66V+U7TUWobPAP3rWSarpU1kc7BXqwgdHInQRlnwGTRaHIHsXo1dQcQL7fWy
 m/jB0vBk1FT79RKU58c8G8V3XHydczZzTQO4+1Zagp+TLimkkCstuxoJIXC1KRqX1jTcWkYUP
 hlrvLl1vxEd/PiQZzkS65CfUfz/aDi+0iuNiqj7BtfsT2i0JqlHGb+NKfZn2BJvjrvQI21Fja
 kesDVlSYjeJMfjjoLsbnDEOthjN6HA15QHXfkbbVIjtABBSIPnsBnlPwLuiw6vnje5ZdOqtyS
 Bmoj7l6FZZq8kTFg1oTNozqJVktD6lCWxjNdMCnHyOd/0lh7AVra4rJXJ8oxK83DyJN58FIOe
 KhcwxVSDri+/IFwKImwKAoctJBjqXLq69loj97h6DwVMePLrsldoya31O4bUGXFyBiuNzeaUa
 csuJK8CiLAOITfTSib4Aja/0087FJebnhrnEkG5vR7pBx9dVQJnZrwWFSVkfdQqdYR1DC9Pi2
 9JrsJFltSStnguzU20sT2eIIsGq8crD3D7UQUITbJ5QB6Dxo2sPPsBFVTr1aBSggWmiQoBjUf
 svnSjxZtwsyxEkJZ045ydXHhFSPT/x/XFHnNIVr3CIg+Z5hF4XcMqpihKCmtavHgAT4wERtfT
 6prwK/JvQ0MeDL1D3JDGqk8vhfKKQinxjh9stnMeUIhVjHgsPBZCnjD8YDJy0d0+2jxZgzFAi
 XVmsPe7anqwjcH8x/mUlAykhVS/l2xTz0O8wihDq9fYlLmxgQYhH9O60r/zeGT/1eQs7sUOhh
 dnBzVi1GhPS/A4BfOYecsIi6r7RZo9I8Zhhxh2y3addgAFTgkPNOqfrcvjphuBaTj8ctiQgNV
 +mDfuFmObZ3B6pZfE4PguPYaKzx9tZxVe7vy+7SVZjxccxytbvvmTfvVCKXxU3+OAutW49mO9
 HkM9LqaQi2p7XCiJuLkLz3bv1gyKRIqRZJPfJ7Wa+zZSXmcmoUACoJkyQv6Z96AOblGDwUj98
 M6vYH8S3zbh9WAEuHf6jJN0YMhH/RTkMFZPpzsL+IV+LirXQYsrnd1/9ALiMOxfmEQ14NJDb1
 Rub+ZGF0L10IXDcc4G1xUVf/OaF4ybQJq2DIgIMU2EXMXiOBIUY8reSQHSrc2lELu0cYs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.04.21 08:28, Christian L=C3=B6hle wrote:
> Oh okay, I was not aware of this issue
> and have not encountered it yet.
> But wouldn't it be more appropriate
> to get u-boot to power cycle the host controller at boot?
This is not about power-cycling the host controller. We have to
power-cycle the SD card itself to switch it back to default speed and
3.3V operation. This is the mode the boot ROM expects.

Unfortunately there is no separate power switch for SD card power on
RockPro64. So we have to power-cycle the whole SoC. This obviously
cannot be done easily after reboot in u-boot, but can be done in trusted
firmware (TF-A, was called ATF before) at reboot. This is what I use on
my boards, see the hack in [1]. Rockchip seems to prefer soft reset,
maybe someone from Rockchip can comment on the exact reasons.

Regards,
Soeren


[1] https://github.com/s-moch/arm-trusted-firmware-rockpro64
>
>
> From: Soeren Moch <smoch@web.de>
> Sent: Tuesday, April 27, 2021 5:07 PM
> To: Christian L=C3=B6hle <CLoehle@hyperstone.com>; robh+dt@kernel.org <r=
obh+dt@kernel.org>; heiko@sntech.de <heiko@sntech.de>; jbx6244@gmail.com <=
jbx6244@gmail.com>; devicetree@vger.kernel.org <devicetree@vger.kernel.org=
>; linux-arm-kernel@lists.infradead.org <linux-arm-kernel@lists.infradead.=
org>; linux-rockchip@lists.infradead.org <linux-rockchip@lists.infradead.o=
rg>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] arm64: dts: rockchip: include uhs support for rockp=
ro64
> =C2=A0
> On 27.04.21 08:20, Christian L?hle wrote:
>> The DesignWare Host Controller has full UHS-I support, so use it.
> Enabling this UHS support makes 'reboot' hang when booting the RockPro64
> from SD card. It would work when booting from eMMC, or with a modified
> ATF which does a power cycle on reboot.
>
> But for general use it is not save to enable UHS support, or did I miss
> some recent changes?
>
> Regards,
> Soeren
>> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
>> ---
>> =C2=A0 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 1 +
>> =C2=A0 1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/=
arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
>> index 6bff8db7d33e..d22a489ec214 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
>> @@ -722,6 +722,7 @@ &sdmmc {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 max-frequency =3D <150000000=
>;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&sdmmc_clk &s=
dmmc_cmd &sdmmc_bus4>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0 sd-uhs-sdr104;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmmc-supply =3D <&vcc3v0_sd>=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vqmmc-supply =3D <&vcc_sdio>=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D "okay";
> Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> Managing Directors: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>

