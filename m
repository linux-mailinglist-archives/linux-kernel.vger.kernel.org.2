Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B58A421C01
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhJEBfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:35:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42468 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232130AbhJEBdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:52 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951MKZK023925;
        Tue, 5 Oct 2021 01:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aYp3p8faWG6LbXBB7CtADIG/AZRzw0JCLLGSgOmDmkw=;
 b=JLHPIwvsYQtNfP6oO+aFEgvBQz3dy4aYKAZA23VUpRLtgvUP6TjgFTw8GLLmE+rPsOVJ
 wUxI0VLsr1q1fzdoVrJkpkK0eRwHHEwUn56DH1bBOVtBG/+nA+V+0/GYOB0a727gKet/
 OGElGUTFX1/A7stVENLT3ui6Ojw7zcQlaqMeFXQSf5UPVnf3LckmIlR0oiGCuc+RR+7g
 XVJ9Dfc172rLzH+4YSMoRcAQfRB4HL3oGdOTiYQIHzXmzaqV0gDnGccMN2RCtLkzR93F
 +KtUjC/6kMiWY3NAxJeLj2hi+1yIm6MyWsVspcjkb5Fk0KvVpfDaWQCJp3gOPnnVWp0z Tw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43gkphf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951Tu3s056799;
        Tue, 5 Oct 2021 01:31:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3bev7sgru8-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKoCdeaEEqEUx4x0kIxIr82TBRvEeJC12UblNpdhecuNvWMCGPEjOO8T09V3e/eAb2MQBNLhQ8cDuFGyigZBMGidna234rW7Mza+I89ELzS8YlDM7iG1K2Lj+gs/0LQ/ybDmkl/7qnNLinIkrUa0zy00HQ4vrBaRheszBFu0SGrvvw3NGA9B6IobfXu5O0G1hanyhWrn6URR8j1RrFZEGLUbBqYSvAPJlWtyboIJgzRZr0eRWvzd1vM2HiOEQN4oOgTz0FOG8AXje9z1yKQbJUde+vKJsIU0vVW6ca51RXe3Z1cxsbJvUJ4Y1TWhIBZNSY5cui3eOhs041EVzllhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYp3p8faWG6LbXBB7CtADIG/AZRzw0JCLLGSgOmDmkw=;
 b=aE00HF4CFrHT4uMx7cM+fM2tSDp790Ae74a9XsBD7VwnHqrMK1FNoFIWj5VbBPduZbDeLGLRVeR6RQ/4XHaIYzq36K7p1chsA5ZjayYRtLRmO4lb9fpKVIwWLpEsho+kKkaNJA0iOQw1GrqG7wRhPFz5fst+KB8B3BtZVaifAYgQOftNqxlmdje8Xs2ikqcK+CSZhgsvCFv7+fbSSUrOBvPFW0yIu6rWRowKBghMBdR5TzjZ5z871MG61PyqicIfTEokcKMGbja/2qNNElVHy2rZ1ar2TpYUNBninOnqoG0WDydgaI2uYyUuSYd+7qCpO5tpHgBE1cdfpFtmbm1fFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYp3p8faWG6LbXBB7CtADIG/AZRzw0JCLLGSgOmDmkw=;
 b=OLLomrT3ArFpRq0wCoRFFtkl2kOlQEJaM7CRsqUQgu0LJWN9RJg4giqpQSYfA4qNyfAkxboXSunADo0F2mcNfjTd+8rlg9D0mkAJMiZna0jlJEAi/X2oJIzgB/CGJxO5XxcpJzd424yhKXmjcFI1ebTXNfU17ADvwXo+D0CU2Y4=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:23 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:23 +0000
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
Subject: [PATCH v3 42/66] kernel/events/core: Use maple tree iterators instead
 of linked list
Thread-Topic: [PATCH v3 42/66] kernel/events/core: Use maple tree iterators
 instead of linked list
Thread-Index: AQHXuYios568d5vvtUWcphK6CSE7yQ==
Date:   Tue, 5 Oct 2021 01:31:02 +0000
Message-ID: <20211005012959.1110504-43-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: d23d4f3e-6081-4056-f8be-08d9879fd740
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044A2213E7BADB98706F6BAFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: No8tuZtYwAWiiE6NelrpGw2TlJ3BmpaZa1Rfr7CDkCNUpNj6ygf1BOiXIoNbyXCaa5PWCXYn6x8KdKHpER6fsNyOS9v21HsUXeeZF8lGWfYXYuDTFiq+w3mN1FxfXbRBtvKLJgSmc43p4ZFtvk7MCYSJpgYzkfKnKWgTQLglFuF69BVBJhFnrD3qWlBqs8ZglpdkwdpgryU9KA4PNx/MRIfruNECEM69SCu9rLY+K73Bh/oNnMYDi/w8Cu1tsaJEPKi10u/usk2u0SNlAr2JEgp0iQIavPsTw9S/by+6yrXWrTLzaFktjIMIqoh9wnOV3GAAlSjht7DQnP5RoxRqlhfkWG7EvXitJ8eHsd5ub7QOiqPND9/YZYLmvTeNN7MuFj3GgU8pZsp0ogpOs/C/g/+SjMLQS5+UxnL4R4z3J1ocwWr4p7vbDWF+1YU/Agl8QyQU5WUa1jt81FmhzSxFp6ykoVk0tr5a3Ks0UThiJvtzH/VLAZNUH8rPW+8z3KRjRS19cbup2VjJ/0EXNt6ezsYr37LT97lFV/JQ1O1XgCrX9rMaxnzeWgSUXSh1le3wOJZ31LPz2xzCKoJPub/qeDp846ybX3pk1EyL9oDixo1kRQ53fe+K4CbcPvq3oCAUUZAXE/Z5A3Js46xwOf1OGn/G1sTSETO5B4VUV5e0f1MHCn5cD1+Dz+gU8NA4ipL5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(4744005)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bWD/3l4Ds6zzzljdDlyBWT2XItATchMFKTbUcziJoKti0KPDsyl/H6/VPy?=
 =?iso-8859-1?Q?kdjkIr2URlvSAmsXiWHTMuP0Qx8QNL/USkf2lRUZiuckioVTOvT2MtYmsI?=
 =?iso-8859-1?Q?PqfCr/ubNGbpUOL1IvNJ5QpL9O1ISdCQbBspIl6Wmc9zm4cJyTlmJlbRLI?=
 =?iso-8859-1?Q?8TPmX7IfrXYRjJ0F/JOaS4FzDxfluYyPc3otUniuESZUObBWfw6xSZ7cJp?=
 =?iso-8859-1?Q?zg7IH1ffeb8BYGEpHsnMX3gqCncT3tLMT9JnoJg8I8YnyewkSyDgEYpQa5?=
 =?iso-8859-1?Q?D991AlQi9N6Squc5fj+G+6TSlD19XdlOX4FHEp19xz+FB2zi48HpIq42qs?=
 =?iso-8859-1?Q?JQlqldnJcMfbMvaa6Gj5HqL1NsvfmcQstXDuNsnfQHwRYstJarquNyleit?=
 =?iso-8859-1?Q?ThpGXxbDfT6vuP0wLL7Hbptu/I+dFxD+GXf04j+0vrgBZ/pggGBkKkfQBS?=
 =?iso-8859-1?Q?DGrxTTyKJ76MIo6Bqu9XoowKtqzVmRjvf1mX4GWVtqWm+NUKCRW2YYdQxH?=
 =?iso-8859-1?Q?0WjTff0wHnBD7qhZiht1yv/CS4qrqObN9e5opTPzEu9k2SghXNUN/XBCXj?=
 =?iso-8859-1?Q?sY5UmJ7Kdjv1tFSw7rkV911nHm0mSEDskJbTLG45otkVYpnnjKeiwzx1cv?=
 =?iso-8859-1?Q?T8lbuNWgBPAwlgutBwzrHMYl1bKj0pyLGbrKZuDKz2jkbRh/AdEjbRQcOH?=
 =?iso-8859-1?Q?6JEGaFvpNXM4d9ZIn3hB+In2OIN5psG6DRWNkwBq5aZKT6SJ6pjKqOV2xf?=
 =?iso-8859-1?Q?NT/JUF5aMhVxTqeyixHxrl9ko9CvAjiZW9XJY0ufKshWyTVy4XkDtS+F4B?=
 =?iso-8859-1?Q?sKN4w6jJMa8xHitvtEPyxOF+sEAqoi9I63MKnXqQrLboTOUXVc93q8zQ56?=
 =?iso-8859-1?Q?KBk1Zd6ZkQdak5Iqps4XDoBteAXuAzJGX/VCqMxJ+Ot1uKdfQRPl9FdU6G?=
 =?iso-8859-1?Q?tGRGWg0yKytfGu2m57G5qp93Lkr1DR9C8cVFZWrgG3SbdCQr86SMm9dp20?=
 =?iso-8859-1?Q?7d7vtxdydWapC8oVOVyqFsZJV3QIaqg6T35q8FZ2mEGlRLHsll7xW71KKS?=
 =?iso-8859-1?Q?/AGB/Cx6CWRN/Xk414nrz01ArMOKEiRgyMRgsQwWEkdvHDRhHIqMJDpb8J?=
 =?iso-8859-1?Q?XVo3IqduX2d5423AQCzCncFoC8BLHGgS61tjJnVlUUb3GbDzuG2w9PuuzJ?=
 =?iso-8859-1?Q?0uOJzkm9vUBqPd7Q+d41mWIHkORvgk0Z/6FUaZGhvWWHKiMznRY4ORShO/?=
 =?iso-8859-1?Q?9RCmH1doGg33I3BrdyjA8IniRhUHlGeKIgk0om5RecWBfx/bW7BL4SAozk?=
 =?iso-8859-1?Q?cWNp2AXMT7dmyIpxOqQIkz4y4o3hHozCgjheadkf2Y4np4fAXhJsiLAq6o?=
 =?iso-8859-1?Q?d2FWWctHBu?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23d4f3e-6081-4056-f8be-08d9879fd740
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:02.2523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JmhBlCJbeS5BsVxzrzdpUk/XDAVjxWdnepLGatLEZGjre2P6pPp9z7gIoLSh2OjGLe/NulttWmsBb2FXORlAZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: vL0vELsjm9HaqAAv1rPvS_zNBHQKFj2S
X-Proofpoint-ORIG-GUID: vL0vELsjm9HaqAAv1rPvS_zNBHQKFj2S
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/events/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0c000cb01eeb..fd72dd1c472c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10162,14 +10162,17 @@ static void perf_addr_filter_apply(struct perf_ad=
dr_filter *filter,
 				   struct perf_addr_filter_range *fr)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma->vm_file)
 			continue;
=20
 		if (perf_addr_filter_vma_adjust(filter, vma, fr))
-			return;
+			break;
 	}
+	rcu_read_unlock();
 }
=20
 /*
--=20
2.30.2
