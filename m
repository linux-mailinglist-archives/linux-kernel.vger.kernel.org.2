Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371C941C5B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 15:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344240AbhI2Nf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 09:35:28 -0400
Received: from mail-eopbgr20040.outbound.protection.outlook.com ([40.107.2.40]:43394
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344171AbhI2NfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 09:35:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQOCwPYfVAh+j1Hswkwgprcq+S99lMroMcOWTPQm1qd7ebkPlaVfEe2xZf0atFpfeVL6YCkTTQMUTo/IGvcfpC0SwK2d7PMTZpwdWxZdKKBh88TivI/pzlfEfWr75AaMEizaRnY/VX8I41UjCcVaCqrWM3tkPdxUvU65nX4vJPkoCaGoG6szF9v7sr+vHk4Tn2onTJ2Fq+WhzsKrOGlbcHaPvZijCun4L+kEKJcz7RwCNA4sKAe+t/vufbmIN69ZRPcBanuzauMZrpi+19kMr3YJxAaxMShAUqztCVjw319rFzfh/eVTm/P/W3GemVR+xIkPYNnVww9KmTslOVKtyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=f4QNJz5o4AItzyVO6GcpS1y5117GXjoOLJgNa2i25R8=;
 b=JlgUgpRBriRnFD7qtvI5luuxnqASd8nfnAgvvZ4qmRPvqGyXCT/09rq6q6eVX/KhBUJZQDZecEvzqWLDysyQkqxzpaZtfMTPqTMGmbVsUmwKo7UViOzxuWJEYYGAZyoXQa7EfV3/tIZn6aJezLRk7/YHL2m+vDMSvrII7YK7Og5cNRgaI0jFSFNtoIdwLcsYYcO/3oRm3EdcG9ii27i45fCuSqGkx50HC54SNd0q6p5mo4Hju4YjLyttpSv3w0AxhszK/mt/yJlRQpX0+h2+IEszTwSKbHcqwskgd8ZDEs757YeoBGXAiYyYGIwf7XqG2i0STplsWtvUIw7RwUJLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4QNJz5o4AItzyVO6GcpS1y5117GXjoOLJgNa2i25R8=;
 b=YM4NHRfE3x7efcAPhmxSwSlr04SBynCySa1X7XL2ihii0R6iTwtf0FPG0m7DUenlA8SO1Ad8Mku64+lT6juxZn7rrgRtWANfCX8jvjtaaCH3UWS1vmngA7nv7HkGFwCBf9o7iVRQfhDpTIqhG2vB4KC68FRnNKVfbspJvMYp2CU=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.16; Wed, 29 Sep
 2021 13:33:37 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::dc0f:9e52:6dbb:1144%7]) with mapi id 15.20.4544.022; Wed, 29 Sep 2021
 13:33:37 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] drivers: mfd: da9063: Add restart notifier implementation
Thread-Topic: [PATCH] drivers: mfd: da9063: Add restart notifier
 implementation
Thread-Index: AQHXrqpI0LoFC+MHc0+B+6k9QHIUIauzTVswgAAUm4CAB616wA==
Date:   Wed, 29 Sep 2021 13:33:37 +0000
Message-ID: <DB9PR10MB46523AE6EF51D6C801B4A9BF80A99@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20210921053356.1705833-1-alexandre.ghiti@canonical.com>
 <DB9PR10MB465252461469340F60A8714780A49@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <CA+zEjCvKaS0sE7paCecMDvqpkw-yLM_QFHdF5pgWTAqeH0JAfA@mail.gmail.com>
In-Reply-To: <CA+zEjCvKaS0sE7paCecMDvqpkw-yLM_QFHdF5pgWTAqeH0JAfA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e5e29b6-e591-4140-848a-08d9834dbe2b
x-ms-traffictypediagnostic: DB6PR10MB1845:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR10MB18454965308C3A553C362786A7A99@DB6PR10MB1845.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5HRygqZ/oSt9GFbp8wtX73/33OIZfYQUdDct88QScSL1AcXS0Y8HkoeEmaOLT+fdSIHfiJOQ8zuf+ltVb7joNeoM/DsUuOU6TfOA6I8CX/iuFO620vJ6Zp5emi13ZlkWG5+mC2xyauksYLJbVeomHCwOMrjGAyn2znF9aTiz9dBKhXZQcG3R8ldOF4m29p5t5NhAL/9PrlynDAflIjaw+xsl5LKczReVDCS6VMTDgmsWunlx0XyxjSPIVC7GumKH8rKjPnmGCkcJd12ug6kli2tciVjG8ev65OXDVGprDc9Sm6WXD25nP7j81vdSqQUiovUIL6+nCCUydnGB1LUwKgDkJWWvUeCA6hG2u8OkGAVtm/vUb763YUk+iNwwChVFPjeL+DoJDhGXLQLjomdLM5ZxcEtUoI2JA+nGN8mLiGV9fwkeW3do+/1yuqANlBiSpOaI25jIn9pzrYYJP/LWDfz2/kjYZB91T1/zl7HOqSTFU43AK7FwzrqKTGzAYdrT01/FbWRgMbnHT4NrcarnYm+S3VcumszZb7/a6QPK3uINOaVrl7QyfdDZQYoOLTm3yMA7cxwh+sZwxpT1m947sAbYZqV3rtmyc7JQnV6BSwBGQksjiX/koZd4VSqSA6ZTC58I9xE74GKFZANg/+vLGP5oVAmO8rKYdRWEIogjeFtab5WkdQV+zluNktLsSSiAAruG3yL6J6NYkhDS/s8LD0OL1KmpsyCVyyV3Hptu7YtIyCuGp+2nMQK7j976wFWTpAS4voWozNXTTTJWrEwkvRaupsiNFxvjPaVntMxnhSU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(9686003)(71200400001)(4326008)(186003)(83380400001)(2906002)(122000001)(33656002)(55016002)(5660300002)(86362001)(316002)(76116006)(8936002)(7696005)(52536014)(38070700005)(54906003)(66946007)(66446008)(66556008)(110136005)(64756008)(66476007)(8676002)(26005)(6506007)(53546011)(508600001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXlOSG9BckR3Uk9mNjllaHJ6TW5MOGc0eFlpMkMwSy9XS2RRZ0h2NGN0TlNw?=
 =?utf-8?B?SVdyNFRIVzBQdDVlSEp5cmxKTGQ2elRSSE8xa1c3SDNPZzZzY3k5enJwV3oz?=
 =?utf-8?B?RVhJSGR5ZkhtQlZPTjNwM004cTVxMy92QzdlM3JCb2lXWXpxbHY3dW1wa1h2?=
 =?utf-8?B?bnJHYkc2OFFXRU9LWnB4SW5POU9MVDRhNXhFdVFBM2FkdWNuS1pTUG9vSmpM?=
 =?utf-8?B?Slg5T3FNc1psYWJnT1p4SzZPdHA1d0dKQWhlUWJpcVg0NlpQUmdTNkcvdDI2?=
 =?utf-8?B?blBDbzFFZGtkYW42V1FuUXhzQmY3S2d4QmY4ZkpqV1ZWVEJkejd1eVJlbEw1?=
 =?utf-8?B?eHpGUCt1RXFIWUJodldXcWdLZnNRbmVRUVA0c1BRTy9aakhudnVCVUhaZndO?=
 =?utf-8?B?N0R4dzZ2bWNqZGhiNC9aRGpoSDJkQ1I1VmhNTFQraU03N2NXTmJWV0hUcUxY?=
 =?utf-8?B?MStydk44Wi83OWwwUUp3WlZOckh0TitHbnpQRHNTazlBYWVUZXR6TzVPUmw3?=
 =?utf-8?B?NzhCeGQvQ05vTUE2VHFhYXFCSXpXSyt2TGRveC9oVnBRYW5zbi85RzFRZFVY?=
 =?utf-8?B?aUwvekZ2VTBLSWRyUTVMczNyZEhpcnlZNGhBVHdhM3dpdjAyMXdKYkhOVHRW?=
 =?utf-8?B?L2tuM204S2ZkWTV5cDF0aXdEMGUraGVYTDhBMHJyRU5taXAzMjRIb011YldO?=
 =?utf-8?B?N2NObWI0elZJeC8ySGFLdFhPTkMxcEVZOWljOG5EWnZtMS9wVHh0Tk9XTGF3?=
 =?utf-8?B?bFlyaXNreXd1Z2ZFelRxN3JUbENadzd1Z3g1T2xQREZ6SzlTZEZIQUpqWTkw?=
 =?utf-8?B?K2JxRmVzMC91QUhRSldRck1iRXZkRHVoRGV3cCthdHl4U3ZYM1VzVm9yR1NR?=
 =?utf-8?B?aEg1QktwbGZSRkM5OE1TOVpnNUNOYlQvOWZRRHhvZWpYZ3gvY0Z5M085VWdL?=
 =?utf-8?B?SWFEMmt3RW9jVHVka1dxMmloRTJvaWQ4a0l6bXZVRVBwRk95RzZNRWJnck5R?=
 =?utf-8?B?U056ZHZaVUhIbSt5MDF3L3dtZUF6eDltYUo3dVM3TUtEMldXYzZMcmp5SVoy?=
 =?utf-8?B?SGM2STlFL3RwOFNHcjFFejF1Zy9RQ0k4dFY1WFZqUXJJT20zQkVsMWl3YjlN?=
 =?utf-8?B?eE42TE5GQlZ0Z0kxRjlURG43dnZoWUVidUtiajI0cjJ4NjJDRTBhNk9VVVRF?=
 =?utf-8?B?emlzVDZHUFBpY0FFY0dnT3E5UWZOVytUTndDR3o1Z2QyeUlXVGZGMzhZaGVm?=
 =?utf-8?B?QXVEQ2ViVWFWbXFWVDRjNzV5RFF5bzc2NlJkUEFEUStWVEZpbVEzY2ZiK29G?=
 =?utf-8?B?S1ljZUlFWmtXdEU1WU9qWW1ZcGxOcVQrbnZJTThDMFcxN2dzNUg3WktJVVE0?=
 =?utf-8?B?c05ILzRKUGRpemdhSzlrd0pQQ1VFOEJXSUdISHl1TE95WnlyYkFDdmxzeCtS?=
 =?utf-8?B?K0lXN0xNdlJFUDc5M0N1eTRQMlIvbVRiVjR2M0VCSDhZc2ZOZzd1TmhNZHpR?=
 =?utf-8?B?VE1jaE1IR1NHWlZ5UngvbGFrWU10YlZxSTRnZWxtTDBCRWc5dGp3RXhISEZO?=
 =?utf-8?B?QkFZejVkbExCRFNXQUthUWcrY3kvRU5Ibm5JNXVGUEpLdE1MTHRLRW4xVlhZ?=
 =?utf-8?B?NHA3WDlPMVRKSktrNHQwN3JzNTNrRFNFL1FFalhpNURRQkdBUXU3OVkvd3lZ?=
 =?utf-8?B?dzBBZzdxd2NDSm1FT2dOVCs2Zm1HSWZDNnB0cjNsT3FyNElFTXB1VlhsN0Fz?=
 =?utf-8?Q?/8ZEPuJD2qQ/t0LmKAnJjyTA/yRBYJXnxcEqC9Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5e29b6-e591-4140-848a-08d9834dbe2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 13:33:37.4515
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: si+0rVaZQKmY9IAHLytb89UQv3uldX7H/iexI5lLzO38zHtGzH1iRD3SdjNjUTA2oagWau6M0bFVCBRiZoH+ZfvbHoiFqu0/IpcTPbxb5oE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1845
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQgU2VwdGVtYmVyIDIwMjEgMTc6MTcsIEFsZXhhbmRyZSBHaGl0aSB3cm90ZToNCg0KPiA+
ID4gK3N0YXRpYyBpbnQgZGE5MDYzX3Jlc3RhcnRfbm90aWZ5KHN0cnVjdCBub3RpZmllcl9ibG9j
ayAqdGhpcywNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBs
b25nIG1vZGUsIHZvaWQgKmNtZCkNCj4gPiA+ICt7DQo+ID4gPiArICAgICBzdHJ1Y3QgZGE5MDYz
ICpkYTkwNjMgPSBjb250YWluZXJfb2YodGhpcywgc3RydWN0IGRhOTA2MywNCj4gPiA+IHJlc3Rh
cnRfaGFuZGxlcik7DQo+ID4gPiArDQo+ID4gPiArICAgICByZWdtYXBfd3JpdGUoZGE5MDYzLT5y
ZWdtYXAsIERBOTA2M19SRUdfUEFHRV9DT04sIDB4MDApOw0KPiA+ID4gKyAgICAgcmVnbWFwX3dy
aXRlKGRhOTA2My0+cmVnbWFwLCBEQTkwNjNfUkVHX0NPTlRST0xfRiwgMHgwNCk7DQo+ID4gPiAr
ICAgICByZWdtYXBfd3JpdGUoZGE5MDYzLT5yZWdtYXAsIERBOTA2M19SRUdfQ09OVFJPTF9BLCAw
eDY4KTsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIHJldHVybiBOT1RJRllfRE9ORTsNCj4gPiA+ICt9
DQo+ID4NCj4gPiBJIHdpbGwgdGFsayB3aXRoIG91ciBIVyB0ZWFtIHRvIGNsYXJpZnksIGJ1dCB0
aGlzIHNlcXVlbmNlIGxvb2tzIHRvIGJlIHZlcnkNCj4gPiBzcGVjaWZpYyB0byB0aGUgbmVlZHMg
b2YgdGhlIHBsYXRmb3JtIGluIHF1ZXN0aW9uIHdoaWNoIGRvZXNuJ3QgZmVlbCByaWdodCB0bw0K
PiA+IG1lLiBBcyB3YXMgbWVudGlvbmVkIG9uIGFub3RoZXIgdGhyZWFkIGFzIHdlbGwsIHRoZSB3
YXRjaGRvZyBkcml2ZXIgYWxyZWFkeQ0KPiBoYXMNCj4gPiBhIHJlc3RhcnQgZnVuY3Rpb24gdG8g
cmVzZXQgdGhlIGRldmljZSAoYW5kIHRodXMgdGhlIHN5c3RlbSksIHNvIEkgZG9uJ3QgYmVsaWV2
ZQ0KPiA+IHdlIHNob3VsZCBoYXZlIG11bHRpcGxlIG9mIHRoZXNlLg0KPiANCj4gRnJvbSB0aGUg
ZGlzY3Vzc2lvbiB0aGF0IGhhcHBlbmVkIGhlcmUNCj4gaHR0cHM6Ly93d3cuZGlhbG9nLXNlbWlj
b25kdWN0b3IuY29tL3Byb2R1Y3RzL3BtaWNzP3Bvc3RfaWQ9MTAwNTIjdGFiLQ0KPiBzdXBwb3J0
X3RhYl9jb250ZW50LA0KPiBpdCBkb2VzIG5vdCBzZWVtIHBvc3NpYmxlIHRvIHVzZSB0aGUgd2F0
Y2hkb2cgb24gYSBjaGlwIHdob3NlIE9UUCBkb2VzDQo+IG5vdCBzZXQgQVVUT0JPT1QuIEJ1dCBh
bnl3YXksIEknbSBsb29raW5nIGZvcndhcmQgdG8gaGVhcmluZyBmcm9tIHRoZQ0KPiBIVyB0ZWFt
IDopDQoNClNvIEkndmUgZGlzY3Vzc2VkIHRoaXMgaW50ZXJuYWxseSBhbmQgc28gZmFyIGl0J3Mg
bm90IGNvbXBsZXRlbHkgY2xlYXIgaG93IHRoZQ0Kc2VxdWVuY2UgeW91IHByb3ZpZGVkIGFjdHVh
bGx5IHBlcmZvcm1zIHRoZSByZXNldCBhcyB5b3Ugc3VnZ2VzdC4gSXQgY2VydGFpbmx5DQpkb2Vz
bid0IGxvb2sgbGlrZSBpdCBzaG91bGQsIHNvIG1heWJlIHRoaXMgcmVsYXRlcyB0byBhbiBleHRl
cm5hbCBwaW4gc29tZWhvdw0KdHJpZ2dlcmluZyB0aGUgcmVzdGFydCBpbiB0aGlzIHBhcnRpY3Vs
YXIgc2NlbmFyaW8/IEknZCBiZSBpbnRlcmVzdGVkIHRvDQp1bmRlcnN0YW5kIHdoaWNoIGV2ZW50
IGJpdHMgYXJlIHNldCB3aGVuIHRoZSBib2FyZCBkb2VzIHJlc3RhcnQgdG8gdW5kZXJzdGFuZA0K
d2hhdCBkaWQgYWN0dWFsbHkgdHJpZ2dlciB0aGUgYm9vdC11cC4NCg0KUmVnYXJkbGVzcyBvZiB0
aGlzIHRob3VnaCwgdGhlIGNvbnNlbnN1cyByaWdodCBub3cgd291bGQgYmUgdG8gdXNlIHRoZSBS
VEMgYXMgYQ0Kd2FrZSBldmVudCB0byByZXN0YXJ0IHRoZSBwbGF0Zm9ybS4gQW4gYWxhcm0gY2Fu
IGJlIHNldCBmb3IgYSBjb3VwbGUgb2Ygc2Vjb25kcw0KaW50byB0aGUgZnV0dXJlIChvciBsb25n
ZXIgaWYgcmVxdWlyZWQpIGFuZCB0aGF0IHdvdWxkIHByb3ZpZGUgdGhlIGV2ZW50DQpyZXF1aXJl
ZCB0byBjb21lIHVwIGZyb20gcG93ZXJkb3duL3NodXRkb3duLCBpbiB0aGUgYWJzZW5jZSBvZiBB
VVRPQk9PVCBiZWluZw0Kc2V0IGluIE9UUC4gSSBiZWxpZXZlIHRoaXMgd291bGQgYmUgdGhlIHNh
ZmVzdCByb3V0ZSB0byB0YWtlIGluIHRoaXMgY2FzZS4gWW91DQpjYW4gdGhlbiBqdXN0IHVzZSB0
aGUgU0hVVERPV04gYml0IG9uIENPTlRST0xfRiB0byB0YWtlIGRvd24gdGhlIGJvYXJkLg0KDQpU
byByZWl0ZXJhdGUsIEkgYmVsaWV2ZSB0aGlzIHNob3VsZCBiZSBtYWRlIGEgYm9hcmQgc3BlY2lm
aWMgcXVpcmssIHJhdGhlciB0aGFuDQphcyBwYXJ0IG9mIHRoZSBnZW5lcmljIE1GRCBjb3JlIG9m
IERBOTA2MywgYXMgdGhlIHRpbWluZ3MgbWF5IHZhcnkgZm9yIG90aGVyDQpwbGF0Zm9ybXMuDQo=
