Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C13421BF8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhJEBek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:34:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:54514 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231708AbhJEBdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:41 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195017pZ004524;
        Tue, 5 Oct 2021 01:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AKAQ4/XSRXKFOqdKGDnoM8c/CAh3erBlNPjdXLIdJ7g=;
 b=dv57V4w8t0vAkJTznNFsqkhAfuL0n9tZ6PSE4vdCKk1NyQ4f50yrdxhXgjYYtIbFmrGA
 aWRoNyQfC7q6arKRXr+EF1ctJsCaE0aJwCGSnV/vPVXBhyt5bQ/xa04Uz8mz+de/cCE/
 peL4kkKZchsqBOkXEArYZrbHhC7d4NL9w1jeR2wAWzUTYBXzGewHiDrBIeFqPcAnYuft
 7knkMxbXa1jnYhk6TmXTJaMx660RXebBwWzyxm6OSwp6SH8Fu7hghQOz2HDRgdjHfyPL
 6PTtRzLRPEl97QG1SrbsDJesW0VGMoxKGaoF2/Gz2TFNLCaP5rDWjKBo3RmijimuQ/Cz kw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UHTU178361;
        Tue, 5 Oct 2021 01:31:32 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3bev8w0386-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSeEVwJ3l+x8sW/qfUWXkWMjJO6/Q8IDjErCDh7C9aGxVTRxR56lmK4nYjWOhV2ggQkPV2ONn9mlDAB/M/hOmZc8QJcCJaAAg6IP4NfH7dPSbfxJLW5CZzbBb1oGotTKzcIFBLCItiRy539+DnuTdedvHBCl4ypUK2V4BxPtTO1f2Xtxai69k/7VwlhXe/WR5V8MzbZJL2D3O5l8wZNM8lOjz4Oyxh5g1ONyK2xCW1Myr5p2O+EypfkNX8khh9uQhx3PAXAUSXpgzwv/BKIfA1OjayHl3MIUyeTZKOAuyLqJ+dpe0OuTtZkUo8PsO4K1u2mOiI+Sw2ICdqfx3LlIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKAQ4/XSRXKFOqdKGDnoM8c/CAh3erBlNPjdXLIdJ7g=;
 b=hYRHM3CpJw1Pkq4H92JMtnIugz5VWU7lWkzmFM7tDQCx6E8mA3upL0m3tQ0w3oWomkJ9avwvNXHB/4dzNqBy4uOeYelIfWfj42XGLU/rLZZpJlZhDwM3qiwpue/lMIuz9YDsLJOsqRPoieZg5msjAg2MkpF56I/0ksOjQMn9ytwdgO8m3NTUtvHUcvzUuHB/nXm07tcUR0PZjKKmai4Z1JbHXK9M4vN5tJTUtHrWSAFEJ7ctoGbjg9Qr3BrK/RQI3dX+spFtR2Xs0b9ck6TYhcCDnrB2MAlOWB8LAP3naO7Bpth1aR3KhrbFFHa5yJFt9jUgu9/kxjtS4ykNHJX5Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKAQ4/XSRXKFOqdKGDnoM8c/CAh3erBlNPjdXLIdJ7g=;
 b=GyDls2z97OjcqafFpFaM83Fc0zfwl0vPACzsXAtJ8toP6YM1YLXX1qRwE+SQ09uRuHdpj9maxtefPMM8sUl2bulztOhiZgXjIRJYt0fcps2AlHpP7CtmJvs3dXFmatyRLNCJhZDXVxXCqfplJbuGYL7Lhktypvx0DRLLyBizxEY=
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
Subject: [PATCH v3 55/66] mm/mprotect: Use maple tree navigation instead of
 vma linked list
Thread-Topic: [PATCH v3 55/66] mm/mprotect: Use maple tree navigation instead
 of vma linked list
Thread-Index: AQHXuYirJodudDComkK/EEk+mSv6sg==
Date:   Tue, 5 Oct 2021 01:31:07 +0000
Message-ID: <20211005012959.1110504-56-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 8e4e8c59-936f-4f26-4516-08d9879fd910
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044C9D3A163831FD19AA5A4FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T6Zw6KszotYXhXrZ9ypnBLuyq3DdyoboJaHIUHuqvVo9qYqxGpQ1XsDgPyIpqmCT+ua1ijefy7WPXRJn/mp/7n4GQgpcWxRkn3yRjEdVR0A8CNCkMVgioeG0kYDX6ZB0sCCjmp6uTWrhr27ig8B+L12Wq399sN6rqRiXMkQORytjiYwq0Jsxuu3alIZZ9aZ7Awr+3nwHjtB6RbTqmSvOeTwE1xQhwTwRl5TV9mmDUWbPqepnMoAjHeLem99kICuoUPfmvX+6q7C/DuSJw0pq2YV+s2qA2FKVk1tdhz2rtMvNFeSRkRqOYl5dJaVBwDVZq9A8PIB5kL4sK6tznR83RzCcOMLd4x6InTRCCNLMuw2J/hHBuHZ8irSXT3hLn5eFxxITkK8yhQ8ZgTUsR6GwyXHxk2jKjf2iEDK9whzgTwT6KA8fkPHcDRzZ+0P+zwt7oFMN8zCOfbNlJ1K6j7l8sFzr/V5QWr5oIcSl4fybom0vhy2XRt+KTjB87gFvZy2Vco4LjjRmHsEQLm7m89TLeTtjWI3Z1uDGdapfmUyFT4y7O88qG724NANll5Ex6rUZBOv/VR/dyoTHeQLsDW7T1czDC5c84XrvRSUH5muqhAXdjQso5otqGWStFvKq9Ch2WAEcj+xJ27rtElWhZ9zwsCkd6c17X86cNhnr64zgv6YFoWBPyZQerzwx4wjy7X8GftWrd0BN0wmVQEfipPkB2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?idxibUH4TwydZ97LGC9FnWgvjpPJLBd7Az2rfxf3nZG8BQmu5qzLQXTi4G?=
 =?iso-8859-1?Q?V3KCXzGxuOF1Bz8NjvbmPiPLvMloJYLRwGHpCi2rDKxIVPJweV+MGZrEgu?=
 =?iso-8859-1?Q?u61fEEJBQBQ24lZasIjqkJzCagtyPbCr2j1HtyKqPZZM+aru+fAxPHfbli?=
 =?iso-8859-1?Q?l+fL8NpKQKerKdgyZeEE7429ixbu5T73zzxn479AuzCQQILwhyHZX24oYs?=
 =?iso-8859-1?Q?24rTf4WtvZ6RBqbkqUPxH3M1Yx90F40WqhJyWzVldmwJCg2McR4RxX7pVr?=
 =?iso-8859-1?Q?Czk0FMbTS5q3AfWHWp61ztztuamVY2zfXnxF9Is7VYq7aA7XD6DE/kzKNg?=
 =?iso-8859-1?Q?bJNK0k8aUQlBVbg34xvEIgN5resjiUAe+2WQukMhbiD8pqBpiBVvJ4D9If?=
 =?iso-8859-1?Q?WQ/+srQj34o6iCNTMhs169bmPSiZ4Tb9R6dCuOCgl1w9CkSblltjDascxh?=
 =?iso-8859-1?Q?WBcGAnr8bNumu4XOciU5dgIoL3n3SRPdQ/olxexsqL5Cum+OxT9dWQZBsA?=
 =?iso-8859-1?Q?/2MeYwQYsHQndkQvqVA3ZoM/V4stxGzc6h1xkGIqKYCWY6oFgyQqkegZha?=
 =?iso-8859-1?Q?7awov7PXSA/lX05Z6pow5n+T+ZTd0Nsv4ieqtsoe+eq9k9KWYfS2yRHgCQ?=
 =?iso-8859-1?Q?1BspwyHlk73rSmTJILHiwIsV5Y9r9wTEWeNzg/+VQvfEFY6mzPAwcDajI0?=
 =?iso-8859-1?Q?e2nOZ1n5HsM/qxBPlL+M9oVWMp4RQrePLouM+bVFxLRM/pSsDe4jVMmDo2?=
 =?iso-8859-1?Q?hXYq65rXKyh6GC2oB6+SII8P7V7b+IqxIiBvU3Blx6SFF6NTtQvKj2dxf8?=
 =?iso-8859-1?Q?5wv6psfH79cNeQtPr4Pn42e9cyA1TLloRnQ3Sn1WhZzcWNJxntUFPQBuUS?=
 =?iso-8859-1?Q?KacGKAY5HJvHXCN6ftVU2pM5rb8A01R2DkyCS8JmhT9dMagOB9o5DsgISQ?=
 =?iso-8859-1?Q?2Wk/qzLCr9h2/l/NH8NxKUA+yv16iBKFbo9kSfvBkLeKbRu3nyFNDpxGeu?=
 =?iso-8859-1?Q?xF6ZBUPxNBEpH5vLRVYvNrdjTIjRnL5a5pBksAc6EWEVv/P6oj9jxoHap/?=
 =?iso-8859-1?Q?yfD9ITsrIF7W9rgVJ/ZFVhu3yyaneYQguJE3z2as5RC6WHIsVLYxl56HtJ?=
 =?iso-8859-1?Q?UYaVU1aRVf5KNdlU8WnuMtRhWf4XbSkz5HMgbZ+6vfj5ymcP8FtRbxkP/C?=
 =?iso-8859-1?Q?TbXmCFVEpIbxKiworGcW8aq515kEYVge8nHzlQFKzZHNE9vu1IZj2m2zLn?=
 =?iso-8859-1?Q?0MDL4Za8MQF8NStca7pcpROqCftn2Bu1lSDx9zZXJxeJVv2exOGnf2dH2g?=
 =?iso-8859-1?Q?rMp9E+lMIpAAds99sn2o0NA/Cby799HRZ44VJL4NAYYpELmQrS+NA0XgGv?=
 =?iso-8859-1?Q?BIp9ljvh0i?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4e8c59-936f-4f26-4516-08d9879fd910
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:07.3204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hEPlSaQXLxr5cxg9xy9i/XT9R14jB3WdPBve3eOFCrjw8nSbXzy64pzzmKecArpVZSez66+vEOpLfdt7sPk5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: o5RUM0SQ18X0CP_T5dc0yoG6SbDRyNgC
X-Proofpoint-ORIG-GUID: o5RUM0SQ18X0CP_T5dc0yoG6SbDRyNgC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mprotect.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 883e2cc85cad..a4041d2c0dfb 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -528,6 +528,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const int grows =3D prot & (PROT_GROWSDOWN|PROT_GROWSUP);
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	start =3D untagged_addr(start);
=20
@@ -559,11 +560,15 @@ static int do_mprotect_pkey(unsigned long start, size=
_t len,
 	if ((pkey !=3D -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
=20
-	vma =3D find_vma(current->mm, start);
+	rcu_read_lock();
+	vma =3D mas_find(&mas, ULONG_MAX);
 	error =3D -ENOMEM;
-	if (!vma)
+	if (!vma) {
+		rcu_read_unlock();
 		goto out;
-	prev =3D vma->vm_prev;
+	}
+	prev =3D mas_prev(&mas, 0);
+	rcu_read_unlock();
 	if (unlikely(grows & PROT_GROWSDOWN)) {
 		if (vma->vm_start >=3D end)
 			goto out;
@@ -644,7 +649,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 		if (nstart >=3D end)
 			goto out;
=20
-		vma =3D prev->vm_next;
+		vma =3D vma_next(current->mm, prev);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			goto out;
--=20
2.30.2
