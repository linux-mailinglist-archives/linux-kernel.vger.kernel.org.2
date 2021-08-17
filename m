Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D861D3EEFA0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240568AbhHQPya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:54:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3864 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240406AbhHQPtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:35 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkEMa023526;
        Tue, 17 Aug 2021 15:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=s08kbkB9kHRbJzhQZ4uwiACXSwxCUbOEWA+z7QCJvT8=;
 b=CxDkeBqY9e8w7NVJFuuEknzCQz08wNWAla/JP3d0ajKZZZFukqmts0khde4GaG+bUSdV
 0o31J7yVmdN3pgI9/wiKno2iMkv+5u3AIfHgJgH+JOeMNu73ZvUWvpyMP0aJyvG56h+D
 abOfOcFZkT6rOqls/xsNkTPbNJ2iMa8G1Zoi1hH0zqKHoGFuM4KlL0xtVzBdwa9pptfo
 Mts4X9ILPKiNmVlzbbheDWJGTPniITjS610eyu9GZxHz3db1ncCfG/AAJ43DTiYaN7Oh
 7NV+M7f1xKWpusSTXzYQFWtsFAyiD6pxFdzZJ15yjgqkf5W2PCkP/UFLMPuh+RjVdmec UQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=s08kbkB9kHRbJzhQZ4uwiACXSwxCUbOEWA+z7QCJvT8=;
 b=go3gN9JEoEOJp+rEOQ8/fjcNo23K3OiOCaUfV93LLzU2RhPDnWB7Gkxyrp6zZ3T6tufU
 fes9uuNUjooDODpnCVPMNP+K8QdT4sHxBgA2j+awEinuu9eLY9dHNZBX/ENzgRqx3B6G
 5TCZppVomhbddJWZ/J0Mg9mcjbeEuCHGe+HFyhZn4VxZtK7y4PxwJHhYv9h8u+cU/Zij
 /VZ82oglVROP+njnL4GKUzrYM3Y2mknOEgn2tJU7ca2YUjxbVW3+3gN9whawoUcuEDqF
 uvLhyGmNztbrzXgA8nEfEru1SZsMX8J+ZL+a6aSh+FUjHqDliiyiAybGzzoQ5/reI/rc Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd4keg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFj3Ob174039;
        Tue, 17 Aug 2021 15:48:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3030.oracle.com with ESMTP id 3ae2y0d2r9-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKLomIFLE5DjmjQr/yGsfmZFRDc8Nqj5++MpGxba2Z3ts7CcU8S8QnxCigy6YcrZj+CwAjdJb3l5ufhJXe/F2AATD77UxRc/zbqlWhfosNH1GfgCzumD78vObXTrCXRa4neWoth5rKsu/pTsAxQtkYOYB/1U6l3fS/fcVtLH/dGOgK1uzKHQk9Xq7TibeU/0l0Ctcrto8gXrfHdRZvvF/2bAOBLe5OiNDz4fL1sduYdFYYUTmuxJP/HEBjGfZg/0hsjbdgp2ses4jpL+TmZ9h7OMe5bU7TCKjQb59xIcRQG1G/9K7dZ9BqZfvu1nAi/bkzZ3iE3mRU7vicEJVGL3Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s08kbkB9kHRbJzhQZ4uwiACXSwxCUbOEWA+z7QCJvT8=;
 b=QfgLahl0tb2+Y+IBMfrUnpjMq7AnJXLLb2EbVw1G+Pwx4ly1yPNX0Bp7KO0CLe7x6JS6PuJyPMll6ehOhDR8oQlWV0sMNAALp97Mh+KMfwMB8JRXfMrjIBuPhvCcaspUj3kXOePFJTNHB3ruXbQFyCLxhjhvb5Mj2CdZpk/ml5ajgvDa/RXhy4ARNA4x1mv1oVbJL/nonB9/FlWChZgj1lCs+qCIB3xPRH7e05oUs9kMbnuarYrsM3Ad+Cue2/sIPUHbiEaOvnHebZT3dox1fYTbndCYUvVpiQvAXSFd8rJSnC1e+5elQPUbrmLEU0Rde95RoE8eBimh4XGbWuibaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s08kbkB9kHRbJzhQZ4uwiACXSwxCUbOEWA+z7QCJvT8=;
 b=Br9G2VBeMBz7G2j7Id9Ow2Ze5bzyH9zirWTL142w+0Trnr66WSh+l0d+0pXBjI8OhQilWv5JIyqoOMywpcJz0faXc1WsDDmz4ayiOj1QoVMa867M+4XZIrbdLeEBuQjVkQ5TvtVVOkrffdImEWb3eofD3I8Vyc90RVjnmqDzZpk=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:53 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:53 +0000
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
Subject: [PATCH v2 37/61] fs/proc/task_mmu: Stop using linked list and
 highest_vm_end
Thread-Topic: [PATCH v2 37/61] fs/proc/task_mmu: Stop using linked list and
 highest_vm_end
Thread-Index: AQHXk38rkuZnJubpMUWXFEUFvFxaTA==
Date:   Tue, 17 Aug 2021 15:47:23 +0000
Message-ID: <20210817154651.1570984-38-Liam.Howlett@oracle.com>
References: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
In-Reply-To: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b10154ce-3194-46f5-c166-08d961966046
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB42364E99A99309C2EB166AA4FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oB8DGvqXL7JCuRwsWTnoBvXN+UCx+Uqs3xSxeL7x1lGSAwv1YZAY0zgkfSvziW0XixE/OtuMhRXZ4t9fn5C2yHOmgyLUT8I+fl58TM+kS9q3GpEAxp8ZiNGX6rrxGyGwC35/2dH731JINMInITOx6IKByl30F6Onu4wL0pz2wjeW4aXFTliFbaVGYtPeeeeKHKXZiP3fb9VhI5TqOvUvsEBTx4bibc+utsXjes7uHwuZ2rd8/qQqcvKPSqkFr7f2Ss2GZupUaj2Gmv5aqMbjamWuLFlJPUKPEqpeKdsOw860F072gp1fitg2VcAdk+i0MLBj1Udzginbw4gnGoSiMULkgzwifkoQIpnHpYtm5fE8Cm+PSTBXd0xdz4RTncHkoujlNk710Q2W/wwVX4/8Ra9OFcdc+GoTwdGCNxpIPAH/SRuSynwYpNL+8iorPlCb+ubeXG6DGFrLvtRy5NhkPzF5yWWxL2HlEMFrdu9pzHIG3EOlpK7aMsSna3uw2F/1TZevjWGZ9Rnhv/aL0MrckI/+FGqN/rBr9f28kAzdFxhoXcxxyKsIocB4Ems5Sts/YsGDPrhUNmBreYJNDPGB0q03kn9Pvl/PhkMe+ncAHT5ZjkpsIRIjxZJf5q4pasmDTWE3uDPzleXmyIQHb8gvf0P+g22x0DcPGob1U12gJmmxJAmAGqYaaRJ3SrhIltUwlCp+xB1QqKUTUfSba8SrcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6666004)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+wPFyh9IdbL3488stnLIoWv1IcwTzMBrIlRmxTg6dZZON4AjEhgO7Lg4c6?=
 =?iso-8859-1?Q?rs/nPBXoIqay6HjX5c3xBf8aucLH7bZETIDlMBv2RRfGHBXQEkBFUtl2EH?=
 =?iso-8859-1?Q?BeNFT67a516HIPWnE7QvEj4Yrykz5u80Rx6Nn4CXd5xd4n3VzWaHqJ9XRL?=
 =?iso-8859-1?Q?u8HU/6YGxzikMRUE1x20/Z/h2yjCvpwLbO9EW1EyR1Oc8Ibu4LnWg0COOU?=
 =?iso-8859-1?Q?iX1JperMhvxYdlW2eDDEwEnxvYAk+To1SS2VLKb6S4stk8LRTdb1yr5Tns?=
 =?iso-8859-1?Q?aYhpUA+g1r4H/MkC0bAwX8M49WPpbvErWyNcTMlm7aQnsJHH8ybVx66BW+?=
 =?iso-8859-1?Q?72ZefLqB1G+88wqyG9CZZO/Ku/WDH8z81CVL1knhjZrW5sb0cUXM0FSWE4?=
 =?iso-8859-1?Q?wl/HLbRW3Z5uTO8c6XpF0IZBNQGHIm7ghaeNYc39MkAk3ShfQJ4cj8sxNw?=
 =?iso-8859-1?Q?WGfpZqNvydNEAyJxlA0DLp1FZy9+sccKHePf3g1f/IvPMPpA/kIj/JQaQf?=
 =?iso-8859-1?Q?wTkktEtVy+l66KM2vafy/mXPP1YvFlKXdvuB3UY8L+HWDyoWaeltCZwZBp?=
 =?iso-8859-1?Q?ufqBgbiYRiM5xDV8f2JmeB1Rb1VObvbWI+vaDTrXv9Lpub0XOX6a2fUtch?=
 =?iso-8859-1?Q?ZwMN1wTFEY6yo8Zv9odhNS9TAxgIUHyRIUibZmxEFQ+FlKvokjzxdjixaz?=
 =?iso-8859-1?Q?/swBkaDomXEtfl8uxh2nwgkborzYRxZv7auqpFbHO7VcH+ufABhUPdxRpA?=
 =?iso-8859-1?Q?Als/JwTBsdI7U+PKiz1ivkxSsvSMYnY701jPBHnRWbtYs7vG9ke0myakrU?=
 =?iso-8859-1?Q?ej4rWydpF4j1ag8vXK3LX09A6upmhW8QKp28KCzBZ8oRNiNJSaRkoziBf9?=
 =?iso-8859-1?Q?kA7aXU+jVg1HmXqxNUIkOhHjo7VTzRpANUCF+kwaJvNKBjCG/ZUzJVXySI?=
 =?iso-8859-1?Q?qaXn9nl1wGQZbr7654TaovyiuXhbEiMNIOxKe2HRlYIIVU8gkSOXDIsxLd?=
 =?iso-8859-1?Q?hLBokiMt1PERMpscMSJGtbVv9R+a61mjIS6keHOTbfNpeXykNAtv6pWRH2?=
 =?iso-8859-1?Q?pWOb1j7ozKE9lm2rRrzUj3hciZC3r8v8bqb5oJ3mLRZaNtONEKUQR7SdSu?=
 =?iso-8859-1?Q?3gZtuoEnpxEJuX6Z4pMmqMAwaQyPkaBupSxHY/BEwVnoBFLa7Eb0Sg41ej?=
 =?iso-8859-1?Q?LhTRWQ4EDCDffc3f7Y6EJyv5V0KrJOhpEvQz/fZRyfdRL84hLHIPybVkYS?=
 =?iso-8859-1?Q?pJDaDB0ZUcZK0glYV8gkF2zHbeTdDDQMavLDKOVszrt5/1d4/+T75D54nk?=
 =?iso-8859-1?Q?8+64bozr8Hl/c5d8yHOSb6MTQy3Z9kbdYJM14eSKPWIRYTNJYt4FaZRVPY?=
 =?iso-8859-1?Q?sSZ74PqNmD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10154ce-3194-46f5-c166-08d961966046
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:23.6076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vup7ZywyrfHJIXhKLwhzC2m+JIQhtjAvotuc+ISnKxbIn8TQeu34zzvsdbBYGtASMi9Y9WL9KXMm4/gp+w7IXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: 6wLUSumkP1E4IqUzaoBopsjRat0mhLAs
X-Proofpoint-GUID: 6wLUSumkP1E4IqUzaoBopsjRat0mhLAs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove references to mm_struct linked list and highest_vm_end for when they=
 are removed

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/task_mmu.c | 47 ++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ab9b4ff44b54..bea4d54ae90a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -164,14 +164,13 @@ static void *m_start(struct seq_file *m, loff_t *ppos=
)
 static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
 {
 	struct proc_maps_private *priv =3D m->private;
-	struct vm_area_struct *next, *vma =3D v;
+	struct vm_area_struct *next =3D NULL, *vma =3D v;
=20
-	if (vma =3D=3D priv->tail_vma)
-		next =3D NULL;
-	else if (vma->vm_next)
-		next =3D vma->vm_next;
-	else
-		next =3D priv->tail_vma;
+	if (vma !=3D priv->tail_vma) {
+		next =3D vma_next(vma->vm_mm, vma);
+		if (!next)
+			next =3D priv->tail_vma;
+	}
=20
 	*ppos =3D next ? next->vm_start : -1UL;
=20
@@ -840,16 +839,16 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mem_size_stats mss;
-	struct mm_struct *mm;
+	struct mm_struct *mm =3D priv->mm;
 	struct vm_area_struct *vma;
-	unsigned long last_vma_end =3D 0;
+	unsigned long vma_start =3D 0, last_vma_end =3D 0;
 	int ret =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	priv->task =3D get_proc_task(priv->inode);
 	if (!priv->task)
 		return -ESRCH;
=20
-	mm =3D priv->mm;
 	if (!mm || !mmget_not_zero(mm)) {
 		ret =3D -ESRCH;
 		goto out_put_task;
@@ -862,8 +861,14 @@ static int show_smaps_rollup(struct seq_file *m, void =
*v)
 		goto out_put_mm;
=20
 	hold_task_mempolicy(priv);
+	rcu_read_lock();
+	vma =3D mas_find(&mas, 0);
+
+	if (unlikely(!vma))
+		goto empty_set;
=20
-	for (vma =3D priv->mm->mmap; vma;) {
+	vma_start =3D vma->vm_start;
+	do {
 		smap_gather_stats(vma, &mss, 0);
 		last_vma_end =3D vma->vm_end;
=20
@@ -872,12 +877,15 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 		 * access it for write request.
 		 */
 		if (mmap_lock_is_contended(mm)) {
+			rcu_read_unlock();
+			mas_pause(&mas);
 			mmap_read_unlock(mm);
 			ret =3D mmap_read_lock_killable(mm);
 			if (ret) {
 				release_task_mempolicy(priv);
 				goto out_put_mm;
 			}
+			rcu_read_lock();
=20
 			/*
 			 * After dropping the lock, there are four cases to
@@ -915,7 +923,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 			 *    contains last_vma_end.
 			 *    Iterate VMA' from last_vma_end.
 			 */
-			vma =3D find_vma(mm, last_vma_end - 1);
+			vma =3D mas_find(&mas, ULONG_MAX);
 			/* Case 3 above */
 			if (!vma)
 				break;
@@ -929,16 +937,16 @@ static int show_smaps_rollup(struct seq_file *m, void=
 *v)
 				smap_gather_stats(vma, &mss, last_vma_end);
 		}
 		/* Case 2 above */
-		vma =3D vma->vm_next;
-	}
+	} while ((vma =3D mas_find(&mas, ULONG_MAX)) !=3D NULL);
=20
-	show_vma_header_prefix(m, priv->mm->mmap->vm_start,
-			       last_vma_end, 0, 0, 0, 0);
+empty_set:
+	show_vma_header_prefix(m, vma_start, last_vma_end, 0, 0, 0, 0);
 	seq_pad(m, ' ');
 	seq_puts(m, "[rollup]\n");
=20
 	__show_smap(m, &mss, true);
=20
+	rcu_read_unlock();
 	release_task_mempolicy(priv);
 	mmap_read_unlock(mm);
=20
@@ -1226,6 +1234,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		return -ESRCH;
 	mm =3D get_task_mm(task);
 	if (mm) {
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp =3D {
 			.type =3D type,
@@ -1245,19 +1254,21 @@ static ssize_t clear_refs_write(struct file *file, =
const char __user *buf,
 		}
=20
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
-			for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+			mas_lock(&mas);
+			mas_for_each(&mas, vma, ULONG_MAX) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
 					continue;
 				vma->vm_flags &=3D ~VM_SOFTDIRTY;
 				vma_set_page_prot(vma);
 			}
+			mas_unlock(&mas);
=20
 			inc_tlb_flush_pending(mm);
 			mmu_notifier_range_init(&range, MMU_NOTIFY_SOFT_DIRTY,
 						0, NULL, mm, 0, -1UL);
 			mmu_notifier_invalidate_range_start(&range);
 		}
-		walk_page_range(mm, 0, mm->highest_vm_end, &clear_refs_walk_ops,
+		walk_page_range(mm, 0, -1, &clear_refs_walk_ops,
 				&cp);
 		if (type =3D=3D CLEAR_REFS_SOFT_DIRTY) {
 			mmu_notifier_invalidate_range_end(&range);
--=20
2.30.2
