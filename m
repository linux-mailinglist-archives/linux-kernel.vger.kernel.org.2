Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785863797FE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 21:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhEJTvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 15:51:55 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35094 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbhEJTvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 15:51:53 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AJoRwi026339;
        Mon, 10 May 2021 19:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2020-01-29;
 bh=Qm7yhKrZR/lh8/4wkNIMctiX4O8BBk5lMoIv0CgSXc8=;
 b=Q/rdM3LmiB2TmIlrozxCuwVa7YUfXq4dBv+Ej3G1/OFgkdKMZX23FlnEl4dXS/Q8V1e0
 wW4kZAzCtZNfdJVKGHJxCA0JcCRv1APclDwRQPt/hbYOQaqfiOQpjFugtpOIbLvKrq7x
 IH2b90pKEdLVVEEbAo5pq6jc4np83jm8ht4qSmNCC7/eG06ItXCvQ8OjX8uP//qHlCsF
 spRzNheNXM+FYjRNT1K6bIOw/zDFKpmciZcTnb9ElxbbRNTSBslcgUaypAQDBu7uHNL5
 X0W6S7EqueRc3vfaiBN1hNRVGPwheIHVaLLrWP6vwMV07DW6Z/YkQeGlk9wnd9n80uTu 1Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38dg5bcksw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 19:50:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AJjY6K061142;
        Mon, 10 May 2021 19:50:26 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3030.oracle.com with ESMTP id 38dfrw0xtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 19:50:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YI5EzI9/54F6mdUrR+7YOZKN0CRBPZ7WggR6fdyHJwK1wukVrB4wip+1vHQopegudTAPNzN8qGi5quCjIsGVc8EkqPd4iso3kIMNvrvAXl6rNdKtJyjxH1xEhmUhweNosYwPr6VxQsPf+xBCTfZqB5am/XHNTT15gLZh/m19V/TPHtre+OSgWggeKUqTn6V+y/6WPlQ89Jh5yrG0N8SMMr1bHC7mL3Dv7MJgV05qv28XuSZsh+reUnmggXNrvY4wrbHsRV18LDiBqGvEeZNjzqkZv5ko8f8wAuQyo4MmnmNYC1GNjaeWTaCOUI14HhcoHcRt93L+nMUBLF8iLsmv3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm7yhKrZR/lh8/4wkNIMctiX4O8BBk5lMoIv0CgSXc8=;
 b=XLepP7E2xPB61TIell2A2cZzOsDlNRayz1eeqAvrc9dvXKd+ZyrhR6gVfKcRhu/sWoQXlf4tIo2sJ/h40SOXdAcomA9Ae8UBCkqQkf855PZkSFo5yrBCtoPBRVPaPtC0uDdQkHEsPwHjuNHwz1RLwlcrKt/T9quqxrg4FzJ4DpbRc6HrMVZa+o7XehLVL2+q1H5aHP8V3pwOnkY0spQi+yuhZMyjQigAvDl5gUdso0tOGRbHStgJscGUPUxdauDNSF/bBI1+ISWr6vsrCnF0FeNx0ePXY7gUWoT3aUZvLJSyjY05+aLiVSkzdW6P5EncCyVROJsU97XFPzDAnFsNpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qm7yhKrZR/lh8/4wkNIMctiX4O8BBk5lMoIv0CgSXc8=;
 b=g8oo2WBDqku+kB1+PyfG1yiYPGvn0HczGjsBtKpSX9xo54ieR+2ZmCOapZ1+rFFqLE9JUmr9dDsiVN0rkcnS8cNh0dCkou2Db6EjdUdWdCbXdtvGbXvf39Td3fao99Hyk2CZQIlsyQLfRiRQdL+lHClPhc03P01UOMXLq+6MqOU=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1309.namprd10.prod.outlook.com (2603:10b6:300:1e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Mon, 10 May
 2021 19:50:23 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 19:50:23 +0000
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
        Michel Lespinasse <michel@lespinasse.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH] mm/mmap: Introduce unlock_range() for code cleanup
Thread-Topic: [PATCH] mm/mmap: Introduce unlock_range() for code cleanup
Thread-Index: AQHXRdW2cmhwkET57kappKEjcFfu8g==
Date:   Mon, 10 May 2021 19:50:22 +0000
Message-ID: <20210510195020.2778501-1-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 217b6cf1-a7c1-4cb3-ba09-08d913ecd96b
x-ms-traffictypediagnostic: MWHPR10MB1309:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1309A0271D616CB5546EDB01FD549@MWHPR10MB1309.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D8Phrx7sLBaoOSvnx1BplK8udgmY1+Er8ash2hpkUgGEPjyrkKnC3Mn+stbTE1fgpFRQZySsvmSWCfXf9kOVR9hDOXREgF+Unl0usvPzgpFr3fF5TFL8D1cKN2YS00NZt3dejek+efIc6iSXRIJk1FjQl/2cRgt0rDt9AWw1Ph9UIk7NkivFXjM4QRg3E4+vo5sckeJDvD6CF40Urxwg6dK/bDdpUSkhhlcNgN2UQShIvjTuGK0Qzod1aAp8fxqmtWftWEGQC6UFvbMZD1GRh7ityS7GPnHd/jY+R7sHnOjNA05agvFR/wR0aW27luA1lCSDf4nYQo5lMDmXzbPYbbIUFQoZuudmm5Q72QMX3e0odrRjeU2+E0An/NbpUkRv2y9qsOUjB+Hmxq5Qhf9cub76uxcsRBcFJvmTL8A8pbOFuQccjuRYkv6QP42vkrpAOJctuVAPocQg2s+VSQq5Wr8KeadL2Q42A3wVLAEaspnwhhr12OOn+litlnof+o8WK/Y5oOOe8ZCwrygxKyi3dqhN4R4McvfXYUycNY+sB0HYZVaS89RoKRkTKnZnJGH+90hAPkFVqTFwh76iiFnsTzJ+ZZGRu9zb5PUjAKY5xss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(39860400002)(136003)(376002)(396003)(71200400001)(36756003)(8676002)(1076003)(110136005)(54906003)(316002)(66946007)(478600001)(6512007)(107886003)(76116006)(91956017)(66446008)(186003)(44832011)(86362001)(7416002)(38100700002)(66556008)(64756008)(5660300002)(8936002)(66476007)(4326008)(6486002)(2616005)(6506007)(2906002)(26005)(83380400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?XktRdlYG5bDWh5eYJ0wr8hBwigb8+PmqexqKCM7OFOLLhpbj/TXjPbs8rZ?=
 =?iso-8859-1?Q?sv1CPnvQ6srHHcAwwvGpoN/w4hexhHuQTB+pEh3fwkSJvwvpFFb32igkn9?=
 =?iso-8859-1?Q?tjOK+ZW+Rq5Bgl61NlxlenQ/fZhCykwFGYYJJQUtnV6j2cDPkdwUPVEyMl?=
 =?iso-8859-1?Q?ZgVsQt+PU9YN/beIgfGQASdj1G3aW90qglpLbD34KJ/e45lTOyaRRlLLLb?=
 =?iso-8859-1?Q?TiWBoJN2XFhnwuiCmJkOYFnCFSO1GL4GZU3cBw3S3MjkcXGqkJxdw2pF1u?=
 =?iso-8859-1?Q?8Cf3Pafho57Z3n3iQzhChSXQ2kXfBGhL1I+c3Srv8+6H+8zy42xitG+hBs?=
 =?iso-8859-1?Q?8WYnM09pAEYjuQUf8xwjYx3vF5pJlPzVovAwmBGuuBS/F0uczby+2Ja0uS?=
 =?iso-8859-1?Q?4xxIXzCUQv7Bm2jvY8/K1VDNO9aZqaNewuichQVbiKzavEwduMCS2EOIDh?=
 =?iso-8859-1?Q?uDgWOpm1PQBb2LLsJVWDdX/8VAYHnsnb8DS4BzvkO2CfeZ3LK2gZHQ3pqc?=
 =?iso-8859-1?Q?TaNIhxsAvkWp1ju64YTngZUCEIvD6FATbnDkdw9Gy6kp7mJq6qIy4DTKB5?=
 =?iso-8859-1?Q?qOQ76Kw07n476voG772Ho+HRuDlVAQvojBZw4QKxCow6UmtsnG6X1OTu0b?=
 =?iso-8859-1?Q?bui1o7x4uQvH3r85pt4epg8IfkSurdrR4mds/H2iaDSD8ADP1dPJFTJhQ8?=
 =?iso-8859-1?Q?wCATOoDOTkgXQBEx4btD6Xvm8viOCquYXrbfLeTys1RUrpIAabPirY57Nq?=
 =?iso-8859-1?Q?n1qpa+W3vg38RNBYkn0c9g5pBYWqYJDsPAB4d74w2Oh3/XtPnmKz34h/Cf?=
 =?iso-8859-1?Q?qklact72lHEQfvR4BKaw6h5Ucq9pThvNwo7wqZ8uVHlfuSOO8G4mRxdlKi?=
 =?iso-8859-1?Q?lZqMXGVaH2AzzuFanfEJspeeadey0dYUb12xTG01sSJbKe+NyF2wZRPzvd?=
 =?iso-8859-1?Q?1alNMIFZ4W8cXFJVWyS4FBX+S2mv+78k5MXuQ/SzD7tWSKqFH5AvbdULjs?=
 =?iso-8859-1?Q?glN8lE+igm1COoVQjBBHjLQBuHAboS11N/MKGutiNlBSawhJXKa5cL2SRV?=
 =?iso-8859-1?Q?ic91YonToOiFzathjJ7DuCTjOxuZYwVaBZ9UimIHZLTVdZ4ZCcSTdkBcB2?=
 =?iso-8859-1?Q?uPcRdj2VCK3FRbJaRs65eFma8LuOcuoxqizbTaAcZyXDYpER1WBLrZnB+U?=
 =?iso-8859-1?Q?z8ukez11n2BmBu3Ep+AIJwU6yv5DS53iixR/PAUcRDOsEGXknevoRbT3/j?=
 =?iso-8859-1?Q?ehuDp4sl7UnUAJ42LCdPuytY7q7LtZygz92i1+Y/jgVDCPTlMGC+1L8jNd?=
 =?iso-8859-1?Q?fneD8JwM2mgcrdUbCVhUALZe2Y08SKtp2m0qrWV8kVr/ELSDe9Yf4cYkvC?=
 =?iso-8859-1?Q?4Fuow5a6BS?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 217b6cf1-a7c1-4cb3-ba09-08d913ecd96b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 19:50:22.9471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vtsVljLGNSt/Hbz3TP7I2cp+8h8PV9qGpZr8SnV7oT7fiT6v/eRhvlYlus6eOS8FGmM16dLhhQ73O0as1gAopQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1309
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100133
X-Proofpoint-GUID: 4T0L41I0sj8UP18ZpD99w02YbF3LYuvz
X-Proofpoint-ORIG-GUID: 4T0L41I0sj8UP18ZpD99w02YbF3LYuvz
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both __do_munmap() and exit_mmap() unlock a range of VMAs using almost
identical code blocks.  Replace both blocks by a static inline function.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 81f5595a8490..ea556fc795d2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2801,6 +2801,21 @@ int split_vma(struct mm_struct *mm, struct vm_area_s=
truct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
+static inline void unlock_range(struct vm_area_struct *start, unsigned lon=
g limit)
+{
+	struct mm_struct *mm =3D start->vm_mm;
+	struct vm_area_struct *tmp =3D start;
+
+	while (tmp && tmp->vm_start < limit) {
+		if (tmp->vm_flags & VM_LOCKED) {
+			mm->locked_vm -=3D vma_pages(tmp);
+			munlock_vma_pages_all(tmp);
+		}
+
+		tmp =3D tmp->vm_next;
+	}
+}
+
 /* Munmap is split into 2 main parts -- this part which finds
  * what needs doing, and the areas themselves, which do the
  * work.  This now handles partial unmappings.
@@ -2889,17 +2904,8 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	/*
 	 * unlock any mlock()ed ranges before detaching vmas
 	 */
-	if (mm->locked_vm) {
-		struct vm_area_struct *tmp =3D vma;
-		while (tmp && tmp->vm_start < end) {
-			if (tmp->vm_flags & VM_LOCKED) {
-				mm->locked_vm -=3D vma_pages(tmp);
-				munlock_vma_pages_all(tmp);
-			}
-
-			tmp =3D tmp->vm_next;
-		}
-	}
+	if (mm->locked_vm)
+		unlock_range(vma, end);
=20
 	/* Detach vmas from rbtree */
 	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
@@ -3184,14 +3190,8 @@ void exit_mmap(struct mm_struct *mm)
 		mmap_write_unlock(mm);
 	}
=20
-	if (mm->locked_vm) {
-		vma =3D mm->mmap;
-		while (vma) {
-			if (vma->vm_flags & VM_LOCKED)
-				munlock_vma_pages_all(vma);
-			vma =3D vma->vm_next;
-		}
-	}
+	if (mm->locked_vm)
+		unlock_range(mm->mmap, ULONG_MAX);
=20
 	arch_exit_mmap(mm);
=20
--=20
2.30.2
