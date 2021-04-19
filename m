Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21847364B38
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 22:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242196AbhDSUhq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 19 Apr 2021 16:37:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:25030 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242155AbhDSUhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 16:37:41 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JKUM0O006778
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 13:37:11 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 380fbaq70f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 13:37:11 -0700
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Apr 2021 13:37:10 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id AA43B62E1A1C; Mon, 19 Apr 2021 13:37:05 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <acme@kernel.org>, <acme@redhat.com>,
        <namhyung@kernel.org>, <jolsa@kernel.org>, <songliubraving@fb.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v4 2/4] perf bpf: check perf_attr_map is compatible with the perf binary
Date:   Mon, 19 Apr 2021 13:36:47 -0700
Message-ID: <20210419203649.164121-3-song@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210419203649.164121-1-song@kernel.org>
References: <20210419203649.164121-1-song@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: kvHToDNGobPh2iY5L3CUyOshuukWnKS6
X-Proofpoint-ORIG-GUID: kvHToDNGobPh2iY5L3CUyOshuukWnKS6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_11:2021-04-19,2021-04-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 clxscore=1034 phishscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=9
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104190141
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf_attr_map could be shared among different version of perf binary. Add
bperf_attr_map_compatible() to check whether the existing attr_map is
compatible with current perf binary.

Signed-off-by: Song Liu <song@kernel.org>
---
 tools/perf/util/bpf_counter.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
index be484ddbbd5be..5de991ab46af9 100644
--- a/tools/perf/util/bpf_counter.c
+++ b/tools/perf/util/bpf_counter.c
@@ -312,6 +312,20 @@ static __u32 bpf_map_get_id(int fd)
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
@@ -346,6 +360,11 @@ static int bperf_lock_attr_map(struct target *target)
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

