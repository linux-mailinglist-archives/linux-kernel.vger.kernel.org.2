Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBE63FDD52
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244181AbhIANfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:35:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56880 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S242520AbhIANfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:35:50 -0400
X-UUID: 97da787bd9ab48a08dfcfac729353af7-20210901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=s8eianChBOl0tNeanAZCFNSSqNz+AJ1F38ejQ/LieO8=;
        b=T71fK+gx2GLpT/M6b5beH/dCPD5W6I6uvgasCZsj1NTCy5MykvneLz0n2unStYtixu0FiZPx7Oma5mFR1ft4oeeYaXfoZ+gqbqoCkvcKPwzYNFtewFuTjKDW0HXaGbPbSnQ/3ysCV8SA23EV4f+ZUXtACleq1s1BYb92LVSqAmY=;
X-UUID: 97da787bd9ab48a08dfcfac729353af7-20210901
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1008223032; Wed, 01 Sep 2021 21:34:49 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Sep 2021 21:34:48 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 1 Sep 2021 21:34:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IinmNlIyUDuxfAGrvAIVJubFsA3GmkFDNDf0AnqsgA/ztvptR/eM/k2sHcRkloQLl4PKtsDqE1djPuNkzIH5BLlWRyDkWHCtWG+4znaU3+d5GSPT0W9g7/87/sVIzFJ33sYSWAaEGuq2jx7xlsX9KEUhEmIT6nZQSvy8HOtCadws8WJER/fac3XZzB0MF+toLzHpcJdRVy376llZBp4oDcEL5EQ9JpUonhSl/fbHIRj1pKMlBL/7o4ruYuDybH+PzyjEV5+lbndrMhq8iq/4HOPbd/v/LTjKNz4m1WhwfoMaQLksfrL5ofuawIhQmFxwsVTjOMSoh5YxM8LSlnIULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=s8eianChBOl0tNeanAZCFNSSqNz+AJ1F38ejQ/LieO8=;
 b=PypzHr909TH6eYk0SCS24kf7aJrxnfl2UFkDtri3ioW+9fA03Md3toAxwTKud60zkpaxVI+qQnukuJjvy4t0SJ99D/+lyUdX+c6ncfzqk4nE0T4fu+S1+BU+x8uMlsBPIgpLbkwa6ZNyzeo/31PZAjMucaWp77/YMtt3+xN/yfm9rhE1ZStQ+M5PW3Ny4DgnvuCVG8cGiWZlvw4/UfsSeuUr9NCz7jDORqndY8a8HS2ISfSX6+AxOmlBO3vQVYiM3+07y/7RCw4Fvlw0UVIRhZyUWIAYEe1DccG61VtZrqLlBaLyoWfgJv7g4Ce7VUQ0mV7siRqRDqMbOiCkivJP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8eianChBOl0tNeanAZCFNSSqNz+AJ1F38ejQ/LieO8=;
 b=kyNqP5VhWzFn/wQtiskHMivAr0u3m6Y2FFFZ/r7tl0UO99nrvoco7wIqpbXT7PRJya4LZdEP9Y7tHrOt4ojB7omNUKG7A77JMw3nCE9O7x5Xjz66DdzsHW44V5/JwBIMpTXwQQt79MhmlQB/UASb0kxecym7C+nEdbvGHkqupbQ=
Received: from HK0PR03MB3139.apcprd03.prod.outlook.com (2603:1096:203:4b::11)
 by HK0PR03MB3892.apcprd03.prod.outlook.com (2603:1096:203:7c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.14; Wed, 1 Sep
 2021 12:10:40 +0000
Received: from HK0PR03MB3139.apcprd03.prod.outlook.com
 ([fe80::6595:af4e:bda9:801e]) by HK0PR03MB3139.apcprd03.prod.outlook.com
 ([fe80::6595:af4e:bda9:801e%6]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 12:10:40 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "hsinyi@chromium.org" <hsinyi@chromium.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        =?utf-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "tfiga@google.com" <tfiga@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?utf-8?B?Q2hhbyBIYW8gKOmDnei2hSk=?= <Chao.Hao@mediatek.com>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v2 11/29] iommu/mediatek: Always pm_runtime_get while tlb
 flush
Thread-Topic: [PATCH v2 11/29] iommu/mediatek: Always pm_runtime_get while tlb
 flush
Thread-Index: AQHXkBCJOXgjCO+qmEuZNYVz7PKI+auCTgcAgAzmkAA=
Date:   Wed, 1 Sep 2021 12:10:39 +0000
Message-ID: <e3d8139174e659c07a606122d4a5402ee5e8adca.camel@mediatek.com>
References: <20210813065324.29220-1-yong.wu@mediatek.com>
         <20210813065324.29220-12-yong.wu@mediatek.com>
         <CAJMQK-hkufqh2vaEKcuO+k0v2SzpCHcyZuEqrvJ__rrAek2P0A@mail.gmail.com>
In-Reply-To: <CAJMQK-hkufqh2vaEKcuO+k0v2SzpCHcyZuEqrvJ__rrAek2P0A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4730a67-5538-4913-a6a7-08d96d4183c6
x-ms-traffictypediagnostic: HK0PR03MB3892:
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR03MB3892C3DEFC6E2C4211A1693198CD9@HK0PR03MB3892.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PH0rX98zsjN+Pi7PdQYlnWg/PJnaZCreQpscloZS/YujdCptzfy+4tBWAq+FFIne9IzrZa7wdzuyKdWfkxkX/EZ8AcFok6rNki5R8LCPyw58W0TIXfp8eXneoYIbTSK5TFlJ+dYYND96SzcYS6j8EhvNBEiBMog45PskkCHRJLfNDoPfcryyenWOWSQPt4IGXV076tMtZAPmnL2dnVkmtgZIgFNLe22xAeJ+eO9+JRLOSmdDTOHRz269MZhaBR8dg8PCNucwQhCcKx7M1A+Wzjt9RSLZRHDP8xVjjYNtvw0KKptNoZGiZRccsrkqJ4pIFUJRNC9XsX8pBEmZSInkj85Uh99T7IzNAbUJYoGpbnqR8YqT5xBX6Rjm1U4je75Tmc2lhrfcidy9a/Vlkt1Oxtmub89bNvzGYDs4YGbaEiBDq/PLsMlrItQe1wzCbrAJuo+g/PZRYqnvAK2v//CL4mfcOGxYhQdwhTDs1fK19sviGUqW9yUhDlarYM29R4+uPIxLMYO5qCDtdQ1PPz3pgwUCTyrFVHLhMcKas3sZn7d2vzu7xkHYj+kTiBlX/RaVBTMQwVwDWb0bTwhpdeZ3hcUd5KBNuJgY4vd4nAFipDqsleDHkdi7kwTEKAfoTSr0jOKYbvh/85b2D7zUH3Tf3JRQNWKHrd7JOVVUj+KxyFHhGlVDpwenuXKgJNAn/rZ8/U363ri58lB/ElVt/pHvRTFVRrGSZXxaEWa2naI58Qk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB3139.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(366004)(376002)(39840400004)(38100700002)(6512007)(6486002)(122000001)(8936002)(186003)(2616005)(8676002)(5660300002)(86362001)(53546011)(54906003)(6506007)(36756003)(38070700005)(316002)(85182001)(66946007)(478600001)(71200400001)(2906002)(4326008)(7416002)(66476007)(66446008)(64756008)(66556008)(76116006)(91956017)(6916009)(83380400001)(26005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1I3My9aOGsrL054MXEvZkhBa3dPM2RGdFlmU2VtNnBKb3ozNWVERThENjZJ?=
 =?utf-8?B?Ni9mU1VwRVFHMUgzS1ErZ3QxVnZ2dmVIc3hCYjlMTmk5VzBMR3VJTUM1MjBa?=
 =?utf-8?B?K3RDTk5ZT1NZc1lvQ2hiRWZGQmtHR2xDQmt0UUdUMGVPVStJTHB1Q1FRMXIw?=
 =?utf-8?B?bFA5ZXRLaDZiOWNlWXkzZmxNWm10QjA5eHBFdm12UnZyMHMzTWtUTkVlMUNR?=
 =?utf-8?B?K001OTVvTEJ1K3JlWDkzQ0NVZ2IwaVptWTJ6dkxXL1dUS003bHZsT1lQbTZQ?=
 =?utf-8?B?V0J4OGw5RXFMMklHZkhidUZXdEJTSTA2ZUFYSmtmVXBnR2F4dXZ6cFJuTEdk?=
 =?utf-8?B?bEFweHljZ09sWHVYSEtLOTNzVkwwaGV4RGRGSURCTUdrdU1IUkZqUW0rSk1t?=
 =?utf-8?B?SEtHZ0JnKzBKSzJqWjFDN2dUTlZaU08zWDdadVoxKzJOWjlvek0wSUwxVlBF?=
 =?utf-8?B?MXIyUWM4VXBINFdWV3NMODdjendDUHFCdTFWNmlMKzZyUEQ1dU16U29oM1NJ?=
 =?utf-8?B?UXFTSHAyUXZQVXd6dnNwMis1YVNnNmhrM04xaHpFZVNacWp6VGdHZ1FPaDhn?=
 =?utf-8?B?SFNtOGlZWWhuc0hWM3haZGN3OWU0OWp1OVFVbDNVM2VuUlJkSWw0NnpQR2Fm?=
 =?utf-8?B?VHVKNVlVajBpN0h0SEFGb2NsQllFV0lBVEpLc2RvbDhldE5sNG1LOG13T1h5?=
 =?utf-8?B?S3BEQmNsdHZiT3R2SEVLRGJObzlVZHZJM0pjS2xEYk1BN3orU0JNM0p3cjFU?=
 =?utf-8?B?MS9UWTBaaTRNSWJQOGhKZ2M4MU1MNHhNM0srZ3VObzdCQTZmai9HU1NlbGtI?=
 =?utf-8?B?V1c4bStQVWVlcFVPbVFnbjJYUUZMQXd3c3FYNGRkWThDVC9oWFZMWndiTUJ1?=
 =?utf-8?B?T200ZGZZRUZ5cFRNQ2MwYmZ3ZWVwQWJ2UUJvNUc3K2tMNUdDS3lxK05MSUF1?=
 =?utf-8?B?R2JNSXJNUW40eTltRWFPRjZNT3Z1ck9jTEs5V3dYajZ2R0h1eEF0aFpwSlM3?=
 =?utf-8?B?V0dkcTdDV05UL2k0eG9NSS9CbFhrMGVEZFBSR3loMDZMUkxUYTJ1bmdFUkhO?=
 =?utf-8?B?WTlrc2ovU3FwL2xlUmpDTXlJOHZjMGlldzl1bHZnUkxjeDMzVDdvZTMwaHBs?=
 =?utf-8?B?YU9uSlJJQWdzQWtnM3o1bkZGdW1tYUFIcFd4dDNTaDZ3akFCUDE0ZHgrUEJZ?=
 =?utf-8?B?L25FbmNtSW13R3pBODAzQjJtSEVJQ2lJQ1JlRjM2eG5vZVh6SmZNMHdwUnZC?=
 =?utf-8?B?RHZUTXpkVlZiNmthdWhJK0ZQQ2R4UlBrN3hPN0dEamtQOFRRcUw5U3ZhSjJN?=
 =?utf-8?B?OENOeW1GTjBmdFZmeFBiK05KYmhSbkd0U09CWStIMEhzaFlBN3VxVy82akV0?=
 =?utf-8?B?YUFGSjNISW9MOWR3T21NNHo3TVNYWG1MVUVzNFROMlJSRk84TjFkc05wWXFk?=
 =?utf-8?B?MHRTTmppd1M3c3YzaFVuVzU3bmVXUWF3aEhhc21JN0ZjalZ1WUluU1VlOVY1?=
 =?utf-8?B?Y3l5ZmNnZWJhRURZZDRMcEl4d1RYRmpmcnpDSVFNSk5seUFhY3BHL3hYRFpU?=
 =?utf-8?B?bktMeGREcXVLWVViMTlHWEZha1FhMms3dFlZdXp0OHdTcjl1TWV3UzV5SXNJ?=
 =?utf-8?B?T3pkYlZhem1OekNBVkRjSk1FTzlQcElHT3lHbDZxekIyMmxtL3RFeGplWU5y?=
 =?utf-8?B?TmtPaGtkSTlFd1BZTTFadEs1UDM5UkFaVnB3N3VFZmFnSE9TMnlIQzUxbTRi?=
 =?utf-8?Q?8sNKWS5QYqE7TFbfWtNV+JPNW36FBvPSEKvgtG7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76A6BDE1AF302C4498A0BD862B70BA52@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB3139.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4730a67-5538-4913-a6a7-08d96d4183c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2021 12:10:39.5344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R6MEKiIJsf+3CmBQlZgtxzZOQDeIXdjJF7m4Swxj1DzZ4XNUYq+X4dA+Ty4aCXoB0QvUNejFOvdUIZ5OWaa0yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR03MB3892
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTI0IGF0IDE1OjEwICswODAwLCBIc2luLVlpIFdhbmcgd3JvdGU6DQo+
IE9uIEZyaSwgQXVnIDEzLCAyMDIxIGF0IDI6NTcgUE0gWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRl
ay5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IFByZXBhcmUgZm9yIDIgSFdzIHRoYXQgc2hhcmluZyBw
Z3RhYmxlIGluIGRpZmZlcmVudCBwb3dlci1kb21haW5zLg0KPiA+IA0KPiA+IFRoZSBwcmV2aW91
cyBTb0MgZG9uJ3QgaGF2ZSBQTS4gT25seSBtdDgxOTIgaGFzIHBvd2VyLWRvbWFpbiwNCj4gPiBh
bmQgaXQgaXMgZGlzcGxheSdzIHBvd2VyLWRvbWFpbiB3aGljaCBuZWFybHkgYWx3YXlzIGlzIGVu
YWJsZWQuDQo+ID4gDQo+ID4gV2hlbiB0aGVyZSBhcmUgMiBNNFUgSFdzLCBpdCBtYXkgaGFzIHBy
b2JsZW0uDQo+ID4gSW4gdGhpcyBmdW5jdGlvbiwgd2UgZ2V0IHRoZSBwbV9zdGF0dXMgdmlhIHRo
ZSBtNHUgZGV2LCBidXQgaXQNCj4gPiBkb24ndA0KPiA+IHJlZmxlY3QgdGhlIHJlYWwgcG93ZXIt
ZG9tYWluIHN0YXR1cyBvZiB0aGUgSFcgc2luY2UgdGhlcmUgbWF5IGJlDQo+ID4gb3RoZXINCj4g
PiBIVyBhbHNvIHVzZSB0aGF0IHBvd2VyLWRvbWFpbi4NCj4gPiANCj4gPiBDdXJyZW50bHkgd2Ug
Y291bGQgbm90IGdldCB0aGUgcmVhbCBwb3dlci1kb21haW4gc3RhdHVzLCB0aHVzDQo+ID4gYWx3
YXlzDQo+ID4gcG1fcnVudGltZV9nZXQgaGVyZS4NCj4gPiANCj4gPiBQcmVwYXJlIGZvciBtdDgx
OTUsIHRodXMsIG5vIG5lZWQgZml4IHRhZ3MgaGVyZS4NCj4gPiANCj4gPiBUaGlzIHBhdGNoIG1h
eSBkcm9wIHRoZSBwZXJmb3JtYW5jZSwgd2UgZXhwZWN0IHRoZSB1c2VyIGNvdWxkDQo+ID4gcG1f
cnVudGltZV9nZXRfc3luYyBiZWZvcmUgZG1hX2FsbG9jX2F0dHJzIHdoaWNoIG5lZWQgdGxiIG9w
cy4NCj4gDQo+IENhbiB5b3UgY2hlY2sgaWYgdGhlcmUgYXJlIGV4aXN0aW5nIHVzZXJzIHRoYXQg
bmVlZCB0byBhZGQgdGhpcw0KPiBjaGFuZ2U/DQoNClRoZSBpc3N1ZSBtYXkgZXhpc3QgaW4gb3Vy
IG1vc3QgdXNlcnMuIE91ciB1c2VycyBtYWlubHkgYXJlIGluIHY0bDIuDQpub3JtYWxseSB0aGVp
ciBmbG93IGxpa2UgdGhpczoNCmEpIFZJRElPQ19SRVFCVUZTOiBjYWxsIGRtYV9hbGxvY19hdHRy
cyBvciBkbWFfYnVmX21hcF9hdHRhY2htZW50Lg0KYikgVklESU9DX1NUUkVBTU9OLiANCmMpIFZJ
RElPQ19RQlVGOiBkZXZpY2VfcnVuOiBwbV9ydW50aW1lX2dldF9zeW5jLg0KDQpSZXF1ZXN0aW5n
IHRoZXkgY2FsbCBwbV9ydW50aW1lX2dldCBiZWZvcmUgZG1hX2FsbG9jX2F0dHJzIGxvb2tzIG5v
dA0KcmVhc29uYWJsZS4gSXQgc2VlbXMgdGhhdCB0aGV5IHNob3VsZCBub3QgY2FyZSBhYm91dCB0
aGlzLg0KDQpUaGlzIHBhdGNoIG1haW5seSBtYWtlIHN1cmUgdGhlIGZsb3cgaXMgcmlnaHQuIExv
Y2FsbHkgSSBoYXZlIGEgVE9ETyB0bw0KdHJ5IGdldCB0aGUgcmVhbCBwb3dlci1kb21haW4gc3Rh
dHVzIGhlcmUsIHRoZSBzYW1wbGUgY29kZSBsaWtlIGJlbG93Og0KDQpzdGF0aWMgc3RydWN0IG5v
dGlmaWVyX2Jsb2NrIG10a19wZW5wZF9ub3RpZmllcjsNCg0KLyogUmVnaXN0ZXIgdGhlIGdlbnBk
IG5vdGlmaWVyLiAqLw0KbXRrX3BlbnBkX25vdGlmaWVyLm5vdGlmaWVyX2NhbGwgPSBtdGtfaW9t
bXVfcGRfY2FsbGJhY2s7DQpyZXQgPSBkZXZfcG1fZ2VucGRfYWRkX25vdGlmaWVyKGRldiwgJm10
a19wZW5wZF9ub3RpZmllcik7DQoNCi8qIFRoZW4gZ2V0IHRoZSByZWFsIHBvd2VyIGRvbWFpbiBz
dGF0dXMgaW4gdGhlIG5vdGlmaWVyICovDQogc3RhdGljIGludCBtdGtfaW9tbXVfcGRfY2FsbGJh
Y2soc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYiwNCiAgICAgICAgICAgICAgICAgICAgICAgIHVu
c2lnbmVkIGxvbmcgZmxhZ3MsIHZvaWQgKmRhdGEpIA0KIHsNCiAgICAgICBpZiAoZmxhZ3MgPT0g
R0VOUERfTk9USUZZX09OKQ0KICAgICAgICAgICAvKiB0aGUgcmVhbCBwb3dlciBkb21haW4gaXMg
cG93ZXIgb24gKi8NCiAgICAgICBlbHNlIGlmIChmbGFncyA9PSBHRU5QRF9OT1RJRllfUFJFX09G
RikNCiAgICAgICAgICAgLyogdGhlIHJlYWwgcG93ZXIgZG9tYWluIGFyZSBnb2luZyB0byBwb3dl
ciBvZmYuIFRha2UgaXQgYXMNCnBvd2VyIG9mZi4NCiAgICAgICAgICAgICogU2tpcCB0aGUgdGxi
IG9wcyBhZnRlciByZWNlaXZpY2UgdGhpcyBmbGFnLg0KICAgICAgICAgICAgKi8NCiB9DQogDQog
SG93IGFib3V0IHRoaXM/IG9yIGFueSBvdGhlciBzdWdnZXN0aW9uIHRvIGdldCB0aGUgcmVhbCBw
b3dlci1kb21haW4NCnJhdGhlciB0aGFuIHRoZSBpb21tdSBkZXZpY2UncyBwb3dlciBkb21haW4g
c3RhdHVzLg0KIFRoYW5rcy4NCg0KPiANCj4gDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogWW9u
ZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+IA0KPiA8c25pcD4NCg==
