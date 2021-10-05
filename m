Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC75D421C07
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbhJEBfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:35:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44754 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232170AbhJEBdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:53 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1950qIPk029448;
        Tue, 5 Oct 2021 01:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fVA+DNe/lyT9QRsbHFoDKnI4qZvJv1+4UeGiKBs3Z6o=;
 b=E5uAf4YhBt1ZJSGzeuL8hu8IpIqY1BkrN6N3rOhg8vg5rPXgLhV2jC4F04F6vXlZGuTj
 d+1fmXlm+nEJIN7PWgmx8yj/6edDelYZaGRbe767/MLLtUk51lh2H9Rt8g9qsgEK93/Z
 6AA2CDQpd0Ck35XNn8zMebNNPIJ24iyb4U1ygiejpYZlyOsFOmEdpncZYKklC/+aDRBy
 q1Rsx0EmfL1Lob38ZsUFJDCCdALuZvL/RuWquqMjxCpm0B3RpemLBxS+KW50E1eMzcf0
 uCe/hXkx2YDr+A38hzEmrcHYOrcZfK9TDiP4GSgnFgQMsjsKcKngDgzaIvYza+uMK7Ay kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg42kkydm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UHTS178361;
        Tue, 5 Oct 2021 01:31:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3bev8w0386-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKZ/cFxaa7ic4zXTpkrOSU1awUmkJ18amYpmP6g8gqMBGKDl/eya2xmrfb1Up7tw1Di7GxKArplkts+WzedRxU75Ibb9y1rsAIlKomRI91zTs5uYYNAEp3iL+ae3qu2gx5I0LAK8Y16VMj62sQvkWgSRNbkAswhrIb6hQFdTLPO74h69ko/r4JU0pxaObiyZDF4ZO/+jRkO/WbBRlVfTzko8zMbq/sgvrfL5dWGKvsgRdKIDduCZ5EI4ZKFnd7vx6z9qmqMi1VwQ6/vY2iCoO91UEVFAtAt4tFrAb9vIgGJTjM1eDmc7p5zA4RI8uqtsBLgcjisNZpD7FOg0BEgpVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVA+DNe/lyT9QRsbHFoDKnI4qZvJv1+4UeGiKBs3Z6o=;
 b=B+yIEFNSePEtSkYyrGWvVqrL5IvCkOabpO8pOseWjmqEpJiBThRPu51jKprfP3+O/ecDueOM63ULEwtI6Hq/43SgLWxiTyTux1gigVpS1QBis5iCCDJeA20hYQMpbd79bnTLc+1yzqz2AQA2TarvkO6WLW7E4YAB3LmxT9XKBzePZAskL61rRNDwbtkmdPHZbPplGnYUOApgdWYRiXSUsd8Bo7bXWqO7YlyhR1zT2dKO5r98t5bGlgLtnaO4KsWuU3D3K9/YrryK3qvwKO5EEqfD5CMu/MdI5Pt4ilqmpRcUcesypsNe8eOI0EgMRWM5/H97g06aVD3s/4QrULTOrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVA+DNe/lyT9QRsbHFoDKnI4qZvJv1+4UeGiKBs3Z6o=;
 b=qJOiSG2uYXG37F0y7yZ5CH1kgiao6fG5HpskpeXlBcw6L/VA5g1f0STEjezSb83NZFvoyPX/a+P4eSTTcStCWdsB6mbI7+ayBkOhf88jz6P0JnNtWVfAMOoK7qLELskk55/1wxgxxpH8WpcwBU2AunRcfAoYzRV7qpUtUgVMXgM=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:25 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:25 +0000
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
Subject: [PATCH v3 53/66] mm/mempolicy: Use maple tree iterators instead of
 vma linked list
Thread-Topic: [PATCH v3 53/66] mm/mempolicy: Use maple tree iterators instead
 of vma linked list
Thread-Index: AQHXuYiqaKgEzHdnAEy177gh1Pc4Lw==
Date:   Tue, 5 Oct 2021 01:31:06 +0000
Message-ID: <20211005012959.1110504-54-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 981a03ff-af3c-4496-f786-08d9879fd8c9
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044B70E21819EB94F2F7ED7FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: evNkJaoDjAnYA3kOv84VwQMpxUSODRhO5EN6keqcxAY1E4xd0042JtEJRC1cws7zx2nFc+xZXH9QeXynNt6lP/HKPHbJ70O1j/W8Uyji2fsZKBuCDLC59bFEMFyWNUbcctxcfYaFmqMtpRpnjUn+QOxgRS8bM2CCJQRjapeST8LAMJYv//HOjt+JzFXHHQJVkLZ0C5UNjV3XYaP6FO4IfJYG+lkM7R43Q+9QSpzYYa+9RyF1Po2zy6IXwPoXnde64Ejh2iwMI6+4jygwSOqsqkfXlAQhVOjbikielHzFXs379/wCpIIAJYNzUtySxzv+GAyHXoD5Zd5tDusUPKVen9C7eKW1EgwuZBJ5w6M3SAKFTwa5lQO8gmG2Httu/y6B8GjaUwf8NTl6wF9pSVd6xB/uSZcROwzaAfV8x+lHffoXnLs2N1H30ul7RRD0k9U/s7MIeKzhMR7UTYCa4JSbHnrjpJhfC0rEYgWldc3KZVl1rXDfARCkjh90Gv9LmjFoqJv2ZsjdtDz47c5As1JsUz2fY/U872LQ6rpZ6cPV0p9BeHwo32w8ytRadlTtXJQ9f4p7YrutN0rTVauSXraw9LeriHmy3He+9zp9V4zoEWCcI7REHClmZTPJ/13IDTT2m6Mu862t71TtkGp29rW703qCwJjuCIDapGsR82KDIM8WkUDDMTZv/yiBq6Eet9NBBvdMsThYwkss2IeIzMxvPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dFBP/1iO2HdFNSlFfjCiq6vDWpKmUZF3FGCzMUAaiEXqDK4S5loBFleePn?=
 =?iso-8859-1?Q?k3bvzUUkOOqvd9rMah1hBV5m7WTEEWKT2BEG38QBNAExyLM12jjqAH1YK4?=
 =?iso-8859-1?Q?U3+iIaU0IcEO0OINLejLxJ6arhYWVWOoP6jS7TNEeh6I7veJ28f13MeReW?=
 =?iso-8859-1?Q?W/1ORF+q664s4ulP8Y021aLxMnX2esb1HcfGBHPg6qY75KWSHz8Mq6ijqw?=
 =?iso-8859-1?Q?JDKHEKQLYtYZZxEeNAWogHGWyVZ6WaQDwoNZZcW65a0PLF7Y1e1ftOiUJ8?=
 =?iso-8859-1?Q?cQDv0SIxMj5IVlRf5Tf7GNWiO4ICyXptsP5raG3ACaol0JhXEH9+RvL6Km?=
 =?iso-8859-1?Q?SLHAMbZgnOpsFIMU5rnx5jOL0Yojv/Vty3p8gRo+qExklE8aaA0YQ88V/A?=
 =?iso-8859-1?Q?jvYsHhgu+hcBw1EGbt/SS0rWqVetHeoKhPEHguw0FU8kIxCmQnbfxI4MIB?=
 =?iso-8859-1?Q?cYlakzdloXX+ZUrZQ6rD8cNHP2sGDo3vW7kpQpssPTRKwlmie81PByivj5?=
 =?iso-8859-1?Q?JtIXf9s+bnLmpCh4yjgMzCRu/R71YmysijPlHw8/krh+ocHnlTew3QExGl?=
 =?iso-8859-1?Q?LNdPlSvYcKlSV1xAItUU53wOpau2KvF9/YMi6Sai0Nsw3I5Bp80aEXxgcq?=
 =?iso-8859-1?Q?9rBvnaiqetG1YcQkxqyc3/310Cv7Rh0Mr7pf6fZVxoQEfgAVq8hJPlTh8y?=
 =?iso-8859-1?Q?Tmv/dZuwbJ1g64leog4PBZMzMrnwUdE33nfFKJBSsjh3d+4laRBqs0Bx02?=
 =?iso-8859-1?Q?vdZyrpu+5bmi5hHHuZ8uz+cnIwRSUDjvZC+anbeWZ6kXyjvZve3F/CBYTU?=
 =?iso-8859-1?Q?wM0wtGoS6kAPSxkuFusRoiLldcZMo0kjAlb2VVAFTplRHhcVRsL5rqA2Ju?=
 =?iso-8859-1?Q?SwN4GmGFLXsrTNnEHXUDFCux7/SzNbLh/uslewpHAGYXGo48qZbnRufPdB?=
 =?iso-8859-1?Q?K1iDIT1lTMxZzo3fFshanpilpMmhp9HFjgBIKaLmGgA9qOD05erQBDRiLL?=
 =?iso-8859-1?Q?uIfrLrqNrXWEd7LMJbwTutluCKBTrnPja/GYde9KFk6B6+GlAZaonl0GCy?=
 =?iso-8859-1?Q?wps2O9up/BzHdv16SKp+rBXC/9YW8CZ1KBIT89SMFOUvKGuXb5I+KToDx8?=
 =?iso-8859-1?Q?zTHm3mX4C0e+UIct1HgfoeUoMUPF8QDn1504Qatq49qlVEd5Mm9TgAmaNU?=
 =?iso-8859-1?Q?BDz+LC1FT+NKKLlSmd7U3MXuveuJe9IdHOAAis/2g6bnjaDGaqMl7mk75P?=
 =?iso-8859-1?Q?8XmDQVj03wp2QYDQgG7g1cfj0l7XKYrbnS0B0WiyaIwpvmFc/OYeVmQLOX?=
 =?iso-8859-1?Q?AzaNZ/iVSXT6YTiXP74N3L+MXevu62dzV41dEpTkJKlY2htJT10L97kzpm?=
 =?iso-8859-1?Q?FdbHBs/TD4?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 981a03ff-af3c-4496-f786-08d9879fd8c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:06.5838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fTBxOUfeljl55W+AmcrCrAQqVCIlfFv50/2pxnh2rHXQdqM1+ShC/ICwKp1ahTX6ZbR59N0xpaNTzb6KUuuXVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=978 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: XPvL7Fqa_SwEY7besdOHkCqrdZGmFl2W
X-Proofpoint-ORIG-GUID: XPvL7Fqa_SwEY7besdOHkCqrdZGmFl2W
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mempolicy.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1592b081c58e..81ea28c8c6c8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -377,10 +377,13 @@ void mpol_rebind_task(struct task_struct *tsk, const =
nodemask_t *new)
 void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_write_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	mas_lock(&mas);
+	mas_for_each(&mas, vma, ULONG_MAX)
 		mpol_rebind_policy(vma->vm_policy, new);
+	mas_unlock(&mas);
 	mmap_write_unlock(mm);
 }
=20
@@ -652,7 +655,7 @@ static unsigned long change_prot_numa(struct vm_area_st=
ruct *vma,
 static int queue_pages_test_walk(unsigned long start, unsigned long end,
 				struct mm_walk *walk)
 {
-	struct vm_area_struct *vma =3D walk->vma;
+	struct vm_area_struct *next, *vma =3D walk->vma;
 	struct queue_pages *qp =3D walk->private;
 	unsigned long endvma =3D vma->vm_end;
 	unsigned long flags =3D qp->flags;
@@ -667,9 +670,10 @@ static int queue_pages_test_walk(unsigned long start, =
unsigned long end,
 			/* hole at head side of range */
 			return -EFAULT;
 	}
+	next =3D vma_next(vma->vm_mm, vma);
 	if (!(flags & MPOL_MF_DISCONTIG_OK) &&
 		((vma->vm_end < qp->end) &&
-		(!vma->vm_next || vma->vm_end < vma->vm_next->vm_start)))
+		(!next || vma->vm_end < next->vm_start)))
 		/* hole at middle or tail of range */
 		return -EFAULT;
=20
@@ -783,28 +787,28 @@ static int vma_replace_policy(struct vm_area_struct *=
vma,
 static int mbind_range(struct mm_struct *mm, unsigned long start,
 		       unsigned long end, struct mempolicy *new_pol)
 {
-	struct vm_area_struct *next;
 	struct vm_area_struct *prev;
 	struct vm_area_struct *vma;
 	int err =3D 0;
 	pgoff_t pgoff;
 	unsigned long vmstart;
 	unsigned long vmend;
+	unsigned long index =3D start;
=20
-	vma =3D find_vma(mm, start);
+	rcu_read_lock();
+	vma =3D find_vma_intersection(mm, start, end);
 	VM_BUG_ON(!vma);
=20
-	prev =3D vma->vm_prev;
+	prev =3D vma_prev(mm, vma);
 	if (start > vma->vm_start)
 		prev =3D vma;
=20
-	for (; vma && vma->vm_start < end; prev =3D vma, vma =3D next) {
-		next =3D vma->vm_next;
+	mt_for_each(&mm->mm_mt, vma, index, end - 1) {
 		vmstart =3D max(start, vma->vm_start);
 		vmend   =3D min(end, vma->vm_end);
=20
 		if (mpol_equal(vma_policy(vma), new_pol))
-			continue;
+			goto next;
=20
 		pgoff =3D vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
@@ -813,7 +817,6 @@ static int mbind_range(struct mm_struct *mm, unsigned l=
ong start,
 				 new_pol, vma->vm_userfaultfd_ctx);
 		if (prev) {
 			vma =3D prev;
-			next =3D vma->vm_next;
 			if (mpol_equal(vma_policy(vma), new_pol))
 				continue;
 			/* vma_merge() joined vma && vma->next, case 8 */
@@ -829,13 +832,16 @@ static int mbind_range(struct mm_struct *mm, unsigned=
 long start,
 			if (err)
 				goto out;
 		}
- replace:
+replace:
 		err =3D vma_replace_policy(vma, new_pol);
 		if (err)
 			goto out;
+next:
+		prev =3D vma;
 	}
=20
- out:
+out:
+	rcu_read_unlock();
 	return err;
 }
=20
@@ -1063,6 +1069,7 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 			   int flags)
 {
 	nodemask_t nmask;
+	struct vm_area_struct *vma;
 	LIST_HEAD(pagelist);
 	int err =3D 0;
 	struct migration_target_control mtc =3D {
@@ -1078,8 +1085,9 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 	 * need migration.  Between passing in the full user address
 	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
 	 */
+	vma =3D find_vma(mm, 0);
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
-	queue_pages_range(mm, mm->mmap->vm_start, mm->task_size, &nmask,
+	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
=20
 	if (!list_empty(&pagelist)) {
@@ -1208,14 +1216,15 @@ static struct page *new_page(struct page *page, uns=
igned long start)
 {
 	struct vm_area_struct *vma;
 	unsigned long address;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
-	vma =3D find_vma(current->mm, start);
-	while (vma) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		address =3D page_address_in_vma(page, vma);
 		if (address !=3D -EFAULT)
 			break;
-		vma =3D vma->vm_next;
 	}
+	rcu_read_unlock();
=20
 	if (PageHuge(page)) {
 		return alloc_huge_page_vma(page_hstate(compound_head(page)),
--=20
2.30.2
