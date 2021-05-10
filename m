Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435133794CB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbhEJRBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:01:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41380 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbhEJRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGuAmU087805;
        Mon, 10 May 2021 16:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=zYgBMaN/7IcU/vwKBJ4b/uog7K7SQ87RGtmdUM3La7o=;
 b=unHMNMeJHVme8jXDjYKHyw6uOJcK83wDMjkhMMF+K3TMnMI3p1DG5xUWcq2WFYWweqpg
 j2CT5+nLCJ6+b4p1ZFwI6Oejg4js/1tsqd2yoUv0LiFrY0cH32C6JdvjozydCeu9WIQ5
 roFvqO9avuSaKESVPhFXUNkoQDc4QZV0qhtclhvVSmbnS4fr6V4HyWUyp2EmE35+XQ2l
 3l7pWXAKe/BhlnN0wjzcKoeSBwZTvPjPbPj0yuYh1dCRNun3H6+eL3/CNTsQ4VNYSa1s
 Oh4vwIB8bCiY/YVs7hyfBMrvue26WSNzu0ANsi/inN0OHoJBRofchUDzHwDr3Rnd4Y6j dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 38djkmbxh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGtx3X001777;
        Mon, 10 May 2021 16:59:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by userp3020.oracle.com with ESMTP id 38e4dskqwm-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5TA/wsUHzn8Xpzb53dSbT6Lw92f79hBDHuCgusc+uR7qKTB24YO9iRAgWnR1A8s0bjMqJTts12dZKPI/NlMKvxIBOi3FnVd51MYkHyreJE8At2OpXAT95Go0m96mls/xyElJw6wWFxWj16ERsEPa4JhMGwzBN2k1nniok0Z8qL0tR3V1fwh6Z28nwUdE1zeC7qg/yEXUU3lM7W1BbrXdzDM3yye4I2Oe6BNw1rSVUCqcd/NAU/ODvvLL6h0aucRbEG9h/gqFWizLrxsiQxpBjRmEnANkYo8EhjylwI2j1UHJMuD9rU11YlAeZ22T7nVyr7UYcIIpiQHahjk9DKzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYgBMaN/7IcU/vwKBJ4b/uog7K7SQ87RGtmdUM3La7o=;
 b=J0Nq81sHAT7+uHlpOjLkIF9bsWk9hda8B6P6Xt+ZI8o99Xb72dwSbVBm8gfafcZAQz7LsH/TZtWUP4PVqmYPlTvjzsXl3PhodpYZB+c6/k72U/erytYK825gqaYoQXfJww0Liw4370WiBsblCl10HN43WpWIiRwPBExnsVi8QBFZhtb6eDImYc1pyfCQyV/1Xqylb9b58MoNpYCRqRRaMvAAlEKkIkzo3c/vAAFaeKLWP0iX46tRMm/nWxEmVrfzWu7CRgZY/lgdIaRhltr31Iq6Q0QHmsl3wPOvuDl1R297JaNt4z0meIdxR7rTjkPzo6wpNGLIVqiMVbUydcN9jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYgBMaN/7IcU/vwKBJ4b/uog7K7SQ87RGtmdUM3La7o=;
 b=yyQTDHJFld2R7F4mgv00eqicWrcSSBNSFvOC+yzSLKqsO6hV9Qk452TygGFCp5UweTzLW3d8mcBvvp9/3tgDjepfRtClAdJDbRNT6lYHhBM3S46ZWDGU5K0+lfTr0MkOHlgVZsjVq3K8v660jaQ6m8t5pQx+rHxn+CmC7geFpCU=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1437.namprd10.prod.outlook.com (2603:10b6:300:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 16:58:59 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:59 +0000
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
        Michel Lespinasse <michel@lespinasse.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 21/22] mm/memory.c: Use vma_lookup() in __access_remote_vm()
Thread-Topic: [PATCH 21/22] mm/memory.c: Use vma_lookup() in
 __access_remote_vm()
Thread-Index: AQHXRb3FmA6JsZrK70u9LfF8sV3q5Q==
Date:   Mon, 10 May 2021 16:58:59 +0000
Message-ID: <20210510165839.2692974-22-Liam.Howlett@Oracle.com>
References: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 9f40e653-a33e-4178-e7a2-08d913d4e7b8
x-ms-traffictypediagnostic: MWHPR10MB1437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB143704E8108CF609F80BED36FD549@MWHPR10MB1437.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6cduA63pSn9972Lcra/lFaSHFgiDy1XNN/XzApdSXb3bS93Mwa3lfdtVmKmtY1P2/C8usLMtjxui22FAhYpqb1unhJdQI9FwhTScA5k7S5Ol44TWYnGb2WH8f+v0fsqg+QQ6gugWwYYGOTEJCoJOx/GmLES6GTnuCRX/R7eMdFLGltY8ut5Eeg5RqVbBeJ5Nvgz+O7WsEH2X5+/u0UScWMW+HLz4gSVPr78Y9nAQV4rXpK4VhqTQqIQttNMidKo/sHrY29ZH7kyp6H9zBaOwnVwzTKMdNqocnbDgHIkJLarWxucujb7OZSMetyXrmGq8mBxqwryeos4JpUgVz3qm5LXXQYXceHQyrVLgBmfcP5vmL+KTL4LXCduWpp03hvADUwSnF0MYk+5JLo/ZKlBGZqE5bHApPCBgQOr0mAocw2p6zi8Ee1d71BSJLEVLJ/nkzdlTSKBPJXrt7f7j1dGmv3LL9DQeTzKnqW43uOw9Xy5vwR+tXzoy6moreG0x5CQC1tZRouurXWuU3KEXUF6IEhAtl31Vy7a7+snNJbORxido7zRmEC5lj4jDLExjuIuf3HRZyGorr6B7cDLAKO1vR+AhtIxBNT87ItOs3WCvuB0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39860400002)(136003)(396003)(2906002)(64756008)(66446008)(8676002)(44832011)(1076003)(6486002)(122000001)(66556008)(66476007)(8936002)(110136005)(26005)(83380400001)(54906003)(71200400001)(316002)(6506007)(86362001)(5660300002)(38100700002)(4744005)(76116006)(91956017)(478600001)(107886003)(6512007)(66946007)(2616005)(7416002)(36756003)(186003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?k5YS/9F3hbmW470ENA2IjfyslprZZODQneKI6geSsoqGyjdJvnr3kVtt61?=
 =?iso-8859-1?Q?JKAPaYhHmhNyZMHHzSYr1dVcf1ypRra38AYZqQtbtZYUk6rkmAQJu/f8B6?=
 =?iso-8859-1?Q?5rDlMHgDIsbdkD1F99j3TkrYyr7Va4satFzO1okdfu9uZUB0q1XJsug1e+?=
 =?iso-8859-1?Q?ZwtlSOOk7mFCYZaGjaNffeqqL2Fr3F9ws1rhmIEETOHlD5a9rFb4imYf3O?=
 =?iso-8859-1?Q?vGYszZ6/C1/kmlIps8jBxvwYirOZaDYh7yZWy+F7Szg/s67fV21XG9TTV5?=
 =?iso-8859-1?Q?gzRtg2aBxWiC9gLpP54W17ogzFyAjcpX25BdkQf7u28VLYJWJwV/auQl1m?=
 =?iso-8859-1?Q?Tjr5DUcv2qjI4oxgX89E9AGSzPaKGM2Dt6L3NkN8nUEei+/WU7wuxDsvLX?=
 =?iso-8859-1?Q?ucyVSEd1ts4bLNWtlDBE8A2osN8UuCBvd6p59rF/Uiuz2lFq2b0Nvuyx6u?=
 =?iso-8859-1?Q?rrsRU7USZns5BV+2Fwzyqo06cAhhfSxCFlBhwGrl5ULROBqmxIYx4wvg1H?=
 =?iso-8859-1?Q?2xQRpseVxNJH6HRB4L4YZIFXAvjZRt1FByS+QYA1Hl3GIDzfASHe5AwQ0S?=
 =?iso-8859-1?Q?v0TbfrlREV4/s7jMbZ+7p1ybXjc48xRWc8gu36B/l1kJx4KnZ7f5ICJc4e?=
 =?iso-8859-1?Q?Ja/KuVMiFloVfTlVWlVyEuigm2HiGXYzVtkL96tdlDz5OJ2Zc37Tel5+PD?=
 =?iso-8859-1?Q?WADqKMPnWsgwRSCS9FZDZ0YZrZtW+uffdy5SlqZeq14oO1oSQlSC6/N+40?=
 =?iso-8859-1?Q?3JFBxzBjvMtN9xjFFZJzFGhLeqkjfYGpI9jLvgXlV78QSB50ZHjRDOWW6g?=
 =?iso-8859-1?Q?3U8VvNLUnw82+8DdDTflkxBxR+qHrmmB7E4Lecd/c6huUp0v9LmNoOBL9y?=
 =?iso-8859-1?Q?BiM3624ViJFSCRIJ3lBgJ5zJ6b5a3ktBnd5F0KjrtYg3IhVy4d6mR/m+dm?=
 =?iso-8859-1?Q?Qj+NL4mB2Pg5ucs+KM1cAZi7VP37v0TIZrY96B2FN2HR0b4cei9EqjEzXJ?=
 =?iso-8859-1?Q?siQI7qfBaUNcO8oH9CSLC3oY41UZWoqsNTThJT3b6KqIIHfP4hVkfZFd2n?=
 =?iso-8859-1?Q?HQis01Cf5wdJ7PZYiRiVswXsakVUhqDRUXh4toUFQ/i6UviFAGcoJd87FQ?=
 =?iso-8859-1?Q?fYa4/mFY6TitnPXW7OgUcKXcaW4brU1wUd7HfbpWqluO+GqJx5fzNfMLqR?=
 =?iso-8859-1?Q?ip7F0Sg5nM8pT9dcj2to0GG9s4f3jSWvTLz4s6uoyRw4wVDSKpW2RDVgjU?=
 =?iso-8859-1?Q?uokdKpep/fR6uygrPlkSwpZ/GchxLbfrTLYnh/DW4RiUM/TZoUcTK2/oxP?=
 =?iso-8859-1?Q?fm5Lh3XRSjTNzIw2UeZmCGftFjMP65Xp6T843qUVKnuBWbIqPQuCjEDSDk?=
 =?iso-8859-1?Q?cpmtDmhV2Z?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f40e653-a33e-4178-e7a2-08d913d4e7b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:59.0185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wcxtQv0ck3RQbFqzDIOYf0p61e1kQEa4/CsI1ZVB/r2OsO5ZUz4Sb1dzzrbUioj4dilo70kLCyz+gzrReC60rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1437
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100114
X-Proofpoint-GUID: QFc1nZKpQGi0wQbV1wY41xfn8U5K-nhM
X-Proofpoint-ORIG-GUID: QFc1nZKpQGi0wQbV1wY41xfn8U5K-nhM
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_lookup() to find the VMA at a specific address.  As vma_lookup()
will return NULL if the address is not within any VMA, the start address
no longer needs to be validated.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 86ba6c1f6821..e3b56903b111 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4954,8 +4954,8 @@ int __access_remote_vm(struct mm_struct *mm, unsigned=
 long addr, void *buf,
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.
 			 */
-			vma =3D find_vma(mm, addr);
-			if (!vma || vma->vm_start > addr)
+			vma =3D vma_lookup(mm, addr);
+			if (!vma)
 				break;
 			if (vma->vm_ops && vma->vm_ops->access)
 				ret =3D vma->vm_ops->access(vma, addr, buf,
--=20
2.30.2
