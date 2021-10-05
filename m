Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F73D421C1B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhJEBhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:37:08 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32416 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232761AbhJEBeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:34:16 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19508Mdg004481;
        Tue, 5 Oct 2021 01:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6CebbRw8RBT3E6aa482wVS0djIbRaNxSd4qADYrJ1Sw=;
 b=knaueyvAPyS3VSMaDlQGrJQ/TZbrpZdigdHn0INequScblfiG8lnng0lKABOMHZE5/mo
 YvLE0Riq7DezNMITl89OKmBb18JQGHhAtmnFxuhHoI/3Ksily//pUXwtmBNvSeeFeryb
 Ak5ZW6b7LoUqKVMeq4DmuiNjWrH0+ekufK1ZKZf8tdbwJLNLaVCSmxKbhikWU8inyeH1
 2fdOYwrPx0tqHCagDSKuwBYmuTPpDkxc3bFigrkTXf9W6CB04TlZouMngox3X1bKDWuS
 P7wdr3ezTBKaugWu6eXOZNIZR2n1O56b0XmoQsScHlz6+v4YGAY9kPw5XzWlUApnuGnA QA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdGF141634;
        Tue, 5 Oct 2021 01:30:42 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by userp3020.oracle.com with ESMTP id 3bf16s9dx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPb17I5pEhy//lf7h70PHNY3R5UhdYWlY+riq+n9jG4pOQaufjSIbk2y3zSUHKDEcAffPmrbXPLxhHLPwAMSS36qVgzm61jWshdgbgnW/EjATVuEPC9q1k41vRXrqrbT1UbnwIvqfNcZgwxGz4TLRGYmBNyBgI1UCuNXEijMAoPujER6H8PyanfF8dw4GHKAIBCWrSEgY8DtEDDR5i0ZXnQs3fl4QCwO65U1vh9nFdFakjdz8VN38mNf/q6S8xYuBqRP9nyjMQSOMWEagJUUb01gq+0jB13ueX6sQK9QcbFIPtlmo5X/gI56SJx22O1oZ0q84BmAmDSPsp8fvzsywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6CebbRw8RBT3E6aa482wVS0djIbRaNxSd4qADYrJ1Sw=;
 b=a0KUW2SmCSyFTiEhObohMWzy/1gULecqtC+AZSo/MhpZU1Pl+sR4h7JVQhTPI56cvYslPRN5+fThqrty/Ub9oMSlB3B/1NDLC37KdS2rRVgDWQ0S193S+haJ5IPR5hVMNVn/IAOqDo0V9JntPHRPPcUvdJRtH8h5lQtSGlJ6qWaLyGP0COag99zaLHqJ1UdkX0Vmma6L5P4BM5j01lDTlY5ZCi5SH1VGYO9dyqnGqdkCt4Q7UqIpCB+hhUp1RvkC5a55bhD+Bo9ynyW3BOoBR3rBq8H6e+bHGlyohjdcRJ1Chdaa02TWNo8ji3F6BVwrsfXetP79QXa8RwfL4QVfNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6CebbRw8RBT3E6aa482wVS0djIbRaNxSd4qADYrJ1Sw=;
 b=dXia7ZaME5Yb64HuXzb04B/MW0akkLkzLNcYmERTqPHSiZr9iC6LTDOIzA2BKyPhRuOM6qziyfEEDYIPRy7TgEui/UM9gYvE1o+0HYO6owtW5qwlEasxUCGDM+3Qp0Zlzvxz7hu5qKWGrRCl1In6pbbiCdFdJetNjvEIl2N5v14=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:35 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:35 +0000
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
Subject: [PATCH v3 10/66] kernel/fork: Use maple tree for dup_mmap() during
 forking
Thread-Topic: [PATCH v3 10/66] kernel/fork: Use maple tree for dup_mmap()
 during forking
Thread-Index: AQHXuYiY8/0mnnbmPUSdWZwEl2KQUA==
Date:   Tue, 5 Oct 2021 01:30:35 +0000
Message-ID: <20211005012959.1110504-11-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 9589043a-f13f-46f7-72c2-08d9879fbade
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB504412046EC0D495710C678FFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8pea32qlB0VktsZxwmlaONPHASHgWfksdv4KrwzU2OqzfGuGEW8F769jctLOxgjKPJys63r7hmXMetdhQmmwQjmlCrINyHMf77iYIOQN7rEZb63RrfTKwHOxA+qY38QlZvn+qd6WE+h52zozxfUZoTzF46SPBqTi/SbxPWwDwMnXd+jl+AS5W2Fwt2WH3ZEUCabQ8lxLkudITPrs6K/n0rrNtHMEi/4pwkdBH8dXLl8jMIc4Yu1gXzOonW0IySc8zQbdHFPrmKUS9xfFIqJ1DDY8aMceKWJ5ZXrDNbdzW74hNJnxS841E9h2/qIPHUwZBiByCmAqU+TmsIgtM3qXUHCdat9KplRRJLi2+t0aPOGrjgt4w9+5mTm1/N19k2W0/COJ22sudsTBi+MpxjHsn1TpQp3AtLGGMOtD9iLaRQdTrSpZAx0kdX1yw8xhnxL2IyTiYeL1ev/azE7uyiyA2HLHBaryw8OUty1zAvfCu+pNCgK4WolKmqe6Zf1agTFnMr0Ybx/Jx2kX4s8JOZaU95Sg2bHrj+dU7lFSNM27UO+h4HeaIm9/+pM6ilNNqD6ByTFh627L0BuQ8QBoOmGl/p3oSpne1o0cJyc4X/GKaTP0VUeZpjEKie3nXBOTN3dfgrlDY/NlGX/CpJxZq+sevalk8aWc2odZe9IqpPF0o1wUi+dd+UFFxQrRXOAPjkisV1UbnoktNImOHFGjhAQf2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(6506007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YVlfQ8gO+3R1Owd660wN++cY/CA3DImSOkWI+29hndZoQWBzRTyPvH78RR?=
 =?iso-8859-1?Q?qDpeyWCfwK1elXVu+mgpJ7ICZTkTFtX4R1JF8AQ25JHv1W3H/YTqe/rioV?=
 =?iso-8859-1?Q?r/XiLMmv5cZv82uaBHrPJOBU9Om6hqstlvvwBPilFyrxUGCBB8COQaQ/JQ?=
 =?iso-8859-1?Q?8aa9/M7d3xVM1v+tQukeDEnWn/iSifOL/5YmIPVl0toSZLpj4eKLJyWV41?=
 =?iso-8859-1?Q?yLL8+jiBhttXZheqLvazX9RpIriBBAsehscxlP2yLyZUsvx0gQzY2Ff6Lh?=
 =?iso-8859-1?Q?1B4Wmjh3IKXN+ID48DltppjVXrBhaevZ/+VXC4qsGwoFLPKK2D660kk9tS?=
 =?iso-8859-1?Q?ZzHToUZyXto1MZC4gLP7YdY4RZV/i9eQm5ZLYPQGMS4zi0rtzVG7IFa758?=
 =?iso-8859-1?Q?0bBGKeuR6f7IpmS4LkJmBTL4qQaHSQNFPPMlSkxI/JgEufHmI+vSCWpkOy?=
 =?iso-8859-1?Q?6Sw2auoV5OYXMN7FxVz5vZLn7Sqi2N4jDgqTUSBYl5tx3hLoay0tsCnFKy?=
 =?iso-8859-1?Q?d+EImp6S05j7G6mMJwiMr14Eqt+tmILMLg4q5nL6l1PYcmlrt/3q/72qRa?=
 =?iso-8859-1?Q?fn0VWGA9/wQekQ7EmLnWJ4AYvQx6rPCjWCveFaU4VDO9YEoGkSts2ngSwL?=
 =?iso-8859-1?Q?ZDytN5alOgKdVfOkjmng3FMrwOH36WlfFAsIp9lmfsEgaN5WIPvokK8CzB?=
 =?iso-8859-1?Q?QOtJtTtWHwqUnr4Ar5BiLiulV3qkg1/j9asJaOkFnjR4J5+QWnktwkDaKZ?=
 =?iso-8859-1?Q?qAqqR9F3WJ4j7akF15yIjAVjEEf62RZatCYq1UP8doxOMM7lbns5ZtV7Xk?=
 =?iso-8859-1?Q?SFb1Z8vhIPS4FMSvExFQq0zfPmrVzmoK51yZJ34HvlJfUdKmiEqwis18P5?=
 =?iso-8859-1?Q?rvA6Mu56n7uKqKcZUyM39P44/FmLeAkxvGy8kklLOpnsK+VStIvobxVyZ8?=
 =?iso-8859-1?Q?X350kjguSUcvixbdkauJ+jkiXJkoUTx9Xus2+jgJFUww+c1EVC1At/Uyj1?=
 =?iso-8859-1?Q?L7Ki4wDommPyZJ8xPn2l2jD5occ3ueDNvgF2qRLhJlEid/7ijc2c0ZxWAU?=
 =?iso-8859-1?Q?X88ts5J7QYQK07pLsrbv4o0TGO0zj0h51xY1uQChIGCoyBR7VHRug3t907?=
 =?iso-8859-1?Q?N7MPmIayLn7/2Jxlp7TeZkEhR/dzXr7FDzBBFx6WnUMYBQe6Jho4pZwUCx?=
 =?iso-8859-1?Q?AYbgwepfwZzs0VZ2VHtXswc44s5PCAJ+yYY/DZcJVf5LUzmTeOnpuMEfqd?=
 =?iso-8859-1?Q?aqnNgrnNcmGpN7JxahxzMx9Xxj70amNE+WlvaADPFi7a25g6NIwJ/cdlwi?=
 =?iso-8859-1?Q?VF42WvdHNG9AgYHPbknVkUWO+us+mELREUBn6czMeaWXfSwDZfbiWAzTuH?=
 =?iso-8859-1?Q?gkJXAMsQbe?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9589043a-f13f-46f7-72c2-08d9879fbade
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:35.1078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckK3sLCw4bdEdWe0hrMvJHjSTBH71zHvpEecKlGbgWcoLOuB+pTAxoGmdo8+9v+EdSL5sF6zNAKAoCDEYNafRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-GUID: UOqqIrBCGZ_kPVpkB8-2lQewSMC54ZFL
X-Proofpoint-ORIG-GUID: UOqqIrBCGZ_kPVpkB8-2lQewSMC54ZFL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The maple tree was already tracking VMAs in this function by an earlier
commit, but the rbtree iterator was being used to iterate the list.
Change the iterator to use a maple tree native iterator, rcu locking,
and switch to the maple tree advanced API to avoid multiple walks of the
tree during insert operations.

anon_vma_fork() may enter the slow path and cause a schedule() call to
cause rcu issues.  Drop the rcu lock and reacquiring the lock.  There is
no harm in this approach as the mmap_sem is taken for write/read and
held across the schedule() call so the VMAs will not change.

Note that the bulk allocation of nodes is also happening here for
performance reasons.  The node calculations are done internally to the
tree and use the VMA count and assume the worst-case node requirements.
The VM_DONT_COPY flag does not allow for the most efficient copy method
of the tree and so a bulk loading algorithm is used.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h       |  2 --
 include/linux/sched/mm.h |  9 +++++++++
 kernel/fork.c            | 35 +++++++++++++++++++++++++++++------
 mm/mmap.c                |  4 ----
 4 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index df592bf937f9..73a52aba448f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2500,8 +2500,6 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
-/* maple_tree */
-void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 5561486fddef..87f4f53a3d7d 100644
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
@@ -67,11 +68,19 @@ static inline void mmdrop(struct mm_struct *mm)
  */
 static inline void mmget(struct mm_struct *mm)
 {
+	mt_set_in_rcu(&mm->mm_mt);
 	atomic_inc(&mm->mm_users);
 }
=20
 static inline bool mmget_not_zero(struct mm_struct *mm)
 {
+	/*
+	 * There is a race below during task tear down that can cause the maple
+	 * tree to enter rcu mode with only a single user.  If this race
+	 * happens, the result would be that the maple tree nodes would remain
+	 * active for an extra RCU read cycle.
+	 */
+	mt_set_in_rcu(&mm->mm_mt);
 	return atomic_inc_not_zero(&mm->mm_users);
 }
=20
diff --git a/kernel/fork.c b/kernel/fork.c
index e8d602de40e8..b8b7063d94e8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -492,7 +492,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
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
@@ -526,11 +528,19 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
 		goto out;
=20
 	prev =3D NULL;
-	for (mpnt =3D oldmm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
+
+	retval =3D mas_entry_count(&mas, oldmm->map_count);
+	if (retval)
+		goto out;
+
+	rcu_read_lock();
+	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
 		struct file *file;
=20
+		rcu_read_unlock();
 		if (mpnt->vm_flags & VM_DONTCOPY) {
 			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
+			rcu_read_lock();
 			continue;
 		}
 		charge =3D 0;
@@ -540,7 +550,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		 */
 		if (fatal_signal_pending(current)) {
 			retval =3D -EINTR;
-			goto out;
+			goto loop_out;
 		}
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned long len =3D vma_pages(mpnt);
@@ -568,6 +578,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 			tmp->anon_vma =3D NULL;
 		} else if (anon_vma_fork(tmp, mpnt))
 			goto fail_nomem_anon_vma_fork;
+
 		tmp->vm_flags &=3D ~(VM_LOCKED | VM_LOCKONFAULT);
 		file =3D tmp->vm_file;
 		if (file) {
@@ -606,7 +617,11 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		rb_parent =3D &tmp->vm_rb;
=20
 		/* Link the vma into the MT */
-		vma_store(mm, tmp);
+		mas_lock(&mas);
+		mas.index =3D tmp->vm_start;
+		mas.last =3D tmp->vm_end - 1;
+		mas_store(&mas, tmp);
+		mas_unlock(&mas);
=20
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -616,10 +631,17 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
 			tmp->vm_ops->open(tmp);
=20
 		if (retval)
-			goto out;
+			goto loop_out;
+
+		rcu_read_lock();
 	}
+	rcu_read_unlock();
 	/* a new mm has just been created */
 	retval =3D arch_dup_mmap(oldmm, mm);
+loop_out:
+	rcu_read_lock();
+	mas_destroy(&mas);
+	rcu_read_unlock();
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
@@ -635,7 +657,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 fail_nomem:
 	retval =3D -ENOMEM;
 	vm_unacct_memory(charge);
-	goto out;
+	goto loop_out;
 }
=20
 static inline int mm_alloc_pgd(struct mm_struct *mm)
@@ -1112,6 +1134,7 @@ static inline void __mmput(struct mm_struct *mm)
 {
 	VM_BUG_ON(atomic_read(&mm->mm_users));
=20
+	mt_clear_in_rcu(&mm->mm_mt);
 	uprobe_clear_state(mm);
 	exit_aio(mm);
 	ksm_exit(mm);
diff --git a/mm/mmap.c b/mm/mmap.c
index 08f7338ca4f0..3da639586715 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -782,10 +782,6 @@ void vma_mt_store(struct mm_struct *mm, struct vm_area=
_struct *vma)
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
