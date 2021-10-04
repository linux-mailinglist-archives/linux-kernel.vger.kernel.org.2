Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0343421260
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbhJDPNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:13:53 -0400
Received: from mail-eopbgr10054.outbound.protection.outlook.com ([40.107.1.54]:54454
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233403AbhJDPNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:13:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHtPuBmntWhgWnXX5oHu8BbRUny8hX25yDbJPEeyx3s+dD7yRC2P05pRoWKgtJ8I9X0N70ySRLmeZFQmJqNbjV0o84nLSh3z7QodYrz+XqlHJiBlEb3cziKbqI4vEykrfkwoKALthaLbOkRBHjgiGfZFW3vFxDA55zV3vwOI08WNC0Ehih88mWfZP4P95H6ZMzlcwhQ/4BnElhz8zmAo6I5HzAHFXndDgreeLjrhL+JtLitLBH/yslxWKS5awUFwbTs3CtaYfosb85ijO7orFedwCuAtvoq3BWjsTdbwu+1t8jsexy/LsnFBdbrRD3UOqqoTlMPDP4p1cyxqou+H+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXxyCxWD0aou69AX5flYWvFEo7Yku0k75gdZ4Ty0+BU=;
 b=Z9+kMZWrIiAhp0LU8AwPupnQl5rgJ4v6Mzv3bHY0kcgGM8ek++TshB2vBp1bhKmL8zU/WFE6RToZn0uf0sKaKVGxujG9G0ZJaO1ya2iEgzL+l56p+SQ6WprjlRz4COyFllC09G/px0urX7Tt7kzM+3MK4VpE77ilvSxXU/mZGajc8wIdukC577S4IxaY9VVcpv0HQW4jZAWI0AXeyxPbSuukMxFILqOD+olgn9nzWUd7NOZHG0fVInPxO88tS9mxOsM6vwrsEAJPLIekcW+zTNxurKPD5L8y6cyAh4vLDgWyw/kcb8UcJfoEaSuYV3zwkhz3SbE4349zDqKoUAuHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXxyCxWD0aou69AX5flYWvFEo7Yku0k75gdZ4Ty0+BU=;
 b=a9e2nZgpoQMsi0yD1t4LJQLNg0YlGZcfSEvhgXk38Pguz/UxLslAVcYW3lyPO40iVfdMAHjq0VCgbDJymLmPuEL5nJdJhd5cq8a7TSgHd5cdHQ8jzWr5Ao5L/h25QznGSRFcvOyjNcwAuF/CqQpYrYVg+DyVcGqtLnI5F7HCdOM=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB8PR10MB3129.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:111::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 15:11:51 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 15:11:51 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        David Abdurachmanov <david.abdurachmanov@gmail.com>
CC:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
Thread-Topic: [PATCH] drivers: mfd: da9063: Add restart notifier
 implementation
Thread-Index: AQHXrqpI0LoFC+MHc0+B+6k9QHIUIauzTVswgAAUm4CAB616wIABMx0AgAArEQCABmU8AIAAMeyA
Date:   Mon, 4 Oct 2021 15:11:51 +0000
Message-ID: <DB9PR10MB4652294AB444536BF57E320A80AE9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
 <DB9PR10MB465252461469340F60A8714780A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvKaS0sE7paCecMDvqpkw-yLM_QFHdF5pgWTAqeH0JAfA@mail.gmail.com>
 <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CAEn-LTqVd8z=kpCtWjiPbKuw24NuHLTQxWzw7g34fEJgDYrp8w@mail.gmail.com>
 <CA+zEjCtQN6c8bikg620PQwoPzJ6T4wGLvzQ413iPs1tCeHif0Q@mail.gmail.com>
 <CA+zEjCtVxDkg8K0iK32j4KO+Wgt+hTjXD15HdRhNeCV2Sjpckw@mail.gmail.com>
In-Reply-To: <CA+zEjCtVxDkg8K0iK32j4KO+Wgt+hTjXD15HdRhNeCV2Sjpckw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f354a61d-b02e-4b5b-8bd7-08d987494b0b
x-ms-traffictypediagnostic: DB8PR10MB3129:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB312908B10E2A8559CE49149EA7AE9@DB8PR10MB3129.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jlNLj0SfrqnN3ycSd8s5zqWr+2ZNTdIb7oguwilaVqP1MxPnSO1LFZjX5bMRXNbQatR6YU9B+BjpDNlpEi8GK4D93fxsuAuZ+KsPFvQd5tkBrok68olwk3TuKclv31ShecYnaMxbvSNALwBr0C7Vdlsem1cMfZf32rhK7nmvHyIyEIBj8JlYb/mDnNyfEjp3p7roxBJ2vBFzqQ/GvK59RPSSN2u1m9n4gt6kAV05RLVyLr7+qnWI6ZNXmo3XyCghaYBPuXPuZXhny8V8qZCjgBLC2P779e0qDH1s3jeZnC3kiglTKs8STHmwo+vBS1FaLEv0CWWBR1lZ1vkJ0kkgpQVGStvlfwauOpdpF3FGX/L32KBZqNV8B3hVTyVsDg0IZ9/h7f34AtAQBz1O4tMWK+spkHOb+cdXx3/XFfcbxNg2qckZTFo4k3/U6mYDgiGxUtYK2c743Rh12jgD6eptsRgfXu80drG3R4L5ZVCXO8OkaWgdnvZL2p1mx69Je+GeB+79V2Cso0Dob7kgoeAXoyrAYOpTaKGAowqlUlB5reOHcv+CYi8/5QyUO8s/ce7mizf7hX56Nw+PpUVbFBNEmkWCSIyx/DmpfjZEzs1l/NbM5VMvoQz9VKowsMaH+UIvA7C/c/06doejeV0g1D1kYu/HDuwR9B5ThFCHda623hGf1wHWyI4UnTWaVqQnB18oFQg5k/Ng6cJtCYJZbHaP2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(7696005)(86362001)(316002)(110136005)(38070700005)(55016002)(4326008)(71200400001)(54906003)(26005)(53546011)(6506007)(508600001)(66556008)(66476007)(5660300002)(186003)(33656002)(83380400001)(76116006)(122000001)(66946007)(38100700002)(8676002)(2906002)(52536014)(8936002)(64756008)(55236004)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NDVNemJvcCtnN3BjYm5UajlWVHBlaVdqNTBheW1mdXVNOW94aTJhVjVteCs0?=
 =?utf-8?B?ajUrYmJUOTM2bU1lRmY2MDJYaVd5Ujg1a2pMTXlzS3FZZ2M4ZTdLZE5YdGEy?=
 =?utf-8?B?RmxLNzRCM3pDRHZUL1oxVDNKQnk5dnFSK2habU00WWU1M1lWQU9zSjhOOERk?=
 =?utf-8?B?dUpRbXo2UXFKbktvWjhER08rK0h3QVhBazVjT251NTcxanVFcis0MG9kMFFs?=
 =?utf-8?B?WHZpSyswMnJtR25peHMxMDRJYzB1TnNOdVRxeGVkNDRVVW1XTFhZczZCUjdB?=
 =?utf-8?B?UGxscFltQUFEcHlNVlMvS1phMy9rRXFQUjlpWDkyd2c1NUNMYkhZdUlOenA5?=
 =?utf-8?B?QU0vTit1a0ViTWJOTDBLK25WQVhBYWF3VHI4aTA5WDVueVpqeEtZYVg2YlBN?=
 =?utf-8?B?NUUwdU9NUUFQZkkxS29qZkY4aEFURGpjcXRtT1Fieno0M0VvZGxQRUJsMkQx?=
 =?utf-8?B?RHBUT1hoNEQ1M1VTUlpjclZBM0srZ1VEVWl1eVBYaTViOVNxbmJnUFM5OXM0?=
 =?utf-8?B?cGRqUXViaUF6L0dUb1ZsSFpZai9OWlRxaW1XY0Z0VmNPVW9ENEs5S3dNNExt?=
 =?utf-8?B?RmJuV3k1c29HTnBiMG83d3hydWhlOFZlcXAzU3R5dEhoZ3JDNlVtbjEvUy9y?=
 =?utf-8?B?ck8zaXptVWZ3WldveVdKQmQwVnBhSTdrMld1NmdoRFRoNEFsNmFha1ZMWi9a?=
 =?utf-8?B?TjRZQUVCSG1UVVM2aFZVTzBBajFTQno4SUxxUmlyV0xZWmpjTXJxS3JEUUIx?=
 =?utf-8?B?eTNlRk84aHlWaHJnN0xYQUpadjJ4b1ZFVWpVMTZRQkJteDlUL1UvSkFUdHlh?=
 =?utf-8?B?d04rREI2bE1QeVZrcXhvQ1NnWFR0ZXZud1dXRCt1am1GZmZUK3hCaUxJWTJT?=
 =?utf-8?B?UjBSbzR3NE5ZcytWRUE1SVlYbUFpaFRaNndYMUlJS2ZPVjVHNFNkN204dlRi?=
 =?utf-8?B?WU0wdWc3Z3AwSzhEcTY2RDl3K1orMytCOUxQTVp6cjRNd2hkRk5MV24xZ0pn?=
 =?utf-8?B?Q2plSWVVODlZd256Rm9vUkZnTk4yTEpXWDgzVHhMN2xGS3Z0OXpqWkF1WTQ4?=
 =?utf-8?B?U3lNdVc3NmhOeEhmYmt0dUhaVnJzZFYrTzkvSjZuRWd1VEIrK1hWVnhnWFRp?=
 =?utf-8?B?K1FmcXhYa09aZTNFaU5RMkN2QkhFbklhOEJZU0s2UzVEQ0FISG9rQ0dWTGs0?=
 =?utf-8?B?TkZ3Q050bHV0MzFxNUxQYnZOYVpWT0dHK05ydS9RVnhrTTd5VzhKeXZwSC9s?=
 =?utf-8?B?VSthbXUwUEtiR2ZqUGk2MTRDeWZRSjgvb2p3d0FGTk1YU0VhQ0FwcFV6ME9H?=
 =?utf-8?B?UjBBZzN2Z1pZVHlpOEM4Q3k3M3JYb3Rjd21iSGc4MnFOT0ZseDNpRXRJWkxp?=
 =?utf-8?B?MFFxbjBRamdDZktXZng0Wk04Tk9EQlVJZXRqQXFkRlNmRWdZSXFxeFhmLzN1?=
 =?utf-8?B?aFdlS0RtdEVneHdKbUtCRFRHV2MvczlyOWNRQ1VVakVXRVA0YlZac0IwbkNK?=
 =?utf-8?B?dllaMG8wSTVYVkJsZUlRVzhEdm44VUhkLzlkaVVxd3Y2ZXhVbExvampFZG8z?=
 =?utf-8?B?d2wzMURCWXBpRVpDU3lXZ1IrNXhzNW9Fci9NRUlCWE1veFU5TlZTc0dnNWFH?=
 =?utf-8?B?T1pQRHVyVEZ4aVVmL2pxS2NYR1pPVW0rZ0lhNVlxL05FOWVUQm5UYUxPN0Vj?=
 =?utf-8?B?b3d3b1Zvd0Q5TXhLc3d2TzU1TGtwejBwN3FoOFV0RkJWQVJCYVREUlEvc1BW?=
 =?utf-8?Q?sGuDli7sp2MGFgI1DCqIhC2KuZhuSVkLVlDB6J0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f354a61d-b02e-4b5b-8bd7-08d987494b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 15:11:51.0269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHruUaUoNrLF7fOEZMrgzRXDvYets75IO0fFbIyTZiwof3km9mOSdGhWVsn6tqIfkvxFxOlo2P/jcpguFgpMwawDcycO7aKSqNXI667Ntyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3129
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQgT2N0b2JlciAyMDIxIDEzOjA1LCBBbGV4YW5kcmUgR2hpdGkgd3JvdGU6DQoNCj4gPiA+
IFRvZGF5IEkgd2FzIGxvb2tpbmcgaW50byBPcGVuQlNEIERBOTA2MyBkcml2ZXJzIGFuZCB0aGV5
IG1pZ2h0IGJlDQo+ID4gPiBkb2luZyB3aGF0IHlvdSBkZXNjcmliZWQgZm9yIHRoZSByZXNldC4N
Cj4gPiA+DQo+ID4gPiBkZXYvZmR0L2RhcG1pYy5jDQo+ID4gPg0KPiA+ID4gWy4uXQ0KPiA+ID4g
MjQxIHZvaWQNCj4gPiA+IDI0MiBkYXBtaWNfcmVzZXQodm9pZCkNCj4gPiA+IDI0MyB7DQo+ID4g
PiAyNDQgICAgIHN0cnVjdCBkYXBtaWNfc29mdGMgKnNjID0gZGFwbWljX2NkLmNkX2RldnNbMF07
DQo+ID4gPiAyNDUgICAgIHVpbnQ4X3QgcmVnOw0KPiA+ID4gMjQ2DQo+ID4gPiAyNDcgICAgIC8q
IEVuYWJsZSB0aWNrIGFsYXJtIHdha2V1cCB3aXRoIGEgb25lIHNlY29uZCBpbnRlcnZhbC4gKi8N
Cj4gPiA+IDI0OCAgICAgcmVnID0gZGFwbWljX3JlZ19yZWFkKHNjLCBBTEFSTV9NTyk7DQo+ID4g
PiAyNDkgICAgIHJlZyAmPSB+QUxBUk1fTU9fVElDS19UWVBFOw0KPiA+ID4gMjUwICAgICByZWcg
fD0gQUxBUk1fTU9fVElDS19XQUtFOw0KPiA+ID4gMjUxICAgICBkYXBtaWNfcmVnX3dyaXRlKHNj
LCBBTEFSTV9NTywgcmVnKTsNCj4gPiA+IDI1Mg0KPiA+ID4gMjUzICAgICAvKiBFbmFibGUgdGlj
ayBmdW5jdGlvbi4gKi8NCj4gPiA+IDI1NCAgICAgcmVnID0gZGFwbWljX3JlZ19yZWFkKHNjLCBB
TEFSTV9ZKTsNCj4gPiA+IDI1NSAgICAgcmVnIHw9IEFMQVJNX1lfVElDS19PTjsNCj4gPiA+IDI1
NiAgICAgZGFwbWljX3JlZ193cml0ZShzYywgQUxBUk1fWSwgcmVnKTsNCj4gPiA+IDI1Nw0KPiA+
ID4gMjU4ICAgICAvKiBDbGVhciBldmVudHMgc3VjaCB0aGF0IHdlIHdha2UgdXAgYWdhaW4uICov
DQo+ID4gPiAyNTkgICAgIGRhcG1pY19yZWdfd3JpdGUoc2MsIEVWRU5UX0EsIGRhcG1pY19yZWdf
cmVhZChzYywgRVZFTlRfQSkpOw0KPiA+ID4gMjYwICAgICBkYXBtaWNfcmVnX3dyaXRlKHNjLCBD
T05UUk9MX0YsIENPTlRST0xfRl9TSFVURE9XTik7DQo+ID4gPiAyNjEgfQ0KPiA+ID4gWy4uXQ0K
PiA+ID4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhlIHBvaW50ZXIhIEkgaGF2ZSBqdXN0IHRlc3Rl
ZCB0aGlzIHNlcXVlbmNlIGZyb20gdGhlDQo+ID4gdS1ib290IHNoZWxsLCBpdCByZXNldHMgdGhl
IGJvYXJkIGNvcnJlY3RseS4gQnV0IHRoZW4gaWYgd2UgdHJ5IHRvDQo+ID4gcG93ZXIgZG93biB0
aGUgYm9hcmQgYnkgYSBsb25nIHByZXNzIHRvIHRoZSBjb3JyZXNwb25kaW5nIGJ1dHRvbiBvbg0K
PiA+IHRoZSBib2FyZCB3aXRoaW4gMTYgc2Vjb25kcywgaXQgcmVzZXRzIHRoZSBib2FyZDogc28g
d2UgY2Fubm90DQo+ID4gc2h1dGRvd24gdGhlIGJvYXJkIGluIHRoZSBuZXh0IDE2IHNlY29uZHMg
dGhhdCBmb2xsb3cgdGhpcyBzZXF1ZW5jZS4NCj4gPg0KPiA+IE1heWJlIHRoYXQgY2FuIGJlIHJl
c29sdmVkIGJ5IHVzaW5nIHRoZSBvbmUtc2hvdCBhbGFybSBhcyBkZXNjcmliZWQgYnkNCj4gPiBB
ZGFtLCBJJ2xsIHRyeSB0byBmaW5kIHRoYXQgaW4gdGhlIGRhdGFzaGVldC4NCj4gDQo+IEFmdGVy
IGNvbmZpZ3VyaW5nIHRoZSBvbmUtc2hvdCBhbGFybSwgSSBzdGlsbCBoYXZlIHRob3NlIGludGVt
cGVzdGl2ZQ0KPiByZWJvb3RzIGlmIEkgdHJ5IHRvIHBvd2VyIGRvd24gdGhlIGJvYXJkIGJ5IGEg
bG9uZyBwcmVzcyB3aXRoaW4gMTYNCj4gc2Vjb25kcy4gVGhlIG9ubHkgdGhpbmcgSSBmb3VuZCBp
biB0aGUgZGF0YXNoZWV0IHJlZ2FyZGluZyB0aGlzIHRpbWluZw0KPiBpcyBpbiBjYXNlIG9mIHBv
d2VyIHVuZGVydm9sdGFnZSwgbm90IHN1cmUgaG93IHRoaXMgaXMgbGlua2VkIHRvIHdoYXQNCj4g
SSBzZWUuDQo+IA0KPiBAQWRhbSBUaG9tc29uIEFueSBpZGVhcz8NCg0KTm90aGluZyBpbW1lZGlh
dGVseSBzcHJpbmdzIHRvIG1pbmQuIENhbiB5b3UgY29uZmlybSB0aGlzIGlzIHRoZSBuT05LRVkg
bG9uZw0KcHJlc3MgdGhhdCB5b3UncmUgYXR0ZW1wdGluZyBoZXJlLCB3aGljaCBpcyByZXNldHRp
bmcgdGhlIGJvYXJkIHJhdGhlciB0aGFuDQpzaHV0dGluZyBkb3duPw0KDQpBbHNvLCB3b3VsZCB5
b3UgYWJsZSB0byBhZ2FpbiBwcm92aWRlIGV2ZW50cyBhbmQgZmF1bHQgbG9nIHdoZW4gdGhpcyB1
bndhbnRlZA0KcmVzZXQgb2NjdXJzLCBqdXN0IGluIGNhc2UgdGhlcmUncyBhbnl0aGluZyB0aGVy
ZSB0byBnaXZlIGEgY2x1ZS4gQ2FuIHRoZW4NCmRpc2N1c3MgaW50ZXJuYWxseSB0byBzZWUgaWYg
d2UgY2FuIGFzY2VydGFpbiB3aGF0IG1pZ2h0IGJlIGhhcHBlbmluZyBoZXJlLg0K
