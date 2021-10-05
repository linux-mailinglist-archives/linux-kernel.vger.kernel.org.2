Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E64421BE8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhJEBdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:33:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32814 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231381AbhJEBdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:25 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951Awbo019258;
        Tue, 5 Oct 2021 01:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xXlFc0zLR4tsCnEhRu6d9hnzXxSO07xslFzYiEBE3nc=;
 b=OyNED/ir4RgDJFq7ZDeJYfh9qlfnQUwJPevk+WO8cDXl2usgkYKau2IK3e/fXRF5Zk9Y
 K7AjCWwAP7Cboc+m9BaOnHW8VOVBTfltGOa9FC6dKuy84L/tKzcjhAjXLNdEwilTGGEn
 zSIyfXdBzJ+hbsT3t+ccLBglAhM079fVNwsMFh9bfaoCgQGgczS4gitiqLCey8y9k3OZ
 zOxCkEdPNsI+qiwLeLiAfILY2O3q1Mr8XwaDL87nB8w2zA0goBmMlEyXm69g2PjJz35V
 SsXdw6/3+zgb3voyrO2t7b8QCLhHiSETGu0VAFFYuxZU6eCf6NHyx4GV8b5w1UMF3iKq gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p5c98m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdG3141646;
        Tue, 5 Oct 2021 01:30:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3bf16s9duq-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alacyOmrC13cre3b03jva01TPRK5fhSaUoaQYeDmx32kztHERM53rMtHNL8ePG2lbOsPOSTnUZncs2Je3b98TJAVyAtYfVogLThnlN7Xt1t7DTkQ+0lB7tJuGXYKbK3/zMRikQo4Z1X6DQOYBUmCvW/6fuP1vu54hbfoKIK3EdOYD5679HpIGphke9MrCRKO249sqmEWDYwH/kd4CAoDoHMwoKCWOvvtgPqLiPEMG34R1m3DaffoLY614y03weHXbeG1Yat9+QRnYxt9jLAKXZF8njT50FumsDbr56RzWaYyOaldtdU/543kBRg3npv+Plc84dKApFMsmmksvTf+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXlFc0zLR4tsCnEhRu6d9hnzXxSO07xslFzYiEBE3nc=;
 b=IZKAznJnlbL2dPgFKubWJW9Vc89T28aZi9dBF9rChS3vGdcun8BkhYliUeD0x7vH5qdPx1fUJWNMYmfAF2ewK2qnoaUhvjqzV+//cG2pRnLhTjNc0spKq6Dh8VWfql1wnfaYicQSlkUw50rnmHOjQMycH2vXoIW3SB130aeHToejWpxdZUzQ8Xn+Y88ocICsua/dGAaUgcYWhcrFbrZ5CxNeGVuIHFgk9srycavN+Y4pLE/Sj6tRCzi5x2hchoJtwEtL3g7zSrL7arF1le72t7QVNh7nam/D4VB1y1SSNcjLPU5S7g1Xra1pUl9pufWf4GSGNDjNwCYtdOi9PQpbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXlFc0zLR4tsCnEhRu6d9hnzXxSO07xslFzYiEBE3nc=;
 b=LweVXO07XaxzU69lrWaQQVqR22S+Gkp6Gz/X4SPDoHsIPivYBAT9L9r39QcZoRZz7Q0XdvT2pUiADtx/iqnG9ROpIDFp2j6hgJnQwF58DcvMxKTETwDzhXjq+t6nPswKbblhUjjxSddRxwGQtwhvcAsVqao5q/TpFCjDXWwVIdM=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:39 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Douglas Gilbert <dgilbert@interlog.com>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 19/66] mm: Remove vmacache
Thread-Topic: [PATCH v3 19/66] mm: Remove vmacache
Thread-Index: AQHXuYiausYI1QNqLkGu8yt4wOftGw==
Date:   Tue, 5 Oct 2021 01:30:39 +0000
Message-ID: <20211005012959.1110504-20-Liam.Howlett@oracle.com>
References: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10f7cabe-f96a-4f09-5f58-08d9879fbd2f
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044C89981F8ED62C1E32C0DFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f3oUbfb/MlaRu49jW1SgO8k7NypbTlWe1wQORxczvUFtgZ0dwHYH/KGZsOFhjK5Nhi/Y1GFKa3x6tEniRW0pr8otEGajQ94VRD89zq7e9SE4f6RLQLuhXYuArvKy44ak853ExVt2tjLOD02xudjuXs1TgZZ99FGf2/z4ibmUwmebAqMcO2KfMZVokwlxaGZCdOMc8PndP/CjOxhb/+pCS4Cjp2ff32Q6JV5pUHFxWuOgId1Y+4vjLndel/480OgfeOEkVosCjF+c+yxys784g9F/+ccLuaJtC5G1TBU2V9VrHzo6HxgGtyHF9hr3uWzba3PPw/r3Kspiw/O3s8cBViDASqJSDNwyerb0blmju1VBsWADYhPe1ri3d/zUJ66oLUcVsY+BMxTsud1SyA4rWzyt20/GaMvyoInwBXUxAXUmWQ3ry/7ciaayhuKDggHxzU6o8wXrP2rANyupaOhr/d+qykVmaLfyem6Nk7N6mgpLikn6ZT2WpEhTu7EWVkrKZ50Zo7csNjsdK7JFlbHO1lB1LXZNGiUMY0zUPmYBUkSI8Lm6eQ7uwULPVte4Fqa8bTcNYCjAGoPyoqo+sxr4OozPU2F3WGqktNLwVWRUce3ShetqrYHxYfHg2QzoOI59kGgtKYBCYsE2cCEEFQYFQMo7C7l4LTyKjvyAjCXCEnuITOfzsEFuFar/s5cYab3VQHVlYFRwv2hSta6vmabDKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(6506007)(36756003)(30864003)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?62JgKvJlwkYqCMHrMy0QiP0agAaVvAr3xuwUnxxOdvEJKjK8ThaoHxyfIY?=
 =?iso-8859-1?Q?hV2V2D6v/few9PzjD/offt2Klt+hQ8rkQcO1mW2YplwyKZrgTyxPy5GvgF?=
 =?iso-8859-1?Q?2UMNFLBcYgpvbZCe1JAhdLbYnWrEd7qtgMN2fWOqSnC3bWFRUEJ3eUc9Bn?=
 =?iso-8859-1?Q?XC+puym3i9SEqJF1by+ufYBJawQBynFSjaq1PTA89hiIBd1tKZaceMHMdO?=
 =?iso-8859-1?Q?+vodeUKKjA2YPr7pl5ow/WZieGFx9fg+PUbJYwipEsV5XwU5GrtTQMFvMV?=
 =?iso-8859-1?Q?8RudkffuEo7x3iKlVqYcXpxtcKNmnXHGyUcJGj0o3wHidPXScwYLrBiQso?=
 =?iso-8859-1?Q?90unmncxDB0wDS+TmxNUX/x6YHYp+QDr1WBj4uEN4wlJ4nOWPZSdns3VvQ?=
 =?iso-8859-1?Q?qBnD3QofxDj2ZNj+vcdW+BW4dUn5SZ024+ufT9WE7cQaVeuvtAdP1ZH3cX?=
 =?iso-8859-1?Q?0XNzEUxl0socnfleAkcpGM/pZwtkHtdI6yjN+v/9ybdVtGFl3P8g6szKV3?=
 =?iso-8859-1?Q?WMIPfSdYDdB6HeYZzTMda6U4ADVWzKY2PQO0bB0s5cqZGWocPyACbogzIh?=
 =?iso-8859-1?Q?DIYw58BgcFfC5k6cKD9EQx/kpY5eQ/2o0ap3zz306lnkSAdnSiExSZV1BS?=
 =?iso-8859-1?Q?JTCv/AoUMWat+8LDgBmHvklLk4dUHN51szonGA/+jBngmaTmU2u3tQGCeY?=
 =?iso-8859-1?Q?E3iRt1gR/8Pn/adTMXtjFfWubmBopV7aF6Bbb/NhyAx30HN+XEI+HxD5qO?=
 =?iso-8859-1?Q?/fJmE9yo3V/i28et+r25Hi/mNlitVZoMXnBFZKTpWIHp1AHAk9SDhEzxHr?=
 =?iso-8859-1?Q?dX2OppDIXDBFTVD8/dR58BIASHt/nLsnSJmwTCipIis9ahed6QZBXJD1Wg?=
 =?iso-8859-1?Q?GtsiVrsgEZXyW+FFC1135psHN7G7AYJFHcW1af9I4e4v5QpAy2OUEwzO1V?=
 =?iso-8859-1?Q?WmuuS8g1Yz1AMXGUmoio67Pf5iyN2DJQfUehpID5n4FCnM1xrXSJqv00iA?=
 =?iso-8859-1?Q?E2io/cdDXT7z/lYb3NFy/6wqjneAa9n85yKbpPPJOhQN/Q2KR5R8ozs/p3?=
 =?iso-8859-1?Q?QYrGBGTpoG9EsH9odBKcyMNcFu2oWC0sLmz2VutY6vjWhoj9UxGyg5dX7F?=
 =?iso-8859-1?Q?nPnGpQbu+2mC16e+E/WIZRBN3xLri5N4y3qjZihwevYCmSXbp7gYaleasT?=
 =?iso-8859-1?Q?H5cKJzry2S95k0It10Bk6HcDmCMwpxe+xQasWghjFHOw7g90HM1scjd7u3?=
 =?iso-8859-1?Q?Ua+17ij4dyguf2RywLRQUsCsdTI6my/y2rQoZBaBl6kp30VVDF1HF8eaIH?=
 =?iso-8859-1?Q?i+Xx5zitOZpnGh28DRwQclfXTzmMDbTXKAkYQCIrUkgJM5PQCnrpyWMdNU?=
 =?iso-8859-1?Q?DxFK4noDWV?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f7cabe-f96a-4f09-5f58-08d9879fbd2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:39.1774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oOq9mJe473vwaeagB7bTsLMXCkSi9uTR7MTHA7TWD8cUVcFL3GsFCHFzKgRHKFE04uCrTW+169tIIaN/5ARZKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: ZnjZ2Tmo6L_jMFXHEvl8qPEUcGkarFF7
X-Proofpoint-GUID: ZnjZ2Tmo6L_jMFXHEvl8qPEUcGkarFF7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

By using the maple tree and the maple tree state, the vmacache is no
longer beneficial and is complicating the VMA code.  Remove the vmacache
to reduce the work in keeping it up to date and code complexity.

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
index 6aad18ee131d..2d05af1a7a3e 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -801,7 +801,6 @@ CONFIG_SLUB_DEBUG_ON=3Dy
 CONFIG_SLUB_STATS=3Dy
 CONFIG_DEBUG_STACK_USAGE=3Dy
 CONFIG_DEBUG_VM=3Dy
-CONFIG_DEBUG_VM_VMACACHE=3Dy
 CONFIG_DEBUG_VM_PGFLAGS=3Dy
 CONFIG_DEBUG_MEMORY_INIT=3Dy
 CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=3Dm
diff --git a/fs/exec.c b/fs/exec.c
index a098c133d8d7..c618a55a20d3 100644
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
@@ -1019,8 +1018,6 @@ static int exec_mmap(struct mm_struct *mm)
 	activate_mm(active_mm, mm);
 	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
 		local_irq_enable();
-	tsk->mm->vmacache_seqnum =3D 0;
-	vmacache_flush(tsk);
 	task_unlock(tsk);
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index cf25be3e0321..63d07414d583 100644
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
index f5de9734fcda..6ba95ad603d6 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -392,7 +392,6 @@ struct mm_struct {
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
index 39039ce8ac4c..d9f93aab6551 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -858,7 +858,6 @@ struct task_struct {
 	struct mm_struct		*active_mm;
=20
 	/* Per-thread vma caching: */
-	struct vmacache			vmacache;
=20
 #ifdef SPLIT_RSS_COUNTING
 	struct task_rss_stat		rss_stat;
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index a185cc75ff52..dd9e1e98bdec 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -119,10 +119,6 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
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
index d6a6cf53b127..f9a2924a2174 100644
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
index da06a5553835..c4e6f5159bed 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -50,7 +50,6 @@
 #include <linux/pid.h>
 #include <linux/smp.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/rcupdate.h>
 #include <linux/irq.h>
=20
@@ -282,17 +281,6 @@ static void kgdb_flush_swbreak_addr(unsigned long addr=
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
index 2eeb51346821..3c14f8aef01a 100644
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
@@ -1056,7 +1055,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 {
 	mm->mmap =3D NULL;
 	mt_init_flags(&mm->mm_mt, MAPLE_ALLOC_RANGE);
-	mm->vmacache_seqnum =3D 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
 	seqcount_init(&mm->write_protect_seq);
@@ -1514,9 +1512,6 @@ static int copy_mm(unsigned long clone_flags, struct =
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
index 6748fe0fffd8..74e8836a4e8b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -802,16 +802,6 @@ config DEBUG_VM
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
index fc60a40ce954..fed159b876a9 100644
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
index fae0f81ad831..5fe665c6ce1c 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -205,7 +205,7 @@ EXPORT_SYMBOL(dump_vma);
=20
 void dump_mm(const struct mm_struct *mm)
 {
-	pr_emerg("mm %px mmap %px seqnum %llu task_size %lu\n"
+	pr_emerg("mm %px mmap %px task_size %lu\n"
 #ifdef CONFIG_MMU
 		"get_unmapped_area %px\n"
 #endif
@@ -233,7 +233,7 @@ void dump_mm(const struct mm_struct *mm)
 		"tlb_flush_pending %d\n"
 		"def_flags: %#lx(%pGv)\n",
=20
-		mm, mm->mmap, (long long) mm->vmacache_seqnum, mm->task_size,
+		mm, mm->mmap, mm->task_size,
 #ifdef CONFIG_MMU
 		mm->get_unmapped_area,
 #endif
diff --git a/mm/mmap.c b/mm/mmap.c
index 747c69ec88de..d6c42f416de2 100644
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
@@ -707,9 +706,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
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
@@ -929,8 +925,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
=20
 	if (remove_next) {
 		__vma_unlink_list(mm, next);
-		/* Kill the cache */
-		vmacache_invalidate(mm);
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
@@ -2202,16 +2196,9 @@ struct vm_area_struct *find_vma_intersection(struct =
mm_struct *mm,
 	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
=20
 	mmap_assert_locked(mm);
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
@@ -2604,9 +2591,6 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, stru=
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
@@ -2986,7 +2970,6 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	if (vma_mas_remove(&unmap, mas))
 		goto mas_store_fail;
=20
-	vmacache_invalidate(vma->vm_mm);
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
 		anon_vma_unlock_write(vma->anon_vma);
diff --git a/mm/nommu.c b/mm/nommu.c
index 86b162011f76..9833f0f77103 100644
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
@@ -586,22 +585,12 @@ static void add_vma_to_mm(struct mm_struct *mm, struc=
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
@@ -613,7 +602,7 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
-	__vma_unlink_list(mm, vma);
+	__vma_unlink_list(vma->vm_mm, vma);
 }
=20
 /*
@@ -638,18 +627,10 @@ struct vm_area_struct *find_vma(struct mm_struct *mm,=
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
@@ -684,11 +665,6 @@ static struct vm_area_struct *find_vma_exact(struct mm=
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
@@ -699,7 +675,6 @@ static struct vm_area_struct *find_vma_exact(struct mm_=
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
index 8ce2620344b2..25683a0e0b95 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1369,10 +1369,6 @@ const char * const vmstat_text[] =3D {
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
