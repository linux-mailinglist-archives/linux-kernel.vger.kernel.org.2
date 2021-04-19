Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661F33640E9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238867AbhDSLt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:49:58 -0400
Received: from mout.web.de ([212.227.15.4]:41193 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238730AbhDSLtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:49:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1618832928;
        bh=gfHCfxuagiO51BKPo/nWIdMmIgZx8rankpWkG7jz79Q=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=G/AVEeo5o5yz6kSMt4wxrtvFRGoBolWtBRpkGgoE2PIcERnkrAP6tSeFS2YjRoA01
         dFvh+SxYnGl3dN+ooRCN3k3+ZWy/gHC2ZMcXVreT/ZVpiEY2QTmkkysUERCmy8VZkp
         SBAnoQFX5nCMhOyBAIkDr+RZEaUJ3oVqFy04R3/E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [167.87.42.108] ([88.215.87.53]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MBY4U-1lP4C61vcM-00ATuv; Mon, 19
 Apr 2021 13:48:48 +0200
Subject: Re: [PATCH 1/3] arm64: dts: xilinx: Add the clock nodes for zynqmp
To:     Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, harini.katakam@xilinx.com,
        ulf.hansson@linaro.org, xuwei5@hisilicon.com, mripard@kernel.org,
        heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1573119856-13548-1-git-send-email-rajan.vaja@xilinx.com>
 <1573119856-13548-2-git-send-email-rajan.vaja@xilinx.com>
 <8b039dac-06c4-6b33-f53b-44b8fa144495@web.de>
 <580bccb2-2e41-aec7-2612-99a2b231f2fc@xilinx.com>
 <09343e7d-fcd8-1a54-470f-c0d8741921b1@web.de>
 <7e8ee1fe-a02d-f6ac-337f-88b35736e1eb@web.de>
 <2f2e3019-afdd-103f-b984-06e65b10fc50@xilinx.com>
From:   Jan Kiszka <jan.kiszka@web.de>
Message-ID: <5176e9bc-50a0-6952-0e5a-8e43095235eb@web.de>
Date:   Mon, 19 Apr 2021 13:48:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <2f2e3019-afdd-103f-b984-06e65b10fc50@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:snCgpjO1Sl+dx6ZGaXfdIhtULxTYowmDcXyHm7rcBbYnVMqZceq
 KVj9Kk//Ymm4gKOkPt/H1O9993HaOAcgaqIlVJEoxNIIA+8le7kgdhKJxx0pTk/Cfupiw8a
 9kZf43POGnaDimOr69GoTLHTIDvvTzSwOvhAzdpXh24Xi4M0wIL5LianxAdh78npzmD6Z1s
 GCbn166WRuQl+uCM93qbw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:rjnJ11hlQKc=:lhWIt5eb0jBNWRFlWY5t61
 SOcHcaLhF0zf7jeJqABbpeXXRRa6WN/bsXUsY/wvpwl1d1AdHda8BHQlicPfbiUwqOER3aiGM
 GAqwk+dcgOtqCJ4x+TPHuGVj3moNWxr7QJtU3o77qqmImXlwHTsmRscWh5lgcnRKszHNdbQXl
 3IN7a4iQbeTLP75jiZbgFqZOsj5JsyMg7LFO+Fz3ow67Lb1r+9qS04CEjr2dKfZXcJtxIkZld
 Q+u7HsT/6DdN8Os5QgEr81+G/bIgk0ezr5Mvk8Jakm59g7HcL6qTzhx6hbS8mI+k6oRBmqGpS
 W96kyIkz/Z8t3drJwXcdpI4vIShpIMDyz08ky4+G4YRlQbc57RvxCC8gPY6J0o1YrLtX8skYB
 p7r+nQ1qfVefS3lPTEs7d8lFRq034usNxd9Bq7HOa9uCQB0dat2xJh+hTin3cupWot9qJNchu
 MQNBYXgq5UpZ6Fy9bF10e22WNPG3IOvAjD/q4w9v95Sre/61tqfmhN/CVfZW4074UlTDL0f+k
 uKLXzR49YU7uhRURJcJobj9ytPIHevCjAJSSvLovRBZ7SsB4aFaJG3SxrOW/nobyQcBmRTXsy
 miwOPW8XSRSHgM82mRhVHWTtmEEzv66l/qkS4AYJJEH99kxzE8tLb7P4eRz4q8HTlK3GX+iHB
 q8YqzUKrRYT5LT+vcstZ7rqrM897aPiDVF4sxvX7r4UjlS369nzf9rP5cjP2CtgF6OG+vJNUa
 WCRMWDL7UWjT/kc/Pf2q3knzrbN2TLP57824kQ1n/Tzk4f0pV+8Q6U8WeTKIbTWOhD1WbbdPA
 kGUCX7802ZECB6EODFSyfGVZ3mxFFrnVzIpq4rkjDdONHF+C+H5S3for0Byik+VNPfvzPapeW
 iupLg3t/rWZ3itPh9uL0HSrBxWuq7v3VUMvapNRumW8tYEF+AdUe6DcOECokHTnqK+s8cnq53
 JZ0XdpXTIncx6btTiaTshiWM4u1Hb/Zs+oTJ63jHPRONYw2G/2Kv3Xk0zzdBu59ZLA13oQLeU
 Wd2j/qp3R7vo5XqyQUpXBPQR3pJkRIjhzMrii8vqQBLXzGa4+RaM8DcfNvE+zIVpvNT9pqxOw
 cHN+QQacUAIxVOIK3cIp/9GBgSH3x9ROliRFSQbd6eEKiZ+KrIOa+ca3zm0aYJN9ulIX6TC1y
 fSi5O0leC1xEbtoO3vlbBR9paXhY0IMNrUrzb+t6jS1LU8pYTn6S2XuoICGFEnR+T+Acs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.21 12:52, Michal Simek wrote:
> Hi Jan,
>
> On 4/18/21 2:12 PM, Jan Kiszka wrote:
>> On 01.04.21 16:52, Jan Kiszka wrote:
>>> On 01.04.21 13:42, Michal Simek wrote:
>>>> Hi Jan,
>>>>
>>>> On 3/27/21 8:55 PM, Jan Kiszka wrote:
>>>>> On 07.11.19 10:44, Rajan Vaja wrote:
>>>>>> Add clock nodes for zynqmp based on CCF.
>>>>>>
>>>>>> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
>>>>>> ---
>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi     | 222 +++++++++=
++++++++++++
>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts  |   4 +-
>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts  |   4 +-
>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts  |   2 +-
>>>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |   4 +-
>>>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |   4 +-
>>>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |   4 +-
>>>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |   4 +-
>>>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    |   4 +-
>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts  |   4 +-
>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  |   4 +-
>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts  |   4 +-
>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts  |   4 +-
>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts  |   4 +-
>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |  24 ++-
>>>>>>  15 files changed, 270 insertions(+), 26 deletions(-)
>>>>>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/=
arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>>>>>> new file mode 100644
>>>>>> index 0000000..9868ca1
>>>>>> --- /dev/null
>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>>>>>> @@ -0,0 +1,222 @@
>>>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>>>> +/*
>>>>>> + * Clock specification for Xilinx ZynqMP
>>>>>> + *
>>>>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>>>> + *
>>>>>> + * Michal Simek <michal.simek@xilinx.com>
>>>>>> + */
>>>>>> +
>>>>>> +#include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>>>>>> +/ {
>>>>>> +	pss_ref_clk: pss_ref_clk {
>>>>>> +		u-boot,dm-pre-reloc;
>>>>>> +		compatible =3D "fixed-clock";
>>>>>> +		#clock-cells =3D <0>;
>>>>>> +		clock-frequency =3D <33333333>;
>>>>>> +	};
>>>>>> +
>>>>>> +	video_clk: video_clk {
>>>>>> +		u-boot,dm-pre-reloc;
>>>>>> +		compatible =3D "fixed-clock";
>>>>>> +		#clock-cells =3D <0>;
>>>>>> +		clock-frequency =3D <27000000>;
>>>>>> +	};
>>>>>> +
>>>>>> +	pss_alt_ref_clk: pss_alt_ref_clk {
>>>>>> +		u-boot,dm-pre-reloc;
>>>>>> +		compatible =3D "fixed-clock";
>>>>>> +		#clock-cells =3D <0>;
>>>>>> +		clock-frequency =3D <0>;
>>>>>> +	};
>>>>>> +
>>>>>> +	gt_crx_ref_clk: gt_crx_ref_clk {
>>>>>> +		u-boot,dm-pre-reloc;
>>>>>> +		compatible =3D "fixed-clock";
>>>>>> +		#clock-cells =3D <0>;
>>>>>> +		clock-frequency =3D <108000000>;
>>>>>> +	};
>>>>>> +
>>>>>> +	aux_ref_clk: aux_ref_clk {
>>>>>> +		u-boot,dm-pre-reloc;
>>>>>> +		compatible =3D "fixed-clock";
>>>>>> +		#clock-cells =3D <0>;
>>>>>> +		clock-frequency =3D <27000000>;
>>>>>> +	};
>>>>>> +};
>>>>>> +
>>>>>> +&can0 {
>>>>>> +	clocks =3D <&zynqmp_clk CAN0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&can1 {
>>>>>> +	clocks =3D <&zynqmp_clk CAN1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&cpu0 {
>>>>>> +	clocks =3D <&zynqmp_clk ACPU>;
>>>>>> +};
>>>>>> +
>>>>>> +&fpd_dma_chan1 {
>>>>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&fpd_dma_chan2 {
>>>>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&fpd_dma_chan3 {
>>>>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&fpd_dma_chan4 {
>>>>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&fpd_dma_chan5 {
>>>>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&fpd_dma_chan6 {
>>>>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&fpd_dma_chan7 {
>>>>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&fpd_dma_chan8 {
>>>>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&lpd_dma_chan1 {
>>>>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&lpd_dma_chan2 {
>>>>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&lpd_dma_chan3 {
>>>>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&lpd_dma_chan4 {
>>>>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&lpd_dma_chan5 {
>>>>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&lpd_dma_chan6 {
>>>>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&lpd_dma_chan7 {
>>>>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&lpd_dma_chan8 {
>>>>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&gem0 {
>>>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM0_REF>,
>>>>>> +		 <&zynqmp_clk GEM0_TX>, <&zynqmp_clk GEM0_RX>,
>>>>>> +		 <&zynqmp_clk GEM_TSU>;
>>>>>> +	clock-names =3D "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>>>>> +};
>>>>>> +
>>>>>> +&gem1 {
>>>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM1_REF>,
>>>>>> +		 <&zynqmp_clk GEM1_TX>, <&zynqmp_clk GEM1_RX>,
>>>>>> +		 <&zynqmp_clk GEM_TSU>;
>>>>>> +	clock-names =3D "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>>>>> +};
>>>>>> +
>>>>>> +&gem2 {
>>>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM2_REF>,
>>>>>> +		 <&zynqmp_clk GEM2_TX>, <&zynqmp_clk GEM2_RX>,
>>>>>> +		 <&zynqmp_clk GEM_TSU>;
>>>>>> +	clock-names =3D "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>>>>> +};
>>>>>> +
>>>>>> +&gem3 {
>>>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM3_REF>,
>>>>>> +		 <&zynqmp_clk GEM3_TX>, <&zynqmp_clk GEM3_RX>,
>>>>>> +		 <&zynqmp_clk GEM_TSU>;
>>>>>> +	clock-names =3D "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>>>>> +};
>>>>>> +
>>>>>> +&gpio {
>>>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&i2c0 {
>>>>>> +	clocks =3D <&zynqmp_clk I2C0_REF>;
>>>>>> +};
>>>>>> +
>>>>>> +&i2c1 {
>>>>>> +	clocks =3D <&zynqmp_clk I2C1_REF>;
>>>>>> +};
>>>>>> +
>>>>>> +&pcie {
>>>>>> +	clocks =3D <&zynqmp_clk PCIE_REF>;
>>>>>> +};
>>>>>> +
>>>>>> +&sata {
>>>>>> +	clocks =3D <&zynqmp_clk SATA_REF>;
>>>>>> +};
>>>>>> +
>>>>>> +&sdhci0 {
>>>>>> +	clocks =3D <&zynqmp_clk SDIO0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&sdhci1 {
>>>>>> +	clocks =3D <&zynqmp_clk SDIO1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&spi0 {
>>>>>> +	clocks =3D <&zynqmp_clk SPI0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&spi1 {
>>>>>> +	clocks =3D <&zynqmp_clk SPI1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&ttc0 {
>>>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&ttc1 {
>>>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&ttc2 {
>>>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&ttc3 {
>>>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&uart0 {
>>>>>> +	clocks =3D <&zynqmp_clk UART0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&uart1 {
>>>>>> +	clocks =3D <&zynqmp_clk UART1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>> +};
>>>>>> +
>>>>>> +&usb0 {
>>>>>> +	clocks =3D <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF=
>;
>>>>>> +};
>>>>>> +
>>>>>> +&usb1 {
>>>>>> +	clocks =3D <&zynqmp_clk USB1_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF=
>;
>>>>>> +};
>>>>>> +
>>>>>> +&watchdog0 {
>>>>>> +	clocks =3D <&zynqmp_clk WDT>;
>>>>>> +};
>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/ar=
ch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>>>>> index 0f7b4cf..2e05fa4 100644
>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>>>>> @@ -2,7 +2,7 @@
>>>>>>  /*
>>>>>>   * dts file for Xilinx ZynqMP ZC1232
>>>>>>   *
>>>>>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>>>>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>>>>   *
>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>   */
>>>>>> @@ -10,7 +10,7 @@
>>>>>>  /dts-v1/;
>>>>>>
>>>>>>  #include "zynqmp.dtsi"
>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>
>>>>>>  / {
>>>>>>  	model =3D "ZynqMP ZC1232 RevA";
>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/ar=
ch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>>>>> index 9092828..3d0aaa0 100644
>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>>>>> @@ -2,7 +2,7 @@
>>>>>>  /*
>>>>>>   * dts file for Xilinx ZynqMP ZC1254
>>>>>>   *
>>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>>   *
>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>   * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
>>>>>> @@ -11,7 +11,7 @@
>>>>>>  /dts-v1/;
>>>>>>
>>>>>>  #include "zynqmp.dtsi"
>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>
>>>>>>  / {
>>>>>>  	model =3D "ZynqMP ZC1254 RevA";
>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts b/ar=
ch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>>>>>> index 4f404c5..1a8127d4 100644
>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>>>>>> @@ -11,7 +11,7 @@
>>>>>>  /dts-v1/;
>>>>>>
>>>>>>  #include "zynqmp.dtsi"
>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>
>>>>>>  / {
>>>>>>  	model =3D "ZynqMP ZC1275 RevA";
>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts=
 b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>>>>> index 9a3e39d..fa7eb1b 100644
>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>>>>> @@ -2,7 +2,7 @@
>>>>>>  /*
>>>>>>   * dts file for Xilinx ZynqMP zc1751-xm015-dc1
>>>>>>   *
>>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>>   *
>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>   */
>>>>>> @@ -10,7 +10,7 @@
>>>>>>  /dts-v1/;
>>>>>>
>>>>>>  #include "zynqmp.dtsi"
>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>>
>>>>>>  / {
>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts=
 b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>>>>>> index 2421ec7..4191dfa 100644
>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>>>>>> @@ -2,7 +2,7 @@
>>>>>>  /*
>>>>>>   * dts file for Xilinx ZynqMP zc1751-xm016-dc2
>>>>>>   *
>>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>>   *
>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>   */
>>>>>> @@ -10,7 +10,7 @@
>>>>>>  /dts-v1/;
>>>>>>
>>>>>>  #include "zynqmp.dtsi"
>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>>
>>>>>>  / {
>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts=
 b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>>>>>> index 7a49dee..3750690 100644
>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>>>>>> @@ -2,7 +2,7 @@
>>>>>>  /*
>>>>>>   * dts file for Xilinx ZynqMP zc1751-xm017-dc3
>>>>>>   *
>>>>>> - * (C) Copyright 2016 - 2018, Xilinx, Inc.
>>>>>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>>>>>   *
>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>   */
>>>>>> @@ -10,7 +10,7 @@
>>>>>>  /dts-v1/;
>>>>>>
>>>>>>  #include "zynqmp.dtsi"
>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>
>>>>>>  / {
>>>>>>  	model =3D "ZynqMP zc1751-xm017-dc3 RevA";
>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts=
 b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>>>>> index 54c7b4f..2366cd9 100644
>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>>>>> @@ -2,7 +2,7 @@
>>>>>>  /*
>>>>>>   * dts file for Xilinx ZynqMP zc1751-xm018-dc4
>>>>>>   *
>>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>>   *
>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>   */
>>>>>> @@ -10,7 +10,7 @@
>>>>>>  /dts-v1/;
>>>>>>
>>>>>>  #include "zynqmp.dtsi"
>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>
>>>>>>  / {
>>>>>>  	model =3D "ZynqMP zc1751-xm018-dc4";
>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts=
 b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>>>>>> index b8b5ff1..9a894e6 100644
>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>>>>>> @@ -2,7 +2,7 @@
>>>>>>  /*
>>>>>>   * dts file for Xilinx ZynqMP zc1751-xm019-dc5
>>>>>>   *
>>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>>   *
>>>>>>   * Siva Durga Prasad <siva.durga.paladugu@xilinx.com>
>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>> @@ -11,7 +11,7 @@
>>>>>>  /dts-v1/;
>>>>>>
>>>>>>  #include "zynqmp.dtsi"
>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>>
>>>>>>  / {
>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/ar=
ch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>>>>> index e5699d0..3e39454 100644
>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>>>>> @@ -2,7 +2,7 @@
>>>>>>  /*
>>>>>>   * dts file for Xilinx ZynqMP ZCU100 revC
>>>>>>   *
>>>>>> - * (C) Copyright 2016 - 2018, Xilinx, Inc.
>>>>>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>>>>>   *
>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>   * Nathalie Chan King Choy
>>>>>> @@ -11,7 +11,7 @@
>>>>>>  /dts-v1/;
>>>>>>
>>>>>>  #include "zynqmp.dtsi"
>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>  #include <dt-bindings/input/input.h>
>>>>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/ar=
ch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>>>>> index 2a3b665..f6e9558 100644
>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>>>>> @@ -2,7 +2,7 @@
>>>>>>  /*
>>>>>>   * dts file for Xilinx ZynqMP ZCU102 RevA
>>>>>>   *
>>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>>   *
>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>   */
>>>>>> @@ -10,7 +10,7 @@
>>>>>>  /dts-v1/;
>>>>>>
>>>>>>  #include "zynqmp.dtsi"
>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>  #include <dt-bindings/input/input.h>
>>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/ar=
ch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>>>>>> index 8f45614..f457f8a 100644
>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>>>>>> @@ -2,7 +2,7 @@
>>>>>>  /*
>>>>>>   * dts file for Xilinx ZynqMP ZCU104
>>>>>>   *
>>>>>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>>>>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>>>>   *
>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>   */
>>>>>> @@ -10,7 +10,7 @@
>>>>>>  /dts-v1/;
>>>>>>
>>>>>>  #include "zynqmp.dtsi"
>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>>
>>>>>>  / {
>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/ar=
ch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>>>>>> index 93ce7eb..f15b99a 100644
>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>>>>>> @@ -2,7 +2,7 @@
>>>>>>  /*
>>>>>>   * dts file for Xilinx ZynqMP ZCU106
>>>>>>   *
>>>>>> - * (C) Copyright 2016, Xilinx, Inc.
>>>>>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>>>>>   *
>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>   */
>>>>>> @@ -10,7 +10,7 @@
>>>>>>  /dts-v1/;
>>>>>>
>>>>>>  #include "zynqmp.dtsi"
>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>  #include <dt-bindings/input/input.h>
>>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/ar=
ch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>>>>>> index 8bb0001..e27cd60 100644
>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>>>>>> @@ -2,7 +2,7 @@
>>>>>>  /*
>>>>>>   * dts file for Xilinx ZynqMP ZCU111
>>>>>>   *
>>>>>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>>>>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>>>>   *
>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>   */
>>>>>> @@ -10,7 +10,7 @@
>>>>>>  /dts-v1/;
>>>>>>
>>>>>>  #include "zynqmp.dtsi"
>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>  #include <dt-bindings/input/input.h>
>>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/bo=
ot/dts/xilinx/zynqmp.dtsi
>>>>>> index 9aa6734..59a547b 100644
>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>>>> @@ -2,7 +2,7 @@
>>>>>>  /*
>>>>>>   * dts file for Xilinx ZynqMP
>>>>>>   *
>>>>>> - * (C) Copyright 2014 - 2015, Xilinx, Inc.
>>>>>> + * (C) Copyright 2014 - 2019, Xilinx, Inc.
>>>>>>   *
>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>   *
>>>>>> @@ -124,6 +124,28 @@
>>>>>>  			     <1 10 0xf08>;
>>>>>>  	};
>>>>>>
>>>>>> +	firmware {
>>>>>> +		zynqmp_firmware: zynqmp-firmware {
>>>>>> +			compatible =3D "xlnx,zynqmp-firmware";
>>>>>> +			method =3D "smc";
>>>>>> +			zynqmp_clk: clock-controller {
>>>>>> +				u-boot,dm-pre-reloc;
>>>>>> +				#clock-cells =3D <1>;
>>>>>> +				compatible =3D "xlnx,zynqmp-clk";
>>>>>> +				clocks =3D <&pss_ref_clk>,
>>>>>> +					 <&video_clk>,
>>>>>> +					 <&pss_alt_ref_clk>,
>>>>>> +					 <&aux_ref_clk>,
>>>>>> +					 <&gt_crx_ref_clk>;
>>>>>> +				clock-names =3D "pss_ref_clk",
>>>>>> +					      "video_clk",
>>>>>> +					      "pss_alt_ref_clk",
>>>>>> +					      "aux_ref_clk",
>>>>>> +					      "gt_crx_ref_clk";
>>>>>> +			};
>>>>>> +		};
>>>>>> +	};
>>>>>> +
>>>>>>  	amba_apu: amba-apu@0 {
>>>>>>  		compatible =3D "simple-bus";
>>>>>>  		#address-cells =3D <2>;
>>>>>>
>>>>>
>>>>> Updating my Ultra96 setups from 5.4 to 5.10, I ran into a blocker:
>>>>> Starting from this commit on, I'm no longer getting the kernel to bo=
ot
>>>>> on both revision 1 and 2 (arm64 defconfig as reference). If I switch=
 the
>>>>> DTBs back before this commit, even a kernel from today's head is fin=
e.
>>>>>
>>>>> Further versions of potential relevance:
>>>>>  - PMUFW 2019.1 and 2020.2
>>>>>  - TF-A 2.3
>>>>>  - U-Boot 2020.10
>>>>>
>>>>> What's missing? I suspect someone forgot to document a subtle depend=
ency
>>>>> of this change.
>>>>
>>>> Does this fix your issue?
>>>> https://lore.kernel.org/linux-arm-kernel/20210316090540.973014-1-puni=
t1.agrawal@toshiba.co.jp/
>>>>
>>>
>>> Nope, CONFIG_COMMON_CLK_ZYNQMP=3Dy does not help. Maybe the defconfig =
is
>>> missing even more. If you have some reference, I'm happy to try. I
>>> suspect that earlyprintk will also not reveal more without clocks (but=
 I
>>> didn't play with that yet).
>>>
>>> Meanwhile, I'm carrying a revert of this commit and a related cleanup.
>>> That helps for now.
>>>
>>
>> OK, dependencies resolved (unfortunately the hard way): It either
>> requires TF-A master or latest release v2.4 + [1] and [2].
>>
>> Those TF-A commits were upstream about a year after the firmware-based
>> clock control hit the kernel. A note would have been nice - or better
>> sychronization between both upstreaming efforts.
>
> I wasn't responsible for TFA but I found this last year in Nov timeframe
> that none really upstream this. Right now that development is working
> like that. I am asking everybody to contribute upstream to have all the
> time upstream heads to work together.
> I haven't had a time to dig into this but unfortunatelly there is no
> feature checking mechanism on zynqmp TFA side to check if this is there
> or not but we are trying our best to check as much as possible but bugs
> happen.

OK, I understand. Reminding of "upstream first" is part of my daily
business as well. :)

And integration is generally more and more complicated with the growing
number of firmware services and interfaces, not only on this SOC...

> And we are lacking space in OCM to be able to add more features to TFA
> anyway.

Yeah, I know - I'm also overflowing it via the SDEI patch [1].

Jan

[1] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/9673
