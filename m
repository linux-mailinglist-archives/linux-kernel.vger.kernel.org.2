Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8069C351C38
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238296AbhDASOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbhDAR4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 13:56:30 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA4FC05BD1B;
        Thu,  1 Apr 2021 05:57:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZiY+OjG+3v+jD8Crcnpw1JuFx+z7Co3OG1rNYjq2y2dy3CE/fZuKHzoupg+xzhMAZqAhY1IzHuOrZw0xgGEAPD2fwtIXDh8c1LgmF5boGgSh3bu02nuI3Bbwu1rcW0GamaSHyEtGNVqufaLJl1h7Tu5D9GI2AK39N1izsHpWbSGoFqOwE3WQoqRMyZBwFyvnL0tZjYCDOhexqCkU0MgcnkYKUdzQzDuptf2LDaAtU4eDfZSfLiymptPSPdRrh9VwOOSSZ1YTsyk3bER0FUyXfxlbGThFoZw5hzpFpOR/0kw4hyXRIoSIn41pxEqV6zDNtBtNcPtqiMBafO0h1Y5Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoZhI5nUEFeYR6b/GHwNUQvmZkhT1e/8D2F+75CpHQA=;
 b=eS8Pc+KzCBC7hK2/VCiDt0qNy5ITv5vVT9W8togKBf7BYLvSf1HrxS4lxVwl8GupU+V+uOMPUSek2WW87WQFahyLWbr/KHLgOpmtFNMEJng3FJ2ahQHvP4V6Vows+gdUHbZB2bjGtukNnF/gpVCnaXG7Mb6o3fbuJPrTnU4zzxJVGC2fQuv5QOs1WKR4SfHkBA5FsFHGtb4a8SJIaXRJ7tsDXo9SAw7lXcje3FJR0fnX6ueGvVTv0fpyIYEccTsobdi4Pk4xs4uKdo4yEOsT+v24VvqPzuueYEF/T7hswkatCaNEqcPXQOmaJQqKGvZa1OocylGn7VVuoFPtvYwfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoZhI5nUEFeYR6b/GHwNUQvmZkhT1e/8D2F+75CpHQA=;
 b=OHga+blgk1d87f8ooowk1fHVIrrwKEJPRRvrxpkUIURZidzLgZBZumW2FMWbi5AV6zCy63xvoZzCYA3bPBOPu9kdXzlKRleoDou8c42qp0rDNuRTtISCNoPL9Y4wBrTIEcPOKevaPWWWvkUsFSnIU+6B65cjYBIrs5eOP/QUHL8=
Received: from CY4PR07CA0001.namprd07.prod.outlook.com (2603:10b6:903:165::11)
 by BYAPR02MB5576.namprd02.prod.outlook.com (2603:10b6:a03:a1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Thu, 1 Apr
 2021 11:42:26 +0000
Received: from CY1NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:165:cafe::d5) by CY4PR07CA0001.outlook.office365.com
 (2603:10b6:903:165::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend
 Transport; Thu, 1 Apr 2021 11:42:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT048.mail.protection.outlook.com (10.152.74.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3977.25 via Frontend Transport; Thu, 1 Apr 2021 11:42:26 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 1 Apr 2021 04:42:25 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Thu, 1 Apr 2021 04:42:25 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 heiko@sntech.de,
 mripard@kernel.org,
 xuwei5@hisilicon.com,
 ulf.hansson@linaro.org,
 mark.rutland@arm.com,
 robh+dt@kernel.org,
 jan.kiszka@web.de
Received: from [172.30.17.109] (port=40904)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lRviS-0000Uq-D6; Thu, 01 Apr 2021 04:42:25 -0700
Subject: Re: [PATCH 1/3] arm64: dts: xilinx: Add the clock nodes for zynqmp
To:     Jan Kiszka <jan.kiszka@web.de>, Rajan Vaja <rajan.vaja@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <harini.katakam@xilinx.com>,
        <ulf.hansson@linaro.org>, <xuwei5@hisilicon.com>,
        <mripard@kernel.org>, <heiko@sntech.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1573119856-13548-1-git-send-email-rajan.vaja@xilinx.com>
 <1573119856-13548-2-git-send-email-rajan.vaja@xilinx.com>
 <8b039dac-06c4-6b33-f53b-44b8fa144495@web.de>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <580bccb2-2e41-aec7-2612-99a2b231f2fc@xilinx.com>
Date:   Thu, 1 Apr 2021 13:42:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <8b039dac-06c4-6b33-f53b-44b8fa144495@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 292f956e-25bc-46af-4f01-08d8f5033946
X-MS-TrafficTypeDiagnostic: BYAPR02MB5576:
X-Microsoft-Antispam-PRVS: <BYAPR02MB55762C63389648E66BCD2A3BC67B9@BYAPR02MB5576.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:162;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FsKUZhGfaRxPygkqfAJ9dyJIqI13gP6pena/dJxSYPD725hFwfZOaRmG1mpoid1tWB1GTVmC1umgVqv906IPamFXHdAqRNVAITuME7amgPd0dwIPFFYsN9iEImu14vGBGYL2ST6mPj2nnHAdAYvIe/umHBKyi26eBAc8Ola/pWw8+T8UbJXbDl78hldymSTn19mDi0jdKqbK2lRhUXSeWAoZQ2pvxWLsJ5xmnXLl39ZFdmlo7uw+yk5DLmhiAf5+7Y5MasxYDgEFltSmLnid+iuTj2ruGIPjoouzdqs5ho8hICPlCF4BVOu2Zf4+F+87ioBz8ZL4t8jjdhGUadVBUnoU8Ljujk75YA5BzNzmFSds+oC7FXc6eCKgHCm5HMHsSeke3cMJT8ulv/FcMuopz8t1loVtyffTUF053UX+mPcSh9UToeGThtl7RZZcGUGBoxXvXZltGvDy97F7I7gINm9T2yG3wKEKaV6i6MAxsjsWNVrT1e1kJDgRe+igkWx9VpQ2Nz9Zyf0aaFOtFt5leXwYk1aEoU8g7KqYsgZBFOxn4xbD6/4wwb+ThqLYnMWWIwVwDnbCUIaX5JUNCRYdp89bgwlOONNonrbbJAgSnoJucDJvlH0a8nlkcPqXNE12uENb3RtmU3wIs1Tx2STtwaXH75TfsFi1pM0Cswzrx8iW7TCkFbx2wgVdu5SKepuMug+HweAMbetv5e4vPrH5y7mrkq6sdFPu1fTLBnt+Ba4xuWmYzq10DahH7JrtNR7AyJH1eSO7LxBtkpBwyqM5EqSAsVh1kRWSclAkF49fXq7kv3KVFmQatERbEhil1Z7HA8jeOYOLTrJXsWowRlOjrh+0DLtJeEQCJuV6E4IRlso=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(46966006)(36840700001)(47076005)(7416002)(110136005)(70586007)(9786002)(70206006)(44832011)(186003)(2616005)(966005)(36756003)(921005)(31696002)(82310400003)(36860700001)(426003)(53546011)(54906003)(8676002)(336012)(8936002)(31686004)(30864003)(5660300002)(2906002)(6666004)(4326008)(26005)(82740400003)(83380400001)(36906005)(478600001)(316002)(7636003)(356005)(50156003)(83996005)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 11:42:26.6911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 292f956e-25bc-46af-4f01-08d8f5033946
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5576
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 3/27/21 8:55 PM, Jan Kiszka wrote:
> On 07.11.19 10:44, Rajan Vaja wrote:
>> Add clock nodes for zynqmp based on CCF.
>>
>> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
>> ---
>>  arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi     | 222 +++++++++++++++++++++
>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts  |   4 +-
>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts  |   4 +-
>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts  |   2 +-
>>  .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |   4 +-
>>  .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |   4 +-
>>  .../boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |   4 +-
>>  .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |   4 +-
>>  .../boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    |   4 +-
>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts  |   4 +-
>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  |   4 +-
>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts  |   4 +-
>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts  |   4 +-
>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts  |   4 +-
>>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |  24 ++-
>>  15 files changed, 270 insertions(+), 26 deletions(-)
>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>> new file mode 100644
>> index 0000000..9868ca1
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>> @@ -0,0 +1,222 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Clock specification for Xilinx ZynqMP
>> + *
>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>> + *
>> + * Michal Simek <michal.simek@xilinx.com>
>> + */
>> +
>> +#include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>> +/ {
>> +	pss_ref_clk: pss_ref_clk {
>> +		u-boot,dm-pre-reloc;
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <33333333>;
>> +	};
>> +
>> +	video_clk: video_clk {
>> +		u-boot,dm-pre-reloc;
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <27000000>;
>> +	};
>> +
>> +	pss_alt_ref_clk: pss_alt_ref_clk {
>> +		u-boot,dm-pre-reloc;
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <0>;
>> +	};
>> +
>> +	gt_crx_ref_clk: gt_crx_ref_clk {
>> +		u-boot,dm-pre-reloc;
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <108000000>;
>> +	};
>> +
>> +	aux_ref_clk: aux_ref_clk {
>> +		u-boot,dm-pre-reloc;
>> +		compatible = "fixed-clock";
>> +		#clock-cells = <0>;
>> +		clock-frequency = <27000000>;
>> +	};
>> +};
>> +
>> +&can0 {
>> +	clocks = <&zynqmp_clk CAN0_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&can1 {
>> +	clocks = <&zynqmp_clk CAN1_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&cpu0 {
>> +	clocks = <&zynqmp_clk ACPU>;
>> +};
>> +
>> +&fpd_dma_chan1 {
>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&fpd_dma_chan2 {
>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&fpd_dma_chan3 {
>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&fpd_dma_chan4 {
>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&fpd_dma_chan5 {
>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&fpd_dma_chan6 {
>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&fpd_dma_chan7 {
>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&fpd_dma_chan8 {
>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&lpd_dma_chan1 {
>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&lpd_dma_chan2 {
>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&lpd_dma_chan3 {
>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&lpd_dma_chan4 {
>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&lpd_dma_chan5 {
>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&lpd_dma_chan6 {
>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&lpd_dma_chan7 {
>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&lpd_dma_chan8 {
>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&gem0 {
>> +	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM0_REF>,
>> +		 <&zynqmp_clk GEM0_TX>, <&zynqmp_clk GEM0_RX>,
>> +		 <&zynqmp_clk GEM_TSU>;
>> +	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>> +};
>> +
>> +&gem1 {
>> +	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM1_REF>,
>> +		 <&zynqmp_clk GEM1_TX>, <&zynqmp_clk GEM1_RX>,
>> +		 <&zynqmp_clk GEM_TSU>;
>> +	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>> +};
>> +
>> +&gem2 {
>> +	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM2_REF>,
>> +		 <&zynqmp_clk GEM2_TX>, <&zynqmp_clk GEM2_RX>,
>> +		 <&zynqmp_clk GEM_TSU>;
>> +	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>> +};
>> +
>> +&gem3 {
>> +	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM3_REF>,
>> +		 <&zynqmp_clk GEM3_TX>, <&zynqmp_clk GEM3_RX>,
>> +		 <&zynqmp_clk GEM_TSU>;
>> +	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>> +};
>> +
>> +&gpio {
>> +	clocks = <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&i2c0 {
>> +	clocks = <&zynqmp_clk I2C0_REF>;
>> +};
>> +
>> +&i2c1 {
>> +	clocks = <&zynqmp_clk I2C1_REF>;
>> +};
>> +
>> +&pcie {
>> +	clocks = <&zynqmp_clk PCIE_REF>;
>> +};
>> +
>> +&sata {
>> +	clocks = <&zynqmp_clk SATA_REF>;
>> +};
>> +
>> +&sdhci0 {
>> +	clocks = <&zynqmp_clk SDIO0_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&sdhci1 {
>> +	clocks = <&zynqmp_clk SDIO1_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&spi0 {
>> +	clocks = <&zynqmp_clk SPI0_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&spi1 {
>> +	clocks = <&zynqmp_clk SPI1_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&ttc0 {
>> +	clocks = <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&ttc1 {
>> +	clocks = <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&ttc2 {
>> +	clocks = <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&ttc3 {
>> +	clocks = <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&uart0 {
>> +	clocks = <&zynqmp_clk UART0_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&uart1 {
>> +	clocks = <&zynqmp_clk UART1_REF>, <&zynqmp_clk LPD_LSBUS>;
>> +};
>> +
>> +&usb0 {
>> +	clocks = <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
>> +};
>> +
>> +&usb1 {
>> +	clocks = <&zynqmp_clk USB1_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
>> +};
>> +
>> +&watchdog0 {
>> +	clocks = <&zynqmp_clk WDT>;
>> +};
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>> index 0f7b4cf..2e05fa4 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>> @@ -2,7 +2,7 @@
>>  /*
>>   * dts file for Xilinx ZynqMP ZC1232
>>   *
>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>   *
>>   * Michal Simek <michal.simek@xilinx.com>
>>   */
>> @@ -10,7 +10,7 @@
>>  /dts-v1/;
>>
>>  #include "zynqmp.dtsi"
>> -#include "zynqmp-clk.dtsi"
>> +#include "zynqmp-clk-ccf.dtsi"
>>
>>  / {
>>  	model = "ZynqMP ZC1232 RevA";
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>> index 9092828..3d0aaa0 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>> @@ -2,7 +2,7 @@
>>  /*
>>   * dts file for Xilinx ZynqMP ZC1254
>>   *
>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>   *
>>   * Michal Simek <michal.simek@xilinx.com>
>>   * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
>> @@ -11,7 +11,7 @@
>>  /dts-v1/;
>>
>>  #include "zynqmp.dtsi"
>> -#include "zynqmp-clk.dtsi"
>> +#include "zynqmp-clk-ccf.dtsi"
>>
>>  / {
>>  	model = "ZynqMP ZC1254 RevA";
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>> index 4f404c5..1a8127d4 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>> @@ -11,7 +11,7 @@
>>  /dts-v1/;
>>
>>  #include "zynqmp.dtsi"
>> -#include "zynqmp-clk.dtsi"
>> +#include "zynqmp-clk-ccf.dtsi"
>>
>>  / {
>>  	model = "ZynqMP ZC1275 RevA";
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>> index 9a3e39d..fa7eb1b 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>> @@ -2,7 +2,7 @@
>>  /*
>>   * dts file for Xilinx ZynqMP zc1751-xm015-dc1
>>   *
>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>   *
>>   * Michal Simek <michal.simek@xilinx.com>
>>   */
>> @@ -10,7 +10,7 @@
>>  /dts-v1/;
>>
>>  #include "zynqmp.dtsi"
>> -#include "zynqmp-clk.dtsi"
>> +#include "zynqmp-clk-ccf.dtsi"
>>  #include <dt-bindings/gpio/gpio.h>
>>
>>  / {
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>> index 2421ec7..4191dfa 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>> @@ -2,7 +2,7 @@
>>  /*
>>   * dts file for Xilinx ZynqMP zc1751-xm016-dc2
>>   *
>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>   *
>>   * Michal Simek <michal.simek@xilinx.com>
>>   */
>> @@ -10,7 +10,7 @@
>>  /dts-v1/;
>>
>>  #include "zynqmp.dtsi"
>> -#include "zynqmp-clk.dtsi"
>> +#include "zynqmp-clk-ccf.dtsi"
>>  #include <dt-bindings/gpio/gpio.h>
>>
>>  / {
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>> index 7a49dee..3750690 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>> @@ -2,7 +2,7 @@
>>  /*
>>   * dts file for Xilinx ZynqMP zc1751-xm017-dc3
>>   *
>> - * (C) Copyright 2016 - 2018, Xilinx, Inc.
>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>   *
>>   * Michal Simek <michal.simek@xilinx.com>
>>   */
>> @@ -10,7 +10,7 @@
>>  /dts-v1/;
>>
>>  #include "zynqmp.dtsi"
>> -#include "zynqmp-clk.dtsi"
>> +#include "zynqmp-clk-ccf.dtsi"
>>
>>  / {
>>  	model = "ZynqMP zc1751-xm017-dc3 RevA";
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>> index 54c7b4f..2366cd9 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>> @@ -2,7 +2,7 @@
>>  /*
>>   * dts file for Xilinx ZynqMP zc1751-xm018-dc4
>>   *
>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>   *
>>   * Michal Simek <michal.simek@xilinx.com>
>>   */
>> @@ -10,7 +10,7 @@
>>  /dts-v1/;
>>
>>  #include "zynqmp.dtsi"
>> -#include "zynqmp-clk.dtsi"
>> +#include "zynqmp-clk-ccf.dtsi"
>>
>>  / {
>>  	model = "ZynqMP zc1751-xm018-dc4";
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>> index b8b5ff1..9a894e6 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>> @@ -2,7 +2,7 @@
>>  /*
>>   * dts file for Xilinx ZynqMP zc1751-xm019-dc5
>>   *
>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>   *
>>   * Siva Durga Prasad <siva.durga.paladugu@xilinx.com>
>>   * Michal Simek <michal.simek@xilinx.com>
>> @@ -11,7 +11,7 @@
>>  /dts-v1/;
>>
>>  #include "zynqmp.dtsi"
>> -#include "zynqmp-clk.dtsi"
>> +#include "zynqmp-clk-ccf.dtsi"
>>  #include <dt-bindings/gpio/gpio.h>
>>
>>  / {
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>> index e5699d0..3e39454 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>> @@ -2,7 +2,7 @@
>>  /*
>>   * dts file for Xilinx ZynqMP ZCU100 revC
>>   *
>> - * (C) Copyright 2016 - 2018, Xilinx, Inc.
>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>   *
>>   * Michal Simek <michal.simek@xilinx.com>
>>   * Nathalie Chan King Choy
>> @@ -11,7 +11,7 @@
>>  /dts-v1/;
>>
>>  #include "zynqmp.dtsi"
>> -#include "zynqmp-clk.dtsi"
>> +#include "zynqmp-clk-ccf.dtsi"
>>  #include <dt-bindings/input/input.h>
>>  #include <dt-bindings/interrupt-controller/irq.h>
>>  #include <dt-bindings/gpio/gpio.h>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>> index 2a3b665..f6e9558 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>> @@ -2,7 +2,7 @@
>>  /*
>>   * dts file for Xilinx ZynqMP ZCU102 RevA
>>   *
>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>   *
>>   * Michal Simek <michal.simek@xilinx.com>
>>   */
>> @@ -10,7 +10,7 @@
>>  /dts-v1/;
>>
>>  #include "zynqmp.dtsi"
>> -#include "zynqmp-clk.dtsi"
>> +#include "zynqmp-clk-ccf.dtsi"
>>  #include <dt-bindings/input/input.h>
>>  #include <dt-bindings/gpio/gpio.h>
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>> index 8f45614..f457f8a 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>> @@ -2,7 +2,7 @@
>>  /*
>>   * dts file for Xilinx ZynqMP ZCU104
>>   *
>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>   *
>>   * Michal Simek <michal.simek@xilinx.com>
>>   */
>> @@ -10,7 +10,7 @@
>>  /dts-v1/;
>>
>>  #include "zynqmp.dtsi"
>> -#include "zynqmp-clk.dtsi"
>> +#include "zynqmp-clk-ccf.dtsi"
>>  #include <dt-bindings/gpio/gpio.h>
>>
>>  / {
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>> index 93ce7eb..f15b99a 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>> @@ -2,7 +2,7 @@
>>  /*
>>   * dts file for Xilinx ZynqMP ZCU106
>>   *
>> - * (C) Copyright 2016, Xilinx, Inc.
>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>   *
>>   * Michal Simek <michal.simek@xilinx.com>
>>   */
>> @@ -10,7 +10,7 @@
>>  /dts-v1/;
>>
>>  #include "zynqmp.dtsi"
>> -#include "zynqmp-clk.dtsi"
>> +#include "zynqmp-clk-ccf.dtsi"
>>  #include <dt-bindings/input/input.h>
>>  #include <dt-bindings/gpio/gpio.h>
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>> index 8bb0001..e27cd60 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>> @@ -2,7 +2,7 @@
>>  /*
>>   * dts file for Xilinx ZynqMP ZCU111
>>   *
>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>   *
>>   * Michal Simek <michal.simek@xilinx.com>
>>   */
>> @@ -10,7 +10,7 @@
>>  /dts-v1/;
>>
>>  #include "zynqmp.dtsi"
>> -#include "zynqmp-clk.dtsi"
>> +#include "zynqmp-clk-ccf.dtsi"
>>  #include <dt-bindings/input/input.h>
>>  #include <dt-bindings/gpio/gpio.h>
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index 9aa6734..59a547b 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@ -2,7 +2,7 @@
>>  /*
>>   * dts file for Xilinx ZynqMP
>>   *
>> - * (C) Copyright 2014 - 2015, Xilinx, Inc.
>> + * (C) Copyright 2014 - 2019, Xilinx, Inc.
>>   *
>>   * Michal Simek <michal.simek@xilinx.com>
>>   *
>> @@ -124,6 +124,28 @@
>>  			     <1 10 0xf08>;
>>  	};
>>
>> +	firmware {
>> +		zynqmp_firmware: zynqmp-firmware {
>> +			compatible = "xlnx,zynqmp-firmware";
>> +			method = "smc";
>> +			zynqmp_clk: clock-controller {
>> +				u-boot,dm-pre-reloc;
>> +				#clock-cells = <1>;
>> +				compatible = "xlnx,zynqmp-clk";
>> +				clocks = <&pss_ref_clk>,
>> +					 <&video_clk>,
>> +					 <&pss_alt_ref_clk>,
>> +					 <&aux_ref_clk>,
>> +					 <&gt_crx_ref_clk>;
>> +				clock-names = "pss_ref_clk",
>> +					      "video_clk",
>> +					      "pss_alt_ref_clk",
>> +					      "aux_ref_clk",
>> +					      "gt_crx_ref_clk";
>> +			};
>> +		};
>> +	};
>> +
>>  	amba_apu: amba-apu@0 {
>>  		compatible = "simple-bus";
>>  		#address-cells = <2>;
>>
> 
> Updating my Ultra96 setups from 5.4 to 5.10, I ran into a blocker:
> Starting from this commit on, I'm no longer getting the kernel to boot
> on both revision 1 and 2 (arm64 defconfig as reference). If I switch the
> DTBs back before this commit, even a kernel from today's head is fine.
> 
> Further versions of potential relevance:
>  - PMUFW 2019.1 and 2020.2
>  - TF-A 2.3
>  - U-Boot 2020.10
> 
> What's missing? I suspect someone forgot to document a subtle dependency
> of this change.

Does this fix your issue?
https://lore.kernel.org/linux-arm-kernel/20210316090540.973014-1-punit1.agrawal@toshiba.co.jp/

Thanks,
Michal

