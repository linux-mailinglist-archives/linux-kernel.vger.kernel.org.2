Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245143D8C70
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 13:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhG1LFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 07:05:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60016 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231994AbhG1LFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 07:05:12 -0400
X-UUID: 8226f3546cc7485da802ac7adf75906a-20210728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=WuS5SPNVr0wzahpzgVixyvQu00cdYARn5gVWREstKDg=;
        b=dTE4L/rSNz7w+lMkOpEOOK+fQpQo17bttrYXY2pEdJeWhpCiHQKVBJ50BUmc0uDfPOPPJn7ORcog4Dt9cbvg0olie1n8OyWocOlK0K6J2CMob+hik+dpz7Dd8ZlH/9Oqrn7HgOAbKv6l1H5PPy43255IONtOUkivNe8xHf8zU1Q=;
X-UUID: 8226f3546cc7485da802ac7adf75906a-20210728
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2119956149; Wed, 28 Jul 2021 19:05:09 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 19:05:07 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 28 Jul 2021 19:05:07 +0800
Message-ID: <29f4844b1af163b0ec463fccbc9b902b3150f5c1.camel@mediatek.com>
Subject: Re: [PATCH 1/2] kasan, mm: reset tag when access metadata
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Marco Elver <elver@google.com>,
        Nicholas Tang <nicholas.tang@mediatek.com>,
        Andrew Yang <andrew.yang@mediatek.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        "Chinwen Chang" <chinwen.chang@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Kuan-Ying.Lee@mediatek.com>
Date:   Wed, 28 Jul 2021 19:05:07 +0800
In-Reply-To: <20210727192217.GV13920@arm.com>
References: <20210727040021.21371-1-Kuan-Ying.Lee@mediatek.com>
         <20210727040021.21371-2-Kuan-Ying.Lee@mediatek.com>
         <CANpmjNM03Pag9OvBBVnWnSBePRxsT+BvZtBwrh_61Qzmvp+dvA@mail.gmail.com>
         <b6b96caf30e62996fa3b75ae8d146c9cc0dcbbf6.camel@mediatek.com>
         <20210727192217.GV13920@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA3LTI3IGF0IDIwOjIyICswMTAwLCBDYXRhbGluIE1hcmluYXMgd3JvdGU6
DQo+IE9uIFR1ZSwgSnVsIDI3LCAyMDIxIGF0IDA0OjMyOjAyUE0gKzA4MDAsIEt1YW4tWWluZyBM
ZWUgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIxLTA3LTI3IGF0IDA5OjEwICswMjAwLCBNYXJjbyBF
bHZlciB3cm90ZToNCj4gPiA+ICtDYyBDYXRhbGluDQo+ID4gPiANCj4gPiA+IE9uIFR1ZSwgMjcg
SnVsIDIwMjEgYXQgMDY6MDAsIEt1YW4tWWluZyBMZWUgPA0KPiA+ID4gS3Vhbi1ZaW5nLkxlZUBt
ZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+ID4gPiANCj4gPiA+ID4gSGFyZHdhcmUgdGFnLWJhc2Vk
IEtBU0FOIGRvZXNuJ3QgdXNlIGNvbXBpbGVyIGluc3RydW1lbnRhdGlvbiwNCj4gPiA+ID4gd2UN
Cj4gPiA+ID4gY2FuIG5vdCB1c2Uga2FzYW5fZGlzYWJsZV9jdXJyZW50KCkgdG8gaWdub3JlIHRh
ZyBjaGVjay4NCj4gPiA+ID4gDQo+ID4gPiA+IFRodXMsIHdlIG5lZWQgdG8gcmVzZXQgdGFncyB3
aGVuIGFjY2Vzc2luZyBtZXRhZGF0YS4NCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6
IEt1YW4tWWluZyBMZWUgPEt1YW4tWWluZy5MZWVAbWVkaWF0ZWsuY29tPg0KPiA+ID4gDQo+ID4g
PiBUaGlzIGxvb2tzIHJlYXNvbmFibGUsIGJ1dCB0aGUgcGF0Y2ggdGl0bGUgaXMgbm90IHNheWlu
ZyB0aGlzIGlzDQo+ID4gPiBrbWVtbGVhaywgbm9yIGRvZXMgdGhlIGRlc2NyaXB0aW9uIHNheSB3
aGF0IHRoZSBwcm9ibGVtIGlzLiBXaGF0DQo+ID4gPiBwcm9ibGVtIGRpZCB5b3UgZW5jb3VudGVy
PyBXYXMgaXQgYSBmYWxzZSBwb3NpdGl2ZT8NCj4gPiANCj4gPiBrbWVtbGVhayB3b3VsZCBzY2Fu
IGtlcm5lbCBtZW1vcnkgdG8gY2hlY2sgbWVtb3J5IGxlYWsuDQo+ID4gV2hlbiBpdCBzY2FucyBv
biB0aGUgaW52YWxpZCBzbGFiIGFuZCBkZXJlZmVyZW5jZSwgdGhlIGlzc3VlDQo+ID4gd2lsbCBv
Y2N1ciBsaWtlIGJlbG93Lg0KPiA+IA0KPiA+IFNvIEkgdGhpbmsgd2Ugc2hvdWxkIHJlc2V0IHRo
ZSB0YWcgYmVmb3JlIHNjYW5uaW5nLg0KPiA+IA0KPiA+ICMgZWNobyBzY2FuID4gL3N5cy9rZXJu
ZWwvZGVidWcva21lbWxlYWsNCj4gPiBbICAxNTEuOTA1ODA0XQ0KPiA+ID09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+
IFsgIDE1MS45MDcxMjBdIEJVRzogS0FTQU46IG91dC1vZi1ib3VuZHMgaW4gc2Nhbl9ibG9jaysw
eDU4LzB4MTcwDQo+ID4gWyAgMTUxLjkwODc3M10gUmVhZCBhdCBhZGRyIGY3ZmYwMDAwYzAwNzRl
YjAgYnkgdGFzayBrbWVtbGVhay8xMzgNCj4gPiBbICAxNTEuOTA5NjU2XSBQb2ludGVyIHRhZzog
W2Y3XSwgbWVtb3J5IHRhZzogW2ZlXQ0KPiANCj4gSXQgd291bGQgYmUgaW50ZXJlc3RpbmcgdG8g
ZmluZCBvdXQgd2h5IHRoZSB0YWcgZG9lc24ndCBtYXRjaC4NCj4gS21lbWxlYWsNCj4gc2hvdWxk
IGluIHByaW5jaXBsZSBvbmx5IHNjYW4gdmFsaWQgb2JqZWN0cyB0aGF0IGhhdmUgYmVlbiBhbGxv
Y2F0ZWQNCj4gYW5kDQo+IHRoZSBwb2ludGVyIGNhbiBiZSBzYWZlbHkgZGVyZWZlcmVuY2VkLiAw
eGZlIGlzIEtBU0FOX1RBR19JTlZBTElELCBzbw0KPiBpdA0KPiBlaXRoZXIgZ29lcyBwYXN0IHRo
ZSBzaXplIG9mIHRoZSBvYmplY3QgKGludG8gdGhlIHJlZCB6b25lKSBvciBpdA0KPiBzdGlsbA0K
PiBhY2Nlc3NlcyB0aGUgb2JqZWN0IGFmdGVyIGl0IHdhcyBtYXJrZWQgYXMgZnJlZWQgYnV0IGJl
Zm9yZSBiZWluZw0KPiByZWxlYXNlZCBmcm9tIGttZW1sZWFrLg0KPiANCj4gV2l0aCBzbGFiLCBs
b29raW5nIGF0IF9fY2FjaGVfZnJlZSgpLCBpdCBjYWxscyBrYXNhbl9zbGFiX2ZyZWUoKQ0KPiBi
ZWZvcmUNCj4gX19fY2FjaGVfZnJlZSgpIC0+IGttZW1sZWFrX2ZyZWVfcmVjdXJzaXZlKCksIHNv
IHRoZSBzZWNvbmQgc2NlbmFyaW8NCj4gaXMNCj4gcG9zc2libGUuIFdpdGggc2x1YiwgaG93ZXZl
ciwgc2xhYl9mcmVlX2hvb2soKSBmaXJzdCByZWxlYXNlcyB0aGUNCj4gb2JqZWN0DQo+IGZyb20g
a21lbWxlYWsgYmVmb3JlIHBvaXNvbmluZyBpdC4gQmFzZWQgb24gdGhlIHN0YWNrIGR1bXAsIHlv
dSBhcmUNCj4gdXNpbmcgc2x1Yiwgc28gaXQgbWF5IGJlIHRoYXQga21lbWxlYWsgZ29lcyBpbnRv
IHRoZSBvYmplY3QgcmVkDQo+IHpvbmVzLg0KPiANCj4gSSdkIGxpa2UgdGhpcyBjbGFyaWZpZWQg
YmVmb3JlIGJsaW5kbHkgcmVzZXR0aW5nIHRoZSB0YWcuDQoNClRoaXMga2FzYW4gaXNzdWUgb25s
eSBoYXBwZW5lZCBvbiBoYXJkd2FyZSB0YWctYmFzZWQga2FzYW4gbW9kZS4NCkJlY2F1c2Uga2Fz
YW5fZGlzYWJsZV9jdXJyZW50KCkgd29ya3MgZm9yIGdlbmVyaWMgYW5kIHN3IHRhZy1iYXNlZA0K
a2FzYW4uDQoNCkhXIHRhZy1iYXNlZCBrYXNhbiBkZXBlbmRzIG9uIHNsdWIgc28gc2xhYiB3aWxs
IG5vdCBoaXQgdGhpcw0KaXNzdWUuDQpJIHRoaW5rIHdlIGNhbiBqdXN0IGNoZWNrIGlmIEhXIHRh
Zy1iYXNlZCBrYXNhbiBpcyBlbmFibGVkIG9yIG5vdA0KYW5kIGRlY2lkZSB0byByZXNldCB0aGUg
dGFnIGFzIGJlbG93Lg0KDQppZiAoa2FzYW5faGFzX2ludGVncmF0ZWRfaW5pdCgpKSAvLyBzbHVi
IGNhc2UsIGh3LXRhZyBrYXNhbg0KCXBvaW50ZXIgPSAqKHVuc2lnbmVkIGxvbmcgKilrYXNhbl9y
ZXNldF90YWcoKHZvaWQgKilwdHIpOw0KZWxzZQ0KCXBvaW50ZXIgPSAqcHRyOyAvLyBzbGFiDQoN
CklzIHRoaXMgYmV0dGVyIG9yIGFueSBvdGhlciBzdWdnZXN0aW9ucz8NCkFueSBzdWdnZXN0aW9u
IGlzIGFwcHJlY2lhdGVkLg0KDQpUaGFua3MsDQpLdWFuLVlpbmcgTGVlDQoNCj4gDQo=

