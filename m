Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03EF3AEC18
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhFUPPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:15:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:18879 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230180AbhFUPPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:15:32 -0400
IronPort-SDR: G8UrbbQlnas514Z5CbACKxdCdBdyiRj53MTj24Pg2htw9TYCZyf62cDBPOG+vUwgHZ074d/bRm
 FlDMP5fQk1bA==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="205039520"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="205039520"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 08:13:17 -0700
IronPort-SDR: jh/Gf1XeIgMdcDiUZ02W5iGDCD64DVQtENMrfITgZn1z7LH0TclaZrxODsBm80nWA3O7sxWBkr
 xgVWCVWvcP6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486522882"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 08:13:16 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 3/4] intel_th: msu: Make contiguous buffers uncached
Date:   Mon, 21 Jun 2021 18:12:45 +0300
Message-Id: <20210621151246.31891-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621151246.31891-1-alexander.shishkin@linux.intel.com>
References: <20210621151246.31891-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We already keep the multiblock mode buffers uncached, but forget the
single mode. Address this.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwtracing/intel_th/msu.c | 48 +++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 2edc4666633d..432ade0842f6 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1024,33 +1024,49 @@ static int __msc_buffer_win_alloc(struct msc_window *win,
 }
 
 #ifdef CONFIG_X86
-static void msc_buffer_set_uc(struct msc_window *win, unsigned int nr_segs)
+static void msc_buffer_set_uc(struct msc *msc)
 {
 	struct scatterlist *sg_ptr;
+	struct msc_window *win;
 	int i;
 
-	for_each_sg(win->sgt->sgl, sg_ptr, nr_segs, i) {
-		/* Set the page as uncached */
-		set_memory_uc((unsigned long)sg_virt(sg_ptr),
-			      PFN_DOWN(sg_ptr->length));
+	if (msc->mode == MSC_MODE_SINGLE) {
+		set_memory_uc((unsigned long)msc->base, msc->nr_pages);
+		return;
+	}
+
+	list_for_each_entry(win, &msc->win_list, entry) {
+		for_each_sg(win->sgt->sgl, sg_ptr, win->nr_segs, i) {
+			/* Set the page as uncached */
+			set_memory_uc((unsigned long)sg_virt(sg_ptr),
+					PFN_DOWN(sg_ptr->length));
+		}
 	}
 }
 
-static void msc_buffer_set_wb(struct msc_window *win)
+static void msc_buffer_set_wb(struct msc *msc)
 {
 	struct scatterlist *sg_ptr;
+	struct msc_window *win;
 	int i;
 
-	for_each_sg(win->sgt->sgl, sg_ptr, win->nr_segs, i) {
-		/* Reset the page to write-back */
-		set_memory_wb((unsigned long)sg_virt(sg_ptr),
-			      PFN_DOWN(sg_ptr->length));
+	if (msc->mode == MSC_MODE_SINGLE) {
+		set_memory_wb((unsigned long)msc->base, msc->nr_pages);
+		return;
+	}
+
+	list_for_each_entry(win, &msc->win_list, entry) {
+		for_each_sg(win->sgt->sgl, sg_ptr, win->nr_segs, i) {
+			/* Reset the page to write-back */
+			set_memory_wb((unsigned long)sg_virt(sg_ptr),
+					PFN_DOWN(sg_ptr->length));
+		}
 	}
 }
 #else /* !X86 */
 static inline void
-msc_buffer_set_uc(struct msc_window *win, unsigned int nr_segs) {}
-static inline void msc_buffer_set_wb(struct msc_window *win) {}
+msc_buffer_set_uc(struct msc *msc) {}
+static inline void msc_buffer_set_wb(struct msc *msc) {}
 #endif /* CONFIG_X86 */
 
 /**
@@ -1097,8 +1113,6 @@ static int msc_buffer_win_alloc(struct msc *msc, unsigned int nr_blocks)
 	if (ret <= 0)
 		goto err_nomem;
 
-	msc_buffer_set_uc(win, ret);
-
 	win->nr_segs = ret;
 	win->nr_blocks = nr_blocks;
 
@@ -1152,8 +1166,6 @@ static void msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 		msc->base_addr = 0;
 	}
 
-	msc_buffer_set_wb(win);
-
 	if (msc->mbuf && msc->mbuf->free_window)
 		msc->mbuf->free_window(msc->mbuf_priv, win->sgt);
 	else
@@ -1260,6 +1272,8 @@ static int msc_buffer_multi_alloc(struct msc *msc, unsigned long *nr_pages,
  */
 static void msc_buffer_free(struct msc *msc)
 {
+	msc_buffer_set_wb(msc);
+
 	if (msc->mode == MSC_MODE_SINGLE)
 		msc_buffer_contig_free(msc);
 	else if (msc->mode == MSC_MODE_MULTI)
@@ -1303,6 +1317,8 @@ static int msc_buffer_alloc(struct msc *msc, unsigned long *nr_pages,
 	}
 
 	if (!ret) {
+		msc_buffer_set_uc(msc);
+
 		/* allocation should be visible before the counter goes to 0 */
 		smp_mb__before_atomic();
 
-- 
2.30.2

