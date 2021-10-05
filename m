Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C046421BEE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhJEBeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:34:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20388 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231311AbhJEBdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:33 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951E6lP023902;
        Tue, 5 Oct 2021 01:31:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mRf1ckOpT5rniYOmHdL447aeME5rQ6SgAzzr/lJ524k=;
 b=ISm9c5OQLsiFqXCHGO5bH6k4aOMOc2G+Zz00W05u3ND3LonN0RsrYM3eYfP6EzOc8n8B
 yfKJy2NE6wFdOahANCI7L1TYvF+iOCcTNU6DWwMB5NCQgOIgyJh12MDEj8FNEHAhnPuY
 /7osUB42Sv6pg1YcqHHhj45gO877sqH3Bz8zZEq9CXc5amWQKTKjUPdMyuBI0fyaUE+e
 dLN1U00n5BcG4uiEIh/u0YJ0oq8GVnDzFF+anJGdrAVGWzYR+ZZOspl+ejLXxFeoI99f
 2PtueBQcHZ+DtL4W4aXe7qjPsm5PGnu4DXNI0wExSL6qGBa+rlZywoMMM4NcAyQ8Nrpd wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43gkph1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951Tu3p056799;
        Tue, 5 Oct 2021 01:31:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3bev7sgru8-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N79eecns7PmCkHExWZF9qKd9JUaJlhX8sPnOvuyMoKiJVEGc1ANpvtyoG26E1OwCoAmmcN9yrNRVLsQxRjEAJcjDX5OyuRaSDbSUcwYqj1PqJl/70FmM4mi3JoEJgSYzOXwyC35m0lWC/EsFYMvlk6ZIAadM/hqW1ZohkPEhNKPmgENGAgRY2bB0NJbo+bPlfU9iZp6wfDc2ZMSyByBAqBuO+yPWqFZF4ZB/kTOHw9XbJAzuBeR/ULNaUgl8rG1wQsCKcOgcqnuGOCQoriuEmLc0LfsyxxlDoqBlZXKCThninSLENcQLh71tABsWwAkniuf0XazEtBiREu20NecoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRf1ckOpT5rniYOmHdL447aeME5rQ6SgAzzr/lJ524k=;
 b=mNvJkh5cerrYoFu1bU3PFCvRfQZMK7CA9uLiUh4ONhnRwyl1GPa2pNw/L0LuR/wqKAqVTNumVdVPdGulVU3KhLcorOzOpyys8jaCHyOd4VmFwLtdDhzhHRthXx+rDuhY9x644C4Tl9kAMK2F+IAppHyAm1azBQ4ILEzLLHBkwBBm9Muz4/rhudfXNMrtS+yMYPtk2ueHsfbfNQzuH0SK4PNeHfKq5/bSqNtAS5F58F92/bQljLNmrg3UEmEz1K2IUH9oYqexTV3D4AzsXGpdepz5URu+UatSI7ED4aMpQzGj52c3GcZ7t30IIgM9tR2sxhbDKypa69baNsaC1mCT0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRf1ckOpT5rniYOmHdL447aeME5rQ6SgAzzr/lJ524k=;
 b=xxadge3B5x43BeA+rV2q1qNHEK/blmOBBuDrD6uxFyUBxG533aes1pyRyULDgmwpXbByuTYLkHSgOArGHBkY9QKrlWN0M5Jk1Q3kiXsZZ4D69C23P3n8kI/onKY+OWQMsTnDePeqlwWCYerH03jqBnMk6o1oolbPCD7LgnZLNgI=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:21 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:21 +0000
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
Subject: [PATCH v3 37/66] fs/proc/base: Use maple tree iterators in place of
 linked list
Thread-Topic: [PATCH v3 37/66] fs/proc/base: Use maple tree iterators in place
 of linked list
Thread-Index: AQHXuYiiuTjjRFCKnEe5EGAQ/+Goqw==
Date:   Tue, 5 Oct 2021 01:30:52 +0000
Message-ID: <20211005012959.1110504-38-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 77415a77-3edd-4cd3-7ed1-08d9879fd68b
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044F8109F4AC66B3474EF77FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IL26YByfmIE0nZnMMj2KbP1Cwb7t7SOseyMQbwLHoNIveuWmht/CIZv0eYpfZkGUxC4VX46IMs1tvNv0HcQ+NQxMN4lbmOh7Csr+ZsBZA265iaK2q0uHpB/awFIHy+RN/yggFg1ijtvCjkyOlP7BButtxIih923hRT8br1tyUt9fhXXZRXwt9eRfnrBv+BPiPzIVjUBZp97W5+t91Hk+CcY4elwAdCc3HSQw2daLQMZeyVsCnmr85+mL+6Csa88c0ZpM3Q3ak6K+cTgVkAVAD8f3Nm6xA4UVFInqGmskVBv4fLh2UxBw3Ue53Vm2NFOFH3U7idCaixgWz7rBEWYimx6DSSJ0/H9gUflRBOFvcGRRpeGESt9Gmdk1CLF6x6t4JS0jBQOunie44XcFwv9zWvImkdN9TWpOaSe6Pq0rriAPpdOTNEyTQdeBR5Shq4+BOyYYGj36fYqhFlRl3kgk3EZ1u801J1LTRgr5HHqCu+ziApUodWIaRywX7J1Cq+5zN4k5yL4nnAduoFmzPcb4GMqGj5UH5hE6mcR+CbHGQ1xLw72xB6d3PfeaYIeyP0CtnYGScU+cjwCCtQE4CvFEkPIHRJc2XFt33yLi5y8BbcZTV2SrXl1wQDlLL03p7m/Zy1thAYvaPrcvgVjv7RCv/fSzfxoguy3VNRb64eUh+Kll3RDL7bVyFfYkXOj1hetNTQk/8cD/MGWMxPR4Fr0JiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PEzTGJWCDxQtIsTvYUvu1wXcCc+/LY0aanBBfSGfNBBX+geHWS4iwSSHeI?=
 =?iso-8859-1?Q?VD8clizY4UhRG3+vbveZsC/V63D2MXoZK/wH1ZPX3cCr0TOj6zhuFTpE6E?=
 =?iso-8859-1?Q?We2k5jMvcYeaOcy6nHFln78nb7wrQvV7BPI5V2Daa6yrWtCLNbT88zWkQ6?=
 =?iso-8859-1?Q?98sEDau3pMmaKnJq76pYBNZIVncAwjyK1SymgCBbXQz7wDf3OlV4VQ4lXA?=
 =?iso-8859-1?Q?svaNPoRDlsXV44wc5lHf2vXmIhUJUT1nHnL332qDd8UgDpx+35SlL7al4T?=
 =?iso-8859-1?Q?q4iOcB40+QMxwTu0DmEcWUljL/FBpJLTGz7tKQF5IBipN9y310OP6G8GYt?=
 =?iso-8859-1?Q?gVBZLhGbgi/coS5mUqqKRJxQTkJnH2O2Ea+twWgDFRcXu7Ad3N30YZtnl3?=
 =?iso-8859-1?Q?fBLaVbu5EhP3POCGB1i1hxrrEut4DzihE36PlO0Qo4DQgM5FLJriaBgQiw?=
 =?iso-8859-1?Q?S2vhzaWTijhclVF1UX2sQUyvyk9pp2rcFgswfOsigqah+a3yLEtVD7mECM?=
 =?iso-8859-1?Q?Yh6rUD6f90iRDIL65wuOmAHBKNCa/y/jNyyXfP+285OtEWIfrf4WGsgzcD?=
 =?iso-8859-1?Q?hz+wkqhIQ7QojZtuq17P2GYvePNhdy0Nchl6DMRLT7JH4tTPgqgHrG0OMP?=
 =?iso-8859-1?Q?R8RwBLPDzqIfi8KYGoPU6wyj4w953zeFAZwbFlAYRpUbIbsxAZ8HTM+6/4?=
 =?iso-8859-1?Q?NF5iXwYviGJnUlUEiBv9GT2Z/W4x3c5TjcD9cMoArwJKQmM1Dj5ooX98Vl?=
 =?iso-8859-1?Q?S6pUOI3ENP2sd4bo8UcG1eK241duZbTsfdO3iYI3dVLGuzyo1UbW4NmGby?=
 =?iso-8859-1?Q?RW6eOlHssWeb6eFSEwMkQA0n/XjFjGqmBGMvtSA3ukql387Mb5gcA2eXof?=
 =?iso-8859-1?Q?zpbhs017j3AXSkMuNDVRcYJ1IALhGT9I1q2vT88tIUgX7M8qn3qZAJCqxD?=
 =?iso-8859-1?Q?wCfNnZF02KgjoPHuLvxLqFvjI1LeSONQhMuLAcjWjQSy7ZT2qKL3vkHoT0?=
 =?iso-8859-1?Q?d3XfA7MW9Cpo4Wkc0r2jkWqM6yjUSt7hBhBFv5YOpYlwVkGLrBirKtSs1g?=
 =?iso-8859-1?Q?7O+fSi90LQl5hLMKDvDQKMj9uq4pPu/CSSeIOKmGwS74mkNaS37dSQJiIG?=
 =?iso-8859-1?Q?LqTSX6UNPgLnh/OqCWVDjHXbO+/eMfamAXjzMUSItV4/uF5YawrOs/8q5e?=
 =?iso-8859-1?Q?ZKpPMzH4aZhZs9lOBOQ7qsFSdJFxJCkKIFGorVtNSxggcj1ladzPDFWBMj?=
 =?iso-8859-1?Q?aebq6HCxzB75R44B/ejRjgpHePMe+R47UhfE7zUR9RUbfaoiyJDdqcP8iz?=
 =?iso-8859-1?Q?A8TQ/IaEwTsNcLpUYq/5/kBdT9F/4fSKheUsZXgUSgdE0cghrZiSu2qNM0?=
 =?iso-8859-1?Q?qy7nenDy6f?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77415a77-3edd-4cd3-7ed1-08d9879fd68b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:52.7117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: saV9e/uzkgSGFw7dFAgTEk2cu/1BbamFV2H39lZg0Y0lBjlslkOngHJHFxPLS+cK2CuZHlrOoHDyJA9LtAGqxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: 7SrtQ3qP1dpO6nG_r2LIgtZoXdcfFjw0
X-Proofpoint-ORIG-GUID: 7SrtQ3qP1dpO6nG_r2LIgtZoXdcfFjw0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/base.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 533d5836eb9a..4f7e7c8abfd8 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2318,6 +2318,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	genradix_init(&fa);
=20
@@ -2343,8 +2344,10 @@ proc_map_files_readdir(struct file *file, struct dir=
_context *ctx)
 		mmput(mm);
 		goto out_put_task;
 	}
+	rcu_read_lock();
=20
 	nr_files =3D 0;
+	mas.tree =3D &mm->mm_mt;
=20
 	/*
 	 * We need two passes here:
@@ -2356,7 +2359,8 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	 * routine might require mmap_lock taken in might_fault().
 	 */
=20
-	for (vma =3D mm->mmap, pos =3D 2; vma; vma =3D vma->vm_next) {
+	pos =3D 2;
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma->vm_file)
 			continue;
 		if (++pos <=3D ctx->pos)
@@ -2374,6 +2378,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 		p->end =3D vma->vm_end;
 		p->mode =3D vma->vm_file->f_mode;
 	}
+	rcu_read_unlock();
 	mmap_read_unlock(mm);
 	mmput(mm);
=20
--=20
2.30.2
