Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D9E3B8185
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 13:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhF3L7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 07:59:33 -0400
Received: from mail-bn8nam11on2042.outbound.protection.outlook.com ([40.107.236.42]:3681
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234148AbhF3L7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 07:59:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AE0EJ6Kfrmb51cQb2as/7+enIRa0IOdyNofSAo4u9S/dhY85WaEBDcEpYQDkQ/EMCYkyL9TlFxjXkcV5EJcOjFSpDTyhS46Xh/Lc6QZY9aUwAA0T4dBSjB2huLVq0475konjBthR7JLoVFZ0amBbmuhAldKzDuMwcUyuQhvmptx8QNJ8NJUZrDN17qzgnTvrf1JBc4k7PwAlV5yApvfbbfZbHOVIFiXgZPUbECOX53ekJZanZ/iAx4KK3MTo1IZhAjqux9Vy+rtnaFKrS/EvKPEWQje6ghxKNF/5pQYxLJNfrSWAPi2+8oVyLfN9nj+LuVcptPhjac6Mdkh5vc2MNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSsLIjH5tm/W/cqoHeiUh0CHWiFM4f6I8Cx/+CLVzz4=;
 b=L16CnihTogetn0z2Cp05vQg3s93VD4Uh0tXmc3yPTVWwjdfvCQQjNIkvvCyZu8Qkhav17MJJlDy5x/gHh6UDebDqv0MWoqltrqtiwK3d9da/17JqSy0EM29H5iu2a9uxEWki/oY2qmHsGCci0ax/Uf2d8cQqj6+MA/2Vo4arAgFQECkyImCbMXW8O68xnI9f2uy0lHVg3Zv06PAeFjYHRyzF/YyB5bHMwoLVgOr5pn2qzQ76GpxAYHzpcyNIDKGPkXv9tbfCnft0F30768GRDV4MNqCi2Y3STZtt7HCspR0kJVXxqoTcuVB+N238EE32WfW5nmXq/wrel4QxEd6sdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSsLIjH5tm/W/cqoHeiUh0CHWiFM4f6I8Cx/+CLVzz4=;
 b=tFoBfTNDUyuhLSi5YLy8ta4qcght0rGoJGogTV7nopwXRew3wDBzhBrD9drCi6jZ00F6H6gE9WjLbXEFhHsJgiwGTjHeK9UWzX7IFHfVQkSPz5I5dkTkUkNCCd2cJ34wqVvpv7lUgVMnrCYyyZmaLzR12fppc4BwaNd09noT75Y=
Received: from BN6PR16CA0008.namprd16.prod.outlook.com (2603:10b6:404:f5::18)
 by DM8PR02MB8039.namprd02.prod.outlook.com (2603:10b6:8:18::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 30 Jun
 2021 11:57:01 +0000
Received: from BN1NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::e4) by BN6PR16CA0008.outlook.office365.com
 (2603:10b6:404:f5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend
 Transport; Wed, 30 Jun 2021 11:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT021.mail.protection.outlook.com (10.13.2.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 11:57:00 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 04:56:59 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 30 Jun 2021 04:56:59 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 zou_wei@huawei.com
Received: from [172.30.17.109] (port=56196)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lyYpv-0006Lm-7w; Wed, 30 Jun 2021 04:56:59 -0700
Subject: Re: [PATCH v2 1/6] firmware: xilinx: add register notifier in zynqmp
 firmware
To:     Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>,
        <michal.simek@xilinx.com>
CC:     <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <amit.sunil.dhamne@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jliang@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>
References: <20210625134937.10349-1-abhyuday.godhasara@xilinx.com>
 <20210625134937.10349-2-abhyuday.godhasara@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <46fe9000-8136-224e-de53-4ac9d53199d4@xilinx.com>
Date:   Wed, 30 Jun 2021 13:56:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625134937.10349-2-abhyuday.godhasara@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a673abfe-27cb-4d0f-feec-08d93bbe2b98
X-MS-TrafficTypeDiagnostic: DM8PR02MB8039:
X-Microsoft-Antispam-PRVS: <DM8PR02MB8039C9C9E4DFC09C584AB711C6019@DM8PR02MB8039.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pt8sI7SWbcuPNwda3kBk/yOjqGY47cnNOryfxhxFZiq+sh9zYyy8ssUYENgjqEEFM9E3DMpwFVwPuE/kWr5iHzzB32fY9JvH+xcF8xUfMUFZyYL+HIdt3GLL4z79Y+fgVuLYHI7zppROUR8PHG65yypr3uf7XwedZgDe0k8c91+jYCPHhrojvbHxlKdOyEVJJXCS5uAvQoAL1XbYFRVTzrhjBaYWtLbUxh/w39fvulmgnLOy2B/CNxpwWzp0ze5u7bi/SfilriKIf7SYKx9zFgup/4oP6l7ap7Iyr2MMoJa9L3KK4pgpZIvncn+GwGWWdYQTqzzMcsW5L/yEA2bZJt2CoABrXjZ96KNlP5cAco9TI7t55GQ3ka5DIDev9OWcJXE5Y7CL1WmyV51QtbgIvndSJOlI4JDMr6Upz8tkmm7UcZttOHM7PftdRjjCXvdlyD0aQpSBIP5Ft98RgcIScgNywQhbu7pIM2X1GP5wRofO66ItrRG0Syn2078Ud1kgTa2BlMHpKXhUmIHNA1hyfcaJMRYECUPMUvfQV0ICiJ7MyLUrBZok5uJaRuYoGGlWUEhIXSSx+Z5Y2XbQGGVoI4MQnJq1RbF7kczpA44A4oNj7zF7zvFOZj+pnpiwscjcp7i5e6Re2D2cLFaODiXLvY5NLK56r5PzXsQcips3uNgjDXTewFXOrTefB+yYnUwjxln8dwJv3QevLRi7Xe7KCZS07a6kY9LoxoSof29k7a/jGj7UW3+aq4sllfKuU05r1a0mrddDOl6YCdZo04HFlQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(376002)(136003)(36840700001)(46966006)(9786002)(8676002)(6666004)(82740400003)(8936002)(5660300002)(7636003)(356005)(31686004)(44832011)(2616005)(2906002)(70206006)(70586007)(336012)(426003)(478600001)(4326008)(31696002)(36756003)(110136005)(54906003)(47076005)(186003)(26005)(82310400003)(53546011)(316002)(36860700001)(36906005)(83380400001)(107886003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 11:57:00.9258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a673abfe-27cb-4d0f-feec-08d93bbe2b98
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/25/21 3:49 PM, Abhyuday Godhasara wrote:
> In zynqmp-firmware, register notifier is not supported, add support of
> register notifier in zynqmp-firmware.
> 
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> ---
> Changes in v2:
> - Removed updated copyright year from unchanged files.
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 23 +++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 11 ++++++++++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 15b138326ecc..33f190e257b1 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -1036,6 +1036,29 @@ int zynqmp_pm_aes_engine(const u64 address, u32 *out)
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_aes_engine);
>  
> +/**
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
>  /**
>   * zynqmp_pm_system_shutdown - PM call to request a system shutdown or restart
>   * @type:	Shutdown or restart? 0 for shutdown, 1 for restart
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 9d1a5c175065..655783259415 100644
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

Acked-by: Michal Simek <michal.simek@xilinx.com>

M
