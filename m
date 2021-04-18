Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43B4363509
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 14:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhDRMNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 08:13:08 -0400
Received: from mout.web.de ([212.227.17.11]:43899 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhDRMNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 08:13:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1618747926;
        bh=WDzUiV1hJ3w895cwPWoLfK/ZJA8tXIvrOTsi3xQr0gM=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=Bf4h5kjr498vUeN02PNZfcOCu2//OdZpUhwFGGwr85FnJOOquuoaRRJpmMYbn9roT
         OPr5JBJJ4fg/U5Z2xmFFZq74ppeD4Irxh1gvc8poiEohDidoVNRTGp6ZDD7TwWKw7f
         YcmN71Z5c3/E6/hu4CnBTSyUKLXiCuVkWlaLjb8I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.10.10] ([88.215.87.53]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lal6K-1lwPYT3qrQ-00kQ2Z; Sun, 18
 Apr 2021 14:12:06 +0200
Subject: Re: [PATCH 1/3] arm64: dts: xilinx: Add the clock nodes for zynqmp
From:   Jan Kiszka <jan.kiszka@web.de>
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
Message-ID: <7e8ee1fe-a02d-f6ac-337f-88b35736e1eb@web.de>
Date:   Sun, 18 Apr 2021 14:12:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <09343e7d-fcd8-1a54-470f-c0d8741921b1@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PM/AX55NcyHGNHTfh5rgcnxy/isTrJ3j5Ln4uJE6GyTzTOjSVpf
 UHmJCLJdE1zfxpEtQIdWRCIbifO4IUzo9HrIRde2K8f6VCcZm5X1zIkJfj2eHR+TOW7nwKv
 GJ4VEo0y2erpwuwu3nDHZOgVPJ5mKU9ZHJzvAU3Lmxys8qL7qxMzmDLoMBD79zftyKoO/k2
 5TOu95nZCckAWhLd5rbrA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kVepM1lD00U=:YwxmXLP0mbzJdQQa9WAIFj
 hw/FZw9Y0+Ono/aKQYBbf1Pbe4gwYi2cGWOkUWtd0MNROaizQUA8ylIPx1yQ/GmA/TRs45ds4
 lCTK0mHBy6qV3m1aREFgDp+FpQ2RTUS6QLchUJ3qGMLEIElGkm4Cc/BmiN7992XVD8XvrqfpZ
 ov9b/hnuiP+CgrUuy+JxenwVIC7iLmY7yXOmUuODGaTWwrk4l+1vyQrwgGeVVvhPwA/T42ERF
 GK45YVQWt3uM/PCta4pSINRUWVTmm4xehHWZ6lr1zWurMqLEp+YDzr39Q5w/ibYH5/mVVtgWY
 8YV0THdM3amGcKEphGoJRpwNZaSSEo/62DqAm7edaof9We7z65vjUC3kLc58zbK+3r3qtyGDx
 sJCYnzj9NwLbQChdv0U4PyTxKR/C78JME+14UzUrDsCHaXbpuf3UXkJjKyXeAwSncZDa0INNQ
 BiiS277va+i8IGpcGHftEKY2HWbPUHOd2yi2VJrRgcDRHxTMLiQ1XUzun/xDlxKHUlGNSfVvl
 lwzaQIfbGG6OOdn8G5cf9SrE5hzbkVQpAwuOtAQVLm2Pq19US/OhxDK8Y/rsk09dYoBCFGPir
 vUSD5y3YcyLtyCqUqUG/b1QZe3W1UJU3mtRfLiRScq8ksUNINMPXhx+UX16PRf0BQsI415Wp0
 EaIdgdcWO5i40ukckhybKU91mvaEfJchXe60jCxHB78pG6aw6pF3ZQlI1ImdHGuRASlcnVIrq
 7yTs4lpi+NywwLk6ovNhi6t4/37s4lW6NftsXQi/WOnuH8FXJ6r7HuAHEOOI0ZHiMk3kaqrmm
 6lcZDtR5fQ+sTTFPzaEq/p0mCmf4g6Pw/0uYgGGq7NM1Ivqv+p9eF/J/L4P3M4OX1C8KjInNy
 2bo0DVwMFkgZhYIBzI/msDCaOJr91KAXPYSr5aDESo7Y7FvaePay5SW2CW1tuAWKMoiG/JCPE
 Tn4q6ufDh1aip6pVXigpJix+T1leF0nrN2qeh4O405iwu/zDFf1mEDar851rfpirBPVfKivBo
 +KVS+gPrvebIG1hvQoQN6XoqNnkjmdat4xWO1krN3Xnn0/pG9J+Ro6bPl7Qm/Ltlh5WVbSru2
 wvw5jfM3Y6o0ozEc/aGL+yx8G9TIizEvuvJl8vWJIBod2KAp6/6SBMtKMMridh6KufH8Qn0hK
 U+16OTPOywkkQz/SUAO924pqTqeu79HWkPn64cbo6IJzV9QiVi4d0AohRXYgZw9MQWldE=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.21 16:52, Jan Kiszka wrote:
> On 01.04.21 13:42, Michal Simek wrote:
>> Hi Jan,
>>
>> On 3/27/21 8:55 PM, Jan Kiszka wrote:
>>> On 07.11.19 10:44, Rajan Vaja wrote:
>>>> Add clock nodes for zynqmp based on CCF.
>>>>
>>>> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
>>>> ---
>>>>  arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi     | 222 +++++++++++=
++++++++++
>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts  |   4 +-
>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts  |   4 +-
>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts  |   2 +-
>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |   4 +-
>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |   4 +-
>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |   4 +-
>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |   4 +-
>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    |   4 +-
>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts  |   4 +-
>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  |   4 +-
>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts  |   4 +-
>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts  |   4 +-
>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts  |   4 +-
>>>>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |  24 ++-
>>>>  15 files changed, 270 insertions(+), 26 deletions(-)
>>>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/ar=
m64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>>>> new file mode 100644
>>>> index 0000000..9868ca1
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>>>> @@ -0,0 +1,222 @@
>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>> +/*
>>>> + * Clock specification for Xilinx ZynqMP
>>>> + *
>>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>> + *
>>>> + * Michal Simek <michal.simek@xilinx.com>
>>>> + */
>>>> +
>>>> +#include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>>>> +/ {
>>>> +	pss_ref_clk: pss_ref_clk {
>>>> +		u-boot,dm-pre-reloc;
>>>> +		compatible =3D "fixed-clock";
>>>> +		#clock-cells =3D <0>;
>>>> +		clock-frequency =3D <33333333>;
>>>> +	};
>>>> +
>>>> +	video_clk: video_clk {
>>>> +		u-boot,dm-pre-reloc;
>>>> +		compatible =3D "fixed-clock";
>>>> +		#clock-cells =3D <0>;
>>>> +		clock-frequency =3D <27000000>;
>>>> +	};
>>>> +
>>>> +	pss_alt_ref_clk: pss_alt_ref_clk {
>>>> +		u-boot,dm-pre-reloc;
>>>> +		compatible =3D "fixed-clock";
>>>> +		#clock-cells =3D <0>;
>>>> +		clock-frequency =3D <0>;
>>>> +	};
>>>> +
>>>> +	gt_crx_ref_clk: gt_crx_ref_clk {
>>>> +		u-boot,dm-pre-reloc;
>>>> +		compatible =3D "fixed-clock";
>>>> +		#clock-cells =3D <0>;
>>>> +		clock-frequency =3D <108000000>;
>>>> +	};
>>>> +
>>>> +	aux_ref_clk: aux_ref_clk {
>>>> +		u-boot,dm-pre-reloc;
>>>> +		compatible =3D "fixed-clock";
>>>> +		#clock-cells =3D <0>;
>>>> +		clock-frequency =3D <27000000>;
>>>> +	};
>>>> +};
>>>> +
>>>> +&can0 {
>>>> +	clocks =3D <&zynqmp_clk CAN0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&can1 {
>>>> +	clocks =3D <&zynqmp_clk CAN1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&cpu0 {
>>>> +	clocks =3D <&zynqmp_clk ACPU>;
>>>> +};
>>>> +
>>>> +&fpd_dma_chan1 {
>>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&fpd_dma_chan2 {
>>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&fpd_dma_chan3 {
>>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&fpd_dma_chan4 {
>>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&fpd_dma_chan5 {
>>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&fpd_dma_chan6 {
>>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&fpd_dma_chan7 {
>>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&fpd_dma_chan8 {
>>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&lpd_dma_chan1 {
>>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&lpd_dma_chan2 {
>>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&lpd_dma_chan3 {
>>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&lpd_dma_chan4 {
>>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&lpd_dma_chan5 {
>>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&lpd_dma_chan6 {
>>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&lpd_dma_chan7 {
>>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&lpd_dma_chan8 {
>>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&gem0 {
>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM0_REF>,
>>>> +		 <&zynqmp_clk GEM0_TX>, <&zynqmp_clk GEM0_RX>,
>>>> +		 <&zynqmp_clk GEM_TSU>;
>>>> +	clock-names =3D "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>>> +};
>>>> +
>>>> +&gem1 {
>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM1_REF>,
>>>> +		 <&zynqmp_clk GEM1_TX>, <&zynqmp_clk GEM1_RX>,
>>>> +		 <&zynqmp_clk GEM_TSU>;
>>>> +	clock-names =3D "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>>> +};
>>>> +
>>>> +&gem2 {
>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM2_REF>,
>>>> +		 <&zynqmp_clk GEM2_TX>, <&zynqmp_clk GEM2_RX>,
>>>> +		 <&zynqmp_clk GEM_TSU>;
>>>> +	clock-names =3D "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>>> +};
>>>> +
>>>> +&gem3 {
>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM3_REF>,
>>>> +		 <&zynqmp_clk GEM3_TX>, <&zynqmp_clk GEM3_RX>,
>>>> +		 <&zynqmp_clk GEM_TSU>;
>>>> +	clock-names =3D "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>>> +};
>>>> +
>>>> +&gpio {
>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&i2c0 {
>>>> +	clocks =3D <&zynqmp_clk I2C0_REF>;
>>>> +};
>>>> +
>>>> +&i2c1 {
>>>> +	clocks =3D <&zynqmp_clk I2C1_REF>;
>>>> +};
>>>> +
>>>> +&pcie {
>>>> +	clocks =3D <&zynqmp_clk PCIE_REF>;
>>>> +};
>>>> +
>>>> +&sata {
>>>> +	clocks =3D <&zynqmp_clk SATA_REF>;
>>>> +};
>>>> +
>>>> +&sdhci0 {
>>>> +	clocks =3D <&zynqmp_clk SDIO0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&sdhci1 {
>>>> +	clocks =3D <&zynqmp_clk SDIO1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&spi0 {
>>>> +	clocks =3D <&zynqmp_clk SPI0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&spi1 {
>>>> +	clocks =3D <&zynqmp_clk SPI1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&ttc0 {
>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&ttc1 {
>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&ttc2 {
>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&ttc3 {
>>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&uart0 {
>>>> +	clocks =3D <&zynqmp_clk UART0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&uart1 {
>>>> +	clocks =3D <&zynqmp_clk UART1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>> +};
>>>> +
>>>> +&usb0 {
>>>> +	clocks =3D <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
>>>> +};
>>>> +
>>>> +&usb1 {
>>>> +	clocks =3D <&zynqmp_clk USB1_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
>>>> +};
>>>> +
>>>> +&watchdog0 {
>>>> +	clocks =3D <&zynqmp_clk WDT>;
>>>> +};
>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch=
/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>>> index 0f7b4cf..2e05fa4 100644
>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>>> @@ -2,7 +2,7 @@
>>>>  /*
>>>>   * dts file for Xilinx ZynqMP ZC1232
>>>>   *
>>>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>>   *
>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>   */
>>>> @@ -10,7 +10,7 @@
>>>>  /dts-v1/;
>>>>
>>>>  #include "zynqmp.dtsi"
>>>> -#include "zynqmp-clk.dtsi"
>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>
>>>>  / {
>>>>  	model =3D "ZynqMP ZC1232 RevA";
>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch=
/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>>> index 9092828..3d0aaa0 100644
>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>>> @@ -2,7 +2,7 @@
>>>>  /*
>>>>   * dts file for Xilinx ZynqMP ZC1254
>>>>   *
>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>   *
>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>   * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
>>>> @@ -11,7 +11,7 @@
>>>>  /dts-v1/;
>>>>
>>>>  #include "zynqmp.dtsi"
>>>> -#include "zynqmp-clk.dtsi"
>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>
>>>>  / {
>>>>  	model =3D "ZynqMP ZC1254 RevA";
>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts b/arch=
/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>>>> index 4f404c5..1a8127d4 100644
>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>>>> @@ -11,7 +11,7 @@
>>>>  /dts-v1/;
>>>>
>>>>  #include "zynqmp.dtsi"
>>>> -#include "zynqmp-clk.dtsi"
>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>
>>>>  / {
>>>>  	model =3D "ZynqMP ZC1275 RevA";
>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b=
/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>>> index 9a3e39d..fa7eb1b 100644
>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>>> @@ -2,7 +2,7 @@
>>>>  /*
>>>>   * dts file for Xilinx ZynqMP zc1751-xm015-dc1
>>>>   *
>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>   *
>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>   */
>>>> @@ -10,7 +10,7 @@
>>>>  /dts-v1/;
>>>>
>>>>  #include "zynqmp.dtsi"
>>>> -#include "zynqmp-clk.dtsi"
>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>
>>>>  / {
>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b=
/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>>>> index 2421ec7..4191dfa 100644
>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>>>> @@ -2,7 +2,7 @@
>>>>  /*
>>>>   * dts file for Xilinx ZynqMP zc1751-xm016-dc2
>>>>   *
>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>   *
>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>   */
>>>> @@ -10,7 +10,7 @@
>>>>  /dts-v1/;
>>>>
>>>>  #include "zynqmp.dtsi"
>>>> -#include "zynqmp-clk.dtsi"
>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>
>>>>  / {
>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b=
/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>>>> index 7a49dee..3750690 100644
>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>>>> @@ -2,7 +2,7 @@
>>>>  /*
>>>>   * dts file for Xilinx ZynqMP zc1751-xm017-dc3
>>>>   *
>>>> - * (C) Copyright 2016 - 2018, Xilinx, Inc.
>>>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>>>   *
>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>   */
>>>> @@ -10,7 +10,7 @@
>>>>  /dts-v1/;
>>>>
>>>>  #include "zynqmp.dtsi"
>>>> -#include "zynqmp-clk.dtsi"
>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>
>>>>  / {
>>>>  	model =3D "ZynqMP zc1751-xm017-dc3 RevA";
>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b=
/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>>> index 54c7b4f..2366cd9 100644
>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>>> @@ -2,7 +2,7 @@
>>>>  /*
>>>>   * dts file for Xilinx ZynqMP zc1751-xm018-dc4
>>>>   *
>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>   *
>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>   */
>>>> @@ -10,7 +10,7 @@
>>>>  /dts-v1/;
>>>>
>>>>  #include "zynqmp.dtsi"
>>>> -#include "zynqmp-clk.dtsi"
>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>
>>>>  / {
>>>>  	model =3D "ZynqMP zc1751-xm018-dc4";
>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b=
/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>>>> index b8b5ff1..9a894e6 100644
>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>>>> @@ -2,7 +2,7 @@
>>>>  /*
>>>>   * dts file for Xilinx ZynqMP zc1751-xm019-dc5
>>>>   *
>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>   *
>>>>   * Siva Durga Prasad <siva.durga.paladugu@xilinx.com>
>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>> @@ -11,7 +11,7 @@
>>>>  /dts-v1/;
>>>>
>>>>  #include "zynqmp.dtsi"
>>>> -#include "zynqmp-clk.dtsi"
>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>
>>>>  / {
>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch=
/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>>> index e5699d0..3e39454 100644
>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>>> @@ -2,7 +2,7 @@
>>>>  /*
>>>>   * dts file for Xilinx ZynqMP ZCU100 revC
>>>>   *
>>>> - * (C) Copyright 2016 - 2018, Xilinx, Inc.
>>>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>>>   *
>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>   * Nathalie Chan King Choy
>>>> @@ -11,7 +11,7 @@
>>>>  /dts-v1/;
>>>>
>>>>  #include "zynqmp.dtsi"
>>>> -#include "zynqmp-clk.dtsi"
>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>  #include <dt-bindings/input/input.h>
>>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>>  #include <dt-bindings/gpio/gpio.h>
>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch=
/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>>> index 2a3b665..f6e9558 100644
>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>>> @@ -2,7 +2,7 @@
>>>>  /*
>>>>   * dts file for Xilinx ZynqMP ZCU102 RevA
>>>>   *
>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>   *
>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>   */
>>>> @@ -10,7 +10,7 @@
>>>>  /dts-v1/;
>>>>
>>>>  #include "zynqmp.dtsi"
>>>> -#include "zynqmp-clk.dtsi"
>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>  #include <dt-bindings/input/input.h>
>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>
>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch=
/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>>>> index 8f45614..f457f8a 100644
>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>>>> @@ -2,7 +2,7 @@
>>>>  /*
>>>>   * dts file for Xilinx ZynqMP ZCU104
>>>>   *
>>>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>>   *
>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>   */
>>>> @@ -10,7 +10,7 @@
>>>>  /dts-v1/;
>>>>
>>>>  #include "zynqmp.dtsi"
>>>> -#include "zynqmp-clk.dtsi"
>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>
>>>>  / {
>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch=
/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>>>> index 93ce7eb..f15b99a 100644
>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>>>> @@ -2,7 +2,7 @@
>>>>  /*
>>>>   * dts file for Xilinx ZynqMP ZCU106
>>>>   *
>>>> - * (C) Copyright 2016, Xilinx, Inc.
>>>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>>>   *
>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>   */
>>>> @@ -10,7 +10,7 @@
>>>>  /dts-v1/;
>>>>
>>>>  #include "zynqmp.dtsi"
>>>> -#include "zynqmp-clk.dtsi"
>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>  #include <dt-bindings/input/input.h>
>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>
>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch=
/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>>>> index 8bb0001..e27cd60 100644
>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>>>> @@ -2,7 +2,7 @@
>>>>  /*
>>>>   * dts file for Xilinx ZynqMP ZCU111
>>>>   *
>>>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>>   *
>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>   */
>>>> @@ -10,7 +10,7 @@
>>>>  /dts-v1/;
>>>>
>>>>  #include "zynqmp.dtsi"
>>>> -#include "zynqmp-clk.dtsi"
>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>  #include <dt-bindings/input/input.h>
>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>
>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot=
/dts/xilinx/zynqmp.dtsi
>>>> index 9aa6734..59a547b 100644
>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>> @@ -2,7 +2,7 @@
>>>>  /*
>>>>   * dts file for Xilinx ZynqMP
>>>>   *
>>>> - * (C) Copyright 2014 - 2015, Xilinx, Inc.
>>>> + * (C) Copyright 2014 - 2019, Xilinx, Inc.
>>>>   *
>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>   *
>>>> @@ -124,6 +124,28 @@
>>>>  			     <1 10 0xf08>;
>>>>  	};
>>>>
>>>> +	firmware {
>>>> +		zynqmp_firmware: zynqmp-firmware {
>>>> +			compatible =3D "xlnx,zynqmp-firmware";
>>>> +			method =3D "smc";
>>>> +			zynqmp_clk: clock-controller {
>>>> +				u-boot,dm-pre-reloc;
>>>> +				#clock-cells =3D <1>;
>>>> +				compatible =3D "xlnx,zynqmp-clk";
>>>> +				clocks =3D <&pss_ref_clk>,
>>>> +					 <&video_clk>,
>>>> +					 <&pss_alt_ref_clk>,
>>>> +					 <&aux_ref_clk>,
>>>> +					 <&gt_crx_ref_clk>;
>>>> +				clock-names =3D "pss_ref_clk",
>>>> +					      "video_clk",
>>>> +					      "pss_alt_ref_clk",
>>>> +					      "aux_ref_clk",
>>>> +					      "gt_crx_ref_clk";
>>>> +			};
>>>> +		};
>>>> +	};
>>>> +
>>>>  	amba_apu: amba-apu@0 {
>>>>  		compatible =3D "simple-bus";
>>>>  		#address-cells =3D <2>;
>>>>
>>>
>>> Updating my Ultra96 setups from 5.4 to 5.10, I ran into a blocker:
>>> Starting from this commit on, I'm no longer getting the kernel to boot
>>> on both revision 1 and 2 (arm64 defconfig as reference). If I switch t=
he
>>> DTBs back before this commit, even a kernel from today's head is fine.
>>>
>>> Further versions of potential relevance:
>>>  - PMUFW 2019.1 and 2020.2
>>>  - TF-A 2.3
>>>  - U-Boot 2020.10
>>>
>>> What's missing? I suspect someone forgot to document a subtle dependen=
cy
>>> of this change.
>>
>> Does this fix your issue?
>> https://lore.kernel.org/linux-arm-kernel/20210316090540.973014-1-punit1=
.agrawal@toshiba.co.jp/
>>
>
> Nope, CONFIG_COMMON_CLK_ZYNQMP=3Dy does not help. Maybe the defconfig is
> missing even more. If you have some reference, I'm happy to try. I
> suspect that earlyprintk will also not reveal more without clocks (but I
> didn't play with that yet).
>
> Meanwhile, I'm carrying a revert of this commit and a related cleanup.
> That helps for now.
>

OK, dependencies resolved (unfortunately the hard way): It either
requires TF-A master or latest release v2.4 + [1] and [2].

Those TF-A commits were upstream about a year after the firmware-based
clock control hit the kernel. A note would have been nice - or better
sychronization between both upstreaming efforts.

Jan

[1]
https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=3Dc=
23cf053037ecc4521a7e03ba0100f1c78afd580
[2]
https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=3Da=
8b10c6490e5a4656bfa06fae5c0f19fabfe4ab2
