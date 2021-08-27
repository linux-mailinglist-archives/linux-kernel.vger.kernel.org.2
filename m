Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FC83F9357
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 06:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244219AbhH0D6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 23:58:32 -0400
Received: from mail-eopbgr1310057.outbound.protection.outlook.com ([40.107.131.57]:51541
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244177AbhH0D6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 23:58:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLaY3wkMYVEMdEa4N8XjFrPM7CASVcXedvTXoEmWv6R6h2bOl9SfR/YkdGII/W5MOwDke3mQq9/UdvVSU72DApL8k7k+lIP489TFerLGb4vhLasulJclZheIQp3spYAM1DhbkS4U8lodErNqKKtd796TIinWbDL1yu+vvOchup0a7hqQZKMMWwvdbGUWtulSa1yjZ56NpFy/N/5/xD6n3XgRc0SLXtgr8YaLDkQ6A0Uc+rdxhOnE17XS3ADD5elVTvr556/+MKo19DbM96YpTs73J1dR3CVJ/gJ82O3u7wgUU47kPmG4ZqBcU4HU6wmQ+1AiDo0cQg4v564gq4OkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcCLheowCr7EVyEITTRn6dQ2qmEsCF4u/gEqL4IOBhc=;
 b=ADTWsRpWSMjiG4xwrEuyaxAU8gN9Bn6su7YvjIKGkDBomlVDcAGsQNleSLJVB5hIoGEw5L9eyf4iaXom8SZxfU5XUNRImHexPe1oMrEcNa+eJx/FqZpGgy40R0Tq+2c4n4y4gCNhyZAF1LFfAkOkWQ8pAutmAvby0POW6Fm97yi5X3uiQHwwuSO0uRzIS9aNcqhWDGAt+MAZZDGXfy0rKKrXust7SYGZLXoqrjBjDxfErKV6cJMqJHM0GqVdCzteg9/pv1P97Mix2vYI4HMyROfbC/uxA2GVjCIrX3/QpC1tXjJdCAbC75l4CfyCtKbPUODw0j2gu9pnDMuEgD0bGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcCLheowCr7EVyEITTRn6dQ2qmEsCF4u/gEqL4IOBhc=;
 b=BuhgXXD956Tk+wrtedg2t0lvAzMFe0WdPGOgdHF4SC4n8B3FY7KG+QHt0NGCEaisYzShAuCBGsA//Ca5L7mbKHblvUoTPTxYkkELhB1iWrsS2yJVYyn0jSLR9t9IyhDh+PBmYcjq9jA8AySEWQzv9j91WLbzfu7XuAc/5XsoO3Q=
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com (2603:1096:403:8::12)
 by TY2PR01MB4970.jpnprd01.prod.outlook.com (2603:1096:404:10e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 03:57:40 +0000
Received: from TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0]) by TY1PR01MB1852.jpnprd01.prod.outlook.com
 ([fe80::4401:f9e:2afb:ebc0%7]) with mapi id 15.20.4436.024; Fri, 27 Aug 2021
 03:57:40 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     "osalvador@suse.de" <osalvador@suse.de>,
        "hughd@google.com" <hughd@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: hwpoison: deal with page cache THP
Thread-Topic: [PATCH] mm: hwpoison: deal with page cache THP
Thread-Index: AQHXmveuhlamTM5VXkqYqAZlltMc2A==
Date:   Fri, 27 Aug 2021 03:57:39 +0000
Message-ID: <20210827035739.GA3247360@hori.linux.bs1.fc.nec.co.jp>
References: <20210824221322.7663-1-shy828301@gmail.com>
 <20210826061724.GA2864786@hori.linux.bs1.fc.nec.co.jp>
 <CAHbLzkpP9Wm-VhXhJb-j9_mRnRskzesRpZiyUDw+xyRrLykp4w@mail.gmail.com>
 <CAHbLzkpvR77xfs+ip1T8G09=ixz4Ko3E-6iKTEZkFCfGTxi6Aw@mail.gmail.com>
In-Reply-To: <CAHbLzkpvR77xfs+ip1T8G09=ixz4Ko3E-6iKTEZkFCfGTxi6Aw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9598acce-40f9-487b-d74d-08d9690ed0a2
x-ms-traffictypediagnostic: TY2PR01MB4970:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB4970F65C28312FAAAFD2ADB5E7C89@TY2PR01MB4970.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C4zRtubZXd/Zx+plLgewGJ+tlOKcWJ0wNcgMPhIlkKPLLUgEyDbuZBoCNauYsJ1SreSXn/OXhmK9Wq3BvRRn1PM0UBHnIveat7wt9pvqhd5oYgOhVlxqZlKTwEoM4t8xP0+/0Xh8gKuU1Swwnobhknfw+5SVb7VPgWRulOlFub7DN0YCTBV0aL2GetIVfZYXyUlgsccVRLUbTXPLw2w7e7Eqabbn9W4LeOEPMetuPv1Qm7At2u3/+NIV+HLHeUDeyGTV1ebEZUuArL7KQpjwPWgpsKqzhaaYdYqx+uqBpMiwOHp09YMM5Ys6K0C/szQC9rcfzoAv7qBi+Q0LpJs+DqeLQ8dUeMoVlLRfQN+zgbeuWCo/Nxi0NYjKefJj7zvIoAl55fYph/KnSPlkkpb6XWC9gSTX+Kt7W0XnDGKqo7IZt3BW/deR+x/NdqRqdw8FTT/7QJ6SoyUDYgLmpAspVR/Wh5jeC0QmZGw9zuLZMTCNUvweLA/aHRFq339BkEv8+da6Ar8ilXIGszd+4ppqq6cR+kcg8aobWp/oe80JSx1fa659nlw5AyMswN/XaKeo9mZRZPY1gPCF6YaX0SvgOFo17q0xfuVrhcSpCtMHVAwIAHpGLP4MUo+n71RT+qskBCVTG8pl9tMWaqGAEkJeI5QEr65McHrA1BmS3DbYTC/7vrnQyJScjCu0CKrHMxByOxUIv1k4fZHzSJkYimInipljmIXOLuj1nPr+wp6ua2gAEsWMJUi6sanQJJMHcYSsJP5L3DOjLrIq+htwgxh3kcMt6yBk5STY1qCbT0fWlrI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1852.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(86362001)(76116006)(64756008)(66946007)(316002)(6512007)(83380400001)(66556008)(66476007)(6916009)(122000001)(38100700002)(5660300002)(2906002)(71200400001)(55236004)(33656002)(66446008)(38070700005)(4326008)(478600001)(53546011)(966005)(6506007)(6486002)(85182001)(26005)(186003)(8676002)(54906003)(8936002)(1076003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGp2RTBOVDBsZS8xSC93aGM0cjVTUDJTYlBjcE5LTjNKMjc3VGltdUJkQlY1?=
 =?utf-8?B?cTZ4YkJUa0dWWU5pUXJjeXRKZzlteUVWd1M0U2E3cGFWV2VSbGh0TTBUdjNT?=
 =?utf-8?B?RzhNQXpNQWh0Q0JpN0tpYjRjRDZpdFdaWjlZelFDejNGZUI3Z2NhTW1KNjhn?=
 =?utf-8?B?VDZqMU9PRm5JdmJteHZOWUVXQUovNVdwZVMvcGZjblNHUXI4WitoS0FnN1dy?=
 =?utf-8?B?RStFaCszOHpNUHBOU2R0bzUwVVBYOGtxbmdKTDJjd01uWldvVjdOQmtLQWM1?=
 =?utf-8?B?RlNhRHRrTHBBSnlla2FEMkhkc0psLzlTejExVGhUd0VpRjNwcTFGNXdVNndQ?=
 =?utf-8?B?TE5MNnU3SCt2WUlhRjNTUlJNeHNmcmZod09jc2RiY09iL0NXWmYzVk5zaVdG?=
 =?utf-8?B?VW9IaVl5M2luakVTL2dXQVE1L0JaUml3WmRnSGhUK1N3S001Y25yUTlXOFNQ?=
 =?utf-8?B?Ukd1UCtIb2ZYcHFlMnZOSlBIbFZsaTg5aTQ1RXM0MXhhL0hqanVYKzhUWTEr?=
 =?utf-8?B?U1lta1l1cWI3SGxtdGlqU1Q5TnVxWFVwRWw5RUJ1ZGxRSUxBMElJS0k4SEdB?=
 =?utf-8?B?ZGlXeWJqdFpCTFlRRWxyRFlxVm14M21PQ2dDWVVtL2gzU3M5RSt3VkJYSG5U?=
 =?utf-8?B?bXdrUHRycGVKL2FMbHVuOHdyandmQkFPNllWY0lwblYwTiswRmJaUmlTTSsw?=
 =?utf-8?B?QWJVZDZDY2pOK3ptVFFYWitMQTBoM0NnNjk1OHRGd0NPVGpnM0dQUUJUdkZ6?=
 =?utf-8?B?ckw2dGtGL1BsNEI4cXdacVVHejFSSG9jZG1CTi80WGl4V2E4T2k2czhJT0hJ?=
 =?utf-8?B?blo2L1hZTmhHNFdGeDhzMUFZcXFidHdmYjJUUVJWNFdoZC9BVGsyTWtyYW5i?=
 =?utf-8?B?TzMreDJ2YUhuancwVURnTDNtemYvdVhxWUhPcjNNZjNTbzl1dGNhTDNiRjNv?=
 =?utf-8?B?TzlqbWRkWiszUExkMWt4OThyS1RBd1RhMUpOTjdzMGd2QzhSRTRGL2Eyalor?=
 =?utf-8?B?TlZDQVV6UGJCN3FRSmFKR0RxM1ZiS1dkTkJ5a2ZzTHZtaE0rbVBBQVZNWXdv?=
 =?utf-8?B?VFJWVVF2VGY1MkkyMW5VYWVzOThTZFFYWW14ZnB5bXAwK2dvc3QrSlVURUNt?=
 =?utf-8?B?R013WE1SejQvdER4NFBrd3FOVCs3YU1yU3JJQ2I2d0Y2YlVWdkhZRnFCbEdC?=
 =?utf-8?B?d0FxSEFUZ2JPR0k3Z2x4TmJNeWxuSVVodmp1cHdMWGUvcWxPSG5OaVJrRS9h?=
 =?utf-8?B?YS9zV1NINFg2VEkwOFJyT0FZR3VUZHRXVlJTcE11UktFZHhNTDYzaHZjeHU1?=
 =?utf-8?B?Mnc1K1FpL2h4TnUvMW1XUG1Xc2thbVQ4d3U0YW9BT3FaWHNVeWxVNW85aVA5?=
 =?utf-8?B?TVFmL1YvWUpVZVlWUzd6L1FDNk5pOFFVd21sbmJsWGRVdjVreEhtSHlKOWNx?=
 =?utf-8?B?Rk1uY0txNkhuV0ZsNmprZmxqWGw4MHR1MEZGcVlHajREOUJqREpIMVhrUW9H?=
 =?utf-8?B?NTRBVi9wWjZPR0xNTXBaSGM3Mis3TkxJYVE2V1lLdU5QZGZFaUxlT3J3R3Zn?=
 =?utf-8?B?UGEzcU44dFNLRkNvMmF5RHNWMU5uOXduK0V0eC9pRGRQbC9nMVc2RU5YTGdo?=
 =?utf-8?B?YmdDeG9oVUdmMHRrK1haNlNYdVNPMHZLK3oveG00WFNZakVKbGVJbkdEaFJ3?=
 =?utf-8?B?akl4KzVYUXhJWTFaT2hLMHNIRjNrZEhYQlpwVG1CSEwzdUFyTkExeWJ4WXdC?=
 =?utf-8?Q?FMzuFQhgTjTMLATfdNwBxkX7ync7cbqZuxhXwL8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A1C1BB3DC843934C8C9F0CD9634D46B5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1852.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9598acce-40f9-487b-d74d-08d9690ed0a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 03:57:39.9817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B0j+NM+iJSjWRJPU8mJqB99gKNY7IdDuAxaJdDjK1HiIewXfKAeU7yJutR3+rvbwAmRtoE4vvgqQlnDuIlDGmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4970
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCBBdWcgMjYsIDIwMjEgYXQgMDM6MDM6NTdQTSAtMDcwMCwgWWFuZyBTaGkgd3JvdGU6
DQo+IE9uIFRodSwgQXVnIDI2LCAyMDIxIGF0IDE6MDMgUE0gWWFuZyBTaGkgPHNoeTgyODMwMUBn
bWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCBBdWcgMjUsIDIwMjEgYXQgMTE6MTcg
UE0gSE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nykNCj4gPiA8bmFveWEuaG9yaWd1Y2hp
QG5lYy5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIFR1ZSwgQXVnIDI0LCAyMDIxIGF0IDAz
OjEzOjIyUE0gLTA3MDAsIFlhbmcgU2hpIHdyb3RlOg0KLi4uDQo+ID4gPg0KPiA+ID4gVGhlcmUg
d2FzIGEgZGlzY3Vzc2lvbiBhYm91dCBhbm90aGVyIGFwcHJvYWNoIG9mIGtlZXBpbmcgZXJyb3Ig
cGFnZXMgaW4gcGFnZQ0KPiA+ID4gY2FjaGUgZm9yIGZpbGVzeXN0ZW0gd2l0aG91dCBiYWNrZW5k
IHN0b3JhZ2UuDQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2FscGluZS5MU1Uu
Mi4xMS4yMTAzMTExMzEyMzEwLjc4NTlAZWdnbHkuYW52aWxzLw0KPiA+ID4gVGhpcyBhcHByb2Fj
aCBzZWVtcyB0byBtZSBsZXNzIGNvbXBsaWNhdGVkLCBidXQgb25lIGNvbmNlcm4gaXMgdGhhdCB0
aGlzDQo+ID4gPiBjaGFuZ2UgYWZmZWN0cyB1c2VyLXZpc2libGUgYmVoYXZpb3Igb2YgbWVtb3J5
IGVycm9ycy4gIEtlZXBpbmcgZXJyb3IgcGFnZXMNCj4gPiA+IGluIHBhZ2UgY2FjaGUgbWVhbnMg
dGhhdCB0aGUgZXJyb3JzIGFyZSBwZXJzaXN0ZW50IHVudGlsIG5leHQgc3lzdGVtIHJlYm9vdCwN
Cj4gPiA+IHNvIHdlIG1pZ2h0IG5lZWQgdG8gZGVmaW5lIHRoZSB3YXkgdG8gY2xlYXIgdGhlIGVy
cm9ycyB0byBjb250aW51ZSB0byB1c2UNCj4gPiA+IHRoZSBlcnJvciBmaWxlLiAgQ3VycmVudCBp
bXBsZW1lbnRhdGlvbiBpcyBqdXN0IHRvIHNlbmQgU0lHQlVTIHRvIHRoZQ0KPiA+ID4gbWFwcGlu
ZyBwcm9jZXNzZXMgKGF0IGxlYXN0IG9uY2UpLCB0aGVuIGZvcmdldCBhYm91dCB0aGUgZXJyb3Is
IHNvIHRoZXJlIGlzDQo+ID4gPiBubyBzdWNoIGlzc3VlLg0KPiA+ID4NCj4gPiA+IEFub3RoZXIg
dGhvdWdodCBvZiBwb3NzaWJsZSBzb2x1dGlvbiBtaWdodCBiZSB0byBzZW5kIFNJR0JVUyBpbW1l
ZGlhdGVseSB3aGVuDQo+ID4gPiBhIG1lbW9yeSBlcnJvciBoYXBwZW5zIG9uIGEgc2htZW0gdGhw
LiBXZSBjYW4gZmluZCBhbGwgdGhlIG1hcHBpbmcgcHJvY2Vzc2VzDQo+ID4gPiBiZWZvcmUgc3Bs
aXR0aW5nIHNobWVtIHRocCwgc28gc2VuZCBTSUdCVVMgZmlyc3QsIHRoZW4gc3BsaXQgaXQgYW5k
IGNvbnRhaW4NCj4gPiA+IHRoZSBlcnJvciBwYWdlLiAgVGhpcyBpcyBub3QgZWxlZ2FudCAoZ2l2
aW5nIHVwIGFueSBvcHRpb25hbCBhY3Rpb25zKSBidXQNCj4gPiA+IGFueXdheSB3ZSBjYW4gYXZv
aWQgdGhlIHNpbGVudCBkYXRhIGxvc3QuDQo+ID4NCj4gPiBUaGFua3MgYSBsb3QuIEkgYXBvbG9n
aXplIEkgZGlkbid0IG5vdGljZSB5b3UgYWxyZWFkeSBwb3N0ZWQgYSBzaW1pbGFyDQo+ID4gcGF0
Y2ggYmVmb3JlLg0KPiA+DQo+ID4gWWVzLCBJIHRoaW5rIEkgZm9jdXNlZCBvbiB0aGUgc29mdCBv
ZmZsaW5lIHBhcnQgdG9vIG11Y2ggYW5kIG1pc3NlZA0KPiA+IHRoZSB1bmNvcnJlY3RlZCBlcnJv
ciBwYXJ0IGFuZCBJIGFkbWl0IEkgZGlkIHVuZGVyZXN0aW1hdGUgdGhlDQo+ID4gcHJvYmxlbS4N
Cj4gPg0KPiA+IEkgdGhpbmsgSHVnaCdzIHN1Z2dlc3Rpb24gbWFrZXMgc2Vuc2UgaWYgd2UgdHJl
YXQgdG1wZnMgYXMgYSByZWd1bGFyDQo+ID4gZmlsZXN5c3RlbSAoanVzdCBtZW1vcnkgYmFja2Vk
KS4gQUZBSUssIHNvbWUgZmlsZXN5c3RlbSwgZS5nLiBidHJmcywNCj4gPiBtYXkgZG8gY2hlY2tz
dW0gYWZ0ZXIgcmVhZGluZyBmcm9tIHN0b3JhZ2UgYmxvY2sgdGhlbiByZXR1cm4gYW4gZXJyb3IN
Cj4gPiBpZiBjaGVja3N1bSBpcyBub3QgcmlnaHQgc2luY2UgaXQgbWF5IGluZGljYXRlIGhhcmR3
YXJlIGZhaWx1cmUgb24NCj4gPiBkaXNrLiBUaGVuIHRoZSBzeXNjYWxscyBvciBwYWdlIGZhdWx0
IHJldHVybiBlcnJvciBvciBTSUdCVVMuDQo+ID4NCj4gPiBTbyBpbiBzaG1lbS90bXBmcyBjYXNl
LCBpZiBod3BvaXNvbmVkIHBhZ2UgaXMgbWV0LCBqdXN0IHJldHVybiBlcnJvcg0KPiA+ICgtRUlP
IG9yIHdoYXRldmVyKSBmb3Igc3lzY2FsbCBvciBTSUdCVVMgZm9yIHBhZ2UgZmF1bHQuIEl0IGRv
ZXMgYWxpZ24NCj4gPiB3aXRoIHRoZSBiZWhhdmlvciBvZiBvdGhlciBmaWxlc3lzdGVtcy4gSXQg
aXMgZGVmaW5pdGVseSBhcHBsaWNhdGlvbnMnDQo+ID4gcmVzcG9uc2liaWxpdHkgdG8gY2hlY2sg
dGhlIHJldHVybiB2YWx1ZSBvZiByZWFkL3dyaXRlIHN5c2NhbGxzLg0KPiANCj4gQlRXLCBJSVVD
IHRoZSBkaXJ0eSByZWd1bGFyIHBhZ2UgY2FjaGUgKHN0b3JhZ2UgYmFja2VkKSB3b3VsZCBiZSBs
ZWZ0DQo+IGluIHRoZSBwYWdlIGNhY2hlIHRvbywgdGhlIGNsZWFuIHBhZ2UgY2FjaGUgd291bGQg
YmUgdHJ1bmNhdGVkIHNpbmNlDQo+IHRoZXkgY2FuIGJlIGp1c3QgcmVyZWFkIGZyb20gc3RvcmFn
ZSwgcmlnaHQ/DQoNCkEgZGlydHkgcGFnZSBjYWNoZSBpcyBhbHNvIHJlbW92ZWQgb24gZXJyb3Ig
KG1lX3BhZ2VjYWNoZV9kaXJ0eSgpIGZhbGxzDQp0aHJvdWdoIG1lX3BhZ2VjYWNoZV9jbGVhbigp
LCB0aGVuIHRydW5jYXRlX2Vycm9yX3BhZ2UoKSBpcyBjYWxsZWQpLg0KVGhlIG1haW4gcHVycG9z
ZSBvZiB0aGlzIGlzIHRvIHNlcGFyYXRlIG9mZiB0aGUgZXJyb3IgcGFnZSBmcm9tIGV4aXNpbmcN
CmRhdGEgc3RydWN0dXJlcyB0byBtaW5pbWl6ZSB0aGUgcmlzayBvZiBsYXRlciBhY2Nlc3NlcyAo
bWF5YmUgYnkgcmFjZSBvciBidWcpLg0KQnV0IHdlIGNhbiBjaGFuZ2UgdGhpcyBiZWhhdmlvciBm
b3Igc3BlY2lmaWMgZmlsZSBzeXN0ZW1zIGJ5IHVwZGF0aW5nDQplcnJvcl9yZW1vdmVfcGFnZSgp
IGNhbGxiYWNrcyBpbiBhZGRyZXNzX3NwYWNlX29wZXJhdGlvbi4NCg0KSG9uZXN0bHksIGl0IHNl
ZW1zIHRvIG1lIHRoYXQgaG93IGRpcnR5IGRhdGEgaXMgbG9zdCBkb2VzIG5vdCBkZXBlbmQgb24N
CmZpbGUgc3lzdGVtLCBhbmQgSSdtIHN0aWxsIG5vdCBzdXJlIHRoYXQgdGhpcyBpcyByZWFsbHkg
YSByaWdodCBhcHByb2FjaA0KZm9yIHRoZSBjdXJyZW50IGlzc3VlLg0KDQpUaGFua3MsDQpOYW95
YSBIb3JpZ3VjaGk=
