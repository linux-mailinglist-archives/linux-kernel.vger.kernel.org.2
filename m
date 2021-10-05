Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096C9421BFA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233153AbhJEBe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:34:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55824 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231741AbhJEBdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:42 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19519hu7019232;
        Tue, 5 Oct 2021 01:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wzOwyYpCuZxLXr4k5w2FkLB8rOZdyea9IDzHkthv/iI=;
 b=WoUEGeMf+v7mdJgUG/T24IXXU1/VADfd5T54YzGtmlUKXF8j67OIfkMMRw49GZwTJGEV
 tqsXXxrcFEowcip3SJeJtTW2CRSs2Vv59LdjZJIazVI1Q9c9CcQ4W1uwzLIeustdtPZN
 ZoNvINZysqgGloVAbnwGlBcR40vx7kNyIFs8CHzat+M8NwWqHRAtpKUdIGrgFMbvq14P
 AY85Ko0NWts0LCQx4IegsovN2t3LEi3F8kG+RR+sKc73cYZpYysLjtrxJOnZW4WLJhbo
 Vru7gdXma/772nyLakzCMVzkirBdO65e47LUzCQMyJjGON6N5UVSRGjaxr+pTEJgyQ5u Ag== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p5c971-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdFt141646;
        Tue, 5 Oct 2021 01:30:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3bf16s9duq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oI4L8yEgyGxqegFMKnQk1fuQ8UW3pIEuhVCYtCWApoV6twYgw2v8MuaP9HQKBH3Ma29e8wvfjpYbzTrKPnM1c3lA0+UfKl9PhedX0CzD7FTUCkb1iNbsR5hZ5qS1OCc1HlSpSxBiFlDm27EWQk4m2dDohI+OWsGVJ4r+H3Q7y6C81KROy5au4Jt5KRZ63X4EIzZYDICvi1K3GimJ60TyR4wC8Uouzs7Nf3cFzXQ5+5l9J4sHBpSI1kNesFRkthHIPvY5kC/YNU1VoRPp2mYAQmeuABkEgS2rRQyWynWiiLouwKhT2xdT+B8z00oW1wC5BtoZ0RHgSHxaz7hqIIYivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzOwyYpCuZxLXr4k5w2FkLB8rOZdyea9IDzHkthv/iI=;
 b=RFMSxvhDxVLbrnAqG+R/eHNZTjaYH0sEcKf5x2TsBCsVLlCk1Fvrzu0SXG8ellvGx/dmdhq54ZOGMd7YucvOKrFcTrWxAiIr+2HybM1r+ebLZ67cBoDeVRzTFmqBzFqcR+cBEojPwO4eQtQ0Az9/IHDv1ZHELZt0mad1wP2wRmR+6MfCFqv//Gt40+hYBNpVSxqRRzeykFuhzjFRZXBL+CtgqF1n/KpJP2a4eEVVCC0cGN2GesLEfuu7QwdzC2GWFsbvs7HykvAwobbCPmUnzh7fMAUI8SjW+aKv02vjkIQiACwzv38E5NxkT2GfP5GJzp6xyB6ssXsPnRMwCxJJIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzOwyYpCuZxLXr4k5w2FkLB8rOZdyea9IDzHkthv/iI=;
 b=BsbBenSvKWu/5Am8ldB7Oah033pBCcgR4/1iWFT1BK1ntzSgS9pvYbibQSvseT6S3ahuXxma6+f379wHlzWsxMMdrY4pd79tkTpdV0IIyUTAmB66Z2iora02q1tpkye5u8cUSOg2JjYrmeK2zCr26LYTHf+jcxnWPfS5R6oYpec=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:35 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:35 +0000
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
Subject: [PATCH v3 09/66] mm/mmap: Use maple tree for unmapped_area{_topdown}
Thread-Topic: [PATCH v3 09/66] mm/mmap: Use maple tree for
 unmapped_area{_topdown}
Thread-Index: AQHXuYiXeg0kEFXiDkWeMJ9/rHPCkg==
Date:   Tue, 5 Oct 2021 01:30:34 +0000
Message-ID: <20211005012959.1110504-10-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: fdc9d212-5674-4501-1afe-08d9879fbaae
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50446D9486BD38DE84A698FFFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: //c8zJtmpYkiuei6feER5A3Hucv4lZhewCRSeeIq+bhjN1Et4zunU6mqvCFRNaUpaqJ4ddU+FnLssfLOkivUEHRWILZWK2UTuhekXlQVCMx9JEbbvnZTmLbj9uiiZKTuxjrvSzI07iz+t5b5j0W5Y4vShqwlMKGJ3jX5MW073hRuyB/7tEnuS0f6vFGeTwkAL99F3s32bHgDez1tqJzUiGvvKHtS5ij6Z2Qn6+mr9MiJpx2o+3wUpfzhEkutSOkK0GHPo37kQEc8WV2SWQsENwGfbOyD0GN5I9r48NC8xRON1H+QcW+hFpl6NCdVWx/zLnewStDnCGFqPisXGbi58qZ7f71W1PiBUANl8eraHpOJZDqgd4ndbDH4TWtt+anKsdbGK++rh42n+if+ObxNWA6YZTtRDGROFuC7m7opEGUN1iY6dYOLg+Lkmz4B9TfluwcfxribDlBujW6vG6Y8YFjuwmxJLU1FCA7oLs+lVQsvAA00wXhbqv7Z66OXa2nCYh0j8TrR/CSFD8mH5shNxWRAFJ+Vjo2yXo/KWbQ4yMdrRidLUrbtsx10LkvAzWDeabbgHN+MGvAzJ4nOd1tuZGPRccFwHfvcNeP/5BJsIRm6H1sdcoJIddQ4Z7HMshIFWaztctgDiCAwJLksyknEmh3zzfteCc7qqazHDRDdXFqycKMbGiS0fn8nWgK7SIetVCQvcd5cRV1N1XTIKfQtBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(6506007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JS7bFWVXFhuTYzKJ8CFRca7QDsuwVONKOcFjUzUUkS75cm/HVvYhiOLIk/?=
 =?iso-8859-1?Q?UN1pfWpljnRSyQJs62s8sdgB2zFb2KvLYdEuU3PcjPl9JnjSpiGDn8M6ZI?=
 =?iso-8859-1?Q?7ldsVGrCY6vxF/7Z0s01iZC7UQZuc3FOsijbNWdK1Pdo968tk/zMC1XH8j?=
 =?iso-8859-1?Q?yacefgkrw0YFtgKLbc0nlm7hvIhqzdbh9ng6o1c70fckG/Fp9M8C5eGFX3?=
 =?iso-8859-1?Q?nBNuZqX/3l9mQRHM3ILUuIL6S44YTPR6dM5/CEx3Tb7iIHTmKGrkE3s15T?=
 =?iso-8859-1?Q?jxKqNWrGkkVtWvKZFDwrcK6/0uBeswxDd8DXrwrY6GejqmB7HGParGzjHa?=
 =?iso-8859-1?Q?th1QOaI7Qu17RiP9aLKyx+dceMTe+T41AGGphtDuuYde8ddi/+oWGV8QE3?=
 =?iso-8859-1?Q?wiHEHEjw79SiKpNJQ4ZwgiRpuiwsEqe9wJrafinUdPxQ/3nL7DUs1bFoSY?=
 =?iso-8859-1?Q?UsLhulyOimn6mt8MoHcKLSpE+pjW6rKQbTIjvGE920jCz571ulIDx+3CTD?=
 =?iso-8859-1?Q?kqDIWOO2LTy96fnl6IchxyYYrPmYPL2k/y0RErzhU7UZxENGr9aANTtYtZ?=
 =?iso-8859-1?Q?/i4O0HQsa/w1zXz26tlpJPz0avRTkRNUZKXWc7rnjJSIb8g0e7OocMgiqd?=
 =?iso-8859-1?Q?8zNPoZOhotLa340ZYJp5/3gWQmHr3jVkcL+pyYoVJSyl0NPJ0cxLRHNWJH?=
 =?iso-8859-1?Q?DEkdHerf4DLvfSbQPKWE6J3+OFFIU9Cs+tbk7VVD0NleNWYckhsiioBYTw?=
 =?iso-8859-1?Q?KW0tBBK507tArhtQHYf633Q6uUZ+w087V2ToWObiqFPCgnnwRjh4+kXY6D?=
 =?iso-8859-1?Q?mPG1Du0sa6Bidwh130P/4Wpm3RvQnsxLjuT9gdi3AL0VZjsXPga+8QpRKM?=
 =?iso-8859-1?Q?veEpFdkhWka3sYaW9fx3rmY8cUrAOkuSYphQ663R2dENceC52rSXi8lvhi?=
 =?iso-8859-1?Q?YLhShbU3yWA5xOGKHPu8EkMbGU9XTM9VRmUSzTN4RkWfs5KhZpswyoYbUN?=
 =?iso-8859-1?Q?sR/v+v1mEUmhnzfxDgBYdVa4gh6xr7mHPUfXclq9TXyTsWBhwxtuUaE35b?=
 =?iso-8859-1?Q?BAm9rsgR7Qi6K17ORh26E+DPT8YlLcvUl1H0UCCYaapAEufLO/7RGFfTtd?=
 =?iso-8859-1?Q?A29r1fKKpMECkl9Ts4gZZbOOVxzgc1Rqs66fTNCknie17cjcTMU8wztI90?=
 =?iso-8859-1?Q?hxraMrmdXjS46cmgLsaxh482Zk3Vi0hWJ3LsYBYISHpJwRlRCKCL5wfHxu?=
 =?iso-8859-1?Q?nTSVmwFJSXqPCFyzUdt+q++qYCX6ZGXkxPT5rZEWkel4gQ/2+sen5ZHxOE?=
 =?iso-8859-1?Q?J3YD5TtOSvsrGSWrVQinJKOJXldSTNIehfIIDoUORKrdbFXK457nxvAo6h?=
 =?iso-8859-1?Q?NZKWCmfvgo?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc9d212-5674-4501-1afe-08d9879fbaae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:34.6700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UTiqfW3HSFNSuwvjl0+IPPXqE2lwBgls3YMMQnqRrZyh0a/TLv17O+Zw3FJ2ehOcsPx/PRt6MjMZGCI/v36H9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: kpV67fs8p_6L_rP-9aDpxSR6CurYXzXL
X-Proofpoint-GUID: kpV67fs8p_6L_rP-9aDpxSR6CurYXzXL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The maple tree code was added to find the unmapped area in a previous
commit and was checked against what the rbtree returned, but the actual
result was never used.  Start using the maple tree implementation and
remove the rbtree code. Note, the advanced maple tree interface is used
so the rcu locking is needed to be handled here or at a higher level.

Add kernel documentation comment for these functions.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 262 ++++++++----------------------------------------------
 1 file changed, 35 insertions(+), 227 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f6856bf65f2b..08f7338ca4f0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2024,21 +2024,20 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 	return error;
 }
=20
+/* unmapped_area() Find an area between the low_limit and the high_limit w=
ith
+ * the correct alignment and offset, all from @info. Note: current->mm is =
used
+ * for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	/*
-	 * We implement the search by looking for an rbtree node that
-	 * immediately follows a suitable gap. That is,
-	 * - gap_start =3D vma->vm_prev->vm_end <=3D info->high_limit - length;
-	 * - gap_end   =3D vma->vm_start        >=3D info->low_limit  + length;
-	 * - gap_end - gap_start >=3D length
-	 */
+	unsigned long length, gap;
=20
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
@@ -2046,238 +2045,47 @@ static unsigned long unmapped_area(struct vm_unmap=
ped_area_info *info)
 		return -ENOMEM;
=20
 	rcu_read_lock();
-	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
-			   length);
+	if (mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+				  length)) {
+		rcu_read_unlock();
+		return -ENOMEM;
+	}
 	rcu_read_unlock();
 	gap =3D mas.index;
 	gap +=3D (info->align_offset - gap) & info->align_mask;
-
-	/* Adjust search limits by the desired length */
-	if (info->high_limit < length)
-		return -ENOMEM;
-	high_limit =3D info->high_limit - length;
-
-	if (info->low_limit > high_limit)
-		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		goto check_highest;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		goto check_highest;
-
-	while (true) {
-		/* Visit left subtree if it looks promising */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end >=3D low_limit && vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-check_current:
-		/* Check if current node has a suitable gap */
-		if (gap_start > high_limit)
-			return -ENOMEM;
-		if (gap_end >=3D low_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit right subtree if it looks promising */
-		if (vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				goto check_highest;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_left) {
-				gap_start =3D vm_end_gap(vma->vm_prev);
-				gap_end =3D vm_start_gap(vma);
-				goto check_current;
-			}
-		}
-	}
-
-check_highest:
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	gap_end =3D ULONG_MAX;  /* Only for VM_BUG_ON below */
-	if (gap_start > high_limit)
-		return -ENOMEM;
-
-found:
-	/* We found a suitable gap. Clip it with the original low_limit. */
-	if (gap_start < info->low_limit)
-		gap_start =3D info->low_limit;
-
-	/* Adjust gap address to the desired alignment */
-	gap_start +=3D (info->align_offset - gap_start) & info->align_mask;
-
-	VM_BUG_ON(gap_start + info->length > info->high_limit);
-	VM_BUG_ON(gap_start + info->length > gap_end);
-
-	VM_BUG_ON(gap !=3D gap_start);
-	return gap_start;
-}
-
-static inline unsigned long top_area_aligned(struct vm_unmapped_area_info =
*info,
-					     unsigned long end)
-{
-	return (end - info->length - info->align_offset) & (~info->align_mask);
+	return gap;
 }
=20
+/* unmapped_area_topdown() Find an area between the low_limit and the
+ * high_limit with * the correct alignment and offset at the highest avail=
able
+ * address, all from * @info. Note: current->mm is used for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
-	validate_mm_mt(mm);
+	unsigned long length, gap;
=20
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
 	rcu_read_lock();
-	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
-		   length);
-	rcu_read_unlock();
-	gap =3D (mas.index + info->align_mask) & ~info->align_mask;
-	gap -=3D info->align_offset & info->align_mask;
-
-	/*
-	 * Adjust search limits by the desired length.
-	 * See implementation comment at top of unmapped_area().
-	 */
-	gap_end =3D info->high_limit;
-	if (gap_end < length)
-		return -ENOMEM;
-	high_limit =3D gap_end - length;
-
-	if (info->low_limit > high_limit)
+	if (mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+				length)) {
+		rcu_read_unlock();
 		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	if (gap_start <=3D high_limit)
-		goto found_highest;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		return -ENOMEM;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		return -ENOMEM;
-
-	while (true) {
-		/* Visit right subtree if it looks promising */
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-		if (gap_start <=3D high_limit && vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-check_current:
-		/* Check if current node has a suitable gap */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end < low_limit)
-			return -ENOMEM;
-		if (gap_start <=3D high_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit left subtree if it looks promising */
-		if (vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				return -ENOMEM;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_right) {
-				gap_start =3D vma->vm_prev ?
-					vm_end_gap(vma->vm_prev) : 0;
-				goto check_current;
-			}
-		}
-	}
-
-found:
-	/* We found a suitable gap. Clip it with the original high_limit. */
-	if (gap_end > info->high_limit)
-		gap_end =3D info->high_limit;
-
-found_highest:
-	/* Compute highest gap address at the desired alignment */
-	gap_end -=3D info->length;
-	gap_end -=3D (gap_end - info->align_offset) & info->align_mask;
-
-	VM_BUG_ON(gap_end < info->low_limit);
-	VM_BUG_ON(gap_end < gap_start);
-
-	if (gap !=3D gap_end) {
-		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
-		       mm, gap, gap_end);
-		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
-		       info->low_limit, length);
-		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
-		       mas.last);
-		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
-		       info->align_mask, info->align_offset);
-		pr_err("rb_find_vma find on %lu =3D> %px (%px)\n", mas.index,
-		       find_vma(mm, mas.index), vma);
-#if defined(CONFIG_DEBUG_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		{
-			struct vm_area_struct *dv =3D mm->mmap;
-
-			while (dv) {
-				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
-				dv =3D dv->vm_next;
-			}
-		}
-		VM_BUG_ON(gap !=3D gap_end);
 	}
+	rcu_read_unlock();
=20
-	return gap_end;
+	gap =3D (mas.index + info->align_mask) & ~info->align_mask;
+	gap -=3D info->align_offset & info->align_mask;
+	return gap;
 }
=20
 /*
--=20
2.30.2
