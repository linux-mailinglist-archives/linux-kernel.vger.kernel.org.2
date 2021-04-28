Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB8F36DC24
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241167AbhD1Pm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:42:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35196 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240435AbhD1Pht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:49 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFOtGQ015173;
        Wed, 28 Apr 2021 15:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=jkgLPuRUxsNkItVYOxz4rhIUE0a8h+rY/Nv9L0hZxC0=;
 b=AWKMv4Dc+jYCx0dRc1B2CXMHeZpQI/TpI5fkDuD198P2iFYmkgKsFDqPalPbi2eigrmX
 Gpp+aSkIIZ/+Xay8/sfRFQXFHtYpcImnNuyttCY1uY/m8E13TkpTUKkg6ONks0YYBBSD
 BPxR5sLqNOJWvUWK2O5FgraaosXm0B3+ENj44sgVq6DBxTvFaCdED9SBSUgAQYH5yEwG
 s9im8r9Hzd2UUAKcNkgrR/4jhwJTk8ldoDRoqBnQyN2jleSS4LOvPKoMFyAf2W7943l+
 bXmZBAxmN1BCf/Zr69AxmT40qViCHxjHG/Tnf0PDScmGpdLvobuKML+WalxFf2A3SwTz Vw== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:43 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaASr030176;
        Wed, 28 Apr 2021 15:36:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 384w3uuag3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DH//u3RXaktPjpbJkTXHquoBYBROhEQ3p32JG54VZU1V7Iveu2thUPmfObSoOa0kWThetR2XEobflGNo9k7eZfko2qij+jImXCzirW8ryqWzscZA0c+9OPClRgiIs6IbFW3NgGzFNK4oke0CkBjnFv0n1EzM8cJqduHV8dGLnut8r/02n6vCmDpV5ycZeTQ/3kWhQf8HVHmU/gKIk5g761OOGfFMu/1VnnsLU5h421hY6IGVhz6LfOQMXkQSDcncfhy93jGlFgK2WK57cyau695THelgmR32Sw8N5bE5uBckwxc8RlOF84STrtzNHJEMKmCowtBcaMB2sCozFZYM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkgLPuRUxsNkItVYOxz4rhIUE0a8h+rY/Nv9L0hZxC0=;
 b=JxkyK4Yu9SYSVFTfTJiln8hi0pdD65Bld7WL3i4xAQLeEFjnu3HL+I5cOUePAagCOCUU2PWrUwQOZj9s4F/BxxokD6BCrRwqvEVCiOuEFY/YoEor0gtdqlD1+anHy0SBlQFS53wW+4v96krCI0B53FM2/jN4jvm5rpW020vSzHZSSF8qpDpeCFb8UCka7yBst+Fpc5V+OqjPZrwvrykz3aJhEfLghoM/sxask65cDDDNhmuDY0MCdmTGC084DE/GDTlstcG0l7S7/tP+WJhPjwx2fVXEGNYpHtNzCJpBTS/wf5H38pHJtJFsS9q2t9B4WUX0gs1/McEpoJMh5BVhQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkgLPuRUxsNkItVYOxz4rhIUE0a8h+rY/Nv9L0hZxC0=;
 b=cEgZrkHRtEqWEXfnCb0CS0W+n/lj+ZCvCas45NW5LOTnFpwVULOZ7bzJo11SuXa320YH6wgDWhWQbCDgs7J4whwwyPvdeskTNAvZjZ5obiItSNhKS/qwEbnsPeOwSyyjruBa/2ZAJuRKjiEZ58KqIOi6d4QDnRjrTTyVBicS9mk=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:36:39 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:39 +0000
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
Subject: [PATCH 41/94] mm: Change find_vma_intersection() to maple tree and
 make find_vma() to inline.
Thread-Topic: [PATCH 41/94] mm: Change find_vma_intersection() to maple tree
 and make find_vma() to inline.
Thread-Index: AQHXPEQ2JoekAuRdn0afRqRwAKkEqg==
Date:   Wed, 28 Apr 2021 15:36:09 +0000
Message-ID: <20210428153542.2814175-42-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 42550c42-af32-4fe3-d488-08d90a5b6a9d
x-ms-traffictypediagnostic: CO1PR10MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4515E014D9C46168239BD7C8FD409@CO1PR10MB4515.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9LuYX3OL+y+SdPNnVoH6LH5Ur4jVVBog6aK8hMwVlSZ+ARH0gM1rnuISOVidN+atjNrKiTZZaA8/wXb62suJ04H1d/OAsWexqrUDa2MOxiud3ggR/2WjVF+knkyS7ziJ6gJbKk0ZPtOVwRUdM9uJZttAljeiVd6OrTgPOu90Kjef4k3w2LTOxZ3f0V0NhJFHCC/GOFFwZGPGOrRQKQk8jdMUYWb8lawM2ODBTaDWjRqfOVKpxxefOnKuFQY8+NNJopSFOZkc7ZZbCgxzNxMk0GTPTsezSU6a8LQtAh08IiDEyAHosm9yOQA+Xx5PmN2pP9BbOcoBs19igx+sf3mMK4uDrQVqSu0c3SDJDfL71HQZhObn+HAAQ3tr+WmzL0/arrGXfEdSRGP0DbVUvvE/3L7bv72KiPJDFcEJXw9sjv1TyfTu2nk8KJaypPd+qGQZE4wStmU7c8iAVXghqDKioS7kTzKtkPCWcz1Ip6BfTiRewuV1ju8Fw1vuwFKGSuHUp438SjjtrsOLmCBFb9ic9teKHyVhD+IebTVZp/9I3nxnKIs1d2RkGaq2Ss+WSKehO/FUzeCPYmHuQagciHKpJzpdxGSCZMiJas/hcuRRPv4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6506007)(4326008)(36756003)(54906003)(71200400001)(26005)(110136005)(6666004)(316002)(8936002)(186003)(44832011)(7416002)(2616005)(8676002)(76116006)(2906002)(91956017)(66556008)(66946007)(478600001)(66446008)(1076003)(107886003)(64756008)(86362001)(5660300002)(66476007)(83380400001)(6486002)(122000001)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?fN3AzLXPsTwMC2xvyjfck8aYTkL2tpPqygdWBRiV0MSe/CNsr4Hxa1LIGO?=
 =?iso-8859-1?Q?gbfmfs9ueWLG09KMgHL7JzjLhhJvLy/yx5hvl5JCe1TU2Ay1cPtla0EqO1?=
 =?iso-8859-1?Q?bqh9tOOexmBIWayUHRHo7jNVaeG2YRKUcAUEzgjvvFunajGR+8Qs0wEiva?=
 =?iso-8859-1?Q?hPY6zdleUGDa3nMlEKnRODG6yJTCF6zHkTMkN3rSxlv3lZiRey2T96wCCR?=
 =?iso-8859-1?Q?aUf8ubXPQEA/nYxoT7ua9y+Bozo/DdGrHD2L5qTH3/SU7bCNSRuQIe5fXs?=
 =?iso-8859-1?Q?RznILXUEnqzHfQpbnJx6Yn3D6VRgrvDbpCLWI4/3qO5Llhpuf/xpbt+4H1?=
 =?iso-8859-1?Q?TcCV6U1pS+QFh03ILdx1UrrZgYtbBAnQbvFEuSeE/KDrQH0xUrvd4RNu64?=
 =?iso-8859-1?Q?nEhcmDbtqdLEUwFuaBHUdfSdKSBnkrZxSlPhNTd0lDbeNovIZTJbDuB8gb?=
 =?iso-8859-1?Q?eYe6pr+Mx75p607nCdwryoDs4kkI/41h4R6TYXB+6StpGGcNXEGX6syrBB?=
 =?iso-8859-1?Q?9NDT25aclPOUd1/0Gd7ENg9fqcQy8epjZdgEJdRySkYZlzo14YKjYRSCmA?=
 =?iso-8859-1?Q?BpVZtoxVmZCY+XNL/2hwYLMgvXd0jw1dUqQOBTHW5K7qDehT5UJGAMq1LM?=
 =?iso-8859-1?Q?ouO4CJMzh5r8B3Q3MJTeSVNoK2OAlpLf4aIjapWDvAIs9bJ33HGovgCx6H?=
 =?iso-8859-1?Q?o2Wu1OjSRIXT6Bfm4iHjidsfnPJ/jxpkDE0m8lOr9VYoXj7XAfiks1d3rf?=
 =?iso-8859-1?Q?TvBhG32+lyDJ8o8yta2xl2iLzvxjBu8blyqpEH1bC9IB6JGgRBsd8tf5D8?=
 =?iso-8859-1?Q?j1A4WfgEmFmosYMITjOcc2QGCW/ukNk6HdhlwuD8dGWnEOQJjc0nxzzHvg?=
 =?iso-8859-1?Q?VIVCzlelw9Vg9QzjXmYRI9ldXtmO7EAxio2wfWW/eL3jfrBNGz2hjvsheu?=
 =?iso-8859-1?Q?PbGe5C54nOiiOYcTHC8Xes4URGotGfMyu/bMDFbRkvJqoZeo+6p4sQ0dCs?=
 =?iso-8859-1?Q?z/+4G5Ftb9rkFV6GrtpPUxXaxRCcY2v8t2WD6bYXVU41pFwSUMIePecSF4?=
 =?iso-8859-1?Q?oRBZZoIp9y11TeHYBRXb0X/vtjUcJ7MDBLZkO98buTlaxQr14xMUfJZZol?=
 =?iso-8859-1?Q?Jx79RCBk+aZuuDQQikE4bD1VSAb/yOB75cLKIwapYT0tPdD/eu27Ix6+ez?=
 =?iso-8859-1?Q?8E77d8j2dnCHVLJXalZVnGDvlB3+2yBL5Rnh3RhKggU3jDL6XWXtlwEt81?=
 =?iso-8859-1?Q?Ed7IDbuVXAIBuQYxpjeCQa+sBxkzSj3nywjNyLCJx94vgFV0DsA49CYUGv?=
 =?iso-8859-1?Q?fFLGbX2g3i9C2arNsL+CWt9FWi4FDCdvL+X2cNDAGNjtsdl3Lv8W4kvz9W?=
 =?iso-8859-1?Q?jCg4l6qZHe?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42550c42-af32-4fe3-d488-08d90a5b6a9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:09.6848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f+O9Eeu5YCNiaeovOhCNRoZ+jR1A4euMo0KSXJSGmyptC1WFq++i93RWzK8oXNCG09iCHdfWV9IKWz1lY9189w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: 4Wlr6-mOm07TZh8N_hX_k3sDvfxznoKX
X-Proofpoint-GUID: 4Wlr6-mOm07TZh8N_hX_k3sDvfxznoKX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move find_vma_intersection() to mmap.c and change implementation to
maple tree.

When searching for a vma within a range, it is easier to use the maple
tree interface.  This means the find_vma() call changes to a special
case of the find_vma_intersection().  Exported for kvm module.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 10 ++--------
 mm/mmap.c          | 40 +++++++++++++++++++++++++++++-----------
 2 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index cf17491be249..dd8abaa433f9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2678,14 +2678,8 @@ extern struct vm_area_struct * find_vma_prev(struct =
mm_struct * mm, unsigned lon
=20
 /* Look up the first VMA which intersects the interval start_addr..end_add=
r-1,
    NULL if none.  Assume start_addr < end_addr. */
-static inline struct vm_area_struct * find_vma_intersection(struct mm_stru=
ct * mm, unsigned long start_addr, unsigned long end_addr)
-{
-	struct vm_area_struct * vma =3D find_vma(mm,start_addr);
-
-	if (vma && end_addr <=3D vma->vm_start)
-		vma =3D NULL;
-	return vma;
-}
+extern struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+		     unsigned long start_addr, unsigned long end_addr);
=20
 /**
  * vma_lookup() - Find a VMA at a specific address
diff --git a/mm/mmap.c b/mm/mmap.c
index 7371fbf267ed..df39c01eda12 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2037,32 +2037,50 @@ get_unmapped_area(struct file *file, unsigned long =
addr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
-/**
- * find_vma() - Find the VMA for a given address, or the next vma.
- * @mm: The mm_struct to check
- * @addr: The address
+/*
+ * find_vma_intersection - Find the first vma between [@start, @end)
+ * @mm: The mm_struct to use.
+ * @start: The start address
+ * @end: The end address
  *
- * Returns: The VMA associated with addr, or the next vma.
- * May return %NULL in the case of no vma at addr or above.
+ * Returns: The VMA associated with the @start or the next VMA within the =
range.
+ * May return %NULL in the case of no vma within the range.
  */
-struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
+struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+					     unsigned long start_addr,
+					     unsigned long end_addr)
 {
 	struct vm_area_struct *vma;
-	MA_STATE(mas, &mm->mm_mt, addr, addr);
+	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
=20
 	/* Check the cache first. */
-	vma =3D vmacache_find(mm, addr);
+	vma =3D vmacache_find(mm, start_addr);
 	if (likely(vma))
 		return vma;
=20
 	rcu_read_lock();
-	vma =3D mas_find(&mas, -1);
+	vma =3D mas_find(&mas, end_addr - 1);
 	rcu_read_unlock();
 	if (vma)
-		vmacache_update(addr, vma);
+		vmacache_update(mas.index, vma);
=20
 	return vma;
 }
+EXPORT_SYMBOL(find_vma_intersection);
+
+/**
+ * find_vma() - Find the VMA for a given address, or the next vma.
+ * @mm:  The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA associated with addr, or the next vma.
+ * May return NULL in the case of no vma at addr or above.
+ */
+inline struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long=
 addr)
+{
+	// Note find_vma_intersection will decrease 0 to underflow to ULONG_MAX
+	return find_vma_intersection(mm, addr, 0);
+}
 EXPORT_SYMBOL(find_vma);
=20
 /**
--=20
2.30.2
