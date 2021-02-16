Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F0731CDC7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 17:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhBPQO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 11:14:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:31316 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230390AbhBPQN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 11:13:59 -0500
IronPort-SDR: bTAYinKGHtESog4U20xq8t4+O9CY8hQcM2SBLaHohmHduuTFC3a3fD1uNmdrf+6JKIOKzd6ak0
 mFd7ZTETEu7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="202118699"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="202118699"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:08:17 -0800
IronPort-SDR: qtFlbmjBping8LqhHBN2mM8jUBrLUy2Ha/TLM202xBwnfNlfpbnx2JUxM+fmuSVKd7+B2Tx07N
 MN2uwTWY2S5w==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="493336758"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 08:08:14 -0800
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Anisha Dattatraya Kulkarni 
        <anisha.dattatraya.kulkarni@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: [PATCH v1 09/12] gna: add a work queue to process scoring requests
Date:   Tue, 16 Feb 2021 17:05:22 +0100
Message-Id: <20210216160525.5028-10-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
References: <20210216160525.5028-1-maciej.kwapulinski@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomasz Jankowski <tomasz1.jankowski@intel.com>

The new workqueue is responsible to process the list of requests
in a FIFO manner. It waits for the hardware to complete	on every
request until it is woken up by an interrupt that will be addressed
in following changes.

Signed-off-by: Tomasz Jankowski <tomasz1.jankowski@intel.com>
Co-developed-by: Anisha Dattatraya Kulkarni <anisha.dattatraya.kulkarni@intel.com>
Signed-off-by: Anisha Dattatraya Kulkarni <anisha.dattatraya.kulkarni@intel.com>
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Co-developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/gna/gna_device.c  |  21 +++++-
 drivers/misc/gna/gna_device.h  |   8 +++
 drivers/misc/gna/gna_driver.c  |   5 ++
 drivers/misc/gna/gna_hw.c      |   8 +++
 drivers/misc/gna/gna_hw.h      |   1 +
 drivers/misc/gna/gna_request.c | 119 +++++++++++++++++++++++++++++++++
 drivers/misc/gna/gna_request.h |   1 +
 7 files changed, 162 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/gna/gna_device.c b/drivers/misc/gna/gna_device.c
index 7a1888824ea1..a229f51fb17b 100644
--- a/drivers/misc/gna/gna_device.c
+++ b/drivers/misc/gna/gna_device.c
@@ -89,6 +89,7 @@ static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 			const struct pci_device_id *pci_id)
 {
 	u32 bld_reg;
+	int ret;
 
 	pci_set_drvdata(pcidev, gna_priv);
 
@@ -102,7 +103,9 @@ static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 
 	if (gna_mmu_alloc(gna_priv)) {
 		dev_err(&gna_priv->dev, "gna mmu allocation failed\n");
-		return -EFAULT;
+		ret = -EFAULT;
+		goto err_pci_drvdata_unset;
+
 	}
 	dev_dbg(&pcidev->dev, "maximum memory size %llu num pd %d\n",
 		gna_priv->info.max_hw_mem, gna_priv->info.num_pagetables);
@@ -111,6 +114,7 @@ static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 		gna_priv->info.desc_info.mmu_info.vamax_size);
 
 	mutex_init(&gna_priv->mmu_lock);
+	init_waitqueue_head(&gna_priv->busy_waitq);
 
 	mutex_init(&gna_priv->filelist_lock);
 	INIT_LIST_HEAD(&gna_priv->file_list);
@@ -119,15 +123,30 @@ static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 
 	idr_init(&gna_priv->memory_idr);
 	mutex_init(&gna_priv->memidr_lock);
+
+	gna_priv->request_wq = create_singlethread_workqueue("gna_request_wq");
+	if (!gna_priv->request_wq) {
+		dev_err(&pcidev->dev, "could not create wq for gna device\n");
+		ret = -EFAULT;
+		goto err_pci_drvdata_unset;
+	}
 	mutex_init(&gna_priv->reqlist_lock);
 	INIT_LIST_HEAD(&gna_priv->request_list);
 
 	return 0;
+
+err_pci_drvdata_unset:
+	pci_set_drvdata(pcidev, NULL);
+
+	return ret;
 }
 
 /* Reverse gna_dev_init() */
 static void gna_dev_deinit(struct gna_private *gna_priv)
 {
+	flush_workqueue(gna_priv->request_wq);
+	destroy_workqueue(gna_priv->request_wq);
+
 	idr_destroy(&gna_priv->memory_idr);
 	gna_mmu_free(gna_priv);
 	pci_set_drvdata(gna_priv->pdev, NULL);
diff --git a/drivers/misc/gna/gna_device.h b/drivers/misc/gna/gna_device.h
index 59b074704d1a..0855972cd085 100644
--- a/drivers/misc/gna/gna_device.h
+++ b/drivers/misc/gna/gna_device.h
@@ -46,6 +46,8 @@ struct gna_private {
 	struct device dev;
 	struct cdev cdev;
 
+	u32 hw_status;
+
 	/* device related resources */
 	struct gna_pci_bar bar0;
 	struct gna_drv_info info;
@@ -55,9 +57,15 @@ struct gna_private {
 	/* lock protecting mmu structure */
 	struct mutex mmu_lock;
 
+	/* device busy indicator */
+	bool busy;
+
+	struct wait_queue_head busy_waitq;
+
 	/* requests */
 	struct list_head request_list;
 	struct mutex reqlist_lock;	/* protects request_list */
+	struct workqueue_struct *request_wq;
 	atomic_t request_count;
 
 	/* memory objects */
diff --git a/drivers/misc/gna/gna_driver.c b/drivers/misc/gna/gna_driver.c
index 80981c448f3a..cb638dfa81ac 100644
--- a/drivers/misc/gna/gna_driver.c
+++ b/drivers/misc/gna/gna_driver.c
@@ -9,6 +9,11 @@
 #include "gna_device.h"
 #include "gna_driver.h"
 
+/* recovery timeout in seconds */
+int recovery_timeout = 60;
+module_param(recovery_timeout, int, 0644);
+MODULE_PARM_DESC(recovery_timeout, "Recovery timeout");
+
 struct gna_driver_private gna_drv_priv;
 
 struct class *gna_class;
diff --git a/drivers/misc/gna/gna_hw.c b/drivers/misc/gna/gna_hw.c
index 3b85c4b75fd8..48e09e5f3ca8 100644
--- a/drivers/misc/gna/gna_hw.c
+++ b/drivers/misc/gna/gna_hw.c
@@ -49,6 +49,14 @@ void gna_print_error_status(struct gna_private *gna_priv, u32 hw_status)
 		dev_dbg(&gna_priv->dev, "GNA error: Saturation Reached !\n");
 }
 
+bool gna_hw_perf_enabled(struct gna_private *gna_priv)
+{
+	void __iomem *addr = gna_priv->bar0.mem_addr;
+	u32 ctrl = gna_reg_read(addr, GNA_MMIO_CTRL);
+
+	return FIELD_GET(GNA_CTRL_COMP_STATS_EN, ctrl) ? true : false;
+}
+
 void gna_start_scoring(struct gna_private *gna_priv, void __iomem *addr,
 		       struct gna_compute_cfg *compute_cfg)
 {
diff --git a/drivers/misc/gna/gna_hw.h b/drivers/misc/gna/gna_hw.h
index 941f54b0f29a..4da29870c4dc 100644
--- a/drivers/misc/gna/gna_hw.h
+++ b/drivers/misc/gna/gna_hw.h
@@ -71,6 +71,7 @@ struct gna_private;
 struct gna_compute_cfg;
 
 void gna_abort_hw(struct gna_private *gna_priv);
+bool gna_hw_perf_enabled(struct gna_private *gna_priv);
 int gna_parse_hw_status(struct gna_private *gna_priv, u32 hw_status);
 void gna_print_error_status(struct gna_private *gna_priv, u32 hw_status);
 void gna_start_scoring(struct gna_private *gna_priv, void __iomem *addr,
diff --git a/drivers/misc/gna/gna_request.c b/drivers/misc/gna/gna_request.c
index a7a55fe68eed..3957d45223d4 100644
--- a/drivers/misc/gna/gna_request.c
+++ b/drivers/misc/gna/gna_request.c
@@ -8,7 +8,121 @@
 
 #include "gna_device.h"
 #include "gna_driver.h"
+#include "gna_hw.h"
 #include "gna_request.h"
+#include "gna_score.h"
+
+static void gna_request_update_status(struct gna_request *score_request)
+{
+	struct gna_private *gna_priv = score_request->gna_priv;
+	void __iomem *addr = gna_priv->bar0.mem_addr;
+	/* The gna_priv's hw_status should be updated first */
+	u32 hw_status = gna_priv->hw_status;
+	u32 stall_cycles;
+	u32 total_cycles;
+
+	/* Technically, the time stamp can be a bit later than
+	 * when the hw actually completed scoring. Here we just
+	 * do our best in a deferred work, unless we want to
+	 * tax isr for a more accurate record.
+	 */
+	score_request->drv_perf.hw_completed = ktime_get_ns();
+
+	score_request->hw_status = hw_status;
+
+	score_request->status = gna_parse_hw_status(gna_priv, hw_status);
+
+	if (gna_hw_perf_enabled(gna_priv)) {
+		if (hw_status & GNA_STS_STATISTICS_VALID) {
+			total_cycles = gna_reg_read(addr, GNA_MMIO_PTC);
+			stall_cycles = gna_reg_read(addr, GNA_MMIO_PSC);
+			score_request->hw_perf.total = total_cycles;
+			score_request->hw_perf.stall = stall_cycles;
+		} else
+			dev_warn(&gna_priv->dev, "GNA statistics missing\n");
+	}
+	if (unlikely(hw_status & GNA_ERROR))
+		gna_print_error_status(gna_priv, hw_status);
+}
+
+static void gna_request_process(struct work_struct *work)
+{
+	struct gna_request *score_request;
+	struct gna_memory_object *mo;
+	struct gna_private *gna_priv;
+	struct gna_buffer *buffer;
+	unsigned long hw_timeout;
+	int ret;
+	u64 i;
+
+	score_request = container_of(work, struct gna_request, work);
+	gna_priv = score_request->gna_priv;
+	dev_dbg(&gna_priv->dev, "processing request %llu\n", score_request->request_id);
+
+	score_request->state = ACTIVE;
+
+	score_request->drv_perf.pre_processing = ktime_get_ns();
+
+	/* Set busy flag before kicking off HW. The isr will clear it and wake up us. There is
+	 * no difference if isr is missed in a timeout situation of the last request. We just
+	 * always set it busy and let the wait_event_timeout check the reset.
+	 * wq:  X -> true
+	 * isr: X -> false
+	 */
+	gna_priv->busy = true;
+
+	ret = gna_priv_score(score_request);
+	if (ret) {
+		score_request->status = ret;
+		goto end;
+	}
+
+	score_request->drv_perf.processing = ktime_get_ns();
+
+	hw_timeout = msecs_to_jiffies(recovery_timeout * 1000);
+
+	/* Wait for HW to finish the current request. */
+	hw_timeout = wait_event_timeout(gna_priv->busy_waitq,
+			!gna_priv->busy, hw_timeout);
+
+	if (!hw_timeout)
+		dev_warn(&gna_priv->dev, "hardware timeout occurred\n");
+
+	/* Update HW status */
+	gna_priv->hw_status = gna_reg_read(gna_priv->bar0.mem_addr, GNA_MMIO_STS);
+
+	gna_request_update_status(score_request);
+	gna_abort_hw(gna_priv);
+
+	/* request post-processing */
+	buffer = score_request->buffer_list;
+	for (i = 0; i < score_request->buffer_count; i++, buffer++) {
+		mutex_lock(&gna_priv->memidr_lock);
+		mo = idr_find(&gna_priv->memory_idr, buffer->memory_id);
+		mutex_unlock(&gna_priv->memidr_lock);
+		if (mo) {
+			mutex_lock(&mo->page_lock);
+			mo->ops->put_pages(mo);
+			mutex_unlock(&mo->page_lock);
+		} else {
+			dev_warn(&gna_priv->dev, "mo not found %llu\n", buffer->memory_id);
+		}
+	}
+
+	/* patches_ptr's are already freed by ops->score() function */
+	kvfree(score_request->buffer_list);
+	score_request->buffer_list = NULL;
+	score_request->buffer_count = 0;
+
+	gna_mmu_clear(gna_priv);
+
+end:
+	score_request->drv_perf.completion = ktime_get_ns();
+	dev_dbg(&gna_priv->dev, "request %llu done, waking processes\n",
+		score_request->request_id);
+	score_request->state = DONE;
+	wake_up_interruptible_all(&score_request->waitq);
+}
 
 static struct gna_request *gna_request_create(struct gna_file_private *file_priv,
 				       struct gna_compute_cfg *compute_cfg)
@@ -34,6 +148,7 @@ static struct gna_request *gna_request_create(struct gna_file_private *file_priv
 	score_request->gna_priv = gna_priv;
 	score_request->state = NEW;
 	init_waitqueue_head(&score_request->waitq);
+	INIT_WORK(&score_request->work, gna_request_process);
 
 	return score_request;
 }
@@ -242,6 +357,7 @@ int gna_enqueue_request(struct gna_compute_cfg *compute_cfg,
 	list_add_tail(&score_request->node, &gna_priv->request_list);
 	mutex_unlock(&gna_priv->reqlist_lock);
 
+	queue_work(gna_priv->request_wq, &score_request->work);
 	kref_put(&score_request->refcount, gna_request_release);
 
 	*request_id = score_request->request_id;
@@ -292,6 +408,7 @@ void gna_delete_request_by_id(u64 req_id, struct gna_private *gna_priv)
 		list_for_each_entry_safe(req, temp_req, reqs_list, node) {
 			if (req->request_id == req_id) {
 				list_del(&req->node);
+				cancel_work_sync(&req->work);
 				kref_put(&req->refcount, gna_request_release);
 				break;
 			}
@@ -313,6 +430,7 @@ void gna_delete_file_requests(struct file *fd, struct gna_private *gna_priv)
 		list_for_each_entry_safe(req, temp_req, reqs_list, node) {
 			if (req->fd == fd) {
 				list_del(&req->node);
+				cancel_work_sync(&req->work);
 				kref_put(&req->refcount, gna_request_release);
 				break;
 			}
@@ -336,6 +454,7 @@ void gna_delete_memory_requests(u64 memory_id, struct gna_private *gna_priv)
 			for (i = 0; i < req->buffer_count; ++i) {
 				if (req->buffer_list[i].memory_id == memory_id) {
 					list_del(&req->node);
+					cancel_work_sync(&req->work);
 					kref_put(&req->refcount, gna_request_release);
 					break;
 				}
diff --git a/drivers/misc/gna/gna_request.h b/drivers/misc/gna/gna_request.h
index c15a2c1803da..cefeea524cf1 100644
--- a/drivers/misc/gna/gna_request.h
+++ b/drivers/misc/gna/gna_request.h
@@ -43,6 +43,7 @@ struct gna_request {
 	u64 buffer_count;
 
 	struct wait_queue_head waitq;
+	struct work_struct work;
 };
 
 int gna_enqueue_request(struct gna_compute_cfg *compute_cfg,
-- 
2.28.0

