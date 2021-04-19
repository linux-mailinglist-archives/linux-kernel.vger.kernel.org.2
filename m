Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC96363FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 12:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhDSKxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 06:53:11 -0400
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com ([40.107.93.43]:9184
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232344AbhDSKxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hU6ArnItTghDsjLSk4saa8CFMIu28DPKZaurz7RoK0+hPKXuIWHnOgy8/YRYemx7grcPEuGzsVJS1rfSzDnNU2U/tdYagwrhrApINYq6A1F9/l6ejglra01YVZVRpHaB7kCpS1Jwigr4yW2C5wNuccBaZ4EKnSHX7x3EOpNWWvSZ/U6IbXhtQx35xky1A+2iXOYKVvPfaWo+tASTPupzMJD2HecPwoKHxGO5Uc4uAwfcwo+b7CT7pdqdj2SEnbRm0viNyvOpr3fpkfuDZOF0j2gYjDg4sBYmpTaYn2scRQErPagns4wrOmhSBgrMbptsWM/NW44KkCngJ+0ZJ3xuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Db7w4SZB3j9Ue+M0cxPeUb40aUL88wSqGtZM/xLqbLI=;
 b=ifYNBtnQPGojV9DOOuhNKZLR7byrtMZDstsk8NZ+9ZCfwWW+oeAVxxzcl3w8yHODfqqIeyhp88OBAM6HJMn2JbqMnf5N78n+yEMHavm9hiwqm2zccuHZCdQJtqiaQFkmlI2ZfLnB2Ko2+z4wZB5g3uQYH93hg2sht2kparx6YwfKTHvVwcdxinWWRqendEAOKl5pKz2TZSuitbUMH/680SpppJpgz4CuOUjZsu73pTuD9MMlnj7x0H3bXuGh1U5VAp5KcN2sQpU4RI0ExnyS7bkw3OqRKin3Lr2LqXzaSeqfThAc4/oxDScSVyLZwjJA8RK7SgIosMVes4t+LpqrAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Db7w4SZB3j9Ue+M0cxPeUb40aUL88wSqGtZM/xLqbLI=;
 b=khvODR3B9JhXxwZBN8bI2BcYIGD1vB2rATrQ2PRU5OuP+GFj4g+BShhs66zea7v35sEa00X3B+gx1PMHJkvg88PFkvvGyFMUB+Lmfyf+wN+Bl5hUjWXUoFzBtivpzXvSeFHNrHaF+m/EQ3EnSbbQ/60ctEmZgD7+BlDOnTqyaeA=
Received: from DM5PR11CA0014.namprd11.prod.outlook.com (2603:10b6:3:115::24)
 by CH2PR02MB6088.namprd02.prod.outlook.com (2603:10b6:610:5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Mon, 19 Apr
 2021 10:52:35 +0000
Received: from DM3NAM02FT048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::28) by DM5PR11CA0014.outlook.office365.com
 (2603:10b6:3:115::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Mon, 19 Apr 2021 10:52:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT048.mail.protection.outlook.com (10.13.4.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.19 via Frontend Transport; Mon, 19 Apr 2021 10:52:35 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Apr 2021 03:52:35 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Mon, 19 Apr 2021 03:52:35 -0700
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
Received: from [172.30.17.109] (port=49608)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lYRW6-0001SU-Fd; Mon, 19 Apr 2021 03:52:35 -0700
To:     Jan Kiszka <jan.kiszka@web.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <harini.katakam@xilinx.com>,
        <ulf.hansson@linaro.org>, <xuwei5@hisilicon.com>,
        <mripard@kernel.org>, <heiko@sntech.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1573119856-13548-1-git-send-email-rajan.vaja@xilinx.com>
 <1573119856-13548-2-git-send-email-rajan.vaja@xilinx.com>
 <8b039dac-06c4-6b33-f53b-44b8fa144495@web.de>
 <580bccb2-2e41-aec7-2612-99a2b231f2fc@xilinx.com>
 <09343e7d-fcd8-1a54-470f-c0d8741921b1@web.de>
 <7e8ee1fe-a02d-f6ac-337f-88b35736e1eb@web.de>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/3] arm64: dts: xilinx: Add the clock nodes for zynqmp
Message-ID: <2f2e3019-afdd-103f-b984-06e65b10fc50@xilinx.com>
Date:   Mon, 19 Apr 2021 12:52:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <7e8ee1fe-a02d-f6ac-337f-88b35736e1eb@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b48100f-acce-403b-1ec1-08d903213df2
X-MS-TrafficTypeDiagnostic: CH2PR02MB6088:
X-Microsoft-Antispam-PRVS: <CH2PR02MB60881460BAF998E16E44DBACC6499@CH2PR02MB6088.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjL4QBzh77p2Mmgs/Y/1+zfte3nS6txs/JdIQ50JJ3M0rCgdZavbriu9wyFeFfILkiGs5U14gvRmXySS03kHaYy7U6sKdJSSh15c0Z0C1GJ+450nbYuXsXLntqFt/VQScPlwN7VGW/rtQ53a5Y5leaM8LVBgxCpbprh2m7HVYj4lGHUe1l5bODFjkRi86iJFLzNfvKzLvy1GAdgYuv2Y6lXAPXUMcTL6pWRj4Qkgl50ZbeDT92+HMaCrZzxXti+nXoo06CpUHWktGKZgsWRCAPnzp+CJVo18bvMRjvyGDkfh35UGOuCcU5+4QK/LkkboR6Va+b0vOXZfEJovUx9p3gUBnRlKs1oF5O5s1U6YrgOWleU1WYxJ/hFWZwzZ5tZ+oyuIceAX2JunPnL/njI8t6nxD3dz4wfIJHraH4zTYPhYWqG/hcR9VK+LLinC6xBTpm+InBVfQK0rKZKHgPA5vb9aEp5lGZrXrPTYO9f2PYOj7DmGlaIgCU9rykZVy9HmwX+CvKOUliD2anZkh9xggdd5MxO4BxDzF4eEMPrMyNfzwrAWBvuLnKuG15ChQBKJ+6GqxM5VWaBIW54YC0TB3iJa1HKcb/111KW+/i5xUDq21rwWT986zSHVvcYIS8AbZjgVpdJbgMC3qUVHwzVhPG9hInWdVCAYPzH8CSKrTIqUM1ixLk5CxNnPk1GCr5o8Eg1ay7oanAigPxuat9oEIWdyG3EhVsx6YcFEM0VIymJI1eo9b7I5Z5/Q0w2JHQ6v8XpQOckLCkh4HzsVHR66SJlb21pMzvYCiYZ86NE3ALls/Vqcbka7S0C4eIcLQKb/dmKFJCRsy6Wp7lX+v07g6y3aJkR9NmMiuiNytRdcjfI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(36840700001)(46966006)(70206006)(70586007)(82310400003)(356005)(7636003)(47076005)(26005)(31686004)(7416002)(186003)(36860700001)(82740400003)(36906005)(336012)(83380400001)(36756003)(426003)(53546011)(2906002)(316002)(54906003)(110136005)(5660300002)(4326008)(44832011)(8676002)(8936002)(31696002)(9786002)(921005)(2616005)(478600001)(30864003)(6666004)(966005)(50156003)(2101003)(43740500002)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 10:52:35.6828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b48100f-acce-403b-1ec1-08d903213df2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 4/18/21 2:12 PM, Jan Kiszka wrote:
> On 01.04.21 16:52, Jan Kiszka wrote:
>> On 01.04.21 13:42, Michal Simek wrote:
>>> Hi Jan,
>>>
>>> On 3/27/21 8:55 PM, Jan Kiszka wrote:
>>>> On 07.11.19 10:44, Rajan Vaja wrote:
>>>>> Add clock nodes for zynqmp based on CCF.
>>>>>
>>>>> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
>>>>> ---
>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi     | 222 +++++++++++++++++++++
>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts  |   4 +-
>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts  |   4 +-
>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts  |   2 +-
>>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |   4 +-
>>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |   4 +-
>>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |   4 +-
>>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |   4 +-
>>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    |   4 +-
>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts  |   4 +-
>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  |   4 +-
>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts  |   4 +-
>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts  |   4 +-
>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts  |   4 +-
>>>>>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |  24 ++-
>>>>>  15 files changed, 270 insertions(+), 26 deletions(-)
>>>>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>>>>> new file mode 100644
>>>>> index 0000000..9868ca1
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>>>>> @@ -0,0 +1,222 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>>> +/*
>>>>> + * Clock specification for Xilinx ZynqMP
>>>>> + *
>>>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>>> + *
>>>>> + * Michal Simek <michal.simek@xilinx.com>
>>>>> + */
>>>>> +
>>>>> +#include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>>>>> +/ {
>>>>> +	pss_ref_clk: pss_ref_clk {
>>>>> +		u-boot,dm-pre-reloc;
>>>>> +		compatible = "fixed-clock";
>>>>> +		#clock-cells = <0>;
>>>>> +		clock-frequency = <33333333>;
>>>>> +	};
>>>>> +
>>>>> +	video_clk: video_clk {
>>>>> +		u-boot,dm-pre-reloc;
>>>>> +		compatible = "fixed-clock";
>>>>> +		#clock-cells = <0>;
>>>>> +		clock-frequency = <27000000>;
>>>>> +	};
>>>>> +
>>>>> +	pss_alt_ref_clk: pss_alt_ref_clk {
>>>>> +		u-boot,dm-pre-reloc;
>>>>> +		compatible = "fixed-clock";
>>>>> +		#clock-cells = <0>;
>>>>> +		clock-frequency = <0>;
>>>>> +	};
>>>>> +
>>>>> +	gt_crx_ref_clk: gt_crx_ref_clk {
>>>>> +		u-boot,dm-pre-reloc;
>>>>> +		compatible = "fixed-clock";
>>>>> +		#clock-cells = <0>;
>>>>> +		clock-frequency = <108000000>;
>>>>> +	};
>>>>> +
>>>>> +	aux_ref_clk: aux_ref_clk {
>>>>> +		u-boot,dm-pre-reloc;
>>>>> +		compatible = "fixed-clock";
>>>>> +		#clock-cells = <0>;
>>>>> +		clock-frequency = <27000000>;
>>>>> +	};
>>>>> +};
>>>>> +
>>>>> +&can0 {
>>>>> +	clocks = <&zynqmp_clk CAN0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&can1 {
>>>>> +	clocks = <&zynqmp_clk CAN1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&cpu0 {
>>>>> +	clocks = <&zynqmp_clk ACPU>;
>>>>> +};
>>>>> +
>>>>> +&fpd_dma_chan1 {
>>>>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&fpd_dma_chan2 {
>>>>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&fpd_dma_chan3 {
>>>>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&fpd_dma_chan4 {
>>>>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&fpd_dma_chan5 {
>>>>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&fpd_dma_chan6 {
>>>>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&fpd_dma_chan7 {
>>>>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&fpd_dma_chan8 {
>>>>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&lpd_dma_chan1 {
>>>>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&lpd_dma_chan2 {
>>>>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&lpd_dma_chan3 {
>>>>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&lpd_dma_chan4 {
>>>>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&lpd_dma_chan5 {
>>>>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&lpd_dma_chan6 {
>>>>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&lpd_dma_chan7 {
>>>>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&lpd_dma_chan8 {
>>>>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&gem0 {
>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM0_REF>,
>>>>> +		 <&zynqmp_clk GEM0_TX>, <&zynqmp_clk GEM0_RX>,
>>>>> +		 <&zynqmp_clk GEM_TSU>;
>>>>> +	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>>>> +};
>>>>> +
>>>>> +&gem1 {
>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM1_REF>,
>>>>> +		 <&zynqmp_clk GEM1_TX>, <&zynqmp_clk GEM1_RX>,
>>>>> +		 <&zynqmp_clk GEM_TSU>;
>>>>> +	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>>>> +};
>>>>> +
>>>>> +&gem2 {
>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM2_REF>,
>>>>> +		 <&zynqmp_clk GEM2_TX>, <&zynqmp_clk GEM2_RX>,
>>>>> +		 <&zynqmp_clk GEM_TSU>;
>>>>> +	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>>>> +};
>>>>> +
>>>>> +&gem3 {
>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM3_REF>,
>>>>> +		 <&zynqmp_clk GEM3_TX>, <&zynqmp_clk GEM3_RX>,
>>>>> +		 <&zynqmp_clk GEM_TSU>;
>>>>> +	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>>>> +};
>>>>> +
>>>>> +&gpio {
>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&i2c0 {
>>>>> +	clocks = <&zynqmp_clk I2C0_REF>;
>>>>> +};
>>>>> +
>>>>> +&i2c1 {
>>>>> +	clocks = <&zynqmp_clk I2C1_REF>;
>>>>> +};
>>>>> +
>>>>> +&pcie {
>>>>> +	clocks = <&zynqmp_clk PCIE_REF>;
>>>>> +};
>>>>> +
>>>>> +&sata {
>>>>> +	clocks = <&zynqmp_clk SATA_REF>;
>>>>> +};
>>>>> +
>>>>> +&sdhci0 {
>>>>> +	clocks = <&zynqmp_clk SDIO0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&sdhci1 {
>>>>> +	clocks = <&zynqmp_clk SDIO1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&spi0 {
>>>>> +	clocks = <&zynqmp_clk SPI0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&spi1 {
>>>>> +	clocks = <&zynqmp_clk SPI1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&ttc0 {
>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&ttc1 {
>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&ttc2 {
>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&ttc3 {
>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&uart0 {
>>>>> +	clocks = <&zynqmp_clk UART0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&uart1 {
>>>>> +	clocks = <&zynqmp_clk UART1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>> +};
>>>>> +
>>>>> +&usb0 {
>>>>> +	clocks = <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
>>>>> +};
>>>>> +
>>>>> +&usb1 {
>>>>> +	clocks = <&zynqmp_clk USB1_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
>>>>> +};
>>>>> +
>>>>> +&watchdog0 {
>>>>> +	clocks = <&zynqmp_clk WDT>;
>>>>> +};
>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>>>> index 0f7b4cf..2e05fa4 100644
>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>>>> @@ -2,7 +2,7 @@
>>>>>  /*
>>>>>   * dts file for Xilinx ZynqMP ZC1232
>>>>>   *
>>>>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>>>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>>>   *
>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>   */
>>>>> @@ -10,7 +10,7 @@
>>>>>  /dts-v1/;
>>>>>
>>>>>  #include "zynqmp.dtsi"
>>>>> -#include "zynqmp-clk.dtsi"
>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>
>>>>>  / {
>>>>>  	model = "ZynqMP ZC1232 RevA";
>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>>>> index 9092828..3d0aaa0 100644
>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>>>> @@ -2,7 +2,7 @@
>>>>>  /*
>>>>>   * dts file for Xilinx ZynqMP ZC1254
>>>>>   *
>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>   *
>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>   * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
>>>>> @@ -11,7 +11,7 @@
>>>>>  /dts-v1/;
>>>>>
>>>>>  #include "zynqmp.dtsi"
>>>>> -#include "zynqmp-clk.dtsi"
>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>
>>>>>  / {
>>>>>  	model = "ZynqMP ZC1254 RevA";
>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>>>>> index 4f404c5..1a8127d4 100644
>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>>>>> @@ -11,7 +11,7 @@
>>>>>  /dts-v1/;
>>>>>
>>>>>  #include "zynqmp.dtsi"
>>>>> -#include "zynqmp-clk.dtsi"
>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>
>>>>>  / {
>>>>>  	model = "ZynqMP ZC1275 RevA";
>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>>>> index 9a3e39d..fa7eb1b 100644
>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>>>> @@ -2,7 +2,7 @@
>>>>>  /*
>>>>>   * dts file for Xilinx ZynqMP zc1751-xm015-dc1
>>>>>   *
>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>   *
>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>   */
>>>>> @@ -10,7 +10,7 @@
>>>>>  /dts-v1/;
>>>>>
>>>>>  #include "zynqmp.dtsi"
>>>>> -#include "zynqmp-clk.dtsi"
>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>
>>>>>  / {
>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>>>>> index 2421ec7..4191dfa 100644
>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>>>>> @@ -2,7 +2,7 @@
>>>>>  /*
>>>>>   * dts file for Xilinx ZynqMP zc1751-xm016-dc2
>>>>>   *
>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>   *
>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>   */
>>>>> @@ -10,7 +10,7 @@
>>>>>  /dts-v1/;
>>>>>
>>>>>  #include "zynqmp.dtsi"
>>>>> -#include "zynqmp-clk.dtsi"
>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>
>>>>>  / {
>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>>>>> index 7a49dee..3750690 100644
>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>>>>> @@ -2,7 +2,7 @@
>>>>>  /*
>>>>>   * dts file for Xilinx ZynqMP zc1751-xm017-dc3
>>>>>   *
>>>>> - * (C) Copyright 2016 - 2018, Xilinx, Inc.
>>>>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>>>>   *
>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>   */
>>>>> @@ -10,7 +10,7 @@
>>>>>  /dts-v1/;
>>>>>
>>>>>  #include "zynqmp.dtsi"
>>>>> -#include "zynqmp-clk.dtsi"
>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>
>>>>>  / {
>>>>>  	model = "ZynqMP zc1751-xm017-dc3 RevA";
>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>>>> index 54c7b4f..2366cd9 100644
>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>>>> @@ -2,7 +2,7 @@
>>>>>  /*
>>>>>   * dts file for Xilinx ZynqMP zc1751-xm018-dc4
>>>>>   *
>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>   *
>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>   */
>>>>> @@ -10,7 +10,7 @@
>>>>>  /dts-v1/;
>>>>>
>>>>>  #include "zynqmp.dtsi"
>>>>> -#include "zynqmp-clk.dtsi"
>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>
>>>>>  / {
>>>>>  	model = "ZynqMP zc1751-xm018-dc4";
>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>>>>> index b8b5ff1..9a894e6 100644
>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>>>>> @@ -2,7 +2,7 @@
>>>>>  /*
>>>>>   * dts file for Xilinx ZynqMP zc1751-xm019-dc5
>>>>>   *
>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>   *
>>>>>   * Siva Durga Prasad <siva.durga.paladugu@xilinx.com>
>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>> @@ -11,7 +11,7 @@
>>>>>  /dts-v1/;
>>>>>
>>>>>  #include "zynqmp.dtsi"
>>>>> -#include "zynqmp-clk.dtsi"
>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>
>>>>>  / {
>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>>>> index e5699d0..3e39454 100644
>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>>>> @@ -2,7 +2,7 @@
>>>>>  /*
>>>>>   * dts file for Xilinx ZynqMP ZCU100 revC
>>>>>   *
>>>>> - * (C) Copyright 2016 - 2018, Xilinx, Inc.
>>>>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>>>>   *
>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>   * Nathalie Chan King Choy
>>>>> @@ -11,7 +11,7 @@
>>>>>  /dts-v1/;
>>>>>
>>>>>  #include "zynqmp.dtsi"
>>>>> -#include "zynqmp-clk.dtsi"
>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>  #include <dt-bindings/input/input.h>
>>>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>>>> index 2a3b665..f6e9558 100644
>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>>>> @@ -2,7 +2,7 @@
>>>>>  /*
>>>>>   * dts file for Xilinx ZynqMP ZCU102 RevA
>>>>>   *
>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>   *
>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>   */
>>>>> @@ -10,7 +10,7 @@
>>>>>  /dts-v1/;
>>>>>
>>>>>  #include "zynqmp.dtsi"
>>>>> -#include "zynqmp-clk.dtsi"
>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>  #include <dt-bindings/input/input.h>
>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>>>>> index 8f45614..f457f8a 100644
>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>>>>> @@ -2,7 +2,7 @@
>>>>>  /*
>>>>>   * dts file for Xilinx ZynqMP ZCU104
>>>>>   *
>>>>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>>>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>>>   *
>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>   */
>>>>> @@ -10,7 +10,7 @@
>>>>>  /dts-v1/;
>>>>>
>>>>>  #include "zynqmp.dtsi"
>>>>> -#include "zynqmp-clk.dtsi"
>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>
>>>>>  / {
>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>>>>> index 93ce7eb..f15b99a 100644
>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>>>>> @@ -2,7 +2,7 @@
>>>>>  /*
>>>>>   * dts file for Xilinx ZynqMP ZCU106
>>>>>   *
>>>>> - * (C) Copyright 2016, Xilinx, Inc.
>>>>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>>>>   *
>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>   */
>>>>> @@ -10,7 +10,7 @@
>>>>>  /dts-v1/;
>>>>>
>>>>>  #include "zynqmp.dtsi"
>>>>> -#include "zynqmp-clk.dtsi"
>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>  #include <dt-bindings/input/input.h>
>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>>>>> index 8bb0001..e27cd60 100644
>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>>>>> @@ -2,7 +2,7 @@
>>>>>  /*
>>>>>   * dts file for Xilinx ZynqMP ZCU111
>>>>>   *
>>>>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>>>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>>>   *
>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>   */
>>>>> @@ -10,7 +10,7 @@
>>>>>  /dts-v1/;
>>>>>
>>>>>  #include "zynqmp.dtsi"
>>>>> -#include "zynqmp-clk.dtsi"
>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>  #include <dt-bindings/input/input.h>
>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>>> index 9aa6734..59a547b 100644
>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>>> @@ -2,7 +2,7 @@
>>>>>  /*
>>>>>   * dts file for Xilinx ZynqMP
>>>>>   *
>>>>> - * (C) Copyright 2014 - 2015, Xilinx, Inc.
>>>>> + * (C) Copyright 2014 - 2019, Xilinx, Inc.
>>>>>   *
>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>   *
>>>>> @@ -124,6 +124,28 @@
>>>>>  			     <1 10 0xf08>;
>>>>>  	};
>>>>>
>>>>> +	firmware {
>>>>> +		zynqmp_firmware: zynqmp-firmware {
>>>>> +			compatible = "xlnx,zynqmp-firmware";
>>>>> +			method = "smc";
>>>>> +			zynqmp_clk: clock-controller {
>>>>> +				u-boot,dm-pre-reloc;
>>>>> +				#clock-cells = <1>;
>>>>> +				compatible = "xlnx,zynqmp-clk";
>>>>> +				clocks = <&pss_ref_clk>,
>>>>> +					 <&video_clk>,
>>>>> +					 <&pss_alt_ref_clk>,
>>>>> +					 <&aux_ref_clk>,
>>>>> +					 <&gt_crx_ref_clk>;
>>>>> +				clock-names = "pss_ref_clk",
>>>>> +					      "video_clk",
>>>>> +					      "pss_alt_ref_clk",
>>>>> +					      "aux_ref_clk",
>>>>> +					      "gt_crx_ref_clk";
>>>>> +			};
>>>>> +		};
>>>>> +	};
>>>>> +
>>>>>  	amba_apu: amba-apu@0 {
>>>>>  		compatible = "simple-bus";
>>>>>  		#address-cells = <2>;
>>>>>
>>>>
>>>> Updating my Ultra96 setups from 5.4 to 5.10, I ran into a blocker:
>>>> Starting from this commit on, I'm no longer getting the kernel to boot
>>>> on both revision 1 and 2 (arm64 defconfig as reference). If I switch the
>>>> DTBs back before this commit, even a kernel from today's head is fine.
>>>>
>>>> Further versions of potential relevance:
>>>>  - PMUFW 2019.1 and 2020.2
>>>>  - TF-A 2.3
>>>>  - U-Boot 2020.10
>>>>
>>>> What's missing? I suspect someone forgot to document a subtle dependency
>>>> of this change.
>>>
>>> Does this fix your issue?
>>> https://lore.kernel.org/linux-arm-kernel/20210316090540.973014-1-punit1.agrawal@toshiba.co.jp/
>>>
>>
>> Nope, CONFIG_COMMON_CLK_ZYNQMP=y does not help. Maybe the defconfig is
>> missing even more. If you have some reference, I'm happy to try. I
>> suspect that earlyprintk will also not reveal more without clocks (but I
>> didn't play with that yet).
>>
>> Meanwhile, I'm carrying a revert of this commit and a related cleanup.
>> That helps for now.
>>
> 
> OK, dependencies resolved (unfortunately the hard way): It either
> requires TF-A master or latest release v2.4 + [1] and [2].
> 
> Those TF-A commits were upstream about a year after the firmware-based
> clock control hit the kernel. A note would have been nice - or better
> sychronization between both upstreaming efforts.

I wasn't responsible for TFA but I found this last year in Nov timeframe
that none really upstream this. Right now that development is working
like that. I am asking everybody to contribute upstream to have all the
time upstream heads to work together.
I haven't had a time to dig into this but unfortunatelly there is no
feature checking mechanism on zynqmp TFA side to check if this is there
or not but we are trying our best to check as much as possible but bugs
happen.
And we are lacking space in OCM to be able to add more features to TFA
anyway.

Thanks,
Michal



