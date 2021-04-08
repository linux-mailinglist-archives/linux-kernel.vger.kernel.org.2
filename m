Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CABC358886
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhDHPcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:32:19 -0400
Received: from mga04.intel.com ([192.55.52.120]:22953 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232076AbhDHPcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:32:18 -0400
IronPort-SDR: c+xMjjox4aJEIFEv8SUxaKjq865tKKNAcemf/xoEiJv6eTCjIrOsRlS8Ok5AFSth0awBW9s0PW
 CxaykZofgEdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="191412377"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="191412377"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 08:32:06 -0700
IronPort-SDR: 7bGg8xsEMCw6+7w7GiwnDYc8yCvI741S4oX4Cg4wcDYrwR6k/SxayRZfvm6Ae4y/uskF/Zapz4
 FpB0zNw5C87Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="415820729"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 08 Apr 2021 08:32:04 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        adrian.hunter@intel.com
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 1/2] perf: Cap allocation order at aux_watermark
Date:   Thu,  8 Apr 2021 18:31:58 +0300
Message-Id: <20210408153159.81880-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210408153159.81880-1-alexander.shishkin@linux.intel.com>
References: <20210408153159.81880-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we start allocating AUX pages half the size of the total
requested AUX buffer size, ignoring the attr.aux_watermark setting. This,
in turn, makes intel_pt driver disregard the watermark also, as it uses
page order for its SG (ToPA) configuration.

Now, this can be fixed in the intel_pt PMU driver, but seeing as it's the
only one currently making use of high order allocations, there is no
reason not to fix the allocator instead. This way, any other driver
wishing to add this support would not have to worry about this.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 kernel/events/ring_buffer.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index bd55ccc91373..bd94b91bd4be 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -674,21 +674,26 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 	if (!has_aux(event))
 		return -EOPNOTSUPP;
 
-	/*
-	 * We need to start with the max_order that fits in nr_pages,
-	 * not the other way around, hence ilog2() and not get_order.
-	 */
-	max_order = ilog2(nr_pages);
-
-	/*
-	 * PMU requests more than one contiguous chunks of memory
-	 * for SW double buffering
-	 */
 	if (!overwrite) {
-		if (!max_order)
-			return -EINVAL;
+		/*
+		 * Watermark defaults to half the buffer, and so does the
+		 * max_order, to aid PMU drivers in double buffering.
+		 */
+		if (!watermark)
+			watermark = nr_pages << (PAGE_SHIFT - 1);
 
-		max_order--;
+		/*
+		 * Use aux_watermark as the basis for chunking to
+		 * help PMU drivers honor the watermark.
+		 */
+		max_order = get_order(watermark);
+	} else {
+		/*
+		* We need to start with the max_order that fits in nr_pages,
+		* not the other way around, hence ilog2() and not get_order.
+		*/
+		max_order = ilog2(nr_pages);
+		watermark = 0;
 	}
 
 	rb->aux_pages = kcalloc_node(nr_pages, sizeof(void *), GFP_KERNEL,
@@ -743,9 +748,6 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 	rb->aux_overwrite = overwrite;
 	rb->aux_watermark = watermark;
 
-	if (!rb->aux_watermark && !rb->aux_overwrite)
-		rb->aux_watermark = nr_pages << (PAGE_SHIFT - 1);
-
 out:
 	if (!ret)
 		rb->aux_pgoff = pgoff;
-- 
2.30.2

