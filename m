Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473123B1219
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 05:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFWDUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 23:20:24 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:36078 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229774AbhFWDUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 23:20:23 -0400
X-UUID: 4f2304a7abac43d6aefc5e044998270f-20210623
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=bgnuDS/Z+nPqmzTT4TvjlnF+A9DJYxftjxThaCbTG3Q=;
        b=tHHRkDmVZ8NTyBlzavJyPKjuaIHNBuMYP7TEyU2yYeyNJfqshKssDapxJPVkniDd/vCfl1dQzDF/3Ytv3NXpAiOE6dDhrQVvQr7sYgf8lWBflWN+Aw6kpem3qmltivDTFgnUpEV70ffdUWgOE20eU+h8oW3s3Lt6KNib6GsMqrE=;
X-UUID: 4f2304a7abac43d6aefc5e044998270f-20210623
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 835981017; Wed, 23 Jun 2021 11:18:03 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Jun 2021 11:17:55 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Jun 2021 11:17:55 +0800
Message-ID: <cd9c48696809ac92f9c201f4a08effe657da53ee.camel@mediatek.com>
Subject: Re: [PATCH v3 2/3] kasan: integrate the common part of two KASAN
 tag-based modes
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>
CC:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        <chinwen.chang@mediatek.com>, <nicholas.tang@mediatek.com>
Date:   Wed, 23 Jun 2021 11:17:55 +0800
In-Reply-To: <CA+fCnZdGQ-_USQ_dCkmp+=MGS01yRtn1eLpGRLvbq=j-SQDrog@mail.gmail.com>
References: <20210620114756.31304-1-Kuan-Ying.Lee@mediatek.com>
         <20210620114756.31304-3-Kuan-Ying.Lee@mediatek.com>
         <CA+fCnZdGQ-_USQ_dCkmp+=MGS01yRtn1eLpGRLvbq=j-SQDrog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTIyIGF0IDE2OjU0ICswMzAwLCBBbmRyZXkgS29ub3ZhbG92IHdyb3Rl
Og0KPiBPbiBTdW4sIEp1biAyMCwgMjAyMSBhdCAyOjQ4IFBNIEt1YW4tWWluZyBMZWUNCj4gPEt1
YW4tWWluZy5MZWVAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiANCj4gPiAxLiBNb3ZlIGthc2Fu
X2dldF9mcmVlX3RyYWNrKCkgYW5kIGthc2FuX3NldF9mcmVlX2luZm8oKQ0KPiA+ICAgIGludG8g
dGFncy5jDQo+IA0KPiBQbGVhc2UgbWVudGlvbiB0aGF0IHRoZSBwYXRjaCBkb2Vzbid0IG9ubHkg
bW92ZSBidXQgYWxzbyBjb21iaW5lcw0KPiB0aGVzZSBmdW5jdGlvbnMgZm9yIFNXX1RBR1MgYW5k
IEhXX1RBR1MgbW9kZXMuDQo+IA0KDQpHb3QgaXQuDQoNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4g
KysrIGIvbW0va2FzYW4vcmVwb3J0X3RhZ3MuaA0KPiA+IEBAIC0wLDAgKzEsNTUgQEANCj4gPiAr
LyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4gPiArLyoNCj4gPiArICog
Q29weXJpZ2h0IChjKSAyMDE0IFNhbXN1bmcgRWxlY3Ryb25pY3MgQ28uLCBMdGQuDQo+ID4gKyAq
IENvcHlyaWdodCAoYykgMjAyMCBHb29nbGUsIEluYy4NCj4gPiArICovDQo+ID4gKyNpZm5kZWYg
X19NTV9LQVNBTl9SRVBPUlRfVEFHU19IDQo+ID4gKyNkZWZpbmUgX19NTV9LQVNBTl9SRVBPUlRf
VEFHU19IDQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAia2FzYW4uaCINCj4gPiArI2luY2x1ZGUgIi4u
L3NsYWIuaCINCj4gPiArDQo+ID4gK2NvbnN0IGNoYXIgKmthc2FuX2dldF9idWdfdHlwZShzdHJ1
Y3Qga2FzYW5fYWNjZXNzX2luZm8gKmluZm8pDQo+IA0KPiBBcyBtZW50aW9uZWQgYnkgQWxleCwg
ZG9uJ3QgcHV0IHRoaXMgaW1wbGVtZW50YXRpb24gaW50byBhIGhlYWRlci4NCj4gUHV0DQo+IGl0
IGludG8gcmVwb3J0X3RhZ3MuYy4gVGhlIGRlY2xhcmF0aW9uIGlzIGFscmVhZHkgaW4ga2FzYW4u
aC4NCj4gDQoNCk9rLiBJIHdpbGwgcmVmYWN0b3IgaW4gdjQuDQpUaGFua3MgZm9yIHN1Z2dlc3Rp
b25zLg0KDQo+ID4gK3sNCj4gPiArI2lmZGVmIENPTkZJR19LQVNBTl9UQUdTX0lERU5USUZZDQo+
ID4gKyAgICAgICBzdHJ1Y3Qga2FzYW5fYWxsb2NfbWV0YSAqYWxsb2NfbWV0YTsNCj4gPiArICAg
ICAgIHN0cnVjdCBrbWVtX2NhY2hlICpjYWNoZTsNCj4gPiArICAgICAgIHN0cnVjdCBwYWdlICpw
YWdlOw0KPiA+ICsgICAgICAgY29uc3Qgdm9pZCAqYWRkcjsNCj4gPiArICAgICAgIHZvaWQgKm9i
amVjdDsNCj4gPiArICAgICAgIHU4IHRhZzsNCj4gPiArICAgICAgIGludCBpOw0KPiA+ICsNCj4g
PiArICAgICAgIHRhZyA9IGdldF90YWcoaW5mby0+YWNjZXNzX2FkZHIpOw0KPiA+ICsgICAgICAg
YWRkciA9IGthc2FuX3Jlc2V0X3RhZyhpbmZvLT5hY2Nlc3NfYWRkcik7DQo+ID4gKyAgICAgICBw
YWdlID0ga2FzYW5fYWRkcl90b19wYWdlKGFkZHIpOw0KPiA+ICsgICAgICAgaWYgKHBhZ2UgJiYg
UGFnZVNsYWIocGFnZSkpIHsNCj4gPiArICAgICAgICAgICAgICAgY2FjaGUgPSBwYWdlLT5zbGFi
X2NhY2hlOw0KPiA+ICsgICAgICAgICAgICAgICBvYmplY3QgPSBuZWFyZXN0X29iaihjYWNoZSwg
cGFnZSwgKHZvaWQgKilhZGRyKTsNCj4gPiArICAgICAgICAgICAgICAgYWxsb2NfbWV0YSA9IGth
c2FuX2dldF9hbGxvY19tZXRhKGNhY2hlLCBvYmplY3QpOw0KPiA+ICsNCj4gPiArICAgICAgICAg
ICAgICAgaWYgKGFsbG9jX21ldGEpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgS0FTQU5fTlJfRlJFRV9TVEFDS1M7IGkrKykNCj4gPiB7DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoYWxsb2NfbWV0YS0+ZnJlZV9wb2ludGVyX3Rh
Z1tpXSANCj4gPiA9PSB0YWcpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiAidXNlLWFmdGVyLWZyZWUiOw0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgIH0NCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4g
Im91dC1vZi1ib3VuZHMiOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsjZW5kaWYNCj4gPiArDQo+ID4g
KyAgICAgICAvKg0KPiA+ICsgICAgICAgICogSWYgYWNjZXNzX3NpemUgaXMgYSBuZWdhdGl2ZSBu
dW1iZXIsIHRoZW4gaXQgaGFzIHJlYXNvbg0KPiA+IHRvIGJlDQo+ID4gKyAgICAgICAgKiBkZWZp
bmVkIGFzIG91dC1vZi1ib3VuZHMgYnVnIHR5cGUuDQo+ID4gKyAgICAgICAgKg0KPiA+ICsgICAg
ICAgICogQ2FzdGluZyBuZWdhdGl2ZSBudW1iZXJzIHRvIHNpemVfdCB3b3VsZCBpbmRlZWQgdHVy
biB1cA0KPiA+IGFzDQo+ID4gKyAgICAgICAgKiBhIGxhcmdlIHNpemVfdCBhbmQgaXRzIHZhbHVl
IHdpbGwgYmUgbGFyZ2VyIHRoYW4NCj4gPiBVTE9OR19NQVgvMiwNCj4gPiArICAgICAgICAqIHNv
IHRoYXQgdGhpcyBjYW4gcXVhbGlmeSBhcyBvdXQtb2YtYm91bmRzLg0KPiA+ICsgICAgICAgICov
DQo+ID4gKyAgICAgICBpZiAoaW5mby0+YWNjZXNzX2FkZHIgKyBpbmZvLT5hY2Nlc3Nfc2l6ZSA8
IGluZm8tDQo+ID4gPmFjY2Vzc19hZGRyKQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gIm91
dC1vZi1ib3VuZHMiOw0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiAiaW52YWxpZC1hY2Nlc3Mi
Ow0KPiA+ICt9DQo=

