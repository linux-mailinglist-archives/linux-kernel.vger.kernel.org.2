Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7275E36DC11
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240905AbhD1Plt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:41:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:43592 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240609AbhD1Pic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:32 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNedL010520;
        Wed, 28 Apr 2021 15:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=aojRHjAmDWZB31YVUdOjTPD0S2QtERZ5qmPhmsp2Gqg=;
 b=GNZU4+a8ML9C80GnKdCrchJKnAIuUBI5hPc60KqRSJRHumkqrJlMviDvk0nGNMxyUjAo
 gFKLXVordbmObTVqZETqpFpt1b6AXx+zzXnRBfPtfGyxWjaVlTc51YlkUGD9U5mWYxNP
 Y4gLFZ9fEg8YwPcZGOGcIJ9EUSzXKPg7dmdum9rAVtU37IcoB1h5xbgdCDb5+BJYvtvj
 XpA0PrIXwwQE5O5mvsiKVNRbVt14qkhiAR3+SnsxclKom7jPzX+oELYxORJGayGxs+22
 9+r+gNdkkLN0eVMVm0nyEeVYSALxE8luaGYi/64iVd7QO4RIMCWHBc7yGEohtyL7dY9G Cg== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 387891060f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:28 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFbScp033031;
        Wed, 28 Apr 2021 15:37:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3020.oracle.com with ESMTP id 384b58qpxp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWE3zwIT1WeTWmVKIvIIGct04cIW/oLFSTLkjeq5i85LWtll2EEKSXWeq2BfgY6YxTmosLOaHbs78+iklidg7PknvVPwZhk8zSN9lnirO/JR727WK96zdUIOOJDv1+S7phUEG+3KeqIiybJKeFLV/9QXnKSwMyXG2pkCIhAPO9sU7pywPig5ewx17ccd11zE9eLsc7bNkwTeYEXvsnwcaG0blBz1Hc00JS/PlR2phz/5vDQzBdBOAjqaHVzUU4XK0u0S9qg1mWfYBAIqmhDtWOLGkbSjqdE5ypMXeMFl+lPyuYsiG8d4BA6B844Xr0W2l41QQsrLhOUzDhUoJ5OC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aojRHjAmDWZB31YVUdOjTPD0S2QtERZ5qmPhmsp2Gqg=;
 b=Wq1HRIpRMLRfHKZUWgQenleyEhvsfrM8JcqkaKJYb1PnGLjVxScx6fOOBVQhY8rny91Yhn5APV6bcrsj0o9E8nxnSqsYxZ3BoQYbPqXrdpK4MDgc8HMLqBWD6BoH3y+2KByWmGoN8l1H/8C6axVeZGeAJasD2X+F33lbSpIQlSw7xNJJtTFN4eQio34EY0mY2jl2aHeyLw3iQumASMmnc2nhbLRrqyBX/KMyaKepcL3TPgHQjf3e+HfCyVoZIID9sThL7ABoPBHVtbeEH7dA6/J7h8V3OX/uEH9oCscLzv5GbK/saVtNGFmoj1K2qog66aZCB7SBYlArjbLxrMQXcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aojRHjAmDWZB31YVUdOjTPD0S2QtERZ5qmPhmsp2Gqg=;
 b=NK31drPe82B6ogFNEnQD8PrYtjjdXxnVCmVOyVKtKP9HKpkC9bm2wydYSP1yt+nNX3D/hD31AT8q45eqCYIKJetGjXK0Voa/7wM1MlOnMpKgtYNc+boK8ly8pOA+lErUwF1DRoUqBS+2JHhvfkEyPIr6Ai2qImeMo1setUGzygI=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:37:23 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:23 +0000
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
Subject: [PATCH 72/94] kernel/sched/fair: Use maple tree iterators instead of
 linked list
Thread-Topic: [PATCH 72/94] kernel/sched/fair: Use maple tree iterators
 instead of linked list
Thread-Index: AQHXPEQ+GPt/wrmyP0ysDAwuPfKHtQ==
Date:   Wed, 28 Apr 2021 15:36:23 +0000
Message-ID: <20210428153542.2814175-73-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 2d5a1966-7e70-4d2c-b863-08d90a5b84a0
x-ms-traffictypediagnostic: CO1PR10MB4548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB45484C9EFB66522863292951FD409@CO1PR10MB4548.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tov92UsF8yKUwzZ+IK4ZP+/sIC9XByTAuxY6XCAKsk8cuKJDzH4g0XU/SXYiALfKnPk6UKe0Mic3Q0sjkqbBB2gH5kzuNHN+ANKzTJ0q5Spl+/I8sxXKdkRuhuQCL7gD6HKdkcZFWkIbMTIUyDd656VFXyTpU80Sob7+FfHvUHRuC1rdWYCbu4uGGK8W2YppLmSD6pEMOBXdhCJMoVvoUCQqhrEYWZYdlHlgXb7HryOB7fV53B/Qfe3P9+cczI/4Y/m3yvjtAE4T7RIPrpnHBNFgrIsez0XcBr/8UzYmkFLZSArfmA9a7iVWRYI3eh/VYASKHT/pE74CMUTe+a8ZMTnBIpTRDV56fpI9nrH/6WUUmTdutsALSlgj47d1bu1CTaUYb80rKsGvk34A5HX0rHDQr66b63T9zgyP1Jyg+kg0YCPDK1i7fkfLEVxRF5rPyCz47xHSQHW+h4hshtY1t0HesF92B1k5feaFiYokG607U/YXWqvOJENgtTA1kDa3jHLovvm0G5dLRBXNVCOOAKDUOokbOSbyKCQXbjmZNT9OpHXIJ0IS8nZifmJL7RgPTK2lizwYtovH7AdjhLjIduMWrSOehAdGRvuZeJIzFsM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(6512007)(66946007)(8936002)(186003)(83380400001)(54906003)(86362001)(478600001)(122000001)(4326008)(76116006)(1076003)(107886003)(7416002)(110136005)(38100700002)(26005)(2906002)(2616005)(8676002)(66446008)(6486002)(71200400001)(5660300002)(316002)(44832011)(64756008)(91956017)(66476007)(66556008)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?hRC9V3vSu87JEeeT3Zxbt7KvSFp8QUlcO81UGUWAfVJOTS7MSaJwGFLrt6?=
 =?iso-8859-1?Q?DnHxzk9FpxcVs24M8fJ2tRI7mfiN+7VSNOh/v3ncqBC9p8CvAa30atbHhn?=
 =?iso-8859-1?Q?rq2GoFEQsctqjNjppSiTutiMRyBK98dwjamW0hlyAIZJuQ2DFBlcqphMf9?=
 =?iso-8859-1?Q?UGk7fiekaZJiJabUCEtmYpemcSbjBbx6UGyyXyscx1h+uzMdnGTcCvDS9R?=
 =?iso-8859-1?Q?2dQejyZUyXF98byHRgC28Se6JdQuqP/9i447Rl2EQrACwGpoHhVmRaKhoJ?=
 =?iso-8859-1?Q?W4KliPCb2JASykXeTmYXwjj6JK332R/ILRgS1pJFZh4f05fOjklvx5eUcq?=
 =?iso-8859-1?Q?qDHSdhjtQ+PpMtW9QvyPmEgPZitmkA31p/Ek8w7+1qLrqBW8ihM3jPd4CK?=
 =?iso-8859-1?Q?dTB/XHvDqsamFNjZveqyPDEtBW4KC71kyUBSW2KM9VS1bqZFKlx0grA/R5?=
 =?iso-8859-1?Q?KmgbGi5WZgdrAs7YAtqJZudYEOD7U0/kInJjz/MHgujO89VfCX7vKVbrqK?=
 =?iso-8859-1?Q?88f+k30j+oSOX11cbjg1W+Cilg6ELchfZ9acDXu8kQHjOlJLgw4EvBrmJm?=
 =?iso-8859-1?Q?9I0IluQOeEptOMXAwRhaapIpDWaWIXwU1a9VTYxxErOC8br2rFHY14oLmP?=
 =?iso-8859-1?Q?g6qVvJWLLFKiEjSyYUzSiTUKSK5VoejqCWfp7AOE/RoEfMrt01EZGYqSSf?=
 =?iso-8859-1?Q?2fpINJ0zowhT4SewpAEX5UCXmC7eUDWm0QCG8nnPzBkEDHO7Qljumt+GBo?=
 =?iso-8859-1?Q?n2Prkg8IXt8ptOB8OACZJFB/llhkReYMmHHXcwTducCBImZ6m9O+nWZ8WE?=
 =?iso-8859-1?Q?+SdCM5m/KP6h4WWqKNbhTZeX+UgjF+fmt6g11gLiU0Oqp0jJPb1AQdtMPt?=
 =?iso-8859-1?Q?4v/sa/V6jBj3MXsKwdOX3SG+Dpro69WDF8asj0+eNcTRU/sdP+WpgWCKED?=
 =?iso-8859-1?Q?VK86dVsi2nZFyBxpRZztfXHaH/Yw9TsSvs1aIe0ranq6DLkpd0LCxClKhW?=
 =?iso-8859-1?Q?xvqkAe9D88GvbkM9p89uJe3TAFAgVSJNJlPGQ46Sk7Ia1QygjhC/kNFktj?=
 =?iso-8859-1?Q?AgEoqXC3fTlTTeZjlP5VqgNy5iQLWrwIOS3mq6UcEeYX3a5hwOX7QXYQkd?=
 =?iso-8859-1?Q?audSYsr4FQcmedV1WEZaRjVA6grC8geSaq/fdjfZdapcQOC0lOzy1cCuS+?=
 =?iso-8859-1?Q?V4T9t/snwR/hIlvdjt+wUgmspFM4PC0WU0Aw8e9ZZxnvSKVamUi0o2528D?=
 =?iso-8859-1?Q?hJhdZ1f70mCrW52Ylp0qSQkgtbjQilaRIO512vPsQ+XyRyx+lQ1GxQJsWH?=
 =?iso-8859-1?Q?b5AoN6Wx5XF0BvlUwXA3aeAr/DWd074MCkA2jKUrAOjSPHbxwLlpiu0yf9?=
 =?iso-8859-1?Q?v9fXG7CUUj?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d5a1966-7e70-4d2c-b863-08d90a5b84a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:23.3168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //0+D11Sye+oj1/baisy8Ce38Nh4U0bQoNhzR+zVYli7XsvHUb7+PxxdRlBvmXTQ+Fwe+AJhOJisWG5h4FTgaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: VNkDgr0n8_WgotltFtV9i1yg8zWwAH4O
X-Proofpoint-ORIG-GUID: VNkDgr0n8_WgotltFtV9i1yg8zWwAH4O
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/sched/fair.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9b8ae02f1994..db403de2131e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2726,6 +2726,7 @@ static void task_numa_work(struct callback_head *work=
)
 	unsigned long start, end;
 	unsigned long nr_pte_updates =3D 0;
 	long pages, virtpages;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	SCHED_WARN_ON(p !=3D container_of(work, struct task_struct, numa_work));
=20
@@ -2778,13 +2779,17 @@ static void task_numa_work(struct callback_head *wo=
rk)
=20
 	if (!mmap_read_trylock(mm))
 		return;
-	vma =3D find_vma(mm, start);
+
+	rcu_read_lock();
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma) {
 		reset_ptenuma_scan(p);
 		start =3D 0;
-		vma =3D mm->mmap;
+		mas_set(&mas, start);
 	}
-	for (; vma; vma =3D vma->vm_next) {
+
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
 			continue;
@@ -2829,7 +2834,9 @@ static void task_numa_work(struct callback_head *work=
)
 			if (pages <=3D 0 || virtpages <=3D 0)
 				goto out;
=20
+			rcu_read_unlock();
 			cond_resched();
+			rcu_read_lock();
 		} while (end !=3D vma->vm_end);
 	}
=20
@@ -2844,6 +2851,7 @@ static void task_numa_work(struct callback_head *work=
)
 		mm->numa_scan_offset =3D start;
 	else
 		reset_ptenuma_scan(p);
+	rcu_read_unlock();
 	mmap_read_unlock(mm);
=20
 	/*
--=20
2.30.2
