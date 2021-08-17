Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CCD3EEFA2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbhHQPyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:54:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38532 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240414AbhHQPt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:58 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkqVV017407;
        Tue, 17 Aug 2021 15:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mXcQYYh5HRDDO5e4OboRM//OaSOWesUCHlFzwmAdRMk=;
 b=EdrZVbDcxUnfgayO0qgIIG9QVUBmd+9iWUFY50Am87JedhDdEpvtBeld8a1bQz3L1GdU
 rfGO/L/5M2XOe8+hvH+Ic+pnooJIgbOOcQoGHHc0+mwWjunMy394Jnra/libbX/KfmoG
 06ubW7GhHsSMd/vO7vuqlFWlz3+6osNkZXu/UkM/dzGBfBvteeq00iouzPQo/EyV9nhx
 Zqo4nTUKzljS413LS78DmwEbDaLk23jpOpGrI4HueWLHEw4+O0hUQlvDDbGTYKBIP/KR
 fR/NcxlUCEKdKPTF5IxhXzG6c6PS2uAQR5fopwLDMlY3MyC1glFbrqAv00cx7nTsX3VO /A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mXcQYYh5HRDDO5e4OboRM//OaSOWesUCHlFzwmAdRMk=;
 b=heurfKLPXsN6wi0X6Xuuvb3Hxaf+gNFycxBFvg6CiM4ZHA4V/8xhF3wvQ9lTwI8fzzHY
 k8yQR1nmkMZROL9z3n90iyguKnyYlpq7+Bk6PKSdWTxbd3ookA6c/cHcmuIiIp7/Lnhl
 EYrNPcgPIXvOnJm85kzWXMCrmuBqYlkWR9Kn6LT4p7kCeyst2VR6RU46Emka2Hj5AD55
 TiH/gQ0xFRI88jAuR2v7hFtZouvpTjX6iDnObEwPVtY/RCv+oDWb9AgRE+7Vazgxkkec
 8WHzWqcFRxg6XN62zri3dF/bs7up0UfO98Fj/Nca8e1iZqJxKPQWBAI8vaVYHJ7zCbB0 Zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf0g7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:34 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFj3MC174002;
        Tue, 17 Aug 2021 15:48:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3030.oracle.com with ESMTP id 3ae2y0d3v8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UmWHzuFQyfsxZSOMAiOoXFmEHeh3+N3dNxtgErCUQgcQptXR5isMwk1+VBvt2+MnVG6Rq59+Z0YF0IAY1B7Db0Urbq1E3rrYrQhz6mA7bj996wkuLOvy5Sl4r0Fjs04oZUnQ0sdKx8t2h0iyURFCQUFLyaSndwlt09kbZ0JKQKeWgBjuYiQDZSyKL0pp8MhwHoMrcjCXWhHZz6GrCf+ZBRnYiiy0gL5hfZBoLOwTn7d837amnzA49BJOsxvD/BPLrp6L8+kaJZ1VMlOaLXYEopjbvoN9Gjgk+nUGvDEY8JFyBggUm/sKY5cJ0YMWSahErUa1ZPN6vOSHFUijOWGXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXcQYYh5HRDDO5e4OboRM//OaSOWesUCHlFzwmAdRMk=;
 b=Y3dgqHYpdIQIBAjbn/ipabdMIY2qrspEnvUZ98vs9GHApMbaVL8+7UpBSEkGjVOC2wdKU35ZA6zlrBKojx75SSvo6JX5mkGp6ZFt6579uoPH9BWDOXsK+VWG+DjBAMfA244mCTDjcUvATMrlS/n4BSGYZOKSJZ0DG+SMfKzuNbycU3Dpz/SHt0FG/iLYFbbcgqjVJ4MlHhtL8jojlDKbpXJZriCjJYSE1yjHIb/DK1fzfpeGoNnDs0NkVmzmW5EvEOmv4owpYvQHUMGsQ11SbRFFtG4Gi1F7UWEnuscd5xeCSBvB4XuBBN4NDb0qbt9iX9aksdk1zcE/BZHzVVm/Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXcQYYh5HRDDO5e4OboRM//OaSOWesUCHlFzwmAdRMk=;
 b=B3t1ASH3mYIKt/FE/L9sUXZBqYQlrwnqofu/6AWWQy01jcOF/dygbfn3EEnWM0YfkvTPCU5GCJRa+Qc5SoxCfNUG6WnLskooH0YEk1MwFl2y3STo2utsjB51tFFXWCgw1kHpYqRrv+08LBnuR9PBhdccSgz4akjUnxar9S4wmdM=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DS7PR10MB5024.namprd10.prod.outlook.com (2603:10b6:5:3a4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:48:29 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:48:29 +0000
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
Subject: [PATCH v2 60/61] mm: Remove the vma linked list
Thread-Topic: [PATCH v2 60/61] mm: Remove the vma linked list
Thread-Index: AQHXk380Kup3jZoQmkqgwkKaKQoCpg==
Date:   Tue, 17 Aug 2021 15:47:38 +0000
Message-ID: <20210817154651.1570984-61-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 2a095c98-bfa9-458e-52f7-08d9619675b1
x-ms-traffictypediagnostic: DS7PR10MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DS7PR10MB5024559F6E6BB18C35208239FDFE9@DS7PR10MB5024.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7kbcIyjM5tT0xQTELKpif0I3svh6EpJqEtE/gbRcslopNjOorDLohJupXYyTjSnWe6IBOejMinMxKQHs7aAtGScdu7fLNHeDNYd3lgw+3iKdyF4OGQA9qSAamxu+BE8bMmFqEJ+c7nru8oag5gSXZvTQD0tBTVmi5+ZezeHzLWGWPHrMViNLoq8OF3z/TDHUqATpWRDpzT8FW+x1LfIqxMfmcxeojuMBRvr9vVcqaIx9ztlhUCAZnxI7CULcGgkS7WhXe/VPPLszI7v5YxqL4mY+1kgOofAB6QX4TDQyho7lc2m86l08maUqhDifHyCKKJJkwz3dDlcXBCcAxBMAHPM9cB3fCkBoo7c76WlFtqWvrAMIoTvb9luwrnAbnG9COVk42sdBcMBF+4L6aFhJQm59hzvMEdaRgOgG+CS7m30V/WapyGl8r2Bv0d8UwKUp2SxrYuhC81zzF4Ar9mmPKPOG2GjJE98iD1oyJDqt2bbi8HC7u5As8JY9BxgbKDC+FZE/FdqoQDgbTzm9jSOIBLqN8fTCuucnbGDM0/fuzZHc/SlySg643s9NFo/pjskUOXRsfpGprkp0vgy8+zHW8GoDSim5PmjohTLBRWGBKCPi9rE7ODjR5LcawYaJDGqLhXhtnQQQKJn0HUeNW6PfUDfPrGI2DilhDvyuxn8guNKx96N3tjgsQbfLywFNkZaVqby4jJPcntKJoXlHq2ZBNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(346002)(39860400002)(136003)(2616005)(44832011)(8676002)(2906002)(8936002)(86362001)(107886003)(478600001)(38070700005)(4326008)(83380400001)(6666004)(71200400001)(1076003)(91956017)(76116006)(38100700002)(5660300002)(66946007)(6512007)(66476007)(30864003)(6486002)(26005)(186003)(66556008)(66446008)(54906003)(110136005)(36756003)(316002)(7416002)(6506007)(64756008)(122000001)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g9Kh8J6nAR2UfXlSoRO0PBMi7ABQ7HhMzRk50eAksd0CpWFRaDH9Z0QLxo?=
 =?iso-8859-1?Q?kzcblpe91Bu3gYfaYCDJhmE2NwswZKI+8gPI2IB6gL1j+PrmV2xRx1QsNx?=
 =?iso-8859-1?Q?KD3fHVt1hNv9zgddbDHyhEFkWogcJC3aDto3U68NxgeNZYx7j/nyqwoRpq?=
 =?iso-8859-1?Q?7SBhiOsSs6x+aNcJPu5Ado11+VvIgJ9bknVC5fydEySQpKoDxkkTdZ7O4z?=
 =?iso-8859-1?Q?tRKSfZ7x7DSgFuzQ82LYrXPpEsxXXpwlUZUvevKmgCKLeUSJGJXXBaaWLD?=
 =?iso-8859-1?Q?ZCDBTI+w4lg+4Uqy9sRu8c9uRnJvaBnv1aowKnPYvRU/BGzciD523EOWqS?=
 =?iso-8859-1?Q?m9Eh54Z9BHtumk4AO9N83CLq9NAg2xqFC0rLBxoNIXqeKKdJacWqzeLNHf?=
 =?iso-8859-1?Q?koeI5hsqz0CAOF6yH4ZGlh7y9uZkv/NXtn3aCEQ2tHDSmgNZScKT643RUP?=
 =?iso-8859-1?Q?jZ0cQPrGxaYoW0rhDUSZiA+r3Osp6ryXyd/VwqERdVigxGd8i0MgKkVLPQ?=
 =?iso-8859-1?Q?xZPjdfiq7wKU8huiLIcHTSkFggiuT8hIYsZvMgXrrzx8FVTIJb5F6dzgUu?=
 =?iso-8859-1?Q?XJHsAOMbAEQ0dhYvi4BDnvFWtfOB+4MfmaF98Re5FK2/qdZJ10Vhd2hyYt?=
 =?iso-8859-1?Q?pRm7Kl9xAD+dYFyYExwh7+fFua/KICs7EuwqHvg2yq2n7qTWjZIoLzsPwG?=
 =?iso-8859-1?Q?kIdnfkeKyAmzZtpBQ5qzKHSxoZLMQlDdQA2+Q+A56Aq3SHIuxLsSnHf7Aw?=
 =?iso-8859-1?Q?VbuoZFYTGwfRyk+D3O1r1wBDuFP/p8INntVYv//VK1vp3fEqhH025l16A4?=
 =?iso-8859-1?Q?iJ6jhjlvtfe9bLt+NgFIBeYto59ruozoaXhHsOT+Hktq5e/QujT83Vjd5w?=
 =?iso-8859-1?Q?6dY9cp3XKEpf0lAgwzqpSm2BRexRPOfSI61Oyi0NX9Yhcc2foy95I5qefj?=
 =?iso-8859-1?Q?3sv0Y/sLExfhp9JL8UBbP6TYET6EdEsFnwVWX6W6V7PZC8Eto9m+lofp+D?=
 =?iso-8859-1?Q?UOTvvHewt8yJtCALVH058XOwChVbkjQ5wE4KtJxxjtrm7Dn7d7GKJaCKHl?=
 =?iso-8859-1?Q?hI01KYxbFCv4ORYOl4q1uWRjUUR6BsMtED8/PPxzsj5OHwL4B/8FPBwjEQ?=
 =?iso-8859-1?Q?RFQjopWZVy6GvL1Zuj/IzXtxIvoc5YMg5WJavYvZDQ0Z4TOGbMGBp5m3aY?=
 =?iso-8859-1?Q?dfuR9u6KFhJM9p+X+1OGi9idMKoICwrW/xRxdxxMqe2NkYKP3YePI1E91Q?=
 =?iso-8859-1?Q?gFCB4n1sQKPbQPYKVLpyE9Z/FYXEjywuqXVrFkB95l1ASlQFPWaCnfspHk?=
 =?iso-8859-1?Q?dj/11XMLKkfnXwa1SkAkGRw2I37UQvU2tAoz6dBsDr6BogRuYPTMO6lo3t?=
 =?iso-8859-1?Q?UXv1VDLfAk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a095c98-bfa9-458e-52f7-08d9619675b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:38.5302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A4dytWBEXIGFWjLfTJr0vMWpVItdUuLPlUwvD/re2SPUdsuDt3LSF4nxkPB/ybDbZaFXBUSPU1GaRiXtvNXaJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5024
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: fZEKjseztJfKX6uYgjRqRd2dtaTPQ4yO
X-Proofpoint-ORIG-GUID: fZEKjseztJfKX6uYgjRqRd2dtaTPQ4yO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Replace any vm_next use with vma_next().

Update free_pgtables(), unmap_vmas(), and zap_page_range() to use the
maple tree.

Use the new free_pgtables() and unmap_vmas() in do_mas_align_munmap().
At the same time, alter the loop to be more compact.

Now that free_pgtables() and unmap_vmas() take a maple tree as an
argument, rearrange do_mas_align_munmap() to use the new table to hold
the lock

Move mas_lock()/mas_unlock() from vma_mas_store() and into
vma_mas_link().  This will allow vma_mas_store() to be used in loops.

Remove __vma_link_list() and __vma_unlink_list() as they are exclusively
used to update the linked list

Rework validation of tree as it was depending on the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/task_nommu.c     |   2 +-
 include/linux/mm.h       |   5 +-
 include/linux/mm_types.h |   4 -
 kernel/fork.c            |  13 +-
 mm/debug.c               |  14 +-
 mm/internal.h            |  14 +-
 mm/memory.c              |  33 ++-
 mm/mmap.c                | 531 +++++++++++++++++++--------------------
 mm/nommu.c               |   6 +-
 mm/util.c                |  40 ---
 10 files changed, 305 insertions(+), 357 deletions(-)

diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index 8691a1216d1c..be02e8997ddf 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -246,7 +246,7 @@ static void *m_next(struct seq_file *m, void *_p, loff_=
t *pos)
 	struct vm_area_struct *vma =3D _p;
=20
 	*pos =3D vma->vm_end;
-	return vma->vm_next;
+	return vma_next(vma->vm_mm, vma);
 }
=20
 static const struct seq_operations proc_pid_maps_ops =3D {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7a5eb1fbb488..96002be8585d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1843,8 +1843,9 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigne=
d long address,
 		  unsigned long size);
 void zap_page_range(struct vm_area_struct *vma, unsigned long address,
 		    unsigned long size);
-void unmap_vmas(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
-		unsigned long start, unsigned long end);
+void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
+		struct vm_area_struct *start_vma, unsigned long start,
+		unsigned long end);
=20
 struct mmu_notifier_range;
=20
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 374c48169692..428a697db7de 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -403,8 +403,6 @@ struct vm_area_struct {
 	unsigned long vm_end;		/* The first byte after our end address
 					   within vm_mm. */
=20
-	/* linked list of VM areas per task, sorted by address */
-	struct vm_area_struct *vm_next, *vm_prev;
 	struct mm_struct *vm_mm;	/* The address space we belong to. */
=20
 	/*
@@ -470,7 +468,6 @@ struct core_state {
 struct kioctx_table;
 struct mm_struct {
 	struct {
-		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
@@ -485,7 +482,6 @@ struct mm_struct {
 		unsigned long mmap_compat_legacy_base;
 #endif
 		unsigned long task_size;	/* size of task vm space */
-		unsigned long highest_vm_end;	/* highest vma end address */
 		pgd_t * pgd;
=20
 #ifdef CONFIG_MEMBARRIER
diff --git a/kernel/fork.c b/kernel/fork.c
index 0c35460c092e..e8471b90910b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -364,7 +364,6 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struc=
t *orig)
 		 */
 		*new =3D data_race(*orig);
 		INIT_LIST_HEAD(&new->anon_vma_chain);
-		new->vm_next =3D new->vm_prev =3D NULL;
 	}
 	return new;
 }
@@ -473,7 +472,7 @@ EXPORT_SYMBOL(free_task);
 static __latent_entropy int dup_mmap(struct mm_struct *mm,
 					struct mm_struct *oldmm)
 {
-	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
+	struct vm_area_struct *mpnt, *tmp, *prev;
 	int retval;
 	unsigned long charge =3D 0;
 	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
@@ -500,7 +499,6 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	mm->exec_vm =3D oldmm->exec_vm;
 	mm->stack_vm =3D oldmm->stack_vm;
=20
-	pprev =3D &mm->mmap;
 	retval =3D ksm_fork(mm, oldmm);
 	if (retval)
 		goto out;
@@ -588,14 +586,6 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		if (is_vm_hugetlb_page(tmp))
 			reset_vma_resv_huge_pages(tmp);
=20
-		/*
-		 * Link in the new vma and copy the page table entries.
-		 */
-		*pprev =3D tmp;
-		pprev =3D &tmp->vm_next;
-		tmp->vm_prev =3D prev;
-		prev =3D tmp;
-
 		/* Link the vma into the MT */
 		mas_lock(&mas);
 		mas.index =3D tmp->vm_start;
@@ -1091,7 +1081,6 @@ static void mm_init_uprobes_state(struct mm_struct *m=
m)
 static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct =
*p,
 	struct user_namespace *user_ns)
 {
-	mm->mmap =3D NULL;
 	mt_init_flags(&mm->mm_mt, MAPLE_ALLOC_RANGE);
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
diff --git a/mm/debug.c b/mm/debug.c
index f84662c87b4f..5b126eb5ef1b 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -187,13 +187,11 @@ EXPORT_SYMBOL(dump_page);
=20
 void dump_vma(const struct vm_area_struct *vma)
 {
-	pr_emerg("vma %px start %px end %px\n"
-		"next %px prev %px mm %px\n"
+	pr_emerg("vma %px start %px end %px mm %px\n"
 		"prot %lx anon_vma %px vm_ops %px\n"
 		"pgoff %lx file %px private_data %px\n"
 		"flags: %#lx(%pGv)\n",
-		vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_next,
-		vma->vm_prev, vma->vm_mm,
+		vma, (void *)vma->vm_start, (void *)vma->vm_end, vma->vm_mm,
 		(unsigned long)pgprot_val(vma->vm_page_prot),
 		vma->anon_vma, vma->vm_ops, vma->vm_pgoff,
 		vma->vm_file, vma->vm_private_data,
@@ -203,11 +201,11 @@ EXPORT_SYMBOL(dump_vma);
=20
 void dump_mm(const struct mm_struct *mm)
 {
-	pr_emerg("mm %px mmap %px task_size %lu\n"
+	pr_emerg("mm %px task_size %lu\n"
 #ifdef CONFIG_MMU
 		"get_unmapped_area %px\n"
 #endif
-		"mmap_base %lu mmap_legacy_base %lu highest_vm_end %lu\n"
+		"mmap_base %lu mmap_legacy_base %lu\n"
 		"pgd %px mm_users %d mm_count %d pgtables_bytes %lu map_count %d\n"
 		"hiwater_rss %lx hiwater_vm %lx total_vm %lx locked_vm %lx\n"
 		"pinned_vm %llx data_vm %lx exec_vm %lx stack_vm %lx\n"
@@ -231,11 +229,11 @@ void dump_mm(const struct mm_struct *mm)
 		"tlb_flush_pending %d\n"
 		"def_flags: %#lx(%pGv)\n",
=20
-		mm, mm->mmap, mm->task_size,
+		mm, mm->task_size,
 #ifdef CONFIG_MMU
 		mm->get_unmapped_area,
 #endif
-		mm->mmap_base, mm->mmap_legacy_base, mm->highest_vm_end,
+		mm->mmap_base, mm->mmap_legacy_base,
 		mm->pgd, atomic_read(&mm->mm_users),
 		atomic_read(&mm->mm_count),
 		mm_pgtables_bytes(mm),
diff --git a/mm/internal.h b/mm/internal.h
index eb883691709d..c8da57abf19b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -45,8 +45,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf);
 void folio_rotate_reclaimable(struct folio *folio);
 bool __folio_end_writeback(struct folio *folio);
=20
-void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vm=
a,
-		unsigned long floor, unsigned long ceiling);
+void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
+		   struct vm_area_struct *start_vma, unsigned long floor,
+		   unsigned long ceiling);
=20
 static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
 {
@@ -395,9 +396,7 @@ static inline int vma_mas_store(struct vm_area_struct *=
vma, struct ma_state *mas
 #endif
 	mas->index =3D vma->vm_start;
 	mas->last =3D vma->vm_end - 1;
-	mas_lock(mas);
 	ret =3D mas_store_gfp(mas, vma, GFP_KERNEL);
-	mas_unlock(mas);
 	return ret;
 }
=20
@@ -431,17 +430,10 @@ static inline int vma_mas_remove(struct vm_area_struc=
t *vma, struct ma_state *ma
 #endif
 	mas->index =3D vma->vm_start;
 	mas->last =3D vma->vm_end - 1;
-	mas_lock(mas);
 	ret =3D mas_store_gfp(mas, NULL, GFP_KERNEL);
-	mas_unlock(mas);
 	return ret;
 }
=20
-/* mm/util.c */
-void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct vm_area_struct *prev);
-void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
-
 #ifdef CONFIG_MMU
 extern long populate_vma_page_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, int *locked);
diff --git a/mm/memory.c b/mm/memory.c
index 39e7a1495c3c..2d0c8b1066ba 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -398,12 +398,21 @@ void free_pgd_range(struct mmu_gather *tlb,
 	} while (pgd++, addr =3D next, addr !=3D end);
 }
=20
-void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
-		unsigned long floor, unsigned long ceiling)
+void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
+		   struct vm_area_struct *vma, unsigned long floor,
+		   unsigned long ceiling)
 {
-	while (vma) {
-		struct vm_area_struct *next =3D vma->vm_next;
+	unsigned long index =3D vma->vm_end;
+
+	do {
 		unsigned long addr =3D vma->vm_start;
+		struct vm_area_struct *next;
+
+		/*
+		 * Note: USER_PGTABLES_CEILING may be passed as ceiling and may
+		 * be 0.  This will underflow and is okay.
+		 */
+		next =3D mt_find(mt, &index, ceiling - 1);
=20
 		/*
 		 * Hide vma from rmap and truncate_pagecache before freeing
@@ -422,7 +431,7 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_ar=
ea_struct *vma,
 			while (next && next->vm_start <=3D vma->vm_end + PMD_SIZE
 			       && !is_vm_hugetlb_page(next)) {
 				vma =3D next;
-				next =3D vma->vm_next;
+				next =3D mt_find(mt, &index, ceiling - 1);
 				unlink_anon_vmas(vma);
 				unlink_file_vma(vma);
 			}
@@ -430,7 +439,7 @@ void free_pgtables(struct mmu_gather *tlb, struct vm_ar=
ea_struct *vma,
 				floor, next ? next->vm_start : ceiling);
 		}
 		vma =3D next;
-	}
+	} while (vma);
 }
=20
 int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
@@ -1616,17 +1625,19 @@ static void unmap_single_vma(struct mmu_gather *tlb=
,
  * ensure that any thus-far unmapped pages are flushed before unmap_vmas()
  * drops the lock and schedules.
  */
-void unmap_vmas(struct mmu_gather *tlb,
+void unmap_vmas(struct mmu_gather *tlb, struct maple_tree *mt,
 		struct vm_area_struct *vma, unsigned long start_addr,
 		unsigned long end_addr)
 {
 	struct mmu_notifier_range range;
+	unsigned long index =3D vma->vm_end;
=20
 	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
 				start_addr, end_addr);
 	mmu_notifier_invalidate_range_start(&range);
-	for ( ; vma && vma->vm_start < end_addr; vma =3D vma->vm_next)
+	do {
 		unmap_single_vma(tlb, vma, start_addr, end_addr, NULL);
+	} while ((vma =3D mt_find(mt, &index, end_addr - 1)) !=3D NULL);
 	mmu_notifier_invalidate_range_end(&range);
 }
=20
@@ -1641,6 +1652,9 @@ void unmap_vmas(struct mmu_gather *tlb,
 void zap_page_range(struct vm_area_struct *vma, unsigned long start,
 		unsigned long size)
 {
+	struct maple_tree *mt =3D &vma->vm_mm->mm_mt;
+	unsigned long index =3D vma->vm_end;
+	unsigned long end =3D start + size;
 	struct mmu_notifier_range range;
 	struct mmu_gather tlb;
=20
@@ -1650,8 +1664,9 @@ void zap_page_range(struct vm_area_struct *vma, unsig=
ned long start,
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 	update_hiwater_rss(vma->vm_mm);
 	mmu_notifier_invalidate_range_start(&range);
-	for ( ; vma && vma->vm_start < range.end; vma =3D vma->vm_next)
+	do {
 		unmap_single_vma(&tlb, vma, start, range.end, NULL);
+	} while ((vma =3D mt_find(mt, &index, end - 1)) !=3D NULL);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index afef4af1c621..06666706d5d3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -74,9 +74,10 @@ int mmap_rnd_compat_bits __read_mostly =3D CONFIG_ARCH_M=
MAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
=20
-static void unmap_region(struct mm_struct *mm,
+static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		unsigned long start, unsigned long end);
+		struct vm_area_struct *next, unsigned long start,
+		unsigned long end);
=20
 /* description of effects of mapping type and prot in current implementati=
on.
  * this is due to the limited x86 page protection hardware.  The expected
@@ -175,10 +176,8 @@ void unlink_file_vma(struct vm_area_struct *vma)
 /*
  * Close a vm structure and free it, returning the next.
  */
-static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
+static void remove_vma(struct vm_area_struct *vma)
 {
-	struct vm_area_struct *next =3D vma->vm_next;
-
 	might_sleep();
 	if (vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
@@ -186,13 +185,13 @@ static struct vm_area_struct *remove_vma(struct vm_ar=
ea_struct *vma)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
 	vm_area_free(vma);
-	return next;
 }
=20
 static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
 			 unsigned long newbrk, unsigned long oldbrk,
 			 struct list_head *uf);
-static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkv=
ma,
+static int do_brk_flags(struct ma_state *mas, struct ma_state *ma_prev,
+			struct vm_area_struct **brkvma,
 			unsigned long addr, unsigned long request,
 			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
@@ -205,6 +204,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct ma_state ma_neighbour;
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -263,7 +263,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		mas.last =3D oldbrk - 1;
 		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
 		if (ret =3D=3D 1)  {
 			downgraded =3D true;
@@ -274,28 +273,30 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		mm->brk =3D origbrk;
 		goto out;
 	}
+	ma_neighbour =3D mas;
+	mas_lock(&ma_neighbour);
+	next =3D mas_next(&ma_neighbour, newbrk + PAGE_SIZE + stack_guard_gap);
+	mas_unlock(&ma_neighbour);
 	/* Only check if the next VMA is within the stack_guard_gap of the
 	 * expansion area */
-	next =3D mas_next(&mas, newbrk + PAGE_SIZE + stack_guard_gap);
 	/* Check against existing mmap mappings. */
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
-	mas_lock(&mas);
-	brkvma =3D mas_prev(&mas, mm->start_brk);
-	mas_unlock(&mas);
+	mas_lock(&ma_neighbour);
+	brkvma =3D mas_prev(&ma_neighbour, mm->start_brk);
+	mas_unlock(&ma_neighbour);
 	if (brkvma) {
-		if(brkvma->vm_start >=3D oldbrk)
+		if (brkvma->vm_start >=3D oldbrk)
 			goto out; // Trying to map over another vma.
=20
-		if (brkvma->vm_end <=3D min_brk) {
+		if (brkvma->vm_end <=3D min_brk)
 			brkvma =3D NULL;
-			mas_reset(&mas);
-		}
 	}
=20
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(&mas, &brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
+	if (do_brk_flags(&mas, &ma_neighbour, &brkvma, oldbrk,
+			 newbrk - oldbrk, 0) < 0)
 		goto out;
=20
 	mm->brk =3D brk;
@@ -306,6 +307,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		mmap_read_unlock(mm);
 	else
 		mmap_write_unlock(mm);
+
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate)
 		mm_populate(oldbrk, newbrk - oldbrk);
@@ -324,45 +326,23 @@ extern void mt_dump(const struct maple_tree *mt);
 static void validate_mm_mt(struct mm_struct *mm)
 {
 	struct maple_tree *mt =3D &mm->mm_mt;
-	struct vm_area_struct *vma_mt, *vma =3D mm->mmap;
+	struct vm_area_struct *vma_mt;
=20
 	MA_STATE(mas, mt, 0, 0);
+
 	rcu_read_lock();
 	mas_for_each(&mas, vma_mt, ULONG_MAX) {
-		if (xa_is_zero(vma_mt))
-			continue;
-
-		if (!vma)
-			break;
-
-		if ((vma !=3D vma_mt) ||
-		    (vma->vm_start !=3D vma_mt->vm_start) ||
-		    (vma->vm_end !=3D vma_mt->vm_end) ||
-		    (vma->vm_start !=3D mas.index) ||
-		    (vma->vm_end - 1 !=3D mas.last)) {
+		if ((vma_mt->vm_start !=3D mas.index) ||
+		    (vma_mt->vm_end - 1 !=3D mas.last)) {
 			pr_emerg("issue in %s\n", current->comm);
 			dump_stack();
 #ifdef CONFIG_DEBUG_VM
 			dump_vma(vma_mt);
-			pr_emerg("and vm_next\n");
-			dump_vma(vma->vm_next);
 #endif // CONFIG_DEBUG_VM
 			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
 				 mas.index, mas.last);
 			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
 				 vma_mt->vm_start, vma_mt->vm_end);
-			if (vma->vm_prev) {
-				pr_emerg("ll prev: %px %lu - %lu\n",
-					 vma->vm_prev, vma->vm_prev->vm_start,
-					 vma->vm_prev->vm_end);
-			}
-			pr_emerg("ll vma: %px %lu - %lu\n", vma,
-				 vma->vm_start, vma->vm_end);
-			if (vma->vm_next) {
-				pr_emerg("ll next: %px %lu - %lu\n",
-					 vma->vm_next, vma->vm_next->vm_start,
-					 vma->vm_next->vm_end);
-			}
=20
 			mt_dump(mas.tree);
 			if (vma_mt->vm_end !=3D mas.last + 1) {
@@ -379,12 +359,7 @@ static void validate_mm_mt(struct mm_struct *mm)
 			}
 			VM_BUG_ON_MM(vma_mt->vm_start !=3D mas.index, mm);
 		}
-		VM_BUG_ON(vma !=3D vma_mt);
-		vma =3D vma->vm_next;
-
 	}
-	VM_BUG_ON(vma);
-
 	rcu_read_unlock();
 	mt_validate(&mm->mm_mt);
 }
@@ -393,35 +368,33 @@ static void validate_mm(struct mm_struct *mm)
 {
 	int bug =3D 0;
 	int i =3D 0;
-	unsigned long highest_address =3D 0;
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	validate_mm_mt(mm);
=20
-	while (vma) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 #ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma =3D vma->anon_vma;
 		struct anon_vma_chain *avc;
+
+		rcu_read_unlock();
 		if (anon_vma) {
 			anon_vma_lock_read(anon_vma);
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				anon_vma_interval_tree_verify(avc);
 			anon_vma_unlock_read(anon_vma);
 		}
+		rcu_read_lock();
 #endif
-		highest_address =3D vm_end_gap(vma);
-		vma =3D vma->vm_next;
 		i++;
 	}
+	rcu_read_unlock();
 	if (i !=3D mm->map_count) {
 		pr_emerg("map_count %d vm_next %d\n", mm->map_count, i);
 		bug =3D 1;
 	}
-	if (highest_address !=3D mm->highest_vm_end) {
-		pr_emerg("mm->highest_vm_end %lx, found %lx\n",
-			  mm->highest_vm_end, highest_address);
-		bug =3D 1;
-	}
 	VM_BUG_ON_MM(bug, mm);
 }
=20
@@ -479,29 +452,13 @@ bool range_has_overlap(struct mm_struct *mm, unsigned=
 long start,
 	struct vm_area_struct *existing;
=20
 	MA_STATE(mas, &mm->mm_mt, start, start);
+	rcu_read_lock();
 	existing =3D mas_find(&mas, end - 1);
 	*pprev =3D mas_prev(&mas, 0);
+	rcu_read_unlock();
 	return existing ? true : false;
 }
=20
-/*
- * _vma_next() - Get the next VMA or the first.
- * @mm: The mm_struct.
- * @vma: The current vma.
- *
- * If @vma is NULL, return the first vma in the mm.
- *
- * Returns: The next VMA after @vma.
- */
-static inline struct vm_area_struct *_vma_next(struct mm_struct *mm,
-					 struct vm_area_struct *vma)
-{
-	if (!vma)
-		return mm->mmap;
-
-	return vma->vm_next;
-}
-
 /*
  * count_vma_pages_range() - Count the number of pages in a range.
  * @mas: The maple state
@@ -598,7 +555,7 @@ void vma_mt_store(struct mm_struct *mm, struct vm_area_=
struct *vma)
  * @vma: The VMA to link in
  * @mas: The maple state
  *
- * Must hold the @mas lock.
+ * Must not hold the maple tree lock.
  */
 static void vma_mas_link(struct mm_struct *mm, struct vm_area_struct *vma,
 			 struct ma_state *mas, struct vm_area_struct *prev)
@@ -610,15 +567,15 @@ static void vma_mas_link(struct mm_struct *mm, struct=
 vm_area_struct *vma,
 		i_mmap_lock_write(mapping);
 	}
=20
+	mas_lock(mas);
 	vma_mas_store(vma, mas);
-	__vma_link_list(mm, vma, prev);
+	mas_unlock(mas);
 	__vma_link_file(vma);
=20
 	if (mapping)
 		i_mmap_unlock_write(mapping);
=20
 	mm->map_count++;
-	validate_mm(mm);
 }
=20
 static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
@@ -632,7 +589,6 @@ static void vma_link(struct mm_struct *mm, struct vm_ar=
ea_struct *vma,
 	}
=20
 	vma_mt_store(mm, vma);
-	__vma_link_list(mm, vma, prev);
 	__vma_link_file(vma);
=20
 	if (mapping)
@@ -652,7 +608,6 @@ static void __insert_vm_struct(struct mm_struct *mm, st=
ruct vm_area_struct *vma)
=20
 	BUG_ON(range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev));
 	vma_mt_store(mm, vma);
-	__vma_link_list(mm, vma, prev);
 	mm->map_count++;
 }
=20
@@ -710,7 +665,9 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 	vma->vm_end =3D end;
 	vma->vm_pgoff =3D pgoff;
 	/* Note: mas must be pointing to the expanding VMA */
+	mas_lock(mas);
 	vma_mas_store(vma, mas);
+	mas_unlock(mas);
=20
 	if (file) {
 		vma_interval_tree_insert(vma, root);
@@ -718,15 +675,8 @@ inline int vma_expand(struct ma_state *mas, struct vm_=
area_struct *vma,
 	}
=20
 	/* Expanding over the next vma */
-	if (remove_next) {
-		/* Remove from mm linked list - also updates highest_vm_end */
-		__vma_unlink_list(mm, next);
-
-		if (file)
-			__remove_shared_vm_struct(next, file, mapping);
-
-	} else if (!next) {
-		mm->highest_vm_end =3D vm_end_gap(vma);
+	if (remove_next && file) {
+		__remove_shared_vm_struct(next, file, mapping);
 	}
=20
 	if (anon_vma) {
@@ -767,7 +717,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	struct vm_area_struct *expand)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct *next =3D vma->vm_next, *orig_vma =3D vma;
+	struct vm_area_struct *next =3D vma_next(mm, vma), *orig_vma =3D vma;
 	struct address_space *mapping =3D NULL;
 	struct rb_root_cached *root =3D NULL;
 	struct anon_vma *anon_vma =3D NULL;
@@ -808,7 +758,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 				 */
 				remove_next =3D 1 + (end > next->vm_end);
 				VM_WARN_ON(remove_next =3D=3D 2 &&
-					   end !=3D next->vm_next->vm_end);
+					   end !=3D vma_next(mm, next)->vm_end);
 				/* trim end to next, for case 6 first pass */
 				end =3D next->vm_end;
 			}
@@ -821,7 +771,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 			 * next, if the vma overlaps with it.
 			 */
 			if (remove_next =3D=3D 2 && !next->anon_vma)
-				exporter =3D next->vm_next;
+				exporter =3D vma_next(mm, next);
=20
 		} else if (end > next->vm_start) {
 			/*
@@ -913,8 +863,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		else
 			vma_changed =3D true;
 		vma->vm_end =3D end;
-		if (!next)
-			mm->highest_vm_end =3D vm_end_gap(vma);
 	}
=20
 	if (vma_changed)
@@ -934,10 +882,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		flush_dcache_mmap_unlock(mapping);
 	}
=20
-	if (remove_next) {
-		__vma_unlink_list(mm, next);
-		if (file)
-			__remove_shared_vm_struct(next, file, mapping);
+	if (remove_next && file) {
+		__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
 		/*
 		 * split_vma has split insert from vma, and needs
@@ -984,7 +930,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 			 * "next->vm_prev->vm_end" changed and the
 			 * "vma->vm_next" gap must be updated.
 			 */
-			next =3D vma->vm_next;
+			next =3D vma_next(mm, vma);
 		} else {
 			/*
 			 * For the scope of the comment "next" and
@@ -1002,33 +948,14 @@ int __vma_adjust(struct vm_area_struct *vma, unsigne=
d long start,
 			remove_next =3D 1;
 			end =3D next->vm_end;
 			goto again;
-		} else if (!next) {
-			/*
-			 * If remove_next =3D=3D 2 we obviously can't
-			 * reach this path.
-			 *
-			 * If remove_next =3D=3D 3 we can't reach this
-			 * path because pre-swap() next is always not
-			 * NULL. pre-swap() "next" is not being
-			 * removed and its next->vm_end is not altered
-			 * (and furthermore "end" already matches
-			 * next->vm_end in remove_next =3D=3D 3).
-			 *
-			 * We reach this only in the remove_next =3D=3D 1
-			 * case if the "next" vma that was removed was
-			 * the highest vma of the mm. However in such
-			 * case next->vm_end =3D=3D "end" and the extended
-			 * "vma" has vma->vm_end =3D=3D next->vm_end so
-			 * mm->highest_vm_end doesn't need any update
-			 * in remove_next =3D=3D 1 case.
-			 */
-			VM_WARN_ON(mm->highest_vm_end !=3D vm_end_gap(vma));
 		}
 	}
-	if (insert && file)
+	if (insert && file) {
 		uprobe_mmap(insert);
+	}
=20
 	validate_mm(mm);
+
 	return 0;
 }
=20
@@ -1182,10 +1109,10 @@ struct vm_area_struct *vma_merge(struct mm_struct *=
mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D _vma_next(mm, prev);
+	next =3D find_vma(mm, prev ? prev->vm_end : 0);
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
-		next =3D next->vm_next;
+		next =3D vma_next(mm, next);
=20
 	/* verify some invariant that must be enforced by the caller */
 	VM_WARN_ON(prev && addr <=3D prev->vm_start);
@@ -1321,16 +1248,20 @@ struct anon_vma *find_mergeable_anon_vma(struct vm_=
area_struct *vma)
 {
 	struct anon_vma *anon_vma =3D NULL;
=20
+	struct vm_area_struct *prev, *next;
+
 	/* Try next first. */
-	if (vma->vm_next) {
-		anon_vma =3D reusable_anon_vma(vma->vm_next, vma, vma->vm_next);
+	next =3D vma_next(vma->vm_mm, vma);
+	if (next) {
+		anon_vma =3D reusable_anon_vma(next, vma, next);
 		if (anon_vma)
 			return anon_vma;
 	}
=20
+	prev =3D vma_prev(vma->vm_mm, vma);
 	/* Try prev next. */
-	if (vma->vm_prev)
-		anon_vma =3D reusable_anon_vma(vma->vm_prev, vma->vm_prev, vma);
+	if (prev)
+		anon_vma =3D reusable_anon_vma(prev, prev, vma);
=20
 	/*
 	 * We might reach here with anon_vma =3D=3D NULL if we can't find
@@ -1986,15 +1917,10 @@ struct vm_area_struct *find_vma_intersection(struct=
 mm_struct *mm,
 					     unsigned long start_addr,
 					     unsigned long end_addr)
 {
-	struct vm_area_struct *vma;
-	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
+	unsigned long index =3D start_addr;
=20
 	mmap_assert_locked(mm);
-	rcu_read_lock();
-	vma =3D mas_find(&mas, end_addr - 1);
-	rcu_read_unlock();
-
-	return vma;
+	return mt_find(&mm->mm_mt, &index, end_addr - 1);
 }
 EXPORT_SYMBOL(find_vma_intersection);
=20
@@ -2008,8 +1934,9 @@ EXPORT_SYMBOL(find_vma_intersection);
  */
 inline struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long=
 addr)
 {
-	// Note find_vma_intersection will decrease 0 to underflow to ULONG_MAX
-	return find_vma_intersection(mm, addr, 0);
+	unsigned long index =3D addr;
+
+	return mt_find(&mm->mm_mt, &index, ULONG_MAX);
 }
 EXPORT_SYMBOL(find_vma);
=20
@@ -2111,7 +2038,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	if (gap_addr < address || gap_addr > TASK_SIZE)
 		gap_addr =3D TASK_SIZE;
=20
-	next =3D vma->vm_next;
+	next =3D vma_next(mm, vma);
 	if (next && next->vm_start < gap_addr && vma_is_accessible(next)) {
 		if (!(next->vm_flags & VM_GROWSUP))
 			return -ENOMEM;
@@ -2157,8 +2084,6 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 				vma->vm_end =3D address;
 				vma_mt_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
-				if (!vma->vm_next)
-					mm->highest_vm_end =3D vm_end_gap(vma);
 				spin_unlock(&mm->page_table_lock);
=20
 				perf_event_mmap(vma);
@@ -2185,7 +2110,7 @@ int expand_downwards(struct vm_area_struct *vma, unsi=
gned long address)
 		return -EPERM;
=20
 	/* Enforce stack_guard_gap */
-	prev =3D vma->vm_prev;
+	prev =3D vma_prev(mm, vma);
 	/* Check that both stack segments have the same anon_vma? */
 	if (prev && !(prev->vm_flags & VM_GROWSDOWN) &&
 			vma_is_accessible(prev)) {
@@ -2320,20 +2245,22 @@ EXPORT_SYMBOL_GPL(find_extend_vma);
  *
  * Called with the mm semaphore held.
  */
-static void remove_vma_list(struct mm_struct *mm, struct vm_area_struct *v=
ma)
+static inline void remove_mt(struct mm_struct *mm, struct maple_tree *deta=
ched)
 {
 	unsigned long nr_accounted =3D 0;
+	unsigned long index =3D 0;
+	struct vm_area_struct *vma;
=20
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
-	do {
+	mt_for_each(detached, vma, index, ULONG_MAX) {
 		long nrpages =3D vma_pages(vma);
=20
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted +=3D nrpages;
 		vm_stat_account(mm, vma->vm_flags, -nrpages);
-		vma =3D remove_vma(vma);
-	} while (vma);
+		remove_vma(vma);
+	}
 	vm_unacct_memory(nr_accounted);
 	validate_mm(mm);
 }
@@ -2343,18 +2270,18 @@ static void remove_vma_list(struct mm_struct *mm, s=
truct vm_area_struct *vma)
  *
  * Called with the mm semaphore held.
  */
-static void unmap_region(struct mm_struct *mm,
+static void unmap_region(struct mm_struct *mm, struct maple_tree *mt,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
+		struct vm_area_struct *next,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D _vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, vma, start, end);
-	free_pgtables(&tlb, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
+	unmap_vmas(&tlb, mt, vma, start, end);
+	free_pgtables(&tlb, mt, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
 				 next ? next->vm_start : USER_PGTABLES_CEILING);
 	tlb_finish_mmu(&tlb);
 }
@@ -2395,8 +2322,9 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	if (err)
 		goto out_free_mpol;
=20
-	if (new->vm_file)
+	if (new->vm_file) {
 		get_file(new->vm_file);
+	}
=20
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
@@ -2438,27 +2366,6 @@ int split_vma(struct mm_struct *mm, struct vm_area_s=
truct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-static inline int
-unlock_range(struct vm_area_struct *start, struct vm_area_struct **tail,
-	     unsigned long limit)
-{
-	struct mm_struct *mm =3D start->vm_mm;
-	struct vm_area_struct *tmp =3D start;
-	int count =3D 0;
-
-	while (tmp && tmp->vm_start < limit) {
-		*tail =3D tmp;
-		count++;
-		if (tmp->vm_flags & VM_LOCKED) {
-			mm->locked_vm -=3D vma_pages(tmp);
-			munlock_vma_pages_all(tmp);
-		}
-		tmp =3D tmp->vm_next;
-	}
-
-	return count;
-}
-
 /*
  * do_mas_align_munmap() - munmap the aligned region from @start to @end.
  * @mas: The maple_state, ideally set up to alter the correct tree locatio=
n.
@@ -2477,9 +2384,13 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_=
area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
 		    unsigned long end, struct list_head *uf, bool downgrade)
 {
-	struct vm_area_struct *prev, *last;
-	/* we have start < vma->vm_end  */
+	struct vm_area_struct *prev, *next;
+	struct maple_tree mt_detach;
+	int count =3D 0;
+	MA_STATE(mas_detach, &mt_detach, start, end - 1);
+	mtree_init(&mt_detach, MAPLE_ALLOC_RANGE);
=20
+	prev =3D next =3D NULL;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2487,8 +2398,11 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_=
area_struct *vma,
 	 * unmapped vm_area_struct will remain in use: so lower split_vma
 	 * places tmp vma above, and higher split_vma places tmp vma below.
 	 */
+
+	/* Does it split the first one? */
 	if (start > vma->vm_start) {
 		int error;
+
 		/*
 		 * Make sure that map_count on return from munmap() will
 		 * not exceed its limit; but let map_count go just above
@@ -2497,31 +2411,55 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
 			return -ENOMEM;
=20
-		error =3D __split_vma(mm, vma, start, 0);
+		/*
+		 * mas_pause() is not needed since mas->index needs to be set
+		 * differently than vma->vm_end anyways.
+		 */
+		mas_unlock(mas);
+		error =3D __split_vma(mm, vma, start, 1);
+		mas_lock(mas);
 		if (error)
 			return error;
-		prev =3D vma;
-		vma =3D _vma_next(mm, prev);
-		mas->index =3D start;
-		mas_reset(mas);
+
+		mas_set(mas, start - 1);
+		prev =3D mas_walk(mas);
 	} else {
-		prev =3D vma->vm_prev;
+		prev =3D mas_prev(mas, 0);
+		if (!prev)
+			mas_set(mas, start);
 	}
=20
-	if (vma->vm_end >=3D end)
-		last =3D vma;
-	else
-		last =3D find_vma_intersection(mm, end - 1, end);
+	/*
+	 * Detach a range of VMAs from the mm. Using next as a temp variable as
+	 * it is always overwritten.
+	 */
+	mas_lock(&mas_detach);
+	mas_for_each(mas, next, end - 1) {
+		/* Does it split the end? */
+		if (next->vm_end > end) {
+			int error;
=20
-	/* Does it split the last one? */
-	if (last && end < last->vm_end) {
-		int error =3D __split_vma(mm, last, end, 1);
-		if (error)
-			return error;
-		vma =3D _vma_next(mm, prev);
-		mas_reset(mas);
+			mas_unlock(mas);
+			error =3D __split_vma(mm, next, end, 0);
+			mas_lock(mas);
+			if (error)
+				return error;
+		}
+		count++;
+#ifdef CONFIG_DEBUG_MAPLE_TREE
+		BUG_ON(next->vm_start < start);
+		BUG_ON(next->vm_start > end);
+#endif
+		vma_mas_store(next, &mas_detach);
+		if (next->vm_flags & VM_LOCKED) {
+			mm->locked_vm -=3D vma_pages(next);
+			munlock_vma_pages_all(next);
+		}
 	}
+	mas_unlock(&mas_detach);
=20
+	mas_set(mas, end);
+	next =3D mas_find(mas, ULONG_MAX);
=20
 	if (unlikely(uf)) {
 		/*
@@ -2539,35 +2477,37 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 			return error;
 	}
=20
-	/*
-	 * unlock any mlock()ed ranges before detaching vmas, count the number
-	 * of VMAs to be dropped, and return the tail entry of the affected
-	 * area.
-	 */
-	mm->map_count -=3D unlock_range(vma, &last, end);
-	/* Drop removed area from the tree */
-	mas_store_gfp(mas, NULL, GFP_KERNEL);
-
-	/* Detach vmas from the MM linked list */
-	vma->vm_prev =3D NULL;
-	if (prev)
-		prev->vm_next =3D last->vm_next;
-	else
-		mm->mmap =3D last->vm_next;
-
-	if (last->vm_next) {
-		last->vm_next->vm_prev =3D prev;
-		last->vm_next =3D NULL;
-	} else
-		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
+	/* Point of no return */
+	mas_set_range(mas, start, end - 1);
+#if defined(CONFIG_DEBUG_MAPLE_TREE)
+	/* Make sure no VMAs are about to be lost. */
+	{
+		MA_STATE(test, &mt_detach, start, end - 1);
+		struct vm_area_struct *vma_mas, *vma_test;
+		int test_count =3D 0;
=20
+		rcu_read_lock();
+		vma_test =3D mas_find(&test, end - 1);
+		mas_for_each(mas, vma_mas, end - 1) {
+			BUG_ON(vma_mas !=3D vma_test);
+			test_count++;
+			vma_test =3D mas_next(&test, end - 1);
+		}
+		rcu_read_unlock();
+		BUG_ON(count !=3D test_count);
+		mas_set_range(mas, start, end - 1);
+	}
+#endif
+	mas_store_gfp(mas, NULL, GFP_KERNEL);
+	mm->map_count -=3D count;
+	mas_unlock(mas);
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
 	 * VM_GROWSUP VMA. Such VMAs can change their size under
 	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
 	 */
 	if (downgrade) {
-		if (last && (last->vm_flags & VM_GROWSDOWN))
+		if (next && (next->vm_flags & VM_GROWSDOWN))
 			downgrade =3D false;
 		else if (prev && (prev->vm_flags & VM_GROWSUP))
 			downgrade =3D false;
@@ -2575,10 +2515,15 @@ do_mas_align_munmap(struct ma_state *mas, struct vm=
_area_struct *vma,
 			mmap_write_downgrade(mm);
 	}
=20
-	unmap_region(mm, vma, prev, start, end);
+	unmap_region(mm, &mt_detach, vma, prev, next, start, end);
+
+	/* Statistics and freeing VMAs */
+	remove_mt(mm, &mt_detach);
+	mtree_destroy(&mt_detach);
+	validate_mm(mm);
=20
-	/* Fix up all other VM information */
-	remove_vma_list(mm, vma);
+	if (!downgrade)
+		mas_lock(mas);
=20
 	return downgrade ? 1 : 0;
 }
@@ -2635,8 +2580,13 @@ int do_mas_munmap(struct ma_state *mas, struct mm_st=
ruct *mm,
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
+	int ret;
 	MA_STATE(mas, &mm->mm_mt, start, start);
-	return do_mas_munmap(&mas, mm, start, len, uf, false);
+
+	mas_lock(&mas);
+	ret =3D do_mas_munmap(&mas, mm, start, len, uf, false);
+	mas_unlock(&mas);
+	return ret;
 }
=20
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2670,8 +2620,12 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
+	mas_lock(&mas);
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false)) {
+		mas_unlock(&mas);
 		return -ENOMEM;
+	}
+	mas_unlock(&mas);
=20
 	/*
 	 * Private writable mapping: check memory availability
@@ -2762,6 +2716,11 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		 * new file must not have been exposed to user-space, yet.
 		 */
 		vma->vm_file =3D get_file(file);
+		/*
+		 * call_mmap() may sleep, but will not alter the maple tree
+		 * since the mmap_lock is held.  This is safe and will be
+		 * changed later.
+		 */
 		error =3D call_mmap(file, vma);
 		file =3D vma->vm_file;
 		if (error)
@@ -2865,7 +2824,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	vma->vm_file =3D NULL;
=20
 	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	unmap_region(mm, mas.tree, vma, prev, next, vma->vm_start, vma->vm_end);
 	charged =3D 0;
 	if (vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
@@ -2890,6 +2849,7 @@ static int __vm_munmap(unsigned long start, size_t le=
n, bool downgrade)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
+	mas_lock(&mas);
 	ret =3D do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
@@ -2899,8 +2859,10 @@ static int __vm_munmap(unsigned long start, size_t l=
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
@@ -2957,11 +2919,11 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
 		goto out;
=20
 	if (start + size > vma->vm_end) {
-		struct vm_area_struct *next;
+		struct vm_area_struct *next, *prev =3D vma;
=20
-		for (next =3D vma->vm_next; next; next =3D next->vm_next) {
+		for (next =3D vma_next(mm, vma); next; next =3D vma_next(mm, next)) {
 			/* hole between vmas ? */
-			if (next->vm_start !=3D next->vm_prev->vm_end)
+			if (next->vm_start !=3D prev->vm_end)
 				goto out;
=20
 			if (next->vm_file !=3D vma->vm_file)
@@ -2972,6 +2934,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, star=
t, unsigned long, size,
=20
 			if (start + size <=3D next->vm_end)
 				break;
+			prev =3D next;
 		}
=20
 		if (!next)
@@ -3017,7 +2980,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 			 struct list_head *uf)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct unmap;
+	struct vm_area_struct unmap, *next;
 	unsigned long unmap_pages;
 	int ret;
=20
@@ -3027,17 +2990,25 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
 		// remove entire mapping(s)
 		mas->last =3D oldbrk - 1;
+		mas_lock(mas);
 		ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf,
 					  true);
+		if (ret !=3D 1)
+			mas_unlock(mas);
 		goto munmap_full_vma;
 	}
=20
 	vma_init(&unmap, mm);
 	unmap.vm_start =3D newbrk;
 	unmap.vm_end =3D oldbrk;
+	unmap.vm_pgoff =3D newbrk >> PAGE_SHIFT;
+	if (vma->anon_vma)
+		vma_set_anonymous(&unmap);
+
 	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
 	if (ret)
 		return ret;
+
 	ret =3D 1;
=20
 	// Change the oldbrk of vma to the newbrk of the munmap area
@@ -3047,10 +3018,12 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 		anon_vma_interval_tree_pre_update_vma(vma);
 	}
=20
-	vma->vm_end =3D newbrk;
+	mas_lock(mas);
 	if (vma_mas_remove(&unmap, mas))
 		goto mas_store_fail;
+	mas_unlock(mas);
=20
+	vma->vm_end =3D newbrk;
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
 		anon_vma_unlock_write(vma->anon_vma);
@@ -3062,8 +3035,11 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
 		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
 	}
=20
+	mas_lock(mas);
+	next =3D mas_next(mas, ULONG_MAX);
+	mas_unlock(mas);
 	mmap_write_downgrade(mm);
-	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	unmap_region(mm, mas->tree, &unmap, vma, next, newbrk, oldbrk);
 	/* Statistics */
 	vm_stat_account(mm, unmap.vm_flags, -unmap_pages);
 	if (unmap.vm_flags & VM_ACCOUNT)
@@ -3074,6 +3050,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	return ret;
=20
 mas_store_fail:
+	mas_unlock(mas);
 	vma->vm_end =3D oldbrk;
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
@@ -3094,15 +3071,16 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
  * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
  * do some brk-specific accounting here.
  */
-static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkv=
ma,
+static int do_brk_flags(struct ma_state *mas, struct ma_state *ma_prev,
+			struct vm_area_struct **brkvma,
 			unsigned long addr, unsigned long len,
 			unsigned long flags)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *prev =3D NULL, *vma;
+	struct vm_area_struct *vma;
 	int error;
 	unsigned long mapped_addr;
-	validate_mm_mt(mm);
+	validate_mm(mm);
=20
 	/* Until we need other flags, refuse anything except VM_EXEC. */
 	if ((flags & (~VM_EXEC)) !=3D 0)
@@ -3127,7 +3105,6 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct **brkvma,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	mas->last =3D addr + len - 1;
 	if (*brkvma) {
 		vma =3D *brkvma;
 		/* Expand the existing vma if possible; almost never a singular
@@ -3136,7 +3113,8 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct **brkvma,
 		if ((!vma->anon_vma ||
 		     list_is_singular(&vma->anon_vma_chain)) &&
 		     ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)){
-			mas->index =3D vma->vm_start;
+			ma_prev->index =3D vma->vm_start;
+			ma_prev->last =3D addr + len - 1;
=20
 			vma_adjust_trans_huge(vma, addr, addr + len, 0);
 			if (vma->anon_vma) {
@@ -3145,11 +3123,28 @@ static int do_brk_flags(struct ma_state *mas, struc=
t vm_area_struct **brkvma,
 			}
 			vma->vm_end =3D addr + len;
 			vma->vm_flags |=3D VM_SOFTDIRTY;
-			mas_lock(mas);
-			if (mas_store_gfp(mas, vma, GFP_KERNEL))
+
+			mas_lock(ma_prev);
+#if defined(CONFIG_DEBUG_MAPLE_TREE)
+			/* Make sure no VMAs are about to be lost. */
+			{
+				MA_STATE(test, ma_prev->tree, vma->vm_start,
+					 vma->vm_end - 1);
+				struct vm_area_struct *vma_mas;
+				int count =3D 0;
+
+				mas_for_each(&test, vma_mas, vma->vm_end - 1)
+					count++;
+
+				BUG_ON(count !=3D 1);
+				mas_set_range(ma_prev, vma->vm_start,
+					      vma->vm_end - 1);
+			}
+#endif
+			if (mas_store_gfp(ma_prev, vma, GFP_KERNEL))
 				goto mas_mod_fail;
+			mas_unlock(ma_prev);
=20
-			mas_unlock(mas);
 			if (vma->anon_vma) {
 				anon_vma_interval_tree_post_update_vma(vma);
 				anon_vma_unlock_write(vma->anon_vma);
@@ -3157,12 +3152,7 @@ static int do_brk_flags(struct ma_state *mas, struct=
 vm_area_struct **brkvma,
 			khugepaged_enter_vma_merge(vma, flags);
 			goto out;
 		}
-		prev =3D vma;
 	}
-	mas_lock(mas);
-	mas->index =3D addr;
-	mas_walk(mas);
-	mas_unlock(mas);
=20
 	/* create a vma struct for an anonymous mapping */
 	vma =3D vm_area_alloc(mm);
@@ -3175,16 +3165,7 @@ static int do_brk_flags(struct ma_state *mas, struct=
 vm_area_struct **brkvma,
 	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	mas_lock(mas);
-	if (vma_mas_store(vma, mas))
-		goto mas_store_fail;
-	mas_unlock(mas);
-
-	if (!prev)
-		prev =3D mas_prev(mas, 0);
-
-	__vma_link_list(mm, vma, prev);
-	mm->map_count++;
+	vma_mas_link(mm, vma, mas, NULL);
 	*brkvma =3D vma;
 out:
 	perf_event_mmap(vma);
@@ -3193,17 +3174,16 @@ static int do_brk_flags(struct ma_state *mas, struc=
t vm_area_struct **brkvma,
 	if (flags & VM_LOCKED)
 		mm->locked_vm +=3D (len >> PAGE_SHIFT);
 	vma->vm_flags |=3D VM_SOFTDIRTY;
-	validate_mm_mt(mm);
+	validate_mm(mm);
 	return 0;
=20
-mas_store_fail:
 	vm_area_free(vma);
 vma_alloc_fail:
 	vm_unacct_memory(len >> PAGE_SHIFT);
 	return -ENOMEM;
=20
 mas_mod_fail:
-	mas_unlock(mas);
+	mas_unlock(ma_prev);
 	vma->vm_end =3D addr;
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
@@ -3231,9 +3211,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
quest, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	// This vma left intentionally blank.
-	mas_walk(&mas);
-	ret =3D do_brk_flags(&mas, &vma, addr, len, flags);
+	ret =3D do_brk_flags(&mas, &mas, &vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
 	if (populate && !ret)
@@ -3254,6 +3232,9 @@ void exit_mmap(struct mm_struct *mm)
 	struct mmu_gather tlb;
 	struct vm_area_struct *vma;
 	unsigned long nr_accounted =3D 0;
+	unsigned long index =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	int count =3D 0;
=20
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
@@ -3282,13 +3263,24 @@ void exit_mmap(struct mm_struct *mm)
 		mmap_write_unlock(mm);
 	}
=20
-	if (mm->locked_vm)
-		unlock_range(mm->mmap, &vma, ULONG_MAX);
+	if (mm->locked_vm) {
+		mas_lock(&mas);
+		mas_for_each(&mas, vma, ULONG_MAX) {
+			if (vma->vm_flags & VM_LOCKED) {
+				mm->locked_vm -=3D vma_pages(vma);
+				munlock_vma_pages_all(vma);
+			}
+		}
+		mas_unlock(&mas);
+		mas_set(&mas, 0);
+	}
=20
 	arch_exit_mmap(mm);
=20
-	vma =3D mm->mmap;
-	if (!vma)	/* Can happen if dup_mmap() received an OOM */
+	rcu_read_lock();
+	vma =3D mas_find(&mas, ULONG_MAX);
+	rcu_read_unlock();
+	if (!vma) /* Can happen if dup_mmap() received an OOM */
 		return;
=20
 	lru_add_drain();
@@ -3296,21 +3288,24 @@ void exit_mmap(struct mm_struct *mm)
 	tlb_gather_mmu_fullmm(&tlb, mm);
 	/* update_hiwater_rss(mm) here? but nobody should be looking */
 	/* Use -1 here to ensure all VMAs in the mm are unmapped */
-	unmap_vmas(&tlb, vma, 0, -1);
-	free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
+	unmap_vmas(&tlb, &mm->mm_mt, vma, 0, ULONG_MAX);
+	free_pgtables(&tlb, &mm->mm_mt, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CE=
ILING);
 	tlb_finish_mmu(&tlb);
=20
 	/*
 	 * Walk the list again, actually closing and freeing it,
 	 * with preemption enabled, without holding any MM locks.
 	 */
-	while (vma) {
+	mt_for_each(&mm->mm_mt, vma, index, ULONG_MAX) {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted +=3D vma_pages(vma);
-		vma =3D remove_vma(vma);
+		remove_vma(vma);
+		count++;
 		cond_resched();
 	}
=20
+	BUG_ON(count !=3D mm->map_count);
+
 	trace_exit_mmap(mm);
 	mtree_destroy(&mm->mm_mt);
 	vm_unacct_memory(nr_accounted);
@@ -3719,12 +3714,13 @@ int mm_take_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	BUG_ON(mmap_read_trylock(mm));
=20
 	mutex_lock(&mm_all_locks_mutex);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
@@ -3732,7 +3728,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 			vm_lock_mapping(mm, vma->vm_file->f_mapping);
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_set(&mas, 0);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->vm_file && vma->vm_file->f_mapping &&
@@ -3740,7 +3737,8 @@ int mm_take_all_locks(struct mm_struct *mm)
 			vm_lock_mapping(mm, vma->vm_file->f_mapping);
 	}
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_set(&mas, 0);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
 		if (vma->anon_vma)
@@ -3799,11 +3797,12 @@ void mm_drop_all_locks(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	struct anon_vma_chain *avc;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	BUG_ON(mmap_read_trylock(mm));
 	BUG_ON(!mutex_is_locked(&mm_all_locks_mutex));
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (vma->anon_vma)
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				vm_unlock_anon_vma(avc->anon_vma);
diff --git a/mm/nommu.c b/mm/nommu.c
index 675aee78f8f2..63dd382d09d3 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -577,7 +577,6 @@ static void add_vma_to_mm(struct mm_struct *mm, struct =
vm_area_struct *vma)
 	mas_reset(&mas);
 	/* add the VMA to the tree */
 	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
 }
=20
 /*
@@ -602,7 +601,6 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
-	__vma_unlink_list(vma->vm_mm, vma);
 }
=20
 /*
@@ -1415,7 +1413,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 				return -EINVAL;
 			if (end =3D=3D vma->vm_end)
 				goto erase_whole_vma;
-			vma =3D vma->vm_next;
+			vma =3D  vma_next(mm, vma);
 		} while (vma);
 		return -EINVAL;
 	} else {
@@ -1472,7 +1470,7 @@ void exit_mmap(struct mm_struct *mm)
 	mm->total_vm =3D 0;
=20
 	while ((vma =3D mm->mmap)) {
-		mm->mmap =3D vma->vm_next;
+		mm->mmap =3D vma_next(mm, vma);
 		delete_vma_from_mm(vma);
 		delete_vma(mm, vma);
 		cond_resched();
diff --git a/mm/util.c b/mm/util.c
index af8508e07a8e..1a420f0742f4 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -271,46 +271,6 @@ void *memdup_user_nul(const void __user *src, size_t l=
en)
 }
 EXPORT_SYMBOL(memdup_user_nul);
=20
-void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct vm_area_struct *prev)
-{
-	struct vm_area_struct *next;
-
-	vma->vm_prev =3D prev;
-	if (prev) {
-		next =3D prev->vm_next;
-		prev->vm_next =3D vma;
-	} else {
-		next =3D mm->mmap;
-		mm->mmap =3D vma;
-	}
-	vma->vm_next =3D next;
-	if (next)
-		next->vm_prev =3D vma;
-	else
-		mm->highest_vm_end =3D vm_end_gap(vma);
-}
-
-void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	struct vm_area_struct *prev, *next;
-
-	next =3D vma->vm_next;
-	prev =3D vma->vm_prev;
-	if (prev)
-		prev->vm_next =3D next;
-	else
-		mm->mmap =3D next;
-	if (next)
-		next->vm_prev =3D prev;
-	else {
-		if (prev)
-			mm->highest_vm_end =3D vm_end_gap(prev);
-		else
-			mm->highest_vm_end =3D 0;
-	}
-}
-
 /* Check if the vma is being used as a stack by this task */
 int vma_is_stack_for_current(struct vm_area_struct *vma)
 {
--=20
2.30.2
