Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3843F18A4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238973AbhHSL54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:57:56 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60604 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238314AbhHSL5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:57:51 -0400
X-UUID: 971861ee941c4a3394c160e9f4081ead-20210819
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ue/k+0id/te0WPYkv0YShr4pfybb1nGffGsi+qMgol4=;
        b=gH0Hb6aqQqbpwIXzgU7LcCV80rNOgsaBx+xY0sYyoBW8d4uLzd87Ga75Vh8COleMTHfdoAgjol5iAnRI7wIQCa9d9KVPYG6Sop+rK99Ra+oV9NbZvK299QviYm6hLdd5a2TkCjIND+HJdzzLRrExIvF+O3LZ+lgVONK+P59Zy68=;
X-UUID: 971861ee941c4a3394c160e9f4081ead-20210819
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 812140564; Thu, 19 Aug 2021 19:57:13 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 19 Aug 2021 19:57:12 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 19 Aug 2021 19:57:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+tq3HyLZsNKOblXO1S50lVWbs8xQvjJd6jdDZ/FqDkAGpR34Et+e5SlvPClDJVxH0GWPnj3RS5La7CUAlkQ7eSvI2AuAhSviQyr00vDamamvM1iIigfMRdd/fypiPX0Izwdup9adBZ01PpHPfDaGYIqrKyF++Fhy3YC6ULKSEqQnCeGaH3qZILwM/rxjHd5LL+a/24SWJ2jJB8W5DQTML/SaP7phRe6H2GhFBWINXVLpkANHKrri/dv6PWehq4LTWWkSrfrlld4FrSBF+HlL6u3yKiAL7O5n5JrscqhQFl7AZockE44wsjCsLYI/diM1MBhNvZ/0NcLiJItFDHaog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ue/k+0id/te0WPYkv0YShr4pfybb1nGffGsi+qMgol4=;
 b=JyQZjc2NM+A03r7OUPxT6x0XGWrymK1KDYmBCp9TxH7ZdZRYnBvkN1CTcC+G/JJ7HT/cmcGK+wFwZgf8Rt5jzlumJXDhh5/BwxfdlDAN8nmwjA/EfheI0otEBAk7Bb2CVQclsURtgnk6tF9hkTLC/okHXcFVhcp7i+HoivOvdoSthpXDubzdZMNi06P2cTx6qo3zX/kr/Us6q0ZHQjRKJUNwXMGE6rV7iD6cjGRcO5vVk/cAcKNizDrsXijbqbi8UrSAdDz8al/63BtpTBVbYyEMyHovWHhEVioi2GyM62rYc0UwHRTSNRMnZKJN30Pn16oQ6Ccuhecmt+xn6rlT/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ue/k+0id/te0WPYkv0YShr4pfybb1nGffGsi+qMgol4=;
 b=AGCWCm5bdkxxf8UpvkeSHoBHyqtFSRR2t7FAakV/pNn3KRSdMbuwRgXO90fRXXkfsPJqr2/BfpILdd1E5mn3B7WiGPEscoL4lImWEtEMLit2KLwGB7Q917v2iqk05T4unMZYYHpj9HFvSB90tB9fDO7JtTolcXlyVFk535NIQbo=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR0302MB5298.apcprd03.prod.outlook.com (2603:1096:820:4d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.15; Thu, 19 Aug
 2021 11:56:59 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608%7]) with mapi id 15.20.4436.018; Thu, 19 Aug 2021
 11:56:59 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "ikjn@chromium.org" <ikjn@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH] usb: xhci-mtk: Do not use xhci's virt_dev in
 drop_endpoint
Thread-Topic: [PATCH] usb: xhci-mtk: Do not use xhci's virt_dev in
 drop_endpoint
Thread-Index: AQHXibwxcFIct+uqAkm4YZOXlp9NAKt6zyiA
Date:   Thu, 19 Aug 2021 11:56:59 +0000
Message-ID: <2593ac262cdf0088e937b9fbc907bb23a6736fb5.camel@mediatek.com>
References: <20210805133731.1.Icc0f080e75b1312692d4c7c7d25e7df9fe1a05c2@changeid>
In-Reply-To: <20210805133731.1.Icc0f080e75b1312692d4c7c7d25e7df9fe1a05c2@changeid>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88c306bf-1285-4686-cd49-08d96308734c
x-ms-traffictypediagnostic: KL1PR0302MB5298:
x-microsoft-antispam-prvs: <KL1PR0302MB529829E23B3DA9B133EA760FFDC09@KL1PR0302MB5298.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CtI1woC7dEX+uMLoPfJ5yRBT/EI4HxPBnnAuzh1RjGixtBll1sEtBdgfPpNJhAhJv02Kb5rsaCPeRekRy3Ll/aw/R7zXaGbpF7wTowfANZOfvFsz8/Xv+x3g+KQOvetcpt7hVqeCyIEWZF22/gwjJ3SPEc9nNiLsDjlHzifqt+V4oxW2yIF3CDW21ofqlS21FepgJDN0G7aM30vKXG9z0fSDVoHenZcI4//QtJB4dh/57CGAs9GlFo9/kb9T8MlsjO+hVxKiqXCAsO4pfZKeC8Wgg6UrO7BqBs6t7aUXgFia6Y6K54gKi5pg+G0ylXn5WuquK00y1cSYgzCqna/tg2LCqZiyCi45djt6e4N/uvChjpSqyE3z2kcdsywdXG/2mHJ63rKAt3UMO8Jj/tTWYKF6S6I+xo9qpb5yTZMGt7x91k68CgwDdd6pyKiSRWX2Dwx5OrW3rVQn/dnBbnhHhZS6q1Zio4sC4sAJCfxMHkj5tB8W1hVM2Nq4DdQ5Ri2kQqbS5kY8t8nlG4Cpl6hSdPBYjtqaU9Zuj65RDx8e7VsiPIr/zndE/IJytI6SBSBYREV2ju+38XKJTEZAvxs3EEMWTpWWu91Tgp8YVt0gKFlLxp+p8w5reQ6bNii8f378vwmQSBWpcyeWTlWp8OPfmkI8aD3EVqcGQ5JsmdVF2NNWZWzQ4jRU/UF3/gveeyD+Y5+6xiK/uxacqRWC6AVzLbvzTt2O6DouXKuRH87fWplFAQRyHK2TNoHUPXf9/gobiGEJIIaaXkp5/vXmO4b21GFEi0z6NbuwYWbfeyizJyY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(5660300002)(122000001)(966005)(316002)(36756003)(478600001)(8676002)(71200400001)(2906002)(85182001)(6512007)(38100700002)(83380400001)(38070700005)(66946007)(8936002)(66476007)(64756008)(66556008)(86362001)(66446008)(186003)(76116006)(6486002)(6916009)(6506007)(4326008)(54906003)(2616005)(26005)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHhONERrajhmdGNGdWpCTDdZeG9NVGdUQktzMWc4NDR1M1N3N0pRRmp2d3la?=
 =?utf-8?B?Z0t2eFpaZVUwY2FRdUVTblRDUHczNDQ1ZTNhNXNCVFlyQlhrY0kwbW8xZFJl?=
 =?utf-8?B?VGZZWGNxK0h0MHQybng3Mm1ycTg1NXVZeFFjd1dyRWUyREUzanpBMWRPWG9F?=
 =?utf-8?B?RVNNZFc2U2lsOFQ2c2pQUE9PZjZIbWMwaW9lTzBzSklpSndaL1V4K1lEL0dW?=
 =?utf-8?B?KzEyZHlrMjZ5NWZoUmZHaHVRdTU1NmpGbnQwWXcwbGdSS0V3cEwzdFZUNnh6?=
 =?utf-8?B?QThBY3lxRmhCajVUVThlNjZXcTV1ZkZtZU9nN0tENGMvTCtoaXNoSjh2andG?=
 =?utf-8?B?ZEJOM2oxcnUyYllOV3dkSzJNQUZDS0xremRQSWZpazVDcWN3REhEL0pSTkwx?=
 =?utf-8?B?Z2xwQVNEQTBlYy9VUU96d202aXRmM0ZrNm9HdVk5bDBjeTczQ1dJL1JGT2RV?=
 =?utf-8?B?MlduZnlsL29kZ3ZnM29QNng2WEpWZE1sNXMzUlZNY2pLckNuREQ1TFRMZmds?=
 =?utf-8?B?MjJMVm9JVlo2M1pZWVR5SzBmWnRiK2NsYW1iZ3AzWmNVdjJ3WFViRGJ6WW53?=
 =?utf-8?B?MWJOaFJHWmdkaXpwYkEyKzJVUzR0M21vZm5yR2xVSHpsSU9PSGFlMHVBdUFv?=
 =?utf-8?B?WURsc1p4dEhnWE9JTU5hRGJLS2JrUVJUTGVLRzExc0wzNG1SOXo2cFNhYXZj?=
 =?utf-8?B?TVhaVVZLNHJQbXUzVjI2SlZaaldnS0VLclNFR0xYTEkrL1R4Q3RBcDBacWdY?=
 =?utf-8?B?Y1FYK0VaNjhMY1lOVXMzTVdYNC9kVWR0ekRNaTlmWFdvd0FxMUdJZkJ6S3NT?=
 =?utf-8?B?VE1FUFM5ZTRPWTRKVUdlamVHMlBmak5PcHFsbkhCVGhPOW5qR0p6ejFQR2Vh?=
 =?utf-8?B?SUFPU0NRZlR1bkE4Q2IyL3loQ1FCejRMQ2YxRXlQQlRnSHFQVlJTdkNhUTg0?=
 =?utf-8?B?dHNPR2Y1VThtM1RJSzBQeEJsa042KzR6OUIwREpZSXJFdFVrZVpsVFZVTjFx?=
 =?utf-8?B?UHl6Uk15SVJyWGhTUUVLekU2T3ZaZlJPRWpDejd0U05mVGNuVk5jSmtlWStW?=
 =?utf-8?B?UWVZSTNmRHMzTEZ2NW5lcWhxOGJoTU1oQ2FsdnE1dDNweWNMSndPMU00bWc2?=
 =?utf-8?B?ZmkzU0JYVFdYVFp2QlhOYWI2Qnk2blJTMitLYjJtRkFhbHF2MmpwR29FdVdJ?=
 =?utf-8?B?c1YxZEl6RFMvWE53emNXVjBVbHJoWS9ka01rd1M3eUk0SE5jVlMvQlo1UGlr?=
 =?utf-8?B?SURTOWZFMUtPUlI4Wjc5Z0oyaWZDWkM3S2VuT0w4WUdkV01ONCtReVd3TGYz?=
 =?utf-8?B?QzB5NXZYUEZ2dk5oNGk1dVprb1k5R2VXUVNwOVpudVFnMjRzckpHbGM1bXFW?=
 =?utf-8?B?VUNzZkFEa3NGQk1LWEZEN3pGWk9wRWpxMytmT3lHMHRkT25mTnNhLzJTL3dH?=
 =?utf-8?B?eDVTanY1MkNZSVRnek8wZ2lsQS9aSXBXRlRRdGcvaHdVdnI2T2MxaGFMTDFW?=
 =?utf-8?B?czk4L1llejVUZkJXYk4wbVFqZGlIcjZxWUdwbVhIRUxweFZya2xmL3JvVGQ2?=
 =?utf-8?B?K1BORlNpYkdtV1JSQTdVcGVjdS9oL0w1M0FLUUtWcTJjd095V0Nncnlya28z?=
 =?utf-8?B?bDR6cmhQd0NNT2NtWlc5ZVhXK0dvdSs2MkMvVDJCeEs3WGp0TVNRbURScjlG?=
 =?utf-8?B?Z1l5RUxVUHZTM3Bxa3Q4dzhXdWkvOUpQTHA5UVArTHBnMkQ5ckVJeHhZZUNP?=
 =?utf-8?Q?97sA+ThdgO6VCR42nNKntJuPRABf8CuM3M9KWvY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7C5C1E5E922C240A2CC3CD932162F64@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c306bf-1285-4686-cd49-08d96308734c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 11:56:59.2788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GFKeRAwHwpjcP4OgsabdyXdCDTb/26UY93GG/VkFsBjlDZqrAKPEmzbjQevMq6zkJkVoGxBkzKHFmrXCKCOxB5F7WmZ16DjYvvWch2v0JbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5298
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgR3JlZywNCg0KT24gVGh1LCAyMDIxLTA4LTA1IGF0IDEzOjM3ICswODAwLCBJa2pvb24gSmFu
ZyB3cm90ZToNCj4geGhjaS1tdGsgZGVwZW5kcyBvbiB4aGNpJ3MgaW50ZXJuYWwgdmlydF9kZXYg
d2hlbiBpdCByZXRyaWV2ZXMgaXRzDQo+IGludGVybmFsIGRhdGEgZnJvbSB1c2JfaG9zdF9lbmRw
b2ludCBib3RoIGluIGFkZF9lbmRwb2ludCBhbmQNCj4gZHJvcF9lbmRwb2ludCBjYWxsYmFja3Mu
IEJ1dCB3aGVuIHNldHVwIHBhY2tldCB3YXMgcmV0aXJlZCBieQ0KPiB0cmFuc2FjdGlvbiBlcnJv
cnMgaW4geGhjaV9zZXR1cF9kZXZpY2UoKSBwYXRoLCBhIHZpcnRfZGV2IGZvciB0aGUNCj4gc2xv
dA0KPiBpcyBuZXdseSBjcmVhdGVkIHdpdGggcmVhbF9wb3J0IDAuIFRoaXMgbGVhZHMgdG8geGhj
aS1tdGtzJ3MgTlVMTA0KPiBwb2ludGVyDQo+IGRlcmVmZXJlbmNlIGZyb20gZHJvcF9lbmRwb2lu
dCBjYWxsYmFjayBhcyB4aGNpLW10ayBhc3N1bWVzIHRoYXQNCj4gdmlydF9kZXYncw0KPiByZWFs
X3BvcnQgaXMgYWx3YXlzIHN0YXJ0ZWQgZnJvbSBvbmUuIFRoZSBzaW1pbGFyIHByb2JsZW1zIHdl
cmUNCj4gYWRkcmVzc2VkDQo+IGJ5IFsxXSBidXQgdGhhdCBjYW4ndCBjb3ZlciB0aGUgZmFpbHVy
ZSBjYXNlcyBmcm9tIHNldHVwX2RldmljZS4NCj4gDQo+IFRoaXMgcGF0Y2ggZHJvcHMgdGhlIHVz
YWdlcyBvZiB4aGNpJ3MgdmlydF9kZXYgaW4geGhjaS1tdGsncw0KPiBkcm9wX2VuZHBvaW50DQo+
IGNhbGxiYWNrIGJ5IGFkb3B0aW5nIHJoYXNodGFibGUgZm9yIHNlYXJjaGluZyBtdGsncyBzY2hl
ZHVsZSBlbnRpdHkNCj4gZnJvbSBhIGdpdmVuIHVzYl9ob3N0X2VuZHBvaW50IHBvaW50ZXIgaW5z
dGVhZCBvZiBzZWFyY2hpbmcgYSBsaW5rZWQNCj4gbGlzdC4NCj4gU28gbXRrJ3MgZHJvcF9lbmRw
b2ludCBjYWxsYmFjayBkb2Vzbid0IGhhdmUgdG8gcmVseSBvbiB2aXJ0X2RldiBhdA0KPiBhbGwu
DQo+IA0KPiBbMV0gDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMTYxNzE3OTE0Mi0yNjgx
LTItZ2l0LXNlbmQtZW1haWwtY2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbQ0KPiANCj4gU2lnbmVk
LW9mZi1ieTogSWtqb29uIEphbmcgPGlram5AY2hyb21pdW0ub3JnPg0KPiAtLS0NCj4gDQo+ICBk
cml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLXNjaC5jIHwgMTQwICsrKysrKysrKysrKysrKysrKy0t
LS0tLS0tLS0NCj4gLS0tLQ0KPiAgZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay5oICAgICB8ICAx
NSArKy0tDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDg2IGluc2VydGlvbnMoKyksIDY5IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2NoLmMg
Yi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktDQo+IG10ay1zY2guYw0KPiBpbmRleCBjZmZjYWY0ZGZh
OWYuLmY5YjRkMjdjZTQ0OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10
ay1zY2guYw0KPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLXNjaC5jDQo+IA0KDQpJ
IHNlZSB0aGUgcGF0Y2ggaXMgYWxyZWFkeSBpbiB1c2ItbmV4dCBicmFuY2gsIGJ1dCBmaW5kIHNv
bWUgbmV3IGJ1Z3MNCmludHJvZHVjZWQgYWZ0ZXIgSSB0ZXN0IGl0IChvbmUgTlVMTCBwb2ludCBk
ZXJlZmVyZW5jZSBvb3BzLCB0d28gbWVtb3J5DQpsZWFrYWdlIGR1ZSB0byBubyBlcnJvciBoYW5k
bGluZykuIA0KV2hhdCBkbyBJIG5lZWQgdG8gZG8/IHJldmVydCB0aGlzIHBhdGNoIHRoZW4gc2Vu
ZCBuZXcgdmVyc2lvbiBvciBqdXN0DQpzZW5kIGZpeCBwYXRjaGVzPw0KDQpUaGFua3MNCg0KDQoN
Cg==
