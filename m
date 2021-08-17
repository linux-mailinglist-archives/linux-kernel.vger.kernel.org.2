Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBC23EEFB9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240832AbhHQPzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:55:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29980 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240332AbhHQPtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:03 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjTxb006859;
        Tue, 17 Aug 2021 15:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2nAYhm9Z8cGDBge+bfJCbS5/JgpnKvcScZgWzRNowhw=;
 b=zSOoGil+vA7Fzo/nv+4/3GDVNN4r+5AAh/o+1CRnbe5cUsLM81+pE76HZp/UmiEx0qKV
 lafImcLut3Er96ZvcBv/OEg6VaKSgTqQUk6yRyOJy/x4Tqxt1y6o+2RxVP/waaVvZvQ/
 wUM3UD+R/Dz8/sDaX9CnyXV7NMzwkJe6tGJjS7n63CWrhRAXDN38i7GpvQs6LcnijAdL
 m2fzK/EHOAUw9/YZlt0qhG74bJMDzQlf/tPM7AQQeTykK1r1ruZAML1pkY1Y56LUnQIN
 el3608kN9PFP2arAtpe4PA9fXJeJLR18+5IAkjvG6a03UD10WhVGiDHLfr0KkNys6c2h mw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2nAYhm9Z8cGDBge+bfJCbS5/JgpnKvcScZgWzRNowhw=;
 b=jeYA/t6hFj3zXQ0IvZiZxPPUtDWYxskS75Q9wu/pwR1/CLF0bKaUUNJCGrZQcNSYHVsx
 JH9cv1ca0K6lL0yzVm1c5RFBuUQ0Xm4kvI/MOf+XnrcJX97tzDwkKQ5ntah8jGZnNlbu
 OiT8pmJnc0pPNzFbLzLHl9FcnrzaHqJ/CQM9YK70PzxW+jqbao2sFolkW3tLSpMY/nr7
 EIqZGRUiwdNI98+hwTbFzH+bj2qHDosPvkc1UtchVbJk1VjFhP4Uv5cbXOMc4Tmexumq
 VrmWD76/Vgl5z6umeMCI35IstyBGQgLaAlVOktgepwe8UJUD4723N2b47NKSi/UxBMsV fg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmbc9wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFj3Oe174039;
        Tue, 17 Aug 2021 15:48:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 3ae2y0d2vn-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RINROcSh0FdTd8HaHiupHaCUgxU6DKzrIY+5LdoccbpoE9+Jxe6xBMWz5RGZscKRQND646wfDnfMbdKUXW/m3xfjZwhfh2v4Xkp6NMJhmf2dGh+dcl2RGvP2SWkFA3zbNIzB1JXx1r6qoREnXuoMgTieOuGVnXW5GZbnIFpvV/8Mf4yU2R9y8/qa0UeY6rufLQrXqpN/O5fpSAP5jM9Qa0CdxB275iqlsu57HUe1OyvIslTbnLTJk18Bs2hyCPnledZpbnQtrdycpO8oyqHbrhkfOeFZg6tANwnEAwVBwtfiNb+V11Qx9GFGDGtUGfEerQF7nj0lnzeYHqGYcUon3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nAYhm9Z8cGDBge+bfJCbS5/JgpnKvcScZgWzRNowhw=;
 b=mGyjopym9YLpUDEWXca8JcXrjd8mMbpzYbxsTj/aoLfXIdvJ/RSm5cNDFBNTRiw7mjGg735b0KTL883iq/fIPjXXjW/7G6eK1N+tDNlNu1YknZ0d13eKFC6BEWrXVwTulrbkhjW3WWw/K5zkr8DASI/DFKkZxXhKZ5kYLJm4kt43xp+NrdE1AlXM+HVCATCqFv6apr+eaNLAqmc50kE4MWmtkqdR3tc7zGYziuWT6CH9XwIVgk5q1jZshW/vuCdccoMUZ7a1sHHRwXTk+h2dpwPmELCC8FKvZuUB+wycBI5DTPj4IuDhQmy6okeZ1gtHxbYne2SPekX/+QHX3kQFig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nAYhm9Z8cGDBge+bfJCbS5/JgpnKvcScZgWzRNowhw=;
 b=zj8fdHUvFxbkeb61gDxw/FiiMMQoiRcVW0E3+Ta4dmiLSr8rwvSdUieoUYt10TkplSih61OR0AdGP8h6P/QhmuuvI7H+bOKYixrb4WGFvll0b8yXf1ksi+LVBuKD+ivbl4ixzWTE+DKZLW1JATl0K3ywSg2MhUWBvupPSyuVZ44=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3580.namprd10.prod.outlook.com (2603:10b6:5:156::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:57 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:57 +0000
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
Subject: [PATCH v2 52/61] mm/mempolicy: Use maple tree iterators instead of
 vma linked list
Thread-Topic: [PATCH v2 52/61] mm/mempolicy: Use maple tree iterators instead
 of vma linked list
Thread-Index: AQHXk38w+kCOBwzH/EGkIuQTPUOe/Q==
Date:   Tue, 17 Aug 2021 15:47:31 +0000
Message-ID: <20210817154651.1570984-53-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: eaa40bdd-a193-416b-246b-08d9619662b2
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3580FBF3573540FDD2DA0CC1FDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Fo9qfhXXVZ0P+pNNxnXchOgF2L5dK11Vph+ZaTJVEys2tA4mR3LsAwXirOstK080G+znoigJ6jhmxGpqCGxZYXbZXlx+FE5ahzN1kKcwL/4kIFrPWE0EAuRpOcFfnvwaAv92STtQl9vupKOwU3J78YQ3vK3a/9+7p5wZwFjUgeV3Cm+BLfDHqUjO4lbd3syD2k2BDc2ej0QI/842gg+aSAxVZ/+osqclS57FU2MbXfggNNh799pk4oU/rtZ9HVmeUZENFdmwIUpqTTPFpXZt8jobZgQFE0xv+KZaHoUxm4xkHeGuYJWsIHAfiDjgY9Ext08vL0qd0NP+6x0T8tAOko1eVYeyj+nYeBDQGCVyH/FMGRVoVPygou2KL2+XcHfgxezwQmYFz8tFfl4RWYdbhEcgLP1mCobCI63q8QohaCkHQ3wQTJK/OPrcbqly1cG5ISirv4iC35O6Hvv8jCuJeUBKo8aRZwEcilFvAhgv6W02kuoG1QbbvaO5DSdThaStNu7ajkK3dvwc5FLHC7aPC8ieyUSW/2ay18mPbPAvxVrjTPx4p/vI8e3zgEdLWF8RoZmYGPrtZ8L4jNNJ5rgZ1Hsbi1H4bsLCQotDi8rZ+2bsSv6mFqbmvYzwZsz8mbJ+uV/aHCYPv/HoFpGfPJ2TqDgsiacdVsGH1ukMmF1z3NNMm+9f0jBuu1/AL55P36u2H+MK09Wwq/nf80VQ6LvfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rRrWyr/sIi1KsGfxGG1TtQdqJOsEkgK1JxfwTdpg1DeXxPIojtGeJ7MCgR?=
 =?iso-8859-1?Q?+I4T/7nAK4A3Ubkmj6c2UgedEeC+gfKP7H1ohDPO7KriNUb3v3p7KwYoRl?=
 =?iso-8859-1?Q?kmu6LUtGL5ma+Ihc5ilb+BtfAdhgj+Bpzo9AleK1A1hl8Upp+FHHxvj3A7?=
 =?iso-8859-1?Q?cy8Bj2jfhfiL2TtmIB3+fRTm+On5LUZmK1LkHr5TQGWOMuwtN9GtwzfyMD?=
 =?iso-8859-1?Q?nLqqw+S01vIcBvYeUYJJtw3D8CUnegwfj/HG8A29COudHLSeqLFgDahU54?=
 =?iso-8859-1?Q?Zj1QjxJ+zvvsyojmYioQAQOEJ+73O43l0ISOF+/9vImk3MF9B2Zhfi2i9j?=
 =?iso-8859-1?Q?oyIIYr2Aup0v0/X+QChHIhtYDIONpk0T9BaRUklGz0O69GT0ge1O0nQId/?=
 =?iso-8859-1?Q?Djqf0LDIpoPCcybL6j+XaPCEvDCcxPPPl85QWbkw9R8dyp7xBKRkuoyzjf?=
 =?iso-8859-1?Q?wQeHQXljYXWjzzWPVcjRrVv7ndDxlj3ElfZop/Zxcf48bO5ckQe2y4GzUK?=
 =?iso-8859-1?Q?i2h7c8T08RW/0KY4xmzyQqo8pL4ruRmphpHwR+hlY1NeptRQ5AKY6ciF+O?=
 =?iso-8859-1?Q?9FfoH5uxnX7O1S0thXkxizj1kwOXjNHFGD7t4ReUBN2IuCTRp29j/kBznq?=
 =?iso-8859-1?Q?vDjShSPoIg+Ry4XrywZwStkdi9mMk98npiJAlucf3ksgSchS7n/ElG7ndS?=
 =?iso-8859-1?Q?ycN9rUn5mnb+haop+OG2e16Aboa7KMTeSyhgQtNPSSD/9HhLrGrvtR9+E3?=
 =?iso-8859-1?Q?iXhHZD4Xu9MI2zw0qRp81kdRSSx6WRHdzZeXzH9n+tVUZD6JQYfsEhRhWo?=
 =?iso-8859-1?Q?xvuOmouvu1saGVvgZvhWFrU31xMHfxUedzA0VyxMPyhxUgYMeQjgZfsau6?=
 =?iso-8859-1?Q?F7Oib2X3Azcj5v17BTihr6hRDz9Jgfar/OLZtt1kAuwnAwuUYGDABNn8t1?=
 =?iso-8859-1?Q?cLJkm9hrlaVD8Sx7zDMy0VBcuc/GOOkqZSKh+Y7Wm6lWHlH0fdddQTqQ5i?=
 =?iso-8859-1?Q?bhqzI1lZiHKnJ5Ww67tfpT+s8/TX4CwDIbbpxY4ghw3quLsfL96YgwK15o?=
 =?iso-8859-1?Q?AE7nSputRX8EtuJl4unIXy4A1BDzwuZe9bJSMdN27P83q7yltx1I1kOV7J?=
 =?iso-8859-1?Q?SBHQGnxKlaXj6bcKLbUTD0yN5H6SA6fmKrlbdiaT4uO7x34XYLVouDUWPi?=
 =?iso-8859-1?Q?9v+BISGe/yGWPUzEOVojHI5RT0leSMiJCsA9GSaJ/DBlyuqGWTSGDgJu7E?=
 =?iso-8859-1?Q?ylRMG3dF2/IPtQK8z4QBn5XiKpavmvbD6vfqoyLHpQAWGB2sjutWfCTKPP?=
 =?iso-8859-1?Q?pzmSLxv5kneC7tE+Cum/SMcqxmWYv8qIoqNRGjuzSu7cw+KELvQlBisYXN?=
 =?iso-8859-1?Q?q7P+Fc0+qK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa40bdd-a193-416b-246b-08d9619662b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:31.9073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4BzVF0AgMuIPgS//hnVp8g46TfvwPV6xKemj60fHKNrHL5NypEnucdQYWS1c/sRBqqr7iXnWOaT/kGUsS9dYyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: 1XsF3aEJqBkITLVpkSz6OjYryGcFrN3m
X-Proofpoint-GUID: 1XsF3aEJqBkITLVpkSz6OjYryGcFrN3m
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mempolicy.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 9d3afa015fac..c8ded4c7dc93 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -377,10 +377,13 @@ void mpol_rebind_task(struct task_struct *tsk, const =
nodemask_t *new)
 void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_write_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	mas_lock(&mas);
+	mas_for_each(&mas, vma, ULONG_MAX)
 		mpol_rebind_policy(vma->vm_policy, new);
+	mas_unlock(&mas);
 	mmap_write_unlock(mm);
 }
=20
@@ -652,7 +655,7 @@ static unsigned long change_prot_numa(struct vm_area_st=
ruct *vma,
 static int queue_pages_test_walk(unsigned long start, unsigned long end,
 				struct mm_walk *walk)
 {
-	struct vm_area_struct *vma =3D walk->vma;
+	struct vm_area_struct *next, *vma =3D walk->vma;
 	struct queue_pages *qp =3D walk->private;
 	unsigned long endvma =3D vma->vm_end;
 	unsigned long flags =3D qp->flags;
@@ -667,9 +670,10 @@ static int queue_pages_test_walk(unsigned long start, =
unsigned long end,
 			/* hole at head side of range */
 			return -EFAULT;
 	}
+	next =3D vma_next(vma->vm_mm, vma);
 	if (!(flags & MPOL_MF_DISCONTIG_OK) &&
 		((vma->vm_end < qp->end) &&
-		(!vma->vm_next || vma->vm_end < vma->vm_next->vm_start)))
+		(!next || vma->vm_end < next->vm_start)))
 		/* hole at middle or tail of range */
 		return -EFAULT;
=20
@@ -783,28 +787,28 @@ static int vma_replace_policy(struct vm_area_struct *=
vma,
 static int mbind_range(struct mm_struct *mm, unsigned long start,
 		       unsigned long end, struct mempolicy *new_pol)
 {
-	struct vm_area_struct *next;
 	struct vm_area_struct *prev;
 	struct vm_area_struct *vma;
 	int err =3D 0;
 	pgoff_t pgoff;
 	unsigned long vmstart;
 	unsigned long vmend;
+	unsigned long index =3D start;
=20
-	vma =3D find_vma(mm, start);
+	rcu_read_lock();
+	vma =3D find_vma_intersection(mm, start, end);
 	VM_BUG_ON(!vma);
=20
-	prev =3D vma->vm_prev;
+	prev =3D vma_prev(mm, vma);
 	if (start > vma->vm_start)
 		prev =3D vma;
=20
-	for (; vma && vma->vm_start < end; prev =3D vma, vma =3D next) {
-		next =3D vma->vm_next;
+	mt_for_each(&mm->mm_mt, vma, index, end - 1) {
 		vmstart =3D max(start, vma->vm_start);
 		vmend   =3D min(end, vma->vm_end);
=20
 		if (mpol_equal(vma_policy(vma), new_pol))
-			continue;
+			goto next;
=20
 		pgoff =3D vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
@@ -813,7 +817,6 @@ static int mbind_range(struct mm_struct *mm, unsigned l=
ong start,
 				 new_pol, vma->vm_userfaultfd_ctx);
 		if (prev) {
 			vma =3D prev;
-			next =3D vma->vm_next;
 			if (mpol_equal(vma_policy(vma), new_pol))
 				continue;
 			/* vma_merge() joined vma && vma->next, case 8 */
@@ -829,13 +832,16 @@ static int mbind_range(struct mm_struct *mm, unsigned=
 long start,
 			if (err)
 				goto out;
 		}
- replace:
+replace:
 		err =3D vma_replace_policy(vma, new_pol);
 		if (err)
 			goto out;
+next:
+		prev =3D vma;
 	}
=20
- out:
+out:
+	rcu_read_unlock();
 	return err;
 }
=20
@@ -1063,6 +1069,7 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 			   int flags)
 {
 	nodemask_t nmask;
+	struct vm_area_struct *vma;
 	LIST_HEAD(pagelist);
 	int err =3D 0;
 	struct migration_target_control mtc =3D {
@@ -1078,8 +1085,9 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 	 * need migration.  Between passing in the full user address
 	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
 	 */
+	vma =3D find_vma(mm, 0);
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
-	queue_pages_range(mm, mm->mmap->vm_start, mm->task_size, &nmask,
+	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
=20
 	if (!list_empty(&pagelist)) {
@@ -1208,14 +1216,15 @@ static struct page *new_page(struct page *page, uns=
igned long start)
 {
 	struct vm_area_struct *vma;
 	unsigned long address;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
-	vma =3D find_vma(current->mm, start);
-	while (vma) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		address =3D page_address_in_vma(page, vma);
 		if (address !=3D -EFAULT)
 			break;
-		vma =3D vma->vm_next;
 	}
+	rcu_read_unlock();
=20
 	if (PageHuge(page)) {
 		return alloc_huge_page_vma(page_hstate(compound_head(page)),
--=20
2.30.2
