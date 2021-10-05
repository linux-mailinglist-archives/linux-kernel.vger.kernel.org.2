Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A475421C18
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhJEBgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:36:54 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10014 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232742AbhJEBeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:34:16 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19517AuH029426;
        Tue, 5 Oct 2021 01:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RFAj0fpAex/rtgYsOHi6IMFmwSN9+4RGdqg4BN60GSs=;
 b=OJoLgA+nFEwMgIy/tSoMOAY9//sn6phtRNHZoF8JWUa6le7PflEuRl0c7hAXM692MBXa
 wwX/TH8Ho5qz/MwYsAXgJY67CKV46GllcHq8RyzLNZLJSfO7RcWMOe87XgfbDWchqV2t
 8lTxd3IX1apuRbnxh6azQ+6PneLy+qhjdDWEPtLisdpNPBLDaHE4QmZ8rDNlSZFxEa79
 jP7ciNzR+s8E33DtfTijcQJUvcXdBBZNa8UX/tqXIBM9ByhhvhIUwcYjAdkS8YQegG5/
 6yi25xNdcMrmg8cx+T8z9XFDWWEPMODBiThIGbYSlr87FVSUa5rRqXAI4yBpfS9FyKVI vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg42kkyd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951Tu3v056799;
        Tue, 5 Oct 2021 01:31:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3bev7sgru8-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5U1zvAwyHkGxrGOmw8smuXYKEKh834G127WRXaJB7uhp25l1fcpuXI/+DRJarFLag5APZG/t62w95Q+iHx8OPHMq9xckZqlgSme8U4LgZTK66Fi+oG0MlF1t0u6jrdURhQegzd2+2U5p0HAeGnqpFGX+MP7tphpSPTfV896c9kA+BfXzsYEba0MRMGHqhcz3Yy6TuaGu8dhNfFfEgx62N2UCStO9nSVSXeRVFCKc82VS1JoMVeyc85pMuZTMlCquf2xzmzVAiDMV/eHF20HvtzY0JvTmnsKExKUGhiIahYKWp0T2rRGwqOPvQdXVbKjrW6UtjHfQPDjVM6YnkRaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFAj0fpAex/rtgYsOHi6IMFmwSN9+4RGdqg4BN60GSs=;
 b=UOCg3sr4qvlb5cqT+cEtGlj534+pAe4VILFfSuWHup4ab57nqRqY4tNfP4ylWepFTVQMlawmLb1DnU0WF0tnN7Kc4BuW1LshDDRwqx/v3de7XqyTaQ3UJsCbmF6Qg3jwcjypzyBrSgALy1nkRKIqC9Nn0iA/BSClgvRR3QLaeWmYRYANqbPza/4l81yLo+E6f6gAcTDxRBAF5p79drmL5OkS3TSVejhm60CcX/xR/W8JnA+fEu6OoLJh2XlOjhy3PgTOdHQ8DOCf/wAIn3pi6aXZbVzgYbfrjXj4XIAbdjbs64SeuExqbVlXrh5MGoYYVR0glnUMf+ow4fiAVm3I6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFAj0fpAex/rtgYsOHi6IMFmwSN9+4RGdqg4BN60GSs=;
 b=jzvZ8JJjAU8mGog/zr8y/+iQpPOG9RIbGX7AWM7HrAOEjPtwnafOrWFAFWHALyfwaF1XHcLnembZ7e49sY5FphNnkyB9qQ82BSYa/Tv8b10G/KkDHKP8dyaxFrrCsxtfAqCdqVM3aIek4+4rr/kyGqZIYFmyjsC77Fxvua2nO3I=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:24 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:24 +0000
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
Subject: [PATCH v3 48/66] mm/gup: Use maple tree navigation instead of linked
 list
Thread-Topic: [PATCH v3 48/66] mm/gup: Use maple tree navigation instead of
 linked list
Thread-Index: AQHXuYip3R5qiwJ0wU20Bjo/5u64qw==
Date:   Tue, 5 Oct 2021 01:31:04 +0000
Message-ID: <20211005012959.1110504-49-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 8df020e4-35d2-4ff7-e9c8-08d9879fd818
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50449AFDC3593DFB20EC3D82FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mXsn+llO51FQu1/CJFTmzHeGwInL2eyeTjnt4mBab9IUwTThvxHDj+TdpqD0hPoMGd1a9qKoHKS/VzcaRVUJ7iDKwZl0QNh2p9UPhq7Yz1Ir26xSQktDbaOvgseyHl2ltpCxN6YGyyV93Lsagm1nB0INdpczsnxkOHKBuTMp5rucW+bhISd5+Wy84k9zKcLYxqx/oberX8lkyKhbICF9kckASVh/af2sis7EDARYDio5KazxI7E4Y7hAMBGFCNZoiKqb6nOhtTeFlWwSR0avRjqZlots4Cu7GgmM41VlWQdcafxv7r7Oe1htRc0K15FIF0NWcQscsjHKVJjgj7zNqnIWzFkYJ3EgurK3FR20mnM5YC5dM9SPq858H+CZgFNHZFZkCeNpzIio/uhuLFy38qG/ryYNh2pDgWSTlLZmgaDD7m3uViokxzB/t9LY5MwKPKxQA49E+m/MiA4Zt6m7anUdkFzkBE0YAvUkCx2BRY62OoEOsCERPQSiTP2UlriuGWHVPvwXx+RNQt4sWHykEMD8RiXwYxMtuzxrV6wYqvziUdG5lrVOVu+XXMgQI9DMZY9aTrFC3358DG8autPg7bVuOrrmoV59QDs+nFVKQj7IxuVGdP3HfhG/tXxI0Slu9H6Sxck9WOKV6jrfntWOpsccjurw+ST5MPjjD0U72uLhonYqAfFs1t1zwmHrRj5QtJS2SQf93XhjnFY9+1xBMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(4744005)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sKQ7b2Sgsk1ETfMN+mDdd1e6is9eATRPVWkdQpCDeavD6QbVaWUOQldxq0?=
 =?iso-8859-1?Q?J/npXTj9m9O3+KR92RVgcEXLWBQ+UXrnF02Of5j7hW480JEYSaEPLxAvXT?=
 =?iso-8859-1?Q?3z05Jmp3ZZANj88JaXXjBcqhRjlDyw0oowkgq6ahUiPsf/d4isSbXGA0wW?=
 =?iso-8859-1?Q?fmPFEkCjUNjV1hsaLywdKY5jGfuh7P095IKB8ODwmPnch3lxWI51IHgROn?=
 =?iso-8859-1?Q?PnxSPV39vawoQ22ZFbdDliTZK5cJ5bpE+dTAG4aPo53uerj80DTUg41R06?=
 =?iso-8859-1?Q?vkdrW/u/o6/iXUdvr2VpzSSIV2lbETZeZJ+cVc28LhHVX3kPZauboK1Gdn?=
 =?iso-8859-1?Q?MA0n7OUBG7sf4ZH1xfWYf97ik0ZZksz51Lo3Pvsqza6t6jM4REE2unGboB?=
 =?iso-8859-1?Q?7nX07euss7sirJq7nV8eyexHDTPTfKXMcZ8GfvoKZmaGQY//3/Xb+gV1cV?=
 =?iso-8859-1?Q?5esDSbNd1VIDvLBaHdG18/1MdNpkbusqMiwHB/DOOmmFCNHe43Tsmnen+r?=
 =?iso-8859-1?Q?cnL7+SQHnXgi0J5oihxXLIkDVjHl6fnqExITQVPja0AyiHRDO9+GQWiHnA?=
 =?iso-8859-1?Q?jm8I2cdJOD3Xh9ozAP96NoHvnUZto353Zeg+6wc1uaFNqYJIlvd9TiIFA9?=
 =?iso-8859-1?Q?2Uzr0XeMkTiQbPpo7CAlYstSg2G0i1/tgJ9IrG50VkQufzFOiXRB2OKVah?=
 =?iso-8859-1?Q?9J5o6TTusAi5Wujh8RJXCoDGntFEH/IW6m5IIx9jaSuDGEGPj2M9jszBKi?=
 =?iso-8859-1?Q?+PExgO9hkKolSqZUwGm7d0gca76pXS7OiDdhDniS7HZPfHWv3CQFLHSaxi?=
 =?iso-8859-1?Q?5yRpjf/y334JvHsIOghYiWg2aX8NWuscRKaw/PRiWA55g3+q2Us9/YQWFI?=
 =?iso-8859-1?Q?l6et7pJpy6LWzAZ9HEBr4FGI0hMYF02m6dZepZDfM56rxhQJ+YkD1nboNU?=
 =?iso-8859-1?Q?6CBMkG5Fzzp78V/3LyokI8h/8OykIIS1Bl/u+k1oC4mU0KTRvkNTBgL2eh?=
 =?iso-8859-1?Q?S8Bpiyx2fUVPWhiLDbhf0g6r/4QajIsP1hFFH0my8NSibihTkNzEvcmM0m?=
 =?iso-8859-1?Q?/tbSKFGYUNKBRFMQSWCAJHRdHrMf8LLi/eSuwgzwewijXFYPxqiQuun7BY?=
 =?iso-8859-1?Q?TzBTCmL3usHWOr+y5w2SkvCeu38Ln0a3lw9/QnfWDywcvR875YpJm23+gZ?=
 =?iso-8859-1?Q?7SBWCh9l+MvT+Bs5u38opfVKgLI2j9Xg7KHH2yDgrFKbV0BaVRY/DxPxZA?=
 =?iso-8859-1?Q?83i7kOEarf/b0UpJcWHLX0UTThJm6AxznZQwNefK/SkbOpb5+oMmJssEb9?=
 =?iso-8859-1?Q?s3ri5DfR7nY2En/9t3SZt/4zdJenBbx/z7s65JDrLI090nmYplnA9H1FeE?=
 =?iso-8859-1?Q?Y+QHskZFBr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df020e4-35d2-4ff7-e9c8-08d9879fd818
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:04.8298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KX7+GtCapxwSjCI3NdIiVommCqMnNUCAamgNc79Dpw+Txt5FV44PfO+xB/m4p3Yg9sxDUqZKrGWsF9VJS3lJ8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: MqhmHKaH1j-c9_CwoMmf1hlKINSuR7HK
X-Proofpoint-ORIG-GUID: MqhmHKaH1j-c9_CwoMmf1hlKINSuR7HK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/gup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 886d6148d3d0..f9710e475899 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1568,7 +1568,6 @@ int __mm_populate(unsigned long start, unsigned long =
len, int ignore_errors)
 	long ret =3D 0;
=20
 	end =3D start + len;
-
 	for (nstart =3D start; nstart < end; nstart =3D nend) {
 		/*
 		 * We want to fault in pages for [nstart; end) address range.
@@ -1577,10 +1576,10 @@ int __mm_populate(unsigned long start, unsigned lon=
g len, int ignore_errors)
 		if (!locked) {
 			locked =3D 1;
 			mmap_read_lock(mm);
-			vma =3D find_vma(mm, nstart);
+			vma =3D find_vma_intersection(mm, start, end);
 		} else if (nstart >=3D vma->vm_end)
-			vma =3D vma->vm_next;
-		if (!vma || vma->vm_start >=3D end)
+			vma =3D vma_next(mm, vma);
+		if (!vma)
 			break;
 		/*
 		 * Set [nstart; nend) to intersection of desired address
--=20
2.30.2
