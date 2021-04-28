Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CD336DBE5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240731AbhD1PjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:39:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64012 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240038AbhD1PhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:01 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFM710009822;
        Wed, 28 Apr 2021 15:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5fUoRqn0ywntDLI4ATvR4+bK8BuyV5hh1WJNI/1GM1w=;
 b=sFO8UfqU0+lVxwfBtGxdLO/r1pejh2Sm1YfAy6/pJ1PAIlSoWjkUTMK8LtLQpOXWWhWn
 6AbmoKaGtWIavX8YR2HcVPYZWlQ2Ed2RTpnGkWQ3kaiGQyRhSzmK+7bT0QAdWqR1ry5A
 DXTluNWsLsbW9d8BXrophtE78Kl72IcZgg5SVRfF27fpTHOqDEV47WhzUj/TDYf8QuLL
 ZvtoIFSgbzx3OE6aDvPTwBpbXa2UBdmKiIH7gj1PhC2U3cgaqaRncPfF4XAzB5y7pNfq
 2HNLosb0lVyx6JxwcfWMdz5WsdGOc0Tt7CI2tD9m5wFss+mN8a+mwEImhYw1wJdYMPuh HA== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38789105xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:53 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFZorC158269;
        Wed, 28 Apr 2021 15:35:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by userp3030.oracle.com with ESMTP id 3848eyqw48-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZ5b2BVdchhMWWe0jzqo5yZFD8QOJuvKc4DmoXbh6n41yqmYYVf873OneGq4kXoczqHbm1xUhwhsHcFyaghIq6oHW7qEAWsLRBcWhRYOdHu+H9ehHoQEq1dehOf/oe/6sodMXk86XO+NoqEtT/McZEqpc7lDfIP0ocbnbtmogof1eILDAZTSoe4uHeCtaXuj/D2aVO71mgOI7BjHPXDafxYPYpqJeu8b0iNDnk/tOqOaoehEciHogg5yR4e8qMVmB3QFDS9yH7rU3C694e/y5bA3LrMGQiGBeoaGUJ+c6mmZ2jVmlrw934nlcvxKNT8k/L+RP6R14nbAGsfLfKZdyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fUoRqn0ywntDLI4ATvR4+bK8BuyV5hh1WJNI/1GM1w=;
 b=mWw7PYENM7+pJhyPqFnN7IPxpv8G5ztly5+ro+rEGFy4Ls6MRrqOTRQnFj/4hyLwEhzE1BCRc2MciPZIl9kiKc1RFbLtIQlgOGf5OrbIUuVNd4hUtY8bfDidJbRRCu4egLfUlp2ZSm4/I1fKlZZhCepp7/G9Dg/V8kTkPSRLUAo5ESOqjGFKNkLzaTt+yva/e7GTIlFKvLxx+iRVCY6Vdj7bQOR/u9ZFagCEBCYguOkowhFYKKqUrvEHSoi9JXQwB9LBkriCgjdMO7BwebkJ2Yxhq1qU/UJk6ETFNqu5psidgTdJtKl2MnNajjWjG4ndpWoskHUii0dNYsFPJdH2yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fUoRqn0ywntDLI4ATvR4+bK8BuyV5hh1WJNI/1GM1w=;
 b=IL8I6XtFtYPeIgmiOIxFu2hp/WGDpnjTYUwvo0Q2qOp1g3RU4WGGcIXX/wGFD4S8tAVbkjz2kbgUfIiCqp8HTgZ28CI8fOjJCF4DnDpiWAjbAPMCw7/ae94jwfgDym0wgNZsGNwQmMCt6jcNBsZI+d0fZAw7QfLcJke/CAGdCGU=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:35:47 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:47 +0000
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
Subject: [PATCH 10/94] vfio: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Topic: [PATCH 10/94] vfio: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Index: AQHXPEQpDpFFVy+SMUGUhqj74jLUJw==
Date:   Wed, 28 Apr 2021 15:35:47 +0000
Message-ID: <20210428153542.2814175-11-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 8aa4f42e-02c3-4a7a-6ccf-08d90a5b4bb8
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4497F368E34E17B65D4AD5F0FD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D4+Mo8CmW/EzAo36G2qHO+g8j9VIERLdAeYpd62Q0bQ1PxuRvkuOok9DjnqIyGffiVevmj8vMKJ1imEhSYIW9y38NGPo5z1OPsmcDX156iSC3KdXEIfhOnDdjpVPjdDfLKpPLUxEaArecS5w1H1BAyNWjYA7434BdVKVBVMrkawyQ2QRyQTd4YWHm7cFGM3fQlrrlmQnT6aB6WPCdkfW5jtYBjVYtqTgq5HpxIAAUSgO1WlECQWgD8IZqYg2JrafhB/OyJWez7QttVoNEmE2mhdvqhZ81Z06ZqkUXgxFmhDiP8lKPkHVG3td5SH2v5Rv4ihJ1+XGojF90LgNelUY/PoQtIoNNY3L7BxmZCjYAfL9sl1+yX3K1hm2ITu1wGyaTU5L7pRj3COAxUVy0Gkn9mRb5sCD70CMdZy0Dki2/hE4ASKpokAhs05WcvIRzkwSMnbVM81iOpkwPgx4XR2cs+pv3BVryS1ZBLpN2H4mV5c+hnkyOjMQD/y6gmnsStlDtHN/nU2yvK20rF6u0u2t0/J1BO4yyCzLQB/oshY1upYaOtaieqMrpwF9MdvFVhmkrzLpyIXZz2xIOg/ij2PaR/sFOSdLDqFUokFRib686Mc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(4744005)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Y5C1EpD1Ou/omoy+MA3Q1eEthUn9KMEcqoURYBNBKAFPrJVlHRVGRPlzkK?=
 =?iso-8859-1?Q?uDcliZV4aCkzZXMRmWD/C7m3pTWny5RSNChW4SlFvPI+9yl/BZbsg0Yvcj?=
 =?iso-8859-1?Q?4DDMSHe22VWKjtZjofUTgQztuubAZiRPF99PKN+QN4FtvGQbkwaEQTGw/F?=
 =?iso-8859-1?Q?KLtYWNcNQ+UqvP8IndsyX1JdHu1bmCQeUxya+ywb56Z2xCHPrpQXuvgEnl?=
 =?iso-8859-1?Q?nSJUkRbYX7m2QOHy+46z0A9pcPLOfDxINy5ZJrpoLtF6zUVvVDC54NOX9v?=
 =?iso-8859-1?Q?H1oEB/HTTEwD0o8jffFJPcz8oYMPmBCzK9TQepMJEmzxaE+9ay1NcuTYyO?=
 =?iso-8859-1?Q?6k8LdLUmjGKNF0JOrjcMCgm1CYgIguKl4cxP/qwGvmPVhvovQStO79fzZv?=
 =?iso-8859-1?Q?3zPYRX02bah9K6LR53Q95wlcCwmWNdMmGFk/irBog7ZmVR8D9wcZNS2G0F?=
 =?iso-8859-1?Q?eTGR8GrIQPxQ3zFzGnWga9E3S4m4a5eW1gxmF1cOYO4VY5VEu5wy+ww+1t?=
 =?iso-8859-1?Q?CK79MjLFE7BvGtrcPAzr5oJxanAYQEAdfeZlK/lNz0Kw+YxBnXDOF0SXps?=
 =?iso-8859-1?Q?PsVmZ7jLgqILLSMMKsNJ7TF/+Oaa9YZXRIZLEE/eAquLYaQZ9W89Td+Xv9?=
 =?iso-8859-1?Q?8WUtGshAjGzB2u8gnPRtuJTsQkr6LgPHsAwwEGKEIJssVkBFU2a3ybTr6n?=
 =?iso-8859-1?Q?Equ1pZ4TTUNVfXxz8IgSnruk0Qq0hzqDWL6BxX+sDbX25GHtCw2ldmZZTW?=
 =?iso-8859-1?Q?NGebT3reaZ5zqbYnhflFSvyfq2W/MbYVhAKcebwMlU1k0YWH2zzHxiS8Cb?=
 =?iso-8859-1?Q?pKdj/F8Xi8mcy3l5FR57jJxTVHVtn4iG7qbd7sXQd/Ff/6QsUED1qoqfmE?=
 =?iso-8859-1?Q?hmtv1Az5+kY23vydmmURrJfQGkKKMhcN8RS/JyTdHz6q4jSGUSyXF0ND8y?=
 =?iso-8859-1?Q?tG4xESY5x6JPhf74fuAMkA0I9ZouypHJEU5xKK3UanWan5umzc1uW7PZIv?=
 =?iso-8859-1?Q?loS2qdi3iy5+KviI2glHWnIWVOBZ6pztqj/q0yEMMlSkOwwyEXu1Vo5EVr?=
 =?iso-8859-1?Q?e8KoUud13grgXTEgC9ccsAV9Dg7c8Nh1WfMl/YZLC9AHm0TiMiBK7RGhOa?=
 =?iso-8859-1?Q?SPLKVtxcWKnbNFyuc/5asZsPtqDtzq1O+v/rOgdjZsDEFqv/McuQCgOiSr?=
 =?iso-8859-1?Q?8btSRWzOW1I+qS+bZnCWN//OmW229ivhKNy92hJ6Mw+UM65uwHns39pjYW?=
 =?iso-8859-1?Q?YOEXNWxwnkzEJgnFnspyelvQo8EbMPlAYmncOSAkMKpAQLYPznOlV6OVsv?=
 =?iso-8859-1?Q?0FkBpQls9RA6xq4uevc2nw19ul2GIVh5E2mdXrkFKnjsXNPNl17b7gjh5X?=
 =?iso-8859-1?Q?OLFwbdwHNg/Jp8nXR+Y7xgetxWucO9cA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa4f42e-02c3-4a7a-6ccf-08d90a5b4bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:47.6865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkBViDLMRfMynIZD1HEmbMl68xs1tfcG0Ox0Q2I1bGvaita0dWh02NCJ4jX0o2f52EkVYSee+Mwcq0ckOx6tJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: uNDd6Y12JsX5GLHRbDED1DNWnNNFlvk4
X-Proofpoint-ORIG-GUID: uNDd6Y12JsX5GLHRbDED1DNWnNNFlvk4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new vma_lookup() call for abstraction & code readability.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
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
