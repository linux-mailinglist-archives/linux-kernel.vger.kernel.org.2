Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1873794DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhEJRCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:02:52 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45026 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbhEJRAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGsdSk166711;
        Mon, 10 May 2021 16:58:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=90ECpS//ToLT2JpRKO8Ph/rzY9m+fXsZzTfb2lc/Og8=;
 b=LBMOazQWpUXLDXVxHCWCuatj2skcIhpl8EzVq8HwRXGHBgj6x3qYchn6y9mzrGiUdXJ6
 z4N4uFtz0JFtq3dZ/+YJ1InFT0WBpGrPcUOKi9VjFdsY0K7EcMs+zhzD5FR/9opZJvym
 xcumQwOf10gb78MoDCe4UiDp2aj35Qo8thw5ErrGOGbf5Uzpwh5t6YaNBaib3zOhSP8G
 8QhcFqJ0JYE6c2nEkWXSZkHuRKazGHAOyxICyoN8xriNmHCcWz10xbGAapw2pEbFxHaj
 /OEQpBDNiTo5wwytD0JYrulhIty2cMR05i6giGQaTD3y0pVLTMhIO/xZKDhay2V+Z9Ir ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38dk9nbx15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGucHH109288;
        Mon, 10 May 2021 16:58:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3020.oracle.com with ESMTP id 38djf74j6a-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvns8XbZpyZauXWnjS53NDU18zqqf8UjZuIG5BuyLlykXFGdtPqVej28GMX1OfgQcL56OOOkLGP+OmPuy7nuIDOb0xZwZXL/XrFwerO0WaW0f3zCqYpYPUreuFUlXYx5Wn3lJBgw7vVZcCT7ChPorh804FJ4OSCtwOK1cRrbDxXi0H4g6j0xHIS/YgCr3V1OlGzLQAY0KBNKwWQuILcDpLqhoo877prwZt/CywXrQ9lZVTX1iVft82NapJKa68QTAqWEKgHWK1W5Bs/+Pyq/Bih3R83pFr9840UOSbnKB6jMX6i8LvRk0JGBH4QBQhl6fIVqoMPHeZFgpAeErI9g/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90ECpS//ToLT2JpRKO8Ph/rzY9m+fXsZzTfb2lc/Og8=;
 b=Tp3AFU5jBF0Rm0jtyZRNPeaeV18SXqdqbLiVxHLQ/4Tu+/FIKH4Rtz7trruRbZ1BlIUOHCV21uK/+RfFWeQhNLQZcHIPnNyIRICwU4g1FRnYl9xw+7VbwPGehXJRS9VcjWo/Z9peZ783zIfCLzIeDFa6psLkjPhIxyCRONU0LJe7KxGI0/U9Pc7qd78qtF/7/DiAZHnHD8PQcuhxRJqQJJI1zqu0RJYvZKrBKwyDzf5qzGpktk512aUl4zy6MD56cGx1qs/kTL96QA9Or+eGJ75WtI/nAaDahf6EdAd43IGTbhYXz/Qgv14hV7jSdAc4daOsy2OVJeeKSNinxA0fpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90ECpS//ToLT2JpRKO8Ph/rzY9m+fXsZzTfb2lc/Og8=;
 b=yhrF5iOflovC+zRMbX7CzGkTxplI3B8UZvkbLdD2zJ6ig1snVumGptI6j2jDKwTb3y5IBAW4knornMcanOsCHZp+Aq/QUn7TE3My7NZsR/7rvKGEO38NbUmg5K2LLjLxHQxBlOI0JgPp74p7bQM3pWb/UV235YvsxfBem8n5gv0=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 16:58:52 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:52 +0000
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
        Michel Lespinasse <michel@lespinasse.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 08/22] arch/m68k/kernel/sys_m68k: Use vma_lookup() in
 sys_cacheflush()
Thread-Topic: [PATCH 08/22] arch/m68k/kernel/sys_m68k: Use vma_lookup() in
 sys_cacheflush()
Thread-Index: AQHXRb3BcZoKDdv1cEy5AdB7DOWGIg==
Date:   Mon, 10 May 2021 16:58:52 +0000
Message-ID: <20210510165839.2692974-9-Liam.Howlett@Oracle.com>
References: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 3ad3770c-9b33-4209-14dc-08d913d4e3d7
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB47695B3C36170A2E58F2208EFD549@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a44qhZPKR3E7NTrFoFk/sOxM1c/ipObM5szF1+aqW+qQ4/RKOv0GEc0Jo+g8SJRXxyOVNeojqjBj2T+nvhssvZhTTqAFxNGBKp79PcJVbKE4rSrIorRNSnLPTvBOxuCEK4sNKAIre6K0qgi8pPMfsD97os9HOzRB4wd8NTEqvRwa6xnV1gkjcBY/30ODykHt//IMjd8rhJTqaZSbjbcRQ+uLhvNiLGkVb/W9B7X6ya7RqZbEPNTmL6+sjJe5MpkO2g7BPcwVpbM/zAdo2q70fMw5FXJVN7LObr/cEvqoAEsAXqsuDyVOk8GvNZtPRjdn9WlEWEzfeUpG+IB19G5atvuf6G+45tC0fMWToUVGXt53yM/QQvv+IRFqqKBZt8yJ8sk4wW1rLDtS4PPBBwgHusMg327eCwpycCEd2x8Gy+J+nVkz9dzbWXoIdzwLaMJNN0nPHBr19WoS7VjtYXVwJkJ5cGNCzfxogFNdJIrE/IdcPpLoOU/7nHVs+huLuzyCjSPx3KQnXZvCYX8z8gmXxqIGjYotsHkoKxwKRdsxxa8RJXKBukM/jZqUDPI9g1YyF1YrxjK6JEYJcXNkP8+lvm26p/KVFcp3625qLhjZQBY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(7416002)(66476007)(64756008)(1076003)(110136005)(478600001)(38100700002)(122000001)(54906003)(6512007)(186003)(2616005)(107886003)(36756003)(66946007)(66446008)(86362001)(66556008)(4326008)(76116006)(71200400001)(6486002)(83380400001)(4744005)(6506007)(8676002)(2906002)(316002)(26005)(8936002)(5660300002)(44832011)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Um4Hl4AfyUTzgBi7l3r4us8epYNUu3AQiRVMfNPuFHWV9AWsqfdAs4cHd5?=
 =?iso-8859-1?Q?DjpznxUWJCPGPZW+vJPDX8fG4ecS84pVM+bJd4gt+rx1wLJLhSTmRafr34?=
 =?iso-8859-1?Q?ItWGa5VO8qvw1Kp5x/JtySLe9a6A/Y5hAN/UjP6QulY94MZnTKShm6a3QR?=
 =?iso-8859-1?Q?c81sYvFM9OrfEuFa30Tdq70gewjwQeqFiBkHBa+cCwkcL+ucYOGrEUYg7G?=
 =?iso-8859-1?Q?V96KCzAP/1kdFstbrilFTFWyTAHzY5miBvpFh4/JESsPuTi2Ic6LvlbuCq?=
 =?iso-8859-1?Q?aBZ7d5KuKRji7zJr7p2WvKIHFYBTJRN3zlLkGqLltz/mSaiomrFHroW9mF?=
 =?iso-8859-1?Q?eiIvNCo7L1467qC+VKVUy5dqMaxn4qqSIh2w7p737SG2g08/3HK9MRgwQk?=
 =?iso-8859-1?Q?3hrIdAjk9sLHA4x6VBPgYXasER3DfWY4P4z86f7CUzy22+jFf1qlWA/e9q?=
 =?iso-8859-1?Q?YP7WIbqHV5RwZBxsnul4xpjCkuVeLW5SKY7aNp5SQADPc/WrHNMlY2r7Z5?=
 =?iso-8859-1?Q?8JDVAtwl7l+3L8XTt0kUA+oWacEVbVMUxsqm/MMcA1xe00wuqOujxaTHJa?=
 =?iso-8859-1?Q?dBY7vyntuF/FLorvVV28hvroH9hkz2GRHWD6/Dpa5t6iBdJTjOK1TRnk8P?=
 =?iso-8859-1?Q?KIrGGqkDcqvxbw4yXAIA22PAxcQA/agJra7pLQcdB/QXWnyeJz8OM9+hqd?=
 =?iso-8859-1?Q?UA+OF7vR8s1iwe4cX5PlIV/zFp6iLwVl6FWE1iDtUhOf8iUCj291rVUpYz?=
 =?iso-8859-1?Q?r2CK6u4q9FjApy5ZKXAv1lVXX5JWE0NLmZ95y5zmRgwCNNHJLoY69sGlIm?=
 =?iso-8859-1?Q?Hvk/FFBo/6IJuYJLlIu+BtfJxXfuKwGYis0Pa5asXc7OpqddVxSffiIT3s?=
 =?iso-8859-1?Q?yMnpSol4Cf4q2VTan0z2BIgdFmtaQ7YU11thx5fj5NOpb1UKloUIXuhStF?=
 =?iso-8859-1?Q?sktbqyrbR5i04YaJ8ewDhow40qh1c+Ht0Y89L/lPYrvzEsz/Ny1II2XyRR?=
 =?iso-8859-1?Q?w/QVudR73PQhAbYEYOu28JIx2X4G66WWtmnPIkPaBmv3CYAWBhjQ1ygc16?=
 =?iso-8859-1?Q?sj3ln8mOO5wCMkfSAW1in8w6fP/ZtXNAZnmE0KRVvLxg3+3UVCHSP9G9OE?=
 =?iso-8859-1?Q?oLg3DCPf4wvkTVXlIVWFQOrQ2MeZNdu0mra/Tn+JN5IbSlvqnkRJPI9+Zm?=
 =?iso-8859-1?Q?MSOsMD2vjD2dbf8B/8yjRM23vphF8HvZAXcvfQNrQUT3KuQfPgA/sHkAX7?=
 =?iso-8859-1?Q?uKewRt/p5D0U7vFuHCoazm+H8zYXsOc2Jx+Au5CURP4VIGTvE6lRBVOdjk?=
 =?iso-8859-1?Q?9U4BzyNEfQhMTc+rxzF6eXGV7ASyIMaueyylSYDjiDFByRrdJOTkTQQ1DC?=
 =?iso-8859-1?Q?GR7ktxsvg2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad3770c-9b33-4209-14dc-08d913d4e3d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:52.5294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBKSrfBuGB2zZOY0Kz/HHNUXc+9GoixHAAVtrt208J7y5EzVVw097vg+I+98xXj9MhPrJ346Qwit8x2xKkiuVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
X-Proofpoint-ORIG-GUID: xXUkpHfRGdA0yXhvnTJzycIcAAK6Kh56
X-Proofpoint-GUID: xXUkpHfRGdA0yXhvnTJzycIcAAK6Kh56
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_lookup() to find the VMA at a specific address.  As vma_lookup()
will return NULL if the address is not within any VMA, the start address
no longer needs to be validated.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/m68k/kernel/sys_m68k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
index f55bdcb8e4f1..bd0274c7592e 100644
--- a/arch/m68k/kernel/sys_m68k.c
+++ b/arch/m68k/kernel/sys_m68k.c
@@ -402,8 +402,8 @@ sys_cacheflush (unsigned long addr, int scope, int cach=
e, unsigned long len)
 		 * to this process.
 		 */
 		mmap_read_lock(current->mm);
-		vma =3D find_vma(current->mm, addr);
-		if (!vma || addr < vma->vm_start || addr + len > vma->vm_end)
+		vma =3D vma_lookup(current->mm, addr);
+		if (!vma || addr + len > vma->vm_end)
 			goto out_unlock;
 	}
=20
--=20
2.30.2
