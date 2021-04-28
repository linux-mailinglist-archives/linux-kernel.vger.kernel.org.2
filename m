Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF0036DC1C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbhD1Pmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:42:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52826 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240359AbhD1Pij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:39 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFLhoL030867;
        Wed, 28 Apr 2021 15:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ii4Gj0sLqNgTgGHxIX4Jn/kt01AmI16O+qYyu0fa6zo=;
 b=TzuXX8v5+T8+4OChndP8LIgZX/jx+cbUV57s0aLZsKiWT1qELu6vRp+mOpqR370vCgbb
 Zlou3qODePC1yor+oTla18r5ELDzoIb5R8BRUw+8SR2BxSXpEusBdMdnvf9ldA24c+DY
 1479LwSd+23+mxP5p9iWdL7E2Rym9r3yj7XItX55F8Q6ycd0+EQBEYIq6dGUBFtxTZ6d
 MhAACVuWDP7mwRX0BCChEcdSNCwyjwECp5gLCvQCJd/JRf4ikCx73mU4plWg+hIjQnOZ
 O7rp4vAEuwClirYomczwou4jvwlDjtuBmJMBpMV/V+G1HXP2g4/02BOAjQ0nL62IczTh hA== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3874kn0eqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:32 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFZjx4021758;
        Wed, 28 Apr 2021 15:37:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3020.oracle.com with ESMTP id 384b58qq07-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObYNXQQqiRhuEHhwJlKHqzRuibfNP4qRLzX6igIen7r6RltIUVSR80N93hoLm6oj8fa+sK1mrpZx3QwJ5ju/oCMtO8tdS7LMpUwlcgCXG0E8G/N41p5P61SWMpVV0BBJIifsu2TVj0ZhPgSORl2MGoLU56r29Z9i5ZuxKS68G9GxWUfUEg5RTWgz0+mWLsgnxKVjkluctDa+UqPJ20OtLSD5yxiNX7zkOIXrGiZUna8d3v5L2PmuKDo8uTnR9hjdM2fhsUuz7SwWXTLuZmjwk/OnaWRvbUEAobu6ufucI+hoon4MJfXwJ++n1Ub+6MvFAVJ7PX9J5aHg0qiNKn8xNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ii4Gj0sLqNgTgGHxIX4Jn/kt01AmI16O+qYyu0fa6zo=;
 b=jDjHHI69mHBIRnRW5JNGTeJCHtJ/M+m9q9npOLxb9p5cyHGtnasS9GAg0a2sMQ0Ftwf+AMBlK/AxYPzkRA4AeJ2h6n8YwhkX3+DjcmH586OeAsqZA07Em7gcfwnqB1rd9hj3YOfEl3x/dDtH4Npt+YKn4KToKSUoSemOqAKxJ/8Z7Bac6vEGG8FjOcKo8xW6fIHVeDNr2Dm0vPta/GG1R/eDKcTBWtyRg7+lq+H+NY+cQDu19bQETOdRKbfWrzXBibRtRO9nI1ImJvwZIBnlvBwFMt2p3dMkhaGbWcrNVE/4HN/XGz01pP20JcgQSFmooxBZyOA/eXxZp+9L6uSfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ii4Gj0sLqNgTgGHxIX4Jn/kt01AmI16O+qYyu0fa6zo=;
 b=v3J59ZstnsY69dIL6YuYac/389OR5jKXoMJe8gof/ZjVlOfY2zfEM9SO0QDB6j4jiVQRqbaczjXGrsf32mkwLi4m6X2PXY6Si1U0YmCTGw8AxYj/wl/s2SI4OTbbJAK8b6wDvP1GiKNR9adMHJGaRw1NzciLpGH88sQiPvyZG1Y=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1871.namprd10.prod.outlook.com (2603:10b6:300:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 15:37:28 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:28 +0000
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
Subject: [PATCH 85/94] mm/oom_kill: Use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH 85/94] mm/oom_kill: Use maple tree iterators instead of
 vma linked list
Thread-Index: AQHXPERB5PvzM+bUHEWBdsrbi4tPvw==
Date:   Wed, 28 Apr 2021 15:36:29 +0000
Message-ID: <20210428153542.2814175-86-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 23786676-6da2-4dfa-52d9-08d90a5b8792
x-ms-traffictypediagnostic: MWHPR10MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1871495AB815548F2F4D071EFD409@MWHPR10MB1871.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:208;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zaPj+sKWfXoC3fA/GZjEez1LcrFNgc9Yn9haShplQobXSwR3+wHspRsjZZEBm8ZCz1fZCJ1kh7/YMVa/nMZ0aEnbRufNiVfRcyhZr8TkBh4eWZpPYWX6XZDr56DA0gzS3gJihyd9P6/15xKmsHUHsoGHX2H0ivCd+4ZF8UXDiG+vyT+NoSf2pJ8EznbFw2cbWCCwtAGQMHzgO2pcgIZ4hP4xvkEZoGHW7OV0cwTTTRCOVLOJHKi2Cqc6uYExN/VSuh6cKwL0pMNAQQ1RDOtTSYNO6/pQRF81bR2vv7GgUCbmn47X8u+nw6JcX5Q64Rb/n5jXtMLUzV9VDvdofB+pM4tf0JUJZh7td/Ja11OxgYErVQ3Vz0Bzd0kXbXQONzCNA2ctOu0e2cojgyWMUsbB5hf5pAvAuzUbdNFBUP91dnHea5bog+1HI0VrdziPbotdot0DLybo2UdJdg210pJdMFxTFYgFJDQHUXOwri4WEZAb+uYQu7FzzxbvCKl7MNvFoGM+67YrO9RrP1XT4p+gagO16ETCU/x/bXh+RrRT7wxIFYnzAS9uuRG3hiRqle+p7RT9GATFaovWF7Phf6QJTuZHtoforlsNi4sUUiIGSMQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(86362001)(186003)(6512007)(66446008)(6486002)(4744005)(66476007)(316002)(107886003)(5660300002)(66556008)(71200400001)(110136005)(54906003)(478600001)(44832011)(76116006)(6506007)(36756003)(7416002)(26005)(2616005)(8936002)(1076003)(122000001)(38100700002)(83380400001)(8676002)(66946007)(91956017)(4326008)(2906002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?5D9nJt/9DUw2H4YTVKltS3H3Fi92LWBcJl2y0IUVzO8UBpieaj6D1IfhOK?=
 =?iso-8859-1?Q?zOP4w1/twYGJGMf6sBaVWuDfvqytiJ54BN1XkB/LcXXaKZ2hwMXNSiMisL?=
 =?iso-8859-1?Q?GbrGrtp/U91U2FkWiCpawNhPmtcntH2r2MPyy5q4z9rfYdlXiXcYJmGnSx?=
 =?iso-8859-1?Q?QEkgKrVHBxyP4ET+g0msztV8laVkkwEm2FVJo9gogqFuzfoJlUMQUtsoSp?=
 =?iso-8859-1?Q?IgyC0BF7in+pfgM41MNliDiys/HUNQleuIhy+aMOXk7ZMgBt2N5BXIdfdZ?=
 =?iso-8859-1?Q?5fZcW+qTKDcUJvqJJ0nobBYVSiG6npNna9sjZn4VVb6Oz0+LmYbj5N4jmk?=
 =?iso-8859-1?Q?9146ymlUpaHRB9CTwLReSq1qfGjomkApAVOlV05bGTni4vXZzJ+5waOOIK?=
 =?iso-8859-1?Q?pyDe6UYxw04rkMm/pZtQCIHaMnxvqzsOxDDuSzC+p2jw7SkRI9Ce5Dtqz+?=
 =?iso-8859-1?Q?n71Wq0B7/YvuYl8bFkcrH8rEgzNmyxWoC/H+HLXKGlcgwvFF39jdZjM/QW?=
 =?iso-8859-1?Q?ziibzh8A/6mm54Up9kkRjstLtetcvFVk1A36hSSSnil/JA5admdd0zkUa7?=
 =?iso-8859-1?Q?5pPLGvlj1iaykLidwghH/eI3L3/fx2VN962N+yWK+9zFt+54nf1X0B6gPR?=
 =?iso-8859-1?Q?1KGXpwVEo9RmVd3LPMZ90wv2BqydnHuxEgwMgKauXEJqkTx6A6jtERgvoL?=
 =?iso-8859-1?Q?mM7qIhivKvv/Hq+wUNKaH2JBlmH8CaANqOyJJXqOzQmAuFukkV3ePrybKr?=
 =?iso-8859-1?Q?S86FQLPe/GdrmHm3RYZoguB2/hEreXxxLsMEVKmEhsPi5eZBdQBq4LWTJv?=
 =?iso-8859-1?Q?f+OGfbKd10MlV10GybuuqRshT0Fp6IH5Y+iuB2bmgQecPdCKIA9SUxUsC/?=
 =?iso-8859-1?Q?eDLtWWzHe2agz7z9OWUziBQLrHt9/kV28GUJi9VVf6hjjOZ6j1uDn7G7uS?=
 =?iso-8859-1?Q?dIbnhp0KBLmgInIKKGY2qnFn7sh4Kt8YpoDJvmJ4cpgHu0+Ab2HixYL60C?=
 =?iso-8859-1?Q?sBnJaomXvQGvmH8f1H4fxFkiw0FHR8OJd+2BbPhPzS+9Xr42aqJG06L8i6?=
 =?iso-8859-1?Q?CGKZonPp1d9pTJA6WXuMmHsK8FrKeB8OKJAaoQjq7DLDLO4LBuydEo/rje?=
 =?iso-8859-1?Q?/RyJgTMTt9H9uaXabbgMdrWX5xCVquxW1e/cskK9x7c4dnyCPEmf1wsPLB?=
 =?iso-8859-1?Q?sz0iK1HsGI/Y/7lPurH5QJXFG3tKgFOtcynK0qFmQgO6R4IgzAMZ8ZWaaP?=
 =?iso-8859-1?Q?/jFoxhJRYjnzc34F0FdY2t54GgET9YxfI8O+KegKr9l1bzpQSnmPYHN06H?=
 =?iso-8859-1?Q?qFrwC2y9zq6ElixwoNYlKCESxWWMEs7EXj4hNZxZyUu2O5pLdKtUsTJS//?=
 =?iso-8859-1?Q?Ir4Du57COo?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23786676-6da2-4dfa-52d9-08d90a5b8792
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:29.0692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C6u/4D3yPahkyGoXm47to4YScw1xcunMovoxI0rTbswwouYPGZ7rgfSjWlpJt7lWdC3HHc0PnJOz0OQg5XcRGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1871
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: QEYKSbcL7u2j08oRZM3DUaMZTIhyuQmV
X-Proofpoint-ORIG-GUID: QEYKSbcL7u2j08oRZM3DUaMZTIhyuQmV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/oom_kill.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 54527de9cd2d..1f6491965802 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -515,6 +515,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret =3D true;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
@@ -524,7 +525,8 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
=20
-	for (vma =3D mm->mmap ; vma; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!can_madv_lru_vma(vma))
 			continue;
=20
@@ -556,6 +558,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 			tlb_finish_mmu(&tlb);
 		}
 	}
+	rcu_read_unlock();
=20
 	return ret;
 }
--=20
2.30.2
