Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAF03B1CD5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 16:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhFWOt5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Jun 2021 10:49:57 -0400
Received: from de-smtp-delivery-105.mimecast.com ([194.104.109.105]:39843 "EHLO
        de-smtp-delivery-105.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230061AbhFWOt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 10:49:56 -0400
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
 (mail-lo2gbr01lp2053.outbound.protection.outlook.com [104.47.21.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-29-AtaEgG65NR-SgCiQJLUBWQ-1; Wed, 23 Jun 2021 16:47:36 +0200
X-MC-Unique: AtaEgG65NR-SgCiQJLUBWQ-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWLP265MB3219.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Wed, 23 Jun
 2021 14:47:35 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::259d:65ac:ae6d:409d%9]) with mapi id 15.20.4242.024; Wed, 23 Jun 2021
 14:47:35 +0000
From:   =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Christian_L=F6hle?= <CLoehle@hyperstone.com>
CC:     "rafael@kernel.org" <rafael@kernel.org>
Subject: [PATCH] kobject: Safe return of kobject_get_path with NULL
Thread-Topic: [PATCH] kobject: Safe return of kobject_get_path with NULL
Thread-Index: AQHXaD5guylz4e+fzky/qfcToJhYzA==
Date:   Wed, 23 Jun 2021 14:47:35 +0000
Message-ID: <CWXP265MB2680094534A5559B0A904B76C4089@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ac332ea-f663-415d-fd11-08d93655d6d8
x-ms-traffictypediagnostic: CWLP265MB3219:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CWLP265MB321955A4A1E071725A5A4B06C4089@CWLP265MB3219.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: cY1fcBu4kMTVHLU84l9UoXZwNp4IeuOT4WCL7RkK5kV+wBYpscQtMeDiRSJY6xEiVVjJ0oHUhD1oJ3Kl5fEUxxUDKBjs5jJYqMg67cdEv+n4VsdXcGIhwS23gRa3sY5bw8YQFcSYL9Ukv4LJhAfJlanc8p3Cg1U9Gt6FymiP2nv1biuZxLBNDvJhizJ5dv74pOTRM7MPMqmuYG5Fr7gBfgGvG7AWGOuGwvQgVDYBFPSew+h54oCUC3kwVs1KkZhi/oIyUFapKct5scQMjdvhzByf6ZPHxSrEn+GD2F+fk6zhRi7k7ee/4/kFDo3efbPCfh88NlxhIR2BOtydBmTQh7IVT4hkAjxkoqbmt42mxQE7lDyvG3z9XkPqcPIpKuUFY3JSEs43nTqN7rGkBfOVLQbHz2LhderkJi2Jfam/sd4tfHi09zQ/KkWz6DRuoRjgEH4aqrQ7SzkVhKSwjP64j19QinItIAj+qhPtXw9SgycuL2i4BlEH2CeTAnE13n6GmTvwLWyFshIiNWJxRDbnNJjm7LmsXoEccTMbU3xI4JCxUasnyRtcqNSxH+u4NC8Mv30qTPutn1xpuhwXRBOkdc8kel5s9Uae59eJFpvSRmM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39830400003)(366004)(346002)(136003)(376002)(122000001)(26005)(66946007)(66476007)(64756008)(66556008)(316002)(66446008)(186003)(52536014)(2906002)(33656002)(4744005)(71200400001)(38100700002)(91956017)(9686003)(478600001)(76116006)(6506007)(110136005)(86362001)(5660300002)(8676002)(55016002)(7696005)(8936002)(4326008);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NuLa2C76zWYOwtzaAC/lckOg1ZDfJcIIRu5oBDdngEhTAy6a9NB/oDDo4h?=
 =?iso-8859-1?Q?K4vPyB2auuGnwEm/Dbg29sTifCZfvIFz99DfdQwAgN5ZuKGWM2flVDhwVh?=
 =?iso-8859-1?Q?jUr586cqHgMy/MrPl9bC+xzCCnK40CULEOfX0v/VhybumL7m/eXxbUCCFq?=
 =?iso-8859-1?Q?WdN5OScygdNH2QLGw9wTDlOuO1RgBUMUQ1myNPlnrM/K4NF6AOyEUD88AI?=
 =?iso-8859-1?Q?rgwxl7htvn/EJOtCjTvpKdWPwwNckJDb2TcqvkGxoGlMAXBtuonD0/CcZi?=
 =?iso-8859-1?Q?MQUyH/12jSe9N8yzEn/EhYUJyIATaXspq/LUvoaTnwlK9IftwwIEpHwtsk?=
 =?iso-8859-1?Q?k1tjg83W07eyGJamI9Q0u5elPBnrsncoBeToB0DmLqeZhIeL1qD81wBwHz?=
 =?iso-8859-1?Q?yOwbE1wodHfSVbmtChN1flUNkQ+xGnzqJ41ngL7hZlYN9VPDLb6QieXjU7?=
 =?iso-8859-1?Q?6Xc3EUiiKj0Se6MMIORadgjHo2JL0andk3+iZyYXkYZBGipM9mbJwcwX/T?=
 =?iso-8859-1?Q?gF7FiX3xuvsSQWcNHT79XpPDVjDqsBuEgypfM9Yaem2NDAwEWa0uicuaA9?=
 =?iso-8859-1?Q?SO0457mkjqJt1zxjNAv9YYaDo5vAbOc/NB0kevw6VlnoGW57NXqCf4MhKz?=
 =?iso-8859-1?Q?+cdFC6ebmHW/Rvw+wFLjYTZXNJJ3Y0cszJfmUgp2lcCKMvj1zwfRdQxzJ0?=
 =?iso-8859-1?Q?L9UILO59Po7nY9ODU/q1TlBd//XCJEwtQF8rYDvXJzav639Sp5wJRkE2Hm?=
 =?iso-8859-1?Q?fdlNJtxQiw/2yrDtrTKD3dQ/l46kn84S+kuCjKknGqLzEj9M2sHOed8ljX?=
 =?iso-8859-1?Q?8WlUhFc5MW7yItQNgpEyZ3QDL+yCGDTHLb07YfjG8+SF1ELH/Xz6+wtbfB?=
 =?iso-8859-1?Q?5qQt5HaRjGAlU3HB6eyN/OitNcDsDsqXH73qsUc+uS23QhV4RHfQ0ok8jZ?=
 =?iso-8859-1?Q?z1pMvKzcXY+vkAC/qB8smwohpmGwxWzJqrCZG+jNDzhrevsVcb9V3xvl6y?=
 =?iso-8859-1?Q?QjXn3G5j+lPqATXpOMVbotzZEXsqhD9lBMxY/V2efWALZ5XA3jaAzmxc01?=
 =?iso-8859-1?Q?Cr2jTA3TOd8LB6cYesckMqFpjCVun2R/SfybbPn0bKxWWQRYqNGgm1oLWh?=
 =?iso-8859-1?Q?CxQZ6cZFKvwXbEhy3WZLTUaomwI1MtPS2WUuX1GhvJxYsyaEcrZY2b4ZbK?=
 =?iso-8859-1?Q?AHbU48UihHWj3QX5GkO8CvA1N+aj3DTt0AkEzJwwCWeqZiRccU2tVVPTb3?=
 =?iso-8859-1?Q?ABw0Q3OuhULVryET72LA3ZQyg0Fx8HEbkkDKvIRIl1fIH7ypPyJ36rL6lV?=
 =?iso-8859-1?Q?SFf8q0fR3oBdkUS53CpVosy4THYlA7tC0AIsNWpkx9nheIg=3D?=
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac332ea-f663-415d-fd11-08d93655d6d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 14:47:35.3464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Ou7X38HYkM/pLSaHmaXXLgHMLN0fZ25b+eE52UP4qVk3L4eSaGtLawMPcTgcgqKwUSat0nXNx1312ERaY1RnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3219
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hyperstone.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent NULL dereference within get_kobj_path_length

Calling kobject_get_path could provoke a NULL dereference
if NULL was passed. while fill_kobj_path will return
with a sane 0 for NULL, kobjet_get_path_length did not.

Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
---
 lib/kobject.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/kobject.c b/lib/kobject.c
index ea53b30cf483..735159c13a94 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -130,6 +130,8 @@ static int get_kobj_path_length(struct kobject *kobj)
 {
 	int length = 1;
 	struct kobject *parent = kobj;
+	if (!kobj)
+		return 0;
 
 	/* walk up the ancestors until we hit the one pointing to the
 	 * root.
-- 
2.32.0

Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
Managing Directors: Dr. Jan Peter Berns.
Commercial register of local courts: Freiburg HRB381782

