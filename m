Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5921136DBED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbhD1Pjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:39:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21702 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240316AbhD1PhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:16 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMkWO020210;
        Wed, 28 Apr 2021 15:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=hWPbG/sDty9jykivoTRVx7+Vpt6ee11y8O8AxqEe+7Y=;
 b=S/VOUuIqGTz1necs4cC1lm/ooRafjpf13sbasH9w7gP47GV6NU82G6Lhw0XW+JCSyCjs
 FXzKRIhXc/EvwkCgQ+r2GwhU/IsL0SJStjEIjyo6+F+ae/V+BQ390QOpkVeXyi2u8lAr
 GgUqWa9PYiEXs/1KJi7HptuKz/cx4bWst2RyK1OEUacZGfnA7rAIleNMtwrUrjBIqbi0
 LMN91XqMeLDHV/JE58hRBWaw94S6Y5ddVEVDrt84JE1W8Kovlr0CGuuD4o77cjIv8KsZ
 geITN8CZffRrU4YBylVhzsLMSNiGXs/HT2n4bbFQ9UIgL6eWWrduxQlpCQcE/YCnahWC Hg== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878kgg51v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:09 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWRiv016446;
        Wed, 28 Apr 2021 15:36:08 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by userp3020.oracle.com with ESMTP id 384w3uu9su-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gSZC7wRrWgK5z7wixGW178B248sXY8uONRbtYKwilgQ9NUdA4kcPlKV6vnDcSMDT314Bsyr5uns56AnDOayQCnqLN2sKW/o9G+SPKrAfwOO9gV4r/VQaUd3+HTrixGaCG0wppUAMXGMCvvgu5IGn+TfzbFP25eRihfvvjN4YQNxZ07ZFyduByq7+uMOOzXwIMSnVZwroPYaLPDuha+ZNHj/5EE9AckP6foNV17eyNoyBpA9W+oc0PNZvOrh0pCxqLdX4Wwp0mnk/xaE1MEM6u8FG6o4KF6Mymw2tgRVre4ZVStIeqX4LkOvDR38uzTabseFSenh4jd5XZYIL6CpBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWPbG/sDty9jykivoTRVx7+Vpt6ee11y8O8AxqEe+7Y=;
 b=U+xA9d1CvdAdKzXz6WupkPf6xXKZ8tr3hSmZwY2/V6oibhYFVmOaWKvqzJz7PJu6ANbFVuhpwBaYqCo/I0zQnYySptK+ghcph0Iiy7e8383S7ZfIDqXxnFG+WHEgXPX5doQn4mwMPr415u5UoIAA9JKAWXMJ+tBqqoblyPeolO0BEVPN9Gi+LxbKhEhyeKNCxsybhMqWD0pda1cGbBJf0CXKl3W+w/eLsd3RZGoOxXy9cZOHH//3WzYKjtWP/luvEpoLGOmFWtqFUC/aRwUPXMCBR8YhTs1bnAjmSwc4vyOmS9eU35mfmkeaiSt2ibIqtLsJyMqWHPqTrTlsxHm25A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWPbG/sDty9jykivoTRVx7+Vpt6ee11y8O8AxqEe+7Y=;
 b=D8StDD88MRvxqWiYgu+AYxsjxmyIM96MlIa5CSqPVIkhP9Q2sBoVSwnUwHAMRhYFUJncO1VJnUBBZvQQlc0PETmiAVE02vuW68qyeGeVt0ASzloX8L/X1s/vBwQGWjulZRq7ifgGdVHFuQ2Lt3WC02SaTUMyfMeziqo7jhMKgtk=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:36:04 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:04 +0000
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
Subject: [PATCH 27/94] mm: Start tracking VMAs with maple tree
Thread-Topic: [PATCH 27/94] mm: Start tracking VMAs with maple tree
Thread-Index: AQHXPEQyTsNMakp4R0q7y/n3wsMtRw==
Date:   Wed, 28 Apr 2021 15:36:03 +0000
Message-ID: <20210428153542.2814175-28-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 60e5325d-153b-4d44-b827-08d90a5b55ae
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4769B7EF797F59D95DA9C88AFD409@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:741;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l1LirBZ/gywQFnWwZokck4VyOZDeKdfqyIUqY6AOcNZ4Ztyvi/xG7dNTrwa/Ri2mkoBt1qp7GLs4W46jOWhMtVkZvsBQ/ei5aoAU9MI5oCvC4J7dYehNgVyUJY/ikiUI/LnLvL8LozyR7n86T9LStXG2dCM0HZleQk5jBezVVnil+OcN20AUvoNaeqtnAcuITroK33B5RFRpdnP1o3HSbd4uCClbGyZ4Z4ztui4Hx4/4bZ0d6854n2ukDEdCLvMUoR3d7/f5EsAFkmien4W/UVWsPFPzfoI7NRsVGNKNKVnAg/CttRA3Q6V49532dxNe3POQGdS7AqGK7++TzZLQJBJjkduRCIWb56ZE3IEuy7FyIVmMBZ06bQTjwdKknACbaQUZXtovgEllOxGq/6q2SUyoXszWOS33t8mLWiGpLIO+/tH2xeLuP5rMBjMLZnPlJLfnbaCN59SPqIR2gcQ4KADYCeHEWkk2ZzHT6ya8wlOtQEM2UcZ/BEspoqZzSNL5fkxyqPaE8ei1/AVK38zyTt5GkU6+0J08IX0mplNbwLZGw7qnVURYroZTH2O0uhi8msNxLwzpp+mFOtI7U83/TthqoSQdk4smImupACjHI/s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(6506007)(86362001)(2906002)(110136005)(83380400001)(66946007)(38100700002)(66446008)(66476007)(54906003)(8936002)(2616005)(8676002)(66556008)(76116006)(478600001)(36756003)(4326008)(44832011)(316002)(1076003)(107886003)(186003)(6512007)(7416002)(64756008)(91956017)(30864003)(26005)(5660300002)(71200400001)(6486002)(122000001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?bDh2BUCr+oKQg0KDWs/HdmYy6IxFXRBkqm8saf3h5SUPgRBZRHC9BNCf7G?=
 =?iso-8859-1?Q?8izEhRJdVUCbzDS5fupczbV9B/DT5gOJ4KTvtVjNAC+6QZtFjonEjHoqo5?=
 =?iso-8859-1?Q?waoAMY+5GMNETWdZ57tLs6UbbkPBQIME0L9kcXP3GCk1cxuoIc7KyPuGNk?=
 =?iso-8859-1?Q?jmiO/OztFBxWzeIeSAJhsc4o+ZK0TdWFM+RDoK+WIXJkqe9BcFPvJlS87u?=
 =?iso-8859-1?Q?sQ/yici0Z/OotF3HnxM+VMqZHa8W4lBJUf3KFQHKTk3FyaBoIPrSyegUGY?=
 =?iso-8859-1?Q?aYomrDIl9WZOSR/0LQxseEtNE14CeDuKS5dE5qWKdgzIJXv12v+UYuQA5/?=
 =?iso-8859-1?Q?VrDKAo7wYh5q2xnWfUL9jh7z4T+jYsfDKGBj8opdaZKoQGAKxWjBO+GEXv?=
 =?iso-8859-1?Q?79hIq8TmaCOCp0LDgpGhQvcQoBZ+japXPEPbLfuOsgubc4/06zc6jdCdlk?=
 =?iso-8859-1?Q?mNRdlxnoasYe1lCA913uDtvpmDTEz21DWyx1IxTxi/UdjL6Njr9SgfqGeV?=
 =?iso-8859-1?Q?G04ikOh65sMoXjgh6VjRNtyLEU1RzmP9QSH/3XNAwof9OcyMV4Ly+LjhDx?=
 =?iso-8859-1?Q?BJTFwfOrjGbqVUvIE3udO/Wle8xTjt+Wp1M1fwcSFVR2VCBbogoQ6j39XF?=
 =?iso-8859-1?Q?5OBZWO8ZDMvDA5J+P3flvSvmbCUEKX+GgOs9B9k7aZkXOSWUu+xkwitKWa?=
 =?iso-8859-1?Q?8mTLkhLKPtzhfW7r8kBMQFMNf4ZMWfrmSJNTvh2jdt4NAqvB4noPDb5mD/?=
 =?iso-8859-1?Q?FNMvUPevXhMnyZihdT8gtcN7GI5dBaHaKbvzDpLW+NDaSkmkI7gYtHOb74?=
 =?iso-8859-1?Q?2h+mZWK4LkhTC9WzCL3qcp4o6dWVhus6jMO7ix2uVpt25qziC/gSLIfaBF?=
 =?iso-8859-1?Q?5wvmbo2Ju5aYp03DI0wk6JBozIvQca8UBH1g8qW7PbgIT2zzZ0BC1tYFZD?=
 =?iso-8859-1?Q?21P/j1+ZrpBb+a0rU+XCeKVwVP8D0c+BHV5B/BS6/oPfPVe0HHDBZ06znZ?=
 =?iso-8859-1?Q?RvjF/VzIgJTtXok43fRgVDTwpSMk61e2Krs4wcW+xTrr1dl+y6ULEp9Syb?=
 =?iso-8859-1?Q?lPIEro4CLStniukXLU5hQK4wAa/uy8D4yg3wphxqKvgnyol3eubA0nucT4?=
 =?iso-8859-1?Q?gtdWEe91YBrgXIgwr3tU9+631znY1kpNM6eLNHYQ5uVL47W25F5PQbYGZV?=
 =?iso-8859-1?Q?+MZiAnlnF8L6c81DdVq/VeovoDi8mB7/Q+jbpoMfKmzzCR2bh5bDX3BfvB?=
 =?iso-8859-1?Q?6LbMwvR+mhhO2wCgz5kbFfVNhh6EdhJNISN6JkQI/7SX0vVykZ/EjiOx/7?=
 =?iso-8859-1?Q?ZbW0YnRuJZgveGwddAgFCGR6zDvNSV2EI4KNLGIhaHFNVffud73aI/X4C6?=
 =?iso-8859-1?Q?t2Bqidia6c?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e5325d-153b-4d44-b827-08d90a5b55ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:03.4716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jBSM8j1Yc2p12AAkt9sSGFtkuWIXiZVNGZrte8JKQ7Y7utcCf8VNOPWv/fe7ykbYwzeaR3DcO30INm32Pjqjtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: v_XMyA0qPDYDcgDjHx4kMN4fNM0KXcqq
X-Proofpoint-GUID: v_XMyA0qPDYDcgDjHx4kMN4fNM0KXcqq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start tracking the VMAs with the new maple tree structure in parallel
with the rb_tree.  Add debug and trace events for maple tree operations
and duplicate the rb_tree that is created on forks into the maple tree.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/x86/kernel/tboot.c     |   1 +
 drivers/firmware/efi/efi.c  |   1 +
 include/linux/mm.h          |   2 +
 include/linux/mm_types.h    |   2 +
 include/trace/events/mmap.h |  71 ++++++++++++
 init/main.c                 |   2 +
 kernel/fork.c               |   4 +
 mm/init-mm.c                |   2 +
 mm/internal.h               |  44 +++++++
 mm/mmap.c                   | 224 +++++++++++++++++++++++++++++++++++-
 10 files changed, 351 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index f9af561c3cd4..6f978f722dff 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -98,6 +98,7 @@ void __init tboot_probe(void)
 static pgd_t *tboot_pg_dir;
 static struct mm_struct tboot_mm =3D {
 	.mm_rb          =3D RB_ROOT,
+	.mm_mt          =3D MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
 	.pgd            =3D swapper_pg_dir,
 	.mm_users       =3D ATOMIC_INIT(2),
 	.mm_count       =3D ATOMIC_INIT(1),
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4b7ee3fa9224..271ae8c7bb07 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -55,6 +55,7 @@ static unsigned long __initdata rt_prop =3D EFI_INVALID_T=
ABLE_ADDR;
=20
 struct mm_struct efi_mm =3D {
 	.mm_rb			=3D RB_ROOT,
+	.mm_mt			=3D MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
 	.mm_users		=3D ATOMIC_INIT(2),
 	.mm_count		=3D ATOMIC_INIT(1),
 	.write_protect_seq      =3D SEQCNT_ZERO(efi_mm.write_protect_seq),
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7f7dff6ad884..e89bacfa9145 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2498,6 +2498,8 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
+/* maple_tree */
+void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6613b26a8894..51733fc44daf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -8,6 +8,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
@@ -387,6 +388,7 @@ struct kioctx_table;
 struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
+		struct maple_tree mm_mt;
 		struct rb_root mm_rb;
 		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
index 4661f7ba07c0..4ffe3d348966 100644
--- a/include/trace/events/mmap.h
+++ b/include/trace/events/mmap.h
@@ -42,6 +42,77 @@ TRACE_EVENT(vm_unmapped_area,
 		__entry->low_limit, __entry->high_limit, __entry->align_mask,
 		__entry->align_offset)
 );
+
+TRACE_EVENT(vma_mt_szero,
+	TP_PROTO(struct mm_struct *mm, unsigned long start,
+		 unsigned long end),
+
+	TP_ARGS(mm, start, end),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct*, mm)
+			__field(unsigned long, start)
+			__field(unsigned long, end)
+	),
+
+	TP_fast_assign(
+			__entry->mm		=3D mm;
+			__entry->start		=3D start;
+			__entry->end		=3D end - 1;
+	),
+
+	TP_printk("mt_mod %px, (NULL), SNULL, %lu, %lu,",
+		  __entry->mm,
+		  (unsigned long) __entry->start,
+		  (unsigned long) __entry->end
+	)
+);
+
+TRACE_EVENT(vma_mt_store,
+	TP_PROTO(struct mm_struct *mm, struct vm_area_struct *vma),
+
+	TP_ARGS(mm, vma),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct*, mm)
+			__field(struct vm_area_struct*, vma)
+			__field(unsigned long, vm_start)
+			__field(unsigned long, vm_end)
+	),
+
+	TP_fast_assign(
+			__entry->mm		=3D mm;
+			__entry->vma		=3D vma;
+			__entry->vm_start	=3D vma->vm_start;
+			__entry->vm_end		=3D vma->vm_end - 1;
+	),
+
+	TP_printk("mt_mod %px, (%px), STORE, %lu, %lu,",
+		  __entry->mm, __entry->vma,
+		  (unsigned long) __entry->vm_start,
+		  (unsigned long) __entry->vm_end
+	)
+);
+
+
+TRACE_EVENT(exit_mmap,
+	TP_PROTO(struct mm_struct *mm),
+
+	TP_ARGS(mm),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct*, mm)
+	),
+
+	TP_fast_assign(
+			__entry->mm		=3D mm;
+	),
+
+	TP_printk("mt_mod %px, DESTROY\n",
+		  __entry->mm
+	)
+);
+
 #endif
=20
 /* This part must be outside protection */
diff --git a/init/main.c b/init/main.c
index 7b6f49c4d388..f559c8fb5300 100644
--- a/init/main.c
+++ b/init/main.c
@@ -115,6 +115,7 @@ static int kernel_init(void *);
=20
 extern void init_IRQ(void);
 extern void radix_tree_init(void);
+extern void maple_tree_init(void);
=20
 /*
  * Debug helper: via this flag we know that we are in 'early bootup code'
@@ -951,6 +952,7 @@ asmlinkage __visible void __init __no_sanitize_address =
start_kernel(void)
 		 "Interrupts were enabled *very* early, fixing it\n"))
 		local_irq_disable();
 	radix_tree_init();
+	maple_tree_init();
=20
 	/*
 	 * Set up housekeeping before setting up workqueues to allow the unbound
diff --git a/kernel/fork.c b/kernel/fork.c
index 9de8c967c2d5..c37abaf28eb9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -593,6 +593,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		rb_link =3D &tmp->vm_rb.rb_right;
 		rb_parent =3D &tmp->vm_rb;
=20
+		/* Link the vma into the MT */
+		vma_store(mm, tmp);
+
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval =3D copy_page_range(tmp, mpnt);
@@ -1018,6 +1021,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 {
 	mm->mmap =3D NULL;
 	mm->mm_rb =3D RB_ROOT;
+	mt_init_flags(&mm->mm_mt, MAPLE_ALLOC_RANGE);
 	mm->vmacache_seqnum =3D 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 153162669f80..2014d4b82294 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm_types.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
@@ -28,6 +29,7 @@
  */
 struct mm_struct init_mm =3D {
 	.mm_rb		=3D RB_ROOT,
+	.mm_mt		=3D MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
 	.pgd		=3D swapper_pg_dir,
 	.mm_users	=3D ATOMIC_INIT(2),
 	.mm_count	=3D ATOMIC_INIT(1),
diff --git a/mm/internal.h b/mm/internal.h
index f469f69309de..7ad55938d391 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -346,6 +346,50 @@ static inline bool is_data_mapping(vm_flags_t flags)
 	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) =3D=3D VM_WRITE;
 }
=20
+/* Maple tree operations using VMAs */
+/*
+ * vma_mas_store() - Store a VMA in the maple tree.
+ * @vma: The vm_area_struct
+ * @mas: The maple state
+ *
+ * Efficient way to store a VMA in the maple tree when the @mas has alread=
y
+ * walked to the correct location.
+ *
+ * Note: the end address is inclusive in the maple tree.
+ */
+static inline int vma_mas_store(struct vm_area_struct *vma, struct ma_stat=
e *mas)
+{
+	int ret;
+
+	mas->index =3D vma->vm_start;
+	mas->last =3D vma->vm_end - 1;
+	mas_lock(mas);
+	ret =3D mas_store_gfp(mas, vma, GFP_KERNEL);
+	mas_unlock(mas);
+	return ret;
+}
+
+/*
+ * vma_mas_remove() - Remove a VMA from the maple tree.
+ * @vma: The vm_area_struct
+ * @mas: The maple state
+ *
+ * Efficient way to remove a VMA from the maple tree when the @mas has alr=
eady
+ * been established and points to the correct location.
+ * Note: the end address is inclusive in the maple tree.
+ */
+static inline int vma_mas_remove(struct vm_area_struct *vma, struct ma_sta=
te *mas)
+{
+	int ret;
+
+	mas->index =3D vma->vm_start;
+	mas->last =3D vma->vm_end - 1;
+	mas_lock(mas);
+	ret =3D mas_store_gfp(mas, NULL, GFP_KERNEL);
+	mas_unlock(mas);
+	return ret;
+}
+
 /* mm/util.c */
 void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
 		struct vm_area_struct *prev);
diff --git a/mm/mmap.c b/mm/mmap.c
index 81f5595a8490..bce25db96fd1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -377,7 +377,73 @@ static int browse_rb(struct mm_struct *mm)
 	}
 	return bug ? -1 : i;
 }
+#if defined(CONFIG_DEBUG_MAPLE_TREE)
+extern void mt_validate(struct maple_tree *mt);
+extern void mt_dump(const struct maple_tree *mt);
=20
+/* Validate the maple tree */
+static void validate_mm_mt(struct mm_struct *mm)
+{
+	struct maple_tree *mt =3D &mm->mm_mt;
+	struct vm_area_struct *vma_mt, *vma =3D mm->mmap;
+
+	MA_STATE(mas, mt, 0, 0);
+	rcu_read_lock();
+	mas_for_each(&mas, vma_mt, ULONG_MAX) {
+		if (xa_is_zero(vma_mt))
+			continue;
+
+		if (!vma)
+			break;
+
+		if ((vma !=3D vma_mt) ||
+		    (vma->vm_start !=3D vma_mt->vm_start) ||
+		    (vma->vm_end !=3D vma_mt->vm_end) ||
+		    (vma->vm_start !=3D mas.index) ||
+		    (vma->vm_end - 1 !=3D mas.last)) {
+			pr_emerg("issue in %s\n", current->comm);
+			dump_stack();
+#ifdef CONFIG_DEBUG_VM
+			dump_vma(vma_mt);
+			pr_emerg("and next in rb\n");
+			dump_vma(vma->vm_next);
+#endif
+			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
+				 mas.index, mas.last);
+			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
+				 vma_mt->vm_start, vma_mt->vm_end);
+			pr_emerg("rb vma: %px %lu - %lu\n", vma,
+				 vma->vm_start, vma->vm_end);
+			pr_emerg("rb->next =3D %px %lu - %lu\n", vma->vm_next,
+					vma->vm_next->vm_start, vma->vm_next->vm_end);
+
+			mt_dump(mas.tree);
+			if (vma_mt->vm_end !=3D mas.last + 1) {
+				pr_err("vma: %px vma_mt %lu-%lu\tmt %lu-%lu\n",
+						mm, vma_mt->vm_start, vma_mt->vm_end,
+						mas.index, mas.last);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_end !=3D mas.last + 1, mm);
+			if (vma_mt->vm_start !=3D mas.index) {
+				pr_err("vma: %px vma_mt %px %lu - %lu doesn't match\n",
+						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_start !=3D mas.index, mm);
+		}
+		VM_BUG_ON(vma !=3D vma_mt);
+		vma =3D vma->vm_next;
+
+	}
+	VM_BUG_ON(vma);
+
+	rcu_read_unlock();
+	mt_validate(&mm->mm_mt);
+}
+#else
+#define validate_mm_mt(root) do { } while (0)
+#endif
 static void validate_mm_rb(struct rb_root *root, struct vm_area_struct *ig=
nore)
 {
 	struct rb_node *nd;
@@ -432,6 +498,7 @@ static void validate_mm(struct mm_struct *mm)
 }
 #else
 #define validate_mm_rb(root, ignore) do { } while (0)
+#define validate_mm_mt(root) do { } while (0)
 #define validate_mm(mm) do { } while (0)
 #endif
=20
@@ -610,6 +677,7 @@ static unsigned long count_vma_pages_range(struct mm_st=
ruct *mm,
 		unsigned long addr, unsigned long end)
 {
 	unsigned long nr_pages =3D 0;
+	unsigned long nr_mt_pages =3D 0;
 	struct vm_area_struct *vma;
=20
 	/* Find first overlapping mapping */
@@ -631,6 +699,13 @@ static unsigned long count_vma_pages_range(struct mm_s=
truct *mm,
 		nr_pages +=3D overlap_len >> PAGE_SHIFT;
 	}
=20
+	mt_for_each(&mm->mm_mt, vma, addr, end) {
+		nr_mt_pages +=3D
+			(min(end, vma->vm_end) - vma->vm_start) >> PAGE_SHIFT;
+	}
+
+	VM_BUG_ON_MM(nr_pages !=3D nr_mt_pages, mm);
+
 	return nr_pages;
 }
=20
@@ -677,11 +752,44 @@ static void __vma_link_file(struct vm_area_struct *vm=
a)
 	}
 }
=20
+/*
+ * vma_mt_szero() - Set a given range to zero.  Used when modifying a
+ * vm_area_struct start or end.
+ *
+ * @mm: The struct_mm
+ * @start: The start address to zero
+ * @end: The end address to zero.
+ */
+static inline void vma_mt_szero(struct mm_struct *mm, unsigned long start,
+		unsigned long end)
+{
+	trace_vma_mt_szero(mm, start, end);
+	mtree_store_range(&mm->mm_mt, start, end - 1, NULL, GFP_KERNEL);
+}
+
+/*
+ * vma_mt_store() - Store a given vm_area_struct in the maple tree.
+ *
+ * @mm: The struct_mm
+ * @vma: The vm_area_struct to store in the maple tree.
+ */
+static inline void vma_mt_store(struct mm_struct *mm, struct vm_area_struc=
t *vma)
+{
+	trace_vma_mt_store(mm, vma);
+	mtree_store_range(&mm->mm_mt, vma->vm_start, vma->vm_end - 1, vma,
+		GFP_KERNEL);
+}
+
+void vma_store(struct mm_struct *mm, struct vm_area_struct *vma) {
+	vma_mt_store(mm, vma);
+}
+
 static void
 __vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct vm_area_struct *prev, struct rb_node **rb_link,
 	struct rb_node *rb_parent)
 {
+	vma_mt_store(mm, vma);
 	__vma_link_list(mm, vma, prev);
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
 }
@@ -754,6 +862,9 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
=20
+	validate_mm(mm);
+	validate_mm_mt(mm);
+
 	if (next && !insert) {
 		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
@@ -879,17 +990,28 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
+		unsigned long old_start =3D vma->vm_start;
 		vma->vm_start =3D start;
+		if (old_start < start)
+			vma_mt_szero(mm, old_start, start);
 		start_changed =3D true;
 	}
 	if (end !=3D vma->vm_end) {
+		unsigned long old_end =3D vma->vm_end;
 		vma->vm_end =3D end;
+		if (old_end > end)
+			vma_mt_szero(mm, end, old_end);
 		end_changed =3D true;
 	}
+
+	if (end_changed || start_changed)
+		vma_mt_store(mm, vma);
+
 	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
+		vma_mt_store(mm, next);
 	}
=20
 	if (file) {
@@ -903,6 +1025,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		/*
 		 * vma_merge has merged next into vma, and needs
 		 * us to remove next before dropping the locks.
+		 * Since we have expanded over this vma, the maple tree will
+		 * have overwritten by storing the value
 		 */
 		if (remove_next !=3D 3)
 			__vma_unlink(mm, next, next);
@@ -1022,6 +1146,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		uprobe_mmap(insert);
=20
 	validate_mm(mm);
+	validate_mm_mt(mm);
=20
 	return 0;
 }
@@ -1169,6 +1294,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	struct vm_area_struct *area, *next;
 	int err;
=20
+	validate_mm_mt(mm);
 	/*
 	 * We later require that vma->vm_flags =3D=3D vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1244,6 +1370,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 		khugepaged_enter_vma_merge(area, vm_flags);
 		return area;
 	}
+	validate_mm_mt(mm);
=20
 	return NULL;
 }
@@ -1736,6 +1863,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged =3D 0;
=20
+	validate_mm_mt(mm);
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
 		unsigned long nr_pages;
@@ -1897,6 +2025,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
+	validate_mm_mt(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -1916,6 +2045,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm_mt(mm);
 	return error;
 }
=20
@@ -1932,12 +2062,21 @@ static unsigned long unmapped_area(struct vm_unmapp=
ed_area_info *info)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
+	rcu_read_lock();
+	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+			   length);
+	rcu_read_unlock();
+	gap =3D mas.index;
+	gap +=3D (info->align_offset - gap) & info->align_mask;
+
 	/* Adjust search limits by the desired length */
 	if (info->high_limit < length)
 		return -ENOMEM;
@@ -2019,20 +2158,39 @@ static unsigned long unmapped_area(struct vm_unmapp=
ed_area_info *info)
=20
 	VM_BUG_ON(gap_start + info->length > info->high_limit);
 	VM_BUG_ON(gap_start + info->length > gap_end);
+
+	VM_BUG_ON(gap !=3D gap_start);
 	return gap_start;
 }
=20
+static inline unsigned long top_area_aligned(struct vm_unmapped_area_info =
*info,
+					     unsigned long end)
+{
+	return (end - info->length - info->align_offset) & (~info->align_mask);
+}
+
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
+
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	validate_mm_mt(mm);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
+	rcu_read_lock();
+	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+		   length);
+	rcu_read_unlock();
+	gap =3D (mas.index + info->align_mask) & ~info->align_mask;
+	gap -=3D info->align_offset & info->align_mask;
+
 	/*
 	 * Adjust search limits by the desired length.
 	 * See implementation comment at top of unmapped_area().
@@ -2118,6 +2276,32 @@ static unsigned long unmapped_area_topdown(struct vm=
_unmapped_area_info *info)
=20
 	VM_BUG_ON(gap_end < info->low_limit);
 	VM_BUG_ON(gap_end < gap_start);
+
+	if (gap !=3D gap_end) {
+		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
+		       mm, gap, gap_end);
+		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
+		       info->low_limit, length);
+		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
+		       mas.last);
+		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
+		       info->align_mask, info->align_offset);
+		pr_err("rb_find_vma find on %lu =3D> %px (%px)\n", mas.index,
+		       find_vma(mm, mas.index), vma);
+#if defined(CONFIG_DEBUG_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		{
+			struct vm_area_struct *dv =3D mm->mmap;
+
+			while (dv) {
+				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
+				dv =3D dv->vm_next;
+			}
+		}
+		VM_BUG_ON(gap !=3D gap_end);
+	}
+
 	return gap_end;
 }
=20
@@ -2330,7 +2514,6 @@ struct vm_area_struct *find_vma(struct mm_struct *mm,=
 unsigned long addr)
 		vmacache_update(addr, vma);
 	return vma;
 }
-
 EXPORT_SYMBOL(find_vma);
=20
 /*
@@ -2411,6 +2594,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	unsigned long gap_addr;
 	int error =3D 0;
=20
+	validate_mm_mt(mm);
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
=20
@@ -2487,6 +2671,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma_merge(vma, vma->vm_flags);
 	validate_mm(mm);
+	validate_mm_mt(mm);
 	return error;
 }
 #endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
@@ -2501,6 +2686,7 @@ int expand_downwards(struct vm_area_struct *vma,
 	struct vm_area_struct *prev;
 	int error =3D 0;
=20
+	validate_mm(mm);
 	address &=3D PAGE_MASK;
 	if (address < mmap_min_addr)
 		return -EPERM;
@@ -2554,6 +2740,8 @@ int expand_downwards(struct vm_area_struct *vma,
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_start =3D address;
 				vma->vm_pgoff -=3D grow;
+				/* Overwrite old entry in mtree. */
+				vma_mt_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				vma_gap_update(vma);
 				spin_unlock(&mm->page_table_lock);
@@ -2695,6 +2883,7 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, stru=
ct vm_area_struct *vma,
=20
 	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
 	vma->vm_prev =3D NULL;
+	vma_mt_szero(mm, vma->vm_start, end);
 	do {
 		vma_rb_erase(vma, &mm->mm_rb);
 		mm->map_count--;
@@ -2733,6 +2922,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 {
 	struct vm_area_struct *new;
 	int err;
+	validate_mm_mt(mm);
=20
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err =3D vma->vm_ops->may_split(vma, addr);
@@ -2785,6 +2975,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	mpol_put(vma_policy(new));
  out_free_vma:
 	vm_area_free(new);
+	validate_mm_mt(mm);
 	return err;
 }
=20
@@ -3057,6 +3248,7 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
 	int error;
 	unsigned long mapped_addr;
+	validate_mm_mt(mm);
=20
 	/* Until we need other flags, refuse anything except VM_EXEC. */
 	if ((flags & (~VM_EXEC)) !=3D 0)
@@ -3114,6 +3306,7 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	if (flags & VM_LOCKED)
 		mm->locked_vm +=3D (len >> PAGE_SHIFT);
 	vma->vm_flags |=3D VM_SOFTDIRTY;
+	validate_mm_mt(mm);
 	return 0;
 }
=20
@@ -3218,6 +3411,9 @@ void exit_mmap(struct mm_struct *mm)
 		vma =3D remove_vma(vma);
 		cond_resched();
 	}
+
+	trace_exit_mmap(mm);
+	mtree_destroy(&mm->mm_mt);
 	vm_unacct_memory(nr_accounted);
 }
=20
@@ -3229,10 +3425,25 @@ int insert_vm_struct(struct mm_struct *mm, struct v=
m_area_struct *vma)
 {
 	struct vm_area_struct *prev;
 	struct rb_node **rb_link, *rb_parent;
+	unsigned long start =3D vma->vm_start;
+	struct vm_area_struct *overlap =3D NULL;
=20
 	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
 			   &prev, &rb_link, &rb_parent))
 		return -ENOMEM;
+
+	overlap =3D mt_find(&mm->mm_mt, &start, vma->vm_end - 1);
+	if (overlap) {
+
+		pr_err("Found vma ending at %lu\n", start - 1);
+		pr_err("vma : %lu =3D> %lu-%lu\n", (unsigned long)overlap,
+				overlap->vm_start, overlap->vm_end - 1);
+#if defined(CONFIG_DEBUG_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		BUG();
+	}
+
 	if ((vma->vm_flags & VM_ACCOUNT) &&
 	     security_vm_enough_memory_mm(mm, vma_pages(vma)))
 		return -ENOMEM;
@@ -3272,7 +3483,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	struct vm_area_struct *new_vma, *prev;
 	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma =3D true;
+	unsigned long index =3D addr;
=20
+	validate_mm_mt(mm);
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
@@ -3284,6 +3497,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
=20
 	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
 		return NULL;	/* should never get here */
+	if (mt_find(&mm->mm_mt, &index, addr+len - 1))
+		BUG();
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx);
@@ -3327,6 +3542,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 		vma_link(mm, new_vma, prev, rb_link, rb_parent);
 		*need_rmap_locks =3D false;
 	}
+	validate_mm_mt(mm);
 	return new_vma;
=20
 out_free_mempol:
@@ -3334,6 +3550,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
+	validate_mm_mt(mm);
 	return NULL;
 }
=20
@@ -3470,6 +3687,7 @@ static struct vm_area_struct *__install_special_mappi=
ng(
 	int ret;
 	struct vm_area_struct *vma;
=20
+	validate_mm_mt(mm);
 	vma =3D vm_area_alloc(mm);
 	if (unlikely(vma =3D=3D NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3491,10 +3709,12 @@ static struct vm_area_struct *__install_special_map=
ping(
=20
 	perf_event_mmap(vma);
=20
+	validate_mm_mt(mm);
 	return vma;
=20
 out:
 	vm_area_free(vma);
+	validate_mm_mt(mm);
 	return ERR_PTR(ret);
 }
=20
--=20
2.30.2
