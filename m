Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363F23E8BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbhHKISp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:18:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48276 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230474AbhHKISn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:18:43 -0400
X-UUID: e4fc9ce1103f4585b64fe6f4163aab13-20210811
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LvvjlH1rJJ0T1VOPrhG8KBDMTioHDZOAcy4aIVQtQdM=;
        b=QZ21bF0Bc85suV0IUhxeg3j3JK2Cvsy4AwANA6YDPrle4MNQ0uCHlcyNRcKkVkphnt6m/CQkUcvAYKGUBc6+g6PJx7BUYq+TzDCcrCD+FMr9UrlcBzwLmFHAAJsgrZNlU4bdW9B1rpMNgYE56rr+PvdWjK4oHkhJfTrefGIq260=;
X-UUID: e4fc9ce1103f4585b64fe6f4163aab13-20210811
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1693293575; Wed, 11 Aug 2021 16:18:14 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 11 Aug 2021 16:18:13 +0800
Received: from APC01-PU1-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 11 Aug 2021 16:18:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ol+NpulFIJadeXgZ4YScJV87KxRb13QTuX/IU24bsvRFG1LTS5N0sFEJr2VRE0OsRHXBpsOQ1+T3Nvqil6q+/NwPJL5lNv/x526TvDjol2UL9mkJiQz9dissL9QyxnDZPmP5XM41mbCi3fJwBL7LwymfjLfZVZT7NA9eefo/9UzW57zLRS50jQ2+Y/+t3ZFBmiNIl44tbXFShWvnGglzrFhRZzZW4jlHjFFxSa3rtvP25o2qEUh1np/TLLh+GL1yPlBSr8vfnjwkG277czXZ1vQeGu1MX6IvT8OSNt8HENZv6Lcq6lyAJEvu28ud1GcuxyOKCok81anOFMEsbWeSHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvvjlH1rJJ0T1VOPrhG8KBDMTioHDZOAcy4aIVQtQdM=;
 b=KTq3xsFdB6r+syPXfjLICSK11zhS2RZW+lJ1iliGplrMZzyHlRAiLEWjEwmoU29ZDI89nXw/nvjTsvGOYUiENWNf+AMrgMqxciguufT95IeCyvYK4V5nQwkHpisYr/96rbeyT270JPKPg2ZK1H0Ct2JaS/iQ2SalfwlqvS39knelTaYbDyuvYbcGxB5b8NvL3ybaXgadwSY/a4UBbjUl5JMMcO21XcpavrMdJ5W+wpb34WKE+lZXNT6ZsH0p+G4k8GL3MOml0W5BsxggmNySrXiBTBGKC9FAKfCwjpqiPnqHTcSC+1VUSVIdfcbjPOQtcvV8EvE0VBKcLGJbPosVBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LvvjlH1rJJ0T1VOPrhG8KBDMTioHDZOAcy4aIVQtQdM=;
 b=TZsXDqqu3P/W4kaUMIHRqcMbybi395RuRMrgZWGoSYqr6vT1d71QdEJXNpeQZ5pZeXWY1Dwsa6aZho7MsyCxeEaFR7CZYYeDzaM0NAuK0U9OrKzyZrtG4Pt4WpHaZDmtkkNbsS0/mzcbR8TyZ0kR8gryxa6FepDIeolbx26q9mU=
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com (2603:1096:820:1a::22)
 by KL1PR03MB5013.apcprd03.prod.outlook.com (2603:1096:820:1a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.7; Wed, 11 Aug
 2021 08:18:02 +0000
Received: from KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608]) by KL1PR03MB5062.apcprd03.prod.outlook.com
 ([fe80::3ce4:e30e:bb67:c608%7]) with mapi id 15.20.4415.015; Wed, 11 Aug 2021
 08:18:02 +0000
From:   =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= 
        <Chunfeng.Yun@mediatek.com>
To:     "ikjn@chromium.org" <ikjn@chromium.org>
CC:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mathias.nyman@intel.com" <mathias.nyman@intel.com>,
        =?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= 
        <Eddie.Hung@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 09/11] usb: xhci-mtk: check boundary before check tt
Thread-Topic: [PATCH 09/11] usb: xhci-mtk: check boundary before check tt
Thread-Index: AQHXhSA6issZ72MZPEyQzPZQeGJZgqtq1yyAgAMxYQA=
Date:   Wed, 11 Aug 2021 08:18:02 +0000
Message-ID: <75f8dd3285046fa85e10b776c758b23b1f408a24.camel@mediatek.com>
References: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
         <1627635002-24521-9-git-send-email-chunfeng.yun@mediatek.com>
         <CAATdQgA4qwKb=Uee1pUj-Fk8G31zA40OD7o49W1YLUhZh7BHWA@mail.gmail.com>
In-Reply-To: <CAATdQgA4qwKb=Uee1pUj-Fk8G31zA40OD7o49W1YLUhZh7BHWA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 806ec9de-d917-49b8-e6b3-08d95ca08991
x-ms-traffictypediagnostic: KL1PR03MB5013:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KL1PR03MB50136858C55F93AEF192478FFDF89@KL1PR03MB5013.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qMh7mn6P4C7ovkVg7PC4rZSVb8ZOTNmX/09FSr/vIQxznEjcdcFANz90rNH3W3L0947HQLM+535RRtsimAYpza0dD/FDZB5EmDd7+LwL9Hrju4+bbZVN08h54PEtNPxKqXmBJ3Nc2vOv6yyl5yJ010mEvxM4QEX7nL8NstoUEQS7+wtHj4KIxlTo4u0tYBbPsKt5VfdTwm5frefE9+SXxlyfAZloGpJCdO4+5OEDYT+LmNb3oZ262EF8g03NAjN8OlvQkbWdhXKVrKMQFcQ+arYv0owJcpLtcoo4f2k/80CeNT1tt/mKOew28hxQ6QNmaT3IKS5zdf0sjvG1FunB7ty5GziY0afj0OTFau6ydeB7ZsvbHXQAYUtWbHigTIyDUPajuEWPreFbj4h6PMPfrrGee79IF/ogZ1VN+LACWOtgvHFBVoVoTqeKpzGK2sQKWBeFJUvvVzdHSTbrtk891Zky6Lh/bW8JFW5zHRKFUGIjXuv+Dt7iA8OSItK3qacKDLpdcSEY5PvE5BRoRe8SBhn9Pqq+bXyII2o89rsEP17DAt47rAyGourRt6CNDVl/9JaIVpY4WczwJ/zYZTdPpcQTyWQRkwq9m3ntwuJR1oAVVC66yqm6z8YdjpIPTkysvs3RUFG2S4bDrcBtMYgbBWnBnZiTC5VQn8IEGwqTwVF/TE8LRvplAYZx5WTAGh3+ZmS0HsOFIUKmOHCldq6uPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB5062.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(6512007)(36756003)(2906002)(6506007)(26005)(85182001)(86362001)(6486002)(53546011)(6916009)(64756008)(8936002)(66446008)(66476007)(8676002)(66556008)(66946007)(91956017)(122000001)(38070700005)(54906003)(83380400001)(76116006)(38100700002)(4326008)(2616005)(186003)(7416002)(498600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3k0RHVtanZaRTJrOVZhTTVXbktaNlFjUEIwVGxkV3dsc2IwSWdPTTJ4SEdN?=
 =?utf-8?B?STFxVHdxa2s2NHpHNUIxVjJtRWZad3R3NUJua3FESVdNaHhTRG44VTBuZitH?=
 =?utf-8?B?VWNZcy9lbG5MbVhwNlRDRmsvMmlUZ3NHNXpsakZ4eW4zOXZKRXprczhwSkM1?=
 =?utf-8?B?SUc3NWNpeGh4TjZNZEFzdFVyVkNheDdJdmlRa1V4WHBNQnhVc2pmc0xPN3Qy?=
 =?utf-8?B?WmVkOTNFQzlRK2JjaVdjVWRUVUdNWS9LdDJhbTV2T0hSeWpLWnNqYW84cXNr?=
 =?utf-8?B?MW55cFl6QW5MWjU3MVpkZ3Y2VGplMnpGYTc2aVYyek9JYVNpSW5JMERydVEv?=
 =?utf-8?B?MldEVk1rUStIdDRQZVBNRFRwKzIrYkVmckNxMDBGK0RZN1ExeGZONVFWem9O?=
 =?utf-8?B?SkJNOUZHaU1CUWRUb0k2cis0aU8zRXI4M2RCZisxM2FtNit4enFYSHVkQ3pK?=
 =?utf-8?B?RzVjcnVZVU5odjh0TVBqdWpJam5jZVJlZG1RYlJLc3kyS2U5eU9zYlFTSGN5?=
 =?utf-8?B?aGNMV0hyeVIyY3hGenBSZDc3RWVYWDZxellSazBKLzNEUXU3THJUN0RuUVpG?=
 =?utf-8?B?ZEpacGJhUDJrbkIvSExkZXZyNnZiTHgweHJoRnNUc2hvVTBSMmtoZk9qNTZm?=
 =?utf-8?B?K1R1SFpDQnhUVHRZT0dNRTV4Z0JHUnhWL2J6UWlDb3FDVDdqMGtwZ2dWcVd0?=
 =?utf-8?B?cW9FOEo4WGlaOVJGMlZOdFhwSXlRSm5yNThvYjE1cnJodkpaUmt5V0RxSTY1?=
 =?utf-8?B?MHk4WFUvdzdvelVhM2FwWmgzaGpiaG04N1prR0lLYXBtM1JvRm5CZGlBc0JD?=
 =?utf-8?B?azZlVm1zVStxK05vOXhPcXFtVzBIYXNOQ3lmcGt5elFYakFJTFFkb01vNWoz?=
 =?utf-8?B?NzFuV1I1aFh4Ti95M1VrUWk4blF5czdlSjZYSmJDTWpwVW1pckViN3l3L1Y2?=
 =?utf-8?B?NWpJMjZscDVTR0c4ay9PdjZMZnUxYW0xT1EwdFhodjdsaUNxU2phYjh2R1NG?=
 =?utf-8?B?RHNwanJnRDZPbXB0aWFUaFh0eS9HMGpydVVUT1FQWld3WGdaeFlDQVBVdVBG?=
 =?utf-8?B?R3E1UlUwRnNGMm91d0lpajM5eVRENEN2N3VxNFZvSjhzWk9BVS9RWnlOTWhL?=
 =?utf-8?B?LzJsa0dOaVZ4bDRPQlVzb055TEE2bGJ0eWp3TEpGYk5WRlF6ZmRIZ3Q4dXhC?=
 =?utf-8?B?eGU3UHZVS1lqRUpTajY4eElpUlQ2YnhTeU4wV0pLbjRWS1ZWVTVGRkN6RkFk?=
 =?utf-8?B?VEZRRWJWeGg5cGVJTFUwc3RadUhsNWUxdWVWcE1EOVJtZlppSlJpaXh1V2Nv?=
 =?utf-8?B?UnRyTDlMVHNWNExpbU1mdTl4OHIwSDlWc2ErOFBVcTJJYWJCQy9kN0FLMmla?=
 =?utf-8?B?MDFoSDBIWHBCODZwSkJYUGRSYkVWM2FTd1E2dnBUN3h6QTZ3WEpWU3pwNWMy?=
 =?utf-8?B?Z1V6RXFSTENmQm1VYmJtYUdrcFB5ZTVOTDByQXlNNTU2ZGZVNituMEpyY0Ur?=
 =?utf-8?B?QkwzKzNsNEVGT2VKOUxjVTNkcW0zMXM3WW1QOUFsZmFEb3JBTjd0TVhQaWZR?=
 =?utf-8?B?ZGZrbmlyR0NZbzZaUWZ5RmQwalNuR0xjQjE2TXJScTVIcGc0M2Z2YUtXRWNK?=
 =?utf-8?B?d1B0c3Qrd3A4NTgrMTZMWWNPbEFxaGRmU3c4cUZNbDBnclpoU2tqcGx5bnF3?=
 =?utf-8?B?d2x1NlBmazlldGtzOUd5ME93eVNZU0ZybUlPZmlpWlFEdkVnV0lxaEhISG9q?=
 =?utf-8?Q?M7KI/KVF9y+spZaSBVnoNShWzAt4ZwmFu84HpR1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <88F7E38B2AAB8440A37DBD1D6C276FA5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB5062.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 806ec9de-d917-49b8-e6b3-08d95ca08991
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 08:18:02.0929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mE5WUZw9pQAmpdxrya1G9DuMZie1/XujY/3ZtGjgnXp8SbI3jpHI1QtH5yrnlP3p0s67CyJG02TyBa+0vwURtPhWGRkkdTcXlTxRbsjN+JY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5013
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA4LTA5IGF0IDE1OjMyICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
SGkgQ2h1bmZlbmcsDQo+IA0KPiBPbiBGcmksIEp1bCAzMCwgMjAyMSBhdCA0OjUwIFBNIENodW5m
ZW5nIFl1biA8DQo+IGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+IA0KPiA+
IGNoZWNrX3NjaF90dCgpIHdpbGwgYWNjZXNzIGZzX2J1c19id1tdIGFycmF5LCBjaGVjayBib3Vu
ZGFyeQ0KPiA+IGZpcnN0bHkgdG8gYXZvaWQgb3V0LW9mLWJvdW5kcyBpc3N1ZS4NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2NoLmMgfCA3ICsrKyst
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay1zY2guYw0K
PiA+IGIvZHJpdmVycy91c2IvaG9zdC94aGNpLW10ay1zY2guYw0KPiA+IGluZGV4IDEwYzBmMGY2
NDYxZi4uYzJmMTNkNjljNjA3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhj
aS1tdGstc2NoLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLXNjaC5jDQo+
ID4gQEAgLTYwMCwxMyArNjAwLDE0IEBAIHN0YXRpYyBpbnQgY2hlY2tfc2NoX2J3KHN0cnVjdA0K
PiA+IG11M2hfc2NoX2J3X2luZm8gKnNjaF9idywNCj4gPiAgICAgICAgICAqIGFuZCBmaW5kIGEg
bWljcm9mcmFtZSB3aGVyZSBpdHMgd29yc3QgYmFuZHdpZHRoIGlzDQo+ID4gbWluaW11bS4NCj4g
PiAgICAgICAgICAqLw0KPiA+ICAgICAgICAgZm9yIChvZmZzZXQgPSAwOyBvZmZzZXQgPCBzY2hf
ZXAtPmVzaXQ7IG9mZnNldCsrKSB7DQo+ID4gLSAgICAgICAgICAgICAgIHJldCA9IGNoZWNrX3Nj
aF90dChzY2hfZXAsIG9mZnNldCk7DQo+ID4gLSAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ID4g
LSAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4gDQo+ID4gICAgICAgICAgICAg
ICAgIGlmICgob2Zmc2V0ICsgc2NoX2VwLT5udW1fYnVkZ2V0X21pY3JvZnJhbWVzKSA+DQo+ID4g
ZXNpdF9ib3VuZGFyeSkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCj4gDQo+
IEluc3RlYWQgb2YgZHJvcHBpbmcgaXQsDQo+IEknbSB3b25kZXJpbmcgaWYgaXQgc2hvdWxkIGJl
IGNoZWNrZWQgYWdhaW5zdCAob2Zmc2V0ICYgNjMpID09IDAgd2hlbg0KPiBpdCdzIDY0Pw0KTm8s
IHNjaF9lcC0+ZXNpdCBhbHJlYWR5IGVuc3VyZSBpdCwgaXQncyA8PSA2NCwgc2VlIGdldF9lc2l0
KCkNCg0KPiANCj4gPiANCj4gPiArICAgICAgICAgICAgICAgcmV0ID0gY2hlY2tfc2NoX3R0KHNj
aF9lcCwgb2Zmc2V0KTsNCj4gPiArICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gPiArDQo+ID4gICAgICAgICAgICAgICAgIHdv
cnN0X2J3ID0gZ2V0X21heF9idyhzY2hfYncsIHNjaF9lcCwgb2Zmc2V0KTsNCj4gPiAgICAgICAg
ICAgICAgICAgaWYgKHdvcnN0X2J3ID4gYndfYm91bmRhcnkpDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgY29udGludWU7DQo+ID4gLS0NCj4gPiAyLjE4LjANCj4gPiANCg==
