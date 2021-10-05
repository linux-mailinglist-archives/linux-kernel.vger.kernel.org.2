Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24646421C1A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhJEBhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:37:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32590 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232768AbhJEBeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:34:17 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951FsWi010243;
        Tue, 5 Oct 2021 01:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=W49VmxYSNacc6em5BHcyUWeRlYrsCsLcX1SLRvxUcPU=;
 b=o2uU7o1aYfFY9DSV4fxoC02fGIMulhgc364QhSGmr2X83iY9FcYGDipYG0+8moE7pgey
 vaLrD3ZzIX9G/4e6yznH8qUKmQzmcnA8vJ4C0e/JKn0LES4SWYTGzmcGd4WWdVQF1Yb3
 3YjY7SBXFSAMmInvkHsh0G+vA0g1qXVdaiZHVTS5f0ROUsQn7lUqBcHpRlQ1fRuhoWWm
 +VfwA0crOvOQ/Uc1nLvcYdegseuB+X35GxWj3GVrmV47jq8ctAy690To4QErd9kV4uWV
 jayW2gV2R+gWBWHbDJcL0F2dWNbOVi1sBwk4TeK/2T21llJ5/J0fCMAQrNH8xrP8IK/F /A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3upv35x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdG1141646;
        Tue, 5 Oct 2021 01:30:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3020.oracle.com with ESMTP id 3bf16s9duq-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT0I3oZw+YDFVKqI6DSQDZgW8QgbMLy1hHq5pb7E8j0HYgllRbjq+b/H0LW5a+YsSi2O9Iz5U5JRBXQpYctLOpJturha5/aosjd0nbdwqn/7lzyuX9fegZH1m5sMClTexyZ6eMOwSVLcc+vHb8yO0fXvjHXGxV5c+/hFDrlCfUkDqC2TZ0bgC/tZHdbkZLC8Js5Abd70fqrenPytl2/CwyypTNl2WrqL2pouN7hSTZiUH0Zx8RenBOkgNWC1XelP6SQqMdJaE8I7zDHuiOOymLUfS4q1bz5JifZeq8gzoVGPpcQ6rRSQHncRxWfANB+n/NggtozZzldhFIu/qMB3xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W49VmxYSNacc6em5BHcyUWeRlYrsCsLcX1SLRvxUcPU=;
 b=dGOvl8xUBLEDw6WN21whr9/rADqkYufh99WT4NCkJhY9qiwNBIpLwrwYxdlbx0JCEIH7zTjiQqZp4YV7NO3IeiZHSNMu6+7gfhV1gs2PylhE13Z2tHaW8fngmF6bA1c/4/v9aNmJ6IsPcbi+g4wJ8J8YHcwoUp8xeEWauzPgc6v3hBVRnhQj/OYMtBa9SsJk4CKO+yNTcJ9YCQkmB/rV3dpI0n9PufikQmswS6vjwDggIYtes+/ehSrHZsRH6YSPK0Uz43ylL9RyeWtjyoCLRDeTa9TyMZBCcm3Ovvwx4HMXtY+NcHq3cQH4uFhdjAapj12Fwgd/vyAzW+TZv47ddg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W49VmxYSNacc6em5BHcyUWeRlYrsCsLcX1SLRvxUcPU=;
 b=DwrZhnH26M5PBovH7jWKXoP0vz3CUD9DrrPfwe/3OzQTrJdo8OIiz17Qs7pWl/mp70i6/gDYarNlD5JKNFVEJnUF/YNztM4DuKtV5yKEyBJMkfTl8115hArwg/dwilnGieLNQeI0krH/kMa9c3CW+KlIRh28JQ9OItrDbELDy+M=
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
Subject: [PATCH v3 17/66] mm: Use maple tree operations for
 find_vma_intersection() and find_vma()
Thread-Topic: [PATCH v3 17/66] mm: Use maple tree operations for
 find_vma_intersection() and find_vma()
Thread-Index: AQHXuYiajM9mMtfvXESTlGCwCkP16Q==
Date:   Tue, 5 Oct 2021 01:30:38 +0000
Message-ID: <20211005012959.1110504-18-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 86ff0336-e84e-4900-a81b-08d9879fbcc0
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50441E685BADE83EA2CBBF09FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tKgAafvm1Tae6C1NnU0lTmqbHJmUaQEk5gFKAEfciP/Dee9zebTPKuA9qn44dlsd0eELhzGTBJSOy3kkTXZ0bxHtbtAuXYl2Bx1Nf1xb2Y91hi3vSnk8dk+t9OQsQUJ7Zg2HV5fcqxucuiKk2Co9TawoV83FFNtb7q5Xg1owFk46LnnpL5TKVkKaSENfJamO+KHyaPE5N4UlsmcPOLUCcUvJp9GcpMwCDutiN6HfmcvejHW540ocdlNoJrlFOwnh4pN5QeudFomFSrPghDlQbpwtH+HTZDCcRHQZEuPep5DYkvDpbums/nsCYBZgszBiopA3HgCa144NuQ1FSYppHmA/EGyWvpOCyAZX19wHBk8/W81OjrlGou9qYd0Mm17ebpUXQiHapVReKTyjPV6JwNozreIerwsouH6ZWS+GR7u0S1qxJsayTP0lOC4NeZ/MEkcaT8Eo+yShM4o6ce74iTIaYatUPqhkeDn535F6BhnXhBkt1ZTpKVOQgGbKVRoFsTyHJakfibj68bTH2SJfYHDh2Gf+mY+iVJHgoeFGhIvdR0/wwhUno7V671Yg+SBoCp3HWsomlf6MjqLxdrCvySUu6EbM2MlFJrpsefLfjACsZ02JanbgccKR83ZHhI3OGVA3t/J+1VsZApp4E5NNWlGB9WfOnPP3VJ4/RInaRXSLJX8ZIHBDjEB0R0abxLZkPvyUZM+SxYxoSpKvfiUbJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(6506007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nUtuRhZM8vQW4P486IJuJ+0RsdUaVQbQGKRFvRQ5EHlgR1efhHpR/rNwQ6?=
 =?iso-8859-1?Q?LHACO9/lXfOPPZnP6sC8J+KgpAlGPBPTIhXplpgYrYacRTUKcp/2VwzilA?=
 =?iso-8859-1?Q?vReHaM50MnKFsPI0Ycj6vyuK2TKlepeyNDZdfOvYNuQJ7iq5x6ilgzUx4O?=
 =?iso-8859-1?Q?HTOnf+AG6fulGVpV4zgWNcOc28tRjEsAEFNRxJ7Pv+g14N64Kn47kqVlPG?=
 =?iso-8859-1?Q?d9UW66zGZR9f8tcZ1YqoiUf63vqjqVMeXp/OuIkiujC0CPNjiQxiShbIAE?=
 =?iso-8859-1?Q?YHC9zVHCHpMUXZx8OGykvqosWyPER3IOP2dK4ApupYPTqekfrHnHmRVYMJ?=
 =?iso-8859-1?Q?Tmd/wRkb2e1mQLx+KMF8NdTY27H0hZZ+2DUO3NMECv+3yY62Q4Cnn5ibIz?=
 =?iso-8859-1?Q?K6WvL+BmKhxS+k1k53MurKPbxFf2OIuh9NUcSngrvTGmNtpYILE1mo6+xD?=
 =?iso-8859-1?Q?A4dGYAmnXMHXjA4jX7OTDdeg05to/L2xHFnBAsK/3OKoAT3aGQogMggYcw?=
 =?iso-8859-1?Q?H3n0Zg21CmlSq4a+amFU76+Bf5SfXSZIWx06Nj6bCy0lL70Es9DODVd2dl?=
 =?iso-8859-1?Q?eMWyB2xzxrjNDsUbChX0qJZuX0BPhHvDoTcBwBeZVIfPKK3bjOFwn8Qwi5?=
 =?iso-8859-1?Q?vkX2wumBAFYkJEHXrtQ98vnXXN/iNBpDzEoBSu3Qb4EHtW0cDBqjX4HaMc?=
 =?iso-8859-1?Q?q2as5HgtulfTTfY5yzylStXeAME8tysINQkAX4zZAP7EkIFrizx536xTW1?=
 =?iso-8859-1?Q?bW/E/MPCilA5bMPvwCH8RBFcWFIwDFFMUte9DUoBXQ/xzAaHFXIXTlKR06?=
 =?iso-8859-1?Q?AGRu9rf68de13I4vNT6OrLoywPsCSRnjJX3DL9G9aeU3zud+7a59nXdsCB?=
 =?iso-8859-1?Q?YxM8l5ksyOnqiyf8AAt9IHti1mmTNXtIDKnZrYf/gfakLK4xxQMRqNWqzw?=
 =?iso-8859-1?Q?35uhTy6poewL2CTPnFbTBew5bD46reBKubyAtxG1z9LTN5+9oFH5i8A+5Z?=
 =?iso-8859-1?Q?yfneGUGUlViF36FuF1/P3Xz6gIzLNNJ722rKpT9m0UR3Q/OLxkaMDa8n8Z?=
 =?iso-8859-1?Q?EY9Ty5uoJRVO+eX0ThE91CRJdiByVhKXbAh4AaDi6HsipbYPQnUWQdeHAc?=
 =?iso-8859-1?Q?CLSHl0Skd08fWrMvS/pQRlgE/p28VqSQvHWePDyB/e2p/ZiO+whxGWfIHb?=
 =?iso-8859-1?Q?F10hbQau9fC3v0FDRSdCTKnvtCcb6sV2qe9gg6eHs2K8/v9tyDbInM2IdU?=
 =?iso-8859-1?Q?+lQpZaJB0y7XXFCXHuH7mO70JJVOjGef9tFAuQuYARztkaOrK8Ft2DsNPI?=
 =?iso-8859-1?Q?g74DMruOfxbNiSkAyoGZPB8caUaCzMjKjdUlJDndnPfwTUlfzilFrdAtkR?=
 =?iso-8859-1?Q?uu4Ov24qZp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ff0336-e84e-4900-a81b-08d9879fbcc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:38.4199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZOdS3Zd9v2m4NzSsKzPdhQxrteWrgXzE5zJrVGc0acEAKH4FnK1ECDjUuy4pOzDXh7nNN0vCaWc1EQqp3qN5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: VPa1BIcmZGyTzXchUtWnbgSbl7G7sWVv
X-Proofpoint-GUID: VPa1BIcmZGyTzXchUtWnbgSbl7G7sWVv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Move find_vma_intersection() to mmap.c and change implementation to
maple tree.

When searching for a vma within a range, it is easier to use the maple
tree interface.  This means the find_vma() call changes to a special
case of the find_vma_intersection().

Exported for kvm module.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 25 ++++++-------------------
 mm/mmap.c          | 38 ++++++++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 10a997fb60dc..21f2f6dbea64 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2679,26 +2679,13 @@ extern struct vm_area_struct * find_vma(struct mm_s=
truct * mm, unsigned long add
 extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsign=
ed long addr,
 					     struct vm_area_struct **pprev);
=20
-/**
- * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
- * @mm: The process address space.
- * @start_addr: The inclusive start user address.
- * @end_addr: The exclusive end user address.
- *
- * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
- * start_addr < end_addr.
+/*
+ * Look up the first VMA which intersects the interval [start_addr, end_ad=
dr)
+ * NULL if none.  Assume start_addr < end_addr.
  */
-static inline
-struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
-					     unsigned long start_addr,
-					     unsigned long end_addr)
-{
-	struct vm_area_struct *vma =3D find_vma(mm, start_addr);
-
-	if (vma && end_addr <=3D vma->vm_start)
-		vma =3D NULL;
-	return vma;
-}
+extern struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+						    unsigned long start_addr,
+						    unsigned long end_addr);
=20
 /**
  * vma_lookup() - Find a VMA at a specific address
diff --git a/mm/mmap.c b/mm/mmap.c
index b1f7c080b9da..3b1de99d0ea0 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2027,32 +2027,50 @@ get_unmapped_area(struct file *file, unsigned long =
addr, unsigned long len,
 EXPORT_SYMBOL(get_unmapped_area);
=20
 /**
- * find_vma() - Find the VMA for a given address, or the next vma.
- * @mm: The mm_struct to check
- * @addr: The address
+ * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
+ * @mm: The process address space.
+ * @start_addr: The inclusive start user address.
+ * @end_addr: The exclusive end user address.
  *
- * Returns: The VMA associated with addr, or the next vma.
- * May return %NULL in the case of no vma at addr or above.
+ * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
+ * start_addr < end_addr.
  */
-struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
+struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+					     unsigned long start_addr,
+					     unsigned long end_addr)
 {
 	struct vm_area_struct *vma;
-	MA_STATE(mas, &mm->mm_mt, addr, addr);
+	MA_STATE(mas, &mm->mm_mt, start_addr, start_addr);
=20
 	mmap_assert_locked(mm);
 	/* Check the cache first. */
-	vma =3D vmacache_find(mm, addr);
+	vma =3D vmacache_find(mm, start_addr);
 	if (likely(vma))
 		return vma;
=20
 	rcu_read_lock();
-	vma =3D mas_find(&mas, -1);
+	vma =3D mas_find(&mas, end_addr - 1);
 	rcu_read_unlock();
 	if (vma)
-		vmacache_update(addr, vma);
+		vmacache_update(mas.index, vma);
=20
 	return vma;
 }
+EXPORT_SYMBOL(find_vma_intersection);
+
+/**
+ * find_vma() - Find the VMA for a given address, or the next vma.
+ * @mm:  The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA associated with addr, or the next vma.
+ * May return NULL in the case of no vma at addr or above.
+ */
+inline struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long=
 addr)
+{
+	// Note find_vma_intersection will decrease 0 to underflow to ULONG_MAX
+	return find_vma_intersection(mm, addr, 0);
+}
 EXPORT_SYMBOL(find_vma);
=20
 /**
--=20
2.30.2
