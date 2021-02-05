Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1BA310537
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 07:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhBEGwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 01:52:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11680 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhBEGvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 01:51:33 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DX5cM36rqzlGw7;
        Fri,  5 Feb 2021 14:49:07 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.61) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Feb 2021 14:50:40 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <amistry@google.com>, <alexey.budankov@linux.intel.com>,
        <adrian.hunter@intel.com>, <namhyung@kernel.org>,
        <jolsa@redhat.com>, <alexander.shishkin@linux.intel.com>,
        <mark.rutland@arm.com>, <acme@kernel.org>, <mingo@redhat.com>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>, <zhangjinhao2@huawei.com>
Subject: [PATCH] perf record: Fix continue profiling after draining the buffer
Date:   Fri, 5 Feb 2021 14:50:01 +0800
Message-ID: <20210205065001.23252-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.30.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit da231338ec9c098707c8a1e4d8a50e2400e2fe17 uses eventfd to solve rare race
where the setting and checking of 'done' which add done_fd to pollfd.
When draining buffer, revents of done_fd is 0 and evlist__filter_pollfd
function returns a non-zero value.
As a result, perf record does not stop profiling.

The following simple scenarios can trigger this condition:

sleep 10 &
perf record -p $!

After the sleep process exits, perf record should stop profiling and exit.
However, perf record keeps running.

If pollfd revents contains only POLLERR or POLLHUP,
perf record indicates that buffer is draining and need to stop profiling.
Use fdarray_flag__nonfilterable to set done eventfd to nonfilterable objects,
so that evlist__filter_pollfd does not filter and check done eventfd.

Fixes: da231338ec9c (perf record: Use an eventfd to wakeup when done)
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/builtin-record.c | 2 +-
 tools/perf/util/evlist.c    | 8 ++++++++
 tools/perf/util/evlist.h    | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index fd3911650612..51e593e896ea 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1663,7 +1663,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		status = -1;
 		goto out_delete_session;
 	}
-	err = evlist__add_pollfd(rec->evlist, done_fd);
+	err = evlist__add_wakeup_eventfd(rec->evlist, done_fd);
 	if (err < 0) {
 		pr_err("Failed to add wakeup eventfd to poll list\n");
 		status = err;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 05363a7247c4..fea4c1e8010d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -572,6 +572,14 @@ int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
 	return perf_evlist__filter_pollfd(&evlist->core, revents_and_mask);
 }
 
+#ifdef HAVE_EVENTFD_SUPPORT
+int evlist__add_wakeup_eventfd(struct evlist *evlist, int fd)
+{
+	return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN,
+				       fdarray_flag__nonfilterable);
+}
+#endif
+
 int evlist__poll(struct evlist *evlist, int timeout)
 {
 	return perf_evlist__poll(&evlist->core, timeout);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 1aae75895dea..6d4d62151bc8 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -142,6 +142,10 @@ struct evsel *evlist__find_tracepoint_by_name(struct evlist *evlist, const char
 int evlist__add_pollfd(struct evlist *evlist, int fd);
 int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask);
 
+#ifdef HAVE_EVENTFD_SUPPORT
+int evlist__add_wakeup_eventfd(struct evlist *evlist, int fd);
+#endif
+
 int evlist__poll(struct evlist *evlist, int timeout);
 
 struct evsel *evlist__id2evsel(struct evlist *evlist, u64 id);
-- 
2.17.1

