Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCACE418876
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 13:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhIZL7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 07:59:43 -0400
Received: from mout.web.de ([217.72.192.78]:41241 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230200AbhIZL7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 07:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1632657470;
        bh=J4qoTt6C/OONDAY5IjSYz0lPj7Auvzjy0GBoisQgE8M=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Yl6uwEROqfriSQbyzGBfetI2dTB/WwLL+ZRGnbNeeqJTvi6+x52cDZDMHaojdvC//
         kj1BVHfYDyPkvZIt6aWKUVWNqpnMx3/gwjX4HPCkNm/LVtyCjuhnhxy5vMhDNUuaY0
         t7OezRYIJfl0E/RFKmtV/ys+kYRc/XxTxL454yMo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([94.217.148.121]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MYeuk-1mHjLg0w2E-00VSI5; Sun, 26
 Sep 2021 13:57:50 +0200
Subject: Re: [PATCH v4 6/6] arm64: dts: ti: iot2050: Add support for product
 generation 2 boards
To:     Nishanth Menon <nm@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bao Cheng Su <baocheng.su@siemens.com>,
        Chao Zeng <chao.zeng@siemens.com>
References: <cover.1631708830.git.jan.kiszka@siemens.com>
 <a4d6ab1dd1f5582b940ac25395eb878e683b3a38.1631708830.git.jan.kiszka@siemens.com>
 <20210922155843.gjn5aezf4lmgtn3d@undecided>
From:   Jan Kiszka <jan.kiszka@web.de>
Message-ID: <f6933a10-4fa9-1abc-fd3f-583a462eb306@web.de>
Date:   Sun, 26 Sep 2021 13:57:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210922155843.gjn5aezf4lmgtn3d@undecided>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E5Fz6ZE82zMpdm1ViHQmq9kNh6Wmi6mWUy79jsOhXxe86wbyxWB
 fpHfbJZygFCAPcE0InT9At7/y3HScb+Bic3VGC/s+ktgCo9DP4Qrkw+fCD1ssFZg4tV01q6
 mIxYye78jIEl8y/EKjDC2YED+2YHdc+8WwOfgHeyORcLLUhlClaK6kBZp5xoWgv5XYoQk6D
 PzRO82dSgPzUuF26GgwpA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1r+CAaYzQBY=:b8EwiE2S1eg81LufvSneUJ
 sNtQayMBz2HrW3m2s6X5vhItFUWGk9dbl9ySf22NF8iDErmLkMZRbpyRhfhoziG0950GRn/s2
 QPSAitGHmJTrke+njBApRyVxrs3RlBDdvFor/M+pitYhXeLOy+siEYBBxwxVF9hwJ1G+Ha1Q2
 9777g4zrsZ9T3sU2w6hbK09Wl+fmcJdkW+xdT2DcSYlcrZubzoUcwQIDEjiigQmRg57h9m+/c
 WzgT8yQXq9wa4kKDRPbmxumDTb2BwCekZoCUN5kTZbzZDoYtkngs6cBC2y/hlOfoUzKpTQrAQ
 mGhz6hHqWLmQBXD1jLi/KnXaDMzxyGD2lKiase9G7m63ZUEEv3cvIdEbn3H16LUF8C+GVzz0v
 ahyNRnctj6NrhYoPVjos2jzn8B58Cpxpel/HnrU0QRUhKwCKSkIBgpNaqdshCEynq64qQGisi
 QOibgjv7NzZxbcQ00hlTayaM9VyhugHRANekPhEJnkoF/lQ5QSLiooUhu2SI3dwn+JYH/Qk93
 Q2iGjBdCPkRWPC8uB0E7n2xZ8oSjiX9u7KEYL6l+mhM5OBp8Ev7GKbgSwoiAbYbBmXcwJ+y/r
 /Hy0lcIMU6+l0Q2+RCpfSUH6N3sNqR/0c4S9mRgue5ng/3nMCWdUcMeUmSx0IqL12fG0psPbS
 PPAaI9gxI6pHIoylXt7UVFF2ka9TzWkoMXHUstDOxCCTFZiEBrUzYTYhuHoUIZZmz8DZ/1bFS
 UO/xE8OTXmS14WmzpkyHZXjjTuj624aTK1g07O+5+ZrIZMvsOixV56Hiodac9e0G7XTt2pjwo
 TBS+gatEJ3Pu1nqkzN3XNfzG+GMgO+3RHbMdcxvdTOwmO8cbBgh75N11SWpfESM7ucOvWvnOt
 ci9+9YNRl8GgrT6BG3fGJUDUEdTPEtFuLSnhnicAYwop6JaANzaIPCq8T4vwtShLDRgjk51mz
 SUz3LHUf46Vuo/J9eRkp82PMikT3RTA2BVlaE6eKNENzFx17c5LcVtQbr6SewUNgPUvofTL4W
 70ca5KQxcPPws8zFoodvPRCyM92GReMWEfZJvXOsBdjPUxk+tWLhnW/1xHYAHnGE3dpGISlpX
 Pu+wWFZXmhxgjI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.21 17:58, Nishanth Menon wrote:
> On 14:27-20210915, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This adds the devices trees for IOT2050 Product Generation 2 (PG2)
>> boards. We have Basic and an Advanced variants again, differing in
>> number of cores, RAM size, availability of eMMC and further details.
>> The major difference to PG1 is the used silicon revision (SR2.x on
>> PG2).
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  arch/arm64/boot/dts/ti/Makefile               |  2 +
>>  .../dts/ti/k3-am65-iot2050-common-pg2.dtsi    | 51 +++++++++++++++++++
>>  .../dts/ti/k3-am6528-iot2050-basic-pg2.dts    | 24 +++++++++
>>  .../dts/ti/k3-am6548-iot2050-advanced-pg2.dts | 29 +++++++++++
>>  4 files changed, 106 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.d=
tsi
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-pg2.=
dts
>>  create mode 100644 arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-p=
g2.dts
>>
>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/M=
akefile
>> index d56c742f5a10..41a4bc96e6bd 100644
>> --- a/arch/arm64/boot/dts/ti/Makefile
>> +++ b/arch/arm64/boot/dts/ti/Makefile
>> @@ -8,7 +8,9 @@
>>
>>  dtb-$(CONFIG_ARCH_K3) +=3D k3-am654-base-board.dtb
>>  dtb-$(CONFIG_ARCH_K3) +=3D k3-am6528-iot2050-basic.dtb
>> +dtb-$(CONFIG_ARCH_K3) +=3D k3-am6528-iot2050-basic-pg2.dtb
>>  dtb-$(CONFIG_ARCH_K3) +=3D k3-am6548-iot2050-advanced.dtb
>> +dtb-$(CONFIG_ARCH_K3) +=3D k3-am6548-iot2050-advanced-pg2.dtb
>>
>>  dtb-$(CONFIG_ARCH_K3) +=3D k3-j721e-common-proc-board.dtb
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi b/a=
rch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
>> new file mode 100644
>> index 000000000000..c25bce7339b7
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi
>> @@ -0,0 +1,51 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) Siemens AG, 2021
>> + *
>> + * Authors:
>> + *   Chao Zeng <chao.zeng@siemens.com>
>> + *   Jan Kiszka <jan.kiszka@siemens.com>
>> + *
>> + * Common bits of the IOT2050 Basic and Advanced variants, PG2
>> + */
>> +
>> +&main_pmx0 {
>> +	cp2102n_reset_pin_default: cp2102n-reset-pin-default {
>> +		pinctrl-single,pins =3D <
>> +			/* (AF12) GPIO1_24, used as cp2102 reset */
>> +			AM65X_IOPAD(0x01e0, PIN_OUTPUT, 7)
>> +		>;
>> +	};
>> +};
>> +
>> +&main_gpio1 {
>> +	pinctrl-names =3D "default";
>> +	pinctrl-0 =3D <&cp2102n_reset_pin_default>;
>> +	gpio-line-names =3D
>> +		"", "", "", "", "", "", "", "", "", "",
>> +		"", "", "", "", "", "", "", "", "", "",
>> +		"", "", "", "", "CP2102N-RESET";
>> +};
>> +
>> +&dss {
>> +	/* Workaround needed to get DP clock of 154Mhz */
>> +	assigned-clocks =3D <&k3_clks 67 0>;
>> +};
>> +
>> +&serdes0 {
>> +	assigned-clocks =3D <&k3_clks 153 4>, <&serdes0 AM654_SERDES_CMU_REFC=
LK>;
>> +	assigned-clock-parents =3D <&k3_clks 153 7>, <&k3_clks 153 4>;
>> +};
>> +
>> +&dwc3_0 {
>> +	assigned-clock-parents =3D <&k3_clks 151 4>,  /* set REF_CLK to 20MHz=
 i.e. PER0_PLL/48 */
>> +				 <&k3_clks 151 8>;  /* set PIPE3_TXB_CLK to WIZ8B2M4VSB */
>> +	phys =3D <&serdes0 PHY_TYPE_USB3 0>;
>> +	phy-names =3D "usb3-phy";
>> +};
>> +
>> +&usb0_phy {
>> +	maximum-speed =3D "super-speed";
>> +	snps,dis-u1-entry-quirk;
>> +	snps,dis-u2-entry-quirk;
>
> ^^
> 	did you mean &usb0?
> usb0_phy uses Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
> usb0 uses Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>
> am i missing a "maximum-speed" there? quirks look like belonging to the
> controller ?
>

Yes, this was probably just a typo, must be "usb0" indeed. Colleagues
confirmed this as well. I'll send an update.

Jan

