Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D3835D4C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 03:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244453AbhDMBXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 21:23:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17318 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239642AbhDMBX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:23:28 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FK78h0MTNz9yy3;
        Tue, 13 Apr 2021 09:20:52 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Tue, 13 Apr 2021
 09:22:57 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <alex.williamson@redhat.com>
CC:     <cohuck@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <liulongfang@huawei.com>
Subject: [RFC PATCH 1/3] vfio/hisilicon: add acc live migration driver
Date:   Tue, 13 Apr 2021 09:20:19 +0800
Message-ID: <1618276821-8320-2-git-send-email-liulongfang@huawei.com>
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

This driver adds the code required by Hisilicon
accelerator device to realize the live migration function.
It mainly includes the following functions:
(1).Match the accelerator device with the vfio-pci
driver framework.
(2).Processing of the status of the live migration
function and processing of the migration data.
(3).Operation and data processing of accelerator hardware devices

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/vfio/pci/Kconfig                      |    9 +
 drivers/vfio/pci/Makefile                     |    3 +-
 drivers/vfio/pci/hisilicon/acc_vf_migration.c | 1164 +++++++++++++++++++++++++
 drivers/vfio/pci/hisilicon/acc_vf_migration.h |  170 ++++
 4 files changed, 1345 insertions(+), 1 deletion(-)
 create mode 100644 drivers/vfio/pci/hisilicon/acc_vf_migration.c
 create mode 100644 drivers/vfio/pci/hisilicon/acc_vf_migration.h

diff --git a/drivers/vfio/pci/Kconfig b/drivers/vfio/pci/Kconfig
index 24ee260..791be27 100644
--- a/drivers/vfio/pci/Kconfig
+++ b/drivers/vfio/pci/Kconfig
@@ -30,3 +30,12 @@ config VFIO_PCI_INTX
 config VFIO_PCI_IGD
 	depends on VFIO_PCI
 	def_bool y if X86
+
+config VFIO_PCI_HISI_MIGRATION
+	bool "Support for Hisilicon Live Migaration"
+	depends on ARM64 && ACPI
+	select PCI_IOV
+	default y
+	help
+	  Support for HiSilicon vfio pci to support VF live migration.
+
diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
index 76d8ec0..7dd1176 100644
--- a/drivers/vfio/pci/Makefile
+++ b/drivers/vfio/pci/Makefile
@@ -2,4 +2,5 @@
 vfio-pci-y := vfio_pci.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
 vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
 
-obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
+vfio-pci-$(CONFIG_VFIO_PCI_HISI_MIGRATION) += hisilicon/acc_vf_migration.o
+obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
\ No newline at end of file
diff --git a/drivers/vfio/pci/hisilicon/acc_vf_migration.c b/drivers/vfio/pci/hisilicon/acc_vf_migration.c
new file mode 100644
index 0000000..45382c7
--- /dev/null
+++ b/drivers/vfio/pci/hisilicon/acc_vf_migration.c
@@ -0,0 +1,1164 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 HiSilicon Limited. */
+
+#include <linux/device.h>
+#include <linux/debugfs.h>
+#include <linux/eventfd.h>
+#include <linux/file.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/sysfs.h>
+#include <linux/vfio.h>
+
+#include "acc_vf_migration.h"
+
+#define VDM_OFFSET(x) offsetof(struct vfio_device_migration_info, x)
+void vfio_pci_hisilicon_acc_uninit(struct acc_vf_migration *acc_vf_dev);
+
+/* return 0 mailbox ready, -ETIMEDOUT hardware timeout */
+static int qm_wait_mb_ready(struct hisi_qm *qm)
+{
+	u32 val;
+
+	return readl_relaxed_poll_timeout(qm->io_base + QM_MB_CMD_SEND_BASE,
+					val, !((val >> QM_MB_BUSY_SHIFT) &
+					0x1), MB_POLL_PERIOD_US,
+					MB_POLL_TIMEOUT_US);
+}
+
+/* return 0 VM acc device ready, -ETIMEDOUT hardware timeout */
+static int qm_wait_dev_ready(struct hisi_qm *qm)
+{
+	u32 val;
+
+	return readl_relaxed_poll_timeout(qm->io_base + QM_VF_EQ_INT_MASK,
+				val, !(val & 0x1), MB_POLL_PERIOD_US,
+				MB_POLL_TIMEOUT_US);
+}
+
+
+/* 128 bit should be written to hardware at one time to trigger a mailbox */
+static void qm_mb_write(struct hisi_qm *qm, const void *src)
+{
+	void __iomem *fun_base = qm->io_base + QM_MB_CMD_SEND_BASE;
+	unsigned long tmp0 = 0;
+	unsigned long tmp1 = 0;
+
+	if (!IS_ENABLED(CONFIG_ARM64)) {
+		memcpy_toio(fun_base, src, 16);
+		wmb();
+		return;
+	}
+
+	asm volatile("ldp %0, %1, %3\n"
+		     "stp %0, %1, %2\n"
+		     "dsb sy\n"
+		     : "=&r" (tmp0),
+		       "=&r" (tmp1),
+		       "+Q" (*((char __iomem *)fun_base))
+		     : "Q" (*((char *)src))
+		     : "memory");
+}
+
+static void qm_mb_pre_init(struct qm_mailbox *mailbox, u8 cmd,
+			   u16 queue, bool op)
+{
+	mailbox->w0 = cpu_to_le16(cmd |
+		     (op ? 0x1 << QM_MB_OP_SHIFT : 0) |
+		     (0x1 << QM_MB_BUSY_SHIFT));
+	mailbox->queue_num = cpu_to_le16(queue);
+	mailbox->rsvd = 0;
+}
+
+static int qm_mb_nolock(struct hisi_qm *qm, struct qm_mailbox *mailbox)
+{
+	int cnt = 0;
+
+	if (unlikely(qm_wait_mb_ready(qm))) {
+		dev_err(&qm->pdev->dev, "QM mailbox is busy to start!\n");
+		return -EBUSY;
+	}
+
+	qm_mb_write(qm, mailbox);
+	while (true) {
+		if (!qm_wait_mb_ready(qm))
+			break;
+		if (++cnt > QM_MB_MAX_WAIT_CNT) {
+			dev_err(&qm->pdev->dev, "QM mailbox operation timeout!\n");
+			return -EBUSY;
+		}
+	}
+	return 0;
+}
+
+static int qm_mb(struct hisi_qm *qm, u8 cmd, dma_addr_t dma_addr, u16 queue,
+		 bool op)
+{
+	struct qm_mailbox mailbox;
+	int ret;
+
+	dev_dbg(&qm->pdev->dev, "QM mailbox request to q%u: %u-0x%llx\n",
+			queue, cmd, (unsigned long long)dma_addr);
+
+	qm_mb_pre_init(&mailbox, cmd, queue, op);
+	mailbox.base_l = cpu_to_le32(lower_32_bits(dma_addr));
+	mailbox.base_h = cpu_to_le32(upper_32_bits(dma_addr));
+
+	mutex_lock(&qm->mailbox_lock);
+	ret = qm_mb_nolock(qm, &mailbox);
+	mutex_unlock(&qm->mailbox_lock);
+
+	return ret;
+}
+
+/*
+ * Each state Reg is checked 100 times,
+ * with a delay of 100 microseconds after each check
+ */
+static u32 acc_check_reg_state(struct hisi_qm *qm, u32 regs)
+{
+	int check_times = 0;
+	u32 state;
+
+	state = readl(qm->io_base + regs);
+	while (state && check_times < ERROR_CHECK_TIMEOUT) {
+		udelay(CHECK_DELAY_TIME);
+		state = readl(qm->io_base + regs);
+		check_times++;
+	}
+
+	return state;
+}
+
+/* Check the  PF's RAS state and Function INT state */
+static int qm_check_int_state(struct acc_vf_migration *acc_vf_dev)
+{
+	struct hisi_qm *vfqm = acc_vf_dev->vf_qm;
+	struct hisi_qm *qm = acc_vf_dev->pf_qm;
+	struct device *dev = &qm->pdev->dev;
+	u32 state;
+
+	/* Check RAS state */
+	state = acc_check_reg_state(qm, QM_ABNORMAL_INT_STATUS);
+	if (state) {
+		dev_err(dev, "failed to check QM RAS state!\n");
+		return -EBUSY;
+	}
+
+	/* Check Function Communication  state between PF and VF */
+	state = acc_check_reg_state(vfqm, QM_IFC_INT_STATUS);
+	if (state) {
+		dev_err(dev, "failed to check QM IFC INT state!\n");
+		return -EBUSY;
+	}
+	state = acc_check_reg_state(vfqm, QM_IFC_INT_SET_V);
+	if (state) {
+		dev_err(dev, "failed to check QM IFC INT SET state!\n");
+		return -EBUSY;
+	}
+
+	/* Check submodule task state */
+	switch (acc_vf_dev->acc_type) {
+	case HISI_SEC:
+		state = acc_check_reg_state(qm, SEC_CORE_INT_STATUS);
+		if (state) {
+			dev_err(dev, "failed to check QM SEC Core INT state!\n");
+			return -EBUSY;
+		}
+		break;
+	case HISI_HPRE:
+		state = acc_check_reg_state(qm, HPRE_HAC_INT_STATUS);
+		if (state) {
+			dev_err(dev, "failed to check QM HPRE HAC INT state!\n");
+			return -EBUSY;
+		}
+		break;
+	case HISI_ZIP:
+		state = acc_check_reg_state(qm, HZIP_CORE_INT_STATUS);
+		if (state) {
+			dev_err(dev, "failed to check QM ZIP Core INT state!\n");
+			return -EBUSY;
+		}
+		break;
+	default:
+		dev_err(dev, "failed to detect acc module type!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int qm_read_reg(struct hisi_qm *qm, u32 reg_addr,
+			 u32 *data, u8 nums)
+{
+	int i;
+
+	if (nums < 1 || nums > QM_REGS_MAX_LEN) {
+		dev_err(&qm->pdev->dev, "QM read input parameter is error!\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < nums; i++) {
+		data[i] = readl(qm->io_base + reg_addr);
+		reg_addr += QM_REG_ADDR_OFFSET;
+	}
+
+	return 0;
+}
+
+static int qm_write_reg(struct hisi_qm *qm, u32 reg_addr,
+			 u32 *data, u8 nums)
+{
+	int i;
+
+	if (nums < 1 || nums > QM_REGS_MAX_LEN) {
+		dev_err(&qm->pdev->dev, "QM write input parameter is error!\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < nums; i++) {
+		writel(data[i], qm->io_base + reg_addr);
+		reg_addr += QM_REG_ADDR_OFFSET;
+	}
+
+	return 0;
+}
+
+static int qm_get_vft(struct hisi_qm *qm, u32 *base, u32 *number)
+{
+	u64 sqc_vft;
+	int ret;
+
+	ret = qm_mb(qm, QM_MB_CMD_SQC_VFT_V2, 0, 0, 1);
+	if (ret)
+		return ret;
+
+	sqc_vft = readl(qm->io_base + QM_MB_CMD_DATA_ADDR_L) |
+		  ((u64)readl(qm->io_base + QM_MB_CMD_DATA_ADDR_H) <<
+		  QM_XQC_ADDR_OFFSET);
+	*base = QM_SQC_VFT_BASE_MASK_V2 & (sqc_vft >> QM_SQC_VFT_BASE_SHIFT_V2);
+	*number = (QM_SQC_VFT_NUM_MASK_V2 &
+		  (sqc_vft >> QM_SQC_VFT_NUM_SHIFT_V2)) + 1;
+
+	return 0;
+}
+
+static int qm_get_sqc(struct hisi_qm *qm, u64 *addr)
+{
+	int ret;
+
+	ret = qm_mb(qm, QM_MB_CMD_SQC_BT, 0, 0, 1);
+	if (ret)
+		return ret;
+
+	*addr = readl(qm->io_base + QM_MB_CMD_DATA_ADDR_L) |
+		  ((u64)readl(qm->io_base + QM_MB_CMD_DATA_ADDR_H) <<
+		  QM_XQC_ADDR_OFFSET);
+
+	return 0;
+}
+
+static int qm_get_cqc(struct hisi_qm *qm, u64 *addr)
+{
+	int ret;
+
+	ret = qm_mb(qm, QM_MB_CMD_CQC_BT, 0, 0, 1);
+	if (ret)
+		return ret;
+
+	*addr = readl(qm->io_base + QM_MB_CMD_DATA_ADDR_L) |
+		  ((u64)readl(qm->io_base + QM_MB_CMD_DATA_ADDR_H) <<
+		  QM_XQC_ADDR_OFFSET);
+
+	return 0;
+}
+
+static int qm_rw_regs_read(struct hisi_qm *qm, struct acc_vf_data *vf_data)
+{
+	struct device *dev = &qm->pdev->dev;
+	int ret;
+
+	/* check VM task driver state */
+	if (unlikely(qm_wait_dev_ready(qm))) {
+		dev_err(&qm->pdev->dev, "QM device is not ready to read!\n");
+		return -EBUSY;
+	}
+
+	ret = qm_read_reg(qm, QM_VF_AEQ_INT_MASK, &vf_data->aeq_int_mask, 1);
+	if (ret) {
+		dev_err(dev, "failed to read QM_VF_AEQ_INT_MASK!\n");
+		return ret;
+	}
+
+	ret = qm_read_reg(qm, QM_VF_EQ_INT_MASK, &vf_data->eq_int_mask, 1);
+	if (ret) {
+		dev_err(dev, "failed to read QM_VF_EQ_INT_MASK!\n");
+		return ret;
+	}
+
+	ret = qm_read_reg(qm, QM_IFC_INT_SOURCE_V,
+			   &vf_data->ifc_int_source, 1);
+	if (ret) {
+		dev_err(dev, "failed to read QM_IFC_INT_SOURCE_V!\n");
+		return ret;
+	}
+
+	ret = qm_read_reg(qm, QM_IFC_INT_MASK, &vf_data->ifc_int_mask, 1);
+	if (ret) {
+		dev_err(dev, "failed to read QM_IFC_INT_MASK!\n");
+		return ret;
+	}
+
+	ret = qm_read_reg(qm, QM_IFC_INT_SET_V, &vf_data->ifc_int_set, 1);
+	if (ret) {
+		dev_err(dev, "failed to read QM_IFC_INT_SET_V!\n");
+		return ret;
+	}
+
+	/* QM_EQC_DW has 7 regs */
+	ret = qm_read_reg(qm, QM_EQC_DW0, vf_data->qm_eqc_dw, 7);
+	if (ret) {
+		dev_err(dev, "failed to read QM_EQC_DW!\n");
+		return ret;
+	}
+
+	/* QM_AEQC_DW has 7 regs */
+	ret = qm_read_reg(qm, QM_AEQC_DW0, vf_data->qm_aeqc_dw, 7);
+	if (ret) {
+		dev_err(dev, "failed to read QM_AEQC_DW!\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qm_rw_regs_write(struct hisi_qm *qm, struct acc_vf_data *vf_data)
+{
+	struct device *dev = &qm->pdev->dev;
+	int ret;
+
+	/* check VF state */
+	if (unlikely(qm_wait_mb_ready(qm))) {
+		dev_err(&qm->pdev->dev, "QM device is not ready to write!\n");
+		return -EBUSY;
+	}
+
+	ret = qm_write_reg(qm, QM_VF_AEQ_INT_MASK, &vf_data->aeq_int_mask, 1);
+	if (ret) {
+		dev_err(dev, "failed to write QM_VF_AEQ_INT_MASK!\n");
+		return ret;
+	}
+
+	ret = qm_write_reg(qm, QM_VF_EQ_INT_MASK, &vf_data->eq_int_mask, 1);
+	if (ret) {
+		dev_err(dev, "failed to write QM_VF_EQ_INT_MASK!\n");
+		return ret;
+	}
+
+	ret = qm_write_reg(qm, QM_IFC_INT_SOURCE_V,
+			   &vf_data->ifc_int_source, 1);
+	if (ret) {
+		dev_err(dev, "failed to write QM_IFC_INT_SOURCE_V!\n");
+		return ret;
+	}
+
+	ret = qm_write_reg(qm, QM_IFC_INT_MASK, &vf_data->ifc_int_mask, 1);
+	if (ret) {
+		dev_err(dev, "failed to write QM_IFC_INT_MASK!\n");
+		return ret;
+	}
+
+	ret = qm_write_reg(qm, QM_IFC_INT_SET_V, &vf_data->ifc_int_set, 1);
+	if (ret) {
+		dev_err(dev, "failed to write QM_IFC_INT_SET_V!\n");
+		return ret;
+	}
+
+	ret = qm_write_reg(qm, QM_QUE_ISO_CFG_V, &vf_data->que_iso_cfg, 1);
+	if (ret) {
+		dev_err(dev, "failed to write QM_QUE_ISO_CFG_V!\n");
+		return ret;
+	}
+
+	/* QM_EQC_DW has 7 regs */
+	ret = qm_write_reg(qm, QM_EQC_DW0, vf_data->qm_eqc_dw, 7);
+	if (ret) {
+		dev_err(dev, "failed to write QM_EQC_DW!\n");
+		return ret;
+	}
+
+	/* QM_AEQC_DW has 7 regs */
+	ret = qm_write_reg(qm, QM_AEQC_DW0, vf_data->qm_aeqc_dw, 7);
+	if (ret) {
+		dev_err(dev, "failed to write QM_AEQC_DW!\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * the vf QM have unbind from host, insmod in the VM
+ * so, qm just have the addr from pci dev
+ * others is null.
+ * so we need read from the SEC hardware REGs.
+ */
+static int vf_migration_data_store(struct hisi_qm *qm,
+			struct acc_vf_migration *acc_vf_dev)
+{
+	struct acc_vf_data *vf_data = acc_vf_dev->vf_data;
+	struct device *dev = &qm->pdev->dev;
+	int ret;
+
+	ret = qm_rw_regs_read(qm, vf_data);
+	if (ret) {
+		dev_err(dev, "failed to read QM regs!\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * every Reg is 32 bit, the dma address is 64 bit
+	 * so, the dma address is store in the Reg2 and Reg1
+	 */
+	vf_data->eqe_dma = vf_data->qm_eqc_dw[2];
+	vf_data->eqe_dma <<= QM_XQC_ADDR_OFFSET;
+	vf_data->eqe_dma |= vf_data->qm_eqc_dw[1];
+	vf_data->aeqe_dma = vf_data->qm_aeqc_dw[2];
+	vf_data->aeqe_dma <<= QM_XQC_ADDR_OFFSET;
+	vf_data->aeqe_dma |= vf_data->qm_aeqc_dw[1];
+
+	/* Through SQC_BT/CQC_BT to get sqc and cqc address */
+	ret = qm_get_sqc(qm, &vf_data->sqc_dma);
+	if (ret) {
+		dev_err(dev, "failed to read SQC addr!\n");
+		return -EINVAL;
+	}
+
+	ret = qm_get_cqc(qm, &vf_data->cqc_dma);
+	if (ret) {
+		dev_err(dev, "failed to read CQC addr!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void qm_dev_cmd_init(struct hisi_qm *qm)
+{
+	/* clear VF communication status registers. */
+	writel(0x1, qm->io_base + QM_IFC_INT_SOURCE_V);
+
+	/* enable pf and vf communication. */
+	writel(0x0, qm->io_base + QM_IFC_INT_MASK);
+}
+
+static void qm_db(struct hisi_qm *qm, u16 qn, u8 cmd,
+	u16 index, u8 priority)
+{
+	void __iomem *io_base = qm->io_base;
+	u16 randata = 0;
+	u64 doorbell;
+
+	if (cmd == QM_DOORBELL_CMD_SQ || cmd == QM_DOORBELL_CMD_CQ)
+		io_base = qm->db_io_base + (u64)qn * qm->db_interval +
+			  QM_DOORBELL_SQ_CQ_BASE_V2;
+	else
+		io_base += QM_DOORBELL_EQ_AEQ_BASE_V2;
+
+	doorbell = qn | ((u64)cmd << QM_DB_CMD_SHIFT_V2) |
+				((u64)randata << QM_DB_RAND_SHIFT_V2) |
+				((u64)index << QM_DB_INDEX_SHIFT_V2) |
+				((u64)priority << QM_DB_PRIORITY_SHIFT_V2);
+
+	writeq(doorbell, io_base);
+}
+
+static void vf_qm_fun_restart(struct hisi_qm *qm)
+{
+	int i;
+
+	for (i = 0; i < qm->qp_num; i++)
+		qm_db(qm, i, QM_DOORBELL_CMD_SQ, 0, 1);
+}
+
+static int vf_info_check(struct hisi_qm *qm,
+	struct acc_vf_migration *acc_vf_dev)
+{
+	struct acc_vf_data *vf_data = acc_vf_dev->vf_data;
+	struct device *dev = &qm->pdev->dev;
+	u32 que_iso_state;
+	int ret;
+
+	/* vf acc type check */
+	if (vf_data->acc_type != acc_vf_dev->acc_type) {
+		dev_err(dev, "failed to match VF acc type!\n");
+		return -EINVAL;
+	}
+
+	/* vf qp num check */
+	ret = qm_get_vft(qm, &qm->qp_base, &qm->qp_num);
+	if (ret || qm->qp_num <= 1) {
+		dev_err(dev, "failed to get vft qp nums!\n");
+		return ret;
+	}
+	if (vf_data->qp_num != qm->qp_num) {
+		dev_err(dev, "failed to match VF qp num!\n");
+		return -EINVAL;
+	}
+
+	/* vf isolation state check */
+	ret = qm_read_reg(qm, QM_QUE_ISO_CFG_V, &que_iso_state, 1);
+	if (ret) {
+		dev_err(dev, "failed to read QM_QUE_ISO_CFG_V!\n");
+		return ret;
+	}
+	if (vf_data->que_iso_cfg != que_iso_state) {
+		dev_err(dev, "failed to match isolation state!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int vf_migration_data_recover(struct hisi_qm *qm,
+	struct acc_vf_data *vf_data)
+{
+	struct device *dev = &qm->pdev->dev;
+	int ret;
+
+	qm->eqe_dma = vf_data->eqe_dma;
+	qm->aeqe_dma = vf_data->aeqe_dma;
+	qm->sqc_dma = vf_data->sqc_dma;
+	qm->cqc_dma = vf_data->cqc_dma;
+
+	qm->qp_base = vf_data->qp_base;
+	qm->qp_num = vf_data->qp_num;
+
+	ret = qm_rw_regs_write(qm, vf_data);
+	if (ret) {
+		dev_err(dev, "Set VF regs failed!\n");
+		return ret;
+	}
+
+	ret = qm_mb(qm, QM_MB_CMD_SQC_BT, qm->sqc_dma, 0, 0);
+	if (ret) {
+		dev_err(dev, "Set sqc failed!\n");
+		return ret;
+	}
+
+	ret = qm_mb(qm, QM_MB_CMD_CQC_BT, qm->cqc_dma, 0, 0);
+	if (ret) {
+		dev_err(dev, "Set cqc failed!\n");
+		return ret;
+	}
+
+	/* which ACC module need to reinit? */
+	qm_dev_cmd_init(qm);
+
+	/* reopen the VF msi interrruption */
+	writel(0x0, qm->io_base + QM_VF_EQ_INT_MASK);
+	writel(0x0, qm->io_base + QM_VF_AEQ_INT_MASK);
+
+	return 0;
+}
+
+static int vf_qm_cache_wb(struct hisi_qm *qm)
+{
+	unsigned int val;
+
+	writel(0x1, qm->io_base + QM_CACHE_WB_START);
+	if (readl_relaxed_poll_timeout(qm->io_base + QM_CACHE_WB_DONE,
+					val, val & BIT(0), MB_POLL_PERIOD_US,
+					MB_POLL_TIMEOUT_US)) {
+		dev_err(&qm->pdev->dev, "vf QM writeback sqc cache fail!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int vf_qm_func_stop(struct hisi_qm *qm)
+{
+	return qm_mb(qm, QM_MB_CMD_PAUSE_QM, 0, 0, 0);
+}
+
+static int vf_qm_state_pre_save(struct hisi_qm *qm,
+		struct acc_vf_migration *acc_vf_dev)
+{
+	struct acc_vf_data *vf_data = acc_vf_dev->vf_data;
+	struct device *dev = &qm->pdev->dev;
+	int ret;
+
+	/* check VM task driver state */
+	if (unlikely(qm_wait_dev_ready(qm))) {
+		dev_err(&qm->pdev->dev, "QM device is not ready to read!\n");
+		return -EBUSY;
+	}
+
+	/* vf acc type save */
+	vf_data->acc_type = acc_vf_dev->acc_type;
+
+	/* vf qp num save */
+	ret = qm_get_vft(qm, &qm->qp_base, &qm->qp_num);
+	if (ret || qm->qp_num <= 1) {
+		dev_err(dev, "failed to get vft qp nums!\n");
+		return -EINVAL;
+	}
+	vf_data->qp_base = qm->qp_base;
+	vf_data->qp_num = qm->qp_num;
+
+	/* vf isolation state save */
+	ret = qm_read_reg(qm, QM_QUE_ISO_CFG_V, &vf_data->que_iso_cfg, 1);
+	if (ret) {
+		dev_err(dev, "failed to read QM_QUE_ISO_CFG_V!\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int vf_qm_state_save(struct hisi_qm *qm,
+		struct acc_vf_migration *acc_vf_dev)
+{
+	struct device *dev = &acc_vf_dev->vf_dev->dev;
+	int ret;
+
+	/* First stop the ACC vf function */
+	ret = vf_qm_func_stop(qm);
+	if (ret) {
+		dev_err(dev, "failed to stop QM VF function!\n");
+		goto state_error;
+	}
+
+	/* Check the VF's RAS and Interrution state */
+	ret = qm_check_int_state(acc_vf_dev);
+	if (ret) {
+		dev_err(dev, "failed to check QM INT state!\n");
+		goto state_error;
+	}
+
+	/* hisi_qm_cache_wb store cache data to DDR */
+	ret = vf_qm_cache_wb(qm);
+	if (ret) {
+		dev_err(dev, "failed to writeback QM Cache!\n");
+		goto state_error;
+	}
+
+	ret = vf_migration_data_store(qm, acc_vf_dev);
+	if (ret) {
+		dev_err(dev, "failed to get and store migration data!\n");
+		goto state_error;
+	}
+
+	return 0;
+
+state_error:
+	vf_qm_fun_restart(qm);
+	return ret;
+}
+
+static int vf_qm_state_resume(struct hisi_qm *qm,
+		struct acc_vf_migration *acc_vf_dev)
+{
+	struct device *dev = &acc_vf_dev->vf_dev->dev;
+	int ret;
+
+	/* recover data to VF */
+	ret = vf_migration_data_recover(qm, acc_vf_dev->vf_data);
+	if (ret) {
+		dev_err(dev, "failed to recover the VF!\n");
+		return ret;
+	}
+
+	/* restart all destination VF's QP */
+	vf_qm_fun_restart(qm);
+
+	return 0;
+}
+
+static int acc_vf_set_device_state(struct acc_vf_migration *acc_vf_dev,
+				       u32 state)
+{
+	struct vfio_device_migration_info *mig_ctl = acc_vf_dev->mig_ctl;
+	struct device *dev = &acc_vf_dev->vf_dev->dev;
+	struct hisi_qm *qm = acc_vf_dev->vf_qm;
+	int ret = 0;
+
+	if (state == mig_ctl->device_state)
+		return 0;
+
+	switch (state) {
+	case VFIO_DEVICE_STATE_RUNNING:
+		if (mig_ctl->device_state == VFIO_DEVICE_STATE_RESUMING) {
+			ret = vf_qm_state_resume(qm, acc_vf_dev);
+			if (ret) {
+				dev_err(dev, "failed to resume device!\n");
+				return -EFAULT;
+			}
+		}
+
+		break;
+	case VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RUNNING:
+		/* ACC should in the pre cycle to read match information data */
+		ret = vf_qm_state_pre_save(qm, acc_vf_dev);
+		if (ret) {
+			dev_err(dev, "failed to pre save device state!\n");
+			return -EFAULT;
+		}
+
+		/* set the pending_byte and match data size */
+		mig_ctl->data_size = QM_MATCH_SIZE;
+		mig_ctl->pending_bytes = mig_ctl->data_size;
+
+		break;
+	case VFIO_DEVICE_STATE_SAVING:
+		/* stop the vf function */
+		ret = vf_qm_state_save(qm, acc_vf_dev);
+		if (ret) {
+			dev_err(dev, "failed to save device state!\n");
+			return -EFAULT;
+		}
+
+		/* set the pending_byte and data_size */
+		mig_ctl->data_size = sizeof(struct acc_vf_data);
+		mig_ctl->pending_bytes = mig_ctl->data_size;
+
+		break;
+	case VFIO_DEVICE_STATE_STOP:
+		/* restart all  VF's QP */
+		vf_qm_fun_restart(qm);
+
+		break;
+	case VFIO_DEVICE_STATE_RESUMING:
+
+		break;
+	default:
+		ret = -EFAULT;
+	}
+
+	if (!ret) {
+		dev_info(dev, "migration state: %s ----------> %s!\n",
+				vf_dev_state[mig_ctl->device_state],
+				vf_dev_state[state]);
+		mig_ctl->device_state = state;
+	}
+
+	return ret;
+}
+
+static int acc_vf_data_transfer(struct acc_vf_migration *acc_vf_dev,
+	char __user *buf, size_t count, u64 pos, bool iswrite)
+{
+	struct vfio_device_migration_info *mig_ctl = acc_vf_dev->mig_ctl;
+	void *data_addr = acc_vf_dev->vf_data;
+	int ret = 0;
+
+	if (!count) {
+		dev_err(&acc_vf_dev->vf_dev->dev,
+			 "Qemu operation data size error!\n");
+		return -EINVAL;
+	}
+
+	data_addr += pos - mig_ctl->data_offset;
+	if (iswrite)  {
+		ret = copy_from_user(data_addr, buf, count) ?
+				     -EFAULT : count;
+		if (ret == count)
+			mig_ctl->pending_bytes += count;
+	} else {
+		ret = copy_to_user(buf, data_addr, count) ?
+				   -EFAULT : count;
+		if (ret == count)
+			mig_ctl->pending_bytes -= count;
+	}
+
+	return ret;
+}
+
+static size_t acc_vf_migration_rw(struct vfio_pci_device *vdev,
+	char __user *buf, size_t count, loff_t *ppos, bool iswrite)
+{
+	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos) -
+				VFIO_PCI_NUM_REGIONS;
+	struct vfio_pci_region	*region = &vdev->region[index];
+	struct vfio_device_migration_info *mig_ctl;
+	struct acc_vf_migration *acc_vf_dev;
+	u64 pos = *ppos & VFIO_PCI_OFFSET_MASK;
+	struct hisi_qm *qm;
+	struct device *dev;
+	u32 device_state;
+	int ret = 0;
+
+	if (!region) {
+		pr_err("Failed to get valid migration region!\n");
+		return -EINVAL;
+	}
+
+	acc_vf_dev = region->data;
+	qm = acc_vf_dev->vf_qm;
+	dev = &acc_vf_dev->vf_dev->dev;
+	mig_ctl = acc_vf_dev->mig_ctl;
+	if (pos >= region->size)
+		return -EINVAL;
+
+	count = min(count, (size_t)(region->size - pos));
+
+	switch (pos) {
+	case VDM_OFFSET(device_state):
+		if (count != sizeof(mig_ctl->device_state)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		if (iswrite) {
+			if (copy_from_user(&device_state, buf, count)) {
+				ret = -EFAULT;
+				break;
+			}
+
+			ret = acc_vf_set_device_state(acc_vf_dev,
+					   device_state) ? ret : count;
+		} else {
+			ret = copy_to_user(buf, &mig_ctl->device_state,
+					   count) ? -EFAULT : count;
+		}
+		break;
+	case VDM_OFFSET(reserved):
+		ret = -EFAULT;
+		break;
+	case VDM_OFFSET(pending_bytes):
+		if (count != sizeof(mig_ctl->pending_bytes)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		if (iswrite)
+			ret = -EFAULT;
+		else
+			ret = copy_to_user(buf, &mig_ctl->pending_bytes,
+					   count) ? -EFAULT : count;
+		break;
+	case VDM_OFFSET(data_offset):
+		if (count != sizeof(mig_ctl->data_offset)) {
+			ret = -EINVAL;
+			break;
+		}
+		if (iswrite)
+			ret = copy_from_user(&mig_ctl->data_offset, buf,
+					count) ? -EFAULT : count;
+		else
+			ret = copy_to_user(buf, &mig_ctl->data_offset,
+					count) ? -EFAULT : count;
+		break;
+	case VDM_OFFSET(data_size):
+		if (count != sizeof(mig_ctl->data_size)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		if (iswrite)
+			ret = copy_from_user(&mig_ctl->data_size, buf, count) ?
+					   -EFAULT : count;
+		else
+			ret = copy_to_user(buf, &mig_ctl->data_size, count) ?
+					   -EFAULT : count;
+		break;
+	default:
+		ret = -EFAULT;
+		break;
+	}
+
+	/* Transfer data section */
+	if (pos >= mig_ctl->data_offset &&
+	    pos < MIGRATION_REGION_SZ) {
+		ret = acc_vf_data_transfer(acc_vf_dev, buf,
+				count, pos, iswrite);
+		if (ret != count)
+			return ret;
+	}
+
+	if (mig_ctl->device_state == VFIO_DEVICE_STATE_RESUMING &&
+	    mig_ctl->pending_bytes == QM_MATCH_SIZE &&
+	    mig_ctl->data_size == QM_MATCH_SIZE) {
+		/* check the VF match information */
+		ret = vf_info_check(qm, acc_vf_dev);
+		if (ret) {
+			dev_err(dev, "failed to check match information!\n");
+			return -EFAULT;
+		}
+		ret = count;
+
+		/* clear the VF match data size */
+		mig_ctl->pending_bytes = 0;
+		mig_ctl->data_size = 0;
+	}
+
+	return ret;
+}
+
+static int acc_vf_migration_mmap(struct vfio_pci_device *vdev,
+				  struct vfio_pci_region *region,
+				  struct vm_area_struct *vma)
+{
+	return -EFAULT;
+}
+
+static void acc_vf_migration_release(struct vfio_pci_device *vdev,
+				      struct vfio_pci_region *region)
+{
+	struct acc_vf_migration *acc_vf_dev = region->data;
+
+	vfio_pci_hisilicon_acc_uninit(acc_vf_dev);
+}
+
+static int acc_vf_migration_add_capability(struct vfio_pci_device *vdev,
+		struct vfio_pci_region *region, struct vfio_info_cap *caps)
+{
+	struct vfio_region_info_cap_type cap_type;
+
+	cap_type.header.id = VFIO_REGION_INFO_CAP_TYPE;
+	cap_type.header.version = 1;
+	cap_type.type = region->type;
+	cap_type.subtype = region->subtype;
+
+	return vfio_info_add_capability(caps, &cap_type.header,
+				       sizeof(cap_type));
+}
+
+static const struct vfio_pci_regops vfio_pci_acc_regops = {
+	.rw = acc_vf_migration_rw,
+	.mmap = acc_vf_migration_mmap,
+	.release = acc_vf_migration_release,
+	.add_capability = acc_vf_migration_add_capability,
+};
+
+static int qm_acc_type_init(struct acc_vf_migration *acc_vf_dev)
+{
+	struct pci_dev *pdev = acc_vf_dev->vf_dev;
+
+	switch (pdev->device) {
+	case SEC_VF_DEVICE_ID:
+		acc_vf_dev->acc_type = HISI_SEC;
+		break;
+	case HPRE_VF_DEVICE_ID:
+		acc_vf_dev->acc_type = HISI_HPRE;
+		break;
+	case ZIP_VF_DEVICE_ID:
+		acc_vf_dev->acc_type = HISI_ZIP;
+		break;
+	default:
+		acc_vf_dev->acc_type = 0;
+		dev_err(&pdev->dev, "failed to check acc type!\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int vf_qm_pci_init(struct pci_dev *pdev, struct hisi_qm *vfqm)
+{
+	struct device *dev = &pdev->dev;
+	u32 val;
+	int ret;
+
+	ret = pci_request_mem_regions(pdev, vfqm->dev_name);
+	if (ret < 0) {
+		dev_err(dev, "failed to request mem regions!\n");
+		return ret;
+	}
+
+	vfqm->phys_base = pci_resource_start(pdev, PCI_BASE_BAR);
+	vfqm->io_base = devm_ioremap(dev,
+					pci_resource_start(pdev, PCI_BASE_BAR),
+					pci_resource_len(pdev, PCI_BASE_BAR));
+	if (!vfqm->io_base) {
+		ret = -EIO;
+		goto err_ioremap;
+	}
+
+	val = readl(vfqm->io_base + QM_QUE_ISO_CFG_V);
+	val = val & QM_QUE_ISO_MASK;
+	if (val) {
+		vfqm->db_phys_base = pci_resource_start(pdev, PCI_DB_BAR);
+		vfqm->db_io_base =
+			devm_ioremap(dev, pci_resource_start(pdev, PCI_DB_BAR),
+				       pci_resource_len(pdev, PCI_DB_BAR));
+		if (!vfqm->db_io_base) {
+			ret = -EIO;
+			goto err_db_ioremap;
+		}
+	} else {
+		vfqm->db_phys_base = vfqm->phys_base;
+		vfqm->db_io_base = vfqm->io_base;
+	}
+
+	vfqm->pdev = pdev;
+	mutex_init(&vfqm->mailbox_lock);
+
+	/*
+	 * Allow VF devices to be loaded in VM when
+	 * it loaded in migration driver
+	 */
+	pci_release_mem_regions(pdev);
+
+	return 0;
+
+err_db_ioremap:
+	devm_iounmap(dev, vfqm->io_base);
+err_ioremap:
+	pci_release_mem_regions(pdev);
+	return ret;
+}
+
+static int acc_vf_dev_init(struct pci_dev *pdev, struct hisi_qm *pf_qm,
+			struct acc_vf_migration *acc_vf_dev)
+{
+	struct vfio_device_migration_info *mig_ctl;
+	struct hisi_qm *vf_qm;
+	__u64 mig_offset;
+	void *vf_data;
+	int ret;
+
+	vf_qm = kzalloc(sizeof(*vf_qm), GFP_KERNEL);
+	if (!vf_qm)
+		return -ENOMEM;
+
+	/* get vf qm dev name from pf */
+	vf_qm->dev_name = pf_qm->dev_name;
+	vf_qm->fun_type = QM_HW_VF;
+	acc_vf_dev->vf_qm = vf_qm;
+	acc_vf_dev->pf_qm = pf_qm;
+
+	ret = vf_qm_pci_init(pdev, vf_qm);
+	if (ret)
+		goto init_qm_error;
+
+	ret = qm_acc_type_init(acc_vf_dev);
+	if (ret)
+		goto init_qm_error;
+
+	/* the data region must follow migration info */
+	mig_offset = sizeof(*mig_ctl);
+	mig_ctl = kzalloc(MIGRATION_REGION_SZ, GFP_KERNEL);
+	if (!mig_ctl)
+		goto init_qm_error;
+
+	acc_vf_dev->mig_ctl = mig_ctl;
+
+	vf_data = (void *)mig_ctl + mig_offset;
+	acc_vf_dev->vf_data = vf_data;
+
+	mig_ctl->device_state = VFIO_DEVICE_STATE_RUNNING;
+	mig_ctl->data_offset = mig_offset;
+	mig_ctl->data_size = sizeof(struct acc_vf_data);
+
+	return 0;
+
+init_qm_error:
+	kfree(vf_qm);
+	return -ENOMEM;
+}
+
+static int pci_dev_id_check(struct pci_dev *pdev)
+{
+	switch (pdev->device) {
+	case SEC_VF_DEVICE_ID:
+	case HPRE_VF_DEVICE_ID:
+	case ZIP_VF_DEVICE_ID:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int vfio_pci_hisilicon_acc_init(struct vfio_pci_device *vdev)
+{
+	struct acc_vf_migration *acc_vf_dev;
+	struct pci_dev *pdev = vdev->pdev;
+	struct pci_dev *pf_dev, *vf_dev;
+	struct hisi_qm *pf_qm;
+	int vf_id, ret;
+
+	pf_dev = pdev->physfn;
+	vf_dev = pdev;
+
+	if (pci_dev_id_check(vf_dev)) {
+		dev_err(&pdev->dev, "device not match migration!\n");
+		return -ENODEV;
+	}
+
+	pf_qm = pci_get_drvdata(pf_dev);
+	if (!pf_qm) {
+		dev_err(&pdev->dev, "host qm driver not insmod!\n");
+		return -EINVAL;
+	}
+	if (pf_qm->ver < QM_HW_V3) {
+		dev_err(&pdev->dev,
+			 "device can't support migration! version: 0x%x\n",
+			 pf_qm->ver);
+		return -ENODEV;
+	}
+
+	vf_id = PCI_FUNC(vf_dev->devfn);
+	acc_vf_dev = kzalloc(sizeof(*acc_vf_dev), GFP_KERNEL);
+	if (!acc_vf_dev)
+		return -ENOMEM;
+
+	if (pci_num_vf(pf_dev) <= 0) {
+		dev_info(&pdev->dev, "vf device: %s, vf id: %d\n",
+			  pf_qm->dev_name, vf_id);
+		return -EINVAL;
+	}
+	acc_vf_dev->vf_id = vf_id;
+	acc_vf_dev->pf_dev = pf_dev;
+	acc_vf_dev->vf_dev = vf_dev;
+	mutex_init(&acc_vf_dev->reflock);
+
+	ret = acc_vf_dev_init(pdev, pf_qm, acc_vf_dev);
+	if (ret) {
+		kfree(acc_vf_dev);
+		return -ENOMEM;
+	}
+
+	ret = vfio_pci_register_dev_region(vdev,
+						VFIO_REGION_TYPE_MIGRATION,
+						VFIO_REGION_SUBTYPE_MIGRATION,
+						&vfio_pci_acc_regops,
+						MIGRATION_REGION_SZ,
+						VFIO_REGION_INFO_FLAG_READ |
+						VFIO_REGION_INFO_FLAG_WRITE,
+						acc_vf_dev);
+	if (ret) {
+		dev_info(&pdev->dev, "register vfio_pci_acc_regops Error!\n");
+		goto register_error;
+	}
+
+	return 0;
+
+register_error:
+	vfio_pci_hisilicon_acc_uninit(acc_vf_dev);
+	return ret;
+}
+
+void vfio_pci_hisilicon_acc_uninit(struct acc_vf_migration *acc_vf_dev)
+{
+	struct device *dev = &acc_vf_dev->vf_dev->dev;
+	struct hisi_qm *qm = acc_vf_dev->vf_qm;
+
+	kfree(acc_vf_dev->mig_ctl);
+	acc_vf_dev->mig_ctl = NULL;
+
+	devm_iounmap(dev, qm->io_base);
+	kfree(qm);
+
+	kfree(acc_vf_dev->regions);
+	acc_vf_dev->regions = NULL;
+	acc_vf_dev->num_regions = 0;
+
+	kfree(acc_vf_dev);
+}
+
diff --git a/drivers/vfio/pci/hisilicon/acc_vf_migration.h b/drivers/vfio/pci/hisilicon/acc_vf_migration.h
new file mode 100644
index 0000000..26c79e4
--- /dev/null
+++ b/drivers/vfio/pci/hisilicon/acc_vf_migration.h
@@ -0,0 +1,170 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2021 HiSilicon Limited. */
+
+#ifndef ACC_MIG_H
+#define ACC_MIG_H
+
+#include <linux/mdev.h>
+#include <linux/pci.h>
+#include <linux/vfio.h>
+
+#include "../vfio_pci_private.h"
+#include "../../../drivers/crypto/hisilicon/qm.h"
+
+#define MIGRATION_REGION_SZ (sizeof(struct acc_vf_data) + \
+			      sizeof(struct vfio_device_migration_info))
+#define VFIO_DEV_DBG_LEN		256
+#define VFIO_DBG_LOG_LEN		16
+#define VFIO_DEVFN_MASK		0xFF
+#define SEC_VF_DEVICE_ID		0xa256
+#define HPRE_VF_DEVICE_ID		0xa259
+#define ZIP_VF_DEVICE_ID		0xa251
+
+#define PCI_BASE_BAR			2
+#define PCI_DB_BAR			4
+#define MB_POLL_PERIOD_US		10
+#define MB_POLL_TIMEOUT_US		1000
+#define QM_CACHE_WB_START		0x204
+#define QM_CACHE_WB_DONE		0x208
+#define QM_MB_CMD_PAUSE_QM		0xe
+#define QM_ABNORMAL_INT_STATUS	0x100008
+#define QM_IFC_INT_STATUS		0x0028
+#define SEC_CORE_INT_STATUS		0x301008
+#define HPRE_HAC_INT_STATUS		0x301800
+#define HZIP_CORE_INT_STATUS		0x3010AC
+#define ERROR_CHECK_TIMEOUT		100
+#define CHECK_DELAY_TIME		100
+#define QM_QUE_ISO_MASK		0x01
+
+#define QM_SQC_VFT_BASE_SHIFT_V2	28
+#define QM_SQC_VFT_BASE_MASK_V2	GENMASK(15, 0)
+#define QM_SQC_VFT_NUM_SHIFT_V2	45
+#define QM_SQC_VFT_NUM_MASK_V2	GENMASK(9, 0)
+
+/* mailbox */
+#define QM_MB_CMD_SQC_BT		0x4
+#define QM_MB_CMD_CQC_BT		0x5
+#define QM_MB_CMD_SQC_VFT_V2		0x6
+
+#define QM_MB_CMD_SEND_BASE		0x300
+#define QM_MB_BUSY_SHIFT		13
+#define QM_MB_OP_SHIFT			14
+#define QM_MB_CMD_DATA_ADDR_L		0x304
+#define QM_MB_CMD_DATA_ADDR_H		0x308
+#define QM_MB_MAX_WAIT_CNT		6000
+
+/* doorbell */
+#define QM_DOORBELL_CMD_SQ		0
+#define QM_DOORBELL_CMD_CQ		1
+#define QM_DOORBELL_SQ_CQ_BASE_V2	0x1000
+#define QM_DOORBELL_EQ_AEQ_BASE_V2	0x2000
+#define QM_DB_CMD_SHIFT_V2		12
+#define QM_DB_RAND_SHIFT_V2		16
+#define QM_DB_INDEX_SHIFT_V2		32
+#define QM_DB_PRIORITY_SHIFT_V2	48
+
+/* RW regs */
+#define QM_REGS_MAX_LEN		7
+#define QM_REG_ADDR_OFFSET		0x0004
+
+#define QM_XQC_ADDR_OFFSET		32U
+#define QM_VF_AEQ_INT_MASK		0x0004
+#define QM_VF_EQ_INT_MASK		0x000c
+#define QM_IFC_INT_SOURCE_V		0x0020
+#define QM_IFC_INT_MASK		0x0024
+#define QM_IFC_INT_SET_V		0x002c
+#define QM_QUE_ISO_CFG_V		0x0030
+
+#define QM_EQC_DW0		0X3000
+#define QM_AEQC_DW0		0X3020
+
+struct qm_mailbox {
+	__le16 w0;
+	__le16 queue_num;
+	__le32 base_l;
+	__le32 base_h;
+	__le32 rsvd;
+};
+
+enum acc_type {
+	HISI_SEC = 0x1,
+	HISI_HPRE = 0x2,
+	HISI_ZIP = 0x3,
+};
+
+struct vf_acc_type {
+	const char *name;
+	u32 type;
+};
+
+enum mig_debug_cmd {
+	STATE_SAVE,
+	STATE_RESUME,
+	MB_TEST,
+	MIG_DATA_DUMP,
+	MIG_DEV_SHOW,
+};
+
+static const char * const vf_dev_state[] = {
+	"Stop",
+	"Running",
+	"Saving",
+	"Running & Saving",
+	"Resuming",
+};
+
+#define QM_MATCH_SIZE		32L
+struct acc_vf_data {
+	/* QM match information */
+	u32 qp_num;
+	u32 acc_type;
+	u32 que_iso_cfg;
+	u32 qp_base;
+	/* QM reserved 4 match information */
+	u32 qm_rsv_state[4];
+
+	/* QM RW regs */
+	u32 aeq_int_mask;
+	u32 eq_int_mask;
+	u32 ifc_int_source;
+	u32 ifc_int_mask;
+	u32 ifc_int_set;
+
+	/*
+	 * QM_VF_MB has 4 regs don't need to migration
+	 * mailbox regs writeback value will cause
+	 * hardware to perform command operations
+	 */
+
+	/* QM_EQC_DW has 7 regs */
+	u32 qm_eqc_dw[7];
+
+	/* QM_AEQC_DW has 7 regs */
+	u32 qm_aeqc_dw[7];
+
+	/* QM reserved 5 regs */
+	u32 qm_rsv_regs[5];
+
+	/* qm memory init information */
+	dma_addr_t eqe_dma;
+	dma_addr_t aeqe_dma;
+	dma_addr_t sqc_dma;
+	dma_addr_t cqc_dma;
+};
+
+struct acc_vf_migration {
+	struct pci_dev			*pf_dev;
+	struct pci_dev			*vf_dev;
+	struct hisi_qm			*pf_qm;
+	struct hisi_qm			*vf_qm;
+	int				vf_id;
+	u8				acc_type;
+
+	struct vfio_device_migration_info *mig_ctl;
+	struct acc_vf_data		*vf_data;
+	struct vfio_pci_region		*regions;
+	int				num_regions;
+};
+
+#endif /* ACC_MIG_H */
+
-- 
2.8.1

