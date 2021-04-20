Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782CC365245
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 08:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhDTGUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 02:20:16 -0400
Received: from mail-dm3nam07on2045.outbound.protection.outlook.com ([40.107.95.45]:26848
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229577AbhDTGUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 02:20:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQj1xhtIUn+4OvV1b2j8ctYYrnT4OT6VnE7WzkqpmOEVs5TPe2hxQBFkj0TajBhjQhntFUd4Rf2mgqoedC63M0h0qFVH3RAvbAbHixtOyIj13eQNAsgL4vmdlWaBhIaqRWqWNOWv/uxydSgxLnkJ11GUlS8IIU9kxiFcJ1aYKjl23+Zf9MVvJSJrhhRPTuQH/YGNR7CwwvYMOk4WLobH+qi1mCYfGD+RjEvl9BefgluXhhDt3GcMxD4ALSMni+aDH0+My60HvPWZ1oHFUF0CyCZELFeAKJn4md9AlnS+SG0d7qzIhezfB/BNESuKFSK3O9BecuLubqkRtQlNCM0JEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8/3AHR8GGkGgPyJJ+bxSehEK4fyBjXVzsvm6kC1qSA=;
 b=Uv5kWO92HsUzSwS4eesi3/F2Fm9Ltm0epqQqLdF9vXgMtHvLVw4BeWVrDCNqs1g/rqlFWiuT2YSHUN+XfcUYM0Fdr5ezPJoDdPMpDh4KPDXrST3T/zyaUlOcvKzv0rmZ/zcxk+BshmloKOAog/I0q1jjAFKaTX6+utN9gvG2tdz6R0hV0V6NF1yzG2LWZYELUenoDASVbCh7RFqhtqbJzeoH5LPNJwfoVvZaH50mB9u5NyqyurSA/66MLqGpS/VkojalbF5CEzDU0Rpup1avJS7FLm6zJbfyUBDCIV6UyJXyGW5ZvH4xId3BfGJvB+ByVVVrfs+dmXnuhnz5Zcl8HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8/3AHR8GGkGgPyJJ+bxSehEK4fyBjXVzsvm6kC1qSA=;
 b=YbfT1jakQULTsKncyPWY+XwRBoZiUe1ODU4wlbUzkZKgZ6307ccr+/XhEagDJqQdlukbQIgZeB6grKOMUvWkzshb5ApeAP3adVxy8eJFJqUOIiOZZrLv2+wQJYoBzDRUcyWkLpZp5JITRulAdhtoUi4kGDWn7daBxv2skgumNcE=
Received: from BL0PR0102CA0035.prod.exchangelabs.com (2603:10b6:207:18::48) by
 BN8PR02MB5986.namprd02.prod.outlook.com (2603:10b6:408:bd::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.19; Tue, 20 Apr 2021 06:19:42 +0000
Received: from BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:18:cafe::3) by BL0PR0102CA0035.outlook.office365.com
 (2603:10b6:207:18::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend
 Transport; Tue, 20 Apr 2021 06:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT040.mail.protection.outlook.com (10.152.77.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4042.19 via Frontend Transport; Tue, 20 Apr 2021 06:19:41 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Apr 2021 23:19:41 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Mon, 19 Apr 2021 23:19:41 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 maz@kernel.org,
 tglx@linutronix.de,
 robert.hancock@calian.com
Received: from [172.30.17.109] (port=48648)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lYjjZ-0004Dd-86; Mon, 19 Apr 2021 23:19:41 -0700
Subject: Re: [PATCH v2] irqchip/xilinx: Expose Kconfig option for Zynq/ZynqMP
To:     Robert Hancock <robert.hancock@calian.com>, <tglx@linutronix.de>,
        <maz@kernel.org>
CC:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <anirudh@xilinx.com>
References: <20210419194245.210550-1-robert.hancock@calian.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <06726d96-1c65-caec-f539-c694eebde22b@xilinx.com>
Date:   Tue, 20 Apr 2021 08:19:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210419194245.210550-1-robert.hancock@calian.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f9ac4c3-aff0-4e00-3185-08d903c448d4
X-MS-TrafficTypeDiagnostic: BN8PR02MB5986:
X-Microsoft-Antispam-PRVS: <BN8PR02MB59861D6F03E4F62EFF7CC557C6489@BN8PR02MB5986.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hezyjglgcC5lz8pR3sNLTsVC5uGEJdogDIajqEat8twduwpo7n+lHmIIjYBKzmQmQHLm93vMdD+/jInXnS42Tnv9irnpb/smhCutlTjTmpZ6WmtIPTw/yd+qAmAXKDXJMdgmL20NXiqZ/LxqxPuH+ChNZC3ViC2XY6CsCTE85NInFBYtY0eU7e844hxXjDFW/pJy3VHwpmr2qjKNCkQAivOnf46cs3Q+Fz36/3msbxUIsDT5rWAs03eCgGZNz+dQD5y5oz8IpOZ/XN089cvTKqZDtGYiY0MvxM5XVeONGqVm01PPUiqaBDqssuJUDbYPzfg/so0G7klFnktrjpH8M3t/Ghud3YnaOwLFfIqOEq6UHA1xEl1PLc+rR4kijHgivGdKDLK2zOvH8ToGTdcPCcwWVhmm/apEWybdrgUzEyl63z0Zca+2mvuWn7MCWrEObmnTnGJET/CIm/wvQY0KLxx0zj+MZc+2jLpZPYlEJruCu0xb0UoX85J1w4HVUhOQZdggzd8orRaTZ+kwEVxhqvPQwZKc59PUMySH1IADkIi+NFgFQiorwfgcOR+YYveXZFPCTNMNmvMvBhLo9QqtUq5XGHg67jYHNYKTtTIvShtPLDf3LM2A4Kh75/EFWoJzb5QZlvYlmPJsPxwmCokQv7keTZ6Hr9bDy7Dz3nxEuZti9TsPabtKjQocdq+ptXiUY3KDESsZ2MT6PTGX3OQzmw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(36840700001)(46966006)(2616005)(83380400001)(82310400003)(70586007)(5660300002)(2906002)(4326008)(186003)(110136005)(107886003)(36756003)(26005)(426003)(478600001)(54906003)(8676002)(356005)(44832011)(31686004)(316002)(47076005)(36906005)(31696002)(336012)(8936002)(82740400003)(36860700001)(53546011)(7636003)(70206006)(9786002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 06:19:41.8495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f9ac4c3-aff0-4e00-3185-08d903c448d4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR02MB5986
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/21 9:42 PM, Robert Hancock wrote:
> Previously the XILINX_INTC config option was hidden and only
> auto-selected on the MicroBlaze platform. However, this IP can also be
> used on the Zynq and ZynqMP platforms as a secondary cascaded
> controller. Allow this option to be user-enabled on those platforms.
> 
> Signed-off-by: Robert Hancock <robert.hancock@calian.com>
> ---
>  drivers/irqchip/Kconfig | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 15536e321df5..1020cc5a7800 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -279,8 +279,13 @@ config XTENSA_MX
>  	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
>  
>  config XILINX_INTC
> -	bool
> +	bool "Xilinx Interrupt Controller IP"
> +	depends on MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP || COMPILE_TEST
>  	select IRQ_DOMAIN
> +	help
> +	  Support for the Xilinx Interrupt Controller IP core.
> +	  This is used as a primary controller with MicroBlaze and can also
> +	  be used as a secondary chained controller on other platforms.
>  
>  config IRQ_CROSSBAR
>  	bool
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
