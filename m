Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B66936DBF0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240879AbhD1Pjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:39:45 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24202 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230527AbhD1Phk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:40 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMebr009359;
        Wed, 28 Apr 2021 15:36:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=11RUoJTLdhs1b6VIZgRl9uI089GpV2Us5INdV44GRWA=;
 b=vLGyFoFfOsmVcFXZA0brFoMH5jeD91KvMUIkPD/KRk7jDhEXAhVl1ILLPasXCS3qZV6J
 6FYdYIfdnoXO8VJQfZOhOWIZUUkl/lyqyliwELzoq2delNxZt3gmvDQDBPWz2uysMaPA
 Jz7m/33R+XU9yq8DwmA+lM7+sErdZRkvikRf7jNxguHxCf6vh0a1f4+Wyuepae78wvfS
 7SkESUfvEzkTcEYkEVyvT2J5RMYlVMyfDK45Kn8deyayEbkeYhb/m7BooKQWK758e5yP
 OGXBNCT5jeOetvJbfK6/WCMyA84SJ1lPx3+M9rtPkcb/tNkVFT4xGNnVpthZXhRIS6EM RQ== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 387a2mr0v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:40 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWB5m196126;
        Wed, 28 Apr 2021 15:36:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3020.oracle.com with ESMTP id 384b58qnej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHresCCaXRQ9WuuS87qEU0levGOsRsu4sYR7UGczdPxaCkf5HSOLTkWYMm3VDwnPFa2qJO3/L4m7R+0pROqxtVCuHeRivW1QVmgh1kk7AkPFCxt37OXZQHGaoPt4Lml3WODGyqQ03lZdmFzEu+yFrHKUxMFCXDd5iSe1KUHU12I28FiXN1N1I1+E78kVDapqXobQ/QvqqHjfoWIJJIbLWY/7WW3x7hg6jnJ2OPNe932Btfi4UNFUDoe8kGylp9YA96Y+Td7IPrQRQfmAaW+N8p4dkM2NukJZYjJreSsjgBcKVdToGsuQdPvihcMRZX2tV/R9WN6BRLcWjVHsT7Sfyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11RUoJTLdhs1b6VIZgRl9uI089GpV2Us5INdV44GRWA=;
 b=ExhIOVi7INGJZQfYDrhgCTKFSPgfoe7rHmTjEhBkplnlN/Tpfdy98uP8iDyVeDgwYbPC5VXXajAqjeOPm7ctNS7wYcHLYlCWyCA7KdHQtgONXVezjh0lkZroCiki8xcuCi9jay5HoircWRXiK9WAv5cd/MMyTkelB+TMTb2E5TxnTEfIVJc+cOnVGcWSx4dTAAZl92IgBJy7kagMklq6uw8ctinvtyqJQC3PQT0w8wsDKesB3sccK09t2fUXLiRBphjR9xfjqROU/QXoVf70GqCC2y1D9pyzBJ1Y2D1Spe2NgowhNqehwfPL1wwav4KeUmuuPN2cbZQyxu6OX7pBGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11RUoJTLdhs1b6VIZgRl9uI089GpV2Us5INdV44GRWA=;
 b=VzEUH9apwT8cJDME6hW+/7YTxJaUuurMhbXbDzu1cD///KamPTWmVPVEsIgd8Exy6SNaIW8Oqf7CVJOjIR29g+BSM9vgIMILi++noG+T5rXiXwefigIZ7+FFdNPigOICesr+FYGB4N7S3qI3ZyfAmPrp2Hlrk4aGh2j7r4A1yzU=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:36:37 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:37 +0000
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
Subject: [PATCH 35/94] xen/privcmd: Optimized privcmd_ioctl_mmap() by using
 vma_lookup()
Thread-Topic: [PATCH 35/94] xen/privcmd: Optimized privcmd_ioctl_mmap() by
 using vma_lookup()
Thread-Index: AQHXPEQ0lFso/sjA+0CVe97NQiFWlQ==
Date:   Wed, 28 Apr 2021 15:36:06 +0000
Message-ID: <20210428153542.2814175-36-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 88660219-6cc5-40c3-004f-08d90a5b6931
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4769FB0EFD70077BB6AE3219FD409@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ncKkZ4BLIFKPbiET5x4PRs57UbkuHP+5OIn/3hL3nyGxmy/qM5ShxAXmHFb7GDuooPTryd10SFR7iPhFnmSWWTuuE4zWY343PZx7VBnIY8wNm8Qqa2jex/HcIoDn/N8utz0RmVVPq3TouP8I32h/n6xm85DauqDqU+JHpRLY6zhC43wjIcn+9JRlF7i/iUFpwh2iwW1fz7imeCR1bjWi7QI0iS2Jy8LVvVmdKzdP8kP379wk+JTLceKDOtVo8/j5agDi2FV0iLSriLnW0D6pTiT1tL1SkhJWfosGx6XbDhgoFci7Qwz4fpUQ3CcIbQ/0rkd563Y5YWCEoVVDE743qaSs8MRNERd9NX0WyccEBo4C5BIsDORrkrFULov5no5oXwV2j1WonL1denYqKrWiNXTc0+KKcTFcM9ZhLsg6ZHIwrFS7X0g2WhoJ7M8JMo2VBmHBSLKjpkz69zeeThfNOAFSICgvJz4l8t46zJDZWIGXCPLP9Q5/umycgLxygG0nB9Q3oJAeqZjcynKulHdIOzH7BLB43yE7joR8boHbrRalECGwNJt6bjt+5SoF6b7MShD8JfxLHd9eT+Mdu4/8HlMpuHBirZDTrCGIuQMj6IM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(6506007)(86362001)(4744005)(2906002)(110136005)(83380400001)(66946007)(6666004)(38100700002)(66446008)(66476007)(54906003)(8936002)(2616005)(8676002)(66556008)(76116006)(478600001)(36756003)(4326008)(44832011)(316002)(1076003)(107886003)(186003)(6512007)(7416002)(64756008)(91956017)(26005)(5660300002)(71200400001)(6486002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?HlPx/RnpTfpqlg9Jz9Tc0wvuHOhTStnl7ePXbexEbNHjbzftmO463KovgB?=
 =?iso-8859-1?Q?DxWwLNBt/STX0wJ+1WgmYXD9WigUr851nMArUcrChf0bE9tUU4MbT7odqI?=
 =?iso-8859-1?Q?gFLKqKfokU5nlPqGa3mi3n0hXY2D6076wZDO/1VRzS8HOg8fIGdlRG9RjQ?=
 =?iso-8859-1?Q?rbzxKSvgilmAceuO8xW8HsjBMoYntf/N1ccLfjDM5IHngckfspKpN+oIN8?=
 =?iso-8859-1?Q?tBOjzgJfRZhFNnhqhtnbxxeKLWBBKz7/LFCXGaFHQ3aLaZ1lI6m787QHPo?=
 =?iso-8859-1?Q?5kCQ4iHs0lzAaX0mfayeuvrw5UWdu1eLemc7i5KCwxi0tb+tPcD9hjHLZl?=
 =?iso-8859-1?Q?Dk79AqCjE8DYKekxln7vTk/h877zCjNHEPOFzOV//5L2XkcaEnELishAdP?=
 =?iso-8859-1?Q?yjbkz8mZx54qn15L3F4FVEMRAnjyYWD/32ndyAEAeKSs3i8PnjMF/dJFms?=
 =?iso-8859-1?Q?devWDwRXDclGrYVN6R0uV+4O6TqaIk8/C650/7qJ+aRkfhGnVSuGKz505z?=
 =?iso-8859-1?Q?2lt3sYdOSgwD/laQOpKi/tvtDIR1nwy243tzAqzXzoFLKAdr6di3jBHkWa?=
 =?iso-8859-1?Q?Ag6pKI9fTtjNroTOMcf5IFmZAJzvptQvhxKtNaYsJEuUbWNigldFCp6rKi?=
 =?iso-8859-1?Q?xnjHppvXEBQtNvwJs9Qv3Yj9Cv9PDa6bzD4QxPZcTLwI89ClZmrxDGKwfC?=
 =?iso-8859-1?Q?k4PNeqD32Y5+EPxDeuP9ZdO+9f8gqRT6HCw1qmOLQxgJb3hVd7pTBQsYsm?=
 =?iso-8859-1?Q?77gnHm+vyzO7tmDE0CKCz1gbZ//qtUwzGgULMDmqVQARJsSvdxV119QCz6?=
 =?iso-8859-1?Q?jB6bCNRR3uLehGlK9pTvjV1cCPnwXltiStZoDQ7B3iPsW7WCTPNsiW7eny?=
 =?iso-8859-1?Q?inE1L1aIn5eAFPR9RzeimVxCOjQ4P1MGx9xxlEMH8QqDpDSJImTTgGGkHa?=
 =?iso-8859-1?Q?yGivh5NpBM35hrl3VoPrGlyc3cpULYKcuPFWgLAudlvmSrn3LhvZGm9qvq?=
 =?iso-8859-1?Q?KJxXkWtiH0LFpQoAGdrZUmhGd+C0DVlrKXz833s+TUmJcawv6/xtyHdcw/?=
 =?iso-8859-1?Q?/SjAtMTGDoKaWfruWPkrqEBPZipoC2IFrAxayN1HlrEASZ22ChsWfrBYok?=
 =?iso-8859-1?Q?S9aRfAHKn9UjS00oQmL84exmBSW999/gkylzJ/yDjc2SnMT7EdbC3mljpe?=
 =?iso-8859-1?Q?iGA15Gcml75nIJrjBnKrJtz2YGDwJve4s60+tUb8CLXzbwDKJHyVsXKZGq?=
 =?iso-8859-1?Q?uQMLGsZosB0hntWIHKo0ppUDwomXNPnz2J1JwmHUZ2Kv+JWA755sMNMP+O?=
 =?iso-8859-1?Q?xT3G5l6MqotrKIPn5pBBRehcjDiLgR2f89j0RsRAWAlPB8BCAv5ZCPrvUp?=
 =?iso-8859-1?Q?qT1OMlFj/G?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88660219-6cc5-40c3-004f-08d90a5b6931
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:06.9030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ARRajnKaP7rFJKcq5FMl6pU7S5pJfPLf407Tdlv16xWLgFPhlQfSwXgjXtgbTMoBPE/BpCpFMwKxYEiaQlwuKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: ymWShi7aASu2HCj4lk7lB3pORD_7nUeK
X-Proofpoint-GUID: ymWShi7aASu2HCj4lk7lB3pORD_7nUeK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() walks the VMA tree for a specific value, find_vma() will
search the tree after walking to a specific value.  It is more efficient
to only walk to the requested value as this case requires the address to
equal the vm_start.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/xen/privcmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 720a7b7abd46..5f903ae9af7e 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -282,7 +282,7 @@ static long privcmd_ioctl_mmap(struct file *file, void =
__user *udata)
 						     struct page, lru);
 		struct privcmd_mmap_entry *msg =3D page_address(page);
=20
-		vma =3D find_vma(mm, msg->va);
+		vma =3D vma_lookup(mm, msg->va);
 		rc =3D -EINVAL;
=20
 		if (!vma || (msg->va !=3D vma->vm_start) || vma->vm_private_data)
--=20
2.30.2
