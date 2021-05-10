Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55B73794E2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhEJRDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:03:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51814 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbhEJRBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:01:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGs0A9073745;
        Mon, 10 May 2021 16:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kwX6LQ+VoappUdbbr3VYVMuoUMWK7kUiAIz9sxfACrs=;
 b=AWVXrYK0PdyYlUzYodEG2vXI1odHNV3uMfad33x0EgcO2cma4NBlPK8K1uFVg1c6WWhK
 Ckz9ECfDlDRESUH5LvfyKiLoaZUuW3hKx03A0GKeiwSZ/jcr4QuF1e3i/GlOuaniDcW1
 z2AhvdiyKYBlMx0uDiQBzmMaQWaze/KIujeGhD6LNZzF952L+Ow317c1uH2Agn29S5yG
 KRu1LLlON/T1LxtAMaDpehT9ZqVJcsE2KovOo+yabbNI/g0UOe04wmxayD3In8kYP2LK
 NTSqBI8vLdxLsJT9zlUy1KWrxZt9Lz7lxgS4y1kI+2QvPxM5ZyP/oAkSFUjHRPAQMQL+ bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 38e285b77p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGtx3S001777;
        Mon, 10 May 2021 16:58:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by userp3020.oracle.com with ESMTP id 38e4dskqwm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+uF4ctmRmpfgCWmABXdTwZNvrGZ5ymVerN3pLEM1ul6vsT0mQB7LnZWnCJ8qiPhKf757K+RJJcR4B+ncf6MZ8MbVK+sfQJxH5qbmgxppNLY1uVUsI+HGxOV+CgNrEOGAoniEIJqCCwD93vqem+XfXXcaJJzrgXqANNA3jRiZhctMegtNVqGhpQ4FYdTinC4xwD0szT+AeFMYAsa/hfYTvFy3zla5oi4qOZbuCg0fwvRVX5aWy+MwMrAvniV85UaKw0eDGE5+oKFqDw2VY+0g8I9MwfWW89ivU4XrNvrIPqZ8SVeoyl8yXwvhUd5GUcEGARyuhJfpWXFfZBDIWTPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwX6LQ+VoappUdbbr3VYVMuoUMWK7kUiAIz9sxfACrs=;
 b=dAGwo8cOKA6X8m+fXWkHx95U3LjF0m+DzFXEH/QiBlcVCEL2uAb2nCWC8JpgoKZm6jclETNcWEWEIttZehC8EalFYpQ2OMl5+wK7EJob3dr1zrSJETWeK4uo3lztkryPQikT8xv/7/YJ7FRAcQB93wDo+GUQS5Vq8+uxfwpUMujHd+zOnRlz70ZJFlpk1QGh5JECa9lgkCqFjdJR6amfaGuJnnTjF0cw2wVm4JXCrQnMyR+7pAIl6tE2vj9K1jl+NdYTmE/QccoMf9oxtVEb604EF3mEZ++n6Htbm0n/YOZqgqNxrjnbHZCg0rkxKk9gDWm7jA8tDsStS0WVoKc50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwX6LQ+VoappUdbbr3VYVMuoUMWK7kUiAIz9sxfACrs=;
 b=BW81N8ja6NGeNRfJ6Kr0gbFfvqNIXDfLGVU8BDZBpwo4w88r3Yk0c8tl48uzG5na4RRsc/I0QT4f6snlkuWo9ZL/Q5MgO5SZ3+db18hCQmECbABJa9qMUcOMAyErisWmLOxJPwzhCUAx++SkDFRaMdiGwa1aDx4yuAQIw+4d6/k=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1437.namprd10.prod.outlook.com (2603:10b6:300:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 16:58:56 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:56 +0000
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
Subject: [PATCH 16/22] kernel/events/uprobes: Use vma_lookup() in
 find_active_uprobe()
Thread-Topic: [PATCH 16/22] kernel/events/uprobes: Use vma_lookup() in
 find_active_uprobe()
Thread-Index: AQHXRb3DtzQbBpnf80qzjuZQliZxEg==
Date:   Mon, 10 May 2021 16:58:56 +0000
Message-ID: <20210510165839.2692974-17-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: c41007a5-4f82-4189-7744-08d913d4e64b
x-ms-traffictypediagnostic: MWHPR10MB1437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1437E4522A2071950C34906DFD549@MWHPR10MB1437.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: II5zargEs65oqxulwN0nKYD6LVKZKq19ye4vmgF38Lal7W9ko3CVP8YH/jeellLoQ86mnUZ/WIbhC5DBc5WqydYu7AXSB0fUz40RFw9rAsAKdira+bX9ww4u9MqfDuzBKDNLY9uMogTX0koP92phH0ngU4oV/qyo3AXZtQMDWe6gNTgsYMehsUNaxQCMxFu4Pum27f42ShcLAyFm+ITlm0dASH6hzk3O1N3wEbdt/vIN4/1ILuCsROc7u0v7QLm7ygeSxJ00qccf4X1BsaSvNauCSI7CbdQvz4RHxqFYtbme7whlLmmk5p9f2TFZkeTss7coCof7fqp+3T9L6oHAUgcoDF5cpetFHFuJiNa+IN9KhVq+QEvSJYHTPm/kpkK06NGbt7V8hTiRlKUlKeIGFRxRvNumtj4yXtPYoGxE+s08yFclgeqbAA9Q3WOUVsoMFw7vYuP8jhEOULt8eLeH0OvECsbnkYpjujvIJkA5Wwi2rUdZ9g3mNlbG73LXFP1B359I5VA6WDDBAeQmu3FTAc2heNnLuc9AKZ6INfDaIr3I0NSfEaMX5vJB5I4fCH+VKDThnYUa/Ux3kLcLzR8e2rV7adj1sYmelLl+3CL8zZc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39860400002)(136003)(396003)(2906002)(64756008)(66446008)(8676002)(44832011)(1076003)(6486002)(122000001)(66556008)(66476007)(8936002)(110136005)(26005)(83380400001)(54906003)(71200400001)(316002)(6506007)(86362001)(5660300002)(38100700002)(4744005)(76116006)(91956017)(478600001)(107886003)(6512007)(66946007)(2616005)(7416002)(36756003)(186003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?KxkzPDjnfz9MR1TbN0HUDTt5XLMS8T1xmV9gd1jmh7rZVZqD63yZd+/PVr?=
 =?iso-8859-1?Q?dRSgx1EMojszX4OaA3nXf62U4A6Bp0pa8GLS+F0K1GGpRn2LITbSU52728?=
 =?iso-8859-1?Q?KRwW0Uy8bIyPwd9ukdNHsqOF8AqfydXw9E8qfYLRCsiiMlgvzgp4w+PUn8?=
 =?iso-8859-1?Q?D53cusK93ibmreJML5gZ8VyJfEi7Dr2fA7Xk1oHlrPOuvsg2RL7W699Wgj?=
 =?iso-8859-1?Q?9MlTQaxZfv6SmJH3/ZSB2a8zTn1TMja+x8njRPsW9q+vzZdJqOg71X0VGI?=
 =?iso-8859-1?Q?EggEK1xqL0hLD49Dvk45HCJRbjQnam8yRUERDvnoBhrt2EdPv72gTu0yY4?=
 =?iso-8859-1?Q?XLJagHIhHE9hOS2f9FiHhNbgTihUI4Om6f2Izu7CI58nZTOrtui5cOS6kr?=
 =?iso-8859-1?Q?oEVeHMxm6xvFXUTGIra7iQTN7kdOtcymtpZ3+ENlxA85HxCs+3dr/70kDl?=
 =?iso-8859-1?Q?uciuHm+frbjrlKLmavPbYq+LaJPJk0DtO9T+q9JzAWpI1u3S5ZZ1RrlIpb?=
 =?iso-8859-1?Q?8wVagYfhyvp+J56jZdeL45AM9yO+FigFIvdhdcB9dJ2R1MJKRjhWwTX5+7?=
 =?iso-8859-1?Q?bQeVl82iEKlYhpns+vb3WMtYNSBbbWlSVJSs98CXdO1M6cm6ir8hB4Xxkq?=
 =?iso-8859-1?Q?+K2YCMySxK1DaRE3OUTRHAxtmO5tsMt8DkBBCtiTBY3kF7uvhL3W8LXn5R?=
 =?iso-8859-1?Q?lMDSFPNANtPqV9lgkErXI5S9NP/QlXryqsUzSJI7jgoUmAUZ05jyQoYN9H?=
 =?iso-8859-1?Q?TwzWrJu2YMjObpVqlc6nCS51Ba0IfXAAKQwEk3KVgXyx+Yyk2g+W/XkKFr?=
 =?iso-8859-1?Q?pkI76mk8j0596mm821pFQtxL1vNUvmOeK9gWeec3FkJTHngGi9k7UJCGNy?=
 =?iso-8859-1?Q?bdsLmAqv2Urymipd621KLpgdJRQC56L5+GJT6BagAbmU9x5+hqSGdx4kE6?=
 =?iso-8859-1?Q?Muhwy51MiPtHBwB/Q7zuI0dAT7jpveXysiAX+VM2DCjGbXAcXQ9UR2wUHR?=
 =?iso-8859-1?Q?q//LcEPapWqeXc2CsVRbHrQyjQTR/XzzGAClv885CauwwV3APpRRyh8iDp?=
 =?iso-8859-1?Q?PvDAsOstpQoJH2swQaYikuGGumW7uop/Ipery9dBSvLg7fdIGdnA0sdNOC?=
 =?iso-8859-1?Q?CUP64oyi2GuEhVtAAZbB6muaYjlhSdzO0RfLhLLQzO/CN/rOwykRgCmqxD?=
 =?iso-8859-1?Q?DNRLL9gaExYQ812kBVUaF87hDW7yFJwYu6G3+OY6cHE9zo5ciZQQvlVTvS?=
 =?iso-8859-1?Q?wYcgqnMieerDJQcS1MiYhDal9GZQrtxTsAS4ZgHEjFz1UI7qMYZO0AXM8/?=
 =?iso-8859-1?Q?WkpzAPn0zri4gxLjgf3WfLfFc0qz7AoWywWp0UguL6nTyKlF263nOqbnDZ?=
 =?iso-8859-1?Q?3uDWVHHrDV?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41007a5-4f82-4189-7744-08d913d4e64b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:56.6386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y09abBS56BdujGLAGpbjrSImhpiMkkpLqYbsARsrAE4Mpgb4ghwHFKFg5NoVzen8M3IRik2mWS7WnHbP5/gZOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1437
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100114
X-Proofpoint-GUID: 5NwWE8GOOm_HYB_kU8AAoMhqnNz3Jthv
X-Proofpoint-ORIG-GUID: 5NwWE8GOOm_HYB_kU8AAoMhqnNz3Jthv
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
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
 kernel/events/uprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6addc9780319..907d4ee00cb2 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2046,8 +2046,8 @@ static struct uprobe *find_active_uprobe(unsigned lon=
g bp_vaddr, int *is_swbp)
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-	vma =3D find_vma(mm, bp_vaddr);
-	if (vma && vma->vm_start <=3D bp_vaddr) {
+	vma =3D vma_lookup(mm, bp_vaddr);
+	if (vma) {
 		if (valid_vma(vma, false)) {
 			struct inode *inode =3D file_inode(vma->vm_file);
 			loff_t offset =3D vaddr_to_offset(vma, bp_vaddr);
--=20
2.30.2
