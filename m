Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77B33311C4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 16:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhCHPMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 10:12:00 -0500
Received: from mga05.intel.com ([192.55.52.43]:26407 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230521AbhCHPLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 10:11:35 -0500
IronPort-SDR: I35U27lFURleWkfyHZmySk3NwU577IBIIGMMUdrb8/QUS85N79lg2vaajy11hwEMV7gDhKGFA3
 ulm3FxZiVu+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="273073017"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="273073017"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 07:11:35 -0800
IronPort-SDR: sYJSPz+rye/HLbNQ5eN4qbQTQtDCAutmt0Uy74IRbYgS6SxlMTHvPSgoRLjO7IPEdfRA1I9Ash
 bZ+3MTPGpp2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="602179477"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.76])
  by fmsmga005.fm.intel.com with ESMTP; 08 Mar 2021 07:11:33 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] perf auxtrace: Fix auxtrace queue conflict
Date:   Mon,  8 Mar 2021 17:11:43 +0200
Message-Id: <20210308151143.18338-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only requirement of an auxtrace queue is that the buffers are in
time order.  That is achieved by making separate queues for separate
perf buffer or AUX area buffer mmaps.

That generally means a separate queue per cpu for per-cpu contexts,
and a separate queue per thread for per-task contexts.

When buffers are added to a queue, perf checks that the buffer cpu
and thread id (tid) match the queue cpu and thread id.

However, generally, that need not be true, and perf will queue
buffers correctly anyway, so the check is not needed.

In addition, the check gets erroneously hit when using sample mode
to trace multiple threads.

Consequently, fix that case by removing the check.

Reported-by: Andi Kleen <ak@linux.intel.com>
Fixes: e502789302a6 ("perf auxtrace: Add helpers for queuing AUX area tracing data")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 953f4afacd3b..5b6ccb90b397 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -298,10 +298,6 @@ static int auxtrace_queues__queue_buffer(struct auxtrace_queues *queues,
 		queue->set = true;
 		queue->tid = buffer->tid;
 		queue->cpu = buffer->cpu;
-	} else if (buffer->cpu != queue->cpu || buffer->tid != queue->tid) {
-		pr_err("auxtrace queue conflict: cpu %d, tid %d vs cpu %d, tid %d\n",
-		       queue->cpu, queue->tid, buffer->cpu, buffer->tid);
-		return -EINVAL;
 	}
 
 	buffer->buffer_nr = queues->next_buffer_nr++;
-- 
2.17.1

