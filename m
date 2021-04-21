Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F056F3667C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 11:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbhDUJP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 05:15:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:24547 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230516AbhDUJPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:15:48 -0400
IronPort-SDR: 6Ioii57Qac5wImbV7hFXO6TB2fF6FFLCQbD0O8ZvCOONmaXe9BbJzSNih0M1svLF6QiKs1hI2L
 tm3PvxQYIC0g==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="193545423"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="193545423"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2021 02:15:15 -0700
IronPort-SDR: iu7XieK2x/FLtydb7ub8P3QHXYCKZHk/kqg102JBUFQDF0I/wL0msZEHrvwjes53CgaAfSxsyc
 n6tWejVqEccw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="463519827"
Received: from silpixa00396680.ir.intel.com (HELO silpixa00396680.ger.corp.intel.com) ([10.237.223.54])
  by orsmga001.jf.intel.com with ESMTP; 21 Apr 2021 02:15:12 -0700
From:   Ray Kinsella <mdr@ashroe.eu>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@kernel.org,
        kan.liang@linux.intel.com, ak@linux.intel.com, mdr@ashroe.eu
Subject: [PATCH] perf tools: Update topdown documentation to permit rdpmc calls
Date:   Wed, 21 Apr 2021 10:10:09 +0100
Message-Id: <20210421091009.1711565-1-mdr@ashroe.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update Topdown documentation to permit calls to rdpmc, and describe
interaction with system calls.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Ray Kinsella <mdr@ashroe.eu>
---
 tools/perf/Documentation/topdown.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/Documentation/topdown.txt b/tools/perf/Documentation/topdown.txt
index 10f07f9455b8..c6302df4cf29 100644
--- a/tools/perf/Documentation/topdown.txt
+++ b/tools/perf/Documentation/topdown.txt
@@ -72,6 +72,7 @@ For example, the perf_event_attr structure can be initialized with
 The Fixed counter 3 must be the leader of the group.
 
 #include <linux/perf_event.h>
+#include <sys/mman.h>
 #include <sys/syscall.h>
 #include <unistd.h>
 
@@ -95,6 +96,11 @@ int slots_fd = perf_event_open(&slots, 0, -1, -1, 0);
 if (slots_fd < 0)
 	... error ...
 
+/* Memory mapping the fd permits _rdpmc calls from userspace */
+void *slots_p = mmap(0, getpagesize(), PROT_READ, MAP_SHARED, slots_fd, 0);
+if (!slot_p)
+	.... error ...
+
 /*
  * Open metrics event file descriptor for current task.
  * Set slots event as the leader of the group.
@@ -110,6 +116,14 @@ int metrics_fd = perf_event_open(&metrics, 0, -1, slots_fd, 0);
 if (metrics_fd < 0)
 	... error ...
 
+/* Memory mapping the fd permits _rdpmc calls from userspace */
+void *metrics_p = mmap(0, getpagesize(), PROT_READ, MAP_SHARED, metrics_fd, 0);
+if (!metrics_p)
+	... error ...
+
+Note: the file descriptors returned by the perf_event_open calls must be memory
+mapped to permit calls to the _rdpmd instruction. Permission may also be granted
+by writing the /sys/devices/cpu/rdpmc sysfs node.
 
 The RDPMC instruction (or _rdpmc compiler intrinsic) can now be used
 to read slots and the topdown metrics at different points of the program:
@@ -141,6 +155,10 @@ as the parallelism and overlap in the CPU program execution will
 cause too much measurement inaccuracy. For example instrumenting
 individual basic blocks is definitely too fine grained.
 
+_rdpmc calls should not be mixed with reading the metrics and slots counters
+through system calls, as the kernel will reset these counters after each system
+call.
+
 Decoding metrics values
 =======================
 
-- 
2.26.2

