Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75DE3FD39C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 07:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbhIAF6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 01:58:20 -0400
Received: from mail-eopbgr1310091.outbound.protection.outlook.com ([40.107.131.91]:40928
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242462AbhIAF6P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 01:58:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDwCdhgLSyGF725EnxHmVEXVam7yrMYr5Yv07zJkLhe5aMGTkqVGfsTdYeD6XDnMwVFDYR5oBD9/sByFrHwAnHIOLaLO/Y0HUj2vCYUxbgDySAd2U9umnV2GFlS/Ku9+S3x55sOxrvDdTraNA0R+mqidkwdw3Chclvct/1lrCFTRsfydNQc8iIdkjdXmqWy6pmd0rASRb1AqcAm2N/q7UsBHJ4ks2mUql3Z2T4mfbhEJpZdnGPQ8+FyZn91X1MaMqBJcyRki/Vxyjn5/EIb4IdyBiumRIJc1N/AOWlO6Ev1eBRVtLyptOU/Li4c1wtHTdYjGBEbo32pHCeVZGAe7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9Ng+ku3A0+H1faci6doI0YHkxzH/Ioc9YojX6SN8SQw=;
 b=CieACavtD9BYgXcTkwfBjDonSpS7iMqb7VgPcMr6DZ2YQ+BC11qNfQJ/OBz12WdbXCesTfuTn/tuU3HRybTFB/Nt4Q2U/vTV9eN360QXOU/P0xOxs0Purj7ORcRbSzwYfQSs7/W2/2IMpPeQ3Gwq8lVGiudYM+zf0WWbn/ZcJVmDiCiyooq21SaTVyRQPAfcdtWHc70dnplNp0A7oFd3kLatiNSKkgcZxE31ltl532dYn6o4P+2lbbgy+p6xjCd1v9xooNheuLWjYVIfpZE4KngVZwrifUjXllhecmjE0vRQa/3sCzYxHCPBBqpwjYP7eI2afrKF7dt0Bg9hGtFFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ng+ku3A0+H1faci6doI0YHkxzH/Ioc9YojX6SN8SQw=;
 b=bBJRPvwonneafvABAYEVylmuSV439HMXFl392p7T3VlKa0Q76+Lp357rPV/nfajqdVwUSle4b2MWIaZVcBStX5pGONcG8aVl4uozaoq0hhwunrS0fXLoxc6e38drry3G3dTE6JRo1zpoVoUR83Wx22WFV1DOP1O0XUTval6IZ5QDrkRAvoEsuVwy3ocMmlIjH/kTdrbrMRp+RkxjFMavowDDHYZTR+YmLyJ2lYgmJlW8ELSvZdFdkdruK3hvj/aY0SaW17/KQQy4sGIvMaAUM9MDhH/5oOIMLdFT7HiydQfnXX5Z06RbWDqan3ZZNISCTiQwBGROv9S+QKCNfe9diw==
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB2340.apcprd06.prod.outlook.com (2603:1096:203:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 05:57:17 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::81e4:c1:aa1a:aa75]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::81e4:c1:aa1a:aa75%7]) with mapi id 15.20.4457.024; Wed, 1 Sep 2021
 05:57:16 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Stephen Boyd <sboyd@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>,
        Michael Turquette <mturquette@baylibre.com>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/1] Fix AST2600 hpll calculate formula
Thread-Topic: [PATCH 0/1] Fix AST2600 hpll calculate formula
Thread-Index: AQHXlAfOaCLwvmFodkSIdbogCAYGs6uJ9w0AgATNPPA=
Date:   Wed, 1 Sep 2021 05:57:16 +0000
Message-ID: <HK0PR06MB33808EA257CE5B70677EA393F2CD9@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20210818080518.9491-1-ryan_chen@aspeedtech.com>
 <163021184290.2676726.4978141961679779291@swboyd.mtv.corp.google.com>
In-Reply-To: <163021184290.2676726.4978141961679779291@swboyd.mtv.corp.google.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2ac02719-a227-456d-f1ec-08d96d0d5a7a
x-ms-traffictypediagnostic: HK0PR06MB2340:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB23403F1749BADF5AC3445322F2CD9@HK0PR06MB2340.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LWqJN2Xjbq55BpGjAZd6hrJzy8yI3OHp9wfBnC33cLBiG9yOQ3769X9lX1IVKNSCiElukFko9R4V5S9IZy2tcie5UXw8HapMCfOuFs+U1sxfZbHleObK3FTe7wcxZZE/mj7aOQxwREFVQrpMHmqpBwGPZj/smKtBpsjPGy7BrHxaZjMexGwG65l4KHI2bov+rCvDxJ3m3nB4Isv06ehI9krQLU53Yka4jeUhGtS0SQwwsDZ7+wzj6ohKa1ePl2Sj2mPKsNME28k4FYXWRPUmhwDlODQxHMqXPXhe2t9Hy8hjtmgiD1PSJuq00SVZ9eIZky1kvabhPn7cSgx4zoUkbxoYVZicdMQDlQtueI+PwmKYpn0TLNpuwYDM9IQdm2KfmyXdAA+XZUsfA4cTMIoLWjKlceuXRQwS45veySH9xTD60KtmNGDv/i7h8fn49NwYSwzbIGFp9QR9os3PcvduOIOXPN/X4iOpCztzIUm7OgArHBlLdehvwZuLUuUkS7m4e2qRu2tIWyaGGyzgz6ImaoiMiubr2OHvX0oLiTkMpS1bS9jrtLZ5fZMHLy8TcQqNkGw0wqP+CCLuQEBfGCzuKCxJJvJo+PcfBZQiQZldHuDzck3EMws02/Nk4KVtCWqZKMvckrpSmi3PyJpuRlNflVpCgWdSvOOHHxkyy0n7C2q0qTEdhIZ7mpeAV5/vPHMaZzkMXibUCje8afv1rBnwzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(376002)(39840400004)(66556008)(66476007)(83380400001)(8936002)(76116006)(33656002)(110136005)(66946007)(66446008)(64756008)(26005)(186003)(6506007)(7696005)(53546011)(316002)(8676002)(478600001)(122000001)(2906002)(5660300002)(71200400001)(4744005)(86362001)(38070700005)(52536014)(9686003)(55016002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTAxUU4yMHE3L1RBQm9sUmR5RG1ha2tuVTRERUZuV3Fkc1l1VzBhN2tPbnV6?=
 =?utf-8?B?ODlaNEplQlVNV0RRTjY3M3ArSWUwT3dEYThFcGI3dlNUckZzajNmM3I0bFQ0?=
 =?utf-8?B?Wm1qMHhrakZ1K290S0ZaS0tDcXhVQy8yQzdmY3VKYkhlZEgyL0tMaTIxNDlm?=
 =?utf-8?B?SlZwSGJqVHFmNjlhTng0YlAxUHdCZ0NGNXlxUHdiVUNJcEVkR3dwNVlIMy95?=
 =?utf-8?B?RkFIVlR5MDBuNUdqWHBNLzkyK2JmZDJTMjdSaWRZZE9DLy9QSml4N2QyeUpm?=
 =?utf-8?B?V3c4YmcxN0tOdEpySUYzcFBYZFBTcTNWUUJFS0xXMEU3S0U1c2IyQlBzWW5T?=
 =?utf-8?B?Z0RQT0FWYzl0UHF4TG5mM29VS295VTljek1RWHVxT3NNbXFFdTZFN0psL0g4?=
 =?utf-8?B?WXNkTlBUWU5IcHBRT3ZucUMvWDFXS3Q4WHBsRzlaMUQwamxvRmtPV0MwYjcw?=
 =?utf-8?B?M3ZZWHNNaEhkdjJjNXlIcS9iK0R1OGFiS2xDbkZlZFFhSEhnMmVZUDNUU0R2?=
 =?utf-8?B?SktNVFBBZUJWbEFiOFRZVGt5cElySFhJcGFWRUdmWncrOFh5SWQrdWdic1Nz?=
 =?utf-8?B?UHYxNFU3NkhLL1BaODhhT2d0RldSU1dZaEJZaVZrUk5kd2FtQ2pWcHdic0F1?=
 =?utf-8?B?bjhjeGMxYm5HWGlUVGZNREh5UTV5WllQSERZUURxZmxzM1FKbExhcFFTTkVZ?=
 =?utf-8?B?V3JFTHQ0UkdHdGZ2M2ZCcGhWMkwxNnBPUXZycEFORDEwRU9aVE1BSjliNDdL?=
 =?utf-8?B?L1Q1VXNwYXdMeHhuVTVvWm5kdnJCNHpvdWZsRFVnTk9tK1BtQ2c0UmlpUjhR?=
 =?utf-8?B?Z3RKWG5sWmEvY1lneHZFSm8zMkJBOThWc2tNZUlXZWFZSmdSVDZGOGhKV2Iv?=
 =?utf-8?B?ZEJJZGxFR0JYU1dYQUYvOVQwbTRhSGFYRHdRUHhpaWdTd0psK3oydFFEeHpz?=
 =?utf-8?B?SDJ4d3EveDJaNzUwWGhpZXlQU0ZCWmRCYlYrZCtza1YzUTFJUEpqdkFLVnRs?=
 =?utf-8?B?amZvdlNDaXhoSUNvZGdJZnlDL1BIcm1yY21ZTFJ3dGx3WHY3a3ozclNYaitq?=
 =?utf-8?B?NTZZbVBFa0pPb3I1Y3JxbEF3M0JBeHFDZWpDc0owK2ZCSUZMMHJ3SU1YbDNw?=
 =?utf-8?B?aEVaMUxrODArVlpZUG5VVGNmYlZzOUxMY1FKc2pNNjBMR1hMUkFsdFNEY0g2?=
 =?utf-8?B?am9nNHBOQm9aRHFFWVZIVXR3UHhqM29ZTG5RbWE3OWFBeU1IVjQwSC9KR3ZN?=
 =?utf-8?B?Z3VzcTlZb1RRK1dpek8rYWdHS01uNTNIbEVqd0xrR25HL2EwYXZ1T3BQQkVC?=
 =?utf-8?B?SFhULzUxSzdyaDFsQ2dZTDROc2tOeEF2VitoV3lNOEdHV2gvOERRcUVFTXpU?=
 =?utf-8?B?NjJ3dm95MVZRSHgrNkxEb0Z3NU1EZkFLdHFEeTlqYkVvRFVYOExyakdBNHU0?=
 =?utf-8?B?WTlmM2dVMjNkT28vL1FDNUxGbDF0WWluNzVxdUNGM3VqTGVIeU1DTVN2dFVY?=
 =?utf-8?B?MTBhZUpsKzVxc0I5ZkRMRTVPZVNNVEhnV0xFdVpLbzVMYVgxRmdVRXJKRjZH?=
 =?utf-8?B?WVA5K1VmTVhQRC9YMm5rWjFLYWdjbEdQd0lkODhuaG9MWHh5bTZPUk9rVmo2?=
 =?utf-8?B?SGFRZDljU3BwSHRlcmVEekRJMVp3RGFINXErV0l1YXB3TEFOa1Vob1FsaDRa?=
 =?utf-8?B?NGFKUWs5cnl2Tm1uRVgxcDcwSTV3Qk1wVXRCdW5DdmFHdytrUmpUTi9JSUhn?=
 =?utf-8?Q?/S8UI2B3Cqn7yefxdIkzbt5fF2obuyu7XQmnjqd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac02719-a227-456d-f1ec-08d96d0d5a7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 05:57:16.7826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wna5mIvLdYsxGsblrXOLvLddWsp2U3xy6kOM0UGuYwd4vcjaBd0uqRE5XnnZ3te5B4yQlspsFfAmL9zQBeR9J+rdTa/j+lT8wTGf4P3XnFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2340
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVwaGVuIEJveWQgPHNib3lk
QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFN1bmRheSwgQXVndXN0IDI5LCAyMDIxIDEyOjM3IFBNDQo+
IFRvOiBBbmRyZXcgSmVmZmVyeSA8YW5kcmV3QGFqLmlkLmF1PjsgSm9lbCBTdGFubGV5IDxqb2Vs
QGptcy5pZC5hdT47IE1pY2hhZWwNCj4gVHVycXVldHRlIDxtdHVycXVldHRlQGJheWxpYnJlLmNv
bT47IEJNQy1TVw0KPiA8Qk1DLVNXQGFzcGVlZHRlY2guY29tPjsgbGludXgtY2xrQHZnZXIua2Vy
bmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgUnlhbiBDaGVuIDxyeWFu
X2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8xXSBGaXggQVNU
MjYwMCBocGxsIGNhbGN1bGF0ZSBmb3JtdWxhDQo+IA0KPiBRdW90aW5nIFJ5YW4gQ2hlbiAoMjAy
MS0wOC0xOCAwMTowNToxNykNCj4gPiBBU1QyNjAwIEhQTEwgY2FsY3VsYXRlIGhhcyBmZXcgZGlm
ZmVyZW50IHdpdGggb3RoZXIgcGxsIGNhbGN1bGF0ZQ0KPiA+DQo+ID4gUnlhbiBDaGVuICgxKToN
Cj4gDQo+IFBsZWFzZSBkb24ndCBzZW5kIGNvdmVyIGxldHRlcnMgZm9yIGEgc2luZ2xlIHBhdGNo
Lg0KDQpHb3QgaXQsIHRoYW5rcy4gDQo+IA0KPiA+ICAgY2xrOmFzcGVlZDpGaXggQVNUMjYwMCBo
cGxsIGNhbGN1bGF0ZSBmb3JtdWxhDQo+ID4NCj4gPiAgZHJpdmVycy9jbGsvY2xrLWFzdDI2MDAu
YyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAyOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiAtLQ0KPiA+IDIuMTcu
MQ0KPiA+DQo=
