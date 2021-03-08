Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C164331363
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhCHQ2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:28:31 -0500
Received: from mail-bn8nam12on2081.outbound.protection.outlook.com ([40.107.237.81]:48736
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230373AbhCHQ2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:28:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SuPfG89nEwN8JRoMeNI3xGrx1f5qhKwooSoFUKs7IvVMNWGjX/Naw/aj/W+NhFRUDhZOvFr/b3Kop0AXsTyOIzwN3OPcG4S09e+ZOUNIkwbn+l9AyT53ptqqU7StVF0nryzmuBhSBTpX9ZQPM/m8leNQhysnvweolcBpeEh7MzR2wV1KJlfJfDNlkuAH00pLeutRfO2DUUKSZSjFjvR2A+HZrLD0Na92adRkaeNRPIV3603NX652PV3wXWdkIHaUEagqWpYbhz6HSmCoUprUNImPBZUdTK6krdaGH8haqu66l9At66O6rnjc13lY2wdkuNmKzXq0ECESCdVUMu6ZUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqcvAPchPYsGPID8AAYJAxpKIKMhTPMzOKpej+SKHaM=;
 b=EWV25bQIyACrLPy2VF2ph4t/DJIzCZdiDVXy3VFvTc7Y8It2JiHdXllvIVtk3BaJg5Ghcj+reert7kMuwzGIrTuRZCNBDmkT3Z6nAQnJyQYIkPT6F5D+7Hp51WS2/klfKMF03RwHECw1nDGHgt4AiruDovz9EtAUXi+N01vex8+54AMuDVs1uMWKRGLtsA3w0TTsJHUqODPEFuzv0A/9vPKfPBN8eiBkkYp4cLck/WQCrDdTgZ5+nYeIIrxzpHU7GK8ntxRIMsSka7A0j2N9Efsam4uY7k+292pgm/BqMnJWfQYHCuPVqCEO46NOHnOFX8w3/oZzrcjy1hGRxG5u+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqcvAPchPYsGPID8AAYJAxpKIKMhTPMzOKpej+SKHaM=;
 b=aCPdsiLCq3mbeG6/UJLX5usNemaA3ahQfxykYbW3EbW5f9QxUnIFYZD9Tjfm9nKKQKDBjL4sBWfsZBaET8TAuP3vfHuwWC8qh+brIDDHWSqq7l6DukWfxPcJLBZyQuVOTcApc3BlAMNCyDJnrM4DTQu7lrOhZBeZZvsJZpt95ro=
Received: from SA0PR13CA0014.namprd13.prod.outlook.com (2603:10b6:806:130::19)
 by MWHPR02MB2895.namprd02.prod.outlook.com (2603:10b6:300:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Mon, 8 Mar
 2021 16:28:01 +0000
Received: from SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:130:cafe::8c) by SA0PR13CA0014.outlook.office365.com
 (2603:10b6:806:130::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.16 via Frontend
 Transport; Mon, 8 Mar 2021 16:28:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT032.mail.protection.outlook.com (10.152.72.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.25 via Frontend Transport; Mon, 8 Mar 2021 16:28:01 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 08:27:57 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Mon, 8 Mar 2021 08:27:57 -0800
Envelope-to: linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 krzk@kernel.org,
 laurent.pinchart@ideasonboard.com,
 robh+dt@kernel.org,
 quanyang.wang@windriver.com
Received: from [172.30.17.109] (port=38344)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lJIjd-0002mu-BE; Mon, 08 Mar 2021 08:27:57 -0800
Subject: Re: [PATCH] arm64: dts: zynqmp: Remove si5328 device nodes
To:     <quanyang.wang@windriver.com>, Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210308115437.2232847-1-quanyang.wang@windriver.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <66e639c2-a1da-8ca5-2031-fe37eb14d740@xilinx.com>
Date:   Mon, 8 Mar 2021 17:27:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210308115437.2232847-1-quanyang.wang@windriver.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b761914-eec4-4d02-2d9e-08d8e24f244a
X-MS-TrafficTypeDiagnostic: MWHPR02MB2895:
X-Microsoft-Antispam-PRVS: <MWHPR02MB289525E384C75F605060B685C6939@MWHPR02MB2895.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mKdrqRFhz6tz/n94AkCtYU69uzoOPJh4OWJJKW5UevcH5di0tqRPcX3I3Q17F/TDoN4KcGP6le/OM//igGdFlEDHbGGrBwqxNfX9WhIma9urcg0xmcULfPSVItIjPmqaXJT0QBXXB3MoOlTG/yZEHTzYnDO8Gm0c7Uu0W3Vr/zxSKhSViPMM9KY2PPhYOoFWoHcsi56y9k65kv/9Kg077+LJsymVEcC0xT3KSUxBBq1kDh/d8jHbrsC+h2At3rmbqLwlp16RoWonsjJ9VnL8V8WCQqei+2fFcKCdlgIILliTY2K/XrdqpECi3Q8ivd0yT+sfkb95H/Okm192QOC2sj5aPvJLzmX0ov1MOoqYHLFFCS2SKzLbYkFZWXm6WuZmbJkVPbPf9dIfJYPgg2HF2isaXXqmEiYO6uXV0X8k/YoKotk7TAwxbHMBOle+RUK363pGGUNsmgdZwwMI+2MyOP4rn/y3cUAnmh4ABJQ+zDT4vCtnipJXjdhPZAFf/V1fEkroQfEkifyeYVj+9tVPPbLUU3jFhEuydv2tZWMDCU4ylVHFiGUGpQduWiyCgHe2/UIi9u8uJLJLx61ScqozFHJa9oglTRmCwXR9AKeSnPG+o45+8uhYjvBUu4tVdHErc0g1hiN1TnTKv/r10nlFdp/qwWlYxBCImU2tEtLD8gJFfv98531tK5jWxZ8ptMjneAtSVGgvjkncrYeTIQ2wvQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(46966006)(2906002)(26005)(478600001)(186003)(31686004)(9786002)(426003)(70206006)(5660300002)(31696002)(36906005)(8936002)(44832011)(316002)(36756003)(53546011)(82740400003)(356005)(70586007)(7636003)(6666004)(83380400001)(336012)(4326008)(47076005)(8676002)(54906003)(110136005)(82310400003)(36860700001)(2616005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 16:28:01.1250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b761914-eec4-4d02-2d9e-08d8e24f244a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2895
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/8/21 12:54 PM, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> The function of_i2c_get_board_info will call of_modalias_node to check
> if a device_node contains "compatible" string. But for the device si5328
> at zcu102/zcu106 boards, there is no proper DT bindings for them. So remove
> si5328 device nodes from dts files to eliminate the error info in the boot
> message:
> 
> i2c i2c-10: of_i2c: modalias failure on /axi/i2c@ff030000/i2c-mux@74/i2c@4/clock-generator@69
> i2c i2c-10: Failed to create I2C device for /axi/i2c@ff030000/i2c-mux@74/i2c@4/clock-generator@69
> 
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
>  .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 20 +------------------
>  .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 20 +------------------
>  2 files changed, 2 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> index 12e8bd48dc8c..eca6c2de84a7 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
> @@ -580,25 +580,7 @@ i2c@4 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <4>;
> -			si5328: clock-generator@69 {/* SI5328 - u20 */
> -				reg = <0x69>;
> -				/*
> -				 * Chip has interrupt present connected to PL
> -				 * interrupt-parent = <&>;
> -				 * interrupts = <>;
> -				 */
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				#clock-cells = <1>;
> -				clocks = <&refhdmi>;
> -				clock-names = "xtal";
> -				clock-output-names = "si5328";
> -
> -				si5328_clk: clk0@0 {
> -					reg = <0>;
> -					clock-frequency = <27000000>;
> -				};
> -			};
> +			/* SI5328 - u20 */
>  		};
>  		/* 5 - 7 unconnected */
>  	};
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> index 18771e868399..eff7c6447087 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
> @@ -581,25 +581,7 @@ i2c@4 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <4>;
> -			si5328: clock-generator@69 {/* SI5328 - u20 */
> -				reg = <0x69>;
> -				/*
> -				 * Chip has interrupt present connected to PL
> -				 * interrupt-parent = <&>;
> -				 * interrupts = <>;
> -				 */
> -				#address-cells = <1>;
> -				#size-cells = <0>;
> -				#clock-cells = <1>;
> -				clocks = <&refhdmi>;
> -				clock-names = "xtal";
> -				clock-output-names = "si5328";
> -
> -				si5328_clk: clk0@0 {
> -					reg = <0>;
> -					clock-frequency = <27000000>;
> -				};
> -			};
> +			/* SI5328 - u20 */
>  		};
>  		i2c@5 {
>  			#address-cells = <1>;
> 

Applied.
M
