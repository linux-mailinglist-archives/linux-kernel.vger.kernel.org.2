Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76CDF3B14A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 09:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFWHds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 03:33:48 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:43590 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229864AbhFWHdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 03:33:46 -0400
X-UUID: 0186910b791f409ea17c120dac1f461d-20210623
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=WaJYFsLLz2Mjmi3C64qa1RVI/b2GIwG6q2aJoTCrFsY=;
        b=I6mxVaE+Er3HovOI2XpvQ3tcgHlWL/5SJBb8fkWdDeNtb4swmgir36qzhp+Pr9jfqmB7YrBQ9f718L+w1yR8FMhErw5NFZEn08EIL5BJnInAFOQ3iiImN5xycdZ5T16jluBEvu6uSu5XT+fY+QlQKnYrXuJElZSyydjQjl1a6dY=;
X-UUID: 0186910b791f409ea17c120dac1f461d-20210623
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 476945307; Wed, 23 Jun 2021 15:31:26 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Jun 2021 15:31:24 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Jun 2021 15:31:24 +0800
Message-ID: <c874a47557ec256664e4cf0914a5e9840a335fe2.camel@mediatek.com>
Subject: Re: [PATCH] kasan: unpoison use memset to init unaligned object size
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
        <linux-mediatek@lists.infradead.org>,
        Marco Elver <elver@google.com>
Date:   Wed, 23 Jun 2021 15:31:24 +0800
In-Reply-To: <CA+fCnZdPwKZ9GfhTYPpWGVEO7bS6sSrh8cioZmRJet2maUjSVQ@mail.gmail.com>
References: <20210621154442.18463-1-yee.lee@mediatek.com>
         <CA+fCnZdPwKZ9GfhTYPpWGVEO7bS6sSrh8cioZmRJet2maUjSVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTIyIGF0IDE3OjAzICswMzAwLCBBbmRyZXkgS29ub3ZhbG92IHdyb3Rl
Og0KPiBPbiBNb24sIEp1biAyMSwgMjAyMSBhdCA2OjQ1IFBNIDx5ZWUubGVlQG1lZGlhdGVrLmNv
bT4gd3JvdGU6DQo+ID4gDQo+ID4gRnJvbTogWWVlIExlZSA8eWVlLmxlZUBtZWRpYXRlay5jb20+
DQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBhZGRzIGEgbWVtc2V0IHRvIGluaXRpYWxpemUgb2JqZWN0
IG9mIHVuYWxpZ25lZCBzaXplLg0KPiA+IER1aW5nIHRvIHRoZSBNVEUgZ3JhbnVscml0eSwgdGhl
IGludGVncmF0ZWQgaW5pdGlhbGl6YXRpb24gdXNpbmcNCj4gPiBod3RhZyBpbnN0cnVjdGlvbiB3
aWxsIGZvcmNlIGNsZWFyaW5nIG91dCBieXRlcyBpbiBncmFudWxhciBzaXplLA0KPiA+IHdoaWNo
IG1heSBjYXVzZSB1bmRlc2lyZWQgZWZmZWN0LCBzdWNoIGFzIG92ZXJ3cml0aW5nIHRvIHRoZQ0K
PiA+IHJlZHpvbmUNCj4gPiBvZiBTTFVCIGRlYnVnLiBJbiB0aGlzIHBhdGNoLCBmb3IgdGhlIHVu
YWxpZ25lZCBvYmplY3Qgc2l6ZSwNCj4gPiBmdW5jdGlvbg0KPiA+IHVzZXMgbWVtc2V0IHRvIGlu
aXRhaWxpemUgY29udGV4dCBpbnN0ZWFkIG9mIHRoZSBod3RhZyBpbnN0cnVjdGlvbi4NCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBZZWUgTGVlIDx5ZWUubGVlQG1lZGlhdGVrLmNvbT4NCj4gPiAt
LS0NCj4gPiAgbW0va2FzYW4va2FzYW4uaCB8IDUgKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9t
bS9rYXNhbi9rYXNhbi5oIGIvbW0va2FzYW4va2FzYW4uaA0KPiA+IGluZGV4IDhmNDUwYmMyODA0
NS4uZDhmYWE2NDYxNGI3IDEwMDY0NA0KPiA+IC0tLSBhL21tL2thc2FuL2thc2FuLmgNCj4gPiAr
KysgYi9tbS9rYXNhbi9rYXNhbi5oDQo+ID4gQEAgLTM4Nyw4ICszODcsMTEgQEAgc3RhdGljIGlu
bGluZSB2b2lkIGthc2FuX3VucG9pc29uKGNvbnN0IHZvaWQNCj4gPiAqYWRkciwgc2l6ZV90IHNp
emUsIGJvb2wgaW5pdCkNCj4gPiANCj4gPiAgICAgICAgIGlmIChXQVJOX09OKCh1bnNpZ25lZCBs
b25nKWFkZHIgJiBLQVNBTl9HUkFOVUxFX01BU0spKQ0KPiA+ICAgICAgICAgICAgICAgICByZXR1
cm47DQo+ID4gKyAgICAgICBpZiAoaW5pdCAmJiAoKHVuc2lnbmVkIGxvbmcpc2l6ZSAmIEtBU0FO
X0dSQU5VTEVfTUFTSykpIHsNCj4gPiArICAgICAgICAgICAgICAgaW5pdCA9IGZhbHNlOw0KPiA+
ICsgICAgICAgICAgICAgICBtZW1zZXQoKHZvaWQgKilhZGRyLCAwLCBzaXplKTsNCj4gPiArICAg
ICAgIH0NCj4gDQo+IFdpdGggdGhpcyBpbXBsZW1lbnRhdGlvbiwgd2UgbG9vc2UgdGhlIGJlbmVm
aXQgb2Ygc2V0dGluZyB0YWdzIGFuZA0KPiBpbml0aWFsaXppbmcgbWVtb3J5IHdpdGggdGhlIHNh
bWUgaW5zdHJ1Y3Rpb25zLg0KPiANCj4gUGVyaGFwcyBhIGJldHRlciBpbXBsZW1lbnRhdGlvbiB3
b3VsZCBiZSB0byBjYWxsDQo+IGh3X3NldF9tZW1fdGFnX3JhbmdlKCkgd2l0aCB0aGUgc2l6ZSBy
b3VuZGVkIGRvd24sIGFuZCB0aGVuDQo+IHNlcGFyYXRlbHkNCj4gZGVhbCB3aXRoIHRoZSBsZWZ0
b3ZlciBtZW1vcnkuDQoNClllcywgdGhpcyBmdWxseSB0YWtlcyB0aGUgYWR2YW50YWdlIG9mIGh3
IGluc3RydWN0aW9uLiANCkhvd2V2ZXIsIHRoZSBsZWZ0b3ZlciBtZW1vcnkgbmVlZHMgb25lIG1v
cmUgaHdfc2V0X21lbV90YWdfcmFuZ2UoKSBmb3INCnByb3RlY3Rpb24gYXMgd2VsbC4NCg0KSWYg
dGhlIGV4dHJhIHBhdGggaXMgb25seSBleGVjdXRlZCBhcyBDT05GSUdfU0xVQl9ERUJVRywgdGhl
DQpwZXJmb3JtYW5jZSBsb3N0IHdvdWxkIGJlIGxlc3MgY29uY2VybmVkLg0KDQo+IA0KPiA+ICAg
ICAgICAgc2l6ZSA9IHJvdW5kX3VwKHNpemUsIEtBU0FOX0dSQU5VTEVfU0laRSk7DQo+ID4gLQ0K
PiA+ICAgICAgICAgaHdfc2V0X21lbV90YWdfcmFuZ2UoKHZvaWQgKilhZGRyLCBzaXplLCB0YWcs
IGluaXQpOw0KPiA+ICB9DQo+ID4gDQo+ID4gLS0NCj4gPiAyLjE4LjANCj4gPiANCg==

