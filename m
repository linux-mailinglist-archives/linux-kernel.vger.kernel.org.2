Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DEC36DC3D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbhD1PpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:45:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29318 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240799AbhD1PjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:39:15 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNedM010520;
        Wed, 28 Apr 2021 15:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=0vkpeMyAqYiHPWcC5h6vBnBJuls6sT/ouTMd8XcVjiY=;
 b=oxBIyrdtSDutUpWb0yhFgQd6LGSO4qxbd43tIFaWyd2gHqLeIQ5Nh/BBIg68c7OGkgGz
 HH4dzZ14jNlXFFoB3Rmlbb4KyEkPDQKYUTBlXC0fTFkiEhJZN8u4+1995LXTDyo6iyGd
 qLSJ7rLMlB8Of87WXnt1A/Br1OjygnOgUZd5T+pdxMUhOTbmV85Z2YDQ+xj5P2MLZhJo
 zBC7LcIr7qIJoCwc1TFs6x5c5vHX0dLzaoD72UhegQs8QfxH7EZyfmweSXVuHMXRKLuD
 TxesVKImkSKW7hmEC6HnhIlcfSHo6G6H91LdO4iSMU+nZgTdeE9Y3pI3f0tWZYXvPX8l Qw== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878910614-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:38:05 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFc2RQ027246;
        Wed, 28 Apr 2021 15:38:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3030.oracle.com with ESMTP id 3874d2773f-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:38:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YElYr5FH269sgYYWQiULzapo+pQyEnJEp61y4tSHjB9f1hIisKYvOCWBLcg5QvdjKxWLTNPfdwo3QVbHjyL2C8f5x+X71e3EoNUHik67SlyWEqa/XzV9aviXi14tAj0wip3uTC3RJ3ndGjIBANbY3WsWGRAVDiE4EI1KjQSgyLTOSayUHTlMBPKtRJA7LnmVpxMJcj7gSiIzoD5xI+58+oQYYKwIcwsz6rIoXStn0fGW9YWlmoaF0WF5qRVe3eoUDb8522PcPB0RJZrzpUwqG/NZWUb5+3qohwcWzVgflWoVW98zuSR/DT0VQr1eECr/J+oq+g2Nm/E99Zx9cOSs0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vkpeMyAqYiHPWcC5h6vBnBJuls6sT/ouTMd8XcVjiY=;
 b=PzbykDQAitP9ieqCngWjdL+lD1a65gJC5hEZq7q6FEmj4SkpNJB3WsA4/PLglZ9GmHgYS0OHHftmNDrr+oSkZ1FUu990IXlVmWjrpysC6eLBzDiYRIE4woZPWZiAZbYcseRTN8zCM2zwA3/wCOqFYSLEalG7v6d37DZY3WyJaKk1Go9ZdESV+zHdpF8extT+uImc3Q8inMiNhY+fApkrWhBqfVHvS4GRimWLVTEL8rsWwD8Sn/MOsuQ/r1nc8nw13PahjZxRvPHfbaGUn2rx0ofzqA51mKurNt2mYYRN0h0SM8ypq5i8gfCaYiguUtfeSB0q+7ffw7gAT8toMz8XuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vkpeMyAqYiHPWcC5h6vBnBJuls6sT/ouTMd8XcVjiY=;
 b=M46abUhl4p1H1EyM+9BWdWvtP62h/cOvuQnQUxqfvHkd6jxYlKyQK4VVDtYypc4m8wDCo2eDztIYDo2kZ2coDHsx84WhXBZTGdest2yUCd4IBntkrBEHW5kk5y8QfqTUftbXifc7lBijS81xwav2Rssye0rhRhyNpa9ZP6bhfCM=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:38:00 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:38:00 +0000
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
Subject: [PATCH 91/94] mm: Remove vma linked list.
Thread-Topic: [PATCH 91/94] mm: Remove vma linked list.
Thread-Index: AQHXPERDw334XN8ZH0mrsyZ/cSkQig==
Date:   Wed, 28 Apr 2021 15:36:31 +0000
Message-ID: <20210428153542.2814175-92-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: e426c2b6-5ebb-4c1a-2455-08d90a5b9ac5
x-ms-traffictypediagnostic: CO1PR10MB4548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB454870B4785FA24D283AEF23FD409@CO1PR10MB4548.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HMklQ9AmaFhwXRNKssWbnNUTjWAFb3Dz/BsgcPdShNQGQvNX8YQrtnCWkEwdi4HtGmeiEiSZ4plUwiqGuKstHAJuRNpB8GApXh1RVCX2M55qKb5ylKurCtnO+Vr78YC/r6/j1U6e3R9g2lgJXaK/QtnUle0QER9MAYfcIQ9GuqfmoIeYuGPCqCG5AEtjD6g/B3KXvuusrz/dnwI/uUw4WtndszccGovsRyGpyGyL4B9+lS6P+40j9VoO4ot3viqSn/owTaRIJD7V+y9hadNe4+H+mIKcXLgGY/lI7dFyOfStSo3vqqxuQWX5sKRZXB3NTyCynIlbfQ0WguosdZA5FH+3nz3vIiGwdR4Tj6oYwIOqr01Skv3BT9+WuH7SX/saHXinuqTOiMgYBuYzbZL3Bwua44NgV+s2NetrmJp4ytjHeQHixBh761gQ8dcdT5oYEyrf48NCGUfCis8IUYCqffXSqNW+p9oxrdkf/NKNRhhCggY7v7tCa0sJGo6d4yf2Kg3uyg+OVSYbSavGLLrHEl/CJ+cd8bGhAfSLQVqJQmbP+LvMJonNjvGcjGnlbs/e9pcarj1ppVeY8KIiPFv9Dw2KDajpMoYCJBpg+ZNnY9E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(6512007)(66946007)(8936002)(186003)(83380400001)(54906003)(86362001)(478600001)(122000001)(4326008)(76116006)(1076003)(107886003)(7416002)(110136005)(38100700002)(26005)(2906002)(2616005)(8676002)(66446008)(6666004)(6486002)(71200400001)(5660300002)(316002)(30864003)(44832011)(64756008)(91956017)(66476007)(66556008)(36756003)(6506007)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?DypcqSPwhPL6RLwB9/c6yAaEF+MV28kspa/HYAnmNUUz0n64qzbOpNRrnk?=
 =?iso-8859-1?Q?6D7NSDIXkgwmQE+kiY5w44WwYj3YEQFzHAKccxPe+LainmBZZeU1UO4aj8?=
 =?iso-8859-1?Q?lCAZI1h6/HeyqUGT/t3ABpKy2CnPV/OsSxMjNAYG3ek0/6fhiEVl9DcL3i?=
 =?iso-8859-1?Q?37KJcbsJDoPJo8Vv45IzJ0vUgOUD3t9TlgVuXUUUvzUbL2hfmW+iiz9Ycg?=
 =?iso-8859-1?Q?ZaT9WOPzlptfiBJVnltSEstd9BYmf1iJxluK0QydfR+QqtHlpOQaIju4In?=
 =?iso-8859-1?Q?J1V1StfAUuR24aikl6HLQMMGjKywrWva9fO63kJ+BUryFJcnOrxhsxRuJw?=
 =?iso-8859-1?Q?XcDJk7MfQfJGFg5y2LW3oBsQ+Jx6raWsCap2ITu2b3236qVfd14ik9RyzG?=
 =?iso-8859-1?Q?QCpxACI8QtCzi6wdka50ZWOJHhX/7Sash6060louVU0/JQHUK990iv4sfJ?=
 =?iso-8859-1?Q?Uye5jlnzp8h8Ylny0fzNqECmtKvcRAfElcirWdrcdz81zvf0N9X51LCh62?=
 =?iso-8859-1?Q?UmYEV8KpFRDIlass2SxyIRMDxfd19kpOSTtZS4G3Tyqyu/PG0K3ZMgLbwI?=
 =?iso-8859-1?Q?sXAxvpGiPq3kd9UMEd5+IjH8Z5RivqbKSB5a88UMZHwPdcCXG7CEXNcziK?=
 =?iso-8859-1?Q?jkz9yr8rlEMd3THXjga8Bv/e4z1pTROshlInHIoQ0SpDJHNSvm88mA4fIQ?=
 =?iso-8859-1?Q?MsdhMeMyYExnR18OkmKm6xgOgZ3z1fzKjb6MA8jjzw9khbGVqf3QxDpt+l?=
 =?iso-8859-1?Q?sX4pdmJ8tUdzBLnvfFYE+Bt+If0denYC64qp74NVaqMJHiG2yaKs9PsU2s?=
 =?iso-8859-1?Q?rce5ZoJXwgL9rXKxoyMem+4+dNFbXmvOwBUVTMwJDsujWdP7Y14082prae?=
 =?iso-8859-1?Q?zsAk8o/Wdz9kgaq4aJZ9b4KAhL9HShDoyxIZZQi86Cxi/BhU2ofm3ze0HQ?=
 =?iso-8859-1?Q?HxerDzV7cJZI+FLR6K6YjQAe4GJ8WfUrvh7UstWLDFxnUwJ6nJSeMWsZcb?=
 =?iso-8859-1?Q?vzJTlup3/UQC8ohVagQi59+210lKRY84oQfVXU/2kCl4o02aY69PY+M/cQ?=
 =?iso-8859-1?Q?I2Vy1dUV5m+xIgms/YCp6uWJzRvLO2kmJ6nc+W9ceL8wSMNRwoPp1KpmOw?=
 =?iso-8859-1?Q?Ma0544vKVZew1gzBG7+Y0SQPKB5MIOgQV7OIA+NawW5Isxwqg61YupcQNh?=
 =?iso-8859-1?Q?kIbQ1+h3qa7zW6wLZdyajKM8LcjCkvkl4LPM/MyP7/vcIVjqsg89a7X792?=
 =?iso-8859-1?Q?i+M6MXfdLlFOlofH9QORby+qJlUCr9KVwhDhOsJ3/84wmF4zCMsoMSK6yo?=
 =?iso-8859-1?Q?y6sCa6wQEf4hOV/Wt4/W95vkS5BuBxQ+0HGQNr/l1mXKCTIC9UMp9LVU07?=
 =?iso-8859-1?Q?dwMbAfXZCW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e426c2b6-5ebb-4c1a-2455-08d90a5b9ac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:31.5731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBUwtpadjaWhrucjh0JfTtjljFmOoljQQBuyrgOl1tXtTmHy0RUNjP4A9YQAa0xMDvAXOLNqhU6gS0592AsM5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: lSWChERn2wL4do4TQVF-ULrMXW4wtW4a
X-Proofpoint-ORIG-GUID: lSWChERn2wL4do4TQVF-ULrMXW4wtW4a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vma linked list has been replaced by the maple tree iterators and
vma_next() vma_prev() functions.

A part of this change is also the iterators free_pgd_range(),
zap_page_range(), and unmap_single_vma()

The internal _vma_next() has been dropped.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/task_nommu.c     |   2 +-
 include/linux/mm.h       |   2 +-
 include/linux/mm_types.h |   6 -
 kernel/fork.c            |  15 +-
 mm/debug.c               |  12 +-
 mm/internal.h            |   4 +-
 mm/memory.c              |  41 ++-
 mm/mmap.c                | 573 +++++++++++++++++----------------------
 mm/nommu.c               |  14 +-
 9 files changed, 301 insertions(+), 368 deletions(-)

diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index 8691a1216d1c..be02e8997ddf 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -246,7 +246,7 @@ static void *m_next(struct seq_file *m, void *_p, loff_=
t *pos)
 	struct vm_area_struct *vma =3D _p;
=20
 	*pos =3D vma->vm_end;
-	return vma->vm_next;
+	return vma_next(vma->vm_mm, vma);
 }
=20
 static const struct seq_operations proc_pid_maps_ops =3D {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 82b076787515..e1f1ae32fa9d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1731,7 +1731,7 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigne=
d long address,
 void zap_page_range(struct vm_area_struct *vma, unsigned long address,
 		    unsigned long size);
 void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
-		unsigned long start, unsigned long end);
+		struct ma_state *mas, unsigned long start, unsigned long end);
=20
 struct mmu_notifier_range;
=20
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 304692ada024..ca9fb13c2aca 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -303,14 +303,11 @@ struct vm_userfaultfd_ctx {};
  * library, the executable area etc).
  */
 struct vm_area_struct {
-	/* The first cache line has the info for VMA tree walking. */
-
 	unsigned long vm_start;		/* Our start address within vm_mm. */
 	unsigned long vm_end;		/* The first byte after our end address
 					   within vm_mm. */
=20
 	/* linked list of VM areas per task, sorted by address */
-	struct vm_area_struct *vm_next, *vm_prev;
 	struct mm_struct *vm_mm;	/* The address space we belong to. */
=20
 	/*
@@ -324,7 +321,6 @@ struct vm_area_struct {
 	unsigned long vm_pgoff;		/* Offset (within vm_file) in PAGE_SIZE
 					 * units
 					 */
-	/* Second cache line starts here. */
 	struct file *vm_file;		/* File we map to (can be NULL). */
 	/*
 	 * For areas with an address space and backing store,
@@ -378,7 +374,6 @@ struct core_state {
 struct kioctx_table;
 struct mm_struct {
 	struct {
-		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
@@ -393,7 +388,6 @@ struct mm_struct {
 		unsigned long mmap_compat_legacy_base;
 #endif
 		unsigned long task_size;	/* size of task vm space */
-		unsigned long highest_vm_end;	/* highest vma end address */
 		pgd_t * pgd;
=20
 #ifdef CONFIG_MEMBARRIER
diff --git a/kernel/fork.c b/kernel/fork.c
index fe0922f75cc5..6da1022e8758 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -364,7 +364,6 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struc=
t *orig)
 		 */
 		*new =3D data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
-		new->vm_next =3D new->vm_prev =3D NULL;
 	}
 	return new;
 }
@@ -473,7 +472,7 @@ EXPORT_SYMBOL(free_task);
 static __latent_entropy int dup_mmap(struct mm_struct *mm,
 					struct mm_struct *oldmm)
 {
-	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
+	struct vm_area_struct *mpnt, *tmp;
 	int retval;
 	unsigned long charge =3D 0;
 	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
@@ -500,7 +499,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	mm->exec_vm =3D oldmm->exec_vm;
 	mm->stack_vm =3D oldmm->stack_vm;
=20
-	pprev =3D &mm->mmap;
 	retval =3D ksm_fork(mm, oldmm);
 	if (retval)
 		goto out;
@@ -508,8 +506,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	if (retval)
 		goto out;
=20
-	prev =3D NULL;
-
 	retval =3D mas_entry_count(&mas, oldmm->map_count);
 	if (retval)
 		goto fail_nomem;
@@ -585,14 +581,6 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		if (is_vm_hugetlb_page(tmp))
 			reset_vma_resv_huge_pages(tmp);
=20
-		/*
-		 * Link in the new vma and copy the page table entries.
-		 */
-		*pprev =3D tmp;
-		pprev =3D &tmp->vm_next;
-		tmp->vm_prev =3D prev;
-		prev =3D tmp;
-
 		/* Link the vma into the MT */
 		mas.index =3D tmp->vm_start;
 		mas.last =3D tmp->vm_end - 1;
@@ -1024,7 +1012,6 @@ static void mm_init_uprobes_state(struct mm_struct *m=
m)
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct =
*p,
 	struct user_namespace *user_ns)
 {
-	mm->mmap =3D NULL;
 	mt_init_flags(&mm->mm_mt, MAPLE_ALLOC_RANGE);
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
diff --git a/mm/debug.c b/mm/debug.c
index f382d319722a..55afc85c4fcc 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -203,8 +203,8 @@ void dump_vma(const struct vm_area_struct *vma)
 		"prot %lx anon_vma %px vm_ops %px\n"
 		"pgoff %lx file %px private_data %px\n"
 		"flags: %#lx(%pGv)\n",
-		vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_next,
-		vma->vm_prev, vma->vm_mm,
+		vma, (void *)vma->vm_start, (void *)vma->vm_end,
+		vma_next(vma->vm_mm, vma), vma_prev(vma->vm_mm, vma), vma->vm_mm,
 		(unsigned long)pgprot_val(vma->vm_page_prot),
 		vma->anon_vma, vma->vm_ops, vma->vm_pgoff,
 		vma->vm_file, vma->vm_private_data,
@@ -214,11 +214,11 @@ EXPORT_SYMBOL(dump_vma);
=20
 void dump_mm(const struct mm_struct *mm)
 {
-	pr_emerg("mm %px mmap %px task_size %lu\n"
+	pr_emerg("mm %px task_size %lu\n"
 #ifdef CONFIG_MMU
 		"get_unmapped_area %px\n"
 #endif
-		"mmap_base %lu mmap_legacy_base %lu highest_vm_end %lu\n"
+		"mmap_base %lu mmap_legacy_base %lu\n"
 		"pgd %px mm_users %d mm_count %d pgtables_bytes %lu map_count %d\n"
 		"hiwater_rss %lx hiwater_vm %lx total_vm %lx locked_vm %lx\n"
 		"pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
@@ -242,11 +242,11 @@ void dump_mm(const struct mm_struct *mm)
 		"tlb_flush_pending %d\n"
 		"def_flags: %#lx(%pGv)\n",
=20
-		mm, mm->mmap, mm->task_size,
+		mm, mm->task_size,
 #ifdef CONFIG_MMU
 		mm->get_unmapped_area,
 #endif
-		mm->mmap_base, mm->mmap_legacy_base, mm->highest_vm_end,
+		mm->mmap_base, mm->mmap_legacy_base,
 		mm->pgd, atomic_read(&mm->mm_users),
 		atomic_read(&mm->mm_count),
 		mm_pgtables_bytes(mm),
diff --git a/mm/internal.h b/mm/internal.h
index 34d00548aa81..0fb161ee7f73 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -36,8 +36,8 @@ void page_writeback_init(void);
=20
 vm_fault_t do_swap_page(struct vm_fault *vmf);
=20
-void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vm=
a,
-		unsigned long floor, unsigned long ceiling);
+void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
+	struct vm_area_struct *vma, unsigned long floor, unsigned long ceiling);
=20
 static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
 {
diff --git a/mm/memory.c b/mm/memory.c
index 91e2a4c8dfd3..4de079ad0d48 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -399,13 +399,18 @@ void free_pgd_range(struct mmu_gather *tlb,
 	} while (pgd++, addr =3D next, addr !=3D end);
 }
=20
-void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
-		unsigned long floor, unsigned long ceiling)
+void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
+	struct vm_area_struct *vma, unsigned long floor, unsigned long ceiling)
 {
-	while (vma) {
-		struct vm_area_struct *next =3D vma->vm_next;
+	struct vm_area_struct *next;
+	struct ma_state ma_next =3D *mas;
+
+	do {
 		unsigned long addr =3D vma->vm_start;
=20
+		next =3D mas_find(&ma_next, ceiling - 1);
+		BUG_ON(vma->vm_start < floor);
+		BUG_ON(vma->vm_end - 1 > ceiling - 1);
 		/*
 		 * Hide vma from rmap and truncate_pagecache before freeing
 		 * pgtables
@@ -422,16 +427,20 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_=
area_struct *vma,
 			 */
 			while (next && next->vm_start <=3D vma->vm_end + PMD_SIZE
 			       && !is_vm_hugetlb_page(next)) {
+				*mas =3D ma_next;
 				vma =3D next;
-				next =3D vma->vm_next;
+				next =3D mas_find(&ma_next, ceiling - 1);
+				BUG_ON(vma->vm_start < floor);
+				BUG_ON(vma->vm_end -1 > ceiling - 1);
 				unlink_anon_vmas(vma);
 				unlink_file_vma(vma);
 			}
 			free_pgd_range(tlb, addr, vma->vm_end,
 				floor, next ? next->vm_start : ceiling);
 		}
+		*mas =3D ma_next;
 		vma =3D next;
-	}
+	} while (vma);
 }
=20
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
@@ -1510,16 +1519,19 @@ static void unmap_single_vma(struct mmu_gather *tlb=
,
  * drops the lock and schedules.
  */
 void unmap_vmas(struct mmu_gather *tlb,
-		struct vm_area_struct *vma, unsigned long start_addr,
-		unsigned long end_addr)
+		struct vm_area_struct *vma, struct ma_state *mas,
+		unsigned long start_addr, unsigned long end_addr)
 {
 	struct mmu_notifier_range range;
=20
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
 				start_addr, end_addr);
 	mmu_notifier_invalidate_range_start(&range);
-	for ( ; vma && vma->vm_start < end_addr; vma =3D vma->vm_next)
+	do {
+		BUG_ON(vma->vm_start < start_addr);
+		BUG_ON(vma->vm_end > end_addr);
 		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
+	} while ((vma =3D mas_find(mas, end_addr - 1)) !=3D NULL);
 	mmu_notifier_invalidate_range_end(&range);
 }
=20
@@ -1536,15 +1548,20 @@ void zap_page_range(struct vm_area_struct *vma, uns=
igned long start,
 {
 	struct mmu_notifier_range range;
 	struct mmu_gather tlb;
+	unsigned long end =3D start + size;
+	MA_STATE(mas, &vma->vm_mm->mm_mt, start, start);
=20
 	lru_add_drain();
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
-				start, start + size);
+				start, end);
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
-	for ( ; vma && vma->vm_start < range.end; vma =3D vma->vm_next)
-		unmap_single_vma(&tlb, vma, start, range.end, NULL);
+	rcu_read_lock();
+	mas_for_each(&mas, vma, end - 1)
+		unmap_single_vma(&tlb, vma, start, end, NULL);
+	rcu_read_unlock();
+
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index ed1b9df86966..c2baf006bcde 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -74,10 +74,6 @@ int mmap_rnd_compat_bits __read_mostly =3D CONFIG_ARCH_M=
MAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
=20
-static void unmap_region(struct mm_struct *mm,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		unsigned long start, unsigned long end);
-
 /* description of effects of mapping type and prot in current implementati=
on.
  * this is due to the limited x86 page protection hardware.  The expected
  * behavior is in parens:
@@ -175,10 +171,8 @@ void unlink_file_vma(struct vm_area_struct *vma)
 /*
  * Close a vm structure and free it, returning the next.
  */
-static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
+static void remove_vma(struct vm_area_struct *vma)
 {
-	struct vm_area_struct *next =3D vma->vm_next;
-
 	might_sleep();
 	if (vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
@@ -186,13 +180,13 @@ static struct vm_area_struct *remove_vma(struct vm_ar=
ea_struct *vma)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
 	vm_area_free(vma);
-	return next;
 }
=20
 static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 			 unsigned long newbrk, unsigned long oldbrk,
 			 struct list_head *uf);
-static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkv=
ma,
+static int do_brk_flags(struct ma_state *mas, struct ma_state *ma_prev,
+			struct vm_area_struct **brkvma,
 			unsigned long addr, unsigned long request,
 			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
@@ -205,6 +199,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct ma_state ma_neighbour;
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -261,7 +256,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		mas.last =3D oldbrk - 1;
 		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
 		if (ret =3D=3D 1)  {
 			downgraded =3D true;
@@ -272,26 +266,26 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		mm->brk =3D origbrk;
 		goto out;
 	}
+	ma_neighbour =3D mas;
+	next =3D mas_next(&ma_neighbour, newbrk + PAGE_SIZE + stack_guard_gap);
 	/* Only check if the next VMA is within the stack_guard_gap of the
 	 * expansion area */
-	next =3D mas_next(&mas, newbrk + PAGE_SIZE + stack_guard_gap);
 	/* Check against existing mmap mappings. */
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
-	brkvma =3D mas_prev(&mas, mm->start_brk);
+	brkvma =3D mas_prev(&ma_neighbour, mm->start_brk);
 	if (brkvma) {
-		if(brkvma->vm_start >=3D oldbrk)
+		if (brkvma->vm_start >=3D oldbrk)
 			goto out; // Trying to map over another vma.
=20
-		if (brkvma->vm_end <=3D min_brk) {
+		if (brkvma->vm_end <=3D min_brk)
 			brkvma =3D NULL;
-			mas_reset(&mas);
-		}
 	}
=20
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(&mas, &brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
+	if (do_brk_flags(&mas, &ma_neighbour, &brkvma, oldbrk,
+			 newbrk - oldbrk, 0) < 0)
 		goto out;
=20
 	mm->brk =3D brk;
@@ -316,85 +310,17 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 extern void mt_validate(struct maple_tree *mt);
 extern void mt_dump(const struct maple_tree *mt);
=20
-/* Validate the maple tree */
-static void validate_mm_mt(struct mm_struct *mm)
-{
-	struct maple_tree *mt =3D &mm->mm_mt;
-	struct vm_area_struct *vma_mt, *vma =3D mm->mmap;
-
-	MA_STATE(mas, mt, 0, 0);
-	rcu_read_lock();
-	mas_for_each(&mas, vma_mt, ULONG_MAX) {
-		if (xa_is_zero(vma_mt))
-			continue;
-
-		if (!vma)
-			break;
-
-		if ((vma !=3D vma_mt) ||
-		    (vma->vm_start !=3D vma_mt->vm_start) ||
-		    (vma->vm_end !=3D vma_mt->vm_end) ||
-		    (vma->vm_start !=3D mas.index) ||
-		    (vma->vm_end - 1 !=3D mas.last)) {
-			pr_emerg("issue in %s\n", current->comm);
-			dump_stack();
-#ifdef CONFIG_DEBUG_VM
-			dump_vma(vma_mt);
-			pr_emerg("and vm_next\n");
-			dump_vma(vma->vm_next);
-#endif // CONFIG_DEBUG_VM
-			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
-				 mas.index, mas.last);
-			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
-				 vma_mt->vm_start, vma_mt->vm_end);
-			if (vma->vm_prev) {
-				pr_emerg("ll prev: %px %lu - %lu\n",
-					 vma->vm_prev, vma->vm_prev->vm_start,
-					 vma->vm_prev->vm_end);
-			}
-			pr_emerg("ll vma: %px %lu - %lu\n", vma,
-				 vma->vm_start, vma->vm_end);
-			if (vma->vm_next) {
-				pr_emerg("ll next: %px %lu - %lu\n",
-					 vma->vm_next, vma->vm_next->vm_start,
-					 vma->vm_next->vm_end);
-			}
-
-			mt_dump(mas.tree);
-			if (vma_mt->vm_end !=3D mas.last + 1) {
-				pr_err("vma: %px vma_mt %lu-%lu\tmt %lu-%lu\n",
-						mm, vma_mt->vm_start, vma_mt->vm_end,
-						mas.index, mas.last);
-				mt_dump(mas.tree);
-			}
-			VM_BUG_ON_MM(vma_mt->vm_end !=3D mas.last + 1, mm);
-			if (vma_mt->vm_start !=3D mas.index) {
-				pr_err("vma: %px vma_mt %px %lu - %lu doesn't match\n",
-						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
-				mt_dump(mas.tree);
-			}
-			VM_BUG_ON_MM(vma_mt->vm_start !=3D mas.index, mm);
-		}
-		VM_BUG_ON(vma !=3D vma_mt);
-		vma =3D vma->vm_next;
-
-	}
-	VM_BUG_ON(vma);
-
-	rcu_read_unlock();
-	mt_validate(&mm->mm_mt);
-}
-
 static void validate_mm(struct mm_struct *mm)
 {
 	int bug =3D 0;
 	int i =3D 0;
-	unsigned long highest_address =3D 0;
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	validate_mm_mt(mm);
+	mmap_assert_locked(mm);
=20
-	while (vma) {
+	mt_validate(&mm->mm_mt);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 #ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma =3D vma->anon_vma;
 		struct anon_vma_chain *avc;
@@ -405,24 +331,18 @@ static void validate_mm(struct mm_struct *mm)
 			anon_vma_unlock_read(anon_vma);
 		}
 #endif
-		highest_address =3D vm_end_gap(vma);
-		vma =3D vma->vm_next;
+		VM_BUG_ON(mas.index !=3D vma->vm_start);
+		VM_BUG_ON(mas.last !=3D vma->vm_end - 1);
 		i++;
 	}
 	if (i !=3D mm->map_count) {
-		pr_emerg("map_count %d vm_next %d\n", mm->map_count, i);
-		bug =3D 1;
-	}
-	if (highest_address !=3D mm->highest_vm_end) {
-		pr_emerg("mm->highest_vm_end %lx, found %lx\n",
-			  mm->highest_vm_end, highest_address);
+		pr_emerg("map_count %d mas_for_each %d\n", mm->map_count, i);
 		bug =3D 1;
 	}
 	VM_BUG_ON_MM(bug, mm);
 }
=20
 #else // !CONFIG_DEBUG_MAPLE_TREE
-#define validate_mm_mt(root) do { } while (0)
 #define validate_mm(mm) do { } while (0)
 #endif // CONFIG_DEBUG_MAPLE_TREE
=20
@@ -469,7 +389,7 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_s=
truct *vma)
  *
  * Returns: True if there is an overlapping VMA, false otherwise
  */
-static bool range_has_overlap(struct mm_struct *mm, unsigned long start,
+static inline bool range_has_overlap(struct mm_struct *mm, unsigned long s=
tart,
 			      unsigned long end, struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *existing;
@@ -480,24 +400,6 @@ static bool range_has_overlap(struct mm_struct *mm, un=
signed long start,
 	return existing ? true : false;
 }
=20
-/*
- * _vma_next() - Get the next VMA or the first.
- * @mm: The mm_struct.
- * @vma: The current vma.
- *
- * If @vma is NULL, return the first vma in the mm.
- *
- * Returns: The next VMA after @vma.
- */
-static inline struct vm_area_struct *_vma_next(struct mm_struct *mm,
-					 struct vm_area_struct *vma)
-{
-	if (!vma)
-		return mm->mmap;
-
-	return vma->vm_next;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -573,7 +475,7 @@ static inline void vma_mt_store(struct mm_struct *mm, s=
truct vm_area_struct *vma
 }
=20
 static void vma_mas_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			 struct ma_state *mas, struct vm_area_struct *prev)
+			 struct ma_state *mas)
 {
 	struct address_space *mapping =3D NULL;
=20
@@ -592,36 +494,26 @@ static void vma_mas_link(struct mm_struct *mm, struct=
 vm_area_struct *vma,
 	validate_mm(mm);
 }
=20
-static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct vm_area_struct *prev)
+static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	struct address_space *mapping =3D NULL;
-
-	if (vma->vm_file) {
-		mapping =3D vma->vm_file->f_mapping;
-		i_mmap_lock_write(mapping);
-	}
-
-	vma_mt_store(mm, vma);
-	__vma_link_file(vma);
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end - 1);
=20
-	if (mapping)
-		i_mmap_unlock_write(mapping);
-
-	mm->map_count++;
-	validate_mm(mm);
+	vma_mas_link(mm, vma, &mas);
 }
=20
 /*
  * Helper for vma_adjust() in the split_vma insert case: insert a vma into=
 the
  * mm's list and the mm tree.  It has already been inserted into the inter=
val tree.
  */
-static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct=
 *vma)
+static inline void __insert_vm_struct(struct mm_struct *mm,
+				      struct vm_area_struct *vma)
 {
-	struct vm_area_struct *prev;
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end - 1);
+
+	BUG_ON(mas_find(&mas, vma->vm_end - 1));
+	mas_reset(&mas);
=20
-	BUG_ON(range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev));
-	vma_mt_store(mm, vma);
+	vma_mas_store(vma, &mas);
 	mm->map_count++;
 }
=20
@@ -637,9 +529,11 @@ inline int vma_expand(struct ma_state *mas, struct vm_=
area_struct *vma,
 	bool remove_next =3D false;
 	int error;
=20
+
 	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
+		/* Expanding existing VMA over a gap and next */
 		remove_next =3D true;
-		if (next->anon_vma && !vma->anon_vma) {
+		if (next->anon_vma && !anon_vma) {
 			vma->anon_vma =3D next->anon_vma;
 			error =3D anon_vma_clone(vma, next);
 			if (error)
@@ -669,7 +563,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	vma->vm_start =3D start;
 	vma->vm_end =3D end;
 	vma->vm_pgoff =3D pgoff;
-	/* Note: mas must be pointing to the expanding VMA */
 	vma_mas_store(vma, mas);
=20
 	if (file) {
@@ -678,11 +571,8 @@ inline int vma_expand(struct ma_state *mas, struct vm_=
area_struct *vma,
 	}
=20
 	/* Expanding over the next vma */
-	if (remove_next && file) {
+	if (remove_next && file)
 		__remove_shared_vm_struct(next, file, mapping);
-	} else if (!next) {
-		mm->highest_vm_end =3D vm_end_gap(vma);
-	}
=20
 	if (anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
@@ -721,7 +611,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	struct vm_area_struct *expand)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct *next =3D vma->vm_next, *orig_vma =3D vma;
+	struct vm_area_struct *next =3D vma_next(mm, vma), *orig_vma =3D vma;
 	struct address_space *mapping =3D NULL;
 	struct rb_root_cached *root =3D NULL;
 	struct anon_vma *anon_vma =3D NULL;
@@ -730,6 +620,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
=20
+	validate_mm(mm);
 	if (next && !insert) {
 		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
@@ -762,7 +653,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 				 */
 				remove_next =3D 1 + (end > next->vm_end);
 				VM_WARN_ON(remove_next =3D=3D 2 &&
-					   end !=3D next->vm_next->vm_end);
+					   end !=3D vma_next(mm, next)->vm_end);
 				/* trim end to next, for case 6 first pass */
 				end =3D next->vm_end;
 			}
@@ -775,7 +666,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 			 * next, if the vma overlaps with it.
 			 */
 			if (remove_next =3D=3D 2 && !next->anon_vma)
-				exporter =3D next->vm_next;
+				exporter =3D vma_next(mm, next);
=20
 		} else if (end > next->vm_start) {
 			/*
@@ -867,8 +758,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		else
 			vma_changed =3D true;
 		vma->vm_end =3D end;
-		if (!next)
-			mm->highest_vm_end =3D vm_end_gap(vma);
 	}
=20
 	if (vma_changed)
@@ -936,7 +825,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 			 * "next->vm_prev->vm_end" changed and the
 			 * "vma->vm_next" gap must be updated.
 			 */
-			next =3D vma->vm_next;
+			next =3D vma_next(mm, vma);
 		} else {
 			/*
 			 * For the scope of the comment "next" and
@@ -954,27 +843,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 			remove_next =3D 1;
 			end =3D next->vm_end;
 			goto again;
-		} else if (!next) {
-			/*
-			 * If remove_next =3D=3D 2 we obviously can't
-			 * reach this path.
-			 *
-			 * If remove_next =3D=3D 3 we can't reach this
-			 * path because pre-swap() next is always not
-			 * NULL. pre-swap() "next" is not being
-			 * removed and its next->vm_end is not altered
-			 * (and furthermore "end" already matches
-			 * next->vm_end in remove_next =3D=3D 3).
-			 *
-			 * We reach this only in the remove_next =3D=3D 1
-			 * case if the "next" vma that was removed was
-			 * the highest vma of the mm. However in such
-			 * case next->vm_end =3D=3D "end" and the extended
-			 * "vma" has vma->vm_end =3D=3D next->vm_end so
-			 * mm->highest_vm_end doesn't need any update
-			 * in remove_next =3D=3D 1 case.
-			 */
-			VM_WARN_ON(mm->highest_vm_end !=3D vm_end_gap(vma));
 		}
 	}
 	if (insert && file)
@@ -1134,10 +1002,14 @@ struct vm_area_struct *vma_merge(struct mm_struct *=
mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D _vma_next(mm, prev);
+	if (!prev)
+		next =3D find_vma(mm, 0);
+	else
+		next =3D vma_next(mm, prev);
+
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
-		next =3D next->vm_next;
+		next =3D vma_next(mm, next);
=20
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <=3D prev->vm_start);
@@ -1203,6 +1075,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 		return area;
 	}
=20
+	validate_mm(mm);
 	return NULL;
 }
=20
@@ -1272,17 +1145,20 @@ static struct anon_vma *reusable_anon_vma(struct vm=
_area_struct *old, struct vm_
 struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma)
 {
 	struct anon_vma *anon_vma =3D NULL;
+	struct vm_area_struct *next, *prev;
=20
 	/* Try next first. */
-	if (vma->vm_next) {
-		anon_vma =3D reusable_anon_vma(vma->vm_next, vma, vma->vm_next);
+	next =3D vma_next(vma->vm_mm, vma);
+	if (next) {
+		anon_vma =3D reusable_anon_vma(next, vma, next);
 		if (anon_vma)
 			return anon_vma;
 	}
=20
 	/* Try prev next. */
-	if (vma->vm_prev)
-		anon_vma =3D reusable_anon_vma(vma->vm_prev, vma->vm_prev, vma);
+	prev =3D vma_prev(vma->vm_mm, vma);
+	if (prev)
+		anon_vma =3D reusable_anon_vma(prev, prev, vma);
=20
 	/*
 	 * We might reach here with anon_vma =3D=3D NULL if we can't find
@@ -2055,7 +1931,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	if (gap_addr < address || gap_addr > TASK_SIZE)
 		gap_addr =3D TASK_SIZE;
=20
-	next =3D vma->vm_next;
+	next =3D vma_next(mm, vma);
 	if (next && next->vm_start < gap_addr && vma_is_accessible(next)) {
 		if (!(next->vm_flags & VM_GROWSUP))
 			return -ENOMEM;
@@ -2101,8 +1977,6 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 				vma->vm_end =3D address;
 				vma_mt_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
-				if (!vma->vm_next)
-					mm->highest_vm_end =3D vm_end_gap(vma);
 				spin_unlock(&mm->page_table_lock);
=20
 				perf_event_mmap(vma);
@@ -2129,7 +2003,7 @@ int expand_downwards(struct vm_area_struct *vma, unsi=
gned long address)
 		return -EPERM;
=20
 	/* Enforce stack_guard_gap */
-	prev =3D vma->vm_prev;
+	prev =3D vma_prev(mm, vma);
 	/* Check that both stack segments have the same anon_vma? */
 	if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
 			vma_is_accessible(prev)) {
@@ -2264,21 +2138,21 @@ EXPORT_SYMBOL_GPL(find_extend_vma);
  *
  * Called with the mm semaphore held.
  */
-static inline void remove_vma_list(struct mm_struct *mm,
-				   struct vm_area_struct *vma)
+static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
 {
+	struct vm_area_struct *vma;
 	unsigned long nr_accounted =3D 0;
=20
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
-	do {
+	mas_for_each(mas, vma, ULONG_MAX) {
 		long nrpages =3D vma_pages(vma);
=20
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted +=3D nrpages;
 		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		vma =3D remove_vma(vma);
-	} while (vma);
+		remove_vma(vma);
+	}
 	vm_unacct_memory(nr_accounted);
 	validate_mm(mm);
 }
@@ -2289,21 +2163,22 @@ static inline void remove_vma_list(struct mm_struct=
 *mm,
  * Called with the mm semaphore held.
  */
 static void unmap_region(struct mm_struct *mm,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		unsigned long start, unsigned long end)
+		     struct vm_area_struct *vma, struct ma_state *mas,
+		     unsigned long start, unsigned long end,
+		     struct vm_area_struct *prev, unsigned long max)
 {
-	struct vm_area_struct *next =3D _vma_next(mm, prev);
 	struct mmu_gather tlb;
+	struct ma_state ma_pgtb =3D *mas;
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, vma, start, end);
-	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
-				 next ? next->vm_start : USER_PGTABLES_CEILING);
+	unmap_vmas(&tlb, vma, mas, start, end);
+	free_pgtables(&tlb, &ma_pgtb, vma,
+		      prev ? prev->vm_end : FIRST_USER_ADDRESS,
+		      max);
 	tlb_finish_mmu(&tlb);
 }
-
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this wher=
e it
  * has already been checked or doesn't make sense to fail.
@@ -2313,7 +2188,6 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 {
 	struct vm_area_struct *new;
 	int err;
-	validate_mm_mt(mm);
=20
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err =3D vma->vm_ops->may_split(vma, addr);
@@ -2366,7 +2240,6 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	mpol_put(vma_policy(new));
  out_free_vma:
 	vm_area_free(new);
-	validate_mm_mt(mm);
 	return err;
 }
=20
@@ -2383,24 +2256,31 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-static inline int unlock_range(struct vm_area_struct *start,
-			       struct vm_area_struct **tail, unsigned long limit)
+
+static inline void detach_range(struct mm_struct *mm, struct ma_state *mas=
,
+			struct ma_state *dst, struct vm_area_struct **vma)
 {
-	struct mm_struct *mm =3D start->vm_mm;
-	struct vm_area_struct *tmp =3D start;
+	unsigned long start =3D dst->index;
+	unsigned long end =3D dst->last;
 	int count =3D 0;
=20
-	while (tmp && tmp->vm_start < limit) {
-		*tail =3D tmp;
+	do {
 		count++;
-		if (tmp->vm_flags & VM_LOCKED) {
-			mm->locked_vm -=3D vma_pages(tmp);
-			munlock_vma_pages_all(tmp);
+		*vma =3D mas_prev(mas, start);
+		BUG_ON((*vma)->vm_start < start);
+		BUG_ON((*vma)->vm_end > end + 1);
+		vma_mas_store(*vma, dst);
+		if ((*vma)->vm_flags & VM_LOCKED) {
+			mm->locked_vm -=3D vma_pages(*vma);
+			munlock_vma_pages_all(*vma);
 		}
-		tmp =3D tmp->vm_next;
-	}
+	} while ((*vma)->vm_start > start);
=20
-	return count;
+	/* Drop removed area from the tree */
+	mas->last =3D end;
+	mas_store_gfp(mas, NULL, GFP_KERNEL);
+	/* Decrement map_count */
+	mm->map_count -=3D count;
 }
=20
 /* do_mas_align_munmap() - munmap the aligned region from @start to @end.
@@ -2419,9 +2299,17 @@ static int do_mas_align_munmap(struct ma_state *mas,=
 struct vm_area_struct *vma,
 	       struct mm_struct *mm, unsigned long start, unsigned long end,
 	       struct list_head *uf, bool downgrade)
 {
-	struct vm_area_struct *prev, *last;
+	struct vm_area_struct *prev, *last, *next =3D NULL;
+	struct maple_tree mt_detach;
+	unsigned long max =3D USER_PGTABLES_CEILING;
+	MA_STATE(dst, NULL, start, end - 1);
+	struct ma_state tmp;
 	/* we have start < vma->vm_end  */
=20
+	validate_mm(mm);
+	/* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, start, end);
+
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2442,28 +2330,33 @@ static int do_mas_align_munmap(struct ma_state *mas=
, struct vm_area_struct *vma,
 		error =3D __split_vma(mm, vma, start, 0);
 		if (error)
 			return error;
+
 		prev =3D vma;
-		vma =3D _vma_next(mm, prev);
-		mas->index =3D start;
-		mas_reset(mas);
+		mas_set_range(mas, start, end - 1);
+		vma =3D mas_walk(mas);
+
 	} else {
-		prev =3D vma->vm_prev;
+		tmp =3D *mas;
+		prev =3D mas_prev(&tmp, 0);
 	}
=20
-	if (vma->vm_end >=3D end)
+	if (end < vma->vm_end) {
 		last =3D vma;
-	else
-		last =3D find_vma_intersection(mm, end - 1, end);
+	} else {
+		mas_set(mas, end - 1);
+		last =3D mas_walk(mas);
+	}
=20
 	/* Does it split the last one? */
 	if (last && end < last->vm_end) {
-		int error =3D __split_vma(mm, last, end, 1);
+		int error;
+		error =3D __split_vma(mm, last, end, 1);
 		if (error)
 			return error;
-		vma =3D _vma_next(mm, prev);
-		mas_reset(mas);
+		mas_set(mas, end - 1);
+		last =3D mas_walk(mas);
 	}
-
+	next =3D mas_next(mas, ULONG_MAX);
=20
 	if (unlikely(uf)) {
 		/*
@@ -2481,27 +2374,15 @@ static int do_mas_align_munmap(struct ma_state *mas=
, struct vm_area_struct *vma,
 			return error;
 	}
=20
-	/*
-	 * unlock any mlock()ed ranges before detaching vmas, count the number
-	 * of VMAs to be dropped, and return the tail entry of the affected
-	 * area.
-	 */
-	mm->map_count -=3D unlock_range(vma, &last, end);
-	/* Drop removed area from the tree */
-	mas_store_gfp(mas, NULL, GFP_KERNEL);
+	/* Point of no return */
+	mas_lock(mas);
+	if (next)
+		max =3D next->vm_start;
=20
-	/* Detach vmas from the MM linked list */
-	vma->vm_prev =3D NULL;
-	if (prev)
-		prev->vm_next =3D last->vm_next;
-	else
-		mm->mmap =3D last->vm_next;
-
-	if (last->vm_next) {
-		last->vm_next->vm_prev =3D prev;
-		last->vm_next =3D NULL;
-	} else
-		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
+	mtree_init(&mt_detach, MAPLE_ALLOC_RANGE);
+	dst.tree =3D &mt_detach;
+	detach_range(mm, mas, &dst, &vma);
+	mas_unlock(mas);
=20
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
@@ -2509,7 +2390,7 @@ static int do_mas_align_munmap(struct ma_state *mas, =
struct vm_area_struct *vma,
 	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
 	 */
 	if (downgrade) {
-		if (last && (last->vm_flags & VM_GROWSDOWN))
+		if (next && (next->vm_flags & VM_GROWSDOWN))
 			downgrade =3D false;
 		else if (prev && (prev->vm_flags & VM_GROWSUP))
 			downgrade =3D false;
@@ -2517,11 +2398,16 @@ static int do_mas_align_munmap(struct ma_state *mas=
, struct vm_area_struct *vma,
 			mmap_write_downgrade(mm);
 	}
=20
-	unmap_region(mm, vma, prev, start, end);
+	/* Unmap the region */
+	unmap_region(mm, vma, &dst, start, end, prev, max);
+
+	/* Statistics and freeing VMAs */
+	mas_set(&dst, start);
+	remove_mt(mm, &dst);
=20
-	/* Fix up all other VM information */
-	remove_vma_list(mm, vma);
+	mtree_destroy(&mt_detach);
=20
+	validate_mm(mm);
 	return downgrade ? 1 : 0;
 }
=20
@@ -2546,16 +2432,14 @@ int do_mas_munmap(struct ma_state *mas, struct mm_s=
truct *mm,
 	unsigned long end;
 	struct vm_area_struct *vma;
=20
-	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
+	if ((offset_in_page(start)) || (start > TASK_SIZE) ||
+	    (len > TASK_SIZE - start))
 		return -EINVAL;
=20
 	end =3D start + PAGE_ALIGN(len);
 	if (end =3D=3D start)
 		return -EINVAL;
=20
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
-
 	/* Find the first overlapping VMA */
 	vma =3D mas_find(mas, end - 1);
 	if (!vma)
@@ -2574,8 +2458,11 @@ int do_mas_munmap(struct ma_state *mas, struct mm_st=
ruct *mm,
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
+	int ret;
 	MA_STATE(mas, &mm->mm_mt, start, start);
-	return do_mas_munmap(&mas, mm, start, len, uf, false);
+
+	ret =3D do_mas_munmap(&mas, mm, start, len, uf, false);
+	return ret;
 }
=20
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2584,15 +2471,18 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 {
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma =3D NULL;
-	struct vm_area_struct *prev, *next;
+	struct vm_area_struct *prev, *next =3D NULL;
 	pgoff_t pglen =3D len >> PAGE_SHIFT;
 	unsigned long charged =3D 0;
 	unsigned long end =3D addr + len;
 	unsigned long merge_start =3D addr, merge_end =3D end;
+	unsigned long max =3D USER_PGTABLES_CEILING;
 	pgoff_t vm_pgoff;
 	int error;
+	struct ma_state ma_prev, tmp;
 	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
=20
+
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
 		unsigned long nr_pages;
@@ -2608,57 +2498,66 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 			return -ENOMEM;
 	}
=20
+	validate_mm(mm);
 	/* Unmap any existing mapping in the area */
-	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false)) {
 		return -ENOMEM;
+	}
=20
 	/*
 	 * Private writable mapping: check memory availability
 	 */
 	if (accountable_mapping(file, vm_flags)) {
 		charged =3D len >> PAGE_SHIFT;
-		if (security_vm_enough_memory_mm(mm, charged))
+		if (security_vm_enough_memory_mm(mm, charged)) {
 			return -ENOMEM;
+		}
 		vm_flags |=3D VM_ACCOUNT;
 	}
=20
+	mas_set_range(&mas, addr, end - 1);
+	mas_walk(&mas);  // Walk to the empty area (munmapped above)
+	ma_prev =3D mas;
+	prev =3D mas_prev(&ma_prev, 0);
=20
-	if (vm_flags & VM_SPECIAL) {
-		prev =3D mas_prev(&mas, 0);
+	if (vm_flags & VM_SPECIAL)
 		goto cannot_expand;
-	}
=20
 	/* Attempt to expand an old mapping */
=20
 	/* Check next */
-	next =3D mas_next(&mas, ULONG_MAX);
-	if (next && next->vm_start =3D=3D end && vma_policy(next) &&
-	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
-				 NULL_VM_UFFD_CTX)) {
-		merge_end =3D next->vm_end;
-		vma =3D next;
-		vm_pgoff =3D next->vm_pgoff - pglen;
+	tmp =3D mas;
+	next =3D mas_next(&tmp, ULONG_MAX);
+	if (next) {
+		max =3D next->vm_start;
+		if (next->vm_start =3D=3D end && vma_policy(next) &&
+		    can_vma_merge_before(next, vm_flags, NULL, file,
+					 pgoff + pglen, NULL_VM_UFFD_CTX)) {
+			/* Try to expand next back over the requested area */
+			merge_end =3D next->vm_end;
+			vma =3D next;
+			vm_pgoff =3D next->vm_pgoff - pglen;
+		}
 	}
=20
 	/* Check prev */
-	prev =3D mas_prev(&mas, 0);
 	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
 	    can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
 				NULL_VM_UFFD_CTX)) {
+		/* Try to expand the prev over the requested area */
 		merge_start =3D prev->vm_start;
 		vma =3D prev;
+		mas =3D ma_prev;
 		vm_pgoff =3D prev->vm_pgoff;
 	}
=20
-
 	/* Actually expand, if possible */
 	if (vma &&
 	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma_merge(prev, vm_flags);
+		khugepaged_enter_vma_merge(vma, vm_flags);
 		goto expanded;
 	}
=20
-	mas_set_range(&mas, addr, end - 1);
 cannot_expand:
 	/*
 	 * Determine the object being mapped and call the appropriate
@@ -2704,9 +2603,12 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		 * Answer: Yes, several device drivers can do it in their
 		 *         f_op->mmap method. -DaveM
 		 */
-		WARN_ON_ONCE(addr !=3D vma->vm_start);
+		if (addr !=3D vma->vm_start) {
+			WARN_ON_ONCE(addr !=3D vma->vm_start);
+			addr =3D vma->vm_start;
+			mas_set_range(&mas, addr, end - 1);
+		}
=20
-		addr =3D vma->vm_start;
=20
 		/* If vm_flags changed after call_mmap(), we should try merge vma again
 		 * as we may succeed this time.
@@ -2717,7 +2619,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 						 pgoff, NULL_VM_UFFD_CTX))) {
 			merge_start =3D prev->vm_start;
 			vm_pgoff =3D prev->vm_pgoff;
-			if (!vma_expand(&mas, prev, merge_start, merge_end,
+			if (!vma_expand(&ma_prev, prev, merge_start, merge_end,
 					vm_pgoff, next)) {
 				/* ->mmap() can change vma->vm_file and fput the original file. So
 				 * fput the vma->vm_file here or we would add an extra fput for file
@@ -2742,6 +2644,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	} else {
 		vma_set_anonymous(vma);
+		vma->vm_pgoff =3D vma->vm_start >> PAGE_SHIFT;
 	}
=20
 	/* Allow architectures to sanity-check the vm_flags */
@@ -2753,9 +2656,8 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	}
=20
-	mas.index =3D mas.last =3D addr;
-	mas_walk(&mas);
-	vma_mas_link(mm, vma, &mas, prev);
+	vma_mas_link(mm, vma, &mas);
+
 	/* Once vma denies write, undo our temporary denial count */
 	if (file) {
 unmap_writable:
@@ -2791,6 +2693,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	vma->vm_flags |=3D VM_SOFTDIRTY;
=20
 	vma_set_page_prot(vma);
+	validate_mm(mm);
=20
 	return addr;
=20
@@ -2799,7 +2702,8 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	vma->vm_file =3D NULL;
=20
 	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	mas_set_range(&mas, addr, end - 1);
+	unmap_region(mm, vma, &mas, vma->vm_start, vma->vm_end, prev, max);
 	charged =3D 0;
 	if (vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
@@ -2823,7 +2727,6 @@ static int __vm_munmap(unsigned long start, size_t le=
n, bool downgrade)
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
-
 	ret =3D do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
@@ -2866,15 +2769,16 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
 	unsigned long populate =3D 0;
 	unsigned long ret =3D -EINVAL;
 	struct file *file;
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
 	pr_warn_once("%s (%d) uses deprecated remap_file_pages() syscall. See Doc=
umentation/vm/remap_file_pages.rst.\n",
 		     current->comm, current->pid);
=20
 	if (prot)
 		return ret;
+
 	start =3D start & PAGE_MASK;
 	size =3D size & PAGE_MASK;
-
 	if (start + size <=3D start)
 		return ret;
=20
@@ -2885,20 +2789,22 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	vma =3D find_vma(mm, start);
+	mas_set(&mas, start);
+	vma =3D mas_walk(&mas);
=20
 	if (!vma || !(vma->vm_flags & VM_SHARED))
 		goto out;
=20
-	if (start < vma->vm_start)
+	if (!vma->vm_file)
 		goto out;
=20
 	if (start + size > vma->vm_end) {
-		struct vm_area_struct *next;
+		struct vm_area_struct *prev, *next;
=20
-		for (next =3D vma->vm_next; next; next =3D next->vm_next) {
+		prev =3D vma;
+		mas_for_each(&mas, next, start + size) {
 			/* hole between vmas ? */
-			if (next->vm_start !=3D next->vm_prev->vm_end)
+			if (next->vm_start !=3D prev->vm_end)
 				goto out;
=20
 			if (next->vm_file !=3D vma->vm_file)
@@ -2909,6 +2815,8 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, star=
t, unsigned long, size,
=20
 			if (start + size <=3D next->vm_end)
 				break;
+
+			prev =3D next;
 		}
=20
 		if (!next)
@@ -2954,9 +2862,10 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
 			 struct list_head *uf)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct unmap;
+	struct vm_area_struct unmap, *next;
 	unsigned long unmap_pages;
 	int ret;
+	struct ma_state ma_next;
=20
 	arch_unmap(mm, newbrk, oldbrk);
=20
@@ -2972,11 +2881,17 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 	vma_init(&unmap, mm);
 	unmap.vm_start =3D newbrk;
 	unmap.vm_end =3D oldbrk;
+	unmap.vm_pgoff =3D newbrk >> PAGE_SHIFT;
+	if (vma->anon_vma)
+		vma_set_anonymous(&unmap);
+
 	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
 	if (ret)
 		return ret;
-	ret =3D 1;
=20
+	ret =3D 1;
+	ma_next =3D *mas;
+	next =3D mas_next(&ma_next, ULONG_MAX);
 	// Change the oldbrk of vma to the newbrk of the munmap area
 	vma_adjust_trans_huge(vma, vma->vm_start, newbrk, 0);
 	if (vma->anon_vma) {
@@ -2984,15 +2899,16 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 		anon_vma_interval_tree_pre_update_vma(vma);
 	}
=20
-	vma->vm_end =3D newbrk;
 	if (vma_mas_remove(&unmap, mas))
 		goto mas_store_fail;
=20
+	vma->vm_end =3D newbrk;
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
 		anon_vma_unlock_write(vma->anon_vma);
 	}
=20
+	validate_mm(mm);
 	unmap_pages =3D vma_pages(&unmap);
 	if (unmap.vm_flags & VM_LOCKED) {
 		mm->locked_vm -=3D unmap_pages;
@@ -3000,14 +2916,15 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 	}
=20
 	mmap_write_downgrade(mm);
-	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	unmap_region(mm, &unmap, mas, newbrk, oldbrk, vma,
+		     next ? next->vm_start : 0);
 	/* Statistics */
 	vm_stat_account(mm, unmap.vm_flags, -unmap_pages);
 	if (unmap.vm_flags & VM_ACCOUNT)
 		vm_unacct_memory(unmap_pages);
=20
 munmap_full_vma:
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return ret;
=20
 mas_store_fail:
@@ -3031,15 +2948,15 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
  * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
  * do some brk-specific accounting here.
  */
-static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkv=
ma,
+static int do_brk_flags(struct ma_state *mas, struct ma_state *ma_prev,
+			struct vm_area_struct **brkvma,
 			unsigned long addr, unsigned long len,
 			unsigned long flags)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *prev =3D NULL, *vma;
+	struct vm_area_struct *vma;
 	int error;
 	unsigned long mapped_addr;
-	validate_mm_mt(mm);
=20
 	/* Until we need other flags, refuse anything except VM_EXEC. */
 	if ((flags & (~VM_EXEC)) !=3D 0)
@@ -3064,7 +2981,6 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct **brkvma,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	mas->last =3D addr + len - 1;
 	if (*brkvma) {
 		vma =3D *brkvma;
 		/* Expand the existing vma if possible; almost never a singular
@@ -3073,17 +2989,21 @@ static int do_brk_flags(struct ma_state *mas, struc=
t vm_area_struct **brkvma,
 		if ((!vma->anon_vma ||
 		     list_is_singular(&vma->anon_vma_chain)) &&
 		     ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)){
-			mas->index =3D vma->vm_start;
+			ma_prev->index =3D vma->vm_start;
+			ma_prev->last =3D addr + len - 1;
=20
 			vma_adjust_trans_huge(vma, addr, addr + len, 0);
 			if (vma->anon_vma) {
 				anon_vma_lock_write(vma->anon_vma);
 				anon_vma_interval_tree_pre_update_vma(vma);
 			}
+			mas_lock(ma_prev);
 			vma->vm_end =3D addr + len;
 			vma->vm_flags |=3D VM_SOFTDIRTY;
-			if (mas_store_gfp(mas, vma, GFP_KERNEL))
+			if (mas_store_gfp(ma_prev, vma, GFP_KERNEL)) {
+				mas_unlock(ma_prev);
 				goto mas_mod_fail;
+			}
=20
 			if (vma->anon_vma) {
 				anon_vma_interval_tree_post_update_vma(vma);
@@ -3092,11 +3012,9 @@ static int do_brk_flags(struct ma_state *mas, struct=
 vm_area_struct **brkvma,
 			khugepaged_enter_vma_merge(vma, flags);
 			goto out;
 		}
-		prev =3D vma;
 	}
-	mas->index =3D addr;
-	mas_walk(mas);
=20
+	mas->last =3D addr + len - 1;
 	/* create a vma struct for an anonymous mapping */
 	vma =3D vm_area_alloc(mm);
 	if (!vma)
@@ -3111,9 +3029,6 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct **brkvma,
 	if (vma_mas_store(vma, mas))
 		goto mas_store_fail;
=20
-	if (!prev)
-		prev =3D mas_prev(mas, 0);
-
 	mm->map_count++;
 	*brkvma =3D vma;
 out:
@@ -3123,7 +3038,6 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct **brkvma,
 	if (flags & VM_LOCKED)
 		mm->locked_vm +=3D (len >> PAGE_SHIFT);
 	vma->vm_flags |=3D VM_SOFTDIRTY;
-	validate_mm_mt(mm);
 	return 0;
=20
 mas_store_fail:
@@ -3162,7 +3076,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
quest, unsigned long flags)
=20
 	// This vma left intentionally blank.
 	mas_walk(&mas);
-	ret =3D do_brk_flags(&mas, &vma, addr, len, flags);
+	ret =3D do_brk_flags(&mas, &mas, &vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
 	if (populate && !ret)
@@ -3183,6 +3097,8 @@ void exit_mmap(struct mm_struct *mm)
 	struct mmu_gather tlb;
 	struct vm_area_struct *vma;
 	unsigned long nr_accounted =3D 0;
+	struct ma_state mas2;
+	MA_STATE(mas, &mm->mm_mt, FIRST_USER_ADDRESS, FIRST_USER_ADDRESS);
=20
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
@@ -3211,32 +3127,43 @@ void exit_mmap(struct mm_struct *mm)
 		mmap_write_unlock(mm);
 	}
=20
-	if (mm->locked_vm)
-		unlock_range(mm->mmap, &vma, ULONG_MAX);
+	if (mm->locked_vm) {
+		mas_for_each(&mas, vma, ULONG_MAX) {
+			if (vma->vm_flags & VM_LOCKED) {
+				mm->locked_vm -=3D vma_pages(vma);
+				munlock_vma_pages_all(vma);
+			}
+		}
+		mas_set(&mas, FIRST_USER_ADDRESS);
+	}
=20
 	arch_exit_mmap(mm);
=20
-	vma =3D mm->mmap;
-	if (!vma)	/* Can happen if dup_mmap() received an OOM */
+	vma =3D mas_find(&mas, ULONG_MAX);
+	if (!vma) { /* Can happen if dup_mmap() received an OOM */
+		rcu_read_unlock();
 		return;
+	}
=20
 	lru_add_drain();
 	flush_cache_mm(mm);
 	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
-	unmap_vmas(&tlb, vma, 0, -1);
-	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
+	mas2 =3D mas;
+	unmap_vmas(&tlb, vma, &mas, 0, -1);
+	free_pgtables(&tlb, &mas2, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING=
);
 	tlb_finish_mmu(&tlb);
=20
 	/*
 	 * Walk the list again, actually closing and freeing it,
 	 * with preemption enabled, without holding any MM locks.
 	 */
-	while (vma) {
+	mas_set(&mas, 0);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted +=3D vma_pages(vma);
-		vma =3D remove_vma(vma);
+		remove_vma(vma);
 		cond_resched();
 	}
=20
@@ -3251,9 +3178,7 @@ void exit_mmap(struct mm_struct *mm)
  */
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	struct vm_area_struct *prev;
-
-	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
+	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		return -ENOMEM;
=20
 	if ((vma->vm_flags & VM_ACCOUNT) &&
@@ -3277,7 +3202,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_=
area_struct *vma)
 		vma->vm_pgoff =3D vma->vm_start >> PAGE_SHIFT;
 	}
=20
-	vma_link(mm, vma, prev);
+	vma_link(mm, vma);
 	return 0;
 }
=20
@@ -3295,7 +3220,6 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	struct vm_area_struct *new_vma, *prev;
 	bool faulted_in_anon_vma =3D true;
=20
-	validate_mm_mt(mm);
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
@@ -3348,10 +3272,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struc=
t **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
-		vma_link(mm, new_vma, prev);
+		vma_link(mm, new_vma);
 		*need_rmap_locks =3D false;
 	}
-	validate_mm_mt(mm);
 	return new_vma;
=20
 out_free_mempol:
@@ -3359,7 +3282,6 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
-	validate_mm_mt(mm);
 	return NULL;
 }
=20
@@ -3496,7 +3418,6 @@ static struct vm_area_struct *__install_special_mappi=
ng(
 	int ret;
 	struct vm_area_struct *vma;
=20
-	validate_mm_mt(mm);
 	vma =3D vm_area_alloc(mm);
 	if (unlikely(vma =3D=3D NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3518,12 +3439,10 @@ static struct vm_area_struct *__install_special_map=
ping(
=20
 	perf_event_mmap(vma);
=20
-	validate_mm_mt(mm);
 	return vma;
=20
 out:
 	vm_area_free(vma);
-	validate_mm_mt(mm);
 	return ERR_PTR(ret);
 }
=20
@@ -3648,12 +3567,14 @@ int mm_take_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	BUG_ON(mmap_read_trylock(mm));
=20
 	mutex_lock(&mm_all_locks_mutex);
+	rcu_read_lock();
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
@@ -3661,7 +3582,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 			vm_lock_mapping(mm, vma->vm_file->f_mapping);
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_set(&mas, 0);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
@@ -3669,7 +3591,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 			vm_lock_mapping(mm, vma->vm_file->f_mapping);
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_set(&mas, 0);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->anon_vma)
@@ -3677,9 +3600,11 @@ int mm_take_all_locks(struct mm_struct *mm)
 				vm_lock_anon_vma(mm, avc->anon_vma);
 	}
=20
+	rcu_read_unlock();
 	return 0;
=20
 out_unlock:
+	rcu_read_unlock();
 	mm_drop_all_locks(mm);
 	return -EINTR;
 }
@@ -3728,17 +3653,21 @@ void mm_drop_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	BUG_ON(mmap_read_trylock(mm));
 	BUG_ON(!mutex_is_locked(&mm_all_locks_mutex));
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (vma->anon_vma)
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				vm_unlock_anon_vma(avc->anon_vma);
 		if (vma->vm_file && vma->vm_file->f_mapping)
 			vm_unlock_mapping(vma->vm_file->f_mapping);
 	}
+	rcu_read_unlock();
=20
 	mutex_unlock(&mm_all_locks_mutex);
 }
diff --git a/mm/nommu.c b/mm/nommu.c
index 916038bafc65..a99e276445ce 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1428,7 +1428,8 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 				return -EINVAL;
 			if (end =3D=3D vma->vm_end)
 				goto erase_whole_vma;
-			vma =3D  vma_next(mm, vma);
+
+			vma =3D vma_next(mm, vma);
 		} while (vma);
 		return -EINVAL;
 	} else {
@@ -1479,18 +1480,23 @@ SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t=
, len)
 void exit_mmap(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	if (!mm)
 		return;
=20
+	mas.tree =3D &mm->mm_mt;
 	mm->total_vm =3D 0;
-
-	while ((vma =3D mm->mmap)) {
-		mm->mmap =3D vma_next(mm, vma);
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		delete_vma_from_mm(vma);
 		delete_vma(mm, vma);
+		rcu_read_unlock();
+		mas_pause(&mas);
 		cond_resched();
+		rcu_read_lock();
 	}
+	rcu_read_unlock();
 }
=20
 int vm_brk(unsigned long addr, unsigned long len)
--=20
2.30.2
