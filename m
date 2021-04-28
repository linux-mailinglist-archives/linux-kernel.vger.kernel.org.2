Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6D236DBF8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240944AbhD1PkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:40:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58574 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240426AbhD1Phr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:47 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFOcnW011645;
        Wed, 28 Apr 2021 15:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=pOAtICnN8RWvcTovp0LNpWJpT5g2RePGc792/oEh4Ys=;
 b=ycNqB+48g9AOhWbke6GIVeQmqU6NrUXBtXHw0ni3YBOxu/Wuccp7AAK71YLmxiYpreLy
 23gK97vDUdOiE4Z1SPiTUQs5aEA1CraGfmNZMt1bpAFjhvbRjZ4ylfEwW2Cf8omK+hok
 I83BcxnXb/i/HzevM9sROH6/llJvK3gQy6C8eyAkx3EAVQzJeMvGdm3+W/gZ9IGCbEzL
 2kR+MTkwe5s6uxHjTT9HtbDIT8ZWFNeMlxrPnADYkyWQL/Wn4sTm+UqWQaGs3ygD73ik
 dwDnEFjbMkT0eNYvpA+lBMxFe3/DdOaH3wDjXEpz2fkmukThCqCDdVrRP7O6F12hRi3q Uw== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38789105ys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:47 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaAx4018431;
        Wed, 28 Apr 2021 15:36:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3874d2759n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COGmtLOnjLHu26g1Q2fjwqU5J6phkDGwu/9I1lvGEPyhE6wM54Rkj7k9IB7yqEaQ2SizvBxGDWhCJXRKIjZDrO5rH8WZV+/2EmSejMx29w490UluIF6oWiChcTodX2+rcXrE1HEDeyVI0cx5H/2+3B4oIQhB2GRGhmmk053jchd7Z2kRwsImOMkkaDjffwZBZIqm9IiFAQV2zvu5IFeS6z3/3QK/c06elQ0DYb8lsmYOXltaTYZ1u7aRSxzvAwaGUIEzFmtdsi78eLiehrIi8ZN741USy4I/JlZND2HycDo3+tLnZpQYChsKCHYT7s5HIHmrnC5LSu0lkCoVDTASbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOAtICnN8RWvcTovp0LNpWJpT5g2RePGc792/oEh4Ys=;
 b=JrkDjsDLCMOjds+AiDwzIqDAx2Pwk+OYwts8TnMhEBpwS1wVyBsvU4Q+fRvLQkOCz8iaWSWaHQDdYzsm5C1v6j2gk/gF64raezW69uxeh8O4OHsUMgaHdVXxaw/3Lnio3N/zaBVMKprBPaz1ssn7lPbETRWKQYpLTXuBT6nLyA7zf/+QbJy6qj/8Acjr7B71PaUMK2Ctvo7TMdRBQEi+VZIKey9o4imno9EiO0vMmh9twvPDPJij2aGrexKQ02if5xhjYvjZxpQ+E4ki1lfp2h2R2iCILRxgcE6B7CdJkaAQC9BFl+BSmpDPdi3LvPQX46UBE4vg+054aqpwpAfj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOAtICnN8RWvcTovp0LNpWJpT5g2RePGc792/oEh4Ys=;
 b=Cb2fHtONj4FJtz3MvHUL+/WAu7BL637t4yoArSpLaz4Okj6ckJRknPyEG26Yf384O3FnxffZGrrH93SI7vzwND14ygNCd+boqWqIfvejpLUp3gZuMcW53ENmRaHajaaQVCzJcbEm7GWbB6fdnoZ1MQYi6+jKNVZM/DzWOzondF0=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1743.namprd10.prod.outlook.com (2603:10b6:301:7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:36:44 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:44 +0000
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
Subject: [PATCH 50/94] mm/mmap: Change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Topic: [PATCH 50/94] mm/mmap: Change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Index: AQHXPEQ4TcocQKxW4U6QeYGrHr1Pzg==
Date:   Wed, 28 Apr 2021 15:36:13 +0000
Message-ID: <20210428153542.2814175-51-Liam.Howlett@Oracle.com>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ee99aa5-0579-4f48-33ee-08d90a5b6d63
x-ms-traffictypediagnostic: MWHPR10MB1743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB17432F1A55067FFCD2E33C41FD409@MWHPR10MB1743.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:78;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C4eOXWFPRDdjTE+ULb6Uexzy4gx+120XqLDlEVrrwOT58MDFJraiyO1oHsvY34NV9TZ++LaGTF+QYK0A+/zJe8Fa3HHU74ueqIQQQwmdfgtG2bmtIuoCAd4PQfs+eY63/4ic+PvXavK5Ep5sdsRToDnXWHLqPiuAn7zXb43sBxugTjDM/7CRXpUAVElxuwe2i603A/EL6bSoRGlTRDXfM1hc12sZwgdIm7y8+Q+r82ha59Fe0zIRMWThFC/drUjCTC2ZNeOtJ7ld+5ges8X+5Z/ikGS5QNNm0fFKYtodhdJ2MbVWgKK3YWKtz2YGCBdMABcS050t4ar8vubm54reJGiKqH7ryXX+V5mVNPMjLCp4wvcqqeZTdP0r/8JL61upa+Q53qNiZP3/hrjZZKUVe61vm4F1f/QTVG2s2u2bz4Q7v5AIN9DYKHu2HKlTD5XkeeEFfb9YBN3JAirsVOrLl444ujL2FhBHnStw9tk/y495dHuWFHwwiS7Oe6xV6NxaFD74Xaeczw9QDSbWYZ4OQ9GdKTg27BjqwXxnjC68xxm7hoBNJEPp8ehkKPR1B0KiTdsBPK4uheW/Ih9xNul8aNQeMCZXLgjbgC3CQZV0Bs4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(136003)(346002)(110136005)(91956017)(316002)(1076003)(64756008)(66946007)(76116006)(44832011)(5660300002)(66476007)(66446008)(8936002)(6486002)(8676002)(83380400001)(54906003)(2616005)(66556008)(2906002)(122000001)(38100700002)(6666004)(478600001)(36756003)(7416002)(86362001)(6506007)(26005)(4326008)(4744005)(186003)(6512007)(71200400001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?lVrmDBuBmwW42lf73o/iHQDkHnj55InyasQUNdslA/6W5PeBpNh18BYLhu?=
 =?iso-8859-1?Q?cyTj/wHdGmYqG3SpNCjc5AzkZDH84mZIQXbDSYIUJqhfx/1c9w/7vpgMhK?=
 =?iso-8859-1?Q?M+DD38O5Qp/FDmE35NHJ3zJ5WYgi8zjQTu8QSTnUDLy3FPeijxzoKWpAPj?=
 =?iso-8859-1?Q?JKlP1Bmt4eq7nx88B5bb5yKRTyrQCIOXbakHPyy2/coYd2nYty0z2SEHMO?=
 =?iso-8859-1?Q?sleGuKH7RS68kEzyA+VGIN31NZ/f5zOkIGSJziITWLKnfHcQl7K+wrPGvV?=
 =?iso-8859-1?Q?oSMtLIeEEY3ukvYZqWIyi7Tsjuk2LNdoRW7OK1stNu1xgw6UTHvJGqiRm6?=
 =?iso-8859-1?Q?aHQWiQGicPfRLdEqRUYI1WeBbdFa4gUnokGvzFquHNu498gpVXgIhrQXkg?=
 =?iso-8859-1?Q?j91bzMntZbtXdP/LMcq53ObK60m6qi1ULKFGSptpkQo16i6zSmDO5AwJPd?=
 =?iso-8859-1?Q?FDYju98I4+552JLFW1PN4Toz0+pw4jWZ81Z/omak9IFtlow4P+iKz+U4Ru?=
 =?iso-8859-1?Q?8Pk/JUEKO+j+Oc6J2hz5nhIeoBE2wHornKLxRo5yrt9TW22XznHFJvYubi?=
 =?iso-8859-1?Q?Oj08dMtAnt6UKU2M6KovURo+EBe5tDjBuXACb3NYzw6zxShE89PEtyiImr?=
 =?iso-8859-1?Q?33RwsxPo9H7FGQ5qHStsGqSJyiDebfMShQ1nnFyy23g7pubywjMTFsCUoA?=
 =?iso-8859-1?Q?noS2XavKrHFKks8jykC+z4F41TbDnm6BAAuWVDU1CLYL/Ll3raD3LcjLgi?=
 =?iso-8859-1?Q?K88oit5NiOaXlUcjOOb1rRl+0EjChqdDgOhrqOEH9nYM9aWXt6tDcXcdl3?=
 =?iso-8859-1?Q?+p+r6Yorc1xfmV3huru7w2haPLYTEN407IX0aojeXSKTecNJNXppvsM5jt?=
 =?iso-8859-1?Q?XjVyCuaGhGUEGDzKcxmGuiyblZvvcRVAa2zOvv+UNDoMyr9ZokQaHFQ/DC?=
 =?iso-8859-1?Q?P8G6JWysR7kjEp6ZrFRSsalmThCPkaLbrloMF28QPCRaTulaUnFtoGvACK?=
 =?iso-8859-1?Q?J4Z6ecmo1STNIZnAY6QhUk3JBaoC8njWTYZDhlb0YO1qXmjjAkALiRHU/u?=
 =?iso-8859-1?Q?xeByDybvXFG59QzpwJdMZ6qK11zWIlyo2ibveJ5Uzl2Hkjt7gofTp2Lrvy?=
 =?iso-8859-1?Q?mkPNZhkjLKiXOfEqBPB5d4ktIPk7kd993qqagWSrY6G4St6f+9nYQZg4Ke?=
 =?iso-8859-1?Q?GIxquv4FnkoxZ1WJkEPV2kaKK1nlLUPduuvYbN6CYtFqwG05q7m/L+JpQs?=
 =?iso-8859-1?Q?kCSZDmotg7ha15zAIaEyrtSCXek6rmWiBQCGFPUpeantDiaYSqxhJHPsuB?=
 =?iso-8859-1?Q?TiDHaOk0kEmQd6zsbReTR3Snu3KBmi+SdcNiWSO1UIgjTEz/lM+sN6LEOq?=
 =?iso-8859-1?Q?bwVkFjIajO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee99aa5-0579-4f48-33ee-08d90a5b6d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:13.5601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmb3QtaPzzpRHoB/0lrnVZgZtuRGqbBkhJanUArSKcVKsjjhsPBC+Ufkd1XRrg3SMb0Vu6IXh0y9hsqD+jGZ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1743
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: N-jNb6XYu-S8Qe0Emom5P04nlNfJbC0V
X-Proofpoint-ORIG-GUID: N-jNb6XYu-S8Qe0Emom5P04nlNfJbC0V
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_brk_munmap() already has aligned addresses.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index cf4aa715eb63..3b1a9f6bc39b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2965,12 +2965,16 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct unmap;
 	unsigned long unmap_pages;
-	int ret =3D 1;
+	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
=20
-	if (likely(vma->vm_start >=3D newbrk)) { // remove entire mapping(s)
-		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
+	if (likely((vma->vm_end < oldbrk) ||
+		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
+		// remove entire mapping(s)
+		mas->last =3D oldbrk - 1;
+		ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf,
+					  true);
 		goto munmap_full_vma;
 	}
=20
--=20
2.30.2
