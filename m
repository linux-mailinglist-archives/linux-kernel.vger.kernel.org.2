Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027C937502F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbhEFHbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:31:55 -0400
Received: from mail-eopbgr1400040.outbound.protection.outlook.com ([40.107.140.40]:10592
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232271AbhEFHby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:31:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYc0pmDR5q6D0sRlGKBzc4S5hQyn5oGLr5bvLDq4vdrNx+9bJUJ4gVk56Kdxt2wCbazQpvWjFj+YpgSIBQ80ntFJer801CSPILmoL/ptyodOAEa+LtxYKQkgQaryoTo+8X09u8KX4Uvi916ibxYiixzqaw8lGQcMzoshuBu36Ysr0vO6in10O+v3eAhHcxgrPq5fSN4Vd62iGgJmk+GY7i8Vn6HjWspWyXJ8Kny2Mfk3IQsQ54ygd3bt0VfdGxP4dGqgkbkEAKVllwi3AMYXu036BBwu7WwVRVPcC5+hrkk7l77eDulXLaSfjzFyhpyo74AqtsksmdqljvRHKzXjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUcPWnOxMBx+92GlOjobZgma9YjwiLEnMoI2pgatpGY=;
 b=L0UGwc+TMbFro2ClXuXYfitet9/naaflX+lB0LACayttN/YGgo7XyD/HleV6A5HYKD0rCdNONiuaguG7VWMAqZXer6YpXk+fjB16jYxPA8IC+3BjSeoEo/AefBZ0l6F4RaJZg/80dIulriJjdSxmtlrk0j5iTa45/r4PpLT7/G1QLaIliISyADsx7A0khslu+vnbmU2lP7Eefyw9/0h24M9xYVXcfgETaOSvAhn9v0wxmT0kNUUxqpi0P4X40ihNxqTFtS6rnTZarQ7nVIy7ztInkncj7oS308iXkA+D3lMTgUWIlFgBTtGhfcV+1Rdjru5xIuU7UPHA37HJMQ4Obg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUcPWnOxMBx+92GlOjobZgma9YjwiLEnMoI2pgatpGY=;
 b=cO8dUYOJoKLvRTa1WK9Yj5TJhuygaaIMbExAI6DKXVcLo09jGddYEDecnwFpMjv1IEGRjIszbXlNobvwVtkMiL+x9OcfE0hwYhHXcEOyMWp07hW3L7UPG+Pv/pqA3TCMjdZoSkK0usZW+Ze5+FxdleROa1txl/twHwI9p0WA8Mk=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TYCPR01MB6770.jpnprd01.prod.outlook.com (2603:1096:400:b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 07:30:55 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::1552:1791:e07c:1f72%7]) with mapi id 15.20.4065.039; Thu, 6 May 2021
 07:30:55 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Ding Hui <dinghui@sangfor.com.cn>
CC:     David Hildenbrand <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/page_alloc: fix counting of free pages after take
 off from buddy
Thread-Topic: [RFC PATCH] mm/page_alloc: fix counting of free pages after take
 off from buddy
Thread-Index: AQHXNlLKvz3SGzZaekOMSRQ4ewYPVarKEEWAgAvIBICAABQTAIAAOn6A
Date:   Thu, 6 May 2021 07:30:55 +0000
Message-ID: <20210506073055.GA1848917@hori.linux.bs1.fc.nec.co.jp>
References: <20210421020426.5914-1-dinghui@sangfor.com.cn>
 <dd242708-e3f5-ab9f-64d4-9efe3b7168ce@redhat.com>
 <20210506024943.GA1777607@hori.linux.bs1.fc.nec.co.jp>
 <33be44ea-f377-c049-03ff-3b45289ab5f7@sangfor.com.cn>
In-Reply-To: <33be44ea-f377-c049-03ff-3b45289ab5f7@sangfor.com.cn>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sangfor.com.cn; dkim=none (message not signed)
 header.d=none;sangfor.com.cn; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27a7158f-359d-41a5-5c06-08d91060e2c1
x-ms-traffictypediagnostic: TYCPR01MB6770:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYCPR01MB6770E5A7A7198FFEA28D526AE7589@TYCPR01MB6770.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3UOmho3zMK/f8Y97XJYHll1XzPFE+amAf++0a9uU+NOVhb28Xc37i4Ttq9gGuSpRGdCGbVhY9LG9rnmeWYNPKXerSXTkDZyLKvcnDo0lZyiikGO10M63lliDcr9pzscdWlU3mtiW22EzHx+fByHwBE61BIdIfwcf9WKYylJDc63fwBXD4n6LvAKn95zXB1XzfXCYQNeLdb36Pz1j4j+uSauLLLBMy6fXn5Udg7VWTvpBOBCF4a/urLaL7UFh0RzfsxnTGAwF9IaZ4U4yMwVU7dpZCkHmpQ2PXvJ1CF5eG/BBZJRLUhU+Quw6sBBLJukxkN1xbhpvm+GZ3ohdYaUL3nLJPVTSLcxGg2bNjCOIHGbPXKZJeurtlafUjsBML41VXz85zREJ/S+rS3wAmweo/DBrLZib1wbnYQrHExlCY2uzgxrDadZ6HWphui4D4kE84vWw+B2h44GxAVtvxiCAgIVu2H6Q1bT9fGq3f0Mni05oYg31MNIs65n7/ePd8ANrq8nBF97Q5I2bxZiVhq57gj8WcRYrQNNlC0JHr6xlbQlYPXygoXysKSo3P384M48yVP7+3/aRm/FFCMi5qHIdIyLW7QBHWK66OS2h55uJsF+O1mt9R1nYquArkwoP9IwlUGSeul3xJFQNyCFXpmKVM7CbjVaC5rbAAzk2yo7A+Vl2VLBNFPvDm1RnThAlrKmd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(71200400001)(6512007)(966005)(316002)(186003)(2906002)(8676002)(4326008)(53546011)(55236004)(66946007)(66446008)(76116006)(66556008)(64756008)(66476007)(33656002)(9686003)(38100700002)(122000001)(6916009)(1076003)(86362001)(54906003)(8936002)(85182001)(6506007)(478600001)(5660300002)(6486002)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RFdRZGNqMks5N3Z2L1Y1SzFqR1VzYzM5aWNaR2pEYXkvZFp6TCtGL0packxy?=
 =?utf-8?B?UjhOTmpDRjZzWTVuczJLMXBqWWpoT3JVOU1EOUdzK3RjTUkvOERzd1VNWWhU?=
 =?utf-8?B?U1Mrdk15TjZrSkx0YWFrN2FxcjIrL3pvZzRwZEEzVlJzL0ovTGRTMG5uQVZF?=
 =?utf-8?B?MnVnNGppbHY1TnhiM2xvb3Y3aXROajI0NzROdWNLRU1oT1hKcktPSk1xdHcy?=
 =?utf-8?B?QXBkbEJETzFQaXZnQ1ZWS01zdE9iaTBLMThsbGltZGt5blNsT2hzT0tQc0RR?=
 =?utf-8?B?bGgwbW14MHMyZktPZnJOZ3FXT1h3N0w1NWZvN3VmamV3WVdvUGZ2UG9nZ2hT?=
 =?utf-8?B?SklZQTRUMDloSVgwc1JUc0V5anpKNDNqWG5nL21yZU5TUDlQd1psT3NYeU03?=
 =?utf-8?B?b0VlcE1sWWlXUGxtN3JCL2pLYXVNczVQZjAvNmJzcUwvelJBWXJodzNSNmFH?=
 =?utf-8?B?S2I2S3JvVXFrMXNndHRzRWV3a0hrYWN5WFZ0dHhIL0h3cnZaWVVwazJudUpD?=
 =?utf-8?B?ZE5oOWo1V2FKNHh6Z1poUkpNbWZzbHJoVytvVTN3STk1OHlRemo5elVSdWFU?=
 =?utf-8?B?a3JTbWxBd0xUSjI1V1hEZ3AzalRqVW9WNmpJZHZxTTlsN3llYnZ0WWRFQjFQ?=
 =?utf-8?B?QXVhTW4yTkIyMzdmWU9qaGpSZHZQekRPZGU1b0VDYUl0Y3oybCtPVFdueTh0?=
 =?utf-8?B?bU1LSnliRHh5aWFLQ0Z2Wk42VjhGRGhOdUFjLzZJQnVTSExFZzNsaE9QazZV?=
 =?utf-8?B?eU9Vak05Z3gvVUZTWTJsU1ByOFJjUm9rczJiVHFudjdpUkpNblBLQVBmR0Fu?=
 =?utf-8?B?NGt5dFQrallCMldKcnlLZkU4OEVDbUkzR0pOUFdmelAwOHJnbFhZMU04b1Q4?=
 =?utf-8?B?b2t6bVVSK1UwbVdITUMyRG03TWpRaWQ1NmZPU0FNV3VhU3A3WHlHVEVHcGtW?=
 =?utf-8?B?ajBvd2J2emhqMTd1T0FkdlJEUi9pOUxwV2h4K1dSNmY5NXRuejdHNGhIOWF5?=
 =?utf-8?B?NEJaUU9ZTDlCNkJiQUtFWVZ0Sm5EalV5MXFwVU9CaFNBZ1d1ZHJ6azZMQzM3?=
 =?utf-8?B?eHZPTHNReVFZeDREd3EvVFlqUTFKb29DRCtyMmR5dlIyS2RwaDJSNDBhMkEy?=
 =?utf-8?B?N1VuTzNRdXVyckpQUUMxVU42ZjNLeU1VMnpGdUczeStOU3JmdWxwUldKcU5q?=
 =?utf-8?B?dllwa3RNaTFXSmFkWUZjcmNkMmpoQ2Qzd0NnajhMOS90Nmt1WnhNbHYwQ3pU?=
 =?utf-8?B?Z0ZRZndwdUNzQ2J0dWlMWHNxTGdqQzB5VkhTYUViWjRsZW1IeWJMS0NNN2V5?=
 =?utf-8?B?S1B1TDhEWnNtd3NBTUpXS3A0eXZ3Vm1oMTUwOU1MM1l2S1lvdUZqVXNrSm5L?=
 =?utf-8?B?U2ZHbTB6Yy94SW5LcUM1TTdiOE43bzJRSTRRZWg2Y3FobkpLWEc0WW9jaWhh?=
 =?utf-8?B?UmEzU2hHbitoM0JpQnlDSUhtWjZWbWxTaVhRZDZ3dFBVTkovdnJEaUQrMEk2?=
 =?utf-8?B?cytpMnorZVdTVkJiU2ZtUHh3c29QaDJDZGxMc1hqZksrelFOVGQ3am5vU1dk?=
 =?utf-8?B?WFRxa2U5YUsvV1V3WTJzT3l5cXd5d0FMQk5HalNIaHE3RVJuMVhndzZXSlRM?=
 =?utf-8?B?eWJEWWVPSDVvK1ZjcTNkdDFXV0JoYzBsRzJZajlKUTdXazVtaytjNnlYQVdZ?=
 =?utf-8?B?dXBpVnpBSk1DN1paREl5VnNHT1piM3RZUFRmMnp1a3ZHT3RIU3JUbHAvZjdt?=
 =?utf-8?Q?lcyiZMF5qs1wRDP4DC2tz40+IPmfkLUUUjoxtH5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <864472A8CD111F40871565536A1EA2BE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a7158f-359d-41a5-5c06-08d91060e2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2021 07:30:55.5894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8peRI7lkIDicnL5st+GcD6F9zMPU3vFHWW1tEyVcTbUvuBt4FJiUO7OCMR2jaEICbcCDzFsfputU/aTaFgsBEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6770
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBNYXkgMDYsIDIwMjEgYXQgMTI6MDE6MzRQTSArMDgwMCwgRGluZyBIdWkgd3JvdGU6
DQo+IE9uIDIwMjEvNS82IDEwOjQ5LCBIT1JJR1VDSEkgTkFPWUEo5aCA5Y+jIOebtOS5nykgd3Jv
dGU6DQo+ID4gT24gV2VkLCBBcHIgMjgsIDIwMjEgYXQgMDQ6NTQ6NTlQTSArMDIwMCwgRGF2aWQg
SGlsZGVuYnJhbmQgd3JvdGU6DQo+ID4gPiBPbiAyMS4wNC4yMSAwNDowNCwgRGluZyBIdWkgd3Jv
dGU6DQo+ID4gPiA+IFJlY2VudGx5IHdlIGZvdW5kIHRoZXJlIGlzIGEgbG90IE1lbUZyZWUgbGVm
dCBpbiAvcHJvYy9tZW1pbmZvIGFmdGVyDQo+ID4gPiA+IGRvIGEgbG90IG9mIHBhZ2VzIHNvZnQg
b2ZmbGluZS4NCj4gPiA+ID4gDQo+ID4gPiA+IEkgdGhpbmsgaXQncyBpbmNvcnJlY3Qgc2luY2Ug
TlJfRlJFRV9QQUdFUyBzaG91bGQgbm90IGNvbnRhaW4gSFdQb2lzb24gcGFnZXMuDQo+ID4gPiA+
IEFmdGVyIHRha2VfcGFnZV9vZmZfYnVkZHksIHRoZSBwYWdlIGlzIG5vIGxvbmdlciBiZWxvbmcg
dG8gYnVkZHkNCj4gPiA+ID4gYWxsb2NhdG9yLCBhbmQgd2lsbCBub3QgYmUgdXNlZCBhbnkgbW9y
ZSwgYnV0IHdlIG1heWJlIG1pc3NlZCBhY2NvdW50aW5nDQo+ID4gPiA+IE5SX0ZSRUVfUEFHRVMg
aW4gdGhpcyBzaXR1YXRpb24uDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEaW5n
IEh1aSA8ZGluZ2h1aUBzYW5nZm9yLmNvbS5jbj4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAgIG1t
L3BhZ2VfYWxsb2MuYyB8IDEgKw0KPiA+ID4gPiAgICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykNCj4gPiA+ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9tbS9wYWdlX2FsbG9jLmMgYi9t
bS9wYWdlX2FsbG9jLmMNCj4gPiA+ID4gaW5kZXggY2ZjNzI4NzM5NjFkLi44ZDY1YjYyNzg0ZDgg
MTAwNjQ0DQo+ID4gPiA+IC0tLSBhL21tL3BhZ2VfYWxsb2MuYw0KPiA+ID4gPiArKysgYi9tbS9w
YWdlX2FsbG9jLmMNCj4gPiA+ID4gQEAgLTg5NDcsNiArODk0Nyw3IEBAIGJvb2wgdGFrZV9wYWdl
X29mZl9idWRkeShzdHJ1Y3QgcGFnZSAqcGFnZSkNCj4gPiA+ID4gICAgCQkJZGVsX3BhZ2VfZnJv
bV9mcmVlX2xpc3QocGFnZV9oZWFkLCB6b25lLCBwYWdlX29yZGVyKTsNCj4gPiA+ID4gICAgCQkJ
YnJlYWtfZG93bl9idWRkeV9wYWdlcyh6b25lLCBwYWdlX2hlYWQsIHBhZ2UsIDAsDQo+ID4gPiA+
ICAgIAkJCQkJCXBhZ2Vfb3JkZXIsIG1pZ3JhdGV0eXBlKTsNCj4gPiA+ID4gKwkJCV9fbW9kX3pv
bmVfcGFnZV9zdGF0ZSh6b25lLCBOUl9GUkVFX1BBR0VTLCAtMSk7DQo+ID4gPiA+ICAgIAkJCXJl
dCA9IHRydWU7DQo+ID4gPiA+ICAgIAkJCWJyZWFrOw0KPiA+ID4gPiAgICAJCX0NCj4gPiA+ID4g
DQo+ID4gPiANCj4gPiA+IFNob3VsZCB0aGlzIHVzZSBfX21vZF96b25lX2ZyZWVwYWdlX3N0YXRl
KCkgaW5zdGVhZD8NCj4gPiANCj4gPiBZZXMsIF9fbW9kX3pvbmVfZnJlZXBhZ2Vfc3RhdGUoKSBs
b29rcyBiZXR0ZXIgdG8gbWUuDQo+ID4gDQo+ID4gQW5kIEkgdGhpbmsgdGhhdCBtYXliZSBhbiBh
ZGRpdGlvbmFsIF9fbW9kX3pvbmVfZnJlZXBhZ2Vfc3RhdGUoKSBpbg0KPiA+IHVucG9pc29uX21l
bW9yeSgpIGlzIG5lY2Vzc2FyeSB0byBjYW5jZWwgdGhlIGRlY3JlbWVudC4gIEkgdGhvdWdodCBv
ZiB0aGUNCj4gPiBmb2xsb3dpbmcsIGJ1dCBpdCBkb2Vzbid0IGJ1aWxkIGJlY2F1c2UgZ2V0X3Bm
bmJsb2NrX21pZ3JhdGV0eXBlKCkgaXMNCj4gPiBhdmFpbGFibGUgb25seSBpbiBtbS9wYWdlX2Fs
bG9jLmMsIHNvIHlvdSBtaWdodCB3YW50IHRvIGFkZCBhIHNtYWxsIGV4cG9ydGVkDQo+ID4gcm91
dGluZSBpbiBtbS9wYWdlX2FsbG9jLmMgYW5kIGxldCBpdCBjYWxsZWQgZnJvbSB1bnBvaXNvbl9t
ZW1vcnkoKS4NCj4gPiANCj4gPiAgICBAQCAtMTg5OSw4ICsxODk5LDEyIEBAIGludCB1bnBvaXNv
bl9tZW1vcnkodW5zaWduZWQgbG9uZyBwZm4pDQo+ID4gICAgICAgICAgICB9DQo+ID4gICAgICAg
ICAgICBpZiAoIWdldF9od3BvaXNvbl9wYWdlKHAsIGZsYWdzLCAwKSkgew0KPiA+ICAgIC0gICAg
ICAgICAgICAgICBpZiAoVGVzdENsZWFyUGFnZUhXUG9pc29uKHApKQ0KPiA+ICAgICsgICAgICAg
ICAgICAgICBpZiAoVGVzdENsZWFyUGFnZUhXUG9pc29uKHApKSB7DQo+ID4gICAgKyAgICAgICAg
ICAgICAgICAgICAgICAgaW50IG1pZ3JhdGV0eXBlID0gZ2V0X3BmbmJsb2NrX21pZ3JhdGV0eXBl
KHAsIHBmbik7DQo+ID4gICAgKw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG51bV9w
b2lzb25lZF9wYWdlc19kZWMoKTsNCj4gPiAgICArICAgICAgICAgICAgICAgICAgICAgICBfX21v
ZF96b25lX2ZyZWVwYWdlX3N0YXRlKHBhZ2Vfem9uZShwKSwgMSwgbWlncmF0ZXR5cGUpOw0KPiA+
ICAgICsgICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICAgICAgICAgICAgIHVucG9pc29uX3By
X2luZm8oIlVucG9pc29uOiBTb2Z0d2FyZS11bnBvaXNvbmVkIGZyZWUgcGFnZSAlI2x4XG4iLA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBmbiwgJnVucG9pc29uX3Jz
KTsNCj4gPiAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gDQo+IA0KPiBJIHRoaW5r
IHRoZXJlIGlzIGFub3RoZXIgcHJvYmxlbToNCj4gSW4gbm9ybWFsIGNhc2UsIHdlIGtlZXAgdGhl
IGxhc3QgcmVmY291bnQgb2YgdGhlIGh3cG9pc29uIHBhZ2UsIHNvDQo+IGdldF9od3BvaXNvbl9w
YWdlIHNob3VsZCByZXR1cm4gMS4gVGhlIE5SX0ZSRUVfUEFHRVMgd2lsbCBiZSBhZGp1c3RlZCB3
aGVuDQo+IGNhbGwgcHV0X3BhZ2UuDQoNCkkgdGhpbmsgdGhhdCB0YWtlX3BhZ2Vfb2ZmX2J1ZGR5
KCkgc2hvdWxkIG5vdCBiZSBjYWxsZWQgZm9yIHRoaXMgY2FzZQ0KKHRoZSBlcnJvciBwYWdlIGhh
dmUgcmVtYWluaW5nIHJlZmNvdW50KS4gIFNvIGl0IHNlZW1zIHRoYXQgbm8gbmVlZCB0bw0KdXBk
YXRlIE5SX0ZSRUVfUEFHRVMgPw0KDQo+IEF0IHJhY2UgY29uZGl0aW9uLCB3ZSBtYXliZSBsZWFr
IHRoZSBwYWdlIGJlY2F1c2Ugd2UgZG9lcyBub3QgcHV0IGl0IGJhY2sgdG8NCj4gYnVkZHkgaW4g
dW5wb2lzb25fbWVtb3J5LCBob3dldmVyIHRoZSBIV1BvaXNvbiBmbGFnLCBudW1fcG9pc29uZWRf
cGFnZXMsDQo+IE5SX0ZSRUVfUEFHRVMgaXMgYWRqdXN0ZWQgY29ycmVjdGx5Lg0KPiANCj4gQ1BV
MCAgICAgICAgICAgICAgICAgICAgICAgIENQVTENCj4gDQo+IHNvZnRfb2ZmbGluZV9wYWdlDQo+
ICAgc29mdF9vZmZsaW5lX2ZyZWVfcGFnZQ0KPiAgICAgcGFnZV9oYW5kbGVfcG9pc29uDQo+ICAg
ICAgIHRha2VfcGFnZV9vZmZfYnVkZHkNCj4gICAgICAgU2V0UGFnZUhXUG9pc29uDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB1bnBvaXNvbl9tZW1vcnkNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKCFnZXRfaHdwb2lzb25fcGFnZShwKSkNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBUZXN0Q2xlYXJQYWdlSFdQb2lzb24NCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIG51bV9wb2lzb25lZF9wYWdlc19kZWMNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBfX21vZF96b25lX2ZyZWVwYWdlX3N0YXRlDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDANCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAvKiBtaXNzIHB1dCB0aGUgcGFnZSBiYWNrIHRvIGJ1ZGR5ICovDQo+ICAg
ICAgIHBhZ2VfcmVmX2luYw0KPiAgICAgICBudW1fcG9pc29uZWRfcGFnZXNfaW5jDQoNClRoYW5r
cyBmb3IgY2hlY2tpbmcgdGhpcywgdW5wb2lzb25fbWVtb3J5KCkgaXMgcmFjeS4gIFJlY2VudGx5
IHdlIGFyZSBzdWdnZXN0aW5nDQp0byBpbnRyb2R1Y2UgbWZfbXV0ZXggYnkgWzFdLiAgQWx0aG91
Z2ggdGhpcyBwYXRjaCBpcyBub3QgbWVyZ2VkIHRvIG1haW5saW5lIHlldCwNCmJ1dCBpdCBjb3Vs
ZCBiZSB1c2VkIHRvIHByZXZlbnQgdGhlIGFib3ZlIHJhY2UgdG9vLg0KDQpbMV0gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbGludXgtbW0vMjAyMTA0MjcwNjI5NTMuMjA4MDI5My0yLW5hby5ob3Jp
Z3VjaGlAZ21haWwuY29tLw0KDQo+IA0KPiBIb3cgYWJvdXQgZG8gbm90aGluZyBhbmQgcmV0dXJu
IC1FQlVTWSAoc28gdGhlIGNhbGxlciBjYW4gcmV0cnkpIGlmIHVucG9pc29uDQo+IGEgemVybyBy
ZWZjb3VudCBwYWdlICwgb3IgcmV0dXJuIDAgbGlrZSAyMzBhYzcxOWM1MDAgKCJtbS9od3BvaXNv
bjogZG9uJ3QNCj4gdHJ5IHRvIHVucG9pc29uIGNvbnRhaW5tZW50LWZhaWxlZCBwYWdlcyIpIGRv
ZXMgPw0KPiANCj4gICBAQCAtMTczNiwxMSArMTczNiw5IEBAIGludCB1bnBvaXNvbl9tZW1vcnko
dW5zaWduZWQgbG9uZyBwZm4pDQo+ICAgICB9DQo+IA0KPiAgICAgaWYgKCFnZXRfaHdwb2lzb25f
cGFnZShwLCBmbGFncywgMCkpIHsNCj4gICAtICAgICAgIGlmIChUZXN0Q2xlYXJQYWdlSFdQb2lz
b24ocCkpDQo+ICAgLSAgICAgICAgICAgbnVtX3BvaXNvbmVkX3BhZ2VzX2RlYygpOw0KPiAgIC0g
ICAgICAgdW5wb2lzb25fcHJfaW5mbygiVW5wb2lzb246IFNvZnR3YXJlLXVucG9pc29uZWQgZnJl
ZSBwYWdlICUjbHhcbiIsDQo+ICAgKyAgICAgICB1bnBvaXNvbl9wcl9pbmZvKCJVbnBvaXNvbjog
U29mdHdhcmUtdW5wb2lzb25lZCB6ZXJvIHJlZmNvdW50IHBhZ2UNCj4gJSNseFxuIiwNCj4gICAJ
CQkJIHBmbiwgJnVucG9pc29uX3JzKTsNCj4gICAtICAgICAgIHJldHVybiAwOw0KPiAgICsgICAg
ICAgcmV0dXJuIC1FQlVTWTsNCg0KQ3VycmVudGx5IHVucG9pc29uX21lbW9yeSgpIGRvZXMgbm90
IHdvcmsgYXMgcmV2ZXJzZSBvcGVyYXRpb24gb2YgdGFrZV9wYWdlX29mZl9idWRkeSgpDQooaXQn
cyBzaW1wbHkgYnJva2VuKSwgc28gaW1wbGVtZW50aW5nIGl0IGF0IG9uZSB0aW1lIHdvdWxkIGJl
IGJldHRlci4NCkknbGwgdGFrZSB0aW1lIHRvIGZpeCB1bnBvaXNvbl9tZW1vcnkoKS4NCg0KVGhh
bmtzLA0KTmFveWEgSG9yaWd1Y2hp
