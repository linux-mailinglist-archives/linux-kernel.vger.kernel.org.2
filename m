Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D353EEF72
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240433AbhHQPuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:50:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22804 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240204AbhHQPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:30 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjffU011253;
        Tue, 17 Aug 2021 15:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3j+08lREa0r9A1JB7kdnPvbg5F8d9idklNPEBbu30uQ=;
 b=G/4fefs/XPizzfiGUv+nVeNTAc90qhpFGflmsdVkETW5m7MTnBQduw84BENdvGB9maEo
 X+eoCqznlRr0RZl2Y4qYJ6qsDU1301VMfS5jxANR8chjMVGFajeiT3tdjM+UZyfXDG2S
 fnasJtqz0UFgeqpNMhdCW3qqgYCjA36uz8Wl0tCX4/4iM9JShc/mLFJvfiZoiBNa+QyI
 UQbLuxxWfkHuFJLJKnlqrRO6Q0hwxZxvZCiZdknL3vYIZWVtiyTMoKtiWEjwEfqfibu0
 jtDMLR6ONyNh1yQ31UpnQtBr54p4uqOy8W5/yuUQEE153zU9zsmPmboxuD61vcMWHzd9 Hw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3j+08lREa0r9A1JB7kdnPvbg5F8d9idklNPEBbu30uQ=;
 b=cz6itQgL7A2xFsAiiFSGaXRKnbCv924pTEXaLlWnYXQl+J/aAWenUvmTvKPAmGDbl68t
 /zRxl005OzXZTPrIb+MYrMJXyy66OOP3sRUjr6+xIfb0wzlB7GOun64Kt5cznI/fhZan
 GQZ61I29w9oxCZtukeYIp1Iiv2M6wMVONqrHzPTX1odPG4vvkJLjYk60Tx/SdFB6MrnB
 iGigkti0/gGR8dFYBVFPu7lOkNlf5k5G4kuSzB7AeD1mZrzCvCiAkjzUU0yfM6v4KqMo
 LokS19XUmwvq4QbWjj01enBdKMzYuJRuSSlYeW7cztGL+7o4WBIOoxMrPVEVhvphE53A fA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7d8bt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkt3Y094574;
        Tue, 17 Aug 2021 15:47:09 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 3ae3vftd2y-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAcDvbCFDdBQPgIocFKupt64D/h/6hHo0sxutDiaoK8g6l8YnrXn9ipp0b1wOor2pFUu/c4WIr8pYURsGjOMkiNm6hfuiMoBtNXCzrWvo1D0W6BFcY7yO6NGzrjPAduxOSZYAfoMJ0PizZtneF2FWoZgQvjoecQBd2t3SJo5Hlh+uA4W3XnJqs0mV/cXiIQFx990Oc6XavQ4nqkvebZkQKYzP0b/caqccGUor1X2HxNnRnykdp6UqwgQEObep+fy9jcHAlIO56ynDgnZeE3trjgmPfJBboKz8trELswW9e7JlXrhU95QnC8heSno80M2QTwf7nI3jNvPT27WhQuV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j+08lREa0r9A1JB7kdnPvbg5F8d9idklNPEBbu30uQ=;
 b=BeVKalSQo/HDtZpTWn1/mbSRULrftLH4Zb41CKM5t2Ys++CknDwrHp+FIDnM4qbYDHvaIN74RvzqPDKmQzkOTvWI8uH0qC5DwmJfxRYPyeoNLojz+tJNR5JejMQ0RqXYq66YT4uJJigb7w+TQRjTmE/WesMl0UWvVuTQ/IkTULjbD5RLEMz2RamWA4RLDUpR3zsmUx3Iv/rlBAH95sNEcuXzT7DEIuQCJY9QFvv6c6M/zL0i0eesf9HYjXXiZOqTK/6ovGUUvl0nZMOorjd2cO/FCFeCGY+5N+h7IMXoanY+a0G6L0Z/16bRZh+wQUgzfZ5voLRNjiKE+nr+EmulWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3j+08lREa0r9A1JB7kdnPvbg5F8d9idklNPEBbu30uQ=;
 b=ObXaZ3wl506hC0AwU3ixrxul6O0t838HF0m1uW2+QIurCcaFxqgAs9Qrn9XahJFWzmjlGYAlNIpQbU49LkcSQx68Lc27JLVIONWn7vEoR4M2UH6V9w9Bi/2fgIz6yZNwb0M83ckmZH7OeWN0/h3M+RzDEItSMz5j3lgMwGwEiD0=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3097.namprd10.prod.outlook.com (2603:10b6:5:1a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 15:47:05 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:05 +0000
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
Subject: [PATCH v2 03/61] radix tree test suite: Add allocation counts and
 size to kmem_cache
Thread-Topic: [PATCH v2 03/61] radix tree test suite: Add allocation counts
 and size to kmem_cache
Thread-Index: AQHXk38gS29shnsm60m0L52s3L7k1w==
Date:   Tue, 17 Aug 2021 15:47:04 +0000
Message-ID: <20210817154651.1570984-4-Liam.Howlett@oracle.com>
References: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
In-Reply-To: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6bc6dbb-1c72-4f6c-1c64-08d961964381
x-ms-traffictypediagnostic: DM6PR10MB3097:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB30975C9CB2F37D3430BB265BFDFE9@DM6PR10MB3097.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GD06udPNaTRzNMmVFsu/joDV3um76OMUeDiZcEyF85AAMD8fsTcoyLUyHh1f/xZTkWUaB3B5+Gu8m6eBDFVyrya5KoxFdm5HiU3LqPgbtvRXLjd5dWiqJkK9HddVqis78bhGfR/E4KyeCzH32DBpoiVb9L2pVsDmrEUeQMUh4WCflYWDH8dvGUWBBBxPl5MzTPHUQlN2om+Gbat6n+bRhImmsZrABQNJj8K/tC5NNx8GGSKRJ6dZAPkCmbsG4+dFrhzEAJXC6swBzWtZT4Y9bxagzpdD79G++f9TVIyX2bVtqareY1LwyHcA0btlkl/k0BRCDtrEMun3zaALJoR96L4cVrIBR/OkU1sr1vOtfnZ+0f9aEBOGetqkSH0d/R3Wm8bxxLqhyo2R6ULIdoybGV6xQOW5LDhDpKufI1cP96sf62tX5wc4croaYlUQSCycJklyu6DUjQ/MG9VrEZh8S92SIEpV8TBPyN0qRWeQZ939+k/gjm+5eCUP+zgQ61AAjIcBLXk3yCAsMYUucGI16ezAgZgqZSYmdzaXCNMt8ZBOLmY14lx0FpYuqV0NG/TI+AJUbUv20BcKZeDgGjpd1boEUSrZRn7Mrr4y3Eindyzp9RvvwH9g+zGN9Ldzn/K25lN93136Y1yy0oEuX9qtjfBxj4y+kxcjsNKOq7JT4Sn4KMr9CXeTUST9lXHnaawwE6f/ihgwjPhz6yy0SQeWIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(396003)(346002)(136003)(8676002)(6506007)(2616005)(54906003)(8936002)(478600001)(26005)(1076003)(38070700005)(110136005)(316002)(5660300002)(36756003)(6486002)(71200400001)(91956017)(66446008)(122000001)(6512007)(38100700002)(83380400001)(7416002)(44832011)(2906002)(186003)(4326008)(107886003)(86362001)(66946007)(64756008)(66556008)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Gkf/8KrqPIbSEF1gCkFUoE1PG92Odp6xggwmngs06GCfcwLRwvAN/5UeGT?=
 =?iso-8859-1?Q?WBdv1EwxeONv1pGef1Xnb+Tnp9/FP+GnDEVp4jm/Lx6gJ6xcVUHelxUGsg?=
 =?iso-8859-1?Q?4ToZ07yYLe5NNU7d7hNEa1g67rBMDK275UuJNAv3sOH8OgTJJgb/tBenD4?=
 =?iso-8859-1?Q?otGpKnal4B/X7pBtUjiCG+CXzurLppwyIP7+mCpBQzZpw6HiL9WRHbn2Pu?=
 =?iso-8859-1?Q?Ka1OU0UqY9dYgMdJfylfcQ1iUMYH50uaRwbBOD/FIo8ZylnJe96Tj1XyBf?=
 =?iso-8859-1?Q?HJUkPP+w5zeSY4GCUc7hSTJt7DCM8j91Nw57cfhIZdDGE6+IgM/mUlNvg5?=
 =?iso-8859-1?Q?0jB8itseaNh1ExZ40ZdMIKTFasprnmwDtCjaBGbvDRDbnftU1G2Ua7JRGf?=
 =?iso-8859-1?Q?fYaxWLSSRCPeO0bZkpGB74SvRtvrqqDwTwNmVC0hVKJaHoy2W5nrMbf5iQ?=
 =?iso-8859-1?Q?aabylGfyKNQgLzJlnfTLxURMjW9rLJNhc+kFu32oCtajiGEjdKxM9dsf4b?=
 =?iso-8859-1?Q?ye215pXFCfBC6SeABh/E3Ag9hH36LEkY8S/zhZTH0A9kBY+uAEf6Jupjft?=
 =?iso-8859-1?Q?cQ7vq5ympcxelmgTYLiDyjxUTOWVWBwYmf98+eOLjhSZ8vawUypoED8SB1?=
 =?iso-8859-1?Q?hq2JMZ31nkrVWg+0sx/OHgWHXLw68ugn6sIkoRWrxZeixQqIEuELInLFf+?=
 =?iso-8859-1?Q?11JaIaD7x5F5DjQqAmstSZ8TyEPpzMiWi3ADhmpO3zinEOotL/segRbPIe?=
 =?iso-8859-1?Q?XuFsig0yqcCAXR98aDtm9KszPqo6Aj3H+jYZS+AOmzGSp6iYzfIn8wCE8X?=
 =?iso-8859-1?Q?xgWI/0Hb8a93bOL05qLgiDZeJbycwJsyNt/PHqixO/H1df1dq3NPBG/2kq?=
 =?iso-8859-1?Q?FTPyZNBifWFOu4EL6if1lHZByliJHNdSJe9rDAZox6LAacpnsKrldCqFc0?=
 =?iso-8859-1?Q?FAthwgzHpg7zcc8c1wu4XeKyA/Kq8fpMbeRfJa2ZnxBmTy+SVxUfQ/maOX?=
 =?iso-8859-1?Q?PoGWIlMWhAIP/5AMAj2cPLh0a2Lnee+3EF2fwMXLxaEzbRxnJLt4FDeMJX?=
 =?iso-8859-1?Q?eesGq+llDjBxg8WFpzp4gIr51eLb0cfa9UK5926kBxGSmbYJYxJK36f4Wh?=
 =?iso-8859-1?Q?U0tCvddkYah3EebNFFxsDcOvi/pkZ1pnxU/X31gcDfUVOsG1AfNimWjbug?=
 =?iso-8859-1?Q?WtG/FTqVmhL5p8FLr74e649I9zz79wKziBK7EjVI4v+3W5lICPdv+Z1rMa?=
 =?iso-8859-1?Q?utAS/RWtmyHxQjApVqosw4tgKO+9q1tMnK6QKz3D3N7Ak95ieVMSKVonr5?=
 =?iso-8859-1?Q?nlwmExyD7fn5kF9YPMq3oWotZpYgFsePAexGKONB7qRXhSDAVG44CwxSvv?=
 =?iso-8859-1?Q?MPqGMiNBsa?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bc6dbb-1c72-4f6c-1c64-08d961964381
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:04.4217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JuvvtTElIGQJUIP9Z5A3VO943G0L5JplB+48rKMMpA3DidGzOLq1+naeUJWO6O811152MBu9+hgRtTagKAEi+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: kGO6AZ5l9TsL8h0f_2OwfZ8NjrTH0v83
X-Proofpoint-ORIG-GUID: kGO6AZ5l9TsL8h0f_2OwfZ8NjrTH0v83
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Add functions to get the number of allocations, and total allocations
from a kmem_cache.  Also add a function to get the allocated size and a
way to zero the total allocations.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 00ee01a14652..f95e71d65f00 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -25,6 +25,8 @@ struct kmem_cache {
 	void *objs;
 	void (*ctor)(void *);
 	unsigned int non_kernel;
+	unsigned long nr_allocated;
+	unsigned long nr_tallocated;
 };
=20
 void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val=
)
@@ -32,6 +34,26 @@ void kmem_cache_set_non_kernel(struct kmem_cache *cachep=
, unsigned int val)
 	cachep->non_kernel =3D val;
 }
=20
+unsigned long kmem_cache_get_alloc(struct kmem_cache *cachep)
+{
+	return cachep->size * cachep->nr_allocated;
+}
+
+unsigned long kmem_cache_nr_allocated(struct kmem_cache *cachep)
+{
+	return cachep->nr_allocated;
+}
+
+unsigned long kmem_cache_nr_tallocated(struct kmem_cache *cachep)
+{
+	return cachep->nr_tallocated;
+}
+
+void kmem_cache_zero_nr_tallocated(struct kmem_cache *cachep)
+{
+	cachep->nr_tallocated =3D 0;
+}
+
 void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp)
 {
 	void *p;
@@ -63,7 +85,9 @@ void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp=
)
 			memset(p, 0, cachep->size);
 	}
=20
+	uatomic_inc(&cachep->nr_allocated);
 	uatomic_inc(&nr_allocated);
+	uatomic_inc(&cachep->nr_tallocated);
 	if (kmalloc_verbose)
 		printf("Allocating %p from slab\n", p);
 	return p;
@@ -73,6 +97,7 @@ void kmem_cache_free(struct kmem_cache *cachep, void *obj=
p)
 {
 	assert(objp);
 	uatomic_dec(&nr_allocated);
+	uatomic_dec(&cachep->nr_allocated);
 	if (kmalloc_verbose)
 		printf("Freeing %p to slab\n", objp);
 	pthread_mutex_lock(&cachep->lock);
@@ -124,6 +149,8 @@ kmem_cache_create(const char *name, unsigned int size, =
unsigned int align,
 	ret->size =3D size;
 	ret->align =3D align;
 	ret->nr_objs =3D 0;
+	ret->nr_allocated =3D 0;
+	ret->nr_tallocated =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
 	ret->non_kernel =3D 0;
--=20
2.30.2
