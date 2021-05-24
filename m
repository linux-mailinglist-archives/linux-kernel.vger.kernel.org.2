Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B630138E0F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 08:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhEXGV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 02:21:59 -0400
Received: from mail-eopbgr60056.outbound.protection.outlook.com ([40.107.6.56]:12878
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232291AbhEXGV6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 02:21:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiYPuDEFM3xUUSIXajCWvHHV28Mm5//ikg3Y2LAUHcrQgl+9bZdrWGVpVhrLXzANW+o+cJWQQaNbF4VgqnAw86JGabznTnVrYWU82ZEDgFqex4TN+P1tSrL0atRNiekEblNvKD6hou9UPiXd0hdZ9NOBKSUimKV27rpXHyBRvpW/0pqXuVWPtxI33usetb0KxL7FpBKb4kzykvoi4HgwFRM2H5fiAolGiEdxnEixO4XwLXRDrvomXebZykdis/+n7QRbdE2GsFvtXQ15f/gYyMTosqMirf4ZR/9VJlm2yPSNiIyT5d94a87yqkCNCVAFS7iHj6wbkdpZbpLDFigbqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGn5tc8YY88BI81cBAjUaCaMl/yCDvIsN79+Taf/3Zw=;
 b=Ji1idLnqYr0XTN+m1Ajy8k/t4Hzhonq1GYCa3nbQ1oaOLsv5VtNoRygoqsKrWt8TwhUQdJPIrB2pREFd+Ac47Z++fcgxkgpaWpcpAzx8RQD6700trtpo129pzwO2lMMopSTjfi0uwyInZZB2bm0QQFB8grAzdrHJew0BBuW3m3xOJPIu88X01Ld8h7VzsRhw5vm7LBVysx2fwqRs6G9m+LCzhi8onrOxSDRZ40vTfPYTqYbzGToTW+nKDHPYBtfrBcJBpRAOCZ5g9GORqkX3pUejuCvOA/LdKEZPIAF+o/bBAJqnspZRAQZmGaOy05ez3iZ9EddHKFup+7GvjQY7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGn5tc8YY88BI81cBAjUaCaMl/yCDvIsN79+Taf/3Zw=;
 b=luL10EwpY8cZDy0wfHl4mFA8XFHYo9okbGOUPDVxu/KYviRCWr+/wPP53hmCDbrLxp/RludnZUWSFeNcku+eoGdMJaEnnvpgLOOmME2yln50luqpVTPxcczeTuoa3Tj1r0Gpev92AwdcbvkefgKK/I4vaSssRBBvRh145H1eUWo=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2314.eurprd03.prod.outlook.com (2603:10a6:3:25::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.26; Mon, 24 May 2021 06:20:25 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::89f0:ff95:a73a:cf4b]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::89f0:ff95:a73a:cf4b%7]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 06:20:25 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "axel.lin@ingics.com" <axel.lin@ingics.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
Subject: Re: [PATCH 1/2] regulator: bd70528: Fix off-by-one for buck123
 .n_voltages setting
Thread-Topic: [PATCH 1/2] regulator: bd70528: Fix off-by-one for buck123
 .n_voltages setting
Thread-Index: AQHXT6LJnxTjx1sTK0WiFfJgEgitmKryJrAOgAADzoA=
Date:   Mon, 24 May 2021 06:20:25 +0000
Message-ID: <0e3816724876c0040a3462322f8db35aabe109fc.camel@fi.rohmeurope.com>
References: <20210523071045.2168904-1-axel.lin@ingics.com>
         <4189cb2094b4fe43e351eb1d80ca6c4cb1ac08ed.camel@fi.rohmeurope.com>
         <CAFRkauA8npjbAwwyRKh-VmMkmK59hE=P6+iHQPMSw-buduagDQ@mail.gmail.com>
In-Reply-To: <CAFRkauA8npjbAwwyRKh-VmMkmK59hE=P6+iHQPMSw-buduagDQ@mail.gmail.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: ingics.com; dkim=none (message not signed)
 header.d=none;ingics.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [2001:14ba:16e2:8300::4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fb1af12-261b-4af6-d1ef-08d91e7c0502
x-ms-traffictypediagnostic: HE1PR0301MB2314:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0301MB2314B697540934E8EFA08F95AD269@HE1PR0301MB2314.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NkQIrmV8PIJjK1v+KqyN8t88qya2kcq1NIJixMzHpAJrMY2OI6WNzOxecPEC4hQZadcKcy6YFj+4ECeg60TjnJXVPa4CMLm/yOSYC43z4x+kD4mloMUfKgRckdF2mFlOaQAtzj8JMnHy89xMcFu4QfrBmtCzyUgEGP8mITdo8jC/OgZIa4bD4vU9UoJpjH8M4S6k6fq34wy+juuQ6vfkpNW9dN/d0YRzV+Gr8sPXupNhck/opLAsVzuE4A35kj4JUAZcW8qvE0Eb16olsPyLH1Vy+jbRg3520q8sQ/z06pHtD3u8OqxKCRQpWTNcZ2OulPtI2SMMj9VvbuZwmrXKyLEgMumwtaIrIPeY935PFJUVHPPkKRX/tkk6tUPealLzkzkQkt+d/gRcv+xZq6oHAne+zyg3sBd0VGe7s52FWjNP6WJFU1wu6VhzF9B1ydAfVCp1VuIaRdF+zeccqeXMk51X+732yTL19HItOYxO6IeqeX6KYIV3KJYqW5Ajri1yKrG8dMOlqjEkUHuTAwDHjN+LrOyAZ8ITF+MA8G9gjY/kFsk5rJbgPBW5cS1MK/mLK7wjAIzamk+Zffbd69fnm4jj3aGpbXHdFtPi64Rssd9zYl8RokXQM7v88F6dFoB6XKOwA2gWe0BBtlP3q7hQX2A/r0yms9DNoD0xfadoiGQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39830400003)(8936002)(54906003)(6506007)(478600001)(3450700001)(122000001)(6916009)(6512007)(5660300002)(2906002)(38100700002)(316002)(76116006)(66476007)(64756008)(86362001)(186003)(66946007)(2616005)(71200400001)(66446008)(6486002)(4326008)(8676002)(83380400001)(66556008)(142923001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ejFvWkwzaDFWYVI1L0V3UUFJK0kzcGFRQmZ1ZzUxcEpuaTNKQzBZYkh1VHNu?=
 =?utf-8?B?VGdIb3gyckZ4VXd2NGVGUVZEbW41cWs0YTd2cXRoQzcxeTNHSHJiaUlrcjNp?=
 =?utf-8?B?NVkxSkNOWXYvVXNpVnYrNnVNQ1JmQmZRc3loY3V6Nk5EUmRTWFV5dE1jdU5a?=
 =?utf-8?B?V3YwbHJRbDlPSTE0REtBbkJPN2Fuc3FJQ3VMRjg1NWhzeTBKa3pLL3JNTTJT?=
 =?utf-8?B?Q0UxV1FuSVF2NXl2a21iMmJxV3ExT3Rib0JZLzNqTWlpTU1PaXdNNHg4V2F3?=
 =?utf-8?B?S1FrcjFzbXpHL2VvSGlUTnFDQXlrOG9XUUdESHN2eG5UOW12Um5aRHV6d25B?=
 =?utf-8?B?cUFhb0hYdFRMaDk5Vk44K2gxR2M4TE9zUmtGeWxVNTFRYUt1K2ZuaDFwRjNY?=
 =?utf-8?B?c004ZXRrV3RQcW9vVGxpdmtaTmdnOWw5Y2w1UStzU1BYNm93UFovdzVNOFQz?=
 =?utf-8?B?anpkRWlPT3RMdm9LemtUSFpoczZ5VTMvcCttUGVGL0tmYVo0dkRNRi9IaVZX?=
 =?utf-8?B?cmR5YkxmOWpLaWJuTi9yMW9CQkNVeEhucU9pakw3Vkg0QVMrRkEzS3NPRHdu?=
 =?utf-8?B?cE5RNFpDOUtHbVpySXVybHVFSXBiZzdIZkRYUzJkMitXbldMemw5K3VwR0F1?=
 =?utf-8?B?b1lCVnp5NDY1MHlwQm9RQldJZkNsOEJFaFFXMWtUeDZnOTh0aTREY0QzQSsx?=
 =?utf-8?B?WGlVaGdXWFQ1ZjNmTTJzV0ZrbnQ4bW94cmZSU0tqSkNaTGw4d3R3WGxsdVNz?=
 =?utf-8?B?R2crNU5RSFU0K1lOZFVvd2FPZGVZbmwydFZtY3dEUjJGUFppazUvODI0ZytL?=
 =?utf-8?B?azdMUGIyRlVqYzZnNStLSTV5NmUwdmVKOWYrVkVqVmd4Z2VtZEdlYXhRSVFE?=
 =?utf-8?B?RG9DWTJjRzl3RkE5TjV5d0NJNlJId3AvZXJQcTlyNDJEWEpySlEzVGZoa3My?=
 =?utf-8?B?aHpoakcvUzlVTFhZZ3hGNVM3UW43THE1dkpDc1ZETUlBN21YRXlCak1lcXYz?=
 =?utf-8?B?RnZtQlVpcFBoK2ZVMEEyaWFrZGJwV0pwaXlheDE0YTRsc2l2ZzJFUUVlcUR1?=
 =?utf-8?B?V2txWmlVb2lHU3oya2pmNFhZbUpkdlg1YmtIeVhOcG9mc2dGVlgybXZLd2tz?=
 =?utf-8?B?RUZsTCtnaU5uaTM5YkpUc2trN2hVVHpLdVRiLzhpcFFKakR1MjVQcmhIM2lQ?=
 =?utf-8?B?NmF5RldCaVpVQWNRZ05tSWcrNDc5Z1hid3FpUDI0K1JxV3NRRE9RMGdqYk8x?=
 =?utf-8?B?YVRlZVRuOGFiMXZQSjJraE1FU3pNOVgwaVdXRm9wWUdSYXg0Lzhzd0MrN3pJ?=
 =?utf-8?B?SXhpNURlaWZyRmZ4eWpNbmp2QUZ2cWZrSmtUcVM5ZDZqTy9aNit5L0toVkFV?=
 =?utf-8?B?bmVpd3ZqbTljaVNQWDY2eldhNm9TamczbGtLcVozZFhPd2x1YXlmVFdHWjlF?=
 =?utf-8?B?QmxVQmVCK3J3RjlBcFVEYlZmRXhyam9JVS9zK3h2Q3A2blF5QU5XQm10V0xx?=
 =?utf-8?B?RVRjbnlFNG8zREk2ZjhXeGVWR1JjWGl6emRlUG8yR1ZFQmVpWTZHbzRGVk5G?=
 =?utf-8?B?ZFg4RForclY1T3VaNHAydXlCY21zQStrdUxmUTREVmJQNS80dnQ0a2prN0di?=
 =?utf-8?B?dTZSUXZ6cnRieFg3c1N0MDhuVVZ1RS95alBVVjRTT2ZhMGVHaWpTR0NsUHRN?=
 =?utf-8?B?U3FwaS9qNVB1aXNFTW1hZEpVUUlGaU1CMUJvMkE2YUZPNTkxN01ybTRhbjlx?=
 =?utf-8?B?Q1h2dEs5SEZFMnVaUDFqazBZUmRtSURLYWpXME41dmJzbzVKNG1ESjJKV1Rl?=
 =?utf-8?Q?L0iSVIdwvGA9JDdc4UAKugcxXiJdWqHqN43mk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8045B235B18C3E4BB78EFEA573A5A8D1@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb1af12-261b-4af6-d1ef-08d91e7c0502
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2021 06:20:25.7810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oC8NndwlL7DiI8gvBepZKo7dTujW2l6NCu/5GcYBw8Ew8XUZkN70SPycNEfGNgVWKneZnYR/QyVdQYIg5yi9tmhWRWgk8I7/lqiPX9TYyR+b/GrnOeGriZo79cpYq7sP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2314
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TW9ybmluZyBBeGVsLA0KDQpPbiBNb24sIDIwMjEtMDUtMjQgYXQgMTQ6MDYgKzA4MDAsIEF4ZWwg
TGluIHdyb3RlOg0KPiBNYXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2htZXVy
b3BlLmNvbT4g5pa8IDIwMjHlubQ15pyIMjTml6Ug6YCx5LiADQo+IOS4i+WNiDE6NDHlr6vpgZPv
vJoNCj4gPiBIaSBBeGVsLA0KPiA+IA0KPiA+IE9uIFN1biwgMjAyMS0wNS0yMyBhdCAxNToxMCAr
MDgwMCwgQXhlbCBMaW4gd3JvdGU6DQo+ID4gPiBUaGUgdmFsaWQgc2VsZWN0b3JzIGZvciBiZDcw
NTI4IGJ1Y2tzIGFyZSAwIH4gMHhmLCBzbyB0aGUNCj4gPiA+IC5uX3ZvbHRhZ2VzDQo+ID4gPiBz
aG91bGQgYmUgMTYgKDB4MTApLiBVc2UgMHgxMCB0byBtYWtlIGl0IGNvbnNpc3RlbnQgd2l0aA0K
PiA+ID4gQkQ3MDUyOF9MRE9fVk9MVFMuDQo+ID4gPiBBbHNvIHJlbW92ZSByZWR1bmRhbnQgZGVm
aW5lcyBmb3IgQkQ3MDUyOF9CVUNLX1ZPTFRTLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBBeGVsIExpbiA8YXhlbC5saW5AaW5naWNzLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gSSB0aGlu
ayB0aGlzIGZpeCBkb2VzIG5vdCBuZWVkICJGaXhlcyIgdGFnIGJlY2F1c2UgaW4gb3JpZ2luYWwN
Cj4gPiA+IGNvZGUNCj4gPiA+IHRoZQ0KPiA+ID4gLm5fdm9sdGFnZSBpcyBncmVhdGVyIHRoYW4g
Y29ycmVjdCBvbmUuIFRoZSBsYXRlc3Qgc2VsZWN0b3IgaXMNCj4gPiA+IG5vdA0KPiA+ID4gdmFs
aWQNCj4gPiA+IGluIHRoZSBsaW5lYXIgcmFuZ2Ugc2V0dGluZyBhbnl3YXkuDQo+ID4gPiAgaW5j
bHVkZS9saW51eC9tZmQvcm9obS1iZDcwNTI4LmggfCA0ICstLS0NCj4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L21mZC9yb2htLWJkNzA1MjguaA0KPiA+ID4gYi9pbmNsdWRl
L2xpbnV4L21mZC9yb2htLWJkNzA1MjguaA0KPiA+ID4gaW5kZXggYTU3YWY4NzhmZDBjLi40YTU5
NjY0NzVhMzUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21mZC9yb2htLWJkNzA1
MjguaA0KPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tZmQvcm9obS1iZDcwNTI4LmgNCj4gPiA+
IEBAIC0yNiw5ICsyNiw3IEBAIHN0cnVjdCBiZDcwNTI4X2RhdGEgew0KPiA+ID4gICAgICAgc3Ry
dWN0IG11dGV4IHJ0Y190aW1lcl9sb2NrOw0KPiA+ID4gIH07DQo+ID4gPiANCj4gPiA+IC0jZGVm
aW5lIEJENzA1MjhfQlVDS19WT0xUUyAxNw0KPiA+ID4gLSNkZWZpbmUgQkQ3MDUyOF9CVUNLX1ZP
TFRTIDE3DQo+ID4gPiAtI2RlZmluZSBCRDcwNTI4X0JVQ0tfVk9MVFMgMTcNCj4gPiA+ICsjZGVm
aW5lIEJENzA1MjhfQlVDS19WT0xUUyAweDEwDQo+ID4gDQo+ID4gVGhhbmsgeW91IGZvciBmaXhp
bmcgdGhpcy4gVGhlcmUgcmVhbGx5IGlzIG9ubHkgMTYgdmFsaWQgdm9sdGFnZQ0KPiA+IHNldHRp
bmdzIGFzIHlvdSBwb2ludGVkIG91dC4gUmVnYXJkaW5nIGNoYW5naW5nIHRoZSBkZWZpbmUgdG8g
aGV4IC0NCj4gPiBJDQo+ID4gd291bGQgcHJlZmVyIHNlZWluZyB0aGUgYW1vdW50IGluIGRlY2lt
YWwgYXMgaXQgaXMgZWFzaWVyIHRvDQo+ID4gdW5kZXJzdGFuZC4gKEkgZG8gdW5kZXJzdGFuZCBi
aXQtcGF0dGVybnMgYmV0dGVyIHdoZW4gaW4gSEVYIC0gYnV0DQo+ID4gInJlYWwgd29ybGQiIHZh
bHVlcyBsaWtlIHZvbHRhZ2VzLCBjdXJyZW50cyBvciBhbW91bnRzIGFyZSBlYXNpZXINCj4gPiAo
Zm9yDQo+ID4gbWUpIHRvIHVuZGVyc3RhbmQgd2hlbiBpbiBkZWNpbWFscykNCj4gDQo+IEN1cnJl
bnQgY29kZSBhbHJlYWR5IHVzZXMgaGV4LWRlY2ltYWwgKHdoaWNoIGlzIHRoZSByZWFzb24gSSB1
c2UNCj4gaGV4LWRlY2ltYWwgZm9yIEJENzA1MjhfQlVDS19WT0xUUyk6DQo+ICNkZWZpbmUgQkQ3
MDUyOF9MRE9fVk9MVFMgMHgyMA0KPiANCj4gU28gZG8geW91IHN1Z2dlc3QgdG8gY2hhbmdlIEJE
NzA1MjhfTERPX1ZPTFRTIHRvIGRlY2ltYWwgYXMgd2VsbD8NCj4gDQoNCkluIG15IG9waW5pb24g
dGhhdCB3b3VsZCBiZSBiZXR0ZXIuIFNvIGlmIHlvdSBmZWVsIGxpa2UgLSB0aGVuIHllcw0KcGxl
YXNlLiBBZnRlciB0aGF0IGJlaW5nIHNhaWQgLSBJIGFtIG5vdCBleHBlY3RpbmcgeW91IHRvIGRv
IGl0IC0gSQ0KYXBwcmVjaWF0ZSB0aGUgZml4IGFzIGl0IGlzLg0KDQpBY2tlZC1ieTogTWF0dGkg
VmFpdHRpbmVuIDxtYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+DQoNCg0KPiBSZWdh
cmRzLA0KPiBBeGVsDQoNCg==
