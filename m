Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72073480CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbhCXSjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:39:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:17741 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237345AbhCXSil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:38:41 -0400
IronPort-SDR: rRwut6S9nlfkjSoOf8yvZfbtBr/HPQnlxZk7LHGaHElTvGoewPLMBJ0ELXNf/jYfGnVVCpyxv4
 Sb06ugoctjUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190859547"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190859547"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:41 -0700
IronPort-SDR: Qb0qcOb2h9F6izKEPo7gSDJKs9Hum+NAOvrup4yeWJwK4wbQkAaNu+uDozBqblkcIxftklnlqG
 7oVU7nrH8/xw==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="608203865"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 11:38:38 -0700
From:   Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Tomasz Jankowski <tomasz1.jankowski@intel.com>,
        Savo Novakovic <savox.novakovic@intel.com>,
        Anisha Dattatraya Kulkarni 
        <anisha.dattatraya.kulkarni@intel.com>,
        Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: [PATCH v2 09/13] intel_gna: add a work queue to process scoring requests
Date:   Wed, 24 Mar 2021 19:36:06 +0100
Message-Id: <20210324183610.4574-10-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
References: <20210324183610.4574-1-maciej.kwapulinski@linux.intel.com>
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
Tested-by: Savo Novakovic <savox.novakovic@intel.com>
Co-developed-by: Anisha Dattatraya Kulkarni <anisha.dattatraya.kulkarni@intel.com>
Signed-off-by: Anisha Dattatraya Kulkarni <anisha.dattatraya.kulkarni@intel.com>
Co-developed-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Co-developed-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Signed-off-by: Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
---
 drivers/misc/intel/gna/gna_device.c  |  12 +++
 drivers/misc/intel/gna/gna_device.h  |   8 ++
 drivers/misc/intel/gna/gna_request.c | 116 +++++++++++++++++++++++++++
 drivers/misc/intel/gna/gna_request.h |   1 +
 4 files changed, 137 insertions(+)

diff --git a/drivers/misc/intel/gna/gna_device.c b/drivers/misc/intel/gna/gna_device.c
index e1a1f3142684..47f238677bc9 100644
--- a/drivers/misc/intel/gna/gna_device.c
+++ b/drivers/misc/intel/gna/gna_device.c
@@ -127,6 +127,15 @@ static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 	mutex_init(&gna_priv->reqlist_lock);
 	INIT_LIST_HEAD(&gna_priv->request_list);
 
+	init_waitqueue_head(&gna_priv->dev_busy_waitq);
+
+	gna_priv->request_wq = create_singlethread_workqueue(GNA_DV_NAME);
+	if (!gna_priv->request_wq) {
+		dev_err(&pcidev->dev, "could not create %s workqueue\n", GNA_DV_NAME);
+		ret = -EFAULT;
+		goto err_pci_drvdata_unset;
+	}
+
 	return 0;
 
 err_pci_drvdata_unset:
@@ -137,6 +146,9 @@ static int gna_dev_init(struct gna_private *gna_priv, struct pci_dev *pcidev,
 
 static void gna_dev_deinit(struct gna_private *gna_priv)
 {
+	flush_workqueue(gna_priv->request_wq);
+	destroy_workqueue(gna_priv->request_wq);
+
 	idr_destroy(&gna_priv->memory_idr);
 	gna_mmu_free(gna_priv);
 }
diff --git a/drivers/misc/intel/gna/gna_device.h b/drivers/misc/intel/gna/gna_device.h
index 878a972ab5b3..23eae806f96d 100644
--- a/drivers/misc/intel/gna/gna_device.h
+++ b/drivers/misc/intel/gna/gna_device.h
@@ -14,6 +14,7 @@
 #include "gna_mem.h"
 
 struct gna_driver_private;
+struct workqueue_struct;
 struct device;
 
 struct gna_drv_info {
@@ -42,6 +43,8 @@ struct gna_private {
 	/* pdev->dev */
 	struct device *parent;
 
+	u32 hw_status;
+
 	/* device related resources */
 	void __iomem *bar0_base;
 	struct gna_drv_info info;
@@ -50,9 +53,14 @@ struct gna_private {
 	struct gna_mmu_object mmu;
 	struct mutex mmu_lock;
 
+	/* if true, then gna device is processing */
+	bool dev_busy;
+	struct wait_queue_head dev_busy_waitq;
+
 	struct list_head request_list;
 	/* protects request_list */
 	struct mutex reqlist_lock;
+	struct workqueue_struct *request_wq;
 	atomic_t request_count;
 
 	/* memory objects' store */
diff --git a/drivers/misc/intel/gna/gna_request.c b/drivers/misc/intel/gna/gna_request.c
index 383871eaebab..ba9bac358270 100644
--- a/drivers/misc/intel/gna/gna_request.c
+++ b/drivers/misc/intel/gna/gna_request.c
@@ -8,7 +8,118 @@
 
 #include "gna_device.h"
 #include "gna_driver.h"
+#include "gna_hw.h"
 #include "gna_request.h"
+#include "gna_score.h"
+
+static void gna_request_update_status(struct gna_request *score_request)
+{
+	struct gna_private *gna_priv = score_request->gna_priv;
+	void __iomem *addr = gna_priv->bar0_base;
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
+			dev_warn(&gna_priv->pdev->dev, "GNA statistics missing\n");
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
+	dev_dbg(&gna_priv->pdev->dev, "processing request %llu\n", score_request->request_id);
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
+	gna_priv->dev_busy = true;
+
+	ret = gna_score(score_request);
+	if (ret) {
+		score_request->status = ret;
+		goto end;
+	}
+
+	score_request->drv_perf.processing = ktime_get_ns();
+
+	hw_timeout = gna_priv->drv_priv->recovery_timeout_jiffies;
+
+	hw_timeout = wait_event_timeout(gna_priv->dev_busy_waitq,
+			!gna_priv->dev_busy, hw_timeout);
+
+	if (!hw_timeout)
+		dev_warn(&gna_priv->pdev->dev, "hardware timeout occurred\n");
+
+	gna_priv->hw_status = gna_reg_read(gna_priv->bar0_base, GNA_MMIO_STS);
+
+	gna_request_update_status(score_request);
+	gna_abort_hw(gna_priv);
+
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
+			dev_warn(&gna_priv->pdev->dev, "mo not found %llu\n", buffer->memory_id);
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
+	dev_dbg(&gna_priv->pdev->dev, "request %llu done, waking processes\n",
+		score_request->request_id);
+	score_request->state = DONE;
+	wake_up_interruptible_all(&score_request->waitq);
+}
 
 static struct gna_request *gna_request_create(struct gna_file_private *file_priv,
 				       struct gna_compute_cfg *compute_cfg)
@@ -34,6 +145,7 @@ static struct gna_request *gna_request_create(struct gna_file_private *file_priv
 	score_request->gna_priv = gna_priv;
 	score_request->state = NEW;
 	init_waitqueue_head(&score_request->waitq);
+	INIT_WORK(&score_request->work, gna_request_process);
 
 	return score_request;
 }
@@ -242,6 +354,7 @@ int gna_enqueue_request(struct gna_compute_cfg *compute_cfg,
 	list_add_tail(&score_request->node, &gna_priv->request_list);
 	mutex_unlock(&gna_priv->reqlist_lock);
 
+	queue_work(gna_priv->request_wq, &score_request->work);
 	kref_put(&score_request->refcount, gna_request_release);
 
 	*request_id = score_request->request_id;
@@ -292,6 +405,7 @@ void gna_delete_request_by_id(u64 req_id, struct gna_private *gna_priv)
 		list_for_each_entry_safe(req, temp_req, reqs_list, node) {
 			if (req->request_id == req_id) {
 				list_del(&req->node);
+				cancel_work_sync(&req->work);
 				kref_put(&req->refcount, gna_request_release);
 				break;
 			}
@@ -313,6 +427,7 @@ void gna_delete_file_requests(struct file *fd, struct gna_private *gna_priv)
 		list_for_each_entry_safe(req, temp_req, reqs_list, node) {
 			if (req->fd == fd) {
 				list_del(&req->node);
+				cancel_work_sync(&req->work);
 				kref_put(&req->refcount, gna_request_release);
 				break;
 			}
@@ -336,6 +451,7 @@ void gna_delete_memory_requests(u64 memory_id, struct gna_private *gna_priv)
 			for (i = 0; i < req->buffer_count; ++i) {
 				if (req->buffer_list[i].memory_id == memory_id) {
 					list_del(&req->node);
+					cancel_work_sync(&req->work);
 					kref_put(&req->refcount, gna_request_release);
 					break;
 				}
diff --git a/drivers/misc/intel/gna/gna_request.h b/drivers/misc/intel/gna/gna_request.h
index 609e66ffb54f..0d8c0f4180c8 100644
--- a/drivers/misc/intel/gna/gna_request.h
+++ b/drivers/misc/intel/gna/gna_request.h
@@ -43,6 +43,7 @@ struct gna_request {
 	u64 buffer_count;
 
 	struct wait_queue_head waitq;
+	struct work_struct work;
 };
 
 int gna_enqueue_request(struct gna_compute_cfg *compute_cfg,
-- 
2.28.0

