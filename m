Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FE3421C15
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhJEBgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:36:44 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22602 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232521AbhJEBeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:34:08 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19519huC019232;
        Tue, 5 Oct 2021 01:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DCq2IE3y+vM6Ehn6VmVTdQUsL9NXI0mbFcSLG2C6Q6c=;
 b=km4AsnDmEJCLS9v8iMV3pJ3AZD75BRUcg8DkHSQYa1IY66YjKzaQCVmgf4x+pqwjaj9d
 fj81Ub75JUAqv6LNuSwbbbJmgiJ+IFVpVkYOBSygBIlezDeiVLbldcavAjFpWsxnsOg7
 iwyOfqEOQpXvbczRRjime6IjvzMAhIsQahEWr+O+buKZsM5YI/BQHstEITC3CcJFY6MU
 Ldtett4Z0flC/90GORHGy6auo8Jeg4LSUzga5oRP9L4MRKVQIYky5iCRYpX+dMfq8hs8
 X6emzJxWJdkYUOo6IrqDJ8l6Mca6WeF9ar9ERLVJXz7ECRlDI/Y9f7UJemlZJ16vd+HQ oA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p5c9c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951Tu3h056799;
        Tue, 5 Oct 2021 01:31:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3bev7sgru8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEfrhFv147T/DJRWrH5YAP4TkTGnDmJNBNBmOjmoToppdAMEfxu6H7X6iFXclhh3KCF3KX6x9ChrBC0VVhtDh990PG2ycPNOmYASksSa8rgjGcBREI6qUuUcu47dsKeYPulwd5TKzcA+x8Ooeb8/08W77DnAUJUbYtWrDagb5EUUU/1EBz76oPhV8+3CvhydMqTFniIw9F13KAdDoqljqX7BvFx8o1x2RsAU358wOkjP4THc0PdA7jDRKKV+lbJrRcQ3J1OWklQIBaj45dD+PeM4G6HjE9xjifj7DwOWDGIgaheEyRu8+V5R3l8vb1T0FzkHC9tlPg8pccoDwvm/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCq2IE3y+vM6Ehn6VmVTdQUsL9NXI0mbFcSLG2C6Q6c=;
 b=ZDC1O0C9nLVilN4q9HyBV3thCEUfkRu5ScHMAJSDaZ++dJ+dBBMX2bbDzrliLopBoWUKT7fbYSacUKNl8bnh7ucm4E8q1J4MAXK7D6MSIHLzqeSiSfuVW36rY8wqaXv2TZzDqzKS8Z0977SN1Vb7WphSTNeURvKD0XjuOdpZB7tYL6YPlDKFDsT5A7PCjsu9deZ055AZ52fCPibKcAjh+1AbGERHOGVlTCSSenRgh+pa9BVtjBhUYDuVs1ZOktygvHz+F0+F5PRLDixgqBiXH5iW6eIALeRub5vOWuywOCwRtR3GlByzf66YnezeRAnwtl70kEi9rXbg4lHn1063Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCq2IE3y+vM6Ehn6VmVTdQUsL9NXI0mbFcSLG2C6Q6c=;
 b=N10KHaNddvxVrlRvP+DOlLyocB0CaIU5FD40cd9pyUZuNhr1wW6Kb30UbHZjjRwNgtM7R5rrQYx79OmRlOY4SwQH4y3S4msm9kz0kLSoaWiMvs7vHYSmgRrLtmM3Ra5OrYylN2sjzFF++ZVkJbHsxtU6O3edXJqt6S/tvo1YRH8=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:20 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:20 +0000
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
Subject: [PATCH v3 30/66] arch/x86: Use maple tree iterators for vdso/vma
Thread-Topic: [PATCH v3 30/66] arch/x86: Use maple tree iterators for vdso/vma
Thread-Index: AQHXuYigOMBAH1rzkUOHe5ggxtREoA==
Date:   Tue, 5 Oct 2021 01:30:49 +0000
Message-ID: <20211005012959.1110504-31-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 554e4a59-af97-447d-5c6d-08d9879fd58c
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044750D4E9C18E8F50F0832FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OKXLR1g+xorXYNwWLWyjy7dJFLAqDszmsYLLO4n5Jlr0XJtq3KE4d0jGBazr1fmZHDhYawo2IWwOKd2t3nh3lQaDj+8miU9wobogTG2SeR5l8gOBM12cQrpV7g+whtTEPs4+J31tsmF+AzawtbGYtOTO5PXgpTjuVyPqESW/Mkr9hOJw+4iBN3RkquPIgT39Jg9tp7LUyWU0px+CuKGbzccL2UVz8aSCTi8vDUmNdfC1xmv8B+bZgJYkhAk/ynCLkzWWSpavPs00iZwY2qoVr4wC6fn69uTV1UvfuLHtEmUoqm2YOWL2tBFfKkiJpoNQgebmRk3OSo+8vt6xMWnHOV4zm52E/3kak4xJcYZOgqMOM2FvpZodWgLz7aV8De3IOrVrb7elg15B//Es4HGUzJGWOmrpOKUGlpgcujUKWTK3DXelsPK5s2m62vW9PxyW0pItHe6WB2buyHaHF1vZ9ggK8bRZbnaG6F4z/Pg+mN4kPJuXVQz0S3/B3Hg/oVfCmaTYKMmMCePZ/a3MK60MIa2SktNdvmbcxx5rEhd+3/z52vF+eVt7rprTqIXX1/ldVdNx3BIHc4pKy8MhIGDYEySjbzSPaIiN/uCLo3qYoi5l2cLcF1nzmyw4KzOks0Hbeu3yzhFIX+5a/YrfZJjx6c+37nrPxklkBa+EP8jPDJfw0fMEOxc8Nl3NzcHGh4o0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WMPcnCZ9fFtMqblzq+pQ8FyA0ULPO5ihwjUk+Pw6cAG1v28cv5jLxE3imP?=
 =?iso-8859-1?Q?UIJnKBJcyLZ4uY9vdOcAGFoscpVRhefFZVOPIkjGgkYkVlk2QC4igrBgTX?=
 =?iso-8859-1?Q?kCiVljp+jfpzduBi/1EOPltB1KxSHUjQLaL0/iyag/u1f2tjjQFlxI+YCr?=
 =?iso-8859-1?Q?FRJlxOWxwlcFtpqPIl/YrjhXtQbo8NVjO5f7g1DcotG1aQ9OPNetntxzlF?=
 =?iso-8859-1?Q?Ry3jK4QsbLuJcF95fVP03LyYP9SRRbYqVyhtUp0JxAWdcdGElTr3W9ZrFI?=
 =?iso-8859-1?Q?8zXjzSnb3ciNbI1In7EXVr4mNeddR1vDF5dbdEFyRzwMtmQcYqMgvywJE/?=
 =?iso-8859-1?Q?NFlDy6eNHfmP4/I4Fk6sm+VKHWc8LWEgnbiVj+FkNLSUD948dMICj3zEWn?=
 =?iso-8859-1?Q?0dXSZ0hVGNobQBe2yRZqVBf0FjkFTMdiZYO5nJQk8whYf/Hp9rNy2PTqA4?=
 =?iso-8859-1?Q?6JSYkqQNUx7ku4BHTd8Zeg5HSz421ym39hb5TIUqiY89vCMTQbaiBF6d1K?=
 =?iso-8859-1?Q?oMmBw2pG+U7DNv1L3UsuV7x7Hg0BcfOewu6klWwn7bHFhe0d1W1a4E2YTi?=
 =?iso-8859-1?Q?S60CTh2dy5dWiyi+fUKQTqeSS2Pu2969BvGy044S3kTbAlixTKqBWx/UXt?=
 =?iso-8859-1?Q?qZfJNaEMHz/savDu9ggBdLdKUKQ9UFmjtT2CsyEuimhyDeEYTlwpz4S6JV?=
 =?iso-8859-1?Q?fANNjcLkdgvM3C/nXtGiAmVsG3q1mvvkBXt4Oq1XwPonHmhJaUjyhko73H?=
 =?iso-8859-1?Q?KxBrcti5FAJid+4bSzv+NCdCWIshUO6fQT+nU/1M6JWBmEeqUuO+4XftCc?=
 =?iso-8859-1?Q?KihBA3ktYoEIScJtuxig0Tapna72qnaU2H4LCkcZSPNF6HgCA37CfuzpW9?=
 =?iso-8859-1?Q?msDKoo4blOAtMaWYE7nCo8f5JTlPtX/gy+rAiBYMUBO2VCsAwZgVGRaox2?=
 =?iso-8859-1?Q?HxERp3FaQHzn006B/tHXwsYND51BTBBKGvM+CyeMCX7vq2oP7l0oQsgsCm?=
 =?iso-8859-1?Q?oiLI6/iteMMaJggghRe7SpQoDen6uZ9Pc9aBqkzjDC7/YffzBdbIhk8rMY?=
 =?iso-8859-1?Q?APSvKWwcTDwTZqzZyJwzDhW+tLyuigbQQmL/q1DiSnwUinyipsNYRQX8Tj?=
 =?iso-8859-1?Q?HPjNx7aFhqrPn409bC6Z171nYyVqSxq5bk2XXs8XPTRPiT2c248u9YWMQD?=
 =?iso-8859-1?Q?wd1QWivMNfJrp/UM454bJlYDdh8Bd2+mgwmisX+PwztStQ++wluWqHe1Qf?=
 =?iso-8859-1?Q?TJkU/JTyqgboY2Jna3/4WSN8z6MCCbHgrPvYLxM7wcpPokulpaRQRfatyT?=
 =?iso-8859-1?Q?7idy3yKPPn0oXEV+2XPuAH5/wVm/Z85fxqmKlxAEjiupbcUm+/5bVVtFyr?=
 =?iso-8859-1?Q?o0Gb+nGGu9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 554e4a59-af97-447d-5c6d-08d9879fd58c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:49.2907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8rVczk7g+rgifbpbtPeJ+rpKritBfcCYNTgVc3OXfgAAnKFMfQClByMaPzJS5uH5Dp6FJarjuRz8WxX3PDQFPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: 8uAfINWyAiZnyGXSZB5hdJMrstQlUJo7
X-Proofpoint-GUID: 8uAfINWyAiZnyGXSZB5hdJMrstQlUJo7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/x86/entry/vdso/vma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 235a5794296a..c0b160a9585d 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -128,15 +128,19 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
=20
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+
 	mmap_read_lock(mm);
+	rcu_read_lock();
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_mapping))
 			zap_page_range(vma, vma->vm_start, size);
 	}
=20
+	rcu_read_unlock();
 	mmap_read_unlock(mm);
 	return 0;
 }
@@ -354,6 +358,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_write_lock(mm);
 	/*
@@ -363,13 +368,16 @@ int map_vdso_once(const struct vdso_image *image, uns=
igned long addr)
 	 * We could search vma near context.vdso, but it's a slowpath,
 	 * so let's explicitly check all VMAs to be completely sure.
 	 */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_lock(&mas);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
 				vma_is_special_mapping(vma, &vvar_mapping)) {
+			mas_unlock(&mas);
 			mmap_write_unlock(mm);
 			return -EEXIST;
 		}
 	}
+	mas_unlock(&mas);
 	mmap_write_unlock(mm);
=20
 	return map_vdso(image, addr);
--=20
2.30.2
