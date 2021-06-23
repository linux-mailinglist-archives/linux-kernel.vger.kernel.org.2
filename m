Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946873B1294
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 06:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhFWEOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 00:14:49 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:45952 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229544AbhFWEOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 00:14:47 -0400
X-UUID: bfc18a5dc5c54696a76ab05f28b8c583-20210623
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=TBxfwLBKGn4+TI8Df5N7zNLI4LFZZ6G306I1NI2naDU=;
        b=rEs2Lb/bY+TyhaTlmCTs9yMAwPjjrrSVjxXYX1SnoRuM2G3k3CjMG2JT3FgTyX1Aa8+xufkuPW3PzdLpkE81F6wc2N/b/A53e/tTaUj7tKJPmSmTco8vwlf4Qz6rL+znJh/Ur8P9dKGyDwRK7mGo5/4mAJo2UQaP8GteZ+GZSeQ=;
X-UUID: bfc18a5dc5c54696a76ab05f28b8c583-20210623
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1280553861; Wed, 23 Jun 2021 12:12:28 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Jun 2021 12:12:27 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Jun 2021 12:12:27 +0800
Message-ID: <d75209622c3ffd9c2c9743c594fa5ff60d19a9fc.camel@mediatek.com>
Subject: Re: [PATCH v3 3/3] kasan: add memory corruption identification
 support for hardware tag-based mode
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
        <chinwen.chang@mediatek.com>, <nicholas.tang@mediatek.com>,
        <kuan-ying.lee@mediatek.com>
Date:   Wed, 23 Jun 2021 12:12:26 +0800
In-Reply-To: <CA+fCnZcSy6LqqhbYfiC8hn16+T640uw_rnUzNPg1zsvg_RwYzw@mail.gmail.com>
References: <20210620114756.31304-1-Kuan-Ying.Lee@mediatek.com>
         <20210620114756.31304-4-Kuan-Ying.Lee@mediatek.com>
         <CA+fCnZcSy6LqqhbYfiC8hn16+T640uw_rnUzNPg1zsvg_RwYzw@mail.gmail.com>
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
YW4tWWluZy5MZWVAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPiANCj4gPiBBZGQgbWVtb3J5IGNv
cnJ1cHRpb24gaWRlbnRpZmljYXRpb24gc3VwcG9ydCBmb3IgaGFyZHdhcmUgdGFnLWJhc2VkDQo+
ID4gbW9kZS4gV2Ugc3RvcmUgb25lIG9sZCBmcmVlIHBvaW50ZXIgdGFnIGFuZCBmcmVlIGJhY2t0
cmFjZS4NCj4gDQo+IFBsZWFzZSBleHBsYWluIHdoeSBvbmx5IG9uZS4NCj4gDQoNCkdvdCBpdC4g
SSB3aWxsIHJld3JpdGUgdGhpcyBjb21taXQgbWVzc2FnZSBpbiB2NC4NCg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEt1YW4tWWluZyBMZWUgPEt1YW4tWWluZy5MZWVAbWVkaWF0ZWsuY29tPg0KPiA+IFN1
Z2dlc3RlZC1ieTogTWFyY28gRWx2ZXIgPGVsdmVyQGdvb2dsZS5jb20+DQo+ID4gQ2M6IEFuZHJl
eSBSeWFiaW5pbiA8cnlhYmluaW4uYS5hQGdtYWlsLmNvbT4NCj4gPiBDYzogQWxleGFuZGVyIFBv
dGFwZW5rbyA8Z2xpZGVyQGdvb2dsZS5jb20+DQo+ID4gQ2M6IEFuZHJleSBLb25vdmFsb3YgPGFu
ZHJleWtudmxAZ21haWwuY29tPg0KPiA+IENjOiBEbWl0cnkgVnl1a292IDxkdnl1a292QGdvb2ds
ZS5jb20+DQo+ID4gQ2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+
DQo+ID4gLS0tDQo+ID4gIGxpYi9LY29uZmlnLmthc2FuIHwgMiArLQ0KPiA+ICBtbS9rYXNhbi9r
YXNhbi5oICB8IDIgKy0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIg
ZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2xpYi9LY29uZmlnLmthc2FuIGIv
bGliL0tjb25maWcua2FzYW4NCj4gPiBpbmRleCA2ZjVkNDg4MzIxMzkuLjJjYzI1NzkyYmMyZiAx
MDA2NDQNCj4gPiAtLS0gYS9saWIvS2NvbmZpZy5rYXNhbg0KPiA+ICsrKyBiL2xpYi9LY29uZmln
Lmthc2FuDQo+ID4gQEAgLTE1Nyw3ICsxNTcsNyBAQCBjb25maWcgS0FTQU5fU1RBQ0sNCj4gPiAN
Cj4gPiAgY29uZmlnIEtBU0FOX1RBR1NfSURFTlRJRlkNCj4gPiAgICAgICAgIGJvb2wgIkVuYWJs
ZSBtZW1vcnkgY29ycnVwdGlvbiBpZGVudGlmaWNhdGlvbiINCj4gPiAtICAgICAgIGRlcGVuZHMg
b24gS0FTQU5fU1dfVEFHUw0KPiA+ICsgICAgICAgZGVwZW5kcyBvbiBLQVNBTl9TV19UQUdTIHx8
IEtBU0FOX0hXX1RBR1MNCj4gPiAgICAgICAgIGhlbHANCj4gPiAgICAgICAgICAgVGhpcyBvcHRp
b24gZW5hYmxlcyBiZXN0LWVmZm9ydCBpZGVudGlmaWNhdGlvbiBvZiBidWcNCj4gPiB0eXBlDQo+
ID4gICAgICAgICAgICh1c2UtYWZ0ZXItZnJlZSBvciBvdXQtb2YtYm91bmRzKSBhdCB0aGUgY29z
dCBvZg0KPiA+IGluY3JlYXNlZA0KPiA+IGRpZmYgLS1naXQgYS9tbS9rYXNhbi9rYXNhbi5oIGIv
bW0va2FzYW4va2FzYW4uaA0KPiA+IGluZGV4IGIwZmM5YTFlYjdlMy4uZDZmOTgyYjhhODRlIDEw
MDY0NA0KPiA+IC0tLSBhL21tL2thc2FuL2thc2FuLmgNCj4gPiArKysgYi9tbS9rYXNhbi9rYXNh
bi5oDQo+ID4gQEAgLTE1Myw3ICsxNTMsNyBAQCBzdHJ1Y3Qga2FzYW5fdHJhY2sgew0KPiA+ICAg
ICAgICAgZGVwb3Rfc3RhY2tfaGFuZGxlX3Qgc3RhY2s7DQo+ID4gIH07DQo+ID4gDQo+ID4gLSNp
ZmRlZiBDT05GSUdfS0FTQU5fVEFHU19JREVOVElGWQ0KPiA+ICsjaWYgZGVmaW5lZChDT05GSUdf
S0FTQU5fVEFHU19JREVOVElGWSkgJiYNCj4gPiBkZWZpbmVkKENPTkZJR19LQVNBTl9TV19UQUdT
KQ0KPiA+ICAjZGVmaW5lIEtBU0FOX05SX0ZSRUVfU1RBQ0tTIDUNCj4gPiAgI2Vsc2UNCj4gPiAg
I2RlZmluZSBLQVNBTl9OUl9GUkVFX1NUQUNLUyAxDQo+ID4gLS0NCj4gPiAyLjE4LjANCj4gPiAN
Cj4gDQo+IE90aGVyIHRoYW4gdGhhdDoNCj4gDQo+IFJldmlld2VkLWJ5OiBBbmRyZXkgS29ub3Zh
bG92IDxhbmRyZXlrbnZsQGdtYWlsLmNvbT4NCg==

