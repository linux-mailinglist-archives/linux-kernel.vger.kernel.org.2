Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49AE63AE874
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 13:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFUL6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 07:58:11 -0400
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com ([40.107.237.59]:61793
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229576AbhFUL6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 07:58:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0F4QTVjsXP3vLpSVPb0w5IY4ONEpIDzBIEafCKljhLkxyTCVpGRQwkEI3DWDzV8jbzZuORjS7M6/O025UfRZBEsc1b1y0ScRH66mxtw5Nw7WhzRjFuCL6Q/sbvW4YkROy1ICrSCqBU6XSwk22CDWRGuNcMhwwnWTuQvrUTCzFgloNCZ4HS2yzMOMeE8P0UoJ0OMbphukmG9rEorGf+cKr96lmk0VgHJ8gP7RErYPSr6B3OovJYBsI1cLODDCuOfaa0PeszYjLN2VaXvOKGs21Muha+WY6lW2QQVKSr5qHgTAuzUuaIkJpFQP5uDR1XF9R7N635qbWN64tR6PPK7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q1QbPG0prefeGhPTTbszMwPtWFWv3otNfXw5Ocji0I=;
 b=anF9nWaSJ93p3I+91WNTFHdtmYhbjYR3F3pNc9wc/M5lPt1imJiaf+40lW9AEuMT/duWenm/5rEimejKTu/4Ta5hUTiYJtij6yYTU0R2uyIxH7KepNmQRiGfr28XdIXkOkJxDinbrs7dORSwPufIflRnQp13bVMq3+jF+UP78pXAl478ktNNiKtIDIb6GGxWeUJs2T81EfVDwdcE8IDjLcqywpCFI2HETMB+E+gsaGarClH11nQ/UqlF397pzhND12E9hmvwlsu+JpJeb+621HJ4iQAEdbOha+/JHmNSsVOf35iWdbS7Tkl/1DJJmZDSAGwdKtwQ9tKgVqCqr6PnJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q1QbPG0prefeGhPTTbszMwPtWFWv3otNfXw5Ocji0I=;
 b=M0WtPe8qVfirQu0rucIVMcI5zT0D92Ea2CQx14wXUzoLYEEjYKemHmJTYwOZv2zQGENPgb4Xr3JWWa7uk0nVUCITFrGFVCdq40eLeU6z0cCpqBK6RFpJsr/PRYL2ij3Q4WVYrypK2shjHSBQlRDhDyKHHqnMd8klRJ8iVg41ruU=
Received: from SN6PR05CA0036.namprd05.prod.outlook.com (2603:10b6:805:de::49)
 by BYAPR02MB4888.namprd02.prod.outlook.com (2603:10b6:a03:47::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Mon, 21 Jun
 2021 11:55:54 +0000
Received: from SN1NAM02FT0059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:de:cafe::f6) by SN6PR05CA0036.outlook.office365.com
 (2603:10b6:805:de::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.9 via Frontend
 Transport; Mon, 21 Jun 2021 11:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0059.mail.protection.outlook.com (10.97.5.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Mon, 21 Jun 2021 11:55:53 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 21 Jun 2021 04:55:48 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 21 Jun 2021 04:55:48 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 zou_wei@huawei.com
Received: from [172.30.17.109] (port=50380)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lvIWp-0007Fv-RY; Mon, 21 Jun 2021 04:55:48 -0700
Subject: Re: [PATCH 4/6] drivers: soc: xilinx: add xilinx event management
 driver
To:     Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>,
        <michal.simek@xilinx.com>
CC:     <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <amit.sunil.dhamne@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tejas Patel <tejas.patel@xilinx.com>
References: <1622217566-1856-1-git-send-email-abhyuday.godhasara@xilinx.com>
 <1622217566-1856-5-git-send-email-abhyuday.godhasara@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <14ce59d6-957c-f252-2a67-632d4c4648a9@xilinx.com>
Date:   Mon, 21 Jun 2021 13:55:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1622217566-1856-5-git-send-email-abhyuday.godhasara@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6edb0bd2-8864-4e9a-0798-08d934ab85e0
X-MS-TrafficTypeDiagnostic: BYAPR02MB4888:
X-Microsoft-Antispam-PRVS: <BYAPR02MB488896FBCBFE6F290CDCB556C60A9@BYAPR02MB4888.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ERl1xUiJrpwUVOYqgAZXcgYmveSqnWHS3SMXKNnMyxHJMWCbBF3fzJgnRvWWlSCmmPqSXI+Zh8Xg0kAgK9Efy9Rj7rjnTrlsqAqG0qCSgElSsWtAKUxrVrGJFYIwS6kfn9N6f6vmRDGZcNmBEOcMKogDEpuN4tUga4cjYNSprWoIyua4ThgWS3RB7ZSex1dvceOQv1uIF79ERnvYHNj902KTZOmOK/RH902+LDpMrdXHLps2RwClHifUnMwEkSOlHEhYCO9Xt8w/vG/4ytah6HJcFQCmBmxNXqJQfjOLumdIi42ptOZl6SV62W6O0SaGblP4GqTBMyYR+xhfpj6EwNIp7jXymT7B7OBYqext0pdkzPRwnGDc9g4Q+YDPn6k/W1/OHflmn3hjT2uIzspCQN4bK2cr/Itkq3lejDezXDK5Gt0l/6kFMpIwro7Besk/xNEw2dfXzJT6H61RwfpLMl3LPYf5/Ww117280JtfLEia0Lymh4GGYFHmQxK4/tEOa5IB8VlYy/eoCXOCTozkOWuBUaA0/+V3bkjZliDxIZsLnSRGktl2YCp1DSYtqG+t80xdMXW0qE8YvTbtowsfyafewElwFRv84AZiuZQl0M16qVZL8AWqfJW6wLw1yOb9cDsSaohip0E8XdVsoErOGat0y50P5CpiirmypxmuYRQ8zI+fJX+0QThYLNDUTdxf+IaRtNmjlXrAvL0mPwyya/2Vc6Fun1771yKHvWXvIZPqiDdyNeyWAM2XzMBvIcIF+5D+s17yyLk2X47PX7+wW75z1RHKZR5dZGFbla/SpAlV5DAmPABFCHM8guXC6SdTFGw2Q2C+W+WpMh4ETq4i3A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39850400004)(36840700001)(46966006)(107886003)(54906003)(82310400003)(110136005)(36906005)(9786002)(6666004)(356005)(316002)(30864003)(186003)(70206006)(70586007)(8936002)(36860700001)(7636003)(26005)(47076005)(83380400001)(53546011)(36756003)(478600001)(426003)(336012)(5660300002)(44832011)(4326008)(31696002)(31686004)(82740400003)(2906002)(2616005)(966005)(8676002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 11:55:53.8939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6edb0bd2-8864-4e9a-0798-08d934ab85e0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0059.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4888
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/21 5:59 PM, Abhyuday Godhasara wrote:
> Xilinx event management driver provide an interface to subscribe
> or unsubscribe for the event/callback supported by firmware. Agent can use
> this driver to register for Error Event, Device Event and Suspend callback.
> This driver only allow one agent per event to do registration. Driver will
> return an error in case of multiple registration for the same event.
> 
> This driver gets notification from firmware through ATF as SGI. During
> initialization, event manager driver register handler for SGI used for
> notification. It also provide SGI number info to ATF by using
> IOCTL_REGISTER_SGI call to ATF.
> 
> After receiving notification from firmware, driver makes SMC call to ATF
> to get IPI data. From the IPI data provided by ATF, event manager
> identified cause of event and forward that event/callback notification to
> respective subscribed driver. After this, in case of Error Event, driver
> performs unregistration as firmware expecting from agent to do
> re-registration if agent wants to get notified on second occurrence of
> error event.
> 
> Add new IOCTL id IOCTL_REGISTER_SGI = 25 which use to register SGI on ATF.

nit: Instead of ATF you should use TF-A

> 
> Older firmware doesn't have all required support for event handling
> which is required by event manager driver. So add check for register
> notifier version in event manager driver.
> 
> Xilinx event management driver provide support to subscribe for multiple
> error events with the use of Event Mask in single call of
> xlnx_register_event(). Agent driver can provide 'Event' parameter value as
> ORed of multiple event masks to register single callback for multiple
> events. For example, to register callback for event=0x1 and event=0x2 for
> the given node, agent can provide event=0x3 (0x1 | 0x2). It is not
> possible to register multiple event for different nodes in single
> registration call.
> 
> Also provide support to receive multiple error events as in single
> notification from firmware and then forward it to subscribed drivers via
> registered callback one by one.
> 
> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> ---
>  MAINTAINERS                                 |   6 +
>  drivers/soc/xilinx/Kconfig                  |  10 +
>  drivers/soc/xilinx/Makefile                 |   1 +
>  drivers/soc/xilinx/xlnx_event_manager.c     | 598 ++++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-event-manager.h |  36 ++
>  include/linux/firmware/xlnx-zynqmp.h        |   2 +
>  6 files changed, 653 insertions(+)
>  create mode 100644 drivers/soc/xilinx/xlnx_event_manager.c
>  create mode 100644 include/linux/firmware/xlnx-event-manager.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a2384e..6299069 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20096,6 +20096,12 @@ T:	git https://github.com/Xilinx/linux-xlnx.git
>  F:	Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
>  F:	drivers/phy/xilinx/phy-zynqmp.c
>  
> +XILINX EVENT MANAGEMENT DRIVER
> +M:	Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> +S:	Maintained
> +F:	drivers/soc/xilinx/xlnx_event_manager.c
> +F:	include/linux/firmware/xlnx-event-manager.h
> +
>  XILLYBUS DRIVER
>  M:	Eli Billauer <eli.billauer@gmail.com>
>  L:	linux-kernel@vger.kernel.org
> diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
> index 53af911..8a755a5 100644
> --- a/drivers/soc/xilinx/Kconfig
> +++ b/drivers/soc/xilinx/Kconfig
> @@ -25,4 +25,14 @@ config ZYNQMP_PM_DOMAINS
>  	  Say yes to enable device power management through PM domains
>  	  If in doubt, say N.
>  
> +config XLNX_EVENT_MANAGER
> +	bool "Enable Xilinx Event Management Driver"
> +	depends on ZYNQMP_FIRMWARE
> +	default ZYNQMP_FIRMWARE
> +	help
> +	  Say yes to enable event management support for Xilinx.
> +	  This driver uses firmware driver as an interface for event/power
> +	  management request to firmware.
> +
> +	  If in doubt, say N.
>  endmenu
> diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
> index 9854e6f..41e585b 100644
> --- a/drivers/soc/xilinx/Makefile
> +++ b/drivers/soc/xilinx/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_ZYNQMP_POWER)	+= zynqmp_power.o
>  obj-$(CONFIG_ZYNQMP_PM_DOMAINS) += zynqmp_pm_domains.o
> +obj-$(CONFIG_XLNX_EVENT_MANAGER)	+= xlnx_event_manager.o
> diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
> new file mode 100644
> index 0000000..bf726ee
> --- /dev/null
> +++ b/drivers/soc/xilinx/xlnx_event_manager.c
> @@ -0,0 +1,598 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Event Management Driver
> + *
> + *  Copyright (C) 2021 Xilinx, Inc.
> + *
> + *  Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> + */
> +
> +#include <linux/cpuhotplug.h>
> +#include <linux/firmware/xlnx-event-manager.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/hashtable.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +static DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number1);
> +
> +static int virq_sgi;
> +static int event_manager_availability = -EACCES;
> +
> +/* SGI number used for Event management driver */
> +#define XLNX_EVENT_SGI_NUM	(15)
> +
> +/* Max number of driver can register for same event */
> +#define MAX_DRIVER_PER_EVENT	(10U)
> +
> +/* Max HashMap Order for PM API feature check (1<<7 = 128) */
> +#define REGISTERED_DRIVER_MAX_ORDER	(7)
> +
> +#define MAX_BITS	(32U) /* Number of bits available for error mask */
> +
> +#define FIRMWARE_VERSION_MASK			(0xFFFFU)
> +#define REGISTER_NOTIFIER_FIRMWARE_VERSION	(2U)
> +
> +static DEFINE_HASHTABLE(reg_driver_map, REGISTERED_DRIVER_MAX_ORDER);
> +static int sgi_num = XLNX_EVENT_SGI_NUM;

make this module parameter with default on XLNX_EVENT_SGI_NUM.

> +
> +/**
> + * struct registered_event_data - Registered Event Data.
> + * @key:		key is the combine id(Node-Id | Event-Id) of type u64
> + *			where upper u32 for Node-Id and lower u32 for Event-Id,
> + *			And this used as key to index into hashmap.
> + * @agent_data:		Data passed back to handler function.
> + * @cb_type:		Type of Api callback, like PM_NOTIFY_CB, etc.
> + * @eve_cb:		Function pointer to store the callback function.
> + * @wake:		If this flag set, firmware will wakeup processor if is
> + *			in sleep or power down state.
> + * @hentry:		hlist_node that hooks this entry into hashtable.
> + */
> +struct registered_event_data {
> +	u64 key;
> +	enum pm_api_cb_id cb_type;
> +	void *agent_data;
> +
> +	event_cb_func_t eve_cb;
> +	bool wake;
> +	struct hlist_node hentry;
> +};
> +
> +static bool xlnx_is_error_event(const u32 node_id)
> +{
> +	if (node_id == EVENT_ERROR_PMC_ERR1 ||
> +	    node_id == EVENT_ERROR_PMC_ERR2 ||
> +	    node_id == EVENT_ERROR_PSM_ERR1 ||
> +	    node_id == EVENT_ERROR_PSM_ERR2)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int xlnx_add_cb_for_notify_event(const u32 node_id, const u32 event, const bool wake,
> +					event_cb_func_t cb_fun,	void *data)
> +{
> +	u64 key = 0;
> +	struct registered_event_data *eve_data;
> +
> +	key = ((u64)node_id << 32U) | (u64)event;
> +	/* Check for existing entry in hash table for given key id */
> +	hash_for_each_possible(reg_driver_map, eve_data, hentry, key) {
> +		if (eve_data->key == key) {

Don't you need to check eve_data here too?

> +			pr_err("Found as already registered\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* Add new entry if not present */
> +	eve_data = kmalloc(sizeof(*eve_data), GFP_KERNEL);
> +	if (!eve_data)
> +		return -ENOMEM;
> +
> +	eve_data->key = key;
> +	eve_data->cb_type = PM_NOTIFY_CB;
> +	eve_data->eve_cb = cb_fun;
> +	eve_data->wake = wake;
> +	eve_data->agent_data = data;
> +
> +	hash_add(reg_driver_map, &eve_data->hentry, key);
> +
> +	return 0;
> +}
> +
> +static int xlnx_add_cb_for_suspend(event_cb_func_t cb_fun, void *data)
> +{
> +	struct registered_event_data *eve_data;
> +
> +	/* Check for existing entry in hash table for given cb_type */
> +	hash_for_each_possible(reg_driver_map, eve_data, hentry, PM_INIT_SUSPEND_CB) {
> +		if (eve_data->cb_type == PM_INIT_SUSPEND_CB) {

Same as above to make sure that eve_data is not NULL.
The same is also below.

> +			pr_err("Found as already registered\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* Add new entry if not present */
> +	eve_data = kmalloc(sizeof(*eve_data), GFP_KERNEL);
> +	if (!eve_data)
> +		return -ENOMEM;
> +
> +	eve_data->key = 0;
> +	eve_data->cb_type = PM_INIT_SUSPEND_CB;
> +	eve_data->eve_cb = cb_fun;
> +	eve_data->agent_data = data;
> +
> +	hash_add(reg_driver_map, &eve_data->hentry, PM_INIT_SUSPEND_CB);
> +
> +	return 0;
> +}
> +
> +static int xlnx_remove_cb_for_suspend(event_cb_func_t cb_fun)
> +{
> +	bool is_callback_found = false;
> +	struct registered_event_data *eve_data;
> +
> +	/* Check for existing entry in hash table for given cb_type */
> +	hash_for_each_possible(reg_driver_map, eve_data, hentry, PM_INIT_SUSPEND_CB) {
> +		if (eve_data->cb_type == PM_INIT_SUSPEND_CB &&
> +		    eve_data->eve_cb == cb_fun) {
> +			is_callback_found = true;
> +			/* remove an object from a hashtable */
> +			hash_del(&eve_data->hentry);
> +			kfree(eve_data);
> +		}
> +	}
> +	if (!is_callback_found) {
> +		pr_warn("Didn't find any registered callback for suspend event\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int xlnx_remove_cb_for_notify_event(const u32 node_id, const u32 event,
> +					   event_cb_func_t cb_fun)
> +{
> +	bool is_callback_found = false;
> +	struct registered_event_data *eve_data;
> +	u64 key = ((u64)node_id << 32U) | (u64)event;
> +
> +	/* Check for existing entry in hash table for given key id */
> +	hash_for_each_possible(reg_driver_map, eve_data, hentry, key) {
> +		if (eve_data->key == key &&
> +		    eve_data->eve_cb == cb_fun) {
> +			is_callback_found = true;
> +			/* remove an object from a hashtable */
> +			hash_del(&eve_data->hentry);
> +			kfree(eve_data);
> +		}
> +	}
> +	if (!is_callback_found) {
> +		pr_warn("Didn't find any registered callback for 0x%x 0x%x\n",
> +			node_id, event);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * xlnx_register_event() - Register for the event.
> + * @cb_type:	Type of callback from pm_api_cb_id,
> + *			PM_NOTIFY_CB - for Error Events,
> + *			PM_INIT_SUSPEND_CB - for suspend callback.
> + * @node_id:	Node-Id related to event.
> + * @event:	Event Mask for the Error Event.
> + * @wake:	Flag specifying whether the subsystem should be woken upon
> + *		event notification.
> + * @cb_fun:	Function pointer to store the callback function.
> + * @data:	Pointer for the driver instance.
> + *
> + * Return:	Returns 0 on successful registration else error code.
> + */
> +int xlnx_register_event(const enum pm_api_cb_id cb_type, const u32 node_id, const u32 event,
> +			const bool wake, event_cb_func_t cb_fun, void *data)
> +{
> +	int ret = 0;
> +	u32 eve;
> +	int pos;
> +
> +	if (event_manager_availability)
> +		return event_manager_availability;
> +
> +	if (cb_type != PM_NOTIFY_CB && cb_type != PM_INIT_SUSPEND_CB) {
> +		pr_err("%s() Unsupported Callback 0x%x\n", __func__, cb_type);
> +		return -EINVAL;
> +	}
> +
> +	if (!cb_fun)
> +		return -EFAULT;
> +
> +	if (cb_type == PM_INIT_SUSPEND_CB) {
> +		ret = xlnx_add_cb_for_suspend(cb_fun, data);
> +	} else {
> +		if (!xlnx_is_error_event(node_id)) {
> +			/* Add entry for Node-Id/Event in hash table */
> +			ret = xlnx_add_cb_for_notify_event(node_id, event, wake, cb_fun, data);
> +		} else {
> +			/* Add into Hash table */
> +			for (pos = 0; pos < MAX_BITS; pos++) {
> +				eve = event & (1 << pos);
> +				if (!eve)
> +					continue;
> +
> +				/* Add entry for Node-Id/Eve in hash table */
> +				ret = xlnx_add_cb_for_notify_event(node_id, eve, wake, cb_fun,
> +								   data);
> +				/* Break the loop if got error */
> +				if (ret)
> +					break;
> +			}
> +			if (ret) {
> +				/* Skip the Event for which got the error */
> +				pos--;
> +				/* Remove registered(during this call) event from hash table */
> +				for ( ; pos >= 0; pos--) {
> +					eve = event & (1 << pos);
> +					if (!eve)
> +						continue;
> +					xlnx_remove_cb_for_notify_event(node_id, eve, cb_fun);
> +				}
> +			}
> +		}
> +
> +		if (ret) {
> +			pr_err("%s() failed for 0x%x and 0x%x: %d\r\n", __func__, node_id,
> +			       event, ret);
> +			return ret;
> +		}
> +
> +		/* Register for Node-Id/Event combination in firmware */
> +		ret = zynqmp_pm_register_notifier(node_id, event, wake, true);
> +		if (ret) {
> +			pr_err("%s() failed for 0x%x and 0x%x: %d\r\n", __func__, node_id,
> +			       event, ret);
> +			/* Remove already registered event from hash table */
> +			if (xlnx_is_error_event(node_id)) {
> +				for (pos = 0; pos < MAX_BITS; pos++) {
> +					eve = event & (1 << pos);
> +					if (!eve)
> +						continue;
> +					xlnx_remove_cb_for_notify_event(node_id, eve, cb_fun);
> +				}
> +			} else {
> +				xlnx_remove_cb_for_notify_event(node_id, event, cb_fun);
> +			}
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xlnx_register_event);
> +
> +/**
> + * xlnx_unregister_event() - Unregister for the event.
> + * @cb_type:	Type of callback from pm_api_cb_id,
> + *			PM_NOTIFY_CB - for Error Events,
> + *			PM_INIT_SUSPEND_CB - for suspend callback.
> + * @node_id:	Node-Id related to event.
> + * @event:	Event Mask for the Error Event.
> + * @cb_fun:	Function pointer of callback function.
> + *
> + * Return:	Returns 0 on successful unregistration else error code.
> + */
> +int xlnx_unregister_event(const enum pm_api_cb_id cb_type, const u32 node_id, const u32 event,
> +			  event_cb_func_t cb_fun)
> +{
> +	int ret;
> +	u32 eve, pos;
> +
> +	if (event_manager_availability)
> +		return event_manager_availability;
> +
> +	if (cb_type != PM_NOTIFY_CB && cb_type != PM_INIT_SUSPEND_CB) {
> +		pr_err("%s() Unsupported Callback 0x%x\n", __func__, cb_type);
> +		return -EINVAL;
> +	}
> +
> +	if (!cb_fun)
> +		return -EFAULT;
> +
> +	if (cb_type == PM_INIT_SUSPEND_CB) {
> +		ret = xlnx_remove_cb_for_suspend(cb_fun);
> +	} else {
> +		/* Remove Node-Id/Event from hash table */
> +		if (!xlnx_is_error_event(node_id)) {
> +			xlnx_remove_cb_for_notify_event(node_id, event, cb_fun);
> +		} else {
> +			for (pos = 0; pos < MAX_BITS; pos++) {
> +				eve = event & (1 << pos);
> +				if (!eve)
> +					continue;
> +
> +				xlnx_remove_cb_for_notify_event(node_id, eve, cb_fun);
> +			}
> +		}
> +
> +		/* Un-register for Node-Id/Event combination */
> +		ret = zynqmp_pm_register_notifier(node_id, event, false, false);
> +		if (ret) {
> +			pr_err("%s() failed for 0x%x and 0x%x: %d\n",
> +			       __func__, node_id, event, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(xlnx_unregister_event);
> +
> +static void xlnx_call_suspend_cb_handler(const u32 *payload)
> +{
> +	bool is_callback_found = false;
> +	struct registered_event_data *eve_data;
> +	u32 cb_type = payload[0];
> +
> +	/* Check for existing entry in hash table for given cb_type */
> +	hash_for_each_possible(reg_driver_map, eve_data, hentry, cb_type) {
> +		if (eve_data->cb_type == cb_type) {
> +			eve_data->eve_cb(&payload[0], eve_data->agent_data);
> +			is_callback_found = true;
> +		}
> +	}
> +	if (!is_callback_found)
> +		pr_warn("Didn't find any registered callback for suspend event\n");
> +}
> +
> +static void xlnx_call_notify_cb_handler(const u32 *payload)
> +{
> +	bool is_callback_found = false;
> +	struct registered_event_data *eve_data;
> +	u64 key = ((u64)payload[1] << 32U) | (u64)payload[2];
> +	int ret;
> +
> +	/* Check for existing entry in hash table for given key id */
> +	hash_for_each_possible(reg_driver_map, eve_data, hentry, key) {
> +		if (eve_data->key == key) {
> +			eve_data->eve_cb(&payload[0], eve_data->agent_data);
> +			is_callback_found = true;
> +
> +			/* re register with firmware to get future events */
> +			ret = zynqmp_pm_register_notifier(payload[1], payload[2],
> +							  eve_data->wake, true);
> +			if (ret) {
> +				pr_err("%s() failed for 0x%x and 0x%x: %d\r\n", __func__,
> +				       payload[1], payload[2], ret);
> +				/* Remove already registered event from hash table */
> +				xlnx_remove_cb_for_notify_event(payload[1], payload[2],
> +								eve_data->eve_cb);
> +			}
> +		}
> +	}
> +	if (!is_callback_found)
> +		pr_warn("Didn't find any registered callback for 0x%x 0x%x\n",
> +			payload[1], payload[2]);
> +}
> +
> +static void xlnx_get_event_callback_data(u32 *buf)
> +{
> +	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
> +}
> +
> +static irqreturn_t xlnx_event_handler(int irq, void *dev_id)
> +{
> +	u32 cb_type, node_id, event, pos;
> +	u32 payload[CB_MAX_PAYLOAD_SIZE] = {0};
> +	u32 event_data[CB_MAX_PAYLOAD_SIZE] = {0};
> +
> +	/* Get event data */
> +	xlnx_get_event_callback_data(payload);
> +
> +	/* First element is callback type, others are callback arguments */
> +	cb_type = payload[0];
> +
> +	if (cb_type == PM_NOTIFY_CB) {
> +		node_id = payload[1];
> +		event = payload[2];
> +		if (!xlnx_is_error_event(node_id)) {
> +			xlnx_call_notify_cb_handler(payload);
> +		} else {
> +			/*
> +			 * Each call back function expecting payload as an input arguments.
> +			 * We can get multiple error events as in one call back through error
> +			 * mask. So payload[2] may can contain multiple error events.
> +			 * In reg_driver_map database we store data in the combination of single
> +			 * node_id-error combination.
> +			 * So coping the payload message into event_data and update the
> +			 * event_data[2] with Error Mask for single error event and use
> +			 * event_data as input argument for registered call back function.
> +			 *
> +			 */
> +			memcpy(event_data, payload, (4 * CB_MAX_PAYLOAD_SIZE));
> +			/* Support Multiple Error Event */
> +			for (pos = 0; pos < MAX_BITS; pos++) {
> +				if ((0 == (event & (1 << pos))))
> +					continue;
> +				event_data[2] = (event & (1 << pos));
> +				xlnx_call_notify_cb_handler(event_data);
> +			}
> +		}
> +	} else if (cb_type == PM_INIT_SUSPEND_CB) {
> +		xlnx_call_suspend_cb_handler(payload);
> +	} else {
> +		pr_err("%s() Unsupported Callback %d\n", __func__, cb_type);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int xlnx_event_cpuhp_start(unsigned int cpu)
> +{
> +	enable_percpu_irq(virq_sgi, IRQ_TYPE_NONE);
> +
> +	return 0;
> +}
> +
> +static int xlnx_event_cpuhp_down(unsigned int cpu)
> +{
> +	disable_percpu_irq(virq_sgi);
> +
> +	return 0;
> +}
> +
> +static void xlnx_disable_percpu_irq(void *data)
> +{
> +	disable_percpu_irq(virq_sgi);
> +}
> +
> +static int xlnx_event_init_sgi(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	int cpu = smp_processor_id();
> +	/*
> +	 * IRQ related structures are used for the following:
> +	 * for each SGI interrupt ensure its mapped by GIC IRQ domain
> +	 * and that each corresponding linux IRQ for the HW IRQ has
> +	 * a handler for when receiving an interrupt from the remote
> +	 * processor.
> +	 */
> +	struct irq_domain *domain;
> +	struct irq_fwspec sgi_fwspec;
> +	struct device_node *interrupt_parent = NULL;
> +	struct device *parent = pdev->dev.parent;
> +
> +	/* Find GIC controller to map SGIs. */
> +	interrupt_parent = of_irq_find_parent(parent->of_node);
> +	if (!interrupt_parent) {
> +		dev_err(&pdev->dev, "Failed to find property for Interrupt parent\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Each SGI needs to be associated with GIC's IRQ domain. */
> +	domain = irq_find_host(interrupt_parent);
> +	of_node_put(interrupt_parent);
> +
> +	/* Each mapping needs GIC domain when finding IRQ mapping. */
> +	sgi_fwspec.fwnode = domain->fwnode;
> +
> +	/*
> +	 * When irq domain looks at mapping each arg is as follows:
> +	 * 3 args for: interrupt type (SGI), interrupt # (set later), type
> +	 */
> +	sgi_fwspec.param_count = 1;
> +
> +	/* Set SGI's hwirq */
> +	sgi_fwspec.param[0] = sgi_num;
> +	virq_sgi = irq_create_fwspec_mapping(&sgi_fwspec);
> +
> +	per_cpu(cpu_number1, cpu) = cpu;
> +	ret = request_percpu_irq(virq_sgi, xlnx_event_handler, "xlnx_event_mgmt",
> +				 &cpu_number1);
> +	WARN_ON(ret);
> +	if (ret) {
> +		irq_dispose_mapping(virq_sgi);
> +		return ret;
> +	}
> +
> +	irq_to_desc(virq_sgi);
> +	irq_set_status_flags(virq_sgi, IRQ_PER_CPU);
> +
> +	return ret;
> +}
> +
> +static void xlnx_event_cleanup_sgi(struct platform_device *pdev)
> +{
> +	int cpu = smp_processor_id();
> +
> +	per_cpu(cpu_number1, cpu) = cpu;
> +
> +	cpuhp_remove_state(CPUHP_AP_ONLINE_DYN);
> +
> +	on_each_cpu(xlnx_disable_percpu_irq, NULL, 1);
> +
> +	irq_clear_status_flags(virq_sgi, IRQ_PER_CPU);
> +	free_percpu_irq(virq_sgi, &cpu_number1);
> +	irq_dispose_mapping(virq_sgi);
> +}
> +
> +static int xlnx_event_manager_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = zynqmp_pm_feature(PM_REGISTER_NOTIFIER);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Feature check failed with %d\n", ret);
> +		return ret;
> +	}
> +
> +	if ((ret & FIRMWARE_VERSION_MASK) <
> +	    REGISTER_NOTIFIER_FIRMWARE_VERSION) {
> +		dev_err(&pdev->dev, "Register notifier version error. Expected Firmware: v%d - Found: v%d\n",
> +			REGISTER_NOTIFIER_FIRMWARE_VERSION,
> +			ret & FIRMWARE_VERSION_MASK);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/* Initialize the SGI */
> +	ret = xlnx_event_init_sgi(pdev);
> +	if (ret) {
> +		dev_err(&pdev->dev, "SGI Init has been failed with %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Setup function for the CPU hot-plug cases */
> +	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "soc/event:starting",
> +			  xlnx_event_cpuhp_start, xlnx_event_cpuhp_down);
> +
> +	ret = zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_REGISTER_SGI, sgi_num,
> +				  0, NULL);
> +	if (ret) {
> +		dev_err(&pdev->dev, "SGI Registration over ATF failed with %d\n", ret);
> +		xlnx_event_cleanup_sgi(pdev);
> +		return ret;
> +	}
> +
> +	event_manager_availability = 0;
> +
> +	dev_info(&pdev->dev, "Xilinx Event Management driver probed\n");
> +
> +	return ret;
> +}
> +
> +static int xlnx_event_manager_remove(struct platform_device *pdev)
> +{
> +	int i;
> +	struct registered_event_data *eve_data;
> +	struct hlist_node *tmp;
> +	int ret;
> +
> +	hash_for_each_safe(reg_driver_map, i, tmp, eve_data, hentry) {
> +		hash_del(&eve_data->hentry);
> +		kfree(eve_data);
> +	}
> +
> +	ret = zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_REGISTER_SGI, 0, 1, NULL);
> +	if (ret)
> +		dev_err(&pdev->dev, "SGI unregistration over ATF failed with %d\n", ret);
> +
> +	xlnx_event_cleanup_sgi(pdev);
> +
> +	event_manager_availability = -EACCES;
> +
> +	return ret;
> +}
> +
> +static struct platform_driver xlnx_event_manager_driver = {
> +	.probe = xlnx_event_manager_probe,
> +	.remove = xlnx_event_manager_remove,
> +	.driver = {
> +		.name = "xlnx_event_manager",
> +	},
> +};
> +module_platform_driver(xlnx_event_manager_driver);
> diff --git a/include/linux/firmware/xlnx-event-manager.h b/include/linux/firmware/xlnx-event-manager.h
> new file mode 100644
> index 0000000..09758ab
> --- /dev/null
> +++ b/include/linux/firmware/xlnx-event-manager.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _FIRMWARE_XLNX_EVENT_MANAGER_H_
> +#define _FIRMWARE_XLNX_EVENT_MANAGER_H_
> +
> +#include <linux/firmware/xlnx-zynqmp.h>
> +
> +#define CB_MAX_PAYLOAD_SIZE	(4U) /*In payload maximum 32bytes */
> +
> +/************************** Exported Function *****************************/
> +
> +typedef void (*event_cb_func_t)(const u32 *payload, void *data);
> +
> +#if IS_REACHABLE(CONFIG_XLNX_EVENT_MANAGER)
> +int xlnx_register_event(const enum pm_api_cb_id cb_type, const u32 node_id,
> +			const u32 event, const bool wake,
> +			event_cb_func_t cb_fun, void *data);
> +
> +int xlnx_unregister_event(const enum pm_api_cb_id cb_type, const u32 node_id,
> +			  const u32 event, event_cb_func_t cb_fun);
> +#else
> +static inline int xlnx_register_event(const enum pm_api_cb_id cb_type, const u32 node_id,
> +				      const u32 event, const bool wake,
> +				      event_cb_func_t cb_fun, void *data)
> +{
> +	return -ENODEV;
> +}
> +
> +istatic inline int xlnx_unregister_event(const enum pm_api_cb_id cb_type, const u32 node_id,
> +					 const u32 event, event_cb_func_t cb_fun)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
> +#endif /* _FIRMWARE_XLNX_EVENT_MANAGER_H_ */
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 06ea5a4..f3e857c 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -133,6 +133,8 @@ enum pm_ioctl_id {
>  	IOCTL_READ_PGGS = 15,
>  	/* Set healthy bit value */
>  	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
> +	/* Register SGI to ATF */
> +	IOCTL_REGISTER_SGI = 25,
>  };
>  
>  enum pm_query_id {
> 

The rest looks good to me. Please push interface to TFA first to make
sure that API won't change.

Thanks,
Michal

