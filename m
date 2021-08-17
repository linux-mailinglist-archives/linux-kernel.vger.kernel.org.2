Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69F93EEF8E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240496AbhHQPxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:53:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9112 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240197AbhHQPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:31 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjTxL006859;
        Tue, 17 Aug 2021 15:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=B/CXMDCg88zQJULLR50hsANdz1bEnJVRcUSLy8dEuDo=;
 b=SkefR89tYULJUHSTfM8sCI+yPIdeLz4JeXp+WsBUjsz8nO1NJgLnlwiYSEBXd0hev7ys
 IzaaV6LzTd08kVgQ3CaY1+FnMBCUAD4ifDP4NlkNfVv41m6Mn/5OAlyYJ+c6LtZnkUDs
 VBwWhUvTBdsI0pv+5hD+8Ap0G4lo3TLN7vBPiglGFknN+o+ZcQJtHaqJf3g7Myup5t0Z
 /BmK0H0FYdiTjMuBWeFniihwyw5zSOGGbKNl20B2lmLApDv57/jBrFMCNvK5wpQHJFT8
 oBml/7APVwsEWPq+it1FjlhjwB/N5D2b6U05jG37slNymV0xMRdOr6y09J9j/KPZcANV VQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=B/CXMDCg88zQJULLR50hsANdz1bEnJVRcUSLy8dEuDo=;
 b=xQT8ethuN0iuxWtYkZrcPs3kgPVl2QHlj1JE2DPTyrYEZl02T6O5CS8EEq0qRIFwVfsP
 5aqfKNjt8CvAkQ9MM2ovstgQl4dkeTpORbkuiNA0SYj2nedvRqZjSz3mrJJGgl7xhmRH
 ON+C9ckEQp4jaeXBxIsCL6n9/2YGFyvgRrdstOjx/gfsIDEiFfrY78B8foXlSQlpOEh2
 kfvKWqZ2aZu3w30q7Udmw8tKDYZc2hlWaQzKGoGOM4DXnyghFSYfOLi/BpbprW2F6hDF
 ZNZ0dzB91lGWBN+I0sBRz4UtnclawkmfQ08k1VYJu/KsnyqPRsAraFHoANiMV7KpYxSK 9Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmbc9ud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmf4158706;
        Tue, 17 Aug 2021 15:47:17 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3ae5n7styr-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BT8y7q0zPVSKY9mXNVcXBp/Xs6HjbxIX5Q06GYHTeqArORSD5mzJwoqLgM3yaFgJxEfs29qJUOKQSEEdjoKzTxHyplImTFNu+WQcrQ2pIVvTBAg3tlYJP3GWdIQsBWHpwJwE7ubRGPFG2vhwQWfV/GRdYYBEBTZdK3SE7Bj1XYEVBRqwqa8FBOg1oNo5LJiERpGNyFsUIjFqU1GeCsUPoznHHAshWZBW+igQhw2YiPZEoblrYhdo0ZIWvnJCnXHNP2iaTl3NVjPSTzHp7F6zhUps3B9QHU5u8gV7vVHr0rAkXQPgkN+UpLS2J8zrfGHsfDs8ZzyzuK4SUj3tYsc3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/CXMDCg88zQJULLR50hsANdz1bEnJVRcUSLy8dEuDo=;
 b=XdjlPSSuAA7t/5yAJ3LlxLaL5V2vM8ocHy6UbXXMTJZkThWvQWkd+DdGDinZSE3TXlFnv9qQpR8Xeya2Lh7UeIO/Ja1PCUzjDzXg0yvo0DapgAwnyRU8dAmCsJ3zrkJffGtpLl6+rzAy6tpDK0i7cpqMadJ9sd4N+WTcVu5AFreIh4QxkpqXUVYKPTXsbVTXBPeLiroOIzKDHfHa7w/1VxQ+KYFDub6CQvngNPkbruCCsPU4pHc0YKUjT78c/OKvzilQt7Zxm39H/i2eTD38RyFlqgMJ3eUMlzaiM/c4xLEa3inTX3s+/TCG1eXxWcC5YlISlt3/QBLAx9+AWg6CEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/CXMDCg88zQJULLR50hsANdz1bEnJVRcUSLy8dEuDo=;
 b=zlu5iJul+nS5ZR+0gPEKusl+T4hGUqnniZj1cDpVph9tLOEWDCcsekH3m48B/svgIcDG9pjj3NBkaH1qsdFGr2zWz8hMcrpvU583AFjb+zAS34vVA+hmBRYOheJVJMVysrCjF2OZQRboJ3J9JwJ5+9LUp7hBw2Z4KrSfLp1kjN4=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:14 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:14 +0000
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
Subject: [PATCH v2 17/61] mm/mmap: Use advanced maple tree API for
 mmap_region()
Thread-Topic: [PATCH v2 17/61] mm/mmap: Use advanced maple tree API for
 mmap_region()
Thread-Index: AQHXk38mPN4sIzDZJEeXJiQ9YKww9w==
Date:   Tue, 17 Aug 2021 15:47:13 +0000
Message-ID: <20210817154651.1570984-18-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 9d128933-7346-4539-190a-08d96196489c
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB42368444F00A8EABB19350BFFDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fUa70gCzLgsd9KHfYTZ2/HXHD1PhhJP9a+Evo2hutbRjUj/5xQLx+AhlOn09iWGay0orH0I4PQMZiQjs7gL6gBQOyO5JHRNvMlmu+7Xh9W2UImjwApo1P+AWWw2N4iH+plKGD/vSguiJlYnNGR93eJVxoSOBpWIDrRKBUSf2FGeYI7GBtzFnIsJ/0Lodilewzlfw7juyqkxG5kW5+ka5GFVa2Ez+G+L6Stih7b0BsB7i7isGpc50xrqmcfMQ3h7Ohk5IrJHOJE5rDjl4fLaF2nrqHc8SY8fELZ4tK4mQ9296DXRSpT7F7ULUQO8qHSiFWBx9Kj8yLT24+jOV8pD5YchPT2FqRe7koPyQygnn3POBV7UU8pFXbRRzB/A7xorK+IczmZ7TXcApenqF6OxmCRaaMPF2bl/z7Ef/rQIQjvdgSyw7CN2x4amqTijFILiT7QDM8ByyXgeM/zeqe/SgZWigvSgRkOXaGkn1eIH12K4U8K+Sx76yKuNxFQueSyCZV/yMMCT75aSzbp19qy68oqZijSCUM91WLT8VdKJk/nbV95tSouY1WCmDupNRF8KD5EmPQaQvXd+MUo6RJwVrp+lHgt9Ln93dK+a1kt/H5jxxSPxJmrpu9WcTWfSduM94sT7DbbV19Nj1D29RjSRbWGmr9ZWgpMLQI57cQYzedOoOsmGjXziQfVCSol74Z8XUMek0VjGuE5fU8R/avKOTww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(30864003)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?st8PlBiWLuN5UnV2Y4raUsexzMTJrUpa7g/D4lc+fNeiFQSnpFAilnLAba?=
 =?iso-8859-1?Q?yBdn0Praoi7B88srwBCNnArCeYUbq+93oQo0XRZfrr4+OT8d16ao4BRcjI?=
 =?iso-8859-1?Q?YmAZyNh6dpWwC+HDYuZvKRXf9reFeiXlYg5780eF5Rl/9CwdASKWt4pRxL?=
 =?iso-8859-1?Q?ck6Nv9bUf+WkXMTz4tjr5dzZ0K4pB8aXBfhXOa+tlR/maUhQEH30Gz7VWO?=
 =?iso-8859-1?Q?/A5VK04whr9kyqDsWhDcvO6pzcJWPbXH0hEUp8cVzJ+KLD7HD1iOUbbypb?=
 =?iso-8859-1?Q?2OT9W79CE6S9zzTdfB+IWcI08jsUI4GjVSWcPBzi2kl+MLEABR+IqeTr/g?=
 =?iso-8859-1?Q?F2NzoqmD24/1Tpq3Y6teKbfsLI03F75CB48gRg3pIPaf+EQ4oVRLAvi63E?=
 =?iso-8859-1?Q?VoDSg/jMbQX6BVkrr09w+nxAqcbxkzdXWFM8b173uECtkxmtZ+Rsd+loNX?=
 =?iso-8859-1?Q?12yq0PfuyNKTS9iZDTkAD+jOD8UBM9aOJRsSaJ4rXFJQdQIjki+5De95pr?=
 =?iso-8859-1?Q?V+e3btNrN5xCiIaNd2IK/yYfQRgAn4+KMWEGG1HNfzBt6L9/bI9MRmhrU1?=
 =?iso-8859-1?Q?7jJ9RV82HKcSoP0bLx9u1yw88dmtQwuHzCCLklcJA07DiOqTztGweBhKUX?=
 =?iso-8859-1?Q?NkWRJCMAh63+S9bJapsY9FsRbMjQ7fQ8YOrnBOtByrbC4lpoZ1BN+Yk1Vs?=
 =?iso-8859-1?Q?PsJaQaSbniY8SfekBTiD4W7nm6uYouovSllRHzzauGdmfSo1hfHZvtDqk/?=
 =?iso-8859-1?Q?aFuqROczGb2Kc+kPdnVVt41v/3zMhWk6EePaKiNGb4MJqtncem9rd3kO3c?=
 =?iso-8859-1?Q?QqPmqR05e2dj17ckB2sx4NRhuYv3KB7tmNKklgPSYJ/QN2LdscMzp0Ykg1?=
 =?iso-8859-1?Q?BWAUlzSYq2Nv/Zz1siy6Og0qEaRPkPOEAqT0HvKGVVMN4ToZx8+7KL7eZU?=
 =?iso-8859-1?Q?3gmfadoQK0NK+XlKW8VVdQZLNzB60kMXaRZ1myXcZhQ/G/rldtNLfRvZKW?=
 =?iso-8859-1?Q?DPKPgfRYCiDehg5b0xqgtco2kh4rnObdK/tFlNX+wHGcHUYpdJYYf+hEdw?=
 =?iso-8859-1?Q?gtRPiZM62RQ5akI0S7a3FjHhNbbRlvqNJjW3VmqMpshcTHCS92gASbbVWg?=
 =?iso-8859-1?Q?ZsHxcn6Ol2niHb4//d25j/Ag6Z8j9btiq8nwgf36cjRevPZFFfzXHka+0y?=
 =?iso-8859-1?Q?GbWVYcQ3wC7yANiCERgSopE73BJnro8EWa3JnRJaJfRNmzSThXuQ4/fXQm?=
 =?iso-8859-1?Q?ZyPON91DSMgTHhugrcYa7Nbks7xEfNYQ2zNinb818Hpp85qA3b9qedM2G4?=
 =?iso-8859-1?Q?rxkWFCkUmTqSn9x15HuNJlE9B1DpSKPPbbZddYjMPSghkJRX+6YHJZ1sat?=
 =?iso-8859-1?Q?4oKvO4cZPl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d128933-7346-4539-190a-08d96196489c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:13.9669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ug1hAJ+iG6T/Pg9TPAU63D5Ua2bxw3TQjUsmrJof93JfS17H5IzW8NEMzG/zN1EMhhlq3K6BBK2cDHeetqJ8dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: YSmWcfGKcBrry_RotirTRLJSdqlA-4Kq
X-Proofpoint-GUID: YSmWcfGKcBrry_RotirTRLJSdqlA-4Kq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Changing mmap_region() to use the maple tree state and the advanced
maple tree interface allows for a lot less tree walking.

This change removes the last caller of munmap_vma_range(), so drop this
unused function.

Add vma_expand() to expand a VMA if possible by doing the necessary
hugepage check, uprobe_munmap of files, dcache flush, modifications then
undoing the detaches, etc.

Add vma_mas_link() helper to add a VMA to the linked list and maple tree
until the linked list is removed.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 258 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 206 insertions(+), 52 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9b86f47f7387..060a372fc812 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -503,28 +503,6 @@ static inline struct vm_area_struct *vma_next(struct m=
m_struct *mm,
 	return vma->vm_next;
 }
=20
-/*
- * munmap_vma_range() - munmap VMAs that overlap a range.
- * @mm: The mm struct
- * @start: The start of the range.
- * @len: The length of the range.
- * @pprev: pointer to the pointer that will be set to previous vm_area_str=
uct
- *
- * Find all the vm_area_struct that overlap from @start to
- * @end and munmap them.  Set @pprev to the previous vm_area_struct.
- *
- * Returns: -ENOMEM on munmap failure or 0 on success.
- */
-static inline int
-munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long =
len,
-		 struct vm_area_struct **pprev, struct list_head *uf)
-{
-	// Needs optimization.
-	while (range_has_overlap(mm, start, start + len, pprev))
-		if (do_munmap(mm, start, len, uf))
-			return -ENOMEM;
-	return 0;
-}
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -604,6 +582,35 @@ void vma_mt_store(struct mm_struct *mm, struct vm_area=
_struct *vma)
 		GFP_KERNEL);
 }
=20
+/*
+ * vma_mas_link() - Link a VMA into an mm
+ * @mm: The mm struct
+ * @vma: The VMA to link in
+ * @mas: The maple state
+ *
+ * Must hold the @mas lock.
+ */
+static void vma_mas_link(struct mm_struct *mm, struct vm_area_struct *vma,
+			 struct ma_state *mas, struct vm_area_struct *prev)
+{
+	struct address_space *mapping =3D NULL;
+
+	if (vma->vm_file) {
+		mapping =3D vma->vm_file->f_mapping;
+		i_mmap_lock_write(mapping);
+	}
+
+	vma_mas_store(vma, mas);
+	__vma_link_list(mm, vma, prev);
+	__vma_link_file(vma);
+
+	if (mapping)
+		i_mmap_unlock_write(mapping);
+
+	mm->map_count++;
+	validate_mm(mm);
+}
+
 static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 			struct vm_area_struct *prev)
 {
@@ -639,6 +646,108 @@ static void __insert_vm_struct(struct mm_struct *mm, =
struct vm_area_struct *vma)
 	mm->map_count++;
 }
=20
+/*
+ * vma_expand - Expand an existing VMA
+ * @mas: The maple state
+ * @vma: The vma to expand
+ * @start: The start of the vma
+ * @end: The exclusive end of the vma
+ *
+ * @mas must be locked
+ */
+inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
+		      unsigned long start, unsigned long end, pgoff_t pgoff,
+		      struct vm_area_struct *next)
+{
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct address_space *mapping =3D NULL;
+	struct rb_root_cached *root =3D NULL;
+	struct anon_vma *anon_vma =3D vma->anon_vma;
+	struct file *file =3D vma->vm_file;
+	bool remove_next =3D false;
+	int error;
+
+	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
+		remove_next =3D true;
+		if (next->anon_vma && !vma->anon_vma) {
+			vma->anon_vma =3D next->anon_vma;
+			error =3D anon_vma_clone(vma, next);
+			if (error)
+				return error;
+		}
+	}
+
+	vma_adjust_trans_huge(vma, start, end, 0);
+
+	if (file) {
+		mapping =3D file->f_mapping;
+		root =3D &mapping->i_mmap;
+		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
+		i_mmap_lock_write(mapping);
+	}
+
+	if (anon_vma) {
+		anon_vma_lock_write(anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
+
+	if (file) {
+		flush_dcache_mmap_lock(mapping);
+		vma_interval_tree_remove(vma, root);
+	}
+
+	vma->vm_start =3D start;
+	vma->vm_end =3D end;
+	vma->vm_pgoff =3D pgoff;
+	/* Note: mas must be pointing to the expanding VMA */
+	vma_mas_store(vma, mas);
+
+	if (file) {
+		vma_interval_tree_insert(vma, root);
+		flush_dcache_mmap_unlock(mapping);
+	}
+
+	/* Expanding over the next vma */
+	if (remove_next) {
+		/* Remove from mm linked list - also updates highest_vm_end */
+		__vma_unlink_list(mm, next);
+
+		/* Kill the cache */
+		vmacache_invalidate(mm);
+
+		if (file)
+			__remove_shared_vm_struct(next, file, mapping);
+
+	} else if (!next) {
+		mm->highest_vm_end =3D vm_end_gap(vma);
+	}
+
+	if (anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(anon_vma);
+	}
+
+	if (file) {
+		i_mmap_unlock_write(mapping);
+		uprobe_mmap(vma);
+	}
+
+	if (remove_next) {
+		if (file) {
+			uprobe_munmap(next, next->vm_start, next->vm_end);
+			fput(file);
+		}
+		if (next->anon_vma)
+			anon_vma_merge(vma, next);
+		mm->map_count--;
+		mpol_put(vma_policy(next));
+		vm_area_free(next);
+	}
+
+	validate_mm(mm);
+	return 0;
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -1622,9 +1731,15 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		struct list_head *uf)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev, *merge;
-	int error;
+	struct vm_area_struct *vma =3D NULL;
+	struct vm_area_struct *prev, *next;
+	pgoff_t pglen =3D len >> PAGE_SHIFT;
 	unsigned long charged =3D 0;
+	unsigned long end =3D addr + len;
+	unsigned long merge_start =3D addr, merge_end =3D end;
+	pgoff_t vm_pgoff;
+	int error;
+	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
=20
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
@@ -1634,16 +1749,17 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		 * MAP_FIXED may remove pages of mappings that intersects with
 		 * requested mapping. Account for the pages it would unmap.
 		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, addr + len);
+		nr_pages =3D count_vma_pages_range(mm, addr, end);
=20
 		if (!may_expand_vm(mm, vm_flags,
 					(len >> PAGE_SHIFT) - nr_pages))
 			return -ENOMEM;
 	}
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
+	/* Unmap any existing mapping in the area */
+	if (do_munmap(mm, addr, len, uf))
 		return -ENOMEM;
+
 	/*
 	 * Private writable mapping: check memory availability
 	 */
@@ -1654,14 +1770,50 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		vm_flags |=3D VM_ACCOUNT;
 	}
=20
-	/*
-	 * Can we just expand an old mapping?
-	 */
-	vma =3D vma_merge(mm, prev, addr, addr + len, vm_flags,
-			NULL, file, pgoff, NULL, NULL_VM_UFFD_CTX);
-	if (vma)
-		goto out;
=20
+	if (vm_flags & VM_SPECIAL) {
+		rcu_read_lock();
+		prev =3D mas_prev(&mas, 0);
+		rcu_read_unlock();
+		goto cannot_expand;
+	}
+
+	/* Attempt to expand an old mapping */
+
+	/* Check next */
+	rcu_read_lock();
+	next =3D mas_next(&mas, ULONG_MAX);
+	rcu_read_unlock();
+	if (next && next->vm_start =3D=3D end && vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
+				 NULL_VM_UFFD_CTX)) {
+		merge_end =3D next->vm_end;
+		vma =3D next;
+		vm_pgoff =3D next->vm_pgoff - pglen;
+	}
+
+	/* Check prev */
+	rcu_read_lock();
+	prev =3D mas_prev(&mas, 0);
+	rcu_read_unlock();
+	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
+	    can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
+				NULL_VM_UFFD_CTX)) {
+		merge_start =3D prev->vm_start;
+		vma =3D prev;
+		vm_pgoff =3D prev->vm_pgoff;
+	}
+
+
+	/* Actually expand, if possible */
+	if (vma &&
+	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+		khugepaged_enter_vma_merge(prev, vm_flags);
+		goto expanded;
+	}
+
+	mas_set_range(&mas, addr, end - 1);
+cannot_expand:
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -1674,7 +1826,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	vma->vm_start =3D addr;
-	vma->vm_end =3D addr + len;
+	vma->vm_end =3D end;
 	vma->vm_flags =3D vm_flags;
 	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
 	vma->vm_pgoff =3D pgoff;
@@ -1706,8 +1858,6 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		 *
 		 * Answer: Yes, several device drivers can do it in their
 		 *         f_op->mmap method. -DaveM
-		 * Bug: If addr is changed, prev, rb_link, rb_parent should
-		 *      be updated for vma_link()
 		 */
 		WARN_ON_ONCE(addr !=3D vma->vm_start);
=20
@@ -1716,18 +1866,25 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		/* If vm_flags changed after call_mmap(), we should try merge vma again
 		 * as we may succeed this time.
 		 */
-		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
-				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX);
-			if (merge) {
+		if (unlikely(vm_flags !=3D vma->vm_flags && prev &&
+			     prev->vm_end =3D=3D addr && !vma_policy(prev) &&
+			     can_vma_merge_after(prev, vm_flags, NULL, file,
+						 pgoff, NULL_VM_UFFD_CTX))) {
+			merge_start =3D prev->vm_start;
+			vm_pgoff =3D prev->vm_pgoff;
+			if (!vma_expand(&mas, prev, merge_start, merge_end,
+					vm_pgoff, next)) {
 				/* ->mmap() can change vma->vm_file and fput the original file. So
 				 * fput the vma->vm_file here or we would add an extra fput for file
 				 * and cause general protection fault ultimately.
 				 */
 				fput(vma->vm_file);
 				vm_area_free(vma);
-				vma =3D merge;
-				/* Update vm_flags to pick up the change. */
+				vma =3D prev;
+				/* Update vm_flags and possible addr to pick up the change. We don't
+				 * warn here if addr changed as the vma is not linked by vma_link().
+				 */
+				addr =3D vma->vm_start;
 				vm_flags =3D vma->vm_flags;
 				goto unmap_writable;
 			}
@@ -1751,7 +1908,8 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	}
=20
-	vma_link(mm, vma, prev);
+	mas_set(&mas, addr);
+	vma_mas_link(mm, vma, &mas, prev);
 	/* Once vma denies write, undo our temporary denial count */
 	if (file) {
 unmap_writable:
@@ -1760,14 +1918,14 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		if (vm_flags & VM_DENYWRITE)
 			allow_write_access(file);
 	}
-out:
+expanded:
 	perf_event_mmap(vma);
=20
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-					is_vm_hugetlb_page(vma) ||
-					vma =3D=3D get_gate_vma(current->mm))
+		    is_vm_hugetlb_page(vma) ||
+		    vma =3D=3D get_gate_vma(current->mm))
 			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
 		else
 			mm->locked_vm +=3D (len >> PAGE_SHIFT);
@@ -2605,13 +2763,10 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 	vma =3D find_vma_intersection(mm, start, end);
 	if (!vma)
 		return 0;
+
 	prev =3D vma->vm_prev;
 	/* we have start < vma->vm_end  */
=20
-	/* if it doesn't overlap, we have nothing.. */
-	if (vma->vm_start >=3D end)
-		return 0;
-
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2621,7 +2776,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	 */
 	if (start > vma->vm_start) {
 		int error;
-
 		/*
 		 * Make sure that map_count on return from munmap() will
 		 * not exceed its limit; but let map_count go just above
--=20
2.30.2
