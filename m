Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31E63EEF91
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbhHQPxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:53:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31034 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240235AbhHQPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:31 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkHu9018094;
        Tue, 17 Aug 2021 15:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6EreRMiWsKcuTGgizQoUto4ZCiHZVZDuYd7IwO8hgtw=;
 b=txTwyR1XRIGvVCAzFvLN7UI0U9Y7BA/4lWfJMkgewXqx7U/mH6ozaRRqW+MqZTM34NfG
 Rh0w+Xs6pewHdnzinQezB/b8Z6lTCKDLcaaZ0aqO2o5DOmV7n3IaHU6QzJAZUmfuO3v5
 IgTA3emaZR0RymXzsPGLzwmV5URDwe5l+N53ofHKKqLryZK7C+wG48eW0H/oO8Ny2KPV
 wWckNUyKxZ0sXElGHtYA8V150P8YpsN1v/soY5TBhfPX0tuAYA70EPBCu89QuaYNfFL2
 IYZ+0NlWDpVJap3Ia28xCOn+BHdOpa1bHYKhm1LQwaK1I5I2fIZjG3/vVY6KWfMVUDWz Lg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=6EreRMiWsKcuTGgizQoUto4ZCiHZVZDuYd7IwO8hgtw=;
 b=l66bhx7wYZbkHfhLBDn6fCrtI16gQSsFXkuXE90uRQOAnR/ZtCuxjMrtm65FIhedsH21
 I2XCKvMl8wOrM26yOIsuBXHWOBZbLYbP86OQQYWFK4xUgbSNjcawWZS2BMDbkZE188Co
 dlSIJQ9zIb7+OJ/0N419tqingjH2iIar1WS9Oi3AFDMVBOjHKvvRT0K1GGEEzP3r2svG
 +V+9km3tCZR9RpMeVK1VtZzaSvcvUotE8utWjt+ELB7kxuu1F6Vsarn8zOE7QrAFFd8i
 i39BpX1CnaFKD3ffHQu+pSU+j+BmvPuhedX+/37uXtx5LeKwj1OW3LGpW9+Rix/28FgW 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7mrc38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmhM158764;
        Tue, 17 Aug 2021 15:47:15 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3020.oracle.com with ESMTP id 3ae5n7su0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ir5WwGFOIwdpN/CV3mN+GVhaKm4VJBr/jJeGTdYjJV1CkNu6RGQVvrrgiEZaKwpiyRoItoGb44u4/kFsB5jR0wMps/EHSWsJC7pgPAQ6Rs3HL8xklUbxNMG9rp30bVwAhwX1i3GfNVdD/eu7ZNetiO5C+iSKX1dAMpbueCorXaFXoxF5g7S/PV70UWnbwr/W6ZowJuymth0JjN9ZA30LFuHotoESWiZEx1CzkAJiIwLVsZMyiNwaTDQmQV4OVKYWfeqrxENBySBXnXm1k2q92LLTMnLkMh5X00c9SF3iTiXmipSLYtURiwpSYV8bHOf5Vd2uqK6pHIKys0NUAy1nNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EreRMiWsKcuTGgizQoUto4ZCiHZVZDuYd7IwO8hgtw=;
 b=ZsRK1ppuWa2HecdZzcAnqnAYmnSEpEHlkfjhgCxSkE0Kr+Eyd9FjtKhoNwJOrBnTUoIRgMovHvZLGNZ3Z3wKdXEbibItgAAbFJDaW6eqZSR+PDmnTHfzlRlh4mp1oIid7GPI/mXWaZaJHR1H7u3lUUi9GqRvI51n3xZoT+pDR6dmQCP3P9DDTKDA6y5aMmdkNJc9mQmdO+kTL7AeT1RXsxWN7FZxm6uTcM0uTsxT0i1hOKTukD+gcu+P47B7I31l3hawZv1avMfEiTgprRffEvC+46jMEjgwOKf027Lv2i8saoLXO2M05xhHAf1XfKzaTd3ZB2ij49ZAgszA+1Gxeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6EreRMiWsKcuTGgizQoUto4ZCiHZVZDuYd7IwO8hgtw=;
 b=QYH/HkZSwLEuoUiW6H6GxYNRKEucFH5xZo3qPpPlJ0jt6KKiCyLgLvN7j0qU9Qn2Ue7vshOY9yui4Xq3Bp75BODy9hNuCkh8jvi4trsZuF8hhu5SLxJ/Ih3AUunUi5ZsL5cmJFLE2kToXkiKmCkrEsKK4SRBEX0nBPlHuL8jWOA=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3097.namprd10.prod.outlook.com (2603:10b6:5:1a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 15:47:11 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:11 +0000
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
Subject: [PATCH v2 06/61] mm: Start tracking VMAs with maple tree
Thread-Topic: [PATCH v2 06/61] mm: Start tracking VMAs with maple tree
Thread-Index: AQHXk38k0N8Gra6hyUqaBhxXzoY1cQ==
Date:   Tue, 17 Aug 2021 15:47:10 +0000
Message-ID: <20210817154651.1570984-7-Liam.Howlett@oracle.com>
References: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
In-Reply-To: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64c27ac0-623b-469f-d8a6-08d96196470c
x-ms-traffictypediagnostic: DM6PR10MB3097:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3097A32384859888182BE16DFDFE9@DM6PR10MB3097.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:118;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: beOYIIRFWnFy9WyQiYwxt83XeHGStHyhcx+EMmuHQb1WeyVpJW9jDucdMPSJ0Pru0t/JSMfrpBmY+VxjLjKLKnS7o3NKVbgHqrOyG+PftWC5CIJWjMXnm/AIGosKGMtsH4dv/Fac/oKEhqaTc8L2IEx9EhXY9PE95iZzw3vDiJ7NhysBkc7FXQTKiDr5zC0FTNZnwbyB/zWpreCkvadL+EFWlkj/rWzuGymUW+gBnj9zwovYlpprheqSOyx5F0H2CGivngo/MR+BflvFVdAqvw/oIXTe8eToWIi3hGg2Urtb5UG+AOBIBhegK91vOdSo/5Yn03IKFHdj0ncHgNLjEibTHoEMZG8B6DenL4M8u4YIZW0i7wlPn0jWJWmNoR0jw/suHeskRNBr7nKICOWMwIU2snTd95AfV6Q/+hYsFkMGWDYmtnHsP0rSFrEl5WXikLw7jm+7w94hjx7769f842EEEHUQU9/o2D/k+6twm24GUjkDCns50kpRacyBBFFkRCGJDkpKeh5nxdPHug7OCnyd4vS0rMDHY7UKWyFmzHboMwjW/LO0SldzmY8eKx3o7huhKkFaGbT/QGJqa1da9mXRuOQSjJrM+pGfOT5tOH2xuBF+FzxCBNHH5SNhhb3KlFGxAvAxUe1mqQsNPfnahr8tUVPbAmCIeE/jyeNv1RQBoKZ5hMZHzkpAON3QNUkhyc2mX/7vDp+EWN7/LhfjoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(396003)(346002)(136003)(8676002)(6506007)(2616005)(54906003)(8936002)(478600001)(26005)(1076003)(38070700005)(110136005)(316002)(5660300002)(36756003)(30864003)(6486002)(71200400001)(91956017)(66446008)(122000001)(6512007)(38100700002)(83380400001)(7416002)(44832011)(2906002)(186003)(4326008)(107886003)(86362001)(66946007)(64756008)(66556008)(66476007)(76116006)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0RcukwoOGPGIhAwHB1IVQN/xa6POGH3cqIYXKMcTVrxejNyuT8iLLbP4M3?=
 =?iso-8859-1?Q?NhPYNeq11E/qN6mAKNgYu/MHI3eyQkr9Qq2nytwWUAdShr42cpBLxdNdi1?=
 =?iso-8859-1?Q?DLGgdQfd75QVCVw+PQJ8bO3xLIq1u3k81XDC6ivNaUXhSKS/Y4txDxNOxZ?=
 =?iso-8859-1?Q?sGTUxhcOqPKrsoKJ7JrywdLNj47VBsfS9Cf57YC0KmDn21re/bwN/rvvvX?=
 =?iso-8859-1?Q?dovGIXsBsDZduRJpXRgyCFB+rchmbLVpbnhwQ9kmpCZtMparmfSt03bbtW?=
 =?iso-8859-1?Q?Gc98clAPrRtohgxT5RIDybM5XAHSVTUGHbW50CRFmJJLlIhrsZgPjvSX77?=
 =?iso-8859-1?Q?XBPsD32DTCj/V9P+WyRlT/TiEeW5CW/iZhtGqXXExTvqIgEhE9/7omONVw?=
 =?iso-8859-1?Q?Aiq35FIOdh2KR5G7XTkiyOdPXkgDt/XBtkAm1/BnTA0jeCCWt2tv76FiGl?=
 =?iso-8859-1?Q?MyyeI8tqSMojXB0614RWgC+PogsuuIrbh98q52QVJ6hF+I2QhQP5b7ilHm?=
 =?iso-8859-1?Q?mqmNIvWrtZc12W8YPpRTikmtcVOmjeV9SKZLEM1PzuSZtF+x9J5STiQWqE?=
 =?iso-8859-1?Q?D6a4ppEdkfkCYBr43l/zD/Aak9z+4escJQ/q/eIhbnIqaEkh5TaqD1alht?=
 =?iso-8859-1?Q?68xl1lTqwpHqe/so14b4yO6BjDKgUV9EEPaeOgV9o8L3URR85Z47WqNPJl?=
 =?iso-8859-1?Q?kCW+1DBvR9GyyLuNzawGOIcxQiEUpwFbWojrfw9VGFxY01nV7Okpf+n89k?=
 =?iso-8859-1?Q?LBewgpJHYjYpbT/OLITv1egX7VZ8TzRVhwIVRHMLNj4wrwsknvSgF3zBI/?=
 =?iso-8859-1?Q?eCB1sCmfUH6uhAcmPkW7x8acp+A4tgNgaQ1onxRLZTMNY85xLOiwxt9fw6?=
 =?iso-8859-1?Q?fxVc/s7mMIUWaCu5hg0e2h4ezjcPtXNINxxnPsnu3+r0i6bYT/8jFW5gDI?=
 =?iso-8859-1?Q?OtuA3MCsVLFsnUWUzYalfL6Xl9AslnWOVvx8dh0mWz1/4PVQKuMvi8oJw3?=
 =?iso-8859-1?Q?87hC8xnY5iOZeACSTKCXdjprTZzbj0gVtZ7JGNIfL+9VUIcw9k+y6s5m0X?=
 =?iso-8859-1?Q?U3HSfEmmWuICTC0vB09o+qYY4vgV+2EHQMwvZZwgx9w9zeFFbIghkljAeU?=
 =?iso-8859-1?Q?MLdITDixDvYtEu7uiX5+GkNoaT3GzquW4NXnGFzrHvOpL1qD8rRBwd2Op5?=
 =?iso-8859-1?Q?7NtWR7P5XYrf2ZphqMTu6kQs9kuB9R9yHzUa6nunUZetXiw/OFr9T6t90o?=
 =?iso-8859-1?Q?HK/5pRw16xAhk54XeQtrpFgkgLt03ZcIJT4APc8pZoNiOKlVRy1mjnW+lF?=
 =?iso-8859-1?Q?zXDlXkEkemMxFHIjT+Ew+C6NnrT0h//Vtb8l2OKKzjFWCAUQBFAvGJWvkX?=
 =?iso-8859-1?Q?ciLk0pvcKe?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c27ac0-623b-469f-d8a6-08d96196470c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:10.5130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k0Yhe5+I9zK2kdh/Zt+PdG+PEQ3Yi9CtMEZa7SbXYjh/9PH6gamGigwnEzTs6+0hk6E89sQCRR5yREe6WN7NyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: QsXOU5EKVPMoGdx7_x-ELMbW4KXURWce
X-Proofpoint-GUID: QsXOU5EKVPMoGdx7_x-ELMbW4KXURWce
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Start tracking the VMAs with the new maple tree structure in parallel
with the rb_tree.  Add debug and trace events for maple tree operations
and duplicate the rb_tree that is created on forks into the maple tree.

In this commit, the maple tree is added to the mm_struct including the
mm_init struct, added support in required mm/mmap functions, added
tracking in kernel/fork for process forking, and used to find the
unmapped_area and checked against what the rbtree finds.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/x86/kernel/tboot.c     |   1 +
 drivers/firmware/efi/efi.c  |   1 +
 include/linux/mm.h          |   2 +
 include/linux/mm_types.h    |   2 +
 include/trace/events/mmap.h |  71 +++++++++++
 init/main.c                 |   2 +
 kernel/fork.c               |   4 +
 mm/init-mm.c                |   2 +
 mm/internal.h               |  77 ++++++++++++
 mm/mmap.c                   | 229 +++++++++++++++++++++++++++++++++++-
 10 files changed, 389 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index f9af561c3cd4..6f978f722dff 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -98,6 +98,7 @@ void __init tboot_probe(void)
 static pgd_t *tboot_pg_dir;
 static struct mm_struct tboot_mm =3D {
 	.mm_rb          =3D RB_ROOT,
+	.mm_mt          =3D MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
 	.pgd            =3D swapper_pg_dir,
 	.mm_users       =3D ATOMIC_INIT(2),
 	.mm_count       =3D ATOMIC_INIT(1),
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 847f33ffc4ae..1aaecca36e23 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -55,6 +55,7 @@ static unsigned long __initdata rt_prop =3D EFI_INVALID_T=
ABLE_ADDR;
=20
 struct mm_struct efi_mm =3D {
 	.mm_rb			=3D RB_ROOT,
+	.mm_mt			=3D MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
 	.mm_users		=3D ATOMIC_INIT(2),
 	.mm_count		=3D ATOMIC_INIT(1),
 	.write_protect_seq      =3D SEQCNT_ZERO(efi_mm.write_protect_seq),
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ce8fc0fd6d6e..80b7af9e725c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2596,6 +2596,8 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
+/* maple_tree */
+void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b9aa9aa99924..b13fa84d5134 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -8,6 +8,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
@@ -481,6 +482,7 @@ struct kioctx_table;
 struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
+		struct maple_tree mm_mt;
 		struct rb_root mm_rb;
 		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
index 4661f7ba07c0..4ffe3d348966 100644
--- a/include/trace/events/mmap.h
+++ b/include/trace/events/mmap.h
@@ -42,6 +42,77 @@ TRACE_EVENT(vm_unmapped_area,
 		__entry->low_limit, __entry->high_limit, __entry->align_mask,
 		__entry->align_offset)
 );
+
+TRACE_EVENT(vma_mt_szero,
+	TP_PROTO(struct mm_struct *mm, unsigned long start,
+		 unsigned long end),
+
+	TP_ARGS(mm, start, end),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct*, mm)
+			__field(unsigned long, start)
+			__field(unsigned long, end)
+	),
+
+	TP_fast_assign(
+			__entry->mm		=3D mm;
+			__entry->start		=3D start;
+			__entry->end		=3D end - 1;
+	),
+
+	TP_printk("mt_mod %px, (NULL), SNULL, %lu, %lu,",
+		  __entry->mm,
+		  (unsigned long) __entry->start,
+		  (unsigned long) __entry->end
+	)
+);
+
+TRACE_EVENT(vma_mt_store,
+	TP_PROTO(struct mm_struct *mm, struct vm_area_struct *vma),
+
+	TP_ARGS(mm, vma),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct*, mm)
+			__field(struct vm_area_struct*, vma)
+			__field(unsigned long, vm_start)
+			__field(unsigned long, vm_end)
+	),
+
+	TP_fast_assign(
+			__entry->mm		=3D mm;
+			__entry->vma		=3D vma;
+			__entry->vm_start	=3D vma->vm_start;
+			__entry->vm_end		=3D vma->vm_end - 1;
+	),
+
+	TP_printk("mt_mod %px, (%px), STORE, %lu, %lu,",
+		  __entry->mm, __entry->vma,
+		  (unsigned long) __entry->vm_start,
+		  (unsigned long) __entry->vm_end
+	)
+);
+
+
+TRACE_EVENT(exit_mmap,
+	TP_PROTO(struct mm_struct *mm),
+
+	TP_ARGS(mm),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct*, mm)
+	),
+
+	TP_fast_assign(
+			__entry->mm		=3D mm;
+	),
+
+	TP_printk("mt_mod %px, DESTROY\n",
+		  __entry->mm
+	)
+);
+
 #endif
=20
 /* This part must be outside protection */
diff --git a/init/main.c b/init/main.c
index 4b4897b791fd..f8453261fff9 100644
--- a/init/main.c
+++ b/init/main.c
@@ -116,6 +116,7 @@ static int kernel_init(void *);
=20
 extern void init_IRQ(void);
 extern void radix_tree_init(void);
+extern void maple_tree_init(void);
=20
 /*
  * Debug helper: via this flag we know that we are in 'early bootup code'
@@ -985,6 +986,7 @@ asmlinkage __visible void __init __no_sanitize_address =
start_kernel(void)
 		 "Interrupts were enabled *very* early, fixing it\n"))
 		local_irq_disable();
 	radix_tree_init();
+	maple_tree_init();
=20
 	/*
 	 * Set up housekeeping before setting up workqueues to allow the unbound
diff --git a/kernel/fork.c b/kernel/fork.c
index af408d06e1fb..1da5c1b20a60 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -593,6 +593,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		rb_link =3D &tmp->vm_rb.rb_right;
 		rb_parent =3D &tmp->vm_rb;
=20
+		/* Link the vma into the MT */
+		vma_store(mm, tmp);
+
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval =3D copy_page_range(tmp, mpnt);
@@ -1076,6 +1079,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 {
 	mm->mmap =3D NULL;
 	mm->mm_rb =3D RB_ROOT;
+	mt_init_flags(&mm->mm_mt, MAPLE_ALLOC_RANGE);
 	mm->vmacache_seqnum =3D 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index b4a6f38fb51d..e4a058f7e8b6 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm_types.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
@@ -28,6 +29,7 @@
  */
 struct mm_struct init_mm =3D {
 	.mm_rb		=3D RB_ROOT,
+	.mm_mt		=3D MTREE_INIT(mm_mt, MAPLE_ALLOC_RANGE),
 	.pgd		=3D swapper_pg_dir,
 	.mm_users	=3D ATOMIC_INIT(2),
 	.mm_count	=3D ATOMIC_INIT(1),
diff --git a/mm/internal.h b/mm/internal.h
index b1001ebeb286..eb883691709d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -360,6 +360,83 @@ static inline bool is_data_mapping(vm_flags_t flags)
 	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) =3D=3D VM_WRITE;
 }
=20
+/* Maple tree operations using VMAs */
+/*
+ * vma_mas_store() - Store a VMA in the maple tree.
+ * @vma: The vm_area_struct
+ * @mas: The maple state
+ *
+ * Efficient way to store a VMA in the maple tree when the @mas has alread=
y
+ * walked to the correct location.
+ *
+ * Note: the end address is inclusive in the maple tree.
+ */
+static inline int vma_mas_store(struct vm_area_struct *vma, struct ma_stat=
e *mas)
+{
+	int ret;
+
+#ifdef CONFIG_DEBUG_MAPLE_TREE
+	/* Make sure no VMAs are about to be lost. */
+	MA_STATE(test, mas->tree, vma->vm_start, vma->vm_end - 1);
+	struct vm_area_struct *vma_mas;
+	int count =3D 0;
+
+	mas_for_each(&test, vma_mas, vma->vm_end - 1) {
+		/* Rule out vma_expand */
+		if ((vma->vm_start !=3D vma_mas->vm_start) &&
+		    (vma->vm_end !=3D vma_mas->vm_end))
+			count++;
+	}
+
+	BUG_ON(count);
+
+	BUG_ON(mas->min > vma->vm_start);
+	BUG_ON(mas->index > vma->vm_start);
+#endif
+	mas->index =3D vma->vm_start;
+	mas->last =3D vma->vm_end - 1;
+	mas_lock(mas);
+	ret =3D mas_store_gfp(mas, vma, GFP_KERNEL);
+	mas_unlock(mas);
+	return ret;
+}
+
+/*
+ * vma_mas_remove() - Remove a VMA from the maple tree.
+ * @vma: The vm_area_struct
+ * @mas: The maple state
+ *
+ * Efficient way to remove a VMA from the maple tree when the @mas has alr=
eady
+ * been established and points to the correct location.
+ * Note: the end address is inclusive in the maple tree.
+ */
+static inline int vma_mas_remove(struct vm_area_struct *vma, struct ma_sta=
te *mas)
+{
+	int ret;
+
+#ifdef CONFIG_DEBUG_MAPLE_TREE
+	/* Make sure no VMAs are about to be lost. */
+	MA_STATE(test, mas->tree, vma->vm_start, vma->vm_end - 1);
+	struct vm_area_struct *vma_mas;
+	int count =3D 0;
+
+	mas_for_each(&test, vma_mas, vma->vm_end - 1)
+		count++;
+
+	BUG_ON(count !=3D 1);
+
+	BUG_ON(mas->min > vma->vm_start);
+	BUG_ON(mas->index > vma->vm_start);
+	BUG_ON(mas->min > mas->index);
+#endif
+	mas->index =3D vma->vm_start;
+	mas->last =3D vma->vm_end - 1;
+	mas_lock(mas);
+	ret =3D mas_store_gfp(mas, NULL, GFP_KERNEL);
+	mas_unlock(mas);
+	return ret;
+}
+
 /* mm/util.c */
 void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
 		struct vm_area_struct *prev);
diff --git a/mm/mmap.c b/mm/mmap.c
index 1a23d4575cc4..e891977293fa 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -377,7 +377,73 @@ static int browse_rb(struct mm_struct *mm)
 	}
 	return bug ? -1 : i;
 }
+#if defined(CONFIG_DEBUG_MAPLE_TREE)
+extern void mt_validate(struct maple_tree *mt);
+extern void mt_dump(const struct maple_tree *mt);
=20
+/* Validate the maple tree */
+static void validate_mm_mt(struct mm_struct *mm)
+{
+	struct maple_tree *mt =3D &mm->mm_mt;
+	struct vm_area_struct *vma_mt, *vma =3D mm->mmap;
+
+	MA_STATE(mas, mt, 0, 0);
+	rcu_read_lock();
+	mas_for_each(&mas, vma_mt, ULONG_MAX) {
+		if (xa_is_zero(vma_mt))
+			continue;
+
+		if (!vma)
+			break;
+
+		if ((vma !=3D vma_mt) ||
+		    (vma->vm_start !=3D vma_mt->vm_start) ||
+		    (vma->vm_end !=3D vma_mt->vm_end) ||
+		    (vma->vm_start !=3D mas.index) ||
+		    (vma->vm_end - 1 !=3D mas.last)) {
+			pr_emerg("issue in %s\n", current->comm);
+			dump_stack();
+#ifdef CONFIG_DEBUG_VM
+			dump_vma(vma_mt);
+			pr_emerg("and next in rb\n");
+			dump_vma(vma->vm_next);
+#endif
+			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
+				 mas.index, mas.last);
+			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
+				 vma_mt->vm_start, vma_mt->vm_end);
+			pr_emerg("rb vma: %px %lu - %lu\n", vma,
+				 vma->vm_start, vma->vm_end);
+			pr_emerg("rb->next =3D %px %lu - %lu\n", vma->vm_next,
+					vma->vm_next->vm_start, vma->vm_next->vm_end);
+
+			mt_dump(mas.tree);
+			if (vma_mt->vm_end !=3D mas.last + 1) {
+				pr_err("vma: %px vma_mt %lu-%lu\tmt %lu-%lu\n",
+						mm, vma_mt->vm_start, vma_mt->vm_end,
+						mas.index, mas.last);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_end !=3D mas.last + 1, mm);
+			if (vma_mt->vm_start !=3D mas.index) {
+				pr_err("vma: %px vma_mt %px %lu - %lu doesn't match\n",
+						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_start !=3D mas.index, mm);
+		}
+		VM_BUG_ON(vma !=3D vma_mt);
+		vma =3D vma->vm_next;
+
+	}
+	VM_BUG_ON(vma);
+
+	rcu_read_unlock();
+	mt_validate(&mm->mm_mt);
+}
+#else
+#define validate_mm_mt(root) do { } while (0)
+#endif
 static void validate_mm_rb(struct rb_root *root, struct vm_area_struct *ig=
nore)
 {
 	struct rb_node *nd;
@@ -432,6 +498,7 @@ static void validate_mm(struct mm_struct *mm)
 }
 #else
 #define validate_mm_rb(root, ignore) do { } while (0)
+#define validate_mm_mt(root) do { } while (0)
 #define validate_mm(mm) do { } while (0)
 #endif
=20
@@ -611,6 +678,7 @@ static unsigned long count_vma_pages_range(struct mm_st=
ruct *mm,
 		unsigned long addr, unsigned long end)
 {
 	unsigned long nr_pages =3D 0;
+	unsigned long nr_mt_pages =3D 0;
 	struct vm_area_struct *vma;
=20
 	/* Find first overlapping mapping */
@@ -632,6 +700,13 @@ static unsigned long count_vma_pages_range(struct mm_s=
truct *mm,
 		nr_pages +=3D overlap_len >> PAGE_SHIFT;
 	}
=20
+	mt_for_each(&mm->mm_mt, vma, addr, end) {
+		nr_mt_pages +=3D
+			(min(end, vma->vm_end) - vma->vm_start) >> PAGE_SHIFT;
+	}
+
+	VM_BUG_ON_MM(nr_pages !=3D nr_mt_pages, mm);
+
 	return nr_pages;
 }
=20
@@ -678,11 +753,49 @@ static void __vma_link_file(struct vm_area_struct *vm=
a)
 	}
 }
=20
+/*
+ * vma_mt_szero() - Set a given range to zero.  Used when modifying a
+ * vm_area_struct start or end.
+ *
+ * @mm: The struct_mm
+ * @start: The start address to zero
+ * @end: The end address to zero.
+ *
+ * Must not hold the maple tree lock.
+ */
+static inline void vma_mt_szero(struct mm_struct *mm, unsigned long start,
+				unsigned long end)
+{
+	trace_vma_mt_szero(mm, start, end);
+	mtree_store_range(&mm->mm_mt, start, end - 1, NULL, GFP_KERNEL);
+}
+
+/*
+ * vma_mt_store() - Store a given vm_area_struct in the maple tree.
+ *
+ * @mm: The struct_mm
+ * @vma: The vm_area_struct to store in the maple tree.
+ *
+ * Must not hold the maple tree lock.
+ */
+static inline
+void vma_mt_store(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	trace_vma_mt_store(mm, vma);
+	mtree_store_range(&mm->mm_mt, vma->vm_start, vma->vm_end - 1, vma,
+		GFP_KERNEL);
+}
+
+void vma_store(struct mm_struct *mm, struct vm_area_struct *vma) {
+	vma_mt_store(mm, vma);
+}
+
 static void
 __vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct vm_area_struct *prev, struct rb_node **rb_link,
 	struct rb_node *rb_parent)
 {
+	vma_mt_store(mm, vma);
 	__vma_link_list(mm, vma, prev);
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
 }
@@ -755,6 +868,9 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
=20
+	validate_mm(mm);
+	validate_mm_mt(mm);
+
 	if (next && !insert) {
 		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
@@ -880,17 +996,28 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
+		unsigned long old_start =3D vma->vm_start;
 		vma->vm_start =3D start;
+		if (old_start < start)
+			vma_mt_szero(mm, old_start, start);
 		start_changed =3D true;
 	}
 	if (end !=3D vma->vm_end) {
+		unsigned long old_end =3D vma->vm_end;
 		vma->vm_end =3D end;
+		if (old_end > end)
+			vma_mt_szero(mm, end, old_end);
 		end_changed =3D true;
 	}
+
+	if (end_changed || start_changed)
+		vma_mt_store(mm, vma);
+
 	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
+		vma_mt_store(mm, next);
 	}
=20
 	if (file) {
@@ -904,6 +1031,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		/*
 		 * vma_merge has merged next into vma, and needs
 		 * us to remove next before dropping the locks.
+		 * Since we have expanded over this vma, the maple tree will
+		 * have overwritten by storing the value
 		 */
 		if (remove_next !=3D 3)
 			__vma_unlink(mm, next, next);
@@ -1023,6 +1152,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		uprobe_mmap(insert);
=20
 	validate_mm(mm);
+	validate_mm_mt(mm);
=20
 	return 0;
 }
@@ -1170,6 +1300,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	struct vm_area_struct *area, *next;
 	int err;
=20
+	validate_mm_mt(mm);
 	/*
 	 * We later require that vma->vm_flags =3D=3D vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1245,6 +1376,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 		khugepaged_enter_vma_merge(area, vm_flags);
 		return area;
 	}
+	validate_mm_mt(mm);
=20
 	return NULL;
 }
@@ -1735,6 +1867,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged =3D 0;
=20
+	validate_mm_mt(mm);
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
 		unsigned long nr_pages;
@@ -1896,6 +2029,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
+	validate_mm_mt(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -1915,6 +2049,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm_mt(mm);
 	return error;
 }
=20
@@ -1931,12 +2066,21 @@ static unsigned long unmapped_area(struct vm_unmapp=
ed_area_info *info)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
+	rcu_read_lock();
+	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+			   length);
+	rcu_read_unlock();
+	gap =3D mas.index;
+	gap +=3D (info->align_offset - gap) & info->align_mask;
+
 	/* Adjust search limits by the desired length */
 	if (info->high_limit < length)
 		return -ENOMEM;
@@ -2018,20 +2162,39 @@ static unsigned long unmapped_area(struct vm_unmapp=
ed_area_info *info)
=20
 	VM_BUG_ON(gap_start + info->length > info->high_limit);
 	VM_BUG_ON(gap_start + info->length > gap_end);
+
+	VM_BUG_ON(gap !=3D gap_start);
 	return gap_start;
 }
=20
+static inline unsigned long top_area_aligned(struct vm_unmapped_area_info =
*info,
+					     unsigned long end)
+{
+	return (end - info->length - info->align_offset) & (~info->align_mask);
+}
+
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
+
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	validate_mm_mt(mm);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
+	rcu_read_lock();
+	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+		   length);
+	rcu_read_unlock();
+	gap =3D (mas.index + info->align_mask) & ~info->align_mask;
+	gap -=3D info->align_offset & info->align_mask;
+
 	/*
 	 * Adjust search limits by the desired length.
 	 * See implementation comment at top of unmapped_area().
@@ -2117,6 +2280,32 @@ static unsigned long unmapped_area_topdown(struct vm=
_unmapped_area_info *info)
=20
 	VM_BUG_ON(gap_end < info->low_limit);
 	VM_BUG_ON(gap_end < gap_start);
+
+	if (gap !=3D gap_end) {
+		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
+		       mm, gap, gap_end);
+		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
+		       info->low_limit, length);
+		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
+		       mas.last);
+		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
+		       info->align_mask, info->align_offset);
+		pr_err("rb_find_vma find on %lu =3D> %px (%px)\n", mas.index,
+		       find_vma(mm, mas.index), vma);
+#if defined(CONFIG_DEBUG_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		{
+			struct vm_area_struct *dv =3D mm->mmap;
+
+			while (dv) {
+				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
+				dv =3D dv->vm_next;
+			}
+		}
+		VM_BUG_ON(gap !=3D gap_end);
+	}
+
 	return gap_end;
 }
=20
@@ -2330,7 +2519,6 @@ struct vm_area_struct *find_vma(struct mm_struct *mm,=
 unsigned long addr)
 		vmacache_update(addr, vma);
 	return vma;
 }
-
 EXPORT_SYMBOL(find_vma);
=20
 /*
@@ -2411,6 +2599,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	unsigned long gap_addr;
 	int error =3D 0;
=20
+	validate_mm_mt(mm);
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
=20
@@ -2487,6 +2676,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma_merge(vma, vma->vm_flags);
 	validate_mm(mm);
+	validate_mm_mt(mm);
 	return error;
 }
 #endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
@@ -2501,6 +2691,7 @@ int expand_downwards(struct vm_area_struct *vma,
 	struct vm_area_struct *prev;
 	int error =3D 0;
=20
+	validate_mm(mm);
 	address &=3D PAGE_MASK;
 	if (address < mmap_min_addr)
 		return -EPERM;
@@ -2554,6 +2745,8 @@ int expand_downwards(struct vm_area_struct *vma,
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_start =3D address;
 				vma->vm_pgoff -=3D grow;
+				/* Overwrite old entry in mtree. */
+				vma_mt_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				vma_gap_update(vma);
 				spin_unlock(&mm->page_table_lock);
@@ -2695,6 +2888,7 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, stru=
ct vm_area_struct *vma,
=20
 	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
 	vma->vm_prev =3D NULL;
+	vma_mt_szero(mm, vma->vm_start, end);
 	do {
 		vma_rb_erase(vma, &mm->mm_rb);
 		mm->map_count--;
@@ -2733,6 +2927,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 {
 	struct vm_area_struct *new;
 	int err;
+	validate_mm_mt(mm);
=20
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err =3D vma->vm_ops->may_split(vma, addr);
@@ -2785,6 +2980,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	mpol_put(vma_policy(new));
  out_free_vma:
 	vm_area_free(new);
+	validate_mm_mt(mm);
 	return err;
 }
=20
@@ -3056,6 +3252,7 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
 	int error;
 	unsigned long mapped_addr;
+	validate_mm_mt(mm);
=20
 	/* Until we need other flags, refuse anything except VM_EXEC. */
 	if ((flags & (~VM_EXEC)) !=3D 0)
@@ -3113,6 +3310,7 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	if (flags & VM_LOCKED)
 		mm->locked_vm +=3D (len >> PAGE_SHIFT);
 	vma->vm_flags |=3D VM_SOFTDIRTY;
+	validate_mm_mt(mm);
 	return 0;
 }
=20
@@ -3211,6 +3409,9 @@ void exit_mmap(struct mm_struct *mm)
 		vma =3D remove_vma(vma);
 		cond_resched();
 	}
+
+	trace_exit_mmap(mm);
+	mtree_destroy(&mm->mm_mt);
 	vm_unacct_memory(nr_accounted);
 }
=20
@@ -3222,10 +3423,25 @@ int insert_vm_struct(struct mm_struct *mm, struct v=
m_area_struct *vma)
 {
 	struct vm_area_struct *prev;
 	struct rb_node **rb_link, *rb_parent;
+	unsigned long start =3D vma->vm_start;
+	struct vm_area_struct *overlap =3D NULL;
=20
 	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
 			   &prev, &rb_link, &rb_parent))
 		return -ENOMEM;
+
+	overlap =3D mt_find(&mm->mm_mt, &start, vma->vm_end - 1);
+	if (overlap) {
+
+		pr_err("Found vma ending at %lu\n", start - 1);
+		pr_err("vma : %lu =3D> %lu-%lu\n", (unsigned long)overlap,
+				overlap->vm_start, overlap->vm_end - 1);
+#if defined(CONFIG_DEBUG_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		BUG();
+	}
+
 	if ((vma->vm_flags & VM_ACCOUNT) &&
 	     security_vm_enough_memory_mm(mm, vma_pages(vma)))
 		return -ENOMEM;
@@ -3265,7 +3481,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	struct vm_area_struct *new_vma, *prev;
 	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma =3D true;
+	unsigned long index =3D addr;
=20
+	validate_mm_mt(mm);
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
@@ -3277,6 +3495,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
=20
 	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
 		return NULL;	/* should never get here */
+	if (mt_find(&mm->mm_mt, &index, addr+len - 1))
+		BUG();
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx);
@@ -3320,6 +3540,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 		vma_link(mm, new_vma, prev, rb_link, rb_parent);
 		*need_rmap_locks =3D false;
 	}
+	validate_mm_mt(mm);
 	return new_vma;
=20
 out_free_mempol:
@@ -3327,6 +3548,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
+	validate_mm_mt(mm);
 	return NULL;
 }
=20
@@ -3463,6 +3685,7 @@ static struct vm_area_struct *__install_special_mappi=
ng(
 	int ret;
 	struct vm_area_struct *vma;
=20
+	validate_mm_mt(mm);
 	vma =3D vm_area_alloc(mm);
 	if (unlikely(vma =3D=3D NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3484,10 +3707,12 @@ static struct vm_area_struct *__install_special_map=
ping(
=20
 	perf_event_mmap(vma);
=20
+	validate_mm_mt(mm);
 	return vma;
=20
 out:
 	vm_area_free(vma);
+	validate_mm_mt(mm);
 	return ERR_PTR(ret);
 }
=20
--=20
2.30.2
