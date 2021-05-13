Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D712E37F646
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbhEMLEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:04:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:45133 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233045AbhEMLDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:03:13 -0400
IronPort-SDR: hT1ayGq15qKTYwcRzmTzZHlNwRb+7VeN3kHC7oLUleUpr1HyYx29V2aEZGRkKonH85MTlWGEza
 fZGxd6heEK8g==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187048326"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187048326"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:18 -0700
IronPort-SDR: ToPHSBDP9c9XBYqZw8ScJSi6Fx/wp+iCjFvL9OKpezyvKWTF9FCZi14ZCzliM5ntJ4mezeYatm
 pHx9Qrbxoa2Q==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="625984125"
Received: from gna-dev.igk.intel.com ([10.102.80.34])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 04:01:15 -0700
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
Subject: [PATCH v3 09/14] intel_gna: add a work queue to process scoring requests
Date:   Thu, 13 May 2021 13:00:35 +0200
Message-Id: <20210513110040.2268-10-maciej.kwapulinski@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
References: <20210513110040.2268-1-maciej.kwapulinski@linux.intel.com>
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
 drivers/misc/intel/gna/device.c  |  34 +++++++++
 drivers/misc/intel/gna/device.h  |  14 ++++
 drivers/misc/intel/gna/request.c | 115 +++++++++++++++++++++++++++++++
 drivers/misc/intel/gna/request.h |   2 +
 4 files changed, 165 insertions(+)

diff --git a/drivers/misc/intel/gna/device.c b/drivers/misc/intel/gna/device.c
index c8a127cc3039..ca988d3ec408 100644
--- a/drivers/misc/intel/gna/device.c
+++ b/drivers/misc/intel/gna/device.c
@@ -23,6 +23,34 @@ static void gna_devm_idr_destroy(void *data)
 	idr_destroy(idr);
 }
 
+static void gna_devm_destroy_workqueue(void *data)
+{
+	struct workqueue_struct *request_wq = data;
+
+	destroy_workqueue(request_wq);
+}
+
+static int gna_devm_create_singlethread_workqueue(struct gna_private *gna_priv)
+{
+	struct device *dev = gna_parent(gna_priv);
+	const char *name = gna_name(gna_priv);
+	int ret;
+
+	gna_priv->request_wq = create_singlethread_workqueue(name);
+	if (!gna_priv->request_wq) {
+		dev_err(dev, "could not create %s workqueue\n", name);
+		return -EFAULT;
+	}
+
+	ret = devm_add_action(dev, gna_devm_destroy_workqueue, gna_priv->request_wq);
+	if (ret) {
+		dev_err(dev, "could not add devm action for %s workqueue\n", name);
+		gna_devm_destroy_workqueue(gna_priv->request_wq);
+	}
+
+	return ret;
+}
+
 int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem *iobase)
 {
 	static atomic_t dev_last_idx = ATOMIC_INIT(-1);
@@ -90,6 +118,12 @@ int gna_probe(struct device *parent, struct gna_dev_info *dev_info, void __iomem
 	mutex_init(&gna_priv->reqlist_lock);
 	INIT_LIST_HEAD(&gna_priv->request_list);
 
+	init_waitqueue_head(&gna_priv->dev_busy_waitq);
+
+	ret = gna_devm_create_singlethread_workqueue(gna_priv);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
diff --git a/drivers/misc/intel/gna/device.h b/drivers/misc/intel/gna/device.h
index e879ac045928..65856d08729f 100644
--- a/drivers/misc/intel/gna/device.h
+++ b/drivers/misc/intel/gna/device.h
@@ -16,6 +16,7 @@
 
 #define GNA_DV_NAME	"intel_gna"
 
+struct workqueue_struct;
 struct device;
 struct file;
 
@@ -42,6 +43,9 @@ struct gna_private {
 	const char *name;
 	struct device *parent;
 
+	/* hardware status set by interrupt handler */
+	u32 hw_status;
+
 	/* device related resources */
 	void __iomem *iobase;
 	struct gna_dev_info info;
@@ -50,9 +54,14 @@ struct gna_private {
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
@@ -78,6 +87,11 @@ static inline struct device *gna_parent(struct gna_private *gna_priv)
 	return gna_priv->parent;
 }
 
+static inline const char *gna_name(struct gna_private *gna_priv)
+{
+	return gna_priv->name;
+}
+
 static inline struct device *gna_dev(struct gna_private *gna_priv)
 {
 	return gna_priv->parent;
diff --git a/drivers/misc/intel/gna/request.c b/drivers/misc/intel/gna/request.c
index d9e7bc5d2d3a..eabbab8924be 100644
--- a/drivers/misc/intel/gna/request.c
+++ b/drivers/misc/intel/gna/request.c
@@ -10,8 +10,118 @@
 #include <linux/slab.h>
 
 #include "device.h"
+#include "hw.h"
 #include "mem.h"
 #include "request.h"
+#include "score.h"
+
+static void gna_request_update_status(struct gna_request *score_request)
+{
+	struct gna_private *gna_priv = score_request->gna_priv;
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
+			total_cycles = gna_reg_read(gna_priv, GNA_MMIO_PTC);
+			stall_cycles = gna_reg_read(gna_priv, GNA_MMIO_PSC);
+			score_request->hw_perf.total = total_cycles;
+			score_request->hw_perf.stall = stall_cycles;
+		} else
+			dev_warn(gna_dev(gna_priv), "GNA statistics missing\n");
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
+	dev_dbg(gna_dev(gna_priv), "processing request %llu\n", score_request->request_id);
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
+	hw_timeout = gna_priv->recovery_timeout_jiffies;
+
+	hw_timeout = wait_event_timeout(gna_priv->dev_busy_waitq,
+			!gna_priv->dev_busy, hw_timeout);
+
+	if (!hw_timeout)
+		dev_warn(gna_dev(gna_priv), "hardware timeout occurred\n");
+
+	gna_priv->hw_status = gna_reg_read(gna_priv, GNA_MMIO_STS);
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
+			dev_warn(gna_dev(gna_priv), "mo not found %llu\n", buffer->memory_id);
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
+	dev_dbg(gna_dev(gna_priv), "request %llu done, waking processes\n",
+		score_request->request_id);
+	score_request->state = DONE;
+	wake_up_interruptible_all(&score_request->waitq);
+}
 
 static struct gna_request *gna_request_create(struct gna_file_private *file_priv,
 				       struct gna_compute_cfg *compute_cfg)
@@ -37,6 +147,7 @@ static struct gna_request *gna_request_create(struct gna_file_private *file_priv
 	score_request->gna_priv = gna_priv;
 	score_request->state = NEW;
 	init_waitqueue_head(&score_request->waitq);
+	INIT_WORK(&score_request->work, gna_request_process);
 
 	return score_request;
 }
@@ -245,6 +356,7 @@ int gna_enqueue_request(struct gna_compute_cfg *compute_cfg,
 	list_add_tail(&score_request->node, &gna_priv->request_list);
 	mutex_unlock(&gna_priv->reqlist_lock);
 
+	queue_work(gna_priv->request_wq, &score_request->work);
 	kref_put(&score_request->refcount, gna_request_release);
 
 	*request_id = score_request->request_id;
@@ -295,6 +407,7 @@ void gna_delete_request_by_id(u64 req_id, struct gna_private *gna_priv)
 		list_for_each_entry_safe(req, temp_req, reqs_list, node) {
 			if (req->request_id == req_id) {
 				list_del(&req->node);
+				cancel_work_sync(&req->work);
 				kref_put(&req->refcount, gna_request_release);
 				break;
 			}
@@ -316,6 +429,7 @@ void gna_delete_file_requests(struct file *fd, struct gna_private *gna_priv)
 		list_for_each_entry_safe(req, temp_req, reqs_list, node) {
 			if (req->fd == fd) {
 				list_del(&req->node);
+				cancel_work_sync(&req->work);
 				kref_put(&req->refcount, gna_request_release);
 				break;
 			}
@@ -339,6 +453,7 @@ void gna_delete_memory_requests(u64 memory_id, struct gna_private *gna_priv)
 			for (i = 0; i < req->buffer_count; ++i) {
 				if (req->buffer_list[i].memory_id == memory_id) {
 					list_del(&req->node);
+					cancel_work_sync(&req->work);
 					kref_put(&req->refcount, gna_request_release);
 					break;
 				}
diff --git a/drivers/misc/intel/gna/request.h b/drivers/misc/intel/gna/request.h
index f34e974ad25c..f95947dd7272 100644
--- a/drivers/misc/intel/gna/request.h
+++ b/drivers/misc/intel/gna/request.h
@@ -8,6 +8,7 @@
 #include <linux/list.h>
 #include <linux/types.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
 
 #include <uapi/misc/intel/gna.h>
 
@@ -46,6 +47,7 @@ struct gna_request {
 	struct gna_buffer *buffer_list;
 	u64 buffer_count;
 
+	struct work_struct work;
 	struct wait_queue_head waitq;
 };
 
-- 
2.28.0

