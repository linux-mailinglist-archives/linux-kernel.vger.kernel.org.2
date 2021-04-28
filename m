Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B7436DBDF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbhD1PiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:38:24 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:65274 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240063AbhD1PhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:01 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNiXP032601;
        Wed, 28 Apr 2021 15:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=p/hiMfuguBWKHlYtzn5lxsjBPobTNL9kktXzeDnHAxY=;
 b=G2BXg3oqoRfu1NI+AU/hjAF3NE9+RmNALX2+rWSCo3hPqRu5FphbUt9D7d5oM+GrfuE9
 5Uljwi8Xg3mr42JM+Djmm5vHlNa69kL2J4eF6l+sE/JA71pXAWFFRsd1RpWb+j1zKbUQ
 bQ5boWK29hDDwbXxny2snC4wraHXqByYssP1UzjhYsYhZZqjc9by0kgIyl3B2DxbkfsS
 MJ2pDOqDKfKR6mhVYcHTCjOH/I03pXgsE0wnusHmRDpdcA3yXYB5y0z5gT7O/AIe9Zwp
 i4mxGz9Ms2zO3VrD68LnQvMgSzOk/6tqINxdAfhhTpRjB+iX/5Lpua1xG3jF06YuqTBJ /g== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3874kn0ep4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:55 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWkAZ003673;
        Wed, 28 Apr 2021 15:35:55 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3874d273w0-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZzqqqxZ5Nd5es45+Tl2o9nzfrBuO0Re1z1xrRioIcfLc+ARqW7lJehXdjYDDS6Ll867WWdpaJQ3m7UmKBONL+zmM/wN5ru3zOBr9AVZ2P9YZV7nmUKT4Y4j/zmSwBFTgW6XHPSY+jPtvUW/34J/sG9yzE8uZuo8UrlsOHeHYSe14HE/B0rzIe/xU+sXET6YGsUK0Dv7tHHLyHaV+ITbTcpYVlDBu9yp7pbkxB/ibYaYL5/i+bV8HxS0vaSTeDQKq74IvVDCeS7hhHAlwsk8ZFRIIvD96zhK0RXWEgLC3khwsiVm8MU+SVNzq/aVYNYhYClPygMWKGUqg0Q1y4An4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/hiMfuguBWKHlYtzn5lxsjBPobTNL9kktXzeDnHAxY=;
 b=CtdLBSkcFAWj7tEuONYX9orZ1UCTy4d34mA0vF902COnlI9aNwG6GtD0wfFP7IWk0LEaAvvjhGWAv1h/VVAZMTHR47w2pM7EM8n3X41qKVSZkTnIH2XDHiQ8U8jQbk3zX+92s9FM6WqHU7KG5UqIcuoOrx3hsJDLvAO1ZPIvAvdcyl8f5FoV/uhc+NB+1UOLzCPzaOxDJ2feQunBvU1+LvN7v8aNp9C9w687zX0xeIIOqRCQV1T1YKSll/i7t9goPaCBpJs9ez4kqw0AOnrKREST8Mj48ojyYNF4xm5B/6CJld+iwirIR5efwGndye/fOW2hiBvn6hzNBnDMS8u01Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/hiMfuguBWKHlYtzn5lxsjBPobTNL9kktXzeDnHAxY=;
 b=YnGIbT979qgrSOp2h1AEO6xxDL5nztx8lxPJiswbIuvMLtjfT9IK5bfWDoPEMjTHIkUHozIAIA4uc6Qh2dM1VXg3IzUomHDYWkoAuZIc3CnBdJ35vqrRB1SWFvCwUkS463lIzfpuXQtHbyXs9klYd3bq4PQedvK3PUxzlLHSy2M=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:35:52 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:52 +0000
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
Subject: [PATCH 18/94] mm/migrate: Use vma_lookup() in do_pages_stat_array()
Thread-Topic: [PATCH 18/94] mm/migrate: Use vma_lookup() in
 do_pages_stat_array()
Thread-Index: AQHXPEQrnxyzHD1CI0GIL/3GEmEaTg==
Date:   Wed, 28 Apr 2021 15:35:51 +0000
Message-ID: <20210428153542.2814175-19-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: b92a95aa-4fea-46d5-842c-08d90a5b4e4e
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4497B79849C38DC5A107FDAEFD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HO1Mhj6kxqCm0xif0zN7eNQIEF3SDav17HlbwSlNr16gXP49hjUsdyv3i7ZBz4n/gCZRT3vQ0eGj9OGMs29P3SVEdxL4tX+MuybZESXRwLtjKKcT3dskDfFP7ve3RnksWd8vkvRsCb+BtAFA0M+9zI0KZxaOrjWnrB/AkCmFNsLhJ+nb+2zeol2tpcIb0Rdp3WZ05UyAakmgaTGXLje6bUAnFNclaqEP7LKOd3zYprzaQSbHlQjT+QBnQNvNJ+hr+06eQh+/RwVtasD0S/TKFcRvfRkNrY1eenURZFItj44kCjU4ikP0kdQDrwzm7pc1jFf4dGOpcApksaT6xnTx/SZLP/SJBTpDfNQhLFXGF1Fe/AzTf6j/nTh4VJ/HXYguGw0Y0Pt+Vrw7SRvTC3b0Hg0xqtut0s3psVuuoPiskoccwIWnzq9JeetqbHFkm3A8nEorMscr1hy4VurEUa1Bdd8auoOj0oPINvFzEjWitkEJ3f5hD8FbdhCoy0lnatz3cEMfjlGGXiE+KgpV/LYwFIU/Alloi31SGhHZdMDlbXw/W2xm+5kJe+DLOHtMbGzNPPLLeOiYcUZS/GItB7x5z+AOPqlSjculQmGGRVTjm4I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(4744005)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?LIzv4J2vpSN/E0mJiwcYbNAScsKo5hDn5iyFDwWSX6iV7bpD4FhvwdkBsg?=
 =?iso-8859-1?Q?pN44R52CFrzYIyALDsORdL0IUvNf/bMFF/cdcXdiKTVc4uGN+Mjxnw2nmU?=
 =?iso-8859-1?Q?hl6ntPwvKlfV+zF5eAyP2hSTdLKmDLOuXQttyOAxyvp44Iy/wn6BLCmtUA?=
 =?iso-8859-1?Q?tOIeLHOTRelI4uwC0t1qzBc9JRO0ya1aAgYb+W29NFozntjxXUC1ObyIpS?=
 =?iso-8859-1?Q?GCpn0asrWbFp5AH7w1l3ApSa/T/jbFFHPyP64j2AVFIPToXPOfElhsPJfP?=
 =?iso-8859-1?Q?Miry94qAXEjWpK4xgODTrPiYMGQY6hm14a2UffWTKPz4UMYRZRARWP5BpI?=
 =?iso-8859-1?Q?U/STkOPXzUqcywM8T/0MG6C2dKmo2tMEWMcdm0CRs3TyMHS0B0TMz8nYix?=
 =?iso-8859-1?Q?W8w5hDv3y7Yh59N128JTWOK0nYAnCz2p1YmGPn+smvl3rgEgr5wrn9L/Qu?=
 =?iso-8859-1?Q?CIQ3IGDQQ6iMOzWNjmSSp0LHj5LbHxIl74k6k9o+ViU8ZinmLvLDhRmqr2?=
 =?iso-8859-1?Q?noZKMt7ILoOuljeRZEGP1bjRuE1niuVvW4GDgSY8Wc/j1zQln2Hchr5tJ7?=
 =?iso-8859-1?Q?0VA8Q8o+RYW/bfZ6+dIZufuTJAVpPrb7WZmMr8gs/CAZcVt6cxZwSIvMGI?=
 =?iso-8859-1?Q?MWedxb8aKpapeaJsYjpRKzo3hVP+w5uyMW1RDn0C0SyDs0R/yLoWPRFcKv?=
 =?iso-8859-1?Q?x8OhCpA6NBlgUego8E/oTddFYLxjTKHxsn5qVFoBV8iNhICTjKsJ5CsaGs?=
 =?iso-8859-1?Q?D+hDfHfAfZdu+ho1yCSZPvORp3zSwzyJHA721God02IwU2KmudZQ+x4FxW?=
 =?iso-8859-1?Q?DJapzm5L7gEC3AD34Rpmrb468gMVSSOFnq2QFWh1kxAELd0VNirK39Qi8k?=
 =?iso-8859-1?Q?NjlhUqrdCp+AKY6/r1IqTG0K2gTxQ4fkqs+KvkTXsKS+iJtDsVhBeRh+It?=
 =?iso-8859-1?Q?yZLitRtNuAJprQ0dWS7b8vn8NQH/pIkGhnpSXpChhVUOcuGHmwm7xrc4eQ?=
 =?iso-8859-1?Q?YOYSkGsaf302sf4rzn/lqCoxJhGOMFpT7B/aCh0lNwh38NNsbH+9OR738h?=
 =?iso-8859-1?Q?zlNt2j6h1LMvpqCdLnhGQVdXUJoNlD7mPb/BrShUl/dOInU+QlkT0kEAeG?=
 =?iso-8859-1?Q?1o636mwqLuZWc5nvXruL82+eGsHdpFniijMX7Y5xmaHlWatS6uAQfecD2Q?=
 =?iso-8859-1?Q?iN566CSPyT4zGXJPrRCJGifW+OJ5PPuUE2jiionG2U2Y8LM2ECiFN099Rd?=
 =?iso-8859-1?Q?rH6pL3r2X/RoSqWYbM+c7j024/7XrQUmKBjucCfFEQ/NJkH5KaVdPChdZx?=
 =?iso-8859-1?Q?pRHIkuBkQYh9aENfNt3vXBfsVZInp+3pvZgTfKTufC7vUSg77FdHuposx+?=
 =?iso-8859-1?Q?yInmM7SI2T2bIw9gTSvjKw9Wrxfcd5sw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b92a95aa-4fea-46d5-842c-08d90a5b4e4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:51.9197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SkNEnITk+SP3clHk1u8JXN+4H1PIB2TUEyWjL5UtB9h0dUum25xPyAsD4TlOHyYCwcba9fmex09sbNNtQtWi5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: tXjBuPTHTroG83YugbQq1v1CAwsvo-H4
X-Proofpoint-ORIG-GUID: tXjBuPTHTroG83YugbQq1v1CAwsvo-H4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using vma_lookup() allows for cleaner and more clear code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/migrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index b234c3f3acb7..611781c0f9b5 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1833,8 +1833,8 @@ static void do_pages_stat_array(struct mm_struct *mm,=
 unsigned long nr_pages,
 		struct page *page;
 		int err =3D -EFAULT;
=20
-		vma =3D find_vma(mm, addr);
-		if (!vma || addr < vma->vm_start)
+		vma =3D vma_lookup(mm, addr);
+		if (!vma)
 			goto set_status;
=20
 		/* FOLL_DUMP to ignore special (like zero) pages */
--=20
2.30.2
