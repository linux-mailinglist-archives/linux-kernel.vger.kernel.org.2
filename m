Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E61636DC2F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240959AbhD1Pnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:43:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42420 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240477AbhD1Phz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:55 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFKhaA029931;
        Wed, 28 Apr 2021 15:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=pv6uCKl9cr94UJyWun8mN17SpPD1eqBNgLe0A9cpU04=;
 b=UJotaCeW5ebCMiEMF3tj1dmYS//lVS3fh7ISgSOlWcN7ZKRO/WLBUWCz/3zktUZPplZ/
 m7kZja5sGcjRo8aS5mfhDzC8Tcihyxu+TKixr6V3X69ldqwkXm22W5f8me/fY7oVxz3X
 t6TWcJkxcXnGHeLcq2+ObRx0EwwUUaXXLu8YNAHYoF0qW50KAgRMm05ZoXTqiC8JsQOP
 MRqYTBkug++ITJb4YoWnBvvqPOpkfooTOhmZdFKW1jzqMip6//sR6tE9h0pFtWawMVqm
 p/SgepGYxg5xr0NeClAYZ74Ufjbu1HdJA3VIuPApuyoYlMgXpZ9mBD1k/RfGKsPmjx7S Ow== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 386mxjh62f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:45 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaASt030176;
        Wed, 28 Apr 2021 15:36:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 384w3uuag3-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q04WMMRU0W5+Z0Dp3snrYwT6L5bee26vq1tjFzhygY/1iihoP2UiKyM4Ekb3uqWG3wl3ZKpj4YmuEYrdi3pIfjytJI51MMJq3b4sic38zldWKSF+pBeqco1U1w3JMbEPYdFOZLGLoZ0K9z2ST4sjlJreGHxX8INB40jNPC6uDXBm4Gye9XDW1P4iafnqE9lravsS35OpGk1vhmH7dNqU0MFF5UN/bB6YOct8KKuGYOK/S5ihSbsz5WQRrmcINZ5itf6UaUO2sJRjYrUqj4CYV19/mqVi9heDbNiPq6fXYngqxNdbowp2zzZNKWYkxB2/C9MCH/t5dpfeydxgklRtaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv6uCKl9cr94UJyWun8mN17SpPD1eqBNgLe0A9cpU04=;
 b=FQiyMYGXYaYtMAtYxIn01XX8P/DIgf76u/Cbnjtl/uKDr/doTsDcIrHX6D+MeeXEPJdeIr1b5edzgIR7djWMNASlpHxIIZC09HIV5MTaAfMGj4deAop+pHddecn5QXO5NJB2Jh6st9iQ7w1DmXqKPwaDzOTqqlqW7ntRZPicWIZkh0aEvIRWQX2kPHc0pDm9LQ3TNp9PBTIxcKpw6Fq7u6tq5XLmyX6YkrM+vYSf+bj47/Eaovgp8VwJqmsIJa9+UasEDTb0IQmu7Pp/kp9s4BaKSUgnuUqCoIZJdsZgfJvMowGBpsq+aokUoBCGq2b0n9WAuZUYgeIeX7PDfK3FhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv6uCKl9cr94UJyWun8mN17SpPD1eqBNgLe0A9cpU04=;
 b=VbtfpfVHfAmwT31fG94uLd8q6LBPuDbCfWUVbWYZPm80QMD2S/yNEqU4+FRzQdDMWm5q+9KbnFP5bDxhSpVZfI03pgQa4dWui3v2qmgEjVq9fyphzRD+axiowVnIyG2HSGsTBKxc7imvu32f+/vTFtSSqtlz2jNosR0BuXMwtiE=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:36:41 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 44/94] mm: Remove vmacache
Thread-Topic: [PATCH 44/94] mm: Remove vmacache
Thread-Index: AQHXPEQ3fPdob8VQp0mpeaOUxeof3g==
Date:   Wed, 28 Apr 2021 15:36:10 +0000
Message-ID: <20210428153542.2814175-45-Liam.Howlett@Oracle.com>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3da4dca5-2032-4fe1-d21b-08d90a5b6bcb
x-ms-traffictypediagnostic: CO1PR10MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB45152008852BAD1E867F5615FD409@CO1PR10MB4515.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5k4xfCPZXx8j1rmLhJafi4AZ0UI9dX8b4tFTIvhbnnSGanDWp8l8G00APdPQh4lnHb7rQnBrhXKixTaqOuQvMseHFpaOydLrKvfT98llKuFCHvQ6FUwKH+I672r7CPG01hKemf4Dazq26+OwXj93NEiXn2r+UntLLpkysa1jJB9EpSB6QoDFRGl6eI8yKLojeot3ic+qpJ2AfMlgSYTLcWH2VRQkTL9HTD/PUTkdBfC41kAYBKwEmgobP9yhWiPmGwEYLMNn2RQhEpZBTZLWiwCJqsNG1xwQpjvTZ1LP+FQ5c2Q9hRh6fIXwjzL484QqHMHKhq6PVkq/D+L+bqSCx3cIKnXj9raFVCiuN8+xVBiiGpHYnzlfnowE6nTXubp6Bkx64wfM8/+205gsuaJl5vtojgEHUeeKjWOoojWPxwGgY7E6NTXvV6ijz/9B5LWZisru1FnoHuEqIYQAbda3jIUwoO4Wqm5ezLWEIw+lM9cZxdU/5/JmS91LzS0CbSh+FQyfS9w/bxmRo/7g2fMTXX+FuV5YvJ67vk3PDwIMXsq3dzG7vMyRaCPYx0iQQfY9pSxDqgpQHg6CdnrR1E7dzueZosbBiLrVFglPzRCaS44=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6506007)(4326008)(36756003)(54906003)(71200400001)(26005)(110136005)(6666004)(30864003)(316002)(8936002)(186003)(44832011)(7416002)(2616005)(8676002)(76116006)(2906002)(91956017)(66556008)(66946007)(478600001)(66446008)(1076003)(107886003)(64756008)(86362001)(5660300002)(66476007)(83380400001)(6486002)(122000001)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?6Z4GxMDlwRSGk4LtKhrgqcoP/OGPdGUhf5rgPo8QJtaaboB33EbSSRTSGc?=
 =?iso-8859-1?Q?f3/n71oob8U+lNiw1TBodhdcQDZ1RLB+DYPPRUZXuMykTFzWXLezzuDuNz?=
 =?iso-8859-1?Q?URfWGNQ3U55HJfimneIe2+xUsMYL8gVl8kEKJlmGYeyUsQQ3UMmolq8vX8?=
 =?iso-8859-1?Q?Ah++IOYW+DjDr3Q6Gnifs4v9oK3KOIXcZ0kxq5/9km05/JDxz4R3LvmqkR?=
 =?iso-8859-1?Q?llEeJM+a4Y4wtlZJnCDB9jhlGuedI+ffxEMjTK75hlNOIxec+AkBxUA7nR?=
 =?iso-8859-1?Q?iNa2PK8v94hwvToelmTtwjGIMZjX7rQzlj+OLIa4Jgii+bkDuVYHFHZNbC?=
 =?iso-8859-1?Q?Y2GLEh1uhTOvWNSAuCX37P+58OLyxuRdL7PvAr0hLNeaFGUnUR/tGETFN3?=
 =?iso-8859-1?Q?7owcC/zzmQ9yQez81q4bvxHdLFSrzhssnZjJlum6BH6qki5OnUrIDIHIxn?=
 =?iso-8859-1?Q?+ZpWkreQxSHTiVhjUUMn/+IjyLdfGGFgC6p1s3biQZaG5yipd089vPEZ3O?=
 =?iso-8859-1?Q?VZuVy+IaSc8vAlklu26crc8eJFUbflm5mGVlaiut7o5wWyWR4lZTQefJwS?=
 =?iso-8859-1?Q?4K8N0FbynJqBcQqxYS4T2fzuB/T/Vi/99cgQB2Uvd13+VRvJYjK1Vfmpn6?=
 =?iso-8859-1?Q?2pTkpK6J/sSMba3cXvIYIMYwnj3++jaxxcKtS1fgR8NGO6EDJUz9CpLFD9?=
 =?iso-8859-1?Q?mN7C8499nbFsQGzQE20l7pwBs/XzAtffgmFxmFrkxO2UIZnpIyEGhoRz4N?=
 =?iso-8859-1?Q?qlM7uJ/94n7bIXRp39ZwKazsOiZHLdlpQlTJ+1D3JSvEA6mEWT5nZ89hYw?=
 =?iso-8859-1?Q?NNktrsF2n+LKc3360hKSPfRthNDvvbIs2X4OmR955J24BpavkjQC/y1kz1?=
 =?iso-8859-1?Q?xCdVSqUYZiHslUllAzChp8Fua3IE5lwSuaql5pkomMGuRtKd1x1mhn09hu?=
 =?iso-8859-1?Q?2gGT9DelpG68cb9AaARwRxzEEdt1luflxSCt8TvdIUgVRgWMVwTCZfsA2+?=
 =?iso-8859-1?Q?+RNdGheRNHQ5ZC8Fbb0rb/tltsEG5Lud5uWRpO4SK7a/yvMxSoPJD7V6nl?=
 =?iso-8859-1?Q?YSJ2S/Vh5HuF0mwYKQUFt9XzNTcMMDn8tsBvuXva4khP9aXa2qIhueiBjv?=
 =?iso-8859-1?Q?Q9xVILy2xoQnxTqP/DJgU1Zo6P7bFS4w7T2OywW5PYNlxSZHR+ikh8PJ3P?=
 =?iso-8859-1?Q?RSuQkcTeJA5EmZAVkDRqkWRdjmyzn4aORHkrkPzOmf85UrqQsl/yVnUc0T?=
 =?iso-8859-1?Q?HGhopRD9pYqVNCUl2rpwHKZwg4yV8B0PIw0l+XpPula+0a1L3NjhQNjRAL?=
 =?iso-8859-1?Q?etMnyDb06mat6bn9bQXsSqrHGNFvlyfPYiSDvFhZSw9QchonEtN6QOMZ+1?=
 =?iso-8859-1?Q?v2EPTOpe0Z?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da4dca5-2032-4fe1-d21b-08d90a5b6bcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:10.9872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qv+IpClKqrFHaetndwny5OpKY76vkoLCb0TMHKh+nceFNp/2vDJ00vXiQsBBHeHxmcSqqqX8oROSPwP1rbM0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: Rog7pA2HNBjs2DFm_AeC_ULDfNclUER-
X-Proofpoint-ORIG-GUID: Rog7pA2HNBjs2DFm_AeC_ULDfNclUER-
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The maple tree is able to find a VMA quick enough to no longer need the
vma cache.  Remove the vmacache to reduce work in keeping it up to date
and code complexity.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/s390/configs/debug_defconfig |   1 -
 fs/exec.c                         |   3 -
 fs/proc/task_mmu.c                |   1 -
 include/linux/mm_types.h          |   1 -
 include/linux/mm_types_task.h     |   5 --
 include/linux/sched.h             |   1 -
 include/linux/vm_event_item.h     |   4 -
 include/linux/vmacache.h          |  28 -------
 include/linux/vmstat.h            |   6 --
 kernel/debug/debug_core.c         |  12 ---
 kernel/fork.c                     |   5 --
 lib/Kconfig.debug                 |  10 ---
 mm/Makefile                       |   2 +-
 mm/debug.c                        |   4 +-
 mm/mmap.c                         |  17 -----
 mm/nommu.c                        |  31 +-------
 mm/vmacache.c                     | 117 ------------------------------
 mm/vmstat.c                       |   4 -
 18 files changed, 6 insertions(+), 246 deletions(-)
 delete mode 100644 include/linux/vmacache.h
 delete mode 100644 mm/vmacache.c

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_de=
fconfig
index 6422618a4f75..a7aed6dbc06e 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -790,7 +790,6 @@ CONFIG_SLUB_DEBUG_ON=3Dy
 CONFIG_SLUB_STATS=3Dy
 CONFIG_DEBUG_STACK_USAGE=3Dy
 CONFIG_DEBUG_VM=3Dy
-CONFIG_DEBUG_VM_VMACACHE=3Dy
 CONFIG_DEBUG_VM_PGFLAGS=3Dy
 CONFIG_DEBUG_MEMORY_INIT=3Dy
 CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=3Dm
diff --git a/fs/exec.c b/fs/exec.c
index 18594f11c31f..3d3f7d46137c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -28,7 +28,6 @@
 #include <linux/file.h>
 #include <linux/fdtable.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/swap.h>
@@ -1020,8 +1019,6 @@ static int exec_mmap(struct mm_struct *mm)
 	activate_mm(active_mm, mm);
 	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
 		local_irq_enable();
-	tsk->mm->vmacache_seqnum =3D 0;
-	vmacache_flush(tsk);
 	task_unlock(tsk);
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index fc9784544b24..503e1355cf6e 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pagewalk.h>
-#include <linux/vmacache.h>
 #include <linux/hugetlb.h>
 #include <linux/huge_mm.h>
 #include <linux/mount.h>
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 41551bfa6ce0..304692ada024 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -380,7 +380,6 @@ struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
-		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
 				unsigned long addr, unsigned long len,
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index c1bc6731125c..33c9fa4d4f66 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -31,11 +31,6 @@
 #define VMACACHE_SIZE (1U << VMACACHE_BITS)
 #define VMACACHE_MASK (VMACACHE_SIZE - 1)
=20
-struct vmacache {
-	u64 seqnum;
-	struct vm_area_struct *vmas[VMACACHE_SIZE];
-};
-
 /*
  * When updating this, please also update struct resident_page_types[] in
  * kernel/fork.c
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8d5264b18cb6..e85fcd3ef86a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -772,7 +772,6 @@ struct task_struct {
 	struct mm_struct		*active_mm;
=20
 	/* Per-thread vma caching: */
-	struct vmacache			vmacache;
=20
 #ifdef SPLIT_RSS_COUNTING
 	struct task_rss_stat		rss_stat;
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index ae0dd1948c2b..cd3ff075470b 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -117,10 +117,6 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NR_TLB_LOCAL_FLUSH_ALL,
 		NR_TLB_LOCAL_FLUSH_ONE,
 #endif /* CONFIG_DEBUG_TLBFLUSH */
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-		VMACACHE_FIND_CALLS,
-		VMACACHE_FIND_HITS,
-#endif
 #ifdef CONFIG_SWAP
 		SWAP_RA,
 		SWAP_RA_HIT,
diff --git a/include/linux/vmacache.h b/include/linux/vmacache.h
deleted file mode 100644
index 6fce268a4588..000000000000
--- a/include/linux/vmacache.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_VMACACHE_H
-#define __LINUX_VMACACHE_H
-
-#include <linux/sched.h>
-#include <linux/mm.h>
-
-static inline void vmacache_flush(struct task_struct *tsk)
-{
-	memset(tsk->vmacache.vmas, 0, sizeof(tsk->vmacache.vmas));
-}
-
-extern void vmacache_update(unsigned long addr, struct vm_area_struct *new=
vma);
-extern struct vm_area_struct *vmacache_find(struct mm_struct *mm,
-						    unsigned long addr);
-
-#ifndef CONFIG_MMU
-extern struct vm_area_struct *vmacache_find_exact(struct mm_struct *mm,
-						  unsigned long start,
-						  unsigned long end);
-#endif
-
-static inline void vmacache_invalidate(struct mm_struct *mm)
-{
-	mm->vmacache_seqnum++;
-}
-
-#endif /* __LINUX_VMACACHE_H */
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 3299cd69e4ca..0517f3b123ea 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -125,12 +125,6 @@ static inline void vm_events_fold_cpu(int cpu)
 #define count_vm_tlb_events(x, y) do { (void)(y); } while (0)
 #endif
=20
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-#define count_vm_vmacache_event(x) count_vm_event(x)
-#else
-#define count_vm_vmacache_event(x) do {} while (0)
-#endif
-
 #define __count_zid_vm_events(item, zid, delta) \
 	__count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
=20
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 4708aec492df..1bd0bb76ed2c 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -53,7 +53,6 @@
 #include <linux/pid.h>
 #include <linux/smp.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/rcupdate.h>
 #include <linux/irq.h>
=20
@@ -285,17 +284,6 @@ static void kgdb_flush_swbreak_addr(unsigned long addr=
)
 	if (!CACHE_FLUSH_IS_SAFE)
 		return;
=20
-	if (current->mm) {
-		int i;
-
-		for (i =3D 0; i < VMACACHE_SIZE; i++) {
-			if (!current->vmacache.vmas[i])
-				continue;
-			flush_cache_range(current->vmacache.vmas[i],
-					  addr, addr + BREAK_INSTR_SIZE);
-		}
-	}
-
 	/* Force flush instruction cache if it was outside the mm */
 	flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 83afd3007a2b..fe0922f75cc5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -42,7 +42,6 @@
 #include <linux/mmu_notifier.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/nsproxy.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
@@ -1027,7 +1026,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 {
 	mm->mmap =3D NULL;
 	mt_init_flags(&mm->mm_mt, MAPLE_ALLOC_RANGE);
-	mm->vmacache_seqnum =3D 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
 	seqcount_init(&mm->write_protect_seq);
@@ -1425,9 +1423,6 @@ static int copy_mm(unsigned long clone_flags, struct =
task_struct *tsk)
 	if (!oldmm)
 		return 0;
=20
-	/* initialize the new vmacache entries */
-	vmacache_flush(tsk);
-
 	if (clone_flags & CLONE_VM) {
 		mmget(oldmm);
 		mm =3D oldmm;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index df977009425e..2328b8aa1f54 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -789,16 +789,6 @@ config DEBUG_VM
=20
 	  If unsure, say N.
=20
-config DEBUG_VM_VMACACHE
-	bool "Debug VMA caching"
-	depends on DEBUG_VM
-	help
-	  Enable this to turn on VMA caching debug information. Doing so
-	  can cause significant overhead, so only enable it in non-production
-	  environments.
-
-	  If unsure, say N.
-
 config DEBUG_VM_RB
 	bool "Debug VM red-black trees"
 	depends on DEBUG_VM
diff --git a/mm/Makefile b/mm/Makefile
index a9ad6122d468..a061cf7fd591 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -50,7 +50,7 @@ obj-y			:=3D filemap.o mempool.o oom_kill.o fadvise.o \
 			   readahead.o swap.o truncate.o vmscan.o shmem.o \
 			   util.o mmzone.o vmstat.o backing-dev.o \
 			   mm_init.o percpu.o slab_common.o \
-			   compaction.o vmacache.o \
+			   compaction.o \
 			   interval_tree.o list_lru.o workingset.o \
 			   debug.o gup.o mmap_lock.o $(mmu-y)
=20
diff --git a/mm/debug.c b/mm/debug.c
index 0bdda8407f71..f382d319722a 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -214,7 +214,7 @@ EXPORT_SYMBOL(dump_vma);
=20
 void dump_mm(const struct mm_struct *mm)
 {
-	pr_emerg("mm %px mmap %px seqnum %llu task_size %lu\n"
+	pr_emerg("mm %px mmap %px task_size %lu\n"
 #ifdef CONFIG_MMU
 		"get_unmapped_area %px\n"
 #endif
@@ -242,7 +242,7 @@ void dump_mm(const struct mm_struct *mm)
 		"tlb_flush_pending %d\n"
 		"def_flags: %#lx(%pGv)\n",
=20
-		mm, mm->mmap, (long long) mm->vmacache_seqnum, mm->task_size,
+		mm, mm->mmap, mm->task_size,
 #ifdef CONFIG_MMU
 		mm->get_unmapped_area,
 #endif
diff --git a/mm/mmap.c b/mm/mmap.c
index b730b57e47c9..10c42a41e023 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -13,7 +13,6 @@
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/shm.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
@@ -686,9 +685,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		/* Remove from mm linked list - also updates highest_vm_end */
 		__vma_unlink_list(mm, next);
=20
-		/* Kill the cache */
-		vmacache_invalidate(mm);
-
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
=20
@@ -902,8 +898,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
=20
 	if (remove_next) {
 		__vma_unlink_list(mm, next);
-		/* Kill the cache */
-		vmacache_invalidate(mm);
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
@@ -2188,16 +2182,9 @@ struct vm_area_struct *find_vma_intersection(struct =
mm_struct *mm,
 	struct vm_area_struct *vma;
 	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
=20
-	/* Check the cache first. */
-	vma =3D vmacache_find(mm, start_addr);
-	if (likely(vma))
-		return vma;
-
 	rcu_read_lock();
 	vma =3D mas_find(&mas, end_addr - 1);
 	rcu_read_unlock();
-	if (vma)
-		vmacache_update(mas.index, vma);
=20
 	return vma;
 }
@@ -2590,9 +2577,6 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, stru=
ct vm_area_struct *vma,
 		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
 	tail_vma->vm_next =3D NULL;
=20
-	/* Kill the cache */
-	vmacache_invalidate(mm);
-
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
 	 * VM_GROWSUP VMA. Such VMAs can change their size under
@@ -2973,7 +2957,6 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	if (vma_mas_remove(&unmap, mas))
 		goto mas_store_fail;
=20
-	vmacache_invalidate(vma->vm_mm);
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
 		anon_vma_unlock_write(vma->anon_vma);
diff --git a/mm/nommu.c b/mm/nommu.c
index c410f99203fb..0eea24df1bd5 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -19,7 +19,6 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/sched/mm.h>
-#include <linux/vmacache.h>
 #include <linux/mman.h>
 #include <linux/swap.h>
 #include <linux/file.h>
@@ -601,22 +600,12 @@ static void add_vma_to_mm(struct mm_struct *mm, struc=
t vm_area_struct *vma)
  */
 static void delete_vma_from_mm(struct vm_area_struct *vma)
 {
-	int i;
-	struct address_space *mapping;
-	struct mm_struct *mm =3D vma->vm_mm;
-	struct task_struct *curr =3D current;
 	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
=20
-	mm->map_count--;
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		/* if the vma is cached, invalidate the entire cache */
-		if (curr->vmacache.vmas[i] =3D=3D vma) {
-			vmacache_invalidate(mm);
-			break;
-		}
-	}
+	vma->vm_mm->map_count--;
 	/* remove the VMA from the mapping */
 	if (vma->vm_file) {
+		struct address_space *mapping;
 		mapping =3D vma->vm_file->f_mapping;
=20
 		i_mmap_lock_write(mapping);
@@ -628,7 +617,7 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
-	__vma_unlink_list(mm, vma);
+	__vma_unlink_list(vma->vm_mm, vma);
 }
=20
 /*
@@ -653,18 +642,10 @@ struct vm_area_struct *find_vma(struct mm_struct *mm,=
 unsigned long addr)
 	struct vm_area_struct *vma;
 	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	/* check the cache first */
-	vma =3D vmacache_find(mm, addr);
-	if (likely(vma))
-		return vma;
-
 	rcu_read_lock();
 	vma =3D mas_walk(&mas);
 	rcu_read_unlock();
=20
-	if (vma)
-		vmacache_update(addr, vma);
-
 	return vma;
 }
 EXPORT_SYMBOL(find_vma);
@@ -699,11 +680,6 @@ static struct vm_area_struct *find_vma_exact(struct mm=
_struct *mm,
 	unsigned long end =3D addr + len;
 	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	/* check the cache first */
-	vma =3D vmacache_find_exact(mm, addr, end);
-	if (vma)
-		return vma;
-
 	rcu_read_lock();
 	vma =3D mas_walk(&mas);
 	rcu_read_unlock();
@@ -714,7 +690,6 @@ static struct vm_area_struct *find_vma_exact(struct mm_=
struct *mm,
 	if (vma->vm_end !=3D end)
 		return NULL;
=20
-	vmacache_update(addr, vma);
 	return vma;
 }
=20
diff --git a/mm/vmacache.c b/mm/vmacache.c
deleted file mode 100644
index 01a6e6688ec1..000000000000
--- a/mm/vmacache.c
+++ /dev/null
@@ -1,117 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2014 Davidlohr Bueso.
- */
-#include <linux/sched/signal.h>
-#include <linux/sched/task.h>
-#include <linux/mm.h>
-#include <linux/vmacache.h>
-
-/*
- * Hash based on the pmd of addr if configured with MMU, which provides a =
good
- * hit rate for workloads with spatial locality.  Otherwise, use pages.
- */
-#ifdef CONFIG_MMU
-#define VMACACHE_SHIFT	PMD_SHIFT
-#else
-#define VMACACHE_SHIFT	PAGE_SHIFT
-#endif
-#define VMACACHE_HASH(addr) ((addr >> VMACACHE_SHIFT) & VMACACHE_MASK)
-
-/*
- * This task may be accessing a foreign mm via (for example)
- * get_user_pages()->find_vma().  The vmacache is task-local and this
- * task's vmacache pertains to a different mm (ie, its own).  There is
- * nothing we can do here.
- *
- * Also handle the case where a kernel thread has adopted this mm via
- * kthread_use_mm(). That kernel thread's vmacache is not applicable to th=
is mm.
- */
-static inline bool vmacache_valid_mm(struct mm_struct *mm)
-{
-	return current->mm =3D=3D mm && !(current->flags & PF_KTHREAD);
-}
-
-void vmacache_update(unsigned long addr, struct vm_area_struct *newvma)
-{
-	if (vmacache_valid_mm(newvma->vm_mm))
-		current->vmacache.vmas[VMACACHE_HASH(addr)] =3D newvma;
-}
-
-static bool vmacache_valid(struct mm_struct *mm)
-{
-	struct task_struct *curr;
-
-	if (!vmacache_valid_mm(mm))
-		return false;
-
-	curr =3D current;
-	if (mm->vmacache_seqnum !=3D curr->vmacache.seqnum) {
-		/*
-		 * First attempt will always be invalid, initialize
-		 * the new cache for this task here.
-		 */
-		curr->vmacache.seqnum =3D mm->vmacache_seqnum;
-		vmacache_flush(curr);
-		return false;
-	}
-	return true;
-}
-
-struct vm_area_struct *vmacache_find(struct mm_struct *mm, unsigned long a=
ddr)
-{
-	int idx =3D VMACACHE_HASH(addr);
-	int i;
-
-	count_vm_vmacache_event(VMACACHE_FIND_CALLS);
-
-	if (!vmacache_valid(mm))
-		return NULL;
-
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		struct vm_area_struct *vma =3D current->vmacache.vmas[idx];
-
-		if (vma) {
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-			if (WARN_ON_ONCE(vma->vm_mm !=3D mm))
-				break;
-#endif
-			if (vma->vm_start <=3D addr && vma->vm_end > addr) {
-				count_vm_vmacache_event(VMACACHE_FIND_HITS);
-				return vma;
-			}
-		}
-		if (++idx =3D=3D VMACACHE_SIZE)
-			idx =3D 0;
-	}
-
-	return NULL;
-}
-
-#ifndef CONFIG_MMU
-struct vm_area_struct *vmacache_find_exact(struct mm_struct *mm,
-					   unsigned long start,
-					   unsigned long end)
-{
-	int idx =3D VMACACHE_HASH(start);
-	int i;
-
-	count_vm_vmacache_event(VMACACHE_FIND_CALLS);
-
-	if (!vmacache_valid(mm))
-		return NULL;
-
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		struct vm_area_struct *vma =3D current->vmacache.vmas[idx];
-
-		if (vma && vma->vm_start =3D=3D start && vma->vm_end =3D=3D end) {
-			count_vm_vmacache_event(VMACACHE_FIND_HITS);
-			return vma;
-		}
-		if (++idx =3D=3D VMACACHE_SIZE)
-			idx =3D 0;
-	}
-
-	return NULL;
-}
-#endif
diff --git a/mm/vmstat.c b/mm/vmstat.c
index cccee36b289c..37bf2fef2cee 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1361,10 +1361,6 @@ const char * const vmstat_text[] =3D {
 	"nr_tlb_local_flush_one",
 #endif /* CONFIG_DEBUG_TLBFLUSH */
=20
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-	"vmacache_find_calls",
-	"vmacache_find_hits",
-#endif
 #ifdef CONFIG_SWAP
 	"swap_ra",
 	"swap_ra_hit",
--=20
2.30.2
