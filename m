Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DBB3794D9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhEJRC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:02:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45004 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbhEJRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGscnp166680;
        Mon, 10 May 2021 16:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yEU4+7V/nTBEI2d04quRfESRAJG1uPs7+0aPiYsfUB8=;
 b=Zu4JWir2lMvM1vjgwFw8uidTk8kjViR/bbz5RXz/c0TJKqdT+45uKihn6e6BBSTymh9D
 Tt2kSgO5N/AO9FeaFaAF8/bKNtiXsFyDVqumNiEheHP/1Q47fA524b+dDi9rdf7zXD75
 hriev2HLpMSXuxp6B8aMaqQ62WbEMTaze24YYVkB10Y4KP1iw9Bjr6xonTTrzfC/fqj2
 +Pg0us0w9BW2vy3ENjpKjlxH/UrV+CFCcvWlDmcLK4AjWw/D+IDsXXOSEz80fPgEiQNr
 nBzJCwSslef5el+kA+RXNih2a3rOiona2Z120pKdsrCI2Vo92J3Y18Y5nM/suwZDwv3w 8A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38dk9nbx0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGucHB109288;
        Mon, 10 May 2021 16:58:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3020.oracle.com with ESMTP id 38djf74j6a-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIDGJMCbs0IOmHckwIkh2OX3dW88G0qJ+VItq1xJzZyR08CSDzDxXrxj28fJV0Mxa/LlPCj/IWjulENXgnCVhN9Csju4szUQDJYy8LVt7xGD8kYixsIY6mHM9EfMUIorEdOuDjlhOaTZghURixsUIcY7f8btyM2iq4R0U+MTJHvNuChAnWbNzYkZlH4i26Bz2WLScAtP6J4jnCSa+pnOpvifOCs40yoPLLNqZPgNsNJXOvp1xg4eC4XQEoMpb6aT5IFMDCPU/G/eh/EmSb+mTPoWUKiysgOh0agx5jyMgBK/rbDVIJ/7OnD+X6j5E5re1I0pfAyJxiY8YKaBFp2xGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEU4+7V/nTBEI2d04quRfESRAJG1uPs7+0aPiYsfUB8=;
 b=gOeKRu2vcUYs4oSLrY11DutuxbopnSrmBMAbw7Q/y09rGpuzNGPz2ymmTMaGzjTK3U2+sQQXjRpHpCdFGUF/qys74/f60Sqrt3yCnvf9SPC0hgDsaXbqPRzoj7MxgSJBl7mXqZKfXwXJbQdU6ypXsBeAaHfqxWzFqnsgWUgvqVggdnVLjLYTqvhRgw44nobmT2rtCcIunoefZvblkqXlRdkyy5Mf5O5Huurs5OiAE+xvJ9uNTjexKi4WAC1CqQ8sIogOoiDScgMtjluGvsX1ZqNutuOwJajQ6Hbslj/0idZl0MhRHCkLuhFnVFOds4m9uv0hu4SvNhil8tcF8Sd9gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEU4+7V/nTBEI2d04quRfESRAJG1uPs7+0aPiYsfUB8=;
 b=P8DC39tjJlqAnOFwE/WAqMNAJyL29cBHp8ch5F1zFVu19bpVtkvF25R09wOyPjSPzJfXiuRATgJGvtcXcAcN3fsLJ0gzAhGsdq8+n9uG+Xe8vyAMiZ3+jVNGmQTkFhPk3Dgk6/R2LRQ4sn1OQ8Lu6k0tl+sif3+cEDyDK3CBWUY=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 16:58:49 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:49 +0000
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
Subject: [PATCH 02/22] drm/i915/selftests: Use vma_lookup() in __igt_mmap()
Thread-Topic: [PATCH 02/22] drm/i915/selftests: Use vma_lookup() in
 __igt_mmap()
Thread-Index: AQHXRb2/4wv+niv1B0CWNi0GBj3oZg==
Date:   Mon, 10 May 2021 16:58:49 +0000
Message-ID: <20210510165839.2692974-3-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 3737a55f-9838-4358-cecf-08d913d4e20f
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB47690FD86BAB1FBC065B7F2FFD549@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MeFQ229KwxgDjeN1uJtaj103D75rVEjQFb+CUuIwo8VQOLNNmF8eIrPI9+oOqMy+6e68/OjAiXaP8+ShHk/EpUe6zcElxjLDdEzJyDiwcCLcKN4YA4UYfxwwwB2fMXmp/o0pJDpRsoNYHONjkiWKWAlD2NYX3+kIEHx3iHIDGvakd4Q+PP67LT/bhNglyKr84vw3DYi9UPd21yHNVetXD+bZV3jbLAtCDFYIf4aoJwrEYmswiuHDKkuH0dNap8pML6e8JNfp6y0V7sl60IK0+w2Nqi6ibyJ6qWMDjUKSX6/dcKiOgJs8ygO5e56/UN+AC4fSy3V1FLOZkUToU7+GCoqC4xFtAvtRPe9hg+qm3gtFrGFGNduQpLg1Kgfo4QwtcXK3WYrWvVJy0fYzneqgztHhxSaVOsfDNSFuzDZ5lBDCP12OKkSLN2DsuE+pq0bgpjPqmG3ydTfe1QOdkeX3VVxaZwN1viZ8fw+A9XiKFYi84TCOu0RW+YbW6PWmCIMAlspoJfiuWeyKYLBqYMzR+k3riK9IVSL0fZ8491pHLORHk4et9VPZV5gezuf0VVOOWLO7iDDDuYMTX2won1NEfdNHFKy0sD721AEuZk42x+o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(7416002)(66476007)(64756008)(1076003)(110136005)(478600001)(38100700002)(122000001)(54906003)(6512007)(186003)(2616005)(107886003)(36756003)(66946007)(66446008)(86362001)(66556008)(4326008)(76116006)(71200400001)(6486002)(83380400001)(6506007)(8676002)(2906002)(316002)(26005)(8936002)(5660300002)(44832011)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?QRwbIG07dZjEywt7kXVM3RH0Y3HGBFY5ytZenixFMwJ2BJUp83OHMR6twh?=
 =?iso-8859-1?Q?GOgmkJy3SvWi29GPrs6Sr/9rd84FX7pM12Shg064vHKgY265dqVAXgea6T?=
 =?iso-8859-1?Q?K0DCob9xHnacX5HlZhABF3IuB6QSk8JhSVGwxTMvgaWwKSHi5aW42VMs2U?=
 =?iso-8859-1?Q?vkPFxZPuQhy/6Gx3PJ5E5RSWWbZ/T0+8s0Jjlh/+9R0DwuQuP1eyU6IM8I?=
 =?iso-8859-1?Q?pivRrvtTUlSHC2h3kla/lMHpdmF4Zs3ajNwEeIyUYQ94EYDHbXVqI31ds8?=
 =?iso-8859-1?Q?J0kkUify/W5bs4HzPjCpMDCXMmny4/FJijdpXr2AVpj3FjLUqi/SDDVWcq?=
 =?iso-8859-1?Q?r1Wm2gz75dHkh5/s1As39CEvsQMQApW7B/UoIqXmGBFgDqyk4bGIb40x26?=
 =?iso-8859-1?Q?Exep1R2EfhIFQTFsGkkDnRtVudcWSXp4BMSTer0HIImOXRQx0YGZQQXWEo?=
 =?iso-8859-1?Q?2StXLmTI2BIPVzonVEq0VF5oWWJ9UQlPDMUDQ3SB5jDaBLLpM2dSVI8B+T?=
 =?iso-8859-1?Q?1VP2onkszls8sjd+0gRxAam1/oo1ZA+yGsDBHFfwfO24r6Qw4fvis1GSlZ?=
 =?iso-8859-1?Q?tprnwXfS3JE/6egy1WPXZwiYKAE9H0qBZLqwLmbM/5PDA5YuMO2FbtYpnF?=
 =?iso-8859-1?Q?xSWfrZtQuvHswuPg/MME4vFQTbB1PbWwi/DRMcC+AqIzigun7vp2xbBo+Q?=
 =?iso-8859-1?Q?UKpeC6XTBpj2nR1bpJD7j5AFAkpMpsoOwOm3GvLY3RTJGewgwX7ASfw9YS?=
 =?iso-8859-1?Q?pbGSTG5wN0ApFYxbmxj2kSoCeB8gFd+O6FwxhHffNOFl2sU+12v50wVDgm?=
 =?iso-8859-1?Q?A0WP0cgkxLNmpgKPtlttDAPLLZdS45AVDKrJxi9kqmlCRbp8ME9vyIzlrf?=
 =?iso-8859-1?Q?AG+bwNKuFNPZBgQ4cMY+8GnUQ2IDcXWYhb1FNSrfNaxgF1e0z/L6RgBELX?=
 =?iso-8859-1?Q?m+DDdh6RefZ5X7hOgD/Hiixug3wjjXQX372BcAmuqjq9AEDUBVikVgrIkZ?=
 =?iso-8859-1?Q?JSVYwM16nkt3S/ZWMTQ8XLqlzV1P4CkUEiRTmu/Q4gQtz0vmmaJxINrL26?=
 =?iso-8859-1?Q?iI01TYsORZw3QkvzwIn/IQpjH8l6yTTIlppWDsd28ADk9sHO1yLDUxzo8j?=
 =?iso-8859-1?Q?SvwKWDQr/rMm5JonVTuJVW1EHXKUY+afDZUCDwdNGzgj88CVH+zbUf0zaI?=
 =?iso-8859-1?Q?iVUu78h7NGlYLxDcfztW8H8na3KueV3mG+E6AirlysQF9mgIrooDBQl68V?=
 =?iso-8859-1?Q?5zjfV/IxcDSXTm/t2Gn7+cJjyuwZ0qbtgXj5IEYiimHbM0nEtOGoamV61L?=
 =?iso-8859-1?Q?b7m3jCZSSZvdR5peqg1qiG5KdEYDrgQJxQuqlrx30Lw7vDMotaZO1utd/X?=
 =?iso-8859-1?Q?bveNo7yqJk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3737a55f-9838-4358-cecf-08d913d4e20f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:49.5047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cCODw7V+Lwfpml5g1MpB2YY0zce0TQ/nPzrgrbuQTHzrJEmZ+Nu0wpI+lVLvcfNPnM2KLuUCMYQglD392WUSRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
X-Proofpoint-ORIG-GUID: 5bUS0ni-9gvR9buJybm2X2k8AG7avCuz
X-Proofpoint-GUID: 5bUS0ni-9gvR9buJybm2X2k8AG7avCuz
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() will look up the vma at a specific address.  find_vma()
will start the search for a specific address and continue upwards.  This
fixes an issue with the selftest as the returned vma may not be the
newly created vma, but simply the vma at a higher address.

Fixes: 6fedafacae1b (drm/i915/selftests: Wrap vm_mmap() around GEM
objects
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c b/drivers/g=
pu/drm/i915/gem/selftests/i915_gem_mman.c
index 5cf6df49c333..35c15ef1327d 100644
--- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
@@ -871,7 +871,7 @@ static int __igt_mmap(struct drm_i915_private *i915,
=20
 	pr_debug("igt_mmap(%s, %d) @ %lx\n", obj->mm.region->name, type, addr);
=20
-	area =3D find_vma(current->mm, addr);
+	area =3D vma_lookup(current->mm, addr);
 	if (!area) {
 		pr_err("%s: Did not create a vm_area_struct for the mmap\n",
 		       obj->mm.region->name);
--=20
2.30.2
