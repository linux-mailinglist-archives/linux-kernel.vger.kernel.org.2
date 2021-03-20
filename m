Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D07342C36
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 12:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCTLbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 07:31:03 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14109 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhCTLaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 07:30:22 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F2dmm33lDz17NHn;
        Sat, 20 Mar 2021 19:28:24 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 20 Mar 2021 19:30:13 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 4/4] crypto: hisilicon/qm - add queue isolation support for Kunpeng930
Date:   Sat, 20 Mar 2021 19:27:46 +0800
Message-ID: <1616239666-43572-5-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616239666-43572-1-git-send-email-qianweili@huawei.com>
References: <1616239666-43572-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kunpeng930 supports doorbell isolation to ensure that each queue
has an independent doorbell address space.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/qm.c     | 161 +++++++++++++++++++++++++++-----------
 drivers/crypto/hisilicon/qm.h     |   4 +-
 include/uapi/misc/uacce/hisi_qm.h |   1 +
 3 files changed, 118 insertions(+), 48 deletions(-)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 683ee0c..478117c 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -97,6 +97,7 @@
 #define QM_QUE_ISO_EN			0x100154
 #define QM_CAPBILITY			0x100158
 #define QM_QP_NUN_MASK			GENMASK(10, 0)
+#define QM_QP_DB_INTERVAL		0x10000
 #define QM_QP_MAX_NUM_SHIFT		11
 #define QM_DB_CMD_SHIFT_V2		12
 #define QM_DB_RAND_SHIFT_V2		16
@@ -186,6 +187,7 @@
 #define QM_CACHE_WB_DONE		0x208
 
 #define PCI_BAR_2			2
+#define PCI_BAR_4			4
 #define QM_SQE_DATA_ALIGN_MASK		GENMASK(6, 0)
 #define QMC_ALIGN(sz)			ALIGN(sz, 32)
 
@@ -571,21 +573,22 @@ static void qm_db_v1(struct hisi_qm *qm, u16 qn, u8 cmd, u16 index, u8 priority)
 
 static void qm_db_v2(struct hisi_qm *qm, u16 qn, u8 cmd, u16 index, u8 priority)
 {
-	u64 doorbell;
-	u64 dbase;
+	void __iomem *io_base = qm->io_base;
 	u16 randata = 0;
+	u64 doorbell;
 
 	if (cmd == QM_DOORBELL_CMD_SQ || cmd == QM_DOORBELL_CMD_CQ)
-		dbase = QM_DOORBELL_SQ_CQ_BASE_V2;
+		io_base = qm->db_io_base + (u64)qn * qm->db_interval +
+			  QM_DOORBELL_SQ_CQ_BASE_V2;
 	else
-		dbase = QM_DOORBELL_EQ_AEQ_BASE_V2;
+		io_base += QM_DOORBELL_EQ_AEQ_BASE_V2;
 
 	doorbell = qn | ((u64)cmd << QM_DB_CMD_SHIFT_V2) |
 		   ((u64)randata << QM_DB_RAND_SHIFT_V2) |
 		   ((u64)index << QM_DB_INDEX_SHIFT_V2)	 |
 		   ((u64)priority << QM_DB_PRIORITY_SHIFT_V2);
 
-	writeq(doorbell, qm->io_base + dbase);
+	writeq(doorbell, io_base);
 }
 
 static void qm_db(struct hisi_qm *qm, u16 qn, u8 cmd, u16 index, u8 priority)
@@ -2201,6 +2204,8 @@ static int hisi_qm_uacce_mmap(struct uacce_queue *q,
 {
 	struct hisi_qp *qp = q->priv;
 	struct hisi_qm *qm = qp->qm;
+	resource_size_t phys_base = qm->db_phys_base +
+				    qp->qp_id * qm->db_interval;
 	size_t sz = vma->vm_end - vma->vm_start;
 	struct pci_dev *pdev = qm->pdev;
 	struct device *dev = &pdev->dev;
@@ -2212,16 +2217,19 @@ static int hisi_qm_uacce_mmap(struct uacce_queue *q,
 		if (qm->ver == QM_HW_V1) {
 			if (sz > PAGE_SIZE * QM_DOORBELL_PAGE_NR)
 				return -EINVAL;
-		} else {
+		} else if (qm->ver == QM_HW_V2 || !qm->use_db_isolation) {
 			if (sz > PAGE_SIZE * (QM_DOORBELL_PAGE_NR +
 			    QM_DOORBELL_SQ_CQ_BASE_V2 / PAGE_SIZE))
 				return -EINVAL;
+		} else {
+			if (sz > qm->db_interval)
+				return -EINVAL;
 		}
 
 		vma->vm_flags |= VM_IO;
 
 		return remap_pfn_range(vma, vma->vm_start,
-				       qm->phys_base >> PAGE_SHIFT,
+				       phys_base >> PAGE_SHIFT,
 				       sz, pgprot_noncached(vma->vm_page_prot));
 	case UACCE_QFRT_DUS:
 		if (sz != qp->qdma.size)
@@ -2336,14 +2344,20 @@ static int qm_alloc_uacce(struct hisi_qm *qm)
 	uacce->priv = qm;
 	uacce->algs = qm->algs;
 
-	if (qm->ver == QM_HW_V1) {
-		mmio_page_nr = QM_DOORBELL_PAGE_NR;
+	if (qm->ver == QM_HW_V1)
 		uacce->api_ver = HISI_QM_API_VER_BASE;
-	} else {
+	else if (qm->ver == QM_HW_V2)
+		uacce->api_ver = HISI_QM_API_VER2_BASE;
+	else
+		uacce->api_ver = HISI_QM_API_VER3_BASE;
+
+	if (qm->ver == QM_HW_V1)
+		mmio_page_nr = QM_DOORBELL_PAGE_NR;
+	else if (qm->ver == QM_HW_V2 || !qm->use_db_isolation)
 		mmio_page_nr = QM_DOORBELL_PAGE_NR +
 			QM_DOORBELL_SQ_CQ_BASE_V2 / PAGE_SIZE;
-		uacce->api_ver = HISI_QM_API_VER2_BASE;
-	}
+	else
+		mmio_page_nr = qm->db_interval / PAGE_SIZE;
 
 	dus_page_nr = (PAGE_SIZE - 1 + qm->sqe_size * QM_Q_DEPTH +
 		       sizeof(struct qm_cqe) * QM_Q_DEPTH) >> PAGE_SHIFT;
@@ -2561,13 +2575,23 @@ static void hisi_qm_pre_init(struct hisi_qm *qm)
 	qm->misc_ctl = false;
 }
 
-static void hisi_qm_pci_uninit(struct hisi_qm *qm)
+static void qm_put_pci_res(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
 
-	pci_free_irq_vectors(pdev);
+	if (qm->use_db_isolation)
+		iounmap(qm->db_io_base);
+
 	iounmap(qm->io_base);
 	pci_release_mem_regions(pdev);
+}
+
+static void hisi_qm_pci_uninit(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+
+	pci_free_irq_vectors(pdev);
+	qm_put_pci_res(qm);
 	pci_disable_device(pdev);
 }
 
@@ -4236,61 +4260,104 @@ static int qm_get_qp_num(struct hisi_qm *qm)
 	return 0;
 }
 
-static int hisi_qm_pci_init(struct hisi_qm *qm)
+static int qm_get_pci_res(struct hisi_qm *qm)
 {
 	struct pci_dev *pdev = qm->pdev;
 	struct device *dev = &pdev->dev;
-	unsigned int num_vec;
 	int ret;
 
-	ret = pci_enable_device_mem(pdev);
-	if (ret < 0) {
-		dev_err(dev, "Failed to enable device mem!\n");
-		return ret;
-	}
-
 	ret = pci_request_mem_regions(pdev, qm->dev_name);
 	if (ret < 0) {
 		dev_err(dev, "Failed to request mem regions!\n");
-		goto err_disable_pcidev;
+		return ret;
 	}
 
 	qm->phys_base = pci_resource_start(pdev, PCI_BAR_2);
-	qm->phys_size = pci_resource_len(qm->pdev, PCI_BAR_2);
-	qm->io_base = ioremap(qm->phys_base, qm->phys_size);
+	qm->io_base = ioremap(qm->phys_base, pci_resource_len(pdev, PCI_BAR_2));
 	if (!qm->io_base) {
 		ret = -EIO;
-		goto err_release_mem_regions;
+		goto err_request_mem_regions;
+	}
+
+	if (qm->ver > QM_HW_V2) {
+		if (qm->fun_type == QM_HW_PF)
+			qm->use_db_isolation = readl(qm->io_base +
+						     QM_QUE_ISO_EN) & BIT(0);
+		else
+			qm->use_db_isolation = readl(qm->io_base +
+						     QM_QUE_ISO_CFG_V) & BIT(0);
+	}
+
+	if (qm->use_db_isolation) {
+		qm->db_interval = QM_QP_DB_INTERVAL;
+		qm->db_phys_base = pci_resource_start(pdev, PCI_BAR_4);
+		qm->db_io_base = ioremap(qm->db_phys_base,
+					 pci_resource_len(pdev, PCI_BAR_4));
+		if (!qm->db_io_base) {
+			ret = -EIO;
+			goto err_ioremap;
+		}
+	} else {
+		qm->db_phys_base = qm->phys_base;
+		qm->db_io_base = qm->io_base;
+		qm->db_interval = 0;
 	}
 
 	if (qm->fun_type == QM_HW_PF) {
 		ret = qm_get_qp_num(qm);
 		if (ret)
-			goto err_iounmap;
+			goto err_db_ioremap;
 	}
 
+	return 0;
+
+err_db_ioremap:
+	if (qm->use_db_isolation)
+		iounmap(qm->db_io_base);
+err_ioremap:
+	iounmap(qm->io_base);
+err_request_mem_regions:
+	pci_release_mem_regions(pdev);
+	return ret;
+}
+
+static int hisi_qm_pci_init(struct hisi_qm *qm)
+{
+	struct pci_dev *pdev = qm->pdev;
+	struct device *dev = &pdev->dev;
+	unsigned int num_vec;
+	int ret;
+
+	ret = pci_enable_device_mem(pdev);
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable device mem!\n");
+		return ret;
+	}
+
+	ret = qm_get_pci_res(qm);
+	if (ret)
+		goto err_disable_pcidev;
+
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
 	if (ret < 0)
-		goto err_iounmap;
+		goto err_get_pci_res;
 	pci_set_master(pdev);
 
 	if (!qm->ops->get_irq_num) {
 		ret = -EOPNOTSUPP;
-		goto err_iounmap;
+		goto err_get_pci_res;
 	}
 	num_vec = qm->ops->get_irq_num(qm);
 	ret = pci_alloc_irq_vectors(pdev, num_vec, num_vec, PCI_IRQ_MSI);
 	if (ret < 0) {
 		dev_err(dev, "Failed to enable MSI vectors!\n");
-		goto err_iounmap;
+		goto err_get_pci_res;
 	}
 
 	return 0;
 
-err_iounmap:
-	iounmap(qm->io_base);
-err_release_mem_regions:
-	pci_release_mem_regions(pdev);
+err_get_pci_res:
+	qm_put_pci_res(qm);
 err_disable_pcidev:
 	pci_disable_device(pdev);
 	return ret;
@@ -4310,28 +4377,28 @@ int hisi_qm_init(struct hisi_qm *qm)
 
 	hisi_qm_pre_init(qm);
 
-	ret = qm_alloc_uacce(qm);
-	if (ret < 0)
-		dev_warn(dev, "fail to alloc uacce (%d)\n", ret);
-
 	ret = hisi_qm_pci_init(qm);
 	if (ret)
-		goto err_remove_uacce;
+		return ret;
 
 	ret = qm_irq_register(qm);
 	if (ret)
-		goto err_pci_uninit;
+		goto err_pci_init;
 
 	if (qm->fun_type == QM_HW_VF && qm->ver != QM_HW_V1) {
 		/* v2 starts to support get vft by mailbox */
 		ret = hisi_qm_get_vft(qm, &qm->qp_base, &qm->qp_num);
 		if (ret)
-			goto err_irq_unregister;
+			goto err_irq_register;
 	}
 
+	ret = qm_alloc_uacce(qm);
+	if (ret < 0)
+		dev_warn(dev, "fail to alloc uacce (%d)\n", ret);
+
 	ret = hisi_qm_memory_init(qm);
 	if (ret)
-		goto err_irq_unregister;
+		goto err_alloc_uacce;
 
 	INIT_WORK(&qm->work, qm_work_process);
 	if (qm->fun_type == QM_HW_PF)
@@ -4341,13 +4408,13 @@ int hisi_qm_init(struct hisi_qm *qm)
 
 	return 0;
 
-err_irq_unregister:
-	qm_irq_unregister(qm);
-err_pci_uninit:
-	hisi_qm_pci_uninit(qm);
-err_remove_uacce:
+err_alloc_uacce:
 	uacce_remove(qm->uacce);
 	qm->uacce = NULL;
+err_irq_register:
+	qm_irq_unregister(qm);
+err_pci_init:
+	hisi_qm_pci_uninit(qm);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hisi_qm_init);
diff --git a/drivers/crypto/hisilicon/qm.h b/drivers/crypto/hisilicon/qm.h
index cf0290f..34e69fe 100644
--- a/drivers/crypto/hisilicon/qm.h
+++ b/drivers/crypto/hisilicon/qm.h
@@ -202,6 +202,7 @@ struct hisi_qm {
 	const char *dev_name;
 	struct pci_dev *pdev;
 	void __iomem *io_base;
+	void __iomem *db_io_base;
 	u32 sqe_size;
 	u32 qp_base;
 	u32 qp_num;
@@ -209,6 +210,7 @@ struct hisi_qm {
 	u32 ctrl_qp_num;
 	u32 max_qp_num;
 	u32 vfs_num;
+	u32 db_interval;
 	struct list_head list;
 	struct hisi_qm_list *qm_list;
 
@@ -250,7 +252,7 @@ struct hisi_qm {
 	/* doorbell isolation enable */
 	bool use_db_isolation;
 	resource_size_t phys_base;
-	resource_size_t phys_size;
+	resource_size_t db_phys_base;
 	struct uacce_device *uacce;
 	int mode;
 };
diff --git a/include/uapi/misc/uacce/hisi_qm.h b/include/uapi/misc/uacce/hisi_qm.h
index 6435f0b..1faef5f 100644
--- a/include/uapi/misc/uacce/hisi_qm.h
+++ b/include/uapi/misc/uacce/hisi_qm.h
@@ -16,6 +16,7 @@ struct hisi_qp_ctx {
 
 #define HISI_QM_API_VER_BASE "hisi_qm_v1"
 #define HISI_QM_API_VER2_BASE "hisi_qm_v2"
+#define HISI_QM_API_VER3_BASE "hisi_qm_v3"
 
 /* UACCE_CMD_QM_SET_QP_CTX: Set qp algorithm type */
 #define UACCE_CMD_QM_SET_QP_CTX	_IOWR('H', 10, struct hisi_qp_ctx)
-- 
2.8.1

