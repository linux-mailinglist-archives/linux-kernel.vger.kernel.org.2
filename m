Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC8D421BFE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhJEBfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:35:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59104 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231840AbhJEBdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:45 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951FsWk010243;
        Tue, 5 Oct 2021 01:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6CHDmO6c+BrstRVpzSbkln27992djVTS1blnPzCWFGY=;
 b=AEZyFm12WOPbPd/GHSJp2m+gaOwNlzGO9ZTGqFRPUkkKCVimHPI7ZQxBT6wTNfNDzSj0
 +8Mk7U8H0GkPmxN5aWlaZCUk8Uz2RfDKbKTrfs3OWRKppEJzLF4KCcbQrc9WW2KO6s7/
 s6xppNcPHhUFzb/I6J+l2X9qahjRTDGV08owwy0KdP5KtShd9DjsJC6NYP7y3zxzLnS+
 kVepRmGwuFDWLZaoFfJwVMXYbgJ29cGts06D9AsSC91jl7q8Vvyac/Hb4nv5IpgyxM1V
 MSF5y/oT5zFAjxSGpbGAajtT/jSn8O/x8QfwIQzydE8NwuuI054ej+8IAeh+7e5L9Oc5 Mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3upv368-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdG4141646;
        Tue, 5 Oct 2021 01:30:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3bf16s9duq-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXBiDH+asOC44mCDRcB5ezk8ck01rJFkZmA+cSR1fjF+K5e9Gck7kYP8AnCo6NnbO7Pumh12ziDp8+PvkezaqIB8W42gMTwY6lM13rKAACSvovYH0ZK2vCs0Y64XnceBgWhZKYv+CcZwvuP5U4QEmZYmNaps77dVvdsHXMI8KsEwKttLAdIYPYyxxFXpcVwAnRn2JgtCkbbl1NOHG8HIrxCGHTqWXw5Oaii0sM07iBJ5kdCAGPfMURurTOqWlMxlgLbyo/bN+rEfcJCUHqrYJvl/DrYmOUSmNn3G2rjITJOLoeOrHXbLfj328iNNQNPwsmTodLEXNt0e88Ibd2EJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CHDmO6c+BrstRVpzSbkln27992djVTS1blnPzCWFGY=;
 b=LzPXAFo4/M4VQ7hl8pWVxPdeyQ9dwOQi174XhtcXVx27R8ERUnTSV8zNJXe7vrGItjv0YC8CLwNH3Z7BqYbGtZfQkXCn5C2kaVEAAXzvw+vZXohZA0WycHu//yGb3I69X0zg+JzelJfeqSOOO3vWpcRKtaH4gX01sAeNyzSmd2kwG4AMl21SMDqxHk4XZ+kLvJ/kP9q1VDEkzPxV45CGQzPP5G20NDlWp64l3b+RdSkbDocsg926L8nD70fF9OMO2Ej4DAxJISaQyOzMYujeVmtvdnKuwlhRgmxOhSuzjBvAQXh+LYufEnjqb2Zw8qwI/uTIlvrSt7IvLuI4ls2ETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CHDmO6c+BrstRVpzSbkln27992djVTS1blnPzCWFGY=;
 b=dXWVXRcUkMEbYb7N5vbX9P0N59bET7uTdQzEVOpS6NKbysVRWIBmK7ef2tvOeJEGwSMQDQdKlMirNlAfvg2WOVft2VWs6uzhjih8Bv1Ket2HsENOtpISuZCDd6AAX9xOQqfTS+6unmHQnWcy39ojtvVvatFAkulweY3UNnVrKPQ=
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
Subject: [PATCH v3 21/66] mm/mmap: Convert count_vma_pages_range() to use
 ma_state
Thread-Topic: [PATCH v3 21/66] mm/mmap: Convert count_vma_pages_range() to use
 ma_state
Thread-Index: AQHXuYiedkZeyGaEX0KDq4CbKBs0Dg==
Date:   Tue, 5 Oct 2021 01:30:45 +0000
Message-ID: <20211005012959.1110504-22-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: af4ca944-bdf2-42be-4806-08d9879fc0b3
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50444D83082F30FE5801AF7CFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iQCxaUJ2n+KpuueaSX3vQ4qV6i/4nAreM2SxJd8ATGi7ALKwSGqNLKsh99fO6D1CfbMNM1fLOBZL/vlPSnu6HvJUTF82YmpD1dGfDDyEFnNYwUKBxzBl/mYFWxGDicwtET0aIggV6/uHK2x+y5AYhCAqgxqd+tmM8BULWGmEVdh4yMLOuCLNp6UjhOHfT/JXppIFuCxHWY1zptZ7LAevc4iVuF5BNYJt+r8mxhJC8eQsTlhqBjaNOz1ImiH0aCko9e9wQnQ818jPOml18PSkxr0jKibR7bXlhMi+2O3ZPZhJfs3M5h5eBJgPG1GpdWv/OkMZCsWfaqoQTgBul06Oe4PM+dULMsJWeiFPbe0s+U+gDvUEKx2gcWLvZ56E2wj/lu/6hM2kqvpiFFHyBFyZdiR3eu+ug7kI/kjkc14MDJTLeG2f2VkfhdmdZ/U4zpbwYzP6NzYvYRh/0YaCtXqrX8/MFuH+UXN5IV1mJoz7WTztB77MDUMFqOzksloDScYiAScEi0sAEex78U4HCtj0ukUMCW2mcfOB6dxRaClC4DZa0xEikb+jMRMjEImLTOYOmw/lx8DrgHgfkT3yWyr2yOStcdIp4PCsWcVSdC4QJJFyaL6xxOzjR2ukZ6Scib8RVddd0iAJrJUwbmCb2mkWVKLj4vaYCvEu9SZoOXTEJfvxBdfd04uX7IUuLH5YZnqZkWitQ24IFBcuXM1AclhFiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(6506007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lS6AXpbEM3n2BLZYPl1A310mDrmaArOtYpMEWdAZhCpddFmDkSXy0M2nl8?=
 =?iso-8859-1?Q?kU0A3CegDjF08KbbFk3wfJ6339sUyM1hfeq7HwO3y4B+gPGvB8ribVxUMY?=
 =?iso-8859-1?Q?7tH/Gl/ijeqEnGVOnOOWc9V1iAUcFv5pM6yeHnQKtVRXFq/HjFKHKBTknG?=
 =?iso-8859-1?Q?Pte6zpktx7v+/oDZt9xTmMhuK2PiaIj23nuQt5VFD5Afz1gqdYMXQFeup7?=
 =?iso-8859-1?Q?0f49QUC09yf7+C1KxZFIzBeMYmcj644S6w5pJDKP7pkiHG1WoJh7xU2iLR?=
 =?iso-8859-1?Q?u5bhB6MruXubiNSdKYlrDxbjCpTNgu5rt4kY/mRSaBbB3rTQA9TUuSk8ZQ?=
 =?iso-8859-1?Q?eXvyGNA+AAWar058MdkzTGdB+RD88aRv+OBYFRrkQanob8eVN+k2qPu6CM?=
 =?iso-8859-1?Q?xo++09jtExFW8poiePMH/74+6CCnJPkHSDOTlMEkwtbHm+FKaRHmESGca/?=
 =?iso-8859-1?Q?QRFuGr0ibKlBSt4l9pMTl1sk/0l1ku/IuVPIPD02cceZ2eQS4Kb+KjIYP1?=
 =?iso-8859-1?Q?OWxo74pYooQTy4sUF9oXxPHE+sJkOIBFX3UBhsBBcbzgG0c6yyKUwEhgcG?=
 =?iso-8859-1?Q?lnslN40UGg5dNVfiRZtyQefLXhqTxS1Eba5dyqmOESEkMwWb8jmxoC5WpA?=
 =?iso-8859-1?Q?2ugsEaVprsvMvSAhN+Q4aoj3QZ2wJ45ALI2UJm40c/YrP5twE0dF/byVNL?=
 =?iso-8859-1?Q?LzNWDfFpJFNbbUFmSewfrloIQIpxN5CYMpT/cgFOogLI1O74PZdfiQCo64?=
 =?iso-8859-1?Q?uJaAfZd1wbRn8nz9mHAvI5ZHlsMBSiXOXKw0zWv3bmDopmWK/r3brwecOJ?=
 =?iso-8859-1?Q?vwMJDhgoqI+/QwzI3eITbi9AA9ocedZPXFGIVXktIpOo5aqJpm2uYbKiFV?=
 =?iso-8859-1?Q?txLYLZ6LvnkBDA9ZrxZ9ZfFTNTT6WzHRsvNF7u75d0c2bixmPBd8DIs1Hx?=
 =?iso-8859-1?Q?pv0rh4ZB3Iw8TZxT5Dh8ftG7i4iTbZX/ngYnQriP0XYaNNMnKYJ+aGMAmx?=
 =?iso-8859-1?Q?Syav+B4A8pe5Gy/B7TekYC1coa4mPkd5nHqS1sthDtM281HUcy8kn42Slk?=
 =?iso-8859-1?Q?lh1dl0u1KWAb1UkyjvZ86RvaPPHi/MgRWJd8stpOgr6C1LeUcllDw3qZvU?=
 =?iso-8859-1?Q?ucVU7EZ1j0hHoBGOVztbndHrGFGWW+GT/j2jcFFhSyq/aq1Lq5dZ/fEwIJ?=
 =?iso-8859-1?Q?sGGu8dQ+tl7/IF9bno6iKZXbNJHEh05saLueKZNP4eC5NF6zrn+R8u0nEx?=
 =?iso-8859-1?Q?FbzPNiw60lJjZGfVRPh931pp4QBeURlsOJl/XFstEQ6gjrqdX/qMGVgL+l?=
 =?iso-8859-1?Q?LqkbVjleUaazUKKiPw1FujkKCwX6m+1+Fg7eZkmfdD5EEh7IaRqEI48u0y?=
 =?iso-8859-1?Q?K3oRLsxlUf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4ca944-bdf2-42be-4806-08d9879fc0b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:45.1131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6+AF5OCkMncc6ZFUnA6T4A6dHOUn/RKQdH/rFZRwzK91HDh205D5z9FV2mKseO30Mza1qOO9zkvshUQGXA3dvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: VzKHW_krhjnU7xWNSSJ_MxCPLlz3O8dZ
X-Proofpoint-GUID: VzKHW_krhjnU7xWNSSJ_MxCPLlz3O8dZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

mmap_region() uses a maple state to do all the work so convert the
static inline count_vma_pages_range() to use the same structure.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 54838406518d..ec3eac307a25 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -500,30 +500,41 @@ static inline struct vm_area_struct *vma_next(struct =
mm_struct *mm,
 	return vma->vm_next;
 }
=20
-static unsigned long count_vma_pages_range(struct mm_struct *mm,
-		unsigned long addr, unsigned long end)
+/*
+ * count_vma_pages_range() - Count the number of pages in a range.
+ * @mas: The maple state
+ *
+ * The start and end address are in the @mas
+ * @mas must be locked.
+ */
+static unsigned long count_vma_pages_range(struct ma_state *mas)
 {
 	unsigned long nr_pages =3D 0;
 	struct vm_area_struct *vma;
 	unsigned long vm_start, vm_end;
-	MA_STATE(mas, &mm->mm_mt, addr, addr);
+	unsigned long end =3D mas->last;
+	unsigned long addr =3D mas->index;
+	struct ma_state ma_count =3D *mas;
=20
+	rcu_read_lock();
 	/* Find first overlapping mapping */
-	vma =3D mas_find(&mas, end - 1);
+	vma =3D mas_find(&ma_count, end);
 	if (!vma)
-		return 0;
+		goto unlock;
=20
 	vm_start =3D vma->vm_start;
 	vm_end =3D vma->vm_end;
-	nr_pages =3D (min(end, vm_end) - max(addr, vm_start)) >> PAGE_SHIFT;
+	nr_pages =3D (min(end + 1, vm_end) - max(addr, vm_start)) >> PAGE_SHIFT;
=20
 	/* Iterate over the rest of the overlaps */
-	mas_for_each(&mas, vma, end) {
+	mas_for_each(&ma_count, vma, end) {
 		vm_start =3D vma->vm_start;
 		vm_end =3D vma->vm_end;
 		nr_pages +=3D (min(end, vm_end) - vm_start) >> PAGE_SHIFT;
 	}
=20
+unlock:
+	rcu_read_unlock();
 	return nr_pages;
 }
=20
@@ -2599,7 +2610,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		 * MAP_FIXED may remove pages of mappings that intersects with
 		 * requested mapping. Account for the pages it would unmap.
 		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, end);
+		nr_pages =3D count_vma_pages_range(&mas);
=20
 		if (!may_expand_vm(mm, vm_flags,
 					(len >> PAGE_SHIFT) - nr_pages))
--=20
2.30.2
