Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C7D421BDC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhJEBcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:32:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51668 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229568AbhJEBcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:32:51 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195017oe004524;
        Tue, 5 Oct 2021 01:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3j+08lREa0r9A1JB7kdnPvbg5F8d9idklNPEBbu30uQ=;
 b=MfiD08bsrJQLjiZ9XGYzpiKPOYT+7m8XH6Z/q+3RHjJhA7IBh0N4OURXuobQHLbY1nbf
 rz0P4pXdWiAYhs2+jx9GG26xp+dfsi6uxvwoiFG/qZf5PCW//XNuldZ6I4xp5ks5ZHtW
 2DlViZchHr8WRGMTIJ1kU66U0AIgrV4GEfHGZxBCCyUofTmNXxioALHH4m354KUzacGP
 4aB+H3G6oYXuIOqRP98OxLNmDEuCPfT5zjEqtb24qz6EOGQuuXVlQ8HAzpkTHMT98brj
 m5LsT0wlq+8rUMAtuo25aIZWPeGewvsQKP4Sg3AmGfZkLRXt2Utve8D7/ZC3xUUgfoPF PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UHf3178354;
        Tue, 5 Oct 2021 01:30:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3020.oracle.com with ESMTP id 3bev8w02af-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HM7aqE65gyYutB8PkwauQIzvYPzCzrQUELpBeEtiUEwJtA2OECxA4RGvW8dXnzL8rjEmMab9Z9mqw3ryA0PlJg30KzaxpeWBd2mNUr/HEJXJ1Sj8bHf5ON4ACJJ+rIdcZaZRo8AInjUHkzMgSOsS9OOu/an3kIiVdzK9T6O6A9wSUYhEJ9Qtdgxycd0uHShK19xXwgNnIbuFnoev18iyKaDFGBxIZZHWmo6bgm4nEDFJa0ztKgyInpZQYS38ffo7tLw62ia7zObGx8qQJC39ecIwHgKwHTcv4Oo3BXwf4Nsf3NMdmV7Xrnff3/8mqqaxIlBF7eOqesI5W70dKRzDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3j+08lREa0r9A1JB7kdnPvbg5F8d9idklNPEBbu30uQ=;
 b=bg5ZwGQzFgQb2hDtr4gJEjxY86Wpj1VMZ9M3BFaGIhwvpi1Ud0OU0MG7zPy+cjXoxWKQM8EYePFvCrVGsFm1HJybtz0XWIc5R69p8P1IKtJbb70nJIwJ7vf9XLCzwQ1y8iog/nZKBqYPQ4jj3D4u04SLD0RjhlaJV0gETpVjGSBc5AKdLCd/w2JYA2EUESCnH6MI0Vl5MGlfZfvpRPiiebCRn7C0fEotNS8EOVkyX9FfzkfPIYYImkrDIPy4gZVWpqIWQ5FQ5AyXjJh1CI8y8WXUOIjHhgpgLLSs7VqmsgmhwCcRx/DzfL1Z6BvOsgwQByxLgjOQkzlfJVN+OOBWeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j+08lREa0r9A1JB7kdnPvbg5F8d9idklNPEBbu30uQ=;
 b=Z26SBzb246dMZbBIecbBFBFtXycE8Ltx/DQqWDmYMr1ZETD2in2tSf2GvN4wT/Us9HOK3YUQiwtGLpqtlQ7ep6Ffm9us/LN8VfNYupiVsE1YCkiUqDKekBe/qEXNwAF+847nIhNB+AlDFZvcMKQMb/FMVA+yzPsCJZ2+v5MC6gs=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5218.namprd10.prod.outlook.com (2603:10b6:208:306::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:26 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:26 +0000
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
Subject: [PATCH v3 03/66] radix tree test suite: Add allocation counts and
 size to kmem_cache
Thread-Topic: [PATCH v3 03/66] radix tree test suite: Add allocation counts
 and size to kmem_cache
Thread-Index: AQHXuYiTXcPYXjEkSkODQmzn1G588Q==
Date:   Tue, 5 Oct 2021 01:30:26 +0000
Message-ID: <20211005012959.1110504-4-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: fb3c1bf2-1c78-4128-9fb6-08d9879fb5a5
x-ms-traffictypediagnostic: BLAPR10MB5218:
x-microsoft-antispam-prvs: <BLAPR10MB521803849167D057B034C8BFFDAF9@BLAPR10MB5218.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jMYmhvHVPplcH7iIX58+ipcVf45IrmQazo8CkSmAPZteiU+rZonqMcsq5B2xov7cpAFNZArpTMb246Mk0LDMS9gXZ0tzvPLJivTodV0dNORL/Vu1j0ST96dJZZu68ZWQVGCn51w7UyAw4VfOi1KeNWfulyv8tY+OE05cbJY3gg/I3VNHieOLzyv+qaNB9HWd2qRfNKp+zOZwxf/7DgkrILp6nbQjbNF2DAQcedG2ltXIghwy2915JPBParAe2y/vpDbuWH9sVATM7rR9NmpDFbNTZrU2HLUzNGzdk/uBiyujtiNwi3Bg40z7s2zwP1oOvodq0FLig0b1hzBmUquJQvByYnrIuhNG6Y44PnZAs1dj9FTZSVSZkmV5vjj6X9FztnzCEgNnoY4X/3Znbyb+GQW5SkQ13eW81SGHQKFNQqU0+F41PkmTsIxNwicbSlxBksbYVesacX0dlxIHYgpYRoSU/21x3GlC6pC5+cvid5dPE4DoAgtwZAmJ+zKo5RbBWYJ7FSKAwBDXTSo6bLEN/5UViDhA1+03l3tQ0LfjYJt1XVikWdrM7vB8Mgmne3iOkO6jw3KMpUlvoI4xOVqcHbvPqzQmHYWSxI6IhjFrl2IL4ao3k8lQV7HP6lAY2EtIxpjKCa+/9Ju1qBlr+hucGT7MbKF6NNZOgIVRPBBqd7T+OlPbIXJZ+MCXFU7xUrcPFQcyXvQcdx0YSMROfoshcg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(5660300002)(6486002)(186003)(6506007)(86362001)(6512007)(1076003)(36756003)(38100700002)(508600001)(8936002)(71200400001)(8676002)(122000001)(316002)(110136005)(76116006)(91956017)(2616005)(44832011)(7416002)(38070700005)(54906003)(4326008)(66556008)(2906002)(64756008)(83380400001)(66476007)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?90wVkpYu2epZ3DfUJ/ZeO2LURofGr7Cd1c53MHnumdZurTpCH1ALurGwwb?=
 =?iso-8859-1?Q?nzHfZ7UTgy4nEEm00eBI2uFEQWP9SzjHueP7tZg1avuCRTTD4bclM/FpGl?=
 =?iso-8859-1?Q?P43AHiIp9rKiDcAWtrC9yHBDm5A9pRV2LzvK1Yx2a/ZiCj8C9T1t2PXowk?=
 =?iso-8859-1?Q?hpfaSu+RokYlbacefpgQvt45uLRjzY9mTpcpKYKiMh3f3p2zuzt0+MwgP6?=
 =?iso-8859-1?Q?qp0T8EDW292KEQB3MLZfryLkGrV4mq370/f6yrTx7Hug0DGqKjmjnGZrVD?=
 =?iso-8859-1?Q?2of8mlr1rxCn4sSEnff/r9RXIeO5aA0iB/3wCZCD+vh+VRB7sdcP4CPQ74?=
 =?iso-8859-1?Q?Bx1gv3EmPqLdfL38b+WFB0uZtG3YS3m4dHyNT7m8oJ510FShMKtXt/5t7g?=
 =?iso-8859-1?Q?82bSNEcA3uHK04gqdnAZF4vpaNAG8v9//yTSg7ukHQwIzHQDTYEvqEPknq?=
 =?iso-8859-1?Q?BKez+LUD3sHy/CE63VH+y5SSPozg5eUd1Iaz9/SdUD0y/aB6ioDfBFuLss?=
 =?iso-8859-1?Q?8nyo/CRofAbt8B3VU692j2M8405wSHhcfVT2khHL8uEWgcvHAaBVfJkRJQ?=
 =?iso-8859-1?Q?XgPTLr4Ow7aK7Zn/JlIKOUOdBP1ilx3+A83F60ksJ4zbITPfURWfgAG1Es?=
 =?iso-8859-1?Q?8uaMyMpgbMmNzjBS9cjOIgRgiYENJmmju9GcVKZbIUnliugzzUfZbEdXgf?=
 =?iso-8859-1?Q?2VRaqAEJWarkdMOAFdP1SYHiGdkrYFPr92eHNPcNcdYNxZ0fLplzZQHVlH?=
 =?iso-8859-1?Q?L37LMvwM+Tbza63Tm9iiCNvaPlGjDo06OvUE2u/Xg+mkm9jTwY56DlhRWd?=
 =?iso-8859-1?Q?N+f+0wzB/5UZ/8b4LcsL6ch8DviDFOhoMOUtvASWX2icHkaAydtxS71Di+?=
 =?iso-8859-1?Q?EHXbgX54ro95uLTz1d4v9ZwiMtZrhTBhtFJl39xxxYMxlklZY5IJfhQ5Kp?=
 =?iso-8859-1?Q?kP9lFlGyg0QxWbgkqKlfmWhvIqTHeEWZnDJ/+c4ccZTCqaTekIMr4ZkKJD?=
 =?iso-8859-1?Q?ZQX4Fn9XSBv4o7gm7N2qSuBqNzOqFT/QTgkaxV8hIy9hTYANiYdut8TLiJ?=
 =?iso-8859-1?Q?/PSd4lhz+Xjiui2ZTs1FirVqSLNkF1gqT7+HsKIhIUMKVnG2rHc7Y9yaiu?=
 =?iso-8859-1?Q?9g9cDnEFYBPbW2v9UlEm+QdV4N5Bqcnqn7oF8482otqT7kK/YdkXMYRxha?=
 =?iso-8859-1?Q?dCyiQDYqEXYYKbpmEPqkVo7hmkUyzJQ/Wg2iWzoHfk9wnl9tlIMufKnc+Y?=
 =?iso-8859-1?Q?d+/iFgUpk3FZo0xr8BnVHNJJsMjgals+c7ertlRKZjQNJZmX18qoBSiksv?=
 =?iso-8859-1?Q?7NfH1ZQvUN4Qk+LWnkcFTomCleLauItTSV0oGyLVzM2GbGj3CptoOZvKyP?=
 =?iso-8859-1?Q?bZUuSrETfU?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3c1bf2-1c78-4128-9fb6-08d9879fb5a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:26.4977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FrNY6y1BiOUjp1003/7JVcC0f/MzItaCxlBKMvs3X6f+jstt6zwK+gd+aqz4afzo2kbY2XvTlUThRoK0yV9Fgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5218
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: qF2W1-rSckRvNCEQ-FCxKMnChj-yn5tR
X-Proofpoint-ORIG-GUID: qF2W1-rSckRvNCEQ-FCxKMnChj-yn5tR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Add functions to get the number of allocations, and total allocations
from a kmem_cache.  Also add a function to get the allocated size and a
way to zero the total allocations.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 00ee01a14652..f95e71d65f00 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -25,6 +25,8 @@ struct kmem_cache {
 	void *objs;
 	void (*ctor)(void *);
 	unsigned int non_kernel;
+	unsigned long nr_allocated;
+	unsigned long nr_tallocated;
 };
=20
 void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val=
)
@@ -32,6 +34,26 @@ void kmem_cache_set_non_kernel(struct kmem_cache *cachep=
, unsigned int val)
 	cachep->non_kernel =3D val;
 }
=20
+unsigned long kmem_cache_get_alloc(struct kmem_cache *cachep)
+{
+	return cachep->size * cachep->nr_allocated;
+}
+
+unsigned long kmem_cache_nr_allocated(struct kmem_cache *cachep)
+{
+	return cachep->nr_allocated;
+}
+
+unsigned long kmem_cache_nr_tallocated(struct kmem_cache *cachep)
+{
+	return cachep->nr_tallocated;
+}
+
+void kmem_cache_zero_nr_tallocated(struct kmem_cache *cachep)
+{
+	cachep->nr_tallocated =3D 0;
+}
+
 void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp)
 {
 	void *p;
@@ -63,7 +85,9 @@ void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp=
)
 			memset(p, 0, cachep->size);
 	}
=20
+	uatomic_inc(&cachep->nr_allocated);
 	uatomic_inc(&nr_allocated);
+	uatomic_inc(&cachep->nr_tallocated);
 	if (kmalloc_verbose)
 		printf("Allocating %p from slab\n", p);
 	return p;
@@ -73,6 +97,7 @@ void kmem_cache_free(struct kmem_cache *cachep, void *obj=
p)
 {
 	assert(objp);
 	uatomic_dec(&nr_allocated);
+	uatomic_dec(&cachep->nr_allocated);
 	if (kmalloc_verbose)
 		printf("Freeing %p to slab\n", objp);
 	pthread_mutex_lock(&cachep->lock);
@@ -124,6 +149,8 @@ kmem_cache_create(const char *name, unsigned int size, =
unsigned int align,
 	ret->size =3D size;
 	ret->align =3D align;
 	ret->nr_objs =3D 0;
+	ret->nr_allocated =3D 0;
+	ret->nr_tallocated =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
 	ret->non_kernel =3D 0;
--=20
2.30.2
