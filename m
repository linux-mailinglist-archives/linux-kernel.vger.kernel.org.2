Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BED3351A64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbhDASAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:00:44 -0400
Received: from mout.web.de ([217.72.192.78]:55155 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236413AbhDARoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1617299082;
        bh=umachb5L4Rh+9LC8tk5fZUXerK5xUJY2V8FE3/GAhes=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=RSv082TiHKICUuLqViPPc6XQarhVjvnJpRNa++qnzXWTKwr5pQ2AdJdGcATs9qQgY
         5SZB0lJX8Fd6vV2MWPA1ByaE18wA6nsS0+jMM481pa+WTsGjq7WgBgzbDTrN6j2v3A
         JLDxH58TNjfSB1ZK4e4UY6zxMh6xCO8H9kZwVsS8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([84.61.93.130]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N79RG-1lg4k802CC-017Yip; Thu, 01
 Apr 2021 16:52:48 +0200
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
From:   Jan Kiszka <jan.kiszka@web.de>
Message-ID: <09343e7d-fcd8-1a54-470f-c0d8741921b1@web.de>
Date:   Thu, 1 Apr 2021 16:52:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <580bccb2-2e41-aec7-2612-99a2b231f2fc@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vGywyNvXpMsw1mQSKhj7uufyvwRkYPhazD7qHn6z0LzqCZ902sy
 +zR7pNGbscbj6FnJHzz+cYnR+smioMQod9m/1FyUTHjQeO7+AG4RACh5tHvYUwW0smUH+bh
 en5YHCS9/toxVEvscDf3BSvek+BQ0Xt2RMQb/Y/dbcdB3zQI7kU51BhNhenneF70vVm8Nim
 nkCtYE68lAyCHX6Rh/2DA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GUg6T/KRTkg=:cyf+WX2Q7gadsEJOJeL7ng
 DYkNdTjnBgpn1KO6UKAh+HqUwGIvLP3r0/Z8dm5aVlkub78x+vqxtqnG+7BC8iMPHbwAvQmj3
 hJURYzvSo+j7eOeUE2sZpAYv4xAY0U9bKq0xYL/Ga2E3SW74DuC/ff9LaI9lAh0J+wPVTHQuj
 A6tZDYjBtRQEhEU1VuQlDO4XzHKJroZvTOPpzytoQxcAFUkyNc1XXEADE7uprviejKqxgBnA3
 Y/aau7ZBy3wT8me4ywlrKf2w0FkpyJ3JFoICWwUOBtPVE53kEOOk/tFJac4RneRfYCSLVV7GE
 7Soz4DNTaT5Bd4+rBQOiYhIazPAgzdVmjM3fMpYOwHYyXomN6kV5Lh5Vt441EdZ+xx5ikusGs
 RTGNNH3Ov/Zn1OD0GFko0naKy+3KvG/61wCCzU9dnBlN5c64h3kt95FgCThKuMVNAxjaVlsT2
 NNFyBMhzy+UVcu3mAN+dsMQWZyvte0qUA+b3k3uSI+qSjsCraP105eFvkilw8UKL7G8mZk2A0
 CNubzrmPB/nu/tpmdH3A8A+nPsg5Uj6NYZH4UyhZBlQkHaGY+8OJDe8VmFTF9B+oQkGuyLIrs
 dLwfZuau9u/zyyYHNNeGRFtKoITwO5xhgWAvu2bqfFi3UskmsvuXHHkVyIjhsmgxDx2Z8vWle
 O/+yg7uKgkuSaax+Xwzt5PdoLxP00SDrUHnzTn+X5Hu6IoCtBM1iBLBwAJfINwLYBRS/X/eBB
 ABFc3AoQ6MAHNbb28/TDF85JjQY3XO/SvZXrRw5Kvi3YLM9e9fBEQI6gxSF5XGMjGKaGVTcxi
 RgJ4J52Qq+9H9iMCU8fRjl03Rs5bPmBMNWarO9i6JRBubSZo3JF6u23bzDFH7zVOtBin3AhdW
 TsGzHcvySOlxjnCJ4DfxB5ow7HKp5W2/WzsltWUM2bEBhy6+BqSQmb0ZvtFddRfMuNm87v/Jj
 5eOrqHQPN8UzMGJKgmGlCsyiWA+urYhEtmCESYKd+pCxdOXJwhCPfJpEu4A01rXSpNgObcBvu
 NAiin/zUQ2rk90MoVoqoOBPEI7M+XeJwz2Gn+lXcwSu3z1RQZi1shbstioxjF015/5UaZT+u1
 oMjocX9FVEr89th6TBndZtqPg7bmgTnvm6cSvEySY05//6vyT8w0+q5kDovDAVhoMvmkSq/N5
 cJZdiSxXMBsO/jOZjNwiibCX8f9oB3xnhdTlG1AScXz5k8a0FbTJMCAuW/jEilCophqb0=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.04.21 13:42, Michal Simek wrote:
> Hi Jan,
>
> On 3/27/21 8:55 PM, Jan Kiszka wrote:
>> On 07.11.19 10:44, Rajan Vaja wrote:
>>> Add clock nodes for zynqmp based on CCF.
>>>
>>> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
>>> ---
>>>  arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi     | 222 ++++++++++++=
+++++++++
>>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts  |   4 +-
>>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts  |   4 +-
>>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts  |   2 +-
>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |   4 +-
>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |   4 +-
>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |   4 +-
>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |   4 +-
>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    |   4 +-
>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts  |   4 +-
>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  |   4 +-
>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts  |   4 +-
>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts  |   4 +-
>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts  |   4 +-
>>>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |  24 ++-
>>>  15 files changed, 270 insertions(+), 26 deletions(-)
>>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm=
64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>>> new file mode 100644
>>> index 0000000..9868ca1
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>>> @@ -0,0 +1,222 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Clock specification for Xilinx ZynqMP
>>> + *
>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>> + *
>>> + * Michal Simek <michal.simek@xilinx.com>
>>> + */
>>> +
>>> +#include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>>> +/ {
>>> +	pss_ref_clk: pss_ref_clk {
>>> +		u-boot,dm-pre-reloc;
>>> +		compatible =3D "fixed-clock";
>>> +		#clock-cells =3D <0>;
>>> +		clock-frequency =3D <33333333>;
>>> +	};
>>> +
>>> +	video_clk: video_clk {
>>> +		u-boot,dm-pre-reloc;
>>> +		compatible =3D "fixed-clock";
>>> +		#clock-cells =3D <0>;
>>> +		clock-frequency =3D <27000000>;
>>> +	};
>>> +
>>> +	pss_alt_ref_clk: pss_alt_ref_clk {
>>> +		u-boot,dm-pre-reloc;
>>> +		compatible =3D "fixed-clock";
>>> +		#clock-cells =3D <0>;
>>> +		clock-frequency =3D <0>;
>>> +	};
>>> +
>>> +	gt_crx_ref_clk: gt_crx_ref_clk {
>>> +		u-boot,dm-pre-reloc;
>>> +		compatible =3D "fixed-clock";
>>> +		#clock-cells =3D <0>;
>>> +		clock-frequency =3D <108000000>;
>>> +	};
>>> +
>>> +	aux_ref_clk: aux_ref_clk {
>>> +		u-boot,dm-pre-reloc;
>>> +		compatible =3D "fixed-clock";
>>> +		#clock-cells =3D <0>;
>>> +		clock-frequency =3D <27000000>;
>>> +	};
>>> +};
>>> +
>>> +&can0 {
>>> +	clocks =3D <&zynqmp_clk CAN0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&can1 {
>>> +	clocks =3D <&zynqmp_clk CAN1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&cpu0 {
>>> +	clocks =3D <&zynqmp_clk ACPU>;
>>> +};
>>> +
>>> +&fpd_dma_chan1 {
>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&fpd_dma_chan2 {
>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&fpd_dma_chan3 {
>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&fpd_dma_chan4 {
>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&fpd_dma_chan5 {
>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&fpd_dma_chan6 {
>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&fpd_dma_chan7 {
>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&fpd_dma_chan8 {
>>> +	clocks =3D <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&lpd_dma_chan1 {
>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&lpd_dma_chan2 {
>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&lpd_dma_chan3 {
>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&lpd_dma_chan4 {
>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&lpd_dma_chan5 {
>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&lpd_dma_chan6 {
>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&lpd_dma_chan7 {
>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&lpd_dma_chan8 {
>>> +	clocks =3D <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&gem0 {
>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM0_REF>,
>>> +		 <&zynqmp_clk GEM0_TX>, <&zynqmp_clk GEM0_RX>,
>>> +		 <&zynqmp_clk GEM_TSU>;
>>> +	clock-names =3D "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>> +};
>>> +
>>> +&gem1 {
>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM1_REF>,
>>> +		 <&zynqmp_clk GEM1_TX>, <&zynqmp_clk GEM1_RX>,
>>> +		 <&zynqmp_clk GEM_TSU>;
>>> +	clock-names =3D "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>> +};
>>> +
>>> +&gem2 {
>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM2_REF>,
>>> +		 <&zynqmp_clk GEM2_TX>, <&zynqmp_clk GEM2_RX>,
>>> +		 <&zynqmp_clk GEM_TSU>;
>>> +	clock-names =3D "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>> +};
>>> +
>>> +&gem3 {
>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM3_REF>,
>>> +		 <&zynqmp_clk GEM3_TX>, <&zynqmp_clk GEM3_RX>,
>>> +		 <&zynqmp_clk GEM_TSU>;
>>> +	clock-names =3D "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>> +};
>>> +
>>> +&gpio {
>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&i2c0 {
>>> +	clocks =3D <&zynqmp_clk I2C0_REF>;
>>> +};
>>> +
>>> +&i2c1 {
>>> +	clocks =3D <&zynqmp_clk I2C1_REF>;
>>> +};
>>> +
>>> +&pcie {
>>> +	clocks =3D <&zynqmp_clk PCIE_REF>;
>>> +};
>>> +
>>> +&sata {
>>> +	clocks =3D <&zynqmp_clk SATA_REF>;
>>> +};
>>> +
>>> +&sdhci0 {
>>> +	clocks =3D <&zynqmp_clk SDIO0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&sdhci1 {
>>> +	clocks =3D <&zynqmp_clk SDIO1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&spi0 {
>>> +	clocks =3D <&zynqmp_clk SPI0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&spi1 {
>>> +	clocks =3D <&zynqmp_clk SPI1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&ttc0 {
>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&ttc1 {
>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&ttc2 {
>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&ttc3 {
>>> +	clocks =3D <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&uart0 {
>>> +	clocks =3D <&zynqmp_clk UART0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&uart1 {
>>> +	clocks =3D <&zynqmp_clk UART1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>> +};
>>> +
>>> +&usb0 {
>>> +	clocks =3D <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
>>> +};
>>> +
>>> +&usb1 {
>>> +	clocks =3D <&zynqmp_clk USB1_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
>>> +};
>>> +
>>> +&watchdog0 {
>>> +	clocks =3D <&zynqmp_clk WDT>;
>>> +};
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/=
arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>> index 0f7b4cf..2e05fa4 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>> @@ -2,7 +2,7 @@
>>>  /*
>>>   * dts file for Xilinx ZynqMP ZC1232
>>>   *
>>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>   *
>>>   * Michal Simek <michal.simek@xilinx.com>
>>>   */
>>> @@ -10,7 +10,7 @@
>>>  /dts-v1/;
>>>
>>>  #include "zynqmp.dtsi"
>>> -#include "zynqmp-clk.dtsi"
>>> +#include "zynqmp-clk-ccf.dtsi"
>>>
>>>  / {
>>>  	model =3D "ZynqMP ZC1232 RevA";
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/=
arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>> index 9092828..3d0aaa0 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>> @@ -2,7 +2,7 @@
>>>  /*
>>>   * dts file for Xilinx ZynqMP ZC1254
>>>   *
>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>   *
>>>   * Michal Simek <michal.simek@xilinx.com>
>>>   * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
>>> @@ -11,7 +11,7 @@
>>>  /dts-v1/;
>>>
>>>  #include "zynqmp.dtsi"
>>> -#include "zynqmp-clk.dtsi"
>>> +#include "zynqmp-clk-ccf.dtsi"
>>>
>>>  / {
>>>  	model =3D "ZynqMP ZC1254 RevA";
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts b/arch/=
arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>>> index 4f404c5..1a8127d4 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>>> @@ -11,7 +11,7 @@
>>>  /dts-v1/;
>>>
>>>  #include "zynqmp.dtsi"
>>> -#include "zynqmp-clk.dtsi"
>>> +#include "zynqmp-clk-ccf.dtsi"
>>>
>>>  / {
>>>  	model =3D "ZynqMP ZC1275 RevA";
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/=
arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>> index 9a3e39d..fa7eb1b 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>> @@ -2,7 +2,7 @@
>>>  /*
>>>   * dts file for Xilinx ZynqMP zc1751-xm015-dc1
>>>   *
>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>   *
>>>   * Michal Simek <michal.simek@xilinx.com>
>>>   */
>>> @@ -10,7 +10,7 @@
>>>  /dts-v1/;
>>>
>>>  #include "zynqmp.dtsi"
>>> -#include "zynqmp-clk.dtsi"
>>> +#include "zynqmp-clk-ccf.dtsi"
>>>  #include <dt-bindings/gpio/gpio.h>
>>>
>>>  / {
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/=
arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>>> index 2421ec7..4191dfa 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>>> @@ -2,7 +2,7 @@
>>>  /*
>>>   * dts file for Xilinx ZynqMP zc1751-xm016-dc2
>>>   *
>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>   *
>>>   * Michal Simek <michal.simek@xilinx.com>
>>>   */
>>> @@ -10,7 +10,7 @@
>>>  /dts-v1/;
>>>
>>>  #include "zynqmp.dtsi"
>>> -#include "zynqmp-clk.dtsi"
>>> +#include "zynqmp-clk-ccf.dtsi"
>>>  #include <dt-bindings/gpio/gpio.h>
>>>
>>>  / {
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/=
arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>>> index 7a49dee..3750690 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>>> @@ -2,7 +2,7 @@
>>>  /*
>>>   * dts file for Xilinx ZynqMP zc1751-xm017-dc3
>>>   *
>>> - * (C) Copyright 2016 - 2018, Xilinx, Inc.
>>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>>   *
>>>   * Michal Simek <michal.simek@xilinx.com>
>>>   */
>>> @@ -10,7 +10,7 @@
>>>  /dts-v1/;
>>>
>>>  #include "zynqmp.dtsi"
>>> -#include "zynqmp-clk.dtsi"
>>> +#include "zynqmp-clk-ccf.dtsi"
>>>
>>>  / {
>>>  	model =3D "ZynqMP zc1751-xm017-dc3 RevA";
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/=
arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>> index 54c7b4f..2366cd9 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>> @@ -2,7 +2,7 @@
>>>  /*
>>>   * dts file for Xilinx ZynqMP zc1751-xm018-dc4
>>>   *
>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>   *
>>>   * Michal Simek <michal.simek@xilinx.com>
>>>   */
>>> @@ -10,7 +10,7 @@
>>>  /dts-v1/;
>>>
>>>  #include "zynqmp.dtsi"
>>> -#include "zynqmp-clk.dtsi"
>>> +#include "zynqmp-clk-ccf.dtsi"
>>>
>>>  / {
>>>  	model =3D "ZynqMP zc1751-xm018-dc4";
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b/=
arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>>> index b8b5ff1..9a894e6 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>>> @@ -2,7 +2,7 @@
>>>  /*
>>>   * dts file for Xilinx ZynqMP zc1751-xm019-dc5
>>>   *
>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>   *
>>>   * Siva Durga Prasad <siva.durga.paladugu@xilinx.com>
>>>   * Michal Simek <michal.simek@xilinx.com>
>>> @@ -11,7 +11,7 @@
>>>  /dts-v1/;
>>>
>>>  #include "zynqmp.dtsi"
>>> -#include "zynqmp-clk.dtsi"
>>> +#include "zynqmp-clk-ccf.dtsi"
>>>  #include <dt-bindings/gpio/gpio.h>
>>>
>>>  / {
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/=
arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>> index e5699d0..3e39454 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>> @@ -2,7 +2,7 @@
>>>  /*
>>>   * dts file for Xilinx ZynqMP ZCU100 revC
>>>   *
>>> - * (C) Copyright 2016 - 2018, Xilinx, Inc.
>>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>>   *
>>>   * Michal Simek <michal.simek@xilinx.com>
>>>   * Nathalie Chan King Choy
>>> @@ -11,7 +11,7 @@
>>>  /dts-v1/;
>>>
>>>  #include "zynqmp.dtsi"
>>> -#include "zynqmp-clk.dtsi"
>>> +#include "zynqmp-clk-ccf.dtsi"
>>>  #include <dt-bindings/input/input.h>
>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>  #include <dt-bindings/gpio/gpio.h>
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/=
arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>> index 2a3b665..f6e9558 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>> @@ -2,7 +2,7 @@
>>>  /*
>>>   * dts file for Xilinx ZynqMP ZCU102 RevA
>>>   *
>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>   *
>>>   * Michal Simek <michal.simek@xilinx.com>
>>>   */
>>> @@ -10,7 +10,7 @@
>>>  /dts-v1/;
>>>
>>>  #include "zynqmp.dtsi"
>>> -#include "zynqmp-clk.dtsi"
>>> +#include "zynqmp-clk-ccf.dtsi"
>>>  #include <dt-bindings/input/input.h>
>>>  #include <dt-bindings/gpio/gpio.h>
>>>
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/=
arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>>> index 8f45614..f457f8a 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>>> @@ -2,7 +2,7 @@
>>>  /*
>>>   * dts file for Xilinx ZynqMP ZCU104
>>>   *
>>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>   *
>>>   * Michal Simek <michal.simek@xilinx.com>
>>>   */
>>> @@ -10,7 +10,7 @@
>>>  /dts-v1/;
>>>
>>>  #include "zynqmp.dtsi"
>>> -#include "zynqmp-clk.dtsi"
>>> +#include "zynqmp-clk-ccf.dtsi"
>>>  #include <dt-bindings/gpio/gpio.h>
>>>
>>>  / {
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/=
arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>>> index 93ce7eb..f15b99a 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>>> @@ -2,7 +2,7 @@
>>>  /*
>>>   * dts file for Xilinx ZynqMP ZCU106
>>>   *
>>> - * (C) Copyright 2016, Xilinx, Inc.
>>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>>   *
>>>   * Michal Simek <michal.simek@xilinx.com>
>>>   */
>>> @@ -10,7 +10,7 @@
>>>  /dts-v1/;
>>>
>>>  #include "zynqmp.dtsi"
>>> -#include "zynqmp-clk.dtsi"
>>> +#include "zynqmp-clk-ccf.dtsi"
>>>  #include <dt-bindings/input/input.h>
>>>  #include <dt-bindings/gpio/gpio.h>
>>>
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/=
arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>>> index 8bb0001..e27cd60 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>>> @@ -2,7 +2,7 @@
>>>  /*
>>>   * dts file for Xilinx ZynqMP ZCU111
>>>   *
>>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>   *
>>>   * Michal Simek <michal.simek@xilinx.com>
>>>   */
>>> @@ -10,7 +10,7 @@
>>>  /dts-v1/;
>>>
>>>  #include "zynqmp.dtsi"
>>> -#include "zynqmp-clk.dtsi"
>>> +#include "zynqmp-clk-ccf.dtsi"
>>>  #include <dt-bindings/input/input.h>
>>>  #include <dt-bindings/gpio/gpio.h>
>>>
>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/=
dts/xilinx/zynqmp.dtsi
>>> index 9aa6734..59a547b 100644
>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>> @@ -2,7 +2,7 @@
>>>  /*
>>>   * dts file for Xilinx ZynqMP
>>>   *
>>> - * (C) Copyright 2014 - 2015, Xilinx, Inc.
>>> + * (C) Copyright 2014 - 2019, Xilinx, Inc.
>>>   *
>>>   * Michal Simek <michal.simek@xilinx.com>
>>>   *
>>> @@ -124,6 +124,28 @@
>>>  			     <1 10 0xf08>;
>>>  	};
>>>
>>> +	firmware {
>>> +		zynqmp_firmware: zynqmp-firmware {
>>> +			compatible =3D "xlnx,zynqmp-firmware";
>>> +			method =3D "smc";
>>> +			zynqmp_clk: clock-controller {
>>> +				u-boot,dm-pre-reloc;
>>> +				#clock-cells =3D <1>;
>>> +				compatible =3D "xlnx,zynqmp-clk";
>>> +				clocks =3D <&pss_ref_clk>,
>>> +					 <&video_clk>,
>>> +					 <&pss_alt_ref_clk>,
>>> +					 <&aux_ref_clk>,
>>> +					 <&gt_crx_ref_clk>;
>>> +				clock-names =3D "pss_ref_clk",
>>> +					      "video_clk",
>>> +					      "pss_alt_ref_clk",
>>> +					      "aux_ref_clk",
>>> +					      "gt_crx_ref_clk";
>>> +			};
>>> +		};
>>> +	};
>>> +
>>>  	amba_apu: amba-apu@0 {
>>>  		compatible =3D "simple-bus";
>>>  		#address-cells =3D <2>;
>>>
>>
>> Updating my Ultra96 setups from 5.4 to 5.10, I ran into a blocker:
>> Starting from this commit on, I'm no longer getting the kernel to boot
>> on both revision 1 and 2 (arm64 defconfig as reference). If I switch th=
e
>> DTBs back before this commit, even a kernel from today's head is fine.
>>
>> Further versions of potential relevance:
>>  - PMUFW 2019.1 and 2020.2
>>  - TF-A 2.3
>>  - U-Boot 2020.10
>>
>> What's missing? I suspect someone forgot to document a subtle dependenc=
y
>> of this change.
>
> Does this fix your issue?
> https://lore.kernel.org/linux-arm-kernel/20210316090540.973014-1-punit1.=
agrawal@toshiba.co.jp/
>

Nope, CONFIG_COMMON_CLK_ZYNQMP=3Dy does not help. Maybe the defconfig is
missing even more. If you have some reference, I'm happy to try. I
suspect that earlyprintk will also not reveal more without clocks (but I
didn't play with that yet).

Meanwhile, I'm carrying a revert of this commit and a related cleanup.
That helps for now.

Jan
