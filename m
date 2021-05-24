Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC5038E0A9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 07:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhEXFc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 01:32:28 -0400
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:2958
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232238AbhEXFc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 01:32:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbmDt5VTtRUpWTMjA8W0mcIKdcW/Km/OBtTxVqhJ/s/BZrqU++FV5HAwrUYXh+UDZ9231a+3Hp6600O+Z9qlGTcfTDW58Tt2KxLYLuyVYHFYgLLDTj5YIocobdA0IMdtHCeGm/FybiaY0Y0OlmzWmxVx+eHglfUON0jD0Vmcf2l/jSpCPYNjLv5Q1YqWY2WXonnXtHJm+HmzI2v33evR6rpgvRAfqdwZf8M7prGuz/8dz4OmT1hlziD5SQTlD29NznUoSXlSgxi+LPyEjACTrKrdSjr7v5nLg1xQgVa5iL9NH6E5GK84Gv88KE4/ZMQ0PfkOzViiTMXJMpHdbYRRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCm4baPrTHWgHV8UwqAq9eGdspWdEPgZnsxHd+o20QM=;
 b=Q+4NAwgDb0FISjFHH2HHQxAeXynHLIicyJo4nXpHh0znm1DinbQXhFvZGG08Slk/cOnIRNy8fa1/LhM3gddIA9YwQ1h4ov/NxYrSg8J+ffwedKvdgpoiyninPUshHaItnYU21fJ7Qm1uWus3Fxgf3QD/e9016BpIjyi7p/AnWzt5ZrYE8P7p6FAiW+RgVX6n/8iTO/S6n0Dan9Y6g3vpiH0EBShsWiBEGZea8vutKMgrAVGrQjKPawC0z9rSVubPx7knAgRfzyTPMDxAVJubalv4Lj9kKHoq4JN4XaiZqqLorLiW9flCXilCCUcsGGooT70lJ1AoJiJxkztF7/zjxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCm4baPrTHWgHV8UwqAq9eGdspWdEPgZnsxHd+o20QM=;
 b=lbAqeiF9CTkH/7Wg/6vgg/21gB68fngog2FduU25J1SUFs0E0UPwocls+DW81SwwxZLMxm+9lhpTEjOB8x6a33UqcgRDkgFQRu+WJSwSv7gFI/2yEHaDMplNcmowkxb5HlgDNy5/Swr4v2AFPHXSTRS2Uct2OBZJB3n38zNg0ZY=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0302MB2585.eurprd03.prod.outlook.com (2603:10a6:3:ec::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27; Mon, 24 May 2021 05:30:56 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::89f0:ff95:a73a:cf4b]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::89f0:ff95:a73a:cf4b%7]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 05:30:56 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
Subject: Re: [PATCH] regulator: bd71815: add select to fix build
Thread-Topic: [PATCH] regulator: bd71815: add select to fix build
Thread-Index: AQHXT2ibSd4tUUzjsEavfTgHZLlZNqryHR6A
Date:   Mon, 24 May 2021 05:30:56 +0000
Message-ID: <744ae90afc192e0b527ddfc4c54ab9fccfa9343c.camel@fi.rohmeurope.com>
References: <20210523001427.13500-1-rdunlap@infradead.org>
In-Reply-To: <20210523001427.13500-1-rdunlap@infradead.org>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dcaa6d4-835c-4ca4-4744-08d91e751b00
x-ms-traffictypediagnostic: HE1PR0302MB2585:
x-microsoft-antispam-prvs: <HE1PR0302MB2585AC4B643B9CF162AF2813AD269@HE1PR0302MB2585.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k8GHOWV8h59oc4bhspZ9gOGBL1vbc2L9h7+OsKc4RucnKZXmc92nQ1W7DaB7rk7MMu6ThFunTU2hOyWm38uuo4LrowhktQVyR7kGuTFuLI2esSsd6n19BQ+LXzRenUg1gMqdUZ5b0WZZxBC70/CVcYhII6jMdzxo0F1QL7UeqgVkiG466gPKINESE62MqOGSnerpGObT9TqirKu3/dpZc6eIhTaUiR0WAkmW3EUjwoWjtOVs/0gVYvYPnHCge5AQh5OYUKwYeUPiU/VZeOGq3GGQrmSKRG1Bu0/TrI3DmIkwdYlbunOHZcc4Y+7EFHwVhWyKPCVoMdDSvBmvEF1M+2iFqH4JpVp5BrwC2FbK9V04fC+mq1qu4SlELjD9G17/yxWqcOK5pGyaCJT7LNDxf8T7/KGLoePLMlpDZbcSAqw+TdIsPrLgyoFxj1b/Ba67pCqOVj4uJrBdYlEK41H3UXBi9KY28CIgnR6EYmPe+qg0T7M2eJjDwmbwtPBabi8FdIZ99qxw1gFd/Xvs+DvBa13cpS7+n/Bi+FZYkySvpG8pUQCYii/UvyGuGv5AFhsxyG01j4s9TatVx3dQfnSAG6lpN0GScAuZNBMFYa3o7dM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39830400003)(366004)(396003)(376002)(86362001)(186003)(2616005)(316002)(64756008)(66476007)(66556008)(66446008)(71200400001)(4326008)(6512007)(478600001)(8676002)(54906003)(110136005)(8936002)(3450700001)(2906002)(76116006)(6486002)(38100700002)(5660300002)(122000001)(6506007)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?L082OGpVOTdZcGkwcVdrYU9lcm5zRWNjVFo5QUw5YkE1bVVLRE9YQXNaQW1l?=
 =?utf-8?B?VFJmd0VzUmJWR2ZDTlRjc1lBTlRGUDhzTXV3QTg1WVBxSVJTUEpvaDN6ZE5K?=
 =?utf-8?B?bnNEc3kvQlVqdnJ1TXU2OWhQNmRtU3RjcHowZm9RTTZNdzQ0aE1OU1FCa1hL?=
 =?utf-8?B?QTZ6VFI5b0dMUUhzdFpsQUUxTWVleDMzMXpUTG5QMjVqWEhlUGQ0elExVVdH?=
 =?utf-8?B?NFJLbG8rWEZxcXBBVlhONGk2OXY1NVN6S0ZreW1ZMnpqdlFOYnlMd0xtaWRq?=
 =?utf-8?B?VEQ0MEp4UytFbXdra2swU1daeGNkb21sdUphSGtjNEtpNjI5bXlxZUh4NXlV?=
 =?utf-8?B?eURGM05vQlRtVjUxazg1bjZIV3JmblB1M0ZaNjRKdG1aWjJrZVJXbFZNRmwx?=
 =?utf-8?B?ZHFXeFhGWmZqY0NCZi9PbTUybzMyM212WHp5dDdtQWdWeENQTHp1RjFYZDBZ?=
 =?utf-8?B?UlFSTldwY253aWhFM043S05mNnpyckY3YTBDaHhjME1tck5tRXl1a0VjOVkv?=
 =?utf-8?B?Z3paYkcrd2dCU25FL3JQMDVnYkprQi9vaTgybjRXNWpRUkgyRm53UkFGNXRP?=
 =?utf-8?B?eWZFV1VhRmRyYkVyZXowYlZGd29RU3VIMFoyeWw2TjR4OUxCY0RLb0VIQTdt?=
 =?utf-8?B?K2ExSnJubTRCSGs0UmJtUVdiRjNqTm5adlJITHhhdzV5VG8xTCs1ZHFIaERJ?=
 =?utf-8?B?YVlCalNjOE94VGo5UzZaV1hadTZrTzVuMjc5d1V6bFUrUkZZOW9vV2U2RnND?=
 =?utf-8?B?TStEMTFRUVU0am55TWVvUVRadG0rT0ZjOGJwWk9idVVnZTIyUG9WUU05bUVO?=
 =?utf-8?B?Rm5yU1hJMGVKZ0loQ215UDczcmcwYUlYV2NqZE9JNmtHMjltWGRlOXlCbnVR?=
 =?utf-8?B?QUNRaGR3WWNYS0x5MmtqdDI0M3FSeWhJTUx3OWZHOUp6Sk1yRjQzV29Gdk9H?=
 =?utf-8?B?Mk9odUcyYnZhOXBCeXFXaDJ4NENQaUp5ZGNhVmlSME9POXRtY1pLSEw5cmxB?=
 =?utf-8?B?aFF2ZW1jTUhEaXJxODRlUGZOc3hlck5zcWYvQTlVUkw5M3N6K05DdkhVdnJJ?=
 =?utf-8?B?UkJOeE0raE9ZQnh2REtVY1J6TXJOdTcwWnU2azl6TVRCMWFSOFlvTFM2djU5?=
 =?utf-8?B?eDhKTDVEalNCNDFXeDhGSElpN3o3WGg2SXFSL0YzZGovTU11VlJuUytQbE9D?=
 =?utf-8?B?ZW9OcFNQeTlaRFFLMUVwSUM3UUdyTUQzWnVvdmpCd0N1eWRoQnQvUVNMRGpQ?=
 =?utf-8?B?OVg4b0JGUDhPQWFieXJVTlZXU0R1OExWWG1MTzRUL29xa3ZHZkJmTlFBWk5X?=
 =?utf-8?B?QUJlRm0wUERXMEtEMFNLMjVmdzZ0OVoydGFtdktqUGplQWtUVFg4dk1TOGdm?=
 =?utf-8?B?c2JGTnQ1QzlFd29oRzROZkJjbzlwSFRYWm9zblY3NGpUNURYNkpZMUpJeE1U?=
 =?utf-8?B?RFFnc1hJZkVTOHR2RlZiYkkyQ2V0eDlrUVg0TkttLy9Ec0tHandkbG4zVDRX?=
 =?utf-8?B?OHQ4UzhpcndFT1p3UDR3VWxFYko5eHRudHAvNUtUTnFKb2dlSjlCZ1pBRWtZ?=
 =?utf-8?B?d1RJU0g5VS9uaG1ncllKWEtnVGRreUZ6T0twUnUvQkJOR1c5QmgvbkZoa1dS?=
 =?utf-8?B?TEhIdVpVSGw1YmxkYlZ5WDdWUXU0aGl2S2dPREdHSjA5T3NwNHdFVFFMc0FO?=
 =?utf-8?B?RjR6RkhpTjBKam93VHQ3dGlXYjhMS2JtbllLc2IvMGh0eXVYd3JkTkNOVGJL?=
 =?utf-8?B?c2hqMnNuWEhaaklkT0RPNVN6VS9IWjArdUhQNmc4OFQ1VTErL2hjN2k0RERJ?=
 =?utf-8?Q?PFIQi/Zn4rVeNrAH24lRSXaQ2phoGimmSkOxY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5650809BF90AF4DADDB4657E166DAF3@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dcaa6d4-835c-4ca4-4744-08d91e751b00
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 05:30:56.1058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgiKtO/UtoOtay30c44B/Ylr1DqfVQYTRGpA8jRs4yZd2htEqo/puLTjobBzzwW7e7zPhPBqQ7NMaZIfawoqJxhbDGWOVgYVsxamXM1dWxnVutdbTL9weAqD64D9iL/C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2585
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBTYXQsIDIwMjEtMDUtMjIgYXQgMTc6MTQgLTA3MDAsIFJhbmR5IER1bmxhcCB3cm90ZToN
Cj4gTWVuZCB0aGUgS2NvbmZpZyBmb3IgUkVHVUxBVE9SX0JENzE4MTUgdG8gcHJldmVudCBidWls
ZCBlcnJvcnM6DQo+IA0KPiByaXNjdjMyLWxpbnV4LWxkOiBkcml2ZXJzL3JlZ3VsYXRvci9iZDcx
ODE1LXJlZ3VsYXRvci5vOiBpbiBmdW5jdGlvbg0KPiBgLkwwICc6DQo+IHJlZ3VsYXRvci5jOjI4
OTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgcm9obV9yZWd1bGF0b3Jfc2V0X2R2c19sZXZl
bHMnDQo+IHJpc2N2MzItbGludXgtbGQ6IGRyaXZlcnMvcmVndWxhdG9yL2JkNzE4MTUtcmVndWxh
dG9yLmM6MzcwOg0KPiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGByb2htX3JlZ3VsYXRvcl9zZXRf
ZHZzX2xldmVscycNCj4gDQo+IEZpeGVzOiAxYWFkMzkwMDFlODUgKCJyZWd1bGF0b3I6IFN1cHBv
cnQgUk9ITSBCRDcxODE1IHJlZ3VsYXRvcnMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5s
YXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gQ2M6IE1hdHRpIFZhaXR0aW5lbiA8bWF0dGku
dmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0KPiBDYzogTGVlIEpvbmVzIDxsZWUuam9uZXNA
bGluYXJvLm9yZz4NCj4gQ2M6IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz4NCj4gQ2M6
IExpYW0gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFpbC5jb20+DQo+IC0tLQ0KUmV2aWV3ZWQtYnk6
IE1hdHRpIFZhaXR0aW5lbiA8bWF0dGkudmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0KDQpU
aGFuayB5b3UgKGFnYWluKSBmb3IgZml4aW5nIHRoaXMgUmFuZHkuDQpJIGFtIHF1aXRlIHN1cmUg
dGhpcyBpcyBub3QgdGhlIGZpcnN0IHRpbWUgSSBzZWUgdGhpcyBwYXRjaC4gQXMgZmFyIGFzDQpJ
IHJlbWVtYmVyIGZldyBmaXhlcyB3ZXJlIHNlbnQgZHVyaW5nIGxhc3QgZGV2ZWxvcG1lbnQgY3lj
bGUgYnkgUmFuZHkNCmFuZCBBcm5kIC0gYnV0IEkgdGhpbmsgdGhleSB3ZXJlIG5vdCBtZXJnZWQg
YmVjYXVzZSBjb21taXRzIHRoZXkgZml4ZWQNCndlcmUgbm90IHlldCBpbiByZWd1bGF0b3IgdHJl
ZS4NCg0KSSBjb3VsZCBnbyB0aHJvdWdoIHRob3NlIGFuZCByZXNlbmQgdGhlbSBpZiB0aGV5IGFy
ZSBtaXNzaW5nIC0gYnV0IGlzDQp0aGVyZSBhIHdheSB0byBkbyB0aGF0IHdoaWxlIGdpdmluZyB0
aGUgY3JlZGl0IHRvIG9yaWdpbmFsIGF1dGhvcnM/DQoNCj4gIGRyaXZlcnMvcmVndWxhdG9yL0tj
b25maWcgfCAgICAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4g
LS0tIGxpbnV4LW5leHQtMjAyMTA1MjEub3JpZy9kcml2ZXJzL3JlZ3VsYXRvci9LY29uZmlnDQo+
ICsrKyBsaW51eC1uZXh0LTIwMjEwNTIxL2RyaXZlcnMvcmVndWxhdG9yL0tjb25maWcNCj4gQEAg
LTIwNyw2ICsyMDcsNyBAQCBjb25maWcgUkVHVUxBVE9SX0JENzA1MjgNCj4gIGNvbmZpZyBSRUdV
TEFUT1JfQkQ3MTgxNQ0KPiAgCXRyaXN0YXRlICJST0hNIEJENzE4MTUgUG93ZXIgUmVndWxhdG9y
Ig0KPiAgCWRlcGVuZHMgb24gTUZEX1JPSE1fQkQ3MTgyOA0KPiArCXNlbGVjdCBSRUdVTEFUT1Jf
Uk9ITQ0KPiAgCWhlbHANCj4gIAkgIFRoaXMgZHJpdmVyIHN1cHBvcnRzIHZvbHRhZ2UgcmVndWxh
dG9ycyBvbiBST0hNIEJENzE4MTUgUE1JQy4NCj4gIAkgIFRoaXMgd2lsbCBlbmFibGUgc3VwcG9y
dCBmb3IgdGhlIHNvZnR3YXJlIGNvbnRyb2xsYWJsZSBidWNrDQoNCg==
