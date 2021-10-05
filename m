Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A779D421BE3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhJEBd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:33:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22114 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230510AbhJEBdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:18 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951Awbk019258;
        Tue, 5 Oct 2021 01:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YwoDWzBTBDcUgz8r0Ko8DsxvF4zH+ee/T3rLbx85xzE=;
 b=PkxPBxKkpCqX56g4emdaLDpt86DW331Tf1C2+kJpDVfVW/qVnrXpSTeSC3ShkdqHUoYy
 45+3KMHeChP97QOayDuzG3zWaPVaDvJ37b9lJUWxOye1ZPOaWprP6UY840x7zCD2mMbf
 a+Xxchq18j4JgBoehk27M3fOfO8f1BoQ93u6nEqSCK7FhaHXCwQ3+FFaDmjLDtpjmqQ9
 xSBuD17vghDPlSKm3ZfHAdPbWI9T7S57BcmHsFZnT13xH8vIbdDYJm1P5i9rRNzQH804
 nyLf2137O3y5CyOg3git0ywTp3iThl4defJ0Lo1PzVtjUZY7k7Yvt5Xd/miyAtUN8D4x yg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p5c97y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951Ueb9141761;
        Tue, 5 Oct 2021 01:30:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by userp3020.oracle.com with ESMTP id 3bf16s9dua-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl0FvPx4KbqP4ouEdwJAiPmmczFvrIveRWAtqXunr1YDbB7EFNvAY3CRdsfo0YxmRwo9z9jNhUrSMhKCH7oMeuqdz9pazxl4W8y/PwSuNt7nRL64/3/WQCe7YuYI8FOIOg/kh8fZiQ/pLeUK0l3iS6k8OejTsWqWs9Ajbn5YnDQjl1FF+r+mFeK9Ce3/ixsGc/hHdKJ/2YxIzrjAWDCf7f6dMMLQIlezhzLVPeTj7LC/52+67tI1GwE2p8WAMp38bNaju6R3tssL4fANZnBFnujv1HKgaAful3rYMKow9t+6AhodWDhgQOsmblf3aYbPxYDOoEte4PIl1+yDYFN9CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwoDWzBTBDcUgz8r0Ko8DsxvF4zH+ee/T3rLbx85xzE=;
 b=BgBKeqJKWBHnyIHPQ6BJM7fLPealcuVoJmNdkXdocf71jIAYJAJ447RmKc3hlq4QEvNEq9gX70diip/0keO0Onieb5zHzx58gRLgErbQ+0i5JfTHuDeQ/HMhBO27QnTe7ZXfq0ijXluNiZ/fUft270GOY/hZlpe4cNecDjZZSTz8jNOXpG6eS7s1e9Vn2oLlwEHPR7ypp+o3emdY5K4cEI7aD2Mm+p6EY+drqC8vh8UFpAlCdT2n6TBM2i+BxQAgiMGD6KQngql1ahqQauhf2yRPfvZP7YEpNsFjOCrH3BdedHqBgNbSe5IudFTEYaqQQP/mDgUzD036uROTs5D9Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwoDWzBTBDcUgz8r0Ko8DsxvF4zH+ee/T3rLbx85xzE=;
 b=IS1XAwy9NT43WnRMtMzxieUpQVW1ZXKnhwKnNdnyvZEQBWBIJCQJdUS3Y5JyuhPVqxEKdedEBYJNp/e8RmjR/mHARCBPlkG7eLpuY4kDQUUK0xoAtSszoJwWBJKhNCtb+Q8Lot4Qadgz/r89umhswbRXmN+jB665XJuNFcQp6E8=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5218.namprd10.prod.outlook.com (2603:10b6:208:306::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:34 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:34 +0000
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
Subject: [PATCH v3 08/66] mm/mmap: Use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Topic: [PATCH v3 08/66] mm/mmap: Use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Index: AQHXuYiXDosBZ3Y2uk6Sc+lidyUqVQ==
Date:   Tue, 5 Oct 2021 01:30:34 +0000
Message-ID: <20211005012959.1110504-9-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 49c784d7-faba-461d-f297-08d9879fba82
x-ms-traffictypediagnostic: BLAPR10MB5218:
x-microsoft-antispam-prvs: <BLAPR10MB52186C2E819C57BE02AE6188FDAF9@BLAPR10MB5218.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k0Ocud3zIv7Ojnx82qBj17cPNBvUJdj3FoUS05dkgZfsIwIBAmmm0xqus2aSHeLsVHdJ4NJIl8ECtkN2l6kSCBaypA5ylhkp3yDh4T0OASCz3GrlGHbTXwDFyicmj7c00Ccud1WYjq+nHyI/e58YFkUtDV4rF5pfL6NNa1zagg02U5/M8zOj5CMErDeRlkzl7D+oXblPhWSz+f+GGFg7Onf5dKbbodoZKIQ7Dqw+VwwcdgodRGgsGzLyDq75uzsh69b8L0sOuZ2q65lvATZDwRom7ir9M35UOfgvHeleyjNKRWnEH8wHvs5fDmsSj9A5rExcMpUoB/38rc/6PZODJSTkDV6SU7g8Cr264jIdmGTY2XgJUMSdn1m0gw9WusUXYqCRqihDnS/zL3JGpb0oPl3XlT3wzu8Ua/JlxROps4FV538qEXV0RSyzA1gaR4sFBsyXfXgLPqzLv1Mu7DyJPQ/Mac8nfkLIbmMgf6dQ07tSNhxFVngQuTrBbjckmXPWPvc7y0H+fPqvTpE5HrWQ8LD8jERxsXJCpGbeT+vCkgGoz7Pro6AD7U67pAYn5QC//5WrDVnD6T7Cnu/YrCWZpe7YiSklodn3mpx4Qjg264pMvgV7TgqIpqJeGKEvwkLDCuO5a12+62K/yWKub6PdeqkSgIrgOG6sMqk2xxY8DbIgA3xsFq/ghLN1XKZsNtHxOudqFbCS3BVOMne+4U2H3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(5660300002)(6486002)(186003)(6506007)(86362001)(6512007)(1076003)(36756003)(38100700002)(508600001)(8936002)(71200400001)(8676002)(122000001)(316002)(110136005)(76116006)(91956017)(2616005)(44832011)(7416002)(38070700005)(54906003)(4326008)(66556008)(2906002)(64756008)(83380400001)(66476007)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BY8t+N0RFNvgA/KM3BeP4lkrVZHJxIgAdIAIGKw1VgUWJ8OhkV3F0u4OAp?=
 =?iso-8859-1?Q?fiA8t5ddiIP76UPRPhALKcyy2XUkX44V0f8yq7AKsG9u59FqzM6OZBDpF5?=
 =?iso-8859-1?Q?E+nhaRu7OosNq0H+m9k9nNP87qeDa/KuYEKICRX5CkG/NoblsQN1Txwl8Z?=
 =?iso-8859-1?Q?mR9/OaXorSPnjnDC2nehftAdJJhEmPvcV48nGfD0QN32deYPcEr/HJuOvS?=
 =?iso-8859-1?Q?9szuIyr+LrIjXZ3ybpOefDlIKRNsQ8qve5RTm3MNZF6VCVLcVexWafxuUf?=
 =?iso-8859-1?Q?4JBfvAIHfvkAyOFghBb0mYwV39Cu8Ytb/ut8QclqXjNz5wcpqHSmlWSqJW?=
 =?iso-8859-1?Q?MsUWkmfx6I2MoL0ZTJb9BS7kwcj/+0qu71Jwv4K9O1hrcygLpCWLYd7Ns4?=
 =?iso-8859-1?Q?U3rGXlY1KnEKbXCIP68eTKEdTIFg2/IqozZNhJXoQLIkDiLPlG5WZ69Vux?=
 =?iso-8859-1?Q?C+V32gueL5SeRspkDdMkWkjKa2x6T0qQG9944m+TcqvglDx3GEiXgFTEDb?=
 =?iso-8859-1?Q?EeRYeCH6gpiFuAy2s1Jltbds7Nb2RGqyUFYYN7qAVBcOl8x/Zs6quM0jyS?=
 =?iso-8859-1?Q?txVKcpP8xqWy9xF4/rN8q4E7gIsdvxNjvPbS5FxLjEqC4m3BmDdqole6MO?=
 =?iso-8859-1?Q?di0MiyOk2DIr28ier3zW0ZrRP/0Qh3oL9Mjut3IQ4L9v2MeoTnbgAqB/lm?=
 =?iso-8859-1?Q?ccrhQbbIFpKhfCTrO1SWs3LYZOE902vlHow5PLRZL5RrGfVe8RUgBd9fQP?=
 =?iso-8859-1?Q?q6931W3oZA38c1jwvCbhM15Q220d9+acKVFg8vdHgPMov0RlqHThyFQuED?=
 =?iso-8859-1?Q?wnaMc5SopKpZt31ojouO9z2WONj5DQC9NpXpjrURqZqpidN+YiA1WoOdzv?=
 =?iso-8859-1?Q?9w3XFq/Ouw/A78pNgnsCmbzAweQYffLrWcD8zU2xzw3TPJV2BH5mUShzpv?=
 =?iso-8859-1?Q?NXMrDj/GkLoHjT0AkFdgLwDqJYMo/1NEJ0ju0F8IRrKR5hTDUsHvFxVRgW?=
 =?iso-8859-1?Q?9RuPfHMAyxQpdXcpCEVyJG9YI7T3pbHBAwTOIFLYdv1N/7E12lWNoOhjF1?=
 =?iso-8859-1?Q?IH6rLjvBCScV+3s+Wj/DgE/7orGqwl4Kd5UzaJWkVbhfRRP3hh6zRbgxNm?=
 =?iso-8859-1?Q?92YPCse5G3tjhdRfZ71BLSjlSofZRXpzX79wy9L8LOKgoBQyUa9kqY3Upu?=
 =?iso-8859-1?Q?CwSdQpxbrSnlUozTcq4Giwjs9tcp/mV5/LSOJsCUmvxeqs/beqyBeu0Uem?=
 =?iso-8859-1?Q?rY1U7GviRzTW5kb05vvy3r4uS5rPENqNiUR1gHAWrqje8GiB/v3+ivlejl?=
 =?iso-8859-1?Q?eemcVGmrvsxQJOGPGzYQccxOYouDRH/jBgAyhKiA+X5aiZOp2P4DZms3UC?=
 =?iso-8859-1?Q?cRPkyhFAyy?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c784d7-faba-461d-f297-08d9879fba82
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:34.2373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8Rf0x3KN4XkHtCp5vUXcZCSyf/AWxljTC3U4R8uexYke0zCKseI2b96iP6ovb81NXdRf6ZG25p+hsyK0bEf6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5218
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: IuA24hc22glnKFy0KdJxoxepvdDpocya
X-Proofpoint-GUID: IuA24hc22glnKFy0KdJxoxepvdDpocya
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use the maple tree's advanced API and a maple state to walk the tree for
the entry at the address or the next vma, then use the maple state to
walk back one entry to find the previous entry.  Note, the advanced
maple tree interface does not handle the rcu locking.

Add kernel documentation comments for this API.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index fde3497a3c85..f6856bf65f2b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2484,23 +2484,30 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
m, unsigned long addr)
 }
 EXPORT_SYMBOL(find_vma);
=20
-/*
- * Same as find_vma, but also return a pointer to the previous VMA in *ppr=
ev.
+/**
+ * find_vma_prev() - Find the VMA for a given address, or the next vma and
+ * set %pprev to the previous VMA, if any.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ * @pprev: The pointer to set to the previous VMA
+ *
+ * Returns: The VMA associated with @addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
  */
 struct vm_area_struct *
 find_vma_prev(struct mm_struct *mm, unsigned long addr,
-			struct vm_area_struct **pprev)
+	      struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	vma =3D find_vma(mm, addr);
-	if (vma) {
-		*pprev =3D vma->vm_prev;
-	} else {
-		struct rb_node *rb_node =3D rb_last(&mm->mm_rb);
+	rcu_read_lock();
+	vma =3D mas_find(&mas, ULONG_MAX);
+	if (!vma)
+		mas_reset(&mas);
=20
-		*pprev =3D rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb) : N=
ULL;
-	}
+	*pprev =3D mas_prev(&mas, 0);
+	rcu_read_unlock();
 	return vma;
 }
=20
--=20
2.30.2
