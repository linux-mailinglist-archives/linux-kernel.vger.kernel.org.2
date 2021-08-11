Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B993E8B69
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbhHKIH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:07:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54066 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235951AbhHKIFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:05:42 -0400
X-UUID: 07d1385744ca43949c1187e49639eafa-20210811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=r0FHI9qvyygZq++u+aozW1AKPwYLZ17XSQ8c/WaoWzU=;
        b=oPRwuEWjHOxue5MOiD/zxBsmuHeDnvpJvPzzuijCNMfy1mT2cuWkA78ZhdTWqPAyZfT14LRpDPAMh8S0VbqCOAcH9Nxe3rFKpXtuLFog3zRncklWRmCijPga/RNfz/37vOHJH4rNGKzSUfc+Jup5qoCzvUjAiVmqQGE9wrgAQhQ=;
X-UUID: 07d1385744ca43949c1187e49639eafa-20210811
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1551054453; Wed, 11 Aug 2021 16:02:51 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkexhb02.mediatek.inc (172.21.101.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Aug 2021 16:02:50 +0800
Received: from APC01-HK2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 11 Aug 2021 16:02:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gamUlN10q8eKvadmEapvs9xJXBNv1zkgjUnzF7TIaZZdNYCV4lxsfmwh4Um8kdz/2dZZXpl7eMC7dJsrKy1DiC3cFnRByNGnxeTJ3/ApRgnOl+/2G3R7miDsSySz2C/IehoEg1f6NMpdMnl3o7rf5DXgpDxg/WySXv/Ceqp7QjIltWMHg0v3KTxS42/Sa8sz0lF3lyp1JU7/EQ5DD1PHAbUXMVIVyqE4C+mkP20asVSCPVZfgeIsR3evIb2CGC8l517HCt9T4D1dON+ZVXG+xouAev387Ok4fgr6VKMxA+MdILN8VHh2PJ3ip9geWMz5jxlH9mWaDzhimsrdIBE1tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0FHI9qvyygZq++u+aozW1AKPwYLZ17XSQ8c/WaoWzU=;
 b=h1hUISu4tpi8GCemGl0ospF+WpXQThQha/Cewr+87OT9Lflt5XeZKbUQi0aiT7dh7xQl0usIFX3tBufOG+yHSHFK9Csb5g8fKRsCLISVjI/Ow18+yvU5aQ3HN3+TgltO3TMBtwC3IRoc3LYFpGsxqKu7s3U1YHVIaBqPwRDgm8E3F1LnBi/KfTueYqTvmkPHW4IJFN6JhJcsPkABgU47iNrUE0zHgxmC8lONQycFEOG13p84Lj5Lw6rTL/zJ+Ok1jSKMfPQ2HSKsqdBLE7cL/CHdydqiec9vJs/TQkggCLYFYKg62i2l603H+kaQhbhXoQ4Usod8iWfNt3OQx/IdnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0FHI9qvyygZq++u+aozW1AKPwYLZ17XSQ8c/WaoWzU=;
 b=tLOt0f4hAYXMti/xf+DEXXJ1EoNmvQlV7pN21jFSvbuKzEWmxd/sVMufmc/e/dSFsG2FTatjKZ+MXJbnEXR9oHYge6XM3BKeC8J3J/GteDor6KeIHrgxp03hiSLkkcqCV9fdTmvvlhaJ+hVFPeepjIXDcp6Gpy5g1OHC1PBBd7I=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR03MB5585.apcprd03.prod.outlook.com (2603:1096:820:5b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5; Wed, 11 Aug
 2021 08:02:39 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608%7]) with mapi id 15.20.4415.015; Wed, 11 Aug 2021
 08:02:39 +0000
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
Subject: Re: [PATCH 03/11] dt-bindings: usb: mtk-xhci: add compatible for
 mt8195
Thread-Topic: [PATCH 03/11] dt-bindings: usb: mtk-xhci: add compatible for
 mt8195
Thread-Index: AQHXhR/6noCL61VyMkeKozDzz7Lwjqtm/SEAgAcHHwA=
Date:   Wed, 11 Aug 2021 08:02:38 +0000
Message-ID: <cd1662f5f47fe7539d2c01bd280ad8b9d9d25b3e.camel@mediatek.com>
References: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
         <1627635002-24521-3-git-send-email-chunfeng.yun@mediatek.com>
         <YQ2e6AGFi7beqp6Q@robh.at.kernel.org>
In-Reply-To: <YQ2e6AGFi7beqp6Q@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14d70366-af22-42a3-2d6b-08d95c9e634f
x-ms-traffictypediagnostic: KL1PR03MB5585:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KL1PR03MB5585F581B74A64F28602F41BFDF89@KL1PR03MB5585.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SYMpLFWmukYqsBM0HpRWBzk6m6O8+9FBA8jnrZUKDdSjo1IRbyH17hQD2lqRoCnwIgbeN2x87+1kKaMdTS7oXoAK+UWXszmwGvVxQjw90Rd8gbYSRKX1u9SS+kxewvuUVKU0LNNzJTaeKO7kzQZQI7Nj+TAHYGr2E08sYI3IW5/+cWxMfT/96HHCMDQminkiQtWoqah/s6wi6SsbV62e6BWOP/f+zi96M0Emkb273ilj5Z5MVJg57JSLVMgGXOjXNGlZxxzy1/DDScQtbGqqBAVIhAFp4H781k1JCwkFZ2B3NMAmJdGVpqlZPXWYIe4tEIvv3+bjSpVyXabU//TLWc+l92uWHp78Qum2cHM6cpW6f5pWI5yfv7rJbFsCN3h6YVP0waTrORzZ5gM8UsFRyfX2j85cBy6y0CimNX3YWUTzfJHCQqJ65jqXncRbQTkovPzg/LASiCSac2JTsqAh3I/NaW1QlfN03NXCgGs7B1RhLkhzeTum5N4/crzvA2WACMk/CMhLPsON1+uRQz7j+/lukrZUVmh5nlY+kesKxt6EBwJmdH6tJk8qV6fNDAlkCnubVxzCfTAiLJW3MfNyzjBv/exEXsV1pVk9rm/Z+Dw1v9j12S23K6xc2toi3lb8c0hg84xLgdgVoiiF1uaqDSmLtVZ8M5/bR7GO5cy6CNR+L3O2n6K3mdi3op8HCph5LOp6tH6uiItbJy8hHx2IfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(54906003)(86362001)(71200400001)(2906002)(4326008)(186003)(26005)(6506007)(38070700005)(5660300002)(8936002)(6512007)(122000001)(498600001)(38100700002)(36756003)(6486002)(66946007)(8676002)(6916009)(66476007)(66556008)(76116006)(91956017)(2616005)(66446008)(85182001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTZhMXE0c2syTGoxZExQQitvTXY2T0N6dkZlME9EU0VZUkhXdXgyd3luT294?=
 =?utf-8?B?dklPV2VUc2ZlZlJDYi9lUE12VDhVMG84dlMxU0pXK2VDMjhuVU1ZRTZ4am5j?=
 =?utf-8?B?eXZCQ0pDVGVjSnJ4UFdTSlhpY0FrTDd2WWRQeGJmT0M3K09DeEZLdWFBbWpz?=
 =?utf-8?B?dkJOM3ovdEtJcTNkTHozSVpHLzBKSW93WnF6NGZEL1FtSm1MWDlpclZ5M0pS?=
 =?utf-8?B?VEtjVTF2QW55bGdQd2JKNHRuVTRLS0VJVVdZZE5qeDlpUzl3NlJGUVl2ZzUw?=
 =?utf-8?B?UGRlQklmTUM2U0dESFkvcnVRMkJoWjNvZTJsbXR4b2V3MHIwamd0MEVoMHVW?=
 =?utf-8?B?YTM5UFBCYzFkdWdQUkFDWEVIY0ZFSHFGeFVHV01IcWFyOVNOSktSOHp4WEVt?=
 =?utf-8?B?NjZYMTZQNlR4b1IyM3hzMUhPRC8wTW92NGdNTnpJdmhtRFd1ZFpmclNEZnhz?=
 =?utf-8?B?aVRuSlpCeEl3eU1HdmF1cnltN1U3ZENadHV5ZU5JTHhpQkN5YVZuNTRRd2FX?=
 =?utf-8?B?Z2xTZkRoY2t0R3c5ZitONVlzcUVSYlJFc0xSeDVyam0xMDhZL21nNUt1Wm5V?=
 =?utf-8?B?U1FqZnFnYS9Ed3RBbzFhZWQvZ0liZ1czSld2ck16d2pCSWxYSFdaa201UzBm?=
 =?utf-8?B?c3F4QnJHWjF4dS93S0ZvZkl3OUxJaVoxVUNqVnJHQlQ3RkdTZTVxQklKL2R1?=
 =?utf-8?B?eWJuSHdwbTl1WmxBNFIzMVlVUmxQNm9qQU95VUkyVkluLytNS0RROGhBZ2tS?=
 =?utf-8?B?b0tXR2tnQWFLWC94bEkwM0VyVVY5TDBWMkJEZFIxcEFxMmwzME0vN2VsNnd1?=
 =?utf-8?B?Zis0cklPRG9SZFIzQXdvZ2pOU0JBeXRvNTVsZ21kU3FQNGxPaGplZG1rUDdP?=
 =?utf-8?B?TG0yYS9QaU5rcTdQUGpEUWU1TGlWUThIR2FsZWtjUjJTcDdpOE9nS1IvUVl5?=
 =?utf-8?B?Tk1BTzdTMjgyaDYxU1NTRWZxVFFodzZDVnpWbmwvQWc5RmJ4VHVkU0VDcXA1?=
 =?utf-8?B?QWZWeURULzliU1hIQ2x1dVVRNUhMTHNPK2k3SDJnVXh6RVhneVpZaFpodnBE?=
 =?utf-8?B?YUtubzNPZi9Uay9jaDhkK042SHUrR2ZrNnNNdzJ3SHZPMkQzUHl2S1kzb0to?=
 =?utf-8?B?K0ZWcmRsZ3JIMDJRdS9nMiszbUU3aXVVL2U3aWdxa2JIbmRIWG0yWkJMOEhx?=
 =?utf-8?B?TGpMTlh1TDBSeXl6V1I4RStyS1VOVWhXdTJMakNibXh1Zzl4ODRQdGZ6bWNy?=
 =?utf-8?B?ak9DbjVwY0ROd0RUZ25RNzB1R3BoWTZPVHNqd2NzNGtQVkxXOWxzNk1QS0VH?=
 =?utf-8?B?NVZGRjRHazB2QUZFV1BQUFBDTWlZOWg3aXlJVEs5R1VDSEp1NTlPWWhoczR6?=
 =?utf-8?B?MnRvWlBBTzI0N2o4STQ5aDl2dU1CQXRtZTlROUhNd0plZWlRWmtNWlJLRWdX?=
 =?utf-8?B?dHFPUVpEdzh5eTMxWkI2U3lzV0h2N3psaXExb1ppZWdtbkw5TmQ3VENCa3Z3?=
 =?utf-8?B?MENSeUdMSmJhaTd6dk5YakZ3a2VkZ2lielQ0aUF4OVljWnFSOGQ1UlZVYzB1?=
 =?utf-8?B?WVBkMHZnN2M0SEZ4azQ2dlpadVY0c2Nldm4vZVROSktwc3EySWl3ajhFS3ZU?=
 =?utf-8?B?VFg0bjB4OWpFcVJjdlFDY3M3T3VNQzAyMHB5L0M3RkJsTkd3SXZ5MjVPeHBt?=
 =?utf-8?B?N1hIYS80aUFncDlwMnlrUzlUUFNCdTcrTE1INnN0ODk2THhSQ3crS2FkMUlV?=
 =?utf-8?Q?lJGiUl/CgSYEPm7UQlXh4oX8GGC+oedmDMo8x5S?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6CDFA6EBCC0234AA384FF40F2F43245@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d70366-af22-42a3-2d6b-08d95c9e634f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 08:02:38.9797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bltdEqX+dxJJFuFbYdlp5ZR9FxNfyLtNk1AxqPd4v5CMjPkYnf+hSIUQDm0LtGsuIlcovvC8gyc6pJyztdawmQMAKr9QMZck+VECCw5heBc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5585
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA4LTA2IGF0IDE0OjQzIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gRnJpLCBKdWwgMzAsIDIwMjEgYXQgMDQ6NDk6NTRQTSArMDgwMCwgQ2h1bmZlbmcgWXVuIHdy
b3RlOg0KPiA+IFRoZXJlIGFyZSA0IFVTQiBjb250cm9sbGVycyBvbiBNVDgxOTUsIHRoZSBjb250
cm9sbGVycyAoSVAxfklQMywNCj4gPiBleGNsdWRlIElQMCkgaGF2ZSBhIHdyb25nIGRlZmF1bHQg
U09GL0lUUCBpbnRlcnZhbCB3aGljaCBpcw0KPiA+IGNhbGN1bGF0ZWQgZnJvbSB0aGUgZnJhbWUg
Y291bnRlciBjbG9jayAyNE1oeiBieSBkZWZhdWx0LCBidXQNCj4gPiBpbiBmYWN0LCB0aGUgZnJh
bWUgY291bnRlciBjbG9jayBpcyA0OE1oeiwgc28gd2Ugc2hvdWxkIHNldA0KPiA+IHRoZSBhY2N1
cmF0ZSBpbnRlcnZhbCBhY2NvcmRpbmcgdG8gNDhNaHouIEhlcmUgYWRkIGEgbmV3IGNvbXBhdGli
bGUNCj4gPiBmb3IgTVQ4MTk1LCBpdCdzIGFsc28gc3VwcG9ydGVkIGluIGRyaXZlci4gQnV0IHRo
ZSBmaXJzdCBjb250cm9sbGVyDQo+ID4gKElQMCkgaGFzIG5vIHN1Y2ggaXNzdWUsIHdlIHByZWZl
ciB0byB1c2UgZ2VuZXJpYyBjb21wYXRpYmxlLA0KPiA+IGUuZy4gbXQ4MTkyJ3MgY29tcGF0aWJs
ZS4NCj4gDQo+IFRoYXQgb25seSB3b3JrcyB1bnRpbCB5b3UgZmluZCBzb21lIDgxOTUgYnVnIGNv
bW1vbiB0byBhbGwNCj4gaW5zdGFuY2VzLiANCkl0J3MgYWxzbyBPSyBmb3IgSVAwIHRvIHVzZSBt
dDgxOTUncyBjb21wYXRpYmxlLCB0aGVzZSBzZXR0aW5nIHZhbHVlIGlzDQp0aGUgc2FtZSBhcyBJ
UDAncyBkZWZhdWx0IHZhbHVlLCB1c2UgbXQ4MTkyJ3MgbWF5IGF2b2lkIHRoZXNlIGR1bW15DQpz
ZXR0aW5nLg0KDQo+IENhbid0IHlvdSByZWFkIHRoZSBjbG9jayBmcmVxdWVuY3k/DQpObywgaXQg
bWF5IGJlIGRpdmlkZWQgaW50ZXJuYWxseSwgbm90IHRoZSBzYW1lIGFzIHRoZSBjbG9jayBzb3Vy
Y2UuDQoNCj4gDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVuZmVu
Zy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14aGNpLnlhbWwgfCAxICsNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLQ0KPiA+IHhoY2kueWFt
bCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLQ0K
PiA+IHhoY2kueWFtbA0KPiA+IGluZGV4IDYxYTBlNTUwYjVkNi4uNzUzZTA0M2U1MzI3IDEwMDY0
NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0
ZWssbXRrLXhoY2kueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2kueWFtbA0KPiA+IEBAIC0zMSw2ICszMSw3IEBAIHBy
b3BlcnRpZXM6DQo+ID4gICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE3My14aGNpDQo+ID4gICAg
ICAgICAgICAtIG1lZGlhdGVrLG10ODE4My14aGNpDQo+ID4gICAgICAgICAgICAtIG1lZGlhdGVr
LG10ODE5Mi14aGNpDQo+ID4gKyAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5NS14aGNpDQo+ID4g
ICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10ay14aGNpDQo+ID4gIA0KPiA+ICAgIHJlZzoNCj4g
PiAtLSANCj4gPiAyLjE4LjANCj4gPiANCj4gPiANCg==
