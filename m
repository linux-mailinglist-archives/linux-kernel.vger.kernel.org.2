Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C68B43911C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 10:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhJYI0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 04:26:47 -0400
Received: from mail-sn1anam02on2083.outbound.protection.outlook.com ([40.107.96.83]:43310
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231986AbhJYI0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 04:26:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vs115aG/cx+O9enaF/vIUqlwLDyCPDLdtptZQDrgqp2Noz1bn9qjQEcMdQHNiFBJfx/xzc+u2EzVEwewqedfqkTKxTQ33w7oORJVR/cddRpkH3+IFrUBylrMBj7vTwXWcycSBsot19MeZUQdQ0st1QSWHj1Ho8I0DQl6rYgZjNvE4YOcg/rjoVeCjAc0dpS9muqc4qxa+ibO+IF7noDOCQh7db029IN+JSMV6Ankwx8xMlDTXBwvlGbtu9s8EU6dC6yfLSEk52F9FmLxEEW30mboDFSMoK9DWxRjs9IYSWJuPOrt5RYUSCcadwQWUVjpOoiQpKN7wElEpEw1atmyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLnv9WdyODy0fc1qtO0IWmkcDQtXA1z5uDpFHDKKJjY=;
 b=Cv2B3zaONOz8iX4WyRMPVa2AF4KgaJpKU4f64v1h8sykc3wMPFkGMQd8ZTvd0IXKR+JlHbVtu1xqy71CFpBXhLf4ewWPXf0AAqe58ZBSQxGHWUP2SxQsEcbITDVu0Ut2MD7/2XH5Bq9h1L3J31v9TgVmiGiwTUGiubVn4gwbHZkgZXH3vFODZeJR21wy5o/iRxube5qN+qTdPQ42tyLL+AxTz9ZU8RXhrdE5AmlYApogF+i8r8V9M0pviyJ//6anHT8DygEN6EWXpq9/6eJdJdv6VWucHFliSiik51oCe/N2Dmw/dAhqvvT2XCyg7gjW/4CaF6NVi8znrRPKMu01VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLnv9WdyODy0fc1qtO0IWmkcDQtXA1z5uDpFHDKKJjY=;
 b=Xewl1s3ZgZeuOUdZYn/OuBlYMSjq576zu7Em3ofsJTSfC2gZPuUIZodXat95L+/vebqpLiFMrzEUS/FuPRWoGRXfxj8DICmJl1VIV+t1+39W/lnht2p0eIKcgBxsalg7+WgHcCMRTO8zXd6J6PPalf0KcmyXj5etUUPglRkSd3w=
Received: from BN1PR13CA0011.namprd13.prod.outlook.com (2603:10b6:408:e2::16)
 by BY5PR02MB7027.namprd02.prod.outlook.com (2603:10b6:a03:23e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 08:24:10 +0000
Received: from BN1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::18) by BN1PR13CA0011.outlook.office365.com
 (2603:10b6:408:e2::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.11 via Frontend
 Transport; Mon, 25 Oct 2021 08:24:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT013.mail.protection.outlook.com (10.13.2.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 08:24:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 25 Oct 2021 01:24:01 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 25 Oct 2021 01:24:01 -0700
Envelope-to: gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.19.2.91] (port=37006 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <abhyuday.godhasara@xilinx.com>)
        id 1mevGz-0003vt-NG; Mon, 25 Oct 2021 01:24:01 -0700
From:   Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
To:     <gregkh@linuxfoundation.org>
CC:     <michal.simek@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <rajan.vaja@xilinx.com>, <manish.narani@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <wendy.liang@xilinx.com>, <jliang@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tejas Patel <tejas.patel@xilinx.com>
Subject: [PATCH v6 4/6] drivers: soc: xilinx: add xilinx event management driver
Date:   Mon, 25 Oct 2021 01:23:48 -0700
Message-ID: <20211025082350.10881-5-abhyuday.godhasara@xilinx.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a
In-Reply-To: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
References: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 572e9b67-2f9a-478c-bc1a-08d99790d1b1
X-MS-TrafficTypeDiagnostic: BY5PR02MB7027:
X-Microsoft-Antispam-PRVS: <BY5PR02MB7027709004A1B5EE878CDD3CA1839@BY5PR02MB7027.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:50;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J351REXchB3OZpoP0MPJGxt7h9e+hQjG/YhgGUqtf4yoT7HXu4zF+c03m7yynhGkg76iRK8jyLzr6rdUSrFnb0POTlwa/7YfL6U2Ub9hAE5Ea+ynvKYaobNGrIINB7KBgFo+Z/JmPNBYiF10b8nJ9IJR7HEFg2TQ9Mga/hbrEv69yPAPTWkF0tclMVsxGWuncO1ONyxAKfvVAbP5vkOCxnSLMYJafa7YLdFBcS21vumaW210C2nEeZQOe0mBvW6b9dF+x7r0TF8AbSKA52OtlSJhVwHp9QBSWBhlWZ4NXLpt0iFGcIWlTKoKOPDfmKzun89F5m47MelXgdzz9+OdzesDCN9UD5uBkVHCWBkIV1ojjO2/nEyiqvmWCj8XjiEWsy+2XciqMyOjbfeVRqhTXQmIEXwGfO7jcxqG4FLuiYKsKlSfuGCg1bIJPM2vlXEZ47PXKb5CQCPGBGnRRt+w5H8ZzkoPZrwPiiqtZUeM7JfWaqw661d6vpFzBa7H8qvcOc8zLvDoemmPeuW/sDNSdbSzlHCsH1L/O+zCdgTM+6ANevX6lhi73MBYLj8JHG9pOGNnChbTZW/fhlJ/jZYxDNf6/W7jmwuBU0V41Gi5SYlwPq/LL57G9EWOEl9kU7d+ZYt2wrToNTimiIvhfT58MX/BR68hmdfmwW+juuJXogyhletHnkFgg+WmflwEqgxJ/5aEhyrGiBRODtApVs0OGdZ8CAwpr3DJM3bvMycj+yesxZUdHxpfDQACl6e4LcdQF4J1RCZF7C0tNyvYGVzlPwxcMckoa2B7nJ6gSCR3BxR6HAWiFCp3NsuWi95ZnfIl
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(83380400001)(70206006)(107886003)(316002)(7696005)(36906005)(1076003)(356005)(82310400003)(8936002)(7636003)(4326008)(2906002)(54906003)(36860700001)(5660300002)(70586007)(26005)(6916009)(508600001)(47076005)(44832011)(8676002)(30864003)(36756003)(336012)(186003)(9786002)(6666004)(426003)(966005)(2616005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 08:24:09.7397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 572e9b67-2f9a-478c-bc1a-08d99790d1b1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7027
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
---
Changes in v6:
- None

Changes in v5:
- None

Changes in v4:
- None

Changes in v3:
- Update the commit message.
- Fix the debug print.

Changes in v2:
- make sgi_num as module parameter
- Add info print for SGI registration
---
 MAINTAINERS                                 |   6 +
 drivers/soc/xilinx/Kconfig                  |  10 +
 drivers/soc/xilinx/Makefile                 |   1 +
 drivers/soc/xilinx/xlnx_event_manager.c     | 600 ++++++++++++++++++++
 include/linux/firmware/xlnx-event-manager.h |  36 ++
 include/linux/firmware/xlnx-zynqmp.h        |   2 +
 6 files changed, 655 insertions(+)
 create mode 100644 drivers/soc/xilinx/xlnx_event_manager.c
 create mode 100644 include/linux/firmware/xlnx-event-manager.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c79388b78818..cd3571ff1abe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20635,6 +20635,12 @@ T:	git https://github.com/Xilinx/linux-xlnx.git
 F:	Documentation/devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml
 F:	drivers/phy/xilinx/phy-zynqmp.c
 
+XILINX EVENT MANAGEMENT DRIVER
+M:	Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
+S:	Maintained
+F:	drivers/soc/xilinx/xlnx_event_manager.c
+F:	include/linux/firmware/xlnx-event-manager.h
+
 XILLYBUS DRIVER
 M:	Eli Billauer <eli.billauer@gmail.com>
 L:	linux-kernel@vger.kernel.org
diff --git a/drivers/soc/xilinx/Kconfig b/drivers/soc/xilinx/Kconfig
index 53af9115dc31..8a755a5c8836 100644
--- a/drivers/soc/xilinx/Kconfig
+++ b/drivers/soc/xilinx/Kconfig
@@ -25,4 +25,14 @@ config ZYNQMP_PM_DOMAINS
 	  Say yes to enable device power management through PM domains
 	  If in doubt, say N.
 
+config XLNX_EVENT_MANAGER
+	bool "Enable Xilinx Event Management Driver"
+	depends on ZYNQMP_FIRMWARE
+	default ZYNQMP_FIRMWARE
+	help
+	  Say yes to enable event management support for Xilinx.
+	  This driver uses firmware driver as an interface for event/power
+	  management request to firmware.
+
+	  If in doubt, say N.
 endmenu
diff --git a/drivers/soc/xilinx/Makefile b/drivers/soc/xilinx/Makefile
index 9854e6f6086b..41e585bc9c67 100644
--- a/drivers/soc/xilinx/Makefile
+++ b/drivers/soc/xilinx/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_ZYNQMP_POWER)	+= zynqmp_power.o
 obj-$(CONFIG_ZYNQMP_PM_DOMAINS) += zynqmp_pm_domains.o
+obj-$(CONFIG_XLNX_EVENT_MANAGER)	+= xlnx_event_manager.o
diff --git a/drivers/soc/xilinx/xlnx_event_manager.c b/drivers/soc/xilinx/xlnx_event_manager.c
new file mode 100644
index 000000000000..b27f8853508e
--- /dev/null
+++ b/drivers/soc/xilinx/xlnx_event_manager.c
@@ -0,0 +1,600 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Event Management Driver
+ *
+ *  Copyright (C) 2021 Xilinx, Inc.
+ *
+ *  Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
+ */
+
+#include <linux/cpuhotplug.h>
+#include <linux/firmware/xlnx-event-manager.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/hashtable.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+static DEFINE_PER_CPU_READ_MOSTLY(int, cpu_number1);
+
+static int virq_sgi;
+static int event_manager_availability = -EACCES;
+
+/* SGI number used for Event management driver */
+#define XLNX_EVENT_SGI_NUM	(15)
+
+/* Max number of driver can register for same event */
+#define MAX_DRIVER_PER_EVENT	(10U)
+
+/* Max HashMap Order for PM API feature check (1<<7 = 128) */
+#define REGISTERED_DRIVER_MAX_ORDER	(7)
+
+#define MAX_BITS	(32U) /* Number of bits available for error mask */
+
+#define FIRMWARE_VERSION_MASK			(0xFFFFU)
+#define REGISTER_NOTIFIER_FIRMWARE_VERSION	(2U)
+
+static DEFINE_HASHTABLE(reg_driver_map, REGISTERED_DRIVER_MAX_ORDER);
+static int sgi_num = XLNX_EVENT_SGI_NUM;
+
+/**
+ * struct registered_event_data - Registered Event Data.
+ * @key:		key is the combine id(Node-Id | Event-Id) of type u64
+ *			where upper u32 for Node-Id and lower u32 for Event-Id,
+ *			And this used as key to index into hashmap.
+ * @agent_data:		Data passed back to handler function.
+ * @cb_type:		Type of Api callback, like PM_NOTIFY_CB, etc.
+ * @eve_cb:		Function pointer to store the callback function.
+ * @wake:		If this flag set, firmware will wakeup processor if is
+ *			in sleep or power down state.
+ * @hentry:		hlist_node that hooks this entry into hashtable.
+ */
+struct registered_event_data {
+	u64 key;
+	enum pm_api_cb_id cb_type;
+	void *agent_data;
+
+	event_cb_func_t eve_cb;
+	bool wake;
+	struct hlist_node hentry;
+};
+
+static bool xlnx_is_error_event(const u32 node_id)
+{
+	if (node_id == EVENT_ERROR_PMC_ERR1 ||
+	    node_id == EVENT_ERROR_PMC_ERR2 ||
+	    node_id == EVENT_ERROR_PSM_ERR1 ||
+	    node_id == EVENT_ERROR_PSM_ERR2)
+		return true;
+
+	return false;
+}
+
+static int xlnx_add_cb_for_notify_event(const u32 node_id, const u32 event, const bool wake,
+					event_cb_func_t cb_fun,	void *data)
+{
+	u64 key = 0;
+	struct registered_event_data *eve_data;
+
+	key = ((u64)node_id << 32U) | (u64)event;
+	/* Check for existing entry in hash table for given key id */
+	hash_for_each_possible(reg_driver_map, eve_data, hentry, key) {
+		if (eve_data->key == key) {
+			pr_err("Found as already registered\n");
+			return -EINVAL;
+		}
+	}
+
+	/* Add new entry if not present */
+	eve_data = kmalloc(sizeof(*eve_data), GFP_KERNEL);
+	if (!eve_data)
+		return -ENOMEM;
+
+	eve_data->key = key;
+	eve_data->cb_type = PM_NOTIFY_CB;
+	eve_data->eve_cb = cb_fun;
+	eve_data->wake = wake;
+	eve_data->agent_data = data;
+
+	hash_add(reg_driver_map, &eve_data->hentry, key);
+
+	return 0;
+}
+
+static int xlnx_add_cb_for_suspend(event_cb_func_t cb_fun, void *data)
+{
+	struct registered_event_data *eve_data;
+
+	/* Check for existing entry in hash table for given cb_type */
+	hash_for_each_possible(reg_driver_map, eve_data, hentry, PM_INIT_SUSPEND_CB) {
+		if (eve_data->cb_type == PM_INIT_SUSPEND_CB) {
+			pr_err("Found as already registered\n");
+			return -EINVAL;
+		}
+	}
+
+	/* Add new entry if not present */
+	eve_data = kmalloc(sizeof(*eve_data), GFP_KERNEL);
+	if (!eve_data)
+		return -ENOMEM;
+
+	eve_data->key = 0;
+	eve_data->cb_type = PM_INIT_SUSPEND_CB;
+	eve_data->eve_cb = cb_fun;
+	eve_data->agent_data = data;
+
+	hash_add(reg_driver_map, &eve_data->hentry, PM_INIT_SUSPEND_CB);
+
+	return 0;
+}
+
+static int xlnx_remove_cb_for_suspend(event_cb_func_t cb_fun)
+{
+	bool is_callback_found = false;
+	struct registered_event_data *eve_data;
+
+	/* Check for existing entry in hash table for given cb_type */
+	hash_for_each_possible(reg_driver_map, eve_data, hentry, PM_INIT_SUSPEND_CB) {
+		if (eve_data->cb_type == PM_INIT_SUSPEND_CB &&
+		    eve_data->eve_cb == cb_fun) {
+			is_callback_found = true;
+			/* remove an object from a hashtable */
+			hash_del(&eve_data->hentry);
+			kfree(eve_data);
+		}
+	}
+	if (!is_callback_found) {
+		pr_warn("Didn't find any registered callback for suspend event\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int xlnx_remove_cb_for_notify_event(const u32 node_id, const u32 event,
+					   event_cb_func_t cb_fun)
+{
+	bool is_callback_found = false;
+	struct registered_event_data *eve_data;
+	u64 key = ((u64)node_id << 32U) | (u64)event;
+
+	/* Check for existing entry in hash table for given key id */
+	hash_for_each_possible(reg_driver_map, eve_data, hentry, key) {
+		if (eve_data->key == key &&
+		    eve_data->eve_cb == cb_fun) {
+			is_callback_found = true;
+			/* remove an object from a hashtable */
+			hash_del(&eve_data->hentry);
+			kfree(eve_data);
+		}
+	}
+	if (!is_callback_found) {
+		pr_warn("Didn't find any registered callback for 0x%x 0x%x\n",
+			node_id, event);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * xlnx_register_event() - Register for the event.
+ * @cb_type:	Type of callback from pm_api_cb_id,
+ *			PM_NOTIFY_CB - for Error Events,
+ *			PM_INIT_SUSPEND_CB - for suspend callback.
+ * @node_id:	Node-Id related to event.
+ * @event:	Event Mask for the Error Event.
+ * @wake:	Flag specifying whether the subsystem should be woken upon
+ *		event notification.
+ * @cb_fun:	Function pointer to store the callback function.
+ * @data:	Pointer for the driver instance.
+ *
+ * Return:	Returns 0 on successful registration else error code.
+ */
+int xlnx_register_event(const enum pm_api_cb_id cb_type, const u32 node_id, const u32 event,
+			const bool wake, event_cb_func_t cb_fun, void *data)
+{
+	int ret = 0;
+	u32 eve;
+	int pos;
+
+	if (event_manager_availability)
+		return event_manager_availability;
+
+	if (cb_type != PM_NOTIFY_CB && cb_type != PM_INIT_SUSPEND_CB) {
+		pr_err("%s() Unsupported Callback 0x%x\n", __func__, cb_type);
+		return -EINVAL;
+	}
+
+	if (!cb_fun)
+		return -EFAULT;
+
+	if (cb_type == PM_INIT_SUSPEND_CB) {
+		ret = xlnx_add_cb_for_suspend(cb_fun, data);
+	} else {
+		if (!xlnx_is_error_event(node_id)) {
+			/* Add entry for Node-Id/Event in hash table */
+			ret = xlnx_add_cb_for_notify_event(node_id, event, wake, cb_fun, data);
+		} else {
+			/* Add into Hash table */
+			for (pos = 0; pos < MAX_BITS; pos++) {
+				eve = event & (1 << pos);
+				if (!eve)
+					continue;
+
+				/* Add entry for Node-Id/Eve in hash table */
+				ret = xlnx_add_cb_for_notify_event(node_id, eve, wake, cb_fun,
+								   data);
+				/* Break the loop if got error */
+				if (ret)
+					break;
+			}
+			if (ret) {
+				/* Skip the Event for which got the error */
+				pos--;
+				/* Remove registered(during this call) event from hash table */
+				for ( ; pos >= 0; pos--) {
+					eve = event & (1 << pos);
+					if (!eve)
+						continue;
+					xlnx_remove_cb_for_notify_event(node_id, eve, cb_fun);
+				}
+			}
+		}
+
+		if (ret) {
+			pr_err("%s() failed for 0x%x and 0x%x: %d\r\n", __func__, node_id,
+			       event, ret);
+			return ret;
+		}
+
+		/* Register for Node-Id/Event combination in firmware */
+		ret = zynqmp_pm_register_notifier(node_id, event, wake, true);
+		if (ret) {
+			pr_err("%s() failed for 0x%x and 0x%x: %d\r\n", __func__, node_id,
+			       event, ret);
+			/* Remove already registered event from hash table */
+			if (xlnx_is_error_event(node_id)) {
+				for (pos = 0; pos < MAX_BITS; pos++) {
+					eve = event & (1 << pos);
+					if (!eve)
+						continue;
+					xlnx_remove_cb_for_notify_event(node_id, eve, cb_fun);
+				}
+			} else {
+				xlnx_remove_cb_for_notify_event(node_id, event, cb_fun);
+			}
+			return ret;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xlnx_register_event);
+
+/**
+ * xlnx_unregister_event() - Unregister for the event.
+ * @cb_type:	Type of callback from pm_api_cb_id,
+ *			PM_NOTIFY_CB - for Error Events,
+ *			PM_INIT_SUSPEND_CB - for suspend callback.
+ * @node_id:	Node-Id related to event.
+ * @event:	Event Mask for the Error Event.
+ * @cb_fun:	Function pointer of callback function.
+ *
+ * Return:	Returns 0 on successful unregistration else error code.
+ */
+int xlnx_unregister_event(const enum pm_api_cb_id cb_type, const u32 node_id, const u32 event,
+			  event_cb_func_t cb_fun)
+{
+	int ret;
+	u32 eve, pos;
+
+	if (event_manager_availability)
+		return event_manager_availability;
+
+	if (cb_type != PM_NOTIFY_CB && cb_type != PM_INIT_SUSPEND_CB) {
+		pr_err("%s() Unsupported Callback 0x%x\n", __func__, cb_type);
+		return -EINVAL;
+	}
+
+	if (!cb_fun)
+		return -EFAULT;
+
+	if (cb_type == PM_INIT_SUSPEND_CB) {
+		ret = xlnx_remove_cb_for_suspend(cb_fun);
+	} else {
+		/* Remove Node-Id/Event from hash table */
+		if (!xlnx_is_error_event(node_id)) {
+			xlnx_remove_cb_for_notify_event(node_id, event, cb_fun);
+		} else {
+			for (pos = 0; pos < MAX_BITS; pos++) {
+				eve = event & (1 << pos);
+				if (!eve)
+					continue;
+
+				xlnx_remove_cb_for_notify_event(node_id, eve, cb_fun);
+			}
+		}
+
+		/* Un-register for Node-Id/Event combination */
+		ret = zynqmp_pm_register_notifier(node_id, event, false, false);
+		if (ret) {
+			pr_err("%s() failed for 0x%x and 0x%x: %d\n",
+			       __func__, node_id, event, ret);
+			return ret;
+		}
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xlnx_unregister_event);
+
+static void xlnx_call_suspend_cb_handler(const u32 *payload)
+{
+	bool is_callback_found = false;
+	struct registered_event_data *eve_data;
+	u32 cb_type = payload[0];
+
+	/* Check for existing entry in hash table for given cb_type */
+	hash_for_each_possible(reg_driver_map, eve_data, hentry, cb_type) {
+		if (eve_data->cb_type == cb_type) {
+			eve_data->eve_cb(&payload[0], eve_data->agent_data);
+			is_callback_found = true;
+		}
+	}
+	if (!is_callback_found)
+		pr_warn("Didn't find any registered callback for suspend event\n");
+}
+
+static void xlnx_call_notify_cb_handler(const u32 *payload)
+{
+	bool is_callback_found = false;
+	struct registered_event_data *eve_data;
+	u64 key = ((u64)payload[1] << 32U) | (u64)payload[2];
+	int ret;
+
+	/* Check for existing entry in hash table for given key id */
+	hash_for_each_possible(reg_driver_map, eve_data, hentry, key) {
+		if (eve_data->key == key) {
+			eve_data->eve_cb(&payload[0], eve_data->agent_data);
+			is_callback_found = true;
+
+			/* re register with firmware to get future events */
+			ret = zynqmp_pm_register_notifier(payload[1], payload[2],
+							  eve_data->wake, true);
+			if (ret) {
+				pr_err("%s() failed for 0x%x and 0x%x: %d\r\n", __func__,
+				       payload[1], payload[2], ret);
+				/* Remove already registered event from hash table */
+				xlnx_remove_cb_for_notify_event(payload[1], payload[2],
+								eve_data->eve_cb);
+			}
+		}
+	}
+	if (!is_callback_found)
+		pr_warn("Didn't find any registered callback for 0x%x 0x%x\n",
+			payload[1], payload[2]);
+}
+
+static void xlnx_get_event_callback_data(u32 *buf)
+{
+	zynqmp_pm_invoke_fn(GET_CALLBACK_DATA, 0, 0, 0, 0, buf);
+}
+
+static irqreturn_t xlnx_event_handler(int irq, void *dev_id)
+{
+	u32 cb_type, node_id, event, pos;
+	u32 payload[CB_MAX_PAYLOAD_SIZE] = {0};
+	u32 event_data[CB_MAX_PAYLOAD_SIZE] = {0};
+
+	/* Get event data */
+	xlnx_get_event_callback_data(payload);
+
+	/* First element is callback type, others are callback arguments */
+	cb_type = payload[0];
+
+	if (cb_type == PM_NOTIFY_CB) {
+		node_id = payload[1];
+		event = payload[2];
+		if (!xlnx_is_error_event(node_id)) {
+			xlnx_call_notify_cb_handler(payload);
+		} else {
+			/*
+			 * Each call back function expecting payload as an input arguments.
+			 * We can get multiple error events as in one call back through error
+			 * mask. So payload[2] may can contain multiple error events.
+			 * In reg_driver_map database we store data in the combination of single
+			 * node_id-error combination.
+			 * So coping the payload message into event_data and update the
+			 * event_data[2] with Error Mask for single error event and use
+			 * event_data as input argument for registered call back function.
+			 *
+			 */
+			memcpy(event_data, payload, (4 * CB_MAX_PAYLOAD_SIZE));
+			/* Support Multiple Error Event */
+			for (pos = 0; pos < MAX_BITS; pos++) {
+				if ((0 == (event & (1 << pos))))
+					continue;
+				event_data[2] = (event & (1 << pos));
+				xlnx_call_notify_cb_handler(event_data);
+			}
+		}
+	} else if (cb_type == PM_INIT_SUSPEND_CB) {
+		xlnx_call_suspend_cb_handler(payload);
+	} else {
+		pr_err("%s() Unsupported Callback %d\n", __func__, cb_type);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int xlnx_event_cpuhp_start(unsigned int cpu)
+{
+	enable_percpu_irq(virq_sgi, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int xlnx_event_cpuhp_down(unsigned int cpu)
+{
+	disable_percpu_irq(virq_sgi);
+
+	return 0;
+}
+
+static void xlnx_disable_percpu_irq(void *data)
+{
+	disable_percpu_irq(virq_sgi);
+}
+
+static int xlnx_event_init_sgi(struct platform_device *pdev)
+{
+	int ret = 0;
+	int cpu = smp_processor_id();
+	/*
+	 * IRQ related structures are used for the following:
+	 * for each SGI interrupt ensure its mapped by GIC IRQ domain
+	 * and that each corresponding linux IRQ for the HW IRQ has
+	 * a handler for when receiving an interrupt from the remote
+	 * processor.
+	 */
+	struct irq_domain *domain;
+	struct irq_fwspec sgi_fwspec;
+	struct device_node *interrupt_parent = NULL;
+	struct device *parent = pdev->dev.parent;
+
+	/* Find GIC controller to map SGIs. */
+	interrupt_parent = of_irq_find_parent(parent->of_node);
+	if (!interrupt_parent) {
+		dev_err(&pdev->dev, "Failed to find property for Interrupt parent\n");
+		return -EINVAL;
+	}
+
+	/* Each SGI needs to be associated with GIC's IRQ domain. */
+	domain = irq_find_host(interrupt_parent);
+	of_node_put(interrupt_parent);
+
+	/* Each mapping needs GIC domain when finding IRQ mapping. */
+	sgi_fwspec.fwnode = domain->fwnode;
+
+	/*
+	 * When irq domain looks at mapping each arg is as follows:
+	 * 3 args for: interrupt type (SGI), interrupt # (set later), type
+	 */
+	sgi_fwspec.param_count = 1;
+
+	/* Set SGI's hwirq */
+	sgi_fwspec.param[0] = sgi_num;
+	virq_sgi = irq_create_fwspec_mapping(&sgi_fwspec);
+
+	per_cpu(cpu_number1, cpu) = cpu;
+	ret = request_percpu_irq(virq_sgi, xlnx_event_handler, "xlnx_event_mgmt",
+				 &cpu_number1);
+	WARN_ON(ret);
+	if (ret) {
+		irq_dispose_mapping(virq_sgi);
+		return ret;
+	}
+
+	irq_to_desc(virq_sgi);
+	irq_set_status_flags(virq_sgi, IRQ_PER_CPU);
+
+	return ret;
+}
+
+static void xlnx_event_cleanup_sgi(struct platform_device *pdev)
+{
+	int cpu = smp_processor_id();
+
+	per_cpu(cpu_number1, cpu) = cpu;
+
+	cpuhp_remove_state(CPUHP_AP_ONLINE_DYN);
+
+	on_each_cpu(xlnx_disable_percpu_irq, NULL, 1);
+
+	irq_clear_status_flags(virq_sgi, IRQ_PER_CPU);
+	free_percpu_irq(virq_sgi, &cpu_number1);
+	irq_dispose_mapping(virq_sgi);
+}
+
+static int xlnx_event_manager_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = zynqmp_pm_feature(PM_REGISTER_NOTIFIER);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Feature check failed with %d\n", ret);
+		return ret;
+	}
+
+	if ((ret & FIRMWARE_VERSION_MASK) <
+	    REGISTER_NOTIFIER_FIRMWARE_VERSION) {
+		dev_err(&pdev->dev, "Register notifier version error. Expected Firmware: v%d - Found: v%d\n",
+			REGISTER_NOTIFIER_FIRMWARE_VERSION,
+			ret & FIRMWARE_VERSION_MASK);
+		return -EOPNOTSUPP;
+	}
+
+	/* Initialize the SGI */
+	ret = xlnx_event_init_sgi(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "SGI Init has been failed with %d\n", ret);
+		return ret;
+	}
+
+	/* Setup function for the CPU hot-plug cases */
+	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "soc/event:starting",
+			  xlnx_event_cpuhp_start, xlnx_event_cpuhp_down);
+
+	ret = zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_REGISTER_SGI, sgi_num,
+				  0, NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "SGI %d Registration over TF-A failed with %d\n", sgi_num, ret);
+		xlnx_event_cleanup_sgi(pdev);
+		return ret;
+	}
+
+	event_manager_availability = 0;
+
+	dev_info(&pdev->dev, "SGI %d Registered over TF-A\n", sgi_num);
+	dev_info(&pdev->dev, "Xilinx Event Management driver probed\n");
+
+	return ret;
+}
+
+static int xlnx_event_manager_remove(struct platform_device *pdev)
+{
+	int i;
+	struct registered_event_data *eve_data;
+	struct hlist_node *tmp;
+	int ret;
+
+	hash_for_each_safe(reg_driver_map, i, tmp, eve_data, hentry) {
+		hash_del(&eve_data->hentry);
+		kfree(eve_data);
+	}
+
+	ret = zynqmp_pm_invoke_fn(PM_IOCTL, 0, IOCTL_REGISTER_SGI, 0, 1, NULL);
+	if (ret)
+		dev_err(&pdev->dev, "SGI unregistration over TF-A failed with %d\n", ret);
+
+	xlnx_event_cleanup_sgi(pdev);
+
+	event_manager_availability = -EACCES;
+
+	return ret;
+}
+
+static struct platform_driver xlnx_event_manager_driver = {
+	.probe = xlnx_event_manager_probe,
+	.remove = xlnx_event_manager_remove,
+	.driver = {
+		.name = "xlnx_event_manager",
+	},
+};
+module_param(sgi_num, uint, 0);
+module_platform_driver(xlnx_event_manager_driver);
diff --git a/include/linux/firmware/xlnx-event-manager.h b/include/linux/firmware/xlnx-event-manager.h
new file mode 100644
index 000000000000..3f87c4929d21
--- /dev/null
+++ b/include/linux/firmware/xlnx-event-manager.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _FIRMWARE_XLNX_EVENT_MANAGER_H_
+#define _FIRMWARE_XLNX_EVENT_MANAGER_H_
+
+#include <linux/firmware/xlnx-zynqmp.h>
+
+#define CB_MAX_PAYLOAD_SIZE	(4U) /*In payload maximum 32bytes */
+
+/************************** Exported Function *****************************/
+
+typedef void (*event_cb_func_t)(const u32 *payload, void *data);
+
+#if IS_REACHABLE(CONFIG_XLNX_EVENT_MANAGER)
+int xlnx_register_event(const enum pm_api_cb_id cb_type, const u32 node_id,
+			const u32 event, const bool wake,
+			event_cb_func_t cb_fun, void *data);
+
+int xlnx_unregister_event(const enum pm_api_cb_id cb_type, const u32 node_id,
+			  const u32 event, event_cb_func_t cb_fun);
+#else
+static inline int xlnx_register_event(const enum pm_api_cb_id cb_type, const u32 node_id,
+				      const u32 event, const bool wake,
+				      event_cb_func_t cb_fun, void *data)
+{
+	return -ENODEV;
+}
+
+static inline int xlnx_unregister_event(const enum pm_api_cb_id cb_type, const u32 node_id,
+					 const u32 event, event_cb_func_t cb_fun)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif /* _FIRMWARE_XLNX_EVENT_MANAGER_H_ */
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 591bdbb4290e..ecc9d6ab1117 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -138,6 +138,8 @@ enum pm_ioctl_id {
 	IOCTL_READ_PGGS = 15,
 	/* Set healthy bit value */
 	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
+	/* Register SGI to ATF */
+	IOCTL_REGISTER_SGI = 25,
 };
 
 enum pm_query_id {
-- 
2.32.0.93.g670b81a

