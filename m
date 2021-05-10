Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C866D3794E0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhEJRDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:03:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45048 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbhEJRAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGscm2166679;
        Mon, 10 May 2021 16:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=TeATQGxrqIy2CXFoCnv+4GXF4grEt4gSDH55xSep17k=;
 b=jYA0z8MFK8EZaM4ixJIvbxMVxCbk5SehcePPI15Y0zjfiODM1Hlzkyiw0NUYN6+6r57O
 UrZyQE5V6LJt1mETjXnJFj+No+mKVkhnguakLpkrFLuQ2XXnHYXsZ8IFja0WpK2sIqso
 HHEEx6m1F23dwdEjx8/lZzcbDwZ/HiytQv9sPA9JHFICIdVFRS39xYc2tdNijzVh8Ogz
 sWSjwnBhtFqFEgDHlDUoeTFUc3SjrKM0LS4zjRfCTszFBZn8SUFMS/jLD2zLUqi/n1R3
 yid8OR14ZGnfwqm13Ypd28UxNhSSlOOLlnF4It36y5HeU83FoexXR4kzkX5gznefZV6K JA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 38dk9nbx1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGu00N001823;
        Mon, 10 May 2021 16:59:00 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by userp3020.oracle.com with ESMTP id 38e4dskqxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:59:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MC+CwY+KpdW32b98mtzu72bHxWjBMpJYb2aNT7GkkTc0UxjQ8B+PlPHUviL2+O883N13LHee7KKGHLTYQqQ6Inso2boRvuqOW14GXryC/GWRHfQUXbQK16SmnQ/vc5s26ZmAOnHV1e0Bd1nKR+MtYqoDVK6bilqlF7C9WUbe8H6l4r3Su/Ae8qWyIxl67R8X3ok8Isj/zccKPTSODLiLCZWa2VVMuHucZhM6p1/c7vGx25u7J+/Km+KXvTN2tsbIwCoNRV5+D3Ls2FTb12Sg90VNgN0QJ9SVP9yrXP0gTksc6LAN2vx35dVacz5NzN5h1PuUNloRKhAeFte4wkdM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeATQGxrqIy2CXFoCnv+4GXF4grEt4gSDH55xSep17k=;
 b=SwdDLxT82uKe1k3DHhluADumpoV6E448M1jGUNw9zZ9P5OSNfVwbVWJOyPcYgdWNEYhviRnHZCjrSW7B1PCadtk/bQ4cGhC6Jma6V3cT0s2ghhHVxDsf0pXlEYo9yNxaq3LWpOxBUs4A0WbaHOw6s3hign2Z2xPS6lP6DHZDfWGkspE8YuotbI1bqcEB2RYJTRf7IYdFp+GX4dWYcuPbFNRUN18mimxBEEPsA0bgP6N0uLpGgifs7CZ3NUIui1wswJ6bQYJfBvM4SV0NTzCusEWkk3wOQTExvwjR4Zaeiw74fNEA50ugWOcet9BpY+r5q34TBlpbf9OK/mvlE+hsaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeATQGxrqIy2CXFoCnv+4GXF4grEt4gSDH55xSep17k=;
 b=Psg3odFmtufLMU4C5NVtES2I7vGdrP1KtjtyJ1iM/wpU15kA5h0ZYAIvQQG5iT4jPZhmBNFP7TKcH6aitEDe+zueirPWQRmRVHg+BtWrnOEHtYWLZZFZgZgbhV1rnq0NUwRvcfhVQC+u+czc9MCk/y6fewM28CniDKQNNqu327k=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4580.namprd10.prod.outlook.com (2603:10b6:303:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Mon, 10 May
 2021 16:58:57 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:57 +0000
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
Subject: [PATCH 18/22] mm/ksm: Use vma_lookup() in find_mergeable_vma()
Thread-Topic: [PATCH 18/22] mm/ksm: Use vma_lookup() in find_mergeable_vma()
Thread-Index: AQHXRb3ESWqpAN1FzE2jh8MoJhoEAQ==
Date:   Mon, 10 May 2021 16:58:57 +0000
Message-ID: <20210510165839.2692974-19-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 968686dd-1589-4f9f-f7c5-08d913d4e6ee
x-ms-traffictypediagnostic: CO1PR10MB4580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB45800FBEEFD5EE01DDBB9838FD549@CO1PR10MB4580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RLCzIZXLeMz3jH1o63iOnwLIRkhQSaFuTZZQmuUmdJ0o8+BHuJj8emq0qK2oTf//KVS5+Y7dwX8oHhWzFmKw1AC+xIP3x0AfYYdT6CpMQFl7R3lSh2PIbT42409wMRp8bQUcbZxL3mBgnH7C6M9X+k69GUKFgBkBsTyqE2m5rAng3MsY56bPRbSPGRi3qPPwDFQOBQ+EQdsu+mz4yxeGqwYR8FRsK5IKNEnsUw8UqcHri9FQZg3Eg69hLqYt3BqYOu0gMR68ButuATICfg4eurrZ71TNflVX/MeHhOkQZujvCsxqnb87xu2GT99G1WsJv7CbWsFRW/9HY7Q3qISN5BWgq/I5KuX2SUWN1DmyXtXHCNfzQvLSw/oW8tce5SNmk33BdEXrIbbX164uAlpgnmcI9Sui8+AM5P7sW3N0IV2uCQ6i3HrZ6lXKanR/xr+MTx/MDnDoRHOyuhpKUvaO8phkGx9SIE8irXWuJm2lXenjd7o26hKRKg1PFeg46BC0mbTmkcxEz/iFctamN9fMyIvCb8jEComN7QoHgOGS5ISh3RnaCgxqjqxOrR+l0Y3LFgwtmId+C7W/56nzJQCC1KzyVeE7ELBpFI8+5pxZkiQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(4326008)(83380400001)(66946007)(66446008)(66556008)(5660300002)(66476007)(64756008)(36756003)(1076003)(91956017)(478600001)(2616005)(4744005)(71200400001)(8676002)(26005)(76116006)(6512007)(7416002)(122000001)(44832011)(110136005)(186003)(107886003)(2906002)(54906003)(8936002)(38100700002)(86362001)(6506007)(6486002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?UTpbC6i2SiRjBJytfcV0eQZZ6F05tZ0hve4WLF4DpYkL8ECYKobqvenwCT?=
 =?iso-8859-1?Q?XYx7/vaRQhyuXKupP08jkavMKq8Je62IoL51FJOoEyMWCcYb+0+H4XCtj1?=
 =?iso-8859-1?Q?RZopemFFNImbIuzs7zEqfj9YNZfcS0+425V/1arpKz80ZyPMGuIN3vnI7B?=
 =?iso-8859-1?Q?wKYbuGny8D82qrANc65kGFZwIbkppHA2jKvnhi73TBJSUCQN4O8Pusgsr/?=
 =?iso-8859-1?Q?2E0vSOJ0F5nvqKzI7iSnTkGQXmQEC2f7bT1dqWdv8WNQ2AnSZZHXh3EbAH?=
 =?iso-8859-1?Q?E4vj2UiHLxf2HIkvgmuf6bIvYKi0EZVPZPUTFxVen/8nktSzY/A4pj1TqY?=
 =?iso-8859-1?Q?zuXUFBiTU6QwUWtP8QmLEUv2nnIzsyWmFavbL2bXXmoTkHGr6Ik2b/IUMX?=
 =?iso-8859-1?Q?edz/af1g1p7Ua/S0xfMlffdGC/3b1ypmxXruj6CYTSfeQRHGd7JlQkDE61?=
 =?iso-8859-1?Q?UuSlkbjAyqsCCshJTs/pbUIdgPp8+LAWKbwvcHJEIsChdHxblQf25p/HPH?=
 =?iso-8859-1?Q?OQuq0/HDT2yM6zj/YEsE3JsIjwQR7KOvvnYcvxlc32KSUprXJD4OMlHFjV?=
 =?iso-8859-1?Q?Jni/EDvw7v6HEyiFTY0j6IodXv07xbVwLlOtC4k7gCH4PXhQVMWOAvtv9X?=
 =?iso-8859-1?Q?96vxIhgt6JdiNlESigafD+jP/GCaiQG2gUvaYDxXhBq7iILHU1OGbHJ4Le?=
 =?iso-8859-1?Q?Rq9k54H3mF8AbiBOgb6/n6TFAewsVixXLT9EawPczjegvWhNmTRMdKdnk/?=
 =?iso-8859-1?Q?XflDBQL/Q937O3/iUmmKI5Cbu8aQFfJEbj+wtHqIbO3aZnbm73URQ2OqXj?=
 =?iso-8859-1?Q?xWHiLui6xb04/ukhO24SRRL8tfi1MuC+bVcFo/j6LtcbO1/MezU1QMs1GC?=
 =?iso-8859-1?Q?yYuPcRNCAnCHh2AmAgcJIEIgre8RJEDyGJlRoB57ybux+DXztuOhJfWwhz?=
 =?iso-8859-1?Q?SaJ0/7RfQS1I1OI9/PFimQGM4zA5Iwn4HC+qI5Sm+ydft0NS5S5R+D9IyP?=
 =?iso-8859-1?Q?7VbSm2B2sxo7NS3fCyXg1Bo+UZ6tcHGx0t5RXWI8sHulrq/S0cc8hFmvCB?=
 =?iso-8859-1?Q?IbBsWUDosXrU4dOLSJGBgDTv/im+BLxjXERxYp7TKubEg6IMK04Ao3R0Ml?=
 =?iso-8859-1?Q?0Jp8f29A6JGFi0eiPNKgeQIF++Q/8CelAX4qXr6Jmn5aiHE5BE8ZL63XOy?=
 =?iso-8859-1?Q?ND36ueFxwyeB0fe3AU7A0tg/I+vJrqdApXMesm7Xu+e5toe6erAJosIR3l?=
 =?iso-8859-1?Q?fY0ubbW+8Zh67wuJMrNu/LceV8bly2gCZ0pKt5PphOKAnGizQ8fj22Jpr1?=
 =?iso-8859-1?Q?ibQKbl0DhP65Cqd0f2aWgiHUuJPd4F1+v+yqdbxcTZt1BLP2IzXkJUdzxh?=
 =?iso-8859-1?Q?CLIdlV6Z6F?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968686dd-1589-4f9f-f7c5-08d913d4e6ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:57.6741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fB62p5MEyd6FHx923BEZCXvGVNiBMEjoSJFD9pEUv/Bd3Al4CZA1VwAORaIqwfxUqRRaNLk2MoigW4F0SckiOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=967 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100114
X-Proofpoint-ORIG-GUID: _dajx81PrmZ8ndQc1MWp1lAUjMHimkyo
X-Proofpoint-GUID: _dajx81PrmZ8ndQc1MWp1lAUjMHimkyo
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
 mm/ksm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 6bbe314c5260..ced6830d0ff4 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -521,10 +521,8 @@ static struct vm_area_struct *find_mergeable_vma(struc=
t mm_struct *mm,
 	struct vm_area_struct *vma;
 	if (ksm_test_exit(mm))
 		return NULL;
-	vma =3D find_vma(mm, addr);
-	if (!vma || vma->vm_start > addr)
-		return NULL;
-	if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+	vma =3D vma_lookup(mm, addr);
+	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
 		return NULL;
 	return vma;
 }
--=20
2.30.2
