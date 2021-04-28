Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B48836DC16
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241069AbhD1PmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:42:07 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46142 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240619AbhD1Pie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:34 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNedK010520;
        Wed, 28 Apr 2021 15:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rSKhRKcacyV4W9zzE7fDBVYr4fO28bQt4Zhci0sKYDE=;
 b=jcBDOm9cJS4B/nntvLglSCUKl2zGA5hIptiiIwNFkJUkGxDkhaHUspeWcymp0pCJQBu6
 zgFwHGgpmO3crZnKxbED27SKkVC87Hg07z+TPPkS2+0ZFzsONKaDXAfT2IXjkWSvFWeE
 QwzExg236N/ohbOUGQrjnd1fM3PY9QU6L5sPgqb0xSVJt8CIwApHBbXiC6YpNTfCmism
 ewS/a7dENsCozIU6tRbYqTxQ/SsCxvPTCikPqvfT/dcNI9NH0nS/jWlN2hAntLIbaeke
 xsEW0tbUFVGU0bYg9swU9sKc3BZM2fQx8nYNgB7ftGD7QEtur1KkblqTsbdVV6OUyaWS Mw== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 387891060d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:26 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFbPca024423;
        Wed, 28 Apr 2021 15:37:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 3874d2765a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIFa9Py4q4+9fQfT1jwNQfDZDPDOf9g+V1MIS/wXfBksnFMNVa23eNBjYXyl/R9XWyT7tQYtX+8b0c/5xYwh2sfXtqJXLad6RC3aCG5oK9KDFJ1TG3vO/7XkUXB3prCBvqbuNZqFoLn7H8wiquI6PtF5CwKxBNV3j0a7TiOVhkYze5YJAqQ8iftzpWbhz8HlTA8VFff48qWatGKtf1nUyO4Y0Uk0MDao6ygCVD/0J9pGad0SeI3ZmVNoUiBwZ5lmftTHOp6hFZzUo3m7Gr8EiCGoISC8aHUHezay69Ok31svDeZTJ4qGB+VdcH/DK/BvzufI4GE9Ourqdwy5/JvPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSKhRKcacyV4W9zzE7fDBVYr4fO28bQt4Zhci0sKYDE=;
 b=P9K+LF53qbKmGvd1UdysEB8cFa7/t72iAH0FJa1k1XjBYdDQq8Jucyf8dnibYem0aw/4zrZBaqXriGCbFV5X1MrLpe5NYS8wtPSbRHqi1S1bPanoVtTJFG9d5/wIRz6vrIMMrJk0/VXfsZga0swaOdoT+PFhSGgDkhKjcvRZlTpjHRkwkk7LCZKr4RhMDvYgQbNgwlkgcjySD4XQzuv354ZJAC6/1A8Segcr743hNTKu+3/CcSTbqwdK+Q4mBauFdWq1LjZqgCQo3cQEwLyofikdxaie+uh3CDikWbuAHySLiPYWOeUocUgQcIbt40ZZDe1uCCCRX4DzBuuQIZSL1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSKhRKcacyV4W9zzE7fDBVYr4fO28bQt4Zhci0sKYDE=;
 b=UrgJCwq+Y2CzlouBwry458JP9Q6ubyPw+nA/f7yqq6R7uNxzGoer+rDbi3J7MCtA0jBnemaBTqCnua5Z/FrGVmsI/o1Er/ihVijdLqMp7zrUyLh/p80V5goR6XNKQegGwJLumM04Ynwt8NiXY7GaK4MZz6SgzrMuILlItpWTK6M=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:37:23 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:22 +0000
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
Subject: [PATCH 71/94] kernel/events/uprobes: Use maple tree iterators instead
 of linked list
Thread-Topic: [PATCH 71/94] kernel/events/uprobes: Use maple tree iterators
 instead of linked list
Thread-Index: AQHXPEQ+75E4B2HUXkOM5VQTLsLxRw==
Date:   Wed, 28 Apr 2021 15:36:22 +0000
Message-ID: <20210428153542.2814175-72-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: cd3a0de0-8497-4e91-792f-08d90a5b846d
x-ms-traffictypediagnostic: CO1PR10MB4548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB45489A943622CA64392C707BFD409@CO1PR10MB4548.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eVlF5G7RaeiB/CcRaQDVTPprHW6zvn8mGlpGzqcK4H74i9Su+dHSB25xjh9L6hoZt8AyldvwmjgleCYy7SvCxlavM+MPMZ4PFTGQPsFaWX65r3sH9T924tkAab018XRpWVDoaOnuS/ojnrK+q3NdDI7n7Yp+XIblR+eF5OxxQY0CTiz2kvNeRV9+uYAfPW35KsXaRjtkpoOvo/m8S5YsXSW2+0tXq5UNhC7F14qeWJ6BwaBSNag+nEdT5xAy/6o6mjaNJ9yu/k6rULVoEHqCGuPF9GJiMuhhsqG/3soKSXzBsXf1gkxe9tKAwuQlCRll42Iw5Tm72a/dgkL7Ns0YKI+kyzNbXdG6i6qnA7BTbCEUbLLRJqwPHJcTxWH1JvzZXkWsUmImFM/aI10Xj9nlVW/W0ISpE1ij8zAH+fzhUii4y7gATv43/jiMWuMS2ROVS7ZdpvfrGQjScadT2J62adKLAs7Kg5za0xbs9PrFEkCZtEGnch4z1wlyHAnedILfPL7Tgvh7meIjtR+FoNjP9dPS/RcMJKMFxN0+T41MvlGgEbgm84OLIFo5wFZnZbBM4id7gkS2qckPgKOmbHs136yH8pRHX7b67TgHmQecQzU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(6512007)(66946007)(8936002)(186003)(83380400001)(54906003)(86362001)(478600001)(122000001)(4326008)(76116006)(1076003)(107886003)(7416002)(110136005)(38100700002)(26005)(2906002)(2616005)(8676002)(66446008)(6486002)(71200400001)(5660300002)(316002)(44832011)(64756008)(91956017)(66476007)(66556008)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?4UAVli6C3EEHvjOVmheGolcgBzBB9Bl3VShIF7YM6cCyJibTipopVXVG9e?=
 =?iso-8859-1?Q?3mwBCJ1fxuXq1hPt2Dwoytf9n7orEBqNl6YXT5lk14Jp8yVztfRWd1Ldql?=
 =?iso-8859-1?Q?jn7epx5cgkZ9pvPMZE4qhF6gnweZuAZcpFY5VLTUdQ2tzCnosOG5YQlV3U?=
 =?iso-8859-1?Q?n1S7MQrbTfqw1z9YMtMXsh1sKun2YEZ4p0x8QVdotuGE7iUylMlHdf5iHN?=
 =?iso-8859-1?Q?36T5s5vmSW1MyoDtGImWlRe3D6Qx+jPIZnp8U7pQe4exHjUz0G2xQEWvoE?=
 =?iso-8859-1?Q?dTfL/r6wSlZvUFyk6i4Hl6fuafoO5AJrvK87fcUK5tXroL546s71yInURP?=
 =?iso-8859-1?Q?HgRLdx4mxg7n7BiYPZup/JmKovcifia2gCUhOYxWt3RIFf4eKnFyURCHM8?=
 =?iso-8859-1?Q?u10hQVQ7y0z8cPn6+SPlZEU4b4VRyPejKaf5XYeoO0jSIAJVCiKZjMNQhQ?=
 =?iso-8859-1?Q?8Xxfqdv1DBj9JWygumqH5qm2Tc2qqyEizXnCaOhpFojdWfIzSGdlvoXEXh?=
 =?iso-8859-1?Q?5A9yrSpbPWkvDGVvghFOpwfsMFXTouHEhNznhHUgCNxX6nz6e/L82rgagA?=
 =?iso-8859-1?Q?1Gy1jemj1eAcFXcfafx1R9KiI7q3BpyXcx/9+SvFU0f64VCW/EbcJ/88Wb?=
 =?iso-8859-1?Q?ypW1S4vyqS6CODPkNbxPb/QK11KPIYmgbyalgwzrrynrC5kTTkLrKgVhvX?=
 =?iso-8859-1?Q?DXkLBnEEo7Tir5gjsT7UuIUSTjzVtfDogACLIPJ4A9DxEHulNwn9Q/1i0Q?=
 =?iso-8859-1?Q?AGuK3ro3cF0W0HokfXI90VPZBtRnvtAkhTruQqggBZFBn5ucy3ilzWPkJw?=
 =?iso-8859-1?Q?eavEdNfqXZKntZ5lhZ00BGE6+nH9KZAuT4gU5imr6xfQDDIix1tbA5ZExz?=
 =?iso-8859-1?Q?XW4SvvZtY8CCipAdomnGpHcIUNMCgkXaCRHrocolhWdLmkWvK2M6F0ywJp?=
 =?iso-8859-1?Q?TnSiqKCFPF7ydMvv53lKxY1nfdfO9DVCPYv/XYzg4h7q29E0kol+DqSFCp?=
 =?iso-8859-1?Q?DCTpq32zR+PsjBkbIlNsjGW76h7xrYP0yty8KfRN2KyZdO5hP82Zm/N8A4?=
 =?iso-8859-1?Q?HXYWymgwqj4vVZsS+MH9aoRXzx4Rss3CSh7nqQTedqL3V8cXG1MtqxPqH+?=
 =?iso-8859-1?Q?qAgG6IrhIKZpo26+UllcYmble02YQhqlhRVYq3MuKrPVR35mCK6Yd0GKJg?=
 =?iso-8859-1?Q?BOF3zMZbiSO/mq8gsu2EUquiiA9IsLHY97B1aq1SOHPZic9p06p325Gns3?=
 =?iso-8859-1?Q?Xkq9MuNW8L8OAoMnepFuvXXV+G+6m0ThuDs0XqFJqEpt4QA9P6m1ET1EaP?=
 =?iso-8859-1?Q?2vDQHslUEdPjA1ypy+2WBmwY5GSF1ZAo+QMaRUF1AfibomtxJINHCei4oa?=
 =?iso-8859-1?Q?pvBNkWAVJl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3a0de0-8497-4e91-792f-08d90a5b846d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:22.9030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j/Ul5Z2bcSb9Ep/MoS8kS3tCnPvRMkT8qR2II4/0Jh3Zh8+8idb6TZTkl+Z2kgcahSxyTzpW3qOYil2OIeps/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: gADt4lo5oW2zlUBfzCJ93PfsMpK0nJkU
X-Proofpoint-ORIG-GUID: gADt4lo5oW2zlUBfzCJ93PfsMpK0nJkU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/events/uprobes.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 907d4ee00cb2..8d3248ffbd68 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -355,13 +355,16 @@ static bool valid_ref_ctr_vma(struct uprobe *uprobe,
 static struct vm_area_struct *
 find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
 {
-	struct vm_area_struct *tmp;
+	struct vm_area_struct *tmp =3D NULL;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	for (tmp =3D mm->mmap; tmp; tmp =3D tmp->vm_next)
+	rcu_read_lock();
+	mas_for_each(&mas, tmp, ULONG_MAX)
 		if (valid_ref_ctr_vma(uprobe, tmp))
-			return tmp;
+			break;
+	rcu_read_unlock();
=20
-	return NULL;
+	return tmp;
 }
=20
 static int
@@ -1237,9 +1240,10 @@ static int unapply_uprobe(struct uprobe *uprobe, str=
uct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	int err =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		unsigned long vaddr;
 		loff_t offset;
=20
@@ -1988,8 +1992,10 @@ bool uprobe_deny_signal(void)
 static void mmf_recalc_uprobes(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!valid_vma(vma, false))
 			continue;
 		/*
@@ -1999,10 +2005,15 @@ static void mmf_recalc_uprobes(struct mm_struct *mm=
)
 		 * Or this uprobe can be filtered out.
 		 */
 		if (vma_has_uprobes(vma, vma->vm_start, vma->vm_end))
-			return;
+			goto completed;
 	}
+	rcu_read_unlock();
=20
 	clear_bit(MMF_HAS_UPROBES, &mm->flags);
+	return;
+
+completed:
+	rcu_read_unlock();
 }
=20
 static int is_trap_at_addr(struct mm_struct *mm, unsigned long vaddr)
--=20
2.30.2
