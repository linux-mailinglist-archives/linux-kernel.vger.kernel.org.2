Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F070745A494
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 15:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbhKWOMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 09:12:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:46791 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237545AbhKWOLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 09:11:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="235263592"
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="235263592"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 06:08:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,257,1631602800"; 
   d="scan'208";a="509422399"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga008.jf.intel.com with ESMTP; 23 Nov 2021 06:08:33 -0800
From:   Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [PATCH v12 04/16] perf record: Introduce function to propagate control commands
Date:   Tue, 23 Nov 2021 17:08:00 +0300
Message-Id: <b82e5e30c5eeb4ad6546c0321c81dca3660d59af.1637675515.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1637675515.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce evlist__ctlfd_update() function to propagate external control
commands to global evlist object.

Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/evlist.c | 16 ++++++++++++++++
 tools/perf/util/evlist.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5f92319ce258..da0664bd98b5 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2115,6 +2115,22 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
 	return err;
 }
 
+int evlist__ctlfd_update(struct evlist *evlist, struct pollfd *update)
+{
+	int ctlfd_pos = evlist->ctl_fd.pos;
+	struct pollfd *entries = evlist->core.pollfd.entries;
+
+	if (!evlist__ctlfd_initialized(evlist))
+		return 0;
+
+	if (entries[ctlfd_pos].fd != update->fd ||
+	    entries[ctlfd_pos].events != update->events)
+		return -1;
+
+	entries[ctlfd_pos].revents = update->revents;
+	return 0;
+}
+
 struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
 {
 	struct evsel *evsel;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 97bfb8d0be4f..2a1fd2c3d5a1 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -372,6 +372,7 @@ void evlist__close_control(int ctl_fd, int ctl_fd_ack, bool *ctl_fd_close);
 int evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
 int evlist__finalize_ctlfd(struct evlist *evlist);
 bool evlist__ctlfd_initialized(struct evlist *evlist);
+int evlist__ctlfd_update(struct evlist *evlist, struct pollfd *update);
 int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
 int evlist__ctlfd_ack(struct evlist *evlist);
 
-- 
2.19.0

