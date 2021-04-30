Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C383B36F618
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhD3HD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:03:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:34039 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230491AbhD3HDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:03:50 -0400
IronPort-SDR: mZK39j8xxefUo2t9saLieyBIrJRq3hLzlAN5l3BfNehAaH3sYpULXf6PGioN1ahx8H6Oab6Uiy
 imGCsXbnObmw==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="197312431"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="197312431"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 00:03:02 -0700
IronPort-SDR: 6RSycfxVgyCVUWSzvK7DGDJPhklJyNLuGGnW3OrWqzG+nfwu9JKLTYrd04Bq7jJF+pE1jjXPGF
 YgKD1YmuVhNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="404492304"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga002.jf.intel.com with ESMTP; 30 Apr 2021 00:03:01 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V2 06/12] perf auxtrace: Allow buffers to be mapped read / write
Date:   Fri, 30 Apr 2021 10:03:03 +0300
Message-Id: <20210430070309.17624-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210430070309.17624-1-adrian.hunter@intel.com>
References: <20210430070309.17624-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support in-place update, allow buffers to be mapped read / write.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/auxtrace.c | 5 +++--
 tools/perf/util/auxtrace.h | 6 +++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 48b88e2bca1e..ade655d58780 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1120,8 +1120,9 @@ int auxtrace_queue_data(struct perf_session *session, bool samples, bool events)
 					 auxtrace_queue_data_cb, &qd);
 }
 
-void *auxtrace_buffer__get_data(struct auxtrace_buffer *buffer, int fd)
+void *auxtrace_buffer__get_data_rw(struct auxtrace_buffer *buffer, int fd, bool rw)
 {
+	int prot = rw ? PROT_READ | PROT_WRITE : PROT_READ;
 	size_t adj = buffer->data_offset & (page_size - 1);
 	size_t size = buffer->size + adj;
 	off_t file_offset = buffer->data_offset - adj;
@@ -1130,7 +1131,7 @@ void *auxtrace_buffer__get_data(struct auxtrace_buffer *buffer, int fd)
 	if (buffer->data)
 		return buffer->data;
 
-	addr = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, file_offset);
+	addr = mmap(NULL, size, prot, MAP_SHARED, fd, file_offset);
 	if (addr == MAP_FAILED)
 		return NULL;
 
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 9ac2ac1bd793..472c0973b1f1 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -533,7 +533,11 @@ int auxtrace_queue_data(struct perf_session *session, bool samples,
 			bool events);
 struct auxtrace_buffer *auxtrace_buffer__next(struct auxtrace_queue *queue,
 					      struct auxtrace_buffer *buffer);
-void *auxtrace_buffer__get_data(struct auxtrace_buffer *buffer, int fd);
+void *auxtrace_buffer__get_data_rw(struct auxtrace_buffer *buffer, int fd, bool rw);
+static inline void *auxtrace_buffer__get_data(struct auxtrace_buffer *buffer, int fd)
+{
+	return auxtrace_buffer__get_data_rw(buffer, fd, false);
+}
 void auxtrace_buffer__put_data(struct auxtrace_buffer *buffer);
 void auxtrace_buffer__drop_data(struct auxtrace_buffer *buffer);
 void auxtrace_buffer__free(struct auxtrace_buffer *buffer);
-- 
2.25.1

