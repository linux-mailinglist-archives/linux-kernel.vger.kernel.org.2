Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA7F421BF9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhJEBew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:34:52 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:31024 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231726AbhJEBdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:42 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19511ntx024407;
        Tue, 5 Oct 2021 01:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Bj3fLapn7xY+BdV96sONz2fX9EzvUkup6IEOMssVztQ=;
 b=fclmqeOxjG2+r/j1zRV8rMxkqojwUNEQ0vmdETm7u+wkQ+SnUdtvSO/0P1GTFTr47qYW
 RjHAgqMFRirtdJEt7OBacc18Fwv2A/j+QfPXBgK0GKHuPrwaynEfA+35uhEMk/+SwT7q
 cJYe4wvhOKVcSJgKfM3GvZF0WDDXP6tQSETcTXSJfdvZGei0WFHdttFneZ7t8GWZBv+o
 jgl5xVXm7AAYUZ3IpgZGqYxLymPWbGN932QjRbv11wcN6W5W4/YVfXMuXkEnRoLsvsp9
 PdYHJzM74cbzU8+pXoDmt7pCFFlIC3/KiIzEZvi8oXxK8e4hulPWBykjPuv80odHTSW6 ZA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg454bvqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UHTX178361;
        Tue, 5 Oct 2021 01:31:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3bev8w0386-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CesFLlmr4uMH4dc56971utUG1xjbZdyvs0cd5tTzCWM8NRJ1zOqzS8dhZksPc5tMJDAQYEdQLeMRZIVItYM/pG+1Ck/0fRre1LEnOiAk0AAbpfrCCTBRIVo4doNjaznKTk9bl2ptslxm8x3G4vj6B7PLwry8G0GHenNWfC/tFcF7uOb08vb+VfxK84nHZYCEQ5fGkF6Q8x7whV1M7eVQzoaQl0GFEa4bt9w3m+6s76Dv7EWzLfxEmGx2bvvbfGbS6fMjjDzYvvLzYxPL7sl7McwB8jzk05KeliitMtAOvRSboYQ1yIUss+9WIOyre3uXqr0X9JB8UGJ1hQqKmmYh0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bj3fLapn7xY+BdV96sONz2fX9EzvUkup6IEOMssVztQ=;
 b=PHMz+aYet0I6UJZugbB6M8HeZoqouGmnth7+QXV11/YJ17MWsjSHRaGjJAKL/WX50IURUY7FGxSLCrFE5f0KeTy0TC1+X5OZ68f+0Lw8KkGonfWtZk+pGZaUbSNtGTRidJ+s6+a0kAgsEBUOd4By27h5dDuigjiF71KzY0Qn481+nT7A8SE3LfZOwMkccNmGaJALSk1FCZ0w2RMhvJNXtyIYL0Ru9NxaBycirNVJ36PqUOo8ju/95zAjj5LZbHTzoTAxOBfV9p4ZSGpY2Yipxox4iyPGutOUIRXoViWfqB9Kvv/XS+ZUMMvCpA7wcXvmNH4Vqu5csvIEnbGWG4mpNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bj3fLapn7xY+BdV96sONz2fX9EzvUkup6IEOMssVztQ=;
 b=zyV+RV4nB+xbiHdIf8t7Foh0JbqkHUyy3wdfI3eAfxopFtDiLokvYU5tcWQo8OeKHz1bPjinjOwzuRUSjYCYOQNJnFgeXZRHAUZISWDy4C8SKiFMSl04U7AS0pMJ4AdGkFBZUGjDl+HATgT74fM16o42eiNfJ6s8gfJwMVZMCdk=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:26 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:26 +0000
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
Subject: [PATCH v3 58/66] mm/oom_kill: Use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH v3 58/66] mm/oom_kill: Use maple tree iterators instead
 of vma linked list
Thread-Index: AQHXuYisFGigQEVdzkGpPBKHaTZEYA==
Date:   Tue, 5 Oct 2021 01:31:08 +0000
Message-ID: <20211005012959.1110504-59-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 5d0088fa-563b-4741-e72f-08d9879fd976
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044D1831475AD71FF8ECEF0FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:208;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wOk6gY0L0UNNbRUxEywjnpZxu5OEPXwwu6U0lVPgBWq8qLR4hTaEnEhNpHVC94+JSl+jSngjHpPPRIoiUzpDuTSUN7aQz2A6qGvV5OzgQf9XigOofFihntY2PFb9zOCyuvgY32yB4Mhep/ZGUfhtIsqCjHdrZBef6VGjfbo9d7FM6TCJGZL4ete0ClKe0I2BLMl2rmwpnBPokJzzS7OaXXA++QnTINDVAxdsWfbnZsB+vpUye/eGsIWZovIaUKJbYCgd+ovWB/rn2c2fkZgWqhE1ShFFz07M3E2Vc9Nj1s1d+Lc7NoFBmbUZa9GIPLft154E1mQ2X+/qQ6N9uEbQ3ogoRBaufDrHmqkpO40eZQSbHh2xWgXzeIJ/zvfdXHg2iWnln3SeeIq0RTd4zsKCQseXcKphvPRR1OsHvjkjHTiavvN+jlXu+pcFstfZJLPnUqFQcD10x/Uo7JwAAUopQTnz+lOgNl3Ob3MMM4W+RCiZddgzxO89M2QJLSF4Ok2su5sojhTk7Zlipwzm8WpiLkGKBryXDE0fccRaDW21TZ7J9ZQBJvCOJAxIqSbSW+cAhnXc7KzogixVsRxOGQGkkx1KqeRuPd0KWa4lWT7eCtqGdoa9Uc7Iui6mgxw8xmxOjwy+1BV5t53vekydnIikUohG1sHFWrlI8iqJtN0z1CWtRqcS8bXCdMYLxQvXoBFGW4H+NkCkx+5L6elFI1lJUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(4744005)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZcTa0Ff2zwAP3p8zaO+OuOaBQUsxz8/2gy415/lOlXT+HQBF8PhPgFbd/9?=
 =?iso-8859-1?Q?CJHV4a7Sk3XHdk99FXD3b4uTQdMiTRJ8yqOSIDTDjC8Hqj4WHIh9vCkN5d?=
 =?iso-8859-1?Q?NPxMyukYshlE/khvyvUh1KKWW37BIg1U3PCWikusjwJjlwgvsRecafPMoe?=
 =?iso-8859-1?Q?vXyH4M9c3dMpkGxx9/ovUYwYOLgt+f7rjbvmEmj/uSCKTaPMyJMOesRE6s?=
 =?iso-8859-1?Q?EDVw6iule5wweZmAYw0m5ematZh0IlFauB3ELnYb9gTQVpgozG8HdYVmGd?=
 =?iso-8859-1?Q?oM2Jl+YdhMgP74uH4Wl2X9AKPQabY5inGVhbf41cd3sR90JBtR7St/C+LM?=
 =?iso-8859-1?Q?vLo6+yAi/VFD9BhlZHreRNiyoFdfDbN//65BUiOjzIvRBc0eQ8eUdBu1L6?=
 =?iso-8859-1?Q?FjIxH4OzgXBOml3I+LLwwBvOBORg9LDVamtaC0ty4ALidwtlaYLR2rIJ8/?=
 =?iso-8859-1?Q?VoSGyZxNQE4ovQnS1pwALndTq4UhRq48ho8eCfchCwtzKRzM0qpTV1SF/Q?=
 =?iso-8859-1?Q?Yk4yqRzzhhaFx09kryo5YSl0+reMUAU7jLBdnjYFz1Yyw7ZeyMTpp/dEQh?=
 =?iso-8859-1?Q?gDLaPPsWxo71hrrlMkXnRYoUxwVZf2js0O3SP7UYwewjcxC9DJa6VrIeSX?=
 =?iso-8859-1?Q?owkhwItDdUUUS2Gt9IxDH6Q2KRquQlXKUdpwJf05WzfpP1u5LcoIU5+Als?=
 =?iso-8859-1?Q?egyZcz4t6XkbgaOYgTE6RWcbCdTcyTo14ETLLAl7eLnGBC1lZRvtIdhiHW?=
 =?iso-8859-1?Q?b+e+Rzk7W0R2/CK1d8Zq9B2HfSZWI06qlN/+aRf7Bo9NXvPGQ6wOY0Ubtq?=
 =?iso-8859-1?Q?tStVmqV8vGsl3eFZ6wIFtKnYcEiwm0EisiSUkNkukEyxj1O/0eQh4fob9r?=
 =?iso-8859-1?Q?sNV6aLGG4VFin1KlYo3xUYRt3CTROJP2aE3pSlFVswC/G0hiuZRq4qzDjc?=
 =?iso-8859-1?Q?y79WlWnLmWV2fDBkVqsXMFHrp8BuvCLoI8+iAWfcORHWcqoBWXCr3TRYPN?=
 =?iso-8859-1?Q?sRsrK3AmO4k89hQNCki4wuoLxDJMnxpt2y1VmJF1H+qj2Y3h+b02eI+l0Y?=
 =?iso-8859-1?Q?kyZi/j94FGkur9G4EfnX8ghkSn2Pyjvt5Q8V6x0hYXbioVXM25N8mh+LAY?=
 =?iso-8859-1?Q?5pgY1ED3rvQ51+43oNDjvL/X6B90HMORe0shltl/HsZan9JFm7PoaRk77g?=
 =?iso-8859-1?Q?6LYIDJucFjFHmNblRMU8k25URsHe6lF5WJwCieRCe73rhwew1Tg/t0vjR2?=
 =?iso-8859-1?Q?Jr08CjI1MpdXyqqsDGqXiMBo0xPEjJh36ZE50i0eXoASWyXFAyidcnHqVW?=
 =?iso-8859-1?Q?+THUxurTdVxf/FB5ewVG6BkQO5o55NrT2UoIpdYuFhCS9kaSJWJIueHiIX?=
 =?iso-8859-1?Q?50xfonjwPF?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0088fa-563b-4741-e72f-08d9879fd976
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:08.7626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5YF6vBsDBx9Xi7wyx73ErCNL5K3v/OZkfJ/+qXyOT834uremitmCi+REAEbHtTQiIIUMTjjxAYJaE6dTVTcoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: e-H_qXuneRnpKD6uV4m_xYdNxy_KgvDb
X-Proofpoint-ORIG-GUID: e-H_qXuneRnpKD6uV4m_xYdNxy_KgvDb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/oom_kill.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 831340e7ad8b..e0334667d36a 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -516,6 +516,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret =3D true;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
@@ -525,7 +526,8 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
=20
-	for (vma =3D mm->mmap ; vma; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!can_madv_lru_vma(vma))
 			continue;
=20
@@ -557,6 +559,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 			tlb_finish_mmu(&tlb);
 		}
 	}
+	rcu_read_unlock();
=20
 	return ret;
 }
--=20
2.30.2
