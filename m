Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3569236DBF5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbhD1PkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:40:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56494 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240419AbhD1Phq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:46 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNiXQ032601;
        Wed, 28 Apr 2021 15:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=0hw+e1GlqV3raF7gFtYzr9MKTHbezMhTJ6zfLuhI+HI=;
 b=pPeatr+fMG/k5YZFAaMg2bKN336LaEsZAV2OLBeK0qxtoeKOP/nFV1cM3MovzEWs2LsW
 HG/Iio60YBjmVt2Uijdlu0KQMsLELC8BO0iEuJFTyYYFrl6HwzSdWBaPAev26nReKPQA
 UnHibOtXDbNvmKf0inYg3yVRsz4YPyehL7l0mm2VxqV1GRPT3A4xdW55lcmgzEDn3HdE
 3p80fYlqqPayviOiPmY2gND/ktJHGP2jiihAaYfaDJF4MIMXqrr2w7LGlNLV+Lwiw7A/
 1oN//ikEECzKP/+cuO3kLubIrAQzo0XZZAODJQrJtiOWrnbKZOPNdtQzwJ/cgCFsBpDE 1g== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3874kn0epu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:44 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaASs030176;
        Wed, 28 Apr 2021 15:36:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 384w3uuag3-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrudFk039y6B4tAIP0+tBWmy0eo8NieXLz9SuF+a9BG8C7mkFVbvyTvlVrJi8NFZwhsRZEJ4rLQ75Ff4m9qFVbTxr1nnwp8FPyECfRcvqGlqPlGN79G1yQmUukyrU95LO3Hzw1JNdP5JkiyDp8tAQwsnEumj+BwgaCtCiaEvpYb3UIJWPIGLbCDd7PLy5BOHeAwbIlWEjpUEIUlmXeKPS6nZ6B7v5W9txK+cACnyvt1WvZ09XzdeJxlnKes+x4oKEZObmNBsk0xYu9+SgkmiZuqb86icZ8sLsA39dWykWWUxCVCxTmrrhJNgdemwVQYacT2DhzR9FxtECzLzO5XXFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hw+e1GlqV3raF7gFtYzr9MKTHbezMhTJ6zfLuhI+HI=;
 b=DzpTDUZ1fd8W18V7MeWHZD+tcIJ2AmbqBtFfryS5ya6WQqtQ5VyFJeAXQU3Apitw/CqjSqYhKBmPXd4eI/O6psDYZ14LMJthqWAWU1oorYiRQ+KftPeGBMS0F9bUd/AWQi/qTjXeEA1CfjDZg1HXFKnauJVTsD/cJUawM2qEBrVdrRcd+WlEE+u3ei5Pm2PcOMPn/dUg7nRkFs8oqkpBShpLKrsVo/hqD/7NQtEKXTUk8z37ZKEc4FVi+WbjoSIe3iYsuoW+a1nKoMxO33Vq4xINNF0CLDmlm390yUXtBdUQs1Ca1EPJv/DCL8sFn03H3bND23yD0dHefnnqx6yGWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hw+e1GlqV3raF7gFtYzr9MKTHbezMhTJ6zfLuhI+HI=;
 b=wGn5C3VKeghv4O+xN1FS76ro9ZKNl6//GCrNHl7UVqnZkTBIKNfbC+lWRdUyTGV/Z1d3K1aAVyoTKYr4K4nqCSo80NrK8IPDO6bABT9BbrpPasxYeojkmfzhMdG5bGocGDzQVaxT5wUI790sJnBqpzsNDRYmVfIxvGoZI2e13zQ=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:36:40 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:40 +0000
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
Subject: [PATCH 43/94] mm/mmap: Drop munmap_vma_range()
Thread-Topic: [PATCH 43/94] mm/mmap: Drop munmap_vma_range()
Thread-Index: AQHXPEQ2YRR6GdJG10eBGSMARkA7nw==
Date:   Wed, 28 Apr 2021 15:36:10 +0000
Message-ID: <20210428153542.2814175-44-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: a012e7d1-dee7-4e1a-91cd-08d90a5b6b40
x-ms-traffictypediagnostic: CO1PR10MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4515412979B1CF5D40C5D44EFD409@CO1PR10MB4515.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HlgzjX9VmTz+uDF/qcwNfyTtMAkg4IhYhoM99jSRMcE56GzzmrsjTULcZwG3oLw/ouJs8RaETja8W27zDc99OXEK3Vs4g+yza8CkZ21WxWfCdGdYIRMnu+XwaK/SEbVphxfuoMvrr4uaIdd2jx/s2SPk2MGrlGFjrYx7ts2zeTiWiXnegFKd5cHerV/9VuzHdZsZ8eFKqov8lkHncevcvg9ZIJELrxDkZ+mYf695FJg+zHtwl288LAVlGbwbE14Ep/z2JQQWcaz+TWCJ1NGy9hFza+n2/RY3swcc4L/YMSIwHVzdeLvSXSJ+/JMC/tw71jKcaRvUcbK/FRxEUIKA/ydaqdQNgQXgE3Guo383uQg1D9/6sPbiuI0SMt8CBJuG9DGcr1C/YNLqvHVaVtnA9yyPi10BAjZBK069xIfcwIPlEwiHOspBaRr0Cw2mIOtU67fgBvjzLXkuUTHbMdC2P/hIuVNUN9Inwsy7ICvKn3XrF3Mhy2lORfigRgvKdrmBKNcj+RwgPDrOjp/Y1ddLYDVtjsrtd0uhk5BPHfvA/wJYOzoJHC8AChdgoaLeltm5PeRKDad+CmZSKudnzC+uhf45wDktm26oTwTUnvXCDwY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6506007)(4326008)(36756003)(54906003)(71200400001)(26005)(110136005)(6666004)(316002)(8936002)(186003)(44832011)(7416002)(2616005)(8676002)(76116006)(2906002)(91956017)(66556008)(66946007)(478600001)(66446008)(1076003)(107886003)(64756008)(86362001)(5660300002)(66476007)(83380400001)(6486002)(122000001)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?daYc1UR+z0ITqm/lai5fWds2n+oz91vB2H5QrS0qZIHZzCUfohAgB4St+M?=
 =?iso-8859-1?Q?Nc1DltRc9oVPP9H31WsEpg/f4xc+HjR0Q3f/GvfMYCdFz9C7dJyitx0yEG?=
 =?iso-8859-1?Q?wcoZf1q7I9RwjX+vzcrXHzE7CvCpRdAl4nmUoNhW1GJXik01/Uot/26Yge?=
 =?iso-8859-1?Q?kRz6BZimKr/h5OikgkOzi162YqqfyJ7UlMNg2BWmOFUdyxLn6SajB8hOt7?=
 =?iso-8859-1?Q?5Oc4cli2kCJ7Jjil0tVBe8b4VhnRbf/NatDb8QVL3UhC2cXW8IQZ6CA0El?=
 =?iso-8859-1?Q?t5n8X13uWnsUrTqmT6euhJKjiSef1hNcMMW/VfAYgMq7Og6cUaXqRID2wk?=
 =?iso-8859-1?Q?qxIdVrBDdShXjAtAmAT7YTPv1gMbh6kPqz5PdBJBVz4niFAQdLYbpA4Gwy?=
 =?iso-8859-1?Q?vQlPJY7snqVm3q2/W0MC4rs2BEQLLNqZZ9nmS1qO3V8J7sS1kyhahy5bnM?=
 =?iso-8859-1?Q?ufim34lJoQlbYvfyMif7X+Ov1/BT2cckTvTYEkHibgHyu9a1JCVFBniTQu?=
 =?iso-8859-1?Q?dRnDBHRI3y9NNG2qUMdsZ3jpw3uSsUJkoaNFepMZ/pByxflsYXLh1k8/WI?=
 =?iso-8859-1?Q?USaMJNS4dX+psFnT78nF7UyIuPXfmfEyvaYq/rs+Qq1FrlLJMXxqAhtWrj?=
 =?iso-8859-1?Q?LkAF2rfe5SyVHqMoYJ660mKbzqqAaiCW/D4LzQmCgVv+fAMKZ4y7DB+zFa?=
 =?iso-8859-1?Q?7Sm4LM/Jvjkz1lduYGOoYia3bGabOVdZcFvWmFmOUXEUfpsrP3QgdJeLyX?=
 =?iso-8859-1?Q?xrZni+5OXtBNAtqCLepvJc16iVToM+iKw1AOn7YF5lL5BKsszyBBwBwUff?=
 =?iso-8859-1?Q?J8TP2MXFkiE6yJRUyQdS22kA21qUxCF/J510Ib0YPwBLqqSNa8NeArUTki?=
 =?iso-8859-1?Q?FFo1nME1kuQWEWs2NXJ0Bgs/KAjKcix1kC7Ez08f9vIcqeK4HwbEpK1NmI?=
 =?iso-8859-1?Q?qnoFWWFGWbKDLrrCsKsFynwXOvG1dad3bd8HAsf0trmWGlRXodTG5Wxtac?=
 =?iso-8859-1?Q?qnEakQE+oAy4oXnmdIwYoyL7M+WOnGoD1Izeeg0BK8IVnZebs3zlmD7fPz?=
 =?iso-8859-1?Q?vWsh/sDubXL8fOicQUFVMq2t4dTUGp2MSQETDC+CyS3bSg1qY6rOJa7H6W?=
 =?iso-8859-1?Q?/0DyIwZMxh97x97A/+qKI8gF/hsGs6sLkGHX1CJBW42ElUU1opj/v4lbH6?=
 =?iso-8859-1?Q?srzVg9zjvQJLBIoByfe6wiUVH+ORY/VV3kXb+/FRd8aMkz6YtJ608An/ww?=
 =?iso-8859-1?Q?ghxnk7RyY2QlNOUxHopp8GqiYVmWRIozHBdDElBwQUu3Drft4hJxH9EbA0?=
 =?iso-8859-1?Q?deMKjFCbuYA/SkmZGdkaW7M4bUK5kY+z7i4fgeQO0d6JX5gQfmdOeZAOJa?=
 =?iso-8859-1?Q?z/0DzYHgQV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a012e7d1-dee7-4e1a-91cd-08d90a5b6b40
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:10.5004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uEkG6dJ2I61U8SXrkDGRPqWRU2TFHCCx4xrIvszyd7Z0S0E/prRrht1V9sM5x812THsQNuCS4ng0Zgv7oYzLnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: mO1KXwN6m3uoZdLflVYHzPJY4vSKX5wU
X-Proofpoint-ORIG-GUID: mO1KXwN6m3uoZdLflVYHzPJY4vSKX5wU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4c873313549a..b730b57e47c9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -499,29 +499,6 @@ static inline struct vm_area_struct *vma_next(struct m=
m_struct *mm,
 	return vma->vm_next;
 }
=20
-/*
- * munmap_vma_range() - munmap VMAs that overlap a range.
- * @mm: The mm struct
- * @start: The start of the range.
- * @len: The length of the range.
- * @pprev: pointer to the pointer that will be set to previous vm_area_str=
uct
- *
- * Find all the vm_area_struct that overlap from @start to
- * @end and munmap them.  Set @pprev to the previous vm_area_struct.
- *
- * Returns: -ENOMEM on munmap failure or 0 on success.
- */
-static inline int
-munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long =
len,
-		 struct vm_area_struct **pprev, struct list_head *uf)
-{
-	// Needs optimization.
-	while (range_has_overlap(mm, start, start + len, pprev)) {
-		if (do_munmap(mm, start, len, uf))
-			return -ENOMEM;
-	}
-	return 0;
-}
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
--=20
2.30.2
