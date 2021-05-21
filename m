Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E366738CCAB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbhEURvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:51:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48574 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238529AbhEURtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHT4Ii142878;
        Fri, 21 May 2021 17:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rMEEjPB1YeHifaUpVgJXZW1XTOsKQHVK8e24oTuRo7Q=;
 b=Qcw9nlJvjNvoVnNgc7Jty1JcUOO4Uba5J6rdY2Lc9LqQxLHYNcM8dQ3batIzOunzSdEj
 KYcPEWr/iDHxWGmTfyeaoV9j/GjTqPdWO9EtgRsd0LgpzFGpMYsary5MX2cUactuBGFM
 dTOEp6H0+qKZJj4IGj/7P3hlUpvsi+Bwo6Ui7wDT8j6k53qYT403Ue3/Qa2P1+ZvwAAo
 Fd15Af9SRsbXH8MzOCsQMA/DEJL4zZPqfQyQAcGf/gmfJk0QpLEqZDfk5h7p3RxXOeq6
 2aAnXvKcRVzaNbaxg1yHym6kmr/7bkeeNkNZoNJK6DD8Connecxm41bRzAjImME00rB9 mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 38j68mraty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHkYWO095609;
        Fri, 21 May 2021 17:48:11 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by userp3030.oracle.com with ESMTP id 38megnskas-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7XdwyFKBcIXQsW32feJirMjN8FBTHGCOrEx8P1uc1FV2wTvqiUNym+lZzNrR6PqdeZW+WzVveXoInAZwNO/XevdHQ274qoXswQc75wOOcn9mAbK0x2kL0keom9RR7hZFb92iRZjyaK9xwdqSzrjWnPfdOKPgfa1HcU5AEbYYsQfvwxy2B61aWmfD0Xnj8DMTEsvg5Wu4mvxFbeQ9fj+7kstlG3RqGF0IUGrY4s/ivRzBS6JY8PmhA4+Uy97enbza1eQaEI0w6MN36kwO+e88ap7g+hKptCCyg/mzCEk4VfQ3y3cteGXkGbzN0jgZ53JwPXzObZGNASgNSRzVPZQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMEEjPB1YeHifaUpVgJXZW1XTOsKQHVK8e24oTuRo7Q=;
 b=JAIo5Yq8CzLrP8IhBnq5cqePWameUQvKyD7qa9xj89+XMKdKvbFNYVsopAEmMf7iMvd+9Hrw/CkQ3uZdz7YffZIyFAyxFzGrUDUrCxiIfCHxnnH6PggtJhIDUAsRURE7iqwRozuLTcNB1b1+6ct8FOgOozdAf9oH8ne1FQuvPahL+K4MdJoKbfebKHoBWUV6X3FV8BpXR4InBTaF8+i1k08G4RPyJVfNghOMEjfnV4JbfKun2zZByWp7OOb9eEgpI5eQTTQWZ4K5rmYrtwjTfNSewY0cVNnxJZPCVMaO4ga2RhrmYjecfOPJwCVWUhoJEJ+RsyufkNR9hXZ85RtwmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMEEjPB1YeHifaUpVgJXZW1XTOsKQHVK8e24oTuRo7Q=;
 b=iIKCNQuvPe2co3CSYF23wRP7rJxXTA9AjZp31YSq0K4dSUUdLg1sRD6lHHVq3PWkTN8rzACXvUIeSw3KNFHfCPl6U3LANTgivSzir4EHUXsA/Y4eynDhlgx5Z9qtWdMKe34gL/pZE1poOv1MbcluNbpY6Y4zrtMa66Sfc5ydxTg=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:48:07 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:48:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 20/22] mm/mremap: Use vma_lookup() in vma_to_resize()
Thread-Topic: [PATCH v2 20/22] mm/mremap: Use vma_lookup() in vma_to_resize()
Thread-Index: AQHXTml1bjC5FVDaBkOU1DzV2ck2gA==
Date:   Fri, 21 May 2021 17:48:07 +0000
Message-ID: <20210521174745.2219620-21-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 357063cf-196d-487d-391a-08d91c8097a0
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4467F79746E85B50E87D1AD0FD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RZBUQrt/enQGgsagpoh2QkZ/5+xTz7tcNjkGSuhpFBN9n+qVAE8dOHfWuapuuA4arKXmwos56e8pan03Kt3cs26NK7HoNe1Ysnj9pZcD9GsPpfEHe2RykN70iAMmkZdQcglc+ZyqlOxU6oKJ00VASqkdcLC9BePV3Itq3ZFaP+gG/DjtUAJsLYmijm2boslBtpOCDs3HDMouGLcZPdo6CcFRKIJpFw1KumtM668ufWwzWxfMM4VZ3GxE4ZkRnkvs5IpLUJJD7Ac8tEclXEf7cEuGZK+6Yv63ONbCraJZ+lSj8BGYO9NpU1QHGpOuDkRY/58FwF6+0+kQhUDDN3idJNWyl8HsZ+E59nnGDkr8oVs1Vk/LZsx023uRYBCCzN42gkx1ePf429iUt36zrSySzQqXwY4WXS9O7llKrlT3CcJyZoX5mCSPIGbOO6HLIjzXZaMzWy1CJDYSG08GhfAczer2O0i5e6KTcZliNU2WiyLFzkkPp2jpNfNb68cx9U9fzdqmzYk7Li9uaPoDogQSF4tPJPw6NTW/iw7txLP/M79yZu9ODngioHdmqweetXt8lB1ulUn24L2c2pWroy++4QNIY5rqR4fVods2vafe/qI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(4744005)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?sUGYyCtd4A+I17NGkxKQl3ZsgI8V11au8estGmPuSdk113A1Pvo4JyY9C6?=
 =?iso-8859-1?Q?H7fJaiAkQLGnxvVc5DVlKwhpgk12tpXN22tWVNiWaqYquz1PkBqcxy8Dlb?=
 =?iso-8859-1?Q?FcnYm8q7iwIZ12wO3d9bRkWDJAmLzfmntntge5YVCgBve7D6DlBQmPyMLS?=
 =?iso-8859-1?Q?xTlVg1VUDyjWPDxMSxmF0MuPbNCoDOl/jmp+mOrrtLidItAkz+zXkS6Wku?=
 =?iso-8859-1?Q?oZwr/7TyYXpIgiPzzBDs0DVHk3AXbMF7LRtWke5jDZtqeHhh+HlnSTp6Wy?=
 =?iso-8859-1?Q?kjff86aERrDYK+qdnh7KAQt0rkvF/19+J+bA4zjvJsDB+VZMZdAA67MfWn?=
 =?iso-8859-1?Q?ToV2QkFL6u18pZrsS2o7KwDZ3jvmvAgGtKpPL7dy+gxVi1wopFpB1LA1MP?=
 =?iso-8859-1?Q?NeoR5QiehljsEboE/6zLvgmuTW2HXtut+q8x+mseDvXMuHwLpga4/kl0Ya?=
 =?iso-8859-1?Q?GIcYjpeSWb4QB9PtJiH7S9y/uJV++OFIVxt5e8ZBFZ2AKz5TTBbm57grUR?=
 =?iso-8859-1?Q?lJhw4SkW24GkEGgENg8S148YO9t9QFK545KKExyz9qJan02JbOxuuq/lzf?=
 =?iso-8859-1?Q?vHOXEXmdfLbS1N0iwunTM09GIR56VprLPXRCMYFrSiTJWQAH+bjkbEywu/?=
 =?iso-8859-1?Q?Yj52aFo10kN0lAx/pIyEymb9aOsoL2CYQ5l+d0vbFMLCxWErCjtgYv84ui?=
 =?iso-8859-1?Q?/S/5Xim6+GGT1Wp+j4lvqJzDeuxY5nY1n/4v7d18cZJINEBNrqioiqBoO1?=
 =?iso-8859-1?Q?kXjN4t1Dboi4q05FZGqzLYA4Rzyylkn31ocJ5+x7tr1EJ5RFudV9p3AqqD?=
 =?iso-8859-1?Q?8NE0+mUIq3CFuYBc3lrwYCBl2/cBl6Tt8+j13TBNHz9qI+R2Y6HztRnqmW?=
 =?iso-8859-1?Q?4ZRNLfRzPiSC+9MhrB/gTivc2y1GRIvX24rcFmCrjnhwdVUPTF/QUcfWxm?=
 =?iso-8859-1?Q?RtjPHDMnKYktyeMzU0XIdTO4pqYkEi7IJ2pYhbYlXRvEX+LLHMDjVHxJcR?=
 =?iso-8859-1?Q?TvhlZNmeeRBINd/G8zd+6tJc2aPevqWy6Dzdan8P1M/0uXz3FTm2KgvaF3?=
 =?iso-8859-1?Q?SdsE5ZchC7oCcPQJKLIpJfG0XFeByXv3U2LLU8DgX9CBWx1HBcgb5UToIz?=
 =?iso-8859-1?Q?Rx1CYtFg4S5LL4bPIS0IiL4DNfNByobzNRM4z9bf2ssNg6vFcChhfCcMV3?=
 =?iso-8859-1?Q?bwGkHAMG8LjqAZOQPYHDGXzygvtvVfPaG3XQkj0Z1g5kjH0OWw0i3d226t?=
 =?iso-8859-1?Q?PqnmxoHnqL6upYmSZtpQr9zQOnOmFXCciZyjrGc0ROPMOlXTsxugOUXf3J?=
 =?iso-8859-1?Q?Sl9iH/YoC91lrzuSQSswFkyyrGGZRzXr3Ds5SMe84gO2TMjw8JUZzuYNnF?=
 =?iso-8859-1?Q?KPabDIR+xb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357063cf-196d-487d-391a-08d91c8097a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:48:07.3727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sAXYP5SWRCpwTPGqy0Ct/LGL4P+6K9tpg/rUuiW1dV5p1muQUoC2/43K7tSW+vA23HfzipHyPmZ4ZArFjrWZcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210093
X-Proofpoint-ORIG-GUID: aR4L6rpH0nMHqhL5irylqGIVDTp4Pb5g
X-Proofpoint-GUID: aR4L6rpH0nMHqhL5irylqGIVDTp4Pb5g
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_lookup() to find the VMA at a specific address.  As vma_lookup()
will return NULL if the address is not within any VMA, the start address
no longer needs to be validated.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 mm/mremap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 47c255b60150..a369a6100698 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -634,10 +634,11 @@ static struct vm_area_struct *vma_to_resize(unsigned =
long addr,
 	unsigned long *p)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D find_vma(mm, addr);
+	struct vm_area_struct *vma;
 	unsigned long pgoff;
=20
-	if (!vma || vma->vm_start > addr)
+	vma =3D vma_lookup(mm, addr);
+	if (!vma)
 		return ERR_PTR(-EFAULT);
=20
 	/*
--=20
2.30.2
