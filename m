Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD37421BFC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhJEBfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:35:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57114 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231789AbhJEBdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:43 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951FsWj010243;
        Tue, 5 Oct 2021 01:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=9yaumyphYCyNdVnIicMMYex63o6sSPDgmUVydigwMWY=;
 b=JPH0E10W14ARKD48kyoE9y8aluBzaglsdas6xQG5qp2RfeS9ZFG00cU3zmMsDlnnQfm6
 i7xcb3BJE3kDeg36d4xxjl3f3WETBiX93H6X/E13vIOFCNZVh/tun6pxb62UrohM538k
 BKP/jqdMAYf0JiByob9dHEhehJS58kgNkQgAxVf1hiBX4eXopB73teCL7F0KaF7GqxlH
 XnRTbz2wBfz8yHH2GzaUZmU9/A+/TAqWvZpd3Qo2Sf2F+2JI+duF6ABMVXJeOXz1ZEL3
 rmQwl35GmtPWcyjqOJwwGNVltDuwOwhS9R+RNpjg7J4Mmhe1QZB+EP1uUhPuxDOYDfSI /A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3upv36f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdG5141646;
        Tue, 5 Oct 2021 01:30:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3bf16s9duq-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/yjWhGtxPOXUgMS7t//L8IRWGv5WQmUKKFubpMgDOdGV/HptvKhy85OMaYr4dAYkX/G6wouWOnynK7ilw5W/y7qteEveEmviCms8/JvebQlxKM+ekkVlnRr+TC/KUAJR5+BlK+6KrWosxStZ7K320WAZVpU638h7g+DuA6sEJwu4QZ3X+wkqakjHiPsWFzzlQwvr6r+XocG2g8WtOmc0KYacQXxxUrihauw4bP110bHKMR73gDfT3lkOPkm9YjWRbn4tIalDpR92nErUuufaudQ26cJl1CrQ07sZeLIFDm3PD9hMWBOJyBG4usmFcjuTyXvaNZthSihnl3z+TfGJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yaumyphYCyNdVnIicMMYex63o6sSPDgmUVydigwMWY=;
 b=SxGRIchVluk7Qqgl/jZHyphGRxq+ikwDohyR2w4X7t9H3VJyA+8yd46iH8mYpO9G4k2+zWGimE1QfhW20zSWw6b8vTfw1v4OKJgj6EVhlOL9EuJEtJpAW6edIe2gnxQ0pgHzwRxo47NP+YD05Q4I1SMROnPlCt5PHaMSXoKsPIptJA4zJObVqFsuVbyrwm5KDWGEK7LPG8lO4SEViqU4KK9WjIa0hPvHykuTPgG57DZsV6VXASTC9b0ibdWVDh9pxgG6u6lWLeteDHIc8XnPi43Skio8EFM1njMAdA21O823ujvE/TAbcgE+Hx92SpMs94s2beK3APY+FhBcChUkyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yaumyphYCyNdVnIicMMYex63o6sSPDgmUVydigwMWY=;
 b=KCw+UwDnP6buEEaF4Wz+8tTHsKo740n9LWqKTPfd3p2SxZenGL1nGZiuEjiQRVGjSuk1kBWmVQzJwNdoME+/+sONvDS97VpvGmUkNin3+v0GwqZNB2a1SqgEXtAZ36yBsyyATQQ7PPBoGWw6sTwEGm3EmdtzGxViL/98+BPU+NU=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:45 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:45 +0000
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
Subject: [PATCH v3 22/66] mm/mmap: Reorganize munmap to use maple states
Thread-Topic: [PATCH v3 22/66] mm/mmap: Reorganize munmap to use maple states
Thread-Index: AQHXuYieqdVoz6+6X0+LdL8rdnEJTA==
Date:   Tue, 5 Oct 2021 01:30:45 +0000
Message-ID: <20211005012959.1110504-23-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: c649e50e-f1f0-476e-063b-08d9879fc0fc
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50444D35954E192F23009E15FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:240;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8m3S4gvk6TmHCx17fGg4CAh+9pUJOh2aewDE7OxRoKnNL3fmA27R82NOdgt0FMH+Bj8LECAC09S9bzt6CIiQnlQlkO/e2UDcF1Em6u19ogCCv7jYACaqI7lxHJTvgiUZ+YqJRzMKY+TLrzcGMqyDMPKstanaFpwq6/q8Dp6+3DVhKeGIYLLqXA4zWJRnqRMgCP6dZiVJWyKuXBrYGzWb+RfegIAQDNalSte7bwMFFUGIxr0Dg0+tn2Rx8ZtQZB7aHHEPOeQzK4OE7+ElGVxM3uKWIqdinGy5RW9ckIvZoN429PuIXB1KBkakEneXC0836ke/S6uks+IjKYwoYn0iM9KSkUdatcTZiwxv7KOGH2L4O6Z6uaGAokUxWXu7+lMQ2rCbctdsZMk1+4B1UbsHmUFxK4dQfMNA2qIlmokWvdjhyeXw3HUzKkgwK4VGAS3aH+pOR8hPG0V5E+Zc6ZjktJAdhI0DZrRvmHE/KBnX8ofpodHBSib5y5qYQQxKez2Y61ZquU0dt+JMgLRVnIYg9yrw7J0KjmWhGonAaF3Wi03JmNLRvErUuQpH/mKwrsSTwV0EjwxYR3Mnjf/vMio7HUHorCXLzYQCdqpEUvwrTCCn2ICQLW69Z7MrfsL36Xgavndjoz+tfBJRZ5tMOFppjgrW7484CllytAys6sn6NH7MbVt0KUbWeGUaQkJ47pjZ8giHIFQ7pi9/+yJgfgtWvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(6506007)(36756003)(30864003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3T6kARV3YslPFMHtdT8LzsMzychGBIWlvGyT6NqwxNWN2VpzGatoA+vlZL?=
 =?iso-8859-1?Q?FuxILQqTTDyZ4FEoG9m82D0JlV+GOCiBwiu+FuXf+idekHgJpJUQIsi6RZ?=
 =?iso-8859-1?Q?Y6SBcWtCuyAiIbFfRvJNl0lZjkcg4jRczGlY7U/2wn9YVZOj4m1lYNnYSa?=
 =?iso-8859-1?Q?TZ1sWxz4uew263xdSD1dK86eFx2NcsbnOg9sRlOSogOP97oYohsQH0Eud+?=
 =?iso-8859-1?Q?Le4hupq1a8x2BSyFJAb0Wjr2/jWmCZXtLrAFcKzswHXI0uKG5qqu+ocQL3?=
 =?iso-8859-1?Q?nDY3b49wDb7AOd6Myl1Zin71tqyczo7ijwZzYZ9QaGunrDDfVRtqunofuF?=
 =?iso-8859-1?Q?RPA8uxWBbWflIuDgd5fYyiBkyXIkfsk3dTRleJzDfzfknbRPsUusd89XQR?=
 =?iso-8859-1?Q?29tuMrTAkdvBt/A9OGPF2YkFLOXXLf6qI5snQa8Uw5+Ms7sdXraoBryX8g?=
 =?iso-8859-1?Q?zGqxzS6hDn9UQcqm7xqLHdrrNhZzs1XdRTaJ7kyawYMY/HpC+o4NIRLNxr?=
 =?iso-8859-1?Q?QJbHA+zpaifTjVdtB3DT4oYJZM4/XCZPZY17BPjHwuXXZ//M72mnNth+p4?=
 =?iso-8859-1?Q?gteTEH6d8/mYu5rRr2Mf5Ba7kHWMLJzqcYiNn8Lpyweh1jG7JwHQapBxXE?=
 =?iso-8859-1?Q?ChiQY+lobBXuMdMa26GjMQjkFtEb8XjPd0RkNSrdROk7K+2zZfTDk70St5?=
 =?iso-8859-1?Q?UfwTi48J2mRZpIkYKQJjPhEx32rEoweoarCnup0dml3OBIRvXVnvL9qrQL?=
 =?iso-8859-1?Q?tfg7Mwf71wXDGbVLnabTBJse8z+b5vNkeZp9rIDNtJWCDf3XZdqgwM9+HI?=
 =?iso-8859-1?Q?+nPwqsoFnmypdvYuYUu0mj7fKNKa464h/fe8OdJImiYi5YYiJ9Htt70Has?=
 =?iso-8859-1?Q?gAsUeJDCnWuiEeOfEbT8TFVJ3o/6EAdunQuhYNa1oqXqyPQLZH1c53Mjhj?=
 =?iso-8859-1?Q?cd2FEHua7VUavyxMLCSw/zfI8NzoSJe5IxcZBoZG347+2Lr+ycan3pqPQG?=
 =?iso-8859-1?Q?rQ9gVt157baoSd7roPVDHQ+5OtHaD71ie0BgMpYj4vF7u9BBc7DqGwqRHm?=
 =?iso-8859-1?Q?TzuODJku5Fft8tHTGsq/DRGlMCEUejDVVJDDg1GBdWpXuzxlrVHe0iG8JZ?=
 =?iso-8859-1?Q?1myyOPjbLjV3N9LBPLA5HuXVePO8FNUMsaI316JtCuKXmYKaLO4m7YChXw?=
 =?iso-8859-1?Q?pAienJ+FGBUftiqCSDPnaL6KPlfodP40/BY1lNWoSxFBqOn3Ifp4DfEcYf?=
 =?iso-8859-1?Q?3VH4H+PPbyQsZPenWrI2c8q9yjPZ6D3LDXZT05tHEFMiGT4R1ls86sm8s9?=
 =?iso-8859-1?Q?az0SQBn3LuI0BHs9yHN/tLQDwbM2n53WaAxcIGaeLhSj7xuZ+pM/+l1ZMv?=
 =?iso-8859-1?Q?zowREDeWb3?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c649e50e-f1f0-476e-063b-08d9879fc0fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:45.5858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dNuZ+rMxMiujlPPwZFk7CVUIJWfL6fOlG2BUqYQX7mtxVl9cyHbXPv7dEpndjZeZuJrgxkB3OXiNyglzpTcPIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: wQIzuKmxCvpHDW7rCjMdziKkcGDzY3Bu
X-Proofpoint-GUID: wQIzuKmxCvpHDW7rCjMdziKkcGDzY3Bu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove __do_munmap() in favour of do_munmap(), do_mas_munmap(), and
do_mas_align_munmap().

do_munmap() is a wrapper to create a maple state for any callers that
have not been converted to the maple tree.

do_mas_munmap() takes a maple state to mumap a range.  This is just a
small function which checks for error conditions and aligns the end of
the range.

do_mas_align_munmap() uses the aligned range to mumap a range.
do_mas_align_munmap() starts with the first VMA in the range, then finds
the last VMA in the range.  Both start and end are split if necessary.
Then the VMAs are unlocked and removed from the linked list at the same
time.  Followed by a single tree operation of overwriting the area in
with a NULL.  Finally, the detached list is unmapped and freed.

By reorganizing the munmap calls as outlined, it is now possible to
avoid extra work of aligning pre-aligned callers which are known to be
safe, avoid extra VMA lookups or tree walks for modifications.

detach_vmas_to_be_unmapped() is no longer used, so drop this code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h |   5 +-
 mm/mmap.c          | 231 ++++++++++++++++++++++++++++-----------------
 mm/mremap.c        |  21 +++--
 3 files changed, 162 insertions(+), 95 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 21f2f6dbea64..ae1bf8087f03 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2607,8 +2607,9 @@ extern unsigned long mmap_region(struct file *file, u=
nsigned long addr,
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
-extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
-		       struct list_head *uf, bool downgrade);
+extern int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+			 unsigned long start, size_t len, struct list_head *uf,
+			 bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t le=
n_in, int behavior);
diff --git a/mm/mmap.c b/mm/mmap.c
index ec3eac307a25..25fcdf2ff739 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2351,44 +2351,6 @@ static void unmap_region(struct mm_struct *mm,
 	tlb_finish_mmu(&tlb);
 }
=20
-/*
- * Create a list of vma's touched by the unmap, removing them from the mm'=
s
- * vma list as we go..
- */
-static bool
-detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vm=
a,
-	struct vm_area_struct *prev, unsigned long end)
-{
-	struct vm_area_struct **insertion_point;
-	struct vm_area_struct *tail_vma =3D NULL;
-
-	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
-	vma->vm_prev =3D NULL;
-	vma_mt_szero(mm, vma->vm_start, end);
-	do {
-		mm->map_count--;
-		tail_vma =3D vma;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
-	*insertion_point =3D vma;
-	if (vma)
-		vma->vm_prev =3D prev;
-	else
-		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
-	tail_vma->vm_next =3D NULL;
-
-	/*
-	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
-	 * VM_GROWSUP VMA. Such VMAs can change their size under
-	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
-	 */
-	if (vma && (vma->vm_flags & VM_GROWSDOWN))
-		return false;
-	if (prev && (prev->vm_flags & VM_GROWSUP))
-		return false;
-	return true;
-}
-
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this wher=
e it
  * has already been checked or doesn't make sense to fail.
@@ -2468,49 +2430,46 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-static inline void
-unlock_range(struct vm_area_struct *start, unsigned long limit)
+static inline int
+unlock_range(struct vm_area_struct *start, struct vm_area_struct **tail,
+	     unsigned long limit)
 {
 	struct mm_struct *mm =3D start->vm_mm;
 	struct vm_area_struct *tmp =3D start;
+	int count =3D 0;
=20
 	while (tmp && tmp->vm_start < limit) {
+		*tail =3D tmp;
+		count++;
 		if (tmp->vm_flags & VM_LOCKED) {
 			mm->locked_vm -=3D vma_pages(tmp);
 			munlock_vma_pages_all(tmp);
 		}
 		tmp =3D tmp->vm_next;
 	}
+
+	return count;
 }
=20
-/* Munmap is split into 2 main parts -- this part which finds
- * what needs doing, and the areas themselves, which do the
- * work.  This now handles partial unmappings.
- * Jeremy Fitzhardinge <jeremy@goop.org>
+/*
+ * do_mas_align_munmap() - munmap the aligned region from @start to @end.
+ * @mas: The maple_state, ideally set up to alter the correct tree locatio=
n.
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @downgrade: Set to true to attempt a downwrite of the mmap_sem
+ *
+ * @mas must be locked before calling this function.  If @downgrade is tru=
e,
+ * check return code for potential release of the lock.
  */
-int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
-		struct list_head *uf, bool downgrade)
+static int
+do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool downgrade)
 {
-	unsigned long end;
-	struct vm_area_struct *vma, *prev, *last;
-
-	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
-		return -EINVAL;
-
-	len =3D PAGE_ALIGN(len);
-	end =3D start + len;
-	if (len =3D=3D 0)
-		return -EINVAL;
-
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
-
-	/* Find the first overlapping VMA where start < vma->vm_end */
-	vma =3D find_vma_intersection(mm, start, end);
-	if (!vma)
-		return 0;
-
-	prev =3D vma->vm_prev;
+	struct vm_area_struct *prev, *last;
 	/* we have start < vma->vm_end  */
=20
 	/*
@@ -2534,16 +2493,27 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		if (error)
 			return error;
 		prev =3D vma;
+		vma =3D vma_next(mm, prev);
+		mas->index =3D start;
+		mas_reset(mas);
+	} else {
+		prev =3D vma->vm_prev;
 	}
=20
+	if (vma->vm_end >=3D end)
+		last =3D vma;
+	else
+		last =3D find_vma_intersection(mm, end - 1, end);
+
 	/* Does it split the last one? */
-	last =3D find_vma(mm, end);
-	if (last && end > last->vm_start) {
+	if (last && end < last->vm_end) {
 		int error =3D __split_vma(mm, last, end, 1);
 		if (error)
 			return error;
+		vma =3D vma_next(mm, prev);
+		mas_reset(mas);
 	}
-	vma =3D vma_next(mm, prev);
+
=20
 	if (unlikely(uf)) {
 		/*
@@ -2556,22 +2526,48 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * failure that it's not worth optimizing it for.
 		 */
 		int error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+
 		if (error)
 			return error;
 	}
=20
 	/*
-	 * unlock any mlock()ed ranges before detaching vmas
+	 * unlock any mlock()ed ranges before detaching vmas, count the number
+	 * of VMAs to be dropped, and return the tail entry of the affected
+	 * area.
 	 */
-	if (mm->locked_vm)
-		unlock_range(vma, end);
+	mm->map_count -=3D unlock_range(vma, &last, end);
+	/* Drop removed area from the tree */
+	mas_store_gfp(mas, NULL, GFP_KERNEL);
=20
-	/* Detach vmas from the MM linked list and remove from the mm tree*/
-	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
-		downgrade =3D false;
+	/* Detach vmas from the MM linked list */
+	vma->vm_prev =3D NULL;
+	if (prev)
+		prev->vm_next =3D last->vm_next;
+	else
+		mm->mmap =3D last->vm_next;
=20
-	if (downgrade)
-		mmap_write_downgrade(mm);
+	if (last->vm_next) {
+		last->vm_next->vm_prev =3D prev;
+		last->vm_next =3D NULL;
+	} else
+		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
+
+	/*
+	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
+	 * VM_GROWSUP VMA. Such VMAs can change their size under
+	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
+	 */
+	if (downgrade) {
+		if (last && (last->vm_flags & VM_GROWSDOWN))
+			downgrade =3D false;
+		else if (prev && (prev->vm_flags & VM_GROWSUP))
+			downgrade =3D false;
+		else {
+			mas_unlock(mas);
+			mmap_write_downgrade(mm);
+		}
+	}
=20
 	unmap_region(mm, vma, prev, start, end);
=20
@@ -2581,10 +2577,65 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 	return downgrade ? 1 : 0;
 }
=20
+/*
+ * do_mas_munmap() - munmap a given range.
+ * @mas: The maple state
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length of the range to munmap
+ * @uf: The userfaultfd list_head
+ * @downgrade: set to true if the user wants to attempt to write_downgrade=
 the
+ * mmap_sem
+ *
+ * This function takes a @mas that is in the correct state to remove the
+ * mapping(s).  The @len will be aligned and any arch_unmap work will be
+ * preformed.
+ * @mas must be locked. @mas may be unlocked if @degraded is true.
+ *
+ * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
+ */
+int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+		  unsigned long start, size_t len, struct list_head *uf,
+		  bool downgrade)
+{
+	unsigned long end;
+	struct vm_area_struct *vma;
+
+	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
+		return -EINVAL;
+
+	end =3D start + PAGE_ALIGN(len);
+	if (end =3D=3D start)
+		return -EINVAL;
+
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, start, end);
+
+	/* Find the first overlapping VMA */
+	vma =3D mas_find(mas, end - 1);
+	if (!vma)
+		return 0;
+
+	mas->last =3D end - 1;
+	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
+}
+
+/* do_munmap() - Wrapper function for non-maple tree aware do_munmap() cal=
ls.
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length to be munmapped.
+ * @uf: The userfaultfd list_head
+ */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
-	return __do_munmap(mm, start, len, uf, false);
+	int ret;
+	MA_STATE(mas, &mm->mm_mt, start, start);
+
+	mas_lock(&mas);
+	ret =3D do_mas_munmap(&mas, mm, start, len, uf, false);
+	mas_unlock(&mas);
+	return ret;
 }
=20
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2618,8 +2669,12 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
+	mas_lock(&mas);
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false)) {
+		mas_unlock(&mas);
 		return -ENOMEM;
+	}
+	mas_unlock(&mas);
=20
 	/*
 	 * Private writable mapping: check memory availability
@@ -2817,11 +2872,13 @@ static int __vm_munmap(unsigned long start, size_t =
len, bool downgrade)
 	int ret;
 	struct mm_struct *mm =3D current->mm;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D __do_munmap(mm, start, len, &uf, downgrade);
+	mas_lock(&mas);
+	ret =3D do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
 	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
@@ -2830,8 +2887,10 @@ static int __vm_munmap(unsigned long start, size_t l=
en, bool downgrade)
 	if (ret =3D=3D 1) {
 		mmap_read_unlock(mm);
 		ret =3D 0;
-	} else
+	} else {
+		mas_unlock(&mas);
 		mmap_write_unlock(mm);
+	}
=20
 	userfaultfd_unmap_complete(mm, &uf);
 	return ret;
@@ -2955,10 +3014,10 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 	arch_unmap(mm, newbrk, oldbrk);
=20
 	if (likely(vma->vm_start >=3D newbrk)) { // remove entire mapping(s)
-		mas_set(mas, newbrk);
-		if (vma->vm_start !=3D newbrk)
-			mas_reset(mas); // cause a re-walk for the first overlap.
-		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		mas_lock(mas);
+		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
+		if (ret !=3D 1)
+			mas_unlock(mas);
 		goto munmap_full_vma;
 	}
=20
@@ -3213,7 +3272,7 @@ void exit_mmap(struct mm_struct *mm)
 	}
=20
 	if (mm->locked_vm)
-		unlock_range(mm->mmap, ULONG_MAX);
+		unlock_range(mm->mmap, &vma, ULONG_MAX);
=20
 	arch_exit_mmap(mm);
=20
diff --git a/mm/mremap.c b/mm/mremap.c
index badfe17ade1f..160ec0d05465 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -960,20 +960,27 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-	 * __do_munmap does all the needed commit accounting, and
+	 * do_mas_munmap does all the needed commit accounting, and
 	 * downgrades mmap_lock to read if so directed.
 	 */
 	if (old_len >=3D new_len) {
 		int retval;
+		MA_STATE(mas, &mm->mm_mt, addr + new_len, addr + new_len);
=20
-		retval =3D __do_munmap(mm, addr+new_len, old_len - new_len,
-				  &uf_unmap, true);
-		if (retval < 0 && old_len !=3D new_len) {
-			ret =3D retval;
-			goto out;
+		mas_lock(&mas);
+		retval =3D do_mas_munmap(&mas, mm, addr + new_len,
+				       old_len - new_len, &uf_unmap, true);
 		/* Returning 1 indicates mmap_lock is downgraded to read. */
-		} else if (retval =3D=3D 1)
+		if (retval =3D=3D 1) {
 			downgraded =3D true;
+		} else {
+			mas_unlock(&mas);
+			if (retval < 0 && old_len !=3D new_len) {
+				ret =3D retval;
+				goto out;
+			}
+		}
+
 		ret =3D addr;
 		goto out;
 	}
--=20
2.30.2
