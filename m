Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD1A3B01BA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 12:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhFVKug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 06:50:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55766 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229873AbhFVKuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 06:50:35 -0400
X-UUID: 32333258e4374f999c43cf6b44d74857-20210622
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2Xe8s5S2Pr4ZdWw9QKHGiKnjYf3PUAlezQXXPGZ6XEY=;
        b=gzfNptSpgprLIDASwWuot5yz8g6+tlxSm99SiEIx66xcbfWlNFswAlL5H9DYnt8TqvDF/6yHRb5ORoB5Yor4/P4+PfPJbaC4pP0fvvlmDeqeAbvJzFCwFEuBooamcmKutHMG1kGu2OT/2jlnvhZAcZB2Q2Y13WCem4vJ8/vR50s=;
X-UUID: 32333258e4374f999c43cf6b44d74857-20210622
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 793337003; Tue, 22 Jun 2021 18:48:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Jun 2021 18:48:13 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Jun 2021 18:48:13 +0800
Message-ID: <46b1468146206e6cef0c33ecbfd86e02ea819db4.camel@mediatek.com>
Subject: Re: [PATCH] kasan: [v2]unpoison use memzero to init unaligned object
From:   Yee Lee <yee.lee@mediatek.com>
To:     Marco Elver <elver@google.com>
CC:     <andreyknvl@gmail.com>, <wsd_upstream@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 22 Jun 2021 18:48:13 +0800
In-Reply-To: <CANpmjNPyP2-oULXuO9ZdC=yj_XSiC2TWKNBp0RL_h3k-XvpFsA@mail.gmail.com>
References: <20210622084723.27637-1-yee.lee@mediatek.com>
         <CANpmjNPyP2-oULXuO9ZdC=yj_XSiC2TWKNBp0RL_h3k-XvpFsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTIyIGF0IDExOjAxICswMjAwLCBNYXJjbyBFbHZlciB3cm90ZToNCj4g
T24gVHVlLCAyMiBKdW4gMjAyMSBhdCAxMDo0OCwgPHllZS5sZWVAbWVkaWF0ZWsuY29tPiB3cm90
ZToNCj4gPiANCj4gPiBGcm9tOiBZZWUgTGVlIDx5ZWUubGVlQG1lZGlhdGVrLmNvbT4NCj4gPiAN
Cj4gPiBGb2xsb3dzIHRoZSBkaXNjdXNzaW9uOiANCj4gPiBodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTUwNDQzOQ0KPiANCj4g
VGhlIGluZm8gYWJvdXQgdGhlIHBlcmNlbnRhZ2Ugb2YgaG93IGZyZXF1ZW50IHRoaXMgaXMgY291
bGQgaGF2ZSBiZWVuDQo+IHByb3ZpZGVkIGFzIGEgc2ltcGxlIHJlcGx5IHRvIHRoZSBkaXNjdXNz
aW9uLg0KPiANCj4gPiBUaGlzIHBhdGNoIEFkZCBtZW16ZXJvX2V4cGxpY3QgdG8gaW5pdGlhbGl6
ZSB1bmFsaWduZWQgb2JqZWN0Lg0KPiANCj4gVGhpcyBwYXRjaCBkb2VzIG5vdCBhcHBseSB0byBh
bnl0aGluZyAoSSBzZWUgaXQgZGVwZW5kcyBvbiB0aGUNCj4gcHJldmlvdXMgcGF0Y2gpLg0KPiAN
Cj4gV2hhdCB5b3UgbmVlZCB0byBkbyBpcyBtb2RpZnkgdGhlIG9yaWdpbmFsIHBhdGNoLCBhbmQg
dGhlbiBzZW5kIGENCj4gW1BBVENIIHYyXSAoZ2l0IGhlbHBzIHdpdGggdGhhdCBieSBwYXNzaW5n
IC0tcmVyb2xsLWNvdW50IG9yIC12KSB0aGF0DQo+IGFwcGxpZXMgY2xlYW5seSB0byB5b3VyIGJh
c2Uga2VybmVsIHRyZWUuDQo+IA0KPiBUaGUgY29tbWl0IG1lc3NhZ2Ugd2lsbCB1c3VhbGx5IGVu
ZCB3aXRoICctLS0nIGFuZCB0aGVuIGJyaWVmbHkNCj4gZGVub3RlDQo+IHdoYXQgY2hhbmdlZCBz
aW5jZSB0aGUgbGFzdCB2ZXJzaW9uLg0KPiANCkdvdCBpdC4NCg0KPiANCmh0dHBzOi8vd3d3Lmtl
cm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3Mvc3VibWl0dGluZy1wYXRjaGVzLmh0bWwj
dGhlLWNhbm9uaWNhbC1wYXRjaC1mb3JtYXQNCj4gDQo+ID4gQmFzZWQgb24gdGhlIGludGVncmF0
ZWlvbiBvZiBpbml0aWFsaXphdGlvbiBpbiBrYXNhbl91bnBvaXNvbigpLg0KPiA+IFRoZSBod3Rh
ZyBpbnN0cnVjdGlvbnMsIGNvbnN0cmFpbmVkIHdpdGggaXRzIGdyYW51bGFyaXR5LCBoYXMgdG8N
Cj4gPiBvdmVyd3JpdGUgdGhlIGRhdGEgYnR5ZXMgaW4gdW5hbGlnbmVkIG9iamVjdHMuIFRoaXMg
d291bGQgY2F1c2UNCj4gPiBpc3N1ZSB3aGVuIGl0IHdvcmtzIHdpdGggU0xVQiBkZWJ1ZyByZWR6
b25pbmcuDQo+ID4gDQo+ID4gSW4gdGhpcyBwYXRjaCwgYW4gYWRkaXRpb25hbCBpbml0YWxpemFp
bmcgcGF0aCBpcyBhZGRlZCBmb3IgdGhlDQo+ID4gdW5hbGlnbmVkIG9iamVjdHMuIEl0IGNvbnRh
aW5zIG1lbXplcm9fZXhwbGljdCgpIHRvIGNsZWFyIG91dCB0aGUNCj4gPiBkYXRhIGFuZCBkaXNh
YmxlcyBpdHMgaW5pdCBmbGFnIGZvciB0aGUgZm9sbG93aW5nIGh3dGFnIGFjdGlvbnMuDQo+ID4g
DQo+ID4gSW4gbGFiIHRlc3QsIHRoaXMgcGF0aCBpcyBleGVjdXRlZCBhYm91dCAxLjElKDk0MS84
MDg1NCkgd2l0aGluIHRoZQ0KPiA+IG92ZXJhbGwga2FzYW5fdW5wb2lzb24gZHVyaW5nIGEgbm9u
LWRlYnVnIGJvb3RpbmcgcHJvY2Vzcy4NCj4gDQo+IE5pY2UsIHRoYW5rcyBmb3IgdGhlIGRhdGEu
IElmIGl0IGlzIHNvbWVob3cgZG9hYmxlLCBob3dldmVyLCBJJ2QNCj4gc3RpbGwNCj4gcmVjb21t
ZW5kIHRvIGFkZGl0aW9uYWxseSBndWFyZCB0aGUgbmV3IGNvZGUgcGF0aCBieSBhIGNoZWNrIGlm
DQo+IGRlYnVnLXN1cHBvcnQgd2FzIHJlcXVlc3RlZC4gSWRlYWxseSB3aXRoIGFuIElTX0VOQUJM
RUQoKSBjb25maWcNCj4gY2hlY2sNCj4gc28gdGhhdCBpZiBpdCdzIGEgcHJvZHVjdGlvbiBrZXJu
ZWwgdGhlIGJyYW5jaCBpcyBzaW1wbHkgb3B0aW1pemVkDQo+IG91dA0KPiBieSB0aGUgY29tcGls
ZXIuDQoNCkRvZXMgaXQgbWVhbiB0aGUgbWVtemVybyBjb2RlIHBhdGggd291bGQgYmUgYXBwbGll
ZCBvbmx5IGF0DQpDT05GSUdfREVCVUdfU0xVQiBlbmFibGVkPyBJdCBleHBlY3RzIG5vIG90aGVy
IHBvdGVudGlhbCBvdmVyd3JpdGluZw0KaW4gbm9uLWRlYnVnIGtlcm5lbC4NCiANCkJ5IHRoZSB3
YXksIGJhc2VkIG9uIGRlLWNvdXBsaW5nIHByaW5jaXBsZSwgYWRkaW5nIGEgc3BlY2lmaWMNCmNv
bmRpdGlvbmFsIHN0YXRlbWVudChpc19lbmFibGUgc2x1Yl9kZWJ1ZykgaW4gYSBwcmltaXRpdmUN
CmZ1bmNpdG9uKGthc2FuX3VucG9pc29uKSBpcyBub3QgbmVhdC4gSXQgbWF5IGJlIG1vcmUgcHJv
cGVyIHRoYXQgdGhlDQpjb25kaXRpb25hbCBzdGF0ZW1lbnQgYmUgYWRkZWQgaW4gb3RoZXIgcHJv
Y2VkdXJlcyBvZiBzbHViIGFsbG9jLg0KIA0KVGhhbmtzLA0KDQpCUiwNClllZQ0KDQo+IA0KPiA+
IExhYiB0ZXN0OiBRRU1VNS4yICgrbXRlKSAvIGxpbnV4IGtlcm5lbCA1LjEzLXJjNw0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFllZSBMZWUgPHllZS5sZWVAbWVkaWF0ZWsuY29tPg0KPiA+IC0t
LQ0KPiA+ICBtbS9rYXNhbi9rYXNhbi5oIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbW0va2Fz
YW4va2FzYW4uaCBiL21tL2thc2FuL2thc2FuLmgNCj4gPiBpbmRleCBkOGZhYTY0NjE0YjcuLmVk
YzExYmNjM2ZmMyAxMDA2NDQNCj4gPiAtLS0gYS9tbS9rYXNhbi9rYXNhbi5oDQo+ID4gKysrIGIv
bW0va2FzYW4va2FzYW4uaA0KPiA+IEBAIC0zODksNyArMzg5LDcgQEAgc3RhdGljIGlubGluZSB2
b2lkIGthc2FuX3VucG9pc29uKGNvbnN0IHZvaWQNCj4gPiAqYWRkciwgc2l6ZV90IHNpemUsIGJv
b2wgaW5pdCkNCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+ICAgICAgICAgaWYgKGlu
aXQgJiYgKCh1bnNpZ25lZCBsb25nKXNpemUgJiBLQVNBTl9HUkFOVUxFX01BU0spKSB7DQo+ID4g
ICAgICAgICAgICAgICAgIGluaXQgPSBmYWxzZTsNCj4gPiAtICAgICAgICAgICAgICAgbWVtc2V0
KCh2b2lkICopYWRkciwgMCwgc2l6ZSk7DQo+ID4gKyAgICAgICAgICAgICAgIG1lbXplcm9fZXhw
bGljaXQoKHZvaWQgKilhZGRyLCBzaXplKTsNCj4gPiAgICAgICAgIH0NCj4gPiAgICAgICAgIHNp
emUgPSByb3VuZF91cChzaXplLCBLQVNBTl9HUkFOVUxFX1NJWkUpOw0KPiA+ICAgICAgICAgaHdf
c2V0X21lbV90YWdfcmFuZ2UoKHZvaWQgKilhZGRyLCBzaXplLCB0YWcsIGluaXQpOw0KPiA+IDIu
MTguMA0KPiA+IA0KPiA+IC0tDQo+ID4gWW91IHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBiZWNhdXNl
IHlvdSBhcmUgc3Vic2NyaWJlZCB0byB0aGUgR29vZ2xlDQo+ID4gR3JvdXBzICJrYXNhbi1kZXYi
IGdyb3VwLg0KPiA+IFRvIHVuc3Vic2NyaWJlIGZyb20gdGhpcyBncm91cCBhbmQgc3RvcCByZWNl
aXZpbmcgZW1haWxzIGZyb20gaXQsDQo+ID4gc2VuZCBhbiBlbWFpbCB0byBrYXNhbi1kZXYrdW5z
dWJzY3JpYmVAZ29vZ2xlZ3JvdXBzLmNvbS4NCj4gPiBUbyB2aWV3IHRoaXMgZGlzY3Vzc2lvbiBv
biB0aGUgd2ViIHZpc2l0IA0KPiA+IGh0dHBzOi8vZ3JvdXBzLmdvb2dsZS5jb20vZC9tc2dpZC9r
YXNhbi1kZXYvMjAyMTA2MjIwODQ3MjMuMjc2MzctMS15ZWUubGVlJTQwbWVkaWF0ZWsuY29tDQo+
ID4gLg0K

