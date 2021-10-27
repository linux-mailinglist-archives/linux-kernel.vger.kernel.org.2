Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2DC43CE76
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 18:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhJ0QRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 12:17:07 -0400
Received: from mail-eopbgr80105.outbound.protection.outlook.com ([40.107.8.105]:54342
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229885AbhJ0QRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 12:17:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb1hpN0z7n0vLZKj5YCRea36hyaIqzfCHvKNr7tM42mM9c/0m/+OXt7n+UvJojuvdpdap4fTtSU61sfmsa8lp+MNbNUPRrN9iwZzwfmRDAvzqg6yVrbfS0mpCQKzE0oMj9eK4R2PCZfVQoGcHqM+Bs52s294wmSIGeE+Dl40TQKVbiKBg5Lt0p7GPlNtWavy3U0SJPnMyAPQknwTijWe3cC7jwBLqfnRuMkN+mXiB/cmxJLLVhKghdb6uCW7lKWpx1LHZT/NQFuXMwP/QB1tIcZ850QXlqraZ+rr3luhDFLxdSoxaxloFsG2FE9RhunkAtrIoK8vTpBw5SJImYO9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tyz66RZWViaL7XRzKl4nwNV8Kk5ojx8bpm/UOfqcY4=;
 b=efNUMmG9bz5mgYj89MoqiWrvQtvMaRGQ2boEhhmlmGphlQjU8ApFVkcl4840y8MQbxXLCTWK2NHFF8bX/Qc4zGbUeWyfVGEv7ID/cCxVv8Tni+viomijmBXj7jp0+jkNo13uwdgO/nLpdNN6Lfr1fKwNBQuhRFB849009oG5XgPBY2pQYjL/xvdW4quSs5XWoHB5SA0umh55EY+Hp2vA8iDgJ5ZN1mEkCN+wDRqCkDA3bPY9hXbf7na9XOACEqJx+5gD1nN0BmUaxEZ4CYoLU1oO7Qk5ILzYeJ2WMs1o9MFpBJ5iq9HBLkydU8k6l/WxsMWRdbe560HELeaUuS7ylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tyz66RZWViaL7XRzKl4nwNV8Kk5ojx8bpm/UOfqcY4=;
 b=M93KIrbG5pgMIVKmcg24yDYOBdMBQZzYmhao6dg/pEN4pUJC4dCtWhDKWIBgSULq41L5VH3wNU2IAFfFAboPFgiBMItGM9F57NfyV26qR5KhsYjWrvBTM2ejEF5CXSA7SQezxC4PwKnXJyx4LJ6MELpgUj0qCiVsozJJtb0Dwlk=
Received: from DB7PR05MB5431.eurprd05.prod.outlook.com (2603:10a6:10:55::32)
 by DB6PR0501MB2184.eurprd05.prod.outlook.com (2603:10a6:4:4b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 27 Oct
 2021 16:14:37 +0000
Received: from DB7PR05MB5431.eurprd05.prod.outlook.com
 ([fe80::91e8:e960:243:da70]) by DB7PR05MB5431.eurprd05.prod.outlook.com
 ([fe80::91e8:e960:243:da70%5]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 16:14:37 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "oleksandr.suvorov@toradex.com" <oleksandr.suvorov@toradex.com>,
        "oleksandr.suvorov@foundries.io" <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH] mfd: stmpe: Support disabling sub-functions
Thread-Topic: [PATCH] mfd: stmpe: Support disabling sub-functions
Thread-Index: AQHXywu7Kr36aJLw/k2IC9Nh1i6dvavnBWAA
Date:   Wed, 27 Oct 2021 16:14:37 +0000
Message-ID: <7bcab132eb763b33a49c065068199a5996330652.camel@toradex.com>
References: <20211027082155.206449-1-francesco.dolcini@toradex.com>
In-Reply-To: <20211027082155.206449-1-francesco.dolcini@toradex.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbaf78bd-8b25-42a9-d93f-08d99964df7b
x-ms-traffictypediagnostic: DB6PR0501MB2184:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0501MB2184086392DEF6A6A884DE4BFB859@DB6PR0501MB2184.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:565;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aCEAthm6Q4yqPx+d4Rnq9qTdMa2lvI1x1OO393cd751LcAAgWo19Pu4vaRQ8Vhr78Vl2dnQcfNtYuJAbbGeO27T2lsblaRbzJ1t8cbwi+Y0PiYwEUZE1zWJB4JjXOoMlMYIIzUiBX8gG9NiZVlwiQPgnqJRAjW099zuQPtW5ANfilLbIm6H77XKte3ulRsAZ2vRgejjMIxXUQcZxrv2xB5ZP4Md23wYZevPJaUOXWDiGlevX10pMv291O53mBB1HeC2cTg2jrcgr3c8kEtjM4qs8JdeInZMpU8I8IbXKoMRfC9YB7MMCfpQhk9qG8QZ4L0E0F4Zqw41brsa+0ZbxeFIRzPau2Gv1lH76fekQxwfmFK/wYadBD7fvb6S8CKvdpw95baWJPbu21dIQ0dZBKxlwF+qRindoiYcErlG7val6VD40bm7mV9C++UUEZ18EfP1JP9+SL8l28nFi+t3BUNJu1bqhLs5dHMQu9YZmYi9VYCpAszbObiknCKxCulfU1vqHfWuOeXmc0AmXCKZzpuZVGCv5S+WFpfdkrPbalDtbHrhUwedpTz0ifkR0y0n7u979TE2ZJPY0L4SGxXOPB9B7wxeDYup9qbIAU1DD/qU2eiehk4mALYOuwel/eFYGDwOkozudR6tIdg4MelbPkDg6EBiZYwxxeVtjxQGbVjqL2iMn2YrGsnt8E12FDZn9AByshwpayWxvrVbH3MQl/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR05MB5431.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(376002)(136003)(346002)(366004)(122000001)(6506007)(2616005)(38100700002)(71200400001)(316002)(44832011)(186003)(6512007)(2906002)(83380400001)(76116006)(4001150100001)(36756003)(508600001)(4326008)(26005)(6486002)(86362001)(54906003)(66476007)(8936002)(66446008)(38070700005)(64756008)(66946007)(66556008)(8676002)(91956017)(5660300002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmxkaDFWL2Nlakl6RUZ4RU9iY2k2Z2RxZ0dlMnB5ektnNlM3S29idGxDL3Rm?=
 =?utf-8?B?Y1ZKUzlkNzhWaW9MRWJRaDJYVnE1YmZxMnVLamExUXNxM1BZTDZPODdjY0xS?=
 =?utf-8?B?WFRjMjI3TWNDRjVOSWRrUW1Qc3pIekNvSyt6ejVaOWNTY3hPY1R0bldHeHEv?=
 =?utf-8?B?N2hpbWZMcnJLaXMvSUQwQjZkb01OV2RIVEdpUkF3MjVoKzB0a0VpN1VBalNx?=
 =?utf-8?B?VTRadVF5ZmxCNnRNNnFPUUxXZkJkdSs0VGNrdVZwbHZuK2FIdGtpTnJ5akQ4?=
 =?utf-8?B?eGZ2T2Z6MUE0SXlBZXQ1Y3dOa0szV0JveFFnT25zN2R4Ui9Nb3BHUjlBZldW?=
 =?utf-8?B?Tjd4bDFZQUJLZWhpK1ZWN3ExNTlxKzdGUUhvZzhsQW1ySW1ueUVCWEJYeU96?=
 =?utf-8?B?NktoTDgxUUN0WGhtbS9MbkFuLyt3TjFsamMrYlFRT2dSWmZjdkExR0hkZkdX?=
 =?utf-8?B?eDd6SUJSQXFYeXNRdUtCODM3aXFObWFOTW1MTGQrT2hDTUFGc0tJcjFzeEZi?=
 =?utf-8?B?WFY4cUdTaGZ6QkVXS3d4blFFSi9lY0dIbC9QMmlzendWb0E4K3hxbmlLRXln?=
 =?utf-8?B?NEVibVFHZG1maXNabGpvdXo5engzbHMxYTg0dGZzQTNGaXlCKzY4UW9CRity?=
 =?utf-8?B?Smk1Nm9LdTRZdmNJb2c5Q3FGdGFUSzRpRjdZaHE0OGhDM3J3WGRnL0VITDdU?=
 =?utf-8?B?REx4eUMzay8yQUs1bGp3TXpkaURDS1pudGlZcFNnTEF4eTArMUJoQkl5NXRs?=
 =?utf-8?B?VFA0QWh1Q3ZyTndkN1kxUWtTVkNTUkdYTEhRbmVPTEJleGhkNW4xejRtTkFl?=
 =?utf-8?B?M0F1RGdDNDljK2FWR2ttNzdrdzUvWHU5aXdVdi9lTnA5TThWRXdVNDV5WlJu?=
 =?utf-8?B?NFQ5czd3V21ONEdBaGFRcEpUVGgvVHJhZzMwdURDcFBZOThvQnBBK3BuSlRj?=
 =?utf-8?B?L0NEQVBSdUx3MVBoSUhkck9SZWhLaTV0UmJOTzBBYU93SlY3dVBYZnRhVjgy?=
 =?utf-8?B?dXJwUkVOQ05kRjdvSUJ5WnpNQnoyK1ZBNmQxWlo3T3FqZkRGbzZYNnhyNFh2?=
 =?utf-8?B?RldTclVrZjU3bkVDbUt4cmVFOUJOSFg0czRlRGFaZHVYMktrblZZRjl2bGFS?=
 =?utf-8?B?OEFZVm5uWGRLOXdFdzlQeDNOeFRDeW5uWlI1UjE3QVB1UWVKUXE3aTcwTmFI?=
 =?utf-8?B?c3dqcTU1alhyNHFOOFBuNkhhZkswd3dsNHZPWWJyYUxlWEsrMU5yaGU3Q3pN?=
 =?utf-8?B?TzdZalBsRzR6a3Y4dWdkNU11dzBCTCs0QUV4VFJPUlVnZHZOaHVWZlMxdjZp?=
 =?utf-8?B?Y2ZYNEVCcldVK3pPVm5DTGwyVUxXNEVFbVAwb3dydWVmU0FNcmYwbExRZC9u?=
 =?utf-8?B?c1pmT2hYZDNaSEF6T01zY1Rkb3FMUGE4RjEwR1BEMDBuSW9pVkNraW5kbDR5?=
 =?utf-8?B?cWsvdnRDcWQwTWFBUUFtbWw3RUhGaTM4WHRSWHJPTHRvTVQvalo5Q05nMHZD?=
 =?utf-8?B?Q0lnaWtxdHd1QlZXRGlXNXV2OVA1bW9penF3dFdIOGhwU1NmMm01cjE3Sklp?=
 =?utf-8?B?cFhjQWo0ZXU5dTBEOHl6dTV3RFdpVmtrazB4cGhGcUdraUdNNTJ5NmpLTDdU?=
 =?utf-8?B?cFNoWExrT3gzbHNHQ0tlc0dlbEhjaHZZUGhDbWJMUTZQbFdXM0tHYS9oQmp4?=
 =?utf-8?B?MFZEeTVQN3kxcTY2Vk82VFc5OE5wOGk1RWtMNjNTVTUwWDhmZkhxOTFHWlJU?=
 =?utf-8?B?WXdOTEpaOTJ5SFo4UmRqaU1OVkM0TW1jRDd1NFE0SFJEU2hnMkFxN1N3dWw3?=
 =?utf-8?B?QnlRTTVFQkxFbzBiNE83Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC37345C35FBC04397E6D138D99A1B12@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR05MB5431.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbaf78bd-8b25-42a9-d93f-08d99964df7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2021 16:14:37.4421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S4x9tSJUjeGPArJr2QviYh1GThNs+LGHF6li4q//cDtBxb9Je6v7uyeNyDWcvk6Av9ShjoiHRBGlXaUTANMVJ7oWcHeVGlkTlL68AWrDqng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2184
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRnJhbmNlc2NvDQoNCk9uIFdlZCwgMjAyMS0xMC0yNyBhdCAxMDoyMSArMDIwMCwgRnJhbmNl
c2NvIERvbGNpbmkgd3JvdGU6DQo+IEZyb206IE9sZWtzYW5kciBTdXZvcm92IDxvbGVrc2FuZHIu
c3V2b3JvdkB0b3JhZGV4LmNvbT4NCj4gDQo+IEFkZCBzdXBwb3J0IG9mIHN1Yi1mdW5jdGlvbnMg
ZGlzYWJsaW5nLiBJdCBhbGxvd3Mgb25lIHRvIGRlZmluZQ0KPiBhbiBzdG1wZSBzdWItZnVuY3Rp
b24gZGV2aWNlIGluIGRldmljZXRyZWUsIGJ1dCBrZWVwIGl0IGRpc2FibGVkLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogT2xla3NhbmRyIFN1dm9yb3YgPG9sZWtzYW5kci5zdXZvcm92QHRvcmFkZXgu
Y29tPg0KPiBDYzogT2xla3NhbmRyIFN1dm9yb3YgPG9sZWtzYW5kci5zdXZvcm92QGZvdW5kcmll
cy5pbz4NCj4gU2lnbmVkLW9mZi1ieTogRnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNjby5kb2xj
aW5pQHRvcmFkZXguY29tPg0KDQpSZXZpZXdlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwu
emlzd2lsZXJAdG9yYWRleC5jb20+DQoNCj4gLS0tDQo+IEhlbGxvLA0KPiB0aGUgbWFpbiByZWFz
b24gZm9yIHRoaXMgcGF0Y2ggaXMgdG8gYWxsb3cgZW5hYmxpbmcvZGlzYWJsaW5nIHN1Yi1mdWN0
aW9ucw0KDQo6cy9zdWItZnVjdGlvbnMvc3ViLWZ1bmN0aW9ucy8NCg0KPiB1c2luZyBEVFMgb3Zl
cmxheSB0byBlbmFibGUgbW9yZSBmbGV4aWJpbGl0eSBvbiBTb00vQ2FycmllciBib2FyZHMNCg0K
OnMvYm9hcmRzL2JvYXJkLw0KDQo+IGNvbWJpbmF0aW9ucy4NCj4gLS0tDQo+IMKgZHJpdmVycy9t
ZmQvc3RtcGUuYyB8IDIgKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21mZC9zdG1wZS5jIGIvZHJp
dmVycy9tZmQvc3RtcGUuYw0KPiBpbmRleCBlOTI4ZGY5NWUzMTYuLmFlYjllYTU1Zjk3ZCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9tZmQvc3RtcGUuYw0KPiArKysgYi9kcml2ZXJzL21mZC9zdG1w
ZS5jDQo+IEBAIC0xMzYxLDcgKzEzNjEsNyBAQCBzdGF0aWMgdm9pZCBzdG1wZV9vZl9wcm9iZShz
dHJ1Y3Qgc3RtcGVfcGxhdGZvcm1fZGF0YSAqcGRhdGEsDQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKg
wqBwZGF0YS0+YXV0b3NsZWVwID0gKHBkYXRhLT5hdXRvc2xlZXBfdGltZW91dCkgPyB0cnVlIDog
ZmFsc2U7DQo+IMKgDQo+IC3CoMKgwqDCoMKgwqDCoGZvcl9lYWNoX2NoaWxkX29mX25vZGUobnAs
IGNoaWxkKSB7DQo+ICvCoMKgwqDCoMKgwqDCoGZvcl9lYWNoX2F2YWlsYWJsZV9jaGlsZF9vZl9u
b2RlKG5wLCBjaGlsZCkgew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChv
Zl9ub2RlX25hbWVfZXEoY2hpbGQsICJzdG1wZV9ncGlvIikpIHsNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGRhdGEtPmJsb2NrcyB8PSBTVE1QRV9C
TE9DS19HUElPOw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0gZWxzZSBpZiAo
b2Zfbm9kZV9uYW1lX2VxKGNoaWxkLCAic3RtcGVfa2V5cGFkIikpIHsNCg0KQ2hlZXJzDQoNCk1h
cmNlbA0K
