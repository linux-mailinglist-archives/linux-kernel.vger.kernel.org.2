Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F7841D659
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 11:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349407AbhI3Jaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 05:30:30 -0400
Received: from mail-am6eur05on2044.outbound.protection.outlook.com ([40.107.22.44]:50486
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349386AbhI3Ja1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 05:30:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQgKNwI71nLGqIGMdDLFwcjYTvpsYyg72FNu3n+E/WkT8SpLRzQOpLHyKytX8E5wji4g/Bqryc7o99ZdbA1d9qM8duuEHRwg8mvxHDpX9gr5r/KsyTVjfeclwmkUO8VJh4vq4u6FgGUAUHYCUQsSe9T/P3iIGj9szRnoJ4S3EKZD7mVwRyC63FHZLjjTyItXVC1JZYZHVo10o1GH4KPa8Li5+A8dDgmSvfhY+MEkO3TVFhu3eLpVsLoKm5okASNFRZQMJZsX1qRoPeXZbLMF0B53wZwLSb8Zv2Ym2yw7ZX20JqBeehNPYcdDZadSpOlIaUJLn2JeqeRot4ELTOJmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=1+ZpohUEUovF11WZqnw3Q+2NRAGp1aWSHNhUI3aEyrs=;
 b=SHNUAkMzDAvxHAgg+s/eOUpot7gZhjaIbLjeAZ1qTY4tIOdIe/n10GOQbnrEP/wYEvIzptzixZdX+aukfZcjNcBNtkz6xn07yUpZRCW4+NR5oM3pWSL8m471Lo1lSjpUnO+Bixljx85KRB+Sz+KU6BKttVmVUdZgPGAiGQpV8l6P+tODNgHLGXi65Qs63R0w14ldeNYAEiUYF6HLZMStYH8b6XTw08FDG0RlrqmspGKsF6Zhujy+HkeTCbA1Cf+W1eJMgmVmw1cVg5gwoN7k44d6LE2tqtn2zzzxzrrqTaAmOcEiTJVn3WP3MuehJKCrgPmTveypeJ9ymyhVNqlHsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+ZpohUEUovF11WZqnw3Q+2NRAGp1aWSHNhUI3aEyrs=;
 b=g6z6wmQXZHQt2iWBZJBZmIkbm+ozQnFajQFBFG0wGFUgzSqSlzrvFVcjOaMN/I7TAAwZrbw/isBCGbj+iP2MIOZ87CsrUMGvndOPDb7B/6KCj4je2c/b92Nc4Jgn+Vvubxcvg5SB9G8V8AJ/MGthHikr3xPtupXU+hKgzyBCOz4=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB9PR10MB4682.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:261::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Thu, 30 Sep
 2021 09:28:38 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144%7]) with mapi id 15.20.4544.022; Thu, 30 Sep 2021
 09:28:38 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
Thread-Topic: [PATCH] drivers: mfd: da9063: Add restart notifier
 implementation
Thread-Index: AQHXrqpI0LoFC+MHc0+B+6k9QHIUIauzTVswgAAUm4CAB616wIABMx0AgAAYygA=
Date:   Thu, 30 Sep 2021 09:28:37 +0000
Message-ID: <DB9PR10MB4652444644C8ECF3C729A8C680AA9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
 <DB9PR10MB465252461469340F60A8714780A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvKaS0sE7paCecMDvqpkw-yLM_QFHdF5pgWTAqeH0JAfA@mail.gmail.com>
 <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CAEn-LTqVd8z=kpCtWjiPbKuw24NuHLTQxWzw7g34fEJgDYrp8w@mail.gmail.com>
In-Reply-To: <CAEn-LTqVd8z=kpCtWjiPbKuw24NuHLTQxWzw7g34fEJgDYrp8w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45a24128-961d-41a6-ed0a-08d983f4af01
x-ms-traffictypediagnostic: DB9PR10MB4682:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB9PR10MB46825060170E29A9B42BE6DFA7AA9@DB9PR10MB4682.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ebZsIpg28+aFJQQ3ZgTNMtftjzi82U7NP7VGXnDyKhfDvQ9QsEEjprL4Yj/frYTUSY0uiHEkL04CNddCH4C9J2gukD/y9rbN+lgmkJw+oJa5TqCVvqVaN/KeltDNrgGa59DAj+3Fil+LqTGRthCs3HTzmqMI2bFXNSb16gGzNCJF92GiDbkZjSotuc8oAKRtugQnTDuLC4Pij0L5nVOSdjimvupQ7/s9MELl4w4zNmwezTKMxyUyRLPq0wjhKxBHGaxEkT1Ne6Ep0/80cUjOnAKUPq0/af8m0VlIoUtUJbXovwv5AgSGrS0GhI+5hwdfWb2yVg7FNYqPrt2X9qKxYP+eyP+4AOsIx303NV+PYAMSQDeV4cfZ31mUhInY36/iNbC1xJrwDlMp4r1djLrYE5KXb/rit4VLg2UChwGi1HcYvqYhMGIz7Kat7lb9bDSOXmnj3/po3ek1+HoQBsPWLko0qNvdJnIVcxypC4/mJdpy04u2lGZYmLrEC60O927JJasqpPS02hPCL0xn+GyAYZBH/wEgMiyKJW/nTfMf0ZTO7lRG+9wUG5beZr7rU8XLL2+Y04hqM1hs+7njugojdTRs3o4f3LiJKJTDFU8zvOd7PB3zzRFwwji1E0tArlO9CzutyF4pd2aPWi2N79DMStPYvbSvSVJA+2fKwRZa7+DyGBVL2oD2Kce4+U1q3tpIii9n8MURtskyiDQh8I8aVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(5660300002)(66476007)(316002)(64756008)(86362001)(38070700005)(66446008)(76116006)(66556008)(66946007)(6506007)(2906002)(53546011)(54906003)(8676002)(52536014)(71200400001)(7696005)(26005)(110136005)(38100700002)(4326008)(508600001)(8936002)(55016002)(122000001)(33656002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXowYkQ1MDEwMkF3MnZRSmtLc3FFYXJSTUdiK2JoQ1g5WjZRbDhsWkJmU1No?=
 =?utf-8?B?dDNPVnF6VmVFUnc3VWJ5VGFIVTFFYy92ck0wS3oxOHgvMTdud2plNlFxT0VP?=
 =?utf-8?B?N3VyZTZSakdENklkRGZBU3FwWWs0TnRCSUdRenRMQUlEWFNzODhhbVErUC9x?=
 =?utf-8?B?OUEwK3NDVnk2cTFBVzcvV05ZTkY2WWF5anZ6R01adDdNSytEY1FqaW1ndkxG?=
 =?utf-8?B?VGQ5azkxZG40b2JGd2tySE14bTBGZWJURTdsZldiQTdXZWxJN1craEFVdGhN?=
 =?utf-8?B?bmcxKzF3RnUrVktEZXRwTVF0Z2RITTYyR09QcCtKUUNGckZKOTl0VTFNajly?=
 =?utf-8?B?SitEL1gyK0tjQjdUbG5sWFI0ZndTRHdZUURHM1RKcHFzeVRoem5mRUdHK1ZR?=
 =?utf-8?B?N2JyYmJ5SFRrNGV2aEQxdlhSc2k1eW8yNG03alBnVHJHRUM2d2J2NDhteTVo?=
 =?utf-8?B?UHIyQzdwbzd5bngwQUlTRU5QYlNrMFJIVmxLcmk1KzA5L0xDMG9HdFJUeG43?=
 =?utf-8?B?MHlxWXRmMU9HMHVyVklKZGx3aWF1MUkySEdSNEhITXBIY2FMTjZ4M2k3TkJL?=
 =?utf-8?B?SFlmWnAvSmE0dUNSOUdxcDg5andjQWEzT1hKYTRHc0ltNCtubWpNQTNZNFlt?=
 =?utf-8?B?V091d0E3YUJCa1EySWNuU1JGNHFZQXEyWW10dkpqZEdNcmI3T1EyeTJtUkE0?=
 =?utf-8?B?OUdEc2REYjh5TG9IelhNT09VS1loN2lhb1FQSlRWNCtDSW9hSkVCZUVjOEtW?=
 =?utf-8?B?U1pTckV1OGN6b3Uwak1ieCtOUmszVEhRaEE2ZFdTWDBGYkNKSEV4aS9HbUhU?=
 =?utf-8?B?eE9DVUJ5MnNuSHJRQ3hkMjVmcnVvc1JseWViZWRCZHZVREpXQVRhQjRjRlhF?=
 =?utf-8?B?bmM3bXJyZEdsa1lCaFY0dmpYTFNZSk9FejN6ZDl5QUJaWHZVRUkzTGdmNVV4?=
 =?utf-8?B?MTBJZXRYVlFSQnNscnMvenZtOUdSVHJkdXhOaWdBL3VHcW9SMTVxNkp0MmR3?=
 =?utf-8?B?NGduMXZrQVhxMm5jemE3VzlOQlp0RHZhTTNNbW04bHRwT2VFelZUSjlTRFFY?=
 =?utf-8?B?RE9mWUhPM21MUFgxcUZ5bGlZdklBUHhyRE9hM2FNQ09kOTJzMmdib08rcDZn?=
 =?utf-8?B?TWpaeXNlSlRhaFFISzdTanU0VjNjUGJXWGZNdWp6OU1tOEp4OHlJSlF6M1Ji?=
 =?utf-8?B?b3NHVjUxd1UvbDdHYWExZ2dsb0xrbStzQTNLdzREVTJxaTNsbi9TeHk5QS9E?=
 =?utf-8?B?bXZHT01kMmc3enRSK2FoYzQ0MmFYOGlDZDJSb0VyVDFqRGpTUnBIL2h6K2JX?=
 =?utf-8?B?ck5TSXQyemFpb0VRY1B6SWNTOHFBU0V6ditCYkRSS3M1c2JtcVYwb2dIMThj?=
 =?utf-8?B?aHplS2hxTUdWTE1WTjJWaUlBbUd4czhMMlFRQWJydHk5QjFWZjZFc3pIV0xw?=
 =?utf-8?B?WVVEUTAwSXJJN1liN29XUS95NW0rREtxakxHYm1DYlZiNHVoWjhEcG5lNlZx?=
 =?utf-8?B?b2s5L3NXZ2JWQzBubFREMUtTVzNBT01MMk1sTFZyUjNtNXg0dU1yb0xTNTVh?=
 =?utf-8?B?cDkwNTNWblVUb3pqNUlHZnZBNUhkUGZ2V09BWEtqM0RvM0tGcHNpQVRKT012?=
 =?utf-8?B?eExuSjhrSzF4anRDa0hrQ0RXUERvdUFzUXhkcTNkdTl4UXF4bHFCb25uTy9Z?=
 =?utf-8?B?TzBFOHhKNE5FamZOQzNPQmFFaDBXdDBvczZscmNpcDBhZmlyZDBuZWpXeEtJ?=
 =?utf-8?Q?iOM46Ajvm7VBIARQT0ThLT6EfRcgWsJ5rdRgQrI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a24128-961d-41a6-ed0a-08d983f4af01
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2021 09:28:37.9878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kckx6DGqgW8qX66QP7xxSZC1FrYI7ExzLtLp2cyWmJ8uR/pGQMmkKdjq1OK8cKAl9og2WoZqBSXpDIZf2aQCy0WHg8fvoGhyi+o7RDmV1OI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4682
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAgU2VwdGVtYmVyIDIwMjEgMDg6NTEsIERhdmlkIEFiZHVyYWNobWFub3Ygd3JvdGU6DQoN
Cj4gPiBSZWdhcmRsZXNzIG9mIHRoaXMgdGhvdWdoLCB0aGUgY29uc2Vuc3VzIHJpZ2h0IG5vdyB3
b3VsZCBiZSB0byB1c2UgdGhlIFJUQyBhcw0KPiBhDQo+ID4gd2FrZSBldmVudCB0byByZXN0YXJ0
IHRoZSBwbGF0Zm9ybS4gQW4gYWxhcm0gY2FuIGJlIHNldCBmb3IgYSBjb3VwbGUgb2Ygc2Vjb25k
cw0KPiA+IGludG8gdGhlIGZ1dHVyZSAob3IgbG9uZ2VyIGlmIHJlcXVpcmVkKSBhbmQgdGhhdCB3
b3VsZCBwcm92aWRlIHRoZSBldmVudA0KPiA+IHJlcXVpcmVkIHRvIGNvbWUgdXAgZnJvbSBwb3dl
cmRvd24vc2h1dGRvd24sIGluIHRoZSBhYnNlbmNlIG9mDQo+IEFVVE9CT09UIGJlaW5nDQo+ID4g
c2V0IGluIE9UUC4gSSBiZWxpZXZlIHRoaXMgd291bGQgYmUgdGhlIHNhZmVzdCByb3V0ZSB0byB0
YWtlIGluIHRoaXMgY2FzZS4gWW91DQo+ID4gY2FuIHRoZW4ganVzdCB1c2UgdGhlIFNIVVRET1dO
IGJpdCBvbiBDT05UUk9MX0YgdG8gdGFrZSBkb3duIHRoZSBib2FyZC4NCj4gDQo+IFRvZGF5IEkg
d2FzIGxvb2tpbmcgaW50byBPcGVuQlNEIERBOTA2MyBkcml2ZXJzIGFuZCB0aGV5IG1pZ2h0IGJl
DQo+IGRvaW5nIHdoYXQgeW91IGRlc2NyaWJlZCBmb3IgdGhlIHJlc2V0Lg0KPiANCj4gZGV2L2Zk
dC9kYXBtaWMuYw0KPiANCj4gWy4uXQ0KPiAyNDEgdm9pZA0KPiAyNDIgZGFwbWljX3Jlc2V0KHZv
aWQpDQo+IDI0MyB7DQo+IDI0NCAgICAgc3RydWN0IGRhcG1pY19zb2Z0YyAqc2MgPSBkYXBtaWNf
Y2QuY2RfZGV2c1swXTsNCj4gMjQ1ICAgICB1aW50OF90IHJlZzsNCj4gMjQ2DQo+IDI0NyAgICAg
LyogRW5hYmxlIHRpY2sgYWxhcm0gd2FrZXVwIHdpdGggYSBvbmUgc2Vjb25kIGludGVydmFsLiAq
Lw0KPiAyNDggICAgIHJlZyA9IGRhcG1pY19yZWdfcmVhZChzYywgQUxBUk1fTU8pOw0KPiAyNDkg
ICAgIHJlZyAmPSB+QUxBUk1fTU9fVElDS19UWVBFOw0KPiAyNTAgICAgIHJlZyB8PSBBTEFSTV9N
T19USUNLX1dBS0U7DQo+IDI1MSAgICAgZGFwbWljX3JlZ193cml0ZShzYywgQUxBUk1fTU8sIHJl
Zyk7DQo+IDI1Mg0KPiAyNTMgICAgIC8qIEVuYWJsZSB0aWNrIGZ1bmN0aW9uLiAqLw0KPiAyNTQg
ICAgIHJlZyA9IGRhcG1pY19yZWdfcmVhZChzYywgQUxBUk1fWSk7DQo+IDI1NSAgICAgcmVnIHw9
IEFMQVJNX1lfVElDS19PTjsNCj4gMjU2ICAgICBkYXBtaWNfcmVnX3dyaXRlKHNjLCBBTEFSTV9Z
LCByZWcpOw0KPiAyNTcNCj4gMjU4ICAgICAvKiBDbGVhciBldmVudHMgc3VjaCB0aGF0IHdlIHdh
a2UgdXAgYWdhaW4uICovDQo+IDI1OSAgICAgZGFwbWljX3JlZ193cml0ZShzYywgRVZFTlRfQSwg
ZGFwbWljX3JlZ19yZWFkKHNjLCBFVkVOVF9BKSk7DQo+IDI2MCAgICAgZGFwbWljX3JlZ193cml0
ZShzYywgQ09OVFJPTF9GLCBDT05UUk9MX0ZfU0hVVERPV04pOw0KPiAyNjEgfQ0KPiBbLi5dDQoN
ClRoaXMgaXMgdXNpbmcgdGhlIHRpY2sgYWxhcm0gd2hpY2ggaXMgcmVwZWF0aW5nLiBUaGF0IGlz
IG9uZSBvcHRpb24gb3INCmFsdGVybmF0aXZlbHkgdGhlcmUncyBhIG9uZS1zaG90IGFsYXJtIG9w
dGlvbiB3aGljaCBjYW4gYmUgdXNlZCB3aGljaCBtaWdodCBiZQ0KcHJlZmVyYWJsZSBhcyB5b3Ug
d29uJ3Qgc2VlIGNvbnRpbnVlcyBldmVudHMgZnJvbSB0aGUgUlRDIHdoZW4gdGhlIHN5c3RlbSBi
b290cw0KdXAgYWdhaW4uDQo=
