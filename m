Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE495421BDB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhJEBcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:32:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51672 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229549AbhJEBcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:32:51 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19519htc019232;
        Tue, 5 Oct 2021 01:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=QUUmOptoT//G+arebZug5MSDuhuq9/8Lx6E8dBP54hE=;
 b=NKgMD2msP00eLz0LC31/hRlV0X1VpN4kbHqWainLZX0Morz+wFcErYcZeu2A9rImONxX
 AKLVMK3sY0z+vhjq75JyqL1DXPIpsSkgelnVl/synFti1FRmHSmt2QlMdkGIN3K8F2v9
 fErHKbhllUy2hlWkFgljAskeHGGy0aOTRPrnnFGy5XJwP7mZDSrXlsdeL6LhHNSzBXpo
 R1DDkLpf2nunE5lcMfzOSg1oHu293X73aEmI8SbcgFaVafNaOo9uuoJ4Omu9j+Bm09n7
 kcTsbiPbsucMsPQbbdYEBoIiq+wmOHzSPvYS/wyEyBeb6CJMuOFU58idkqGfZ6tzJoaw ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p5c954-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UHf2178354;
        Tue, 5 Oct 2021 01:30:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3020.oracle.com with ESMTP id 3bev8w02af-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1Sf0M1pTlY/0pLYHlaJef5WjgDvNJ0HYLao+UjB03SuZIK8/j6xQ+MEmISzsdPgOM364R7Rz5EdOnpmJMQD+8jlbzJQE2gzQ+mbmF4PWrOH6uqNw6P5jHdRBhr6MGL1xQP8l4D11os8zMhNHOLx+R0nTChtfJShWit//ftN3Bi4uj7+n6nZBRiqL+OCKhaEULYOuNxoumRua60eDYorZiurC5Fg6Hjnw7dJkCuSq88eyj6dO4jZ+BW+7h5NqeK/TgL4+7a7Ff3QNPQ4LM/ShvXjR4A5O/9W00KywdlcE5+jXFnLhP1VbEK4nbQ7hDLfurT7Ppx8Y4m6/ec8hLIJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUUmOptoT//G+arebZug5MSDuhuq9/8Lx6E8dBP54hE=;
 b=KiR69ADxG7B3FtXc5LtYo5XiOrx5V9xX3MF3zkkJUykW/Abvch0/sa9jKrDjCtb5Xyco68sFnx/88ovALTMqPx5YzKntRrzYUbv3AB5An9EHvoly9Grxpj4nRVJdWW6wCcZ15VURgTk/niBs4i5OFVnnNLw/ZW7j2xYso5UkEwUKmgvH5+dxDnWs/LyWJVxXLUq6OJXZRMUEQ7YSF7zBWwg55snBpxpcMKU1LtnyoRKNLoyOTEtKWQw0RFb12SDfWMEr+SyYpgOGhb2KhVvuYXMszud+B4geKNaProqqmgfq78Lj9d9Yj+yJwJScZWXkiJ7mXuC3/mTLfAGdXWym9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUUmOptoT//G+arebZug5MSDuhuq9/8Lx6E8dBP54hE=;
 b=wyz57BG4cCwU2ofrT9KIuVNhc+XfiLYE0j9P7UglaR7i9rURRkQLSGRBTHm39MStmSvbirjAtMegcYvNnXCoj9S56MLcflQs/2kov5glIa8refXALwp40pvr9IL9VhbcknxD/VN2tjD8lnuXdS7D0JOZSyRtnjrlxpc9JNPGVs0=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5218.namprd10.prod.outlook.com (2603:10b6:208:306::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:26 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:26 +0000
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
Subject: [PATCH v3 02/66] radix tree test suite: Add
 kmem_cache_set_non_kernel()
Thread-Topic: [PATCH v3 02/66] radix tree test suite: Add
 kmem_cache_set_non_kernel()
Thread-Index: AQHXuYiScYZkD9Q81EWBZfAA0YQzgw==
Date:   Tue, 5 Oct 2021 01:30:26 +0000
Message-ID: <20211005012959.1110504-3-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 10985466-dd8f-48de-4bd1-08d9879fb57c
x-ms-traffictypediagnostic: BLAPR10MB5218:
x-microsoft-antispam-prvs: <BLAPR10MB52180355B93A737A27E17AA8FDAF9@BLAPR10MB5218.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pLTM1wL+ZAp21IAffoSxj1ZzoNkG5DQMGBKWsYPoTDrrUyI+cPiH1YapzYRYRpgOs5ZZVVrAzT+YODP70lErwjsQXqR0eLx3hw0ljgSOLDl2KlI1n/39LrkhRFt/MRfSjWWYTpgH7ZzeY06FUE7S6pWIita6CAss7JjSTB+KI0upyVgsCEITdy7BYnLlc6mXzatxzEV5qwPKEber6Bw1OPeob+FQmWranX/vNrGbh4h8y3+OY3sim3LJFGds4XHHHU4+6RdupSuevr9e76P7xHMXvHg51CldN7BtaeNhE4aScS8ZzzVD7xEVkIXOB5J2HMkiBTkDuwpn6Ga1DL+lZMvyGESMGI66IgFnQdbIkLkhwYeks8/l6XK0gV1oWVFRkFg2ieot2sw3SfeFNWMI/I8Yfwf92wOk9LE6tHzU/5OI80c+E/nprD67bO5Ys+Xy4pg7wrw+Kh5Vy6htJjKvo3QSbWdR+9ICY/UK0dygap7i9MI4hHA8IHIZzinlsabWtPTHtoChpBIOtr5UZPyLF7mADMebaKenCse9Izlwxet5cgwxrAuBtOKSb09tM1aVqWdoaAaFb/ZP2KqLXDe+jZ7ypfXvPI7Ihwelob/SFHAXTukeK2q4sOei0XWd4TqHtIsUlZgO9rXglp6cVAWkIVkxwljP6XDYtTwv0ZyBBiTZkNGIUgRXZoSAhbuNTXIcJaC9HXYtqmRsarF2i2TIXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(5660300002)(6486002)(186003)(6506007)(86362001)(6512007)(1076003)(36756003)(38100700002)(508600001)(8936002)(71200400001)(8676002)(122000001)(316002)(110136005)(76116006)(91956017)(2616005)(44832011)(7416002)(38070700005)(54906003)(4326008)(66556008)(2906002)(64756008)(83380400001)(66476007)(66946007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fAj0GSt9bvtn2VnnM+e4CHKFqseJy41vbAT6OKiwQxeNDJNg2HBWnaQ7sC?=
 =?iso-8859-1?Q?jHu6yXuLKeV1PvrI3txKZVXVuZMyh2tzvQ5bm+EBFo9suhLurF2zycHU/9?=
 =?iso-8859-1?Q?mAn/UHDZ6HdBqSaouyHBRIhu+BTPbZeDmvRhTpP1Qn8k5IZpwIqsjjXwxY?=
 =?iso-8859-1?Q?oaLPwjNC3g1cgmgEMY8xh86j+9mSUo49iZgNyMmWErfb81WxU+cTyHNVJB?=
 =?iso-8859-1?Q?xdGgfD8pm1SAENa5V+gfqifDAfC2uDNgLptYu9ZEzd8Yvwq5EMrbX52HF4?=
 =?iso-8859-1?Q?jtiOpMOZowKTVa9hHiF5qghq1c8rW799y6W6icfTm15DKfFXpIXksrAO7E?=
 =?iso-8859-1?Q?ciDN1s82zHUGiCcaegR5v3lvZT8WDgztDQQhJpJec71Pb1VtHxUXn+Drv1?=
 =?iso-8859-1?Q?UGsoD6SjfiHuwxhCHVacIZZxoJANGWR+dgi/dXjo+CW1EMzhScnj4X7w/j?=
 =?iso-8859-1?Q?YQCA8ms+1JBGLskpn8cdIYoMk6N+BdFwwnrldO0GM2a+8wpakmctBj4+su?=
 =?iso-8859-1?Q?eTO8mdWDmBJ0k1wgpWUWYssFTYCwUCIsS6JpYTtyjNsR1rG9SUnl7qciiL?=
 =?iso-8859-1?Q?AwOQc8HQyfj/qT6axktcDvlH7ddlIbJJbtJBicCGrephcu8WU9C1kYKAha?=
 =?iso-8859-1?Q?IznP6qNuT80ZzgRcqm155iGGSbtMyz4mpKkWPwzMgDBl5QMoENNrrASuNq?=
 =?iso-8859-1?Q?y9xgl4t1TughPPqCqkeBYMPVi6Y6j3In1fTaBrtM5pcwlAETgbjny39W6Y?=
 =?iso-8859-1?Q?OiIqfdJ/qE8O9tgUXKV1DN4XifrLE8FVax5Jg4YrQFMvrRdPZDYfWoT51T?=
 =?iso-8859-1?Q?v74kCCVEb7Go2xsGhPFsWKIKAH1hK8EntByOE0dIMkaq5eS8uqE775sTFt?=
 =?iso-8859-1?Q?pn3378z/Lsf311AVrJUYtgnu2Ua1krHeTXNDhhZlE234stCmj+FvBOotPG?=
 =?iso-8859-1?Q?a016U1HNk6k5w/jcasKtAy/HolCheOrGhp1ZNrG1GqgsETO3z2rI1kA4Bb?=
 =?iso-8859-1?Q?iglrdFe4xuQyt2ibIAxB3OjYplINM3vnZ0n4nARdITtCuF13B8sIgJyZxO?=
 =?iso-8859-1?Q?zWi+2Bg12Vx/Pow27CTc5QQuJZoKsK13AIXnazYtJvkmfOVpB8b/JlbA7H?=
 =?iso-8859-1?Q?FfwU6QP+XjQwBPCx2+p8Hiaiu0xCd3yqNrCEHVwy5dTbyQrM9chb5hc58z?=
 =?iso-8859-1?Q?qt/rGFyJZFhKtXi6JlbEfLye3NFN1F8RlY7udb4/CXe7X4bZrVzSiivFV/?=
 =?iso-8859-1?Q?Axo2CSVYLIaDekSDcxivpELMFW40ftnvKCPghNzOde4tCEsQprdOA5Nyx5?=
 =?iso-8859-1?Q?DG27vsaE4tT9wvPMgIONdXMqHeyZoPVl9O8WlrigiVl/K1W5WhtbiBwJ+v?=
 =?iso-8859-1?Q?MWq27tsaZl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10985466-dd8f-48de-4bd1-08d9879fb57c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:26.0719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dscJaXXZZxA/tx4kKo2kwoa77+rtK0va2TWQUhaRXTS8LXDDJa565aHBtdT//DWX0W50HCgRmnfN4GQMZw1QHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5218
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=974 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: E51TyVR85NG6R1HtMgebbdf4nOvHz2ga
X-Proofpoint-GUID: E51TyVR85NG6R1HtMgebbdf4nOvHz2ga
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

kmem_cache_set_non_kernel() is a mechanism to allow a certain number of
kmem_cache_alloc requests to succeed even when GFP_KERNEL is not set in
the flags.  This functionality allows for testing different paths though
the code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/testing/radix-tree/linux.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 2d9c59df60de..00ee01a14652 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -24,14 +24,24 @@ struct kmem_cache {
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
 void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp)
 {
 	void *p;
=20
-	if (!(gfp & __GFP_DIRECT_RECLAIM))
-		return NULL;
+	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+		if (!cachep->non_kernel)
+			return NULL;
+
+		cachep->non_kernel--;
+	}
=20
 	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs) {
@@ -116,5 +126,6 @@ kmem_cache_create(const char *name, unsigned int size, =
unsigned int align,
 	ret->nr_objs =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
+	ret->non_kernel =3D 0;
 	return ret;
 }
--=20
2.30.2
