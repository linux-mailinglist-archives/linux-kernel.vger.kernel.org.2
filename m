Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D068B4116B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236024AbhITOVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:21:02 -0400
Received: from mail-eopbgr00107.outbound.protection.outlook.com ([40.107.0.107]:48871
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232291AbhITOVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:21:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eyx+n6TEx67Yqg/n4lOv3bqjaWJIegP7APJMvMifiw0ctA1pTjp4cBiyor9I7qp9Tw2dofl4Cg8v/ntHPNYNDk19Ui59eafbj/F7uDL0L2ux7GDQW/L+gTANuS/q24QiWKeZc9KE5q6KD0Ra+dxblL0vcosoh9Y3fA8qCo/XQHUuWLt+n+0Kihi1V3ZUsw3AJEBmQrlyWjxAulgWk4FZx+2loix4VTmTrZlxzFtAA4KHoRyUhG77Q45EQMzhvBGVt8UavwNBNC4vRU9v2E6lFlHLXlFipDqXaIxYHYk28U083a9YlTx/YUsO8jDe86XO4xkYrK6mtvEJIk8w0Fb/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xHcFTK+mpr3hCZBl2F0hx/rTjCqs4ID76QCIHtEnnkw=;
 b=aphI+Re5Yq4kk/yktH8iWdSIESnW/z+pkRp6UnJeAMWRk2pc7qgNH7v0/sE28vo+w7y2EPjJOfk0jwqCppKrlqZ5CLgGYCzmb2XNh9S7jsJaUumDQfLX4JEhJDe7a7C0IeuZPuIMlsgs1CsVsA5AgvEOm1Fb0NcwB2OprleYgkr8L3NHnAxBbJLk5XRarPqPEPVWhgTXUU7/6+/izfrJptuKQLrNxVbGM4hWwUkq2lQQrEquiGt8Gxg8MqytdpzM872WnVJrAL9ddPo1csKvN254vMjMduNmPayySnb9wgdWGN3ahmCigNc6CdAWdoIZZtv5os2vVfh59KgCtWJCdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHcFTK+mpr3hCZBl2F0hx/rTjCqs4ID76QCIHtEnnkw=;
 b=Xh0Qyt7xAMx1Q6S9L4w3ADJ25IILZMFc3+43tTYI8+7OSwcGoeTmwUZJ14vA+wDCum3xCowZD22ESmlif7O2y+3eym0UUk7rckhpylbSNUellB+IFDtJkAFaoLxTfM/JYi61YwSjMv10ebA5Q4UV86+tpIXHbL3K2yhPe/CNDzM=
Received: from DB7PR05MB5431.eurprd05.prod.outlook.com (2603:10a6:10:55::32)
 by DB9PR05MB8492.eurprd05.prod.outlook.com (2603:10a6:10:268::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.15; Mon, 20 Sep
 2021 14:19:30 +0000
Received: from DB7PR05MB5431.eurprd05.prod.outlook.com
 ([fe80::8f4:9f42:ea10:e8e7]) by DB7PR05MB5431.eurprd05.prod.outlook.com
 ([fe80::8f4:9f42:ea10:e8e7%3]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 14:19:29 +0000
From:   Marcel Ziswiler <marcel.ziswiler@toradex.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "s.riedmueller@phytec.de" <s.riedmueller@phytec.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 7/9] dt-bindings: arm: fsl: clean-up all toradex
 boards/modules
Thread-Topic: [PATCH v3 7/9] dt-bindings: arm: fsl: clean-up all toradex
 boards/modules
Thread-Index: AQHXrVW9e2MDMcKR106AO96H4s3tzKus22aAgAAe+oA=
Date:   Mon, 20 Sep 2021 14:19:29 +0000
Message-ID: <d0568e8c5c46ebc04530b09c14c500d9ae8d5e51.camel@toradex.com>
References: <20210919125536.117743-1-marcel@ziswiler.com>
         <20210919125536.117743-8-marcel@ziswiler.com>
         <1632140917.871356.4136126.nullmailer@robh.at.kernel.org>
In-Reply-To: <1632140917.871356.4136126.nullmailer@robh.at.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=toradex.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 922f6d9f-71a8-4f0b-5b63-08d97c41a8fe
x-ms-traffictypediagnostic: DB9PR05MB8492:
x-microsoft-antispam-prvs: <DB9PR05MB849288A43518157F1AC893C3FBA09@DB9PR05MB8492.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bY601HgU0xgafrX2/QfQn57VTgDtG7wKULNDp7afUqyO8b/gdSvYhyl0W2HEL/kKkTRGgHMPRkwHgjYh9eG//BO+7q+vNH8rgBUkPyM10sPD1nD9VNcUK6prXvYFxYHOTFm2n7TfVIaxmJlj/CWDzD33x8ipEL8fK0YAOt8c5ZeUU20yVmea8tL/PaRAX1Haeniwx2GFe7xiXsszuOLWXeNpPJdK2AA1dNCEtQoPjOiBpI0+ipfH21pB8Bz3pWJeOy7vxBB2DJZkivp+3x9GUQT5/Ft2xhVI3TdGy8gTkzjaM99XyjOj+FRy+OT8cQxCuZIJJdlyarEYaPrVmkHZYXCoEXVvPwbzYDbFdhY5C6FACObLW6JESVdJ4Dife7de6AbGjC3WqrgsmEGVQqc8Hdu8Oz1kXLVOPsPELJ9xgLpmGmxTmCAZEoxe7Up8MvfeZLkNoRWfqpdBiNKCHXosxBDmD0IFtv6JFH560NyARGKnt9FhnqWroMTJ6Sr3tQuT7KsAHWEwWrK/wr/z2OTl7+gYWz5k01ra12iUIglpgYh8ygwVz+pDq48533wrdJ/Ok8O5e+D2laqnT1kJdf3JkMa5npoZfsGK8vaXn/6KwyFtBITdGxUm63TezgkXT0kHXo8+IWHCI7TkmxgnQZCMpV3YOM0Bo+OWtJghRtS69ZVf1F1aFbpf04hnFkeUfPM036IH2YL4Q6tzfIS2E0fTLx3laiGJO8UavguYUa7ctP1ZrSxR6x0aTqzDDfcv/It7rixAU2l344XHjJ9rCixyq3bVYLFPYgc0JysuoR5Dyao=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR05MB5431.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(136003)(376002)(396003)(366004)(71200400001)(8676002)(38070700005)(38100700002)(64756008)(66556008)(26005)(4326008)(186003)(8936002)(6512007)(966005)(2616005)(508600001)(44832011)(6486002)(83380400001)(2906002)(6506007)(122000001)(76116006)(36756003)(66476007)(91956017)(66446008)(6916009)(7416002)(54906003)(66946007)(316002)(86362001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWJqcWwxZk0veFhUUnRtcTNodnBHaDM5MDl4OWk1WmNIaFhMVFVoZVA3ZzBJ?=
 =?utf-8?B?QVBCcUdjTm5NajYyMjVqVmUyZ0ZMQ0ZrNER3RmhRL2tRLzFlQndKZFpMZ2dn?=
 =?utf-8?B?Lzhyd0hsNGx2WHBNTjZNZElCQXVDTlBBZjJPOHhxRlZKdlJnbFVwRFArVTJj?=
 =?utf-8?B?d1JzMmkwdEQ4aUYrbVBnUGU3WGJobkpJWjNFTUlNSDIxMzdEMHBqTlBXRkJo?=
 =?utf-8?B?R1JkcGJvazV2Y0xIOTVZRks1dXFnd2JHVEx5dXYyRmxFNC9iT0MvV2J5Ukp0?=
 =?utf-8?B?Y05ab25iWXFuSWlyVytJNHYvR3RKVFVjTmJESDFseDhHVTZuM1hpSllSN0hm?=
 =?utf-8?B?ZmRQRHM3UEZWNzF3b1craEJhSHgvSnBWVG9lRUxNdjc3RENVSm1yb2tlUnBZ?=
 =?utf-8?B?dWI0Zng4bkNaNTdHc0pXZmJsSFVrZEhqMElTcW5JaDhGRGpBVnd5YWVvY3Bz?=
 =?utf-8?B?N2d6bExYN0M2UWpHeTR2SlVyL0tHY3dCUmhodjFBYi9VaDdYUyt3bEl2WHhs?=
 =?utf-8?B?cU9hL25OenpJU1E1QW9tWGdmbWpmZ2RkUlpaUE1FM2U0MXgwWnNvZndMOEtI?=
 =?utf-8?B?djIrODVBdDAvQWlIcHRETVhYM0psT1JsOUpCeXY4eXlZWC9QaUlOTktWT0t3?=
 =?utf-8?B?TFZlalAwQjBTWVQwSzNVZkw3VHZ0ck5FZjZKMmJ5K0FnZlNOMzJTaU8zbTlU?=
 =?utf-8?B?STZ2dldJYWNPalpVazFtV2xWRTJVY3ovZmdvRXJDRnZvOFB1czg5bjJGTnRk?=
 =?utf-8?B?dWFGVzI3SzgvR2c4SUZHdmRRUTNQNThMZXR0UFlaeDZwVG9BYW80TVVBZ0lQ?=
 =?utf-8?B?OW0vdlR3TjdOVU4rMElHZCtHekJxN2RIeFVwSkV5N0VwSXYzWHFKdVQ2RklH?=
 =?utf-8?B?MjFLN2kzaDhvd1YvODlkZmtLVm90S0tKUW1Da3FBWGc1VzBxTm4ybmErMGhM?=
 =?utf-8?B?VXhyN3A1NGh1UWNlU0QxRXhWVTNCcVJTNCt2Z0ZKNnY4RFpYQU5VQ3Ayc2du?=
 =?utf-8?B?K2V2MEZEbGtyQ3M2WGJvSERGclZBN1dwUXRRUGt1dEtvNDRTTk9SejIwcTNJ?=
 =?utf-8?B?eTFQUzA0ZUk5bEtaeFVLa0lIK1p0VVRJSGNwVXYyZE15a0ZEcjQ5WDNBWHJM?=
 =?utf-8?B?S2p4eWIwcHh5aG5FeG9lN25Qd2gxYUJ0YStudnpCUmh6Q1JFQXFSbHdjcjZY?=
 =?utf-8?B?aU8velpjaFNTV0FCRXlPYXRrdC9CcEtkSXJVampZT00ycXZqNUNaVklMNTV0?=
 =?utf-8?B?dityY1d0WEltSXVYN3E2OU5NaTBqL3NDQlhVaFFDU2t3aXlSKzFOa1k0RHZq?=
 =?utf-8?B?cTBXRnRoSnUwU2NnaWFOMTQ3UVdpSXpMUW5BZXJwV0pMdllZR0V0QWpqOGFZ?=
 =?utf-8?B?bjdYcC9lUFVsbnhyVzlLbjl2SGhOd0c2MWVqSkxTWGI0eGc5bDliekVsbk1E?=
 =?utf-8?B?eGgxQVZWTnJzUDdWVVNpWFViZUQ4bWNQcnpFSk9XODRJVUozTk5hdmo1VjZ0?=
 =?utf-8?B?czdpL09icUdWK21tZ1J6OVg3N1ZpVW5INHZLRjArMytWWmwzZERYeTZaZ1E4?=
 =?utf-8?B?WEtvblI2Yys0MTRoZWtBWEdib29VaVhRMmFJcW9XaGgyYlNPRWFmWDlZQjIz?=
 =?utf-8?B?ZC9iWGFJVkplcE5vamJ5aDFJWGtocU43SUpCOVFXa2dCdng4Y1hzdFIzQXBB?=
 =?utf-8?B?eFk0azJ3VjgrR0U5UXA5MDhyMlRkQTg1eFhDVWt2L2FlaVJHb3UvVlFEeDY3?=
 =?utf-8?B?WnFRYUg5dlp5VlBrUzlLekxhRUZuOE9wZTdPZnpYRjBMSklmQk9nK2ZjQU5k?=
 =?utf-8?B?NWhBNzhETUEvRTNWTzYxQT09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF6A84B809A3F1488AC3C9025DCD117B@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR05MB5431.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922f6d9f-71a8-4f0b-5b63-08d97c41a8fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 14:19:29.8546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cxn2dLJgqE1lAwFbiV9tT4Kw1rwe/d9geWceyiJEGVO62fc7BrWmcZLqj/5TniDz0h71xs3mwNnJLGHNis5wibDU6BapRndTYKZ+Q1imG2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB8492
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iDQoNCk9uIE1vbiwgMjAyMS0wOS0yMCBhdCAwNzoyOCAtMDUwMCwgUm9iIEhlcnJpbmcg
d3JvdGU6DQo+IE9uIFN1biwgMTkgU2VwIDIwMjEgMTQ6NTU6MzQgKzAyMDAsIE1hcmNlbCBaaXN3
aWxlciB3cm90ZToNCj4gPiBGcm9tOiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNlbC56aXN3aWxlckB0
b3JhZGV4LmNvbT4NCj4gPiANCj4gPiBTaW1wbGlmeSBhbmQgdW5pZnkgdGhlIGRpc3RpbmN0aW9u
IGJldHdlZW4gbW9kdWxlcyBhbmQgY2FycmllciBib2FyZHMuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRleC5jb20+DQo+ID4g
QWNrZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQo+ID4gUmV2aWV3ZWQtYnk6
IEZhYmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4gPiANCj4gPiAtLS0NCj4gPiAN
Cj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+IC0gQWRkIEZhYmlvJ3MgcmV2aWV3ZWQtYnkuIFRoYW5r
cyENCj4gPiAtIEFkZCBSb2IncyBhY2suIFRoYW5rcyENCj4gPiANCj4gPiBDaGFuZ2VzIGluIHYy
Og0KPiA+IC0gTmV3IHBhdGNoIGNsZWFuaW5nLXVwIGR0LWJpbmRpbmdzIGRvY3VtZW50YXRpb24u
DQo+ID4gDQo+ID4gwqAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWzCoMKgwqDC
oMKgwqDCoMKgwqAgfCA3OSArKysrKysrKysrLS0tLS0tLS0tDQo+ID4gwqAxIGZpbGUgY2hhbmdl
ZCwgNDEgaW5zZXJ0aW9ucygrKSwgMzggZGVsZXRpb25zKC0pDQo+ID4gDQo+IA0KPiBNeSBib3Qg
Zm91bmQgZXJyb3JzIHJ1bm5pbmcgJ21ha2UgRFRfQ0hFQ0tFUl9GTEFHUz0tbSBkdF9iaW5kaW5n
X2NoZWNrJw0KPiBvbiB5b3VyIHBhdGNoIChEVF9DSEVDS0VSX0ZMQUdTIGlzIG5ldyBpbiB2NS4x
Myk6DQo+IA0KPiB5YW1sbGludCB3YXJuaW5ncy9lcnJvcnM6DQo+IC4vRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbDo0NzU6MTExOiBbd2FybmluZ10gbGluZSB0
b28gbG9uZyAoMTEzID4gMTEwIGNoYXJhY3RlcnMpDQo+IChsaW5lLWxlbmd0aCkNCj4gLi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sOjYxMjoxMTE6IFt3YXJu
aW5nXSBsaW5lIHRvbyBsb25nICgxMTMgPiAxMTAgY2hhcmFjdGVycykNCj4gKGxpbmUtbGVuZ3Ro
KQ0KPiANCj4gZHRzY2hlbWEvZHRjIHdhcm5pbmdzL2Vycm9yczoNCj4gDQo+IGRvYyByZWZlcmVu
Y2UgZXJyb3JzIChtYWtlIHJlZmNoZWNrZG9jcyk6DQo+IA0KPiBTZWUgaHR0cHM6Ly9wYXRjaHdv
cmsub3psYWJzLm9yZy9wYXRjaC8xNTI5ODMzDQo+IA0KPiBUaGlzIGNoZWNrIGNhbiBmYWlsIGlm
IHRoZXJlIGFyZSBhbnkgZGVwZW5kZW5jaWVzLiBUaGUgYmFzZSBmb3IgYSBwYXRjaA0KPiBzZXJp
ZXMgaXMgZ2VuZXJhbGx5IHRoZSBtb3N0IHJlY2VudCByYzEuDQo+IA0KPiBJZiB5b3UgYWxyZWFk
eSByYW4gJ21ha2UgZHRfYmluZGluZ19jaGVjaycgYW5kIGRpZG4ndCBzZWUgdGhlIGFib3ZlDQo+
IGVycm9yKHMpLCB0aGVuIG1ha2Ugc3VyZSAneWFtbGxpbnQnIGlzIGluc3RhbGxlZCBhbmQgZHQt
c2NoZW1hIGlzIHVwIHRvDQo+IGRhdGU6DQo+IA0KPiBwaXAzIGluc3RhbGwgZHRzY2hlbWEgLS11
cGdyYWRlDQoNClN0cmFuZ2UsIEkgaGF2ZSBkb25lIGFsbCBvZiB0aGF0IGJ1dCBJIHN0aWxsIGNh
biBub3QgY29udmluY2UgZHRfYmluZGluZ19jaGVjayBvbiBteSBzeXN0ZW0gdG8gc2hvdyBtZSB0
aGF0DQpzYW1lIHlhbWxsaW50IHdhcm5pbmdzL2Vycm9ycyBvbiB0aGF0IGZzbC55YW1sIGZpbGUu
IEhvd2V2ZXIsIGl0IG90aGVyd2lzZSBzZWVtcyB0byB3b3JrIGFzIGl0IHNob3dzIGRvemVucyBv
Zg0Kb3RoZXIgaXNzdWVzIHRocm91Z2hvdXQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzIGJ1dCB0aG9zZSBhcmUgbm90IGZvciBtZSB0byBmaXgsIGF0IGxlYXN0IG5vdCByaWdodA0K
bm93ICg7LXApLg0KDQo+IFBsZWFzZSBjaGVjayBhbmQgcmUtc3VibWl0Lg0KDQpBbnl3YXksIEkg
YWxyZWFkeSBwcmVwYXJlZCBhIFY0IHdpdGggdGhpcyBmaXhlZC4gSnVzdCBhYm91dCB0byBzZW5k
IGl0IG91dC4NCg0KVGhhbmtzLCBhbmQgc29ycnkgYWdhaW4gdGhhdCBJIG1pc3NlZCB0aGlzLg0K
DQpDaGVlcnMNCg0KTWFyY2VsDQo=
