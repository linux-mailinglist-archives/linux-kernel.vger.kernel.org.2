Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11533E8B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhHKIN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:13:27 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:49512 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230474AbhHKINZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:13:25 -0400
X-UUID: d16b863157844a09abdf71d20561b706-20210811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fP6mhnWzbxmGH4jRMR3vk3dW3qBpPE9JsE1/WkImSHY=;
        b=cofj+JZLkygPPvWp9GtrXQnqH3VtTtRxsyRq5zNlKdVkTuj3jgVBCjQov5mjXPCziRCzVKMbnqq74X7FcvON4Bhdrfa5E/JcsPRUk7Nyg8VQHWOE6Ocey2fi2GptKNKWA4XyGOmV79pZDRugEQRQ4qFyIuG3IEWpFujSe43CSAs=;
X-UUID: d16b863157844a09abdf71d20561b706-20210811
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1238846071; Wed, 11 Aug 2021 16:13:00 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkexhb02.mediatek.inc (172.21.101.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Aug 2021 16:12:58 +0800
Received: from APC01-HK2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 11 Aug 2021 16:12:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXkHO0d/cjQm3hubkPZ76/kSgjUctQQoNvzgzVKSMngea3s9ialNRejLaKlYwF4kHcoCqRAlARrUOPTg7PsUwpFU1Q0E3FgZVHVJbuaPm+yU0hj4yzFENI9ZhZ68QcbJ4G6sRN44H6HZBW11lpH1GxyBO/gNsx7GJ5stBHjdnCzPGMHQ2yoKDMX1c5FFcxaQzgiOeUFhzDYXpvzk/FAjdlrWfYocyjw0hUilCChdCwf6oxs87VPvCmoYcJrkY/hY1WB64RB5OUI6vvM+Jk8mdOC7OvXeHfzgpuXcuv2ttwvqJ8J3QiFxZk7Nbscbz4E+iBzMjCfEiWm3bLPOO82lZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fP6mhnWzbxmGH4jRMR3vk3dW3qBpPE9JsE1/WkImSHY=;
 b=ewCUUGqY5vYTFqbdsNMRQYMTEirS2yo+SG7WrYcB3IsU2Z4ACytu1R9y6/n+qD2hxLJzrb8ioGiEJnpsLqQ8h3M1+IS8N46GDyj4pCXs11mUdQYNubhOrbqU7bXKZOibPnDkCafbG6xelFSCY388VNNemiq1JXDWnOjmQLCeFRRePbX2L2+azyj2d9/v5ZuLFlBcsWskQwShDEcnkEFNUrEW5DGeGOcZTXlHCegKSl/ftv8dLE/Z6zDLXaQi/uX3wEtciYlGSiEvSmPAZsRyDXGOoSZGumOJXBcwmgfpnsCfQ8r3idJkl9L/JlpyBErsALGgo4cWwb2dkaTCkIllgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fP6mhnWzbxmGH4jRMR3vk3dW3qBpPE9JsE1/WkImSHY=;
 b=NtnLSKVaxXlMGJsx4PhAd2cMAxNqdcWGZISwqNpE1xTeF38veEvP6mUrBHTvtC0/Wx9or363OCBQGmAWi36v0MrjbxSqJWAAoq4qfBzJUQaPh70QKYBHladbc8+x/Gzp7DXHpEfgofQmvfbHY4GC0vhFtXRkBQV1ILCEC2GVDS0=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR03MB5126.apcprd03.prod.outlook.com (2603:1096:820:16::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.7; Wed, 11 Aug
 2021 08:12:46 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608%7]) with mapi id 15.20.4415.015; Wed, 11 Aug 2021
 08:12:46 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 02/11] dt-bindings: usb: mtk-xhci: add optional property
 to disable usb2 ports
Thread-Topic: [PATCH 02/11] dt-bindings: usb: mtk-xhci: add optional property
 to disable usb2 ports
Thread-Index: AQHXhR/4TrVKyvGHK06O5ZvJnpkukatm/IYAgAcKjwA=
Date:   Wed, 11 Aug 2021 08:12:46 +0000
Message-ID: <f311317b53a548d230b8688c675dc95f77c4de6c.camel@mediatek.com>
References: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
         <1627635002-24521-2-git-send-email-chunfeng.yun@mediatek.com>
         <YQ2eZkqb++K3K5NN@robh.at.kernel.org>
In-Reply-To: <YQ2eZkqb++K3K5NN@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6218b526-6026-4c6f-0ee3-08d95c9fcd8f
x-ms-traffictypediagnostic: KL1PR03MB5126:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KL1PR03MB51267AA529348E6BD42E0FD8FDF89@KL1PR03MB5126.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: War0EYN650qk6WxmD+1PgNcjrCmP5iaWS+wPd4E20VQ+cPzL+C0rUYmxPjnF36aDlX5YN5ZSUYqV7UvbEFNEwGvTRVsFIY3V+ubN0Rp1QWXOKAM/5Ee9Nqn/XgUKYuKHBHEGZv8UvTxxChVYiciEPpHtTFevB41M5VYDOwokXYsAfgPoCap68gR3T3lvLDEMS1ckDB7dWnCG994v6d7SX6pmafla4H8AOxH+1wmU+oX2kOXrO4IxM4KJfxfWVnzo15eYyYhBMna1TcGOyNPDUVtPk9T040dG0yvVsBD2vYrb2pHAaQm0GrqaJNKTWjx1WiszZg0KMoJZdyzid7xKT10tHcicS6JjzhflvQi427Ult1or509bQbmiyJLxi3vHMxgrv0oGV0YZGiq96JJqBObRD3dtwukle4owSkSIO26/Nlsb2kcERp/ftW02NrGa1V9OSEerSYEz6bAPuypCX7oBsEH0nYmN600RgqBsDvRrUmH42Mu3hYrtVFMMcX7DA9ts5zztwnUo38+PHjJGLQ3MISu2TophDy8b2m877OAeX2W02gO4PPBnoZqgIogQ3nOWRXMfGYHEt/FOqv+fZe8LRYMR+N4jP89vKEd2RHq5hskF83FAiNQ/374SlgmdeBEdwu6JMYNvE9Euvj7VFV+znRnHTTNKI2WoXoIPtpp9ffA0j9+9gWBB6FzK3ugTzDjn1TPmrgCC0kDCQJcHOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(66446008)(5660300002)(36756003)(71200400001)(86362001)(38100700002)(83380400001)(38070700005)(122000001)(8936002)(91956017)(66946007)(66476007)(2906002)(6916009)(66556008)(6506007)(186003)(6512007)(2616005)(64756008)(4326008)(26005)(498600001)(85182001)(76116006)(8676002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y1lsU2FFWEFiSVdnbEZZeWtvdExEeHdveXJSMEIyWkVsZlo1d2M0ZjBEMkw5?=
 =?utf-8?B?MEp2ZzhxVGtycC9lMlhUNjRyZlVXVFp3ekwzd1cyc1dXR25oNkVWNDZXVzRx?=
 =?utf-8?B?aWhoRzg5aGd1eXpDbXBTSWQvRXlYcE9TaFhqTmphTXhwSWVTUFZSa1NqMDVx?=
 =?utf-8?B?bmVJdjR5cXN4ZTR2dTBTcmxpUU5CbWd3MTZRWGFMUWM3V1JRMG44VUNuS29w?=
 =?utf-8?B?K1VFeUtpc0ZRR1hqV3lpZEkxVHhRQThYZ2xJYzBVU3I0SE5TbFhxajdRblZG?=
 =?utf-8?B?dTMydTMwOWNuUkQveGtQL2hVc2R0MHdHRWdyMmtxV01WRnhMYWM4ZkhlZlhv?=
 =?utf-8?B?NWdUZnFLUEFiNExJcnpTNHFvTHRrWW5DblAvWGk5NlpQcTJHSjRXY0IrOHNi?=
 =?utf-8?B?MDVzOVRMbk5menBKWGxMMmdSNW5GMkI0MXRTTFovNTdaVHRHTGlqbjR0S0V3?=
 =?utf-8?B?amJNV1JJUUx5NUhDeFFaYSt0RzUvOWZ5VU9EQ2ViQ2dMNGE1WWVMTldkNzQw?=
 =?utf-8?B?VnNERXQwT0NIeUV3bEd5NU91Z3o4bnpjSnc1VG1STE9GZStLcWlIZGhTT1FR?=
 =?utf-8?B?YVh3SFQxeCtMZWNxbXIvRXJmSzZqbi9XNVVHVHpBc1NqSmJ1d1ZTYk5EWVMy?=
 =?utf-8?B?UHN1SmpHVWd4NDd2UUVuRTFyUlkweml2bGhIYlFpVmJVOWFRdmd3QjNQaFYx?=
 =?utf-8?B?Q2VCcHAzTFJaaFVaSTJ5clRFcENVM2xXSFVjZ1JwZmFjWlpnR0doVTU0cjd2?=
 =?utf-8?B?RWlqZG9XaXdscytxV2xGT3JDV0NwaWF0TEhOb3BvY2dRYVdSNldzWnBLYWJN?=
 =?utf-8?B?STdJRXFMbjNXaU9tL0J3dnlrcVhhL0ZjcG8rdEZiRlNoYmxXRkxWRTZjVGJG?=
 =?utf-8?B?dExkeXdPSkt2eUxLb0FmdEFMcUdIakEzRzFkajJWYVRLRVBFR0twRVFISWpF?=
 =?utf-8?B?VDRDNmpYeTJXY0d2azRwT00vcVk4b1ZteStzbXN5L2FPOEVLQ0FmVkd5dFpp?=
 =?utf-8?B?cy9BeHRQL2s5N3R6TGg1amNMVUpZMVQyR0hpZ3lnbVJUWXgvM3h6Wk9Ec28v?=
 =?utf-8?B?OHMvdmM4YnUrNWpUQUV3cm5FbjlpdGxHWk4ycnQ3U0pTYjBYOGN5MlYyU0pv?=
 =?utf-8?B?Y1lGS2dRT1hjNzM4SC9oTGJ0aWtxaTVGd0xpRnFFTm9USXYrdzBaMzcwb1pI?=
 =?utf-8?B?eWJjZFEvdE92dlg2UlN0RmJTRTZwVkM0ZTZIWWJzUUh3Vi9vWkwrTk1SWEZm?=
 =?utf-8?B?VUl6L2FNbnE5RkU0c0ZJRVk4VnhWaFY0Qkw1L1RNbHNuY2hSblM3c2NrWldm?=
 =?utf-8?B?dWhjOUZBVGRuNy9zdmR4MFJ1ZXlERm5WSkxKdjlmaHpWVCtzQVg2dmxDeFNV?=
 =?utf-8?B?VGtlc29WUHlUejJBL0RVVjU2bjBPMGRoUG9NTHphYTZBYkpjbmIzWk5uMHd5?=
 =?utf-8?B?d24rbnNxd2VKSllJaU00cEpIdEw5N05POWttUzZCek1DNmVKVUxzdWVJaEYx?=
 =?utf-8?B?SHlvMFBjNFpIb1JhVnBTa2pBd09vendzOVB6VzhCcVNGMFBMS1A5UytsanNU?=
 =?utf-8?B?bHJ6Zzl0WUs2TFhubkJBeHRZNXRBbTJzeC9VMkdYc0NiMi95RzJsV3VYVWdJ?=
 =?utf-8?B?c01nZEtUTTR6VnU1UUNtL3g2QjdBbEVabElhVzNKa1dLc1NJTEc1S3NVREU3?=
 =?utf-8?B?TUZZc0o2bGc1L3Vrayt6UHFMam1ZczVybkF3Z0Y0Y09yZElMWmVLVTRWNTlr?=
 =?utf-8?Q?UIlxn/zSd2ec9pfLuL71U52XtqKjEIvgumLIxih?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A497460A51626E44B92DCDBA0ED6CB7A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6218b526-6026-4c6f-0ee3-08d95c9fcd8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 08:12:46.7106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IlheBkxtKrEd9/JP1bXfPek10Tal7aO5pc701JJxUO0E6ESlwPwYUmP+vubBRauCnl1Jcmk7/+mDjNVd2fiM1Xovdo2L90srZHRb8RXvVZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA4LTA2IGF0IDE0OjQxIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gRnJpLCBKdWwgMzAsIDIwMjEgYXQgMDQ6NDk6NTNQTSArMDgwMCwgQ2h1bmZlbmcgWXVuIHdy
b3RlOg0KPiA+IEFkZCBzdXBwb3J0IHRvIGRpc2FibGUgc3BlY2lmaWMgdXNiMiBob3N0IHBvcnRz
LCBpdCdzIHVzZWZ1bCB3aGVuDQo+ID4gYSB1c2IyIHBvcnQgaXMgZGlzYWJsZWQgb24gc29tZSBw
bGF0Zm9ybXMsIGJ1dCBlbmFibGVkIG9uIG90aGVycw0KPiA+IGZvcg0KPiA+IHRoZSBzYW1lIFNv
QywgYW5vdGhlciBjYXNlIGlzIHRoYXQgdGhlIGRpZmZlcmVudCBwYWNrYWdlIG1heQ0KPiA+IHN1
cHBvcnQNCj4gPiBkaWZmZXJlbnQgbnVtYmVyIG9mIHBvcnRzLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGst
eGhjaS55YW1sIHwgNQ0KPiA+ICsrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3VzYi9tZWRpYXRlayxtdGstDQo+ID4geGhjaS55YW1sIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGstDQo+ID4geGhjaS55YW1sDQo+ID4g
aW5kZXggNDk3MjlhYWI2ZDFhLi42MWEwZTU1MGI1ZDYgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGsteGhjaS55YW1sDQo+
ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxt
dGsteGhjaS55YW1sDQo+ID4gQEAgLTE1NCw2ICsxNTQsMTEgQEAgcHJvcGVydGllczoNCj4gPiAg
ICAgIGRlc2NyaXB0aW9uOiBUaGUgbWFzayB0byBkaXNhYmxlIHUzcG9ydHMsIGJpdDAgZm9yIHUz
cG9ydDAsDQo+ID4gICAgICAgIGJpdDEgZm9yIHUzcG9ydDEsIC4uLiBldGMNCj4gPiAgDQo+ID4g
KyAgbWVkaWF0ZWssdTJwLWRpcy1tc2s6DQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55
YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgIGRlc2NyaXB0aW9uOiBUaGUgbWFzayB0
byBkaXNhYmxlIHUycG9ydHMsIGJpdDAgZm9yIHUycG9ydDAsDQo+ID4gKyAgICAgIGJpdDEgZm9y
IHUycG9ydDEsIC4uLiBldGMNCj4gDQo+IFlvdSBhbHJlYWR5IGhhdmUgdGhpcyBwcm9wZXJ0eSBp
biB0aGUgcGFyZW50IG5vZGUsIHJpZ2h0PyBXaHkgYXJlIHdlIA0KPiBkdXBsaWNhdGluZyBpdCBp
biBib3RoIHBsYWNlcz8NClNvbWUgU29DIG1heSBvbmx5IHN1cHBvcnQgeEhDSSBjb250cm9sbGVy
LCB0aGVuIG9ubHkgdXNlIG10ay14aGNpIG5vZGUNCndpdGhvdXQgcGFyZW50IG10dTMgbm9kZSB3
aGljaCBpcyB1c2VkIGZvciBkdWFsLXJvbGUgY29udHJvbGxlci4NCml0J3MgbWFpbmx5IGZvciBi
YWNrd2FyZCBjb21wYXRpYmxlLg0KDQpUaGFua3MgYSBsb3QNCg0KPiANCj4gUm9iDQo=
