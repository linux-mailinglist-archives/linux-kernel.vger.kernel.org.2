Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3218A30673D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 23:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbhA0Ww1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 17:52:27 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11422 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230526AbhA0WwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:52:01 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10RMjTJL030601
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 14:51:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=bvaiGMM1mr9eGI8AlmM77HhvzHcIVW0PiMrP4anZWEQ=;
 b=S6hmmiNDyAK1HOMcbN0appLyoi5U1L9z6O3SvtQxR53DPX3dtLDqv+7q3vzGPnpHZ8ag
 KAm+hPdoOiUbUe54C5ICSt4Eq+LCO9cUThPr5x4+56OmXZMKfvR44mU8FQocf6bZKf6J
 i2KIb7gePYRik2DLOovon7lD5dmzXi5wCA0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36adeu39n9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 14:51:21 -0800
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 Jan 2021 14:51:19 -0800
Received: from devvm1945.atn0.facebook.com (localhost [127.0.0.1])
        by devvm1945.atn0.facebook.com (Postfix) with ESMTP id CB7ED2545C5C;
        Wed, 27 Jan 2021 14:51:14 -0800 (PST)
Received: (from saravanand@localhost)
        by devvm1945.atn0.facebook.com (8.15.2/8.15.2/Submit) id 10RMpBaj246973;
        Wed, 27 Jan 2021 14:51:11 -0800
X-Authentication-Warning: devvm1945.atn0.facebook.com: saravanand set sender to saravanand@fb.com using -f
From:   Saravanan D <saravanand@fb.com>
To:     <x86@kernel.org>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Saravanan D <saravanand@fb.com>
Subject: [PATCH V3] x86/mm: Tracking linear mapping split events
Date:   Wed, 27 Jan 2021 14:50:59 -0800
Message-ID: <20210127225059.246646-1-saravanand@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <YBHc4JHc4ogwV93W@slm.duckdns.org>
References: <YBHc4JHc4ogwV93W@slm.duckdns.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-27_09:2021-01-27,2021-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101270114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To help with debugging the sluggishness caused by TLB miss/reload,
we introduce monotonic lifetime hugepage split event counts since
system state: SYSTEM_RUNNING to be displayed as part of
/proc/vmstat in x86 servers

The lifetime split event information will be displayed at the bottom of
/proc/vmstat
....
swap_ra 0
swap_ra_hit 0
direct_map_2M_splits 167
direct_map_1G_splits 6
nr_unstable 0
....

One of the many lasting (as we don't coalesce back) sources for huge page
splits is tracing as the granular page attribute/permission changes would
force the kernel to split code segments mapped to huge pages to smaller
ones thereby increasing the probability of TLB miss/reload even after
tracing has been stopped.

Signed-off-by: Saravanan D <saravanand@fb.com>
---
 arch/x86/mm/pat/set_memory.c  | 18 ++++++++++++++++++
 include/linux/vm_event_item.h |  8 ++++++++
 mm/vmstat.c                   |  8 ++++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 16f878c26667..3ea6316df089 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -16,6 +16,8 @@
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
 #include <linux/libnvdimm.h>
+#include <linux/vmstat.h>
+#include <linux/kernel.h>
=20
 #include <asm/e820/api.h>
 #include <asm/processor.h>
@@ -85,12 +87,28 @@ void update_page_count(int level, unsigned long pages=
)
 	spin_unlock(&pgd_lock);
 }
=20
+void update_split_page_event_count(int level)
+{
+	if (system_state =3D=3D SYSTEM_RUNNING) {
+		if (level =3D=3D PG_LEVEL_2M) {
+#if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
+			count_vm_event(DIRECT_MAP_2M_SPLIT);
+#else
+			count_vm_event(DIRECT_MAP_4M_SPLIT);
+#endif
+		} else if (level =3D=3D PG_LEVEL_1G) {
+			count_vm_event(DIRECT_MAP_1G_SPLIT);
+		}
+	}
+}
+
 static void split_page_count(int level)
 {
 	if (direct_pages_count[level] =3D=3D 0)
 		return;
=20
 	direct_pages_count[level]--;
+	update_split_page_event_count(level);
 	direct_pages_count[level - 1] +=3D PTRS_PER_PTE;
 }
=20
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.=
h
index 18e75974d4e3..439742d2435e 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -120,6 +120,14 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOU=
T,
 #ifdef CONFIG_SWAP
 		SWAP_RA,
 		SWAP_RA_HIT,
+#endif
+#if defined(__x86_64__)
+#if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
+		DIRECT_MAP_2M_SPLIT,
+#else
+		DIRECT_MAP_4M_SPLIT,
+#endif
+		DIRECT_MAP_1G_SPLIT,
 #endif
 		NR_VM_EVENT_ITEMS
 };
diff --git a/mm/vmstat.c b/mm/vmstat.c
index f8942160fc95..beaa2bb4f9dc 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1350,6 +1350,14 @@ const char * const vmstat_text[] =3D {
 	"swap_ra",
 	"swap_ra_hit",
 #endif
+#if defined(__x86_64__)
+#if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
+	"direct_map_2M_splits",
+#else
+	"direct_map_4M_splits",
+#endif
+	"direct_map_1G_splits",
+#endif
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
 #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG =
*/
--=20
2.24.1

