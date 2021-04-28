Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB1036DC37
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241389AbhD1Pob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:44:31 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:40392 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240632AbhD1Piu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:50 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFM3Il013796;
        Wed, 28 Apr 2021 15:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=C37pRbQEaQeL2DJ6bpzdft46g26v84nOXzha1/PX+dg=;
 b=eQdCH+mNVZqx1ZE/pXraRg5+gyzp6yNuEcXy8KDNQhBeJTk+te8liR/uXuIEFZI3rAbb
 stVNrsPxmooQmvd7r3mYRLC21fhWfdIO4AmFRK1tI/ciN28wvzVUZoXLrDaMr7kH9RXU
 R27AFgkPoiTOtdpWJoTbGnyGHxFGdBV29s58kA4qtw8vhFsF9efn5gYyGa1MRI9gJTps
 +noaxU0lC5nK/qp+3Z+pa2WW+vyStG0WsjS6BT4h7iOM3EVKe858/hoiPtvAF3wy8xWC
 ugBMjo0dqnqZVVH76YT1QejSlJ9IQRs1O0dt7oDNyaCBSYt/QnjZGCb6RVKLLZoiW2ql XQ== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:32 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFbPch024423;
        Wed, 28 Apr 2021 15:37:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 3874d2765a-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncygwESFhbmVhbOoqWtH+BR2+tk14+KWQTsLgqpNNNV0YMcALmd4aGS/xMzphX3mIbi5W0MA2uW4OFQl6RsfW+amwQcilLkXgsOjIIN0ag00rNgT2RzncnIMjhK9Ewfoe6FNkbqZcZhAIFv6ElJzfD/3mbWCbJni6JLNeDhJhKIYOWQde1gdkqzxxfJeGLdA6TZvwuwle1Ke8PZTe+aWz5haJ9OnLwl1BChY7aejADNseQyZbsifqBZFgIGcDXrnhlesuEP3qg63z2b58uSYNNFdIbLsMuQZKQGrNiO9t66OayBRqP9iwP7bIqydZ6asCpYcAR6UFQK86rVdwDhp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C37pRbQEaQeL2DJ6bpzdft46g26v84nOXzha1/PX+dg=;
 b=L/ox+AxRqfvOOTybmdYK5WEd8tlzEyeQ6/IEOXg+eNzxZMpxNIF5zzkdDvfmH3au8m1Il4BSwBERNAWV5yOyLQ299KWUbWVAtOv8ExCffCgh200+zZ1p/Fl/U0R5umgCgrGoNbmKhrnaG8IgfuhLsuI59+fKeO4SfeKyuoD6v+E8VBE297sDoeXr3+pvmyLXGD8U5GSDdvShQi6APGRCxmY9NPXuxrtbcaKF/RQOXV0IBDF+vvx6mx6YTrTYyRtVlfWe6fiR3G2YDhlIe5fZx6y8o9XZM39UYj1RDfYbiHuD5f+YB4V8PMP3Uq0VyVL2oZS5lMZ1HCIgbHT6XjSRgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C37pRbQEaQeL2DJ6bpzdft46g26v84nOXzha1/PX+dg=;
 b=KjaSOfOCR5DGJzygdtK+3m2AbrLaPZHiwfWnEPX05kC3krYC6tfaEB3MUlRG+Qn0zF6Jq8arT84NRyKyinIkvUVqrm5hqFsjJudMP5CeVJVnff0R7UORKA2ZidaPZuLZmPWIs+gDryWrB5np19unmdg2/KI4ZIAcTBmEl/tPVC0=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:37:27 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:27 +0000
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
Subject: [PATCH 82/94] mm/mprotect: Use maple tree navigation instead of vma
 linked list
Thread-Topic: [PATCH 82/94] mm/mprotect: Use maple tree navigation instead of
 vma linked list
Thread-Index: AQHXPERBVNFP6yhP8U+ugGbxLncz7w==
Date:   Wed, 28 Apr 2021 15:36:27 +0000
Message-ID: <20210428153542.2814175-83-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 9ced96c6-01f2-47ed-7347-08d90a5b86e4
x-ms-traffictypediagnostic: CO1PR10MB4548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4548D1D86742EFE51001484FFD409@CO1PR10MB4548.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ooJxM+Qa0A67k/L3aLRYgZ6ymVs9hv3iQTRH7T6AEkyBIJAVPM6tpztKxqBZKsfy+5WzHM7n/tvPlSQt/fqUvIJcbsBt9vUE4z63+uEb81plGRB/oJHcIar21u4PKw8Ib0qrTeob+IBaN+gpOBwzBAoY30lQcFX6pdZvkPuJDbt0Q5exT1iHIo7qjN6b9YE27VeN7FDwdppdB3rCsVRXBe5vKgIXozl+w1XPg4qJw1I95R2SndDg52ei6MLBZhHoIQr/XLwqwQpcjognv/0nJljOCw8ddubpINOT6nep5DefBKkppMEkCdAuSgy3Rp+yL1DR7ZnRvGljG0ncE8l/BcYlSy4oDzzbfScQR9GUgR188xL/CFz2WfLA94catHEnX8UNSOZ7bcpbqZY+gprisW9b+KX4KXoDRUklzqvpXRD2978FUk2SzjqvagTRAvZr9iI6AYIkSjUXDuwQ1TSgs3s60kvz7nCKFZX6Y1nyHYPKP3F6SaDUPD8RgQkH7Nvth0/JDpDydIRCnp+e/nrgO7BDkyr1XmgrjCHfpK8DF3cIzexDXYVU0qKSNYsRzGpPBXlMWV6isNyl/0BTWZRkMzYQR5DNTatpKWD5OP44ig=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(6512007)(66946007)(8936002)(186003)(83380400001)(54906003)(86362001)(478600001)(122000001)(4326008)(76116006)(1076003)(107886003)(7416002)(110136005)(38100700002)(26005)(2906002)(2616005)(8676002)(66446008)(6486002)(71200400001)(5660300002)(316002)(44832011)(64756008)(91956017)(66476007)(66556008)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Cucr3id05w8n5/O5GT0zfj2K2AEm+YHBW697FCMFYTUZzWNGis9jltnPVs?=
 =?iso-8859-1?Q?sasgLbzF7E8xF64Q0ErJAOEKyOhrAOISKPcgn9Jxda5R6MeCATtYTJsVZo?=
 =?iso-8859-1?Q?GMlCDu/31Vg1bhzfuNCknnxBPx9WVeYptXQV7Dw6gBwnvGTL0K3rjjITuC?=
 =?iso-8859-1?Q?8lkYEBCCS78LWt/S87RHy5T63FjktNtzgRO5Pjiq1crN2zKY7g33Wb6UDR?=
 =?iso-8859-1?Q?qYFHRZ+U95tz6OrgbCtT6NUIv9XQ9o+yKU/s7D0wdoMvuUPZtqiPdNZx+c?=
 =?iso-8859-1?Q?XrLOZMWL9zFO98p5kF+4PmSCenPK2PlS/BtJ+oGbSj9S/A0k4mQ/GwXvWn?=
 =?iso-8859-1?Q?KHBHe/Iv6ATH9OpyJeZOyla6J/COdwyZ3lgiuar6xXOK/jt5Q/oNOssyGJ?=
 =?iso-8859-1?Q?8xD6bQjgY9tiECiMfIIu1dhlUgVSJSJFfSNdeWCgwkZt49nIrAzlcDXISm?=
 =?iso-8859-1?Q?gQOwIjpvzkXZjXv1rNwCWNaZMWTD32o7Kryq4yN4w55y4qZvemhuTbUm37?=
 =?iso-8859-1?Q?wtr0TGl4R+k8W0FO1oJ2DvIHtUbLTS/NPz9IbwGzufDXVSoR6OmC/N6hlD?=
 =?iso-8859-1?Q?rhKJ62rUXjcuCB3qSM3s26k6cgvQWLWb2sHyuBzXtT1sYiwPovQTGMiywM?=
 =?iso-8859-1?Q?3+dZHyszXkasnVqTV2+AFFnx7qb7P2CXvs7WeT5tmeQMb2bnNSam4kJh5q?=
 =?iso-8859-1?Q?m8nAsaWksz6PWGg2udtGYXFbKe19ThG+EvNcuZh9sp9NqQn0lv9OvfM2UI?=
 =?iso-8859-1?Q?TWP1W6tkyYW+8BnpC0PQVkbZsnyj0KXIeBKzEEiEYDk6aOg1UOydMblbTL?=
 =?iso-8859-1?Q?qvm4vXSONy+yXz/sKLJTEbL/Y4vCmm12MLZpl6LhZneGtClFAt9jhuMIfJ?=
 =?iso-8859-1?Q?ZFM5JJGODbGLr49HFvgq6t1Xpo/jkMZpdFmXzdg2ZUnI/eJP8NpACwTRC2?=
 =?iso-8859-1?Q?qk8+w3qJ5UEfKFkqhhyI11OyeP0yBycptanS00UNb2agrABdXsthKC7ME7?=
 =?iso-8859-1?Q?eHoyDRnDnOgYhmJUSgjE9GYVIkg7Gb1WFKG/NkjecKQstlAIxcjV/Zic7X?=
 =?iso-8859-1?Q?Vm5aF0iZ9Koa9vxlZ7r8adsU16h0M1yzOGeOep6SWxO0ESW+/g3JH7t16v?=
 =?iso-8859-1?Q?/LoKwOhG1AN7JmjLREkEWYz0zmZg9W/no2Qypn1d7fc6lTkJ6xGWjsSJ8o?=
 =?iso-8859-1?Q?WGPh06XH+60VRJxnUrUs2AzbKnpzKEpR6+VfrBp7TImt8ljamafg/mV5BZ?=
 =?iso-8859-1?Q?JclXVE/2GKgwUsmc7NzjjcNYltOyUycV4HsjYiXd9Yekz+F0/26pSV2bAk?=
 =?iso-8859-1?Q?de60dH00EzTw2s/LJGeluhQGx5UpQ16F3w3+/LgiUiltv3TqOI1ig2UYql?=
 =?iso-8859-1?Q?ACBlQNhQfw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ced96c6-01f2-47ed-7347-08d90a5b86e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:27.8288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9KGkx0I8QyPLShHIQewQs3aBfVvAJCPL9R2HTb0/BJtQNpKhrcKym+2xpPnco629S+coGzVzq5nSqztvkz4ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: ST8eiPO9KBv-_EiR0fRn63tO26bhMr2u
X-Proofpoint-GUID: ST8eiPO9KBv-_EiR0fRn63tO26bhMr2u
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mprotect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index e7a443157988..c468a823627f 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -518,6 +518,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const int grows =3D prot & (PROT_GROWSDOWN|PROT_GROWSUP);
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	start =3D untagged_addr(start);
=20
@@ -549,11 +550,11 @@ static int do_mprotect_pkey(unsigned long start, size=
_t len,
 	if ((pkey !=3D -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
=20
-	vma =3D find_vma(current->mm, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	error =3D -ENOMEM;
 	if (!vma)
 		goto out;
-	prev =3D vma->vm_prev;
+	prev =3D mas_prev(&mas, 0);
 	if (unlikely(grows & PROT_GROWSDOWN)) {
 		if (vma->vm_start >=3D end)
 			goto out;
@@ -634,7 +635,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 		if (nstart >=3D end)
 			goto out;
=20
-		vma =3D prev->vm_next;
+		vma =3D vma_next(current->mm, prev);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			goto out;
--=20
2.30.2
