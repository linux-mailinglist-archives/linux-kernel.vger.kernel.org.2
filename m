Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A434B3A9734
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 12:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbhFPK1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 06:27:09 -0400
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com ([40.107.93.49]:33601
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231769AbhFPK1H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 06:27:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSsMuR+HJwr5kq+XwWixqWEeu32HIFz7ov2ayAtC8sU3arp/NwFXsTknchVAjTthDZIg2qkP4NHHU+pTWOKoHFEBm7WW4FgMzojaroBqKjDURQfhgHIh7CJA9tsJx060fiAge+8F8tL+HDn8VaCQRPLY8qeNrZtmMncuP9PHN9u/slUZ7JbAdZpFbLtLOXoAvsDieqRIR74oUk3ztscf2R28SkyrhXDwY7szQxaxCnk6F+dY6ADSguqtbaAXOPgztnjiMcXu72CbAvQG6A+2M+rN6qUY88M4qvV8of07OMYBcV/OalM82n4IlAXIDs6fMSYs97FTCdt0kEBiCoTD8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8F4xzHN4pLNf2rsQt0EeQ+DOyUIIQkAe/wjoNWG6leo=;
 b=GDnmOmafwQaAshqHG/5PdGWd9rVPds8esZMb2np52Mq2NdY/A2GHz17iXd48U3z+99Byiv10ng3zxbYkh/stTIb/3vIDRDax6yMZ8ZO3JfAYcUDUl5Ked6I2LSjgUN0P8PQqx4UtQcSp6iiGWk7j+d+SS5kQIAGkCNTiwghleu7HyY0ASFXvRbC6tgFXvt1dkLiebklPAo+oSGCpUWhrc3hBLbi4htOH4/SrnUpppPrc6OIiDEmZe4mcHw7PjaYhInd9eyw3a/EUMc/HgG3iqoY/fcS5eQQ4ZEc4s8wtMiKVN6ffOi5P/oy74TLKvMD50KAtHKTa5l4ktGcS2IcrXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8F4xzHN4pLNf2rsQt0EeQ+DOyUIIQkAe/wjoNWG6leo=;
 b=Gg6zFkSBN8ZndoKIi201+IlFYyUjbGxvtQhQ8M9WbKSS3ODR4emJg7XFdIl1lNZVbpc5hbemVjkTKF9+INBwJ+LkfDs+lEyQ1QzIR8c8rrTNEc83d4Q1tcH6WK5RQcL8+Cho6gPk5Oo4sfGD0RyhLTvYVnoluROuWXnlV+7Q1zI=
Received: from DM5PR22CA0005.namprd22.prod.outlook.com (2603:10b6:3:101::15)
 by BN7PR02MB5185.namprd02.prod.outlook.com (2603:10b6:408:2a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 16 Jun
 2021 10:24:59 +0000
Received: from DM3NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:101:cafe::66) by DM5PR22CA0005.outlook.office365.com
 (2603:10b6:3:101::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Wed, 16 Jun 2021 10:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT052.mail.protection.outlook.com (10.13.5.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Wed, 16 Jun 2021 10:24:59 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 03:24:58 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 16 Jun 2021 03:24:58 -0700
Envelope-to: git@xilinx.com,
 kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 robh+dt@kernel.org,
 quanyang.wang@windriver.com,
 laurent.pinchart@ideasonboard.com,
 krzk@kernel.org,
 viresh.kumar@linaro.org,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 m.tretter@pengutronix.de
Received: from [172.30.17.109] (port=60794)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1ltSjA-0006bs-SY; Wed, 16 Jun 2021 03:24:57 -0700
To:     Michael Tretter <m.tretter@pengutronix.de>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>, Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>
References: <cover.1623684253.git.michal.simek@xilinx.com>
 <3a68b328a69a0db51948798216cf914c9073baf2.1623684253.git.michal.simek@xilinx.com>
 <20210616100704.GH22530@pengutronix.de>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v2 31/33] arm64: zynqmp: Enable xlnx, zynqmp-dwc3 driver
 for xilinx boards
Message-ID: <f365e23b-7f3f-b9f7-8f1b-9d539f431403@xilinx.com>
Date:   Wed, 16 Jun 2021 12:24:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616100704.GH22530@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab60f046-288c-4796-3324-08d930b0fe93
X-MS-TrafficTypeDiagnostic: BN7PR02MB5185:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5185CCED9DD63BCC14865699C60F9@BN7PR02MB5185.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S9dTlIaIFtsJF5br4OaEeEmcRsyvqLdEeQCMNrEQ9hjKZov8B1ELBloDXCDSwofbTOysvPnaTBsAuf8aRcSj2xaTnQF13VyjmwfNwBw2+yJrWvtAp6lEWUgKKiHzNK7mZ0FrVHxbiD2ObgcjCfWrwJ9jzY5Q8iL1RsueFKT2V2t8WJ5WbKhVJRk2Cj03XTtuEI58F3Q6EtXWdvHPmQJzjlIVoWl/CyKXJkOVMUYU8O6Kj7PVKei/oiMjMKrmtUza5jpJL0fD1RALLzUsFVIk1NLMhHRZW3rzH8uKgKN0Siv1gBiutrfBXOkJi+MfgnFAyy94UcrKTdP7uykms4wGhtSYIzmkx2AnV57jRB0sf+GTCDR9O2nTHmjSruSCLo031QrCdO1Gh0QQLvNlc/P9thrslWJ6OYUG4PfntPyFpbNGhvq1zAP0e8vjjlHA9B8OgmXB+nRTTJwzbPHx45hwUl4ukzBhGXtlxsXDO4Yk4GJ8Nzl+wBy+ack4RNVZngA2EKlkUrlTy/KvGZYWnoP1aiDC8JkJI0zMhy3/15R7kHo5SYG+62dgJRhn7Pxp0LcFPR0FOG12PW1J29k4V0/qmKnY+bHlzaSnGLHXEx6sIZdj9b/iW5o0nx8v9ycN4yk7UmagzpLiMTwSdYhR6SXKPrPJ1AQc0pAZfTSDd/1tv+X7CnKXzaieTx4zj2HSdF5joLqf71ryHngCouYvMSUlCg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(36840700001)(4326008)(31686004)(44832011)(186003)(70206006)(26005)(53546011)(478600001)(36756003)(36906005)(70586007)(8676002)(336012)(7416002)(6666004)(30864003)(5660300002)(110136005)(426003)(83380400001)(82310400003)(2616005)(8936002)(82740400003)(316002)(7636003)(54906003)(2906002)(9786002)(36860700001)(31696002)(47076005)(356005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 10:24:59.2183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab60f046-288c-4796-3324-08d930b0fe93
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5185
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/16/21 12:07 PM, Michael Tretter wrote:
> On Mon, 14 Jun 2021 17:25:39 +0200, Michal Simek wrote:
>> The commit 84770f028fab ("usb: dwc3: Add driver for Xilinx platforms")
>> finally add proper support for Xilinx dwc3 driver. This patch is adding DT
>> description for it.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> Changes in v2:
>> - New patch in the series
>>
>>  .../dts/xilinx/zynqmp-zc1751-xm015-dc1.dts    |  6 ++
>>  .../dts/xilinx/zynqmp-zc1751-xm016-dc2.dts    |  7 ++
>>  .../dts/xilinx/zynqmp-zc1751-xm017-dc3.dts    | 14 ++++
>>  .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 10 +++
>>  .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    |  6 ++
>>  .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    |  6 ++
>>  .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    |  6 ++
>>  .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    |  6 ++
>>  .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    |  6 ++
>>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 70 +++++++++++++++----
>>  10 files changed, 124 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>> index d78439e891b9..c1cedc92e017 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
>> @@ -27,6 +27,7 @@ aliases {
>>  		rtc0 = &rtc;
>>  		serial0 = &uart0;
>>  		spi0 = &qspi;
>> +		usb0 = &usb0;
>>  	};
>>  
>>  	chosen {
>> @@ -404,7 +405,12 @@ &usb0 {
>>  	status = "okay";
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&pinctrl_usb0_default>;
>> +};
>> +
>> +&dwc3_0 {
>> +	status = "okay";
>>  	dr_mode = "host";
>> +	snps,usb3_lpm_capable;
>>  	phy-names = "usb3-phy";
>>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>>  	maximum-speed = "super-speed";
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>> index cd61550c52e5..938b76bd0527 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts
>> @@ -26,6 +26,7 @@ aliases {
>>  		serial1 = &uart1;
>>  		spi0 = &spi0;
>>  		spi1 = &spi1;
>> +		usb0 = &usb1;
>>  	};
>>  
>>  	chosen {
>> @@ -479,7 +480,13 @@ &usb1 {
>>  	status = "okay";
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&pinctrl_usb1_default>;
>> +};
>> +
>> +&dwc3_1 {
>> +	status = "okay";
>>  	dr_mode = "host";
>> +	snps,usb3_lpm_capable;
>> +	maximum-speed = "super-speed";
>>  };
>>  
>>  &uart0 {
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>> index ba7f1f21c579..4394ec3b6a23 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts
>> @@ -24,6 +24,8 @@ aliases {
>>  		rtc0 = &rtc;
>>  		serial0 = &uart0;
>>  		serial1 = &uart1;
>> +		usb0 = &usb0;
>> +		usb1 = &usb1;
>>  	};
>>  
>>  	chosen {
>> @@ -147,11 +149,23 @@ &uart1 {
>>  
>>  &usb0 {
>>  	status = "okay";
>> +};
>> +
>> +&dwc3_0 {
>> +	status = "okay";
>>  	dr_mode = "host";
>> +	snps,usb3_lpm_capable;
>> +	maximum-speed = "super-speed";
>>  };
>>  
>>  /* ULPI SMSC USB3320 */
>>  &usb1 {
>>  	status = "okay";
>> +};
>> +
>> +&dwc3_1 {
>> +	status = "okay";
>>  	dr_mode = "host";
>> +	snps,usb3_lpm_capable;
>> +	maximum-speed = "super-speed";
>>  };
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>> index 80415e202814..6d32bfac48b5 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
>> @@ -30,6 +30,8 @@ aliases {
>>  		serial2 = &dcc;
>>  		spi0 = &spi0;
>>  		spi1 = &spi1;
>> +		usb0 = &usb0;
>> +		usb1 = &usb1;
>>  		mmc0 = &sdhci0;
>>  		mmc1 = &sdhci1;
>>  	};
>> @@ -537,6 +539,10 @@ &usb0 {
>>  	status = "okay";
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&pinctrl_usb0_default>;
>> +};
>> +
>> +&dwc3_0 {
>> +	status = "okay";
>>  	dr_mode = "peripheral";
>>  	phy-names = "usb3-phy";
>>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 0>;
>> @@ -548,6 +554,10 @@ &usb1 {
>>  	status = "okay";
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&pinctrl_usb1_default>;
>> +};
>> +
>> +&dwc3_1 {
>> +	status = "okay";
>>  	dr_mode = "host";
>>  	phy-names = "usb3-phy";
>>  	phys = <&psgtr 3 PHY_TYPE_USB3 1 0>;
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>> index becfc23a5610..b17677378ab5 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
>> @@ -31,6 +31,7 @@ aliases {
>>  		serial1 = &uart1;
>>  		serial2 = &dcc;
>>  		spi0 = &qspi;
>> +		usb0 = &usb0;
>>  	};
>>  
>>  	chosen {
>> @@ -998,7 +999,12 @@ &usb0 {
>>  	status = "okay";
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&pinctrl_usb0_default>;
>> +};
>> +
>> +&dwc3_0 {
>> +	status = "okay";
>>  	dr_mode = "host";
>> +	snps,usb3_lpm_capable;
>>  	phy-names = "usb3-phy";
>>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>>  	maximum-speed = "super-speed";
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>> index 86fff3632c7d..fb7a9f7907d9 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
>> @@ -29,6 +29,7 @@ aliases {
>>  		serial1 = &uart1;
>>  		serial2 = &dcc;
>>  		spi0 = &qspi;
>> +		usb0 = &usb0;
>>  	};
>>  
>>  	chosen {
>> @@ -481,7 +482,12 @@ &usb0 {
>>  	status = "okay";
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&pinctrl_usb0_default>;
>> +};
>> +
>> +&dwc3_0 {
>> +	status = "okay";
>>  	dr_mode = "host";
>> +	snps,usb3_lpm_capable;
>>  	phy-names = "usb3-phy";
>>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>>  	maximum-speed = "super-speed";
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
>> index 2a872d439804..afc9b200a59b 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts
>> @@ -29,6 +29,7 @@ aliases {
>>  		serial1 = &uart1;
>>  		serial2 = &dcc;
>>  		spi0 = &qspi;
>> +		usb0 = &usb0;
>>  	};
>>  
>>  	chosen {
>> @@ -493,7 +494,12 @@ &usb0 {
>>  	status = "okay";
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&pinctrl_usb0_default>;
>> +};
>> +
>> +&dwc3_0 {
>> +	status = "okay";
>>  	dr_mode = "host";
>> +	snps,usb3_lpm_capable;
>>  	phy-names = "usb3-phy";
>>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>>  	maximum-speed = "super-speed";
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>> index d2219373580a..793740cbd791 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
>> @@ -31,6 +31,7 @@ aliases {
>>  		serial1 = &uart1;
>>  		serial2 = &dcc;
>>  		spi0 = &qspi;
>> +		usb0 = &usb0;
>>  	};
>>  
>>  	chosen {
>> @@ -991,7 +992,12 @@ &usb0 {
>>  	status = "okay";
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&pinctrl_usb0_default>;
>> +};
>> +
>> +&dwc3_0 {
>> +	status = "okay";
>>  	dr_mode = "host";
>> +	snps,usb3_lpm_capable;
>>  	phy-names = "usb3-phy";
>>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>>  	maximum-speed = "super-speed";
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>> index dac5ba67a160..a245250970c8 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
>> @@ -30,6 +30,7 @@ aliases {
>>  		serial0 = &uart0;
>>  		serial1 = &dcc;
>>  		spi0 = &qspi;
>> +		usb0 = &usb0;
>>  	};
>>  
>>  	chosen {
>> @@ -828,7 +829,12 @@ &usb0 {
>>  	status = "okay";
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&pinctrl_usb0_default>;
>> +};
>> +
>> +&dwc3_0 {
>> +	status = "okay";
>>  	dr_mode = "host";
>> +	snps,usb3_lpm_capable;
>>  	phy-names = "usb3-phy";
>>  	phys = <&psgtr 2 PHY_TYPE_USB3 0 2>;
>>  	maximum-speed = "super-speed";
>> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> index 6f0fcec28ae2..731b2d170344 100644
>> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
>> @@ -2,7 +2,7 @@
>>  /*
>>   * dts file for Xilinx ZynqMP
>>   *
>> - * (C) Copyright 2014 - 2019, Xilinx, Inc.
>> + * (C) Copyright 2014 - 2021, Xilinx, Inc.
>>   *
>>   * Michal Simek <michal.simek@xilinx.com>
>>   *
>> @@ -805,24 +805,68 @@ uart1: serial@ff010000 {
>>  			power-domains = <&zynqmp_firmware PD_UART_1>;
>>  		};
>>  
>> -		usb0: usb@fe200000 {
>> -			compatible = "snps,dwc3";
>> +		usb0: usb0@ff9d0000 {
> 
> usb@ff9d0000

I spot it myself too. Will fix in next version.

> 
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>>  			status = "disabled";
>> -			interrupt-parent = <&gic>;
>> -			interrupts = <0 65 4>;
>> -			reg = <0x0 0xfe200000 0x0 0x40000>;
>> -			clock-names = "clk_xin", "clk_ahb";
>> +			compatible = "xlnx,zynqmp-dwc3";
>> +			reg = <0x0 0xff9d0000 0x0 0x100>;
>> +			clock-names = "bus_clk", "ref_clk";
>>  			power-domains = <&zynqmp_firmware PD_USB_0>;
>> +			resets = <&zynqmp_reset ZYNQMP_RESET_USB0_CORERESET>,
>> +				 <&zynqmp_reset ZYNQMP_RESET_USB0_HIBERRESET>,
>> +				 <&zynqmp_reset ZYNQMP_RESET_USB0_APB>;
>> +			reset-names = "usb_crst", "usb_hibrst", "usb_apbrst";
>> +			ranges;
>> +
>> +			dwc3_0: usb@fe200000 {
>> +				compatible = "snps,dwc3";
>> +				status = "disabled";
> 
> I think it would be better to drop the status from dwc3_0, since it is a child
> node of the already disabled usb0 node. With the current change, the board dts
> has to enable usb0 and dwc3_0 to enable usb support, which is kind of
> unexpected.

I don't think we have a choice here. I know it is not the best but even
when we remove this property from here you need to align board dts to
match it.
You need to move for example dr_mode to &dwc3_0 and not keeping it in &usb0.
Please correct me if I am wrong here.

> 
>> +				reg = <0x0 0xfe200000 0x0 0x40000>;
>> +				interrupt-parent = <&gic>;
>> +				interrupt-names = "dwc_usb3", "otg";
>> +				interrupts = <0 65 4>, <0 69 4>;
>> +				#stream-id-cells = <1>;
>> +				iommus = <&smmu 0x860>;
>> +				snps,quirk-frame-length-adjustment = <0x20>;
>> +				snps,refclk_fladj;
>> +				snps,enable_guctl1_resume_quirk;
>> +				snps,enable_guctl1_ipd_quirk;
>> +				snps,xhci-stream-quirk;
> 
> The last four properties for snps are not documented (and not used by the
> driver).

I missed this - will remove it also for second instance.

Thanks,
Michal
