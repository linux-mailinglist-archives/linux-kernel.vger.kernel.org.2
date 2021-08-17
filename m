Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483143EEF99
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbhHQPyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:54:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28172 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240225AbhHQPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:31 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkHuB018094;
        Tue, 17 Aug 2021 15:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lFN6cz0L4kJYcKyH7DuNJtczGX3JjGNlsNVRiQpVLVU=;
 b=IsDfAsbcBGP98IaRjcTkKlqK+apg2hc47JptusK2el3x27SN3JFQW4AZrei02uJtrWaQ
 ijHSM9czDrn62dwXXkULVt8iPh9oVD/x4xUHf2RNocgjfRNx63AH7DUgYpUC/M9O3R3e
 PrI5r9bcyUTQCWkDPnqNbSPF7XHa4y73BxJ8bYSsSJXGxq94GkkxV8TdZx8J/KQwi+nJ
 At5+tEhQmdAfC06sxjDkPWPzaFeUUWSXqthagGtcCflpEB1IhklHa7xzb4Wisf69MO8Q
 5n0wz0+tFhSw83LfhqgHYx29g7mrBjLHmqYgfG4c+ZpbPkvghS+j0atNTrcbAPU+WWdm RQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lFN6cz0L4kJYcKyH7DuNJtczGX3JjGNlsNVRiQpVLVU=;
 b=AZMraIVzr31noRLMBd5U4oYdUaDXT1MIcXT0qgpFqgYbEmwIDOT00YvssFv+S9w8g5E4
 C0hnHL0auu+dqASyZ7KNImFgHkl6wxONNfOUbL71Onf/KeE31S82hpHE30UVGXimlN9D
 n0NxGMXkGv0BYBtZhwtNeLIdo/ES320d7I/0tFh+e09Ee8GXJe9MXRneDdaR7VlSD9Fe
 5bXv8pbXB8K+G40U+juI68VSRR3AmxYNEkF/0RkrbHuptaLOCr+ZmoPdDvcwBM4bFcC1
 HVWkZXFtY7yz95Mk0Hqep5aE4r7ofdR7kGoJZu+C+HlaCFLQMuQntNrD4FyQoIF/GREM OA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7mrc3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmf8158706;
        Tue, 17 Aug 2021 15:47:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3ae5n7styr-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F7bSX3zLkD9SAWV6jCr3NG/wsGTdTJ7TRUzgn0SGA/04KQSoMhvmb439aVxamxWul/1ZV58LlTGhQgcBxlEAE62VjxDY1FYRmiVkOzETGx466BPnbOn8fErZTxQjBY9Ic0diNlcpuNTGnsgnJqSriBlHZOujws8H1sXnZhrQ1dydeB67qgseLUwAP2PPCBSJ1kjdRVPtCbMEmXukhgtsIcCPMUUPO0AMNQG72+tBq+nVzLxuHkQrFNCsdJZMsdQolTtHNuPWojTAyTzNkE0tlCDNaAEWC8q+BZxtdul3vPYifGRSUUSlx+Lv+s38K9CJulqonqiythP8haNhb9yQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFN6cz0L4kJYcKyH7DuNJtczGX3JjGNlsNVRiQpVLVU=;
 b=eoPMAZv/y4Kq5s1ooVVx0pMakZrAc3y+o6yosebNb7MSnxMnc4NM1nG9JuNlW4GwYdiELVX7hjhBD+KcbQOtSzEgWJEK/371T4wnRZqXCaW+LTPjyLa03jiGNSfVgPAemIxz6BjG6CM6Enw/rAgCKjJz7vE9bEk8rF54tXlNV8Anejc33T0IKNtr4Y7s5nHKpafa27+XQRXZZqJ49mEPIfn33RltonMS/GxDaB06UKxsj2MEguV5LZeiv74PcJYfOGSLkSPt/FOhZ6ZSU7lFjozEKiJ+gmiMzNwanFhJwQWzMoL1iA8tU3/q3mLaeQ5vNSTxv0CVlmk2AgJapKhiOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFN6cz0L4kJYcKyH7DuNJtczGX3JjGNlsNVRiQpVLVU=;
 b=Zux0RoY4nRV0CIR7qwJrqYGkNrDLH+tzCalx6knOepeFX5CjsPG3ynO8ZvjptKUW9W5i32NoRm/gWd3oU7wjPRcCjg7bQm5Z8WWAN/bI1HKQ+cFS8Y6+mqQklthW0mIdWEHV1UAAyuaionae8Vdu1ow2s9YVi/MpknCfPq3DD0c=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:18 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:18 +0000
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
Subject: [PATCH v2 21/61] mm/mmap: Reorganize munmap to use maple states
Thread-Topic: [PATCH v2 21/61] mm/mmap: Reorganize munmap to use maple states
Thread-Index: AQHXk38ozEr3pHtkrEuZjGEVJolO3A==
Date:   Tue, 17 Aug 2021 15:47:18 +0000
Message-ID: <20210817154651.1570984-22-Liam.Howlett@oracle.com>
References: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
In-Reply-To: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ca9fe3f-dd72-4452-6556-08d961964b57
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB423623DFD5C25FB359FAC669FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:240;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l2dU5D+nT1PiIYfJdZAeQspw2gjWEz2ub0QSzjQBgWa2XRsykSDXdgAlQltXcsnYCwXtVp6AAVL1BGtWOMJ10CYVMbTqktZcmm7iS/ZBt847ch6NSo44ufV5RK2t90RMrUk+F2hu9LNeM3wjtkGgs52NK3epRMWCk9A6n6EbBuqwS9AEhFZFZNYDt5exxuEBdwAlzG3UF0sv9g3gvcVEnr4MkwjmHHwky1KSfCQ92j53jqnoQeyABi5BZn0XvxF+4SfweLfIHsOoW7MbdIZjlILOHqkZEmoALZB9uktiJvlQ+qwgwGhXaqjvgUFpfaija067pRnUSgPBy6VdJzfbZhcGyLYsLcXl34z+qKFr1LwgqbXY6abBJhpklhxJGERaV/3QWAlTsJpgE4fjLBg1IQGvowk25Djo6pJaq/BPL0Lv+PyzMo4D59tGsS2levDXb8bCi0YODc7MzcdYNH7kF+uRHbOHH4C7SiW2tIOE1LVbUQdQf2H1/JgFh3XvLpqevOoU5E1EWoDfwVxtu3mFQ7Bb4THrFMGBh0J637/+eeShiRYl/KosNyzb5gKXxVRkiRqRsVJmTONWAnW2Bw3gSnmR1+qiSd5EKM5B4jDX1rfur6er/3nwl2yBV7Horg/wYlRdVFxjYEMLQ/vLYfq8EO0B9xrTtN+2gtExFtjC41KRNsWt4smRAFnRLyVjfqWl1xk97UZb65THI9JixSrinQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(30864003)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RGfbc6fZgjCGeE364tTH6OBRX0JeXKXC+5FvQHJW7bqUwUpSDFAkP7QPpt?=
 =?iso-8859-1?Q?ZhAE4nlcKOYr7J8NeN02nEQzbVV8mTje5EeN/AKtZ9reTonPkPYeiQ6GO+?=
 =?iso-8859-1?Q?MOYpPFg7f6MJGjgnXq8ob9sbcRI3cwg4KvzrZKmuZk6fls9xtEVWOLnPi0?=
 =?iso-8859-1?Q?ZTFMsEV6yUbjfUnpzZ1qcy7EyA158BywClCwAfOf35263z0An665gntq+o?=
 =?iso-8859-1?Q?c44Yf6NRKBVjppOmfWwx0fH1aLF/lK8ZdRluunxSHgIFAvXeb5DYf6UTWO?=
 =?iso-8859-1?Q?Ig4g3XTROShVDtZveAJ5oGJ5bF1V2LvkPY28+MiASVgDoZJbF7TAiOfpN6?=
 =?iso-8859-1?Q?fTx+QwZuqMUu3saECupraoEVJqskN4Rk8pH9hC6YjOxGEz3wS5KxgAr8r8?=
 =?iso-8859-1?Q?xc7o4v9aumXLEKI2T5KbzvBMM3rzSaNc4EtyEkU0/jILfgKH/DjZ++N/Oe?=
 =?iso-8859-1?Q?FtCiBQx2AadDWxdJkjdBQ1HdNl1bcffVWotOYdRpTUazHYdAvmM1ZhPil3?=
 =?iso-8859-1?Q?5D4jT1WhD12Jq8G5/REcpDIg3S8W5aeRmVWYO08AC2Y1IcsxM89Ad6n4H4?=
 =?iso-8859-1?Q?AYCYR2KOFgZsL05ZEpq/J9bg3EdElTXRfr0zipGoPgV7mgIlHKCbSMLhRq?=
 =?iso-8859-1?Q?GA1y7cdR4PA5MtUpNXcDQKWbcXnMSJCNdaYEFw9waE96hP1B/bEiB/ArX6?=
 =?iso-8859-1?Q?triwtzsk9iGf0QkRhBmXHcbQOJ8pCm2pTsWSrUABmSCp9Rn8hurPCZbn6b?=
 =?iso-8859-1?Q?pub4A5lE+oIWcb/L171QsKQVueegdWH/uVAiIMyxElMf13isHkgSOjjjcd?=
 =?iso-8859-1?Q?vjyN4/r5Idy1Y8wnetAS/8qaihyO+pOIfp4SVlk0Grygfw12QnRXYx1Cmi?=
 =?iso-8859-1?Q?Vr4AOaCYQed4k1NwqACwbPY245u8B+MyYkyf/PPtY+ivTXX5uIHcPINXEB?=
 =?iso-8859-1?Q?qKNUNt/zVr8Mj5dSVNFR85lk6i619o8FDDcDCym9XP2avVX0FN3XFqTHIJ?=
 =?iso-8859-1?Q?YYUtZXELaI7yVZqALnKtibHVas/wEAwvAgt0Ep0AgIUpPK+K6jFYA5KW4I?=
 =?iso-8859-1?Q?aaLsEEy/r0QbMtqH0lxb80EGutefwN27lV5hnUji4MGGSQmB/CMgydrxPk?=
 =?iso-8859-1?Q?AGPXtKuywPc+y8GWsMsYWNw9PGl2UM3cIkyzWNnMR0OWjBxRarx2YoDEA6?=
 =?iso-8859-1?Q?uHtnWGAxv8TSS/J69K0/vVtijNvLi0SPbNMZ5pGw7Jq4bioJ+LoIWrlQSx?=
 =?iso-8859-1?Q?2WuLCVjZJnn3itCFhYUMJu4tCHw2jL155FGhec+A/5yU88wfNI4k3nfafb?=
 =?iso-8859-1?Q?nEiAekZi1DCh/8Np0u+m4KVVlCGD5F+VV77w464GM6+aTCoZgiTjnfGZw0?=
 =?iso-8859-1?Q?spUsn7fTE0?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca9fe3f-dd72-4452-6556-08d961964b57
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:18.5159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCf+Ixo/hfNPzHmKYnEZHrScrCQIKjnOmdBC2rK7JSTOoQUonTvFm3Tp6tq2HyAEU5k5MySQ+ziEeZ4bBORqmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: sw0xwCSsouK-dpx8jXgW69w4J2x3NZcM
X-Proofpoint-GUID: sw0xwCSsouK-dpx8jXgW69w4J2x3NZcM
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
 mm/mmap.c          | 212 +++++++++++++++++++++++++++------------------
 mm/mremap.c        |   7 +-
 3 files changed, 134 insertions(+), 90 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 10763bd6fccb..e14d07649007 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2702,8 +2702,9 @@ extern unsigned long mmap_region(struct file *file, u=
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
index d01659a64b86..4fdeed164381 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2359,44 +2359,6 @@ static void unmap_region(struct mm_struct *mm,
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
@@ -2476,49 +2438,46 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
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
@@ -2542,16 +2501,27 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
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
@@ -2564,22 +2534,46 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
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
+		else
+			mmap_write_downgrade(mm);
+	}
=20
 	unmap_region(mm, vma, prev, start, end);
=20
@@ -2589,10 +2583,60 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
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
+	MA_STATE(mas, &mm->mm_mt, start, start);
+	return do_mas_munmap(&mas, mm, start, len, uf, false);
 }
=20
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2626,7 +2670,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
 		return -ENOMEM;
=20
 	/*
@@ -2841,11 +2885,12 @@ static int __vm_munmap(unsigned long start, size_t =
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
+	ret =3D do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
 	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
@@ -2979,10 +3024,7 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
 	arch_unmap(mm, newbrk, oldbrk);
=20
 	if (likely(vma->vm_start >=3D newbrk)) { // remove entire mapping(s)
-		mas_set(mas, newbrk);
-		if (vma->vm_start !=3D newbrk)
-			mas_reset(mas); // cause a re-walk for the first overlap.
-		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
 		goto munmap_full_vma;
 	}
=20
@@ -3237,7 +3279,7 @@ void exit_mmap(struct mm_struct *mm)
 	}
=20
 	if (mm->locked_vm)
-		unlock_range(mm->mmap, ULONG_MAX);
+		unlock_range(mm->mmap, &vma, ULONG_MAX);
=20
 	arch_exit_mmap(mm);
=20
diff --git a/mm/mremap.c b/mm/mremap.c
index c0b6c41b7b78..f48ccfcf3217 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -948,14 +948,15 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
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
+		retval =3D do_mas_munmap(&mas, mm, addr + new_len,
+				       old_len - new_len, &uf_unmap, true);
 		if (retval < 0 && old_len !=3D new_len) {
 			ret =3D retval;
 			goto out;
--=20
2.30.2
