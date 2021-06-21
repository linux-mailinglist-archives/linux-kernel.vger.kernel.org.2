Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97CF3AE850
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhFULsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 07:48:05 -0400
Received: from mail-dm6nam12on2080.outbound.protection.outlook.com ([40.107.243.80]:38803
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229576AbhFULsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:48:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCBtcVwJx76yQ7wYr1oRzEiHEnuGoqVOHkL1J0RWfLt0D60o8iNOP4xpsAT3RbrNbgH0XdbVrqo8z8VrJPt0NmhGFnlYfTZeKFUXN9M2bNBXsAQ9v/Nx2Lq/Rc+l0OCdV1EZuNdERPFe5nuoNFzIlGFYbiMA8AEhNuTbE7HyFjoJkCVIX5DJJQxfRc5EWf/BvBgIJs42uam87miTa54igJIzmm8NaB/jufM5gYrbfL/0q9mkz6uKyk8OERs1ep4ohT/h5DIrWysZgENMYPN6er9bSlEKF/jKWexzFYQi8Z42BZO3oAVKqvZUannif/sOcJKjh33kGacATsR7NkMkug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkvzXuE1H9tyF08IgllN+wKflWGXyD78Ps31n7CkS8E=;
 b=EIE1hLNN0HHlbj4RPJkDnta30b4gsOTVvSfN29NvsWyQYR683O31zDKLK8sAmrj536JMzl/k2i/kiytIB457nxirTw+f0jiYUQ27+KBESP1JTqL+bmxaVwvVyqYlxk1QJ93GWnpdb4KMCIe5cLNvrG1HOxfgodOixFAmzRkBJrTLrEHNT8xCF8lIi0EGeFOPs2bPGmeqZ5JSYlg5baoJrYUOIrQhUkw9HPXS8HNrY3WFP7zoaIFv1UrxE7nes4akypx1IKdkQoBFCRPWD8F6T0Wozy+wj7ONq3LNM+mxAus348X1wxkQ+QfOeiVDspQiTDjvEq6Gze8YNaMubI7gDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkvzXuE1H9tyF08IgllN+wKflWGXyD78Ps31n7CkS8E=;
 b=E6tWy96fuSeGqG/g1NQroTz/WPegm2jUQlhQpQpZ1cwA0ST3vYVI9kzf2/91cNWDN4iuSkF1GtVI3Ps18p1WhSUiYFSGHfPvbDGzHpzjPglPHmyBLYttDfRLzT3bFTVBrpNSBu7DQuCEkdV1wfnsgzoLpPfl/1IAi5FCCzc+cGY=
Received: from BN0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:e7::31)
 by BN0PR02MB8221.namprd02.prod.outlook.com (2603:10b6:408:153::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Mon, 21 Jun
 2021 11:45:48 +0000
Received: from BN1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::79) by BN0PR03CA0056.outlook.office365.com
 (2603:10b6:408:e7::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Mon, 21 Jun 2021 11:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT055.mail.protection.outlook.com (10.13.2.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 11:45:48 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 04:45:44 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 21 Jun 2021 04:45:44 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 zou_wei@huawei.com
Received: from [172.30.17.109] (port=49540)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lvIN5-0006CA-Ti; Mon, 21 Jun 2021 04:45:44 -0700
Subject: Re: [PATCH 1/6] firmware: xilinx: add register notifier in zynqmp
 firmware
To:     Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>,
        <michal.simek@xilinx.com>
CC:     <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <amit.sunil.dhamne@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tejas Patel <tejas.patel@xilinx.com>
References: <1622217566-1856-1-git-send-email-abhyuday.godhasara@xilinx.com>
 <1622217566-1856-2-git-send-email-abhyuday.godhasara@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <6d230f7e-d039-a99b-87e9-25b42bdf9cdb@xilinx.com>
Date:   Mon, 21 Jun 2021 13:45:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1622217566-1856-2-git-send-email-abhyuday.godhasara@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b70418ce-259e-45ab-6dcc-08d934aa1cc9
X-MS-TrafficTypeDiagnostic: BN0PR02MB8221:
X-Microsoft-Antispam-PRVS: <BN0PR02MB822115A3DD6D0380B86129C9C60A9@BN0PR02MB8221.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKzwteVtD8kBh05i+3MT/G6jqC7tbfnDpW53ITelFCvgnlKJQVg49Ypa58wQfstXcVYoJgrl7HUmfZpSsFLyVT43hw8wy/Mu4ddJDRf5oIKMp5VnI8zoqs8CReOrDOjuBrwajTDKiV8o7LWrwzAtOm8MwBu3S3+aLh0swz55x362KdenR9o/l9yY4KLxIq844h8w/E1uf8eb/WH/QH/pQtCm+UJm+DiJbeajbCRoVu2EHfqTC7mhHvLGzorPgFPvqzNi0w+s8AHJhKDq5/B4zC9F6U6b1L/EdyBMzZoBOpIbXOKNI70VJYP1PspyQxdphXq0ABSYPeavNlIqay6rZ6xr+si4/OGVzP3EUv4c7eSkZft03kw91Mrujw1TJ7qp4MG8jN7NG2/5ZfsCeyYIZ8vdv2P+ICxZFKb5AZVk94t3sR6cro55YDroBNJQEw1iqfvrBLtlpseM5bkWB0V4MtDClf3K3qzQ2fV0os7O2SrjcOPWIgZcQWWQ8OpyffnhaQW88QbpNYZ6e7bOSwbVu7aj9L9ZhXHL+GQXrQqXJEYxFZ2TFfUALtdxFe4qH3lrxBtjrJeO+kPQ05TSaqaw8keOoFn4c42nH64KP/beNr6BOBfRwluJcAmyPRneNVAH9/xuStBXA7KKWmpa+Q2zf87aIdCaiBeY0Bci690TspZa84aQ0PdT74L+65nJs4oKM1OXzA+HgtkPehgf7SVWmg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(36840700001)(31696002)(36860700001)(82740400003)(36756003)(356005)(9786002)(70206006)(31686004)(8676002)(5660300002)(44832011)(186003)(47076005)(107886003)(426003)(26005)(4326008)(478600001)(83380400001)(82310400003)(53546011)(54906003)(2906002)(8936002)(2616005)(336012)(6666004)(7636003)(110136005)(316002)(70586007)(36906005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 11:45:48.0204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b70418ce-259e-45ab-6dcc-08d934aa1cc9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT055.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8221
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/21 5:59 PM, Abhyuday Godhasara wrote:
> In zynqmp-firmware, register notifier is not supported, add support of
> register notifier in zynqmp-firmware.
> 
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp-debug.c |  2 +-
>  drivers/firmware/xilinx/zynqmp.c       | 23 +++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h   | 11 ++++++++++-
>  3 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp-debug.c b/drivers/firmware/xilinx/zynqmp-debug.c
> index 99606b3..7841cb7 100644
> --- a/drivers/firmware/xilinx/zynqmp-debug.c
> +++ b/drivers/firmware/xilinx/zynqmp-debug.c
> @@ -2,7 +2,7 @@
>  /*
>   * Xilinx Zynq MPSoC Firmware layer for debugfs APIs
>   *
> - *  Copyright (C) 2014-2018 Xilinx, Inc.
> + *  Copyright (C) 2014-2021 Xilinx, Inc.

no reason for this change when you don't change this file.

>   *
>   *  Michal Simek <michal.simek@xilinx.com>
>   *  Davorin Mista <davorin.mista@aggios.com>
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 15b13832..33f190e 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -1037,6 +1037,29 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
>  EXPORT_SYMBOL_GPL(zynqmp_pm_aes_engine);
>  
>  /**
> + * zynqmp_pm_register_notifier() - PM API for register a subsystem
> + *                                to be notified about specific
> + *                                event/error.
> + * @node:	Node ID to which the event is related.
> + * @event:	Event Mask of Error events for which wants to get notified.
> + * @wake:	Wake subsystem upon capturing the event if value 1
> + * @enable:	Enable the registration for value 1, disable for value 0
> + *
> + * This function is used to register/un-register for particular node-event
> + * combination in firmware.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +
> +int zynqmp_pm_register_notifier(const u32 node, const u32 event,
> +				const u32 wake, const u32 enable)
> +{
> +	return zynqmp_pm_invoke_fn(PM_REGISTER_NOTIFIER, node, event,
> +				   wake, enable, NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_register_notifier);
> +
> +/**
>   * zynqmp_pm_system_shutdown - PM call to request a system shutdown or restart
>   * @type:	Shutdown or restart? 0 for shutdown, 1 for restart
>   * @subtype:	Specifies which system should be restarted or shut down
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 9d1a5c1..6557832 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -2,7 +2,7 @@
>  /*
>   * Xilinx Zynq MPSoC Firmware layer
>   *
> - *  Copyright (C) 2014-2019 Xilinx
> + *  Copyright (C) 2014-2021 Xilinx
>   *
>   *  Michal Simek <michal.simek@xilinx.com>
>   *  Davorin Mista <davorin.mista@aggios.com>
> @@ -62,6 +62,7 @@
>  
>  enum pm_api_id {
>  	PM_GET_API_VERSION = 1,
> +	PM_REGISTER_NOTIFIER = 5,
>  	PM_SYSTEM_SHUTDOWN = 12,
>  	PM_REQUEST_NODE = 13,
>  	PM_RELEASE_NODE = 14,
> @@ -411,6 +412,8 @@ int zynqmp_pm_pinctrl_get_config(const u32 pin, const u32 param,
>  				 u32 *value);
>  int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
>  				 u32 value);
> +int zynqmp_pm_register_notifier(const u32 node, const u32 event,
> +				const u32 wake, const u32 enable);
>  #else
>  static inline int zynqmp_pm_get_api_version(u32 *version)
>  {
> @@ -622,6 +625,12 @@ static inline int zynqmp_pm_pinctrl_set_config(const u32 pin, const u32 param,
>  {
>  	return -ENODEV;
>  }
> +
> +static inline int zynqmp_pm_register_notifier(const u32 node, const u32 event,
> +					      const u32 wake, const u32 enable)
> +{
> +	return -ENODEV;
> +}
>  #endif
>  
>  #endif /* __FIRMWARE_ZYNQMP_H__ */
> 

M
