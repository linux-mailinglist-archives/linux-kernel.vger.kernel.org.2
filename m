Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2C5421BDE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhJEBdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:33:04 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63244 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhJEBdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:00 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951OdX8010252;
        Tue, 5 Oct 2021 01:30:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+54JDV0CwfFMEun9TA0IU1DN8fUJ+zkLs6ezMryWlLM=;
 b=KPSfRIPxhQP4iV6wjgJKhwz/Bhiv9PomvswESSgWIn0yLDplFFbiUHGQwRmcAA6clD6M
 GTGXvRrgB8a09C74+HuB3WRzzadCITxF6WXhz4CVILCRShjoIbKyURSX+wlRsgWr+/jR
 R0GD3HzTm6FXB7vdnRPq3kyP1oMugR7iXNUwLVefQJaNWDA0TqJflGf/Z3Zv81hoxLDF
 YtJ+fNik66SUWB6hMYG3xZU6MQFuW7dNxBedKNUxIfTyyfLhZnIYEZLrkALsEC23671v
 q591PycwNiN3Zxy0J4uLjnbOZcvLRQABi5lA0bAvTcXco+fnciPnOznWuR3AVdTx5nQD gA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3upv334-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UHf4178354;
        Tue, 5 Oct 2021 01:30:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3020.oracle.com with ESMTP id 3bev8w02af-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crUvjpbPBpigQmsSBaB5HT4otJXe7wfMDdIHz9T2CxuIeLBAnbB4UmehhzyfUUkDHBdgWVu47K/VBZx5VFVTNHLH3UuLzPg0cZj31S6X76uxTgXNnUUC/HcSkB7luITJ+YkcXRFv6wMHOm6ig9begVfdQUO7uUuzyWJFVJmcJ9cRS1SpOV50rFa0v2ujUTrsLV15sKlBXj2J/ADM0BieXnCySJ9MlruA+/ioVLIgnppwicGPTuRxCTlc3ofIUu7wfbbJ/DFLy9BXIV3CEmi9cKZN1Q3a3lbxIOOCYSrvFrEk8TbVZn4Mx1D8Ld0X/5deAgZp2M71K/8thmTnByARyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+54JDV0CwfFMEun9TA0IU1DN8fUJ+zkLs6ezMryWlLM=;
 b=ZBPonQ+Mu9Nrlm2fAUcCbz6WAqBnva7GBDq8YQTp+dJJTSOZibTaP/RmamyUx2EgSdZ8VkiBusEX+Krmy7Zq/aLnboVwIqhy05zVhnYEp1WOP6xiuYflgXHG3fZ5kJq7J5+hFzriwkq56r0WgIj3eAh9diYDtlc1g8IyvU8alIIRl/kFze6TD3MvQlalhSHkI62bHGQ+RBZW5IQTt/s1VaC5mityrepD/IIwi4qI6EAlUVDq3/OUOR9P7pvYqLT6vh45N7x9yru8XLnOfoIWbKwxTuCz793yIwmDKlrIICouhb/ZjXvY658Rnxca1Mb7N2fwO2zo2qp0MYp9XaybAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+54JDV0CwfFMEun9TA0IU1DN8fUJ+zkLs6ezMryWlLM=;
 b=AO/JGe87syPJXTAWFNdy73/ver1xMsQAvQ7WZgsTadUXJEILEIcmqGFZ96i37gibG99EWdxL3PxnRcTGR2Iy+NvwPjYwkeDCEXjCUNS2wjxnULuUba1WybiURpjF0hEQWzQT0dbwCN573S5A3Te4qI+MJik/zCkRtOAZ3c7oD/A=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5218.namprd10.prod.outlook.com (2603:10b6:208:306::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:27 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:27 +0000
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
Subject: [PATCH v3 04/66] radix tree test suite: Add support for slab bulk
 APIs
Thread-Topic: [PATCH v3 04/66] radix tree test suite: Add support for slab
 bulk APIs
Thread-Index: AQHXuYiTBB6IAxrBTUmkVdtG/wQblQ==
Date:   Tue, 5 Oct 2021 01:30:26 +0000
Message-ID: <20211005012959.1110504-5-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: da255dfd-875c-45bc-14f8-08d9879fb5e3
x-ms-traffictypediagnostic: BLAPR10MB5218:
x-microsoft-antispam-prvs: <BLAPR10MB52186DD15020D8386BEACC9EFDAF9@BLAPR10MB5218.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CG1Tx1ryEFLkc3c5fx2jHkbrtG2qEIi7VewgWg+1ioZO7iDLQ0MjP6QIV9p1ywY8CA4rHrM5CtlmH6+LsP7IEpCD1L1A2MHwhJC0jVhYQZL0OmUdKNPKy1bUgirdx/CuVPR4c5opfDF1oPu5h0lPWKdepPfP1iFd1PY1XyP2iT/8W6qddFfto82OGwTypeyjqpAacO3xskIjg2ov7VmmQ1bJIovwfZXt4PSqRP6ErVSy8mHP0KyuxJDe4Tp9qkBt5haXJ/R83FFQbZjy+vqjN/SuHhRKLCe8RFGPUvpX3DHS/HTEAKzTCtT2Cj00G576FNFbgDuk+wDy29JSYP2CGeOEvaGcdsgJXSZLpBq/HsQ6VZ1r7JdTnQ/P1T9i8NT8lRHYkYJNuLTcGlUIFhtmFh9kh+LoyzSNHFlnzOJbEGLJqAHtnTfczUle7SwPAkx3jSY3x5GdeyM4XPYAzk9JFBpswrLqmfsTxMT/qSVDHKllDCh3BD/jHyfEGK3WJ8tiioiE1c9Z6KJfYaDVlOAD54GPD0jvqe/+GGIglBVcJnBbzfrJ5k7xqPDkgBP3SV0zcmmT0U7P6PAnTw5zGVLAVl13Q15y41T2ULtsa7J8qeE8gaA8TNqX6y+GEKVPBGUJBRDc5w0VHKT7ZYx6LLM3AsL/0MFtqvcapTSq68554TCllLX/ZpQTxM0L0n6AfftDkSRmh0TA/eMx6gHS1wo93g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(5660300002)(6486002)(186003)(6506007)(86362001)(6512007)(1076003)(36756003)(38100700002)(508600001)(8936002)(71200400001)(8676002)(122000001)(316002)(110136005)(76116006)(91956017)(2616005)(44832011)(7416002)(38070700005)(54906003)(4326008)(66556008)(2906002)(64756008)(83380400001)(66476007)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fAyBlyT9hplJ0/qlxuIBzEws0pFCYsa5+GnDvtUB6oxsi0TQjRotYIUsBu?=
 =?iso-8859-1?Q?j81zodUDKela54iAFuXxWCmAprhi5T+rurZjByh+VUu7SynHrapCeK922Z?=
 =?iso-8859-1?Q?chnx6H7uJ2ClPFLWY2wRniAiJ0G4i+cQqEtlPjC5I+vn0CPCnxKcOy/Onk?=
 =?iso-8859-1?Q?1YT6kCOTad5RLysqGmyWOLxvn6iSCDcVD5B6Zwvy5AChlEahV9aHYBNJq1?=
 =?iso-8859-1?Q?LOSBqG8cwSJ83gYsFBcc/ePmzNX/vPqJgvNXLc6YnYYcQ0NhEPcFBDalko?=
 =?iso-8859-1?Q?GVRFczvmecV4aweQRIW2NmJL3Qmf4DXcWYvFHZ3enuJkp+XebHYCTVGaTC?=
 =?iso-8859-1?Q?s93PUwrqllNlRnrMlo4iHR9XuhdjPAsvrMliMyhaP/CsYjxrqnZdh5YCre?=
 =?iso-8859-1?Q?BuPn6W81e3S1VlKUyNuKEI39qRs6F7Lu97EaAG5uw86IyH7bgTl0ruP/Ai?=
 =?iso-8859-1?Q?ttJXHXJ/HPIMQbgy+xJym+hWbV9oJxooejvrb8lCWG+zRQ3HDshOrD2OX6?=
 =?iso-8859-1?Q?oX4Amunma0qBz0pd9hyMNXvv+wK3pxOTIX8PavYdHbZhIUT2h+dF/9Lsqs?=
 =?iso-8859-1?Q?ZcoANE/KqxDM1zyFIaYor6/v3va/eXbyQsTgMjmPA2cTlQBagPjtyELeru?=
 =?iso-8859-1?Q?psU5rv3NrMCKqlDWew/2nRb9x3IqkJZQr7RSdMzdwGWOAdeUNw/F6pL3xx?=
 =?iso-8859-1?Q?HBnWPS/a4/DO+sVMh+ThH8Rj0aUwD4eJVR0MFO3frF1FckZc+w3qasyu/h?=
 =?iso-8859-1?Q?s7cQegw0cz87n0Qbbrywgzc6ceIfdXrah7cgu2Yo+hP1IJai5+2lc16STE?=
 =?iso-8859-1?Q?n4qC1Frye5YqPKMV4T6X7gsf9xaOOu7rajqAVnESGTZNohXQhnCDl88cOi?=
 =?iso-8859-1?Q?s4hVNsva4doEKwjmhGZ7VIImIREnow3mwLZ9Oh+UffnfScA9n2x3O1yLbS?=
 =?iso-8859-1?Q?a75hl5d7iY9bVQT6mdZNwMbYQge5ARbNQ8TNYf/vsZnf+aBz6F6UR0c6LN?=
 =?iso-8859-1?Q?ivWQHy7iq6dLvtfvmwGPjBnrK/EEDR6rPknhVY32qRyPX9vE2r2pC4PEiK?=
 =?iso-8859-1?Q?gAvc3h9s+QEpq4ehHYgEhrmgeQ41FoAGK7Tm8uad/KfBUbdlCpePSulxbE?=
 =?iso-8859-1?Q?ZNjn3vzmpUio69c7gCojAEs9ZEfOtrfUfb5mDO4OslGHe0MUY43B9IqI+U?=
 =?iso-8859-1?Q?/0jCFNnDRYgfXzvwRn6JoV2d0phe1hy2CAd6hFP1CqmVAe6jriKO4zgBXh?=
 =?iso-8859-1?Q?L6BT/s1SHRruRX37qH7Lmx6bBVJgGQrsk6EFjTsI/edO0YLsK5jU2x1Z09?=
 =?iso-8859-1?Q?nPJJ4ze45lC71imusVKIayUdyMDe9CZZaLzKlYldona5fPPBqaeNDTozf0?=
 =?iso-8859-1?Q?lZOzcfC5vB?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da255dfd-875c-45bc-14f8-08d9879fb5e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:26.9494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9jXIY7p0wxOsDCWVqxd26MfG5+HKzFqeVDxLCIqaQdscAKhF3h/Lp+ylLWhkV8P1+YhiHy3tboBVqTZuHI/jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5218
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: u6bGm-N1BJOmLlInU2JajW-zVMFM7UIt
X-Proofpoint-GUID: u6bGm-N1BJOmLlInU2JajW-zVMFM7UIt
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
