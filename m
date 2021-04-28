Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A22136DC22
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbhD1Pmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:42:55 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34000 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240656AbhD1Pip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:45 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFPXv6015928;
        Wed, 28 Apr 2021 15:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=7biadSj4FxS5oDHb2ss8ClvXb3eZ3GHdAlceu7NDU8s=;
 b=EkQpkXg8xnx6Gw9RXSDD3SOlF1n2KKG0rkKBobsIKC+Xu3DOrGDZtvqsnV73/mqV2o9Z
 WvULWyGEzsJjcsNW5mytrkg2Uuu0pEQC1od1Y67S0Lzp9OpmXjzm639M3z7N+BBRwudM
 qzs9+AmBjOgBJSOKM4QDlmcLBo6jJy8fNmZsS/faq3LQZ7YdDgCzGJFxK08bRBCiswcn
 ktXw7PU9PDC7cMxLe35KS5QKZARYTxrPfGrLRm1byATbsWK4Q+HINgKwPMJGOCnUr7tx
 gpb/2+UGg74JgkDbumh+wjy2sZz2xxuOi8keV+zW6Zz4oxLRltVcotFy23GNA+jrg92y dQ== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:33 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFZjx5021758;
        Wed, 28 Apr 2021 15:37:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3020.oracle.com with ESMTP id 384b58qq07-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7LuOacpMmQiHh13Q8tXGNjZCqAcfuKK20NW1vL/WxInK0DBr2cQmsdFxaCeL7sUnBVzaBSVJH4BgdLu+jxbHslHofuH3e07X3sqP1SizBT6LmBt3k5NVU7RM5Uzx62FC7de8ZWNImem/3Js9OSK1AIGbf6r/JQHnj3KNOYNM0kLYO722x3Dt5oHZkBO4lO5MTxnPrX5iWRbO44lQd4HcAJ7upHfVmQHp21KKF6b0mzrTNf+X9FshdQlVEDVfHGbhnbmU7pRt/uU8stUtT+XAtgAjHxmVgvRD6k0shTym3EcTlJ+7zb9/bfmz6SH9gurj5rqHSo4uTn5ltTXiykmvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7biadSj4FxS5oDHb2ss8ClvXb3eZ3GHdAlceu7NDU8s=;
 b=U3dclILeJorbNOkLlzekJM3mdpEYWkn9LuBixbLN6cjM7c7dzhfija6DSqtTlAYWd6REfsqL8pV0LSMJFEQg2Rq5DVSYULUUa1yd0Q7Yq7EzbRCvQs90bb2Y/AM/wH8VGpW0Rwdq1FbAf5DqD1E0H2TtkXIkJ3BGk0nR6FRV7ZjWFX8d1fFBrNrV8sC7jwdHZDyrULjz43HPJJEgT0nGadkR953ZYfei2EHvwiOeibfE64Oqsc+NvKuoH3xZJvqP7wmCQ5ElZcsAl109mMfT3uEt2bcwqtN5HXkO72XkqYTZUvzdR380eDTJDzjFUFCCnzSTzjL5sPJ0xVMoJt+2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7biadSj4FxS5oDHb2ss8ClvXb3eZ3GHdAlceu7NDU8s=;
 b=m3UK7iZ9PZrCIvBzX1BGM1NFO7ViAO2q1445J+xYHtEAkZYc/wOKeZC6tv9iCeNzj14i1cHMSGPL+lLpvfqhSyL+/dnLBRnzHNlwDbu9fs2mRdq17cX1KnlNNo0JKc6niVnBbIIFGAIH1iSspFj4un2h7y6Bvjfs6gR7SEJRF10=
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
Subject: [PATCH 86/94] mm/pagewalk: Use vma_next() instead of vma linked list
Thread-Topic: [PATCH 86/94] mm/pagewalk: Use vma_next() instead of vma linked
 list
Thread-Index: AQHXPERCgNYXMR+X5UqzG/PNmNdLEg==
Date:   Wed, 28 Apr 2021 15:36:29 +0000
Message-ID: <20210428153542.2814175-87-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 1ecf57b8-329d-427b-b4b1-08d90a5b87c7
x-ms-traffictypediagnostic: MWHPR10MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1871994B1491242E59802CA5FD409@MWHPR10MB1871.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n6cu0d+JnMv8HyrJtMhV+CqZO0Q5Hh2trGjeTwX18FuoMNsuD3vwwwctv1aimZF2ESHdAFIXsUjGFGnM1ijCdyv18HDVspubEEVL0vGELYLauaiVbeEdTlWENcTrBxOzLB3JswDprCuDJpS8d/WiGzFOmOuO2sdGFjo/PXFBsTSmZWlMlbD8Rhr4XF4860hRIiYIC+Y/x5z1LPkmm8wfHxQl8csALmFJJ2Ys91UB4K44O2i8Slx3wNFL1kfR1rSKVl4xxtDm9kx9MphjA9R4XbUYkUvx4GWDfsy0iTFYT7rdMWhtEooa1070e0eZSVM/ljaiSowKIMvfeIBs+OfpRVwGVpyQh5j8Xkq3kgoz1dgUEd5syaO0tqXFzf7k3x1O9jYiNtPtsc2bQslglC1FXExDnowa4x/POA9bI+El0SXNKpd/cLWqMFzFRcqEB9wyFR8rp/TFYMf1C0+J6at2+Qq/i71Pbq1IYHEQtsswlK+Lm9Z8XcvoyPf5fn0hqqJE7CtaZGkHp/ELvRXzvm6ftjEvvU0N4c3aK2EGE56yl8HEu7VwK1MQTqYVZlwRt06IVgvzvof4eLy0giE/QbkSiDwhPkNaOJJKFh6HsPJQm9E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(86362001)(186003)(6512007)(66446008)(6486002)(4744005)(66476007)(316002)(107886003)(5660300002)(66556008)(71200400001)(110136005)(54906003)(478600001)(44832011)(76116006)(6506007)(36756003)(7416002)(26005)(2616005)(8936002)(1076003)(122000001)(38100700002)(83380400001)(8676002)(66946007)(91956017)(4326008)(2906002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?yrSi1gzwXKcah1EAgKOqcZFXuqr5mUaLL8L95cfKrPbJryl38ixXJ3nrz2?=
 =?iso-8859-1?Q?AeLec03t5Br3TLMrB4fzvprcxvkhQhmuy4elgfxKSaNoArFsxT9vh7vLXX?=
 =?iso-8859-1?Q?U4HbY721Cmg4nGhskdT/f9Xax1BoJG7oy9fjxvKLelXgKGkXVm0rCQmqJp?=
 =?iso-8859-1?Q?6cck8GQ6tMU2A2phq8FcR/2UOU1H2jf4jilIFa+LPLGVYpMjDn1mr+KBWq?=
 =?iso-8859-1?Q?p30x11HJetqNKxA4PSlfOzLKqzuLf158YU/7h+iBOggzW3ldcMCw2h+mb7?=
 =?iso-8859-1?Q?ePDAeLoFQf+lGsixDxx3sre5oH0seE0GG0TOc/CJ16uqVmxebwgy+MIi4s?=
 =?iso-8859-1?Q?ABH3xfCFrkXrZjit2xCaC9586jgygHbiwadgEOwiuoct6b8QQVntEV/LPI?=
 =?iso-8859-1?Q?Jo91FZaXc39s64m9Lt6HivRAywVbnjbtjj+P2XceD6JRFhOdDzTzs6NCMW?=
 =?iso-8859-1?Q?QL95zO8uBFQwLtZ6cWr7CVLgPeNEz8SuCZi5zjFwrtjfPY/jHmE9yJ05pA?=
 =?iso-8859-1?Q?02bCHBbzf8c6feq/VtpqTU7RG/xaRsyMVzL6xPUfGXwCRjVJ0CdzRvSnDv?=
 =?iso-8859-1?Q?9quAvb5xY46Y0jw7gnO5mvInMrmAEhBHs1EcWGVceXDH01U2pJRooHTAxx?=
 =?iso-8859-1?Q?2+yf98wUQ5mrdfWh82Ih9poINBieYv9keMgLwmC2O0lh/VnMdR57vu8uAi?=
 =?iso-8859-1?Q?9MbIZBDPuqOHGNyCswRnAQ8tcuSfOoGr4B2EUd7zBIihbMLdU7N8eogE1X?=
 =?iso-8859-1?Q?S0eul78rXwrJrzJrlkZ5mTM4QnTWN8UT3sCnDt/cFZC1Ojo67NsAtPM8yJ?=
 =?iso-8859-1?Q?XYVCbddBUbYyVfGFVJMGTN2Njrn4nnkpmZunQkHW67AT3gWXX9dHuyJGiY?=
 =?iso-8859-1?Q?1Yf5DyDwK1v7pCbUIQenvolKplyLAuCfxWkrfTBVFqvXySjcr2hDYdk/u5?=
 =?iso-8859-1?Q?59ngyRiUisqgTiw3O/jDimFuVO4kPZx/LrBzEXYxa5p5Imbe7lH9gFDogQ?=
 =?iso-8859-1?Q?YIMdfWWTxSqF0w+a3kGVETzcxo5OZdW7XZ/k33OMqaj8hTASDM8nvtz+5I?=
 =?iso-8859-1?Q?wpvc/hmJQrVzIpGJR3blkj9qbsBfoqeh5+awwY8mwy2gUabDHkaXqB++Za?=
 =?iso-8859-1?Q?4gvGvxhRfGiHVQFmZpTsn/xETvtZX/Ej7rJcJu+ski2Qm69YI9/rUam145?=
 =?iso-8859-1?Q?D2nE2lR40qWUJfTBQh8Wak48hd5ctxzjKMhsAVA+Qz/JxPLiBzb6bddF90?=
 =?iso-8859-1?Q?AqCS0E4z6pLhwWB4h+DsvDBKq9fzxkbEoHyk5epdLmeEHD2+FoB2FwxZIj?=
 =?iso-8859-1?Q?L3ZRJYCWujMBsI7uxhG/ePMR2n/6ug3/A/nL2IZRzZNSOTEu6gnmg42bE+?=
 =?iso-8859-1?Q?YQT1p4Wjgg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ecf57b8-329d-427b-b4b1-08d90a5b87c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:29.4691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHo8N51EwI0ucKeM62GmTCquq4FEYPtYRQXIuuWY3Rt/Vgvsun8CGlzk4C1SO4PHSnIGaSUPPHS/xKyihLGQ8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1871
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: yg_oDM4cngp5OFabEmadZoBMIlHQ6el6
X-Proofpoint-GUID: yg_oDM4cngp5OFabEmadZoBMIlHQ6el6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index e81640d9f177..20bd8d14d042 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -408,7 +408,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long=
 start,
 		} else { /* inside vma */
 			walk.vma =3D vma;
 			next =3D min(end, vma->vm_end);
-			vma =3D vma->vm_next;
+			vma =3D vma_next(mm, vma);;
=20
 			err =3D walk_page_test(start, next, &walk);
 			if (err > 0) {
--=20
2.30.2
