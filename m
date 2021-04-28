Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7B936DBF3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240910AbhD1PkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:40:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:27852 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240407AbhD1Phn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:43 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFOtGP015173;
        Wed, 28 Apr 2021 15:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rEdqFMrb2zaQQVRasJ/ulhCgc64FkZhHw+mlEjz0CuU=;
 b=wcOwCmIFczl60xhcmIB39wwSDZnzO4rTCE4qzz5+OSwGDEfHUrs0nhQi4UppZtI4rQZf
 5b58XUjBPUIwSfymmw19BTn4E3Ttt2+EaTebL4LOXuDzvWIoKkWPOrE+mG+bUx1bTR/U
 saHDHouQQ7n71fiTQml9EAFjB/4nyjs1atzcv2J1yGa7p6J6nUByIIw4GN2iPsRE0jTt
 RYEX95MfzX2FnsM1ExpdeKAcsUTdJQ9jI6dEge/0cP1KXagtVakyv6sgs/9sOTJ2m39J
 nNsrMO/Cc3fvePgnSj6J5Kx0eAINeygTQ1Qkl9M82A+iccewBH79Caz14n5RurqRvl6X cA== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:39 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFY4iX022800;
        Wed, 28 Apr 2021 15:36:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3020.oracle.com with ESMTP id 384w3uuaea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgyXablksSeJQhsP63TBzvvgINTkGHHZaIPe1kSwPKc8UAfM0NLuv9yQJlAxs4ErEhLmuvxpeXhR3o3F1sNoZqpsP/EDZgbCc6uCdKHQJZbDuueSzcM5TjzF3XG12ndOd9iGIeErZ34V3cfG5xFrSiq11kHUkPSDTsE/N9kEeGw/SUo8DufWNczc/9KkVZAmTjnlyvRwQ8BgftFsgV4Z9JOztnYPD0RnT580ThMTVWMwAcDjpOah7h9cb3MN0EC3ksQwZ+WxgkzfWqkUeq7oY4x/b/Nf0EIv59XqNx4qm1D+GTeL/mFHVzASzKPfc0vX8DNaBPZenPBh/1JKk2te2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEdqFMrb2zaQQVRasJ/ulhCgc64FkZhHw+mlEjz0CuU=;
 b=kdwC8cKynXW9p9fkowTd1fUvQuElexhcSMzBOFDBuCxRpXRHp3geo7fkBVkeJuAd+8cPHZ3mVZwzx4w+6SYPEiCTsHqTgsxZ+HF1X7TLLKyr7zk4i3syFo1WXGohMnS34lmIB+3I7uMgQALwG4L7APjTPY0oDSeSK83juLkwIiIYEgtzSZCW+YnvHZjwTKB07CVW3oM//Nvzw6L6WfMpaneZXa3olbJ0vL39foXyMyG2qlHZblgGy2M+zGYnbuh2y4DhK33ykCrO2NLxzbAz8RwsagV+XEnkfMCllxSHNvwGCTZmK4xsDmyUAmtm8OYz5ZOPHbnY1UjYi5bT6S9jyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rEdqFMrb2zaQQVRasJ/ulhCgc64FkZhHw+mlEjz0CuU=;
 b=q4wiIZrx75Z4NXAMCb1Q8tj/utGOPCbYYk/Iq/+TfYXUZ8rWNrdJ4xznhiJ6sLa3uhWvsoZIwgMvvSEHz43v2r97uqBvnMVND2XmNQfQ2BaNZ+wHywAxQVSKOtn18v6O7G7B8AJhgTuEuxGSyJKau/6nXdUd5Ib3unrBe+88dSI=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1982.namprd10.prod.outlook.com (2603:10b6:300:10a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:36:35 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:35 +0000
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
Subject: [PATCH 30/94] mm/mmap: Change find_vma_prev() to use maple tree
Thread-Topic: [PATCH 30/94] mm/mmap: Change find_vma_prev() to use maple tree
Thread-Index: AQHXPEQzICtDe6rRakSmm9wmPE6aTg==
Date:   Wed, 28 Apr 2021 15:36:04 +0000
Message-ID: <20210428153542.2814175-31-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 261724b2-93b2-4b9f-8837-08d90a5b681f
x-ms-traffictypediagnostic: MWHPR10MB1982:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1982D432A26F7554BC5F5E41FD409@MWHPR10MB1982.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZSypMPZWw7EeN4XFiRqzXWAMz9oeBOYaiyIeXEZceEF1wu/gyeIXd67ameBQQ9g1zm/CDvkq7FQQkKnGw4aF/rf4Fx/M1X1DF60wU6kuXlKC5XBnqhrPG3Lv9YvpCwlB5Klel40q54WCK8CDxpp8hMSv0bFCmp85rskzBaH+piFbV3T43+pCnHIThtp544VkzyH/syFBqpbADidtxnF97RBz52wcCNOtOMK6vuo3DLY50tFqRjzCVxp5BK/qWffrLWSVeRkiVw4P+22FDdWFTAYlURiW/P9dRQvo4Qai/lfvsRw0SJrh6vw1D01MhImOA+EntZSkLOflBRaVAL9QvceDNySO7Rj4Qxnn9kfoXjPVWjfth25y8vogxXqk7FKPRnM9DXcoFqRJhHE+60prJGWeTkjA/6p4LQe4T91lnvOPRpT2hGu19oFfurtCcnoxKc3Wr2DuBOaYYLhiJ2x4Y5ttAU4rV0r1tU+rmmNzN4achvAZcQe1kdtard+6JRKaUgMYZPhaL3cAYsbRbN7nWsFUpuS/6jZEjfIwnrbCtHjaYIseeMhx1h1T4iOJNpdIjd8scR8ehFiM9pd4XkH8Zjzcu63i/81kwHh1cGEhhAo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(346002)(39860400002)(2906002)(8936002)(6512007)(1076003)(66556008)(76116006)(83380400001)(66946007)(6666004)(2616005)(7416002)(186003)(26005)(4326008)(110136005)(107886003)(66446008)(54906003)(6486002)(71200400001)(316002)(5660300002)(38100700002)(91956017)(478600001)(64756008)(6506007)(86362001)(44832011)(8676002)(66476007)(122000001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?VZHsb239s6PPc89no4UOK53xw0SOAAUPhIzMzMJeG+DriZxQGAYIM7kh2w?=
 =?iso-8859-1?Q?kmwB6f/d3to8IsFFIQGjmXTo8+YEaYugFKEnZTOqzLOmXBxAyYimbhY6W0?=
 =?iso-8859-1?Q?JMsuZV/PFTwXQUWxeyqbQjGet6Ry1IiMThqu7HndDU8RwGqgWMY8lYzjnF?=
 =?iso-8859-1?Q?qJba2+ngkyDxfaWWLpsZPTpXVWtUgFa145F9GsTPjVYwRngTb/eUQWvOOX?=
 =?iso-8859-1?Q?cltSPM+pvzWwKzW1VjBSFnPZFIQOHRZmXkoXgWvgJqlT1uL2Km5H97C11b?=
 =?iso-8859-1?Q?/0KDQ891HV1OMuP2VZUJxcmqnLJPWx+7bHAWCsx6vEH3JZaPC4vQKT6T0a?=
 =?iso-8859-1?Q?45ygOI4ol4RiKBvOwcpiJbsXIReeEmky4JMFq0VkeA7tTUCL4mS3gxadBu?=
 =?iso-8859-1?Q?U6OgLAy8P6OQyVq9pYaXHo2rzcezlpNusm8vDTncDSFTcjjuP9DQzeGIS+?=
 =?iso-8859-1?Q?51onjUrj3gmKibnRrewF6Lq2NiVims3rE4rnRvDl+h+VWS9SALOZzQvHLj?=
 =?iso-8859-1?Q?K7KRutCWKJP/0gl5wWm3CTh7dl/sSCn4+j4ZsPeHOqzwMnaE0u9YrBfjCZ?=
 =?iso-8859-1?Q?IHyztz+0Rg6btmlkIn/5r0xR/5z877ZHgBKZ+dIDAJBOqqWgdd9qO0ayDj?=
 =?iso-8859-1?Q?X/mTY42hgPAWQDJxvlE4wmg6l8KKvnv15ylvOGQj2LSqwvoFtVOW0uzADi?=
 =?iso-8859-1?Q?2Q0vaRbFnPKGWcgXQiUSyonQl30TAyt5AT1OiBVJ/XmW2tcNGIPO/4+bQ0?=
 =?iso-8859-1?Q?xS5VOu3NBi8Vrx+FY2tVxNFopbj20h9X5fZraMfqS+DyAF3bFAUOxT5mtP?=
 =?iso-8859-1?Q?b8vo+2uJjhVe5q1C/whaVnWlq6mUUqYkXbB85C5IVdDbpzuWDRvIIWmb3b?=
 =?iso-8859-1?Q?/i7GhnOyEM+scUkPmXQseVzNKXSOlka9fRV2Boj5JzHgU+y1BJ0V77Pu8X?=
 =?iso-8859-1?Q?TDa0VNrCHhHQrhrzOhQtIgvP1HcHbpk7+8+SrNXZ8QlBZhHNaEVFA2GhxQ?=
 =?iso-8859-1?Q?foGyKdB0msL5rLWdY+F+4v9NiPgMe9y29qRmSEzdT1ATN6V3Eq6bWID27k?=
 =?iso-8859-1?Q?QkiS8QyenK+gsayeqbpN4k4Ernba8pZeVdkqt2iAlVkEqOky6/OJzwRTai?=
 =?iso-8859-1?Q?hX2QCPByt6Ow4pBaLJc14CvJt8jgkU0JfuIHXzIYgPQlTq/KzAtWUb5h6b?=
 =?iso-8859-1?Q?oh9p16sZ2j7GrhCiNSGEuWOv5eGJXrqDX626ruQ7IkhE8+GGRRZ1mHu22N?=
 =?iso-8859-1?Q?9XJwDDMGMO/a2yQVGJ50clzHTegGmPJmEG6xiaPbcFU0wsPNWS5cMO0d8C?=
 =?iso-8859-1?Q?m/H3KtoMVLoBrylr1Zv519sQKivYcGoKOJ/ILO0DyoFlyk4BKXwA9ejT++?=
 =?iso-8859-1?Q?lX6paZd8D9?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261724b2-93b2-4b9f-8837-08d90a5b681f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:04.6870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDvguAyUMP/gTJNYerUTCLeh0L0k/X1PKiYxh3biEIxvPTL8vjPaiIS4AxnC/vcFqpbesYZDZu5xVR6G6U9hCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1982
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: ALF6ILs2D_XcpQ5P7aLwaeN6e_KQoj6K
X-Proofpoint-GUID: ALF6ILs2D_XcpQ5P7aLwaeN6e_KQoj6K
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the implementation of find_vma_prev to use the new maple tree
data structure.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3a9a9aee2f63..0fc81b02935f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2508,23 +2508,30 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
m, unsigned long addr)
 }
 EXPORT_SYMBOL(find_vma);
=20
-/*
- * Same as find_vma, but also return a pointer to the previous VMA in *ppr=
ev.
+/**
+ * find_vma_prev() - Find the VMA for a given address, or the next vma and
+ * set %pprev to the previous VMA, if any.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ * @pprev: The pointer to set to the previous VMA
+ *
+ * Returns: The VMA associated with @addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
  */
 struct vm_area_struct *
 find_vma_prev(struct mm_struct *mm, unsigned long addr,
-			struct vm_area_struct **pprev)
+	      struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	vma =3D find_vma(mm, addr);
-	if (vma) {
-		*pprev =3D vma->vm_prev;
-	} else {
-		struct rb_node *rb_node =3D rb_last(&mm->mm_rb);
+	rcu_read_lock();
+	vma =3D mas_find(&mas, ULONG_MAX);
+	if (!vma)
+		mas_reset(&mas);
=20
-		*pprev =3D rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb) : N=
ULL;
-	}
+	*pprev =3D mas_prev(&mas, 0);
+	rcu_read_unlock();
 	return vma;
 }
=20
--=20
2.30.2
