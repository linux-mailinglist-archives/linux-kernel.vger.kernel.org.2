Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6226C3794DA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhEJRCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:02:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:34180 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbhEJRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:52 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGrlNU173094;
        Mon, 10 May 2021 16:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vbu0Cr2FshfunsnLLOLcJRvrN8W+qkudDjKfhqJkklw=;
 b=YgRz30unryoVrpd5vG+43Z436XdYZ8SAG/ecCPM2UF0MK/j0S2h940FJeBqVCF8IkPG2
 bPC4FLkNVFpTKqdJ9rSIvbtFSfd6j+F+B3tQFefE3nXe/KWMt93oLoYLO+aryP0/BiEG
 Z8kmnOaciEZb6/fOdnNyUhT1YHNgSI7yQOXJPdmJY87axIy79B1Ye+RtcDxjF/WbRt8G
 0B3i3NQ2UoZ7T6llGtGbr8SqjNRgXs55ZS898xTb/O+tiAlgcMbWl1D0xfjcKtPlSObA
 h+YGU05c/B7/4i34FB6Xu52cyNlfog5xDueHif4wk3CH921dIpc+XMWbrfqI3U+uZsGs LQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38dg5bc2gg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGtfFj036499;
        Mon, 10 May 2021 16:59:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3030.oracle.com with ESMTP id 38dfrvs50x-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzzyVVeXZ1qrrP0gpd23ivfjHivOqCVO3gIYchpo6qpgvnXjE+y91MIbOy6qy7anRzgI4Url6PtwH9VnPNTgcsPsGGkIz0z2QqunGnJa/10kzdNGOpyyB00MJVPntFJT11h4qF5z3d5NzdXqkx4B3xPRA54Eeox5I5KGPQYYNexx4R05VpoBDVjIc6mdBIlbe7NPz5wCbzo+1qSB0L/nyOQ3NCqSlmIyY5GGj+wEfspHajKLzuiImAO+xg52ewntvEi+7ZrtEjEy+5Ulqvw68gkum9icHOCTm9d2PLXXnPx5RinKeZRAP7t4J8TPl3QF53+xuFU3vHLXo55q3B9rww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbu0Cr2FshfunsnLLOLcJRvrN8W+qkudDjKfhqJkklw=;
 b=lLGmb+fsBgh4qYV30Nl1GmWOLj1NBDkm2PRrmzFhFfleLO5yiL+nULllJbp91wsylD0WmSdpxgf8+Xqqp0mcqg9unhRqb9rPhw1wDqSGgzB/dCWdFtN3e/0KxXzPozotLpRHHXW1KJrxRhOcfHJ9iymMv+35O8JMuk/F0lMRwvIbtwzvChS3L4HlXGfRMsbbFH+D+geQUdJeh0KHpIxbgcVwoAI2xp7U1ShhXEwgINfmiD9D2UtAZW2bLe1xETQkO9M5HBiQ8y1JG5CXBjstjlgPDpyN+MEukgAm8r2cTg75aETSOmxkMB2m2ZPJfYvyc0AQtnqkp5Z5AH+bH+QZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vbu0Cr2FshfunsnLLOLcJRvrN8W+qkudDjKfhqJkklw=;
 b=JIsfZPTA5hsXDlmyEIAiUjHDX+pItRlsuvIDkWqs8P+QMXvXQx/fQndFTP0LwFsrFlLMcgKY5HSr7dxL1lQHSaV70At9nHhwlDkXaF5cmRpJqdG2wHhbpushp2TyOZbuYoOroMT4Y1FEXEDf19zEsdJudNQGvTjeWhVtekC6mGE=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 16:58:55 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:55 +0000
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
Subject: [PATCH 14/22] media: videobuf2: Use vma_lookup() in
 get_vaddr_frames()
Thread-Topic: [PATCH 14/22] media: videobuf2: Use vma_lookup() in
 get_vaddr_frames()
Thread-Index: AQHXRb3D6isd5T4qZUek43lpNUmYpg==
Date:   Mon, 10 May 2021 16:58:55 +0000
Message-ID: <20210510165839.2692974-15-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: e933b7c4-cb3c-49c5-10ea-08d913d4e5a5
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB476992EB273A4EF5986A6C20FD549@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:883;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kFKlj1AZRwx2BYnfcW8hSpNzYXdne+hco6P4IXiRzZnmghFfq8L2vJIeV45tNGj3tm5mGuSjwuAdh2CPAg/8HXA9XsOh8XtTz00bvRkPqg2FLPmOtsg9Nih/COw0k8cLEyfcxqJbO4GekDuJrZdYJkT/XFJsUmonj8pIAXUdXhaErYbsJWzi1Bk/l/17G3+HiAjCOFG/cQdNeq3AgkgbRBZ07nPJnoSRJ4T6zcxldJ9u0Q1/4LxGvZMJOuFEJKT8xeAO7jwodOX0bZ6qEkG+l0ze1htJT+OJV6nryXHbqK5OtqxUrCEERHIW28TEsZx2ipMWOvtYYpIEVVxA00a1gQxJv8cd2TF0g7Nxsn1y4wmeRr1vdOnibj3ZVSWtRVuWMHlz87kQJnQ+AcQ7/vicq6nj5vIvGgHdW4CYRfWsGCdBh1//BqEg0d1xfHjCCW/Y6nPgJyCIcLy+MbFzIQmCm0I8Q8mdxk9vd6ekYF9W4/LYm8Mzc+CmPD8tcsH5G9ZiIQHeuER2/9KgiXehqKQRFy0YcDciR2rJ1gmYH7FvBjVISgXjw5m53CZOyBkWi3zXOQDidAcII3UFN19/jNbcsBs5Z56u8QgIsVotrpbt8Mc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(7416002)(66476007)(64756008)(1076003)(110136005)(478600001)(38100700002)(122000001)(54906003)(6512007)(186003)(2616005)(107886003)(36756003)(66946007)(66446008)(86362001)(66556008)(4326008)(76116006)(71200400001)(6486002)(83380400001)(4744005)(6506007)(8676002)(2906002)(316002)(26005)(8936002)(5660300002)(44832011)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?GHILGLV0Vl7VF3U8MeHKCxqS3ZBTvLZpxQYHWeYk+Z/tl/Prtqzot+pjfi?=
 =?iso-8859-1?Q?Id+oYY0i2wXcNcdzPBPlTzWdkkb0BrTIgY/WrcOgMwtd6dR2BQc4EiQcAJ?=
 =?iso-8859-1?Q?NFg92/17RbU0nsphwsaNI2TTvmFebKPxRgTirNlU+fYuDbxB18GDTbUhnY?=
 =?iso-8859-1?Q?2W+pUyLb8+pK3N+C9eVyD+oAIYKdHFcwmvY5uGMVXYJ7fHelIDkIt7FecL?=
 =?iso-8859-1?Q?ua9PJQj/P0BLMjpNwm6WU6oEEOevC6KYZsKDZWe9Up6GfCiudY+vFfPoqQ?=
 =?iso-8859-1?Q?mWTcXZ7pciYu+WGjwlj3VCZIKgxd0u7cO4usZxd9gB59kO2xi3CqMduemS?=
 =?iso-8859-1?Q?Wc6oK5EXcBkWlVhEhJdLVNfYf5ZdDPg679iOo/37WcGiiu7uxCIAJ1uJym?=
 =?iso-8859-1?Q?Vbik6Bf/DMJvAVrBju6Y3znSI8gzVi/EK5Gjej9M7L8YSuADUdO4UfbTqt?=
 =?iso-8859-1?Q?aQa75yEeDjH4M9syongDISzFAExddDIc61pX4UiyD5jLstzQC8kx6cm+Kk?=
 =?iso-8859-1?Q?hhgdIF/MSkJjEpleWNoMvA8W5mzbXDs5rsT99KO1u4AcdfKhVZ+qz8e6vr?=
 =?iso-8859-1?Q?qgxiebI3xnD8rhaaiDfmCnIHYH2Dc0EYSnKIk/hjNQGGRa6gaHwcSop2RE?=
 =?iso-8859-1?Q?Jijxne3M1gesZKv9YDdsKBENqdXMYLP7KZtyhL/43Yus1qv/k8SGej0CR2?=
 =?iso-8859-1?Q?ggynzXamplGlBjJ8T6Omh3kRq2hDUGQrvpyb9n3axJagpHz9/BD3OakrLX?=
 =?iso-8859-1?Q?0MWryUDj2jLGvGVHDcxbsXbvS3pkaGd/ABH3cOX49RNANxCki4ie3ne9Lk?=
 =?iso-8859-1?Q?E9v39eGL4zvCiEokOcI26iEiiUnsly0z+cm68/h3KbSKIq0rhGyICBcO7a?=
 =?iso-8859-1?Q?JKxNL2jY52i4SjQAjqeER4tSyex9iGm3N2Uxp64dR0MrjxZp27wlpCAZ5r?=
 =?iso-8859-1?Q?XxrnhbENy0VGQSzzsgih+OlZQ0mn1aa1ih5dSK4D2qs6Z7B9t+KdAeL+cX?=
 =?iso-8859-1?Q?Nsf37f/0kQ7t57nBruDGRYKxLO0L4g+mI4gE+7SqfNABi06zAwA6MlYrUg?=
 =?iso-8859-1?Q?hojx2bbblGdUT4t2mcx7VbV0Ez7BR3BaUD41IMdxv2cU+gf9/8ST4ainkL?=
 =?iso-8859-1?Q?2Tvh0jIQLv+G+xFIun2zHjK0S22c2p7CAtby+O0lVrR9vuFLBgl63WphaE?=
 =?iso-8859-1?Q?jHHLQ1CN6b3e7JRsDMsKirktWhvgEJ55iNyo/4at7+GtWeUq3ykka4vXqH?=
 =?iso-8859-1?Q?7cmqX8VK1t3GJQs67ZDYrhF7gXO1OINbwIGbE/jEkOmHJ7uIkG01O28wZj?=
 =?iso-8859-1?Q?CjU58cYZGVuUiTwSCzs4dK+uK7IVwaEM9cydyop6ba+ltZgLpqjSO+YhwP?=
 =?iso-8859-1?Q?jOcxo1xGlu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e933b7c4-cb3c-49c5-10ea-08d913d4e5a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:55.5451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDKh1fGdyf8wqdOIBXhScI4ijU3Nl8w2Bjh78PUmRllGteTFxceMNII6I1fpqES2jBZvHCiEjOu0fRQPAG8zmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100114
X-Proofpoint-GUID: -YDlpZEp4AUQvctbljleVmLxtLGZemKN
X-Proofpoint-ORIG-GUID: -YDlpZEp4AUQvctbljleVmLxtLGZemKN
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() finds the vma of a specific address with a cleaner
interface and is more readable.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/media/common/videobuf2/frame_vector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/=
common/videobuf2/frame_vector.c
index 91fea7199e85..b84b706073cb 100644
--- a/drivers/media/common/videobuf2/frame_vector.c
+++ b/drivers/media/common/videobuf2/frame_vector.c
@@ -64,7 +64,7 @@ int get_vaddr_frames(unsigned long start, unsigned int nr=
_frames,
 	do {
 		unsigned long *nums =3D frame_vector_pfns(vec);
=20
-		vma =3D find_vma_intersection(mm, start, start + 1);
+		vma =3D vma_lookup(mm, start);
 		if (!vma)
 			break;
=20
--=20
2.30.2
