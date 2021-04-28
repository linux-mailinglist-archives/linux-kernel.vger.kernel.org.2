Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E21936DC27
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240507AbhD1PnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:43:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63604 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240446AbhD1Phw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:52 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMCTJ020060;
        Wed, 28 Apr 2021 15:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=6vy7QghKEPrgX4g5ythxoSSlTCpQsdECl9P4/d4wv80=;
 b=q/sG6HqKOViKj63eG4/hHG9rcq9OPyYoDbRJbqzILEv4JtwJQe432p287Om8GMRtpF6I
 7AdBVoBnPOgNSeUjyNbYm8zX/nGxbSgzt47K36SGk7gUu6dPhwjBDiYYmTFiw4S87KLT
 D8TG23vg2zwuMApveG3dFqHGF4xnkiM66WKoPawF2z3ue94t56BEamd8cjG2IOSE0tKk
 yLCmjui8SketiSNnmSmxlzRBpiPeaHhpUN3gKPW217kDpOojTK4vmodzZKAi0aajBWIL
 o9UwfTNaDR13ha5q2P29r3gpWzTPa4/cjarPjSGHtBBMUs0LXTSLpwpXyOSIWCnqBC94 rw== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878kgg52e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:47 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWJwO016127;
        Wed, 28 Apr 2021 15:36:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3020.oracle.com with ESMTP id 384w3uuaj4-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXpx9esJr3wDqjgLUQhH8QNj3BEqbyEcM95ktlT80oYivhCI/lVFuL6yc3T0rex0ka0NpTrsUf2v1DE7LfDqIlpPYrlUn4aWx+EAVyl9Wu6V1aA1+1Uj/MlE55xbvnj2yuDKC5hWn/5AbjpMgbDgd3c9p3958L1opPKyLDfThhy0tFgq9IW/9recq+WJWaZw8MAJ1/zMWcrQ8W31sfZtqdceafNFhoitaWNSalW0omVrC29mqhaYWEQbqy9U40HZVX9pVMpujb/0UUlH5VamVV7XH/L2dSIStqKeOiJn1lSJmuUiDL8vJSrhFs9JRMkoNGkCu/oma2XRxwxvcYnq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vy7QghKEPrgX4g5ythxoSSlTCpQsdECl9P4/d4wv80=;
 b=JxHecAxtHOd/tJUyOz1hXYBhNcigudp+we8SBrXq3fedtCmKkzxu6nVBj0xAvMfg6dKRHVNW/towQREekkwRFLG9huXuH1ijp5LWN34nmw8yl5lHXWlL6xPIi0gXUr6cqodzLNWBH6tinMEsgoaxazJwsgPffzMDfjOuJixYXz4O2fofcOjQzqJz22rzxoQ2pYoxmHwcAzBCFkUysVJSCma+a7FYID9d/sqMInPgVXB5gBVpYUma/la2ujus5a4r4pf4bhqr3lNuMPLTO4u1oyDFNHmH3KjEUWZsnpo2NkmUuF24kEdJq7oxmgkaki6hIOodUo5XbIrR0tKPzHXkoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vy7QghKEPrgX4g5ythxoSSlTCpQsdECl9P4/d4wv80=;
 b=dtrHlohRc5MFaCBDBpUlOfjhVNQEFfv1NcrhXZVhE3OzaX3i1tCbZu91t8IdgtAeSn/9x6nsoN7VHXtiK35L8GT9HAj05/cfGGX8WNKJaGePgyZKm7wUfYKNfxFL93HELWE7XYR2m1PZDAd3usYU+W7JlZjy/gFf9Fh300ABPP0=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1982.namprd10.prod.outlook.com (2603:10b6:300:10a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:36:38 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:38 +0000
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
Subject: [PATCH 39/94] mm/mmap: Change do_brk_flags() to expand existing VMA
 and add do_brk_munmap()
Thread-Topic: [PATCH 39/94] mm/mmap: Change do_brk_flags() to expand existing
 VMA and add do_brk_munmap()
Thread-Index: AQHXPEQ1pCHkAlZX4kCwrdURkRu4vw==
Date:   Wed, 28 Apr 2021 15:36:08 +0000
Message-ID: <20210428153542.2814175-40-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: a4d3eebf-07f5-4218-aa49-08d90a5b6a08
x-ms-traffictypediagnostic: MWHPR10MB1982:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB198288CCCEEC999E67BAE919FD409@MWHPR10MB1982.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hQEmvpNWiRDMobV+za1S4jJx1dah4LDNZ1EqlgEmEj82S384NNlJHwrlRTLCcF+59LtYuCe9OfLKHl9TR6uCYa26aD9BR5Pn41YRrMVK0Y9GCl7Dho6y6wdxnJznHqA5JmygIYFG0UJ5J1FFPaF5MSLPO4VPl7Y9xEwH3+mwtr1wcQRHh+IwvSQfEymk+3tVndYrQSeqExIigCT2qJYSCE7JMo8Wy/gxEXbhqdeukq4Da2anc7pSLcmt8He3JutuUr10epTlUMPq7DdnKJNoC6ZM2s8NbXW7PJvvDIGjiWFPoQ6s/y5hYiMM7NG2t64HmQwqemFu9yxuimhCz3e2acg1ktKLcyubu1xdBBatnVoT06WzP0YC+L2O1yXsEGn3ijE3ED1DWCah2PPnlbiPT2q7f4vJuXg+jPuFTEfB68xHSGWehEYBs2T3mifbzo1UGG3x2u000L9N45VGLliyENpRUIosnlA09kqyofia1RZptYsnrkxxI5O7+GF6uWUYidAH69Y3AGCy78KSOtcmIbLpPOD/tpmBNZsoFGrvz9XuUp/QEKfso2LmVV+JdMYKIv8pTw3acCC1qcNmPhLtJe3ekCrfA95dXjY76z2YXQo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(346002)(39860400002)(2906002)(8936002)(6512007)(1076003)(66556008)(76116006)(83380400001)(66946007)(6666004)(2616005)(7416002)(186003)(26005)(4326008)(110136005)(107886003)(66446008)(54906003)(6486002)(71200400001)(316002)(5660300002)(38100700002)(91956017)(478600001)(64756008)(6506007)(86362001)(44832011)(8676002)(66476007)(122000001)(30864003)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?RE8cC4c7LKxpJ0Rgi6F07+JhLWlkzqKzdvsFfphlywR7S7o3blCZ1OBd4J?=
 =?iso-8859-1?Q?4JS8SugZJjPm0LhI3jEEnua2DkomOakpnw+2MCX30zB8WYuHSiRyF4tMRu?=
 =?iso-8859-1?Q?R+tHvlOyusEEgC2z85RLhTluierDmk+SYxMiuU0znu1AETdrNnN9ipt6N7?=
 =?iso-8859-1?Q?pUwRE1r3bThPUYFXgzE2AauAvd/avBlqDWoopiJ30KHxayfHzbQ+B6QuXh?=
 =?iso-8859-1?Q?izFIW49kz4vtMmuJ8EOOV2shPVT2UfX/1IbVEqXlwlgJVeSEefCfjiqKY4?=
 =?iso-8859-1?Q?BhBCyijSa9r/+N4n9VOjkZA6F0XdJOn6O1hZ+evpiHmLenWjSY3x1XQsWL?=
 =?iso-8859-1?Q?ky0GXp2djfKHpzJTmtR64wN9oZdPRy2hCdJOZUjM0WHiRoVT6sozLG9idw?=
 =?iso-8859-1?Q?+a+jKrdKqGqlpfkxgbBAO9hekoJM5Fe7Pd7W0anp6l7Gzr6EYjWAnXa2IR?=
 =?iso-8859-1?Q?brCQJpTFVPpfIufKojnbgt1d0fA/B580qsxWqvCYBrpg9r3Y3ym63axA4E?=
 =?iso-8859-1?Q?R0veJWioWHuqW4V62fl2IarnyugFGzsVFEUzBV6iWwI8oWnM3gceJdkhtc?=
 =?iso-8859-1?Q?pszbFt179wHggwPQIxM/QTi0yLvLQ5ErpA/xWVDjpM0f9UG9JwA8X06H/S?=
 =?iso-8859-1?Q?GAEJkPPEOoBBAefr4kgz96XFsGA5GD2OYPMgDdXp2Tcd9Y2KfR7UQ8+No9?=
 =?iso-8859-1?Q?5loWjYaNxDvUEX6v0YO92ga7VqP7WgItcuzEoZugzLHTkBWHyWDobAi/Ge?=
 =?iso-8859-1?Q?AQi/IxCO1FzIcmxs5P2LYFcH/uda3NQwQjvo3Ool2NBRo5xj9YNYn3EdXU?=
 =?iso-8859-1?Q?akMg5ux8nvIEjiIvBHzHE6qehgVzvCmoPKBYvkEeFCsQjdnd4pjwHyMinf?=
 =?iso-8859-1?Q?H0RWNNGnO9ggdvfqmnG1+93RF0/Ayv/c0ySTHBMlGEvTZsRSEJnD/y/xyM?=
 =?iso-8859-1?Q?ihonujvHE/Kzd3CsV/bQ9CPR9P2N+haUzBtWOugq9IIA5qUPgKpCJy/HZt?=
 =?iso-8859-1?Q?1y63gsLWQ4jzPmI0+tA4RjwS3QPctOgLMdFFKeNx6pPbj8Do1i+49DK/wx?=
 =?iso-8859-1?Q?sVcBbWuOJCfhWQxag3aODx55Bn8PwszBTnMO7LzNGPa8PZmojiui7GImfj?=
 =?iso-8859-1?Q?usNKde6LzVzZ4IZ/HKFdT+04fZFK5cF9pKkwpcUbIf10b80woyw8INxyRX?=
 =?iso-8859-1?Q?vWzJgDkZ9B9bY1/04K/AonwQIvf6MCds0j5orzxstGMEWAUeFQhVyChTTN?=
 =?iso-8859-1?Q?9LPkX54icn7+N552Kpu81JjWJ+VOIQVfWW3oqEod1JqBRIKIeCF8n6ILee?=
 =?iso-8859-1?Q?yFX7kpqWVXGbXBHiFUJQOcsS8w2EAhHg970bU1Kg0brJtUYrnxcC1ngyFw?=
 =?iso-8859-1?Q?J7ViNptLDI?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d3eebf-07f5-4218-aa49-08d90a5b6a08
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:08.6043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 58mhAgG3PHPLzt+y5aIKcIbZxonymkPvrqjDApmmQ4kx0JuP0t9kEYflqyhz9Z0l3bT43JSK41iLxGmlwfV7gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1982
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: z30C6OAHjpsNd-lwag1mNG3LcXKdKeNo
X-Proofpoint-GUID: z30C6OAHjpsNd-lwag1mNG3LcXKdKeNo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid allocating a new VMA when it is not necessary.  Expand or contract
the existing VMA instead.  This avoids unnecessary tree manipulations
and allocations.

Once the VMA is known, use it directly when populating to avoid
unnecessary lookup work.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 269 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 214 insertions(+), 55 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7747047c4cbe..6671e34b9693 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -190,17 +190,22 @@ static struct vm_area_struct *remove_vma(struct vm_ar=
ea_struct *vma)
 	return next;
 }
=20
-static int do_brk_flags(unsigned long addr, unsigned long request, unsigne=
d long flags,
-		struct list_head *uf);
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf);
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkv=
ma,
+			unsigned long addr, unsigned long request,
+			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *next;
+	struct vm_area_struct *brkvma, *next =3D NULL;
 	unsigned long min_brk;
 	bool populate;
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -240,37 +245,56 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		goto success;
 	}
=20
-	/*
-	 * Always allow shrinking brk.
-	 * __do_munmap() may downgrade mmap_lock to read.
-	 */
-	if (brk <=3D mm->brk) {
+	mas_set(&mas, newbrk);
+	brkvma =3D mas_walk(&mas);
+	if (brkvma) { // munmap necessary, there is something at newbrk.
+		/*
+		 * Always allow shrinking brk.
+		 * do_brk_munmap() may downgrade mmap_lock to read.
+		 */
 		int ret;
=20
+		if (brkvma->vm_start >=3D oldbrk)
+			goto out; // mapping intersects with an existing non-brk vma.
 		/*
-		 * mm->brk must to be protected by write mmap_lock so update it
-		 * before downgrading mmap_lock. When __do_munmap() fails,
-		 * mm->brk will be restored from origbrk.
+		 * mm->brk must to be protected by write mmap_lock.
+		 * do_brk_munmap() may downgrade the lock,  so update it
+		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
-		if (ret < 0) {
-			mm->brk =3D origbrk;
-			goto out;
-		} else if (ret =3D=3D 1) {
+		mas.last =3D oldbrk - 1;
+		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		if (ret =3D=3D 1)  {
 			downgraded =3D true;
-		}
-		goto success;
-	}
+			goto success;
+		} else if (!ret)
+			goto success;
=20
+		mm->brk =3D origbrk;
+		goto out;
+	}
+	/* Only check if the next VMA is within the stack_guard_gap of the
+	 * expansion area */
+	next =3D mas_next(&mas, newbrk + PAGE_SIZE + stack_guard_gap);
 	/* Check against existing mmap mappings. */
-	next =3D find_vma(mm, oldbrk);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
+	brkvma =3D mas_prev(&mas, mm->start_brk);
+	if (brkvma) {
+		if(brkvma->vm_start >=3D oldbrk)
+			goto out; // Trying to map over another vma.
+
+		if (brkvma->vm_end <=3D min_brk) {
+			brkvma =3D NULL;
+			mas_reset(&mas);
+		}
+	}
+
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
+	if (do_brk_flags(&mas, &brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
+
 	mm->brk =3D brk;
=20
 success:
@@ -281,7 +305,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		mmap_write_unlock(mm);
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate)
-		mm_populate(oldbrk, newbrk - oldbrk);
+		mm_populate_vma(brkvma, oldbrk, newbrk);
 	return brk;
=20
 out:
@@ -372,16 +396,16 @@ static void validate_mm(struct mm_struct *mm)
 	validate_mm_mt(mm);
=20
 	while (vma) {
+#ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma =3D vma->anon_vma;
 		struct anon_vma_chain *avc;
-
 		if (anon_vma) {
 			anon_vma_lock_read(anon_vma);
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				anon_vma_interval_tree_verify(avc);
 			anon_vma_unlock_read(anon_vma);
 		}
-
+#endif
 		highest_address =3D vm_end_gap(vma);
 		vma =3D vma->vm_next;
 		i++;
@@ -2024,13 +2048,16 @@ EXPORT_SYMBOL(get_unmapped_area);
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	/* Check the cache first. */
 	vma =3D vmacache_find(mm, addr);
 	if (likely(vma))
 		return vma;
=20
-	vma =3D mt_find(&mm->mm_mt, &addr, ULONG_MAX);
+	rcu_read_lock();
+	vma =3D mas_find(&mas, -1);
+	rcu_read_unlock();
 	if (vma)
 		vmacache_update(addr, vma);
=20
@@ -2514,7 +2541,6 @@ static inline void unlock_range(struct vm_area_struct=
 *start, unsigned long limi
 			mm->locked_vm -=3D vma_pages(tmp);
 			munlock_vma_pages_all(tmp);
 		}
-
 		tmp =3D tmp->vm_next;
 	}
 }
@@ -2749,16 +2775,105 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, s=
tart, unsigned long, size,
 }
=20
 /*
- *  this is really a simplified "do_mmap".  it only handles
- *  anonymous maps.  eventually we may be able to do some
- *  brk-specific accounting here.
+ * bkr_munmap() - Unmap a parital vma.
+ * @mas: The maple tree state.
+ * @vma: The vma to be modified
+ * @newbrk: the start of the address to unmap
+ * @oldbrk: The end of the address to unmap
+ * @uf: The userfaultfd list_head
+ *
+ * Returns: 0 on success.
+ * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
+ * possible.
+ */
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf)
+{
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct vm_area_struct unmap;
+	unsigned long unmap_pages;
+	int ret =3D 1;
+
+	arch_unmap(mm, newbrk, oldbrk);
+
+	if (likely(vma->vm_start >=3D newbrk)) { // remove entire mapping(s)
+		mas_set(mas, newbrk);
+		if (vma->vm_start !=3D newbrk)
+			mas_reset(mas); // cause a re-walk for the first overlap.
+		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		goto munmap_full_vma;
+	}
+
+	vma_init(&unmap, mm);
+	unmap.vm_start =3D newbrk;
+	unmap.vm_end =3D oldbrk;
+	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
+	if (ret)
+		return ret;
+	ret =3D 1;
+
+	// Change the oldbrk of vma to the newbrk of the munmap area
+	vma_adjust_trans_huge(vma, vma->vm_start, newbrk, 0);
+	if (vma->anon_vma) {
+		anon_vma_lock_write(vma->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
+
+	vma->vm_end =3D newbrk;
+	if (vma_mas_remove(&unmap, mas))
+		goto mas_store_fail;
+
+	vmacache_invalidate(vma->vm_mm);
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+
+	unmap_pages =3D vma_pages(&unmap);
+	if (unmap.vm_flags & VM_LOCKED) {
+		mm->locked_vm -=3D unmap_pages;
+		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
+	}
+
+	mmap_write_downgrade(mm);
+	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	/* Statistics */
+	vm_stat_account(mm, unmap.vm_flags, -unmap_pages);
+	if (unmap.vm_flags & VM_ACCOUNT)
+		vm_unacct_memory(unmap_pages);
+
+munmap_full_vma:
+	validate_mm_mt(mm);
+	return ret;
+
+mas_store_fail:
+	vma->vm_end =3D oldbrk;
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+	return -ENOMEM;
+}
+
+/*
+ * do_brk_flags() - Increase the brk vma if the flags match.
+ * @mas: The maple tree state.
+ * @addr: The start address
+ * @len: The length of the increase
+ * @vma: The vma,
+ * @flags: The VMA Flags
+ *
+ * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the =
flags
+ * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
+ * do some brk-specific accounting here.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len,
-			unsigned long flags, struct list_head *uf)
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkv=
ma,
+			unsigned long addr, unsigned long len,
+			unsigned long flags)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev;
-	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
+	struct vm_area_struct *prev =3D NULL, *vma;
 	int error;
 	unsigned long mapped_addr;
 	validate_mm_mt(mm);
@@ -2776,11 +2891,7 @@ static int do_brk_flags(unsigned long addr, unsigned=
 long len,
 	if (error)
 		return error;
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
-		return -ENOMEM;
-
-	/* Check against address space limits *after* clearing old maps... */
+	/* Check against address space limits by the changed size */
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
@@ -2790,28 +2901,59 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	/* Can we just expand an old private anonymous mapping? */
-	vma =3D vma_merge(mm, prev, addr, addr + len, flags,
-			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX);
-	if (vma)
-		goto out;
+	mas->last =3D addr + len - 1;
+	if (*brkvma) {
+		vma =3D *brkvma;
+		/* Expand the existing vma if possible; almost never a singular
+		 * list, so this will almost always fail. */
=20
-	/*
-	 * create a vma struct for an anonymous mapping
-	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		vm_unacct_memory(len >> PAGE_SHIFT);
-		return -ENOMEM;
+		if ((!vma->anon_vma ||
+		     list_is_singular(&vma->anon_vma_chain)) &&
+		     ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)){
+			mas->index =3D vma->vm_start;
+
+			vma_adjust_trans_huge(vma, addr, addr + len, 0);
+			if (vma->anon_vma) {
+				anon_vma_lock_write(vma->anon_vma);
+				anon_vma_interval_tree_pre_update_vma(vma);
+			}
+			vma->vm_end =3D addr + len;
+			vma->vm_flags |=3D VM_SOFTDIRTY;
+			if (mas_store_gfp(mas, vma, GFP_KERNEL))
+				goto mas_mod_fail;
+
+			if (vma->anon_vma) {
+				anon_vma_interval_tree_post_update_vma(vma);
+				anon_vma_unlock_write(vma->anon_vma);
+			}
+			khugepaged_enter_vma_merge(vma, flags);
+			goto out;
+		}
+		prev =3D vma;
 	}
+	mas->index =3D addr;
+	mas_walk(mas);
+
+	/* create a vma struct for an anonymous mapping */
+	vma =3D vm_area_alloc(mm);
+	if (!vma)
+		goto vma_alloc_fail;
=20
 	vma_set_anonymous(vma);
 	vma->vm_start =3D addr;
 	vma->vm_end =3D addr + len;
-	vma->vm_pgoff =3D pgoff;
+	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	vma_link(mm, vma, prev);
+	if (vma_mas_store(vma, mas))
+		goto mas_store_fail;
+
+	if (!prev)
+		prev =3D mas_prev(mas, 0);
+
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
+	*brkvma =3D vma;
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -2821,15 +2963,31 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	vma->vm_flags |=3D VM_SOFTDIRTY;
 	validate_mm_mt(mm);
 	return 0;
+
+mas_store_fail:
+	vm_area_free(vma);
+vma_alloc_fail:
+	vm_unacct_memory(len >> PAGE_SHIFT);
+	return -ENOMEM;
+
+mas_mod_fail:
+	vma->vm_end =3D addr;
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+	return -ENOMEM;
+
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long len;
 	int ret;
 	bool populate;
-	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	len =3D PAGE_ALIGN(request);
 	if (len < request)
@@ -2840,10 +2998,11 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D do_brk_flags(addr, len, flags, &uf);
+	// This vma left intentionally blank.
+	mas_walk(&mas);
+	ret =3D do_brk_flags(&mas, &vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
-	userfaultfd_unmap_complete(mm, &uf);
 	if (populate && !ret)
 		mm_populate(addr, len);
 	return ret;
--=20
2.30.2
