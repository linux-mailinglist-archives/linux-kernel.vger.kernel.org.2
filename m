Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D6936DC13
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240617AbhD1PmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:42:01 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:19572 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240387AbhD1Pid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:33 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFPXv5015928;
        Wed, 28 Apr 2021 15:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=RrmtkLvtrWhEb9+FEOjYgrIGyPSSsT9VNjDzy+oQ6O8=;
 b=MPHeSNZv5lEK4Q8uOzJ6ce+FvXLNjjoaMgyHwzwOzIsTlXuxhfHsd7Yy/vwzM4EB4yzP
 1Gd+l4vSyGrAmxAe+aL+6qolL9/XTa/9UU7ORglYt+DH0POYO0wLMU7SbpAc7+uNPnp7
 t3VVkdYNR7NldHwqCHdDt4M+YEOnVVag5fGKggJykYE+IQcjGkDT91xIKGuLNgNmL1JY
 QzOVmnr5vv3birwAzdjT9l+7Tp9d75YjfM2pbfBn+L1MUzwEaDqOrHV1d8cEGvUfCKqZ
 TR7dmsEOwO+wrz3Z/NWko4taos7c7rAqvLQ1oquWXRIWS6bO7KeNzu+Rz23urCDdRB6j Rg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:30 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFbPce024423;
        Wed, 28 Apr 2021 15:37:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 3874d2765a-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7pPONPXIifpeo+M3AfV8NBL57Bi2iSgYGn1Af/azLtL/tGljaRaZqt1rn13Z8yu/AKy+x/3foXR1wgfgvvi/DvbBqg2QDi5cbZ6NKDx6NGX46BJCEfNO8I3uuCdrBZwZg0+UrHyjjc8iZUhWU27viOgz1nQKOhlQTC1q3VmqicNujFO+kVcVcixJojx/dfNHnvRAyQdM2GM9luszEWtPQbeJXGI7TW0ksYk2JgtNWySiZyhOdvj6VcKDI/k56zCcqotJYTyEDMypKcTTD4NHAsy62lCLJdN6D0pHZ+7IXrybWlQ8BJI/f9sWJMkm9e2RIABAouXX66eMyTj9nMBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrmtkLvtrWhEb9+FEOjYgrIGyPSSsT9VNjDzy+oQ6O8=;
 b=Yc2UIpwDtC2Ts/+gREGfmsPjpQDIjWL4q9/2Wuy11LqitdM+nqAk2vucLpNOvcTQbY2Eja0mxwKGgJu3xd3CZQle4y3k38tJhx0JZ7hVrv6pX2rax641igekd+wp6rRgDPj7LcanzGQ/cG8YDLw/FUQRgjqVXO4RvQmX0HyxpeqlhsJ5zerjd9OqBWx1MjZ8Dun+gqj9o3JGeAjCkaDcEndvaQtpqIthzo7URpEJ2cfFmmQRgtSta5Y/agSMacZ82tagQ6seFjriwMxRuaaoLByPzEgoKBWA6gJHap4v+sjLF8pVQ/e+nEbM8aPHg7gjwbN+Q1dCElKy9oqNRDadjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrmtkLvtrWhEb9+FEOjYgrIGyPSSsT9VNjDzy+oQ6O8=;
 b=JMK12SB9enXuYVdeeuu2y2Fi3FXTjPw4dkJ/14j1zRIH+kKVc43p5BoBDKDGFfHevcIUcGguzSVnWyE4FBHZMtYNGgIDQCoBYa6y3IKKgwxK85ATHr37ycIwAJlF0I1pxcylanDQ59CJyRtMaJOXLxzeklgmuHpKGuPiWMT3/qA=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:37:25 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:25 +0000
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
Subject: [PATCH 77/94] mm/ksm: Use maple tree iterators instead of vma linked
 list
Thread-Topic: [PATCH 77/94] mm/ksm: Use maple tree iterators instead of vma
 linked list
Thread-Index: AQHXPEQ/rM7X49aelEWkp2F3H5jzZw==
Date:   Wed, 28 Apr 2021 15:36:25 +0000
Message-ID: <20210428153542.2814175-78-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: df7f3c0a-b57d-489f-e1b9-08d90a5b85c3
x-ms-traffictypediagnostic: CO1PR10MB4548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB45489A33D7FBB4CF447CDF01FD409@CO1PR10MB4548.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GIAr8AJdyg2Ew6JQxCgzKmXYS2awP0pPJ4zy5+ojePbJXTNByoV/6VgdcYoqlUuyEIDMEtj8DjHwMahQzgV5VLHw9FJaANqLZLMgb+2OfqUk8Hxe7GDrEMBqM9jyu3HKLMa7t8O2AjnMY1oXIcAcGPDxHOMVtQxotVCPodOFyGGW9p31pMAnk6S1yh2aF0Cq6EWpdajrLnBa21AD4QAPBBEQSurM9hUcXCx7yB2ivMu4kdtrnAKaylW7kpenfFT1PdFbXelGUer2PTXLhD/PKPDmtzhj+gNQHv9ZvwOBtr+dJjPJHXgubfVbxC4JaNn2GmKheCCTKE1nSomJk9tKR3JtDMQyZcVTZOBRx3CNcUH0KoBE9k65jZTLf1BKvBYaQIicnxB0zPMn6uTy4t7yGY63xj/2TJivR6L1G3odp6MBbGZLqNhEOGPUGlAIz2abFcuhDhqjjWBk5Wot82E4pTHyvEXizHyvklzqFIauL6+R+kzOR1Ix3HGktSlzYA8yOuV1gl5MGTizR8TvAOlfbjUzJ7cGrcLAm/VS98pH0vs/4DtoASlo01Rxgpukl6/wPcXloZyjCmU22rDwfdSpolVUqWV7H50hdKI8pJIwfSg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(6512007)(66946007)(8936002)(186003)(83380400001)(54906003)(86362001)(478600001)(122000001)(4326008)(76116006)(1076003)(107886003)(7416002)(110136005)(38100700002)(26005)(2906002)(2616005)(8676002)(66446008)(6486002)(71200400001)(5660300002)(316002)(44832011)(64756008)(91956017)(66476007)(66556008)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?fTx7oTYJ+HKmh7Powp3uAC4RnlElZ0TssoF1f4l7fh6vua6eXvQfWi/z7t?=
 =?iso-8859-1?Q?+n5kWtoxKQE7VrPNNiqg6CCQxCyrR6DD3HNgzwADeb2yk/WSYh7CO3P/Vd?=
 =?iso-8859-1?Q?SzJAI4AD2w3PJtEldH2N7Wra1n173wvSonYbXFDjJhPAAm3LfipuXCQx4x?=
 =?iso-8859-1?Q?4xcE17pAdF/MkBWUyEhmztJWQP0gHBE1bZdODlu0k4HPchB4ryI0WCUDVC?=
 =?iso-8859-1?Q?o9j6Fv7HFylIcJKVliOTJeLCTGmdNhSQeUoD97/LpYt6LWIr+ve/W1Ebie?=
 =?iso-8859-1?Q?kidH0yYpI4dGSk7aaCOM0NMzaKmTQBZV2cgw+s6beH4nrrJQBCVecEtMFz?=
 =?iso-8859-1?Q?7pEMnUWChDBhNfAdQiq7rNywmdSoe+URnO59l61mtQT+01HR9op//1EA7S?=
 =?iso-8859-1?Q?EbIcLVNvOv1sJTs/h4a0PproZbdAsPm+p+ngv+Yp6zqK+e6j+ep6BIAa6A?=
 =?iso-8859-1?Q?GXKBs4RWZBz1z9EnFHUiopp1/DyYzz25IT1o/DxRkaWe7OSSXal06ZstHS?=
 =?iso-8859-1?Q?qz9R/wkU+yeBFRP8jEMskmuWlMX6Jafk290h53erPfOvwwmpAAz9Zf68X9?=
 =?iso-8859-1?Q?ATsnpyoLWB9rG76Silsnl2BDOS63kB5wIAWaNLe4aQzdfbBjkB4ZIIh2iT?=
 =?iso-8859-1?Q?RF4Y8bm58bzlr2gknLSiBG7pNOrSUIkd1KOKZfJ3iJA62z3h3HxH4Ka3mr?=
 =?iso-8859-1?Q?+hRP13E1cRb56yYPULS9CzBeKN+Jr35ozD6aB1ugrCoPA1jMkymcAM+f3o?=
 =?iso-8859-1?Q?k7nGwewSpyqIUTJ2/wWbShLEoWLKO/2XZj6sdUHDOozUX6qaeojJmmuPY0?=
 =?iso-8859-1?Q?hg9mwvyVhmOXFSRyjSTdIR0yTzLnP8UbKNtyGM8w2ypydozkt0dCJlB48+?=
 =?iso-8859-1?Q?Tz0qjNGv+dlgVnm389F/rts3z4/TR298fZuob+my/J4rRoLbm1s4hgxcWW?=
 =?iso-8859-1?Q?0NmDdb8aN7uv8C039A+4uFeIs8Jbn77Wb5+k+ImBVpHENzgED1fRT0Rfod?=
 =?iso-8859-1?Q?4gjs9rQaklwmwSf7UwEAqnYqDFw3wW+vRKsCi5DBhfgvTLQFxTZ0YAXbA1?=
 =?iso-8859-1?Q?IvTN+gxnuCnJ+7KqT0gW0ER4YWRBppyw1fSJ+8Qgv8KfAuygYNHgwB9I8P?=
 =?iso-8859-1?Q?GUsKip87X7lUt0qAIErA+UkY6+omymceMuNb9sqdncP+Y4zmPrpr/Vbb/i?=
 =?iso-8859-1?Q?YlBBoaxr0C7BjnXgc5NotrJALoDZBQMQ7JEa5meM9e9ejWyOmnj7NDK7AD?=
 =?iso-8859-1?Q?j4ZUpIX/6R4XfkNIKrZgxrXZhMqfrjfdfg+Gq2ZxRDtWs3rBt5o6GMhZ2/?=
 =?iso-8859-1?Q?ZXkefMUfXH+QEewkfOEqhlbJE+f88K9QugVyRInCiXw3zcwbbtsagnpHIC?=
 =?iso-8859-1?Q?KZ3Ryg2hJv?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7f3c0a-b57d-489f-e1b9-08d90a5b85c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:25.3249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5lBy2pR5yDad/YJJc3G4uTHLSz4/OgNMHkLcbrBknNf7w25RxRTGrYGtgQkIc0L3D1NMmnqiXPF0ahu1KMathw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: GWI6seXROfj0GN3c3Z497l5tKu7M0DQq
X-Proofpoint-GUID: GWI6seXROfj0GN3c3Z497l5tKu7M0DQq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/ksm.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index ced6830d0ff4..aa0cfe1ef2d7 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -969,11 +969,14 @@ static int unmerge_and_remove_all_rmap_items(void)
 						struct mm_slot, mm_list);
 	spin_unlock(&ksm_mmlist_lock);
=20
-	for (mm_slot =3D ksm_scan.mm_slot;
-			mm_slot !=3D &ksm_mm_head; mm_slot =3D ksm_scan.mm_slot) {
+	for (mm_slot =3D ksm_scan.mm_slot; mm_slot !=3D &ksm_mm_head;
+	     mm_slot =3D ksm_scan.mm_slot) {
+		MA_STATE(mas, &mm_slot->mm->mm_mt, 0, 0);
+
 		mm =3D mm_slot->mm;
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		rcu_read_lock();
+		mas_for_each(&mas, vma, ULONG_MAX) {
 			if (ksm_test_exit(mm))
 				break;
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
@@ -985,6 +988,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 		}
=20
 		remove_trailing_rmap_items(&mm_slot->rmap_list);
+		rcu_read_unlock();
 		mmap_read_unlock(mm);
=20
 		spin_lock(&ksm_mmlist_lock);
@@ -1008,6 +1012,7 @@ static int unmerge_and_remove_all_rmap_items(void)
 	return 0;
=20
 error:
+	rcu_read_unlock();
 	mmap_read_unlock(mm);
 	spin_lock(&ksm_mmlist_lock);
 	ksm_scan.mm_slot =3D &ksm_mm_head;
@@ -2222,6 +2227,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	struct vm_area_struct *vma;
 	struct rmap_item *rmap_item;
 	int nid;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	if (list_empty(&ksm_mm_head.mm_list))
 		return NULL;
@@ -2279,13 +2285,15 @@ static struct rmap_item *scan_get_next_rmap_item(st=
ruct page **page)
 	}
=20
 	mm =3D slot->mm;
+	mas.tree =3D &mm->mm_mt;
+
 	mmap_read_lock(mm);
+	rcu_read_lock();
 	if (ksm_test_exit(mm))
-		vma =3D NULL;
-	else
-		vma =3D find_vma(mm, ksm_scan.address);
+		goto no_vmas;
=20
-	for (; vma; vma =3D vma->vm_next) {
+	mas_set(&mas, ksm_scan.address);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!(vma->vm_flags & VM_MERGEABLE))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
@@ -2313,6 +2321,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 					ksm_scan.address +=3D PAGE_SIZE;
 				} else
 					put_page(*page);
+				rcu_read_unlock();
 				mmap_read_unlock(mm);
 				return rmap_item;
 			}
@@ -2323,6 +2332,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	}
=20
 	if (ksm_test_exit(mm)) {
+no_vmas:
 		ksm_scan.address =3D 0;
 		ksm_scan.rmap_list =3D &slot->rmap_list;
 	}
@@ -2351,9 +2361,11 @@ static struct rmap_item *scan_get_next_rmap_item(str=
uct page **page)
=20
 		free_mm_slot(slot);
 		clear_bit(MMF_VM_MERGEABLE, &mm->flags);
+		rcu_read_unlock();
 		mmap_read_unlock(mm);
 		mmdrop(mm);
 	} else {
+		rcu_read_unlock();
 		mmap_read_unlock(mm);
 		/*
 		 * mmap_read_unlock(mm) first because after
--=20
2.30.2
