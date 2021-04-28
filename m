Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5CA36DC3C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbhD1PpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:45:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62324 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240782AbhD1PjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:39:09 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFPXv7015928;
        Wed, 28 Apr 2021 15:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Spjr9k9WUILics98eX5mRBwOuyi9M2nXlILbaXG30no=;
 b=LC5vmRmg5I8paILeV5Dte0cbldKFtKisrLFuQAwB6bfMgLAPQJSDANbLIKrVXIwAbYQQ
 p/Rdw1aKXzeupAw/KP+ExwN1CQILs0MHGx31kaa0GSeIdycl/AE4HTptYXGJkSQ04x/I
 e6JnFSHcgRhE3CEiUjLqGSogEeL2ZJGMnzm26pMQL4glo/ePqif+nak2yTX24bM8a/td
 5D0f+GqnoQ4M6xeWfFdIjefcfubp/eIzboLjkGq8kgAu3SkoFqw07SuGXyJIpMMjnZhK
 N9nokjI1Jd6NrsEE+mlnSkkHuTmwzQxwRTnBFuqUk9BLoSA786l4wi6zZQnhww7/7tHx 1g== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:38:06 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFc2RR027246;
        Wed, 28 Apr 2021 15:38:06 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3030.oracle.com with ESMTP id 3874d2773f-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:38:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8qSjbV5JrPoPdgQZ4YkMmpXIAwEzddBI2kkLZGKqFaREaaKYt24xML6zN7Pow6EOOkWXsFonOU6OCKupTSp/x3Nm54Y71mP5G+fVhQhvla4i9DK59QR3ycTp/8jeNIcNkhu+JF0eF21LjTuooQKZ6KVD1quPInSEzR/r/lQ/tYQvCov+yfBwZLRHJrWiJXjsYPr4R3Ou9U+yvbY1Uyg0JdwKft+sSOaaCOZg5KUaOVZDQQVdm+jToL+STOaAUPhMStrqWi3aq/nZVcXK9PuVNMTJ4hifQlXoBjpUaIDKOs/bIwuIGqgOP5PiuhN5w4TFiIPzMplu2v6u4KvM90NsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spjr9k9WUILics98eX5mRBwOuyi9M2nXlILbaXG30no=;
 b=fOfE/J7qyHFSX2ip2x/7KgcDDXHxlaWv4n3eEhU27LBV33eyTkMJa13u2EFLaqx0alVxCztOV/fq06T5t6vf5SuZba+dSNbW+56VSeDfqQzDOCHjXWuy2SqmmhRS8zKmwNe/HdQ+zJv+F54lWFu+26xkmC3kR08C5MchdA37DnFtXuh2UrHCzuC76Nn3cMq+bOfBshfuO7ouSame3NwSIit89u3bhcqHgMqRYuaSvfu/r24AFIE9sTlCzIwxUUBuMUCerPgN9ZxIUaMTQmgvbfAISasGOzsXfJb16xqhfUWBQnZ3a4ClVl/RV7bL9ZyjBihwQiV0s5H6cbigWJbFLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Spjr9k9WUILics98eX5mRBwOuyi9M2nXlILbaXG30no=;
 b=HKlw1hqYiJ3Tsfv8ve3P/kh7hQgJclbF0DAnSZ3zdnNjdSHC2AdaAzUjEHOYSHw6g1x9wtL/kcAbNgMYVW1gd4UhMoLS6LT+HDTLySub/1alK1aNiImR2wimOH5KxfOTsTijnZg/AaQwrua7E/2TNWc4TxnuCrbqK70h5n7UPiI=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:38:01 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:38:01 +0000
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
Subject: [PATCH 94/94] mm: Move mas locking outside of munmap() path.
Thread-Topic: [PATCH 94/94] mm: Move mas locking outside of munmap() path.
Thread-Index: AQHXPERDRfg+Yjl5x0SvTuH2bZDirQ==
Date:   Wed, 28 Apr 2021 15:36:32 +0000
Message-ID: <20210428153542.2814175-95-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 83abecd5-c75e-4d01-dc38-08d90a5b9b84
x-ms-traffictypediagnostic: CO1PR10MB4548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4548EA8E22BF1DF71653E368FD409@CO1PR10MB4548.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 31VmBRm1YnMyT8jBJWtFc47foXIh5GUPW75VyZc/wvR8I74PlocglGl3XbXQ3BC6xkpA3l7utvh+DSyL8diVUJPwNJEBf9aAFvdymefQzx3Sg18y6fnmYieRDCmAFM9U/OJRbMg65PUjEUtc1XObBeJ2k0QV6y3I5tN9k8UREhm79QChDr9qbABBkc87kVOvUdLLGJdKRaCoZ2BPkxgICmpHyzXpASiZDtO+axebvgq+Dp1EXIHi5Cqql8iXyITnCaspFpXK95Qdt3RwcUpo+dkH+87te+2C9PaYlzWCrIrX0xexgYHs+y+ajoTZEXVBqO4BP2JdlXSiaBG9tahGrEM/2M/hbRLo9vjAE82rTrVplO/yJIUtbw0v39Ua41vwY+ECSaUvnhVgvJZgq74F1RFPuYPIdYVJKW8HNTzED8jdJgsErWZ3LCdCvTBrUA0A6bavztcGtUhYDXsKaxN9eiCLC4lZBhOsPOWAkN8ZugQuZW0SXvvRAwG5LZ/vmgwkeYM8g4sy92jatpM5vMiErAi2LE0YAIjqI/NC5oaaC4nJ6Jsh06lI9iDzEDFtA/fB0BrsxvIefdtSMoYPlf46O3UIXO41jOj8vDa5GZgINuc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(6512007)(66946007)(8936002)(186003)(83380400001)(54906003)(86362001)(478600001)(122000001)(4326008)(76116006)(1076003)(107886003)(7416002)(110136005)(38100700002)(26005)(2906002)(2616005)(8676002)(66446008)(6666004)(6486002)(71200400001)(5660300002)(316002)(44832011)(64756008)(91956017)(66476007)(66556008)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?a6nw1vu1Z38XTa7WI+44p3LlndHujwOIuEBAuhMxyVYS0uxBteGJ1Ki4o9?=
 =?iso-8859-1?Q?FpC/K+c7x4P7NiA9rvP7Jdxr/cJPILzAYH4RaCSQmd8kK1mywy6vH0chaz?=
 =?iso-8859-1?Q?L+9pe/kZVc44sQuG9f1EvnpyeylXPV0vvDPIvZ4wtQKhghkjf5XTM2eEdj?=
 =?iso-8859-1?Q?L59FlLhx6iuqHVYgBAlco8mUNFnJO5Mve5T53/9APBCnxnb3RCoIRnqM7s?=
 =?iso-8859-1?Q?PkC7bfTGwl736oe71VaZT4HoLFUVS8KvNY44xB20pYUm6ZBqOC1NF+wot0?=
 =?iso-8859-1?Q?FxsUKM5rrW0Kna0jlKIcLBXyVve0AxHfq7nOfeftK/2Y4fQPSZkkQiCafl?=
 =?iso-8859-1?Q?lRJC0q1/z0sE771U0GtB77uAnoGy1aZmfoqZsRxNaw7ipSzOHUADqR+4nT?=
 =?iso-8859-1?Q?6hDJFHVkR60axRep8x7gBprGuWPM4oD2ibY3xduwfaBWZqoTz+TV8FP7TB?=
 =?iso-8859-1?Q?qBBKtu1RIgiGVvSGrYMuYnQx6uE3J2ikOE+KnRZmG6QdquRkFQ/Ely4a/1?=
 =?iso-8859-1?Q?STglnw3fliLAzvtM8gobBI4Vm1XFdqK7AcSzbp9t7Y+cFKT6ZZOI3cPKXO?=
 =?iso-8859-1?Q?dW2id/D51zX9xG7ESPqwK1anmHzDQZTzA18Eiv7EtylIt8X/E9pla3N+c2?=
 =?iso-8859-1?Q?om5qH4LrzEZSM2KZlCif2UEiZFJbhHxQ0PMqkLIwCA+E8X4SWHbad4/ZHy?=
 =?iso-8859-1?Q?93IBlDJtFvEQ6duqJzs8pZt6VoYqxP5XE9WYqfVCQ27teJx2RIgfKSrH9E?=
 =?iso-8859-1?Q?DCpeUB9MpT3ody0XDRnbpr3XGzYeXIFJg0xE5d2Oi1Lkmj0wVY4/FD7ryo?=
 =?iso-8859-1?Q?q/RYq1s2rihBVqtq5OjsAgqG+0jaGEwhC0vJm7n4zJoFsYXWCvYwHc045H?=
 =?iso-8859-1?Q?T8rX6qCzxdWio9gRxQYDVU5Y4mOeuRPFZHrw8iqxpmY1OuhPm0TjJNaZ9L?=
 =?iso-8859-1?Q?WQvM9xJDKmwkyAvggZkzietK9RmfnnZPmmT8c1VUi++t1RuQzyu7Dl5rU1?=
 =?iso-8859-1?Q?fx17ZLGLotUWD0VYXFhF/L6VLFXefXlkzTDbYxu/HbVtXluxD0XHrEssiF?=
 =?iso-8859-1?Q?BJv3Q5YGQEdZzHtIejw54ayvEuM/VlVhz8tQ9PmDyZqBb7zGijq0iP5elN?=
 =?iso-8859-1?Q?Aq4S4z+k4Wqu3wkKn3okHkQ+qUSJnzDCUupGhcbqLgl9cndM3is9D1e4xk?=
 =?iso-8859-1?Q?waa1KDNGQEV8/dFVcEI38o5uPsBRwmKkMzBebvOguAYV32puRgSA1wUYxU?=
 =?iso-8859-1?Q?7W39a2Xkn9CZxGaez5wOOFDVAQk9cDTN9NeYFnhl7RJ/QIUtx0QXtw/gw9?=
 =?iso-8859-1?Q?2+nqeoC4/HpJge09yTkgmkHNdX7YcBtl8ZOlXbJR4oPPGcNWrx6kABa0wE?=
 =?iso-8859-1?Q?0/gXrXQusp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83abecd5-c75e-4d01-dc38-08d90a5b9b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:32.6966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wC3UKuMYCVZpf5UFecvYd9QaJT+rv/Klwg9yvSOe7L4zDFdRwAD2lpQlK1Is7yxu4jkPxxgeFht7PbxSMqnHGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: QFOQEaci5sAFYsrYku4YPS8ZIO-xikNr
X-Proofpoint-GUID: QFOQEaci5sAFYsrYku4YPS8ZIO-xikNr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is a split variant that allows splitting to use a maple stat=
e,
move the locks to a more logical position.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/internal.h |  4 ---
 mm/mmap.c     | 81 +++++++++++++++++++++++++++++++++------------------
 mm/nommu.c    |  4 +++
 3 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 0fb161ee7f73..68888d4d9cb3 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -367,9 +367,7 @@ static inline int vma_mas_store(struct vm_area_struct *=
vma, struct ma_state *mas
=20
 	mas->index =3D vma->vm_start;
 	mas->last =3D vma->vm_end - 1;
-	mas_lock(mas);
 	ret =3D mas_store_gfp(mas, vma, GFP_KERNEL);
-	mas_unlock(mas);
 	return ret;
 }
=20
@@ -388,9 +386,7 @@ static inline int vma_mas_remove(struct vm_area_struct =
*vma, struct ma_state *ma
=20
 	mas->index =3D vma->vm_start;
 	mas->last =3D vma->vm_end - 1;
-	mas_lock(mas);
 	ret =3D mas_store_gfp(mas, NULL, GFP_KERNEL);
-	mas_unlock(mas);
 	return ret;
 }
=20
diff --git a/mm/mmap.c b/mm/mmap.c
index 5335bd72bda3..a0a4d1c4ca15 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -239,6 +239,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		goto success;
 	}
=20
+	mas_lock(&mas);
 	mas_set(&mas, newbrk);
 	brkvma =3D mas_walk(&mas);
 	if (brkvma) { // munmap necessary, there is something at newbrk.
@@ -289,19 +290,21 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		goto out;
=20
 	mm->brk =3D brk;
-
 success:
 	populate =3D newbrk > oldbrk && (mm->def_flags & VM_LOCKED) !=3D 0;
 	if (downgraded)
 		mmap_read_unlock(mm);
-	else
+	else {
+		mas_unlock(&mas);
 		mmap_write_unlock(mm);
+	}
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate)
 		mm_populate_vma(brkvma, oldbrk, newbrk);
 	return brk;
=20
 out:
+	mas_unlock(&mas);
 	mmap_write_unlock(mm);
 	return origbrk;
 }
@@ -501,7 +504,9 @@ static void vma_link(struct mm_struct *mm, struct vm_ar=
ea_struct *vma)
 {
 	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end - 1);
=20
+	mas_lock(&mas);
 	vma_mas_link(mm, vma, &mas);
+	mas_unlock(&mas);
 }
=20
 /*
@@ -2442,8 +2447,6 @@ static inline void detach_range(struct mm_struct *mm,=
 struct ma_state *mas,
 	do {
 		count++;
 		*vma =3D mas_prev(mas, start);
-		BUG_ON((*vma)->vm_start < start);
-		BUG_ON((*vma)->vm_end > end + 1);
 		vma_mas_store(*vma, dst);
 		if ((*vma)->vm_flags & VM_LOCKED) {
 			mm->locked_vm -=3D vma_pages(*vma);
@@ -2548,14 +2551,12 @@ static int do_mas_align_munmap(struct ma_state *mas=
, struct vm_area_struct *vma,
 	}
=20
 	/* Point of no return */
-	mas_lock(mas);
 	if (next)
 		max =3D next->vm_start;
=20
 	mtree_init(&mt_detach, MAPLE_ALLOC_RANGE);
 	dst.tree =3D &mt_detach;
 	detach_range(mm, mas, &dst, &vma);
-	mas_unlock(mas);
=20
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
@@ -2567,8 +2568,10 @@ static int do_mas_align_munmap(struct ma_state *mas,=
 struct vm_area_struct *vma,
 			downgrade =3D false;
 		else if (prev && (prev->vm_flags & VM_GROWSUP))
 			downgrade =3D false;
-		else
+		else {
+			mas_unlock(mas);
 			mmap_write_downgrade(mm);
+		}
 	}
=20
 	/* Unmap the region */
@@ -2634,7 +2637,9 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len,
 	int ret;
 	MA_STATE(mas, &mm->mm_mt, start, start);
=20
+	mas_lock(&mas);
 	ret =3D do_mas_munmap(&mas, mm, start, len, uf, false);
+	mas_unlock(&mas);
 	return ret;
 }
=20
@@ -2651,11 +2656,12 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 	unsigned long merge_start =3D addr, merge_end =3D end;
 	unsigned long max =3D USER_PGTABLES_CEILING;
 	pgoff_t vm_pgoff;
-	int error;
+	int error =3D ENOMEM;
 	struct ma_state ma_prev, tmp;
 	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
=20
=20
+	mas_lock(&mas);
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
 		unsigned long nr_pages;
@@ -2668,23 +2674,21 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
=20
 		if (!may_expand_vm(mm, vm_flags,
 					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
+			goto no_mem;
 	}
=20
 	validate_mm(mm);
 	/* Unmap any existing mapping in the area */
-	if (do_mas_munmap(&mas, mm, addr, len, uf, false)) {
-		return -ENOMEM;
-	}
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
+		goto no_mem;
=20
 	/*
 	 * Private writable mapping: check memory availability
 	 */
 	if (accountable_mapping(file, vm_flags)) {
 		charged =3D len >> PAGE_SHIFT;
-		if (security_vm_enough_memory_mm(mm, charged)) {
-			return -ENOMEM;
-		}
+		if (security_vm_enough_memory_mm(mm, charged))
+			goto no_mem;
 		vm_flags |=3D VM_ACCOUNT;
 	}
=20
@@ -2735,10 +2739,8 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		error =3D -ENOMEM;
+	if (!vma)
 		goto unacct_error;
-	}
=20
 	vma->vm_start =3D addr;
 	vma->vm_end =3D end;
@@ -2863,6 +2865,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	vma->vm_flags |=3D VM_SOFTDIRTY;
 	vma_set_page_prot(vma);
 	validate_mm(mm);
+	mas_unlock(&mas);
 	return addr;
=20
 unmap_and_free_vma:
@@ -2883,6 +2886,8 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+no_mem:
+	mas_unlock(&mas);
 	return error;
 }
=20
@@ -2895,6 +2900,7 @@ static int __vm_munmap(unsigned long start, size_t le=
n, bool downgrade)
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
+	mas_lock(&mas);
 	ret =3D do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
@@ -2904,8 +2910,10 @@ static int __vm_munmap(unsigned long start, size_t l=
en, bool downgrade)
 	if (ret =3D=3D 1) {
 		mmap_read_unlock(mm);
 		ret =3D 0;
-	} else
+	} else {
+		mas_unlock(&mas);
 		mmap_write_unlock(mm);
+	}
=20
 	userfaultfd_unmap_complete(mm, &uf);
 	return ret;
@@ -2957,6 +2965,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, star=
t, unsigned long, size,
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
+	rcu_read_lock();
 	mas_set(&mas, start);
 	vma =3D mas_walk(&mas);
=20
@@ -3005,6 +3014,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, star=
t, unsigned long, size,
 			prot, flags, pgoff, &populate, NULL);
 	fput(file);
 out:
+	rcu_read_unlock();
 	mmap_write_unlock(mm);
 	if (populate)
 		mm_populate(ret, populate);
@@ -3021,7 +3031,8 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, star=
t, unsigned long, size,
  * @oldbrk: The end of the address to unmap
  * @uf: The userfaultfd list_head
  *
- * Returns: 0 on success.
+ * Returns: 0 on success, 1 on success and downgraded write lock, negative
+ * otherwise.
  * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
  * possible.
  */
@@ -3083,6 +3094,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
 	}
=20
+	mas_unlock(mas);
 	mmap_write_downgrade(mm);
 	unmap_region(mm, &unmap, mas, newbrk, oldbrk, vma,
 		     next ? next->vm_start : 0);
@@ -3165,13 +3177,10 @@ static int do_brk_flags(struct ma_state *mas, struc=
t ma_state *ma_prev,
 				anon_vma_lock_write(vma->anon_vma);
 				anon_vma_interval_tree_pre_update_vma(vma);
 			}
-			mas_lock(ma_prev);
 			vma->vm_end =3D addr + len;
 			vma->vm_flags |=3D VM_SOFTDIRTY;
-			if (mas_store_gfp(ma_prev, vma, GFP_KERNEL)) {
-				mas_unlock(ma_prev);
+			if (mas_store_gfp(ma_prev, vma, GFP_KERNEL))
 				goto mas_mod_fail;
-			}
=20
 			if (vma->anon_vma) {
 				anon_vma_interval_tree_post_update_vma(vma);
@@ -3242,10 +3251,12 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
+	mas_lock(&mas);
 	// This vma left intentionally blank.
 	mas_walk(&mas);
 	ret =3D do_brk_flags(&mas, &mas, &vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
+	mas_unlock(&mas);
 	mmap_write_unlock(mm);
 	if (populate && !ret)
 		mm_populate_vma(vma, addr, addr + len);
@@ -3307,9 +3318,10 @@ void exit_mmap(struct mm_struct *mm)
=20
 	arch_exit_mmap(mm);
=20
+	mas_lock(&mas);
 	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma) { /* Can happen if dup_mmap() received an OOM */
-		rcu_read_unlock();
+		mas_unlock(&mas);
 		return;
 	}
=20
@@ -3322,6 +3334,7 @@ void exit_mmap(struct mm_struct *mm)
 	unmap_vmas(&tlb, vma, &mas, 0, -1);
 	free_pgtables(&tlb, &mas2, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING=
);
 	tlb_finish_mmu(&tlb);
+	mas_unlock(&mas);
=20
 	/*
 	 * Walk the list again, actually closing and freeing it,
@@ -3346,12 +3359,16 @@ void exit_mmap(struct mm_struct *mm)
  */
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
-		return -ENOMEM;
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end - 1);
+
+	mas_lock(&mas);
+	if (mas_find(&mas, vma->vm_end - 1))
+		goto no_mem;
=20
 	if ((vma->vm_flags & VM_ACCOUNT) &&
 	     security_vm_enough_memory_mm(mm, vma_pages(vma)))
-		return -ENOMEM;
+		goto no_mem;
+
=20
 	/*
 	 * The vm_pgoff of a purely anonymous vma should be irrelevant
@@ -3370,8 +3387,14 @@ int insert_vm_struct(struct mm_struct *mm, struct vm=
_area_struct *vma)
 		vma->vm_pgoff =3D vma->vm_start >> PAGE_SHIFT;
 	}
=20
-	vma_link(mm, vma);
+	mas_reset(&mas);
+	vma_mas_link(mm, vma, &mas);
+	mas_unlock(&mas);
 	return 0;
+
+no_mem:
+	mas_unlock(&mas);
+	return -ENOMEM;
 }
=20
 /*
diff --git a/mm/nommu.c b/mm/nommu.c
index a99e276445ce..65eee2770625 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -571,6 +571,7 @@ static void add_vma_to_mm(struct mm_struct *mm, struct =
vm_area_struct *vma)
=20
 	BUG_ON(!vma->vm_region);
=20
+	mas_lock(&mas);
 	mm->map_count++;
 	printk("mm at %u\n", mm->map_count);
 	vma->vm_mm =3D mm;
@@ -592,6 +593,7 @@ static void add_vma_to_mm(struct mm_struct *mm, struct =
vm_area_struct *vma)
 	mas_reset(&mas);
 	/* add the VMA to the tree */
 	vma_mas_store(vma, &mas);
+	mas_unlock(&mas);
 }
=20
 /*
@@ -601,6 +603,7 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
 {
 	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
=20
+	mas_lock(&mas);
 	vma->vm_mm->map_count--;
 	/* remove the VMA from the mapping */
 	if (vma->vm_file) {
@@ -616,6 +619,7 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
+	mas_unlock(&mas);
 }
=20
 /*
--=20
2.30.2
