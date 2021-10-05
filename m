Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC61421BF6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhJEBed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:34:33 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53992 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231530AbhJEBdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:41 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19508Mdh004481;
        Tue, 5 Oct 2021 01:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7B/batcvMOTTDvq8A4zwzmfhvDPWLsViUs1ak/T4YAg=;
 b=vhjtsh+OeT+llRKrVqZ/fxPNAYkyFPULGcdUt2deQKXZthWfwsFa1K4rORh+LdzQ77Xu
 OvQBizHv6wsfAywPcbwoLr90Qp1YIWjWJjXBp2nrr82Rsi7rdEH6XwbvQMCwL6Agievd
 Le7sBI+RNoCEl3ZUDVXItgHznZpN9fCeSl/GYR23G+WHK3RtO99xnEP6vrGM8NejgqBc
 XmTu6IgupIXnFYLpMQFEX60/etylVz5d/7/A/qFGQF2qduCWu1ffikNOpSlUtD5/zzps
 6X1KG7l3O+MASUAMn5hDNWKMaTjrtWtrPvJssIhgHD9R2baTRNHXA21WogorQUdj7yDj qQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdGJ141634;
        Tue, 5 Oct 2021 01:30:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by userp3020.oracle.com with ESMTP id 3bf16s9dx1-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJLwiKnz3hM1kQmnQKYbmFwnyZph+hw3yUYOdqH57s4othm+ePOKS79xDxufflV8D4xDcsrCS2T4Menk5fCTQ9oTjDxYp9v8t9PkypHZN153+15ku/G6f0CeIvWsRf7Do8akUHEhZrV5wMAvN+M6xBk5KNWSkbNy2kp0Y808JGpWlVPhDyO9xV2PD17kchxE4pUtXKWrqbXaLO9cMdqxRzw90ewXEc2+ZACJZVao4GB/3Vfkm9gwxb9euZEt64jNS1wpG49ns/2XVnh+w87C8uY0QMnAARL+FxQcKwTWArBsYb8Gab6Z4u4YwEkJucutl+52M6X1WvgH4od7M+8dxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7B/batcvMOTTDvq8A4zwzmfhvDPWLsViUs1ak/T4YAg=;
 b=jgchGHpkt3DuHxDPgPwieKTI7emNV2YdISRBXHTzAnSSld4e31ZEfX4QJluvo9/aqkQfmsTFBgZOAmLDaerZGEPJM4gX14zPWyu5p2zEXYH6fEcLEerfyChPX7HF/C5AWSh63p4YYkMlesIibGV7InIQAwfVKVRTnbRaqQP5ZmnmNh3zFfyby8PE2uItREIbgL9c/7oi+8yoofHCMahjGnaxrSZAJi7qfVjJRzk+xZ0wiU3qa4dFmXM9cyBEJbHn1aJ23b6aXxjbpvin1TyxexAVJKj1xL/8wDiyStQyIiQbOrZq5ilb3pSHhDQ7agyUf8jpNsKFo2TgJL1WC7DjQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7B/batcvMOTTDvq8A4zwzmfhvDPWLsViUs1ak/T4YAg=;
 b=hTY8dnO+Qph0ApcIkK8CEC2haC2oIwerquPEL0MTaXv/r3T9U5GlT5XYuum6aj1rOwfGO5cEQ0d4ro2yNr1BwV3ZFOZ6WK8FtyIZufY7BxMSrnBbwjtTB/1P7oTEt3ohdmj8phIPQIOGbwMW/Sz8GnULtb/bqn2vJT7pdctKIXE=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:38 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:38 +0000
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
Subject: [PATCH v3 18/66] mm/mmap: Use advanced maple tree API for
 mmap_region()
Thread-Topic: [PATCH v3 18/66] mm/mmap: Use advanced maple tree API for
 mmap_region()
Thread-Index: AQHXuYiaG4rRVLdtWk65fIbdQSuKiw==
Date:   Tue, 5 Oct 2021 01:30:38 +0000
Message-ID: <20211005012959.1110504-19-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 472b1b20-f37f-4909-edfa-08d9879fbcf8
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044428A35E164BDF7D1F4C5FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LUlEoR4yZv/QowmGDtOJ6uXbT8eyk80oDu8X1dn+y3RUSczixLfgL7rgL6mZOPQN2iPCXIw4wTNu2fEZdOH4tLOQXixkuke+GZEN0BekzXDPXLBF2GbjB6u+ceNp6NeA2PrmWGj/OlwW0fUQLP0diNBEcpWZ04VECyhpz1A6QW99x3CDHAUQ8KS2xpRVl32qKsOIMbuBnAuRS3dMlseMzhZL2VwdD9d5QqPvjgHSPjjxh5Ys1JZxunKHxI+G+A8azG8WUEh6rsr2Z3hLOrvx8uRGAri9Q+fMQg/3uRRkZpqHWXdYizDjeyIehcj7Qz5BkLRjmnEa4zIkWzzxLgOsDrO4BZHMeJ2AW/BDO46gHdheFRKrL5G2JQZyRDZWmBwzd6oSOVcQmCOZml6Ti3EkMFLckunawiqf4pb48CU2f4OkUiScqXN/SBQkVVuV/PD4Ax2JlUJ9mX2LQoxxMyvWw+XJH2XcatYgWYs7kNOlMMxd/DW+JsfDfOtihFCPUufjFG+59CHnAFC8RWT8PPbmcwSeAIMs+z7UGioRpz0m4OHLkfJqzqpPZjZJWbvof2rHWPpSKso50Z6c0h69SpmGLQXDGpdHVVm9wuZ9bTREjFLNA+oucGvPVdZ2j3rwMxhTgQaBF9Gk2Ee3envA5xoXHmudlro50BPPCPwKrMTyG19HS+zSyGMR9SwV6mvqfIr9/hG+syIw2WfmqSAv3ped/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(6506007)(36756003)(30864003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2OyIVeUqc0iEHF/fdfR0qvXD0m7vjuCL8QZsszxle64WS5WXJjh9wXZ9T5?=
 =?iso-8859-1?Q?xg/lww4b2s5wCNnlYQJatPgWnvDyfd3goeL3iOqdx7o2insN6nL/Fwr7NM?=
 =?iso-8859-1?Q?W4Anhbf6I+NjrxyC9W9lN4F6LDHPU/wcNCF0vvwWlfnCzu79ihyuhASnRn?=
 =?iso-8859-1?Q?dNBs47SJGV+ng86mc9GwZsqhVyE6IUYOvqjy72QPmpwlPVLccdw0sQmQ7W?=
 =?iso-8859-1?Q?akoCWp72jWulg/gLc3ewiRL2Q9inqIRpZT9RE7hxBAHaSgKDyXIeMz8/1z?=
 =?iso-8859-1?Q?U243+GOG407d8weyFzytBZwfFCnGbikuyT4Gr8UdmKTIq7PzMJt0JuKDUF?=
 =?iso-8859-1?Q?oTowp/EINRrRa4wkDyzL7zeKqeWSXD1qXTqfDemek2us2PE3Q+z5855p8/?=
 =?iso-8859-1?Q?2EPmZamCZosQPWMEqOFOYYlvCkcyohi/PO5OyKU4AdP1CFo1a4//ueucz3?=
 =?iso-8859-1?Q?NpJ5CjHXvyUbvdrP2Mtzklzx16qPqQ3RgukntLtFs4JaIHr1+helLmO69D?=
 =?iso-8859-1?Q?cU1RkZEnp07nWkcZ5ysj9su6fUzSHvmo5FHlZNfO09H5CxRHb4onjpEt3i?=
 =?iso-8859-1?Q?eQni/DEx9r4wb7hY7VyGhIBc4Jk9e1xXZC2QCK8W+HraqzaYywUCJbCyRy?=
 =?iso-8859-1?Q?YxFpf3QbiEfQsm8p/3ucerTbI2FHGFSifMel1RratfutbHOTThzQMweWnk?=
 =?iso-8859-1?Q?2hysE2hO4LgjRK4OatnPvw2vNB4wv8Pnf9gy/GVTtxyYONl4DXpXgO3PJF?=
 =?iso-8859-1?Q?NoZV98YrEL3kkvjWI/WDIpLzwVk9xCxJA3R4cWuFWAIsPW1GTD90G8w7Y9?=
 =?iso-8859-1?Q?9QpPeqRfSRAQOtOmjO0Exovhpl096ZxpbedUqxGkcdTw0SgIyEjQ4A+0wa?=
 =?iso-8859-1?Q?1pVDlIVIP3QClESUCFMlIqfTAubvnlr9H0XpuGh2nw2V2S83AauRt9ngNk?=
 =?iso-8859-1?Q?VyeQOlDniowTLF79Kp2Yl17xpSTxqo631XFjoWM20/+uE1CeMVc5kz7+kI?=
 =?iso-8859-1?Q?UVEzLdihufk+GAbqr8gTVCtlvsvcbaaXk22wgvpIeqb2P7VD+HkasQGp8d?=
 =?iso-8859-1?Q?ZEbjiOXkpqhbvvd5AdtXpwgMJHtKiJFBguShcTWpRi8wt0OIsfCdZjOdAg?=
 =?iso-8859-1?Q?BPM6sZPYxvpE9I7pV3xWGlKqJc6ru+IHCwvpxUd4pThNEGtu2NLV7mcRN9?=
 =?iso-8859-1?Q?FE7kG6zfmLWdlgUFfBSy6Zq8XHyyuB48AKPZAHZAmPDuLm/i81yj+oLKMr?=
 =?iso-8859-1?Q?ASFYtyLAc8xwPZBnVOZ7Ub02bJY45phfXtsecgCoNGlXnicgEzOR3hKfbE?=
 =?iso-8859-1?Q?C+ZoyklylEpqdgO/Pyi9WPycIvD4BKAuBHTgLNz8lr1f/gWuVIlS8KDWng?=
 =?iso-8859-1?Q?Wu/mBEduP/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 472b1b20-f37f-4909-edfa-08d9879fbcf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:38.8136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvlHKcww111+kgq0KCNtfTQzzz+wawEwC1WKrph4deIXkp82YAbpFOKyFCSbWgc6tAZitp/rjpVW0EldWH5NaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-GUID: BQYoHGjdaohQZSf0Gc12AmaAhHmgDrKd
X-Proofpoint-ORIG-GUID: BQYoHGjdaohQZSf0Gc12AmaAhHmgDrKd
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
 mm/mmap.c | 259 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 207 insertions(+), 52 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3b1de99d0ea0..747c69ec88de 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -501,28 +501,6 @@ static inline struct vm_area_struct *vma_next(struct m=
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
@@ -600,6 +578,35 @@ void vma_mt_store(struct mm_struct *mm, struct vm_area=
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
@@ -634,6 +641,108 @@ static void __insert_vm_struct(struct mm_struct *mm, =
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
@@ -1614,9 +1723,15 @@ unsigned long mmap_region(struct file *file, unsigne=
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
@@ -1626,16 +1741,17 @@ unsigned long mmap_region(struct file *file, unsign=
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
@@ -1646,14 +1762,51 @@ unsigned long mmap_region(struct file *file, unsign=
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
+	mas.index =3D addr;
+	mas.last =3D end - 1;
+cannot_expand:
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -1666,7 +1819,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	vma->vm_start =3D addr;
-	vma->vm_end =3D addr + len;
+	vma->vm_end =3D end;
 	vma->vm_flags =3D vm_flags;
 	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
 	vma->vm_pgoff =3D pgoff;
@@ -1687,8 +1840,6 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		 *
 		 * Answer: Yes, several device drivers can do it in their
 		 *         f_op->mmap method. -DaveM
-		 * Bug: If addr is changed, prev, rb_link, rb_parent should
-		 *      be updated for vma_link()
 		 */
 		WARN_ON_ONCE(addr !=3D vma->vm_start);
=20
@@ -1697,23 +1848,31 @@ unsigned long mmap_region(struct file *file, unsign=
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
 		}
=20
+		mas_set(&mas, addr);
 		vm_flags =3D vma->vm_flags;
 	} else if (vm_flags & VM_SHARED) {
 		error =3D shmem_zero_setup(vma);
@@ -1732,20 +1891,20 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 			goto free_vma;
 	}
=20
-	vma_link(mm, vma, prev);
+	vma_mas_link(mm, vma, &mas, prev);
 	/* Once vma denies write, undo our temporary denial count */
 unmap_writable:
 	if (file && vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
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
@@ -2580,13 +2739,10 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
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
@@ -2596,7 +2752,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
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
