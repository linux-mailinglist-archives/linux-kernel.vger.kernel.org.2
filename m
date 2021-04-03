Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE99C3531C6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 02:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbhDCAaJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 2 Apr 2021 20:30:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42800 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235720AbhDCAaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 20:30:07 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1330TeUk004949
        for <linux-kernel@vger.kernel.org>; Fri, 2 Apr 2021 17:30:06 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37nsn9dtg9-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 17:30:05 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Apr 2021 17:29:49 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id D665062E209C; Fri,  2 Apr 2021 17:29:46 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <acme@kernel.org>, <acme@redhat.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <songliubraving@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH 1/2] perf util: move bperf definitions to a libperf header
Date:   Fri, 2 Apr 2021 17:29:37 -0700
Message-ID: <20210403002938.390878-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uwv6T2qfesb96eJYRNcuWmKtppG6Zg2M
X-Proofpoint-GUID: uwv6T2qfesb96eJYRNcuWmKtppG6Zg2M
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-02_16:2021-04-01,2021-04-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1034 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104030001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By following the same protocol, other tools can share hardware PMCs with
perf. Move perf_event_attr_map_entry and BPERF_DEFAULT_ATTR_MAP_PATH to
bperf.h for other tools to use.

Also add bperf_attr_map_compatible() to check whether existing attr_map
is compatible with current perf binary.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/lib/perf/include/perf/bperf.h | 29 +++++++++++++++++++
 tools/perf/util/bpf_counter.c       | 44 ++++++++++++++---------------
 2 files changed, 50 insertions(+), 23 deletions(-)
 create mode 100644 tools/lib/perf/include/perf/bperf.h

diff --git a/tools/lib/perf/include/perf/bperf.h b/tools/lib/perf/include/perf/bperf.h
new file mode 100644
index 0000000000000..02b2fd5e50c75
--- /dev/null
+++ b/tools/lib/perf/include/perf/bperf.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
+#ifndef __LIBPERF_BPERF_H
+#define __LIBPERF_BPERF_H
+
+/*
+ * bperf uses a hashmap, the attr_map, to track all the leader programs.
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
+/* pin the map at sysfs__mountpoint()/BPERF_DEFAULT_ATTR_MAP_PATH */
+#define BPERF_DEFAULT_ATTR_MAP_PATH "fs/bpf/perf_attr_map"
+
+#endif /* __LIBPERF_BPERF_H */
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index 81d1df3c4ec0e..df70c8dcf7850 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -14,6 +14,7 @@
 #include <bpf/btf.h>
 #include <bpf/libbpf.h>
 #include <api/fs/fs.h>
+#include <perf/bperf.h>
 
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
@@ -333,6 +312,20 @@ static __u32 bpf_map_get_id(int fd)
 	return map_info.id;
 }
 
+static bool bperf_attr_map_compatible(int attr_map_fd)
+{
+	struct bpf_map_info map_info = {0};
+	__u32 map_info_len = sizeof(map_info);
+	int err;
+
+	err = bpf_obj_get_info_by_fd(attr_map_fd, &map_info, &map_info_len);
+
+	if (err)
+		return false;
+	return (map_info.key_size == sizeof(struct perf_event_attr)) &&
+		(map_info.value_size == sizeof(struct perf_event_attr_map_entry));
+}
+
 static int bperf_lock_attr_map(struct target *target)
 {
 	char path[PATH_MAX];
@@ -342,7 +335,7 @@ static int bperf_lock_attr_map(struct target *target)
 		scnprintf(path, PATH_MAX, "%s", target->attr_map);
 	} else {
 		scnprintf(path, PATH_MAX, "%s/%s", sysfs__mountpoint(),
-			  DEFAULT_ATTR_MAP_PATH);
+			  BPERF_DEFAULT_ATTR_MAP_PATH);
 	}
 
 	if (access(path, F_OK)) {
@@ -367,6 +360,11 @@ static int bperf_lock_attr_map(struct target *target)
 			return -1;
 	}
 
+	if (!bperf_attr_map_compatible(map_fd)) {
+		close(map_fd);
+		return -1;
+
+	}
 	err = flock(map_fd, LOCK_EX);
 	if (err) {
 		close(map_fd);
-- 
2.30.2

