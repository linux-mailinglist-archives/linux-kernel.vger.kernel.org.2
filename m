Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E46421C19
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhJEBg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:36:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9956 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232741AbhJEBeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:34:16 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19515wfm024348;
        Tue, 5 Oct 2021 01:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=c1WdicHnSrX/6d1uhIQqP4beidNP3KqZXDZhBMAEsjE=;
 b=yHoCY05eXTE5YXjScg/7p6YFTbWCgzoqCwbnkhK+SCmPOh4Z6eahzsWiwg2MWclnFP6y
 bB2WsGxdGvdaC7XlXlnayOgNcqXp8uzJ7xyR7SztDmLLZ8/3UOQZieXsZZE4ciyWGdY1
 XQECV2pPZArceqR3K7lcIc7xOx7M7Ulw0LOuBG2mMV+owfd9ZYL2w8AN2r5gR1gCAube
 SIHy2QLcyCNVBYSB5o0jykuX/yi8DpEUcUs12+aakACNlV6l0dSGS2+9pGCKPGMM9IYv
 TfjU/gmQxD7JLPCI7Fnxg3eEp2yTCvx/1RDfZTG/HeQqaDLFxN9zLMRp+FUyiXUituPJ Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg454bvur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:32:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UIEk178435;
        Tue, 5 Oct 2021 01:32:03 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3020.oracle.com with ESMTP id 3bev8w03ud-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:32:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwIhSe2opKiGQXZuL5lcnUnOIWWXFYrvo6CYSkdBXBuUNcf/p2fH03c75rxqPVtNyBcMdRDB/tcPczyqdRv4Pa5EHuYQaN7cJb0jXBW5ppt/2/BkaALiWWeK6P2p6u8reopR6EipBvrj5VXc8TOyi84BqBLr+MEVacSBAnBW7adCCEYBHH+k1HjagPQSbt9HZsX38yNLXRVf3j5MlkPstkuPc+WwXtQwiQ4gnTUeJoquZbS9D3LuKkMvCIigh1rPuNFJrAlZKzPGU1XhW0GqDpbymEjuW4hkZddc+7r7NONuuIgmC5uts3bDiIq1K83b17pVDlIYqleMSI4/OYgUrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1WdicHnSrX/6d1uhIQqP4beidNP3KqZXDZhBMAEsjE=;
 b=SrVoSzQcLHHwBSzNwZZrRm5r4GalbCTrWmDe7DclyCX//9kNXELgb7h5IVwO0kO5IgCuNywmGCNqArqhAZ4Baxgd5tmo86woqm07EW+LF50bxLxyKpkkD61bYFp2Lf3jCZZdFOU4LLNopdMFy3vinX5jZmLrJ0uK6MgLiQJnNcA05fb6sX4ckxDzSTC+k+tJU0Y/+Rw6jpWcIyxN95lvuZjaP+Keb61zzpO6lgUSVkQ3cPRKXbnsxQJbBK+TGXlFyATQuUucWw3w5+ybMh7OfOqdIfgcQO1Y+28DQB5t6OjvZYpjnC1WeHxpyS8Yp+e3HC5LGRlMcpgq59e/nw0h5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1WdicHnSrX/6d1uhIQqP4beidNP3KqZXDZhBMAEsjE=;
 b=zJ0BKcOpVBsjONL6x/lKN88cr8UoV4ET51O/iiGDAKaCvvJMds0eMb4qIwyhaGlitr1ODei/NHac2nk90XgOEQB+3rJazo6Ai4Op0T/nN3K6hw7dCcgEt3HxqVhZYT82PTsjzO87PIxDqN21XSGE7rA4xgbuWC8NevUqmJ+BEDM=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by MN2PR10MB4288.namprd10.prod.outlook.com (2603:10b6:208:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Tue, 5 Oct
 2021 01:31:58 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:58 +0000
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
Subject: [PATCH v3 64/66] i915: Use the maple tree iterator for vdso
Thread-Topic: [PATCH v3 64/66] i915: Use the maple tree iterator for vdso
Thread-Index: AQHXuYiwItbBnRt6r0+WdsEcRY0Mqw==
Date:   Tue, 5 Oct 2021 01:31:15 +0000
Message-ID: <20211005012959.1110504-65-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 133648c4-dccb-430b-bd20-08d9879fec34
x-ms-traffictypediagnostic: MN2PR10MB4288:
x-microsoft-antispam-prvs: <MN2PR10MB42881E4B1BAF3241ED973F33FDAF9@MN2PR10MB4288.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e5KBef3wsSg8MvHYUXjKM50LNCmKJLnGcvdjAViT7/pSoqkoHKyAgYN1Fc9jDT53H8yGjzJLYoTprAwbTLbWSK/06ZUYS6+L/w1OAruVu7MUh7PWgHjTOMcQbmZGyb/yx51xji/5Gi90iWHbNjknNg5LcGyVzpmOGOXA6wr0gQSsmT7eCkBHnQA+eD9JbWqSktl28H6Rk9YrtSpoZu/wqv17YmQWR3/xH+aEir8GiBGaMv2PWVbwIBFcU4X9ALzsCFEx+TrAiNRDyBCxLNcUb035N7+OmO/y8lYUWZtvWEUsNnB2j/CVJLPEx5REq9q/+wobego3WoHZwC2Jy9Hs1F+nw4slIPmZgcEFRc4QmE3aIVs1a2dpR2VBOqHSWGX9DojYiOfkhOAuQLvepQtSb1S5P9G91MQqmXJ/xoXjbo6x1g5A++8yB8+yASwR4XFeLWwVDrLQnTGFBaySA7sYjriV2pesPY/bPiErIt5Q89aCNWUSDY7vOVA9bZxoPHuiJnCd3m4rOWUNdtvzz+lpDUCz6NL1q9EW68yeFHvF6Bvs4Ijyp/pC7iSvu6NfGvTTmq1wMb3LktSDBI0fYCh1e6ueZ/+P1cki5I0qwXUxABXKaBU196Hf0eS0g7haRWmGZKJnyyip+mOsggwQoT1dv4s+ywq2sO36yl72oXy3QZETXBn+tpmqICX4x5QeBBh2c9J0CMJo8KJNPJJMRTVOhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(38070700005)(71200400001)(8936002)(76116006)(6506007)(1076003)(122000001)(316002)(2616005)(44832011)(6512007)(6666004)(6486002)(38100700002)(508600001)(66556008)(66946007)(66446008)(26005)(86362001)(83380400001)(5660300002)(91956017)(110136005)(4326008)(2906002)(66476007)(54906003)(4744005)(36756003)(7416002)(64756008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Vhn+Uda6BI4WGIyX6/GwbzOG/aSNyo9kwM8pb7JkknwpuV8p+CwAS9q0I9?=
 =?iso-8859-1?Q?00apPcj/XE2qVpxkvx02RsANvCg0wUu65IgKzLG/DWKGPSC+M7XCG+60KV?=
 =?iso-8859-1?Q?tBUIrqlRILeON7fDZXmWo2eD6a8tLziWHt6mqPzNprL8wdj4pfbFzOJGe/?=
 =?iso-8859-1?Q?b9jdEbmKV2LakCfW89e3eTBaLc6P/8hD/EU2iD7VVwbFc/qc0GUIfQINRj?=
 =?iso-8859-1?Q?+T96R9oc6T5Itybz8dVRgN/iqFHo/1iboTfYI5MJkXDmsUS9D9B6WUBPOc?=
 =?iso-8859-1?Q?9Gqple6iOlQg3aXM9CFr66UjIu82zcP5eDsreCIssA6mDv+qRyBdTQvAX3?=
 =?iso-8859-1?Q?EVWM/MrUnC7tmD12HSmm73Ay4foRk02L1ZQ3uqY1In5A8MzB2jLhcgGt0D?=
 =?iso-8859-1?Q?7QAvMxlTHOwXF9mmTNujOIDtbcybRvOQHfyqFHy9EnPZTUFdeTk28WEtHq?=
 =?iso-8859-1?Q?UC/b/ujvyMbRtGqE0epkchIv1dKLlD7aaE09booz0wt14hWrfMVJlrRgt/?=
 =?iso-8859-1?Q?zxTUDGlFDEiVoqB5j1cHSPsZHFjXL5sk4tCinoasPmMdT4E+ul1XHcHFrM?=
 =?iso-8859-1?Q?bjkQlxQD57+BP6C20jtNSNTHamwpPGou4oXfbAFjeWC+OivAqFyJ4iGRF0?=
 =?iso-8859-1?Q?rq4C0fAAk4eHBi48WU98JBeqXHAVW1Hk7Bdo/T0ZtjpkNRLvTAWbWzYrip?=
 =?iso-8859-1?Q?vvzRtCFYKzFNPc0yujb3WWdFxLcYUOno2yrxnWQHUk2OQLaD1c0q0ByYKx?=
 =?iso-8859-1?Q?J5t9ApMnAZ424raYfhD+MEP8nSCyRi+yZTzvwfzUrS6oepHOZfNPzF+1zf?=
 =?iso-8859-1?Q?yZ9ijT3xKwECVyDDGmivcZ0wj5YwlVBR2GsFarFRPy3vtDgWCbYMfELpk6?=
 =?iso-8859-1?Q?aBn8igrFn4O3tbfItjKLOao1RjIs/9p+fDuCQ4Q5rr+cHYP5rBNyoA70aE?=
 =?iso-8859-1?Q?39bRhBLLVvGtz5Vkzbag1UkJ4inQLI2dCLI6oQgak+WWeh8MKQinboHvJ3?=
 =?iso-8859-1?Q?aatyrlc33ZtyP4MHZ1wrOvkjeuU6b8H2nIvnBSxz+jbuwiNla/oLBfciQx?=
 =?iso-8859-1?Q?YzDib8uRBWutzvmJyIBCRRrIWH8WATD7L/4n1iWACLvNbRMUbmF4rJqYr5?=
 =?iso-8859-1?Q?KLwctQefCywctebqzHoMRc8efY1KtDiiCkggdjo6sKCMebwwidxJB5RUX9?=
 =?iso-8859-1?Q?l+aIoFLo1mRLPR3VgbBy9u0tNQgE9EbR38CpAKIqpmCF/0gYtSVcfmcnSZ?=
 =?iso-8859-1?Q?7pjDCWr5rIjgG5iaNOBHyLfB06tUozSAFUgsrz12/V7k/++J7pums819U1?=
 =?iso-8859-1?Q?z+3qbjrf34S+TddO0DQDtanEEWLQnKBnbq13B1F/97fH3Bbs2L4XwpOtzo?=
 =?iso-8859-1?Q?WdTtwNC9PC?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133648c4-dccb-430b-bd20-08d9879fec34
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:15.3059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TdA0TiHZ7+n5occ8v8Dp8GJDe8gUuuTaQW7yc4nneJKzc1IgmQt8tX566CPC6nqRB93QT+H0vQPg4sKq82tbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4288
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: 15e55mMu8NtYJduTaImAvD2bo7rTDjaV
X-Proofpoint-ORIG-GUID: 15e55mMu8NtYJduTaImAvD2bo7rTDjaV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the use of the vma linked list in favour of mas_for_each()

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/=
i915/gem/i915_gem_userptr.c
index 8ea0fa665e53..a67d62159e5b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -423,11 +423,12 @@ static int
 probe_range(struct mm_struct *mm, unsigned long addr, unsigned long len)
 {
 	const unsigned long end =3D addr + len;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
 	struct vm_area_struct *vma;
 	int ret =3D -EFAULT;
=20
 	mmap_read_lock(mm);
-	for (vma =3D find_vma(mm, addr); vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		/* Check for holes, note that we also update the addr below */
 		if (vma->vm_start > addr)
 			break;
--=20
2.30.2
