Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565C8421C08
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhJEBfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:35:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45734 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231466AbhJEBdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:54 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1950fjVn024345;
        Tue, 5 Oct 2021 01:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=/YBgD6R6ycEEQAm6tID+saHip7SBQS0cRDXt3I5NIeo=;
 b=rX6zQ1POu4/iowtBt5i3YHNRU0k/z0TLmqQJ9nxlfVlczJ7uCCuCVXCbPkV8ffNI08gF
 LEPb9YG6M4Ez3kssn7fK5buThaq1/eQLRl3ljnaMu+1KduurvyXC7saBw455GG1BbIou
 T+s43cJrCIp49sXZ1BrgECcGbBbVwzn7HG/xdK7jzYSc65OpLHxz1GiHZV3gJ1X8QcXM
 RuPWqFX+FKv26fVEOSltOqgqIJoCX3izwmpsJYTo0X4Br9DX9HiMvYwPbial/pSfjI9J
 G8LyvywFyZ2KUlkUknlWCt8V890lGsJ7rHGycUddUNYjm65XgjMGpifWujZJzY/GpQNh fA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg454bvpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UHTO178361;
        Tue, 5 Oct 2021 01:31:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3bev8w0386-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YyPoD7gcfUhDkYXyRhyoolHOfym7iLGVaRwWUX96QCPHOeHaoZhHSluGOUBd/fY4baUuB6BJgAbIUYv7TznB8H/8RCrprMIlnAQmwvjyWoKAIVA6ANPI7ovoo8S63YaOSYZju37onoWK0Jh8fmbzY0lRhF+TCMXCxJus8gKapEChQiA4Xq5sGfZ1OlO+rCo+vCUChrGFmoGkk/lfYLpcWnySEXDss7wUhh8cpeEKiWIORDTYefDTdt79ZXuVs/y/6XkE17zWFrpFHSS3Aah1fKgaocWuRE7EOE3EGkpflUUoPpqi/MIatbFLUrwHbI1E2D1/osknp2WKJCrr46JC+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YBgD6R6ycEEQAm6tID+saHip7SBQS0cRDXt3I5NIeo=;
 b=hGNgqQEm+eWSt8YwvYxWnxotrxRB3S6vSOFSViPsBDn3VQiDXFC7Cs8TFGUV4lWy2dVV3vXckg0rFCq6xYsmJzCyhHBzvXvaZiLnCyQL4N4JWwOn/PktgDl03uaRnuOHAAsM4OjsO/+UxhPGB2In5l0yvA/8SAcLAiJ2c84a5xUnb2Dc9qkYVxJkRoU230xDdxnLw6h6JLpCHeToLK8ViD/O+9RKjCRy/Da+aQrut9zcC1zx1+SrKLcj4sS+eNrl0c2SKuy3ALict5HU2SeHociy/OT5m8MY7us7qQmn87kUAygLWjVTqHslmHg/jtLNhdzEPFXBlq5vuHMlXllPRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YBgD6R6ycEEQAm6tID+saHip7SBQS0cRDXt3I5NIeo=;
 b=t7sg5D8o7s6qG8r6Fqd0MZufsQ8mnIAewOZJNEaDK2zudFgdLOG26sC6WbjKZyjhGm7bbgEHMKmILdYIBLGCjXyGq/gb4DNQZjVRHec1FfjAc0qBye+lObHVBBGcSZP4PqddyXGeyen39uvFjbBxVC3ZRRYq/jFLAtXHF5GFAHc=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:23 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:23 +0000
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
Subject: [PATCH v3 44/66] kernel/sched/fair: Use maple tree iterators instead
 of linked list
Thread-Topic: [PATCH v3 44/66] kernel/sched/fair: Use maple tree iterators
 instead of linked list
Thread-Index: AQHXuYiorXUzL4zFkUaYahbdRC7KyA==
Date:   Tue, 5 Oct 2021 01:31:03 +0000
Message-ID: <20211005012959.1110504-45-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 8ee5a201-36cf-43ed-6466-08d9879fd78b
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB504452CB2C23FA3D6D0DECA7FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:655;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: udtMORKrY3E3qS7OB7Qvkf4XXaV/GzCKb7OtYajDRjkH6gzMnuhhns4UCHY8B9f5aNhrXDARa1QwKNN2jzG2lNKjEbqYh89D6L1wfEriBhbqWkTZZssI/VG5QBs9QvpvRujDpVPn9BxfP4TJUWsMMFk0CaZEXbEQ4DP1WDJ9kJDHZ787Slc9ZG1kjDpt5/n+rQPvZBU6DY/ZbKQO5JxjgoXgOTKsxur6DhVemvSmzn2FYIwem24wMk1mTmKR2/OEUgx5zMqwPjzt/n8WexdNi78c4sHB/8pj2+fqFiqD8eAX4XS+lDn+wyWCX2Z1+x6zVl/BK3xaiO7fokmF3yLlXJ1KTVwno30CL8ePXc1vYqDwXi8TYI2kEMc27FQZ0LJjkIeXq5EBqA0AruLhK4WMm/gb7cUuPOkduIw2wkM5gROitz5LbZnIxHZjHWtbzfELaoWYd4ml4FeP5HdS4ZL0Yu8PZqaJVKyP/5ovBx+/F7cBuuU7X7E3Ctgqr/a0Gg9yZxF3Hak4lrLFHX7IO5cZV4hUat+AX8rnOeOgNVDO3Nb/u9P0v/+OgVWrVQ02tm456Iz1TqGYJjRQh8OhjwVHLD5oQo7+U39JPOOO90NX5LYImXwIlbFbEsQ9Zwk/lHtY/S18UxRuOzvCs4GcCScycwhAowGDfbgTF2Slg3Za1Qp0CLFnb04Gd8CDMwBqFr+fFQT7VjBAR7fIVnGGSDfObA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4er8KUGkn5YYQrDqkjKFlnryE7u/3gCmbCvPgm93DA0u14bEznAAcjm83L?=
 =?iso-8859-1?Q?RfDivdATliRZgdi+xhrapGm4fOjeVMZDX80S+D4SMMBMVu8zPmhhvS21A5?=
 =?iso-8859-1?Q?iWS6+TMjqK5MsO76okQEKy1K+CunmpSB8Gky/o5w1lHz6nKH0swliHMe5O?=
 =?iso-8859-1?Q?I6xmcFxe1WsvX8HSsWee/omWKeJ9Yn43sqwP80UGYq/V6RUveGGy9AJeGt?=
 =?iso-8859-1?Q?hMNToaMxhjhP835ld7x3N2Db7mBcx4/INaitxw05Lyr2nG64f6O9qeSMpr?=
 =?iso-8859-1?Q?CtR9HlzKbaK3z4kJIO9hOzP1dJrUsxQg6VcKqmp9jRlqf81u065huWTtcn?=
 =?iso-8859-1?Q?LX4lZZptlBoNzODA9sXXAnV6yTZUDkUsL0/djptlzOrswAnrdOGhGa5gJe?=
 =?iso-8859-1?Q?Jbl+iiferaoPy3afICFUTwTSFlJPs0NkHbyILrCET5hewjbeYEYRktUKUX?=
 =?iso-8859-1?Q?mKfT/YTNsvdR9qlk4LaGWT7fqfouppLBbgTuhQ1D99XTcU5YkfdOkd7rJW?=
 =?iso-8859-1?Q?/hJVHlh/Eqan6jy0cTAG5XmPnnHRI6cTSLlM5vaHcK4542tM82nndB6oSU?=
 =?iso-8859-1?Q?rPIEBbEORR+3m8riafw01jSqRQx6VKhgJnMxEN60UVUV794vugIp6MM7y1?=
 =?iso-8859-1?Q?j10yb9pHnP8IB6ZGwF94CiC4HYT28CTOlrvI/ldHTglmPSoS6z8Q6usA9y?=
 =?iso-8859-1?Q?WZ2NhirF+qCcjxV2wYKwVavmXKaRe9szcJLxeCS6CXWhPQNlnQAwNsBQoo?=
 =?iso-8859-1?Q?idlQvOBNmZS0YPUkN46LZRmyQwrROEjhfHYtCXhTsRP5lyL3fVCXE1Jh7k?=
 =?iso-8859-1?Q?JFUOi8BAdPu8OBfZEQGlxnE28wud0//mFlIc4mcPxmvUc2DvAOB3eChNst?=
 =?iso-8859-1?Q?xQVBtQbBJv52Gv23+MOW2u1wbqAXyXaRN5XZQitFHFZT2w9S8hvIRZLi6Z?=
 =?iso-8859-1?Q?aWqdgapxrCZR4lhu0nPczSRAbXOyQakxxJWn1WtAf1vws0YOm0l94x1+XV?=
 =?iso-8859-1?Q?epxCdP6CHTjS/FPmOsk5WS81PiVbembUGeVKucN6/jyAZ5ZTfDiY/0+p66?=
 =?iso-8859-1?Q?dc6QMgqtMUmt2OawbI7dvCNefCb+GP2FaCyUlx+7Pb76iN5R4PqhHqGhNU?=
 =?iso-8859-1?Q?p4xI7VE/IBhR/cIVhUgdGNmbsulDZ0OB2QeKHNbQ9m9gntGm6GYbmCPMIi?=
 =?iso-8859-1?Q?Al1E5piS/C+QNM0hnKRUAj3BUTq+bmuFEPqfRpi2u/k9l48nGloUoxTi/+?=
 =?iso-8859-1?Q?S4KZcjOuPoVD2V6ZHNTxG8wjiMqOiYRZmbDddsTDJZtJISMTyVkRNbAsKf?=
 =?iso-8859-1?Q?5Gw51GS/GtScP8tiwdWRdy6pMT6fnj9M7HatRYLhFcIiQYfF6cv4D3VXTp?=
 =?iso-8859-1?Q?t31fyCkZM9?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee5a201-36cf-43ed-6466-08d9879fd78b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:03.2627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4kZYbImqaYrA+35VtuH4YiN1F5BpSPk0Pp7ylHnBNTbFE5vfy4rXzAziiTTc8A1iEiYhfYpqpkwUmyO8EBxpVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: ygOcS6i5KgZXPPkXL2JxjDs3linCOWu_
X-Proofpoint-ORIG-GUID: ygOcS6i5KgZXPPkXL2JxjDs3linCOWu_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/sched/fair.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff69f245b939..46769907c363 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2720,6 +2720,7 @@ static void task_numa_work(struct callback_head *work=
)
 	unsigned long start, end;
 	unsigned long nr_pte_updates =3D 0;
 	long pages, virtpages;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	SCHED_WARN_ON(p !=3D container_of(work, struct task_struct, numa_work));
=20
@@ -2772,13 +2773,17 @@ static void task_numa_work(struct callback_head *wo=
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
@@ -2823,7 +2828,9 @@ static void task_numa_work(struct callback_head *work=
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
@@ -2838,6 +2845,7 @@ static void task_numa_work(struct callback_head *work=
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
