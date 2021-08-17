Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16233EEF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240444AbhHQPxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:53:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:18340 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240213AbhHQPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:31 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkIpL018121;
        Tue, 17 Aug 2021 15:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=oZPLwy0P8RZ349SzakKNUlJ46ITXRVTdf6QA59VtPkU=;
 b=k/B5/f/ul9oUyo2M6yKdg7EWGt1zwt74k5cOnIMIJYqy05cIpZsJ1qyK/sPhhKpX2BKA
 aH7YFPQVIJNal5b+3B1gpYZMKvo7LCZkHk2t81wjV2wekThxeE/txfPolxwJ4bxwoTof
 1qBDTvTriecSJGoNqer/h1/fdPlO4olUcOh8yIsThedb7l33oeCGToXFpGh2EcSPm9dE
 fxwOqQvEMj8e21Q33ggBxBTQAWEHGwvkdmA7hTuFzY4kueFvAiBYBKtuxuwtSBK8Ze7Z
 0i7vR+HEiDXh9+EqUydIBxrae1lvvzmu5Gmaqy08S2UXhBzmabtNeJoS0qQxSFmDvxSH TA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=oZPLwy0P8RZ349SzakKNUlJ46ITXRVTdf6QA59VtPkU=;
 b=NW6di+aTPEj5DYCrDam1ZhFfSKNIhyGVlrcMDp8aplBzVsSuLTj7/ekVA8XW1nqvTXlj
 Aos8Xo85nFYx1tLCgGCXZ2PYIagQR9zdWbO1KTomIVuhQkn2MKh2MHoQoDP9eKUHqymA
 VoWRFESs7cjYLU4/Rq/yJGUUuGUpTx56lNkCKbOkaa6CYWMdkxkZIMneik68l6Eab6fi
 cx7F6Uoqz3mQOq9/oCXGrkFKgxzj7sbjFmV/4pGcUEnZwz9F9poFizKK4L1up8QesWRF
 HDVVYs8hlL7rVkkW6XOBZs+BYUJVB/Xf3sKHTbi7e52IXCaMW+id+dBM5uUvfmmeUe4Q Bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7mrc3k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFksAk094402;
        Tue, 17 Aug 2021 15:47:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3ae3vftdbk-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AvuuB5Rug74AGRRg0Fe0YIg0gUyL81vtzd6ZVSf8HZ9eFLKb2bS0TmnEBzytBjWIP5b18Yv2fBGquHMBKEsJVzt/U7KR1+B6ZplS/MfOODM9lMKVxdxpTYA/Ugd2Xvw67fobmSQbGY208YEIBeYOPJ5v3IOg9o0Od7g6pPjPO/iVu8+uKEkWP97qd1n6xgV/yuWhp7Y/y1NDRNyYJ9Sap3LetJp8V/AO/D1PqhLBsDwTH5gOZV0jxYEjfUitxoBIsFMdHzMO3+AOFGIGQdqMs1+RMzTI1/Lnz5b+hrskQKq18pb54OMHgrALJbegVOsWVWssko3I3VQrf4Skuxxy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZPLwy0P8RZ349SzakKNUlJ46ITXRVTdf6QA59VtPkU=;
 b=Ayan1Bw69pH3rQeFAEgbcGYToVtvIW3XTgKpsxrtoIgaOJA5xtiHhCNoyYNwvDu/sPRSB9bIqED0No56HLfo4yHI400yu2DLc4sMvPBLY/BXjWTqPyMHEKYgjMy9aW41pE7hppNoDeY3rsjV/HH7cKSiAT50PjP+zA38JN7hfA3/fHyeCFH74VDbQcW8mzEMtpYbFfaDM4KXw64+HPTMwqGEo1UYuymm0b7Jg5alIk2UsH/5LQqJfrXikHeewbT5CWE0BgD/89UYKdypRYDl8QowYe3i2aW+S2S4LcTrCBV0Ap84rEuYak6Z/1yvKf0UV+M9ybdz7g6csVCAnqsaXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZPLwy0P8RZ349SzakKNUlJ46ITXRVTdf6QA59VtPkU=;
 b=GomgtkU6LtDrwzwtRdX4iEjfA0eEgDYsj6+PVpd3XWn9XyznJOeOfTExCJYA4yltLdJ/8RMo9fYbsPlB/3kogS4gxr2A2vlwIFNUaF2jDLFB+aY1YSXgWJ2Hq0R+iBfgzn7F5mgdiWgcrNSuE84yt8LWUSt1oAXAuzPHAANgrm4=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:19 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:19 +0000
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
Subject: [PATCH v2 23/61] mm: Introduce vma_next() and vma_prev()
Thread-Topic: [PATCH v2 23/61] mm: Introduce vma_next() and vma_prev()
Thread-Index: AQHXk38pyokGYWYjKU+DXoz0x15oyA==
Date:   Tue, 17 Aug 2021 15:47:19 +0000
Message-ID: <20210817154651.1570984-24-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: aa860c7a-53e1-45ec-ac15-08d961964b9c
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB423631F34BBA026929CB7BCEFDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:499;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yTX8N26yBjrGgRRkaPxJluCru8eajThwv5Yyi5XDEw9jY+G67DP7ibxNT/8B4o7zphiYNh/QJ4g8aAhIyJ9qN95wdvhgmv4Hxh28pyQxCE5bN1rmjBbBf3KHmKLsnqAMTb671vmHoJ1kXyxI7tmCfpeNXCIHU6DVicDUlnUU5TErVFj29LQ+KTHhMIttMm3raLn/ZfT3B1wdXEQ+En24ulGQ3gc+NwgZemZoJST8PmDYTz2KTYR80rwTmMdCyj/DDR+CkloluVBlmNoUnLOyc+512FeotZBvYX7QXHtbWEMTcfcsEROYLZ3oNVtLHOJEI2A4GZGAc6TBLauDchkEIBsL8owJL9zhA/e3aWgfqBRa02deJ3r2sp4Pdam6x/Qd9hAy3w27zPmNj/EpUGs5TBaVqdxUgfvn9lHIbMAqsGk44JBWNUcSVCgfGeZvLE+6mvJuPLpiu92THs8bsSBavOxonU69XxqcQF5GUos4DHCpeRTr54yYPmSbwEuYT/mi98GQ/lK9YsBeVK7nIRJUi0C2Sq6GfyE0s5t7y6YR3VC8EJvKDi2+1UoBx2791iVWSCEY/5Jj4iFXvLn436k1YKru5npV6aaAU4fquG+xwAtbMZ6ljmWegCb2gvOq8177tXkKLt2m0kCTs/X4APrhwiDO6TyvKaKEnDuiX/ayecJz2D4nrZblI645lwN8/5Klj2syVL4vjGJH1ybSR9o2xA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+Rhi1eDl+e6LjBHey31hOLi+vGnRF4Dkv5qwB4G9ISKwFMfdgoS5pz6Gh8?=
 =?iso-8859-1?Q?IPJY1/wZFBksHx0XCwGXO49XKbkpevDUQSOvep4NdXfht1aWrZnW5neSSc?=
 =?iso-8859-1?Q?G0+YFnmRaWefHxbzTCLv5wHrgED3m38ABcexCWFFMjSvayr94/ZE4cGXk+?=
 =?iso-8859-1?Q?Srq4qR8j4S+kqYwFtPci4LsNSZJKqmPbQcqT8XmvdO/X+0n1P/0PbXMJGp?=
 =?iso-8859-1?Q?QytNoNya3REoUQ6wd+5qpHopruu9MC65TrBwWZhGYtxJ6Oq+bgmcmdondn?=
 =?iso-8859-1?Q?2Gdu/39atnkpVdbmEHrV8vl9j8wR7Xvw3eJtU6FBQoFl0szrZ1rrslOwFs?=
 =?iso-8859-1?Q?qRUnK1wq8iVEaJWF9piBhIJmg3hFQO/FjNmQMfF2UVyd4xhbGLUG5rsBLP?=
 =?iso-8859-1?Q?R5aE/allZZanNdSRG79/uM8EOj7B7ijYpcEfKPdUXbsB7BvEK8dLzfMK/c?=
 =?iso-8859-1?Q?mfgWOtZJ/5+KDDJnYqiubTFQWGXQGrBzFGjhbtAf8zUV2Wx9/7lQQFduPK?=
 =?iso-8859-1?Q?XqV0nH0vmfbhwi3FXl7fvD1dADv/tZ7ULVdqI16+wT1q6YQ9I/AIBwI0qr?=
 =?iso-8859-1?Q?wRw4kH0gh364R0/hnWTCS8Op1l75GebgeO5oz4B+9ewfu1ySCg76xgMW0z?=
 =?iso-8859-1?Q?VEDE3Cekc+MtyiZmf4dyoZHdtMM3xfO31vvBHkyPyaUzUeBTHxLhErnopG?=
 =?iso-8859-1?Q?9CLRJ2foFPfJiF/5lt6Qk3IDE1tFGgY91godDogZcuKrCqalqoliDfw2Q2?=
 =?iso-8859-1?Q?XO4fNQj0ZR8REmEBOpDR5iHvASpC8GqZrBfBy9vM4uGyjTKZsDxR/6tJaS?=
 =?iso-8859-1?Q?ByQx1Cjj3Aus+lHAC9ZsYuRDJ+DrQ1De/YbJTUsgLom4Zqg7+atavcJlwY?=
 =?iso-8859-1?Q?SNM0VYIX0APQV3g53At3KUj4Ffd0rOo1FeLpRTl3gi36oBZhSy8EpSm+Cd?=
 =?iso-8859-1?Q?DBmOBrvSGhUL+LqTZxrIFNQ8Ut5b3T/k6wTIhFQWoA0R6XSQJM6KkyVaXl?=
 =?iso-8859-1?Q?0wFcbQDSaGMuEZottbp6gmt+CSpKPoUISCu1JpTH4JjQ3Bao9q9B/96q5S?=
 =?iso-8859-1?Q?tjK6Y/VjXjD3/vtDUqutQ9doatCPN9TnmJdiETFKMmKhuJ5dhDn7A5H1Ru?=
 =?iso-8859-1?Q?+vccJXXHX59ntLbqtcMcdat4Z5LUyaHInuirR1vYNPAgFlCZXGtPdOyrNW?=
 =?iso-8859-1?Q?Ghuy4x9QDK7kexTC48gLUQB8N0YjqPoSOSrw3z5XDez0neWeiVAZPegEUw?=
 =?iso-8859-1?Q?rph9okOGjg1ARGN6WN3cB5DdsddAbbwwBfbjUGkfXH1NdcWqT0pFs80BAF?=
 =?iso-8859-1?Q?12eaXoohrN5Cn4ba+/q57QfL9d89d+VJzkjU0KHcMOKlOvcyI7MGzyyISq?=
 =?iso-8859-1?Q?ZnbblGMVGK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa860c7a-53e1-45ec-ac15-08d961964b9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:19.0705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ErCN1jVEWNLIN3XWPXR6QekXU1xEu7460kCXwRUTx/HH3gQOf5NgHACevbT6grR3uhZu+pSHPX57QRlEG4VyaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: Xunc1ZRCdilhCVDOI3tIh4lTedPAkjwM
X-Proofpoint-GUID: Xunc1ZRCdilhCVDOI3tIh4lTedPAkjwM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Rename internal vma_next() to _vma_next().

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 12 ++++++++++++
 mm/mmap.c          | 12 ++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e14d07649007..7a5eb1fbb488 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2796,6 +2796,18 @@ struct vm_area_struct *vma_lookup(struct mm_struct *=
mm, unsigned long addr)
        return mtree_load(&mm->mm_mt, addr);
 }
=20
+static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
+			const struct vm_area_struct *vma)
+{
+	return mt_next(&mm->mm_mt, vma->vm_end - 1, ULONG_MAX);
+}
+
+static inline struct vm_area_struct *vma_prev(struct mm_struct *mm,
+			const struct vm_area_struct *vma)
+{
+	return mt_prev(&mm->mm_mt, vma->vm_start, 0);
+}
+
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 {
 	unsigned long vm_start =3D vma->vm_start;
diff --git a/mm/mmap.c b/mm/mmap.c
index 150d9e9c0a68..afef4af1c621 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -485,7 +485,7 @@ bool range_has_overlap(struct mm_struct *mm, unsigned l=
ong start,
 }
=20
 /*
- * vma_next() - Get the next VMA.
+ * _vma_next() - Get the next VMA or the first.
  * @mm: The mm_struct.
  * @vma: The current vma.
  *
@@ -493,7 +493,7 @@ bool range_has_overlap(struct mm_struct *mm, unsigned l=
ong start,
  *
  * Returns: The next VMA after @vma.
  */
-static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
+static inline struct vm_area_struct *_vma_next(struct mm_struct *mm,
 					 struct vm_area_struct *vma)
 {
 	if (!vma)
@@ -1182,7 +1182,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D vma_next(mm, prev);
+	next =3D _vma_next(mm, prev);
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
 		next =3D next->vm_next;
@@ -2347,7 +2347,7 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D vma_next(mm, prev);
+	struct vm_area_struct *next =3D _vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
@@ -2501,7 +2501,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		if (error)
 			return error;
 		prev =3D vma;
-		vma =3D vma_next(mm, prev);
+		vma =3D _vma_next(mm, prev);
 		mas->index =3D start;
 		mas_reset(mas);
 	} else {
@@ -2518,7 +2518,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		int error =3D __split_vma(mm, last, end, 1);
 		if (error)
 			return error;
-		vma =3D vma_next(mm, prev);
+		vma =3D _vma_next(mm, prev);
 		mas_reset(mas);
 	}
=20
--=20
2.30.2
