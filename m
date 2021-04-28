Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C19C36DBF7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240939AbhD1PkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:40:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58234 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240424AbhD1Phr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:47 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNedE010520;
        Wed, 28 Apr 2021 15:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BtpBkR5uxdx5o6HBObDxAGV6g/Ifwm11w7iLnJZ/Imw=;
 b=jmHV2xf4G/4othJQVh3y2tLx2jqjWmOH/odPxdyfvhvEXMACnGfMfLJLtx4iZxAAjvg7
 Wk+omBx7Fuedc4f61xD2Djmt928/UCnGPzRlcGbi/QDinEK/JeGaEM3EIMMab31lxQYB
 6100T/mvW/wNHDUk3jo7nia9mtt1iNoTRQ7vlRoPnDuwbwGUylJEV5On0jpF6C+lV7Jn
 2uvVoJGPMlvQ37FXFEcjCDqQEp5RTT71GXyBIzzpr+TPrNgPjm+NxLZYOMDMMFMlNRul
 beJc/P5N6SwcCXTKs20UxjvJh3+oTBte5u/2BJeLbXgYhF2xQble9WnGbSA/uqQgQH1v Kw== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38789105yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:45 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaASu030176;
        Wed, 28 Apr 2021 15:36:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 384w3uuag3-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acpIHWM9whfR7wJ/OwZ7nh1BWhP2mUStmRapZukyqcxAMgzCni5MWB2M6qILsBgLGtj0CAimxAPsZhmY1fnjUG42LE13jdf/VjoJPMnu0RuJALjrMXU09BXVhnWrEzPmjlEfKkFoPmsSb4fLlec1/fp4fK2rxfgGxQZN7ZzIBVXBiP1MPICqXOmCespA51CoSdbpLCK0BQSHo9edy8vPv2YUVWdXFEkOYPIgBhgQOutQLyxHhhxWcvExU41M48L0phMbeP0pvCN+cqbAcyO4IWmNU32yy0oDNXgcRzfrPM4EJVL4H9uTAyUB3oYRh+NbOdpDuBcyhjaKI0iw2d9nMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtpBkR5uxdx5o6HBObDxAGV6g/Ifwm11w7iLnJZ/Imw=;
 b=O5QgLslHrFh5KAJWCdr8VS5zg3Zw3wBym9Py4Wnx79fjuKFovblzIvYCtFr/QH9bfneplGdeyyR9a4u5R/9vr3LmR8ieSgJI4fhixmrOWxQl2PnzGbA6OTZajT1glWBgNlGfeIvQmDyUWX5e/m+6UR2gXN9LnyxgEmliOwnOxZodNDW1hsiW8Pf/iD/TY0zeQ53OYUQAapuEkkRt1MPAw2JmAzvpzl8nO1uFEf8kfEKWjtQH2tn19ylltenTMOFfgQjsRF97RZu3F8RVCihxACJYDdhpqR60LsF3PfE1JHyYwjj/xpZ/4XoNlsoT/mvTN8z2Yo4I1+Edm9+5o58/kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtpBkR5uxdx5o6HBObDxAGV6g/Ifwm11w7iLnJZ/Imw=;
 b=eAsH4IhXawhdlHVuRjO2DgrFcrcIZ6n+y8Gbx3lwAJR+MT3y2PKosWlqTQqGpuF0dtiYxdxkaQ/51l2Ha5bfTnxMTLb1vmMLG8QxdHD1jqjCsMuQ4KBlJJaTueT1PCpn/Pre0nTeFDHkk4FNqC2n7yTXw6bEN7Z4f3cLfSiHRCM=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:36:41 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:41 +0000
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
Subject: [PATCH 45/94] mm/mmap: Change __do_munmap() to avoid unnecessary
 lookups.
Thread-Topic: [PATCH 45/94] mm/mmap: Change __do_munmap() to avoid unnecessary
 lookups.
Thread-Index: AQHXPEQ34Qd9Jmg/9Em5pMF/kuAOAw==
Date:   Wed, 28 Apr 2021 15:36:11 +0000
Message-ID: <20210428153542.2814175-46-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: c5efafc7-387d-4647-dd5b-08d90a5b6bfb
x-ms-traffictypediagnostic: CO1PR10MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB45153B89B7E0605CAEB1FF2BFD409@CO1PR10MB4515.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JO0jb4OWGqnD4+TsvDtQhopldpRZ9ZXUNTLL4FHhhmkqDvP8k1JSLqf3Y4X0JI8TKhvQXOYLi0VJ7zYZ/gtayWuWHC1YgcrSXkBip1DuiaqM0z6bjSXxb1iEo0S44JtwqP2iSFy2yXo5RCzQ2UYW5xj8sXX/8wDOZ4/IRoXuecH8/y3sCYYg2zg56YJ7rDV5BXlEZ7Y1a+zNAHs5If1BOUJZ8YvAEk7pOO53MasmD2iil5Svj0/pUcFzixg0GeW/eTsxtFUO/OZgqB5OPKBuxY3nhlma5OPiKr1u3xSgGhSWgYa9NkO9ZXqPuDcsfifMN9/In2AYlJwYrYR+AhhaWZ0cG5hylUUMemQwWO0mye6yTxF3DSVizgas+Vs2gGZwKqy53nAuI1G4YRjYx4rBBgMzwTHpjbwc5qYCixcGGZqlSK/zp0YTIW+EqUvzh295tmjMnTHuSflJjMcltjvAGe97TaAhLmG4zEvmHY1cqwfQ1xvzpXAAPvM0C5EmB1IU53kHteykO1RUxC07Jfstm/bTrTFrUnmBkxrlCnZikYCFPCmZl7AsMVvtqMd7scVgfJ13Ub9VEt7PE8DpLhyIuxo8NeS3FMH0KCT0TY3D1VA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6506007)(4326008)(36756003)(54906003)(71200400001)(26005)(110136005)(6666004)(316002)(8936002)(186003)(44832011)(7416002)(2616005)(8676002)(76116006)(2906002)(91956017)(66556008)(66946007)(478600001)(66446008)(1076003)(107886003)(64756008)(86362001)(5660300002)(66476007)(83380400001)(6486002)(122000001)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?fowec4um8/lxQcfBxg1dS5XZqlj0FgV9PrIxWnW4FRSJkwI1mHn+GvKIXM?=
 =?iso-8859-1?Q?1K0Dc7o46wP2Pp+CoTn5e2Mw9i9b/hcuucQzq0xE7SZidRwFkUokejYJ14?=
 =?iso-8859-1?Q?0cWunSkF1dtscS3eE22cIABk67vs725NSyoM1LCf7mRSjaqZqJFWArZgdO?=
 =?iso-8859-1?Q?N+xGAE5T7TKnph/W7tRLzzOiF8K3wpBUFXxOu7VoMiK4xU/YlSIAyVVmsP?=
 =?iso-8859-1?Q?X5CG1GMB2FGq2C+fliqoiEFg8Ua1HZ/w2IbolamYzG4y8qv/qppjbZIT/6?=
 =?iso-8859-1?Q?Kz0XNXHQIVAfLniGws/m/OlFAcn9RoOaQFJ4WH/LTM4M04B70FyZCdPu/b?=
 =?iso-8859-1?Q?hgRfG4tbjk9y4MgSCo3Iw6oXO5yGrTq1CPsTP4mcO/cN3nlmRPnykdgbXi?=
 =?iso-8859-1?Q?0dwn+DEPThFm32/secjZLz8u8LJbSCwcFP5Nz5rX3VP3iXZdcBAezF2T3e?=
 =?iso-8859-1?Q?S/aV+++M21wY4sSMnP1paq7BHenqlHNOo7zlISqBM1ErG1bkXe2u2PzmE7?=
 =?iso-8859-1?Q?T00U01nSFQq3gGmRi4wvS321vy5k2HbIhPp3diDnlAeESPGKl5BBl6ez6t?=
 =?iso-8859-1?Q?sYxTtPbjC2WwUj6pqd959qc1qkdN2EsuGJ+yFyTQsrjKvAilwRQbMWAcEu?=
 =?iso-8859-1?Q?xDJrNHysQ+nCw24bw+G9xFoO6NmHPBlGJ1a+YUYZYmNpPiqMWCMjJ9FA7T?=
 =?iso-8859-1?Q?HQtPX2nQzGaKE67wKSofVY6hTg066dNjVodyxqET0WOwVwbbkx+vXLAHbN?=
 =?iso-8859-1?Q?rH34TWXpE6ABOlMGH03josw04nZDmYyVud/a0BM8dQDkXeae8BohIyMpjU?=
 =?iso-8859-1?Q?iS7F9xgaD1f6iJsOAXgkULMDP6d/PgSecjHrMEKRVTawUJcW/h3TMCf3hV?=
 =?iso-8859-1?Q?4EcWkuE+hCUgrY2orZlT6X2qkZrMT9eRG+HC9vlTWboDJBAeiaaRMoQLWF?=
 =?iso-8859-1?Q?sblQnLPKY56BAPUrP3kGycwfmHWjtnD2r0ohooNuOQ4if+FnblKLGpNgPd?=
 =?iso-8859-1?Q?3kMkAuKqC9a6XJtrzPzPbpIGcRKx9FtCRCocXaHM33S4ODdER8/fbxVd2R?=
 =?iso-8859-1?Q?Y50YAF4BiRpOK49dkJfiN9nYq7mwzv1xsKGEVj0jNZ99+TSUtm9fAqgerc?=
 =?iso-8859-1?Q?qnDhD7bnulGPgRkEBgcAD7mDo0cYYGjrlqDEAElc9o8UTTdP9WuoYQr77V?=
 =?iso-8859-1?Q?VX8cwG6dTW0YAs5NZbxenBXSty5Pnr2E/ASM+LyB2f9uvUFWfk/4NM6t59?=
 =?iso-8859-1?Q?AEcOYxHnMi8SOmr2VxpvCjIG6WllsZ7GTSQ2tGYpoZeFAj6NsBhPQCGn7G?=
 =?iso-8859-1?Q?CmmniYnqoS1rD+CMhhaExwZMZtrQ+3O2T6gt/ecuWhEN/XBl7X3/mFNJAW?=
 =?iso-8859-1?Q?kkRhcnQ1EK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5efafc7-387d-4647-dd5b-08d90a5b6bfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:11.3881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8Nr2WJKuYy2cCtGKmu17s+GChPeOKis3/8ykVLnfeT+edkH+qeXcqydZcAW7Ze9/B3VNL9yQZ5y+MQMzuCuiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: T3__f4etYOjwgFaLmtnHiXBggtspBvKy
X-Proofpoint-ORIG-GUID: T3__f4etYOjwgFaLmtnHiXBggtspBvKy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As there is no longer a vmacache, find_vma() is more expensive and so
avoid doing them

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 115 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 59 insertions(+), 56 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 10c42a41e023..8ce36776fe43 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2551,44 +2551,6 @@ static void unmap_region(struct mm_struct *mm,
 	tlb_finish_mmu(&tlb);
 }
=20
-/*
- * Create a list of vma's touched by the unmap, removing them from the mm'=
s
- * vma list as we go..
- */
-static bool
-detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vm=
a,
-	struct vm_area_struct *prev, unsigned long end)
-{
-	struct vm_area_struct **insertion_point;
-	struct vm_area_struct *tail_vma =3D NULL;
-
-	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
-	vma->vm_prev =3D NULL;
-	vma_mt_szero(mm, vma->vm_start, end);
-	do {
-		mm->map_count--;
-		tail_vma =3D vma;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
-	*insertion_point =3D vma;
-	if (vma)
-		vma->vm_prev =3D prev;
-	else
-		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
-	tail_vma->vm_next =3D NULL;
-
-	/*
-	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
-	 * VM_GROWSUP VMA. Such VMAs can change their size under
-	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
-	 */
-	if (vma && (vma->vm_flags & VM_GROWSDOWN))
-		return false;
-	if (prev && (prev->vm_flags & VM_GROWSUP))
-		return false;
-	return true;
-}
-
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this wher=
e it
  * has already been checked or doesn't make sense to fail.
@@ -2668,18 +2630,24 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-static inline void unlock_range(struct vm_area_struct *start, unsigned lon=
g limit)
+static inline int unlock_range(struct vm_area_struct *start,
+			       struct vm_area_struct **tail, unsigned long limit)
 {
 	struct mm_struct *mm =3D start->vm_mm;
 	struct vm_area_struct *tmp =3D start;
+	int count =3D 0;
=20
 	while (tmp && tmp->vm_start < limit) {
+		*tail =3D tmp;
+		count++;
 		if (tmp->vm_flags & VM_LOCKED) {
 			mm->locked_vm -=3D vma_pages(tmp);
 			munlock_vma_pages_all(tmp);
 		}
 		tmp =3D tmp->vm_next;
 	}
+
+	return count;
 }
 /* Munmap is split into 2 main parts -- this part which finds
  * what needs doing, and the areas themselves, which do the
@@ -2691,24 +2659,24 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 {
 	unsigned long end;
 	struct vm_area_struct *vma, *prev, *last;
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
 	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
 		return -EINVAL;
=20
-	len =3D PAGE_ALIGN(len);
-	end =3D start + len;
-	if (len =3D=3D 0)
+	end =3D start + PAGE_ALIGN(len);
+	if (end =3D=3D start)
 		return -EINVAL;
=20
 	 /* arch_unmap() might do unmaps itself.  */
 	arch_unmap(mm, start, end);
=20
 	/* Find the first overlapping VMA */
-	vma =3D find_vma_intersection(mm, start, end);
+	vma =3D mas_find(&mas, end - 1);
 	if (!vma)
 		return 0;
=20
-	prev =3D vma->vm_prev;
+	mas.last =3D end - 1;
 	/* we have start < vma->vm_end  */
=20
 	/*
@@ -2732,16 +2700,27 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		if (error)
 			return error;
 		prev =3D vma;
+		vma =3D vma_next(mm, prev);
+		mas.index =3D start;
+		mas_reset(&mas);
+	} else {
+		prev =3D vma->vm_prev;
 	}
=20
+	if (vma->vm_end >=3D end)
+		last =3D vma;
+	else
+		last =3D find_vma_intersection(mm, end - 1, end);
+
 	/* Does it split the last one? */
-	last =3D find_vma(mm, end);
-	if (last && end > last->vm_start) {
+	if (last && end < last->vm_end) {
 		int error =3D __split_vma(mm, last, end, 1);
 		if (error)
 			return error;
+		vma =3D vma_next(mm, prev);
+		mas_reset(&mas);
 	}
-	vma =3D vma_next(mm, prev);
+
=20
 	if (unlikely(uf)) {
 		/*
@@ -2754,22 +2733,46 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * failure that it's not worth optimizing it for.
 		 */
 		int error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+
 		if (error)
 			return error;
 	}
=20
 	/*
-	 * unlock any mlock()ed ranges before detaching vmas
+	 * unlock any mlock()ed ranges before detaching vmas, count the number
+	 * of VMAs to be dropped, and return the tail entry of the affected
+	 * area.
 	 */
-	if (mm->locked_vm)
-		unlock_range(vma, end);
+	mm->map_count -=3D unlock_range(vma, &last, end);
+	/* Drop removed area from the tree */
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+
+	/* Detach vmas from the MM linked list */
+	vma->vm_prev =3D NULL;
+	if (prev)
+		prev->vm_next =3D last->vm_next;
+	else
+		mm->mmap =3D last->vm_next;
=20
-	/* Detach vmas from the MM linked list and remove from the mm tree*/
-	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
-		downgrade =3D false;
+	if (last->vm_next) {
+		last->vm_next->vm_prev =3D prev;
+		last->vm_next =3D NULL;
+	} else
+		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
=20
-	if (downgrade)
-		mmap_write_downgrade(mm);
+	/*
+	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
+	 * VM_GROWSUP VMA. Such VMAs can change their size under
+	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
+	 */
+	if (downgrade) {
+		if (last && (last->vm_flags & VM_GROWSDOWN))
+			downgrade =3D false;
+		else if (prev && (prev->vm_flags & VM_GROWSUP))
+			downgrade =3D false;
+		else
+			mmap_write_downgrade(mm);
+	}
=20
 	unmap_region(mm, vma, prev, start, end);
=20
@@ -3182,7 +3185,7 @@ void exit_mmap(struct mm_struct *mm)
 	}
=20
 	if (mm->locked_vm)
-		unlock_range(mm->mmap, ULONG_MAX);
+		unlock_range(mm->mmap, &vma, ULONG_MAX);
=20
 	arch_exit_mmap(mm);
=20
--=20
2.30.2
