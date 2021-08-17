Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CA43EEF98
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbhHQPyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:54:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34026 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240246AbhHQPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:31 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjTpP006863;
        Tue, 17 Aug 2021 15:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=V51yzkb8z/1YOYRbWwNTT6ZoK6NzygCEZeSMRaldiBg=;
 b=aARNFzqsnyd5u9mttrq2wMvwZo+w+keeHsJBnTY+27slKSt5hut6w83JzboSE7JoK2NF
 0Enx+y/7/RvJtKWGN8VkRtD7XwFnTCigsuuxXROz9D2418gyj+91EE+OcBwRRoq3q1ax
 V/8gIbqjEsgVOG9Z6LygQRjMshqHJFGX6mjNlG/g+5lxhv8jxZIqUnUk6xwsD1LpXZRO
 I7tsEXhrzQBlpHuFG/bkbENlkRh/Wn8JgFZ7/a3N7g/SAbX1TBFT5V5fh6b3IfLfCIoA
 XAhEFk7cM4nxC2dscT5MOgdili0YiuVa8z0DNUjUJgMDaiaymvQldPvBcF2Lgzva6onn uA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=V51yzkb8z/1YOYRbWwNTT6ZoK6NzygCEZeSMRaldiBg=;
 b=FF3eQY9uNJ15s+pXaiaM/72TdvCsYdhRzj+qcg16lhvP+oQSuwe8uZHptDB3fF/SGaRg
 EmDwlyVinZ1iJM/sw68oaAs7bvE7SuegDCVzdpOgQWxCp3zLqXu1zmoBlajVT+XyesFg
 x8Vp+4nn9p1tEcpOVo+//RVURC/fQGCA9XFQJsgm96axB7azvOeNx5oeosqa4zBZMSHp
 UxjPj9dVcxMvRT0AALqCX5Fh2wnKLleSPAjbQ784jdCcP+wAu6489j5fYjLMsjwo3T7Q
 IT/Zypz0wQwYZlJLmD1OU2lPYeDwbmRRwUovE3IZD0eGRSYQfQbSDv5WvBIgOy0S8x3P fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmbc9un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFksAj094402;
        Tue, 17 Aug 2021 15:47:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3ae3vftdbk-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgM8WB0tvJAnMLlTH9vhtY9EIlKGR8DntMCvXGVSSTVsE+O5MOm8Z1DSOy06tal/3kZYX7o5KSGOLGwSrWgWV13JkcBVVCgY93n+QoD1ZpBDOzljRGvxTAYinFD4m+r/C6OkniKSXlp510Nv3e110XXavuAp2H/nq76SS0nC/oomGvjpfC7i42s3vepTpbYmLOMN0vFRFnzcIMXA/frkZDSkJQTQymsIwI6y6EQKUk8U4c/eAXk+0YTVb6gSAtNKAvL4MucAULnSrCYiD/bcGbdT9lXQWpPezKW6WnVJ6ahEZMOJ4uP39ikWEVWAbr8H9p6B7cAWrSwTztCxlgI6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V51yzkb8z/1YOYRbWwNTT6ZoK6NzygCEZeSMRaldiBg=;
 b=NQMENhV42ge7Xh8Sie82NXRQhnN0YwqMWC2LjgWPBK03WnWqxs5dJd49RO/CvFVIDM89fwwroNWnB3B3SZbo5WQ3mmX3fBBDMsq4DUL1bup92Q2B2wivtQbP6UR6GQwZ4tdQ5Pu4Phg4aetaTE3omGlxDRwclT3cB86xo7JQeNGwnT2e5zRQyi3zIaAYS8OeQ3Cgo58bEwXAqi2NpIUYUeO+1hKSGxefcMgQ1oWT/2zJ3K82Mj1Mh2qz51RXH+9OzrmHcS2JuLF81HEjts20sCNrpDFbbJ1nVvfJlMWOf48ero6RLouI2pLsZT3P+WFXIjtqM3Vy3ELlNcWfjPgC/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V51yzkb8z/1YOYRbWwNTT6ZoK6NzygCEZeSMRaldiBg=;
 b=tXRHxwHoQAlqeAUW+y9b3n3wC5poVPeC6ah4P3RqD14sSxdEXiKXI8/W3uPTy0UHO/oTqK4i3XpJPAVo/cwIfXhHCJaGIUv2l2mmwz67IhkRSKKrjGWxV0Y++r51H1cm4fhZN85b6jUPVusbiY/e/rNyeGaWAiOTNHUpjCN2iKc=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:18 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:18 +0000
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
Subject: [PATCH v2 22/61] mm/mmap: Change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Topic: [PATCH v2 22/61] mm/mmap: Change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Index: AQHXk38ohye14ZG25UWUhG8MwTnc2g==
Date:   Tue, 17 Aug 2021 15:47:18 +0000
Message-ID: <20210817154651.1570984-23-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 1fe76713-b436-4087-8740-08d961964b7d
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB4236E6A99A2997E9BEB22405FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:241;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z7qRozprgTUNIBWSlWmKaDmcs6tdayUOlbJ4s2lp+vcKaUrqV2sKeVmn4BH9cLLvyDCNa3RFrsLm3Y5rdzHbi6tALiIiFJsdKfcryQfdAYA3TjM8hHdppNQjhcJXVqYH6GHKAlI12Hy37IOuz7A2m7IN8iS7Qt3asIkNyysf7jT/HQQr4cxl5+xLeysapMlnqAo9ZmVIB8pkU39GJfWJ+xMdOhzfbTIaO32THt933ognWFVTy+h9uHWSIZqTx1kpasqEiTZKob3QU62vgPNi58AptzCt8QW1pdMFrbB2eLlpkoK284namBRy1OPhd5fc7zCpGfYQ+ujXmom8l6yhIl8oS+wBSpLdBg0kV9Pz1/sJ3dLDQdQYWfgps4/AJsd6V2Y5FL2gwL5pJnSYk6AWsEelUVVGtVnQYwzUMkbJaSTCBTDJ7X37DxYRVmkGLyHRd+S+Wb7ac4Kv3QMQMH0XIePWNodb3j7l3v5dzFe1f35q3mx/65zEz6ytQp3yMfcQiG0+P84g47enk0eoHF62wJEgfYE8Xa5KWlyhwO/Y3wCwUuOZ8lYrKwQgoGAY2SvVcaVBbwweODzfrNfqvrZVMUpksews/2+cgBxsKeFyCZCeX9nsg2rI4BuY9cWcT8IgQ/UwCN26uf7E78pmEjUGAuWygxSSpl4OJLbYwBc5eFrfwsyByFq6wdS44O6v/9NlLo+pUdtnz0xvmB8kAxyI3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1RWMGBcf+2bJNhTlcXnxnnP1Sjx7MDOv1zky2z48YqKxivyyilh4HOpRLy?=
 =?iso-8859-1?Q?bMOyJEiuuIdQkeBbE6M9b6LvX+wA1vpeRah/QaNwN5r4btI8hD9SJUaDTS?=
 =?iso-8859-1?Q?7EoY8bA1PDuFVA67LGjRSBYcEvITdAdgIhISIPREVLFZWrFINMZHCB4af/?=
 =?iso-8859-1?Q?NkL3zoHEObRlKmIC7a3inunzmypR3/K1eG6iPuZFvlxKHiZ9stb8t1KgZ+?=
 =?iso-8859-1?Q?tftkst01Vbpq6IHP9nP0Gf5YNjHBU06jFXhBMD5KH33mIPPKZwwdSn+Q2L?=
 =?iso-8859-1?Q?gMaxc5qFPfX9yJb7NoV+dIC9IYXARcom1Fvdvhb6sAswllqg91VPtfrTNY?=
 =?iso-8859-1?Q?HmOzvZ003TWuQxYrArK99arC/TKnDZDI5wAzLsTnmqxOL/2uoa92UJROxS?=
 =?iso-8859-1?Q?a+zcxQ8bRvhqOIEeShP1FBofzwicN11+MUNgLjzyo3b2OzASPIWKhyEigH?=
 =?iso-8859-1?Q?4AXhcaIIMXH1gXfoCrM0XR+uAwKW5EUTYXBB9hEvqTnMm1kn689L4L6KWP?=
 =?iso-8859-1?Q?AifilW8qm+DCUtPowFhwWiyRikMtV/t1dI7tzgycVQBJ5sZH0evDYYxa8u?=
 =?iso-8859-1?Q?Kn6uBg8JeZK3eRM5erxBn18Q4EkZ7t2noFa42W742/gM88lqQyOAY53r37?=
 =?iso-8859-1?Q?qbRALRemfii3JK2blmFATUO+jADPryY78jyHZNJM1jm6pQEFRtzgOG+BYm?=
 =?iso-8859-1?Q?fBtBBp8sdG82cacFCrawotR8VTkefjfm1VMwwXILNv9vAp/WnNT2Z4uO9v?=
 =?iso-8859-1?Q?jfzE8AfhfOFhH1OdQmi0uUmD98UfXOmi5FHswUoTgzmFs5UGBNiVQPj7X3?=
 =?iso-8859-1?Q?5atY/iXA/AdMwJuU0AHQ0pHDEHpmauwP5cFarWuFRaUds/GPZ4r6FOsLrQ?=
 =?iso-8859-1?Q?CDi6WNdzxGH1s5jJAjzXV4r0ZlPLc5eV6e5GAxmP3o7PP8CqMj1QNA+9np?=
 =?iso-8859-1?Q?hw1tmbRcnBqFcs3O+N8h+Iu8RuMqax9UNY5ofTKxxB4UnQLTVLHcwvR2Hu?=
 =?iso-8859-1?Q?R9S3OIEaFk605BSLMRM9etUF5QUNq9FvFmWAW2Ms+ONIB57uT1DmXR3fbs?=
 =?iso-8859-1?Q?BNJBIlnNnwkLNmGDBu0/kRPWTjMpc8+QjRLU1vhIbP8M6tU/BLGEaMJ4D4?=
 =?iso-8859-1?Q?v/CkiGST3GCBIzLKWsWI3kymLJ2LljQH/JgCm8e4WVC7hZSSY55FbPvtXp?=
 =?iso-8859-1?Q?bOXJmsKbDU6u47eJqDUU72qELNjJPuQXFLREH+5JWNu/hMZ9TFamgN09dY?=
 =?iso-8859-1?Q?bstt9mueeqTumFISNekGinyYuPoXSxjB0P29JPFGRH6aOYMnZUyDGeqM0H?=
 =?iso-8859-1?Q?Dalx030I2+LGRNOJbmXNKPpNyWuajmrWTLvs8rzQ4uUnPT2hGGK654R+L9?=
 =?iso-8859-1?Q?Sm+q5oXKce?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe76713-b436-4087-8740-08d961964b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:18.8246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDnAQesL/0BixZhNJoyJPOfEd6zC+gaRjeUcVSAVV6/ioRIglNKq/osmBIhtotHfOye7gD82LxwecRNn8NdkuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: R5BnBhvw5l3_vmMxX8yn5YFVSSpdvIvE
X-Proofpoint-GUID: R5BnBhvw5l3_vmMxX8yn5YFVSSpdvIvE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

do_brk_munmap() has already aligned the address and has a maple tree
state to be used.  Use the new do_mas_align_munmap() to avoid
unnecessary alignment and error checks.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4fdeed164381..150d9e9c0a68 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3019,12 +3019,16 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct unmap;
 	unsigned long unmap_pages;
-	int ret =3D 1;
+	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
=20
-	if (likely(vma->vm_start >=3D newbrk)) { // remove entire mapping(s)
-		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
+	if (likely((vma->vm_end < oldbrk) ||
+		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
+		// remove entire mapping(s)
+		mas->last =3D oldbrk - 1;
+		ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf,
+					  true);
 		goto munmap_full_vma;
 	}
=20
--=20
2.30.2
