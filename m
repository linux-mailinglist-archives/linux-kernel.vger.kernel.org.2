Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A343A421C09
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhJEBfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:35:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45750 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232216AbhJEBdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:54 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951NSP5023914;
        Tue, 5 Oct 2021 01:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PFd+vMy9PW7z1+Wup1XBFBjBqTggUvVUiKvvvwpwxyE=;
 b=bC2UnI2H/GB7X7aWPwcaoNnmmBsdLGSfv2SwyBrAOzbEVgxj+sr/Fb6WeAIibfhB+OHm
 m9Zf089/1ZOiqqPPhxyZf03Uqzz3bXetvl6BOtSsgXm8apb9YKwb/BNfNVfVToG13axZ
 qHpB9wHX9QaCujmQp9BOfigIuTR4P0zXfUf5NBwntv3MFlZJkAGFhMRzHzktb5RqYUDA
 qPdfnyvR7AN4WsCdKz1p9S7Xg84h3B/TVjHGfOpzoFRsaEnOUaMyNlxaOezfqleNYqFi
 3ouxSZVb1yrM/gsmVOh1ewVyUY0i1RXWqoS2R8BrN9U+Fgd26tC/I8kEOHfpg/jLh1em XQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43gkpj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:33 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UHTT178361;
        Tue, 5 Oct 2021 01:31:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3bev8w0386-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJZBlsHDBc1gIJowfj0ZYrSYGu+BS/qFdZZerURJrx+7LcYjhIYfrNphTMC/vOt9fPVdiqNruDpUxtOgcX2Bt8OuCh9H8szNUt+cykcJcNpsavJ48B/yJ5eCicDADUgezAJzzPwIsiqg33+YPLGxtWw1OuGkxIUYQ0pU1Ww3GskXgjut88mI9cqyhyMT5i9dNMtPIm2tZAzHTueBFXImK+lIyLZeCt1Lv+DzYRt2IMDUimuy0Dy8tiMm63YL+pfdZQJlYpb2lJjc4qjhWFX4Xyf5Kls8/X/MPD5uJdzXyeZg7dFWNKcJ1DVUDp/6ZEu4TQmzltLTXylBkSNVh0L6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFd+vMy9PW7z1+Wup1XBFBjBqTggUvVUiKvvvwpwxyE=;
 b=KyNaBZGXqx/vUvYTRtKaN6KYK083QKQ+vx7ewlEtTJaZNO7fHX/fc7S5qSmQ32B3OmxlVKaMTVPUmpgQ0kLwqVeeWI6cx8uCzbeibtPG/7Aj3pBR8IMniiEH1LOKueN60Omuiwx4B7ZCiFjMjHfVvEJyoGQz3d1YDCheQsP9yLeV7KGopgiPKvxu2MID9EpFBp8PKhaTFqY6tgLJzNriS+IwPtdwy3dk3dArZCoMolgLeo7l+xmk/89WWe6WJQfD42UV5EjhhElpIMfpvrGvftA9x5uuF5DJwwIvOxV26sctriduN6XRCQWr5qOSY1lCqjgnn3ogeXDZ9cjIemBLZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFd+vMy9PW7z1+Wup1XBFBjBqTggUvVUiKvvvwpwxyE=;
 b=ymfLSAiT9hX8r32cII7TSEW2V+VDpU0xSSdZkMExOAT4SQYMhCdrCh84m1n9guJVpeveY8WWVuzoVDBBaNu8G5er4JmXaJ+8eifVho5qZuxPYK49lP9smrgjZ2ucadqQWQwRq2pCNImWQI8Q5z1VDRKUxG4DoC4a4qo/UdoqKUo=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:25 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:25 +0000
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
Subject: [PATCH v3 54/66] mm/mlock: Use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH v3 54/66] mm/mlock: Use maple tree iterators instead of
 vma linked list
Thread-Index: AQHXuYirS3dqQD537ECUEyVxWTWuPw==
Date:   Tue, 5 Oct 2021 01:31:06 +0000
Message-ID: <20211005012959.1110504-55-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: c89beb1f-b301-464b-d278-08d9879fd8eb
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044A1609685A982127CFE99FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c6yBssLsVPNPYQYLqqfoXJxVdU2hmc8dajxpt+vEKAULsVl1T72c2LB/7srEzxzgGO8Q/H9DqXYxyf471rkqKKYtFhkqFZPOSzcR7kKyiC6yt6JC3YAqpiosH+K5BalH1KcB4zC4M8enZPkEF6jW+3IRdI9E1xVr266tE8P237yXV9DyMXPtImyUJhMZ/LDzzjleoh5AJxnhV3SlHu0eeqa66PHGst/syGH6b8yPNBu31s/amIjx786TornJX3dFvyIhzT9My/GbiErkAPURAlATbrGbJNWBFefQ+BLd1O/AmCQjWKr1vpdt9IsodTR0MlP6OLrkQRb6qYNjTTXaWADBKUpmOfgsh5M3a/ZOiRlvGhzHpNa2jFzhjz15ta2kSqiSeJ4kUpCXMjboMBqqPjuTfnqqfN2ZOcUPfLk7jl3Mr6NbqnQ42ANm1sEfhKoco1Aenn47h7nqjpFTJ8cfnzb8T71ix+gOOt4kKRDkt8LjNFvlvJtPO1iz57Gq/LTZ7YIGgTCatBEzXfbDVEVXK6XYGpNGI58R+9DUBEzTVsdvZ9H7XjNcA3F6wuB0aP2OYnHyU6tetaMGcZ3MNRfh/LzmLALJp9twU+Kf8U8nRrZjeHUtaf2j9wBztLz90yNkAng+MMaztUHdGElY82rNS12ZO+NhbezR9YZOmC9g6kV9yrxheKJTCbBmDWaJY/YWmgBESsx858WxdHGfI/4cXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CxLU9DTu64Ppw20UUkFJaUfKzV7pPySjfbh9TpPuPtTxHphAl7IRoD/HJx?=
 =?iso-8859-1?Q?FNbt6ZIR8qCNXQWzskCwpRWznAC3Xx29WZhxH2oHh21vn7RdTPAqr+Hjds?=
 =?iso-8859-1?Q?alulugMM0zEyTcC5F/gp/95RGKiDa8RGe3e9KNpp/2eaGQvfy+c8KQclGq?=
 =?iso-8859-1?Q?PtgHMzdnoU1Kzu5417cVDx7ZDPlRrUJKnibcf4esTUUHBYSy1PC7Z1hMZk?=
 =?iso-8859-1?Q?rWqlGzAy9Cn5tzgXAzXf0pmmEKZkEy4UUJjZ+fspgwJyy8cl+2Qess8znG?=
 =?iso-8859-1?Q?SgX/xLg4xeoCA5TwOakLyQxrCGy+NBw1t/TG0eM68YN73SC3Jpu+sDDd5X?=
 =?iso-8859-1?Q?6LiVy9a/qzKALrTY1c1eJ0cCFFlPCujUKTCILyqqKD8RlU0kFW3f/YQFX8?=
 =?iso-8859-1?Q?AjtPyp2alRN385JpQVNL/r7kiXy2rWZMHj44X9T3z8jBMQf0XmLI7G7se/?=
 =?iso-8859-1?Q?Uegtl69RGLDcfhjlt4ZydMwzeHO6jyJQvdkaiOcg/zn9LJqDHMPhlbcJNJ?=
 =?iso-8859-1?Q?njpxfJOgBeuVefe/7ruq3A4eyAlWHFDhtTnNHH3rYyOXzRJMtTK7eLZam5?=
 =?iso-8859-1?Q?DcCsZ5FzsgPhfG/Yc4dSjXt3UfBKYUKGCNN2PwTQuA+EufXkXA4v1jEb1j?=
 =?iso-8859-1?Q?wSA8L3kyosMAACHgJCGHG0JMAfGWTpTkwo7HSOwRF2/y/IulcR1g+Wsl4e?=
 =?iso-8859-1?Q?SpZ5ekVsDgbcjaSWn4/lqRwI+e65WcRRvYqdmKaXJ9JNlnGQP2SbsnS3eL?=
 =?iso-8859-1?Q?reZa/KzrpeRD0W0dmBU8IiX6/JUzYsLHN/80qmSELlMJ4wVX4Ld489TBpV?=
 =?iso-8859-1?Q?9m6FlCC+gXtGQokobMNdHHD46CtDjQG1bqV8bZnS83lOVMoxIVx+HC16TH?=
 =?iso-8859-1?Q?CaaGp2OC6+56Qdu4L3hJ1aFVO4dhix8m6IesPY39uHEMe68M8vwE6I2648?=
 =?iso-8859-1?Q?0vU4tliD5+KHwPRUr/jBy/Cqx/ku8jnWoG4ZjljLCDZxq+G904jujPCBU8?=
 =?iso-8859-1?Q?sS1JQo8WOxJhOLq77wM9FK0MPWi8BoqxS09sTZpnumG3Vz9nYZR1fs85gb?=
 =?iso-8859-1?Q?sbMwel41X5xIRjmJ9XnQNztNSFo4IZf+d6v8MNBImP0umK6el8HuyujNKQ?=
 =?iso-8859-1?Q?DCGHgJ7RVhNjLck8eSxoAv/v94EXEIqPejrh01yprP8NsA64bJpql7XOdL?=
 =?iso-8859-1?Q?DZg9RvMYhn5LSkVfw6tXDGElaYCtqs5HYKA2FwZFBwsM/3FRqBtV9ZgReN?=
 =?iso-8859-1?Q?L2cWqZHmBlFEeryccxpAG93C7k5+pasUPNMiTgs9DSK1QsRDPBjS94THmY?=
 =?iso-8859-1?Q?iUohGix1H8qnpPYYKp6mth+OsfTaa0eAwJ7baFHKLdS0IwWjbULKvfLx4s?=
 =?iso-8859-1?Q?fwsYkunDeS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89beb1f-b301-464b-d278-08d9879fd8eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:06.9626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +b7hlVuydtXNxbLYt8gzNE+k+OfJ8coxb7v7juLhcpVk/B3o0v3tvQZPvx5oDR5u1XE8mXL0KMnszuSvoS338A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: 6aFnNoTEWnPv6pOuBKjYRbxLCYbcYFyo
X-Proofpoint-ORIG-GUID: 6aFnNoTEWnPv6pOuBKjYRbxLCYbcYFyo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mlock.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 16d2ee160d43..1e102fa52ef6 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -562,6 +562,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
 	int error;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	VM_BUG_ON(offset_in_page(start));
 	VM_BUG_ON(len !=3D PAGE_ALIGN(len));
@@ -570,11 +571,11 @@ static int apply_vma_lock_flags(unsigned long start, =
size_t len,
 		return -EINVAL;
 	if (end =3D=3D start)
 		return 0;
-	vma =3D find_vma(current->mm, start);
-	if (!vma || vma->vm_start > start)
+	vma =3D mas_walk(&mas);
+	if (!vma)
 		return -ENOMEM;
=20
-	prev =3D vma->vm_prev;
+	prev =3D mas_prev(&mas, 0);
 	if (start > vma->vm_start)
 		prev =3D vma;
=20
@@ -596,7 +597,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 		if (nstart >=3D end)
 			break;
=20
-		vma =3D prev->vm_next;
+		vma =3D vma_next(prev->vm_mm, prev);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			break;
@@ -617,15 +618,13 @@ static unsigned long count_mm_mlocked_page_nr(struct =
mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long count =3D 0;
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
 	if (mm =3D=3D NULL)
 		mm =3D current->mm;
=20
-	vma =3D find_vma(mm, start);
-	if (vma =3D=3D NULL)
-		return 0;
-
-	for (; vma ; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, start + len) {
 		if (start >=3D vma->vm_end)
 			continue;
 		if (start + len <=3D  vma->vm_start)
@@ -640,6 +639,7 @@ static unsigned long count_mm_mlocked_page_nr(struct mm=
_struct *mm,
 			count +=3D vma->vm_end - vma->vm_start;
 		}
 	}
+	rcu_read_unlock();
=20
 	return count >> PAGE_SHIFT;
 }
@@ -740,6 +740,7 @@ static int apply_mlockall_flags(int flags)
 {
 	struct vm_area_struct *vma, *prev =3D NULL;
 	vm_flags_t to_add =3D 0;
+	unsigned long addr =3D 0;
=20
 	current->mm->def_flags &=3D VM_LOCKED_CLEAR_MASK;
 	if (flags & MCL_FUTURE) {
@@ -758,7 +759,7 @@ static int apply_mlockall_flags(int flags)
 			to_add |=3D VM_LOCKONFAULT;
 	}
=20
-	for (vma =3D current->mm->mmap; vma ; vma =3D prev->vm_next) {
+	mt_for_each(&current->mm->mm_mt, vma, addr, ULONG_MAX) {
 		vm_flags_t newflags;
=20
 		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
--=20
2.30.2
