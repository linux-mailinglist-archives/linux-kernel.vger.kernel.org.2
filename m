Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD5436DBF1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239980AbhD1Pjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:39:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49834 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240398AbhD1Phk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:40 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFM712009822;
        Wed, 28 Apr 2021 15:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ZP+QmAE0E8ttO+SaJORYitpOdCnTRaIqqqlF1408xfQ=;
 b=H/E4NCaNe5Fm0nethmlW2SYyQl9LSxIhluSU0RBOW8NQMIyI7vtXoHSzPaFgdvdLzCTh
 laiNgd5gxQgrHEJMbtKC/IS081iz/SfeJ082A1ammYquRIW4E1oovBQo5rLpte8F3hZD
 O5fgwTXMyVKChIcUHmJT0bG3+4EdtEr1eJPitDUpnlwqgBr3i4+tQxsbi34TTtqME+zf
 VJjpZyTLKI0tgeGPRfAo61ZZKTpttazGvVni334ckbJvOI65SzoTn62665p8rlebXW1I
 ZLXhgen5Hb+teFYimON5PDj08eNhHxkQg33Nw9XUDJNXahOPcpJqUhviKshpckI94nEe vg== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38789105yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:41 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFY4iZ022800;
        Wed, 28 Apr 2021 15:36:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3020.oracle.com with ESMTP id 384w3uuaea-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYTUu9IyoR0O4msHv63Gvd+VOdDFmR5mMcbZhSrbOQ4F+G6xheW3TKljCMyMIRqvM6tp/0xz8mABhQBMZ25guenq+Xk4/DvpDUenVs8YPqTKqn6W3p8fzZxkPVBRJMQUkt3uXrVM607nq4icw26tLm1M7JEeyxX0DErE6YVQ5UdKfHP4IkCK7FpXvHMJb7no1GZdYc25j1zrZxtugGaLTzfCa3WCPuf7qg1sMmgFOQivPXn04hjptdSQdMUAtn73nPwV9Ol8UzMjHCHNPkz1pqyp8D8mqvQ0LfyBZvyN3RgB+DTBPM/+0L5CMtRj8v4WsVGTVQ8JB1vAnpsXTbOK3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZP+QmAE0E8ttO+SaJORYitpOdCnTRaIqqqlF1408xfQ=;
 b=eReT76OaLyKmrrC6EHIsvHzFiT7su4cAUNof5eX6s2NpeMP/95LJEb+7r2KFJCYdxxKkLDB38YdHmqcKq2PAr3VKJ1K/Odndx94HUmtDjXdpBNaIZHmXZXzIymiEqlkArS4bJ/zPtUySDT+59EPnBOByibyJWfx9DijisyvWbqqD1gIbSogjfYhXh15ICjXqkP8HQbA0ZNNjqZ4wKZbmZZCQxPXX+npQojv91gIIlIGcqlQuR3315HGGazsze7Q0tS/UmdYmQdfWud/MCo+uv9OBnCgIGDQ+in1xdjYlzTnwe00zmxTRm4ZKBB+FyDIBYl1F3aLyh63wqkbPPDMPNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZP+QmAE0E8ttO+SaJORYitpOdCnTRaIqqqlF1408xfQ=;
 b=zqobiOOwgwIqSeA5iQlFsWZ2wp2Bvntmzdv7s8f6O8PFYCFH/j5zu7Fma+5mQ937xVmJrU/3QB6vNcKrYJN+Z69xguHJ6qF+dUh4GbIpRkcK7RGcMYgt85oxyhqQmaWbgHdakZJtgwFmFAQLALekzu/o5oqHtJx24en2ti+fpcY=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1982.namprd10.prod.outlook.com (2603:10b6:300:10a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:36:36 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:36 +0000
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
Subject: [PATCH 32/94] kernel/fork: Convert dup_mmap to use maple tree
Thread-Topic: [PATCH 32/94] kernel/fork: Convert dup_mmap to use maple tree
Thread-Index: AQHXPEQzJedE/FbyXUah1XIctJgRAg==
Date:   Wed, 28 Apr 2021 15:36:05 +0000
Message-ID: <20210428153542.2814175-33-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 9b75b7d2-fc90-4653-1796-08d90a5b6890
x-ms-traffictypediagnostic: MWHPR10MB1982:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1982182F9B195E9525E1CB34FD409@MWHPR10MB1982.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6W/0E6SJvivRKSt84Ftdp6sHwTehotlmVzPFu/G/OhwBdNWaYNEQFzCRy8HgOw4gORyv/Lx59yqfXtmLnZrYXMlj/3/hNqUwjPChlar9z3LYpn4BUU47+yzPuZqWsA4INjR6+D2LaZ19014YvEl3lc55Dhx/A/WkDwtxFr9Y9krfU07+8Yk7C3Y/X3S63yhmP5OFuzZXSCptWuD1Xl0p68DtXkZqnhc0hg02OxQ5eZNmf50V8o5O+TEa6oAjIFbOeJvpDxF2ZAK1xvyeMY2xdAI7lIND6bfCsXhXhilaJ+Dzd044MT2zwv2J1g/6kChCPL8pnBczKjqTB3qjEm4beOQWV6eq0B43iz4flpu2UA+IQSfhOrFLUiPyJ/PFh6gBJooqjxVmC2r4m3ONwYL4cDSX4M9bCij03FgSx4rb4BRDuZ2KBteuthm7xHHlV6O2WCiPdTUjrFZPiyptzG+gaktpCSn7XnFpnDL0m6kR9km7Xz0jN1jNbLTr4IfgHqiuZ+3YVm1eRqWg3wzNxQzHarCgX4u7UU92CqAeOPV37ZcjsahmSqN8dzW2OG+/fvasl9CCWSFkx1y1kK+urPL/p5sSp2neRoWBXsDEuDRuj64=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(346002)(39860400002)(2906002)(8936002)(6512007)(1076003)(66556008)(76116006)(83380400001)(66946007)(6666004)(2616005)(7416002)(186003)(26005)(4326008)(110136005)(107886003)(66446008)(54906003)(6486002)(71200400001)(316002)(5660300002)(38100700002)(91956017)(478600001)(64756008)(6506007)(86362001)(44832011)(8676002)(66476007)(122000001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?3QrigB9T9qKIo9psiTEzLVA/65JuMjuIHJw9iTKiStgJn6RA6XEJL3YSWA?=
 =?iso-8859-1?Q?RiDRZ/W0m3T6EvlmTvPQ8CWga29YXh1yL2K8LesgCvRVc7w606W99a/G1e?=
 =?iso-8859-1?Q?h83Ujy6CV04qs2xNn3EmXUV/s+pvEuoP9LXzPGtj/LxKjTMw1yz/DxlTKc?=
 =?iso-8859-1?Q?MHD8ozMx+ysYT2LsYOGO4t4D4FBfN0bIFc63jPf6esJF0SuO2CG5jmO9yF?=
 =?iso-8859-1?Q?zJ2zipMPvpzFbLOY1aaqlIfu3Lzz8gYwMi62FQ72uOqEyGInogwo4ZLChS?=
 =?iso-8859-1?Q?PrOazUV1fJfATHAlwVTNacEMHWPkLRIv1FtlzKNHtdClXiM1DMG+MYf1d+?=
 =?iso-8859-1?Q?wCSyHNx+di3Fv/GzISuc/IzQKIKfiX649+SdAqbPvN5KvXt7q+MW08CZtl?=
 =?iso-8859-1?Q?nID0vvkr1dFiphg/l+Kpq27RtU5uguNePltk2fjRcHLxlye1EBsaifyG5l?=
 =?iso-8859-1?Q?AaaJ7jepqq45GJCDdIa8nVRv8Gox2Z3bH8v3sdeCrrUypwj1RRTw/5nKGk?=
 =?iso-8859-1?Q?hNxx9HJAtSBb4o41IcSLd6HoRuF2c89SWcvtTnw28XksszEVL5vkeAQj18?=
 =?iso-8859-1?Q?tFIW4vWGgEyJFz495tlyYmhLn3syCD7l/eYD1L6EP7XcXPsilM/R11+DKk?=
 =?iso-8859-1?Q?lqWejZKdhNIn7LflD3ZfupHN7whQkSv6kJutE/ZzSR+7QI4+EuDozbeqit?=
 =?iso-8859-1?Q?z04J8NhEKieXlRySiWonZXZdJnh7QEBvp3jA0QpnoiGUKXynmxKiqZF3K2?=
 =?iso-8859-1?Q?PCZFoTztwlvrhirOSV6D0O0F+X0qwXsjMx8WfuPwZH5XLsixMZw+LceC5q?=
 =?iso-8859-1?Q?d/afYcqt1BBmWKwE69WzitF+OuCZpGyZ49MwSqQ3HD10IOv4lfjVMoVYrx?=
 =?iso-8859-1?Q?ZeXzvftz02S9OC+6I9XyOqBAbdH3zp8MzJIV5P62a6IHDM0s7Ysjs4QJZ/?=
 =?iso-8859-1?Q?MjcqnlHDEHciO8Y2EZ9MT/BLGIHNBTuLc8HalYMnZJ/dB+Qy4uy8vu21uA?=
 =?iso-8859-1?Q?pze4zVl8/uNoAxajyQZ3u/FEDepOLLFqU2Vo+oeKtl9O/bOU9Q0yGmWCzO?=
 =?iso-8859-1?Q?scfDoCivpFpffdwKd6vxuDbf7fTqSK8JlJNk/CAf8/KLTwEig/glkVGQXw?=
 =?iso-8859-1?Q?xv1KDOY1Ray0ifVx35dV7nz+7rnzp/C7MnVojLfnfxP7095L9YRlez02aC?=
 =?iso-8859-1?Q?x7gRVQA7kaCDSXJOnD2kHGyvIFnVoC7BIiYS0aeKelCUm6EBI1nHZjQMWP?=
 =?iso-8859-1?Q?o8Egn9+8br2D0azjHa/9IjUjLz+mfJSfdsklmQkFgmhhDrhHiiaLJT8in9?=
 =?iso-8859-1?Q?t7WY/0hJS1qiIdRl3dHjiLmU9NTZgf6fBNsSkLiD5Wpx5XWbF56xLYnUlc?=
 =?iso-8859-1?Q?ibidcn2ZJz?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b75b7d2-fc90-4653-1796-08d90a5b6890
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:05.5416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Nh8nKjaFZCNeb+vlalDDF3C3oeH+pzjZexiNBxCymY3zkEfjHuWLGfmCuVsV52X3XJ2TW5zNELtujNp458JrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1982
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: XfsFKpmDX8w4h_G1iCC1ghXZ6AWYPFst
X-Proofpoint-ORIG-GUID: XfsFKpmDX8w4h_G1iCC1ghXZ6AWYPFst
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the maple tree iterator to duplicate the mm_struct trees.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h       |  2 --
 include/linux/sched/mm.h |  3 +++
 kernel/fork.c            | 24 +++++++++++++++++++-----
 mm/mmap.c                |  4 ----
 4 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e89bacfa9145..7f7dff6ad884 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2498,8 +2498,6 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
-/* maple_tree */
-void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index e24b1fe348e3..76cab3aea6ab 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -8,6 +8,7 @@
 #include <linux/mm_types.h>
 #include <linux/gfp.h>
 #include <linux/sync_core.h>
+#include <linux/maple_tree.h>
=20
 /*
  * Routines for handling mm_structs
@@ -67,11 +68,13 @@ static inline void mmdrop(struct mm_struct *mm)
  */
 static inline void mmget(struct mm_struct *mm)
 {
+	mt_set_in_rcu(&mm->mm_mt);
 	atomic_inc(&mm->mm_users);
 }
=20
 static inline bool mmget_not_zero(struct mm_struct *mm)
 {
+	mt_set_in_rcu(&mm->mm_mt);
 	return atomic_inc_not_zero(&mm->mm_users);
 }
=20
diff --git a/kernel/fork.c b/kernel/fork.c
index c37abaf28eb9..832416ff613e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -477,7 +477,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
-	unsigned long charge;
+	unsigned long charge =3D 0;
+	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	LIST_HEAD(uf);
=20
 	uprobe_start_dup_mmap();
@@ -511,7 +513,13 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		goto out;
=20
 	prev =3D NULL;
-	for (mpnt =3D oldmm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
+
+	retval =3D mas_entry_count(&mas, oldmm->map_count);
+	if (retval)
+		goto fail_nomem;
+
+	rcu_read_lock();
+	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
 		struct file *file;
=20
 		if (mpnt->vm_flags & VM_DONTCOPY) {
@@ -525,7 +533,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		 */
 		if (fatal_signal_pending(current)) {
 			retval =3D -EINTR;
-			goto out;
+			goto loop_out;
 		}
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned long len =3D vma_pages(mpnt);
@@ -594,7 +602,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		rb_parent =3D &tmp->vm_rb;
=20
 		/* Link the vma into the MT */
-		vma_store(mm, tmp);
+		mas.index =3D tmp->vm_start;
+		mas.last =3D tmp->vm_end - 1;
+		mas_store(&mas, tmp);
=20
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -604,14 +614,17 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
 			tmp->vm_ops->open(tmp);
=20
 		if (retval)
-			goto out;
+			goto loop_out;
 	}
 	/* a new mm has just been created */
 	retval =3D arch_dup_mmap(oldmm, mm);
+loop_out:
 out:
+	rcu_read_unlock();
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
 	mmap_write_unlock(oldmm);
+	mas_destroy(&mas);
 	dup_userfaultfd_complete(&uf);
 fail_uprobe_end:
 	uprobe_end_dup_mmap();
@@ -1092,6 +1105,7 @@ static inline void __mmput(struct mm_struct *mm)
 {
 	VM_BUG_ON(atomic_read(&mm->mm_users));
=20
+	mt_clear_in_rcu(&mm->mm_mt);
 	uprobe_clear_state(mm);
 	exit_aio(mm);
 	ksm_exit(mm);
diff --git a/mm/mmap.c b/mm/mmap.c
index 929c2f9eb3f5..1bd43f4db28e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -780,10 +780,6 @@ static inline void vma_mt_store(struct mm_struct *mm, =
struct vm_area_struct *vma
 		GFP_KERNEL);
 }
=20
-void vma_store(struct mm_struct *mm, struct vm_area_struct *vma) {
-	vma_mt_store(mm, vma);
-}
-
 static void
 __vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct vm_area_struct *prev, struct rb_node **rb_link,
--=20
2.30.2
