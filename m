Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12AD31F334
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 00:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBRX6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 18:58:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47026 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229656AbhBRX6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 18:58:51 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11INwAO5019460
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 15:58:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=a3MtBW7828u/FCxz7CQYm9Gq4iuxkyvBumbO+Xi1bQM=;
 b=lpNcIxHGgF/p74w3SVPGl14GC9ozD0LOQoL2gbjzTna+8BgP+Z35qbQYe0lGpxh8fVkk
 lOwTlvxVBRuIIh6Na41eeWosw4ivN9G/172dNKqIDh4G3LiJ8PEHaYEw0StDHMUXyuss
 TzPy8N1QLW7Z8jruyYAYsq2dBOaUPYiVbxs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36rrd8nv99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 15:58:10 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Feb 2021 15:58:09 -0800
Received: from devvm1945.atn0.facebook.com (localhost [127.0.0.1])
        by devvm1945.atn0.facebook.com (Postfix) with ESMTP id 10CEB32F32F5;
        Thu, 18 Feb 2021 15:58:05 -0800 (PST)
Received: (from saravanand@localhost)
        by devvm1945.atn0.facebook.com (8.15.2/8.15.2/Submit) id 11INw4nP1041752;
        Thu, 18 Feb 2021 15:58:04 -0800
X-Authentication-Warning: devvm1945.atn0.facebook.com: saravanand set sender to saravanand@fb.com using -f
From:   Saravanan D <saravanand@fb.com>
To:     <akpm@linux-foundation.org>, <mingo@redhat.com>, <x86@kernel.org>
CC:     <dave.hansen@linux.intel.com>, <tj@kernel.org>,
        <hannes@cmpxchg.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Saravanan D <saravanand@fb.com>
Subject: [PATCH V6] x86/mm: Tracking linear mapping split events
Date:   Thu, 18 Feb 2021 15:57:44 -0800
Message-ID: <20210218235744.1040634-1-saravanand@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-18_14:2021-02-18,2021-02-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102180203
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To help with debugging the sluggishness caused by TLB miss/reload,
we introduce monotonic hugepage [direct mapped] split event counts since
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

One of the many lasting sources of direct hugepage splits is kernel
tracing (kprobes, tracepoints).

Note that the kernel's code segment [512 MB] points to the same
physical addresses that have been already mapped in the kernel's
direct mapping range.

Source : Documentation/x86/x86_64/mm.rst

When we enable kernel tracing, the kernel has to modify
attributes/permissions
of the text segment hugepages that are direct mapped causing them to
split.

Kernel's direct mapped hugepages do not coalesce back after split and
remain in place for the remainder of the lifetime.

An instance of direct page splits when we turn on
dynamic kernel tracing
....
cat /proc/vmstat | grep -i direct_map_level
direct_map_level2_splits 784
direct_map_level3_splits 12
bpftrace -e 'tracepoint:raw_syscalls:sys_enter { @ [pid, comm] =3D
count(); }'
cat /proc/vmstat | grep -i
direct_map_level
direct_map_level2_splits 789
direct_map_level3_splits 12
....

Signed-off-by: Saravanan D <saravanand@fb.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
This patch has been acked and can be routed through either x86 or -mm
Please let me know if there's anything needed. Thanks.
---
 arch/x86/mm/pat/set_memory.c  | 8 ++++++++
 include/linux/vm_event_item.h | 4 ++++
 mm/vmstat.c                   | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 16f878c26667..a7b3c5f1d316 100644
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
@@ -91,6 +93,12 @@ static void split_page_count(int level)
 		return;
=20
 	direct_pages_count[level]--;
+	if (system_state =3D=3D SYSTEM_RUNNING) {
+		if (level =3D=3D PG_LEVEL_2M)
+			count_vm_event(DIRECT_MAP_LEVEL2_SPLIT);
+		else if (level =3D=3D PG_LEVEL_1G)
+			count_vm_event(DIRECT_MAP_LEVEL3_SPLIT);
+	}
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

