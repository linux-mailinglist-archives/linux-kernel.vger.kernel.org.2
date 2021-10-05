Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC5D421BE7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhJEBdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:33:42 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31564 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231182AbhJEBdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:24 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951Awbn019258;
        Tue, 5 Oct 2021 01:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8xmIx6JHK8hTdVQKB00R61jaWflz88mVDJJRJWUJZls=;
 b=GbrgyLImkpD997J9BQEjCw2VCeJ9dr4MVJr4ApoU4Nicr8oaUKX9v2lBB/KKs2wAnsT2
 vlYHyHTvyuSRQpjwagpS5Is3NoFiyD6uTUcPeGE7iPlBI5NTt9J4pdbmIYn4poXQKFE/
 Oc3Tw2zuYB2VzBpAzyDunohn8v+j9A6HvBh5vE4vX89pJXAuzgGq1wQ9q4dA9chnVLk6
 LBnrKMkULAkQAhhQHKVsU24///6cq0TzWNEf7J2im/gtiRKtgAgRp8zONqQXdGNTDB7g
 V9FyISw6SJAhECM4Km/t9S1OYxqeIuo6CV9nQbCvodJmvq6f5e7gcfC6tSdObmUMIGoK iQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p5c986-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdGI141634;
        Tue, 5 Oct 2021 01:30:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by userp3020.oracle.com with ESMTP id 3bf16s9dx1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRA6poJG0n02QBavnV+qxR63vnFtQxnZSqHHeZ/yLtEH0mFMAKR6PM0/xrAdPHYEjoFr1kPiyYlbIFGArZAi20m2Jym7bNyjIrha+OHVk+ao5Nu9qCOzBJH+owiL5JHvVN5KUODyOaI56z098s3V3IlU3BEOr3xh42wleBCg6MpLF/BfPpj0/wOgfMg1KB90KyxJdIcvmzanYeMxrxjQGrfMjJ5HL4RByOL0LIjq2QXl1NiHInZkT7nLvLhY6Azxih2C+II9G4npCUfRDWTBKkigWkzNVEqQ3ueKYtDYeWVuGcbTqfQa8lLnwQUez2J9ILgJVVFmsL+ntonYeh9e9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xmIx6JHK8hTdVQKB00R61jaWflz88mVDJJRJWUJZls=;
 b=CKePF+QGWkDjFaGnHvcYmJqz9t29ezAEAQZ4LzgRIZM4T7FvljpK74uU/XTctlzYN75ejJq/oRZrTZhFzR0lUfBXb6NqJT2mKjFMyOltyhkoXRHl7DTDLZWQ7kG344PPsQW94GvKwo0pLYg7deqaUwrhYkfEq78AVCVcZIr38n6Y8dIAXS1j2UWR0NHEdIeOyIbcLev7IgkmhmfI1b2LgjmaUlbFCxLZApni4gthMOeTlTZUQ42IoSysz1lY/F1cEhXy/P15/NEkkX/3g0LK6Fw9tvXtGYY4HeKbIPVhvNDrlYJQuVegf3n9ewMIixH4AGxojtdK9+nU0cG/9ylndQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xmIx6JHK8hTdVQKB00R61jaWflz88mVDJJRJWUJZls=;
 b=avHT+63ZK24E7w3pMtidYQhDkJ+kK9DaZx31KVy3yLOLMzelX2U/UDJFOiTFNJ/N4qjcnim7ex8UVVAaepd2uyFKPxAEC9SUgTiK0tGm9HawgXLsRpc2Z5JggYNS9Xr0siWOGrjEaMuB0WMFqTC9zULnvk3wXhPIuvXK/CWgxb0=
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
Subject: [PATCH v3 16/66] mm/mmap: Change do_brk_flags() to expand existing
 VMA and add do_brk_munmap()
Thread-Topic: [PATCH v3 16/66] mm/mmap: Change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHXuYiZhbmBRyJSyEO2UuKaDGSFKw==
Date:   Tue, 5 Oct 2021 01:30:37 +0000
Message-ID: <20211005012959.1110504-17-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 4288732e-6fe0-4be3-5576-08d9879fbc85
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044484141AF6B5D0FE53FECFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GJ4on2KaQT/PI48GJlGDCe3TbM5JU1nmS3Trw+r/f+LEaRw165h/8jSW9KNPfeVMAekWltrIAel8ejluezh8Ct9PmvWmjAwbZ6b8KCSek0ryZrZVhtQPrx4vFcxnTrK/Dt4M5gBTwyOFqmPjZh4GAcADtIDFq6G0WJ/nVPO3m4PE2YEmmHKGUHcigQUGGyDMkrY2qbRJzz1ZblAigO4qW2eKdlJSqw7UcAL6+XISO49nYP2sYAHKcwzSAEGP8ZAPNP0z3owWP0JPmjjVXNmwnJRClZS1/rQ+/WyOByqOynUPMJl3wZ58K9uY0rUTaTOTki6mYxPTw3B0cwzlaFMf0PRQmw5KjXQET/8686Nm3fBzohNiiDP94W4k6Foryh7xRn0yh0u1WpU7VtSQngAjGBm1jKrkXxufYRBLzIWUWK7Wkz3cmYLFgAnRleINvgaOS6doe3YRhPDWLZACi0pGTyXZfV13sNC/h2eD0OBaDRGmdAWtcMKKmh1zzvzjQrFJ3m1Z13t3K5SFkwIp7Yxxx/9CLKjhXmNTqfXeC7uWQJm2R7Pxq1ICRXdrRAQJh+rmthFBe2DUgQqghnkk7kLyuxmKRdrStlks/6bhh7tYBUHm6mZVOQzDZdhgyv6ol8VkTtYLM6yO4JMmfJZj3vXBsq02c9bVqtKcpbHKKyYqvOr66p5ko8tjfv2rYcqsqV1htdGIxq1nTIHx3eEYP1qu1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(6506007)(36756003)(30864003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7U7cBiDfHYhDgvB8ZopkaXlN/aWtWzHkq+9GMh1O8O7ecaPCYYVlh5GTXv?=
 =?iso-8859-1?Q?uGf4jGz2XxQ28uYrpqcGnEX3VT96z9R6Wm5T7OOrL/0VYwah3F221t6yf7?=
 =?iso-8859-1?Q?rZjmazDDLlImPNRlwOuR6l2mz6cljXgeD/X4JNxK/MLAaA3tH8WcDZodhU?=
 =?iso-8859-1?Q?j71aaiSFHHrvbfwuENRn4JhqEOIxv3aLDT6krzhVzjUs+qMPSWp/vokOWr?=
 =?iso-8859-1?Q?uSsGLCUovLEWoAk41Y5eklhgj+iUpEpunWD9Z/rls4tQhPBvMymg2aqEpx?=
 =?iso-8859-1?Q?32kgKBDGYuLXwkZGvBtkHr6Uo7GQUeq/N11l8hA+m4y4//0ZuAdvQoub0I?=
 =?iso-8859-1?Q?9dJni1ZiD3MIWDcXnERRbqSbtYRWfb8qnWiojilkkSu9/4k0JQ/e8fTA1i?=
 =?iso-8859-1?Q?v1HlM1/lNIfpwuG+Duc5Qb1qR5VixamKmm6zB0tgynLF8C6L5hz4ChqLEu?=
 =?iso-8859-1?Q?oWjGVrmkpHBdCWDzWz68R1GdcQnhEvQx+h35AiALCp55zCJPPAqixM+hjH?=
 =?iso-8859-1?Q?jY4ApkyhHDIUdHG9Yac1w3dWtBF5rfPHZ1Gp25vLsU1FpRH+k/fZOKTGgn?=
 =?iso-8859-1?Q?L285HIB3evIARwIs5g6d37X2DwEbw/gLpUODcw4AoApNH/BKdE+Ry7/6Lw?=
 =?iso-8859-1?Q?0shtFu2Y9XXiH5Q/jzXpdlavuyzXT3mHLqfyTI+u2QvvNzowrlVWmfqjGg?=
 =?iso-8859-1?Q?1Lcz8+RCXGWViRuKJuLFzaWvwa+gyNQcxVCS1FCrtNSnvIlJPEaevbKWiU?=
 =?iso-8859-1?Q?2xm3AbDhWaf3TgSbkOmFO6lrvD6jneVZknHofN/RRFpiQS9LHOjrfe5gih?=
 =?iso-8859-1?Q?SFPBK29CqQiQHLGKBsm+TJo+BcUyS7qDzMYXkrPHRdPy/1xeGH1OdCF0rN?=
 =?iso-8859-1?Q?byT1kgmVbjw91nsC7HDx6dGc6LjD8ps9O4L6mHJ2NMWIKbuXvGVIsUhos+?=
 =?iso-8859-1?Q?ptfdsh7tyCPBlNQ1DxzuJR3Kw6MmSnZxEUepPYvbigqZICT2APv0d7/1Pp?=
 =?iso-8859-1?Q?hqVBNCJFpttAk5E0+QhXSDA7XlNn0W/7e7qT+UdNchgCH/ke3OE8jqxlN6?=
 =?iso-8859-1?Q?xeXjBbRh9jHzjirw8KTlf/p7fze0eV+LwFFLhzRvWFLnRdhBwaplg3Bz3H?=
 =?iso-8859-1?Q?Mj7F9UqilRDYGJjT1L94Ktq9iHWCDnasN9ep7qYq5BVttD9vhlY8UHT5gz?=
 =?iso-8859-1?Q?+VhIbcfPc7n5ni7S28FmsUKjXAYFjOjR83nwTdcHjpopQCTiYx0RVhjzVL?=
 =?iso-8859-1?Q?zCPHXst6IzNPjEz4Bj/Jaw2di0QJBBv3jlkD+xoPfCdfMWTBQLdJoPDwbN?=
 =?iso-8859-1?Q?anqQc+omTIurGB68Auz7iecQOB/j7BM9peAwYALthIXv9cBb/OWzZnlPre?=
 =?iso-8859-1?Q?1dZ4O9fpYf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4288732e-6fe0-4be3-5576-08d9879fbc85
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:38.0141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7J42roi3dU33NUfwzi3OYpFOAPm5eP4CksXht4DHu3VSb1v5j4qG2/KqnyjZXoAcDplsxog2eLubBucHjLz5Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: kaBj9tHwwAXLAug_Ya-Z7i49yOrHZBFo
X-Proofpoint-GUID: kaBj9tHwwAXLAug_Ya-Z7i49yOrHZBFo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Avoid allocating a new VMA when it a vma modification can occur.  When a
brk() can expand or contract a VMA, then the single store operation will
only modify one index of the maple tree instead of causing a node to
split or coalesce.  This avoids unnecessary allocations/frees of maple
tree nodes and VMAs.

Use the advanced API for the maple tree to avoid unnecessary walks of
the tree.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 278 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 224 insertions(+), 54 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9f047204fa93..b1f7c080b9da 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -188,17 +188,22 @@ static struct vm_area_struct *remove_vma(struct vm_ar=
ea_struct *vma)
 	return next;
 }
=20
-static int do_brk_flags(unsigned long addr, unsigned long request, unsigne=
d long flags,
-		struct list_head *uf);
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf);
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkv=
ma,
+			unsigned long addr, unsigned long request,
+			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *next;
+	struct vm_area_struct *brkvma, *next =3D NULL;
 	unsigned long min_brk;
 	bool populate;
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -238,37 +243,60 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 		goto success;
 	}
=20
-	/*
-	 * Always allow shrinking brk.
-	 * __do_munmap() may downgrade mmap_lock to read.
-	 */
-	if (brk <=3D mm->brk) {
+	mas_set(&mas, newbrk);
+	mas_lock(&mas);
+	brkvma =3D mas_walk(&mas);
+	mas_unlock(&mas);
+	if (brkvma) { // munmap necessary, there is something at newbrk.
+		/*
+		 * Always allow shrinking brk.
+		 * do_brk_munmap() may downgrade mmap_lock to read.
+		 */
 		int ret;
=20
+		if (brkvma->vm_start >=3D oldbrk)
+			goto out; // mapping intersects with an existing non-brk vma.
 		/*
-		 * mm->brk must to be protected by write mmap_lock so update it
-		 * before downgrading mmap_lock. When __do_munmap() fails,
-		 * mm->brk will be restored from origbrk.
+		 * mm->brk must to be protected by write mmap_lock.
+		 * do_brk_munmap() may downgrade the lock,  so update it
+		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
-		if (ret < 0) {
-			mm->brk =3D origbrk;
-			goto out;
-		} else if (ret =3D=3D 1) {
+		mas.last =3D oldbrk - 1;
+		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		if (ret =3D=3D 1)  {
 			downgraded =3D true;
-		}
-		goto success;
-	}
+			goto success;
+		} else if (!ret)
+			goto success;
=20
+		mm->brk =3D origbrk;
+		goto out;
+	}
+	/* Only check if the next VMA is within the stack_guard_gap of the
+	 * expansion area */
+	next =3D mas_next(&mas, newbrk + PAGE_SIZE + stack_guard_gap);
 	/* Check against existing mmap mappings. */
-	next =3D find_vma(mm, oldbrk);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
+	mas_lock(&mas);
+	brkvma =3D mas_prev(&mas, mm->start_brk);
+	mas_unlock(&mas);
+	if (brkvma) {
+		if(brkvma->vm_start >=3D oldbrk)
+			goto out; // Trying to map over another vma.
+
+		if (brkvma->vm_end <=3D min_brk) {
+			brkvma =3D NULL;
+			mas_reset(&mas);
+		}
+	}
+
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
+	if (do_brk_flags(&mas, &brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
+
 	mm->brk =3D brk;
=20
 success:
@@ -370,16 +398,16 @@ static void validate_mm(struct mm_struct *mm)
 	validate_mm_mt(mm);
=20
 	while (vma) {
+#ifdef CONFIG_DEBUG_VM_RB
 		struct anon_vma *anon_vma =3D vma->anon_vma;
 		struct anon_vma_chain *avc;
-
 		if (anon_vma) {
 			anon_vma_lock_read(anon_vma);
 			list_for_each_entry(avc, &vma->anon_vma_chain, same_vma)
 				anon_vma_interval_tree_verify(avc);
 			anon_vma_unlock_read(anon_vma);
 		}
-
+#endif
 		highest_address =3D vm_end_gap(vma);
 		vma =3D vma->vm_next;
 		i++;
@@ -2009,6 +2037,7 @@ EXPORT_SYMBOL(get_unmapped_area);
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	mmap_assert_locked(mm);
 	/* Check the cache first. */
@@ -2016,7 +2045,9 @@ struct vm_area_struct *find_vma(struct mm_struct *mm,=
 unsigned long addr)
 	if (likely(vma))
 		return vma;
=20
-	vma =3D mt_find(&mm->mm_mt, &addr, ULONG_MAX);
+	rcu_read_lock();
+	vma =3D mas_find(&mas, -1);
+	rcu_read_unlock();
 	if (vma)
 		vmacache_update(addr, vma);
=20
@@ -2501,7 +2532,6 @@ unlock_range(struct vm_area_struct *start, unsigned l=
ong limit)
 			mm->locked_vm -=3D vma_pages(tmp);
 			munlock_vma_pages_all(tmp);
 		}
-
 		tmp =3D tmp->vm_next;
 	}
 }
@@ -2734,16 +2764,105 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, s=
tart, unsigned long, size,
 }
=20
 /*
- *  this is really a simplified "do_mmap".  it only handles
- *  anonymous maps.  eventually we may be able to do some
- *  brk-specific accounting here.
+ * bkr_munmap() - Unmap a parital vma.
+ * @mas: The maple tree state.
+ * @vma: The vma to be modified
+ * @newbrk: the start of the address to unmap
+ * @oldbrk: The end of the address to unmap
+ * @uf: The userfaultfd list_head
+ *
+ * Returns: 0 on success.
+ * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
+ * possible.
+ */
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf)
+{
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct vm_area_struct unmap;
+	unsigned long unmap_pages;
+	int ret =3D 1;
+
+	arch_unmap(mm, newbrk, oldbrk);
+
+	if (likely(vma->vm_start >=3D newbrk)) { // remove entire mapping(s)
+		mas_set(mas, newbrk);
+		if (vma->vm_start !=3D newbrk)
+			mas_reset(mas); // cause a re-walk for the first overlap.
+		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		goto munmap_full_vma;
+	}
+
+	vma_init(&unmap, mm);
+	unmap.vm_start =3D newbrk;
+	unmap.vm_end =3D oldbrk;
+	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
+	if (ret)
+		return ret;
+	ret =3D 1;
+
+	// Change the oldbrk of vma to the newbrk of the munmap area
+	vma_adjust_trans_huge(vma, vma->vm_start, newbrk, 0);
+	if (vma->anon_vma) {
+		anon_vma_lock_write(vma->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
+
+	vma->vm_end =3D newbrk;
+	if (vma_mas_remove(&unmap, mas))
+		goto mas_store_fail;
+
+	vmacache_invalidate(vma->vm_mm);
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+
+	unmap_pages =3D vma_pages(&unmap);
+	if (unmap.vm_flags & VM_LOCKED) {
+		mm->locked_vm -=3D unmap_pages;
+		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
+	}
+
+	mmap_write_downgrade(mm);
+	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	/* Statistics */
+	vm_stat_account(mm, unmap.vm_flags, -unmap_pages);
+	if (unmap.vm_flags & VM_ACCOUNT)
+		vm_unacct_memory(unmap_pages);
+
+munmap_full_vma:
+	validate_mm_mt(mm);
+	return ret;
+
+mas_store_fail:
+	vma->vm_end =3D oldbrk;
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+	return -ENOMEM;
+}
+
+/*
+ * do_brk_flags() - Increase the brk vma if the flags match.
+ * @mas: The maple tree state.
+ * @addr: The start address
+ * @len: The length of the increase
+ * @vma: The vma,
+ * @flags: The VMA Flags
+ *
+ * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the =
flags
+ * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
+ * do some brk-specific accounting here.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len,
-			unsigned long flags, struct list_head *uf)
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct **brkv=
ma,
+			unsigned long addr, unsigned long len,
+			unsigned long flags)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev;
-	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
+	struct vm_area_struct *prev =3D NULL, *vma;
 	int error;
 	unsigned long mapped_addr;
 	validate_mm_mt(mm);
@@ -2761,11 +2880,7 @@ static int do_brk_flags(unsigned long addr, unsigned=
 long len,
 	if (error)
 		return error;
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
-		return -ENOMEM;
-
-	/* Check against address space limits *after* clearing old maps... */
+	/* Check against address space limits by the changed size */
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
@@ -2775,28 +2890,65 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	/* Can we just expand an old private anonymous mapping? */
-	vma =3D vma_merge(mm, prev, addr, addr + len, flags,
-			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX);
-	if (vma)
-		goto out;
+	mas->last =3D addr + len - 1;
+	if (*brkvma) {
+		vma =3D *brkvma;
+		/* Expand the existing vma if possible; almost never a singular
+		 * list, so this will almost always fail. */
=20
-	/*
-	 * create a vma struct for an anonymous mapping
-	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		vm_unacct_memory(len >> PAGE_SHIFT);
-		return -ENOMEM;
+		if ((!vma->anon_vma ||
+		     list_is_singular(&vma->anon_vma_chain)) &&
+		     ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)){
+			mas->index =3D vma->vm_start;
+
+			vma_adjust_trans_huge(vma, addr, addr + len, 0);
+			if (vma->anon_vma) {
+				anon_vma_lock_write(vma->anon_vma);
+				anon_vma_interval_tree_pre_update_vma(vma);
+			}
+			vma->vm_end =3D addr + len;
+			vma->vm_flags |=3D VM_SOFTDIRTY;
+			mas_lock(mas);
+			if (mas_store_gfp(mas, vma, GFP_KERNEL))
+				goto mas_mod_fail;
+
+			mas_unlock(mas);
+			if (vma->anon_vma) {
+				anon_vma_interval_tree_post_update_vma(vma);
+				anon_vma_unlock_write(vma->anon_vma);
+			}
+			khugepaged_enter_vma_merge(vma, flags);
+			goto out;
+		}
+		prev =3D vma;
 	}
+	mas_lock(mas);
+	mas->index =3D addr;
+	mas_walk(mas);
+	mas_unlock(mas);
+
+	/* create a vma struct for an anonymous mapping */
+	vma =3D vm_area_alloc(mm);
+	if (!vma)
+		goto vma_alloc_fail;
=20
 	vma_set_anonymous(vma);
 	vma->vm_start =3D addr;
 	vma->vm_end =3D addr + len;
-	vma->vm_pgoff =3D pgoff;
+	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	vma_link(mm, vma, prev);
+	mas_lock(mas);
+	if (vma_mas_store(vma, mas))
+		goto mas_store_fail;
+	mas_unlock(mas);
+
+	if (!prev)
+		prev =3D mas_prev(mas, 0);
+
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
+	*brkvma =3D vma;
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -2806,15 +2958,32 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	vma->vm_flags |=3D VM_SOFTDIRTY;
 	validate_mm_mt(mm);
 	return 0;
+
+mas_store_fail:
+	vm_area_free(vma);
+vma_alloc_fail:
+	vm_unacct_memory(len >> PAGE_SHIFT);
+	return -ENOMEM;
+
+mas_mod_fail:
+	mas_unlock(mas);
+	vma->vm_end =3D addr;
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+	return -ENOMEM;
+
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long len;
 	int ret;
 	bool populate;
-	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	len =3D PAGE_ALIGN(request);
 	if (len < request)
@@ -2825,10 +2994,11 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D do_brk_flags(addr, len, flags, &uf);
+	// This vma left intentionally blank.
+	mas_walk(&mas);
+	ret =3D do_brk_flags(&mas, &vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
-	userfaultfd_unmap_complete(mm, &uf);
 	if (populate && !ret)
 		mm_populate(addr, len);
 	return ret;
--=20
2.30.2
