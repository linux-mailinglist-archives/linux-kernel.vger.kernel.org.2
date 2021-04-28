Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A610D36DC07
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240751AbhD1PlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:41:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38772 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240380AbhD1Pi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:27 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMAmE031068;
        Wed, 28 Apr 2021 15:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/JdRh0UFvcxV6k/VO8y3tZs6clVGtwZffBRWHpkAGYg=;
 b=zQSLOLoUfRZSDywLMwR6mWjpezUotouxa/Oa86glAuBOzCgQD+dhGWWYTrWKENRQ7zwr
 RshohIRxInDNDor5D4SYpGMhqg6D6vMC9fGqRJG1m3mZEOr3oSow9ISMgfTOiQAGYfLw
 AdtXrmYPE5Uo7EhIpKC0QEAZfvK8UK26R8+9nBlZwu7HFL2lPX+TYEvtlrtrtcR+yB8H
 cj5g54eFS2MtjYhy7cz8PJwq4IPcPs18GswbTCfcCvXetKEUIOyjp/bxil0wGGzpSYwS
 B+1eBCUsHcjj4nOL5adyzWVnzD+TEuE5gbd9ku/rSrAwJwIPT/wgU7ZHymv/a53dJuxy 1g== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3874kn0eqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:25 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWZKP146776;
        Wed, 28 Apr 2021 15:37:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3030.oracle.com with ESMTP id 3848eyqygy-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsFXhbWuacfBv+qBzTrNsT3pCSYuIlPBoMJ8wB7CJPQkVK3YwDhJ9GOybo8uBdOE94/mp6T1iCrpV7fQ6w3pJUh0sLI2UyAO6ixiYZgDunpWhMrvTRuP+IjDUi957GhL9AeevLDLr92k3U1quYnwqT3zmnqfiRM3kY9nGozr1Fg1E0ApM5QSUb/waWvE+2DlgRTHD2refZqkhKUhopBy6xrlWX4fmBjD8rh4+Tx0wug6RgmB37fPeotMddT28pfCsiRXGydeXvxDD2mMY4+nJ/quo/s4O8qaMw66BOK1tAh3SI4f6PDlBtFSXcASf91gby6k0RfmK1P/acPHSivDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JdRh0UFvcxV6k/VO8y3tZs6clVGtwZffBRWHpkAGYg=;
 b=Mhn2CEvb0iyWRCr0Q5PjD121or+pOKJi/nKQOj+sZwGTCIuM+vAlMaIN7jhaApivAlALrARRbqE93BJOsjLprFUbjjiKwbYPA81ycBQHRuxOBE1eL0RQBcCB89O2AFYUvpMNDL7KxwzOLB1vcFXsNaqs/NFidKe9EOEK4z5MFSYQpV7QLP49dX4X220sZEeAIDzw7kjT35wS54wNKcSo23qMwXbjsOwzqyk+JjkUDbe6NC8vUz9H2MhkXlP6N3YpkHQrFKNVnIr73T5C0AaiFwUTW6XqzL+pvxm7/i79wEDb1eYByNbcKcVnQzVjnEp+RGvMZ1R54nnwhF9vzM0fOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JdRh0UFvcxV6k/VO8y3tZs6clVGtwZffBRWHpkAGYg=;
 b=dqSYd86p0G6dmaY+PcRaF3crbcwwxHRYJWqNN4WPriRCZxGguh09hCtO6NjuQc09z1B9GxufUm0OLKlBqg++pCpsQfF10AiRhxv02/vUK5l/k1BXfu61zkGwhs8TJBcd5aptsb0YjzCzPJqAmdF4At2mrE+006ypDNVizSt6muw=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1871.namprd10.prod.outlook.com (2603:10b6:300:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 15:37:20 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:20 +0000
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
Subject: [PATCH 64/94] fs/exec: Use vma_next() instead of linked list
Thread-Topic: [PATCH 64/94] fs/exec: Use vma_next() instead of linked list
Thread-Index: AQHXPEQ8GnAqy9GCh0i/IlcLZa35mw==
Date:   Wed, 28 Apr 2021 15:36:19 +0000
Message-ID: <20210428153542.2814175-65-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 1a4ad258-e96f-47e1-2b70-08d90a5b8302
x-ms-traffictypediagnostic: MWHPR10MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB187107352DE4552947B7210DFD409@MWHPR10MB1871.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sHlm7VxNrx+UOUL55xpVcDkRH0Vls0xV6z13e99gP79PnNqQwneOGLu7P0OfI5C/wv455Ntt/fiSssODLmO5J9Jl0VppOoVSeg2YwtLHqkhidlxdvqjVffbck6HcNVbkaxd3R5N1pZLm5X6LnErqyw55uGuMifmcuQ5Jbt1HLn8kNZQlC/0o5nGl2Ktu/gpG6lpAmRlBoNKtgH/1nUxUwu0iuFmlpYyN5CL079rOuywXFqYN8ETCmUAf7GSGbsemtU9Td1KB30P/vARBamYysKXpYSBQQfid53YprSrTX5SiRcOtDyBgF+wMfgpTXWvr55Fa4cYgMBbzpxyg4UHTwKbfuYHpfXFIvyab6P5YLYQuYMZc7RbqvWNMr8+8kBifXViKKHZJb8UD0maeIzBXEyNCsMr72fPqoAtJbIaSeZ/bRy0+H6uPe/PIl3SRu+8N3rq49SaPbJBRFcJTQiUglOkeKEXwpdU/vH1gzA87EiQCXE8/+0GD3s/3tGIdynYkiCmHMNreYPPCx5oulsYyMUUOB3yAhDQwFG9Y4QOOVTWACOPPpWYYp1FCmjp+MunYxzlBlucqAVks6omYiw9nLg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(86362001)(186003)(6512007)(66446008)(6486002)(66476007)(316002)(107886003)(5660300002)(66556008)(71200400001)(110136005)(54906003)(478600001)(44832011)(76116006)(6506007)(36756003)(7416002)(26005)(2616005)(8936002)(1076003)(122000001)(38100700002)(83380400001)(8676002)(66946007)(91956017)(4326008)(2906002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Xx2//mghXnB5ooLYA0AdLPAK5zxi44/4az6jZBvqtHY2UUwRuM84kcme1a?=
 =?iso-8859-1?Q?ApCAp8MUow7Y42hsiKO2lE4pZj3RUvgNV9TKREWzs6LauNGQrv7AziAaGI?=
 =?iso-8859-1?Q?MGqHfgUI8IIhXTMRZoLh+iEx4fZ+jsytXRsdm0tdr0ObmPfdB+bqYrZIBe?=
 =?iso-8859-1?Q?wQwy8R1EQF4jAy1rB6N59t9POdEqpu7StRLRs0575iCWbS4Rhs8RSUfxJp?=
 =?iso-8859-1?Q?g/FX6kg+YP62Gj1XHmAGy5pKYhl6HRpWmzz/1iuqo1TnpIPx12IvPp7JEh?=
 =?iso-8859-1?Q?haOibgjTM0+EahBxjjH6YfTa0rZKn+uYWkErgZ+mIobNPPVww8DNo0+HsE?=
 =?iso-8859-1?Q?9ujaRYcOqsvmugbOtJzKpuhTHEoDJx5JySjDGl1OHh0ctmD+2QNbmqnoOc?=
 =?iso-8859-1?Q?4P/pHLxTqg6CgDdcJCuJfxKcV9jwOVMimyqrfb3BZvw9CVHwZEfh0AjlES?=
 =?iso-8859-1?Q?2RCOvgyu//QAJfF4qOoeaoHsg7dWeDGS1JvMl40zIb9s5N4mhCMq5UHxkT?=
 =?iso-8859-1?Q?Sh5fnaTrs0EpopOWqfDwrYRNN9YSfX3ax4qk0FQelAjmcznYigyAeTRi7Q?=
 =?iso-8859-1?Q?3QzRNWa/BKah6XkzBDmeMHF+SgkIx2XxZ5hZQvfBU3XUq2w/AmVqPWFExv?=
 =?iso-8859-1?Q?Ft/vefevXEu8CqPsWo9pF59Go8JahNk/c+8zh2urKzCJ55G7I1UK2AH940?=
 =?iso-8859-1?Q?jR2AXYecPOwP5DqMgZ8X/o8R2Lp8dWKJzNvUREa7eWb+GzgInaZIv6pmPT?=
 =?iso-8859-1?Q?U9xtlnkFPGVwByegcUnHIJ/NGQGMSC5A+6m0nHzSjXqFLjtziHaERL0Dje?=
 =?iso-8859-1?Q?3IF93YSV8ATdrQ7WQY0weXhjuEmViaB4wDn5Q/IGKwX3tqVLMWTbTgBZIv?=
 =?iso-8859-1?Q?a0TDVqoGGjv0rgX1NoTa7fIYy4bnCjmbVcL3vm5rC0faDHWzmdHU+LPOMF?=
 =?iso-8859-1?Q?uVoTwCTcJUz/A+Kuj1ven0KyUfkyuw0HzMI7TV31uk3zazRmEHTsKchYhl?=
 =?iso-8859-1?Q?H7IfNRwD7pPwSXQoVPH+Pme0gjC7es8ZbuWMig8QIgk5tn2OBi9xHuKLFv?=
 =?iso-8859-1?Q?QSBHWNEEuI6vQRreJya1BuDFH2/81Iipen9s3ZHMvppQuazl8Cda7Ij4p8?=
 =?iso-8859-1?Q?d21Aco6IKJIaGGrSAzbGL0ZxfqxURVd5jMiMeQJ8IMm7jp1C7596A0Idfm?=
 =?iso-8859-1?Q?/s4b3cavMuHe3fxTVsC3vQFZiNo3dzZGyeRlcguDPazGYm+ed4V3FxJ8gG?=
 =?iso-8859-1?Q?jBmtkavDiCoTiQR1QxR00/AzPwbHWeyZxypsgTjv5n6TQ1WMn+eQdJUlGr?=
 =?iso-8859-1?Q?H7edOk8539wmgYggaYJcRZngtUbRu/0LNZltdHTMTEyfX0CeteaMURgPXq?=
 =?iso-8859-1?Q?ObMFEqv4DA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4ad258-e96f-47e1-2b70-08d90a5b8302
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:19.8733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ut/IomxpKvpcf+mMC4XnT/+fX2D6sO8S5SDcC6dIUtKOi3lvtorxAXLWQpQTcW+Y9DO/eFi1MIAPwosmIIaD/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1871
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: Dh4-W0oCclVyxyQn5Uz1POMq1usZDhZn
X-Proofpoint-ORIG-GUID: Dh4-W0oCclVyxyQn5Uz1POMq1usZDhZn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/exec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 3d3f7d46137c..3c9dae291b94 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -681,6 +681,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	unsigned long length =3D old_end - old_start;
 	unsigned long new_start =3D old_start - shift;
 	unsigned long new_end =3D old_end - shift;
+	struct vm_area_struct *next;
 	struct mmu_gather tlb;
=20
 	BUG_ON(new_start > new_end);
@@ -708,12 +709,13 @@ static int shift_arg_pages(struct vm_area_struct *vma=
, unsigned long shift)
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
+	next =3D vma_next(mm, vma);
 	if (new_end > old_start) {
 		/*
 		 * when the old and new regions overlap clear from new_end.
 		 */
 		free_pgd_range(&tlb, new_end, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	} else {
 		/*
 		 * otherwise, clean from old_start; this is done to not touch
@@ -722,7 +724,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 		 * for the others its just a little faster.
 		 */
 		free_pgd_range(&tlb, old_start, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	}
 	tlb_finish_mmu(&tlb);
=20
--=20
2.30.2
