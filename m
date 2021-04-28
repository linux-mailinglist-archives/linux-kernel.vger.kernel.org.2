Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC26936DBCB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240061AbhD1PhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:37:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31268 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236811AbhD1Pgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:36:53 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFKnmE030215;
        Wed, 28 Apr 2021 15:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yEU4+7V/nTBEI2d04quRfESRAJG1uPs7+0aPiYsfUB8=;
 b=dKqlqflajpQak2z9SpY8Rp+zb6lWNzXfwiTXLH43tzZgrAMUFsgO+ryq7lBF/nqb82io
 75/N0Q/GTQx+17gh36Gx6ZZUwL+FfnglzcOkhk9x6yVM5kP008he98uLKVZX3F1X7akS
 u+s80K2qnjEi0kBOcQFc+L96wuMEVM7wavGEXe5ERJd9Hk18ZroKCWUN1dvmiXkipuuW
 6ybTxbDfNj43r19k65Nhk6tNVKEEEbk0tUvZgoPQ6a5/7XrlnBry3iaWu7hy1pgv+XhQ
 GLyJtf0NhgeFt7ysQJvvDGHF2g7Bnbt0M+kB9c9d2zsBlUOwALv3L64GFBhaDUk1cC7c jg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 386mxjh61j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:48 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWkAP003673;
        Wed, 28 Apr 2021 15:35:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3874d273w0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9gxaZmKCjg0YwkGkfgoquaP6xfIGSP0mndPaLadkOiQnLkEWK/+4z7SXlg6gUAYQ6DOC8mec0cQud8MKCT6Yx/sGF46RdkYf1BORbOt+K+aZLPz8A7pRE7yAFXACzsBc+rNfw6fcdFTddp2UCdMB4ikDKpQFx0LXqwM3gKofH/ttZrCt39dUT5dqMKkeeDG02ffQ2ulZVUQM2Y4ZBoTfXN+ZUDPpVdNBHaUHPKwrmtywbmJ5pHAgcmyVTUbh4p1Da3J4rzFrINGDETr2qWB3EiCLuM3Iqc70d63LTEAXVSnxkzZeYpA/5eCE9YAYteNDiciPbfDmfbA49k2vPzzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEU4+7V/nTBEI2d04quRfESRAJG1uPs7+0aPiYsfUB8=;
 b=MfTHy6EZhhYoBoQSI12xynZ8z6IlHa7JGyKRTG/EILrLJunxg/DMI2XCnzZFzK3bs7UkgG55VggzVBEHv8vSr99h/SGdiJT7YXrQJtUmUOQ7pscX+DFy63ilZgmFEO4D2EB0RdAep4jpnqJ3JKtjIW3nxhGev6fQAy58lfB9/97g8sMrgSbyu/aliOfUB2+9GigkvGZF/6mBB59+xx2b5DrWaqGImlAB+FVfHt9UmpLeTHzr5pqF44QRF68arly6CRArQjoL7rnfL1wYlzCRa2v/46ZuzWm+BRfLGqWRMGJRO2F+KMi2Nq0XzOuafgrjvignq7Xl+wIwgH/5JdZSvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEU4+7V/nTBEI2d04quRfESRAJG1uPs7+0aPiYsfUB8=;
 b=PgcIGcnpPyitXPLsAcBDWEiUkum5J2vTG+VAQQfx6Pw5fO7mFLKhK8YcMNT7xCVCC8JDXDq8SdptIVB0GSK+X7lYHOJXgdAMjsZC0vBVU9HvWDNnFf0X2lfXpE7bwHrXsU/eN1njm+7c12ZGJ8NfcZwkdEHZ2CRMxELBgIAishM=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:35:44 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:44 +0000
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
Subject: [PATCH 02/94] drm/i915/selftests: Use vma_lookup() in __igt_mmap()
Thread-Topic: [PATCH 02/94] drm/i915/selftests: Use vma_lookup() in
 __igt_mmap()
Thread-Index: AQHXPEQnM/TeVAhEBUW3zxlPkEBDpQ==
Date:   Wed, 28 Apr 2021 15:35:44 +0000
Message-ID: <20210428153542.2814175-3-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: a2e0fa8c-65c2-468b-43ed-08d90a5b499d
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4497B646FBEFB57A4A93B183FD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M4klswOLQK9GKzCrdTiszL8jvqMUzh7JvD48NN39jFLYlG9Z5jExmBrSBUpdghrlCgpP/QZrs7cEDBgtSZ+ldhTN0y1p+Pek7YL0l4kbNSf+Z/AmM2k0ly7CQ7JRgAN5QG2PRJXailIl4oNoLLR2+o5h/5sJTSgYXWQZ+trOxzEStrmPlrnTJ2ai6bP5p6dfk6+f0uWVbkAG2cDSxn1FvU3ERrb+lws0p3CwmM8lhcfdznZJ58HE+FmBkZeim2MFqpSzywE4j+pAKgKGSnI38QKmVWd/FYtF7DU6z7qr7Ih3D0/hs1zdWyF/yIA6ZogTJTso8GNWke/IBkcmhcyU6RE5ATEgeNAq/N77+NwmOuVuQkeWsdmQhxecaBkcplUrQ+3wV8F1xn16jwX2u427pJd8Rd3z2nJUw/7n//rSIAnR2pgY2Y6gSJJFieyw46WTn8ktD8WOOwr3yq+r2RRBI5WQVtDkFuljmf4idz4bqWzAgB+Xcxd+LSvm4nF16hOswxyptUF6QcJC2gARk//h0gK+qyfAze1ZKbZBvzwO9z7e2vu9mofK+p3t5tPK2z8EnSCuxIcDs/RbsGXxa40PGAyyMX72cfAuc9xqHEgh7zE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?eergvLZYJ/W4YXhvR5QN/UCSCl3XY4Dx+SDATHYIagsSvAFCqZu+IAScZv?=
 =?iso-8859-1?Q?Y0xH3ZpuzcP9Gv09T1zjlvVTE5lwe8shnjQCEPPWocuAEAYuDuPIz7WYtg?=
 =?iso-8859-1?Q?3/5X9Ds0k729W+BgRTBQ8x5WLZq9D3YDbOdbuVEdwyR6r6Lr/iqsudB2Fc?=
 =?iso-8859-1?Q?IejKz06UY4jVw6ykOrKo2r09MS/Ldp3UDIBoEncjtO9L+naiWWyXhn/Tuj?=
 =?iso-8859-1?Q?y8Ks1G33owY/Ni1o3onYN7NJbID/iv0ZxAqb4mTY2sP2Uf7pqCnZ8FSFt9?=
 =?iso-8859-1?Q?1o2IccjnZDM6MqdXB2CqcQ1sJlMoxPtDfqWJfesPM+4C4JzKxmPdd1fldb?=
 =?iso-8859-1?Q?JXuKYQ2UXoS6fvkEgNECHcj2Goe6sKG42PDJZ7O/U2v53QVcsRTIDC56Qu?=
 =?iso-8859-1?Q?3pp0Cd8NL3tCjjBze10Uxh/uMY1hsq5ZShbiG3Bl+MkzDwWZzJMJXALA63?=
 =?iso-8859-1?Q?3qKlI7TcHfOdQ3qB3vpYw9E7eltkXohgXvOFlP5bG/FY9Obp4xJRXbB6tI?=
 =?iso-8859-1?Q?wp9uaZ5pwwfFV9s7vl8g+T1w4+x5jLaH6pV6E+3OBlt/ILhmMTDclLwyHw?=
 =?iso-8859-1?Q?1ovvB87wP/hSQCXKnIdOm8rNNEPH824vT7uyFWvllZeRwC8CPBlN7EjOtq?=
 =?iso-8859-1?Q?KTmiU7cicoA1jWm58PTNJtMfhJovgBmN7SCi+JE0kpA0X5OyxxdTLCuggH?=
 =?iso-8859-1?Q?QyVxzd+vYLNHjVGLCIKq5DEGVLP3VskAqdv92qXoZuQaDVdlg/4MfgfpZp?=
 =?iso-8859-1?Q?7mo6Ln13Y1YJH2NBxdW4eWrFIq5I8x9Pn7e53I7jkTls1f65DhMWwirxGG?=
 =?iso-8859-1?Q?irKgbFm6XTCOt6N/1R8NWz0OPzictxPN1iXf+CUPr1Y1/xudOrQA7kSIFR?=
 =?iso-8859-1?Q?LAZwR9H1LND8XyQg3c+xcI+v/9IfQ5Tc4HTfB3HE5Jg0QSfFkEGZDwB97R?=
 =?iso-8859-1?Q?EfkIAq+Gd4FRzlgujL1/6axIGuDsTKTycUQq8f1CHCv2ZUHoeE7Q3GAoHw?=
 =?iso-8859-1?Q?oikMMzJS8lcP2mxD1ZNDO3oJekre0oeLI2c1JRxixDvaXi64R2QQvu0V6P?=
 =?iso-8859-1?Q?WdZL6n3+VRxxu0sYJm2f/A4oakTLZmKSCiJXvNxfRoMWgkFaryOW/+ymrc?=
 =?iso-8859-1?Q?7pj4IVejOXM11uzhBtFsv42ehFpv8FnFEH1plP/6WfWt3Z9euQj20Jko3T?=
 =?iso-8859-1?Q?IEGoa/VFibc4TngGOn6Aj7FvSc718Y3Rz/tTPaK25rpflXaFFqJsfS/wpW?=
 =?iso-8859-1?Q?5xhNsvrhL3mwGIiUBhdjFmUgkHd+ldRuf/14VPS0Wof9DnhGV4pUd2n9xW?=
 =?iso-8859-1?Q?IZdTMvrQsuoCsWeqrBojbkYzDSGz8K3nWFzZ3RhPfI95wqXnLmzf5O8vmU?=
 =?iso-8859-1?Q?GIfLiHTErwWOHoF/5uDAn0l27I65Yt/w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e0fa8c-65c2-468b-43ed-08d90a5b499d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:44.2141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IypjrEA46pibN6NhZRzdx3M7YBdjQXUq2/TXR9RsW0hgv/+g+XKFkrdOfuaBMuxSIxQlh4Sc1d+b3KypilAbRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: P9ElUfCqJZdAwdT-f8smpNohkvZnzzop
X-Proofpoint-ORIG-GUID: P9ElUfCqJZdAwdT-f8smpNohkvZnzzop
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() will look up the vma at a specific address.  find_vma()
will start the search for a specific address and continue upwards.  This
fixes an issue with the selftest as the returned vma may not be the
newly created vma, but simply the vma at a higher address.

Fixes: 6fedafacae1b (drm/i915/selftests: Wrap vm_mmap() around GEM
objects
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c b/drivers/g=
pu/drm/i915/gem/selftests/i915_gem_mman.c
index 5cf6df49c333..35c15ef1327d 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -871,7 +871,7 @@ static int __igt_mmap(struct drm_i915_private *i915,
=20
 	pr_debug("igt_mmap(%s, %d) @ %lx\n", obj->mm.region->name, type, addr);
=20
-	area =3D find_vma(current->mm, addr);
+	area =3D vma_lookup(current->mm, addr);
 	if (!area) {
 		pr_err("%s: Did not create a vm_area_struct for the mmap\n",
 		       obj->mm.region->name);
--=20
2.30.2
