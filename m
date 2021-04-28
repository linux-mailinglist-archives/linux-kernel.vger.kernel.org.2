Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D307036DC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbhD1PnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:43:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61014 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240436AbhD1Pht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:49 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNiXR032601;
        Wed, 28 Apr 2021 15:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ejyYY+M0jJoa6ZXBGLXc071FEveHtxtpwtFw76/JpS4=;
 b=JxJS5FWx6uILxe1fsVAODitANz5wcI2/qLOc/9B2Xj8t4kXP+oIszsbI02yafWKkaOAW
 Agofme5xS9j/qUCk5g+0y0F4vJb/JRBmdEOGtnL0cFfyrIRKiDG8/TvZ7PD5rtOHSogU
 JWsUySKUaOGH8t2e35UxWB8m5iZqWxVha0N/vkQuLub2C0fD+ktTC/fXHHfQA8B83eiz
 8jF1rqaS30A5rBwbBlqfXqfsbHFrcFgVrAdB938caER5/hMx9aK+1dTNFMTYx85aYKhf
 XazlUGMi1hUFAz06hnJoT2Yr4GBHe4yJ3K4anW4eY9SdMF/6Rxtx4miyqp9h3YSBmiFo mw== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3874kn0epy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:47 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaASw030176;
        Wed, 28 Apr 2021 15:36:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 384w3uuag3-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XGgjbYWja2fm9KJKqSSjgykiAiVamOxZOdJmuzYD5T4zcC171HLkYSf3PE4WaM6cBB8jpDIGvqv+QLLt/8RTshqPp6t0frk/YkLN+o906b9ahAk1pK2x8gNXNXYHmN+/s4ktIJvA7RC54mn336Av9PRR19QRpNuWA4mr7TErbqqd3W0jM28PXqnZDkUvtUrxh89g7WDw7QzmIoZ+Po9OKJ7P/5KR5n9mwcVjEsbNdKL41xjXqFULo3kJ9mbYAPETv0DUQDsyQIW95ulPX52cOV7331EiYWzkw9vc5arai1W8zFzsyM3eeROOOAoSYr8x4ZnK/8GBFYXv5wZcV4PAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejyYY+M0jJoa6ZXBGLXc071FEveHtxtpwtFw76/JpS4=;
 b=ocpjbpZW7MSuUasxVmBanYWYt9uMvajPg8y6o3l4zJt/tKWjukQEmshVSw1XWsNC6RJqDOdeLNLijnqd3LIWnjVHnDhW6uPODAeCkrowJhXBkyLFyXsDy+dVdEPZjpdSuGTL2e56jPBkD+TYEoeaqJ4RB8HY+0jhYic+5Cyu+QshquQfrOxXYS9w6KAciV5fdRMDeGVMbK2SLgNBEKP3UaI3oECvNlMpa2Ci/zxDl1tKTarEAa2dsjIt3NnYXnaZwg4dkkNl6kTw9of/546fw8yxciT2MmtKCjW9uiBlpYdvcPFhA+SbKIJN00P8q8hVPXvwiTuaveUIYrqAkFkPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejyYY+M0jJoa6ZXBGLXc071FEveHtxtpwtFw76/JpS4=;
 b=aFb+OVUduB3gCTEsmzgywFCicyAXmpxdakg/YC+ecM/xnXVM4Ch7UIHdweVQwDUqm419ZvxYAz9zmEJ9NQpa5quoAfXURHh/DYIcOYOCy60/r1iD9gfFhpn3qtUweMrlBuDEH+Ld5+e7TnHEP38mvv7Y16FoCVynkLC7beVkzeg=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:36:43 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:43 +0000
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
Subject: [PATCH 47/94] mm/mmap: Add do_mas_munmap() and wraper for
 __do_munmap()
Thread-Topic: [PATCH 47/94] mm/mmap: Add do_mas_munmap() and wraper for
 __do_munmap()
Thread-Index: AQHXPEQ321aiStTYNEGXcgYKyqW8Uw==
Date:   Wed, 28 Apr 2021 15:36:12 +0000
Message-ID: <20210428153542.2814175-48-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: b13efa56-7a03-48c1-9a9a-08d90a5b6c9e
x-ms-traffictypediagnostic: CO1PR10MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB45158081EFC89A90A73D456FFD409@CO1PR10MB4515.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IqESAMZVhtQ8bqd2SazqOFTIMnX/5xe8PhwHlmILAhikMN77StDHqKJaghh/yhhUSbMszgYDvBKYsYQ+qVs2a9dPgnprRTN4WjtAVRSs8Rxi0b+XjygmKyr7VjhAKL0ArIuWAk3N0Ia0l6JpFTntaZQBb7CZLnBg/4tYaTyYmQG/wl1lLXpMnb6MjGAqGnZH6jA7ZOD7RvLLZ7ypVMP7OEbSE+H0fHPlel8s86oiokdzCIknH0WL3Mo47sI2k/eAmNF89fxaQC9wh9j2n5eCTD/Ue3G/oioat1/cE1wU+h73ugqW93V3RCV04/eGiUMLLm2L2XeVNUuKuMkUVC/cRYL9KETcu+7p6zbJXEAGNPeLJEzfx3CjC9R2MqLxt1FIxuUUVM7SQigvMfELtWcoYnWDX8dAEjYgVwZqKRY/nr5yGG0xUrllA6856s/fa2d4CfCdQwBOizPRVpQb/u791+uDmd5PjwG2BX4KQ9D7A5v1rJ6fFyL4/JD+zd/haT7lO4pAKUhPxN7VP8glwpq8MstGZgEk3HBenGx61zwEPvANb7SMfGxQCZlKaxLcTWNndReeQqTr0UwsJDo7+VOXgd76rqncs/lBnWlQ3Km7Zgk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6506007)(4326008)(36756003)(54906003)(71200400001)(26005)(110136005)(6666004)(316002)(8936002)(186003)(44832011)(7416002)(2616005)(8676002)(76116006)(2906002)(91956017)(66556008)(66946007)(478600001)(66446008)(1076003)(107886003)(64756008)(86362001)(5660300002)(66476007)(83380400001)(6486002)(122000001)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?f89A1oixz1fr7qhBaBFNK6CaNbiV8d986C+PjCaTuOK3H14QENqcj2XdTI?=
 =?iso-8859-1?Q?jNokrmwgVBrIwwwY4jid3eW4bqtTjV6gys9enhE8ekMop5d49Bf7Mam85r?=
 =?iso-8859-1?Q?VHG38/epZeVnZZxtJspUMH5Wrb5V8xr30ztUAsWHB/CIf4eXs5dDiFgRe4?=
 =?iso-8859-1?Q?TQ4P4bRMLJ36qabFwZn4NgXTO3h3fhiBSPcYvI+gMdE6VIL796svtZZVrC?=
 =?iso-8859-1?Q?OBh0hlfx9pe/F8e4TN2RtvtwqOYtgefCOqi1iohoKjEvaiCjb3BQkVxno5?=
 =?iso-8859-1?Q?K3ZxJfC7MPOrJh9lytAQkyWFCgBotgIlhbH06pTXn7j+pBCN2/FJMGeFQr?=
 =?iso-8859-1?Q?CWrGEGqLW5ElYYLXQb54WM3597jAI7pTCrLLV1F41rleSJKQaG9hksq5yW?=
 =?iso-8859-1?Q?DPQMu49mlxJABsgYglB4bLevF0eZZYgLKP096nDzfngwAGpjf/tPFCgjUp?=
 =?iso-8859-1?Q?1L5DogaUSZZiV5tPxWYnS2FtZ9eoSf+CnlHqv+pAUHWAPMONbPzJuDkS7q?=
 =?iso-8859-1?Q?VON7k1lT5rMoa7gk9Zu2tJnvJELSKsIz2mdbLNup00NtwUT3VTURhWWn87?=
 =?iso-8859-1?Q?2rJQHE5jQvojxCJxgvOAiBb1SHoGQ7CVFqs3lDK00wNkEZjcs1RZtYCH7L?=
 =?iso-8859-1?Q?X+ttu6V71bkLghReIINbAKSnmdupv1oPa0I4BezacKtpU7WUxwsFLFjSOv?=
 =?iso-8859-1?Q?aHc6hmDn4ChT8o8iPuzhEUm+Yw3c0+IJWA9CLe/aEucgqHModhuh73qvLc?=
 =?iso-8859-1?Q?CqBFO8tUY+/83O5PNjv9tVpn+2gcD/M9TPgfNZCyYmliJ93bABUSzW1+5K?=
 =?iso-8859-1?Q?FN2jQ0zeXmF7mq/qBiwE7Puc+QekHkUHC90U/7Y7ZKEQUO1xXLLkuqzXZg?=
 =?iso-8859-1?Q?Z5WKklFj2urSxrJ0cJJZvIa/KzNbwl8u8aKHsA1X/mwdPcxLA3iry4akmE?=
 =?iso-8859-1?Q?S4qYNvW9aZypyQhYJpURMNRgoc3ey8ZG0rIzA5zWweJIAzpiGRlw0Ca1CW?=
 =?iso-8859-1?Q?QSz0yqPNbVSnK/pbkFrOu+dAOMyREJBq2lizDZHNu6ndlALCmxXiXGxryI?=
 =?iso-8859-1?Q?Y9TxyKG9WH+300kiKmRk+GDltqJAEU8dIaObL3pRfuSbl03QsU4qzxzJRZ?=
 =?iso-8859-1?Q?5ANw0TZ3XWMdjYxaSYW+mqIls0/s78wrt84ZllBRGgFvRMJVv7JF8AtfNt?=
 =?iso-8859-1?Q?5cWzVkSv+CIkAH3gHsV4M5dkp18rpFTUnFOsJ/OmUnoh8zb+5IMPNXUtgv?=
 =?iso-8859-1?Q?22K1r4JzM5O6brw8PS9hqaOLAu2Rt4XojCYXuIuQmb5Xrpwoeg/CMWlHDN?=
 =?iso-8859-1?Q?d8rK4km2qdWGjzpaKLLMquBza/kQ9xdjl5VcwsRKraPtBJViiWM0xTPqlJ?=
 =?iso-8859-1?Q?FGUz7QFcAU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b13efa56-7a03-48c1-9a9a-08d90a5b6c9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:12.2217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LfuyjNPIQdWWFqlLJOJZFv618eFHaXQKeY7TAoDMBk4wfjrU9SmtdrKcJnErRtvtojjn3UVJ/7ezKhocBDCunQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: ATwObbu3oUfAsXMHm-5eph-XBknNXpeN
X-Proofpoint-ORIG-GUID: ATwObbu3oUfAsXMHm-5eph-XBknNXpeN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid extra tree work, it is necessary to support passing in a maple sta=
te
to key functions.  Start this work with __do_munmap().

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 107 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 75 insertions(+), 32 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0106b5accd7c..6fa93606e62b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2413,34 +2413,24 @@ static inline int unlock_range(struct vm_area_struc=
t *start,
=20
 	return count;
 }
-/* Munmap is split into 2 main parts -- this part which finds
- * what needs doing, and the areas themselves, which do the
- * work.  This now handles partial unmappings.
- * Jeremy Fitzhardinge <jeremy@goop.org>
+
+/* do_mas_align_munmap() - munmap the aligned region from @start to @end.
+ *
+ * @mas: The maple_state, ideally set up to alter the correct tree locatio=
n.
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @downgrade: Set to true to attempt a downwrite of the mmap_sem
+ *
+ *
  */
-int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
-		struct list_head *uf, bool downgrade)
+static int do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct=
 *vma,
+	       struct mm_struct *mm, unsigned long start, unsigned long end,
+	       struct list_head *uf, bool downgrade)
 {
-	unsigned long end;
-	struct vm_area_struct *vma, *prev, *last;
-	MA_STATE(mas, &mm->mm_mt, start, start);
-
-	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
-		return -EINVAL;
-
-	end =3D start + PAGE_ALIGN(len);
-	if (end =3D=3D start)
-		return -EINVAL;
-
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
-
-	/* Find the first overlapping VMA */
-	vma =3D mas_find(&mas, end - 1);
-	if (!vma)
-		return 0;
-
-	mas.last =3D end - 1;
+	struct vm_area_struct *prev, *last;
 	/* we have start < vma->vm_end  */
=20
 	/*
@@ -2465,8 +2455,8 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 			return error;
 		prev =3D vma;
 		vma =3D vma_next(mm, prev);
-		mas.index =3D start;
-		mas_reset(&mas);
+		mas->index =3D start;
+		mas_reset(mas);
 	} else {
 		prev =3D vma->vm_prev;
 	}
@@ -2482,7 +2472,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 		if (error)
 			return error;
 		vma =3D vma_next(mm, prev);
-		mas_reset(&mas);
+		mas_reset(mas);
 	}
=20
=20
@@ -2509,7 +2499,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	 */
 	mm->map_count -=3D unlock_range(vma, &last, end);
 	/* Drop removed area from the tree */
-	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+	mas_store_gfp(mas, NULL, GFP_KERNEL);
=20
 	/* Detach vmas from the MM linked list */
 	vma->vm_prev =3D NULL;
@@ -2546,6 +2536,59 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	return downgrade ? 1 : 0;
 }
=20
+/*
+ * do_mas_munmap() - munmap a given range.
+ * @mas: The maple state
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length of the range to munmap
+ * @uf: The userfaultfd list_head
+ * @downgrade: set to true if the user wants to attempt to write_downgrade=
 the
+ * mmap_sem
+ *
+ * This function takes a @mas that is in the correct state to remove the
+ * mapping(s).  The @len will be aligned and any arch_unmap work will be
+ * preformed.
+ */
+int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+		  unsigned long start, size_t len, struct list_head *uf,
+		  bool downgrade)
+{
+	unsigned long end;
+	struct vm_area_struct *vma;
+
+	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
+		return -EINVAL;
+
+	end =3D start + PAGE_ALIGN(len);
+	if (end =3D=3D start)
+		return -EINVAL;
+
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, start, end);
+
+	/* Find the first overlapping VMA */
+	vma =3D mas_find(mas, end - 1);
+	if (!vma)
+		return 0;
+
+	mas->last =3D end - 1;
+	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
+}
+
+int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
+		struct list_head *uf, bool downgrade)
+{
+	MA_STATE(mas, &mm->mm_mt, start, start);
+	return do_mas_munmap(&mas, mm, start, len, uf, downgrade);
+}
+
+/* do_munmap() - Wrapper function for non-maple tree aware do_munmap() cal=
ls.
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length to be munmapped.
+ * @uf: The userfaultfd list_head
+ */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
@@ -2583,7 +2626,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
 		return -ENOMEM;
=20
 	/*
@@ -2937,7 +2980,7 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 		mas_set(mas, newbrk);
 		if (vma->vm_start !=3D newbrk)
 			mas_reset(mas); // cause a re-walk for the first overlap.
-		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
 		goto munmap_full_vma;
 	}
=20
--=20
2.30.2
