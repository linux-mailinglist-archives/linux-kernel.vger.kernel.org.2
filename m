Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9513E421BE1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhJEBdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:33:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13200 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231332AbhJEBdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:11 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195017p0004524;
        Tue, 5 Oct 2021 01:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=L2UdrgBqe6smKDEbH387+TP8HISoi98TKLC+E5mVPHg=;
 b=PppmzHKqHnCwEd9LqTd5e1Tep7idvJg+EB8EOUzC1XMaoZJzuPanEcQIyUtUc8fvGtAb
 ocIFt9cSXStOj2rctq5MJJPLCPhB9RcGlwlwMARIODx95/lPaRc3zaFd1/v3RnsMelEN
 8T9CTswZ0+oYseR1z07gUhCnoDEjaFrlAgWL7OO0k1SX4OiZSLmSXAjJB6pzacYOm/VE
 w0aPr8BNG+sgZSCCXHOig/340rL0upEEVWiQU369oirywnBhA/4QqCMwgOlelb98GHTC
 ukREN4WgCQ+obKjbGVK7AeF4kT8C8Zy/De8u54K0uapeqDJkicaNQ4NzNSHJVwmx/Gsv zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdG7141646;
        Tue, 5 Oct 2021 01:30:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3bf16s9duq-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lf+3e3FqP/3hGrirc3G276UQIP+G9+bUlVsoVY+GCtpmdmun5O2dvGOu5gmtB1jLGJ6vjYomfPVsO7haJlzC9EjTq+8+2Z12SI0JA01xD47Yi0d9r1/CPhRQhtFz7cl5bmVfFvrQviAnqlKJhdlkv/bkjNlxUQllvypz0IiIGiJ7V9HbbgE7hU4lLCxpiGCwHKglLQCcTlgOan1QQAByHqlMVjZ/+Hdp84YneKeFNwXlqWLoptlX2JRL+XZmwxO1L7iHSGAy20yMOcGnoCHq0Wfe+bYakDnNjk1QJ0elayw/g0VV5dTf6ypSTu9ivBMP2Ec0E2yrNaOdoBB8BK0qTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2UdrgBqe6smKDEbH387+TP8HISoi98TKLC+E5mVPHg=;
 b=M7gsTNlsX+R/yH1RwswKl9odfD+vMlp/o1qrN1LG6yLAtSHF0q49zthOD6yP4QLxzqS/oLo3A11JM/6LLWxweLjtvyb0Ibwoh6pFu/e8gB0TocuZaVPhZYcvIC6BZGesV3+pxY5tOBcO8Q+7VHkYpROEyO+4k8Do9duAlz+nNtgP6qxxY6BtJWAInPXhGzBBKI09HnFZSiKqUm9yQjnRUed/8tExJc27NKFM6urb29CtVbE3ATqJqfNTOqOQ54c7yy6ReP7I3mAEsWPxQRiwq1M0oHdpHJqo7hcCEXk3GXrlFzPoHzKZB15bvsD1/zHcr489fEztDJlRl42e5s5Z6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2UdrgBqe6smKDEbH387+TP8HISoi98TKLC+E5mVPHg=;
 b=AwUMr28gakQgsddCj4s3hlkwhNsZCdXvgG/Y9kVPwlSu5jjArH2BDszpDzxPjUa5N+JaDEOai9yhyuUNlK+l1a2vXHbsmOeI34aaOc6bl9ePs09Pd7wTlxi/EfL/EsNOYjyyU0ZwJXz0SgEjK7gVUwiVnH88/gZm6S/kAmvOh/I=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:46 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:46 +0000
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
Subject: [PATCH v3 24/66] mm: Introduce vma_next() and vma_prev()
Thread-Topic: [PATCH v3 24/66] mm: Introduce vma_next() and vma_prev()
Thread-Index: AQHXuYifUrxQ0SZZNUyTxq3FuB24Bg==
Date:   Tue, 5 Oct 2021 01:30:46 +0000
Message-ID: <20211005012959.1110504-25-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 6bf61f40-d0cd-4322-5a5e-08d9879fc19f
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB504469280E94EE9CADD701B0FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:499;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Y++fANWnNZR+R+rFxHaDe7/41al71Wet88EqJCx0XUDwUOLOQqMTyAaGne5dH5Oqz5GXplfkf0dPJFeULGW9foIJPlYUAcemthWYjRh1OKYvyyzhg8Cx6V/w3yKJPj3rhshGpwJG5QRaQ0SrNbxMpVY8qR3b5uWL3QHwby0sTG6OTLjus/ocsFzW9vHh+wZVZ3367pkKPesRuv6A739W0MZNBg8WQ0pVUQ1POwJFkN5hMLt+92ps9GMe/M7/nqH7IHqNj7dQK/EJpgmOJJGF7RCFsRDj41hq9ovKApn3uIhcUmVPXcphl3CUC2wTYfEU+eyCFdR7mjXH9Fw5bOXb+BF0bXXZMXbuBXGQtStLqQINMGf3lgRT2tv6A1E5Rhd2X59VII8rb7k5Yi7rEiEdsvXb5Al4lcUn/Xa2JAmBkE6oSiEHt6TNvm0cdV+p9HCGspDCreF0PRbsRqkCjH8JdnyOWCavTGvMTbevJ83Z47PQS9b2j8Eqy2lddAgke7JwNG/5ak0pndf6mqIk9J9Dj5k7WMMHLIRVbba0m4m3s0o8S4RAkfMmfSHhd84xC1MTpqF8DvORC8Rj4ampdJQtoF6Cj8db1EMlrxEdzHQrKLpJiimRD+7kUd5xi2Sqjrq1okHz8p9Z7HOTWXeRQdEu1iU+8uhkkuuHO7DBbHzZYfv96NN3HkvsugVhmcYJAutX7GACfj/P015SHCTVG3LIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(6506007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NFyBI/mouDcJsh7JfFXULPtOk9ZKtBbJptc9eBXS0F1UVrxEGTQfOK3kKn?=
 =?iso-8859-1?Q?ecF8at2jLcC/ykSbYXCZI0QLXW1i1euBGGvYSceYcWzQG6anAN0P1IlsBX?=
 =?iso-8859-1?Q?EoDh7Ch/9HiwOMjBGm6Od09FAZwOd1gHzxM6Fyg4lwPPtOBoB632GRbicc?=
 =?iso-8859-1?Q?8yFAJ2fZ2siTPDAiKBFDmaI1KDWe3q1i/2YadGnGVwbKhe3T6HyNbCy0Kn?=
 =?iso-8859-1?Q?apMaLVYcI8QsA4vnZfMCqcHTpkXck5nwTX3z7AOBXBVpjgZX/7USbPTb3z?=
 =?iso-8859-1?Q?ceKuPGwcs01JfQ6RHoeSuW9WA2VGrBnbFNmaj/VnythXBK+F8j3NabkQ/+?=
 =?iso-8859-1?Q?jpUXWOsNfeBFeSSfeBgA9Bx3aFLfK2hI3YrYuaXIoCIB9N3YTkCXO0jjs/?=
 =?iso-8859-1?Q?quHXQ26UMjWeOQJxQCbJiSTGfO5KQTUeIlD0ZNOKc9OmBG7zS+2b9eBxz2?=
 =?iso-8859-1?Q?ETiZuH7mf7KHg2q1d79tEsprZZ+WNRhKRxdMWa842pMntUib7t+Q7W5kNU?=
 =?iso-8859-1?Q?jSCDpCQkEwOfEPBmqQqGagfwbPsIm8XzHmLzgQneG4zmazbZszWVo+ZHIA?=
 =?iso-8859-1?Q?yb7ibOa5JxbIX4aK6szdVwGk4gNwWsTfTClnRscyp8roJMReixnOdQZLRu?=
 =?iso-8859-1?Q?ptSIatEU4DgFuLuNdYjd+eZABVOGE+DuIjcO/wOIk9im5hSVKN97+7GB0I?=
 =?iso-8859-1?Q?dFX3KB7JPCq2Q/DGFnUMkByTjPMFf5m08k0e8OA3bhRsDboJhWLwooUkV3?=
 =?iso-8859-1?Q?p1WGc6NVQW5vV8Csb1Xwkl4OXcV7WQhO6ACe1HlxCq3DWag9lPS9f5ZG/1?=
 =?iso-8859-1?Q?FMlclcVohGuZZxqkj/+iNBKLxHVhkL3ADPULkx6AKPAvdFRP2dvxd1MM7T?=
 =?iso-8859-1?Q?vt7NHqh01kNr8gxnYpzEAh17/KoQR3EbiQgBCEbp19T6ga3hkolCP45InP?=
 =?iso-8859-1?Q?TG15rEOy6ZCRuACki/Q21/QFg/wGP29R2iqz0NuGcFweqAFTNYxPYH7YJD?=
 =?iso-8859-1?Q?XdZMDR4bHndkLPNWIodRFV7Ma+OvcnZf+5Oiy67mb82UIl4OAev8XKc3P9?=
 =?iso-8859-1?Q?exNtxPC0FIHwbNo1UIRycZl9JAo1av2VLNNlx0YRkOohVNu3Jg1TskLl4x?=
 =?iso-8859-1?Q?tY5dla/cY1p1Me+vjgsGxiJWvxFaNFik/PdLvdroh5llLo0KJUdXwJxk3b?=
 =?iso-8859-1?Q?cfaEn07guUdzKc2hvOfb2cW08WMZ7gBleCSnt0Yy+fciWYe/o8aYac5VLW?=
 =?iso-8859-1?Q?FGuToME4ne8qxxYcV6fylY3yUs8eQPKTO4+dAVnnj44xbWGQp6hJpwFuuf?=
 =?iso-8859-1?Q?HeCeZJuY0kBZpTBPrHWo/CAsMXy1bO+a4Qi+ar4NwWBdRG3FWKo3x0mcln?=
 =?iso-8859-1?Q?qyaHMpPPQe?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf61f40-d0cd-4322-5a5e-08d9879fc19f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:46.6562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icOyqJ9z7ykIfq4NziF0cGQA8WErSb8rWV8Ed65mMEjfeUdR2AmsJkVRydBmy9IgPT7/eN4ISQ+I64SWuaXb0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-GUID: mCSmHS7jPx3xrPNn5gUER0jsNuECc2Ne
X-Proofpoint-ORIG-GUID: mCSmHS7jPx3xrPNn5gUER0jsNuECc2Ne
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
index ae1bf8087f03..68e315cb1056 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2701,6 +2701,18 @@ struct vm_area_struct *vma_lookup(struct mm_struct *=
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
index 56da5a23e293..9b6765db14c0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -483,7 +483,7 @@ bool range_has_overlap(struct mm_struct *mm, unsigned l=
ong start,
 }
=20
 /*
- * vma_next() - Get the next VMA.
+ * _vma_next() - Get the next VMA or the first.
  * @mm: The mm_struct.
  * @vma: The current vma.
  *
@@ -491,7 +491,7 @@ bool range_has_overlap(struct mm_struct *mm, unsigned l=
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
@@ -2339,7 +2339,7 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D vma_next(mm, prev);
+	struct vm_area_struct *next =3D _vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
@@ -2493,7 +2493,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		if (error)
 			return error;
 		prev =3D vma;
-		vma =3D vma_next(mm, prev);
+		vma =3D _vma_next(mm, prev);
 		mas->index =3D start;
 		mas_reset(mas);
 	} else {
@@ -2510,7 +2510,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
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
