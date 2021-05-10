Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF7E3794E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhEJRDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:03:40 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34304 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbhEJRBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:01:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGsFPl173330;
        Mon, 10 May 2021 16:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=h5RNn6t/J7JDee4qNWalyV68/tmGEGDlcmcNW4sqW1E=;
 b=CbUgNGKXqI7MIdlT7CTqd/XumkdsELMD8IdQRbdkJfM0vbXj3hu2hNTIZkA2tc83q/bQ
 lq3wO7V9rm5KQa2VyIWP2K+S0jjVlRSp4qp/XHrYzCCvFa6QKXAE1e4ed2QmNAKoMATD
 1ZZUQtW5vcLEJQcrgel9Yp7hpatt4jFMHJX0LMJfuD77vuTcB0ZnmuhJnuzi1AGMJxKI
 NZGAG2J9A/ju3yKku7Tmovs6oaq4a29uwzlr71o4X/BzXoBW5aqZKQp7VLewe1ZjnlXV
 SRFU1RgHu5LXK0GETMySqACn/vsY6J0NjMOmDu34WIYkGp3Iow2ePkMzOsMA90qmbwJN Sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38dg5bc2gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGtx3T001777;
        Mon, 10 May 2021 16:59:00 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by userp3020.oracle.com with ESMTP id 38e4dskqwm-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux765IHRm6IM5Rg2eigMlsYTm2fk26LcXdSNusqX/ehjqPBVCa/tIkH/1AIIZBfyikEYtwyX2k6k2gRkzgIV+c5qY5/cAveZXIwxXo+REA0KTmSPs/OEHxXQogwSHIJ5UrfSYaKB1AkvPyeMqd+8ABpBcZGB75jOSes9IehJbPkz/sLkeq1jsjmwJq1NaZIJlYtgXX+uI7rXGUDJipW2keGVueM4V1uumxosEFCv/F96uNZ7RKPOZ2iCqp5PVHNbelY7VAzk1o+uXCPOcBDnMeT2vIOjsrE4fhpI29THJIiRYHocjQOIbXbi8zUTnemcunkxLIvHnNh1/sC0Ic34ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5RNn6t/J7JDee4qNWalyV68/tmGEGDlcmcNW4sqW1E=;
 b=iJeYMnjeo1d0E1ijug+y0BjiK7rf18UltSYNUU7T21GRVzEN32H72XQSnmemRMlmjvV+6f0Me83ce5/riUELVOTqUitQszr0EPitwp9o8xd0pJ0Eoh0Nr6bXIeN9j2K11tdvHJDCum0EpO6/L8j5UIxswZPJNVmf76/Rh7LNeSTXjgNXAPbAQ+H6u7oIEd5WhiMo1D16TAWRtY1ElPk5HCl95hlbvZ5+tz91AhW9Lfb9Dz6L5fX7l+ONSE90Avc7Zz2lWXIKSwuyPaxxSq02Bfq1EzxqTTIV6V/ourygIHrgQO4JHcja+nTEx5WoLWkg/Jw1KXmcmL7y7dv/6e8mVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5RNn6t/J7JDee4qNWalyV68/tmGEGDlcmcNW4sqW1E=;
 b=zIUquyUg725nN9TKGdNv8bDvydkR+H/yETe4uv+bQ3igoZYv/lkXzP+vtQ+I1ict0Btf8Z5WZDNCE4eLbBCwynd6aTlrZvYfbgTbOW+bheDXRIHXfla5MGOWTe8KX+BAlo1p19T4fSHW8qZ6IEugbxrMMn098WfI2CqFe/zb+Mw=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1437.namprd10.prod.outlook.com (2603:10b6:300:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 16:58:57 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:57 +0000
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
        Michel Lespinasse <michel@lespinasse.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 17/22] lib/test_hmm: Use vma_lookup() in dmirror_migrate()
Thread-Topic: [PATCH 17/22] lib/test_hmm: Use vma_lookup() in
 dmirror_migrate()
Thread-Index: AQHXRb3Ef6pRmxzHI06KCcftrosezg==
Date:   Mon, 10 May 2021 16:58:57 +0000
Message-ID: <20210510165839.2692974-18-Liam.Howlett@Oracle.com>
References: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 87260ced-7716-4c78-e553-08d913d4e695
x-ms-traffictypediagnostic: MWHPR10MB1437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1437672F96321F3EBA821283FD549@MWHPR10MB1437.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: if1ep5dLVoNV3mMNd6WFcIlt7npufQUdCkhixONzPSTcHkxAqpBajgT+MkyRbZsVB4+AWKUHYHPiE9HAMjJxdvT346hNy1vIbWSeuWfQE/iEfFdm0FEolzjDgeIUgH6eOl+I3QPITcub6DKqnHc9dn4eDheOUW3ho1wUzlhzlL+/EBxoa8ngfkuRZR47i4O6uyfEWdoAL5ef4wSpO5TKe4QAKARiTvFqLmrd/i9S3W7qjSkS4Jyk9S/wRSasthjlpw1jBLHHHdsvNcdH+wQwWXcG10FH5wG8UKpzefjaOeBbWx6NYkovIOPgLaxs/xiMpbJ9yfc1bR7LuLL1tTT4fD7XYQ/0qjizF6kxIG6qjCWye+ZPYmc14Z3W5u+ZB75c04hCyvKgv+AdSbYsK9TUFkAMe0P3CdRij1d5pbjRHt3mHjobMpXx/LDLoUUSnMTGftWH0RuJmj9th24qzQC8XBBnM3PmTt9JD3RPcwlCshS9/7bmOTSkQ4wgkFr1yBkbsohYRVIUTd2UXmppvDuczgi24hmd2HRjF/aaXREozUT6qMAyxHv07zz79S0d/++li8UHRVdOFv0cOvKx/kd7UZ+mbr+ioc8zXuLTw1w6JRY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39860400002)(136003)(396003)(2906002)(64756008)(66446008)(8676002)(44832011)(1076003)(6486002)(122000001)(66556008)(66476007)(8936002)(110136005)(26005)(83380400001)(54906003)(71200400001)(316002)(6506007)(86362001)(5660300002)(38100700002)(4744005)(76116006)(91956017)(478600001)(107886003)(6512007)(66946007)(2616005)(7416002)(36756003)(186003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?9ADstqWACnnGVZjLQIcxs3VQGBL0qkO2mgI2Ymhqyum3i5PPxnYznoOX7j?=
 =?iso-8859-1?Q?YzPdbYP/Kg0D8HYxEtd/1JD3lbaLrtUGZ9ibDyjznKzEumPZ30hhkHuyCe?=
 =?iso-8859-1?Q?cSoQhXAZDy8vMChiSkq92uA/a6KlhQ5NcD9hQmEqiXg1FfihDLU2T1VewO?=
 =?iso-8859-1?Q?gNWaevp/k4VYUcBd21S4Wa98HvX+1Y1pWOdratvaIs6adiR8ExVTmaxeHq?=
 =?iso-8859-1?Q?uRTmGdojqiqBMlYaW1Oi4P0j6IZonZkkN5zs/NBB8lmkLqS58wTNMNiPtF?=
 =?iso-8859-1?Q?DmQLx+JPdrLv+v6+6rkfZHCcCq0Rw9/0A2YPbOXxqInVHorYbx63A5d8Zv?=
 =?iso-8859-1?Q?0/mPelFMOQMDSGPmZXB7J6aIQAtD7pFPuNSTwOp6Isaoj0YHAcdVaXrofR?=
 =?iso-8859-1?Q?ObolbKsMUDdLMnMRETHUOlUAvP+enLiY0MiNBYI17hbiRFLmPg539GSLY1?=
 =?iso-8859-1?Q?vjFRbXdUWIX7iHTFUC7/ra6gtrIZiwVsdY2tBJ9DjPBevU0511AlA+hyba?=
 =?iso-8859-1?Q?D6jvqrkwRyf2N5Z9h2KE2GgySf8PoYvj5Zz2uz1q0wmmfxxsq8t6FOYH05?=
 =?iso-8859-1?Q?3FYkDTJYTfNZg73Oto5ekuetNuXhrDjtQSnPCduDqm8MQyG6DAdr+8d5W+?=
 =?iso-8859-1?Q?T0KrjJ/Szo90PYBUfHamThn8zOdsVsv0HhBhHOzAqpKktERN4x+qsQEfaf?=
 =?iso-8859-1?Q?Xw+b+WpB+F3cRF6UHvWd4hrTk+gDhv/lSOoHJ6lsfnYX5+ksmvyuyQ6i0T?=
 =?iso-8859-1?Q?sxOLJR1jjqDo1K3FuRR5zQRRyomH0w5hAnkUDK5Zcs9gAs6+ZxG5AEqOOt?=
 =?iso-8859-1?Q?ZcfWs5I0DAxlkL7IDybddShqHHnnvBsNURufCyuOypMjgVIeN4KVskHmU6?=
 =?iso-8859-1?Q?6xdBqWBSVRB38fgejsZsc70BLYlZ810dGFg+QwLaBmS2MxV+/G4wFb/yA8?=
 =?iso-8859-1?Q?am1G1qnzovRmdc3AEPag0g37/KghwOfdDRbZ+dFNJmkLEXmT7pVj9wJLbz?=
 =?iso-8859-1?Q?6jMO0sUQwjkB3XjzmDcLE1GHI0d+M1A4Ybf9K5s9gjXiTQaouzT+BsYVHU?=
 =?iso-8859-1?Q?2GN3uBUMCSqDq8TTp+4W3XR2YibnUjCh/La3w/SHr2pUFifmloj/PZ4zpc?=
 =?iso-8859-1?Q?AiWvdR/T0GnkgnXutOkkGRPXyp7j19RHt7dmBW43zmqXCVCvtJ0ncKlB8y?=
 =?iso-8859-1?Q?tFPqEuPmlGF+K87K1ElfY5xHn0wGkOxMQmldXyr+m7SIp8m5QtatCBTlv5?=
 =?iso-8859-1?Q?DPIPdABKFoX8RMM7HWgMHRN6/JqdT9F05mIsUxuYCE3CYVOyyKhSWAjZFZ?=
 =?iso-8859-1?Q?7+v8waIxQyq2gGUj/xKJRQbyWN4hl8YYTxxuAO917RYRMn+gJEvsuqxKiI?=
 =?iso-8859-1?Q?F3xEgFZeyr?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87260ced-7716-4c78-e553-08d913d4e695
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:57.1383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: awUK9sn51LL6hhDT3nd8bF3uG9oevrqo51tSqbjSUW4xgIxOP4466fEXdrlUesYYY3ZR7VAUhDrePj2nA3JHeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1437
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=857 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100114
X-Proofpoint-GUID: ZFzE25s-hH4cyXliS2O5FvdDEZiSPWqx
X-Proofpoint-ORIG-GUID: ZFzE25s-hH4cyXliS2O5FvdDEZiSPWqx
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=971 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_lookup() to find the VMA at a specific address.  As vma_lookup()
will return NULL if the address is not within any VMA, the start address
no longer needs to be validated.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 lib/test_hmm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 80a78877bd93..15f2e2db77bc 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -686,9 +686,8 @@ static int dmirror_migrate(struct dmirror *dmirror,
=20
 	mmap_read_lock(mm);
 	for (addr =3D start; addr < end; addr =3D next) {
-		vma =3D find_vma(mm, addr);
-		if (!vma || addr < vma->vm_start ||
-		    !(vma->vm_flags & VM_READ)) {
+		vma =3D vma_lookup(mm, addr);
+		if (!vma || !(vma->vm_flags & VM_READ)) {
 			ret =3D -EINVAL;
 			goto out;
 		}
--=20
2.30.2
