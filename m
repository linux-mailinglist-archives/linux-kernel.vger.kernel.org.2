Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3CB3E8BAD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbhHKIWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:22:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55244 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229679AbhHKIWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:22:42 -0400
X-UUID: 6f1d188cd29e4c0990b8ca31a5510ac8-20210811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=A1dtyvSeClUiDW24torobKqHDvRFCWAZVLZ2pQ4M5jE=;
        b=F0KsDmKlGaBW/kDkQ9bQHCFkOok+2g680crTQtFDrIJbTFEJGMpNpMsBFImB91nlL6B9LhdnGJEZE7GyXCRTr43VkeIl5UNGeMJ1swDiEWHQZj0fk+hpr/EwzVfVH4KGqOVKEoKGPnAJRizk+g75hgy/2N8spoPWRWM2gzKzarA=;
X-UUID: 6f1d188cd29e4c0990b8ca31a5510ac8-20210811
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2072867624; Wed, 11 Aug 2021 16:22:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Aug 2021 16:22:15 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 11 Aug 2021 16:22:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqSpwJ0oXv/NxMW4RrNCQWPBG9eA60Lp3NXgNB3gvo3T53o95hZhiT1YmR8lfouc8PxhyETDFDhCjBSU0wMuWdNU86iUxMj9IrK6ocFX7DzW0EKJESi66Y8QbaT+7BbHmpOQHv8btVgXrCUSyl0+wmM1bI0+Hld+XTU3bm8aTQlCkHjj9LR4TyITclt8dokmGWbWfXT+t7tslDDDA9GNsF57vJTrQG2odYKk0lAr+GwvipAu6wCrR/ERF4xM32nLYPHwbF8Z01a55Gkv7zDzYlNduni+sRTflejwkiojVe55vRYBLpcZH9PkYxmMoZjCp2WhSzxEG1JvBUbB1cn9Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1dtyvSeClUiDW24torobKqHDvRFCWAZVLZ2pQ4M5jE=;
 b=JE4x/lIqntdNNznEsyYoF3xxb5lhyfo9ncb6D304mftwO59Ainu5SdzRdZRD51I+ia0DSmMsjKxa1JAxS8x+VGSrYHu79xeouusjRxhnc/ka+EtTJQDNFhENDQCnZgEu9VDzmxkDQOITOLYtZ9On47HnDjodidgY9vP569f2tovyt/dg6sLZA6I0dmQ7gS2ikD4ak9oDlDmjSumUDgWGZfqBQptm+sRdSyxF9dkEeqlI2vP2zqaqkT0dIMv0HvIrMzTwjBuZ0Bctt8x2FnbHOif6vyRqi4f3iVn66De7j/cawH8fdXu7XAJdGSvwOeMa7bopPaaYXFTxRC5B2epZ6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1dtyvSeClUiDW24torobKqHDvRFCWAZVLZ2pQ4M5jE=;
 b=OZSWwyQkA/UqGZI1h3/4wTOQjzHi63dg8Z1rHREWQy+QQdzgriS/go0Swc/57cXBy1vjkrRIQn2NvLlpmxPIvgwdW37DB0CSaJ+Ll/Yjm/4+4Pnpc+AA3ek3yiZw2wSnLF+RtfgdL0mAdeH3fMtpi/8Bu8IdqdDaAaQCl/S4gPg=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR03MB5013.apcprd03.prod.outlook.com (2603:1096:820:1a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.7; Wed, 11 Aug
 2021 08:22:04 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608%7]) with mapi id 15.20.4415.015; Wed, 11 Aug 2021
 08:22:04 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "ikjn@chromium.org" <ikjn@chromium.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: xhci-mtk: Do not use xhci's virt_dev in
 drop_endpoint
Thread-Topic: [PATCH] usb: xhci-mtk: Do not use xhci's virt_dev in
 drop_endpoint
Thread-Index: AQHXibwxcFIct+uqAkm4YZOXlp9NAKtuAHYA
Date:   Wed, 11 Aug 2021 08:22:04 +0000
Message-ID: <e7e8be5ff6e070dab40368a3c59dda21d1816c94.camel@mediatek.com>
References: <20210805133731.1.Icc0f080e75b1312692d4c7c7d25e7df9fe1a05c2@changeid>
In-Reply-To: <20210805133731.1.Icc0f080e75b1312692d4c7c7d25e7df9fe1a05c2@changeid>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2011b212-1d5e-4883-c60d-08d95ca11a17
x-ms-traffictypediagnostic: KL1PR03MB5013:
x-microsoft-antispam-prvs: <KL1PR03MB501334CFE2FDDDB8CD5BA6EAFDF89@KL1PR03MB5013.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T+6nZkvF8xrYk9093CD83pVY5x4X22xHpuB3G0iGFJtL/ZuCCkHq8+/StEDvCDcwR4D6im4yx1fHcPE7wEXaGx7NMP67z4RIHyS0xoaiRzZvlnh3ddEYbcdHiDwCOCjHuaSmZ9u8v+iCCPZRS+fuHUPDTr9fM9wBMPU2mn5ceTrvlaejQHKOln1Us7zBu7rLplg9aG/tkDLUugxh5He2Ji9aYPZw3QgHm+y0Cju32EnodFriww4R7UAVwogKSVwLUyNKwRBn48c/fi2HRt9L1mpjXdRwbNzZeAGTSPDmaPXlgApxHwuntlRkNsttA9iYI/tRGV4ACYzzVP+M5av4akJ5FWF4tBxPnNINR63dAnrU7XOXWVa4a7olbFVOtSSQvZ7Ih15U9/iu+H29PhFVPZLm+XoQkDynON9997wKrldyEQtApOqMUmbOqUnITZX0ui1p/wJPH3bYOZbFfxRtdUc2B7VALPs1vae8l0wLWgIVAMyF+eTuqJP5aEfotGVUQZd4OyEECM+qeSxjBAbp+BOl8t3sbLuKQ7qyyMpgf/qwjjT68nWw+0dxfKwmzTr9IE2p+Kcd1fP26/HDsvgcGE73+tbKYeJ/7BAh4QTfh8brDzUbxvzsZtCOp3EKJ4kEnfVUPk4+70hR+3wXswwWhXRmDNSU1kVhzT/rdiCti5qZ6YwCYRzPRYtOosgjGtyhjqVXjPEIKOPiiCIKR5/L/4HvLv3u9M9qnbyQC4aH8UIrL7xna1qZdUSGT3W4LBMZFvRoiOe4bCM8JS37/bFJLqbpg2S4NXipYzZExt/68s4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(38070700005)(76116006)(83380400001)(110136005)(122000001)(66946007)(91956017)(966005)(71200400001)(498600001)(38100700002)(4326008)(2616005)(186003)(2906002)(6506007)(26005)(85182001)(86362001)(6512007)(5660300002)(36756003)(8936002)(66446008)(64756008)(66476007)(8676002)(66556008)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjNvWkJhMTA5OEZ6K014dGtSaXlqSmYrZHN0KzFDVDlNb1NXUXhMVjlPdS85?=
 =?utf-8?B?dDdwdG90WE1hYUlLRFgrVFhlS1V2aHpSTDhYVXpXZ3Q3Wm9iYUR1T09Ta3JJ?=
 =?utf-8?B?azROS3JmSm5wcS95TEczbmtDR1kvczhCTzVQSmpwL0FUNm1XUS9aYWtGaXhl?=
 =?utf-8?B?ZjZ4cnlHNHJxNTRoSlZqQmRudHd0TEgxR1Z3c0pEODB1Y1FOcGMyUllUaW81?=
 =?utf-8?B?Zm1xOXZ6YlpVelN0UjJtSjFWRjZzT2tZTnlMb29iSmpHd0RSVlQ0WWRtS21O?=
 =?utf-8?B?Y1NQaW1QV2ZONTd3b1I4bmFuaDBUT2RXbnVOMWN2MjFQR0dQZ1h2NzFIT1Aw?=
 =?utf-8?B?SERCYWg1MmVoTG1QZXl1ejE3UnVLbnBJZHVGOE1RWXNvVmhQZWhpUzJ0eDIw?=
 =?utf-8?B?Zk9pT25qMTJncUtpbStyMWVVSklFWjgxaTdDVTcvL2ZvYWhvaDhRR3VORUwy?=
 =?utf-8?B?ZC9NMTNQeHRQMkZzNGYrMXRnSUI2Yjl5THc3N3JObWw4Uld1WnZrUFo0Y2tt?=
 =?utf-8?B?eXM0Q1hQM0czcjJUQ254c2tTQTVXYlJSZndFVDRxK3JjZ2xqTXVSb2h0SFNs?=
 =?utf-8?B?QXFjYzdNUlNrQXFLS3NWbFJrR0NDdHJkVVhZdkxIeGYwRStrL2tWTWMyRC9E?=
 =?utf-8?B?RGhCRyttSXZYMDA0czk3aFlMN29KQlQrRzlFUE8vdnZCd2s0Unlkc3ZPY214?=
 =?utf-8?B?QUtOU055K3pWRjZkQWpNYkdtMkI5NWQ1bTJsUG9QQXFTaHZ6Wkh3M1lyV2p2?=
 =?utf-8?B?QVNDSWllSE9vN3QvWG82SmlaWUk2aVZYdlZpcTYxcHk2MkE0aDJmYWR2KzNz?=
 =?utf-8?B?bm1JK1plWklyV0ZjNGhzNEhpYjY4a2ZuRXMwZDJQelNaMEFpekxnODlqUmt2?=
 =?utf-8?B?OWN0K3lpNXBiUlBERkJVYWg0aWFCRHlhMUgwNWNLeXN3d3VrR3lRTmg4WDRk?=
 =?utf-8?B?WUJ0NWtSaTZXRDk4aVY1RmIrcGhKMTVub0daenVPWmttRXQ5bWlTRStHNDZk?=
 =?utf-8?B?THl0UUd4MVR0UmJoSWdsYVNhaE5XSCtPY3pTczQ4cm4vQlNuVnR0bnZXV3hP?=
 =?utf-8?B?ZWwyNVhSL3lWSWlPS0lUUFI3M3FEVjZXZWIwaWtIUkZqZ0U2bnZYaDR6dzV5?=
 =?utf-8?B?bWFDLy9oTTlZKzV6bkdGRE1DQlpNUktrT2FXQy9kR2I0TWJnamRCalBFZHIy?=
 =?utf-8?B?c3AwY0tlU24zUjdPVDdyVG1IaXJacTI5M3B4MTJDZitQb3FLcklEWUZlR2dG?=
 =?utf-8?B?dXlrd0xvR1JpbWVMd25aNktHdXpIUzRtWkE2NSsxQmlITFhoMWNabDJLazI2?=
 =?utf-8?B?dWRXUjZJYU1lNjhBK2lhaE5JQXllSFlydTBDWlpSQ2ExMFpkTEt1MmhoWjlT?=
 =?utf-8?B?cjN6WmtaK1k3SDRuK1E4WjFwL2taMUdicDJmRFBoTUNBYTluWU1Gem5WZVVO?=
 =?utf-8?B?UTh1c2ZjRUJVVEhMeEh2L1NEeEZNQU1pK1hVZjh2NUl1eUtKZGZ6TWFrTklU?=
 =?utf-8?B?c1JuMGFhL2QvKzVUcHg2NXBrUnJDQ1RMb1E5OUNSQUJuWk9ybFRES0V1Y3Q5?=
 =?utf-8?B?UlRwV3M4S20wT1FSb3NyU3U4eStyejNKZnQycVhLSmFCcU5jUFBRS3kwRG04?=
 =?utf-8?B?YjhtZ2VzVnJIVGVlWGFJN3ZTMmtDbVczZVdnTHh2Qlo0MDN6TlhSMUNXOG9n?=
 =?utf-8?B?azVySTAreWdWUEhjQlpON3VRRFFDZkN2ZnJzZFM5cjBrN1oyY21xalI1VE5P?=
 =?utf-8?Q?w1gyRO/SgIf1/e3RpykdQV2+9BPuzXycQLj2hIL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F9900260940DE4D887B1492A7717655@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2011b212-1d5e-4883-c60d-08d95ca11a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 08:22:04.5652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XcHWVmAESjAKCCjGdPQggxe57N1VBWeUgPFfTsba8GZQ3rtfZ0OJo+42E0rUNX+rnMJZbE6YHtpTCCLGcWmEz1XYTFuePMnZAZhJBeL31SU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5013
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWtqb29uLA0KDQpPbiBUaHUsIDIwMjEtMDgtMDUgYXQgMTM6MzcgKzA4MDAsIElram9vbiBK
YW5nIHdyb3RlOg0KPiB4aGNpLW10ayBkZXBlbmRzIG9uIHhoY2kncyBpbnRlcm5hbCB2aXJ0X2Rl
diB3aGVuIGl0IHJldHJpZXZlcyBpdHMNCj4gaW50ZXJuYWwgZGF0YSBmcm9tIHVzYl9ob3N0X2Vu
ZHBvaW50IGJvdGggaW4gYWRkX2VuZHBvaW50IGFuZA0KPiBkcm9wX2VuZHBvaW50IGNhbGxiYWNr
cy4gQnV0IHdoZW4gc2V0dXAgcGFja2V0IHdhcyByZXRpcmVkIGJ5DQo+IHRyYW5zYWN0aW9uIGVy
cm9ycyBpbiB4aGNpX3NldHVwX2RldmljZSgpIHBhdGgsIGEgdmlydF9kZXYgZm9yIHRoZQ0KPiBz
bG90DQo+IGlzIG5ld2x5IGNyZWF0ZWQgd2l0aCByZWFsX3BvcnQgMC4gVGhpcyBsZWFkcyB0byB4
aGNpLW10a3MncyBOVUxMDQo+IHBvaW50ZXINCj4gZGVyZWZlcmVuY2UgZnJvbSBkcm9wX2VuZHBv
aW50IGNhbGxiYWNrIGFzIHhoY2ktbXRrIGFzc3VtZXMgdGhhdA0KPiB2aXJ0X2RldidzDQo+IHJl
YWxfcG9ydCBpcyBhbHdheXMgc3RhcnRlZCBmcm9tIG9uZS4gVGhlIHNpbWlsYXIgcHJvYmxlbXMg
d2VyZQ0KPiBhZGRyZXNzZWQNCj4gYnkgWzFdIGJ1dCB0aGF0IGNhbid0IGNvdmVyIHRoZSBmYWls
dXJlIGNhc2VzIGZyb20gc2V0dXBfZGV2aWNlLg0KPiANCj4gVGhpcyBwYXRjaCBkcm9wcyB0aGUg
dXNhZ2VzIG9mIHhoY2kncyB2aXJ0X2RldiBpbiB4aGNpLW10aydzDQo+IGRyb3BfZW5kcG9pbnQN
Cj4gY2FsbGJhY2sgYnkgYWRvcHRpbmcgcmhhc2h0YWJsZSBmb3Igc2VhcmNoaW5nIG10aydzIHNj
aGVkdWxlIGVudGl0eQ0KPiBmcm9tIGEgZ2l2ZW4gdXNiX2hvc3RfZW5kcG9pbnQgcG9pbnRlciBp
bnN0ZWFkIG9mIHNlYXJjaGluZyBhIGxpbmtlZA0KPiBsaXN0Lg0KPiBTbyBtdGsncyBkcm9wX2Vu
ZHBvaW50IGNhbGxiYWNrIGRvZXNuJ3QgaGF2ZSB0byByZWx5IG9uIHZpcnRfZGV2IGF0DQo+IGFs
bC4NCj4gDQo+IFsxXSANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8xNjE3MTc5MTQyLTI2
ODEtMi1naXQtc2VuZC1lbWFpbC1jaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBJa2pvb24gSmFuZyA8aWtqbkBjaHJvbWl1bS5vcmc+DQo+IC0tLQ0KPiANCj4g
IGRyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2NoLmMgfCAxNDAgKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLQ0KPiAtLS0tDQo+ICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmggICAgIHwg
IDE1ICsrLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgODYgaW5zZXJ0aW9ucygrKSwgNjkgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay1zY2gu
YyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS0NCj4gbXRrLXNjaC5jDQo+IGluZGV4IGNmZmNhZjRk
ZmE5Zi4uZjliNGQyN2NlNDQ5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2kt
bXRrLXNjaC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2NoLmMNCj4gQEAg
LTgwLDcgKzgwLDcgQEAgZGVjb2RlX2VwKHN0cnVjdCB1c2JfaG9zdF9lbmRwb2ludCAqZXAsIGVu
dW0NCj4gdXNiX2RldmljZV9zcGVlZCBzcGVlZCkNCj4gIAkJaW50ZXJ2YWwgLz0gMTAwMDsNCj4g
IAl9DQo+ICBQbGVhc2UgZ2l2ZSBtZSBtb3JlIHRpbWUgdG8gbG9vayBhdCB0aGlzIHBhdGNoLCBh
bmQgdHJ5IHRvIHJlcHJvZHVjZQ0KPiBpdCwgSSdtIGJ1c3kgd2l0aCBEVlQgdGVzdCByZWNlbnRs
eSwgdGhhbmtzIGEgbG90DQoNCg0K
