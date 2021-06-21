Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5A63AE7F1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFULOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 07:14:06 -0400
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com ([40.107.94.46]:34560
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229641AbhFULOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:14:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wrjq94/MVC0NxW9H3sruj5d2jgcygKc9NdcG3yGtDUlGAxOCmLEycjjg0Lky+B0BuPmjCROVzWR8ZvzUOwYq94HH27TwXSgVFMAAB9qWivupA1LytOWqPY5JCiZZH3H+ueTxFxTw7960qGsnGWONeeYY1TgnX2pKtxNhoQYcCTB8PPbK21/frdyW7r1IEM8pGghqb44fWKg1iFn3FN/SvLqFiBewmp7n/13B6DAUOc2BF67h2QAa0HLC1uEeDru2me4NGn7+5tcIBu6fN5QpyX6ETVV00DQEXkhLbqCXZu2AYUUsuiYMMYK/czKLmR7IIjTi3Vv7kDoe1/vJF4l1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/FH/SFoIWnvshKm3P0I5MgZn5ylC6y9EnMXADel+DE=;
 b=K4H8mfzhAKcoTFfjci4LzXEqcQEvu6fE9Sd2kKOlGsCplILVDlvDdszvtShRsip5+JO5Dqa/SLaVnZ9z5c1YxyKlBmKCs/mIty0mmmvFqyI0wjlayVSVQNeBBVsgPwx0Rd32TOX+QfDisTZJRtb8CSpTmkpSRBVuDin5S8yLwl0GBQcAkvHuInTriiuX47Fvd16mS0ehiHN7fT7ijqAOqrrmfr2BqCnTIUPm6g+tgrgmpfoyw4Hw0wV78AUkOUhFa9u9sNI20py7M3L3ZTVjqPHlhF/E0rYvOVYWApSlwm9FX08LjgO4aFA8XpFpGYYNhlj3hzNrMnJFxd0Q6++Oig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/FH/SFoIWnvshKm3P0I5MgZn5ylC6y9EnMXADel+DE=;
 b=tjDMCL9snBlqBOUJvuRkcK6Yf/camRprl4GOYHVl8kNkJWgYboPHlcWA7AU9adMgkF28CurPXSl8s5jtNbeQuCbmbwG9X5Mk43tIcKZSEUTldJaXh5jdPpoo8agifv6/6bPZkxL0KcfnWPUN7uMNeBZdg3XkSuXmn308ODfDLVY=
Received: from SA0PR11CA0090.namprd11.prod.outlook.com (2603:10b6:806:d2::35)
 by CY4PR02MB2472.namprd02.prod.outlook.com (2603:10b6:903:70::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Mon, 21 Jun
 2021 11:11:49 +0000
Received: from SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d2:cafe::a4) by SA0PR11CA0090.outlook.office365.com
 (2603:10b6:806:d2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Mon, 21 Jun 2021 11:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0003.mail.protection.outlook.com (10.97.4.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 11:11:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 04:11:48 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 21 Jun 2021 04:11:48 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 zou_wei@huawei.com
Received: from [172.30.17.109] (port=46728)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lvHqG-00021b-8m; Mon, 21 Jun 2021 04:11:48 -0700
Subject: Re: [PATCH 2/6] firmware: xilinx: add macros of node ids for error
 event
To:     Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>,
        <michal.simek@xilinx.com>
CC:     <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <amit.sunil.dhamne@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1622217566-1856-1-git-send-email-abhyuday.godhasara@xilinx.com>
 <1622217566-1856-3-git-send-email-abhyuday.godhasara@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a4d6b733-0cfc-4624-e46f-6d8c89c252a2@xilinx.com>
Date:   Mon, 21 Jun 2021 13:11:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1622217566-1856-3-git-send-email-abhyuday.godhasara@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abf6dac0-b99e-4591-3b62-08d934a55dda
X-MS-TrafficTypeDiagnostic: CY4PR02MB2472:
X-Microsoft-Antispam-PRVS: <CY4PR02MB247257F5E0378819874C4252C60A9@CY4PR02MB2472.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRyQonzmN/i97x7eybGy7a7ErwsfU7YGoLfsqwpCuGkYXbCr0VdrXhnAtFeVxWohvpfgTlmylPRS8GkJAnR+uRTTMYLGnhXbz5D1bGftesi7sHrTxObTmX7vSac0z3SdxqsqmKKRq3c54wU0h1OwUBU+/x+d7KZBxba7EudRBE4KAFTJgAYHSd0OIo8fSNjQTw2z0eZF9ak6Z1piihrsy/542Isq6bqLiL0KXfe0uQCc608mvPV7HLYj9MXZbOdCifcSleKDW1w+nFkjtLy6dh5o8F3JJ5LxrJJziaaPwhGm9GvLijTslJCz5ZYclxWGlBIVtgjyW09EoCb3mj0yI30KP6t4PcerZVuaQE5c/tF1UzdHAcGLu9xqhcJVxXYQE6vQ4q0rIuQJWmmJ6HZzquDovOg2XXzoa56Vp5Edd3TbqJeVip2I5FyqYv014DHYScftMj/JpL4aOLYTkvurnSTMgLKFS0n3RcVU+bWtb+4PuOqPa9yVhTA9LSkTRxfOE8Kl7QTqYIZ4A3DQyTTmIgYz6XzP/n/+Z0dOfT5OtL+1gpUfovK+yCEw1TbcvAqRNnYu6kSqNlAhMFlDX3fWqITWOJPTKndXQqKEu5l8bTljqtKyglzWX67Hz+7jm4ggtoFrS9RdZ1DrZWiUGcLKJd1jNIG84bUehHwf4nZjZAWYaG9LXqfNe9uX9eP7/gNcstWzJTp/sx0GOG/8ocw2jA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(356005)(83380400001)(8676002)(82740400003)(31686004)(7636003)(9786002)(82310400003)(47076005)(2616005)(8936002)(36756003)(110136005)(426003)(44832011)(478600001)(70206006)(5660300002)(26005)(316002)(54906003)(336012)(36860700001)(36906005)(31696002)(53546011)(186003)(70586007)(6666004)(2906002)(4326008)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 11:11:49.7657
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abf6dac0-b99e-4591-3b62-08d934a55dda
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2472
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/21 5:59 PM, Abhyuday Godhasara wrote:
> Add macros for the Node-Id of Error events.
> 
> Move supported api callback ids from zynqmp-power to zynqmp-firmware.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> ---
>  drivers/soc/xilinx/zynqmp_power.c    |  6 ------
>  include/linux/firmware/xlnx-zynqmp.h | 13 +++++++++++++
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
> index c556623..76478fe 100644
> --- a/drivers/soc/xilinx/zynqmp_power.c
> +++ b/drivers/soc/xilinx/zynqmp_power.c
> @@ -46,12 +46,6 @@ static const char *const suspend_modes[] = {
>  
>  static enum pm_suspend_mode suspend_mode = PM_SUSPEND_MODE_STD;
>  
> -enum pm_api_cb_id {
> -	PM_INIT_SUSPEND_CB = 30,
> -	PM_ACKNOWLEDGE_CB,
> -	PM_NOTIFY_CB,
> -};
> -
>  static void zynqmp_pm_get_callback_data(u32 *buf)
>  {
>  	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 6557832..c715756 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -60,6 +60,19 @@
>  #define XILINX_ZYNQMP_PM_FPGA_FULL	0x0U
>  #define XILINX_ZYNQMP_PM_FPGA_PARTIAL	BIT(0)
>  
> +/*
> + * Node IDs for the Error Events.
> + */
> +#define EVENT_ERROR_PMC_ERR1	(0x28100000U)
> +#define EVENT_ERROR_PMC_ERR2	(0x28104000U)
> +#define EVENT_ERROR_PSM_ERR1	(0x28108000U)
> +#define EVENT_ERROR_PSM_ERR2	(0x2810C000U)
> +
> +enum pm_api_cb_id {
> +	PM_INIT_SUSPEND_CB = 30,

No information about why PM_ACKNOWLEDGE_CB was removed. Doing it via
separate patch would be the best.

M

> +	PM_NOTIFY_CB = 32,
> +};
> +
>  enum pm_api_id {
>  	PM_GET_API_VERSION = 1,
>  	PM_REGISTER_NOTIFIER = 5,
> 
