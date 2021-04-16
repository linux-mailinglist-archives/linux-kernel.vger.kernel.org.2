Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0BB362ADA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 00:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbhDPWOQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Apr 2021 18:14:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25170 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235138AbhDPWOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 18:14:06 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GM5JIW016105
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:13:40 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37yb5e2wh5-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 15:13:40 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 15:13:38 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id B77D162E1FDE; Fri, 16 Apr 2021 15:13:35 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <acme@kernel.org>, <acme@redhat.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <songliubraving@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v3 1/4] perf util: move bpf_perf definitions to a libperf header
Date:   Fri, 16 Apr 2021 15:13:22 -0700
Message-ID: <20210416221325.2373497-2-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416221325.2373497-1-song@kernel.org>
References: <20210416221325.2373497-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: MvwGjHILFnLwExk-mw6xo8D-SsgqHXPx
X-Proofpoint-ORIG-GUID: MvwGjHILFnLwExk-mw6xo8D-SsgqHXPx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160154
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By following the same protocol, other tools can share hardware PMCs with
perf. Move perf_event_attr_map_entry and BPF_PERF_DEFAULT_ATTR_MAP_PATH to
bpf_perf.h for other tools to use.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/lib/perf/include/perf/bpf_perf.h | 31 ++++++++++++++++++++++++++
 tools/perf/util/bpf_counter.c          | 27 +++-------------------
 2 files changed, 34 insertions(+), 24 deletions(-)
 create mode 100644 tools/lib/perf/include/perf/bpf_perf.h

diff --git a/tools/lib/perf/include/perf/bpf_perf.h b/tools/lib/perf/include/perf/bpf_perf.h
new file mode 100644
index 0000000000000..e7cf6ba7b674b
--- /dev/null
+++ b/tools/lib/perf/include/perf/bpf_perf.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+#ifndef __LIBPERF_BPF_PERF_H
+#define __LIBPERF_BPF_PERF_H
+
+#include <linux/types.h>  /* for __u32 */
+
+/*
+ * bpf_perf uses a hashmap, the attr_map, to track all the leader programs.
+ * The hashmap is pinned in bpffs. flock() on this file is used to ensure
+ * no concurrent access to the attr_map.  The key of attr_map is struct
+ * perf_event_attr, and the value is struct perf_event_attr_map_entry.
+ *
+ * struct perf_event_attr_map_entry contains two __u32 IDs, bpf_link of the
+ * leader prog, and the diff_map. Each perf-stat session holds a reference
+ * to the bpf_link to make sure the leader prog is attached to sched_switch
+ * tracepoint.
+ *
+ * Since the hashmap only contains IDs of the bpf_link and diff_map, it
+ * does not hold any references to the leader program. Once all perf-stat
+ * sessions of these events exit, the leader prog, its maps, and the
+ * perf_events will be freed.
+ */
+struct perf_event_attr_map_entry {
+	__u32 link_id;
+	__u32 diff_map_id;
+};
+
+/* default attr_map name */
+#define BPF_PERF_DEFAULT_ATTR_MAP_PATH "perf_attr_map"
+
+#endif /* __LIBPERF_BPF_PERF_H */
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 81d1df3c4ec0e..be484ddbbd5be 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -14,6 +14,7 @@
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
 #include <api/fs/fs.h>
+#include <perf/bpf_perf.h>
 
 #include "bpf_counter.h"
 #include "counts.h"
@@ -29,28 +30,6 @@
 #include "bpf_skel/bperf_leader.skel.h"
 #include "bpf_skel/bperf_follower.skel.h"
 
-/*
- * bperf uses a hashmap, the attr_map, to track all the leader programs.
- * The hashmap is pinned in bpffs. flock() on this file is used to ensure
- * no concurrent access to the attr_map.  The key of attr_map is struct
- * perf_event_attr, and the value is struct perf_event_attr_map_entry.
- *
- * struct perf_event_attr_map_entry contains two __u32 IDs, bpf_link of the
- * leader prog, and the diff_map. Each perf-stat session holds a reference
- * to the bpf_link to make sure the leader prog is attached to sched_switch
- * tracepoint.
- *
- * Since the hashmap only contains IDs of the bpf_link and diff_map, it
- * does not hold any references to the leader program. Once all perf-stat
- * sessions of these events exit, the leader prog, its maps, and the
- * perf_events will be freed.
- */
-struct perf_event_attr_map_entry {
-	__u32 link_id;
-	__u32 diff_map_id;
-};
-
-#define DEFAULT_ATTR_MAP_PATH "fs/bpf/perf_attr_map"
 #define ATTR_MAP_SIZE 16
 
 static inline void *u64_to_ptr(__u64 ptr)
@@ -341,8 +320,8 @@ static int bperf_lock_attr_map(struct target *target)
 	if (target->attr_map) {
 		scnprintf(path, PATH_MAX, "%s", target->attr_map);
 	} else {
-		scnprintf(path, PATH_MAX, "%s/%s", sysfs__mountpoint(),
-			  DEFAULT_ATTR_MAP_PATH);
+		scnprintf(path, PATH_MAX, "%s/fs/bpf/%s", sysfs__mountpoint(),
+			  BPF_PERF_DEFAULT_ATTR_MAP_PATH);
 	}
 
 	if (access(path, F_OK)) {
-- 
2.30.2

