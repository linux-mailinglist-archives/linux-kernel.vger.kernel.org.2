Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CA3393F20
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236242AbhE1JEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:04:21 -0400
Received: from mail-eopbgr00089.outbound.protection.outlook.com ([40.107.0.89]:62339
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234769AbhE1JEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:04:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwRId6CYT8LCHlxFWJsN1/qlUoKvRuG1Zwy0Of9MBZkaVCpwVStdsio21ZjjJ0A6KbAdddqwgWtwM42I4Bz6/WFLEAchDiLHMlUXfCSv7JoKRjoxrPojWsnbb77334ki44V+XowjX2GXzAK0+93UseywX46MXtnkRraN8vEqlHyWJwQybU7Q8uB64+tRSsReLUW2v0uIqxjL6fEBYKZVI1u5RTmE7DpRB1jCmrPLrdce4ZpQjBQSY+l9RyVsa2GuVy8DB0UZm7I3ypsZpJDzQXiZNKsdJBsvmtEece0nhxFg67p8qY9QIBgMlGt5BaqYIpEsqT5srxsne6hOO0UoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvBxuaEtbZPZXkt8osRwEO3oSrS7+eOFWMxhaditLm8=;
 b=GOwucVsC3jsOZU7ROFFM4a/6+WpJNFR8TR/pcprNAbOwQEMW4DJCyJ95zP6S0f+rFpHLcvd8yvIRztfKNsCWpFLHVIL2A5dIzLGxeaS2vjl2RKtqlJ0DxQt3wFZwaeGw2aIGDSRLY/tXuJ5mMVYwlMVwExssryqDKGM4cM90DMCS28oKg07s6zdvfJe3na4FsJ4wiftN7D0WrXSv+Sz0HVABmUNPsPXDvJwJAuLe3HjZxDQoXRZPKb243zopopXdmrJkPOAhK7XQmjxXQfiAdYihX50IWc6M/IyEo5b8cpYvRseDKKyoeKVWMy/A7Allp9Tn3F9wZte+N/gagUJMDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvBxuaEtbZPZXkt8osRwEO3oSrS7+eOFWMxhaditLm8=;
 b=DxpCwLYYZFdVbdn/BJyQVAS73VPJbEYhFn2QQw24jFOtlFVgPfUUHytB8FwSGymdzJNICcOENZZW4h/S5X9cK04aCJS/TJMwovwflH+eMT96QP6PY8aDg/ugwAgm0Uum2wxpaZAbAv56gPZfI7D4V6XnTM6+m3TeFgqf6njFqTM=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2393.eurprd03.prod.outlook.com (2603:10a6:3:68::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.24; Fri, 28 May 2021 09:02:42 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::a88a:6fa9:ab7f:4a44]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::a88a:6fa9:ab7f:4a44%4]) with mapi id 15.20.4173.026; Fri, 28 May 2021
 09:02:42 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "gene.chen.richtek@gmail.com" <gene.chen.richtek@gmail.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
CC:     "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "inux-pm@vger.kernel.org" <inux-pm@vger.kernel.org>,
        "shufan_lee@richtek.com" <shufan_lee@richtek.com>,
        "cy_huang@richtek.com" <cy_huang@richtek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gene_chen@richtek.com" <gene_chen@richtek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wilma.Wu@mediatek.com" <Wilma.Wu@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "benjamin.chao@mediatek.com" <benjamin.chao@mediatek.com>
Subject: Re: [PATCH v5 1/3] lib: add linear range get selector within
Thread-Topic: [PATCH v5 1/3] lib: add linear range get selector within
Thread-Index: AQHXU5lQ+linZHKpckqd+H+t7ps1cKr4mTqA
Date:   Fri, 28 May 2021 09:02:42 +0000
Message-ID: <8d5eb59bf3a2054e945d6c3c0203be529b61f8ec.camel@fi.rohmeurope.com>
References: <20210528081300.64759-1-gene.chen.richtek@gmail.com>
         <20210528081300.64759-2-gene.chen.richtek@gmail.com>
In-Reply-To: <20210528081300.64759-2-gene.chen.richtek@gmail.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c751bd2c-b492-4ad0-0214-08d921b75a17
x-ms-traffictypediagnostic: HE1PR0301MB2393:
x-microsoft-antispam-prvs: <HE1PR0301MB2393AA9F558F79CD5F754CFAAD229@HE1PR0301MB2393.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PSe/UBTpkbGN1jKFvsDhxu4wcUeOqC1X9TQtYhftC+cT6yMmYb7OUNVXxDFU8OIdx2s9u2lk7qslD6c7VQe3mwezvUN8O/tJfyJimpFVaPkuuSlQmVOxn/xj+RPU4QxYegez07sawZTiPj1BdKBwjzBoBVpRd7XsCnNbdsr1/XQVKLDsn0kCqJpj0UQDY/pd1Ds/qIuNevobDRHI7r/jEMfwsrJ0mKAYaAbT7jvFTojpvU1AhugEqK3HAshXaUPeuG/VDywl1HARaU4HP7dLgV372ppB7clJfnWR8gkKsWixkhLU+4F5P4FbS4uRfkJfBHqi1WGZ3MU8sANHxj1J+21StMhS9eF+7uahB1DUmrLX+mjfh2VpLqnvHs/5PK8vnSQzaCaKsmR1NEnUOtBhf7rKjVneDkINepe+olw0xBIkxdum4JxDepSvnK5/UdTjOmn0oXVOBExhgR2zRkFCBRS7ZrvH3dAQTk1Js0ReypEQhxx6WZl1m3MEefv0caZ8bgUZ6aiBAG+uVdCnieY80j3Ndybd3WE+Yn3xwdnpKOCDFsT8k5Et4A5nI9ApluN12romtfICk41QqHZTFUzsgdWNVuhfqyYFkWF+UB5mSHM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39840400004)(396003)(366004)(136003)(376002)(478600001)(83380400001)(186003)(71200400001)(6506007)(8676002)(3450700001)(316002)(8936002)(2906002)(122000001)(110136005)(38100700002)(7416002)(86362001)(6486002)(54906003)(4326008)(5660300002)(6512007)(76116006)(2616005)(66446008)(64756008)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dEpMQ0ltTjAxYnlKejVkVzFGdXQ1V3d0RGdONEhleFBlaHg5em9GTFk3ZnpL?=
 =?utf-8?B?VU1JSWNsZUIwNHNGSHZEOWFtRkticE82eU1yWEx0WjMrSFdLYW1xbENZcXpm?=
 =?utf-8?B?WXc4U2FYNHo2Nk0zSnQrZWI2RUU0RXR1a3VvV0FFWTFjRU1LYzVNSzFFSW5E?=
 =?utf-8?B?V3BDajlNb1F3NXUrZ3B2ZllZcW1JdUtJM3o0MUxQcERFZW52aFArTVVEN2dr?=
 =?utf-8?B?OVVXQUZKRHdpRGxyaXJpSW9Qd3dENjloc1ZtOSt2VzVXZFFOS2pGbmlJdEZh?=
 =?utf-8?B?d09pT3BzbXdzRURLaGdac2pvRGNzNkZUSWlzMjJTcnIyVWhwMGNpVWg0WGdp?=
 =?utf-8?B?MExUa0lUUVZ6VlRNQlU4MUxTYVFEMGdrMEV6WTlmMkNLYlFmT3ZnVUQrd21W?=
 =?utf-8?B?UEFhVXZwZ1htU2tDQ0NXNWx2aytDMGFLZ2hJOHYvZXlXc0VrOUVSdUMzNW5N?=
 =?utf-8?B?THhYUDd4eCtzTTNZSldjblNqbGkySlNYVzhXYUJYejFlRWgxNVVxcmRqUGtR?=
 =?utf-8?B?WXdIYUpzYmo2bmgzazNDUlYyenk1dnBJVWxzV0xkbTdGZTlabFJhOXc3dUJJ?=
 =?utf-8?B?Q3l0VW12WDdSd1ZlNkgvVkIwQnU0Y3A5QlladjZrbWhjbjRlR1VPQm9VU2tX?=
 =?utf-8?B?U3lDYWZzNmNZejFUL2JYaW5uT1ZFN1J3OVVsdHlzdnhmSXlvcmZCdDRGaTBN?=
 =?utf-8?B?UE1CTDRqeHAxcEZjeEpONDJucW5tcm03ejU1eTV2QUtlejdLMDYxWlFIWHk0?=
 =?utf-8?B?ejdJL3hTYTBieWRqR1pUQmt4dGNoN0pubThycXhRRFloWUJpUnZzV0ZBTnVO?=
 =?utf-8?B?OFBKeE4wWlV3Y0hhdXhPOGlWdXNNNUhLOS92ZStpSGgwb3Q1aS83UWV4QTY5?=
 =?utf-8?B?S1c5Q3FhWWNHS2g5dGF1aDNqdmQ2bUlKNmdQWWpzMlIvekxxS0dtZGRoQm1q?=
 =?utf-8?B?bldvM0RveFJwN3RNVE1sVC9UY1dFeVBwamRCRVRMRFBwelAxelB4RFFHWFUr?=
 =?utf-8?B?b1YwU1A2MWYwVXF4bWMvNVo0ZDgrYXJLYkliOWFUbDRlWDNQcUNENE1PMG1Y?=
 =?utf-8?B?TXhxQU9GejJEMEFPWXF0cGgyNnc4QXJkSkZYZjZ3YnNjeE5QeVZTa1B1OVNL?=
 =?utf-8?B?M0JuZ1VGa0lEdXBnR3QzU3E0aU9BNVc5ZC9tdERncTU1NVBxU3VUZ2NMMVBZ?=
 =?utf-8?B?N0UwbThiaTdjaFhVZWdLWWJTRmVVdnUxaitBM0QwTGFOTWpsVzRXODl3WHY5?=
 =?utf-8?B?cy9aaVdicE1ibjZnUDhxZzVWYTllSy9rb1hIYm4zWGthOGdkRjVUaENUVTM3?=
 =?utf-8?B?dUNsTDdVM3RiUmFkYmJwVG81bXhYMXBtSlNnSFoxR2lZTEwzTXlLUDFPZk4y?=
 =?utf-8?B?bFo2Q3JqL1lLeUxpY25DWXZMT0c2NSt2dDIvOUJnajR2N3pVcXNQdWV3cFZE?=
 =?utf-8?B?SFcrTVd6c0loNndxNTRWbUovMFJFVE5UUU5FRmRsTmx6NkdYNGk3b3A4QVpv?=
 =?utf-8?B?MHBmbWVheEd3MFplbDVQam1xQ09xaUdvOU05cFNBWEs2MnJiSjE1bENTdXdO?=
 =?utf-8?B?ZVRTdlFjTFROeW1wWHhaNHpiQ0lxeEJ0aHF4ZjJmUWNBY3NvWExJTGkzVHhl?=
 =?utf-8?B?UjQ0elE4NVJGeFFHTFd6Wk1TYTdNUkRWdDlFeDRkdGJBd05qY29TYUc5cnE5?=
 =?utf-8?B?ZC9LczluOGI4ZEFXMit1TEtGTjNLMnFiSVlBT1REL0tDMXR5V09tTFJCS3Mw?=
 =?utf-8?B?VmtzNnMwai9aTUlmU3ppMUtvckYzM2RzZGk4a2hVdUhzb001akhSRWE5M0pq?=
 =?utf-8?Q?sLsbDzMw6zFMTQI8JKv8pQ4tiOAZBjcN1OVXE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AB756DAFEE3424E8A0746A45629390C@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c751bd2c-b492-4ad0-0214-08d921b75a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2021 09:02:42.1936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aUCbvH2FvLZ33o9zci0ze9a1iumqAU7xozJpAzp+dxIcsavnu4Jx/n+xG/sAFKggmgj0eEr8Dfgg6XF4Xs9Zg41aFcnMH15/RSPycrq8Qi4IOTbhfNfHZ7EFxGITyiQ1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2393
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA1LTI4IGF0IDE2OjEyICswODAwLCBHZW5lIENoZW4gd3JvdGU6DQo+IEZy
b206IEdlbmUgQ2hlbiA8Z2VuZV9jaGVuQHJpY2h0ZWsuY29tPg0KPiANCj4gQWRkIGxpbmVhciBy
YW5nZSBnZXQgc2VsZWN0b3Igd2l0aGluIGZvciBjaG9vc2UgY2xvc2VzdCBzZWxlY3Rvcg0KPiBi
ZXR3ZWVuIG1pbmltdW0gYW5kIG1heGltdW0gc2VsZWN0b3IuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBHZW5lIENoZW4gPGdlbmVfY2hlbkByaWNodGVrLmNvbT4NCj4gLS0tDQo+ICBpbmNsdWRlL2xp
bnV4L2xpbmVhcl9yYW5nZS5oIHwgIDIgKysNCj4gIGxpYi9saW5lYXJfcmFuZ2VzLmMgICAgICAg
ICAgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDMzIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2xp
bmVhcl9yYW5nZS5oDQo+IGIvaW5jbHVkZS9saW51eC9saW5lYXJfcmFuZ2UuaA0KPiBpbmRleCAx
N2I1OTQzNzI3ZDUuLmZkM2QwYjM1OGYyMiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9s
aW5lYXJfcmFuZ2UuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2xpbmVhcl9yYW5nZS5oDQo+IEBA
IC00MSw2ICs0MSw4IEBAIGludCBsaW5lYXJfcmFuZ2VfZ2V0X3NlbGVjdG9yX2xvdyhjb25zdCBz
dHJ1Y3QNCj4gbGluZWFyX3JhbmdlICpyLA0KPiAgaW50IGxpbmVhcl9yYW5nZV9nZXRfc2VsZWN0
b3JfaGlnaChjb25zdCBzdHJ1Y3QgbGluZWFyX3JhbmdlICpyLA0KPiAgCQkJCSAgIHVuc2lnbmVk
IGludCB2YWwsIHVuc2lnbmVkIGludA0KPiAqc2VsZWN0b3IsDQo+ICAJCQkJICAgYm9vbCAqZm91
bmQpOw0KPiArdm9pZCBsaW5lYXJfcmFuZ2VfZ2V0X3NlbGVjdG9yX3dpdGhpbihjb25zdCBzdHJ1
Y3QgbGluZWFyX3JhbmdlICpyLA0KPiArCQkJCSAgICAgIHVuc2lnbmVkIGludCB2YWwsIHVuc2ln
bmVkIGludA0KPiAqc2VsZWN0b3IpOw0KPiAgaW50IGxpbmVhcl9yYW5nZV9nZXRfc2VsZWN0b3Jf
bG93X2FycmF5KGNvbnN0IHN0cnVjdCBsaW5lYXJfcmFuZ2UNCj4gKnIsDQo+ICAJCQkJCWludCBy
YW5nZXMsIHVuc2lnbmVkIGludCB2YWwsDQo+ICAJCQkJCXVuc2lnbmVkIGludCAqc2VsZWN0b3Is
IGJvb2wNCj4gKmZvdW5kKTsNCj4gZGlmZiAtLWdpdCBhL2xpYi9saW5lYXJfcmFuZ2VzLmMgYi9s
aWIvbGluZWFyX3Jhbmdlcy5jDQo+IGluZGV4IGNlZDVjMTVkM2YwNC4uYTFhN2RmYTg4MWRlIDEw
MDY0NA0KPiAtLS0gYS9saWIvbGluZWFyX3Jhbmdlcy5jDQo+ICsrKyBiL2xpYi9saW5lYXJfcmFu
Z2VzLmMNCj4gQEAgLTI0MSw1ICsyNDEsMzYgQEAgaW50IGxpbmVhcl9yYW5nZV9nZXRfc2VsZWN0
b3JfaGlnaChjb25zdCBzdHJ1Y3QNCj4gbGluZWFyX3JhbmdlICpyLA0KPiAgfQ0KPiAgRVhQT1JU
X1NZTUJPTF9HUEwobGluZWFyX3JhbmdlX2dldF9zZWxlY3Rvcl9oaWdoKTsNCj4gIA0KPiArLyoq
DQo+ICsgKiBsaW5lYXJfcmFuZ2VfZ2V0X3NlbGVjdG9yX3dpdGhpbiAtIHJldHVybiBsaW5lYXIg
cmFuZ2Ugc2VsZWN0b3INCj4gZm9yIHZhbHVlDQo+ICsgKiBAcjoJCXBvaW50ZXIgdG8gbGluZWFy
IHJhbmdlIHdoZXJlIHNlbGVjdG9yIGlzDQo+IGxvb2tlZCBmcm9tDQo+ICsgKiBAdmFsOgl2YWx1
ZSBmb3Igd2hpY2ggdGhlIHNlbGVjdG9yIGlzIHNlYXJjaGVkDQo+ICsgKiBAc2VsZWN0b3I6CWFk
ZHJlc3Mgd2hlcmUgZm91bmQgc2VsZWN0b3IgdmFsdWUgaXMgdXBkYXRlZA0KPiArICoNCj4gKyAq
IFJldHVybiBzZWxlY3RvciBmb3Igd2hpY2ggcmFuZ2UgdmFsdWUgaXMgY2xvc2VzdCBtYXRjaCBm
b3IgZ2l2ZW4NCj4gKyAqIGlucHV0IHZhbHVlLiBWYWx1ZSBpcyBtYXRjaGluZyBpZiBpdCBpcyBl
cXVhbCBvciBsb3dlciB0aGFuIGdpdmVuDQo+ICsgKiB2YWx1ZS4gQnV0IHJldHVybiBtYXhpbXVt
IHNlbGVjdG9yIGlmIGdpdmVuIHZhbHVlIGlzIGhpZ2hlciB0aGFuDQo+ICsgKiBtYXhpbXVtIHZh
bHVlLg0KPiArICovDQo+ICt2b2lkIGxpbmVhcl9yYW5nZV9nZXRfc2VsZWN0b3Jfd2l0aGluKGNv
bnN0IHN0cnVjdCBsaW5lYXJfcmFuZ2UgKnIsDQo+ICsJCQkJICAgICAgdW5zaWduZWQgaW50IHZh
bCwgdW5zaWduZWQgaW50DQo+ICpzZWxlY3RvcikNCg0KSSBsaWtlIHRoZSBuYW1pbmchIFRoZSAi
d2l0aGluIiBzb3VuZHMgZ29vZCB0byBtZSA6KQ0KSXQgc2xpZ2h0bHkgYm90aGVycyBteSAic3R5
bGUgZXllIiB0byBzZWUgdGhpcyBub3QgcmV0dXJuaW5nIGEgdmFsdWUNCih2b2lkKSAtIGJ1dCBz
dGlsbCByZXR1cm5pbmcgdGhlIHZhbHVlIHZpYSBwYXJhbWV0ZXIgKHNlbGVjdG9yKS4gSXQgbWF5
DQpiZSBzbGlnaHRseSBtb3JlIGNvbXBsaWNhdGVkIHRvIHJlYWQgd2hlbiB1c2VkLg0KDQpQbGVh
c2UgY29uc2lkZXIgZm9yIGZpcnN0IHRpbWUgcmVhZGluZyBjb2RlIGxpa2U6DQp1bnNpZ25lZCBp
bnQgZG9fc29tZXRoaW5nKGNvbnN0IHN0cnVjdCBsaW5lYXJfcmFuZ2UgKnIsIHVuc2lnbmVkIGlu
dA0KdmFsLCBpbnQgKm15dmFsdWUpDQp7DQoJaW50IHJldDsNCg0KCS4uLg0KDQoJbGluZWFyX3Jh
bmdlX2dldF9zZWxlY3Rvcl93aXRoaW4ociwgdmFsLCBteXZhbHVlKTsNCg0KCS4uLg0KDQoJcmV0
dXJuIHJldDsNCn0NCg0KdG8gcmVhZGluZyBjb2RlIGxpa2U6DQp1bnNpZ25lZCBpbnQgZG9fc29t
ZXRoaW5nKGNvbnN0IHN0cnVjdCBsaW5lYXJfcmFuZ2UgKnIsIHVuc2lnbmVkIGludA0KdmFsLCBp
bnQgKm15dmFsdWUpDQp7DQoJaW50IHJldDsNCg0KCS4uLg0KDQoJKm15dmFsdWUgPSBsaW5lYXJf
cmFuZ2VfZ2V0X3NlbGVjdG9yX3dpdGhpbihyLCB2YWwpOw0KDQoJLi4uDQoNCglyZXR1cm4gcmV0
Ow0KfQ0KDQpGb3IgbWUgcmVhZGluZyB0aGUgbGF0dGVyIHNob3dzIGJldHRlciB3aGVyZSB0aGUg
bXl2YWx1ZSBpcyByZWFsbHkgc2V0Lg0KDQpPVE9ILCBZb3VyIHN1Z2dlc3Rpb24gaXMgY29uc2lz
dGVudCB3aXRoIHRoZSBvdGhlciBmdW5jdGlvbnMgc28gSSBhbQ0Kbm90IGFza2luZyBmb3IgYSBj
aGFuZ2UgaWYgdGhpcyBpcyBPayB3aXRoIG90aGVycyA6KSBUaGFua3MgYSBsb3QhDQoNClJldmll
d2VkLWJ5OiBNYXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNv
bT4NCg0KPiArew0KPiArCWlmIChyLT5taW4gPiB2YWwpIHsNCj4gKwkJKnNlbGVjdG9yID0gci0+
bWluX3NlbDsNCj4gKwkJcmV0dXJuOw0KPiArCX0NCj4gKw0KPiArCWlmIChsaW5lYXJfcmFuZ2Vf
Z2V0X21heF92YWx1ZShyKSA8IHZhbCkgew0KPiArCQkqc2VsZWN0b3IgPSByLT5tYXhfc2VsOw0K
PiArCQlyZXR1cm47DQo+ICsJfQ0KPiArDQo+ICsJaWYgKHItPnN0ZXAgPT0gMCkNCj4gKwkJKnNl
bGVjdG9yID0gci0+bWluX3NlbDsNCj4gKwllbHNlDQo+ICsJCSpzZWxlY3RvciA9ICh2YWwgLSBy
LT5taW4pIC8gci0+c3RlcCArIHItPm1pbl9zZWw7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQ
TChsaW5lYXJfcmFuZ2VfZ2V0X3NlbGVjdG9yX3dpdGhpbik7DQo+ICsNCj4gIE1PRFVMRV9ERVND
UklQVElPTigibGluZWFyLXJhbmdlcyBoZWxwZXIiKTsNCj4gIE1PRFVMRV9MSUNFTlNFKCJHUEwi
KTsNCg0K
