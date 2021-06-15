Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C763A7AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhFOJh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:37:29 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6506 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhFOJhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:37:17 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G434c2nQQzZhT6;
        Tue, 15 Jun 2021 17:32:16 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 17:35:11 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 15 Jun 2021 17:35:10 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <alexander.shishkin@linux.intel.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <jonathan.zhouwen@huawei.com>,
        <f.fangjian@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <coresight@lists.linaro.org>,
        <linuxarm@huawei.com>, <liuqi115@huawei.com>
Subject: [RFC PATCH 2/4] ultrasoc: add ultrasoc core layer framework
Date:   Tue, 15 Jun 2021 17:34:42 +0800
Message-ID: <1623749684-65432-3-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1623749684-65432-1-git-send-email-liuqi115@huawei.com>
References: <1623749684-65432-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a platform driver for the top device of Ultrasoc
SubSystem. It also provides a framework to manage Ultrasoc communictors,
and a set of standard attributes of communicators to access the service
data and to configure the communictor drivers.
Once a Ultrasoc Communictor driver register itself into the framework,
these attributes will be added into communicator devices.

Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 MAINTAINERS                           |   7 +
 drivers/Makefile                      |   1 +
 drivers/hwtracing/Kconfig             |   2 +
 drivers/hwtracing/ultrasoc/Kconfig    |  16 ++
 drivers/hwtracing/ultrasoc/Makefile   |   7 +
 drivers/hwtracing/ultrasoc/ultrasoc.c | 518 ++++++++++++++++++++++++++++++++++
 drivers/hwtracing/ultrasoc/ultrasoc.h | 168 +++++++++++
 7 files changed, 719 insertions(+)
 create mode 100644 drivers/hwtracing/ultrasoc/Kconfig
 create mode 100644 drivers/hwtracing/ultrasoc/Makefile
 create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc.c
 create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 88c2c4d..d799f6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8324,6 +8324,13 @@ S:	Maintained
 F:	drivers/misc/hisi_hikey_usb.c
 F:	Documentation/devicetree/bindings/misc/hisilicon-hikey-usb.yaml
 
+SIEMENS EMBEDDED ANALYTICS DRIVER
+M:	Jonathan Zhou <Jonathan.zhouwen@huawei.com>
+M:	Qi Liu <liuqi115@huawei.com>
+S:	Supported
+F:	Documentation/trace/ultrasoc-trace.rst
+F:	drivers/hwtracing/ultrasoc/
+
 HISILICON PMU DRIVER
 M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
 S:	Supported
diff --git a/drivers/Makefile b/drivers/Makefile
index 5a6d613..4c132a7 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -176,6 +176,7 @@ obj-$(CONFIG_PERF_EVENTS)	+= perf/
 obj-$(CONFIG_RAS)		+= ras/
 obj-$(CONFIG_USB4)		+= thunderbolt/
 obj-$(CONFIG_CORESIGHT)		+= hwtracing/coresight/
+obj-y				+= hwtracing/ultrasoc/
 obj-y				+= hwtracing/intel_th/
 obj-$(CONFIG_STM)		+= hwtracing/stm/
 obj-$(CONFIG_ANDROID)		+= android/
diff --git a/drivers/hwtracing/Kconfig b/drivers/hwtracing/Kconfig
index 1308583..3829030 100644
--- a/drivers/hwtracing/Kconfig
+++ b/drivers/hwtracing/Kconfig
@@ -5,4 +5,6 @@ source "drivers/hwtracing/stm/Kconfig"
 
 source "drivers/hwtracing/intel_th/Kconfig"
 
+source "drivers/hwtracing/ultrasoc/Kconfig"
+
 endmenu
diff --git a/drivers/hwtracing/ultrasoc/Kconfig b/drivers/hwtracing/ultrasoc/Kconfig
new file mode 100644
index 0000000..90a3934
--- /dev/null
+++ b/drivers/hwtracing/ultrasoc/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: MIT
+#
+# ultrasoc configuration
+#
+
+menuconfig ULTRASOC
+	tristate "Ultrasoc Tracing Support"
+	select CORESIGHT
+	help
+	  This framework provides a kernel interface for the Ultrasoc trace
+	  drivers to register themselves with. It's intended to build
+	  a topological view of the Ultrasoc components based on ACPI
+	  specification and configure the right series of components when a
+	  trace source gets enabled.
+
+endif
diff --git a/drivers/hwtracing/ultrasoc/Makefile b/drivers/hwtracing/ultrasoc/Makefile
new file mode 100644
index 0000000..a747171
--- /dev/null
+++ b/drivers/hwtracing/ultrasoc/Makefile
@@ -0,0 +1,7 @@
+# # SPDX-License-Identifier: MIT
+#
+# Makefile for ultrasoc drivers.
+#
+
+obj-$(CONFIG_ULTRASOC) += ultrasoc-drv.o
+ultrasoc-drv-objs := ultrasoc.o
diff --git a/drivers/hwtracing/ultrasoc/ultrasoc.c b/drivers/hwtracing/ultrasoc/ultrasoc.c
new file mode 100644
index 0000000..191c3ec
--- /dev/null
+++ b/drivers/hwtracing/ultrasoc/ultrasoc.c
@@ -0,0 +1,518 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright (C) 2021 Hisilicon Limited Permission is hereby granted, free of
+ * charge, to any person obtaining a copy of this software and associated
+ * documentation files (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modify,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Software,
+ * and to permit persons to whom the Software is furnished to do so, subject
+ * to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ *
+ * Code herein communicates with and accesses proprietary hardware which is
+ * licensed intellectual property (IP) belonging to Siemens Digital Industries
+ * Software Ltd.
+ *
+ * Siemens Digital Industries Software Ltd. asserts and reserves all rights to
+ * their intellectual property. This paragraph may not be removed or modified
+ * in any way without permission from Siemens Digital Industries Software Ltd.
+ */
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+
+#include "ultrasoc.h"
+
+static ssize_t com_mux_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t size)
+{
+	struct ultrasoc_drv_data *drvdata = dev_get_drvdata(dev);
+	long val;
+	int ret;
+
+	ret = kstrtol(buf, 0, &val);
+	if (ret)
+		return -EINVAL;
+
+	writel(val & 0xffffffff, drvdata->com_mux);
+	return size;
+}
+
+static ssize_t com_mux_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	struct ultrasoc_drv_data *drvdata = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "0x%x\n", readl(drvdata->com_mux));
+}
+static DEVICE_ATTR_RW(com_mux);
+
+static umode_t ultrasoc_com_mux_is_visible(struct kobject *kobj,
+					   struct attribute *attr, int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct ultrasoc_drv_data *drvdata = dev_get_drvdata(dev);
+
+	if (IS_ERR(drvdata->com_mux))
+		return 0;
+
+	return attr->mode;
+}
+
+static struct attribute *ultrasoc_com_mux_attr[] = {
+	&dev_attr_com_mux.attr,
+	NULL,
+};
+
+static const struct attribute_group ultrasoc_com_mux_group = {
+	.attrs = ultrasoc_com_mux_attr,
+	.is_visible = ultrasoc_com_mux_is_visible,
+};
+
+static const struct attribute_group *ultrasoc_global_groups[] = {
+	&ultrasoc_com_mux_group,
+	NULL,
+};
+
+static int ultrasoc_probe(struct platform_device *pdev)
+{
+	struct ultrasoc_drv_data *drvdata;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+	drvdata->dev = &pdev->dev;
+	INIT_LIST_HEAD(&drvdata->ultrasoc_com_head);
+
+	drvdata->com_mux = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(drvdata->com_mux)) {
+		dev_err(&pdev->dev, "Failed to ioremap for com_mux resource.\n");
+		return PTR_ERR(drvdata->com_mux);
+	}
+	/* switch ultrasoc commucator mux for on-chip drivers. */
+	writel(US_SELECT_ONCHIP, drvdata->com_mux);
+	platform_set_drvdata(pdev, drvdata);
+
+	return 0;
+}
+
+static int ultrasoc_remove(struct platform_device *pdev)
+{
+	struct ultrasoc_drv_data *pdata = platform_get_drvdata(pdev);
+
+	/* switch back to external debuger users if necessary.*/
+	if (!IS_ERR(pdata->com_mux))
+		writel(0, pdata->com_mux);
+
+	return 0;
+}
+
+static struct acpi_device_id ultrasoc_acpi_match[] = {
+	{"HISI0391", },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, ultrasoc_acpi_match);
+
+static struct platform_driver ultrasoc_driver = {
+	.driver = {
+		.name = "ultrasoc",
+		.acpi_match_table = ultrasoc_acpi_match,
+		.dev_groups = ultrasoc_global_groups,
+	},
+	.probe = ultrasoc_probe,
+	.remove = ultrasoc_remove,
+};
+module_platform_driver(ultrasoc_driver);
+
+static const char * const ultrasoc_com_type_string[] = {
+	"UNKNOWN",
+	"UP-DOWN-BOTH",
+	"DOWN-ONLY",
+};
+
+static const char * const ultrasoc_com_service_status_string[] = {
+	"stopped",
+	"sleeping",
+	"running normal",
+};
+
+/*
+ * To avoid communicator buffer overflow, we create a service thread
+ * to do the communicator work. This is the service thread entry.
+ */
+static int ultrasoc_com_service(void *arg)
+{
+	unsigned int deep_sleep = 0;
+	struct ultrasoc_com *com;
+	int ud_flag = 0;
+	int core;
+
+	core = smp_processor_id();
+	com = (struct ultrasoc_com *)arg;
+	if (!com->com_work) {
+		dev_err(com->dev,
+			 "This communicator do not have a work entry.\n");
+		com->service_status = ULTRASOC_COM_SERVICE_STOPPED;
+		return -EINVAL;
+	}
+	dev_dbg(com->dev, "ultrasoc com service %s run on core %d.\n",
+		com->name,  core);
+
+	while (true) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		spin_lock(&com->service_lock);
+		if (com->service_status == ULTRASOC_COM_SERVICE_SLEEPING) {
+			spin_unlock(&com->service_lock);
+			schedule();
+			spin_lock(&com->service_lock);
+		}
+
+		/*
+		 * Since this thread service might be woken up with a status
+		 * of STOP, we check the status again to avoid setting an error
+		 * status
+		 */
+		if (com->service_status == ULTRASOC_COM_SERVICE_SLEEPING) {
+			com->service_status =
+				ULTRASOC_COM_SERVICE_RUNNING_NORMAL;
+			deep_sleep = 0;
+		}
+		spin_unlock(&com->service_lock);
+		__set_current_state(TASK_RUNNING);
+
+		if (com->service_status == ULTRASOC_COM_SERVICE_STOPPED)
+			break;
+
+		ud_flag = com->com_work(com);
+		if (!ud_flag) {
+			usleep_range(10, 100);
+			deep_sleep++;
+		} else {
+			deep_sleep = 0;
+			usleep_range(1, 4);
+		}
+		if (deep_sleep > com->timeout)
+			com->service_status = ULTRASOC_COM_SERVICE_SLEEPING;
+		if (kthread_should_stop())
+			break;
+	}
+	com->service_status = ULTRASOC_COM_SERVICE_STOPPED;
+
+	return 0;
+}
+
+static void com_try_stop_service(struct ultrasoc_com *com)
+{
+	if (com->service_status != ULTRASOC_COM_SERVICE_STOPPED) {
+		spin_lock(&com->service_lock);
+		com->service_status = ULTRASOC_COM_SERVICE_STOPPED;
+		spin_unlock(&com->service_lock);
+		kthread_stop(com->service);
+		com->service = NULL;
+	}
+}
+
+static void com_try_start_service(struct ultrasoc_com *com)
+{
+	if (com->service &&
+	    com->service_status != ULTRASOC_COM_SERVICE_STOPPED) {
+		dev_notice(com->dev, "Service is already running on %ld.\n",
+			   com->core_bind);
+		wake_up_process(com->service);
+		return;
+	}
+
+	dev_dbg(com->dev, "Starting service %s on core %ld.\n",	com->name,
+		com->core_bind);
+	com->service = kthread_create(ultrasoc_com_service, com, "%s_service",
+				      com->name);
+	if (IS_ERR(com->service)) {
+		spin_lock(&com->service_lock);
+		com->service_status = ULTRASOC_COM_SERVICE_STOPPED;
+		spin_unlock(&com->service_lock);
+		dev_err(com->dev, "Failed to start service.\n");
+	}
+
+	if (com->core_bind != -1)
+		kthread_bind(com->service, com->core_bind);
+
+	spin_lock(&com->service_lock);
+	com->service_status = ULTRASOC_COM_SERVICE_RUNNING_NORMAL;
+	spin_unlock(&com->service_lock);
+	wake_up_process(com->service);
+}
+
+static void com_service_restart(struct ultrasoc_com *com)
+{
+	com_try_stop_service(com);
+	com_try_start_service(com);
+}
+
+static ssize_t ultrasoc_com_status(struct ultrasoc_com *com, char *buf)
+{
+	enum ultrasoc_com_service_status status = com->service_status;
+	enum ultrasoc_com_type type = com->com_type;
+	ssize_t wr_size;
+
+	wr_size = sysfs_emit(buf, "%-20s: %s\n", "com-type",
+			     ultrasoc_com_type_string[type]);
+	wr_size += sysfs_emit_at(buf, wr_size, "%-20s: %s\n", "service status",
+				 ultrasoc_com_service_status_string[status]);
+	wr_size += uscom_ops_com_status(com, buf, wr_size);
+
+	return wr_size;
+}
+
+ULTRASOC_COM_ATTR_WO_OPS(start, com_try_start_service);
+ULTRASOC_COM_ATTR_WO_OPS(stop, com_try_stop_service);
+ULTRASOC_COM_ATTR_WO_OPS(restart, com_service_restart);
+ULTRASOC_COM_ATTR_RO_OPS(com_status, ultrasoc_com_status);
+
+struct ultrasoc_com *ultrasoc_find_com_by_dev(struct device *com_dev)
+{
+	struct ultrasoc_drv_data *pdata = dev_get_drvdata(com_dev->parent);
+	struct list_head *com_head = &pdata->ultrasoc_com_head;
+	struct ultrasoc_com *com;
+	struct list_head *cur;
+
+	list_for_each(cur, com_head) {
+		com = list_entry(cur, struct ultrasoc_com, node);
+		if (com->dev == com_dev)
+			return com;
+	}
+
+	dev_err(com_dev, "Unable to find com associated with this device!\n");
+	return NULL;
+}
+
+static ssize_t core_bind_store(struct device *dev,
+			       struct device_attribute *attr, const char *buf,
+			       size_t size)
+{
+	struct ultrasoc_com *com = ultrasoc_find_com_by_dev(dev);
+	long core_bind;
+	int ret;
+
+	if (!com)
+		return 0;
+
+	ret = kstrtol(buf, 0, &core_bind);
+	if (!ret)
+		com->core_bind = core_bind;
+
+	return size;
+}
+
+static ssize_t core_bind_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct ultrasoc_com *com = ultrasoc_find_com_by_dev(dev);
+
+	if (!com)
+		return 0;
+
+	return sysfs_emit(buf, "%#lx", com->core_bind);
+}
+static DEVICE_ATTR_RW(core_bind);
+
+static ssize_t message_store(struct device *dev, struct device_attribute *attr,
+			     const char *buf, size_t size)
+{
+	struct ultrasoc_com *com = ultrasoc_find_com_by_dev(dev);
+	u64 msg, msg_len;
+	int elements;
+
+	elements = sscanf(buf, "%llx %llx", &msg, &msg_len);
+	if (elements < 2)
+		return -EINVAL;
+
+	com->com_ops->put_raw_msg(com, msg_len, msg);
+	dev_dbg(dev, "Set message %#llx, length is %#llx.\n", msg, msg_len);
+
+	return size;
+}
+static DEVICE_ATTR_WO(message);
+
+static umode_t ultrasoc_com_message_is_visible(struct kobject *kobj,
+					   struct attribute *attr, int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct ultrasoc_com *com = ultrasoc_find_com_by_dev(dev);
+
+	if (com->com_type != ULTRASOC_COM_TYPE_BOTH)
+		return 0;
+
+	return attr->mode;
+}
+
+static struct attribute *ultrasoc_com_global_attrs[] = {
+	&dev_attr_com_status.attr,
+	NULL,
+};
+
+static struct attribute *ultrasoc_com_service_attrs[] = {
+	&dev_attr_core_bind.attr,
+	&dev_attr_start.attr,
+	&dev_attr_stop.attr,
+	&dev_attr_restart.attr,
+	NULL,
+};
+
+static struct attribute *ultrasoc_com_message_attrs[] = {
+	&dev_attr_message.attr,
+	NULL,
+};
+
+static const struct attribute_group ultrasoc_com_global_group = {
+	.attrs = ultrasoc_com_global_attrs,
+};
+
+static const struct attribute_group ultrasoc_com_service_group = {
+	.attrs = ultrasoc_com_service_attrs,
+	.name = "service",
+};
+
+static const struct attribute_group ultrasoc_com_message_group = {
+	.attrs = ultrasoc_com_message_attrs,
+	.is_visible = ultrasoc_com_message_is_visible,
+};
+
+static const struct attribute_group *ultrasoc_com_attr[] = {
+	&ultrasoc_com_global_group,
+	&ultrasoc_com_service_group,
+	&ultrasoc_com_message_group,
+	NULL,
+};
+
+static int ultrasoc_validate_com_descp(struct ultrasoc_com_descp *com_descp)
+{
+	if (!com_descp->uscom_ops)
+		return -EINVAL;
+
+	if (com_descp->com_type == ULTRASOC_COM_TYPE_BOTH) {
+		if (!com_descp->uscom_ops->put_raw_msg ||
+		    !com_descp->default_route_msg)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int wait_com_service_stop(struct ultrasoc_com *com)
+{
+	u32 timeout = 0;
+
+	if (com->service_status != ULTRASOC_COM_SERVICE_STOPPED)
+		com_try_stop_service(com);
+	while (com->service_status != ULTRASOC_COM_SERVICE_STOPPED) {
+		usleep_range(10, 100);
+		timeout++;
+		if (timeout > com->timeout)
+			return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+/**
+ * ultrasoc_register_com - register a ultrasoc communicator for communication
+ * between usmsg bus devices and platform bus devices.
+ *
+ * @top_dev: the ultrasoc top platform device to manage all communicator.
+ * @com_descp: the communicator description to be registered.
+ * Return: the pointer to a new communicator if register ok, NULL if failure.
+ */
+struct ultrasoc_com *ultrasoc_register_com(struct device *top_dev,
+					   struct ultrasoc_com_descp *com_descp)
+{
+	struct ultrasoc_drv_data *drv_data = dev_get_drvdata(top_dev);
+	struct ultrasoc_com *com;
+	int ret;
+
+	if (!drv_data)
+		return ERR_PTR(-EBUSY);
+
+	ret = ultrasoc_validate_com_descp(com_descp);
+	if (ret)
+		return ERR_PTR(-EINVAL);
+
+	com = devm_kzalloc(top_dev, sizeof(*com), GFP_KERNEL);
+	if (!com)
+		return ERR_PTR(-ENOMEM);
+
+	com->name = com_descp->name;
+	com->com_type = com_descp->com_type;
+	com->com_ops = com_descp->uscom_ops;
+	com->com_work = com_descp->com_work;
+	com->timeout = US_SERVICE_TIMEOUT;
+	com->core_bind = -1;
+	com->root = top_dev;
+	com->dev = com_descp->com_dev;
+	spin_lock_init(&com->service_lock);
+
+	device_lock(top_dev);
+	list_add_tail(&com->node, &drv_data->ultrasoc_com_head);
+	device_unlock(top_dev);
+
+	if (com->com_type == ULTRASOC_COM_TYPE_BOTH && !drv_data->def_up_com) {
+		/*
+		 * There is one ULTRASOC_COM_TYPE_BOTH device per ultrasoc
+		 * system, so race will not happen.
+		 */
+		drv_data->def_up_com = com;
+		/* start the default communicator service. */
+		com_try_start_service(com);
+		/* set ultrasoc route all msgs to port 1 as default*/
+		com->com_ops->put_raw_msg(com, US_ROUTE_LENGTH,
+					  com_descp->default_route_msg);
+	}
+
+	ret = device_add_groups(com->dev, ultrasoc_com_attr);
+	if (ret)
+		return  ERR_PTR(ret);
+
+	return com;
+}
+EXPORT_SYMBOL_GPL(ultrasoc_register_com);
+
+int ultrasoc_unregister_com(struct ultrasoc_com *com)
+{
+	struct ultrasoc_drv_data *pdata = dev_get_drvdata(com->root);
+	struct device *com_dev = com->dev;
+	struct device *dev = com->root;
+
+	if (wait_com_service_stop(com)) {
+		dev_err(com_dev, "Com service is still running.\n");
+		return -EBUSY;
+	}
+
+	if (pdata->def_up_com == com)
+		pdata->def_up_com = NULL;
+
+	device_lock(dev);
+	list_del(&com->node);
+	device_unlock(dev);
+	device_remove_groups(com_dev, ultrasoc_com_attr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ultrasoc_unregister_com);
+
+MODULE_DESCRIPTION("Ultrasoc driver");
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_AUTHOR("Jonathan Zhou <jonathan.zhouwen@huawei.com>");
+MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");
diff --git a/drivers/hwtracing/ultrasoc/ultrasoc.h b/drivers/hwtracing/ultrasoc/ultrasoc.h
new file mode 100644
index 0000000..2831e14
--- /dev/null
+++ b/drivers/hwtracing/ultrasoc/ultrasoc.h
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (C) 2021 Hisilicon Limited Permission is hereby granted, free of
+ * charge, to any person obtaining a copy of this software and associated
+ * documentation files (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modify,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Software,
+ * and to permit persons to whom the Software is furnished to do so, subject
+ * to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ *
+ * Code herein communicates with and accesses proprietary hardware which is
+ * licensed intellectual property (IP) belonging to Siemens Digital Industries
+ * Software Ltd.
+ *
+ * Siemens Digital Industries Software Ltd. asserts and reserves all rights to
+ * their intellectual property. This paragraph may not be removed or modified
+ * in any way without permission from Siemens Digital Industries Software Ltd.
+ */
+
+#ifndef _LINUX_ULTRASOC_H
+#define _LINUX_ULTRASOC_H
+
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+
+struct ultrasoc_drv_data {
+	struct device *dev;
+	void __iomem *com_mux;
+	struct list_head ultrasoc_com_head;
+	struct ultrasoc_com *def_up_com;
+	const char *dev_data_path;
+	spinlock_t spinlock;
+};
+
+enum ultrasoc_com_type {
+	ULTRASOC_COM_TYPE_BOTH,
+	ULTRASOC_COM_TYPE_DOWN,
+};
+
+struct ultrasoc_com_descp {
+	const char *name;
+	enum ultrasoc_com_type com_type;
+	struct device *com_dev;
+	struct uscom_ops *uscom_ops;
+	int (*com_work)(struct ultrasoc_com *com);
+	u64 default_route_msg;
+};
+
+enum ultrasoc_com_service_status {
+	ULTRASOC_COM_SERVICE_STOPPED,
+	ULTRASOC_COM_SERVICE_SLEEPING,
+	ULTRASOC_COM_SERVICE_RUNNING_NORMAL,
+};
+
+#define USMSG_MAX_IDX				9
+struct msg_descp {
+	unsigned int msg_len;
+	__le32 msg_buf[USMSG_MAX_IDX];
+	struct list_head node;
+};
+
+static inline void usmsg_list_realse_all(struct list_head *msg_head)
+{
+	struct msg_descp *msgd, *next;
+
+	list_for_each_entry_safe(msgd, next, msg_head, node) {
+		list_del(&msgd->node);
+		kfree(msgd);
+	}
+}
+
+struct ultrasoc_com {
+	const char *name;
+	enum ultrasoc_com_type com_type;
+	struct device *root;
+	struct device *dev;
+
+	long core_bind;
+	int (*com_work)(struct ultrasoc_com *com);
+	spinlock_t service_lock;
+	struct task_struct *service;
+	int service_status;
+	unsigned int timeout;
+
+	char *data_path;
+	struct uscom_ops *com_ops;
+
+	struct list_head node;
+};
+
+struct uscom_ops {
+	ssize_t (*com_status)(struct ultrasoc_com *com, char *buf,
+			      ssize_t size);
+	void (*put_raw_msg)(struct ultrasoc_com *com, int msg_size,
+			    unsigned long long msg);
+};
+
+#define uscom_ops_com_status(uscom, buf, size)                           \
+	(((uscom)->com_ops && (uscom)->com_ops->com_status) ?            \
+		 (uscom)->com_ops->com_status(uscom, buf, size) : 0)
+
+static inline void *ultrasoc_com_get_drvdata(struct ultrasoc_com *uscom)
+{
+	return dev_get_drvdata(uscom->dev);
+}
+
+struct ultrasoc_com *
+ultrasoc_register_com(struct device *root_dev,
+		      struct ultrasoc_com_descp *com_descp);
+int ultrasoc_unregister_com(struct ultrasoc_com *com);
+int ultrasoc_com_del_usmsg_device(struct ultrasoc_com *com, int index);
+
+struct ultrasoc_com *ultrasoc_find_com_by_dev(struct device *com_dev);
+
+#define ULTRASOC_COM_ATTR_WO_OPS(attr_name, com_ops)                           \
+	static ssize_t attr_name##_store(struct device *dev,                   \
+					 struct device_attribute *attr,        \
+					 const char *buf, size_t size)         \
+	{                                                                      \
+		struct ultrasoc_com *com = ultrasoc_find_com_by_dev(dev);      \
+		long attr_name;                                                \
+		int ret;                                                       \
+		if (!com)                                                      \
+			return 0;                                              \
+		ret = kstrtol(buf, 0, &attr_name);                             \
+		if (ret) {                                                     \
+			return size;                                           \
+		}                                                              \
+		if (attr_name == 1) {                                          \
+			com_ops(com);                                          \
+		}                                                              \
+		return size;                                                   \
+	}                                                                      \
+	static DEVICE_ATTR_WO(attr_name)
+
+#define ULTRASOC_COM_ATTR_RO_OPS(attr_name, com_ops)                           \
+	static ssize_t attr_name##_show(struct device *dev,                    \
+					struct device_attribute *attr,         \
+					char *buf)                             \
+	{                                                                      \
+		struct ultrasoc_com *com = ultrasoc_find_com_by_dev(dev);      \
+		if (!com)                                                      \
+			return 0;                                              \
+		return com_ops(com, buf);                                      \
+	}                                                                      \
+	static DEVICE_ATTR_RO(attr_name)
+
+/* 1000 * (10us ~ 100us) */
+#define US_SERVICE_TIMEOUT		1000
+/* communicator service work status */
+#define US_SERVICE_ONWORK		1
+#define US_SERVICE_IDLE			0
+#define US_ROUTE_LENGTH			11
+#define US_SELECT_ONCHIP		0x3
+
+#endif
-- 
2.7.4

