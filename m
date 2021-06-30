Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44B73B8184
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 13:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbhF3L7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 07:59:16 -0400
Received: from mail-co1nam11on2071.outbound.protection.outlook.com ([40.107.220.71]:51041
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234148AbhF3L7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 07:59:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOboL6C+6tkZuNeWqG7lzUtzcKlVMIgv0JNT39vanxR5TFJ1Itb0V2EA1Px2oKqcCv8v5o/DD7+TZPMDSV86kuLg/9xOfjwEc82VzreXUWWJuhIdW2gJaaSSytKsmBLcUvkyQrOgUweCjjDdnhzaqlzG+fI0dc9bYR9Kzjvah8ZsJnbShs0q4aIUvV3+RP1wjNEEzLqoRRXrk3zUcLR9wOpAKgBJkFo4N01Q026T6q0ltF1Caabg5jrIxORGXm3Z+BDr+XJu4MQdNR2lsc4QHFQiz2WKYmO56QxvPfo/I84Gdg6BhgKIQgjjd4bU2B0HzmAaDiAcBUF1jmO0QAB1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZvEtTJk47Jnj50h1qDmvZqvxkZaLfiG+pcSUTlevxc=;
 b=L4Rfjdoqkky8b5oukeA3YGivk0emm4dBIsEJQAc3tp4uxd5YDoZPfb/S9I2LgseVfTdSP1wiqYxXKy1iTIX3c+UrXj7/IviOwmG63HZkKNA1QAAeysu3eZ/MCGpC32cw66kc3X+AlywrZbXBMTSEi7DUNG+YsD4lYYf45et8170VOQ6OLgofviY1wu55zeSkls9Giawo6p81UnWmeeMapAdwlQzOCuPXf4WNVDrcuUxqQIQ8+1qdCP5KA9PRpgTh141VQczQyrM748IAd/N3qXeGOAcSv8WjTXIwX7qsOL7tLmidxscUDs/9KM0dwQ5b/Z61Wd8V591nf6mW0HD0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZvEtTJk47Jnj50h1qDmvZqvxkZaLfiG+pcSUTlevxc=;
 b=SsSv7VdBBvsLp6VgXb9LwvckRggJuFwGtJ9V/fJIwtowlIJYz2KOPW13d6f9spsdBwaXUb4ATDa60CjPFfqUOuTJlDmrwZo0rUKdmKRW9w4Fmg/J0heuFyPCEije0r5v0l0hrtDd9wbyeX7z3osnba/WrdGW+gvmw1IZpxH0AQI=
Received: from BN6PR12CA0025.namprd12.prod.outlook.com (2603:10b6:405:70::11)
 by SA0PR02MB7434.namprd02.prod.outlook.com (2603:10b6:806:e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 30 Jun
 2021 11:56:44 +0000
Received: from BN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:70:cafe::21) by BN6PR12CA0025.outlook.office365.com
 (2603:10b6:405:70::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Wed, 30 Jun 2021 11:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT019.mail.protection.outlook.com (10.13.3.187) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 11:56:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 04:56:42 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 30 Jun 2021 04:56:42 -0700
Envelope-to: linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 zou_wei@huawei.com
Received: from [172.30.17.109] (port=56172)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lyYpe-0006KE-19; Wed, 30 Jun 2021 04:56:42 -0700
Subject: Re: [PATCH v2 4/6] drivers: soc: xilinx: add xilinx event management
 driver
To:     Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>,
        <michal.simek@xilinx.com>
CC:     <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <amit.sunil.dhamne@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jliang@xilinx.com>,
        Tejas Patel <tejas.patel@xilinx.com>
References: <20210625134937.10349-1-abhyuday.godhasara@xilinx.com>
 <20210625134937.10349-5-abhyuday.godhasara@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <48c6a215-4ce4-5c57-3e87-ccc63082f035@xilinx.com>
Date:   Wed, 30 Jun 2021 13:56:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625134937.10349-5-abhyuday.godhasara@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbc6d525-a3fa-4273-f01c-08d93bbe21bf
X-MS-TrafficTypeDiagnostic: SA0PR02MB7434:
X-Microsoft-Antispam-PRVS: <SA0PR02MB7434F71FAA11E1D993E25EF8C6019@SA0PR02MB7434.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:291;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D6H5sRkUBn/xdcARu+qKEvRqVDiLgDuYl1zyp4rVfLnaIyDUa6HVIcAPT9pm6vl+nfNYgD9QRtR/zpTnDwDn5OsV9+Bjk/tuDi0KWtqMucfOFrVesNOkyT1YlT2MFn8/HPCfWauJR1lyCPmuxldXz26P1G+XWJi2M/gJwYQd3uQBZcgnAlvhsFxlMCfkwlsxyawVJFGcAuzHRBajahxaSCAlZlsC2gq57vGsDPJMAEL4or4UEGzOPX16QqMSY7/H72fU6HdD3BJdMKHVoomLnSdPAMDyA3w+as9ORclZaYb2CYfXFpXeKqMOpvl7RGXGDwVhkcCmwhflE1CKLLT2blViUfnruZibM1Bac/2VR4l+sC+pqFyH9qeX2SeTB8MtRlqNJUKGP4/BGrAWsU+jv0WtQq84L3yEmpcQqp6YDeSw6rYxqXP+HoGOIIYPzYyLwfBs3aVs9n6qnmXxhYNiTw5CGFDpHlxhj8106T2fyHvQX3wjrw6FjQks/NVUAs5sGvUw17j/R5Sy21dsM9rafhk6Z/NNVMvKH+a9RL76kXnLS682ERWjF78uelZs7WNqk54s3ZEhMzvntkaw3VIrqlAEh+PVZ1fIemSpRbHNx4msvoZ9wWRgaR7Zhwv3Np2OTvhtNg9v6v4DnYQDbeOpmjbd9KXAHJWQNRbTEkGH1o2mfW2p4B8bUX5gYVbZn6IKV/Gv4RWCmzhXV2KWX2Qrd+1brbdClMnZUEynxohxXCjSDzh9oPyiK9Axqo7mFaIOR1RIStYjadgJleQxixaSht+tk0dpaxeYL3vBSRlNuA4ub4M1j3b6zeXskhoMu6Z6m13h1wIiQfdDByAncnVv8ICLvex/eSO+ZrmHMyg8jri/FRY7DNfeiZN8xbvmARll
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(39850400004)(396003)(376002)(36840700001)(46966006)(107886003)(8936002)(26005)(5660300002)(36756003)(186003)(8676002)(2616005)(30864003)(44832011)(4326008)(9786002)(336012)(426003)(70206006)(54906003)(70586007)(6666004)(53546011)(316002)(36906005)(110136005)(356005)(83380400001)(82310400003)(36860700001)(31686004)(7636003)(31696002)(478600001)(966005)(82740400003)(2906002)(47076005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 11:56:44.4118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc6d525-a3fa-4273-f01c-08d93bbe21bf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7434
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/25/21 3:49 PM, Abhyuday Godhasara wrote:
> Xilinx event management driver provide an interface to subscribe
> or unsubscribe for the event/callback supported by firmware. Agent can use
> this driver to register for Error Event, Device Event and Suspend callback.
> This driver only allow one agent per event to do registration. Driver will
> return an error in case of multiple registration for the same event.
> 
> This driver gets notification from firmware through TF-A as SGI. During
> initialization, event manager driver register handler for SGI used for
> notification. It also provide SGI number info to TF-A by using
> IOCTL_REGISTER_SGI call to TF-A.
> 
> After receiving notification from firmware, driver makes SMC call to TF-A
> to get IPI data. From the IPI data provided by TF-A, event manager
> identified cause of event and forward that event/callback notification to
> respective subscribed driver. After this, in case of Error Event, driver
> performs unregistration as firmware expecting from agent to do
> re-registration if agent wants to get notified on second occurrence of
> error event.
> 
> Add new IOCTL id IOCTL_REGISTER_SGI = 25 which use to register SGI on TF-A.
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

I have added this to google and there are missing some articles and
missing s in plurals. This is the output.

Xilinx event management driver provides an interface to subscribe or
unsubscribe for the event/callback supported by firmware. An agent can use
this driver to register for Error Event, Device Event and Suspend callback.
This driver only allows one agent per event to do registration. Driver will
return an error in case of multiple registration for the same event.

This driver gets notification from firmware through TF-A as SGI. During
initialization, event manager driver register handler for SGI used for
notification. It also provides SGI number info to TF-A by using
IOCTL_REGISTER_SGI call to TF-A.

After receiving notification from firmware, the driver makes an SMC call to
TF-A to get IPI data. From the IPI data provided by TF-A, event manager
identified the cause of event and forward that event/callback notification
to the respective subscribed driver. After this, in case of Error Event,
driver performs unregistration as firmware expecting from agent to do
re-registration if the agent wants to get notified on the second occurrence
of an error event.

Add new IOCTL id IOCTL_REGISTER_SGI = 25 which is used to register SGI on
TF-A.

Older firmware doesn't have all required support for event handling which
is required by the event manager driver. So add check for the register
notifier version in the event manager driver.

Xilinx event management driver provides support to subscribe for multiple
error events with the use of Event Mask in a single call of
xlnx_register_event(). Agent driver can provide 'Event' parameter value as
ORed of multiple event masks to register single callback for multiple
events. For example, to register callback for event=0x1 and event=0x2 for
the given node, agent can provide event=0x3 (0x1 | 0x2). It is not possible
to register multiple events for different nodes in a single registration
call.

Also provide support to receive multiple error events as in single
notification from firmware and then forward it to subscribed drivers via
registered callback one by one.



> Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
> ---
> Changes in v2:
> - make sgi_num as module parameter
> - Add info print for SGI registration
> ---
>  MAINTAINERS                                 |   6 +
>  drivers/soc/xilinx/Kconfig                  |  10 +
>  drivers/soc/xilinx/Makefile                 |   1 +
>  drivers/soc/xilinx/xlnx_event_manager.c     | 601 ++++++++++++++++++++
>  include/linux/firmware/xlnx-event-manager.h |  36 ++
>  include/linux/firmware/xlnx-zynqmp.h        |   2 +
>  6 files changed, 656 insertions(+)
>  create mode 100644 drivers/soc/xilinx/xlnx_event_manager.c
>  create mode 100644 include/linux/firmware/xlnx-event-manager.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c5ee008301a..a3e4d8dfe104 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20108,6 +20108,12 @@ T:	git https://github.com/Xilinx/linux-xlnx.git
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
> index 53af9115dc31..8a755a5c8836 100644
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
> index 9854e6f6086b..41e585bc9c67 100644
> --- a/drivers/soc/xilinx/Makefile
> +++ b/drivers/soc/xilinx/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_ZYNQMP_POWER)	+= zynqmp_power.o
>  obj-$(CONFIG_ZYNQMP_PM_DOMAINS) += zynqmp_pm_domains.o
> +obj-$(CONFIG_XLNX_EVENT_MANAGER)	+= xlnx_event_manager.o
> diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
> new file mode 100644
> index 000000000000..e61b69235a01
> --- /dev/null
> +++ b/drivers/soc/xilinx/xlnx_event_manager.c
> @@ -0,0 +1,601 @@
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
> +		dev_err(&pdev->dev, "SGI %d Registration over TF-A failed with %d\n", sgi_num, ret);
> +		xlnx_event_cleanup_sgi(pdev);
> +		return ret;
> +	} else {
> +		dev_info(&pdev->dev, "SGI %d Registered over TF-A\n");


./scripts/checkpatch.pl --strict
0001-drivers-soc-xilinx-add-xilinx-event-management-drive.patch
WARNING: else is not generally useful after a break or return
#671: FILE: drivers/soc/xilinx/xlnx_event_manager.c:559:
+		return ret;
+	} else {

drivers/soc/xilinx/xlnx_event_manager.c: In function
'xlnx_event_manager_probe':
drivers/soc/xilinx/xlnx_event_manager.c:560:24: warning: format '%d'
expects a matching 'int' argument [-Wformat=]
  560 |   dev_info(&pdev->dev, "SGI %d Registered over TF-A\n");
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/dev_printk.h:19:22: note: in definition of macro 'dev_fmt'
   19 | #define dev_fmt(fmt) fmt
      |                      ^~~
drivers/soc/xilinx/xlnx_event_manager.c:560:3: note: in expansion of
macro 'dev_info'
  560 |   dev_info(&pdev->dev, "SGI %d Registered over TF-A\n");
      |   ^~~~~~~~
drivers/soc/xilinx/xlnx_event_manager.c:560:30: note: format string is
defined here
  560 |   dev_info(&pdev->dev, "SGI %d Registered over TF-A\n");



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
> +		dev_err(&pdev->dev, "SGI unregistration over TF-A failed with %d\n", ret);
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
> +module_param(sgi_num, uint, 0);
> +module_platform_driver(xlnx_event_manager_driver);
> diff --git a/include/linux/firmware/xlnx-event-manager.h b/include/linux/firmware/xlnx-event-manager.h
> new file mode 100644
> index 000000000000..09758abd6b49
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
> index 6ba1bf21e8b3..b536b46a3820 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -134,6 +134,8 @@ enum pm_ioctl_id {
>  	IOCTL_READ_PGGS = 15,
>  	/* Set healthy bit value */
>  	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
> +	/* Register SGI to ATF */
> +	IOCTL_REGISTER_SGI = 25,
>  };
>  
>  enum pm_query_id {
> 

Thanks,
Michal

