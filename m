Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA2D3646DA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 17:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240859AbhDSPPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 11:15:17 -0400
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:5441
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229661AbhDSPPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 11:15:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/ox2sm6xuBRCC8RWBO+5vXwj93C0mUKqtcjRWufECA4aTfvmIWigkxwY7xdDPsX3sCzcPQ6pkULf4x/hOBjoEY8YK3Sh0Z8i2JvmMvZ41CGzXycyvOcnWFu6b0+YhUiUxl6DLQEhe1KBSD4/gMWPR0uBRRUSpLDP31WG6d3/eGEIZb0/1L7lNE2zskCkkkDl0HF3L6gbPvgT6doy02xgirJYDzRoFTOpkbN5RPyBujOpMN5VI2iJnEfXPZrKMmCyBs7sFYaEWIV7qzcb7SC94f9PAhRYt1jpsOvU7l+tjnyj8W75SoexuZksDRbzwmGScma5GkGlJnYdLeDDiJRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgTh4pGkzreFqAlaWzwtrsyEjCwwBVFmz2Wyea3u4Eo=;
 b=JvAXVxM8/njAa6im6YfjZJBctETYL0skNawnpQrLoh+bOwQ9RPXngYZOnmOQnDOkQERUGY7JsO63lljko17k7MD6AdL+6pTrRPZdohX54SyGTJ3AbOVbcfNgWl7CtpF9HA3x9RrSNQT6Ama7EElFddtPTy7GdH72pW56kpKofDHJhOrvCb22YaREO4e3lSJSmeM+hbJT/EAhoY6PdPdMAeFBm+V5alqY0VV8awtWXQoMZyZtx4+iM7ZUraovpHGvqq14LXdzmaIb/lEkZ7BiYCdnEfsCumZ17Iyy+oNV6qp7LBA/MQYZB9Hb46E5cBsX/DI28jBElb1mpI+dK5f+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgTh4pGkzreFqAlaWzwtrsyEjCwwBVFmz2Wyea3u4Eo=;
 b=S2fM1uUfkp1W3zcmrPrhSiiZtO5SVYfPVG6UVeFWfkrhzQFGqGlPqr6LLIHh4QPJFSM9W+4rZb2VDq0yj9Zu20IHzLYKZQ1jnAP8s/FCwfStclfc26fjNm8gS0DzlKDzIUBNOQArCCqsZ23RQb58JTGxH8Bwa4Ch8hk6diu3V14=
Received: from DM5PR18CA0074.namprd18.prod.outlook.com (2603:10b6:3:3::12) by
 SA2PR02MB7563.namprd02.prod.outlook.com (2603:10b6:806:14d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Mon, 19 Apr
 2021 15:14:42 +0000
Received: from DM3NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::ab) by DM5PR18CA0074.outlook.office365.com
 (2603:10b6:3:3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Mon, 19 Apr 2021 15:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT027.mail.protection.outlook.com (10.13.5.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.19 via Frontend Transport; Mon, 19 Apr 2021 15:14:42 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Apr 2021 08:14:40 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Mon, 19 Apr 2021 08:14:40 -0700
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
Received: from [172.30.17.109] (port=47428)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lYVbj-000631-Qf; Mon, 19 Apr 2021 08:14:40 -0700
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
 <2f2e3019-afdd-103f-b984-06e65b10fc50@xilinx.com>
 <5176e9bc-50a0-6952-0e5a-8e43095235eb@web.de>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 1/3] arm64: dts: xilinx: Add the clock nodes for zynqmp
Message-ID: <0c51ebbf-c17f-9418-f312-a6b0aaa5b8c1@xilinx.com>
Date:   Mon, 19 Apr 2021 17:14:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <5176e9bc-50a0-6952-0e5a-8e43095235eb@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15b5ad41-b598-4a6e-e363-08d90345db8f
X-MS-TrafficTypeDiagnostic: SA2PR02MB7563:
X-Microsoft-Antispam-PRVS: <SA2PR02MB756360ABA60E8B36D130F820C6499@SA2PR02MB7563.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ah4AhjJ1uY21OH+oPSynLfFO+rx/ZqNKYLHYUkGzYXm2b94VBD9MRvdt/pLHGev/Cv/y4aduyHIVn78WnmTlK4rLSDSHh0cQNvNtjFivpVz34wm8iJ9qRy9dMvTANeJ32zhm8BRQO7LGI9g87kEUXbowT7FPAVWQsnT5e11nHJvUkhT3xiPiF5a0gTiRyQHnhlcxditjiPVyL3371jcEZHU8EsgHIhFWRrPaqpWpRDk+9NASgdEsRRfGHLDVodS5Bnjm5tpyX3vViBU+KprZrMBIr+1pcD8ApNYXEPHEE8LQdHSJjAppogCWUYvq+uSzelSWYrK3vvTcJ9Lo4liVOIxIcYtwLShCoVtGL7fEFgUaJvJj6x3wgQGqkhaU+vwQSx2X+ybsS4yMW/n47kcRkNsl/jY6Q774K3pOyjgOBqmTYk5C5eWDhA31xhhlU7fipQ/7jYbyFKqmXW2FB00SyRk8ZYS6+HJJ/g7VK0mFL5sPwqJ4Zfq0IVjsI84lqB3pcNA+P03YhMrp4pQf4EPv1W0IQTTrmmzGp2IKpcxO3sR4k1T1eoK4MhxirIKN8yNfu6hn/gFDOGqYBuEq1ioq3GMaHaYWR+JlUBt293ubZPignRtCGruYELivaNXHLAYItprqjSS7KRdzkGsVVJsPDDFe+BNynr14WFQpJFEvR+zfODcBCMa1oAUZ30shJzlIpzlg0/htD8DXNTqQAUigSToAhMbNOhuDfmILXIUhV1aNOQ8EPIvWJb10AY1nFVI0kJUavUQ/nP1d4/oeuWaAbRKGkCBWpaMCyqFM54wsbhM3bZVNdppic/fANZCs2L4NF4S0om8Yaq9jh7JN7Uv9d2wtWeMaeQr08nlPiTTGNpM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(82310400003)(921005)(2906002)(966005)(82740400003)(6666004)(70586007)(70206006)(5660300002)(31696002)(36756003)(30864003)(31686004)(7636003)(2616005)(36860700001)(26005)(356005)(83380400001)(426003)(54906003)(8676002)(478600001)(8936002)(4326008)(7416002)(186003)(44832011)(9786002)(36906005)(316002)(53546011)(47076005)(336012)(110136005)(50156003)(43740500002)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 15:14:42.0003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b5ad41-b598-4a6e-e363-08d90345db8f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR02MB7563
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/21 1:48 PM, Jan Kiszka wrote:
> On 19.04.21 12:52, Michal Simek wrote:
>> Hi Jan,
>>
>> On 4/18/21 2:12 PM, Jan Kiszka wrote:
>>> On 01.04.21 16:52, Jan Kiszka wrote:
>>>> On 01.04.21 13:42, Michal Simek wrote:
>>>>> Hi Jan,
>>>>>
>>>>> On 3/27/21 8:55 PM, Jan Kiszka wrote:
>>>>>> On 07.11.19 10:44, Rajan Vaja wrote:
>>>>>>> Add clock nodes for zynqmp based on CCF.
>>>>>>>
>>>>>>> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
>>>>>>> ---
>>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi     | 222 +++++++++++++++++++++
>>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts  |   4 +-
>>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts  |   4 +-
>>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts  |   2 +-
>>>>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |   4 +-
>>>>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |   4 +-
>>>>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    |   4 +-
>>>>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts    |   4 +-
>>>>>>>  .../boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts    |   4 +-
>>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts  |   4 +-
>>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts  |   4 +-
>>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts  |   4 +-
>>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts  |   4 +-
>>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts  |   4 +-
>>>>>>>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |  24 ++-
>>>>>>>  15 files changed, 270 insertions(+), 26 deletions(-)
>>>>>>>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>>>>>>> new file mode 100644
>>>>>>> index 0000000..9868ca1
>>>>>>> --- /dev/null
>>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
>>>>>>> @@ -0,0 +1,222 @@
>>>>>>> +// SPDX-License-Identifier: GPL-2.0+
>>>>>>> +/*
>>>>>>> + * Clock specification for Xilinx ZynqMP
>>>>>>> + *
>>>>>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>>>>> + *
>>>>>>> + * Michal Simek <michal.simek@xilinx.com>
>>>>>>> + */
>>>>>>> +
>>>>>>> +#include <dt-bindings/clock/xlnx-zynqmp-clk.h>
>>>>>>> +/ {
>>>>>>> +	pss_ref_clk: pss_ref_clk {
>>>>>>> +		u-boot,dm-pre-reloc;
>>>>>>> +		compatible = "fixed-clock";
>>>>>>> +		#clock-cells = <0>;
>>>>>>> +		clock-frequency = <33333333>;
>>>>>>> +	};
>>>>>>> +
>>>>>>> +	video_clk: video_clk {
>>>>>>> +		u-boot,dm-pre-reloc;
>>>>>>> +		compatible = "fixed-clock";
>>>>>>> +		#clock-cells = <0>;
>>>>>>> +		clock-frequency = <27000000>;
>>>>>>> +	};
>>>>>>> +
>>>>>>> +	pss_alt_ref_clk: pss_alt_ref_clk {
>>>>>>> +		u-boot,dm-pre-reloc;
>>>>>>> +		compatible = "fixed-clock";
>>>>>>> +		#clock-cells = <0>;
>>>>>>> +		clock-frequency = <0>;
>>>>>>> +	};
>>>>>>> +
>>>>>>> +	gt_crx_ref_clk: gt_crx_ref_clk {
>>>>>>> +		u-boot,dm-pre-reloc;
>>>>>>> +		compatible = "fixed-clock";
>>>>>>> +		#clock-cells = <0>;
>>>>>>> +		clock-frequency = <108000000>;
>>>>>>> +	};
>>>>>>> +
>>>>>>> +	aux_ref_clk: aux_ref_clk {
>>>>>>> +		u-boot,dm-pre-reloc;
>>>>>>> +		compatible = "fixed-clock";
>>>>>>> +		#clock-cells = <0>;
>>>>>>> +		clock-frequency = <27000000>;
>>>>>>> +	};
>>>>>>> +};
>>>>>>> +
>>>>>>> +&can0 {
>>>>>>> +	clocks = <&zynqmp_clk CAN0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&can1 {
>>>>>>> +	clocks = <&zynqmp_clk CAN1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&cpu0 {
>>>>>>> +	clocks = <&zynqmp_clk ACPU>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&fpd_dma_chan1 {
>>>>>>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&fpd_dma_chan2 {
>>>>>>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&fpd_dma_chan3 {
>>>>>>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&fpd_dma_chan4 {
>>>>>>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&fpd_dma_chan5 {
>>>>>>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&fpd_dma_chan6 {
>>>>>>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&fpd_dma_chan7 {
>>>>>>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&fpd_dma_chan8 {
>>>>>>> +	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&lpd_dma_chan1 {
>>>>>>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&lpd_dma_chan2 {
>>>>>>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&lpd_dma_chan3 {
>>>>>>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&lpd_dma_chan4 {
>>>>>>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&lpd_dma_chan5 {
>>>>>>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&lpd_dma_chan6 {
>>>>>>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&lpd_dma_chan7 {
>>>>>>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&lpd_dma_chan8 {
>>>>>>> +	clocks = <&zynqmp_clk ADMA_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&gem0 {
>>>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM0_REF>,
>>>>>>> +		 <&zynqmp_clk GEM0_TX>, <&zynqmp_clk GEM0_RX>,
>>>>>>> +		 <&zynqmp_clk GEM_TSU>;
>>>>>>> +	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>>>>>> +};
>>>>>>> +
>>>>>>> +&gem1 {
>>>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM1_REF>,
>>>>>>> +		 <&zynqmp_clk GEM1_TX>, <&zynqmp_clk GEM1_RX>,
>>>>>>> +		 <&zynqmp_clk GEM_TSU>;
>>>>>>> +	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>>>>>> +};
>>>>>>> +
>>>>>>> +&gem2 {
>>>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM2_REF>,
>>>>>>> +		 <&zynqmp_clk GEM2_TX>, <&zynqmp_clk GEM2_RX>,
>>>>>>> +		 <&zynqmp_clk GEM_TSU>;
>>>>>>> +	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>>>>>> +};
>>>>>>> +
>>>>>>> +&gem3 {
>>>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM3_REF>,
>>>>>>> +		 <&zynqmp_clk GEM3_TX>, <&zynqmp_clk GEM3_RX>,
>>>>>>> +		 <&zynqmp_clk GEM_TSU>;
>>>>>>> +	clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
>>>>>>> +};
>>>>>>> +
>>>>>>> +&gpio {
>>>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&i2c0 {
>>>>>>> +	clocks = <&zynqmp_clk I2C0_REF>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&i2c1 {
>>>>>>> +	clocks = <&zynqmp_clk I2C1_REF>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&pcie {
>>>>>>> +	clocks = <&zynqmp_clk PCIE_REF>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&sata {
>>>>>>> +	clocks = <&zynqmp_clk SATA_REF>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&sdhci0 {
>>>>>>> +	clocks = <&zynqmp_clk SDIO0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&sdhci1 {
>>>>>>> +	clocks = <&zynqmp_clk SDIO1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&spi0 {
>>>>>>> +	clocks = <&zynqmp_clk SPI0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&spi1 {
>>>>>>> +	clocks = <&zynqmp_clk SPI1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&ttc0 {
>>>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&ttc1 {
>>>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&ttc2 {
>>>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&ttc3 {
>>>>>>> +	clocks = <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&uart0 {
>>>>>>> +	clocks = <&zynqmp_clk UART0_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&uart1 {
>>>>>>> +	clocks = <&zynqmp_clk UART1_REF>, <&zynqmp_clk LPD_LSBUS>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&usb0 {
>>>>>>> +	clocks = <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&usb1 {
>>>>>>> +	clocks = <&zynqmp_clk USB1_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
>>>>>>> +};
>>>>>>> +
>>>>>>> +&watchdog0 {
>>>>>>> +	clocks = <&zynqmp_clk WDT>;
>>>>>>> +};
>>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>>>>>> index 0f7b4cf..2e05fa4 100644
>>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts
>>>>>>> @@ -2,7 +2,7 @@
>>>>>>>  /*
>>>>>>>   * dts file for Xilinx ZynqMP ZC1232
>>>>>>>   *
>>>>>>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>>>>>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>>>>>   *
>>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>>   */
>>>>>>> @@ -10,7 +10,7 @@
>>>>>>>  /dts-v1/;
>>>>>>>
>>>>>>>  #include "zynqmp.dtsi"
>>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>>
>>>>>>>  / {
>>>>>>>  	model = "ZynqMP ZC1232 RevA";
>>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>>>>>> index 9092828..3d0aaa0 100644
>>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts
>>>>>>> @@ -2,7 +2,7 @@
>>>>>>>  /*
>>>>>>>   * dts file for Xilinx ZynqMP ZC1254
>>>>>>>   *
>>>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>>>   *
>>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>>   * Siva Durga Prasad Paladugu <sivadur@xilinx.com>
>>>>>>> @@ -11,7 +11,7 @@
>>>>>>>  /dts-v1/;
>>>>>>>
>>>>>>>  #include "zynqmp.dtsi"
>>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>>
>>>>>>>  / {
>>>>>>>  	model = "ZynqMP ZC1254 RevA";
>>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>>>>>>> index 4f404c5..1a8127d4 100644
>>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dts
>>>>>>> @@ -11,7 +11,7 @@
>>>>>>>  /dts-v1/;
>>>>>>>
>>>>>>>  #include "zynqmp.dtsi"
>>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>>
>>>>>>>  / {
>>>>>>>  	model = "ZynqMP ZC1275 RevA";
>>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>>>>>> index 9a3e39d..fa7eb1b 100644
>>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>>>>>>> @@ -2,7 +2,7 @@
>>>>>>>  /*
>>>>>>>   * dts file for Xilinx ZynqMP zc1751-xm015-dc1
>>>>>>>   *
>>>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>>>   *
>>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>>   */
>>>>>>> @@ -10,7 +10,7 @@
>>>>>>>  /dts-v1/;
>>>>>>>
>>>>>>>  #include "zynqmp.dtsi"
>>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>>>
>>>>>>>  / {
>>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>>>>>>> index 2421ec7..4191dfa 100644
>>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>>>>>>> @@ -2,7 +2,7 @@
>>>>>>>  /*
>>>>>>>   * dts file for Xilinx ZynqMP zc1751-xm016-dc2
>>>>>>>   *
>>>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>>>   *
>>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>>   */
>>>>>>> @@ -10,7 +10,7 @@
>>>>>>>  /dts-v1/;
>>>>>>>
>>>>>>>  #include "zynqmp.dtsi"
>>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>>>
>>>>>>>  / {
>>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>>>>>>> index 7a49dee..3750690 100644
>>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>>>>>>> @@ -2,7 +2,7 @@
>>>>>>>  /*
>>>>>>>   * dts file for Xilinx ZynqMP zc1751-xm017-dc3
>>>>>>>   *
>>>>>>> - * (C) Copyright 2016 - 2018, Xilinx, Inc.
>>>>>>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>>>>>>   *
>>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>>   */
>>>>>>> @@ -10,7 +10,7 @@
>>>>>>>  /dts-v1/;
>>>>>>>
>>>>>>>  #include "zynqmp.dtsi"
>>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>>
>>>>>>>  / {
>>>>>>>  	model = "ZynqMP zc1751-xm017-dc3 RevA";
>>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>>>>>> index 54c7b4f..2366cd9 100644
>>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts
>>>>>>> @@ -2,7 +2,7 @@
>>>>>>>  /*
>>>>>>>   * dts file for Xilinx ZynqMP zc1751-xm018-dc4
>>>>>>>   *
>>>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>>>   *
>>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>>   */
>>>>>>> @@ -10,7 +10,7 @@
>>>>>>>  /dts-v1/;
>>>>>>>
>>>>>>>  #include "zynqmp.dtsi"
>>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>>
>>>>>>>  / {
>>>>>>>  	model = "ZynqMP zc1751-xm018-dc4";
>>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>>>>>>> index b8b5ff1..9a894e6 100644
>>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
>>>>>>> @@ -2,7 +2,7 @@
>>>>>>>  /*
>>>>>>>   * dts file for Xilinx ZynqMP zc1751-xm019-dc5
>>>>>>>   *
>>>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>>>   *
>>>>>>>   * Siva Durga Prasad <siva.durga.paladugu@xilinx.com>
>>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>> @@ -11,7 +11,7 @@
>>>>>>>  /dts-v1/;
>>>>>>>
>>>>>>>  #include "zynqmp.dtsi"
>>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>>>
>>>>>>>  / {
>>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>>>>>> index e5699d0..3e39454 100644
>>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>>>>>>> @@ -2,7 +2,7 @@
>>>>>>>  /*
>>>>>>>   * dts file for Xilinx ZynqMP ZCU100 revC
>>>>>>>   *
>>>>>>> - * (C) Copyright 2016 - 2018, Xilinx, Inc.
>>>>>>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>>>>>>   *
>>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>>   * Nathalie Chan King Choy
>>>>>>> @@ -11,7 +11,7 @@
>>>>>>>  /dts-v1/;
>>>>>>>
>>>>>>>  #include "zynqmp.dtsi"
>>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>>  #include <dt-bindings/input/input.h>
>>>>>>>  #include <dt-bindings/interrupt-controller/irq.h>
>>>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>>>>>> index 2a3b665..f6e9558 100644
>>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>>>>>>> @@ -2,7 +2,7 @@
>>>>>>>  /*
>>>>>>>   * dts file for Xilinx ZynqMP ZCU102 RevA
>>>>>>>   *
>>>>>>> - * (C) Copyright 2015 - 2018, Xilinx, Inc.
>>>>>>> + * (C) Copyright 2015 - 2019, Xilinx, Inc.
>>>>>>>   *
>>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>>   */
>>>>>>> @@ -10,7 +10,7 @@
>>>>>>>  /dts-v1/;
>>>>>>>
>>>>>>>  #include "zynqmp.dtsi"
>>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>>  #include <dt-bindings/input/input.h>
>>>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>>>>>>> index 8f45614..f457f8a 100644
>>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>>>>>>> @@ -2,7 +2,7 @@
>>>>>>>  /*
>>>>>>>   * dts file for Xilinx ZynqMP ZCU104
>>>>>>>   *
>>>>>>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>>>>>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>>>>>   *
>>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>>   */
>>>>>>> @@ -10,7 +10,7 @@
>>>>>>>  /dts-v1/;
>>>>>>>
>>>>>>>  #include "zynqmp.dtsi"
>>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>>>
>>>>>>>  / {
>>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>>>>>>> index 93ce7eb..f15b99a 100644
>>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>>>>>>> @@ -2,7 +2,7 @@
>>>>>>>  /*
>>>>>>>   * dts file for Xilinx ZynqMP ZCU106
>>>>>>>   *
>>>>>>> - * (C) Copyright 2016, Xilinx, Inc.
>>>>>>> + * (C) Copyright 2016 - 2019, Xilinx, Inc.
>>>>>>>   *
>>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>>   */
>>>>>>> @@ -10,7 +10,7 @@
>>>>>>>  /dts-v1/;
>>>>>>>
>>>>>>>  #include "zynqmp.dtsi"
>>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>>  #include <dt-bindings/input/input.h>
>>>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>>>>>>> index 8bb0001..e27cd60 100644
>>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>>>>>>> @@ -2,7 +2,7 @@
>>>>>>>  /*
>>>>>>>   * dts file for Xilinx ZynqMP ZCU111
>>>>>>>   *
>>>>>>> - * (C) Copyright 2017 - 2018, Xilinx, Inc.
>>>>>>> + * (C) Copyright 2017 - 2019, Xilinx, Inc.
>>>>>>>   *
>>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>>   */
>>>>>>> @@ -10,7 +10,7 @@
>>>>>>>  /dts-v1/;
>>>>>>>
>>>>>>>  #include "zynqmp.dtsi"
>>>>>>> -#include "zynqmp-clk.dtsi"
>>>>>>> +#include "zynqmp-clk-ccf.dtsi"
>>>>>>>  #include <dt-bindings/input/input.h>
>>>>>>>  #include <dt-bindings/gpio/gpio.h>
>>>>>>>
>>>>>>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>>>>> index 9aa6734..59a547b 100644
>>>>>>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>>>>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>>>>>>> @@ -2,7 +2,7 @@
>>>>>>>  /*
>>>>>>>   * dts file for Xilinx ZynqMP
>>>>>>>   *
>>>>>>> - * (C) Copyright 2014 - 2015, Xilinx, Inc.
>>>>>>> + * (C) Copyright 2014 - 2019, Xilinx, Inc.
>>>>>>>   *
>>>>>>>   * Michal Simek <michal.simek@xilinx.com>
>>>>>>>   *
>>>>>>> @@ -124,6 +124,28 @@
>>>>>>>  			     <1 10 0xf08>;
>>>>>>>  	};
>>>>>>>
>>>>>>> +	firmware {
>>>>>>> +		zynqmp_firmware: zynqmp-firmware {
>>>>>>> +			compatible = "xlnx,zynqmp-firmware";
>>>>>>> +			method = "smc";
>>>>>>> +			zynqmp_clk: clock-controller {
>>>>>>> +				u-boot,dm-pre-reloc;
>>>>>>> +				#clock-cells = <1>;
>>>>>>> +				compatible = "xlnx,zynqmp-clk";
>>>>>>> +				clocks = <&pss_ref_clk>,
>>>>>>> +					 <&video_clk>,
>>>>>>> +					 <&pss_alt_ref_clk>,
>>>>>>> +					 <&aux_ref_clk>,
>>>>>>> +					 <&gt_crx_ref_clk>;
>>>>>>> +				clock-names = "pss_ref_clk",
>>>>>>> +					      "video_clk",
>>>>>>> +					      "pss_alt_ref_clk",
>>>>>>> +					      "aux_ref_clk",
>>>>>>> +					      "gt_crx_ref_clk";
>>>>>>> +			};
>>>>>>> +		};
>>>>>>> +	};
>>>>>>> +
>>>>>>>  	amba_apu: amba-apu@0 {
>>>>>>>  		compatible = "simple-bus";
>>>>>>>  		#address-cells = <2>;
>>>>>>>
>>>>>>
>>>>>> Updating my Ultra96 setups from 5.4 to 5.10, I ran into a blocker:
>>>>>> Starting from this commit on, I'm no longer getting the kernel to boot
>>>>>> on both revision 1 and 2 (arm64 defconfig as reference). If I switch the
>>>>>> DTBs back before this commit, even a kernel from today's head is fine.
>>>>>>
>>>>>> Further versions of potential relevance:
>>>>>>  - PMUFW 2019.1 and 2020.2
>>>>>>  - TF-A 2.3
>>>>>>  - U-Boot 2020.10
>>>>>>
>>>>>> What's missing? I suspect someone forgot to document a subtle dependency
>>>>>> of this change.
>>>>>
>>>>> Does this fix your issue?
>>>>> https://lore.kernel.org/linux-arm-kernel/20210316090540.973014-1-punit1.agrawal@toshiba.co.jp/
>>>>>
>>>>
>>>> Nope, CONFIG_COMMON_CLK_ZYNQMP=y does not help. Maybe the defconfig is
>>>> missing even more. If you have some reference, I'm happy to try. I
>>>> suspect that earlyprintk will also not reveal more without clocks (but I
>>>> didn't play with that yet).
>>>>
>>>> Meanwhile, I'm carrying a revert of this commit and a related cleanup.
>>>> That helps for now.
>>>>
>>>
>>> OK, dependencies resolved (unfortunately the hard way): It either
>>> requires TF-A master or latest release v2.4 + [1] and [2].
>>>
>>> Those TF-A commits were upstream about a year after the firmware-based
>>> clock control hit the kernel. A note would have been nice - or better
>>> sychronization between both upstreaming efforts.
>>
>> I wasn't responsible for TFA but I found this last year in Nov timeframe
>> that none really upstream this. Right now that development is working
>> like that. I am asking everybody to contribute upstream to have all the
>> time upstream heads to work together.
>> I haven't had a time to dig into this but unfortunatelly there is no
>> feature checking mechanism on zynqmp TFA side to check if this is there
>> or not but we are trying our best to check as much as possible but bugs
>> happen.
> 
> OK, I understand. Reminding of "upstream first" is part of my daily
> business as well. :)
> 
> And integration is generally more and more complicated with the growing
> number of firmware services and interfaces, not only on this SOC...
> 
>> And we are lacking space in OCM to be able to add more features to TFA
>> anyway.
> 
> Yeah, I know - I'm also overflowing it via the SDEI patch [1].


I have looked at this. How are you using it now? I haven't had a chance
to take a look at it. How do you use it and test it?

We should try to minimalize amount of code and try to fit to OCM.

Thanks,
Michal

