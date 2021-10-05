Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6194A421BEA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbhJEBdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:33:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34848 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231466AbhJEBd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:27 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951DWvF019244;
        Tue, 5 Oct 2021 01:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Jbw5atURRhyIIzaH+ltrvXt3bxGqwb4c9lv39LgYV/k=;
 b=EdgET/QsdMWcc3wnlHO5l2ivmYDAABz+kKY/0hi5bzMygJ63LWrZRCX4IPpujPSwSrys
 cKPr5zpWjX86CHAJm9FJQs7Qd/gYA6PvBLOh00JjmI/jTeAhjvEs2k0VfsUUQz2dOo8U
 n+O1RwKosDYf/NKHSW3JwzOv2AkWNnFmhVbbLfoWkbz7fQYLp56cY/+lu7M4EZu0cco2
 OwZTwLS4tLLJV5pqyTgpNlUzgLK6JxZDg4rS6aBlosJ1kXqaefFCb2ztqkG+EjB58b1n
 30VxispIM7OSqPHrGvIhRRyyPJ9MJvnwFn1jq8R4zhlq3kp+GNziiHmH3YlCj+Yk6Exc Iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p5c99m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdG9141646;
        Tue, 5 Oct 2021 01:30:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3bf16s9duq-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCRC4/GEUCF+YJYOfuDUIhMUHw5c0LtPrg4xhFtPhsT+YSzd2L24c9r0WYQwzol082VlzFcY0FyTX0MXoLOrpKtdAeWqoLCecgJtoFMqdI6KLaIjXQInvoYxZ9D3ie5DmvRVx0St4OFULzrAONbEpl441CwH8K7xAjV3TE2DUsnqND0qzFLDIoqAoU4jILxrafm4im/z8O3+mdvjENsH9GdLuLZBt6Q9d2Jpcxq/qA4D4d4wtf3eXQf2d+c3scl+KxBTiCVOAutln9UIK4yZHSDzeg9+LWsxoWZoScLDzw4hg59DczQKPNasjX+X/WhaTtCDJTDNV55gFHhxqHrWmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jbw5atURRhyIIzaH+ltrvXt3bxGqwb4c9lv39LgYV/k=;
 b=RUSuYGQjYAVxa2k0a+90PorXe+/99VTVkGCcdIPx15FevfXrJn27Wmn6ybhoaDyPSfSER7Xr7aIVsZNL6fw6iImGAtnOk5pXoSYniVlctiMud47mlw+VlXwlXESwd+zUrMibiD4hNsuLGXFGATYNZzn2hVJs3/qby07RyFye2I3hmQTrL4ee3bV5zyBZyDpX3NxCrsDUHMpBetoFOzhn1zqdMsKywwW5lzXVUr/KgTzkXSb659935zWRiSSjigagj1LstG/oPYPYx8uOo8A7xCAa9Gqzu2q7NkuflqDN9lItQ40P0tekpojbfUrMla9L7AW9jzNcAGcsPMtGgtBhfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jbw5atURRhyIIzaH+ltrvXt3bxGqwb4c9lv39LgYV/k=;
 b=b6chhA5igM8OOR9UEK3n83iwuRDul7poFphE0DEkC5BeAui3z1j48kdjOHO5K4yyhp4fXzU/nQrNBffB6fjbESdlkL91hZi8ufgZyy347u1P4krU9FHYLwIqU5f4uPcS7CThMrjounfhl5U1r+yA5c734GQldSKdkU5CX3s8wX8=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:47 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:47 +0000
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
Subject: [PATCH v3 26/66] arch/parisc: Remove mmap linked list from
 kernel/cache
Thread-Topic: [PATCH v3 26/66] arch/parisc: Remove mmap linked list from
 kernel/cache
Thread-Index: AQHXuYifKH2VMm4LekqeXR5XWBpKLA==
Date:   Tue, 5 Oct 2021 01:30:47 +0000
Message-ID: <20211005012959.1110504-27-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 9c533f62-4287-4950-59f9-08d9879fc222
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044AD6BA3C2DB3E86570F0CFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jGu4ufga1Xujd/gETZgt36PE3yBKhNm2c13mC0Yey9QFhocZwxRduP+DWgDpkCwKPvI+tE2KRGrCXYto3cLDwrQ2GqzqPjODFFAhXIB1mJv3qQjGJdQqR27ylBbDu5ZsdjpTYgS0u1ripluZ/4g2qRbeAABc1Bx6bpyp2aAhXOd1P2lRZ1oJsOvpcO+adlm0DzZVjTw13TPyOvPkOuFByAwoYXlU8hbZtEC2/jVUKGjP8w4JzhBciGBb88AL15kgbt36Wx4JKA9W7Ej8+/bxn+rR9k7qhkgLr3GOQH2jzcSgvSTHrbWvMZfbAhHNdX3fKLkbYeG5NoxRw5D1IV9fpJrm3DhSZq8H3v+57kVCL4d5rX4yZudvVTh/xrS7THIh8D6pnWDrywL9I5UNhHWKeR8YNIG1g4u7t+ANeJmluvgzUl8FTUKPpczDRuQH02DzlW6IK5HWO7tAAA3ipTq7gbJNd0e9C6T4f+4K3AgJAYeApHmy9ZNKTLFC3vsQSwVVyjGqcJ/D6xdpMswmm3wJWss/9NfNwSjRIYb2HQb5vkZWpH9lub+RDxwWuvYxGPFGKRYbmFRafEkrjO9YLtOi2FhBeHZqMDHeNsNSp3fdACzXIDapOvYFfuodTessa1V6YPYUXEVA0ADBs5/zpUPZeGm1SPwHYKdOjfluH/1fZyJruckcOaWjzj3jI5j0DTA2Lu0ZV/bWS8sivw0YTxGa6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(6506007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8/liNkspnWr9UaZbk3MrStnSDsS6jp6A0C7oa2BjkeyP1y5eeLMxoiDW9I?=
 =?iso-8859-1?Q?CCp56pnC8Sx+1TOW+WwWkhb+gpZjmlLFkLcErTR4zMJd4OxEFCeMn+QL+J?=
 =?iso-8859-1?Q?r7AIo6gmNrRIFbhlcT+RhP6X/OY/u30O9JeB7FU5R210pZHJA6LoSE2Nju?=
 =?iso-8859-1?Q?P7lw/G5LK7mmP3vGH+/KGatk57fQvYtEjMBCekETHUSpuZAHbyM8A/7VT/?=
 =?iso-8859-1?Q?g1yeE4tfs4l5N8EhthQvym+3nTNoMhQf1a1518zTOB7bSEy0SVragtZVWp?=
 =?iso-8859-1?Q?3LF+U5tjNevF8ppYn4T4aS6vtWELI6q65fk6QjubsxXF49VJ9hzs0cxcFZ?=
 =?iso-8859-1?Q?KhDu3Zcj0iysN+SlYeXpUFb+F3JibRbMefLZGIwRjlXEpxkptxaxK9zDqB?=
 =?iso-8859-1?Q?Q6lvdMda+VSJrHQxDF+jO7US3JG8s3MKDAEXxsZvcNdbXSCB55Vlmd4daE?=
 =?iso-8859-1?Q?KuWQUPzburbFIM/7/6TC7BMXGMqJo4NIDlqrPibxe7Up4SsgWStF7OCsGr?=
 =?iso-8859-1?Q?MocmFGrJ55RCAJuy+6yclPpeyWHnfBcXy+q2aivRSFmh/X8gauMGylRMT8?=
 =?iso-8859-1?Q?q7BREqqgIqUOmeww6NAlW6ak0/WuIkaq3FndBakjhU504c8HRoqjuuSsRo?=
 =?iso-8859-1?Q?dxqFFy066Lsh01mBuWKPaR4heUN/rtHixE8ShAjipCRFgNRYL6LD3gmsRG?=
 =?iso-8859-1?Q?hk3nWeSEzeag7pKHA2betTb7/jXQVH/qHrYPGEdyza8zolwMSdmjGoZkSy?=
 =?iso-8859-1?Q?+vUzFqqeWdd8pV7Jvp7b+aSjNkHIBy+cbDrrsJCHLhzv1guia9t7KnIr5r?=
 =?iso-8859-1?Q?/5Fkx5yTTXyg0UxSer6oTgSLvBLyNfPWtrbz2FZKIpA/XqBB6iKQ92WKD3?=
 =?iso-8859-1?Q?zmfJKi/1FW3VcpoCc49Q/QVEqXvU/7mhgvknRkTIsbmpu/ON1ESXyEdqcv?=
 =?iso-8859-1?Q?Joi09iuWCPmEdrSfAxVAyS9B90wSamYEwAs28xCgB0Fc1umr3cyxjfksyN?=
 =?iso-8859-1?Q?sRhHJRB2kOsUStnOUe3Q4ECkDIpXqb/gVX98qP1ALtQpTEZav+ZosKp4Ig?=
 =?iso-8859-1?Q?ytzVnTDLHD+RbFbuNdb8HWONYrJeAniVrjmOhfzj15Co+QX+IKSeZq2udl?=
 =?iso-8859-1?Q?brwPLQum+4AC5naSssDv15PYoxS4Iw5xqvyT8vs7KOxevnmC0uLqUz6T4r?=
 =?iso-8859-1?Q?N7PmyLl8N+ByHrmEJyq3IURnbr5m8Y4zrMJWyf7u2RyimM/IsUo1iZ6RaY?=
 =?iso-8859-1?Q?n/t0Pn5X59FyNy/bQPg4xJyG6PHajGibOQM/hUUPYZyOB32YpuigcwaDKd?=
 =?iso-8859-1?Q?r2MIopvWJjoHbEDVZlN/Np58yaNAeReVbl711H8+WgyRX0OwYq3+ZBzkDe?=
 =?iso-8859-1?Q?pnGAuXVbst?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c533f62-4287-4950-59f9-08d9879fc222
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:47.5047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5dCzw2j6uDRWVN45HCo9XaTyzOWiC/L96vR+ofofKmCPuQzw8pf5KNdakKNbBA54nWqPzLWu5AIYRH8mqfQg4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: G9psPwkcUryzvF8PBQ_GPTOdBPfWIR8b
X-Proofpoint-GUID: G9psPwkcUryzvF8PBQ_GPTOdBPfWIR8b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Start using the maple tree

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/parisc/kernel/cache.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 39e02227e231..f6316aafba10 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -519,9 +519,13 @@ static inline unsigned long mm_total_size(struct mm_st=
ruct *mm)
 {
 	struct vm_area_struct *vma;
 	unsigned long usize =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX)
 		usize +=3D vma->vm_end - vma->vm_start;
+	rcu_read_unlock();
+
 	return usize;
 }
=20
@@ -547,6 +551,7 @@ void flush_cache_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	pgd_t *pgd;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/* Flushing the whole cache on each cpu takes forever on
 	   rp3440, etc.  So, avoid it if the mm isn't too big.  */
@@ -559,17 +564,20 @@ void flush_cache_mm(struct mm_struct *mm)
 	}
=20
 	if (mm->context =3D=3D mfsp(3)) {
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		rcu_read_lock();
+		mas_for_each(&mas, vma, ULONG_MAX) {
 			flush_user_dcache_range_asm(vma->vm_start, vma->vm_end);
 			if (vma->vm_flags & VM_EXEC)
 				flush_user_icache_range_asm(vma->vm_start, vma->vm_end);
 			flush_tlb_range(vma, vma->vm_start, vma->vm_end);
 		}
+		rcu_read_unlock();
 		return;
 	}
=20
 	pgd =3D mm->pgd;
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		unsigned long addr;
=20
 		for (addr =3D vma->vm_start; addr < vma->vm_end;
@@ -589,6 +597,7 @@ void flush_cache_mm(struct mm_struct *mm)
 			}
 		}
 	}
+	rcu_read_unlock();
 }
=20
 void flush_cache_range(struct vm_area_struct *vma,
--=20
2.30.2
