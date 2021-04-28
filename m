Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE9736DC26
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240671AbhD1PnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:43:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63788 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240447AbhD1Phw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:52 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMAmC031068;
        Wed, 28 Apr 2021 15:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=wFt/A6xwRSu3BLCCRezhKvobRy25QdED9D0Am8WNjmE=;
 b=PnmZDhiFVN1ofqwa2tzH7abLUI/zzqdPIWgXqmGurXW0QZ0R8ViRmmu3hxe8vwA1ogAA
 Kafazo36TnRvloyPRl1abF8QJcn5Xe/RUNgH1MIWc8ThNh1Uzs6h923+etym8P3F2Wlf
 xydgnnPc5j4szcN93HkjSfK1KuYfDGJl/k75ldPOEy+6Gatag3XT5uN1GShH5bC+4mt7
 5nLhp2okp4e0IIWjikHYvTbmgY/kJunBt2wtasE3KajULwijLRHKi5OEoFJRFhkv+HVL
 m7vb/DYhUwPLZgNQZPx6Ggr/XhIlgAFUorYWqQRA5bXIgEqyR3E4pbp7ZdlwK8wb0l8L Hw== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3874kn0eq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:49 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaAx6018431;
        Wed, 28 Apr 2021 15:36:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3874d2759n-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzkymU/uNYfmVNeb9Wl9lqdfMJjWX/R4CeS/zXSwrpEjHVI3lhUmobjPDydykvSjBl65z4wR0WxC+1KhpTvfNSlyDMj8oBYyi8+EN321hFMtv2kBD77P5VABd1cQ8S0CDSChpfidozPRBtYmceqBnkwtyhumuAcKorfxbjzwkPbR+ph6tpmGA34gwFd1BDiFamVaJXCV8UutX6rsLrHmjCC+DZIiKlHViv4sYlcey/mXottyyDey870HcZ+w1Z9P2WjX0pKgQ6FbZMN/JGt0y+L5q9KbS9bB7yJy3j5WxetoXt/HWePDsPYXHXPfpMwz1OUhDsNDW91NGFPwtIIsxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFt/A6xwRSu3BLCCRezhKvobRy25QdED9D0Am8WNjmE=;
 b=FL0OrYobqrcuFwsPy3213FKQDPZAkFEbBDKRy12gseYzeR4yP1ME+e51xNu/Kxp9IGyUR711ZiGGMedD/TZzdOFl2oM+C24U1rfUUSYkUIGaWTJabCBXgrRAGHKTEyH8LTuRPDx5UEohfarbJjLXz3Cvbi498HgOQzf/QuT78SxRsRA9sYYB/tscAEOcxUz6PWu/nKoUEkAAOzJv/uodHGGz40GzfqnnJo3uuqWT4Mx2Vn20icPCNOdCzgUvyqHuk2c4xhX/3CMtiEET0us2mY3MnqZl2J9MpGyiotctbDa3g4LBinklb3VOVFlU1K3+4cQ4ZT9BpAEtj9/V6e5daA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFt/A6xwRSu3BLCCRezhKvobRy25QdED9D0Am8WNjmE=;
 b=HBo6qDDRdS5IyIRkNwipAv4b4ylZa+lZoKYeGBPag6yEt38WPSldfFJH+iaGF4hs36l5qjT4f8iDR3oTsla4xazIJsPipMPg6Q/DLa5z/TDH35I9cyqXF2+Ufv2XnJ2TTz+9IncXeZYjcIL3VYf3n2ui0Sr5GjeCQ8RjZJvkkYw=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1743.namprd10.prod.outlook.com (2603:10b6:301:7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:36:45 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:45 +0000
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
Subject: [PATCH 52/94] mm: Introduce vma_next() and vma_prev()
Thread-Topic: [PATCH 52/94] mm: Introduce vma_next() and vma_prev()
Thread-Index: AQHXPEQ5/vAk1D8p4EWw00p/hvZ2+Q==
Date:   Wed, 28 Apr 2021 15:36:14 +0000
Message-ID: <20210428153542.2814175-53-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: ca885035-66e6-4413-c65e-08d90a5b6df5
x-ms-traffictypediagnostic: MWHPR10MB1743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB17439866FEA99F80770729BDFD409@MWHPR10MB1743.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CIvcanzxIhkdfxHwoGfq+5E5ObAEc+BQ1Z448ZjKiz5djWqK35WljyMmhsGY93EzLyBid7n9EdGhw940GP36Ons2S+CJu2/leFYuS+tr9CtWPRIz3euOz1aKNeqQdQyg3SmpwR4ZUB9Xau/vSqBiHvy8vHseMxOWm6Zb0T/6C1tgOfmKnAQwKUmZ3iXQH6hIbHJQrnHVf4sWFbLmqlALBqB7/vUQryGYJ9o7OVGfPC0bQZUEn+Z2SbX8E8D52WGyt8jP6cz5YRs7d8UgLhiQOmT1xoUVmHPrjFnu/6HOOTrqH/s2dJZLudXMVCMEFSs/PIUGDDNW6TyzFmmYPh2/XXQywMqpW3slxJjBwFZGSfMpt6KeDvmP4GbzzJdeWZi6y3vOtx2ROd9TA0ScDU5O6FEwMqSP65vDeP3XEeFYVUYmwxcs3O/uyOSVziZI5oCRcTzH56oFFmZvD5JQ6Hpm57oWRe+6elRNtnZLMfUFsh8x9wjOC7PWoaL52qRAPg4r2vo3mC9WEiTQuXsNHHqhcYByuk8zPJCvPFrxlIX/jyr6Vl/13Gi09vu6b7d0hv4/t4i62ACjZRTRliRP1P969qmdL0EODW6Y7lBxcBnk1ds=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(136003)(346002)(110136005)(91956017)(316002)(1076003)(64756008)(66946007)(76116006)(44832011)(5660300002)(66476007)(66446008)(8936002)(6486002)(8676002)(83380400001)(54906003)(2616005)(66556008)(2906002)(122000001)(38100700002)(6666004)(478600001)(36756003)(7416002)(86362001)(6506007)(26005)(4326008)(186003)(6512007)(71200400001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?24z0RoifuHH0yeL6h6rhY4rzgDq4c/0bHSCAAX4rEHUIA6PofKwC7dcojn?=
 =?iso-8859-1?Q?+O+LFJoEVfjYua9HrZT5VLcYq7uB8nmkpyFjG83Nsce6xp/PZIFr9DZMIn?=
 =?iso-8859-1?Q?WwgRm1qzDng+NQl3PRiicnveh5t5sILsFRiqCeedR/szEJA0NuneaYnkPX?=
 =?iso-8859-1?Q?3Lybh/IOBxZ4jCBS9582flXLSS14ZvwvOtQqlKonyPMzuhuGV4+FX7Nq/p?=
 =?iso-8859-1?Q?6QBJ6IlzRLOKApgjLhSwXUw6uHHxtTg0WrlqAZFz4CHjmE8tC8zu8Yu/gv?=
 =?iso-8859-1?Q?KIUCJdg9HuxRaCkv21Tl39nQ2CzXJkGJEUahLn8cakWfjIQjs4DiGZnTcF?=
 =?iso-8859-1?Q?gJ/7hLCk0JQPiLuV4wvokaKy3zixF/TAoEscYZSIL3Ge8xK9ZmHf1lmQA5?=
 =?iso-8859-1?Q?eoBw6JUBES7npbgUeS/yPnL6j7/Zi9ssnMpRnqVfUYPNg9qdCmdIMlgneu?=
 =?iso-8859-1?Q?MYOSDJkxXyKSV6Dnkyw82TBcntfB4qDe+jSAF7i429CG5XIlLmneE159ji?=
 =?iso-8859-1?Q?ez6AOT53U18PUMAtn9nKNKrtaTwePq8PqEAtOTwLBMI4VQcNIG9bXwsA8y?=
 =?iso-8859-1?Q?rWyxd3ksGyWvzsDsY1F/Nqa44uODCAxvX14FDenm3BaC2azzgf+gbs6TGQ?=
 =?iso-8859-1?Q?b84bGshRhOvx9FOzgC76eiHA9DXFAgGky2QiCrmcSZt+8xguiqezMyCYtB?=
 =?iso-8859-1?Q?zCeXZ9nolM0I7HrsOu+V2mQ+uq8M2YtfXVcqfsW8UpMPSyUuj6yKSx5P/Q?=
 =?iso-8859-1?Q?cP4wlnNXncqzfuPGRK0iPoLh8/+KLTGCEdmt8M0bgOZpFQLAoCMma6hws+?=
 =?iso-8859-1?Q?307QkmUIoo3GKx+wo4nkJHH7NP60Lrok+oFIS+GUF30Juq2f++hX8S/FVS?=
 =?iso-8859-1?Q?IHwgMOOcQmXCV+3TL6lccCtY6gUnfJPSA73phJum674pZoWQ7w2JhZTLja?=
 =?iso-8859-1?Q?C5Hx1Nvp+rpTBBptQsb2/Z6NjNQhtQflhblSJQSbnRtnyGpYYSR7aiVk40?=
 =?iso-8859-1?Q?PGrnqDXd7GevBOoE/EQIkemGtCJkh3zpHHEFURxj2ZQxXMiZ2fk8LeuOpZ?=
 =?iso-8859-1?Q?suRpdYseq/uh7efpD2s4rVsrq7K0TWxeWs6anrOvhzrXEfeNw03Iz9sn4q?=
 =?iso-8859-1?Q?XKheW17zY5gCN38FVw1zHrAUk54v5n5T7fhOHVwsb/UIgDgXL4pPxzthiD?=
 =?iso-8859-1?Q?z3cgeLR7LqINsttqyjFZVimTEKJgGAeAmVD9bfRZhFTftoODWwEft38HHM?=
 =?iso-8859-1?Q?qSo8FoqG8fkBXfcvJdIqQgdDUk+Ac3VlmcDbzMnlUuVEVLfGv1xwcORPKo?=
 =?iso-8859-1?Q?42OHDtuRA0lqR/SGtWAYqbhlJQTy1WCaIDJI4CRT84MjlzKq0+9Vkc/TF6?=
 =?iso-8859-1?Q?jHPIfBkZb0?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca885035-66e6-4413-c65e-08d90a5b6df5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:14.4457
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wi7HppUqp18K+xDI6xdOEKyIqe+9/GTPrbVf209+eOKWK9WqvsHzsqwDcMMkxi6138GZi76OgbTjc9dKzMMvWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1743
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: nOwCNBhuueN83tn-3nds-hpTNpOVRzyf
X-Proofpoint-ORIG-GUID: nOwCNBhuueN83tn-3nds-hpTNpOVRzyf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename internal vma_next() to _vma_next().

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 33 +++++++++++++++++++++++++++++++++
 mm/mmap.c          | 12 ++++++------
 2 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cbc79a9fa911..82b076787515 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2694,6 +2694,24 @@ struct vm_area_struct *vma_lookup(struct mm_struct *=
mm, unsigned long addr)
        return mtree_load(&mm->mm_mt, addr);
 }
=20
+static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
+			const struct vm_area_struct *vma)
+{
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+
+	mas_set(&mas, vma->vm_end);
+	return mas_next(&mas, ULONG_MAX);
+}
+
+static inline struct vm_area_struct *vma_prev(struct mm_struct *mm,
+			const struct vm_area_struct *vma)
+{
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+
+	mas_set(&mas, vma->vm_start);
+	return mas_prev(&mas, 0);
+}
+
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 {
 	unsigned long vm_start =3D vma->vm_start;
@@ -2735,6 +2753,21 @@ static inline struct vm_area_struct *find_exact_vma(=
struct mm_struct *mm,
 	return vma;
 }
=20
+static inline struct vm_area_struct *vma_mas_next(struct ma_state *mas)
+{
+	struct ma_state tmp;
+
+	memcpy(&tmp, mas, sizeof(tmp));
+	return mas_next(&tmp, ULONG_MAX);
+}
+
+static inline struct vm_area_struct *vma_mas_prev(struct ma_state *mas)
+{
+	struct ma_state tmp;
+
+	memcpy(&tmp, mas, sizeof(tmp));
+	return mas_prev(&tmp, 0);
+}
 static inline bool range_in_vma(struct vm_area_struct *vma,
 				unsigned long start, unsigned long end)
 {
diff --git a/mm/mmap.c b/mm/mmap.c
index a8e4f836b167..51a29bb789ba 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -481,7 +481,7 @@ static bool range_has_overlap(struct mm_struct *mm, uns=
igned long start,
 }
=20
 /*
- * vma_next() - Get the next VMA.
+ * _vma_next() - Get the next VMA or the first.
  * @mm: The mm_struct.
  * @vma: The current vma.
  *
@@ -489,7 +489,7 @@ static bool range_has_overlap(struct mm_struct *mm, uns=
igned long start,
  *
  * Returns: The next VMA after @vma.
  */
-static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
+static inline struct vm_area_struct *_vma_next(struct mm_struct *mm,
 					 struct vm_area_struct *vma)
 {
 	if (!vma)
@@ -1144,7 +1144,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D vma_next(mm, prev);
+	next =3D _vma_next(mm, prev);
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
 		next =3D next->vm_next;
@@ -2302,7 +2302,7 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D vma_next(mm, prev);
+	struct vm_area_struct *next =3D _vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
@@ -2453,7 +2453,7 @@ static int do_mas_align_munmap(struct ma_state *mas, =
struct vm_area_struct *vma,
 		if (error)
 			return error;
 		prev =3D vma;
-		vma =3D vma_next(mm, prev);
+		vma =3D _vma_next(mm, prev);
 		mas->index =3D start;
 		mas_reset(mas);
 	} else {
@@ -2470,7 +2470,7 @@ static int do_mas_align_munmap(struct ma_state *mas, =
struct vm_area_struct *vma,
 		int error =3D __split_vma(mm, last, end, 1);
 		if (error)
 			return error;
-		vma =3D vma_next(mm, prev);
+		vma =3D _vma_next(mm, prev);
 		mas_reset(mas);
 	}
=20
--=20
2.30.2
