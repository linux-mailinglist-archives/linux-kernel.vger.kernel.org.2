Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3B23794D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhEJRCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:02:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45000 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhEJRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGsfZ1166738;
        Mon, 10 May 2021 16:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=6onklbnIb4C7wgxV3e8Ivm2VMSOtnMnkO3gpKku5anU=;
 b=b1vCaMixnm3LWLOXrkm1L7LGYTcGOcLLkEThkOpH9sJRUn89RCdspe1YO1Y1TstFT/b6
 zC1qxhRpp8FVb6g2fA3kfwseUI8be/oXw4dzOdGt755ClW1AP0lIqabJ9xzeWi3vmBhZ
 2JYITTvJ+ghNHzxKKPGiuD00syuRpyUHVjpulyVQK6u+9agYoN1BPcwWQODHpLoT6P5H
 BHg7aR08FUhHgNOJijUiiboJZny3LRjrJUHctnM1fj6THigQpFGfvfgwF62o57o+9FTl
 a5gKC7fZbyt9VgR5XXg0W1ZKtAeDWAYvXaFv62+hK1MFugdewEyG9rq2VMTUuOGSHvlA wA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38dk9nbx1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGtx3V001777;
        Mon, 10 May 2021 16:59:02 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2045.outbound.protection.outlook.com [104.47.74.45])
        by userp3020.oracle.com with ESMTP id 38e4dskqwm-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAJ5/anEFAvO7Grin2BrvQltSMd+s1tT0MwF+ppgdVs/K2CT8c/DylD6vRnu7ZPONhgDLPcfyBwZ+z8lDjl1nHhmy84FenPesAFhXnVxfColGtBdMpD0wRlP5YgG7nyDPAxGN9DFfubLfquWbp9V48GBdXVRgJWtIHnvOB3IYVWJ8YiecmqUElhtGNlrw0WZKChMdC0euvetPRX573p6eykt4DD8IPuw6j0QvLvbdzX1RkD/k9UuG4LFzoeXW8BHjHh7feZO842PGmYvtxRK7r3IVEu6jLpJlvkCVm165lkA40dq1i2jR+vV6HilT7OtuR38pUvIwmaM8VTAjZ4J6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6onklbnIb4C7wgxV3e8Ivm2VMSOtnMnkO3gpKku5anU=;
 b=d2oamtI4KqQ4YpXwHbvRRkn/rf4QFa1jyf42jmbKPUt6JQGa9CUCGbm0pDRf8pxWSfHb4up+EbZ+C9sn9Rc9bvsccKc0PFQcc2cKvRhKd3vuzVVD0HsJqpysYevSb9KxLnLUhmxOTdf7/nnYU8od+DT12OhV6AsX78irsc59iYpEhG536kl+3Uv8X8mF8Qtog91WDOf8fLZVNZZ0m3/tUAqeVy8j9llwTg55s2wKkA9dZ34p0mj768Qz074ANZDcJgFvX+wRsGwN0AXLlsCS2fwXq67JKWg8cWwie+PcsOuxbZR3hTv5kaEZM5kX5vGbHcNSLPoMcl3+M3Qw/asJIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6onklbnIb4C7wgxV3e8Ivm2VMSOtnMnkO3gpKku5anU=;
 b=Jm9CV0c25dHxfqtxKLD8BCc0P4bVBBYqvd+951UB0fbKbaKe5Jhj3reb50oRQb07A59vOYXlTNY4ounBpWoCIKF9qC46YolcpLcXwIKJVCDsbcBDbCF6K1CTGXwSmtTLD3wyyK60ECvWenjzM+AJUIFScccmGze+jdZnaNKvmiM=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1437.namprd10.prod.outlook.com (2603:10b6:300:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 16:58:58 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:58 +0000
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
Subject: [PATCH 20/22] mm/mremap: Use vma_lookup() in vma_to_resize()
Thread-Topic: [PATCH 20/22] mm/mremap: Use vma_lookup() in vma_to_resize()
Thread-Index: AQHXRb3EvCCiex4CdkS+XkdMnKxOcg==
Date:   Mon, 10 May 2021 16:58:58 +0000
Message-ID: <20210510165839.2692974-21-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 0eb9605c-7379-49e2-ee12-08d913d4e780
x-ms-traffictypediagnostic: MWHPR10MB1437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB1437DD88A58BEBC6B1AA9298FD549@MWHPR10MB1437.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v21ZqJFovnuyGq86WOLOUqUPQxjgrmp1XuuVzsHStsjf1Ytb899QjcEop3qHJkRPyk1N6thy72yzCd0lG9voqdT5X4KpSue9hwGnPp1p4gaqrPi42TU0ydlEqxkm/6gkH1/BoUIrH6GYdFhu1DaTitEjkEGkGW6PDwmWiQmV/uVwT0x/RvECBotJoO4/Hfx21kCCJgMCJc0tmKDl4jn7QAtE+nHF1kbP9af2/6ZMqVn/NkSw2KAmaRv09IoAq8IuNDt+tF1trR3bq50vsClMGshqVvBOUjWiCyQzKaIXCXG56nGP59u3/i7nNmwoawO+FdI795gTJWu9xMQTnFkOuHhp5kUzrnGXVAMmAqal552ujZVe6K8g5VfTvja0DOG5CN4NiUiKJmghjpPxywu8SMcZ6eZtPjCk+SblVhCQ7f77hGs4ztpB/ojCDuzhw5cPW5Rk/0+q2qcTACa+qwwMx/xocJCVWoNH79sNIKL4B+EMWrSW3qeo75LOtsKU2kRUG1uMOXBbIZy47UmyWgupjdCF25NXXXmjN/3lCraxaTHf0r01ZDLDo+VQSXSJTccrHL1GkdJOl6BJfAcI3tKA+x5L0nbvC65dA/rH7rHCF9I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39860400002)(136003)(396003)(2906002)(64756008)(66446008)(8676002)(44832011)(1076003)(6486002)(122000001)(66556008)(66476007)(8936002)(110136005)(26005)(83380400001)(54906003)(71200400001)(316002)(6506007)(86362001)(5660300002)(38100700002)(4744005)(76116006)(91956017)(478600001)(107886003)(6512007)(66946007)(2616005)(7416002)(36756003)(186003)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?V7u0b3qWZuOZvuVSJHKbdGCBMhn9XtjWl5wXVHUdD1J1aVekA5/Fj2hx1y?=
 =?iso-8859-1?Q?KdhCK7PZALv81I5ENrq9ubp2Zy76r5WFvacpReZk9aSWQZESVR2K2KfHxP?=
 =?iso-8859-1?Q?uCTmOoSPuTTeqUS0VDWg3/9bsk+6cZLStaQaQMfmiQblnX5+4ZcW7W13NW?=
 =?iso-8859-1?Q?J1ES4t+6r9ip7hIVi6nowUvB5yhRaCyFfJz4e8WY5L8MW7otnKI73jD0cr?=
 =?iso-8859-1?Q?762QIZYjPA+FxBeKIYdE3Vq8N6L2U3KZWRD6LP6L5Xdyd8ug+oG62BROd+?=
 =?iso-8859-1?Q?yruZ4VNziwXWutW2VxmPRdo7XA/CRBJJs7Vnwg1c04XZD/5PAcWJrypWet?=
 =?iso-8859-1?Q?Vd6NGG7tjowL1l1j8L9NmMDYz/7Edf7bWJ3sRkO0dkNHeSG0lVKJroj72W?=
 =?iso-8859-1?Q?33kLVN/thQVIvRgwOoYsPmClYQur+QrB8bDrj/kGFdXePwn99vti3skI7E?=
 =?iso-8859-1?Q?b63jQs96YoWPC7gAAvA4zPV5ihiLqeXIK7HCchnnQHSZB1pDTIkWVarY7k?=
 =?iso-8859-1?Q?DbkyX5El7hW3a7hDUEeb3n6Qk+HSt63FpzcX/w2cArPMEWcSw3MTynknWe?=
 =?iso-8859-1?Q?A7ecbdR9Us12WSpGQ3CPb1KG58nyTKeMvE3GX/VKtPROOx4XBpVAXR+I/g?=
 =?iso-8859-1?Q?9v2VE21Jzsp0Xmc4Jsuqhp5b4wG7iNj+txpZ8BlpS8rzIlpRX1G4gvB7Ih?=
 =?iso-8859-1?Q?GkLe1DiHewg9FQP/Aq2bFpvK8GxNM8wztccTV3hn51rtIwXiIT/DTLZvD8?=
 =?iso-8859-1?Q?uZ+ySr2TDpsstucKc2AQrj9jbfNA129YNaD8GngXgv6+o5AmMUde4LuW3B?=
 =?iso-8859-1?Q?QkyWbR83hHxaUSqFunJuu5LOE0Pgc0H52OdZBgwhlkCSAH0FUq4tyAwvur?=
 =?iso-8859-1?Q?AnTGDyMFAer3ZJckNlJU2pPslnQD9DdcIpXkAYq5h74eM5aRU/Miv5p4q8?=
 =?iso-8859-1?Q?TVKTMrolqgufQOwMfxRKzedhBS82E9HsX45ODVatsj0jK8NZcmpWo+iSPH?=
 =?iso-8859-1?Q?Ogtc8DttbBGEyanjqaX9PEo2x1mnaxecoHxL8/9XnXpxksoAKwc7IAo9Ut?=
 =?iso-8859-1?Q?s7JEUvRiqDjL1B7/6zKQM88TExIqiY0w0BHaJPasejUzUbHJVO9pKHQj0c?=
 =?iso-8859-1?Q?84rAx1CV29433z2lLtks/I/r3pnej5w1Ng9HnCTYUyhCNJK+vvC0LE4QO8?=
 =?iso-8859-1?Q?+LAsyMzL64kXmLqUhLglxvcRT3jrFC4bdRBJI15jMcUCzZ2d14wNxXKHUO?=
 =?iso-8859-1?Q?7IKRDiBu4n7YFDsHziS90EFOl1dzudhtYzUxwkCx+y5Ua8l7gVW7lUl1eL?=
 =?iso-8859-1?Q?bJdw7KD9hbneDDbdo3ds73QVZS6IRw/CpJaIR5i1uVLeivayGHQQZ+Rzl0?=
 =?iso-8859-1?Q?d0hLSLxX16?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb9605c-7379-49e2-ee12-08d913d4e780
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:58.6597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4T5t3gcPBpyrL+J8UnMO6TyK3S03W6HfpJAwJ5yCknpxx2bS1NpF7Vnvc8RGTCSjWkDYg+3s8yESx7BgwusPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1437
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100114
X-Proofpoint-ORIG-GUID: 3Mpd1QlN_w9gY61BXuQIxWL0NXQwtu9k
X-Proofpoint-GUID: 3Mpd1QlN_w9gY61BXuQIxWL0NXQwtu9k
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
 mm/mremap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 47c255b60150..04143755cd1e 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -634,10 +634,10 @@ static struct vm_area_struct *vma_to_resize(unsigned =
long addr,
 	unsigned long *p)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D find_vma(mm, addr);
+	struct vm_area_struct *vma =3D vma_lookup(mm, addr);
 	unsigned long pgoff;
=20
-	if (!vma || vma->vm_start > addr)
+	if (!vma)
 		return ERR_PTR(-EFAULT);
=20
 	/*
--=20
2.30.2
