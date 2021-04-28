Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAB836DBF6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbhD1PkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:40:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56796 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240421AbhD1Phq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:46 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFM7Fn009825;
        Wed, 28 Apr 2021 15:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=qXwnG2Zv8tbFN71SsjTGBhJMYeq6grH4osvmkFeW04c=;
 b=tE75rQvL4nJWc9u9EyXoil+DXbT+yRa2LTdhSSStqVeW52OZ/kOwYYdHv8XXf9pUvQt0
 BiJr6HU1A8gBPvJdR7Ix2Ipk5O5Bcm9aJDuafZirv51adw9CsNtWGWB4TtdCTlh0HLWC
 T/4HGvLwRuSy9rQ4OgVgg0Ak1Xgx8vuh0iRQgiHOi7Ryx5z/Oc+mDnzmPl3Ik537OHP3
 dyTzWcgmP1EIs7eovZthG1iCo5WltY6JDrdBQHKYerzfqBsJ+Aa7b4FiONGSp76RbWMu
 mRa72ygsu0U9Jq7tTgEkH5MVPybZCu5M5elDcVbpoyyVjxan8lIaydEkIaKtd1orsWYF 7Q== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38789105yk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:43 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFag2R161773;
        Wed, 28 Apr 2021 15:36:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by userp3030.oracle.com with ESMTP id 3848eyqxnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2we6StSHl5SBVcpTgyXfysDP8t/m3ridPkAHhx8Dry/dcNfIppPyXiQOxa3Hn8unysQUEJczk1S/cQzDfLcVPqgai+zaKhwI7FwpPXKKF0jkkpKZQII3aiHd/D3LTqyAgLqEiP3/ByDcJzHT6gOpvInKCtjUL2RpP/9TawL18hYD4E3oGiSyKkaRy5qQPvs9/eT91l2dEpV6SpXx9bQqeeayKoYHWkyyVjdkkyl1z+obu1yYirKhXEb0YLhz/JWGNmwEAaXEmW5A1poSf+nRKvs6GoNpXD9BzHil8SZCZVgwVZuqyiG7q0Lbc3cuNkMcCKEDGIyIb/Q3/BnI6K3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXwnG2Zv8tbFN71SsjTGBhJMYeq6grH4osvmkFeW04c=;
 b=jwBKvWkeVfO0ulgwiEXerl0A5s4T3sBKw/huLx1kpbQhqdHlMMOUXHG3W6z/gXJG8eB0bhU/vkYa0dqTuasWAi4JLziIJdZObhSGftsvVQugQDIBv3dsfnT7eqjGqyouRr+oXbq4UrmQ2PSBI0lqF6OA5P8qqY4hgmGiixEIU1CHgBRCjNPbllAr1IhY7ytvSF76u0ZAQpiAPjnF59sUUD/5kQWdinsSe3zD8k80JZo7ArlxSR4wQ9w9Xf6maJ8nmN26Hxf2Xzl//DPg8FC438fRnYzpvFTjb8a0+fAPJX2CnKMTcYDx30rdACWUK75wx2IOd5M7ToRh6Nd9YqvVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXwnG2Zv8tbFN71SsjTGBhJMYeq6grH4osvmkFeW04c=;
 b=pItMs122emSoujHusf0xUANhFMjehBphYMgBGkl55w7uCcFGHp73fD696504kczx0Bw/oymGNyLNKyXUKOL76ss7PDorpR8rC5aCfglNCO5pD5/QpNkWft3uJeB/R2k82TUfhwSIj6soYsF3+EsLzd855UnpgzYSaUogk5dhMks=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1743.namprd10.prod.outlook.com (2603:10b6:301:7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:36:39 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:39 +0000
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
Subject: [PATCH 42/94] mm/mmap: Change mmap_region() to use maple tree state
Thread-Topic: [PATCH 42/94] mm/mmap: Change mmap_region() to use maple tree
 state
Thread-Index: AQHXPEQ2CO//jxFbqUanb/mKdY3o8Q==
Date:   Wed, 28 Apr 2021 15:36:10 +0000
Message-ID: <20210428153542.2814175-43-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: b90b234b-0bd3-4e4d-6689-08d90a5b6ac6
x-ms-traffictypediagnostic: MWHPR10MB1743:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1743C14288ED5B0DE8BBD656FD409@MWHPR10MB1743.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aOWogPEbLF6epkSFMR6z0ZML/O3i016z/FrxiTGKL+qriuBXg6TtBRxyQVS0Z7NicyZf5Z/1NSCS+nL5mHvtvunhr4Oifo9GmNiQ39CO2zt8A2FO/mwD5e1upOwTnpT5g8wsyRD4PA4fGvksk0rpOEhlX+5fpLIVv6V4ZDC716rnWvEf+2xVjwjEcE1YgHCScCBzKeBvTOd7eUO3cs3EtaWlCvZkYn3CVZud+W/6IkD7sMmd/956E2lqBhVIZjohGnBOKFsfVHIgn7vm2zdGQv0ALlAaZpjGBv3H6XTNH2LrGFy1gWA+UBCAHTTQEMjdRkz1HCwUoaQrLnywp7lWtrPAFet8stmtvILaXcO2zzSsZK/MqJWO9JrpptVEHiSg5//PNncvD9iXLBHlYzeWUFTVuYrHXMxQ3EeXACxXZLzfVtrJ36/s/6IVgUAdu2nziMq3yr3jRyHjSmoFsli5RmT/31KTJ3F+MT6LU/yooEbFsIev1BnQpObbxvyqwTbIN/8IlVPyf1HxUk1cOqd/4J5PZMO5kLHfQh7GrqQq/SgwNicE+2AbSTSflUoRwLHvJkHqd8ssFO2kIZjQGvnpmodn2lmzG/bMBzi7JThoZ04=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(366004)(136003)(346002)(110136005)(91956017)(316002)(1076003)(64756008)(66946007)(76116006)(44832011)(5660300002)(66476007)(66446008)(8936002)(6486002)(8676002)(83380400001)(54906003)(2616005)(66556008)(2906002)(122000001)(38100700002)(6666004)(478600001)(36756003)(7416002)(86362001)(6506007)(26005)(4326008)(186003)(6512007)(71200400001)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?6EBltjgjcdNXPDeCnjOFAN6PMjmoRp6XGP1AygnANbv1FiclbwPMpuWQVa?=
 =?iso-8859-1?Q?oFPCXizpqGgNCXg9QZHryraYE6vbghL5VsAZkfH0rz9XmmyU2FcrNyebVH?=
 =?iso-8859-1?Q?qCEGDt8Jh055fTqFNXUYLJeE4E5R/RTLHabKlR2j1yDCLEzYbb9j70wDPt?=
 =?iso-8859-1?Q?KpUAR9/gpv91Maap1qpCZFUGnOUWIX4eX0RFg7+gA18COcpNZ9M054aRKz?=
 =?iso-8859-1?Q?zxpclQB24xSVX0ZRbhVj/GWyDY1zepy2nctwCvgtsmdO9d9mk0ZuLUtb8z?=
 =?iso-8859-1?Q?7595giJINtY6MU2zV4VmsW0wCifH8TwNShSv2tjsPBOlcfPjdkD9QkHoRT?=
 =?iso-8859-1?Q?/3KYfNWLzAddGXp5qOjZ1It++kQE9BUAqEd3PP7vWi7r1MHaugA5gAQIXO?=
 =?iso-8859-1?Q?pGyJw7+9LjchwBSUhh96yAod4hITJg5VeZqaVCtIAYciUchXc36qkqF8yj?=
 =?iso-8859-1?Q?tEvh4/tmdHpp2KupUzs1NhAiJxs0Vm8G/BUvsTJ5BlNMBWfUW+nWLE91bh?=
 =?iso-8859-1?Q?oaUjHmuuccq3mowrCfT2Sl+4Xue3Lfkqvj+lWEbFPvRbbG3KyzBCS+WTvG?=
 =?iso-8859-1?Q?MdfpkI8zNuTtIb7zt8BflM9w4lmt29zXMlelDadILBVQnZMqlRmV+n+zMM?=
 =?iso-8859-1?Q?PNbfgWnrFkFpEa5LdUmr1/J7CZCfzgfs2Z3ouomSs/u2mHU6dHYNgTqI4H?=
 =?iso-8859-1?Q?lAH8g51a3+BZZnYUZaVtoHypANPkK8BdnfmeR+rSdfddTagUhXEYvKSY4d?=
 =?iso-8859-1?Q?AcEA/UKvWWmWw6B2zteLUR5s5OllFwXwfGUaOoOZ2sQmz1aMi00MeOHnCz?=
 =?iso-8859-1?Q?EXtTkNxKLcFM46gGp7LujlVu9vAIBKiHtXzoV798zw1/ZFGSzsAXzwG/eR?=
 =?iso-8859-1?Q?yQiiPeuxr81zK8Lkz5YxL5D0hGhTN047FBzubmxtvta3PdIhbHtRv1o8/5?=
 =?iso-8859-1?Q?SjxSk8+xrDboN+yxATcD4o++8SVZD9xi/6mCR3vc5s40il+tNarltL+1b7?=
 =?iso-8859-1?Q?326QKwMNGedOZMzUdnzwn0HpHxU+t8nSxZtLhVPSbkdppsdryYy61HkRAo?=
 =?iso-8859-1?Q?zQS2Pvd68RC299ErX+da4CFqDle341xqkKZvDCz6IRSMCxc9GbsSG30qvP?=
 =?iso-8859-1?Q?Q8wVkRf7JzFu9mk/9gyIYgDNTE/T2iL6kChCNDOJPNzo8FnAWjXPtGbOqE?=
 =?iso-8859-1?Q?/T6+XdX6xqBEscXTzX4VwAU3J5Znqk6EwQwNmj3fOzR0J2WQCco3rP4b2C?=
 =?iso-8859-1?Q?S5h+YI4Z2ERXUbX6h22k+0nrd4k4YFV3hU1FxfFBg37YO+FWYNsS2nIx44?=
 =?iso-8859-1?Q?GaX3AaQUIbrGNfNNYu79YFrtCd+1gg33m6o+V6reKFMrhrw3w5CINk/O9/?=
 =?iso-8859-1?Q?qZWnTiIqEE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b90b234b-0bd3-4e4d-6689-08d90a5b6ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:10.0726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfxbLwY6Rp9Px3fcawKBzQduZ6TbfQYSvH+LJyXng0ONW+s6yMLdUCNHSPhZc7Mw0bEBTmxi1lJh+vTH328nJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1743
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: 7E2lpd57_cpI-lEJY0bUKOP7CcY4gE3s
X-Proofpoint-ORIG-GUID: 7E2lpd57_cpI-lEJY0bUKOP7CcY4gE3s
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 lib/maple_tree.c |   1 +
 mm/mmap.c        | 218 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 187 insertions(+), 32 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 3a272ec5ccaa..6fa7557e7140 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3946,6 +3946,7 @@ static inline void *_mas_store(struct ma_state *mas, =
void *entry, bool overwrite
 	if (ret > 2)
 		return NULL;
 spanning_store:
+
 	return content;
 }
=20
diff --git a/mm/mmap.c b/mm/mmap.c
index df39c01eda12..4c873313549a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -516,9 +516,10 @@ munmap_vma_range(struct mm_struct *mm, unsigned long s=
tart, unsigned long len,
 		 struct vm_area_struct **pprev, struct list_head *uf)
 {
 	// Needs optimization.
-	while (range_has_overlap(mm, start, start + len, pprev))
+	while (range_has_overlap(mm, start, start + len, pprev)) {
 		if (do_munmap(mm, start, len, uf))
 			return -ENOMEM;
+	}
 	return 0;
 }
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
@@ -595,6 +596,27 @@ static inline void vma_mt_store(struct mm_struct *mm, =
struct vm_area_struct *vma
 		GFP_KERNEL);
 }
=20
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
@@ -630,6 +652,98 @@ static void __insert_vm_struct(struct mm_struct *mm, s=
truct vm_area_struct *vma)
 	mm->map_count++;
 }
=20
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
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -1615,9 +1729,15 @@ unsigned long mmap_region(struct file *file, unsigne=
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
@@ -1627,16 +1747,17 @@ unsigned long mmap_region(struct file *file, unsign=
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
@@ -1647,14 +1768,44 @@ unsigned long mmap_region(struct file *file, unsign=
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
+		prev =3D mas_prev(&mas, 0);
+		goto cannot_expand;
+	}
+
+	/* Attempt to expand an old mapping */
+
+	/* Check next */
+	next =3D mas_next(&mas, ULONG_MAX);
+	if (next && next->vm_start =3D=3D end && vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
+				 NULL_VM_UFFD_CTX)) {
+		merge_end =3D next->vm_end;
+		vma =3D next;
+		vm_pgoff =3D next->vm_pgoff - pglen;
+	}
+
+	/* Check prev */
+	prev =3D mas_prev(&mas, 0);
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
@@ -1667,7 +1818,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	vma->vm_start =3D addr;
-	vma->vm_end =3D addr + len;
+	vma->vm_end =3D end;
 	vma->vm_flags =3D vm_flags;
 	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
 	vma->vm_pgoff =3D pgoff;
@@ -1698,8 +1849,6 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		 *
 		 * Answer: Yes, several device drivers can do it in their
 		 *         f_op->mmap method. -DaveM
-		 * Bug: If addr is changed, prev, rb_link, rb_parent should
-		 *      be updated for vma_link()
 		 */
 		WARN_ON_ONCE(addr !=3D vma->vm_start);
=20
@@ -1708,18 +1857,25 @@ unsigned long mmap_region(struct file *file, unsign=
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
@@ -1743,7 +1899,9 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	}
=20
-	vma_link(mm, vma, prev);
+	mas.index =3D mas.last =3D addr;
+	mas_walk(&mas);
+	vma_mas_link(mm, vma, &mas, prev);
 	/* Once vma denies write, undo our temporary denial count */
 	if (file) {
 unmap_writable:
@@ -1753,14 +1911,14 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 			allow_write_access(file);
 	}
 	file =3D vma->vm_file;
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
@@ -2585,16 +2743,13 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 	arch_unmap(mm, start, end);
=20
 	/* Find the first overlapping VMA */
-	vma =3D find_vma(mm, start);
+	vma =3D find_vma_intersection(mm, start, end);
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
@@ -2604,7 +2759,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
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
