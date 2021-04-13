Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B40A35D4C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244303AbhDMBXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 21:23:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17317 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbhDMBX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:23:28 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FK78h0wy4z9yyP;
        Tue, 13 Apr 2021 09:20:52 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Tue, 13 Apr 2021
 09:22:58 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [RFC PATCH 3/3] vfio/hisilicom: add debugfs for driver
Date:   Tue, 13 Apr 2021 09:20:21 +0800
Message-ID: <1618276821-8320-4-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1618276821-8320-1-git-send-email-liulongfang@huawei.com>
References: <1618276821-8320-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add debugfs debugging interface to live migration driver

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/vfio/pci/hisilicon/acc_vf_migration.c | 193 ++++++++++++++++++++++++++
 drivers/vfio/pci/hisilicon/acc_vf_migration.h |   2 +
 2 files changed, 195 insertions(+)

diff --git a/drivers/vfio/pci/hisilicon/acc_vf_migration.c b/drivers/vfio/pci/hisilicon/acc_vf_migration.c
index 45382c7..b0f7f09 100644
--- a/drivers/vfio/pci/hisilicon/acc_vf_migration.c
+++ b/drivers/vfio/pci/hisilicon/acc_vf_migration.c
@@ -16,6 +16,9 @@
 
 #define VDM_OFFSET(x) offsetof(struct vfio_device_migration_info, x)
 void vfio_pci_hisilicon_acc_uninit(struct acc_vf_migration *acc_vf_dev);
+static void vf_debugfs_exit(struct acc_vf_migration *acc_vf_dev);
+static struct dentry *mig_debugfs_root;
+static int mig_root_ref;
 
 /* return 0 mailbox ready, -ETIMEDOUT hardware timeout */
 static int qm_wait_mb_ready(struct hisi_qm *qm)
@@ -934,6 +937,193 @@ static const struct vfio_pci_regops vfio_pci_acc_regops = {
 	.add_capability = acc_vf_migration_add_capability,
 };
 
+static ssize_t acc_vf_debug_read(struct file *filp, char __user *buffer,
+			   size_t count, loff_t *pos)
+{
+	char buf[VFIO_DEV_DBG_LEN];
+	int len;
+
+	len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+			"echo 0: test vf data store\n"
+			"echo 1: test vf data writeback\n"
+			"echo 2: test vf send mailbox\n"
+			"echo 3: dump vf dev data\n"
+			"echo 4: dump migration state\n");
+
+	return simple_read_from_buffer(buffer, count, pos, buf, len);
+}
+
+static ssize_t acc_vf_debug_write(struct file *filp, const char __user *buffer,
+			    size_t count, loff_t *pos)
+{
+	struct acc_vf_migration *acc_vf_dev = filp->private_data;
+	struct device *dev = &acc_vf_dev->vf_dev->dev;
+	struct hisi_qm *qm = acc_vf_dev->vf_qm;
+	char tbuf[VFIO_DEV_DBG_LEN];
+	unsigned long val;
+	u64 data;
+	int len, ret;
+
+	if (*pos)
+		return 0;
+
+	if (count >= VFIO_DEV_DBG_LEN)
+		return -ENOSPC;
+
+	len = simple_write_to_buffer(tbuf, VFIO_DEV_DBG_LEN - 1,
+					pos, buffer, count);
+	if (len < 0)
+		return len;
+	tbuf[len] = '\0';
+	if (kstrtoul(tbuf, 0, &val))
+		return -EFAULT;
+
+	switch (val) {
+	case STATE_SAVE:
+		ret = vf_qm_state_save(qm, acc_vf_dev);
+		if (ret)
+			return -EINVAL;
+		break;
+	case STATE_RESUME:
+		ret = vf_qm_state_resume(qm, acc_vf_dev);
+		if (ret)
+			return -EINVAL;
+		break;
+	case MB_TEST:
+		data = readl(qm->io_base + QM_MB_CMD_SEND_BASE);
+		dev_info(dev, "debug mailbox addr: 0x%lx, mailbox val: 0x%llx\n",
+			 (uintptr_t)qm->io_base, data);
+		break;
+	case MIG_DATA_DUMP:
+		dev_info(dev, "dumped vf migration data:\n");
+		print_hex_dump(KERN_INFO, "Mig Data:", DUMP_PREFIX_OFFSET,
+				VFIO_DBG_LOG_LEN, 1,
+				(unsigned char *)acc_vf_dev->vf_data,
+				sizeof(struct acc_vf_data), false);
+		break;
+	case MIG_DEV_SHOW:
+		if (!acc_vf_dev->mig_ctl)
+			dev_info(dev, "migration region have release!\n");
+		else
+			dev_info(dev,
+				 "device  state: %u\n"
+				 "pending bytes: %llu\n"
+				 "data   offset: %llu\n"
+				 "data     size: %llu\n"
+				 "data     addr: 0x%lx\n",
+				 acc_vf_dev->mig_ctl->device_state,
+				 acc_vf_dev->mig_ctl->pending_bytes,
+				 acc_vf_dev->mig_ctl->data_offset,
+				 acc_vf_dev->mig_ctl->data_size,
+				 (uintptr_t)acc_vf_dev->vf_data);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static const struct file_operations acc_vf_debug_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = acc_vf_debug_read,
+	.write = acc_vf_debug_write,
+};
+
+static ssize_t acc_vf_state_read(struct file *filp, char __user *buffer,
+			   size_t count, loff_t *pos)
+{
+	struct acc_vf_migration *acc_vf_dev = filp->private_data;
+	char buf[VFIO_DEV_DBG_LEN];
+	u32 state;
+	int len;
+
+	if (!acc_vf_dev->mig_ctl) {
+		len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n", "Invalid\n");
+	} else {
+		state = acc_vf_dev->mig_ctl->device_state;
+		switch (state) {
+		case VFIO_DEVICE_STATE_RUNNING:
+			len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+				"RUNNING\n");
+			break;
+		case VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RUNNING:
+			len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+				"SAVING and RUNNING\n");
+			break;
+		case VFIO_DEVICE_STATE_SAVING:
+			len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+				"SAVING\n");
+			break;
+		case VFIO_DEVICE_STATE_STOP:
+			len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+				"STOP\n");
+			break;
+		case VFIO_DEVICE_STATE_RESUMING:
+			len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+				"RESUMING\n");
+			break;
+		default:
+			len = scnprintf(buf, VFIO_DEV_DBG_LEN, "%s\n",
+				"Error\n");
+		}
+	}
+
+	return simple_read_from_buffer(buffer, count, pos, buf, len);
+}
+
+static const struct file_operations acc_vf_state_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = acc_vf_state_read,
+};
+
+static void vf_debugfs_init(struct acc_vf_migration *acc_vf_dev)
+{
+	char name[VFIO_DEV_DBG_LEN];
+	int node_id;
+
+	if (!mig_root_ref)
+		mig_debugfs_root = debugfs_create_dir("vfio_acc", NULL);
+	mutex_lock(&acc_vf_dev->reflock);
+	mig_root_ref++;
+	mutex_unlock(&acc_vf_dev->reflock);
+
+	node_id = dev_to_node(&acc_vf_dev->vf_dev->dev);
+	if (node_id < 0)
+		node_id = 0;
+
+	if (acc_vf_dev->acc_type == HISI_SEC)
+		scnprintf(name, VFIO_DEV_DBG_LEN, "sec_vf%d-%d",
+			  node_id, acc_vf_dev->vf_id);
+	else if (acc_vf_dev->acc_type == HISI_HPRE)
+		scnprintf(name, VFIO_DEV_DBG_LEN, "hpre_vf%d-%d",
+			  node_id, acc_vf_dev->vf_id);
+	else
+		scnprintf(name, VFIO_DEV_DBG_LEN, "zip_vf%d-%d",
+			  node_id, acc_vf_dev->vf_id);
+
+	acc_vf_dev->debug_root = debugfs_create_dir(name, mig_debugfs_root);
+
+	debugfs_create_file("debug", 0644, acc_vf_dev->debug_root,
+			      acc_vf_dev, &acc_vf_debug_fops);
+	debugfs_create_file("state", 0444, acc_vf_dev->debug_root,
+			      acc_vf_dev, &acc_vf_state_fops);
+}
+
+static void vf_debugfs_exit(struct acc_vf_migration *acc_vf_dev)
+{
+	debugfs_remove_recursive(acc_vf_dev->debug_root);
+
+	mutex_lock(&acc_vf_dev->reflock);
+	mig_root_ref--;
+	mutex_unlock(&acc_vf_dev->reflock);
+
+	if (!mig_root_ref)
+		debugfs_remove_recursive(mig_debugfs_root);
+}
+
 static int qm_acc_type_init(struct acc_vf_migration *acc_vf_dev)
 {
 	struct pci_dev *pdev = acc_vf_dev->vf_dev;
@@ -1137,6 +1327,8 @@ int vfio_pci_hisilicon_acc_init(struct vfio_pci_device *vdev)
 		goto register_error;
 	}
 
+	vf_debugfs_init(acc_vf_dev);
+
 	return 0;
 
 register_error:
@@ -1159,6 +1351,7 @@ void vfio_pci_hisilicon_acc_uninit(struct acc_vf_migration *acc_vf_dev)
 	acc_vf_dev->regions = NULL;
 	acc_vf_dev->num_regions = 0;
 
+	vf_debugfs_exit(acc_vf_dev);
 	kfree(acc_vf_dev);
 }
 
diff --git a/drivers/vfio/pci/hisilicon/acc_vf_migration.h b/drivers/vfio/pci/hisilicon/acc_vf_migration.h
index 26c79e4..38d4035 100644
--- a/drivers/vfio/pci/hisilicon/acc_vf_migration.h
+++ b/drivers/vfio/pci/hisilicon/acc_vf_migration.h
@@ -159,11 +159,13 @@ struct acc_vf_migration {
 	struct hisi_qm			*vf_qm;
 	int				vf_id;
 	u8				acc_type;
+	struct mutex			reflock;
 
 	struct vfio_device_migration_info *mig_ctl;
 	struct acc_vf_data		*vf_data;
 	struct vfio_pci_region		*regions;
 	int				num_regions;
+	struct dentry			*debug_root;
 };
 
 #endif /* ACC_MIG_H */
-- 
2.8.1

