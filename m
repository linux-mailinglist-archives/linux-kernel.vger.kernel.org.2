Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73083EEF8B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240439AbhHQPxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:53:15 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3604 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240178AbhHQPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:31 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjT8Z006866;
        Tue, 17 Aug 2021 15:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+54JDV0CwfFMEun9TA0IU1DN8fUJ+zkLs6ezMryWlLM=;
 b=nqLUzpnR5JPSANy+Qe9jffU0A3G2fIWEG3+x+YaY7jVEAyojSuhfpjU70i5KYgJJ4EJD
 MZS6pz+LN28Jqb6LbZjNyv6gLNzoZGwz67zdoCXT8TwG6JbLnjnXcmX3ssjSbaTLpflU
 eL+13QXpd0YJZzU3TtjOSk6EE316brGQn1//1ugSAfb6hzTaK9kSeu3j/95ITpX1yHx7
 bpfLaveVpbdW14h8xOHPaoAS1NVTWC2T/Piuqx+9JQdrb3Yle7CUorYfZJcLvBc3EsGE
 qmeJ9SsOZ1AXVrzufFqSgDitVR0bHXEA0s88D75uqrwYQnQCcV8zs2BrYuHnFEfYOxzb ow== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=+54JDV0CwfFMEun9TA0IU1DN8fUJ+zkLs6ezMryWlLM=;
 b=PjKxO3UGTR3ewFt4+5/TbyaGGffjAXo0haGePqqpzElFh8talR7l/3X+2TLfgn/REczk
 3gYNf70aXkR02zaUgt7pYexEAIxfvIt1ZRavkImSrcpzmm+Oq9JsJPfn5McMtkO+pK6F
 7fFbc3/7G2iP1UIg82iFTfVqPgsRX5YvQSbG6PvCoUa1LkWYqvY2ThxCui8IrYWEg092
 RahXHuxSPMKP67Ctyvzizdn/3q3GusAmS0ATHjfxbQjjND6Z9Nul7udaQQ/RUiDy7tiu
 lrCLUpAcJ0WdU68b4GAodV86ySMXV0WUS+9HuxJ56lMW76oIuEhxA19C1ulN67HMPY+b gg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmbc9u4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkt3a094574;
        Tue, 17 Aug 2021 15:47:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 3ae3vftd2y-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sk8xx+UCuB498FiDwWoSXAWulEoEWZWkrN6ZHVFGXDUOsisVlgb1zuqVpAg7TfCbErdL7ZDFBP6y2qdoR+4nZhNWon/ransjQmnGJaunjlxC06vvMe/npgd2P6Xtik/zyZUHsGZhzhkBDXVHTAn1ZSPfbSDs6G4Y3tS+wxrSbJV0L2CH/zEP8+7YJo1NSnr71nM1vFgBFdV8XkpaZW1+yy3FKGzWUfJlsZKfEIDXmtwhTdjB7aFbiCdaQN5CkX298815q78YYTzx4/GoYBXuUK+sgf3OqEOtp25aoAy9l01TOeKzUlspdt3KRS7AlqD9z+/OYoG3Jl81WygbgmY1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+54JDV0CwfFMEun9TA0IU1DN8fUJ+zkLs6ezMryWlLM=;
 b=MSwEu1vf60jRKMydBEoZwJHWWrRsbvjc7mO32Cyi1wjg05YXU4SFCIqYssh9if0M2l4Sfk4Y5L8KPq0HKBwlhFIZGvuo66Smr25gNdwoD7phT+ibRX8Nl30b6lYk77yFN/GstSBHJmC5zh06NgWvx7+Pm3eZ1cfFw+PBKg+vULVKbPpQYxfHlgKole4P8IxElD/YpZ7VmmBwl3kA/pOJ2/8pFttdG3uF4zEBPVrRNpcHeGq9Z7idogLct9s0z5zZj+N062dLwoBilrczaYRP+KkY24dGWE6lR6fREeExDSWdgjO7nvIk3GqJkT+KqUd8kByTznBDkPnCsmiajmpWWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+54JDV0CwfFMEun9TA0IU1DN8fUJ+zkLs6ezMryWlLM=;
 b=lu9IVyu6v7LlhaQZEfSqw8rZMni9E3wuufDHVuOKhGB4g1BFyVQm0LGFlU3aOVWP47vG9qi/0RuyMYfoMiSrua+adZGOPWpl5eTIyBehMJvWA+X0gGOYokjqf93IJ3EiRx75t+XoeW7QtEkNFDjT7FIDAIlbRG2Tq5lhgKymT8o=
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
Subject: [PATCH v2 04/61] radix tree test suite: Add support for slab bulk
 APIs
Thread-Topic: [PATCH v2 04/61] radix tree test suite: Add support for slab
 bulk APIs
Thread-Index: AQHXk38g3lf0qqDD9UWMFelNG+TIiA==
Date:   Tue, 17 Aug 2021 15:47:04 +0000
Message-ID: <20210817154651.1570984-5-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 5f754ec7-b050-41e5-54f7-08d9619643a6
x-ms-traffictypediagnostic: DM6PR10MB3097:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB309734F626BCE1CBBF94E2E9FDFE9@DM6PR10MB3097.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NhXCAi1G6gn+eKfZD/7O4Z/8dgwbI17rDGXy2vRH7eYo5fwOP934ZmcoHKBv3UQavkt6nJQ/xjhT4JAo1jHQMuWSjGGPa6loESDq/gnLefWd1pYpgY7n4HUjEYWwFCnc2qI4r9+FMsmpc/xvowgLGSzcGwLM/Th8hhj8K1lfQP3CI1P5Ux+6+m/itpLnuQjPTzHHloZ6fo55BxFysTScYMGv0BN4Q2ndp4RL8yW0T+w8aapqFYfhXfIRLeRx4aTOPp69oPwQ2n9NOwmR/GY/lptth2HlA+TVYFv7X0K7Tvc4s99Z92bT2NIR7y7FkXihZlkTXLXM2FeGT8KviwqO+9374jYlIBt0OAwo5urqhTerV9zCoFDM6cKLwR71t43MmLhO6Sx9jobKlZSYPVTE8MiId+0vWI2H9mE91ObqOCOP3G+FZ5ylMxK5RVIFnD56XHK6KUWlGFrGbjUyX13hSUqPhPpZWFZEM2NAouCZlYJOGS5HQ9qHI+25cN/87oycFLQ/yJ/5LobXIoODFle3nM5bHp61bsO6+cKio9WCXPRTqRDYOpZQ5Q7KQCrmxASILneGe+LaxqSPDrlM8WIaAlbh4LwGy6mFO2Bo+CPFYcGZ0wKFlWySdbCcgZoJzod0+68rP+Y/vhSxWKN1+dhvbCRKy4fXzw6lczrbSqVY9H/vLVDH+nGXcFfWwn26rg69vgOm7GXF2B7XKO8N2fymYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(396003)(346002)(136003)(8676002)(6506007)(2616005)(54906003)(8936002)(478600001)(26005)(1076003)(38070700005)(110136005)(316002)(5660300002)(36756003)(6486002)(71200400001)(91956017)(66446008)(122000001)(6512007)(38100700002)(83380400001)(7416002)(44832011)(2906002)(186003)(4326008)(107886003)(86362001)(66946007)(64756008)(66556008)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Bo1nCfMAt3RlAyu67sGzfPD/yu4Dp2yEsUtttfcxhaEpQD4oqWU2pOiEvn?=
 =?iso-8859-1?Q?VHMXJ+b2s8aiBQx8kDoh64Ed7csohS1pwhB1xgPdAnpeFQsRPMU0j96KzK?=
 =?iso-8859-1?Q?yIESLY8aKpRE4IO2ArmoG41cccGJKJOrtVVr1Nz5a/1v2IFGMU016ETU9K?=
 =?iso-8859-1?Q?mWjQt2d3g2v7/lyoLNCINljxONUYq2HPtp6oXN6h1K9ojXq7bijxs+0WLR?=
 =?iso-8859-1?Q?AJZ6NJr/CODFlm/mZlVL45Q3sFZCOYuxKVnNKL60yORw4K9aPwrg+CwuSV?=
 =?iso-8859-1?Q?EjEm8KM/QXCKW52CMlhianJz+OMel35PBHacZqzu1Jc1t9jIi9UJluBtzV?=
 =?iso-8859-1?Q?q9j0G/QPB5chIg6h7QHkL5U442V0YYrr/8Z8KJr8OQquyEYORLnTQd3U9n?=
 =?iso-8859-1?Q?3tNHKjO7MvZ5YSLDj6UWBByg5ds0jxE6rHgBvmWcBHlZrViHinX8SbIka8?=
 =?iso-8859-1?Q?4wpge5nTwVtvnuCyg6Uf81PPU+v8+lCDp+/jDGBZbkv0iY5IMTh9vHgpKY?=
 =?iso-8859-1?Q?khbqzyqp4CO1ljiBloYK03d502UEXKPCrN37g2arrcWJSuPdZD/7gfiN5j?=
 =?iso-8859-1?Q?CHiibQq8A/yXBC1OpHhl9OluNo4O9OImNs/s79feCvk50z+ug/6Bgy+WfN?=
 =?iso-8859-1?Q?Fo5DeztwOz/Eg7XejBQvPiYoAGYxYo2/6+QzFzbo4XdCWWe5VYQorqRA64?=
 =?iso-8859-1?Q?D6n6/8AlGLBL+Piy6N5NNONSBtX5S+Qc2CDh0ciZdodq26nDz46ewLppbG?=
 =?iso-8859-1?Q?Tf4EaIujvie5B1szGhn7qjTBqlIFmjRjO1ujCnklRqMe2U8Sg+nQZOGDkY?=
 =?iso-8859-1?Q?cqo5LOYtNpfu29vTw4N5Zxq2hLy1xi1At8JZJAapG+MbSWDReo+49tCYWB?=
 =?iso-8859-1?Q?OCA55YiwYQtN7SJFJ+rIc/LCWe1SgzRg+yFBZ2C5ljzEpKPOsW2DNDI9Xn?=
 =?iso-8859-1?Q?+QYa01IKGy0QA8f6yV6KA/KNMcfre+j3Pnp1vjzxv/qJL52cRWHw3KtzrI?=
 =?iso-8859-1?Q?xEOb5S6ULRLiKruk7ZpI1sHQ+Au+uFgcO31IAfNJ3jHZabxL5qYhZWmL9R?=
 =?iso-8859-1?Q?ai+akMwhfEHQFtvM5hsE8q3LYUcxyqfSpGsccPdXUhU4LSiUqCsQVVCu3V?=
 =?iso-8859-1?Q?FKvhSrpMDtOPt2aUrKKplfwLs9LBS2SMzydfBJbWIXS3nxGqcVHQz2w7rw?=
 =?iso-8859-1?Q?vWIaA2gRrvFX0QCZlbjFPncTzhbtvP/nndXv5JUe6/aVOXatwWKLaxbpCo?=
 =?iso-8859-1?Q?994tp4udumrBFwBL0/VJcUAVK+yxIdPBowIPj0FoDorKlG+ZpAMxizcxUR?=
 =?iso-8859-1?Q?I9ZcIc4inmJLYupvAQS5kZgXFSExyhLFjoh3FFrkI+e8ejZHHlEGC8kAd+?=
 =?iso-8859-1?Q?UwhoZzqxGK?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f754ec7-b050-41e5-54f7-08d9619643a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:04.7313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1m8kY/Yow9p0YFhNgS/oVT2PQiKqQuGWYJlxOFpr9cSMdfRd2W/gT03Y1t+JDCf43EbLCS31CAUipmruhr0sbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: ZbnXOX7mpiLduUOCSQddTslB5z0dS8cD
X-Proofpoint-GUID: ZbnXOX7mpiLduUOCSQddTslB5z0dS8cD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Add support for kmem_cache_free_bulk() and kmem_cache_alloc_bulk() to
the radix tree test suite.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c      | 118 +++++++++++++++++++++++++-
 tools/testing/radix-tree/linux/slab.h |   4 +
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index f95e71d65f00..3383d748c650 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -93,14 +93,13 @@ void *kmem_cache_alloc(struct kmem_cache *cachep, int g=
fp)
 	return p;
 }
=20
-void kmem_cache_free(struct kmem_cache *cachep, void *objp)
+void kmem_cache_free_locked(struct kmem_cache *cachep, void *objp)
 {
 	assert(objp);
 	uatomic_dec(&nr_allocated);
 	uatomic_dec(&cachep->nr_allocated);
 	if (kmalloc_verbose)
 		printf("Freeing %p to slab\n", objp);
-	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs > 10 || cachep->align) {
 		memset(objp, POISON_FREE, cachep->size);
 		free(objp);
@@ -110,9 +109,80 @@ void kmem_cache_free(struct kmem_cache *cachep, void *=
objp)
 		node->parent =3D cachep->objs;
 		cachep->objs =3D node;
 	}
+}
+
+void kmem_cache_free(struct kmem_cache *cachep, void *objp)
+{
+	pthread_mutex_lock(&cachep->lock);
+	kmem_cache_free_locked(cachep, objp);
+	pthread_mutex_unlock(&cachep->lock);
+}
+
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **l=
ist)
+{
+	if (kmalloc_verbose)
+		pr_debug("Bulk free %p[0-%lu]\n", list, size - 1);
+
+	pthread_mutex_lock(&cachep->lock);
+	for (int i =3D 0; i < size; i++)
+		kmem_cache_free_locked(cachep, list[i]);
 	pthread_mutex_unlock(&cachep->lock);
 }
=20
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t siz=
e,
+			  void **p)
+{
+	size_t i;
+
+	if (kmalloc_verbose)
+		pr_debug("Bulk alloc %lu\n", size);
+
+	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+		if (cachep->non_kernel < size)
+			return 0;
+
+		cachep->non_kernel -=3D size;
+	}
+
+	pthread_mutex_lock(&cachep->lock);
+	if (cachep->nr_objs >=3D size) {
+		struct radix_tree_node *node;
+
+		for (i =3D 0; i < size; i++) {
+			node =3D cachep->objs;
+			cachep->nr_objs--;
+			cachep->objs =3D node->parent;
+			p[i] =3D node;
+			node->parent =3D NULL;
+		}
+		pthread_mutex_unlock(&cachep->lock);
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
+		uatomic_inc(&cachep->nr_allocated);
+		uatomic_inc(&cachep->nr_tallocated);
+		if (kmalloc_verbose)
+			printf("Allocating %p from slab\n", p[i]);
+	}
+
+	return size;
+}
+
 void *kmalloc(size_t size, gfp_t gfp)
 {
 	void *ret;
@@ -156,3 +226,47 @@ kmem_cache_create(const char *name, unsigned int size,=
 unsigned int align,
 	ret->non_kernel =3D 0;
 	return ret;
 }
+
+/*
+ * Test the test infrastructure for kem_cache_alloc/free and bulk counterp=
arts.
+ */
+void test_kmem_cache_bulk(void)
+{
+	int i;
+	void *list[12];
+	static struct kmem_cache *test_cache, *test_cache2;
+
+	/*
+	 * Testing the bulk allocators without aligned kmem_cache to force the
+	 * bulk alloc/free to reuse
+	 */
+	test_cache =3D kmem_cache_create("test_cache", 256, 0, SLAB_PANIC, NULL);
+
+	for (i =3D 0; i < 5; i++)
+		list[i] =3D kmem_cache_alloc(test_cache, __GFP_DIRECT_RECLAIM);
+
+	for (i =3D 0; i < 5; i++)
+		kmem_cache_free(test_cache, list[i]);
+	assert(test_cache->nr_objs =3D=3D 5);
+
+	kmem_cache_alloc_bulk(test_cache, __GFP_DIRECT_RECLAIM, 5, list);
+	kmem_cache_free_bulk(test_cache, 5, list);
+
+	for (i =3D 0; i < 12 ; i++)
+		list[i] =3D kmem_cache_alloc(test_cache, __GFP_DIRECT_RECLAIM);
+
+	for (i =3D 0; i < 12; i++)
+		kmem_cache_free(test_cache, list[i]);
+
+	/* The last free will not be kept around */
+	assert(test_cache->nr_objs =3D=3D 11);
+
+	/* Aligned caches will immediately free */
+	test_cache2 =3D kmem_cache_create("test_cache2", 128, 128, SLAB_PANIC, NU=
LL);
+
+	kmem_cache_alloc_bulk(test_cache2, __GFP_DIRECT_RECLAIM, 10, list);
+	kmem_cache_free_bulk(test_cache2, 10, list);
+	assert(!test_cache2->nr_objs);
+
+
+}
diff --git a/tools/testing/radix-tree/linux/slab.h b/tools/testing/radix-tr=
ee/linux/slab.h
index 2958830ce4d7..d7aed1cc6978 100644
--- a/tools/testing/radix-tree/linux/slab.h
+++ b/tools/testing/radix-tree/linux/slab.h
@@ -24,4 +24,8 @@ struct kmem_cache *kmem_cache_create(const char *name, un=
signed int size,
 			unsigned int align, unsigned int flags,
 			void (*ctor)(void *));
=20
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **l=
ist);
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t siz=
e,
+			  void **list);
+
 #endif		/* SLAB_H */
--=20
2.30.2
