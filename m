Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D323234A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhBXA2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 19:28:52 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:48010 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbhBWXvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 18:51:47 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NNnw8p050140;
        Tue, 23 Feb 2021 23:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=csBC4fO3lUSN1RA/yjwDRZ5qW6HtCGSseHTHi01DNuQ=;
 b=JQ2QY1SNGfJ/nMHQW9pIgpuOJCNNTWuPTC2flK+cpLSJRdZQnTBv1+3C6BDJ90lYS6X8
 cRMxw9FMVtKYFHddUPIE6x2Z9uMbfQSIfgQLTf9cXY4hV7Q/yocPHwTFasapolC9gprn
 X1Eto6ZaAS/ETCJpNa2wXEj2kJS1HRxXb8TKSPMiiJxtvx8r3ErE8oNGE97xfIVlCWmn
 wIkRP7mVtbtn7mdXDIS1ViLdENX+zqeLcMEJ+tB3vIptLSA2oACNqaHZanKxyum+BBDD
 gPw5Ra5YyULULS04KOjVEuzEhW43GgoHKiZUwItA/RXrrJYHMhzsfH16D5r2GaOsBYrK Ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 36ttcm96pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 23:50:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11NNoSSf053252;
        Tue, 23 Feb 2021 23:50:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3030.oracle.com with ESMTP id 36v9m58hyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Feb 2021 23:50:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JONR27LI6ecrFTRNfleoKgvOhkYMevKUZtKIpP3hiZMv0GX/ez2dTZ5Ufl8mMFcYPRDhwAgrXV6bVPmut0R1kU79PsbRYhgqeGEyyPx3sZ+5J9ox1lopZG98wzi32lyVQsH0CuQXKSZkN0RZJ/O1WHeiP4UK9A5CW3qjR7dWLlwAVgoyuvFnZWHFp6nOGg0wbgLaM8JNGHDD3pmkBjaxQyNzI1Pg+Nkg0Pu6hNF4yUrOv3lMWQDIXDZ9huqDfvULEJSf0bZbrd8v9RmFBCOGcnHqVEMRo/EDFK9dY2SfS1OmsqXM4Y4JJVNvXRZVcKu1kpMKxvn2mIDG9JpzzGD83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csBC4fO3lUSN1RA/yjwDRZ5qW6HtCGSseHTHi01DNuQ=;
 b=ZFhOJPOyWAV/YmeP/zs1+nDqSPG8P+eXHnQUsKD6GNrus3n0JSg/xlE6UgiXcuJsYsljxQWiokjgp3+7Xa8kOweDiHp8IC+XDDa6B8OMZmumfntVNF0jqc5I3TAsw1rSquNiXHuZFiJfXVPql6SvTIrLz4huE6WU9v0QR2tN75NzFDdoj3rLN+jtGMjjr18TYA7QLiKXwzTTpg3mnSkTg2f7WEqdzVs9OP4hI1wpg6J4Dz7tWPttRBdnQhZ9mySgOnFTrlH9xgeexro3Vi2cW1QAZLf7MFUPF6QR3ttgCDRoaqXTNsnVa5KejsrDMDixSTq497QaOrckbGVsMfb39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csBC4fO3lUSN1RA/yjwDRZ5qW6HtCGSseHTHi01DNuQ=;
 b=UCHlTpNf+lHZdkTSg4FYTJilR+NNNxor8WHEiSUedg+LnEp8Fb9WkGzRHAb6TL1utv5PTyMdudCz89RcMFpMNkxzSK0gzuKQUe6BZfe96Ko1+RFzvZFVEvdDG+d8OSoXsQf6qDiGo9x1WDxcEZF41lROdqTczfIzqLxXW7ADw0U=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1871.namprd10.prod.outlook.com (2603:10b6:300:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Tue, 23 Feb
 2021 23:50:23 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::ac3f:8441:8f0c:2c89]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::ac3f:8441:8f0c:2c89%11]) with mapi id 15.20.3890.019; Tue, 23 Feb
 2021 23:50:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3] mm/mmap: Don't unlock VMAs in remap_file_pages()
Thread-Topic: [PATCH v3] mm/mmap: Don't unlock VMAs in remap_file_pages()
Thread-Index: AQHXCj6mqNsC+jTn0USOZcQjo8OwWQ==
Date:   Tue, 23 Feb 2021 23:50:23 +0000
Message-ID: <20210223235010.2296915-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.0
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f7a1ee2-5d40-48ce-4efc-08d8d855c952
x-ms-traffictypediagnostic: MWHPR10MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1871382A6C23AE0D0D4F9FB7FD809@MWHPR10MB1871.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rFIpfEml78G4le7hN3nfe80bODJ94jyrLCDckbBY6Y+NWRKhoMLl9xM4A3i9/Ixj2LgnWZdAJTKkW/fHjf9MS+zpBJgR8awAxgA3jtEfALuPLCTptOgfMppM2DV5ljwNg5o1qkI71Ao6YNy/lDN4M9yR9RzNMs/cWbtJ/NyoXeR9YQXOrWtMkKk2nONnCWMKVWKRiSQfYS5qfhG+G7tuoCLqzLKrGnaIWUJhXo8FOcvYnAubTI5XXMflA7g7ZosnZQGBY5mH7gN8E8IwpL4LyQnAoJY/4BJCLEnMKn9Gy0TePiV6g6gfgRv4WCI3jRP0VGXFVP39RewQtTuZoiFM+r5KHEyton7jIW55W2GzXPGKSsg6mswhztnXzKdFwYsx2txRl+sK/t5lXc7IKTKAvbpU+NeDBeQcNNr4wncCM+VH60h86rxFwQYIwM+QomzPNeFBjppP74u/7LnjZQx0Kb5nxGmwWTaXwPM/R9dfESDmfrRuvCQOmf20S0VWdZ7epx3eB7jOxP5vpuhwLYZkrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(376002)(136003)(366004)(8936002)(186003)(6506007)(1076003)(66446008)(26005)(8676002)(2616005)(478600001)(5660300002)(66556008)(44832011)(4326008)(64756008)(54906003)(66946007)(83380400001)(66476007)(86362001)(76116006)(91956017)(2906002)(6916009)(6512007)(36756003)(71200400001)(316002)(107886003)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?j3qRQ3F64gGKY+GBEeUSX8xwp7P9MWP67YPrk4PaDDz3ThzhhrSbV3T2cH?=
 =?iso-8859-1?Q?2t7cKlOAb7eV3j55PSkmBOZ31lu4USfo0HA9ZgxQq50AUo4IMS7o0H9S1y?=
 =?iso-8859-1?Q?OVp46of74PIzXoPeOUc1QhhkafM3JbnP0CHfrfU8EcoqFPWc/s0+upBtSt?=
 =?iso-8859-1?Q?AvPoTG3XlzE+3IpqNHZ9u5kXNdMnXrejYPx3R9U60dP33zhdlN9GMgSjbg?=
 =?iso-8859-1?Q?B0s9r1ZHbYIgxt8+xo9BoRlbwaVSmUJAG8aR07FS9sga0hCBZC9imW2PFY?=
 =?iso-8859-1?Q?PVVfmORWm7qjYfCc7g0qNt631lTwOSj8qNbGkCeGhN1CdJoEh30Nh+dOR5?=
 =?iso-8859-1?Q?gUk7yKnTlh09uX0PwKF6aIZ5a477VEJ64YsONHUVSprV6mRjTaVkDKpqPM?=
 =?iso-8859-1?Q?/rUzLgxRqJ9U9crD+zpURowUlkoGif4wyUjLqQZy3DdwjpBefFb32H3+S9?=
 =?iso-8859-1?Q?3o43jWuP394wovnSxbTMhpyCGw5TDbTIm3N7khDuy3U8fZFpk0e4xS1Sm4?=
 =?iso-8859-1?Q?EUK0Y7Z+6jmg8H6ZWtJRN1mvn9WMUTJm8b4ZRXVkFu7LkD7N3MZ3Lk6/vo?=
 =?iso-8859-1?Q?83uOhgzRdXEdiaST7fE+ickXW57SC3+StdmBnj5ULXw0Zeu9AtgW//0CRU?=
 =?iso-8859-1?Q?xmvyVTh86ZHdmDP1SQDY3a+UtjjD2eoYhOIZmQtgK4vqTUwcqSO1EUrI8Z?=
 =?iso-8859-1?Q?wJqd5bBWZDM4cIDoN3ZHBpe7tsg5yXUjoezh6uIR9Ta8Xn4OFX2MKNKc5L?=
 =?iso-8859-1?Q?hDf4g1PcfFMr6naAuGE2usUZbuMG/6WAh/LJE25slVgMqIWgaiOMYEjFtY?=
 =?iso-8859-1?Q?F43zJw+By3Rup7kktRqX35kbnNNGUm0rZtcXDToO8YrVG7rWX2KXljSex0?=
 =?iso-8859-1?Q?hhlqrhjS+DAKk5p6Nu5xO7JJ3Ysu2kD6xjTOL/9keC9EE4xRpmYrzqlzNw?=
 =?iso-8859-1?Q?G5e3BHfSD0KczL/YD9eK4b9ORJtlwFTMoZotFuyad5F5WuM8RRi3yMYI0t?=
 =?iso-8859-1?Q?ystkOC0gIKF3euVdRkdw3aRgZ4TC7gpvsWkR1uNYvIyMwvku2mE9JXKpyS?=
 =?iso-8859-1?Q?LDxHyZmmLIolL6UTFMK5BTGacelFprzOYIW6Aik+cLTYYbyajpeK8cpfl0?=
 =?iso-8859-1?Q?ASEr0lqHM8iNK8qxzf7l0Zje/9YAv/rVAPG8QmQU75ek3Uxwo7itR7sp4T?=
 =?iso-8859-1?Q?aXpGGqHwbqci/gRE2gr+PLB31SVjvZRIi5yAXvRKAyGvd+SHzpkgAcU+Hi?=
 =?iso-8859-1?Q?Qhm4/Wt8O7Cy9w2zOX9Wz7uLuASgOo7cP1bkCYxQbaStIsNUdJf/wnZIO4?=
 =?iso-8859-1?Q?dERwL3o0JsFhXdHJ5BlNw86GmYx0dk70jWErkq+tgNHCZLkKYtyYZ6uB47?=
 =?iso-8859-1?Q?SO9C3hU1nY?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7a1ee2-5d40-48ce-4efc-08d8d855c952
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2021 23:50:23.3060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6u0lxrmlDZdbXzBbWW9c+7ar7PmURF/4nZ3Wk6U2Mqt1trqDV0yvGYoL3i22h1BeyEh0klKIutDE47sWd2Zlug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1871
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230201
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230201
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this call uses MAP_FIXED, do_mmap() will munlock the necessary
range.  There is also an error in the loop test expression which will
evaluate as false and the loop body has never execute.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Hugh Dickins <hughd@google.com>
---
 mm/mmap.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dc7206032387c..e22b048733269 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3025,25 +3025,9 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, sta=
rt, unsigned long, size,
=20
 	flags &=3D MAP_NONBLOCK;
 	flags |=3D MAP_SHARED | MAP_FIXED | MAP_POPULATE;
-	if (vma->vm_flags & VM_LOCKED) {
-		struct vm_area_struct *tmp;
+	if (vma->vm_flags & VM_LOCKED)
 		flags |=3D MAP_LOCKED;
=20
-		/* drop PG_Mlocked flag for over-mapped range */
-		for (tmp =3D vma; tmp->vm_start >=3D start + size;
-				tmp =3D tmp->vm_next) {
-			/*
-			 * Split pmd and munlock page on the border
-			 * of the range.
-			 */
-			vma_adjust_trans_huge(tmp, start, start + size, 0);
-
-			munlock_vma_pages_range(tmp,
-					max(tmp->vm_start, start),
-					min(tmp->vm_end, start + size));
-		}
-	}
-
 	file =3D get_file(vma->vm_file);
 	ret =3D do_mmap(vma->vm_file, start, size,
 			prot, flags, pgoff, &populate, NULL);
--=20
2.30.0
