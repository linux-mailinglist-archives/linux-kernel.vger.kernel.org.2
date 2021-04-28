Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6D736DBE8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbhD1PjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:39:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45648 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240201AbhD1PhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:08 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFKkAX030196;
        Wed, 28 Apr 2021 15:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1PjllkePLQeNyYNcfQY/SF+k2JS71wKOLWA8RihserQ=;
 b=UYOcXhCZvp1ct96N/mmamDdxSOBEOMyYOyJ78VKDWGYtCB5zz/X/enaR+VQRr2RHKfd0
 wnGVpCIiHvoSv4p+yOF3pb1Yq17KYY0nLBse014XcXkIIAjGhgXvDzHwRb4QvfAqWh2k
 J494iQE6wKaNa5keI/xqs8GeqZRrA6qTW+sXCRjX4MptJUCdqKVg9s0GjU6N9DMCl8VH
 +J3bkKv2LsP2aie0dicypKr3atvLAtis6vqMwbG0IBz3DEsbwyaMHoHQeIoMnOQD7dTh
 sAOgNr5otXPXgTJCRUbrXuPZD4gto2cg9nAkLB+Dn9Fg5YcR5RHuwhL5fXaGUYcHkcQP Bg== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 386mxjh61s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:01 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFRrsV124479;
        Wed, 28 Apr 2021 15:35:59 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3030.oracle.com with ESMTP id 3848eyqwaq-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpVwXtCzB8+zyDMF7QgJpR7Nu39mA5vG6Mms807cUTHjSmvfzZ5802n0Ty387EwKvwkKLdAGvhLmPxUBZm1DBbsuH13RST2uHAMEOMBJPqQZ2qGSRETO56vdKgtdNEKBctDX0dZtOIHN4jHgI2oGX6D1qH7xN9a5j8UCxearpMqr5GdQ+9vLhzXNNxGuAO7DrzQ9+NwWRh6blpNUdm8T/YFl7jCjHEIEn5XxAH/4KC8t4d8r/YIMT+efQviYQdoaofU7+cqyAk5gtdGXNiQg/HltspACp0VS0G0Ke7yP3FbBy2uVRng+A1uS9PpCYNdLubz8/+i/2uobbGYIUqx5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PjllkePLQeNyYNcfQY/SF+k2JS71wKOLWA8RihserQ=;
 b=JwoHVPKgPq8vzcGrPto1ONrLjl2P5yHhOUvDi9+dl0R8bTyhKDL/IbUA+32GGwEGWEUg8c4aQT+QqiUA5k6LEP2q3K/1psi9Wv6FwsuR9C8VUiiQ6b8K9aRyTv+DopBBHN1+RQ1zAFAHufN/5vKzUxxQiFo1+tf4r9nHLCbQw9xDor3CTV20QTWDMM6WWjV/81S8xIv2U7pLtlniYC20qAp8cpN+89DPpOouOP3FVp97PebKgV30P8DCyJD2LV0d6vkPKW/eDSfvJILP/9svc9kzN5VQoxu7PBKayphmWzsCHHzKix+RPDjKddWEgPEi3LAhTqUQOz53hQBGvh2yHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PjllkePLQeNyYNcfQY/SF+k2JS71wKOLWA8RihserQ=;
 b=rFoboVQvqJnl883thpMd7TdGg5N6xhB9T+zT5xFEkDDkDrO0zt8IjcALuLRw6WJRYrI1WQS4myN3aO+6YmLlCzGBAcdhG/dsa2AU8Lr2uS+szy8WpE28I/dC919CQ7vpKGaEAcwyEZczDyUnXvbmMHx/v2AOdG/bMWxoL0IEMQ0=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:35:56 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:56 +0000
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
Subject: [PATCH 24/94] radix tree test suite: Add keme_cache_alloc_bulk()
 support
Thread-Topic: [PATCH 24/94] radix tree test suite: Add keme_cache_alloc_bulk()
 support
Thread-Index: AQHXPEQuvP7qWSQZGk6zUNYAinMQpA==
Date:   Wed, 28 Apr 2021 15:35:56 +0000
Message-ID: <20210428153542.2814175-25-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: ca7a311b-e6b4-46da-449f-08d90a5b50e8
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4769C21B7CE59E8C8D25DC5FFD409@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pRulvnyOCv4mkSIe3UkU6dF5H9x+IkIPXXF7Xv1Bcq8N9AGtb/dNkw5HlXMxxhw/hazx1npoVkm8g/mFpd3rVO2OZAFUQosOb7k6+l9yKw+EzkoVl675ZUwK70szCJShcUnTA0duc4JpigomHVkAV1SS1RwglD3W/xKv3u23DolcRZc0FU/vtMAps4SA3O4fcaFXdft4xobXkNfVZHYXV24rg0fZMYzD39+oGp+Ws24PUNmDfqnVYFyUtuOGxtoGyOsSJ8i4e46+jFK+jqLkoUdyVOLMEXKF1EBgfb4Wwmmppkx96idAI+ytzGpGbK2g5ryT1sBf5ypHGxkiGMHqJTeH1EVeAIXOvnWkiGhbctueXB0A4qPrWmaQoI8c+HjjF6x5MdCM38zaBQ4oYHWmj1pO/WO3aE2Y8UB9XyzOH/n/blMSbV0DH8Y6ecKsbYj3Z4b7/b1EXzRT8FIpUUFi+wlfQhVuF1dMfWZi0XdhtvGwyhKlQ79NmSjyNnjpWhRX74BH/GnCRTaMO0DqA5s7EyLz7A8Ma1o50KDhsUAezWK+o+MaBcN7dmj8jLzNbwpcBGEJzWeVS4cYLYhuHdNh4qp+rcdambjnpV0/o+CPotM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(6506007)(86362001)(2906002)(110136005)(83380400001)(66946007)(38100700002)(66446008)(66476007)(54906003)(8936002)(2616005)(8676002)(66556008)(76116006)(478600001)(36756003)(4326008)(44832011)(316002)(1076003)(107886003)(186003)(6512007)(7416002)(64756008)(91956017)(26005)(5660300002)(71200400001)(6486002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?hH5tA0+IotHAT4a7oKpxolmjtrjGBZH5hk6+/Rfr6Y6cIIvwi+n8qYkEQ3?=
 =?iso-8859-1?Q?SEQBEbIkNUsyzmk/0DHZpgdE4OZ/Jo/c0aVLV4Qg8zFTTLBeA95hJEZbpV?=
 =?iso-8859-1?Q?8oUxW1YAONv3AQaj9F3iYqd6tGEtrK6AQ4q0HrqeIzEt4abY/dJ6jDLVr6?=
 =?iso-8859-1?Q?F2XUvZJH74LBFbi028xOWw7BzsBpzJzt5HY5W8I08qvUddyinsv4R+2Gn9?=
 =?iso-8859-1?Q?Rn0ZekXHR6S5OP0xHCFb9kpN+oN/t97Ie21t8BGdpbGNL44euKwcW7Ux6Y?=
 =?iso-8859-1?Q?BTVIJxqiAyqN0q37+J3b0Fp4FC3S/103bZU7YOr4h13h38rcN3vnb0G69T?=
 =?iso-8859-1?Q?8OGLrqtIWLn+TLrJBJybbg6HBrWNGqvbQpF2sfGdLqO7NPlN0I7xLCzQIF?=
 =?iso-8859-1?Q?4K+YwS7t6XGCqRKDnzzevPBkbneFIgp5B7Q5ObRE8tjkprPRA9pdUW98PD?=
 =?iso-8859-1?Q?d9q8qJwsTdYmfRYY04L7JMzgA+iTm2L3seI1xdX1M+yLcYMXVzYheFzA8f?=
 =?iso-8859-1?Q?HvJAyafVxLzo5BJw0z/Ho1aEyttyzA6UyOeF+/v1+IR2FLRYZFtoJfHz9+?=
 =?iso-8859-1?Q?PpvC4WnfxTICZxRelwSXPWimynB/C4c0LkXp16TkBgoX8A1K6gKrMdQHIz?=
 =?iso-8859-1?Q?c3rjGuWl2Q6z+XXxztp1MJNuydmNF7PunYoUGA/D58z4h1NiQQUCyKt02o?=
 =?iso-8859-1?Q?+KZGVN7Fv9C6k1eFe7poc6ZqWLdQFYzFYzBJXJjCHX/6hvRK6qXc4RCfm4?=
 =?iso-8859-1?Q?yIqEKaSla/QcubVvlcP93S0YLzJ9rGDQWJ9sq4pqFcyeoNq197yZkz+PtR?=
 =?iso-8859-1?Q?Hz/AqMV+0fFgjHEso0Nmw8X5KJ5rfGdnQDIf5mnO4EntrrTD8tVUKhaQ2O?=
 =?iso-8859-1?Q?y9/Ic0+7m/lJFQXic4U1SWQDu+eOkRKc4TdkM3QQS8cmm//NyMtrbAc9EQ?=
 =?iso-8859-1?Q?Y+doSFTq51aNL6+OwOdy/FifrKHwMd+tmZhU0BxIFtypPSX1vHZmeW7IV/?=
 =?iso-8859-1?Q?7GVLK/kCfY7K14xkLhI09yJVjOc9D3p7WClu9ZmqzXK6XUW3rKw7Ilv5Vk?=
 =?iso-8859-1?Q?Tz2evq8koRVl9XWKNRLfyTXapfRmvddSkAPPs+Dk7nOOjseLlfJLrkrbOc?=
 =?iso-8859-1?Q?lbRpmO+qOuN5zYzPN3LOB3O01o5DvNaL6nya0fuAN6y3pDgbejErCFbYrP?=
 =?iso-8859-1?Q?FuWj3lmm6pVYJzUlHLVKfKGEnETYwabEJkFQjMUqqjpDKkfgFafKO5K9gV?=
 =?iso-8859-1?Q?bv5/AICaOsewBlae7iLGuMpzc0m/dr72YXdG0vcTFC/tu+Nj467YjdBZ0D?=
 =?iso-8859-1?Q?pKxArFF6DoZQL+kvhpFYX8eYaZiu/Pthe8i6npJfz1pP3v8WTDHseOVsVg?=
 =?iso-8859-1?Q?FWnu7GRm98qqrDnY0R6WOmBGGEQO1Rfg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7a311b-e6b4-46da-449f-08d90a5b50e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:56.3947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Khn001SFjMyFFjywukP01qcDeVWCPfMfG56kMPiowmLtiRbsA2el48Ci6F2HhJxZUbW9m147TrSfXsfJzelBpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: k-56J8WLrIlo2szSOwBxsgAK-XfXAt5_
X-Proofpoint-ORIG-GUID: k-56J8WLrIlo2szSOwBxsgAK-XfXAt5_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c      | 51 +++++++++++++++++++++++++++
 tools/testing/radix-tree/linux/slab.h |  1 +
 2 files changed, 52 insertions(+)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 380bbc0a48d6..fb19a40ebb46 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -99,6 +99,57 @@ void kmem_cache_free_bulk(struct kmem_cache *cachep, siz=
e_t size, void **list)
 	for (int i =3D 0; i < size; i++)
 		kmem_cache_free(cachep, list[i]);
 }
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t siz=
e,
+			  void **p)
+{
+	size_t i;
+
+	if (kmalloc_verbose)
+		printk("Bulk alloc %lu\n", size);
+
+	if (!(gfp & __GFP_DIRECT_RECLAIM) && cachep->non_kernel < size)
+		return 0;
+
+	if (!(gfp & __GFP_DIRECT_RECLAIM))
+		cachep->non_kernel -=3D size;
+
+	pthread_mutex_lock(&cachep->lock);
+	if (cachep->nr_objs >=3D size) {
+		struct radix_tree_node *node =3D cachep->objs;
+
+		for (i =3D 0; i < size; i++) {
+			cachep->nr_objs--;
+			cachep->objs =3D node->parent;
+			p[i] =3D cachep->objs;
+		}
+		pthread_mutex_unlock(&cachep->lock);
+		node->parent =3D NULL;
+	} else {
+		pthread_mutex_unlock(&cachep->lock);
+		for (i =3D 0; i < size; i++) {
+			if (cachep->align) {
+				posix_memalign(&p[i], cachep->align,
+					       cachep->size * size);
+			} else {
+				p[i] =3D malloc(cachep->size * size);
+			}
+			if (cachep->ctor)
+				cachep->ctor(p[i]);
+			else if (gfp & __GFP_ZERO)
+				memset(p[i], 0, cachep->size);
+		}
+	}
+
+	for (i =3D 0; i < size; i++) {
+		uatomic_inc(&nr_allocated);
+		uatomic_inc(&nr_tallocated);
+		if (kmalloc_verbose)
+			printf("Allocating %p from slab\n", p[i]);
+	}
+
+	return size;
+}
+
=20
 void *kmalloc(size_t size, gfp_t gfp)
 {
diff --git a/tools/testing/radix-tree/linux/slab.h b/tools/testing/radix-tr=
ee/linux/slab.h
index 53b79c15b3a2..ba42b8cc11d0 100644
--- a/tools/testing/radix-tree/linux/slab.h
+++ b/tools/testing/radix-tree/linux/slab.h
@@ -25,4 +25,5 @@ struct kmem_cache *kmem_cache_create(const char *name, un=
signed int size,
 			void (*ctor)(void *));
=20
 void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t, void **);
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t, size_t, void *=
*);
 #endif		/* SLAB_H */
--=20
2.30.2
