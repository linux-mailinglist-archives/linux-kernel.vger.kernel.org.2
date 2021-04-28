Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA48D36DC30
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240188AbhD1Pnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:43:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3028 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240476AbhD1Phz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:55 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFOcnX011645;
        Wed, 28 Apr 2021 15:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=I2EeMHgYmLA3BpQoIzZpqgFqzgDwMcZwGDn7ZD8/JkI=;
 b=Ba/mLa2XMJb8ZcOBvbKL+Z10089tPNhizNZQq2fA8F6E2WL9f23zLxPhkV18uaFXGwdO
 EaVdEATrwLWLAFFbgz1BMcFOvLmIAsBmtDd0nUAjpeHjyaSqM73K7QQ23M3ZqJ381rJ2
 tg+GlQeepGZCfRRCAJ3j2YUB/M5gMdK7faMRBRpuUBFbQdFnMg/d/QY/02fR1NjT991c
 HLp1BsPpnXfcz0/UAWEdJzvCDgti+/Z/zosUTDrlVWYoDpUY2uj5Qm6kA51Fjh7sEjQF
 lYfkJqB5A2j/yg2GLi5Lr7+6binMM/Y4U3pcXHO2la7yLSyRzdLNRK8oMTOEEjBvmytE hg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38789105yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:53 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaAxB018431;
        Wed, 28 Apr 2021 15:36:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3030.oracle.com with ESMTP id 3874d2759n-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kA/UCJGd8FaXVlEI4fT1gzMMzc/JIVT8e/6xB1RL3bqukzZtrj0edaQBNTJjWC++3MghTKCKjWgTvts1TnE/VL+wbm1SXhn8u2BS3WipCjT+pLUXbBjjJqzV4beLPP4FF2raJ0TwwanwtSjrD3ZDBbOi+Ar/PCAhTmbMWhsBBGX3JEJpWeiCrS+64QQGWWfRXWy7QCh+P9FyWKlZug3v8qztiOfgRFkxwRSg0P5ALyBbDO3kXgtdgS5mO/23cIUvUxd7Q8HRgGYV2BVwKd8hFLbbrZ5udbqNMhsPbrn1cgTgNC76q9DDJ3t3fG8Lb0V8pU+Fj8ZiIFqlEPRbFRBx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2EeMHgYmLA3BpQoIzZpqgFqzgDwMcZwGDn7ZD8/JkI=;
 b=I6acDGLA7WfdHMRFTI9vM5LhN4IN0PxUshyWlOb0ve7/1c8iuvMS57yr95bL2FaVpGLLoYdHOOeAU9DDXnkq3Ecd44wlaOK3u92QXceyfGa0UZsJaEfl43Rb7KjJ7pDp0H40vSnaQ+3ya+hu6OKj37iPtCpML9tB0yFya1DwRcb+jHri7WQWfj0MOEAS2apzhHsckUfCfveiVwE24slhaNiWRoEIjT05vOSheCCBuaZlb7rMtRI6+uXAuWTyX1VxeBaind5opM9nAxyrvQF+obMwJdauzGgBJAwkUZdPOBogaM/0rS2+f1+oIIuwveg/aU3c6bXn/BnFvYw6XVPpGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2EeMHgYmLA3BpQoIzZpqgFqzgDwMcZwGDn7ZD8/JkI=;
 b=toYP8NN2HFAjeeMyWWuU3k3sqLKfvxjgawbIkJ+R2dumT6pFzeyVLe0qRdS8sIwfKFJ1dpKpScRyGsPfQXyRLrXY1nXelKBS6hSIK+xlCTkIdOQwYuBZ9RnZZUa5Z8JgxgpVSo8SkjT1drEx3akMvdkVATuJS5ER4t7V4pOFvL8=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1743.namprd10.prod.outlook.com (2603:10b6:301:7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:36:48 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:48 +0000
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
Subject: [PATCH 58/94] arch/x86: Use maple tree iterators for vdso/vma
Thread-Topic: [PATCH 58/94] arch/x86: Use maple tree iterators for vdso/vma
Thread-Index: AQHXPEQ6vZzbkb6BrU2OY1jyGYUJSw==
Date:   Wed, 28 Apr 2021 15:36:17 +0000
Message-ID: <20210428153542.2814175-59-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 83da907c-a68d-44d9-4887-08d90a5b6fce
x-ms-traffictypediagnostic: MWHPR10MB1743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB17439CCF4D62B94E7D2CC813FD409@MWHPR10MB1743.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4PRI+RoRELJl54pIpUuPx4G8ki+miyK1j1pX51awGISosFKOsllUlp8K1a69JCtT2t2NHrZxEnVSh5zs2f50SdpfThvQ05soopFLggbVbM5xbtyr+FHR9T3ZPYftK5BBaZXypx2DoXVWq6LFXeo/Y0EM1CZtU/jKzK8xsMe7a1gXfKt3IjqtV8t452aWV5fZSbOXvMrH/3vvmoIHuNgdRENSnatpXj4CBZFSI9b/XrIOZvU9qWGtCcbMHu57Y/8/AxWLDW+yT5zUGY1f2cH8oG/joF748oAGeBUu5BcUXNEQpGIAuoHcXIYyou54mE7sIIbOYwCiSx++XbZgXnq6UAid17mupjcX6DLMRRvMYhJFnuE0cJiK9nl8335WdWTYEbjxb6z2kR+Du6M2RuW4/6ECYovUfVbR6TEZNE0LDVQOvdxW7gbeDm00mZFTFUl2MMSkvfENoa1gEoFjSlGGNWf4ncyIxRaft8KuM0lyNBiaeoR8be6UkjiKA1bxjJEWtLHG6GSk49ADh5WGjRM64QQkYnzHG0vz+M+oX4hBOgaQuwi0H8MYYmM0dW8X9/LG2rLIlMlSIlhEsBOoC49gIESSjkjSuECrBYdtgIBc5p8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(136003)(346002)(110136005)(91956017)(316002)(1076003)(64756008)(66946007)(76116006)(44832011)(5660300002)(66476007)(66446008)(8936002)(6486002)(8676002)(83380400001)(54906003)(2616005)(66556008)(2906002)(122000001)(38100700002)(6666004)(478600001)(36756003)(7416002)(86362001)(6506007)(26005)(4326008)(186003)(6512007)(71200400001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?vmyJqT18wJau2sdGNg5ytYAss2yThMO1M7kxqY19QjCkoO5iHMkxGFJSqe?=
 =?iso-8859-1?Q?20+5xnh/k50Xg6eqKDoj/0Xm7DbnhwaXLNmHpMZFW165GZrqFGyXjzqsCV?=
 =?iso-8859-1?Q?AUCqkchB13HV4xrWPvLSPcAopky43Jk/q+vQIsbHJlZLhezw7uVH8jkqIh?=
 =?iso-8859-1?Q?dkZ1TCQbAtl0I6OfwtZHHaz+UjYUOB2HMl/ffr5CDbS/cKMcgKbpMypwgL?=
 =?iso-8859-1?Q?0sMFdr/fFylUWZQSPHTPUI3bvVDWzqz2ifWvKkfTA1TcsfqkhgJ61ZtsUE?=
 =?iso-8859-1?Q?3XIokeQAMqNZNKWhhhyprZJtPHexoZciOxrDkWiSLuhY7A1rqZuILCt8DB?=
 =?iso-8859-1?Q?BW0SvisgXufqjuRC87GBwfCvEl7teU5UcKJVODBOV/aOlCE2az3AP83KME?=
 =?iso-8859-1?Q?IINMQGmsRmmMsXdiLniZ8euiiYdGD+1s6+/tiz8tVkpw9quq1FMUCYBk+E?=
 =?iso-8859-1?Q?6k9UOt7ew5sGdfZCIWZiy1zv2OAGilpfJVdP5PNGjfrBW3C7i0vJZTpjf+?=
 =?iso-8859-1?Q?VaNxUMW6f5aTUaNmHIdKHEjS5yCuBOdkdjg7fDgb4x40B7mn8GDyVcN+Gu?=
 =?iso-8859-1?Q?6ITTG/oVaURIXSnT6fuojKbOwzk43w7DiQxa3s/7YpE/woHxtTp+Pdw+V0?=
 =?iso-8859-1?Q?Pou83T6lAz9W4GowQ4X9nUOQFIW5B2R8q4OAjf69mOoLVJV5jQbZIuIB04?=
 =?iso-8859-1?Q?BRlQ4gpDcTe/x2ILJ8zbapkz7LsmPLwbYRnvRP3FXETMkhaleorrp1UbXU?=
 =?iso-8859-1?Q?va+m0mOf9V0F2aG4vc0RsJJKPsdDVHzXGugaXpDKDu47gL6rIALdJAnGqa?=
 =?iso-8859-1?Q?kfves34/JOSG10Shf+oLFOHmm7oXdIWEVyEvG9gH7jU3sQcWpXAeEB84AC?=
 =?iso-8859-1?Q?JpgmRDmu2jEcMIWzTv0DeiIt9UeIpTV1wsP0Ua7XOzXtolFZWmDZqL/K/U?=
 =?iso-8859-1?Q?JeKCrmI0kKv8uf4QOI9d5brEC9lJwDGFkuuMeiF3OqCTpcW+m+3bWjBBSk?=
 =?iso-8859-1?Q?dX/kQnoU9tNKZGhD9+JsrtME1gwEJ1zLpzYp0hiIApBgoE2Vq6d4Zle8I3?=
 =?iso-8859-1?Q?hwZAjR0jIiLJjzGkQv4mgEdKXBBQgyTBzZZPdB/S9bqDBeIQ46ohUSP8Px?=
 =?iso-8859-1?Q?xYtsk+E2frxr409WRENQ/f5napXAcxbunDBL11bWCsgekrSoPXeSJZSlSN?=
 =?iso-8859-1?Q?zcbl1MU3Q87GPTo3Lf4jIV8cfe+HJ9y81iU9eF1W1JupbTGgQJTqnbgFVH?=
 =?iso-8859-1?Q?iDaCGpJP5GMcVeABMFOZrSWL8O5OqwTOJq3z9SWtEeguj+zQoR6c3zniYX?=
 =?iso-8859-1?Q?QL3cjpGy2dvymFbLOZH/iFGxy/ppTIouDaqkA6Wk/sFZDu068XiHID5f+W?=
 =?iso-8859-1?Q?M+1sGyvNOP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83da907c-a68d-44d9-4887-08d90a5b6fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:17.0456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZJoeYzNg0L3isuRo46j4VmBQgbqAI+hJ+WTJDs8kRWNefpb13xGcMVr5l7DqLOldiIOiwxjNHKcNFjn/Jqz1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1743
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: -lJUVys5TGh7btQxXQ3yY1PyCBZWMfVX
X-Proofpoint-ORIG-GUID: -lJUVys5TGh7btQxXQ3yY1PyCBZWMfVX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
