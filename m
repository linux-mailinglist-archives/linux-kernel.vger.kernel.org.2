Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914C8421C16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbhJEBgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:36:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9894 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232739AbhJEBeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:34:16 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1950qIQU029448;
        Tue, 5 Oct 2021 01:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8UgJhxq4bvRjoM2AO1Vh7gp//G3UrjYOuanRRs1gztg=;
 b=OaPamXSni/ZJTuRyjPZfy9SqzXy7rbrnAFUvltNl8MjI3pV5PbURxyzfwxwNSDkT7NCF
 Rdslxku8XrYR06lTXq+7MRROxb4bvkDE0amvEENmyhENra2r47H5VnUaGQIU+ZloMAR6
 6CTdyY8AbWpkKY9GSCBqeN/ZdZKyXV0lO81lON5b8oezYxejjmaj9eTawIYAze4GNS8u
 lycojyykApDAPIBS18wsELe7+OwLLZeWBrJE9AEkJpMnApyttXTjr++wuO9Y9nrBFoBJ
 ikEC3j+ualYqep1kJVl0JcC60RsXNYdR9jPfAvr7K6sn3GG6sndqk5kCfZ++eQXiTtCB kA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg42kkyjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:32:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UIEm178435;
        Tue, 5 Oct 2021 01:32:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3020.oracle.com with ESMTP id 3bev8w03ud-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:32:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndhHEBVEWcGjh8kDgrxrcCKS3f96e4oTmYqbJ7Atwh71+EXTrsi3WVKejqTyXDKkMkxCznNj+UXIfFOGUJm1Vyl5fEH823HbuE/XmjGVET/d2TSdLJ43amqVRJXPIr4n/QexjhxJRDLBn/L2WdMaAOXNsGf1z0AOh1OHpkTMs+I6WBCFeH7SoLAcO8fMRL0IZmwJxw46MCdATFVdXFJG4siq3YlP9xZv5rAYgfQOC2YqDLbfjl2AAh/HjPb4ZOAxuMqOhvT5yw18lOVGaD/8qgw6rWNPCZigeEL9wSHH8wM1570Azq3gb1MIjz6akvV1wqap8icm/dwYUGgyLYqCkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UgJhxq4bvRjoM2AO1Vh7gp//G3UrjYOuanRRs1gztg=;
 b=kwjQ4YmGHBaAQ/J1RYcnXU+s/Ab/41oMXbBI1jrYOK9Zg7vOvxmvZzaacayQZRpCEIvU/+xgSXyzy+IQI3WzoxFIe/G/G1lNiwcgboVdZMrR+2jIQkQYEXrLerEISKzIdN0eJe05R5FTLmcjvVEDY7MssuoxZAklG34TmEY7JAji6AP0h0IA7ecPo3+WJVKQguMzfeuKmlAKP5r8MMj+TjBGbvheECSNwiHVT78scy1SDLrNeHK8MbQ+ru7/IyJ/YAqHI+AHO1b5O51vJ8PVFqp2a06bml2h2/i/3G8sGFhF6Bn97zrPBswFsE+jRoZQD4zuaQsqavgPN/eLOS1PGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UgJhxq4bvRjoM2AO1Vh7gp//G3UrjYOuanRRs1gztg=;
 b=iIVDr0LN3yk4X2DNInB1UF8h2QXh2gNDcyvxitFvBOTks1tp+774wAs5EDC8DGt1+udQe8pYcslGi8zS0x+rq9yd848J5lmWD+Rm9FiT7P/Qx2N0UpYk0RmKReOae8KxEUVme/lL/aFNoZy0d3jRJZGbbKERDmrTRO7uoemzGzM=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by MN2PR10MB4288.namprd10.prod.outlook.com (2603:10b6:208:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Tue, 5 Oct
 2021 01:31:59 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:59 +0000
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
Subject: [PATCH v3 66/66] mm/mmap: Drop range_has_overlap() function
Thread-Topic: [PATCH v3 66/66] mm/mmap: Drop range_has_overlap() function
Thread-Index: AQHXuYiwOR1YqepDFEOTQIS5Z7Ktfg==
Date:   Tue, 5 Oct 2021 01:31:16 +0000
Message-ID: <20211005012959.1110504-67-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 98c510d1-80fb-4594-8ad7-08d9879fecd6
x-ms-traffictypediagnostic: MN2PR10MB4288:
x-microsoft-antispam-prvs: <MN2PR10MB42886F6A5A5DA18DF689B571FDAF9@MN2PR10MB4288.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /sGY37CmSrlKyqHYDFlyR7wQ3prX06vhT0Pgx0EhTmY7Ct+BAsh+U1aI1Z5MyrlaZ/MPOv74W0hD8WIhf/KKMvmM7kFejn6nxQEpzbUSde5i6mW/fAIqdi6NvdxxiR66ily/vgjA+2mf67fpIStLz1TA5C+JGHngy3a8X/FwOKc6eOASL4lDZabvfkr7MwQn4OuGIuQ+EW19syOI6uLEENDS/G98z42WQ968oq2hGB0d9XsAUavnEQ/zJ+2/zG2xme8MZ5GcD4pMotONvpNPfqArlo1UREdmp4xjoYCUWn2wPcvnedcQnfYF4vsirpE1YWiPy+hNYvoXGNa26AV7PuHW6wh9NaVAEFLUBIwCGyKXv2gyJQXHNojcC4X8dtd07Jg/et8qlc03d7MHBKw7PP5nyLTpONN92AtgGu2o/C/gYDQAvurT4uZansyh2dBqOKYvM+gUCIp4Y/fr6qKU1dbjPRCOnZuDw9adHPkAO5fIP0gTweZkK8N2R2psROf5uQK0/o1FzeBug9zJkHsulORZxs/+roWSobjLnhKYKu3kDqhdCBEgIu1YtkmOPEK0Jg2c01b2xTngV60ZnDCInTVG5eGuZQWSCRKMJaroVYtGvSvazNoMKAJvWoswSS/5+1pzS8yQQCcMA2gN6UOBCR6Ly30xtmVjh5KimZcL+P20OjRsRjViYCS8u+d+UnWiOpdLLaybQCCVz9ACW4d9fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(38070700005)(71200400001)(8936002)(76116006)(6506007)(1076003)(122000001)(316002)(2616005)(44832011)(6512007)(6666004)(6486002)(38100700002)(508600001)(66556008)(66946007)(66446008)(26005)(86362001)(83380400001)(5660300002)(91956017)(110136005)(4326008)(2906002)(66476007)(54906003)(36756003)(7416002)(64756008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LEYeZwVrmA92Vh75H2OB4OSHHS9xJlTv57addyWjYbjxYXAwV/Ur9XTEnV?=
 =?iso-8859-1?Q?qPSk9gdP0EfsUWHaQbIXYQCWQOcGESqQeM7s7GHfRW0QTCzdO8fQ2HNab/?=
 =?iso-8859-1?Q?OIjUXZfQSrHvxd4+n4VsaeJ/BZ6sdZ3A6RMC3CuE8bjBsuQkzJT4g0NlBB?=
 =?iso-8859-1?Q?z1X5XL/Hiqfwz86DZotYH25hvgUuHBFhwPpuII2d8jZipDXcGd+kYH5pGE?=
 =?iso-8859-1?Q?p+cf5cAiOlXR0AqURx1yTtOBE1X+Bz+BRndHvS6jsmUk/o3c+y9e7OqoaC?=
 =?iso-8859-1?Q?jKXsP9vEH/1G4UADa7UcBLz/tJlMkk9S5KQj8+QcxZ60pg4gTh52TjawKi?=
 =?iso-8859-1?Q?kuws/IIT31ptiBRHgYDPoNiIzY8Eu8Y9k6Plgw1mgl9i2cEgnODu8+9Fux?=
 =?iso-8859-1?Q?Zx0eI/z4o7r1vEcp+ZBe4XSaPlbyzD9rRyuGp5lPC+QtoqYs7gyfsdHmkO?=
 =?iso-8859-1?Q?6RoT0syweD/doQY2+Iwf3tBjWJMCXWVX1EQFyr3z4lZC4CBrgDRzzFqpwC?=
 =?iso-8859-1?Q?QZdmksxHjYc1Bpg/EEsyVTWyN9fdkx7tfiRXuJahoBYR/iAX0oww6P6Vsb?=
 =?iso-8859-1?Q?x/lzKmSZVgD89+5OXwS4Cs27AksuZUeOLO+5JPTf7suu7vv9hB+erI5HuR?=
 =?iso-8859-1?Q?i+sffRXx1OZfSmq6iLlvCKANUqYsxYpiKRP5JJijxJuvGBl0lHJgYxcFQw?=
 =?iso-8859-1?Q?LBReocMuYb2Ef8cqSPpObGFvmigc/7y82U5Q31mb9Sicfqy7RJSJ3IyA5N?=
 =?iso-8859-1?Q?lZEu/JckZ3e0Yq++WRKQJAVdr1zsXR0YV6ynbnzb0cd+KPRwWuVDkATwqM?=
 =?iso-8859-1?Q?ThT6NmhwjQjH4kac8LAE6tOO1mhhVcfXcYs+1Fm29wyU8h4IU2mT2CLGRA?=
 =?iso-8859-1?Q?Pdx1CMYiSNPl9dar/F7oefFZuDHqQQH3ur0MrCVnWOOGlGg+NEUmuShaIk?=
 =?iso-8859-1?Q?kZWyShuZR0aWKCWp+9XxBe/VwCruzNegjdzZsfUgNfkXghZ/JhQtODXgYa?=
 =?iso-8859-1?Q?uEJ7uKL9ET3cK9U+OmeqShX1WMmJSDBk2fbAWsLwiCoDwpKk7sgOSAhyK8?=
 =?iso-8859-1?Q?DFUMTF6klJoZrjRLdwN6NlMpLVf9fePTEizhYWwOTBfv4YoJwSOSAulsYh?=
 =?iso-8859-1?Q?5xAHfMuIxqzgn9MaFKUZM69ikqnTCrbqQq11JRd+pTZ60x5r32jqInDE9N?=
 =?iso-8859-1?Q?8z3DmY/BKwlFw38qYVwKbxqqkIy83jolkoWGozaTJvJMPlT//bqZRqL6Uq?=
 =?iso-8859-1?Q?L9lUnVXh6Jw51lHFiBPlCT9LN/acciRKV+2FTxb1eWaqWUYLpHvf/eSyq4?=
 =?iso-8859-1?Q?7I5rBXjsRkQkUFfamJKGjoC5yDOU0N16DsUInDj0O4uBFRnPVub1/NRO6i?=
 =?iso-8859-1?Q?TyDbw4dR6c?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c510d1-80fb-4594-8ad7-08d9879fecd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:16.6001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+3GstVL5OLeJbZ/W5Oe6I7s9+sW3rtoxuSZ7KFOVNHZvB1pC3vybLiGZBR1b2QBwpd7geg7N1k2G7yCyJmiWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4288
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: B9ST42veZhtJnVV4pJ476vNMficgHCHw
X-Proofpoint-ORIG-GUID: B9ST42veZhtJnVV4pJ476vNMficgHCHw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Since there is no longer a linked list, the range_has_overlap() function
is identical to the find_vma_intersection() function.  There is only one
place that actually needs the previous vma, so just use vma_prev() in
that one case.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 49 +++++++++++--------------------------------------
 1 file changed, 11 insertions(+), 38 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 51620d545021..39929b20ef9f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -433,30 +433,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_=
struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
=20
-/*
- * range_has_overlap() - Check the @start - @end range for overlapping VMA=
s and
- * sets up a pointer to the previous VMA
- * @mm: the mm struct
- * @start: the start address of the range
- * @end: the end address of the range
- * @pprev: the pointer to the pointer of the previous VMA
- *
- * Returns: True if there is an overlapping VMA, false otherwise
- */
-static inline
-bool range_has_overlap(struct mm_struct *mm, unsigned long start,
-		       unsigned long end, struct vm_area_struct **pprev)
-{
-	struct vm_area_struct *existing;
-
-	MA_STATE(mas, &mm->mm_mt, start, start);
-	rcu_read_lock();
-	existing =3D mas_find(&mas, end - 1);
-	*pprev =3D mas_prev(&mas, 0);
-	rcu_read_unlock();
-	return existing ? true : false;
-}
-
 /*
  * count_vma_pages_range() - Count the number of pages in a range.
  * @mas: The maple state
@@ -554,7 +530,7 @@ void vma_mt_store(struct mm_struct *mm, struct vm_area_=
struct *vma)
  * Must not hold the maple tree lock.
  */
 static void vma_mas_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			 struct ma_state *mas, struct vm_area_struct *prev)
+			 struct ma_state *mas)
 {
 	struct address_space *mapping =3D NULL;
=20
@@ -574,8 +550,7 @@ static void vma_mas_link(struct mm_struct *mm, struct v=
m_area_struct *vma,
 	mm->map_count++;
 }
=20
-static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
-			struct vm_area_struct *prev)
+static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
 {
 	struct address_space *mapping =3D NULL;
=20
@@ -600,8 +575,6 @@ static void vma_link(struct mm_struct *mm, struct vm_ar=
ea_struct *vma,
  */
 static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct=
 *vma)
 {
-	struct vm_area_struct *prev;
-
 	vma_mt_store(mm, vma);
 	mm->map_count++;
 }
@@ -2760,7 +2733,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	}
=20
-	vma_mas_link(mm, vma, &mas, prev);
+	vma_mas_link(mm, vma, &mas);
 	/* Once vma denies write, undo our temporary denial count */
 unmap_writable:
 	if (file && vm_flags & VM_SHARED)
@@ -3137,7 +3110,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
ma_state *ma_prev,
 	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	vma_mas_link(mm, vma, mas, NULL);
+	vma_mas_link(mm, vma, mas);
 	*brkvma =3D vma;
 out:
 	perf_event_mmap(vma);
@@ -3289,9 +3262,7 @@ void exit_mmap(struct mm_struct *mm)
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
@@ -3315,7 +3286,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_=
area_struct *vma)
 		vma->vm_pgoff =3D vma->vm_start >> PAGE_SHIFT;
 	}
=20
-	vma_link(mm, vma, prev);
+	vma_link(mm, vma);
 	return 0;
 }
=20
@@ -3330,7 +3301,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	struct vm_area_struct *vma =3D *vmap;
 	unsigned long vma_start =3D vma->vm_start;
 	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct *new_vma, *prev;
+	struct vm_area_struct *new_vma;
+	struct vm_area_struct *prev;
 	bool faulted_in_anon_vma =3D true;
=20
 	validate_mm_mt(mm);
@@ -3343,9 +3315,10 @@ struct vm_area_struct *copy_vma(struct vm_area_struc=
t **vmap,
 		faulted_in_anon_vma =3D false;
 	}
=20
-	if (range_has_overlap(mm, addr, addr + len, &prev))
+	if (find_vma_intersection(mm, addr, addr + len))
 		return NULL;	/* should never get here */
=20
+	prev =3D vma_prev(mm, vma);
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx);
@@ -3386,7 +3359,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 			get_file(new_vma->vm_file);
 		if (new_vma->vm_ops && new_vma->vm_ops->open)
 			new_vma->vm_ops->open(new_vma);
-		vma_link(mm, new_vma, prev);
+		vma_link(mm, new_vma);
 		*need_rmap_locks =3D false;
 	}
 	validate_mm_mt(mm);
--=20
2.30.2
