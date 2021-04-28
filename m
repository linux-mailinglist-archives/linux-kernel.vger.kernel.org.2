Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072B236DBEC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbhD1Pjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:39:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21374 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240315AbhD1PhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:16 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMCTI020060;
        Wed, 28 Apr 2021 15:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1wsCub1kmBsHcxvoRDj3hRVOcI6dR03359CQW2OFthI=;
 b=G2sRafs3Y7OemHBFyrJ8OBFjcUX/VZCSFKjAlDWVEosM1OJyyuYoWqCrytWEDPVZ796F
 htkz0utdS/YCBSz+3LnuAqeNQk8QDdcyVhNO1DbxY5ZpBxvFeatlcZzrhsSrwmB4FqA4
 C3b4kgvC96EBx9VSBCM84oBpT9LwzmuSAJRPTRfxwxeWgNkf74nhccPyxDAu9KmtzB72
 L+ZCKiq965I7XD3qi3y5PFeclH8FEkL9rvJXZKhoT3FWO0dFeUtZ8nX4VFbjRS3azWqm
 ovfzUDL14HD9jCq7Vd+NiZ9PCNGT7QzcRSCq05PH6ft/K0Q7p4fnFmEz+MqaenHWrDgp Cw== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878kgg51q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:59 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFRrsU124479;
        Wed, 28 Apr 2021 15:35:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3030.oracle.com with ESMTP id 3848eyqwaq-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ep0d+6AoK7qQCI9I0waCIWmknCAvdNqTAOq4/AOQCthm5qWJjV2u04sRi1poWHuTTypeVuAgHyTF0wb8v2KkdFffU3GquTKlWz3nGrn4DyhiPbFzVl+yE812aH5i2ojhs3Bq4jEfQX3C5KQr4wznPz9jvdjJpE+Qwzm2+n6Cx4tROwaCp7gbMyq2Ydp+CPlz19Zt9NFTgK8oIvmu0I+PQqd/ukVp/Q6oXWybyxB28hIwJPvmNtJO/hlYt7Ej5DTuTVI9u8uxGv93gK+uXMXwCaxBrNdxAT3U9uk/146x6sHQ5DJLhmFij9YBkqutRA+wi17hw/A+IoWDVIz7lVLWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wsCub1kmBsHcxvoRDj3hRVOcI6dR03359CQW2OFthI=;
 b=mnQ+EXznmKd07Ib8+Zo9wvefPdXYrMfwpfV5TKa8KxF4GExcYJ0xusFazxKaqgxnCIVhn2zc42ASoAsWFJiFxPzqEYTCTFGYUfHQZhF6hRml9wXQ1OT/y2DSiZVZ4kTnFQxdN4X9rqR6FNDBmi08r2aZx4M6aPrmXw7B787n+WnLIC8Kswcud1N7W0x+7K8xmV1zQctDXiqqr3IwPJJjdwJpKTiSr3/ORUFoCXwaZ8ypsaCQaRhRuny3WxgEqxkoQ8RFU8zzOuQTQSuZYNCvCUzAq4Brk7RtPVqmqSuItQS+RVaLjSCzOheOqzT13tAswA/NbcbnHL5xWXFkM8Lcqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wsCub1kmBsHcxvoRDj3hRVOcI6dR03359CQW2OFthI=;
 b=Y/iJDN90TDCmKZqOxKOW2DpL7bauObZ8F7HpNZmAKwrGICBGt26a8ubkoAySaDOVwu4JpoDwO9y5A9IkmewPavEXhviygjxxv76J3nP2tvW8oPsO0AUsoN52W/CEyX6yNkTlVg9sFREnPDFKR9JXhO30gO67GdUCJDJP1pHwU1E=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:35:56 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:55 +0000
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
Subject: [PATCH 23/94] radix tree test suite: Add support for
 kmem_cache_free_bulk
Thread-Topic: [PATCH 23/94] radix tree test suite: Add support for
 kmem_cache_free_bulk
Thread-Index: AQHXPEQu20/60aauIUGZQthGSVt2og==
Date:   Wed, 28 Apr 2021 15:35:55 +0000
Message-ID: <20210428153542.2814175-24-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 2674a31e-f81a-4268-61bd-08d90a5b5094
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4769BE5AD4396EB5ECC2BAD1FD409@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NGsNrZy3nIdUfMKADUvyWtAqNaUvjDgb1xIlDiagMCwhNUr1yZBQ0G3Eo6AS0/1tPuzSQ1oRL0l84IUkjxyjz427YNkf1Eq97me0jt+dfmQVfOXzIF+B53VZkbFgH9n/J37EdYld9zdX5WGpKIcZCHGZ53cvlf5sfYgRWa06Bn63ocSg310hpyevvFEMGMec1Fw+xylOZZ5uC9PGuzv6Xk+KUzXHCZrULEn9fV3nmAw5krkwaxfR0Rjt3aIDGNPY/6Z1zYHolJzHPVG0I6kmClv4I+ea1MHD8fuylNsYuZJLq+avIf2UJqVMb0HjLkj5X8dsB2ckc4UxX6VGgJLMbhieOdqjBHDdEViM+q6LrjGFc+My+EJIEI83nAdQn5r09nPq0C+P/Iq7SiCBCQB1zp2fQ5q5POOTQLbgF33cyfHTtfVo8Y8aul26dBuFoQdiaQjQaWvlUhbAdJFckLH4PKYm+q7rK0nBZ4xYFUpMi+YL6AbZkVM5BCy7hs38hAd6X4TyXHUwXU7gld3qogJEUZ+Jjp9GPBrBzjYtpOXh3Vp+iwbHIETt3n5m/Z116mhHUa7jb/TB6JavDmhZx2bgPDcTqW0OaMwlWD0DRhR8Zfc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(6506007)(86362001)(2906002)(110136005)(83380400001)(66946007)(38100700002)(66446008)(66476007)(54906003)(8936002)(2616005)(8676002)(66556008)(76116006)(478600001)(36756003)(4326008)(44832011)(316002)(1076003)(107886003)(186003)(6512007)(7416002)(64756008)(91956017)(26005)(5660300002)(71200400001)(6486002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?jh1L9i+GHU86Auo8FGdE4id34TTlgA7v/dk/35tp1twVB1W82S+vNnimdq?=
 =?iso-8859-1?Q?srVfhmC9zViwdSEBCcecairENke84FW3sZr4IHpRLA/NpFUCn/7IGjrbvJ?=
 =?iso-8859-1?Q?ppdqPD0Z4SpKC3/CQqoGTczGVYl+3BOp9Y3YrLHq6/k/HQhFadTD7F/9i1?=
 =?iso-8859-1?Q?IBW+XX5MQswElg7rhE5ugCxz6HESvU2/JGhqHabLjxmnCxU+RpIpJcYdNf?=
 =?iso-8859-1?Q?qLBoImvNhoaGnAIC6P6JvRBFSIOwhaPpw0xXVQAUMoeKVYcfpKMy2+aTsQ?=
 =?iso-8859-1?Q?wwsBryXJ2dLcjsNDX/GN+98Bwbe8k2Tbrx2HYhdP8XGB+x1zUE8553j5nf?=
 =?iso-8859-1?Q?A+5G7M5dFKU0c5okHb0xGuEbN9Yk5wG+Nh1nAkv46a7ZrSaeGDQsl+PIBW?=
 =?iso-8859-1?Q?UJnR1LAzGvFTK459xeTcCOsFcU+YC7R0QJT5zxrkiuuf+o/j3EnTK5FSw/?=
 =?iso-8859-1?Q?JfNtNuf9H9sjc8iR36iBwwG2s3g1L17oPMapDuyMuJsUPROIlbVNrg6xlq?=
 =?iso-8859-1?Q?2jg1ewsW9sls9qPmWOVUmxyepD/xvRp0/mzOn7rXAuB3aWp3RzuHBGF3wy?=
 =?iso-8859-1?Q?OfUorKrMnJBYaJFatYQ6khR+yCcAuawzvmjaOLbsK0NlIbVmo4AjUM36N8?=
 =?iso-8859-1?Q?7WL9JessVXsUtt6RPa5Ftm8QCwH77h3/5UjV0rpo66/Srk+SuYZTtvQAjJ?=
 =?iso-8859-1?Q?1ZzsKrk3iaEYJ8Ps7XyLXklf5X6uDKRrX2xflJnGAON5OsJF6BOjiODw/b?=
 =?iso-8859-1?Q?G80owAZVgYECAMMiuL6EVS2W+UvIRMjNRbpD/mUdsTRbmptTnBJ0lWtaZz?=
 =?iso-8859-1?Q?vMGgcS9QMkJoT/ahf8Gj/hpjOQd0Dcd0TvxqPMTyi6ICxZXAXqFeJLZN8t?=
 =?iso-8859-1?Q?vVMzADBKmCQGYHONeUeFdJcEiwgGt8wtlTkcFcMDTMUYbmqsVr8UWEQhHz?=
 =?iso-8859-1?Q?P1fekj9EhnaOOIJGVw1/SV5tK+2XucPPWIW5sacQYFBcza4GRHVuLsqmet?=
 =?iso-8859-1?Q?qWWp63tHOzN8xwHcsfVwGYmCouBPWKviale5UCGqRApjvxsk/ZUbNd+OF5?=
 =?iso-8859-1?Q?t5aDuWseWE8IXXRIt7TN6TLg75SoPhykM1sLM/xX20gYL+JrO47GXAp8fQ?=
 =?iso-8859-1?Q?wupxuqAeVV44NrEbG/aFHNudjp2KuyNQzsbG8WqvEIQw0tac1iVMLAm9Gp?=
 =?iso-8859-1?Q?wMFb00ov78eg9OqL+FkJ/YEwo6gTFHeMeNrIN3lbjgsJ8auQjflDiPcz3o?=
 =?iso-8859-1?Q?mGrcdNVtNIk/l+NgL8pApcOZyR9ck0nRlJBPCEMQPyEi1nGfRQYw2yZpTm?=
 =?iso-8859-1?Q?ZIEzugXMbyZZwP4EuIuZOzi2biexofnEOoJixOuQsQHHN/EfIV0hpqV2oZ?=
 =?iso-8859-1?Q?G+gUq7ymuDdFqhiQEjJFRkaTjEM87Fww=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2674a31e-f81a-4268-61bd-08d90a5b5094
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:55.8489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFDf1Cdr1mIkHQCLYw0bgBH41vKdIuIOgkCoO/MBnPojEPFL/GOYKC7vFZ9p2x8kKR8ItcMZjmTDY2uXzl3IZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: fI3iYI9_FOIa2hENoW-ikghEF38YVxnQ
X-Proofpoint-GUID: fI3iYI9_FOIa2hENoW-ikghEF38YVxnQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c      | 9 +++++++++
 tools/testing/radix-tree/linux/slab.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 93f7de81fbe8..380bbc0a48d6 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -91,6 +91,15 @@ void kmem_cache_free(struct kmem_cache *cachep, void *ob=
jp)
 	pthread_mutex_unlock(&cachep->lock);
 }
=20
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **l=
ist)
+{
+	if (kmalloc_verbose)
+		printk("Bulk free %p[0-%lu]\n", list, size - 1);
+
+	for (int i =3D 0; i < size; i++)
+		kmem_cache_free(cachep, list[i]);
+}
+
 void *kmalloc(size_t size, gfp_t gfp)
 {
 	void *ret;
diff --git a/tools/testing/radix-tree/linux/slab.h b/tools/testing/radix-tr=
ee/linux/slab.h
index 2958830ce4d7..53b79c15b3a2 100644
--- a/tools/testing/radix-tree/linux/slab.h
+++ b/tools/testing/radix-tree/linux/slab.h
@@ -24,4 +24,5 @@ struct kmem_cache *kmem_cache_create(const char *name, un=
signed int size,
 			unsigned int align, unsigned int flags,
 			void (*ctor)(void *));
=20
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t, void **);
 #endif		/* SLAB_H */
--=20
2.30.2
