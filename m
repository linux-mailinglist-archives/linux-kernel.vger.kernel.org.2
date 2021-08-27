Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4577B3F97AC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244927AbhH0JuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:50:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47116 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244837AbhH0Jt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:49:58 -0400
X-UUID: 3af4dc1eea514fce88138b87686a511f-20210827
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DVEMyI1MIwQs0gfaeCUqC1lP5vhsfbyO1df8h1Bly4U=;
        b=CrrzHIJjqBgXPL8aL+og9XXT+/H8LYe4MLGUj9PyOICUqkKMGs0En1rdBecIz/M/fd3UibF+m3uuiGGuSXcUNquJ1Yg4iCyVSoub6swnIdC+3ZIllqCLdAhuVm4CKQn/oAnbijRz/VPIxWppmhOQsoHh7Y/Ct4ZQzzmPGoftKXY=;
X-UUID: 3af4dc1eea514fce88138b87686a511f-20210827
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1731666972; Fri, 27 Aug 2021 17:49:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 27 Aug 2021 17:49:05 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 27 Aug 2021 17:49:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpHPMXT9yvSgLFGno0NVWadWQwlHgufL33xyS9cAMyjbSr8eaNXKXfStKWoUw9dRbkyFuFPi2V6TmxveeEfagHyigf7HJLeCLduQ+DGLcGAWx4E5bLbzV+JXu5EJRGPTPRKy/voq8sA1j7/GiN2+unau8o5Zw0w4+p1LOP9vWxtEMPvwXspHK3Z5Wq3mwEvrufD2YsnTImn/uq+pS3gnQDv3Tt+Ol8LWKRsK1YbJrRQOLK5434LZsVCjgrTKf6I8pYyVy07bhkkrT5Ieso4gUUQJCvIr7fWG4ZEjitD4qeKzG4F4KF382ak8LiWsYVdYB+Ye06E/IxTwoxcuRTBgLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVEMyI1MIwQs0gfaeCUqC1lP5vhsfbyO1df8h1Bly4U=;
 b=NDkkejUExDMtY2+3aAwoFgVxxhf1gbjKssa45ekRAYU7iVGB5WNT27RQDNfgBGgN0J52wF5RWN+xyjfdTzv+8ea4uYv35EUc9SUz3V5LAkxyOZ5gZRUK9cIasLfqN4VN743bgP24p1VarpZqdSIfW1RfzLSJnbEDDcviw8OOXtCowG4UjM7lStmMWcWjjZIXbm/T6vyHP5i/MetthiJo2kSYFr3x1A3aUq/nyn1fT/YZsMOYZeBHdFmGFxcg1gPOLJ8rfwlA6pkgXxQiimif+NpGz6kd+zz7m8E4KHxgXJYxER1RIwMfQPA4yE9VokgCiJPttFzgMxgLe1Jf68FwaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVEMyI1MIwQs0gfaeCUqC1lP5vhsfbyO1df8h1Bly4U=;
 b=bX0WmXjA25zlFYgP7s430kmWGmfsDt6jyPR6bipmWf/9jEcqnL5GP86vqF4PYOwRsmMy1etdztJ+wtB7/OnznfEWkDrz28bc70gteRbWAuX0P4tqWIuZKxFUVpTOgtVmnl71gbbvzO8C5ftk0uZStETgUH920UCiGaCIqmZPuz8=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KU1PR03MB2807.apcprd03.prod.outlook.com (2603:1096:802:27::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.8; Fri, 27 Aug
 2021 09:48:53 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::1898:f611:33ba:b58c]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::1898:f611:33ba:b58c%7]) with mapi id 15.20.4457.017; Fri, 27 Aug 2021
 09:48:53 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "ikjn@chromium.org" <ikjn@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        =?utf-8?B?WWFxaWkgV3UgKOatpuS6muWlhyk=?= <Yaqii.Wu@mediatek.com>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH next v2 3/6] usb: xhci-mtk: update fs bus bandwidth by
 bw_budget_table
Thread-Topic: [PATCH next v2 3/6] usb: xhci-mtk: update fs bus bandwidth by
 bw_budget_table
Thread-Index: AQHXmiVZCYpp+DFuZEGdWMiTnTLyNKuFrdcAgAE9OgCAACh2gIAACawA
Date:   Fri, 27 Aug 2021 09:48:53 +0000
Message-ID: <18cb18d7d0ea4a3bb46921aca88c53646f1b3764.camel@mediatek.com>
References: <20210826025144.51992-1-chunfeng.yun@mediatek.com>
         <20210826025144.51992-3-chunfeng.yun@mediatek.com>
         <CAATdQgBD+dTtBie-cNKRJbfxEpc3haqjfUu1k26mTk8pCSOEww@mail.gmail.com>
         <72ee7a203d8a49e6e43a954b45133470ee6d5c16.camel@mediatek.com>
         <CAATdQgA+4VC7J1LMZYOZMV-OTjMGjO=9bJZ7uaCu_MMF-20T1w@mail.gmail.com>
In-Reply-To: <CAATdQgA+4VC7J1LMZYOZMV-OTjMGjO=9bJZ7uaCu_MMF-20T1w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 39e657b8-8e59-45b3-951e-08d9693fe1a2
x-ms-traffictypediagnostic: KU1PR03MB2807:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KU1PR03MB2807541594060EE2CBE562EEFDC89@KU1PR03MB2807.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y2ITfJjuZM3nX9pb54bfUDCMI/QqzKYjRhe3B6Y+jplj4R+nvIV5XuLV4JbOguloBFQin+h/HlO+qWmp/EvPuPPCU2RqHO4zS16jLNZc3u5GlWADiCaBFx9HJIl3ZpeWIaCLxtj+IRbYxLvHxY1sr+BkXAQgIvsrCh1Prx7wuWsUEja1hjZi3nU86w7R3Lg8sEex8/o7LqQ/0GbkWjX7MTXkmCT6n6mPYV2ZRpHGScSqcF+AdSblg3uhSZSMAs/JwaKT9Ek7USltNgKNEapv5XABaJ+/Cy42brWQoVGJYxMUCsiMZOzKZpS8izxIs3hXPhyBLtuOnGsS9zdfCSAD2FDw3+Kpm4hA6IlCXx2cpfT7eQ5KKtdVmzXOrLtndLpYvft0P+tQzQL+k9aFBRjARH0htD9x8mpaP85Dt8oc2cinMgELWXLtjGyROW/MVY/OL3/69lhiURshdGXlkJ6murk37B5mQwfnVq4xOt3fT2FgD0WogTrqugs0dpHtiLhgM0851xfZoc2XDfrDQvooUh+fd2Bj3Ph9MHYXvgD966f8wqiEHsBfsUW+ZRXYX/4KkY2uFH8Uke178XNY2gFXBp6Nqs8jN9mySCOE+ECgHlTmaQJIIyPMv7TJXj03zNEaUjd5TDIl/h5jE0gTvAmn/0H8q1RhHuWFsRD1rD9tUMlk/alJo7lt2cM63BVkct1wgtUkZ8MSbOA+idCWzPTl5YunvTNNKowlYY18W+GkNUozy8DqRfudTSJT1REz6Uyfzgjn++648Y4BiC25LWHwLk0J/sWMSjPXhIo62fNy0lA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(83380400001)(8936002)(15650500001)(86362001)(76116006)(91956017)(4326008)(26005)(6506007)(36756003)(6486002)(71200400001)(8676002)(2906002)(6512007)(66946007)(38070700005)(2616005)(64756008)(66476007)(66556008)(66446008)(122000001)(54906003)(186003)(85182001)(53546011)(5660300002)(6916009)(38100700002)(316002)(99106002)(414714003)(473944003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXgrd291Y2pXU1dYUTRkcUNCaHRRUDhkcmlMQk1BVWVVeHFneVl3cTdFcDVH?=
 =?utf-8?B?S1prcENtSG1PZ2lUYXVFR01CNHNCUHhtNGNPMWRqZG04SG5nL01XRFZQbHgr?=
 =?utf-8?B?d3F1YWl0czBodmlNMURlRjFFd29HSGIyL3M1cGtMNlM5UjErN0J3MlhkcnVJ?=
 =?utf-8?B?WWdMZnpJS3M2TXN5N0JlUy9WTzdPdDR1UDYrSEliU2U4N3dXR25FV0lDL0pE?=
 =?utf-8?B?Sm51TFVFQ1ZySkQrc2ZBWTM2cU0yZmtMR0xjdmFZWGlFMUs5WXBBVy9IQU9C?=
 =?utf-8?B?Z24zS2MwN3lQTXpLbGI2M2tvTkEvUVJuWUI0YzhBQzNseDBZSFhnRnhIZkNQ?=
 =?utf-8?B?ZTZxTC9DeDlXRTBXdUR3bmYyTFNSSnVSOXBWQVhPcS9GWm5UTHN6cWYzZ0J6?=
 =?utf-8?B?KzhFUXRJNWtGVjFrL2syRnd2dWtEMEE2ajNPODNMREgrV2cvZkk4OFVRL2Jy?=
 =?utf-8?B?anBHY0hmWnB0V1dvbnhGeDEyV2V2WkVYNGFLRkIvT3MwcDBzTC9uS1VSVkQ1?=
 =?utf-8?B?bjBsYlY1YUk0SEMzNVJvVVRPZVlQbjQzSjJPdHVXellldnZQaVZKZTJRUnla?=
 =?utf-8?B?bXdCbmdmaHB4YTBQeW9BRnJTV3R1ZGIrMXVhdEVHU1p2RTZjTlBhYmM0QWdY?=
 =?utf-8?B?R0RYTVprRWFJb25OdEMydEF0cVhjWW1wS2NHQ0s1R2pvSEFJREF6ek9FYW51?=
 =?utf-8?B?V2xoTDE1SSttUHlMK0lIYlpTQ28rYS9nbjNZSUhWMGYxZUR4QzRCLzZ0Y2s4?=
 =?utf-8?B?ZDVaaDVRRlZteEVHUC8wSGw2MUdoYTZYMldmRlZCTnlDZE5WcHlIdzMrL05h?=
 =?utf-8?B?dk1uR2xRbzA2ZVRsN2hPNEJManpNdFQ3UlpiRFhmcWllcUZ0Q1B0akMxUmdY?=
 =?utf-8?B?K2VYelpRU3Z4WnEvbUYzd3dJZkhxL1NzTEkzV2hZeGFIWDhRUGlRU2xNUGR3?=
 =?utf-8?B?aUl1V3ovRTJpTHMzVm5tYVJVSFlrZTlCdUJWUmw2WWdsWUJYeEpRT3NaQ3Mv?=
 =?utf-8?B?eUZETFUwWFR2MTdpVW16Q25iRitDeWlRSXE5cnpBbi9uYzhuZDh0ZDhBQnEv?=
 =?utf-8?B?MTROeFNtR0hYNGs0alhMaWtKVnV6SDdtNk5xNGEvVU9mME5NbHEyUXpJQzE3?=
 =?utf-8?B?Z0Q0SU9zYWgvK3RUU1FzOWJJZ25VTzVEN0RyaTBqaEE4Mm5DS2I4clBKZTUv?=
 =?utf-8?B?czJ1OEgxSlFpMXU2cVdIS05SL05xMEpWdlFjV3JwdWpIQnhQZlFPaG5UeWpl?=
 =?utf-8?B?d2VybVVtaCtETHdMRTFtdXNWWjZFcTg4WXJ2R0UwSjVWR3ZXNmhGWTJLUTl3?=
 =?utf-8?B?a3dlSXNibzF5RGVSdi9qSXY0azhFYnFNTjVqQVhvSUNKN1BHY0lYNzdBZFNu?=
 =?utf-8?B?N0lFWVkxZmFTbzFLWFduWjE3citNVEpkajNDcVlHWER4ZFBuVnZQbFpyRXR5?=
 =?utf-8?B?dFBmTjdwT3NmU290Nm81UVNIQitIODcwWVhJS3hnNjk3SzZiZjVxMzlhc0Va?=
 =?utf-8?B?KytFRnZzbzVQQmo1TnkycGt4d05jOXpqOVlYQWdhbmNQRERKZ0RUTTEyRXdn?=
 =?utf-8?B?VjMvMXI0WEJ2TU1UalJtTi83VlNuYlhFV1lJazM0eEtmL0JXQ3FTTUtOeHN0?=
 =?utf-8?B?SlNkZnV5TExDUVdZenVxSGxoTWNPSkVNMmRseHQrL2RYYWZVTVZuZU9ocTV2?=
 =?utf-8?B?cXBMT01xMDd2bmNvU3podDlaaktaVCtVZnMyVzI4NnFzcnFOMTFrMmR4YWps?=
 =?utf-8?Q?540p21E1eo6yTBJlIJvLk7QDPmZm2topVYoLGrF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC49B836479E944A87E8EC1F1492AFE2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e657b8-8e59-45b3-951e-08d9693fe1a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 09:48:53.6841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uS0a/eKSYp+OQLtgy01XlIuV2662IRpGmzj7gLUZ6L9LG0MIHWQqSMfG17ClDOjeHgW6ccbV8snpP16VD3wDp4qvE5VlgCBdq5mFuh4q710=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1PR03MB2807
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA4LTI3IGF0IDE3OjE0ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
T24gRnJpLCBBdWcgMjcsIDIwMjEgYXQgMjo0OSBQTSBDaHVuZmVuZyBZdW4gKOS6keaYpeWzsCkN
Cj4gPENodW5mZW5nLll1bkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFRodSwg
MjAyMS0wOC0yNiBhdCAxOTo1NCArMDgwMCwgSWtqb29uIEphbmcgd3JvdGU6DQo+ID4gPiBIaSBD
aHVuZmVuZywNCj4gPiA+IA0KPiA+ID4gT24gVGh1LCBBdWcgMjYsIDIwMjEgYXQgMTA6NTIgQU0g
Q2h1bmZlbmcgWXVuIDwNCj4gPiA+IGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+IHdyb3RlOg0K
PiA+ID4gPiANCj4gPiA+ID4gVXNlIEBid19idWRnZXRfdGFibGVbXSB0byB1cGRhdGUgZnMgYnVz
IGJhbmR3aWR0aCBkdWUgdG8NCj4gPiA+ID4gbm90IGFsbCBtaWNyb2ZyYW1lcyBjb25zdW1lIEBi
d19jb3N0X3Blcl9taWNyb2ZyYW1lLCBzZWUNCj4gPiA+ID4gc2V0dXBfc2NoX2luZm8oKS4NCj4g
PiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVu
QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IHYyOiBuZXcgcGF0Y2gsIG1vdmUg
ZnJvbSBhbm90aGVyIHNlcmllcw0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvdXNiL2hv
c3QveGhjaS1tdGstc2NoLmMgfCAxNyArKysrKysrLS0tLS0tLS0tLQ0KPiA+ID4gPiAgMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+ID4gPiA+IA0KPiA+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay1zY2guYw0KPiA+ID4g
PiBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2NoLmMNCj4gPiA+ID4gaW5kZXggY2ZmY2Fm
NGRmYTlmLi44M2FiZDI4MjY5Y2EgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hv
c3QveGhjaS1tdGstc2NoLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10
ay1zY2guYw0KPiA+ID4gPiBAQCAtNDU4LDggKzQ1OCw4IEBAIHN0YXRpYyBpbnQgY2hlY2tfZnNf
YnVzX2J3KHN0cnVjdA0KPiA+ID4gPiBtdTNoX3NjaF9lcF9pbmZvICpzY2hfZXAsIGludCBvZmZz
ZXQpDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgKiBDb21wYXJlZCB3aXRoIGhzIGJ1cywgbm8g
bWF0dGVyIHdoYXQgZXANCj4gPiA+ID4gdHlwZSwNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAq
IHRoZSBodWIgd2lsbCBhbHdheXMgZGVsYXkgb25lIHVmcmFtZSB0byBzZW5kDQo+ID4gPiA+IGRh
dGENCj4gPiA+ID4gICAgICAgICAgICAgICAgICAqLw0KPiA+ID4gPiAtICAgICAgICAgICAgICAg
Zm9yIChqID0gMDsgaiA8IHNjaF9lcC0+Y3NfY291bnQ7IGorKykgew0KPiA+ID4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICB0bXAgPSB0dC0+ZnNfYnVzX2J3W2Jhc2UgKyBqXSArIHNjaF9lcC0N
Cj4gPiA+ID4gPiBid19jb3N0X3Blcl9taWNyb2ZyYW1lOw0KPiA+ID4gPiANCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBzY2hfZXAtPm51bV9idWRnZXRfbWljcm9mcmFt
ZXM7DQo+ID4gPiA+IGorKykgew0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICB0bXAg
PSB0dC0+ZnNfYnVzX2J3W2Jhc2UgKyBqXSArIHNjaF9lcC0NCj4gPiA+ID4gPiBid19idWRnZXRf
dGFibGVbal07DQo+ID4gPiANCj4gPiA+IEknbSB3b3JyeWluZyBhYm91dCB0aGlzIGNhc2Ugd2l0
aCB0d28gZW5kcG9pbnRzLA0KPiA+ID4gKiBFUDFPVVQ6IGlzb2Nocm9ub3VzLCBtYXhwYWNrZXQ9
MTkyOiBid19idWRnZXRfdGFibGVbXSA9IHsgMTg4LA0KPiA+ID4gMTg4LA0KPiA+ID4gMCwgLi4u
IH0NCj4gPiA+ICogRVAySU46IGludGVycnVwdCwgbWF4cGFja2V0PTY0OiBid19idWRnZXRfdGFi
bGVbXSA9IHsgMCwgMCwgNjQsDQo+ID4gPiA2NCwNCj4gPiA+IC4uLiB9DQo+ID4gPiAoSXMgdGhp
cyBjb3JyZWN0IGJ3X2J1ZGdldF90YWJsZSBjb250ZW50cyBmb3IgdGhvc2UgZXBzPykNCj4gPiAN
Cj4gPiBZZXMsIGVwMW91dCBpc29jIHVzZSB0d28gdWZyYW1lLCBlcDJpbiBpbnRyIHVzZSBhIGV4
dHJhIGNzOw0KPiA+ID4gDQo+ID4gPiBJJ20gbm90IHN1cmUgaWYgaXQncyBva2F5IGZvciB0aG9z
ZSB0d28gZW5kcG9pbnRzIHRvIGJlIGFsbG9jYXRlZA0KPiA+ID4gb24gdGhlIHNhbWUgdS1mcmFt
ZSBzbG90Lg0KPiA+ID4gQ2FuIHlvdSBwbGVhc2UgY2hlY2sgaWYgdGhpcyBpcyBva2F5IGZvciB4
aGNpLW10az8NCj4gPiANCj4gPiBBbHJlYWR5IHRlc3QgaXQgdGhpcyBhZnRlcm5vb24sIGNhbiB0
cmFuc2ZlciBkYXRhIHJpZ2h0bHkgb24gb3VyDQo+ID4gZHZ0DQo+ID4gZW52Lg0KPiA+IA0KPiA+
ID4gKEkgZmVlbCBsaWtlIEkgYWxyZWFkeSBhc2tlZCB0aGUgc2FtZSBxdWVzdGlvbnMgbWFueSB0
aW1lcy4pDQo+ID4gDQo+ID4gWWVzLCBhcyBzYWlkIGJlZm9yZSwgcHJlZmVyIHRvIHVzZSBid19i
dWRnZXRfdGFibGVbXSwgaWYgdGhlcmUgaXMNCj4gPiBpc3N1ZSwgd2UgY2FuIGZpeCBpdCBieSBi
dWlsZGluZyB0aGlzIHRhYmxlLg0KPiANCj4gU28gZG8geW91IG1lYW4gc3VjaCBhbiBhbGxvY2F0
aW9uIHNob3VsZG4ndCBiZSBhIHByb2JsZW0gYnkgSVANCj4gZGVzaWduPw0KWWVzLCBhdCBsZWFz
dCBvbiBvdXIgZHZ0IHBsYXRmb3JtDQoNCj4gDQo+IFRoaXMgcGF0Y2ggc3RhcnRzIHRvIGFsbG93
IHN1Y2ggYW4gYWxsb2NhdGlvbiAoYWdhaW4pLg0KPiBCdXQgaSByZW1lbWJlciBteSBlYXJsaWVy
IHRlc3RzIHNob3dlZCB0aGF0IHdoZW4gdGhvc2UgdHdvIGVwcw0KPiBpbiB0aGUgYWJvdmUgZXhh
bXBsZSBhcmUgYWxsb2NhdGVkIG9uIHRoZSBzYW1lIHUtZnJhbWUgc2xvdCwNCj4geGhjaS1tdGsg
cHV0cyAiU1NQTElUIGZvciBFUDIiIGJldHdlZW4NCj4gIlNTUExJVC1zdGFydCBhbmQgU1NQTElU
LWVuZCBmb3IgRVAxT1VUIHRyYW5zYWN0aW9uIiwNCj4gd2hpY2ggaXMgYSBzcGVjIHZpb2xhdGlv
bi4gDQoNCldoaWNoIHNlY3Rpb24gaW4gdXNiMi4wIHNwZWM/DQoNCj4gSHViIHdpbGwgZ2VuZXJh
dGUgYml0IHN0dWZmaW5nIGVycm9ycyBvbiB0aGUNCj4gZnVsbC1zcGVlZCBidXMuDQp3aGljaCBw
bGF0Zm9ybT8NCg0KPiANCj4gDQo+ID4gDQo+ID4gVGhhbmtzDQo+ID4gPiANCj4gPiA+IA0KPiA+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAodG1wID4gRlNfUEFZTE9BRF9NQVgpDQo+
ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FU0NIX0JXX09W
RVJGTE9XOw0KPiA+ID4gPiAgICAgICAgICAgICAgICAgfQ0KPiA+ID4gPiBAQCAtNTM0LDIxICs1
MzQsMTggQEAgc3RhdGljIHZvaWQgdXBkYXRlX3NjaF90dChzdHJ1Y3QNCj4gPiA+ID4gbXUzaF9z
Y2hfZXBfaW5mbyAqc2NoX2VwLCBib29sIHVzZWQpDQo+ID4gPiA+ICB7DQo+ID4gPiA+ICAgICAg
ICAgc3RydWN0IG11M2hfc2NoX3R0ICp0dCA9IHNjaF9lcC0+c2NoX3R0Ow0KPiA+ID4gPiAgICAg
ICAgIHUzMiBiYXNlLCBudW1fZXNpdDsNCj4gPiA+ID4gLSAgICAgICBpbnQgYndfdXBkYXRlZDsN
Cj4gPiA+ID4gICAgICAgICBpbnQgaSwgajsNCj4gPiA+ID4gDQo+ID4gPiA+ICAgICAgICAgbnVt
X2VzaXQgPSBYSENJX01US19NQVhfRVNJVCAvIHNjaF9lcC0+ZXNpdDsNCj4gPiA+ID4gDQo+ID4g
PiA+IC0gICAgICAgaWYgKHVzZWQpDQo+ID4gPiA+IC0gICAgICAgICAgICAgICBid191cGRhdGVk
ID0gc2NoX2VwLT5id19jb3N0X3Blcl9taWNyb2ZyYW1lOw0KPiA+ID4gPiAtICAgICAgIGVsc2UN
Cj4gPiA+ID4gLSAgICAgICAgICAgICAgIGJ3X3VwZGF0ZWQgPSAtc2NoX2VwLT5id19jb3N0X3Bl
cl9taWNyb2ZyYW1lOw0KPiA+ID4gPiAtDQo+ID4gPiA+ICAgICAgICAgZm9yIChpID0gMDsgaSA8
IG51bV9lc2l0OyBpKyspIHsNCj4gPiA+ID4gICAgICAgICAgICAgICAgIGJhc2UgPSBzY2hfZXAt
Pm9mZnNldCArIGkgKiBzY2hfZXAtPmVzaXQ7DQo+ID4gPiA+IA0KPiA+ID4gPiAtICAgICAgICAg
ICAgICAgZm9yIChqID0gMDsgaiA8IHNjaF9lcC0+Y3NfY291bnQ7IGorKykNCj4gPiA+ID4gLSAg
ICAgICAgICAgICAgICAgICAgICAgdHQtPmZzX2J1c19id1tiYXNlICsgal0gKz0gYndfdXBkYXRl
ZDsNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBzY2hfZXAtPm51bV9i
dWRnZXRfbWljcm9mcmFtZXM7DQo+ID4gPiA+IGorKykNCj4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKHVzZWQpDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdHQtPmZzX2J1c19id1tiYXNlICsgal0gKz0NCj4gPiA+ID4gc2NoX2VwLQ0KPiA+ID4gPiA+
IGJ3X2J1ZGdldF90YWJsZVtqXTsNCj4gPiA+ID4gDQo+ID4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGVsc2UNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0dC0+
ZnNfYnVzX2J3W2Jhc2UgKyBqXSAtPQ0KPiA+ID4gPiBzY2hfZXAtDQo+ID4gPiA+ID4gYndfYnVk
Z2V0X3RhYmxlW2pdOw0KPiA+ID4gPiANCj4gPiA+ID4gICAgICAgICB9DQo+ID4gPiA+IA0KPiA+
ID4gPiAgICAgICAgIGlmICh1c2VkKQ0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjE4LjANCj4gPiA+
ID4gDQo=
