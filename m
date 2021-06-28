Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737A03B590E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 08:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhF1GWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 02:22:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51239 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229778AbhF1GWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 02:22:14 -0400
X-UUID: 6356ae1550ee45a3a444a23da326cc3c-20210628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=MoVeeFN8QQduQIE2H+ETIc4pO/33E9CcY+5cMgsP0BY=;
        b=l+etoZbUiSHiW27Pr7EDExDK5187sMAMI3Y6xYjHXZcLHxKJkMe/FNROIcEBxyr5ULWKjPaMALSvDtVpda/d/nEzR0Qri/r/YgL/VKuaQXfkyuVnlWVrs4a8/R7pEG7AIzswoFBjZ5DbgzXOLIXRCuXNzdEs1l2ranC6cVhrbOg=;
X-UUID: 6356ae1550ee45a3a444a23da326cc3c-20210628
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 211629925; Mon, 28 Jun 2021 14:19:35 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 28 Jun 2021 14:19:33 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Jun 2021 14:19:33 +0800
Message-ID: <1147252f497e5529de8215486b184af649ac0a0e.camel@mediatek.com>
Subject: Re: [PATCH v2 1/1] kasan: Add memzero init for unaligned size under
 SLUB debug
From:   Yee Lee <yee.lee@mediatek.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
CC:     <wsd_upstream@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 28 Jun 2021 14:19:33 +0800
In-Reply-To: <CA+fCnZe0fng4-53U1=5MiYszCMi97twKut3eQNaNHgPV2HOVug@mail.gmail.com>
References: <20210624112624.31215-1-yee.lee@mediatek.com>
         <20210624112624.31215-2-yee.lee@mediatek.com>
         <CA+fCnZe0fng4-53U1=5MiYszCMi97twKut3eQNaNHgPV2HOVug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA2LTI1IGF0IDE3OjAzICswMzAwLCBBbmRyZXkgS29ub3ZhbG92IHdyb3Rl
Og0KPiBPbiBUaHUsIEp1biAyNCwgMjAyMSBhdCAyOjI2IFBNIDx5ZWUubGVlQG1lZGlhdGVrLmNv
bT4gd3JvdGU6DQo+ID4gDQo+ID4gRnJvbTogWWVlIExlZSA8eWVlLmxlZUBtZWRpYXRlay5jb20+
DQo+ID4gDQo+ID4gSXNzdWU6IHdoZW4gU0xVQiBkZWJ1ZyBpcyBvbiwgaHd0YWcga2FzYW5fdW5w
b2lzb24oKSB3b3VsZA0KPiA+IG92ZXJ3cml0ZQ0KPiA+IHRoZSByZWR6b25lIG9mIG9iamVjdCB3
aXRoIHVuYWxpZ25lZCBzaXplLg0KPiA+IA0KPiA+IEFuIGFkZGl0aW9uYWwgbWVtemVyb19leHBs
aWNpdCgpIHBhdGggaXMgYWRkZWQgdG8gcmVwbGFjaW5nIGluaXQgYnkNCj4gPiBod3RhZyBpbnN0
cnVjdGlvbiBmb3IgdGhvc2UgdW5hbGlnbmVkIHNpemUgYXQgU0xVQiBkZWJ1ZyBtb2RlLg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFllZSBMZWUgPHllZS5sZWVAbWVkaWF0ZWsuY29tPg0KPiA+
IC0tLQ0KPiA+ICBtbS9rYXNhbi9rYXNhbi5oIHwgNiArKysrKysNCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9tbS9rYXNhbi9rYXNh
bi5oIGIvbW0va2FzYW4va2FzYW4uaA0KPiA+IGluZGV4IDhmNDUwYmMyODA0NS4uZDEwNTRmMzU4
MzhmIDEwMDY0NA0KPiA+IC0tLSBhL21tL2thc2FuL2thc2FuLmgNCj4gPiArKysgYi9tbS9rYXNh
bi9rYXNhbi5oDQo+ID4gQEAgLTM4Nyw2ICszODcsMTIgQEAgc3RhdGljIGlubGluZSB2b2lkIGth
c2FuX3VucG9pc29uKGNvbnN0IHZvaWQNCj4gPiAqYWRkciwgc2l6ZV90IHNpemUsIGJvb2wgaW5p
dCkNCj4gPiANCj4gPiAgICAgICAgIGlmIChXQVJOX09OKCh1bnNpZ25lZCBsb25nKWFkZHIgJiBL
QVNBTl9HUkFOVUxFX01BU0spKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4gKyNp
ZiBJU19FTkFCTEVEKENPTkZJR19TTFVCX0RFQlVHKQ0KPiANCj4gSXMgdGhpcyBhbiBpc3N1ZSBv
bmx5IHdpdGggU0xVQj8gU0xBQiBhbHNvIHVzZXMgcmVkem9uZXMuDQpBcyBJIGtub3duLCBody10
YWcga2FzYW4gb25seSB3b3JrcyB3aXRoIFNMVUIuDQoNCj4gDQo+ID4gKyAgICAgICBpZiAoaW5p
dCAmJiAoKHVuc2lnbmVkIGxvbmcpc2l6ZSAmIEtBU0FOX0dSQU5VTEVfTUFTSykpIHsNCj4gDQo+
IFRoaXMgbmVlZHMgYSBjb21tZW50IGFsb25nIHRoZSBsaW5lcyBvZjoNCj4gDQo+IC8qIEV4cGxp
Y2l0bHkgaW5pdGlhbGl6ZSB0aGUgbWVtb3J5IHdpdGggdGhlIHByZWNpc2Ugb2JqZWN0IHNpemUg
dG8NCj4gYXZvaWQgb3ZlcndyaXRpbmcgdGhlIFNMQUIgcmVkem9uZS4gVGhpcyBkaXNhYmxlcyBp
bml0aWFsaXphdGlvbiBpbg0KPiB0aGUgYXJjaCBjb2RlIGFuZCBtYXkgdGh1cyBsZWFkIHRvIHBl
cmZvcm1hbmNlIHBlbmFsdHkuIFRoZSBwZW5hbHR5DQo+IGlzDQo+IGFjY2VwdGVkIHNpbmNlIFNM
QUIgcmVkem9uZXMgYXJlbid0IGVuYWJsZWQgaW4gcHJvZHVjdGlvbiBidWlsZHMuICovDQpTdXJl
LCB3aWxsIHdvcmsgb24gdGhpcy4NCj4gDQo+ID4gKyAgICAgICAgICAgICAgIGluaXQgPSBmYWxz
ZTsNCj4gPiArICAgICAgICAgICAgICAgbWVtemVyb19leHBsaWNpdCgodm9pZCAqKWFkZHIsIHNp
emUpOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsjZW5kaWYNCj4gPiAgICAgICAgIHNpemUgPSByb3Vu
ZF91cChzaXplLCBLQVNBTl9HUkFOVUxFX1NJWkUpOw0KPiA+IA0KPiA+ICAgICAgICAgaHdfc2V0
X21lbV90YWdfcmFuZ2UoKHZvaWQgKilhZGRyLCBzaXplLCB0YWcsIGluaXQpOw0KPiA+IC0tDQo+
ID4gMi4xOC4wDQo+ID4gDQo=

