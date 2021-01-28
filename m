Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10F8306C53
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 05:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhA1Eg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 23:36:59 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59612 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231195AbhA1Eg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 23:36:57 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10S4ZlN2023543
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 20:36:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=SwVCKp0r6gFACJfftCN8eNHYhdZ14H/iWTTsEWW7dR0=;
 b=bL7oHlEy7rAoZgLpc9MSeXObIJYztgo5JVUGXfr1vAORE3aMUhFZvqKDUT+pAhkcMRc2
 7e48kVu7S6YQust/F8OF1T5CvQb0tAfe0OhGfwl92MVybjs4JAny+U7Fuwlc8stasY/X
 3xs7W9luHpsYfZ6XJvQdCvIWOv9r0iXFUCM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36adeu4hbd-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 20:36:17 -0800
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 Jan 2021 20:36:14 -0800
Received: from devvm1945.atn0.facebook.com (localhost [127.0.0.1])
        by devvm1945.atn0.facebook.com (Postfix) with ESMTP id 17EE1257233B;
        Wed, 27 Jan 2021 20:36:12 -0800 (PST)
Received: (from saravanand@localhost)
        by devvm1945.atn0.facebook.com (8.15.2/8.15.2/Submit) id 10S4a9Uj1561314;
        Wed, 27 Jan 2021 20:36:09 -0800
X-Authentication-Warning: devvm1945.atn0.facebook.com: saravanand set sender to saravanand@fb.com using -f
From:   Saravanan D <saravanand@fb.com>
To:     <x86@kernel.org>, <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <peterz@infradead.org>, <corbet@lwn.net>
CC:     <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        <linux-doc@vger.kernel.org>, Saravanan D <saravanand@fb.com>
Subject: [PATCH V4] x86/mm: Tracking linear mapping split events
Date:   Wed, 27 Jan 2021 20:35:47 -0800
Message-ID: <20210128043547.1560435-1-saravanand@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <a936a943-9d8f-7e3c-af38-1c99ae176e1f@intel.com>
References: <a936a943-9d8f-7e3c-af38-1c99ae176e1f@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-28_01:2021-01-27,2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280021
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
direct_map_level2_splits 94
direct_map_level3_splits 4
nr_unstable 0
....

One of the many lasting (as we don't coalesce back) sources for huge page
splits is tracing as the granular page attribute/permission changes would
force the kernel to split code segments mapped to huge pages to smaller
ones thereby increasing the probability of TLB miss/reload even after
tracing has been stopped.

Documentation regarding linear mapping split events added to admin-guide
as requested in V3 of the patch.

Signed-off-by: Saravanan D <saravanand@fb.com>
---
 .../admin-guide/mm/direct_mapping_splits.rst  | 59 +++++++++++++++++++
 Documentation/admin-guide/mm/index.rst        |  1 +
 arch/x86/mm/pat/set_memory.c                  | 13 ++++
 include/linux/vm_event_item.h                 |  4 ++
 mm/vmstat.c                                   |  4 ++
 5 files changed, 81 insertions(+)
 create mode 100644 Documentation/admin-guide/mm/direct_mapping_splits.rs=
t

diff --git a/Documentation/admin-guide/mm/direct_mapping_splits.rst b/Doc=
umentation/admin-guide/mm/direct_mapping_splits.rst
new file mode 100644
index 000000000000..298751391deb
--- /dev/null
+++ b/Documentation/admin-guide/mm/direct_mapping_splits.rst
@@ -0,0 +1,59 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Direct Mapping Splits
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Kernel maps all of physical memory in linear/direct mapped pages with
+translation of virtual kernel address to physical address is achieved
+through a simple subtraction of offset. CPUs maintain a cache of these
+translations on fast caches called TLBs. CPU architectures like x86 allo=
w
+direct mapping large portions of memory into hugepages (2M, 1G, etc) in
+various page table levels.
+
+Maintaining huge direct mapped pages greatly reduces TLB miss pressure.
+The splintering of huge direct pages into smaller ones does result in
+a measurable performance hit caused by frequent TLB miss and reloads.
+
+One of the many lasting (as we don't coalesce back) sources for huge pag=
e
+splits is tracing as the granular page attribute/permission changes woul=
d
+force the kernel to split code segments mapped to hugepages to smaller
+ones thus increasing the probability of TLB miss/reloads even after
+tracing has been stopped.
+
+On x86 systems, we can track the splitting of huge direct mapped pages
+through lifetime event counters in ``/proc/vmstat``
+
+	direct_map_level2_splits xxx
+	direct_map_level3_splits yyy
+
+where:
+
+direct_map_level2_splits
+	are 2M/4M hugepage split events
+direct_map_level3_splits
+	are 1G hugepage split events
+
+The distribution of direct mapped system memory in various page sizes
+post splits can be viewed through ``/proc/meminfo`` whose output
+will include the following lines depending upon supporting CPU
+architecture
+
+	DirectMap4k:    xxxxx kB
+	DirectMap2M:    yyyyy kB
+	DirectMap1G:    zzzzz kB
+
+where:
+
+DirectMap4k
+	is the total amount of direct mapped memory (in kB)
+	accessed through 4k pages
+DirectMap2M
+	is the total amount of direct mapped memory (in kB)
+	accessed through 2M pages
+DirectMap1G
+	is the total amount of direct mapped memory (in kB)
+	accessed through 1G pages
+
+
+-- Saravanan D, Jan 27, 2021
diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin=
-guide/mm/index.rst
index 4b14d8b50e9e..9439780f3f07 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -38,3 +38,4 @@ the Linux memory management.
    soft-dirty
    transhuge
    userfaultfd
+   direct_mapping_splits
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 16f878c26667..767cade53bdc 100644
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
@@ -85,12 +87,23 @@ void update_page_count(int level, unsigned long pages=
)
 	spin_unlock(&pgd_lock);
 }
=20
+void update_split_page_event_count(int level)
+{
+	if (system_state =3D=3D SYSTEM_RUNNING) {
+		if (level =3D=3D PG_LEVEL_2M)
+			count_vm_event(DIRECT_MAP_LEVEL2_SPLIT);
+		else if (level =3D=3D PG_LEVEL_1G)
+			count_vm_event(DIRECT_MAP_LEVEL3_SPLIT);
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
index 18e75974d4e3..7c06c2bdc33b 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -120,6 +120,10 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOU=
T,
 #ifdef CONFIG_SWAP
 		SWAP_RA,
 		SWAP_RA_HIT,
+#endif
+#ifdef CONFIG_X86
+		DIRECT_MAP_LEVEL2_SPLIT,
+		DIRECT_MAP_LEVEL3_SPLIT,
 #endif
 		NR_VM_EVENT_ITEMS
 };
diff --git a/mm/vmstat.c b/mm/vmstat.c
index f8942160fc95..a43ac4ac98a2 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1350,6 +1350,10 @@ const char * const vmstat_text[] =3D {
 	"swap_ra",
 	"swap_ra_hit",
 #endif
+#ifdef CONFIG_X86
+	"direct_map_level2_splits",
+	"direct_map_level3_splits",
+#endif
 #endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
 #endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG =
*/
--=20
2.24.1

