Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70BD36DC38
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241409AbhD1Pof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:44:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:12740 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240710AbhD1PjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:39:00 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMZPc020193;
        Wed, 28 Apr 2021 15:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=biKWyQDwDbcL2dw9D1KkBZ91mFuaeiqChlI0V9T7Ag0=;
 b=k32HL/NQTtA9KoUEt8WXL9heHdgVE6K3fOPvZBVdcpnq2dIiC8FUNQO2X2P1n1tTJG8+
 AVu2o7QhVDWtLQkI1V/26SVnqc4ouasAoptwn5PRvsz+GX0nEd0zVW1rsJyFqenBxaKN
 LiL+o5O51GEUENZM3eo34TBenqeZ5FvSJMGIrBlMsHEEw3sneu3IlCVzRoJa8cYi+Ia8
 9VZBAQkUUE12t4AggMZKXEwL6NkM9sgzQsHkhcwfxjx8yBgeBdc6kRD08yKb9cFboo4g
 h0Axn9QT20YUtmSthKbue+nJmcG4fv20Y7+UQxEjwME0yHYt6w8NfLSiooEGGTiXSIed Gw== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878kgg52x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:28 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFbPcd024423;
        Wed, 28 Apr 2021 15:37:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 3874d2765a-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtBgqACRanrayVGYlu5mxxTnBXld5VghE3jYfq9J1qXpm4Rbzw7JOpwK+W76aBdJ2xJe5zC+OgO4IOPbQYxWsTCkLwEKZIij2AzrhHKJ7+95lSYqMd0TCH+O6krpq1sY1v7MrEyCYsS9MdQSIah7E4Uqc5AMozRPXl/Bqz2ssjd97b341PWDolrVif2JWIT2hoRENaHcFvcByByh/fUcKNMlZnEuC+lIkuIT4Xm9Sg0VsT91usXwMXKLJNTVaHypjkY41dP/N8e7aWY0Bd33uXqDjuEXaFuIqa++hoVf3oCsiufa3I9xaLoxG7WQk48ZNFYhZdKFn85ros6Ufyz36g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biKWyQDwDbcL2dw9D1KkBZ91mFuaeiqChlI0V9T7Ag0=;
 b=RJdze62kOW7DL6HrXf/mhUIXNPlq+Z5E9ifmNuMv34ICMqg/T9NWJ4Ql7169ABDXqh6BrkODRyv7PuSb/EuT24x0Z0pFUJuS1WcSNso22rBLZZIPyGOViVE2O1WhuVipbrwJXBcU6dA3/12XKvJ8UUfqWlTlKQe6DQRp37/I16ahPDnOtihloc/E4fyRiUV0CEId4d1XZjSjmdMRG8wZqD1UszWWevDunc2P5NKZ9kNR89PohgrWHMwFbOJa6+ski7L/CT1wkeipRaBsZZTXe9BNcTKT1MrOyUqiDKOF6sbvqDSup/8O+pHRfNdq09v5GHbl47ogdXkY2AEriT7BPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biKWyQDwDbcL2dw9D1KkBZ91mFuaeiqChlI0V9T7Ag0=;
 b=AsRsleTfuO+JW8pMV2P4dJ/NwKAfOkOSiJSAVYOMrF8RNiY2A5YixPbuK95dJHlsfDejR0cLmQkymPA0Cuil9TzPzz51SAFQPoaJfPc9rbvRTg8xNV75ZrKbnCGtMQqK62NKLHse1yUGsqdH0VUa3cS/uZMyiDLN4EbPApgBnm0=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:37:24 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:24 +0000
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
Subject: [PATCH 75/94] mm/huge_memory: Use vma_next() instead of vma linked
 list
Thread-Topic: [PATCH 75/94] mm/huge_memory: Use vma_next() instead of vma
 linked list
Thread-Index: AQHXPEQ/KtEI2qsdIUOmHXr28WpE7w==
Date:   Wed, 28 Apr 2021 15:36:24 +0000
Message-ID: <20210428153542.2814175-76-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 8b303db5-1a1a-4e9f-d4b3-08d90a5b854d
x-ms-traffictypediagnostic: CO1PR10MB4548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB454849D6726E2264DB434FAAFD409@CO1PR10MB4548.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JUSbLyByLdF6KHpILJJ0UN56YfJ6Q91Q/JVjbAKzRAHBrVZ2Jd/3VMqi3Pd1PoYxEb+gctq0MJvqONs0fMOANezk/CscgenmNyT/Y5A93tuM5qq2p8lsLWL9GrRYzybBqcw5jTV4q/0m+7XBNfecEWQYXHQq+YYQhXlzBzczsFOf7F+GVSCfsC9pR6YyCCV2pP/UeTTv+SIbpTBP1u1BwdrcqqSez1YYbO5agtCDnefKaLzIskaAn8jTPxlnqz7dPNRrLFlSiy2+enaoqxaPmf13G6HPskhDhwsEIr+Pc7BmcLL6/mU44d77HDkY4m2K13VRKqSWTcohntqsV1VynTB3gxNkDrgm1eK6o8OHU1F+k7DfejwkP7tlllzHVqTuKaIhSWX5dPsSaM/qhiBPnBue3M92ytz3J0RyIwlg+/eKM++CJ6UlrhDA2e9RrzXIqi0UZUTb9+BPhuy9BixoVgoD4lpkA7UvIRtEU6r7GIWUKC3TQdPKkYww/Qj/rLQTE8L/18IJPC1aCqCf3evuIqqTkc9Cg1wo7ETRohaHiSP369ej/elU+1wVmVtqKGXcsAwtoHB0z1URIKncXq2xHehQbiNpOZlllcUbiznzA6BjMtln7oB0lcJ5rwg0wnR0yDOvuDUWTcKHxOn9K2rV7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(6512007)(66946007)(8936002)(186003)(83380400001)(54906003)(86362001)(478600001)(122000001)(4326008)(76116006)(1076003)(107886003)(7416002)(110136005)(38100700002)(26005)(2906002)(2616005)(8676002)(66446008)(6486002)(71200400001)(5660300002)(316002)(4744005)(44832011)(64756008)(91956017)(66476007)(66556008)(36756003)(6506007)(14583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?yuewiShPPimUzC4Ds5lehATP9zy5Co8ijX3Ow9JcEGB81E3q6lUzGTcOzF?=
 =?iso-8859-1?Q?8C1e2zl8ar/oyG17NpkNekaHybcunQZDU42g7P/dcfJ7KYDjJeWGmSh2Et?=
 =?iso-8859-1?Q?/AyCJFgjv0/QwOXSZlYKiCQwwrQin8wq0yulKeK4K9o+Z/BE8KeOmL3LTS?=
 =?iso-8859-1?Q?nUqjg2ZSgNDRcysATxP0NlUfmmcPkOzQx7jU4aqNuj6u9XOk/vaigkOUFW?=
 =?iso-8859-1?Q?HcJC5LlH1upcKtlbf8VpBHoJPkXCPclkPb1Aj+IZqHKfg+IU6gU6czQ2bs?=
 =?iso-8859-1?Q?opNX5FR0LpQ3E7KpWmr1K973Zfig3NpT95yFUpQVQLHkXnkfepuCzXvgdt?=
 =?iso-8859-1?Q?a+Lmm//oWKei1b4XdARPPWMkjShs3BH61LwSVV8tDjlJzlVPhbALWaWVhE?=
 =?iso-8859-1?Q?FVVP3EyvgjI2actCY9z6LFRhOi+W9HHGg8kqcITm2jZc8ufAyS9zkFtbqd?=
 =?iso-8859-1?Q?LuCYPsIQQiEeuAKGCOgTR+i34wWXyv4Lwa0F29Nv0BSA2n09pfH79bj9Wy?=
 =?iso-8859-1?Q?R2BMff1wB76wVxol49s5WSn9Hmvjkor+guSVp9pPAr7NE+bGxITpqwx8V8?=
 =?iso-8859-1?Q?PN2N+zqZiZsmlZwKPqtMTfYsn7HxhtnDKSwjWUR9SsnJVzx0AAb+pG12Bo?=
 =?iso-8859-1?Q?5jiGJDwIZUOhvIH5RiM3wHMyFgLUdvBVCP7Pls3I05lHBhWAzmVzKGkswx?=
 =?iso-8859-1?Q?FMfxyTiJfQLrN1+U0g7VTVzyy8loF57lz43zkvVvFOyK65TiQuHN/D3SUF?=
 =?iso-8859-1?Q?JvUSIEZ4o/DZf7bB6wlUv2MtLVSjqCNFqqdByDj7YhWnzcMXhd1PJOt1Ja?=
 =?iso-8859-1?Q?Yd6R7zjy7q7YkLim7EVEtovOE5LV/jmNcGK6I5danHLhy1IgzRGngzwKlT?=
 =?iso-8859-1?Q?AvMByyP46o5q0oIjWvmDoQ0jybWW6sbC0yMjeYSc5N7CuvysYDyRgdKXDV?=
 =?iso-8859-1?Q?PMR2J75QjYpxwxxD9B25Kzduo3gFu5q0lVPmhV6yPKwU54lg2obA6ir1K6?=
 =?iso-8859-1?Q?DS0rJBCrhbglrB0EWQyLzxwhe+7CgIaGIDH4SUMGNtC/+sgOUb+V0rheSG?=
 =?iso-8859-1?Q?z7LsFaswaS7m5EKMDf/tpYzye4nwQqNpaPMMsuhezMF2Q+hBlSsDXaMQWW?=
 =?iso-8859-1?Q?Gh3oxmzDzgckzi8VpS/Ozz+/BHDZm26uqnQhVtQJlpNRU9fd1/vIGH+dhd?=
 =?iso-8859-1?Q?jN7ad63hsa+KTot7JsqvpAqCz6Dm/FCAjdurxj6wD1HkLcNHXty27Fyg6Q?=
 =?iso-8859-1?Q?4SWs95fq6/1UwyrZJ4EWqZyiqlsqmSrH5wKnuTBg6MwEwezdC5Ehei1Rtm?=
 =?iso-8859-1?Q?Zlt4tyvKsTnBgqFk78aPzTzDjbxiEu2N38rBC5/kiM6FX47SIFNLj8glQA?=
 =?iso-8859-1?Q?Fztnk/aqeB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b303db5-1a1a-4e9f-d4b3-08d90a5b854d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:24.4813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckHMLDihpVMQ19VafdGXnpCdbARQZta/RbyY5QiveLPd5mb2al0UNbC/iQuY/uLc4S6w/ciqE16groD6uF/xPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: MpI1a5PsFX9pkJZ8o4Gpbsw57efIaIKZ
X-Proofpoint-GUID: MpI1a5PsFX9pkJZ8o4Gpbsw57efIaIKZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/huge_memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 63ed6b25deaa..cf05049afb1b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2325,11 +2325,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
ma,
 	split_huge_pmd_if_needed(vma, end);
=20
 	/*
-	 * If we're also updating the vma->vm_next->vm_start,
+	 * If we're also updating the vma_next(vma)->vm_start,
 	 * check if we need to split it.
 	 */
 	if (adjust_next > 0) {
-		struct vm_area_struct *next =3D vma->vm_next;
+		struct vm_area_struct *next =3D vma_next(vma->vm_mm, vma);
 		unsigned long nstart =3D next->vm_start;
 		nstart +=3D adjust_next;
 		split_huge_pmd_if_needed(next, nstart);
--=20
2.30.2
