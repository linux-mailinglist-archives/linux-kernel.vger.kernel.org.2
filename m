Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD0B30D39F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 08:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhBCHAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 02:00:11 -0500
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com ([40.107.243.41]:51169
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231784AbhBCG7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 01:59:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5U+ilUB87bTc4VXQ9aTrsMRmJ0REdHx5BIrTJ8Fp3KHRp66ifll09SmamnqCQPg40uwdR4vWBr29eg4LIc/a1p2kzAknneUhoRKCNEMNwyUPYlfsuTnAX8KUk2Nien+oSjnr++POpJR2Dq0dRhxwKBNtPXP2m8Z1/uq4IeXbeRdo0mTpBYExOmEvse0PsbxYGGUIu0UVLImsuGQg+swruK/KePAC+hpCwxFsxvW3alM+cGLe384v9LTiEe5RYD63+KfJ/49em9Cqk8Z5p82c9NM0+AR6YLHvF+GohIqXeU7NaNMdXlUR8nsorcnhzB8U/ey97WP600lZXGuAhU7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOng03xMC5hQ0qAB1LEfvbUo+VJQEdkw7K6XMxb6quc=;
 b=VCLVUiHfzjX6EaulUHxAGFbBLSEh97Tj+FX1YPD8v+Cl4RdDx03QndJrEeBI59hwxyA095/L9eaoMAXuJUGdXLIaa6E7kk3OepAsNpti43717baxdW8EUFx2pNlmQ+KofrWVupQNQ2iYJbk8KBOBf2TdQN7OwP/TkbH7preyb0clAu8pVtMMZBU0X1jNhoknj0RjKhWLAaQdxYmpc7K2jejNmU9ba7LlinZGnNgpWYCA9bI/ZKn3oxtB32ug+9zZpnrKPyB8esNoKOLaRdnZTvLMrH1Lr9H0ZgFUXb3l7623d0/bOeizxDcQs60Pg+1FPk7xxf5Z9qwS/pOhz+MMOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOng03xMC5hQ0qAB1LEfvbUo+VJQEdkw7K6XMxb6quc=;
 b=qNPEdTax96C0BXB2nI6NszLwztJszObyqHn7wp3AtxkFNNuvNvF6DnPmTiDYyeByfbIoSUJk2DRE+mLqwJhiR6HURha+OF6cINYOzge3nGx8zD2SWRjH6PekH1D1oiuxkPxRpVoW1BFtf/I2sL8DEu4jFha3tQlkIw6mQNul+Zc=
Received: from CY4PR12CA0036.namprd12.prod.outlook.com (2603:10b6:903:129::22)
 by MWHPR02MB2752.namprd02.prod.outlook.com (2603:10b6:300:107::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 3 Feb
 2021 06:59:01 +0000
Received: from CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:129:cafe::c) by CY4PR12CA0036.outlook.office365.com
 (2603:10b6:903:129::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19 via Frontend
 Transport; Wed, 3 Feb 2021 06:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT064.mail.protection.outlook.com (10.152.74.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Wed, 3 Feb 2021 06:59:01 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 2 Feb 2021 22:59:00 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 2 Feb 2021 22:59:00 -0800
Envelope-to: michal.simek@xilinx.com,
 robh+dt@kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 michael@walle.cc
Received: from [172.30.17.109] (port=49576)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1l7C7w-0004vo-Gr; Tue, 02 Feb 2021 22:59:00 -0800
Subject: Re: [PATCH] ARM: dts: ebaz4205: add pinctrl entries for switches
To:     Michael Walle <michael@walle.cc>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
References: <20210201133000.23402-1-michael@walle.cc>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <120f29c0-a5d3-5b78-e3d2-df2a15517e05@xilinx.com>
Date:   Wed, 3 Feb 2021 07:58:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210201133000.23402-1-michael@walle.cc>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d39eb69f-c2e0-4205-2543-08d8c8112fb9
X-MS-TrafficTypeDiagnostic: MWHPR02MB2752:
X-Microsoft-Antispam-PRVS: <MWHPR02MB27523A96062A8E4B398240F8C6B49@MWHPR02MB2752.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: feRTYHfer+njqyPecyCR0CyRlPZGQ3dZNuMLNaK+LcRGrqMJqApqPG4GqfMGP9fLhfxt3zCHxM0vw6UMCcy4fsFn0a5S0SaR6ubzxYgGPWeRz7MwhnRLepUs8BjHKr4l/D5yEJu4bN3GgcdwN3769o2geSTxG/a80oHe7YHj0XHyyicNZffY8FuCwS2j7berq3WypinYdzZO7ceApTqhFRzfwP6K5sde2n0ogTv+bkdGVz84gW1OwYo/Gt7s97qQ9HpYRPFNF06zHj3uckbT22hy572t4Cw3Sk6YjLCKjT5aiSTo5+xf3CytxwGC3hTY6Nvn4GP/Ad5ZBuMsyMEH7IdmeaohMykpCniDc11YFobFTjLxYMJHuEf82x7VWF5sx0nB1w3lcYACTKVHjWhZ58LLdDO7xHWGvoLY62jO6fPXzGz01hnVXVsN9fgjyCZUcWULskVncf95tKiW3zn4zCR3h8vUe+IORVxWLUDsxIgE/7KPfGIzbcT7SbnqO29PtHSv7x3cbDZWDu2LBnPujWB12VnH7M8HZeFo+8U/SniSf3jqk4cSFVdydnKFd9kc9E7C5kWmKJ2SuU8PU2dBxMaTEvZJz0ST481gohN10fD/N1YXNsbuT6G7pJmuBAFp9XDEsK0tWRjn75T7AV8BzCgzEKxtfLrXE8pviWjVKNuMGI7tP0H80/r88by9j50NmLe7DPjiDQZZqiEZCKp8Cr1WiAHu8jrzYz7wtmtCw40=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36840700001)(46966006)(82310400003)(47076005)(426003)(31686004)(9786002)(70586007)(336012)(478600001)(110136005)(7636003)(70206006)(5660300002)(82740400003)(26005)(186003)(107886003)(36756003)(53546011)(54906003)(8676002)(316002)(36906005)(8936002)(2906002)(2616005)(4326008)(31696002)(36860700001)(44832011)(356005)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 06:59:01.2947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d39eb69f-c2e0-4205-2543-08d8c8112fb9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2752
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/21 2:30 PM, Michael Walle wrote:
> Add the pinctrl entries for the GPIOs which are connected to the
> push buttons on this board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  arch/arm/boot/dts/zynq-ebaz4205.dts | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/zynq-ebaz4205.dts b/arch/arm/boot/dts/zynq-ebaz4205.dts
> index e802d4ae8804..b0b836aedd76 100644
> --- a/arch/arm/boot/dts/zynq-ebaz4205.dts
> +++ b/arch/arm/boot/dts/zynq-ebaz4205.dts
> @@ -43,7 +43,30 @@
>  	};
>  };
>  
> +&gpio0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_gpio0_default>;
> +};
> +
>  &pinctrl0 {
> +	pinctrl_gpio0_default: gpio0-default {
> +		mux {
> +			groups = "gpio0_20_grp", "gpio0_32_grp";
> +			function = "gpio0";
> +		};
> +
> +		conf {
> +			groups = "gpio0_20_grp", "gpio0_32_grp";
> +			io-standard = <3>;
> +			slew-rate = <0>;
> +		};
> +
> +		conf-pull-up {
> +			pins = "MIO20", "MIO32";
> +			bias-disable;
> +		};
> +	};
> +
>  	pinctrl_sdhci0_default: sdhci0-default {
>  		mux {
>  			groups = "sdio0_2_grp";
> 

Applied.
M
