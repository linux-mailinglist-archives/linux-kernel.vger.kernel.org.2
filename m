Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5644421BEF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhJEBeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:34:12 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22998 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231332AbhJEBdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:35 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1950kPx9029400;
        Tue, 5 Oct 2021 01:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=PZTa6D9SX9SEkEOeCG1FVFSl3jHdiEugyoCq1BYMMw0=;
 b=YIxN+2xhoxT5hDaW5cHhrJl0ctDNEeRGOS6NSez/fVVyZt/NMvj/tqwNjxqC+nB6CKId
 wXVWf4m9Z/S5wOSmeSDtu0npE9HYxAATz7VdAYidWrTG6IUvplP5lTzkh+F5Mu7KMXwO
 nC1OcQP4qV0Rv8Pdz4QDV8Vu0VpamE59Jm2okjqaTAlzoUsmz7kHU6utC4ZImd8BQe2e
 FnU4KVulrwKhhTVJ1Rpdj1vOrjXa18ydaphYV0UlHUkvKSwJE7p6lisUwY0MFIbExc78
 6A4WJ3HEWDTLCnN0wnaWYVqbUYCFvuaME8cD7Stno7w1Nd9kNrNt7a8W2q7/84gA5RyM Yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg42kkycm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UIDM178386;
        Tue, 5 Oct 2021 01:31:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3020.oracle.com with ESMTP id 3bev8w037c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIaa0F8yDtFiO+TrfCTPU8CiJdNlLMzvx9FNLmKBZX0bP35/+uvjggEsKvAuqTwOH6XpxnQRiAEUyvKYNftDdyw7oME/5D9AOCs4w3TyG1/5S5dfGLRwLBZ+xu75Tmtwus/WVwEvc6b8uSdxnOnA5mSqmth8KinjalARUfvJmn2imLZDpx237/lu2+24OK2MyCRh/ohZxTwB0pINFm/jREr4lOA/XHJ73vSGfI0DpGNmIA/JhpbEVpXD5XKpWCPhF26wkqHmPwiN0dxt48C568fbgPnmvb7q8oh2pksfflMT2u26uIrtN+vtGG4ikOzBC5BhCigO8K5e/cenzZ/3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZTa6D9SX9SEkEOeCG1FVFSl3jHdiEugyoCq1BYMMw0=;
 b=dCILC+hCj76fREK278Y+XnBHoGX2s3GRRoH/TiFJNjE59jL+oft0D3MHt+ljikZ8LD/wqMNFpOmNgWjzbRwjT7HQsTWP46PkHRNMWvsWRiyPwha645rTJLlg0dwwLZM3m58nENuLpAVk4lB2496D3ETQVKn+UKDn/iG5rTasAxXPhVY9182ToMMGT8X030JssrBJVo4CQH42AQFldZg8qNYNEhJ35sHkJoWdmQe/L4RV/pzxLPDAoPZCbG5hubB+q4joRyOBEy31/Z/4umljEA0lF16o3+IrJc3h6fhuNXhlUXpNAs3J1degrSM7J7FgU4jJVVeKa1P9p4LJeCGh+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZTa6D9SX9SEkEOeCG1FVFSl3jHdiEugyoCq1BYMMw0=;
 b=EWRgfRnwJv0LuOHZ3ygY9mDtRnvrfCxvYb7Qu8+L2/BhnftkbMwojOz/Cx51lusMk9By51R3sA0IVMxyQSxz3JreyZCQXDAuElmNcV6OVRmq3VkjxZEgzyJ4MM04YLHv64zUxGTf19wz3YQG6YQVGhuIBjpvyVqhCyb5pNUbYuw=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:22 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:22 +0000
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
Subject: [PATCH v3 38/66] fs/proc/task_mmu: Stop using linked list and
 highest_vm_end
Thread-Topic: [PATCH v3 38/66] fs/proc/task_mmu: Stop using linked list and
 highest_vm_end
Thread-Index: AQHXuYiiZrsgpDNwFk6QU4aK7lS2Hg==
Date:   Tue, 5 Oct 2021 01:30:53 +0000
Message-ID: <20211005012959.1110504-39-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 8592d896-4f14-4f1c-e029-08d9879fd6ae
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50442B0C8F7962C9ADF7BF0FFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tny5TykwF9Wk5M8GCgwn4HR/zSJQOKQPfxCnV94Ar+skCHbk70tjKhQfVG2j8y2OiJIqBuI9iAJprdYJtVuZ70+GWQIZWU4zGMnevKd9uLk7M1jmn1kB/1kEPpRkyUdWwMlqqPF3Y2D9WBdGBJioiXfl4hMRyZuG5C8vFCMEp27LKrFKE0DQo+gUvp+cO+RojWY6+3E1wBmY5S4BlRNa1ZSkUxUwzFHbixcOpZXqxh+mhC5PVKdmPHRUrCDOQDAe1owFPHNKrilJmMWZruwRSWsvgn0Axed9Mn+k22NX9Jh7LpBsXlP6dmF3TskhBCbiCK8rikx5UEIDxafari7Ig+qMuMPcjJ1q2ZI90uAien+Z0qszYsb+wa+P3m3Th8pOK2FvIAfStfxj456M8Rx9dSs/RRyrjpE9FdJTAF12AUP4f09E3X7Mqfh4JFjqdo6oL76/kN8L8rQi++CgcGb97As5J1fiucLvu6NoK2eo4tUz/N3moz3g2tYt78jf6iRwCdf5nWYQnWUhtJny/snAYRNA6/HEHnUd+3CelMRSC8aR/911ieP6oSnwG6/4O9sl7I4or0CT5CVq7kzfMsGx3XZfa1lqkKDswXwgU7H3EOM2tqhVmBRc35jbaintY5Gq7B3JYqA/UwzkXN0Jmx8tQhGEv6krAslDynzMq66f5Fo4gUG+FaqNRlE4n9KLclVt++8OEQ3Lakw6laM2O9hK+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?knvyhGOQV775ir23XJiX1GYZNgjGSaSPq77rqFnBzUHrtOWucNPIGAXtra?=
 =?iso-8859-1?Q?jCh8N7kHBtDDwaTKmROs9DVyErLBZhUeGADPzxsqw26g+H+ZCKVoLXZbnc?=
 =?iso-8859-1?Q?1R8HVc+LeVfL0lk8kr6sfhbT9xo26jsF4wrWRI3dG6asqqDCKWEir4MKzB?=
 =?iso-8859-1?Q?wY3nZB2KpuBAB56DMjJ2rGG9va/AYfhWIie8SYOtnGpOaloo1PrqFI+/LA?=
 =?iso-8859-1?Q?zpHfcq9TYmx1N7M/MXNZyXTmAdhlbdFeGPZHMSKhfYXI1J00HeiO2ewqaR?=
 =?iso-8859-1?Q?huGhT2IGuGNXY4IT6Vm+RrhQFB167MZWC5DuHrhpS57xtePbaoRCbT3bSu?=
 =?iso-8859-1?Q?xQrndMb3EOO93rSmsyfqWs9dR+GkNVbp4ut1BhnGRr2CiN7KX02e6T218i?=
 =?iso-8859-1?Q?WXnTdTBmy0G2fMO+YWXs4gV7HIQd2fSd9xuUAIjTf9D3nbUBuQdyiOnzpQ?=
 =?iso-8859-1?Q?26VF7kFC0c1mWfAMCHMNybGa9Y+RieMqUAQ5tFzWDnfF0pCrgqjW8EoCuX?=
 =?iso-8859-1?Q?6Qg6ttXMcvPsAHLvXr09ilNL44hf3q+7kPx1/Yc3lSrTSOGvUgMCjgl1gC?=
 =?iso-8859-1?Q?PfThu1W4cpUU0wdu6onEWN2FrKkvcCnBQ05iTEFF6g7MXaz/a9cePWckFF?=
 =?iso-8859-1?Q?7ejcHLlQNcCgFgXQjeWlGIq6ZNFbY8oWFuWxj2KZjJcqyEP+SSqZo/mlKf?=
 =?iso-8859-1?Q?3AHMAiCLP3LaIXPvQhoYJViBoRG/ZnZ1+yXKDCRvPHxiy4Je9ApvGuxLsN?=
 =?iso-8859-1?Q?/+8Uv7XCYClcHDfTSWHFAySZGRY8wm2bIbUF+AZvA7zKaS87m0/AIxDws0?=
 =?iso-8859-1?Q?Q61l+dH1OsFY5m99qZYA0cVoUSa0HDbkX8uuSGzdJRMKbFBpJzWhDLSp9E?=
 =?iso-8859-1?Q?ps6901GXUx2vFdyMLAeG2E5x+D0ATzSKRlljsoqCd2Qpux89cFRB7NaMKJ?=
 =?iso-8859-1?Q?fAQOZGLUpnE+Rl3MPBRo+pHCiFUze6fv84RcJPBp6DPpLGNbJQDnPkEkGP?=
 =?iso-8859-1?Q?P2c/gkOXpRB1neJV1ORxAaj8Ff5nVKZUsv3o4gaUaCso0K/VUAX+G9knPl?=
 =?iso-8859-1?Q?rcoLraAfDEvvzB32sRa+pExMhtZsrx+YGsxYJt9OmuSuurGoGSxFa1beok?=
 =?iso-8859-1?Q?lRIAPZAXdAaxHAJvu0REkyAQapnamsd4RNTfg3eULlELaWvARcN6FsKYq/?=
 =?iso-8859-1?Q?I3O8m7bq8nNxSd55hLbBWy9Ylhde2nX8I5IQapy+p3S49gP8e5ypBk5FKO?=
 =?iso-8859-1?Q?96aCtvdSWGChsdXICubIGwQV+vNuPo/7Mx/xnSGBaSe4oxXOUQxfId5MQG?=
 =?iso-8859-1?Q?1tX3YyPPB8j8CvD0GPJjY+gjDtpOuT8m6uo9yLXv6dlotvv2YzQ/rQ0QxY?=
 =?iso-8859-1?Q?+Jw9pz2dGD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8592d896-4f14-4f1c-e029-08d9879fd6ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:53.1035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EXWgpjCBv+RjUAtxSa7bUSTgkv9jN/XJcfQUZJvOgq+UPpF5pcB1uS3jjd4nA3c/Puiza21jA6QgBa4qQZb3xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=976 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: AtWHIA7XmXvg33ay-CieqmA_NrpRuZGW
X-Proofpoint-ORIG-GUID: AtWHIA7XmXvg33ay-CieqmA_NrpRuZGW
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
index 63d07414d583..e2482ceab6dc 100644
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
@@ -839,16 +838,16 @@ static int show_smaps_rollup(struct seq_file *m, void=
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
@@ -861,8 +860,14 @@ static int show_smaps_rollup(struct seq_file *m, void =
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
@@ -871,12 +876,15 @@ static int show_smaps_rollup(struct seq_file *m, void=
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
@@ -914,7 +922,7 @@ static int show_smaps_rollup(struct seq_file *m, void *=
v)
 			 *    contains last_vma_end.
 			 *    Iterate VMA' from last_vma_end.
 			 */
-			vma =3D find_vma(mm, last_vma_end - 1);
+			vma =3D mas_find(&mas, ULONG_MAX);
 			/* Case 3 above */
 			if (!vma)
 				break;
@@ -928,16 +936,16 @@ static int show_smaps_rollup(struct seq_file *m, void=
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
@@ -1225,6 +1233,7 @@ static ssize_t clear_refs_write(struct file *file, co=
nst char __user *buf,
 		return -ESRCH;
 	mm =3D get_task_mm(task);
 	if (mm) {
+		MA_STATE(mas, &mm->mm_mt, 0, 0);
 		struct mmu_notifier_range range;
 		struct clear_refs_private cp =3D {
 			.type =3D type,
@@ -1244,19 +1253,21 @@ static ssize_t clear_refs_write(struct file *file, =
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
