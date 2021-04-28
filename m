Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C4436DBE1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbhD1Pil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:38:41 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2522 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240135AbhD1PhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:01 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMtdL020250;
        Wed, 28 Apr 2021 15:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Ko95yPT4hn9j48VnzFl27Nm7UsWHxfA6ppChCNzQN0Q=;
 b=alXZkej9nUcP212mbkhxuD/0D1sRYeW2ZvP/UpdaWdDW+AqJHPXB0K5tCyvaUvYJZ53X
 YM+mq/cEmmUKgmvgJhyoZ9O9tpz2OmbiWbuZ9d0i4CLYG5J5prPMtlehZJ43o5IDUGMu
 UUhiV6udtBPjLpe83etofjfTl6TVP/V9QiJhV9nf9eeJBp8YfaxkyLkpq/Mi0SCNqmqb
 +n9mWwKTznywmbJC8ewtU3IUU+RI4N0iiqevDQkP3MpbzuoVU8cdbxV8mx8P4h6dvr4+
 UKnTHlQjI+A9ZzzVcVOz4WaypABf3N78tGk/fE9RXkSjzRl6HbY4oZiqKEFEqrnlXsH/ hg== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878kgg51p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:58 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFRrsS124479;
        Wed, 28 Apr 2021 15:35:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3030.oracle.com with ESMTP id 3848eyqwaq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPXnSx0rxORHFH++KmpZxHK4hDosUcrGAYVfzoAgt3BJ+3k1NvUHfoU3tftvHlA5Y+oqHb/k48MfeX3i8EWIFIJt+lyBcTa6Q8g5KVXzKC2x3pKCGusywq+Fy5mDvNmsURzfiz/oxgKFu0WRnOc95rM3Iy7UNfaTvEUp18Rufxg8GccVWn1gvq58HseQ8QGyt5HvFV4q3bp6nKMjyWpCQH3DCOVLYFftVsGlAWHRZg3dXoLcMsOr+ioCYlb7USdJrm3Sgb42OzJTtd/s05roouFrJjiwxOZ17lh0jkQr77XSntiFG6ZFNOFnQjw6oWqRLQXeld5D1tKH/QyzEMIvWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko95yPT4hn9j48VnzFl27Nm7UsWHxfA6ppChCNzQN0Q=;
 b=mSgJHMJZg2egEnsoJGy8S3ZXMXTaph+ealbaUbTvyyaYT4cHgTV5bRorjC1zRItSC0NGM0LweakACtxP3mg1uqLveahnP4sWUl41dOgPXDkexgi4pYc5krHdZDhN7ENrCymwdZr++CYMQplhSMufwFoPgJjDtR3x1/KyxlRo02P8lwWA+bwNKXzj6iwUK9odCPYBAjqYSQf5XevNEmgAMzOG+LqxM+1bsdQ25KEDCZUqJXFAalC9+7pipf5/8ALdwKQTHbvw2fLvKs0zZCIDZFlxfORWuNKyIUn/iOE3pHnt+odDq72/6x64nvFfyd9BPqHkEHtok03wTNnEWeOpSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ko95yPT4hn9j48VnzFl27Nm7UsWHxfA6ppChCNzQN0Q=;
 b=hcZpPAFIuJbAYhH922yyvSyj81QtBZQJrUzgl40lJ7PUOmXrUiKiYcPhK+omBtekprR2gzAhQczaJ1Whu42X8mjWNv2RVEiH13qJcH8cZ9Tgf4kN1PYK0sMcwXzXqXUCdUHjsNXAQSQ4pa0upEp8a5al5AoBI/3XIZitWeBWoys=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:35:55 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:54 +0000
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
Subject: [PATCH 21/94] radix tree test suite: Enhancements for Maple Tree
Thread-Topic: [PATCH 21/94] radix tree test suite: Enhancements for Maple Tree
Thread-Index: AQHXPEQt+WoqT/epcUyBrmonyn+D/w==
Date:   Wed, 28 Apr 2021 15:35:54 +0000
Message-ID: <20210428153542.2814175-22-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 4ffa4234-11f3-4ae6-b9de-08d90a5b4ff9
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4769E7D23F8CCE246804414DFD409@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mJyn5s0NZi+NCq3UFH8qUdtT5YJ9T8e6u63KjRxHMXFuOWyTZ1IrzI+jMpat2kyi9c5phyaHCqn/Vyd111xSTffk2OyJB2NaXHs1mM5HX/9XGa9bsZRIneHFWXd+5FNQAe+ZbyTN9VWv44GnK/Bl/IS/s7zMQvwvyzdaZNumiOj1xYaUfimxNZMpXoj+OIFNS1iwcKX3iHVCaAnHRR6gl+B4qnYEBGrqXc7RZK08bvLOyiXoAAXYpzvIfOAwp07mDLT3vmt3swdQZ0EbYAwjOhfh2XfPzuyVjGTfFf44L9/UMR9egoDvnyCFc3oo/tzErhI3yO55SqHf7GgvD5HzVNwsVf9Yxg5CbViIAyMp6EurvaeOUKWnRnGd9K3bmDelXNXpWiLk/Exn2BZhHdEP4qGAiB3NpRSWCkedGSfSifES/GTLYNKI3Xn0HchS+vB3mRsc9ftaK0yVgSAJZtMA3dpFkbqzoi56HV+CDSsbNWN1x+iACLAdry5V650NXVGflamC43GWc5MR3t00ja2uiy224IzIhK4h+d6bb3KmtNjp4MM3ng+axLKVQPjEs0hXrZ55LloVDBJOIqWwXuf4o5AQE3aWlQTNL4eHcZgajmg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(6506007)(86362001)(2906002)(110136005)(83380400001)(66946007)(38100700002)(66446008)(66476007)(54906003)(8936002)(2616005)(8676002)(66556008)(76116006)(478600001)(36756003)(4326008)(44832011)(316002)(1076003)(107886003)(186003)(6512007)(7416002)(64756008)(91956017)(26005)(5660300002)(71200400001)(6486002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?OafIn8rQVd/8eQmn549aZH1/4h9/nWKJQIG6kAZusu90nJMFbxnNJwM7G4?=
 =?iso-8859-1?Q?QtyrosecgwzmLx4IyFOFpEDpus5YFUlKVGWWUTVj+72Yq0pDT7aw7jTmv8?=
 =?iso-8859-1?Q?SQ/Dk0NGhAL3OOB0KodgOcgPq57LOkXgEMWUEfKiTMInLn1pbqmEL7M6Ki?=
 =?iso-8859-1?Q?lSfzRtrmyy3ksrpoN/9suIKs5WS/1mEX4t97VZL36EMfszfWc8inNdFVFo?=
 =?iso-8859-1?Q?+MJqYSl64O6ZijP/X0lcKgQUj8Pd9nDDM5oHnOhFkV+59NOwwHNNjLLyHo?=
 =?iso-8859-1?Q?yuNIdazS7l3VAP/tGSiLzXEBhViHNcsJoQQ+V3VlrSEWe7Q14x41TaB4rM?=
 =?iso-8859-1?Q?PLh7cxbj+eYftDoulUwfZ0rNi0hGCHQdqIGeLg3RubEBQS3GpFtK5f71/y?=
 =?iso-8859-1?Q?+CanODp6czKI9c1Jd/Znr5TCDT64zZYhnnDu8XSyAkixBxAFB3YM9J8oSi?=
 =?iso-8859-1?Q?mvemb7KyirEoO/BkM39J5a1u1Qwkbdjm0EljuEnpEbMIgALBFCGxKp9fRS?=
 =?iso-8859-1?Q?MHc/YR2XS991/JEDt+9AgiY11xw7ZXCQU9MqiwHzPUlU1+OkZXV3m8eVVI?=
 =?iso-8859-1?Q?wla7plqjPQUE1JAzfjZyh5LVPOfNKqgzSiFcHzOTyijMmyRfxVJoCgyMx4?=
 =?iso-8859-1?Q?L9b/eMKce4MxEb1d3slLeuuJKtjCk51z/n9AlkW/Zei6UtRt5tvgawKZR/?=
 =?iso-8859-1?Q?0tt2wd6tRk88Jpl2yu7EhJ1Dl/xZzQtUxoXpqhZ+qd0GO864+RJn2uGasQ?=
 =?iso-8859-1?Q?zMKHTf4YPhtadcyYFYSQWTAyKhSHYd73jXKC5uSEeOhTKVpwQFB3D7+N4B?=
 =?iso-8859-1?Q?jF0xJsYTc1FgXys8nuSuFQu48yZXJx5FSJ1j+/GxfyPQEdwRz5P+z8xRhP?=
 =?iso-8859-1?Q?cIhGbIMenZXi6PuA5pHumkdjmvgCURu+mXUTiDGU7mGZV5W45+jQodf4V4?=
 =?iso-8859-1?Q?fuXG5BaF8qMHQvGqVCy0PqLCk9c/YeyxMPLk6v+Ag0ZAMCmBimnm0VG1lM?=
 =?iso-8859-1?Q?4nf4P6ViHM2ZddNzl73ovaCPP8BxjRffxDrZ59Y5tIRpXNGSYsrGL56G2I?=
 =?iso-8859-1?Q?HVesKDWTl2bUuw/DiUnhZgINcMmC9x7G0XraeMXy61qNhJvXxP+/DUNrkL?=
 =?iso-8859-1?Q?P8re0iveD8xwNbPGdyRsjUurET6+/OWszeYOWDoBC5xlewEdfb+9tMUjD/?=
 =?iso-8859-1?Q?yCIxTbecr9jPiz/IWGKqUwX0PQLrYZNo+YTVF43Wbp6czywtFETc3U1iKW?=
 =?iso-8859-1?Q?Ydu9GFz62wrbnWNgM2h0I0jg90b7+VPsjUNWtrczH0vAw1mSL1VPsbNpX+?=
 =?iso-8859-1?Q?hLur+jbjQfX62jIhsC3UEMhnNgCDb9MkEkCPDpidoWlukd/Vo5k0ILFgP9?=
 =?iso-8859-1?Q?lswtFNOPCa0bsJaVZcJz8K4MFVEsjeVQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffa4234-11f3-4ae6-b9de-08d90a5b4ff9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:54.8534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4yCPflx4HjLyF+PuabNauWAzWr2lTrpoFIzXAeNlLtt06/iP1cMqAMfgO7/5kfZ6kARDRCtmTMElG2yCWSdOMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: V_U_fFFkbvXG1LDlcggay7xr-xXPcJfF
X-Proofpoint-GUID: V_U_fFFkbvXG1LDlcggay7xr-xXPcJfF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/testing/radix-tree/linux.c        | 16 +++++++++++++++-
 tools/testing/radix-tree/linux/kernel.h |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 2d9c59df60de..93f7de81fbe8 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -24,15 +24,28 @@ struct kmem_cache {
 	int nr_objs;
 	void *objs;
 	void (*ctor)(void *);
+	unsigned int non_kernel;
 };
=20
+void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val=
)
+{
+	cachep->non_kernel =3D val;
+}
+
+unsigned long kmem_cache_get_alloc(struct kmem_cache *cachep)
+{
+	return cachep->size * nr_allocated;
+}
 void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp)
 {
 	void *p;
=20
-	if (!(gfp & __GFP_DIRECT_RECLAIM))
+	if (!(gfp & __GFP_DIRECT_RECLAIM) && !cachep->non_kernel)
 		return NULL;
=20
+	if (!(gfp & __GFP_DIRECT_RECLAIM))
+		cachep->non_kernel--;
+
 	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs) {
 		struct radix_tree_node *node =3D cachep->objs;
@@ -116,5 +129,6 @@ kmem_cache_create(const char *name, unsigned int size, =
unsigned int align,
 	ret->nr_objs =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
+	ret->non_kernel =3D 0;
 	return ret;
 }
diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-=
tree/linux/kernel.h
index 39867fd80c8f..c5c9d05f29da 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -14,6 +14,7 @@
 #include "../../../include/linux/kconfig.h"
=20
 #define printk printf
+#define pr_err printk
 #define pr_info printk
 #define pr_debug printk
 #define pr_cont printk
--=20
2.30.2
