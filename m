Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A735038CCA0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238712AbhEURuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:50:24 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41978 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238482AbhEURtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:35 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHUqsO083399;
        Fri, 21 May 2021 17:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=JUqMthCvu536m2QH9SFDBKzofwt46XAD4OGEQazDrRU=;
 b=HpU4h2u7heU1+Mf+Yhyk9upNn4MfBJ5sb2aFWmd7MWE/KbiU2p3LBkamNkyVR1anW8/w
 waQs7gpQr9K34okKUqRvJe1JKHWGXcv3qxQ+fVIUMoRdTpdSo5jztMB/OleogxCCfR9I
 04SyPcZEu2qh+Jr9ks4p48T/O7bGI1k5Gze6I3yy7UW6A8lqSlXU2JP+FK3xAmCmhlxg
 fpivu2dWaZVQlX0NmXALrpCw4At+9z6Fs87e5tMoWbBlRYZvKmFVWte01rG8Wpc1d1gu
 daeCqKKrdLSoLboSz11pwCQB+5Nr0jQiFZOPZ5seL7evwTlRuuCsagKPe+7IHqCMER8f 0g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38j3tbrf2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHk0rZ189475;
        Fri, 21 May 2021 17:48:05 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3020.oracle.com with ESMTP id 38n4930cwe-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWXxx0CdZlVzTZYxOQxCk9qkriXq2pSLCNe+Qqb9odWLeoKCxU6jb1DqW2xWaPyTd0zOUzG6DVu4IOAkSy4hsT2TpAAhNgx94mfw0Z6Tzytck2QwPqBnNWB5awl8wdiVYjUCm9wZ1Xzw+AW3twA+nwugaVM4pf+pAjHAs3oPi/Oybtobdn1DToFL1f5Lv+x9NxvVolymzqiMOFJ49+hOjdJqbxGDXBaCon1KpZ84gr6mnFP/GcvKtr0TwPUB//mJBy2aQT6yD94c8zvMFmY/xL8H+9sU5e1W1Mc/L7wP6t6yNi1ReH6htNxn4bTkHjObBGFEltJmtiUmNA89n0BOPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUqMthCvu536m2QH9SFDBKzofwt46XAD4OGEQazDrRU=;
 b=Ml/erA99+EjnQc8H4r4ORFDb6JNjB7GKAHbLVAqYHzDLTA42Hy8NIEC+aLQJOJpHtWUE3MAelzH8Oxgd2Miu/Am+c4pQ6DAu2P4EAMNsfB7kyeac20isZLJjJ8Uum44pxBf31h/DLG91WWK9EHN7qhYugZ0s4tof3Le1ixZ1JEy4ieajTb+imbRM3lEkcgCoPvhgxkaJTRSzhmqSxe/uHPUmQzIHrEPOOSOkj7MsejCNWAN2zf5IqQTKtSUkTSg3lg2H/NGcuxRZCvOnHnmYmTLRJvfv/Jhm05Ujt9kZgBEMLprzn1RUoovMld821ZtFpYz8Hz0pq8fYrr7yVLG4CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUqMthCvu536m2QH9SFDBKzofwt46XAD4OGEQazDrRU=;
 b=gEMm3X6xjF0P4ChA0W7ca9h0/cUQm086SHFTLh8SLdLYbh6roqsKqnbKcU60+vrteCuOjq4ZQZm6Gs1m24MSL6NrWDlMK8N9e/QCGHkJaoiqmZvnUdxhpgTIv2jwPDNzLLyTasQjqkBln473O5Jyvc0BjzAGEHLf827k98C50YA=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:48:02 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:48:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 11/22] vfio: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Topic: [PATCH v2 11/22] vfio: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Index: AQHXTmlyjv5DX7PKhUmqTa9LPrEquA==
Date:   Fri, 21 May 2021 17:48:02 +0000
Message-ID: <20210521174745.2219620-12-Liam.Howlett@Oracle.com>
References: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ae7c1d1-88aa-41d3-469c-08d91c8094cd
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB44674EFC10B0BA106EED2A28FD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ecHQlJCRT1pVQomFzv42XhX/V5s+3p0gmqLdMrtGs32kEguxezZJKVOXuuA/s1CTFj/kJPwwc4HN3GdSSmHNccSfUFsX74alzoVYqBuccVnFbBzcMpJJIZxlE1gwvMcLhqnE2CpNiNxciPNjYUOHyy2O7DIYCKxgOelAmfMItGuUTJ5MMc6ApkK3dYWSz2WEyIxSZdtFdK1PgLA1oQbGH4lR345j9IoVjiFmD9KG2hlJqTpr/2gsovsUxa9vk9gKT54tVE2gBblJ0zl3FXdJFIdLcQ/ffOJX4NG20FWmk4PntR4z7SKhNUS6cEORWoILczn9ypVybNmBeHu/wmHmPXf3pmKUjvz4gfu1Sd4ozVtV5bqiuCLfvhY/ibhhZtbTmvzxZKI3hbN1Xvi4BH+KZRGxWrXve2XQe/+YxUeW1Yr4WOjgSdxgCjau1I9/f/lW3MHKVVVLh5b3A9EqY7I2Z+wFm5Ak8bJDN1wtx/w/cifmraTQF0LP1QMUIYm3rTQFOeFRuvF6IPghboUpqnY/ykFMAVcBXdFAXbwpCi4BeOaGnGLpF917C5Qk+6XkD+1LBZVZ+kmSadIpaiPYaTUcFkngirKHyeUlhjgC9d0PyvY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(4744005)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?JhNYan6PiDQHH8w3fJyeg5wJDKwOdVzNXPmiKTn2nUEDNQ2dMIvR+CrR6U?=
 =?iso-8859-1?Q?r+k/97l0sTkT8UZKL+gl5maSkGyN+WjupidxPsZxpAujMyN+l0L2tEDpMb?=
 =?iso-8859-1?Q?bMWjeo9aeAPXatrI3VS65gwfTGldKXwbUM6I79xtg92fUjf9Mr6rqQoeJL?=
 =?iso-8859-1?Q?xoqohv3SbkG0eIimBskF4QyjoTknjDrk+edSGTw+jj7tgNX2Fw0hSZAeDl?=
 =?iso-8859-1?Q?JiI5FwMAUYTH+44qZbQIfgS60/IrjNMBvyZsq2Wa5O5S6USpSCUEdFn/h2?=
 =?iso-8859-1?Q?z5hgquvCB03NaM7nDcofZDpwzCLoE2YlNH1A7hBkekh2Zu8V6zxFVgfrGa?=
 =?iso-8859-1?Q?sr9u6sD+gDneZyTG/8Dcy4Wprml1W5XZmwoCHT4W41j0u7bPg6Rz1ryB4P?=
 =?iso-8859-1?Q?3dBYAGX+zjCO0xn3/24NNEIfb5T7mas3FvJbRUHncVvJ1rFULe19RBr34A?=
 =?iso-8859-1?Q?GfDo2om82T25ld5yLTKyedgC5Dwdrpqb86bqo0aaBYkNB6koVtxgiiYCuw?=
 =?iso-8859-1?Q?iXyxq8Vx2fqlvHD4W67coFqkutlvsHSKDe1PQtzSTZ+dcWYjDRVBajZDSw?=
 =?iso-8859-1?Q?s/IYu2rlclndzt3khUT6am2PP+yywLLmTJtC94FshHJeNruSfnyC/SV5iM?=
 =?iso-8859-1?Q?IEPgs1LEodU7ALP0/os/vDAuGf/Y7Q517HPizxcxOQGYHQAsGz0ZuVgzc1?=
 =?iso-8859-1?Q?pz3PYZAbhKfDlVXmqzro2juuOAX5u/ytN9UpPvxKGLPQqJ57B1PAZaaXws?=
 =?iso-8859-1?Q?5GtBAb6Ji2NhmcctHb/YeR91MI/XoUR8Y6oJ6SR5GtTfVfl5q7uKTsw7Lg?=
 =?iso-8859-1?Q?IlWzxoQNJHOVe9BQhY7dbM1lcvISVJQ6GUcKxNINxKj64CPK/H9p9MwzKG?=
 =?iso-8859-1?Q?teat3sL94gXfPs+13TYugAW7rUthgHgaevUvBTGth0VUnBB3sTmmIOyv1X?=
 =?iso-8859-1?Q?/ZM+57EmCG4zUj4I8YgIm1ZNLk4xPL3x6z/c6I5N2KSQBps4PDk05KH/0D?=
 =?iso-8859-1?Q?TeLjAQ1/EkH2pA0C/VDnoe3iBY1Crng2QnuH/CLBkznkzBjfCO1fLPPIrB?=
 =?iso-8859-1?Q?3ioKbrOwgpLQNj+qb7JE/2gXSR0YC9TlwZ0w8ZzRM7yggB2BShC5cVKQgH?=
 =?iso-8859-1?Q?Sxmn6bBHn+OH/MK1SpZC3wgY3BtIcGcopOHns6KX+Zi/LBtFkCRQa0Mn+a?=
 =?iso-8859-1?Q?+Q3g9vPcf84lmNkqYLKcQ1Qp7b8fTP84T37pM2ovXvaY3Qz2L32RGu+u11?=
 =?iso-8859-1?Q?89JGfGokxiUym+ljD9uXHT/dSdPMXEkXeOSx0CJxD0j+18HhvWln9Njskx?=
 =?iso-8859-1?Q?laCsPtb1y/Hvb9EL0THEwFT1droDr4gRdFHIKMB9CxGU+LFSANZiWV1NPp?=
 =?iso-8859-1?Q?tU7Uqy5tUE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae7c1d1-88aa-41d3-469c-08d91c8094cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:48:02.5999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xc/KlFVto0OOd6VY99rSQPtmPJzd50j63vDY/sYgHwKtJ+3onGDsFZqaFnehxxEguOBzj64Czds0FUpTvOPmJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210093
X-Proofpoint-ORIG-GUID: b71nKGCKx4RzdhjepBPO1p43iB7eXCEC
X-Proofpoint-GUID: b71nKGCKx4RzdhjepBPO1p43iB7eXCEC
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() finds the vma of a specific address with a cleaner
interface and is more readable.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/vfio/vfio_iommu_type1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type=
1.c
index a0747c35a778..fb695bf0b1c4 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -567,7 +567,7 @@ static int vaddr_get_pfns(struct mm_struct *mm, unsigne=
d long vaddr,
 	vaddr =3D untagged_addr(vaddr);
=20
 retry:
-	vma =3D find_vma_intersection(mm, vaddr, vaddr + 1);
+	vma =3D vma_lookup(mm, vaddr);
=20
 	if (vma && vma->vm_flags & VM_PFNMAP) {
 		ret =3D follow_fault_pfn(vma, mm, vaddr, pfn, prot & IOMMU_WRITE);
--=20
2.30.2
