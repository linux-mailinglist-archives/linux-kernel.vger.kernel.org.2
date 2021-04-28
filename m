Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775A136DC17
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241077AbhD1PmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:42:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23022 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240629AbhD1Pif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:35 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFTUts018934;
        Wed, 28 Apr 2021 15:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=VdY1ohNbkbZdYceEzlpKzg972JHpv4RY9C2AJ0OO9TE=;
 b=gqjO0ji6ES74PPT+ohCaJFgXTr+EXqskhMUhUTEOIIdf2OP5iMVZRXAnJE2FUrXu+yLg
 XOqs7PIm0+knhg5glDJhKfTGilnSyvWESxMydlb+NIDQchhc/ZbfLqv6iti3xvBFA8MO
 vw7BWU7/LSb/uRHEOffs4aQYNbu/NFlNvTRDTFQMDg4T4lb3Sk3cKZ0Xfq54OsGmbYaT
 qz/hVJFocYy3Ym6p9DDuH939lMi03ib0h598Pes2RIqz6VzVUwZnom0w2xprHd8QX6KW
 +xud5xitU4TU31/YHxNaemXEgPCVp1mwMXQieIe1vY+HgoMUPRHW0mc0v1vh14vGrM5R pQ== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:31 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFbPcg024423;
        Wed, 28 Apr 2021 15:37:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 3874d2765a-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfDBh3cZNC6NZsB5aOBZFQo1Q4BsEakocD6H0pOwyoJ0hQvnbfjWwfo0Ig1st5qZAZe/oG8VwHCQNgAH23AVBboeEU/hCbn65zqOcw6rf9RXsFI7xOUYoeDlboHPwI2bOfnMtFMI/m3m0OfuowhQtje79Pv2ULEVLcGwS87PrM+CiTodigHmdl168riry3RCiy3FQdGR+nqBO+shgR83pdqODs2EpqEg1t9oqvICOdjC9L1MB8uIyqnpFIunEBednhJiyUmDvxxHKJczdSBVhfPPRyApfmaEx4JfBpzWRZOvZm7U2rohYHR0cXTYYpgyPvzgB7BVTgzaO57n6l/R/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdY1ohNbkbZdYceEzlpKzg972JHpv4RY9C2AJ0OO9TE=;
 b=kUgiz97PX6CaLK7gr+Re1bZ71l9HK8IjDLHck8EnI0mafYo/bODpS1cC0pxgwkNwZ53bfGyuwvDaR/3kT3QaS5mYERV6K3oik7Fjh/DaXfg2PK3OK++U/43yv577ixD8wVE+/YR2XVD4y7kyWLdoyUyA09PSSXp62rZrOouXE1F29I3JpOt0fr9FuMlcDGs87sGt8hmIElrTTsfhurNbc2LsgUBTjdw3NqxcMC+z5ltWhXuW/dPg8TJevWZHkSI36c/8KBc0D4BqJ+a5e6C6+Iz4D+0IbkXVr0CTwg65Hj8UUdd6lrWJus7SQn0SK2W7ADUJ/x0xz16+BQ8uCQ/saQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdY1ohNbkbZdYceEzlpKzg972JHpv4RY9C2AJ0OO9TE=;
 b=ltTwFHHLaE6/s3ptQ9vB9FtO6xu88DLBQHJyj9B6SWTwRBjT96OoB0FFGmHLeVi10CPYXSbVahfenpSn9TV1tkURYV4Gmzb0kmc1S3Z3Gib50D9XKpKbHyrhc2CP3jl4fxX2OiYUGYIniuWdOJ03AydN79/zBGltLo/vSJW0EQE=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:37:26 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:26 +0000
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
Subject: [PATCH 80/94] mm/mempolicy: Use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH 80/94] mm/mempolicy: Use maple tree iterators instead of
 vma linked list
Thread-Index: AQHXPERA3MQJrg85BUCOtrH/ATfU7g==
Date:   Wed, 28 Apr 2021 15:36:27 +0000
Message-ID: <20210428153542.2814175-81-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: c0beb874-c672-428f-65f7-08d90a5b8677
x-ms-traffictypediagnostic: CO1PR10MB4548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4548FF19CF642CB1D08C8EFBFD409@CO1PR10MB4548.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lwi2giB69pFmIk6sQpSFVUptUDAAswRNexp/Vc4QlknJS5xA0//8xEzNCpYviqUeCUkFmyAy+ZFE0d2zAfpxOrs0bm4gCP4tDYWvmL59XGpkbdhaUF+q4QJSS2PJg7S4Mo8DmgpXsgQFBwWKLQgxjS3K6OOSJ6FABsHIIBLc6TM81X77aqB0jfnGWD9WLM++/KP6N7WGZ8p4VBvzesIa1IJ0XXH2qYIypnTjOyhZg0DIi/t/U9laCZnlxXgj8UmeHvdYLop253Hw7/hNOhmGOET7V1DMTXwos0tGrrvfUqKKrWZnNmcuTYOFs2coRhUiIp9P6Dzv2aYjlvGrDXgQhHEAfh1k4WHgEh+rxsa6hkvvSbailq9Z4lozx2AbZupm+ZR1yglZpdkeukjnhhIhrkZ40bOf2WwbEzuSgTtulDEM/x+cAN/kJ2gt8+GKZEDxSKBt814QHnklH50aecQLZbZHQ2+umwpPdS4dOVQjc01eNyLHOnVa8DdyOYxZMXR29KsvOq4oc6IpC/cCeCDfAlvXO2aBcAY7l5bW604UWbenM4ywrVINUvhVXydjHjgldBkRmjardxnm5MUfwiF6NlE/ahlmXryq5IyDmHE5mhc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(6512007)(66946007)(8936002)(186003)(83380400001)(54906003)(86362001)(478600001)(122000001)(4326008)(76116006)(1076003)(107886003)(7416002)(110136005)(38100700002)(26005)(2906002)(2616005)(8676002)(66446008)(6486002)(71200400001)(5660300002)(316002)(44832011)(64756008)(91956017)(66476007)(66556008)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?jYkp5e6FKurJxHJ3Lz45HG3q+HlDbYUAjn7K+jYiBBdD3+ACiff55p7nfY?=
 =?iso-8859-1?Q?6kqiZc82P/rqqeLk9X0xUdgfF4WZRcg+esmB5ep8cfneT8+s/RNTx/KVeF?=
 =?iso-8859-1?Q?Tmryqa/9C1hPQiPPynXSENweYFSxL/Jr+HHvIs1TavewWU7LWA3eu5RY6g?=
 =?iso-8859-1?Q?5733czzDVUN4E92qB1vlaYmJ47+kfN2hBXLC+RFEpnLlC1LINdka6t0pNh?=
 =?iso-8859-1?Q?il6c0ymQ3TqeoNuqYIF+27+waflhdKZms0X5QaH6K88SctCxonOi+EpTxV?=
 =?iso-8859-1?Q?l9oeH2H6q8UlaPz36bQoHQ/AzbDfcouMTtWYotBZbwtIiUl4GnuWwtMQhM?=
 =?iso-8859-1?Q?F7b/mMBhm/pneKxImgqHZDSTPfx+4fSFEr89JpPVXFAbai4z7QLrmBDSZp?=
 =?iso-8859-1?Q?T046sgQKFbcT24Fa6dm82LZeiCIZ9ke7MZqjfuUpH9iyxXmjJsIwzkf3fu?=
 =?iso-8859-1?Q?SOgUM/93G4XCxwZ5gDbGkCkZjnU9M8c0qxQLVJe57x8PT4hJ5uwSbUuY9W?=
 =?iso-8859-1?Q?zceGhNP/xENoSpvTTI5I1OI3EX62KJYSysRD5KhC5xUuRJrTXqsbHPBLfj?=
 =?iso-8859-1?Q?8HMj3hMjrS+mVEFg+cjMVW0RIylzoTA1qavy1HlAFXcL2oQ6vG71Age/sl?=
 =?iso-8859-1?Q?uWYHIQhzUSO8RAo6f5NUnojaX3YjLsk6B1UPe8WMlfAlm4wgUOTD/5py2l?=
 =?iso-8859-1?Q?Yap6smp7pFOZY3lXvz72ysS+7ZqsGTU/lvhqorITTLfN7aRTuFXjaeGCl9?=
 =?iso-8859-1?Q?rnEPy+xOVuLlbL4Z7/2oUyqH1x/8REmc/Zo2hIjaycmytZuHPNnJXfXVYy?=
 =?iso-8859-1?Q?IIa2oANp3YriHYWDaES1LY/7eoFrkawMT1e6grPPMNo6Kq4tExg3PMzGPe?=
 =?iso-8859-1?Q?nu15Fw8ZotQVhkhRyEG68/AsVNjJmXDqI2L2r7EqyYZojguCE3XCFxB9IC?=
 =?iso-8859-1?Q?cP1x0VZXjs2HW63wW4UgNj73Rtex1yCKPa9n12FSngHKtB2+JpQhcjV4tq?=
 =?iso-8859-1?Q?V5+N4eQ2HHwc1bNABSvk6ujN8woqY4HMXf5tEgglX21UILMwUhMGzrQYEF?=
 =?iso-8859-1?Q?qgea3WnTcoOp2RD9yCbAPeOC6+7qZ42fuib0ZNOkQcw+snbpKhapJN266V?=
 =?iso-8859-1?Q?n8vasN1ZnbHi6zQzjijI1V7Y7mSe8GvOOnX0QEBd/WcLCa9gb8Du2q66Xj?=
 =?iso-8859-1?Q?GumggBt0R8+aR1Oq9Bfm8zuRZNa8xesBZarcpWK09G2xAyRXtNCJhYZc1i?=
 =?iso-8859-1?Q?W66RMNGihjlfI3H+w5abvn7Ki2owNDwv1fIafYzRfYNdLHWGK/KPR5ANNr?=
 =?iso-8859-1?Q?1Xv8ZvJlDOkZ+jIa9z43xMj62JcUadBIHNoqfCIIy7PstCzCk8ucN/D49J?=
 =?iso-8859-1?Q?HKfe4EzGHp?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0beb874-c672-428f-65f7-08d90a5b8677
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:27.0391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JSOsn+kTfpT2tKTCbozVX+pgarvU8ju/adgF9IsP8wA+Ecleq4eMgYimm0m3FAeoWs1L+N3kj5RoyYyAaV8kBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: 5iEcjp_c2laoZmzGRscTupBbum4_pJoa
X-Proofpoint-GUID: 5iEcjp_c2laoZmzGRscTupBbum4_pJoa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mempolicy.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d79fa299b70c..efffa5e5aabf 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -404,10 +404,13 @@ void mpol_rebind_task(struct task_struct *tsk, const =
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
@@ -671,7 +674,7 @@ static unsigned long change_prot_numa(struct vm_area_st=
ruct *vma,
 static int queue_pages_test_walk(unsigned long start, unsigned long end,
 				struct mm_walk *walk)
 {
-	struct vm_area_struct *vma =3D walk->vma;
+	struct vm_area_struct *next, *vma =3D walk->vma;
 	struct queue_pages *qp =3D walk->private;
 	unsigned long endvma =3D vma->vm_end;
 	unsigned long flags =3D qp->flags;
@@ -686,9 +689,10 @@ static int queue_pages_test_walk(unsigned long start, =
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
@@ -802,28 +806,28 @@ static int vma_replace_policy(struct vm_area_struct *=
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
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
-	vma =3D find_vma(mm, start);
+	rcu_read_lock();
+	vma =3D mas_find(&mas, ULONG_MAX);
 	VM_BUG_ON(!vma);
=20
-	prev =3D vma->vm_prev;
+	prev =3D mas_prev(&mas, 0);
 	if (start > vma->vm_start)
 		prev =3D vma;
=20
-	for (; vma && vma->vm_start < end; prev =3D vma, vma =3D next) {
-		next =3D vma->vm_next;
+	mas_for_each(&mas, vma, end - 1) {
 		vmstart =3D max(start, vma->vm_start);
 		vmend   =3D min(end, vma->vm_end);
=20
 		if (mpol_equal(vma_policy(vma), new_pol))
-			continue;
+			goto next;
=20
 		pgoff =3D vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
@@ -832,7 +836,7 @@ static int mbind_range(struct mm_struct *mm, unsigned l=
ong start,
 				 new_pol, vma->vm_userfaultfd_ctx);
 		if (prev) {
 			vma =3D prev;
-			next =3D vma->vm_next;
+			mas_set(&mas, vma->vm_end);
 			if (mpol_equal(vma_policy(vma), new_pol))
 				continue;
 			/* vma_merge() joined vma && vma->next, case 8 */
@@ -848,13 +852,16 @@ static int mbind_range(struct mm_struct *mm, unsigned=
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
@@ -975,7 +982,7 @@ static long do_get_mempolicy(int *policy, nodemask_t *n=
mask,
 		 * want to return MPOL_DEFAULT in this case.
 		 */
 		mmap_read_lock(mm);
-		vma =3D find_vma_intersection(mm, addr, addr+1);
+		vma =3D vma_lookup(mm, addr);
 		if (!vma) {
 			mmap_read_unlock(mm);
 			return -EFAULT;
@@ -1082,6 +1089,7 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 			   int flags)
 {
 	nodemask_t nmask;
+	struct vm_area_struct *vma;
 	LIST_HEAD(pagelist);
 	int err =3D 0;
 	struct migration_target_control mtc =3D {
@@ -1097,8 +1105,9 @@ static int migrate_to_node(struct mm_struct *mm, int =
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
@@ -1227,14 +1236,15 @@ static struct page *new_page(struct page *page, uns=
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
