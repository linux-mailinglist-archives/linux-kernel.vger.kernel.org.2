Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4EE38CCAA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbhEURvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:51:01 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42044 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238521AbhEURtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:40 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHUO7u083252;
        Fri, 21 May 2021 17:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DxSfNFKSHJm3x+zWGsAvzGZjb1Kk2gcQT6b+y/dq8VA=;
 b=mL6cbXwM7vMauxTkhEereEJbrmnSfap47j2AIOR0gXKTEG6of1Qwxgi/PhavAy63NTM8
 NzG/32R7zDApgxjkIM/GL6LejICtgtOU88/koM2Dz2VR9Car/32xj/XaiLgXqlyph9JZ
 4iCNrgzvQ6auurqE2R/kIVFQ/65CB56+SE6RncepAk+WnGQtWyYDRP7yLIobQWHK1Vf/
 f2p6MijbPkfANBQVQQI6j5H4KG/o0gXByBpJZWPvy3fiCiJK84SyFslra2IytvzZR8M9
 nYqB6x3AI4qBABdy3ILjN0W5Mby9OAAW/07Uhsl6tTIuh4NjsrRoqPhX9HHL95l86LJk vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38j3tbrf2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHkYWM095609;
        Fri, 21 May 2021 17:48:09 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by userp3030.oracle.com with ESMTP id 38megnskas-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIb8yM0zI/jjMSUQVG1N/v14bBtoPPuffUsakVSh4O2seYndIjWvAO5hYa8aVFAX5qMDjY1VZ00wzE/YUbZuU19pSE8ewmpTwfNPWm5N2ezodhcVLOE8lGX0dXLDo+EHSuU6U2RSJzh0IBWiHHmFBQLKYWeWVYgWxf49GtPnRUyyLuJ61+UN5lj9J5wAZQYBKfsAOiTJx9ED4q60LJ9Uqu2/qav+funNAuxCHJaz6+5wsQieigmLy0GnLan6RXT/LQz8CDS3I5jg+qGpT8Hn/GvR70DcH/4jepNdSYQZqfjEAs8xbTgi83/irmz/kOqXiLpYTy6crlj5NBK6dleIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxSfNFKSHJm3x+zWGsAvzGZjb1Kk2gcQT6b+y/dq8VA=;
 b=KnvKslMwTAONTWitV64hGn9dc+3R4biQYjJMVvGJ5J1SOmbg86M85zwOZ0gC51I1q/Vy3QCYSN2S9qGk9TY9WelaPF5CnJevi+9ALBg7Mwpj8XSd2625l/ECPZPMry9TqAdF6WQ63logqofud2dmoHMKTEjBa97JUO9BPNh7U5GZyGwn4cyQw8Us88HXxJs4nI10Q+y/AOvWuIHPm87INBqleR1kQuyXwqAI/DzMvabC10s0usypLVHUdKd9e+EGaAdzkVDdzlhUraGTbQqRM21mVmEs2oYo/cR3EjUtwjf02IpcBsgLDdEpKdgQixCLZhS+9KsBcLpzr+15vt3RpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxSfNFKSHJm3x+zWGsAvzGZjb1Kk2gcQT6b+y/dq8VA=;
 b=VpZpkeopfvyQl7quDz6cCnFZdyKPj1zX4Jm2SY6HH2+SdOS53eMAIOwZbhC+yXFZhHboBU/niyrNWs9miTcK67EqquoaKRhGIRZ4go/ByI8qbKUlm7jakZww4SZKrb6zHbtWkv8TG/B5rHmz9Hmi1Z04QJoA2oIT9EzyIxsSswY=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:48:06 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:48:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 18/22] mm/ksm: Use vma_lookup() in find_mergeable_vma()
Thread-Topic: [PATCH v2 18/22] mm/ksm: Use vma_lookup() in
 find_mergeable_vma()
Thread-Index: AQHXTml0xemHo+Odr0in21Eh0dgSGA==
Date:   Fri, 21 May 2021 17:48:06 +0000
Message-ID: <20210521174745.2219620-19-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 83727a0e-d83b-40ae-6b2c-08d91c8096ea
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB446722BFF5CFBE8F6A480197FD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S3VPCbSTl+mkO8Dg7ZfTw2CNu4pVOv3NOAVskN0KUF+Jn2U4aipV4/0ZN9uejxUYxAz6nrkFs9XCNmlfo/Oa09/LP6e1KDPDk9ZSEpuGOUk7Nc9jw6ZFskLdFsciAa8TfzMz5VoidalO5HQBWVBePt/MDbBVkANnrU8HXE9Ax0832rcSghSzavn4WKeGiksE+Y4oA+n3f3g61P9psXkJ+VthyU/mrPSpG/NRNxCtkUwj0MxK/ZuiWjkNRTqQM0N7tl0P2Q960VNWOS9gLwKwhNGhw+dz5xJ+jgP4mhHmSbsJDHPcpXQkQ/3oDegpL4/RK0LmQDo4rhhvXYsr6hF8wceBSGKVVm+4FvqZWLQlPChPyMxH94M7FvpeY2ko9QOWSCyFv14BjMC5SEsCrA85qP/BV8C2cxglR9jjj3sOxGCGt5U5KR3mzhRzaMcq9X2eVOaGNriaDp9Sn/aKo7W4DYd2kn7PbEDa6pMjTeKyQ6f7d3Cs3UodqW9HiAviqhXPCRWuPBXffXnZ8GUC3ZhCNZw8XpADK21XYzoxtcmtt/GfmQegZ4B4PRXWQta/KXkuIo4bu0FuMAnD+nehi3M+QpKOfmWkNL/4mDA1nTFJXMU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(4744005)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?p4SnpEhfQwr2OzEtfJqs3+yaqWA7hTmdAToOjqxl17wYkFoYCKxT8itCb6?=
 =?iso-8859-1?Q?McJUf39xHSHwmhdHAITQFIzoDNVF7lsYB0inphnXjy4fwM/orqGwRyrgOj?=
 =?iso-8859-1?Q?P4eO4obth8NqRB9q/K8dLvcBFSBqDJz8WwPn4AOTbl8IGeQ4z57+UVOWZ+?=
 =?iso-8859-1?Q?UPhv0gxrUG//Yj0sB5n7BXAOh+IBHuP19+liwDCdtz1tfNntTfUr7F32qc?=
 =?iso-8859-1?Q?rns3N5yWYLBdl2ftRZM3dZyZDanyFsTXxBoG2gg4jdFGQDB2oew19Wtjbt?=
 =?iso-8859-1?Q?9JSzA6WnCD9i6gcH6tg+nTXz6aQSdirYM6GE+hm8vmZjRojscCEJCMDUwG?=
 =?iso-8859-1?Q?8RGk2CWEh38dEZAHIASytUhwiqWxIhX8Dxj0sgMeiW0jZoN/opYvwnbYX6?=
 =?iso-8859-1?Q?rtGOBj02LxWS+C231Zvw5/igeaSqmuJypKPdw8ZCoA72RtvXxpo/IDF0JX?=
 =?iso-8859-1?Q?FsMsKINiCxSbH+KJeLCnOKhDr2AElTDTxAQ7+4IqyufGfUN7TUfJQZCzST?=
 =?iso-8859-1?Q?n657r8NG/iDWQ03AJVAX65iVLhpNXfU3oskZCxkWg/dlXFnYvLARpA0eeC?=
 =?iso-8859-1?Q?AB7Tzt3isnSN/2wz6Gc6QBlNMPlplblDx8dyoAKyEbGTNUuSRhAwFV2ng/?=
 =?iso-8859-1?Q?So2ef+KLWqRykMriDMU9yV2OyN2Nde3huWwML/KdRawOFx/PLIOmd2cIle?=
 =?iso-8859-1?Q?u30C2s536KyFE5ZYSBj6K6CBml5T6Xa9qBSfrLGrKvgxPw0Vqilp/nMPQ3?=
 =?iso-8859-1?Q?fkjGrAhQr8nqgYTULPO9SHdbUxhLa9eJTCIYbaf2VTxh+oWg2k+cfH6mZM?=
 =?iso-8859-1?Q?d3r/Z4qmsSo0NZ6UqtUi5Pg5C3KoIhYARCQg3mItf6Y3NwTqypQ9kHfmCL?=
 =?iso-8859-1?Q?PB3N7VRJqSIT+yfTLpkppZKkZ0ER/wnVGUtD/lqENPb5aW8buWKpA4pEtt?=
 =?iso-8859-1?Q?YplLVqJF64jtEtjQKJ1q0CIaOh/+d8RHBdSwHp2DYx7kJMPkRoMufBhpIt?=
 =?iso-8859-1?Q?RbUCJr0WVocch2pfeZqoj7iQdq11r27JRjzvgy8WZtKI8VHCQNzdLYKOHA?=
 =?iso-8859-1?Q?JX/ixC38PWSF4iTQRWaxe9b77o5rpw8KaF13vDMrWldZl3Gizlw4kxir5x?=
 =?iso-8859-1?Q?GYhwBWop7YOXxrDG/Vk9brOaFBcECNFNjTBZAwHNAZZVbSveVfOULnjBmG?=
 =?iso-8859-1?Q?/+eLYNlSiVJL5rktsjzYXDIcKqMj2w9MDkXbHDGFszwFVM+hZby1+a5FJS?=
 =?iso-8859-1?Q?PMNfruK9woteyImW71r3gZtj/6XAjMlB9Pzx9qYwkfS5WNCXfQzx6JVykN?=
 =?iso-8859-1?Q?qk8VtvmdxcUs4mDEuhmjBE1mZBpETx5uCZkgVddhXFGGPCf3s7AYmaaHMW?=
 =?iso-8859-1?Q?adi5DcOEOP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83727a0e-d83b-40ae-6b2c-08d91c8096ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:48:06.1583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8dwVPvMUpwNRCcfOEEv9nB9fV6ZfTWnThGFDxyXeJNs//qprK7Hhy7z4UZ9l/THk6mGN3c+TVr3Xvp787OPRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210093
X-Proofpoint-ORIG-GUID: YFGVfB4WcQN25SVRK9IitucmEzrbCSQP
X-Proofpoint-GUID: YFGVfB4WcQN25SVRK9IitucmEzrbCSQP
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210092
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
 mm/ksm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 6bbe314c5260..ced6830d0ff4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -521,10 +521,8 @@ static struct vm_area_struct *find_mergeable_vma(struc=
t mm_struct *mm,
 	struct vm_area_struct *vma;
 	if (ksm_test_exit(mm))
 		return NULL;
-	vma =3D find_vma(mm, addr);
-	if (!vma || vma->vm_start > addr)
-		return NULL;
-	if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+	vma =3D vma_lookup(mm, addr);
+	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
 		return NULL;
 	return vma;
 }
--=20
2.30.2
