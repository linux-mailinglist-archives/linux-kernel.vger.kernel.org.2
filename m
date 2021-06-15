Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 058303A7ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 11:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhFOJhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 05:37:39 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4785 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbhFOJhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:37:21 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G432C3wgfzXfyT;
        Tue, 15 Jun 2021 17:30:11 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
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
Subject: [RFC PATCH 4/4] ultrasoc: Add System Memory Buffer driver
Date:   Tue, 15 Jun 2021 17:34:44 +0800
Message-ID: <1623749684-65432-5-git-send-email-liuqi115@huawei.com>
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

This patch adds driver for System Memory Buffer. It includes
a platform driver for the SMB device.

Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/hwtracing/ultrasoc/Kconfig        |   9 +
 drivers/hwtracing/ultrasoc/Makefile       |   3 +
 drivers/hwtracing/ultrasoc/ultrasoc-smb.c | 663 ++++++++++++++++++++++++++++++
 drivers/hwtracing/ultrasoc/ultrasoc-smb.h | 182 ++++++++
 4 files changed, 857 insertions(+)
 create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc-smb.c
 create mode 100644 drivers/hwtracing/ultrasoc/ultrasoc-smb.h

diff --git a/drivers/hwtracing/ultrasoc/Kconfig b/drivers/hwtracing/ultrasoc/Kconfig
index 77429f3..8899949 100644
--- a/drivers/hwtracing/ultrasoc/Kconfig
+++ b/drivers/hwtracing/ultrasoc/Kconfig
@@ -22,4 +22,13 @@ config ULTRASOC_AXI_COM
 	  the upstream channel is used to transmit user configuration, and
 	  downstream channel to carry response and trace data to the users.
 
+config ULTRASOC_SMB
+	tristate "Ultrasoc System memory buffer drivers"
+	help
+	  This config enables support for Ultrasoc System Memory Buffer
+	  drivers. The System Memory Buffer provides a way to buffer and
+	  store messages in system memory. It provides a capability to
+	  store messages received on its input message interface to an
+	  area of system memory.
+
 endif
diff --git a/drivers/hwtracing/ultrasoc/Makefile b/drivers/hwtracing/ultrasoc/Makefile
index 54711a7b..b174ca8 100644
--- a/drivers/hwtracing/ultrasoc/Makefile
+++ b/drivers/hwtracing/ultrasoc/Makefile
@@ -8,3 +8,6 @@ ultrasoc-drv-objs := ultrasoc.o
 
 obj-$(CONFIG_ULTRASOC_AXI_COM) += ultrasoc-axi-com-drv.o
 ultrasoc-axi-com-drv-objs := ultrasoc-axi-com.o
+
+obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb-drv.o
+ultrasoc-smb-drv-objs := ultrasoc-smb.o
diff --git a/drivers/hwtracing/ultrasoc/ultrasoc-smb.c b/drivers/hwtracing/ultrasoc/ultrasoc-smb.c
new file mode 100644
index 0000000..ce03f5e
--- /dev/null
+++ b/drivers/hwtracing/ultrasoc/ultrasoc-smb.c
@@ -0,0 +1,663 @@
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
+
+#include <linux/circ_buf.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+
+#include "ultrasoc-smb.h"
+
+static inline int smb_hw_buffer_empty(struct smb_drv_data *drvdata)
+{
+	u32 buf_status = readl(drvdata->base + SMB_LB_INT_STS);
+
+	return buf_status & BIT(0) ? 0 : 1;
+}
+
+static inline int smb_buffer_pointer_pos(struct smb_drv_data *drvdata)
+{
+	u32 wr_offset, rd_offset;
+
+	wr_offset = readl(drvdata->base + SMB_LB_WR_ADDR);
+	rd_offset = readl(drvdata->base + SMB_LB_RD_ADDR);
+	return wr_offset == rd_offset;
+}
+
+static inline int smb_hw_buffer_full(struct smb_drv_data *drvdata)
+{
+	return smb_buffer_pointer_pos(drvdata) && !smb_hw_buffer_empty(drvdata);
+}
+
+static inline void smb_clear_buf_status(struct smb_drv_data *drvdata)
+{
+	struct smb_data_buffer *sdb = &drvdata->smb_db;
+
+	if (smb_buffer_pointer_pos(drvdata) && !sdb->to_copy)
+		writel(0xf, drvdata->base + SMB_LB_INT_STS);
+}
+
+static void smb_update_hw_write_size(struct smb_drv_data *drvdata)
+{
+	struct smb_data_buffer *sdb = &drvdata->smb_db;
+	u32 write_offset, write_base;
+
+	sdb->lost = false;
+	writel(0x1, drvdata->base + SMB_LB_PURGE);
+	if (smb_hw_buffer_empty(drvdata)) {
+		sdb->to_copy = 0;
+		return;
+	}
+
+	if (smb_hw_buffer_full(drvdata)) {
+		sdb->to_copy = sdb->buf_size;
+		return;
+	}
+
+	write_base = sdb->buf_base_phys & SMB_BUF_WRITE_BASE;
+	write_offset = readl(drvdata->base + SMB_LB_WR_ADDR) - write_base;
+	sdb->to_copy = CIRC_CNT(write_offset, sdb->rd_offset, sdb->buf_size);
+}
+
+static int smb_open(struct inode *inode, struct file *file)
+{
+	struct smb_drv_data *drvdata = container_of(file->private_data,
+			struct smb_drv_data, miscdev);
+
+	if (local_cmpxchg(&drvdata->reading, 0, 1))
+		return -EBUSY;
+
+	smb_update_hw_write_size(drvdata);
+	return 0;
+}
+
+static ssize_t smb_read(struct file *file, char __user *data,
+			size_t len, loff_t *ppos)
+{
+	struct smb_drv_data *drvdata = container_of(file->private_data,
+			struct smb_drv_data, miscdev);
+	struct smb_data_buffer *sdb = &drvdata->smb_db;
+	struct device *dev = &drvdata->csdev->dev;
+	unsigned long to_copy = sdb->to_copy;
+
+	if (!to_copy) {
+		smb_update_hw_write_size(drvdata);
+		to_copy = sdb->to_copy;
+		if (!to_copy)
+			return to_copy;
+	}
+
+	to_copy = min(to_copy, len);
+	/*
+	 * if the read needs to cross the boundary of the data buffer, copy
+	 * last datas of the buffer to user
+	 */
+	if (sdb->rd_offset + to_copy > sdb->buf_size)
+		to_copy = sdb->buf_size - sdb->rd_offset;
+
+	if (copy_to_user(data, (void *)sdb->buf_base + sdb->rd_offset, to_copy)) {
+		dev_dbg(dev, "Failed to copy data to user.\n");
+		return -EFAULT;
+	}
+
+	*ppos += to_copy;
+	sdb->rd_offset += to_copy;
+	sdb->rd_offset %= sdb->buf_size;
+	sdb->to_copy -= to_copy;
+
+	/* update the read point */
+	writel(sdb->buf_base_phys + sdb->rd_offset,
+	       drvdata->base + SMB_LB_RD_ADDR);
+	smb_clear_buf_status(drvdata);
+	dev_dbg(dev, "%lu bytes copied.\n", to_copy);
+
+	return to_copy;
+}
+
+static int smb_release(struct inode *inode, struct file *file)
+{
+	struct smb_drv_data *drvdata = container_of(file->private_data,
+			struct smb_drv_data, miscdev);
+	local_set(&drvdata->reading, 0);
+	return 0;
+}
+
+static const struct file_operations smb_fops = {
+	.owner		= THIS_MODULE,
+	.open		= smb_open,
+	.read		= smb_read,
+	.release	= smb_release,
+	.llseek		= no_llseek,
+};
+
+static ssize_t smb_show_status(struct ultrasoc_com *com, char *buf,
+			       ssize_t wr_size)
+{
+	struct smb_drv_data *drvdata;
+	u32 value;
+
+	drvdata = dev_get_drvdata(com->dev);
+	value = readl(drvdata->base + SMB_LB_INT_STS);
+	wr_size += sysfs_emit_at(buf, wr_size, "%-20s: 0x%08x\n",
+				 "interrupt status", value);
+	value = readl(drvdata->base + SMB_LB_WR_ADDR);
+	wr_size += sysfs_emit_at(buf, wr_size, "%-20s: %#x\n", "write point",
+				 value);
+	value = readl(drvdata->base + SMB_LB_RD_ADDR);
+	wr_size += sysfs_emit_at(buf, wr_size, "%-20s: %#x\n", "read point",
+				 value);
+
+	return wr_size;
+}
+
+static int smb_init_data_buffer(struct platform_device *pdev,
+				struct smb_data_buffer *sdb)
+{
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (IS_ERR(res)) {
+		dev_err(&pdev->dev, "SMB device without data buffer.\n");
+		return -EINVAL;
+	}
+
+	sdb->buf_base_phys = res->start;
+	sdb->buf_size = resource_size(res);
+	if (sdb->buf_size == 0)
+		return -EINVAL;
+
+	sdb->buf_base = ioremap_cache(sdb->buf_base_phys, sdb->buf_size);
+	if (sdb->buf_base == NULL)
+		return -ENOMEM;
+
+	sdb->buf_cfg_mode = SMB_BUF_CFG_STREAMING;
+	return 0;
+}
+
+static void smb_release_data_buffer(struct smb_drv_data *drvdata)
+{
+	struct smb_data_buffer *sdb = &drvdata->smb_db;
+
+	if (sdb->buf_base)
+		iounmap(sdb->buf_base);
+}
+
+static struct uscom_ops smb_ops = {
+	.com_status = smb_show_status,
+	.put_raw_msg = NULL,
+};
+
+static int smb_set_buffer(struct coresight_device *csdev,
+		struct perf_output_handle *handle);
+
+static void smb_enable_hw(struct smb_drv_data *drvdata)
+{
+	writel(0x1, drvdata->base + SMB_GLOBAL_EN);
+}
+
+static void smb_disable_hw(struct smb_drv_data *drvdata)
+{
+	writel(0x1, drvdata->base + SMB_LB_PURGE);
+	writel(0x0, drvdata->base + SMB_GLOBAL_EN);
+}
+
+static int smb_enable_sysfs(struct coresight_device *csdev)
+{
+	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
+	unsigned long flags;
+	int ret = 0;
+
+	WARN_ON_ONCE(drvdata == NULL);
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	/* Don't messup with perf sessions. */
+	if (drvdata->mode == CS_MODE_PERF) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (drvdata->mode == CS_MODE_DISABLED) {
+		smb_enable_hw(drvdata);
+		drvdata->mode = CS_MODE_SYSFS;
+	}
+	atomic_inc(csdev->refcnt);
+out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return ret;
+}
+
+static int smb_enable_perf(struct coresight_device *csdev, void *data)
+{
+	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct device *dev = &drvdata->csdev->dev;
+	struct perf_output_handle *handle = data;
+	unsigned long flags;
+	int ret = 0;
+	pid_t pid;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (drvdata->mode == CS_MODE_SYSFS) {
+		dev_err(dev, "Device is already in used by sysfs.\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* Get a handle on the pid of the target process*/
+	pid = task_pid_nr(handle->event->owner);
+	if (drvdata->pid != -1 && drvdata->pid != pid) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/*
+	 * No HW configuration is needed if the sink is already in
+	 * use for this session.
+	 */
+	if (drvdata->pid == pid) {
+		atomic_inc(csdev->refcnt);
+		goto out;
+	}
+
+	/*
+	 * We don't have an internal state to clean up if we fail to setup
+	 * the perf buffer. So we can perform the step before we turn the
+	 * ETB on and leave without cleaning up.
+	 */
+	ret = smb_set_buffer(csdev, handle);
+	if (ret)
+		goto out;
+
+	smb_enable_hw(drvdata);
+	drvdata->pid = pid;
+	drvdata->mode = CS_MODE_PERF;
+	atomic_inc(csdev->refcnt);
+out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return ret;
+}
+
+static int smb_enable(struct coresight_device *csdev, u32 mode, void *data)
+{
+	int ret;
+
+	switch (mode) {
+	case CS_MODE_SYSFS:
+		ret = smb_enable_sysfs(csdev);
+		break;
+	case CS_MODE_PERF:
+		ret = smb_enable_perf(csdev, data);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret)
+		return ret;
+
+	dev_dbg(&csdev->dev, "Ultrasoc smb enabled.\n");
+
+	return 0;
+}
+
+static int smb_disable(struct coresight_device *csdev)
+{
+	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
+	unsigned long flags;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	if (atomic_dec_return(csdev->refcnt)) {
+		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		return -EBUSY;
+	}
+
+	/* Complain if we (somehow) got out of sync */
+	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
+	smb_disable_hw(drvdata);
+
+	/* Dissociate from the target process. */
+	drvdata->pid = -1;
+	drvdata->mode = CS_MODE_DISABLED;
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	dev_dbg(&csdev->dev, "Ultrasoc smb disabled.\n");
+	return 0;
+}
+
+static void smb_set_default_hw(struct smb_drv_data *drvdata)
+{
+	struct smb_data_buffer *sdb = &drvdata->smb_db;
+	u32 value, base_hi, base_lo, limit_lo;
+
+	/* first disable smb and clear the status of SMB buffer */
+	smb_disable_hw(drvdata);
+	smb_clear_buf_status(drvdata);
+
+	/* using smb in single-end mode, and set other configures default */
+	value = sdb->buf_cfg_mode | SMB_BUF_SINGLE_END | SMB_BUF_ENABLE;
+	writel(value, drvdata->base + SMB_LB_CFG_LO);
+	value = SMB_MSG_FILTER(0x0, 0xff);
+	writel(value, drvdata->base + SMB_LB_CFG_HI);
+
+	writel(HISI_SMB_GLOBAL_CFG, drvdata->base + SMB_GLOBAL_CFG);
+	writel(HISI_SMB_GLB_INT_CFG, drvdata->base + SMB_GLOBAL_INT);
+	writel(HISI_SMB_BUF_INT_CFG, drvdata->base + SMB_LB_INT_CTRL);
+
+	/* config hardware registers according to physical base of SMB buffer */
+	base_hi = sdb->buf_base_phys >> 32;
+	base_lo = sdb->buf_base_phys & SMB_BUF_WRITE_BASE;
+	limit_lo = base_lo + sdb->buf_size;
+	writel(base_lo, drvdata->base + SMB_LB_BASE_LO);
+	writel(base_hi, drvdata->base + SMB_LB_BASE_HI);
+	writel(limit_lo, drvdata->base + SMB_LB_LIMIT);
+
+	/* initial hardware read-ptr address*/
+	writel(base_lo, drvdata->base + SMB_LB_RD_ADDR);
+}
+
+static void *smb_alloc_buffer(struct coresight_device *csdev,
+		struct perf_event *event, void **pages,
+		int nr_pages, bool overwrite)
+{
+	struct cs_buffers *buf;
+	int node;
+
+	node = (event->cpu == -1) ? NUMA_NO_NODE : cpu_to_node(event->cpu);
+	buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);
+	if (!buf)
+		return NULL;
+
+	buf->snapshot = overwrite;
+	buf->nr_pages = nr_pages;
+	buf->data_pages = pages;
+
+	return buf;
+}
+
+static void smb_free_buffer(void *config)
+{
+	struct cs_buffers *buf = config;
+
+	kfree(buf);
+}
+
+static int smb_set_buffer(struct coresight_device *csdev,
+		struct perf_output_handle *handle)
+{
+	struct cs_buffers *buf = etm_perf_sink_config(handle);
+	u32 head;
+
+	if (!buf)
+		return -EINVAL;
+
+	/* wrap head around to the amount of space we have */
+	head = handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
+
+	/* find the page to write to and offset within that page */
+	buf->cur = head / PAGE_SIZE;
+	buf->offset = head % PAGE_SIZE;
+
+	local_set(&buf->data_size, 0);
+
+	return 0;
+}
+
+static void smb_sync_perf_buffer(struct smb_drv_data *drvdata,
+				 struct cs_buffers *buf, unsigned long to_copy)
+{
+	struct smb_data_buffer *sdb = &drvdata->smb_db;
+	char **dst_pages = (char **)buf->data_pages;
+	u32 buf_offset = buf->offset;
+	u32 cur = buf->cur;
+	u32 bytes;
+
+	while (to_copy > 0) {
+		/*
+		 * if the read needs to cross the boundary of the data buffer,
+		 * copy last datas of the buffer to user
+		 */
+		if (sdb->rd_offset + PAGE_SIZE - buf_offset > sdb->buf_size)
+			bytes = sdb->buf_size - sdb->rd_offset;
+		else
+			bytes = min(to_copy, PAGE_SIZE - buf_offset);
+
+		memcpy_fromio(dst_pages[cur] + buf_offset,
+		       sdb->buf_base + sdb->rd_offset, bytes);
+
+		buf_offset += bytes;
+		if (buf_offset >= PAGE_SIZE) {
+			buf_offset = 0;
+			cur++;
+			cur %= buf->nr_pages;
+		}
+		to_copy -= bytes;
+		/* ensure memcpy finished before update the read pointer */
+		sdb->rd_offset += bytes;
+		sdb->rd_offset %= sdb->buf_size;
+	}
+
+	writel(sdb->buf_base_phys + sdb->rd_offset,
+	       drvdata->base + SMB_LB_RD_ADDR);
+	sdb->to_copy = to_copy;
+}
+
+static unsigned long smb_update_buffer(struct coresight_device *csdev,
+		struct perf_output_handle *handle, void *sink_config)
+{
+	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
+	struct smb_data_buffer *sdb = &drvdata->smb_db;
+	struct cs_buffers *buf = sink_config;
+	u64 to_copy;
+
+	if (!buf)
+		return 0;
+
+	smb_update_hw_write_size(drvdata);
+	to_copy = sdb->to_copy;
+	if (to_copy > handle->size) {
+		sdb->rd_offset += (to_copy - handle->size);
+		sdb->rd_offset %= sdb->buf_size;
+		to_copy = handle->size;
+		sdb->lost = true;
+	}
+
+	smb_sync_perf_buffer(drvdata, buf, to_copy);
+	smb_clear_buf_status(drvdata);
+	if (!buf->snapshot && sdb->lost)
+		perf_aux_output_flag(handle, PERF_AUX_FLAG_TRUNCATED);
+
+	return to_copy;
+}
+
+static const struct coresight_ops_sink smb_cs_ops = {
+	.enable		= smb_enable,
+	.disable	= smb_disable,
+	.alloc_buffer	= smb_alloc_buffer,
+	.free_buffer	= smb_free_buffer,
+	.update_buffer	= smb_update_buffer,
+};
+
+static const struct coresight_ops cs_ops = {
+	.sink_ops	= &smb_cs_ops,
+};
+
+static int smb_init_res(struct platform_device *pdev,
+			struct smb_drv_data *drvdata)
+{
+	struct smb_data_buffer *sdb;
+	int ret;
+
+	sdb = &drvdata->smb_db;
+	drvdata->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(drvdata->base)) {
+		dev_err(&pdev->dev, "Failed to ioremap resource.\n");
+		return PTR_ERR(drvdata->base);
+	}
+
+	ret = smb_init_data_buffer(pdev, sdb);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to init buffer, ret = %d.\n", ret);
+
+	return ret;
+}
+
+DEFINE_CORESIGHT_DEVLIST(sink_devs, "sink_smb");
+static int smb_register_sink(struct platform_device *pdev,
+			     struct smb_drv_data *drvdata)
+{
+	struct coresight_platform_data *pdata = NULL;
+	struct coresight_desc desc = { 0 };
+	int ret;
+
+	pdata = coresight_get_platform_data(&pdev->dev);
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+
+	drvdata->dev->platform_data = pdata;
+	desc.type = CORESIGHT_DEV_TYPE_SINK;
+	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
+	desc.ops = &cs_ops;
+	desc.pdata = pdata;
+	desc.dev = &pdev->dev;
+	desc.name = coresight_alloc_device_name(&sink_devs, &pdev->dev);
+	if (!desc.name) {
+		dev_err(&pdev->dev, "Failed to alloc coresight device name.");
+		return -ENOMEM;
+	}
+
+	drvdata->csdev = coresight_register(&desc);
+	if (IS_ERR(drvdata->csdev))
+		return PTR_ERR(drvdata->csdev);
+
+	drvdata->miscdev.name = desc.name;
+	drvdata->miscdev.minor = MISC_DYNAMIC_MINOR;
+	drvdata->miscdev.fops = &smb_fops;
+	ret = misc_register(&drvdata->miscdev);
+	if (ret) {
+		coresight_unregister(drvdata->csdev);
+		dev_err(&pdev->dev, "Failed to register misc, ret=%d\n", ret);
+	}
+
+	return ret;
+}
+
+static void smb_unregister_sink(struct smb_drv_data *drvdata)
+{
+	misc_deregister(&drvdata->miscdev);
+	coresight_unregister(drvdata->csdev);
+}
+
+static int smb_config_com_descp(struct platform_device *pdev,
+				struct smb_drv_data *drvdata)
+{
+	struct device *parent = pdev->dev.parent;
+	struct ultrasoc_com_descp com_descp = {0};
+	struct device *dev = &pdev->dev;
+	struct ultrasoc_com *com;
+
+	com_descp.name = pdev->name;
+	com_descp.com_type = ULTRASOC_COM_TYPE_DOWN;
+	com_descp.com_dev = dev;
+	com_descp.uscom_ops = &smb_ops;
+	com = ultrasoc_register_com(parent, &com_descp);
+	if (IS_ERR(com)) {
+		dev_err(dev, "Failed to register smb com.\n");
+		return PTR_ERR(com);
+	}
+
+	drvdata->com = com;
+	return 0;
+}
+
+static int smb_probe(struct platform_device *pdev)
+{
+	struct smb_drv_data *drvdata;
+	int ret;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	ret = smb_init_res(pdev, drvdata);
+	if (ret)
+		return ret;
+
+	smb_set_default_hw(drvdata);
+	spin_lock_init(&drvdata->spinlock);
+	drvdata->dev = &pdev->dev;
+	drvdata->pid = -1;
+
+	ret = smb_config_com_descp(pdev, drvdata);
+	if (ret)
+		return ret;
+
+	ret = smb_register_sink(pdev, drvdata);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to register smb sink.\n");
+		ultrasoc_unregister_com(drvdata->com);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, drvdata);
+	return 0;
+}
+
+static int smb_remove(struct platform_device *pdev)
+{
+	struct smb_drv_data *drvdata = platform_get_drvdata(pdev);
+
+	smb_unregister_sink(drvdata);
+	ultrasoc_unregister_com(drvdata->com);
+	smb_release_data_buffer(drvdata);
+	return 0;
+}
+
+static const struct acpi_device_id ultrasoc_smb_acpi_match[] = {
+	{"HISI03A1", },
+	{},
+};
+
+static struct platform_driver smb_driver = {
+	.driver = {
+		.name = "ultrasoc,smb",
+		.acpi_match_table = ultrasoc_smb_acpi_match,
+	},
+	.probe = smb_probe,
+	.remove = smb_remove,
+};
+module_platform_driver(smb_driver);
+
+MODULE_DESCRIPTION("Ultrasoc smb driver");
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_AUTHOR("Jonathan Zhou <jonathan.zhouwen@huawei.com>");
+MODULE_AUTHOR("Qi Liu <liuqi115@huawei.com>");
diff --git a/drivers/hwtracing/ultrasoc/ultrasoc-smb.h b/drivers/hwtracing/ultrasoc/ultrasoc-smb.h
new file mode 100644
index 0000000..e37d510
--- /dev/null
+++ b/drivers/hwtracing/ultrasoc/ultrasoc-smb.h
@@ -0,0 +1,182 @@
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
+#ifndef _ULTRASOC_SMB_H
+#define _ULTRASOC_SMB_H
+
+#include <linux/coresight.h>
+#include <linux/list.h>
+#include <linux/miscdevice.h>
+
+#include "ultrasoc.h"
+
+#define SMB_GLOBAL_CFG		0X0
+#define SMB_GLOBAL_EN		0X4
+#define SMB_GLOBAL_INT		0X8
+#define SMB_LB_CFG_LO		0X40
+#define SMB_LB_CFG_HI		0X44
+#define SMB_LB_INT_CTRL		0X48
+#define SMB_LB_INT_STS		0X4C
+#define SMB_LB_BASE_LO		0X50
+#define SMB_LB_BASE_HI		0X54
+#define SMB_LB_LIMIT		0X58
+#define SMB_LB_RD_ADDR		0X5C
+#define SMB_LB_WR_ADDR		0X60
+#define SMB_LB_PURGE		0X64
+
+#define SMB_MSG_LC(lc)		((lc & 0x3) << 2)
+#define SMB_BST_LEN(len)	(((len - 1) & 0xff) << 4)
+/* idle message injection timer period */
+#define SMB_IDLE_PRD(period)	(((period - 216) & 0xf) << 12)
+#define SMB_MEM_WR(credit, rate) (((credit & 0x3) << 16) | ((rate & 0xf) << 18))
+#define SMB_MEM_RD(credit, rate) (((credit & 0x3) << 22) | ((rate & 0xf) << 24))
+#define HISI_SMB_GLOBAL_CFG                                                    \
+	(SMB_MSG_LC(0) | SMB_IDLE_PRD(231) | SMB_MEM_WR(0x3, 0x0) |            \
+	 SMB_MEM_RD(0x3, 0x6) | SMB_BST_LEN(16))
+
+#define SMB_INT_ENABLE		BIT(0)
+#define SMB_INT_TYPE_PULSE	BIT(1)
+#define SMB_INT_POLARITY_HIGH	BIT(2)
+#define HISI_SMB_GLB_INT_CFG	(SMB_INT_ENABLE | SMB_INT_TYPE_PULSE |         \
+				SMB_INT_POLARITY_HIGH)
+
+/* logic buffer config register low 32b */
+#define SMB_BUF_ENABLE			BIT(0)
+#define SMB_BUF_SINGLE_END		BIT(1)
+#define SMB_BUF_INIT			BIT(8)
+#define SMB_BUF_CONTINUOUS		BIT(11)
+#define SMB_FLOW_MASK			GENMASK(19, 16)
+#define SMB_BUF_CFG_STREAMING						       \
+	(SMB_BUF_INIT | SMB_BUF_CONTINUOUS | SMB_FLOW_MASK)
+#define SMB_BUF_WRITE_BASE		GENMASK(31, 0)
+
+/* logic buffer config register high 32b */
+#define SMB_MSG_FILTER(lower, upper)	((lower & 0xff) | ((upper & 0xff) << 8))
+#define SMB_BUF_INT_ENABLE		BIT(0)
+#define SMB_BUF_NOTE_NOT_EMPTY		BIT(8)
+#define SMB_BUF_NOTE_BLOCK_AVAIL	BIT(9)
+#define SMB_BUF_NOTE_TRIGGERED		BIT(10)
+#define SMB_BUF_NOTE_FULL		BIT(11)
+#define HISI_SMB_BUF_INT_CFG						\
+	(SMB_BUF_INT_ENABLE | SMB_BUF_NOTE_NOT_EMPTY |			\
+	   SMB_BUF_NOTE_BLOCK_AVAIL | SMB_BUF_NOTE_TRIGGERED |		\
+	    SMB_BUF_NOTE_FULL)
+
+struct smb_data_buffer {
+	/* memory buffer for hardware write */
+	u32 buf_cfg_mode;
+	bool lost;
+	void __iomem *buf_base;
+	u64 buf_base_phys;
+	u64 buf_size;
+	u64 to_copy;
+	u32 rd_offset;
+};
+
+struct smb_drv_data {
+	void __iomem *base;
+	struct device *dev;
+	struct ultrasoc_com *com;
+	struct smb_data_buffer smb_db;
+	/* to register ultrasoc smb as a coresight sink device. */
+	struct coresight_device	*csdev;
+	spinlock_t		spinlock;
+	local_t			reading;
+	pid_t			pid;
+	u32			mode;
+	struct miscdevice miscdev;
+};
+
+#define SMB_MSG_ALIGH_SIZE 0x400
+
+static inline struct smb_data_buffer *
+	dev_get_smb_data_buffer(struct device *dev)
+{
+	struct smb_drv_data *drvdata = dev_get_drvdata(dev);
+
+	if (drvdata)
+		return &drvdata->smb_db;
+
+	return NULL;
+}
+
+/*
+ * Coresight doesn't export the following
+ * structures(cs_mode,cs_buffers,etm_event_data),
+ * so we redefine a copy here.
+ */
+enum cs_mode {
+	CS_MODE_DISABLED,
+	CS_MODE_SYSFS,
+	CS_MODE_PERF,
+};
+
+struct cs_buffers {
+	unsigned int		cur;
+	unsigned int		nr_pages;
+	unsigned long		offset;
+	local_t			data_size;
+	bool			snapshot;
+	void			**data_pages;
+};
+
+struct etm_event_data {
+	struct work_struct work;
+	cpumask_t mask;
+	void *snk_config;
+	struct list_head * __percpu *path;
+};
+
+#if IS_ENABLED(CONFIG_CORESIGHT)
+int etm_perf_symlink(struct coresight_device *csdev, bool link);
+int etm_perf_add_symlink_sink(struct coresight_device *csdev);
+void etm_perf_del_symlink_sink(struct coresight_device *csdev);
+static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
+{
+	struct etm_event_data *data = perf_get_aux(handle);
+
+	if (data)
+		return data->snk_config;
+	return NULL;
+}
+#else
+static inline int etm_perf_symlink(struct coresight_device *csdev, bool link)
+{ return -EINVAL; }
+int etm_perf_add_symlink_sink(struct coresight_device *csdev)
+{ return -EINVAL; }
+void etm_perf_del_symlink_sink(struct coresight_device *csdev) {}
+static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_CORESIGHT */
+
+#endif
-- 
2.7.4

