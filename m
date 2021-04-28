Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CC736DC28
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241198AbhD1PnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:43:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62982 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240445AbhD1Phv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:51 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNiXS032601;
        Wed, 28 Apr 2021 15:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=qb3Gv2uA5uFBhEl4gH7PwumQpn7PPVKe4rAXpPcQEsE=;
 b=m4xpv+v3/RlaEyYmnZgan/3dAi0b946daExlgYlYgMrOCFRzvplrY+GnbqvehCM/EAQU
 o47ufYFB7OJzquFKGK6CGW1qR9pjEam7iAZ+oiPtnn/jd8//bJTjupTZhptTJhBAQhv5
 vPHq1va0ItjPv5dPTWrnDAX1tKFRXKu5ymhagVLzheBv1rzR8N+vANIlksS7QSzz+0Vn
 gJkGXpGWVXOmi/qkICtb+y1M4SMZe+0TQwFXTkTen2tmVVr95y6A9AVpxKreDVX3u5vo
 TuE1OXvpirCTfyr3jbrYH9ED2+n/0dy9yN1BibPgRjJkhREgrnQlDEw9pNLYf7sAhh/a hg== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3874kn0eq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:48 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaASx030176;
        Wed, 28 Apr 2021 15:36:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 384w3uuag3-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9kPXQ9arSzTu/N8g1vgqTb94+MSxo8ctdFiC236Uskx3AXUqhUZIuNchiwzzpbyOy6QnPRW7nmLWhDrpdj0XWRyjiTBf8gIPBvCnJkzOlafnMqHURxH2yqKzmUrqL5UoHWfsxJpjmRPYf4XtoSmzFUIhLhRf0RHLfevHAfLg9A+A2+flNmKFP+rLgyEn7vGGDAF/r7MibIAkjoE+Acj8oiPDJf1dH8Y9j8P+F5vvxxzAXEESpZ5YtUcC1+1sppMapsk65bATOgD2K9EEXKwjZLpeZ13ssBCD9dFhhEm5EdTV9mItKRgmMF0f6HbZJIsLwEeuXNdB0RUO2xgtcVRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb3Gv2uA5uFBhEl4gH7PwumQpn7PPVKe4rAXpPcQEsE=;
 b=Q4zDWlUqj7z+XiTS61aVz4969sYLLi6GkPeyUanjb6Py7R5moZYFFEvWB3LBJ2DINoEia05+JCbz00aMGXA30eBjxLZiVylCbOPaI8yke5okhpfUeOLrpVA1C2z1HQPPR8ysS5EWlEc5XL1EPNNqS8M189bqQRCknekbQ+yfa7IaEGgigZOb0JOv5Zv23HMKyxn1YQcFaQ7WgNhXQTvzIBVHiPcTilY5JnxOGU4ki9JG4BHBtlaqPsSjdnIjr7nr6A9kjlAZaGWhuRcxsAmYAupsU31QZ2+GVE+L/Y5RDTrO3D10d9N5RLdzd+EcqUn5CyA5HlFevNx5zUjKrQhprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qb3Gv2uA5uFBhEl4gH7PwumQpn7PPVKe4rAXpPcQEsE=;
 b=vA5lRPduweGv7rT76B9h5psILTuzHRLM+nRRj97euuNisRoG5NQuwMF/uGYZhWrx9V8WNE8Byv6+w0vUk84b1v/yvhZsTiYFvRC3sUgXUntXNVbn9ePwDDGIpC6ldKfl8YnmSrpj+0zuTGt8lGbnz06o/oWxrYlFHcDiqy5G8KA=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:36:43 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:43 +0000
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
Subject: [PATCH 48/94] mmap: Use find_vma_intersection in do_mmap() for
 overlap
Thread-Topic: [PATCH 48/94] mmap: Use find_vma_intersection in do_mmap() for
 overlap
Thread-Index: AQHXPEQ4cZaQza+8Rk6MhwFUwwXBFg==
Date:   Wed, 28 Apr 2021 15:36:12 +0000
Message-ID: <20210428153542.2814175-49-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 45892e75-1af2-4047-1f12-08d90a5b6cd6
x-ms-traffictypediagnostic: CO1PR10MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4515A37FFEE6CC4CF4550EF1FD409@CO1PR10MB4515.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Bletr0Q/kcE5fbaBSwEZgdk7lvqJy/kfneXR2flL6LzgHSzp1HO17g2930aJS7eFqr81GCanIZyeh8KzHPz+wXanvS9m5sfnE9tll4PwoHqXv7cm+oGF2izD8CK+Lab4nLHgvc+ul5cNdWBM1xoY8k+vEDKoRb2F/CFEMkEQtgZvXY79xXmlW1ceyxXQTPJwtgm7SGik/pLG1RIOojyJaN4/Wm7ut8/6dCqG3M7z2qdLnRg7cSm7LEqTSpcRmrhVxggYJzJudMXGirtKzzQYDIb7rJkme0ydwe2LuOKd6/bg75EKkzVRx0DdzcsalRt5LOANPm/TLzNdY2szK8PV27caY+Vry/x3zS7VpJhfWSZFU4nfh1RUU16OfW+mUNFoKq0InTiZqFpuNAlNvWrkEShpZJosxYjpflC2RHdnjsFK5SZaSD5/CrlwjArWj8nIyxFSkmeDO+oAKNp/Eqn+24ZnbO74rLOIy6fMwpGYca9x/8K5Fpom9jFT6fJGUnZPXxbfjbvPPciS0ja2DzPkgH8yexe3z816HoqoqCPDl3M/yWyQO6RyM2xDOXOA6kzTrlADtKL/X+M0QCCbKYTwRhoHynGAUEhwIiN1bjHslY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6506007)(4326008)(36756003)(54906003)(71200400001)(26005)(110136005)(6666004)(316002)(8936002)(186003)(44832011)(7416002)(2616005)(4744005)(8676002)(76116006)(2906002)(91956017)(66556008)(66946007)(478600001)(66446008)(1076003)(107886003)(64756008)(86362001)(5660300002)(66476007)(83380400001)(6486002)(122000001)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?wwe3GgXJu9FfDLeJCap7/dJg2SAKHI9VfS+N3taVtW1FIRHbYyyqQr69aK?=
 =?iso-8859-1?Q?GiW5cQqHaivQcPn3atW3eLcqs4MAiSvyXPUoEr4TToRQl1rVpxWI3Fbat0?=
 =?iso-8859-1?Q?ltGu+gOMfMsXgSWBBraqmDFywjV8a9S9KOKPRiQkOQW+ssnmDIQcsUpaXn?=
 =?iso-8859-1?Q?K7azZq4NfUflzL9p9GNKhfj2HbebkVwQfPP5kHc7I4so/rDx+AqQvIAuqj?=
 =?iso-8859-1?Q?xD8ec5cMGSNjNignGuq0hpdB5fDhC77lO0MIcO0Kf0gKph08BFmKdtc7eF?=
 =?iso-8859-1?Q?8gJJlDhQT6kP2d1nmoyEx0FzeHgoNnphiJLg/FJbX4/Zmf97TZIy0oAnf3?=
 =?iso-8859-1?Q?On+9zy4WqBoXFAJmbG1HwnQzMV5fCAHHhgqpn7i6GoDCOWwCCQr5mba/kH?=
 =?iso-8859-1?Q?QbbSsHTynInUcsKiHw7lTqaAW2OKK7dg0zQ+iCZiXar0My+m+LzUY3i4Ry?=
 =?iso-8859-1?Q?7IypUBtMSoEgj19Uwq2mRktMGXkOzHTRWPeJed3QSbjISEaIyn9v2lBJ0Y?=
 =?iso-8859-1?Q?Z57MQi+b1EbF4OJFHNPHW6G/17gqoOMZh0GdDd6tSAdZDFULWqVt7PPqTR?=
 =?iso-8859-1?Q?yH9inSlGx3QSkqG2MShZ4DV3YJf6NKMsSCCgt2FqXyq38ILzSZb9uf2LJK?=
 =?iso-8859-1?Q?1w/hqHKk0e/Fp+s2sNCJyhsOqTQcskL/KJ8Cbg15EQ59W3vNIex3woagcN?=
 =?iso-8859-1?Q?zB8Suwz2nmQvRceXcS7rZsZlPAdmCtBZHkOKt15PGhpClC/WYZYnpF3hub?=
 =?iso-8859-1?Q?/y2DSBHTtIsaajrv5+cIcfv0kUPsgOeLdfN1j1zlfZC78yhPbb/X6yK8Zn?=
 =?iso-8859-1?Q?cLfm+ZOAGdr26J+5S0WWd2biBhXvbptSHPkbvipgaQdg+mIOMzP8u1KSe7?=
 =?iso-8859-1?Q?QJ8GYBGhobxfMjQeu0kmKzxr3tECAfSVddUJ6bdVGi9rrCTGsLbCnhmf99?=
 =?iso-8859-1?Q?5dpZVoeeWBqKrX2bQS+awZ+sImfDiFcOUzeFb5kuTh18l+KVICotxUC0XP?=
 =?iso-8859-1?Q?qwUtE3Q43hwX36PTZDgZUuQ+nHWdvB5fPiMODSoNUD7umhnADetTfMVTH2?=
 =?iso-8859-1?Q?9nv7yUnd6/89CWAxxaGjE787VYTboTxN0bI6A7j4xypb3mGbQMcEY9FYJL?=
 =?iso-8859-1?Q?VD48hBmtQPfOKYcBXl6KPpXKQCwgO5hAwYdk7l5UrJE+90nOhuTrsRpapM?=
 =?iso-8859-1?Q?qlFI7PvXrhTtKZ7sBYCpKjGNzqtj1fwoLqN4QjICQVr7fMXtGECUTjvgV8?=
 =?iso-8859-1?Q?On/AGQghXK1o3KBkcbj0lHJifBO86DrpAqmGrdE4DyeWUTZslqWY7EJd2L?=
 =?iso-8859-1?Q?osFEpbpfyuwk29aHvfB+JeBfWRuz4Z1MEgWmFp+ThqzpNWZiVzpBKghqT7?=
 =?iso-8859-1?Q?h327hqATmC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45892e75-1af2-4047-1f12-08d90a5b6cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:12.5995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ahfOPyjbgIpPdFCWO/hx3gWihyhcBbbEJrV5XQ2VM349MLoBGFPM/ispvxu2Ii1Z+8nlvj0FKePA3mutMsqNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: MoU2q_jkDUKLQE5BtbdqUNCxqxVW5YWQ
X-Proofpoint-ORIG-GUID: MoU2q_jkDUKLQE5BtbdqUNCxqxVW5YWQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When detecting a conflict with MAP_FIXED_NOREPLACE, using the new interface=
 avoids
the need for a temp variable

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6fa93606e62b..3e67fb5eac31 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1425,9 +1425,7 @@ unsigned long do_mmap(struct file *file, unsigned lon=
g addr,
 		return addr;
=20
 	if (flags & MAP_FIXED_NOREPLACE) {
-		struct vm_area_struct *vma =3D find_vma(mm, addr);
-
-		if (vma && vma->vm_start < addr + len)
+		if (find_vma_intersection(mm, addr, addr + len))
 			return -EEXIST;
 	}
=20
--=20
2.30.2
