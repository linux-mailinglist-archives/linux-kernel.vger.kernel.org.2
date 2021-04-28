Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DED936DC04
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240707AbhD1Pk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:40:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33750 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240578AbhD1PiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:22 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFLhoK030867;
        Wed, 28 Apr 2021 15:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Ahe7F6uwMJgZ1Pp3GPc7Csjr7HGZgZAR0aJoghZWIuY=;
 b=dxkaV1Pb4y+E9d5wZAxfMFt0CP1ZiNKs60bAoHgxyhl/XGd1QifiHthjvhiJSIzqM3B/
 xeaf+adf3WJR6hZuaUwr9e/FLWdJhzZWy9IPqCM4Y5ncqpGhpH9bJ42SbvBfw6VDcsDu
 An0Yp5XkPCrOiyX0JJ1Cq2XeaDr4dyx0y1/ijUVckviZIq2lXZjWHk15r8Xv9VaHyE5h
 TzZJxWUMS4KoM63DGhiOIiuYLNoh9CoSgkaZqcPXbKFixnwPzCpNVTEuotCTpMCsrP5z
 HeUmCUw4WPD8yfm0kFPmUe+2M+oeDUBjKJz5wLzLKGaToY7M9tCI9QnlNjZF4gQ00t23 sg== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3874kn0eqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:23 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWZKM146776;
        Wed, 28 Apr 2021 15:37:22 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3030.oracle.com with ESMTP id 3848eyqygy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4qdkUufED+EEkyj/W+QpHfQJSPzhPFpLIm8xwjCDXt7rh09+7xJPtclGeiueGV0JJBurpw0bCMzOejom4e5LL8+T/Fpz0mIzctUHQWRwyp36mYDMFALjaVMRgr13ionQr+yGCRI69LB81YU4JfzJ/TRWlVqaBZgwYuFClt5QQxwr+8UiZDK4AVhYRrjz3YdhWhq82miTIGQi5CY3spW+WvMOXrnUaEizPMhm2Lo5kzc5zErZ/0Xw/fXmPcQLLEHJ4noE5qCpsIwBlB+CQ13p6d0GtFRAE3nwfEiQiNkzGIUCMtKROUfi3f/ndNRFw8UuJe5jiXK+Jsvxwc5UGLNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ahe7F6uwMJgZ1Pp3GPc7Csjr7HGZgZAR0aJoghZWIuY=;
 b=gvFqZrYuJkSitsH/pAGcfGu32Bt2pElKHVnNkDWw0dXFpjeoYOkhJwqIwXcXDLtIKJxBzWh+j8eeJfzqos0Co7eH7FNPwnMeZAJjUzTB+e0Vz42ENDiRd0HmR1B/+okcz3f3qTzvgKcVQi6d0AqJEJ5NbRnafsLwqtFro3xhAnH1oYpDCEhDzz21Oik9qFoYok4zpRN15KmH7WNkXYvQ3/aAZgcm335M+11/4qqEFCOofbmpeHSqJxl2yJEHDPYzI8+4vAjnjhGGK5boG/TE0l8NCsNyKW3VD203JndKoJG0M5aKTtt17glo70fs8aev9B1WbDgfd04ZtKLt899N+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ahe7F6uwMJgZ1Pp3GPc7Csjr7HGZgZAR0aJoghZWIuY=;
 b=tCPLr4EuTZCKUgHcyR6RHwR5r7AKJWQsyzK/KaS+PE9KZqdtEqJYBZqeEys+G3fqTj9TZpFhhH4SbLhUkS+5zQtj8XttEoEWIoMMtLJ7KvczRzkwwar3ygKUcSyeNlA2wJtSR3Q97dQLd5L7Z7ci90I+1wX/1x/p0CeD/izm7PA=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1871.namprd10.prod.outlook.com (2603:10b6:300:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 15:37:19 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:19 +0000
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
Subject: [PATCH 60/94] drivers/misc/cxl: Use maple tree iterators for
 cxl_prefault_vma()
Thread-Topic: [PATCH 60/94] drivers/misc/cxl: Use maple tree iterators for
 cxl_prefault_vma()
Thread-Index: AQHXPEQ7f7mwLlwXLk6SPq2C7tnu0A==
Date:   Wed, 28 Apr 2021 15:36:18 +0000
Message-ID: <20210428153542.2814175-61-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: aa8d56c3-97f4-4548-8636-08d90a5b821f
x-ms-traffictypediagnostic: MWHPR10MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1871BD15D3DAB7FB1D2E953DFD409@MWHPR10MB1871.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: edNLUH/CyX2iDM0Rm7jZ87m3waGublkvcR5LTRIyBaSZkS0K71vxWIA4yWNJJ32g6ml3/ldFo9quNZyB5cS/eCgzOAIDdPCyASNvAEx+SLfB8/c+4N9KqchAtiww63jYSwj/jK0uqsKqRSxwEGYW+8CjAYsHrl8FV+Zft2hzRQsXdRpzV+SiHGfqrcz0b8pDjSWfsuMn9yf0tYeliHBMKFMEg3OOzk3tSqQbYtGqMgsqLoNiKVIcwfohZFUsPp3cskVvLD5EHjBOlf1jeBbbcAGogihBmZj6nejl39xoMK1c2db4inntYPWYfX3AyR/qG2VVYpwcDuqcqb/iSBzWwO9WiPGRpP9Vxc1XekBBBBaRSA9pu8PMLAMdRFCo5UdAJbg0T7AGDVlL4SL1hssMyr7uaeKInsFQ9SfP7+c3JAlg2+hSXzZX2R/Ur8TMDPCwDWGAwM3ZOa0LsjwMZfaEv4ffuyqy2opgifSvG6Q3ePQhDST5v/P2u6iGab3Ft4oMgE6QGBi2WUwDoHL8WgUPTtTiIQbk77m43WgydeRu8IWXcGu2IRsaPXNJ4fbz/wh243Yhy4IJKUnhHv3JkzwSwh/CS52nrJLAn3Ty9u3LOYI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(86362001)(186003)(6512007)(66446008)(6486002)(66476007)(316002)(107886003)(5660300002)(66556008)(71200400001)(110136005)(54906003)(478600001)(44832011)(76116006)(6506007)(36756003)(7416002)(26005)(2616005)(8936002)(1076003)(122000001)(38100700002)(83380400001)(8676002)(66946007)(91956017)(4326008)(2906002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?HUG76rywkzS+DxadEvLY9ArQDQGdMjyIwMeTMhk/Hn92Q70b/IL0r7r4An?=
 =?iso-8859-1?Q?VspWZMYVRopOqzs3eOogH2O73IrgUK4aBwhKKiGllecOeZbu7lPsab0KK3?=
 =?iso-8859-1?Q?86HPcMETo/z+1b0ENarvK82S64Oe9lhbMyK0hbXfS4W22swi0EVSAG/VuV?=
 =?iso-8859-1?Q?nNBWJydjUh4tNPanbuY7FfDvdfa2wJg+drosMkjNJX9xgDcYbNy41plX/8?=
 =?iso-8859-1?Q?FGXLigpbV9xelS1Zu4i15a0mF23sKQdHi5H5WH04fUmGvMwTORsqHSOjrB?=
 =?iso-8859-1?Q?gEtGHgFpwHOQ8sgEt03sMo7pOp2bh3otOfVoPC7LyqrxRf93ykdk5d3bKr?=
 =?iso-8859-1?Q?06vPbmmvs1yZbnbUGfnB659XGAEq5OgwtlnPwSL3PNVXRRdM5YfEKtFnn6?=
 =?iso-8859-1?Q?Xnr0zxOiMXeYLuD0K7G3DOk7p86Gq+jpYuAG4PGMxN6XAmmJn0SVXl/6bh?=
 =?iso-8859-1?Q?kIC4AXVOLEWEoYO/bunhmTjyRaT4Q/JDslgCHMg1geHjYtjRW4XKcr8ICj?=
 =?iso-8859-1?Q?Z7Dc23DSmd9MK9zjFhpPPdCnxGAsScr66ZvJqfvhznirxkmtX4a0Hixj7Q?=
 =?iso-8859-1?Q?Aq49Q0lTFIAi3vlxzGIMDSyGHTXUoIDvdRfdHxzp7s2CHW+KiO0h4i5caH?=
 =?iso-8859-1?Q?ds6RUbo4XcXX+3jybJzHT3yGRQbn3UAJ+kEH6eNp6yQxxhpwBxSgjfTqqq?=
 =?iso-8859-1?Q?F3FMVgpoEK7NjlXMXYcSZK2suyu5y8cxbvjAGHCJH6eUHce15lVG7vnexM?=
 =?iso-8859-1?Q?vt0+xgs6d+rDxQmJetwi2FPI3H6/wNrNqXGV0k2/y/WUQMyN85e1R66N6q?=
 =?iso-8859-1?Q?ka7DHbcEHEMSMXHwXzCFbdPLSiQDPpDqsFCX1VqSzpmH+wXomvFifzg2RY?=
 =?iso-8859-1?Q?f0uPWC5GJew5QC3vIoh/ZUWeK9G2e6cAkSMJ3lz1lJd+Fte/bY8Di+Q0j9?=
 =?iso-8859-1?Q?Ec/BpOPBf7UyP+WFBI3qXy1mui/i9xEIUNqcmE7AglyDlkl/9ygvzq1AAi?=
 =?iso-8859-1?Q?H75wTgsfWk2HOhXU9yR85e2L9LP7Cer3/Zuq/cwVn6QzDcBCJyEFwAJ+cZ?=
 =?iso-8859-1?Q?Ft2Pgm0ZixeSUNbArha1R9A1qeISZZcjATTbHRWmxgGulko/6STY4JTlci?=
 =?iso-8859-1?Q?jVCpb2I2IEWHOVwLMUv8VCSXmH6eDvjTyOS/CwSbJxXsIgzHiIj9VD1HTl?=
 =?iso-8859-1?Q?a5WbrqZtYXVfp8RO4FiuUgLhzZgb8TTJZeuT69Jx6pqdyl90FB8Lnq4Oow?=
 =?iso-8859-1?Q?Lf9VZjCwoWT/Qj0iONjOkYtk3Hgg/ngGzvrzU4glqp7HtBvqU3+l8akunn?=
 =?iso-8859-1?Q?VbFqBBMhKAz1J2Fnyo67Msg0uo/tAkpcOGuN2Jo6hlfvjIMI4GcqMN00UT?=
 =?iso-8859-1?Q?fdVAnE9d2T?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa8d56c3-97f4-4548-8636-08d90a5b821f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:18.2660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nOJfvrg5UwDiyA5YC/OPWZTIYSlbhh3SoKITAl89d3AKuST7r/mi1/EPywmzYgD6N6QKE7kYrfUQL3VhcPMHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1871
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: KZ_wIMXgQpmtD3q5iyotTS50AkuTBMHv
X-Proofpoint-ORIG-GUID: KZ_wIMXgQpmtD3q5iyotTS50AkuTBMHv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/misc/cxl/fault.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 60c829113299..60a33b953ef4 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -313,6 +313,7 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 	struct vm_area_struct *vma;
 	int rc;
 	struct mm_struct *mm;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	mm =3D get_mem_context(ctx);
 	if (mm =3D=3D NULL) {
@@ -321,8 +322,10 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 		return;
 	}
=20
+	mas.tree =3D &mm->mm_mt;
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		for (ea =3D vma->vm_start; ea < vma->vm_end;
 				ea =3D next_segment(ea, slb.vsid)) {
 			rc =3D copro_calculate_slb(mm, ea, &slb);
@@ -336,6 +339,7 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 			last_esid =3D slb.esid;
 		}
 	}
+	rcu_read_unlock();
 	mmap_read_unlock(mm);
=20
 	mmput(mm);
--=20
2.30.2
