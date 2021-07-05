Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44163BBDE9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 15:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhGEN4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 09:56:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36143 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231266AbhGEN43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 09:56:29 -0400
X-UUID: 47d8e4c82a8649c0bb9cd813dff420bc-20210705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=tWi3mQSz+Lkgh0l0iwDGIwHxWLR6tJfo9WaRVowuGB8=;
        b=dPu98BdeHWnRyxm+1sU6UNGnA2iaJesZdv5PEjiznJk4+WaIgUUTfKYe7REA1tXMI0nBZ/mgm7qTxliB8gbHMWMDscQngOVe2oHeLTNBNw0Cg+wb84GJcgcGYAFdQMR669u3ONnVB7MyagPlG0l7IXplHhnuzskqlLAM5MMHSEI=;
X-UUID: 47d8e4c82a8649c0bb9cd813dff420bc-20210705
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1313421630; Mon, 05 Jul 2021 21:53:48 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 5 Jul 2021 21:53:47 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 5 Jul 2021 21:53:47 +0800
Message-ID: <da9034e02d0a2b5ce5fae01403a881e4d637ab16.camel@mediatek.com>
Subject: Re: [PATCH v6 2/2] kasan: Add memzero int for unaligned size at
 DEBUG
From:   Yee Lee <yee.lee@mediatek.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     LKML <linux-kernel@vger.kernel.org>, <nicholas.tang@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <chinwen.chang@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:KASAN" <kasan-dev@googlegroups.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 5 Jul 2021 21:53:47 +0800
In-Reply-To: <CA+fCnZfKAZuy9oyDpTgNUTcNz5gnfHpJK5WN-yBNDV5VF8cq0g@mail.gmail.com>
References: <20210705103229.8505-1-yee.lee@mediatek.com>
         <20210705103229.8505-3-yee.lee@mediatek.com>
         <CA+fCnZdhrjo4RMBcj94MO7Huf_BVzaF5S_E97xS1vXGHoQdu5A@mail.gmail.com>
         <CANpmjNNXbszUL4M+-swi7k28h=zuY-KTfw+6W90hk2mgxr8hRQ@mail.gmail.com>
         <CA+fCnZfKAZuy9oyDpTgNUTcNz5gnfHpJK5WN-yBNDV5VF8cq0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91LCBNYWNyby4gSSB0aG91Z2h0IG1lbWJlcnMgaW4gInN1Z2dlc3RlZC1ieSIgd291
bGQgYmUgcHV0IGluDQp0aGUgbGlzdCBhcyB3ZWxsLi4uIEFuZCB0aGFuayB5b3UgZ3V5cyBmb3Ig
dGhlIHJldmlldyB0aGVzZSBkYXlzLiANCg0KDQpAQW5kcmV3IE1vdG9tDQpIaSBBbmRyZXcsIA0K
DQpDb3VsZCB5b3UgaGVscCB0byBwdXNoIHRoZSBwYXRjaGVzPyBXZSBhcmUgZGVhbGluZyB3aXRo
IHRoZSBpc3N1ZSBhbmQgDQp3b3VsZCBiYWNrcG9ydCB0byBBbmRyb2lkIHBvcmplY3QgcmlnaHQg
YWZ0ZXIgdGhlIGFjdGlvbi4NCkFwcHJlY2lhdGVkIQ0KDQoNCkJSLA0KWWVlIA0KDQoNCk9uIE1v
biwgMjAyMS0wNy0wNSBhdCAxMzoyMyArMDIwMCwgQW5kcmV5IEtvbm92YWxvdiB3cm90ZToNCj4g
T24gTW9uLCBKdWwgNSwgMjAyMSBhdCAxOjE4IFBNIE1hcmNvIEVsdmVyIDxlbHZlckBnb29nbGUu
Y29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBNb24sIDUgSnVsIDIwMjEgYXQgMTM6MTIsIEFuZHJl
eSBLb25vdmFsb3YgPGFuZHJleWtudmxAZ21haWwuY29tDQo+ID4gPiB3cm90ZToNCj4gPiBbLi4u
XQ0KPiA+ID4gPiArICAgICAgIC8qDQo+ID4gPiA+ICsgICAgICAgICogRXhwbGljaXRseSBpbml0
aWFsaXplIHRoZSBtZW1vcnkgd2l0aCB0aGUgcHJlY2lzZQ0KPiA+ID4gPiBvYmplY3Qgc2l6ZSB0
bw0KPiA+ID4gPiArICAgICAgICAqIGF2b2lkIG92ZXJ3cml0aW5nIHRoZSBTTEFCIHJlZHpvbmUu
IFRoaXMgZGlzYWJsZXMNCj4gPiA+ID4gaW5pdGlhbGl6YXRpb24gaW4NCj4gPiA+ID4gKyAgICAg
ICAgKiB0aGUgYXJjaCBjb2RlIGFuZCBtYXkgdGh1cyBsZWFkIHRvIHBlcmZvcm1hbmNlDQo+ID4g
PiA+IHBlbmFsdHkuIFRoZSBwZW5hbHR5DQo+ID4gPiA+ICsgICAgICAgICogaXMgYWNjZXB0ZWQg
c2luY2UgU0xBQiByZWR6b25lcyBhcmVuJ3QgZW5hYmxlZCBpbg0KPiA+ID4gPiBwcm9kdWN0aW9u
IGJ1aWxkcy4NCj4gPiA+ID4gKyAgICAgICAgKi8NCj4gPiA+ID4gKyAgICAgICBpZiAoX19zbHVi
X2RlYnVnX2VuYWJsZWQoKSAmJg0KPiA+ID4gDQo+ID4gPiBXaGF0IGhhcHBlbmVkIHRvIHNsdWJf
ZGVidWdfZW5hYmxlZF91bmxpa2VseSgpPyBXYXMgaXQgcmVuYW1lZD8NCj4gPiA+IFdoeT8gSQ0K
PiA+ID4gZGlkbid0IHJlY2VpdmUgcGF0Y2ggIzEgb2YgdjYgKG5vciBvZiB2NSkuDQo+ID4gDQo+
ID4gU29tZWJvZHkgaGFkIHRoZSBzYW1lIGlkZWEgd2l0aCB0aGUgaGVscGVyOg0KPiA+IGh0dHBz
Oi8vbGttbC5rZXJuZWwub3JnL3IvWU9Lc0M3NWtKZkNad3lTREBlbHZlci5nb29nbGUuY29tDQo+
ID4gYW5kIE1hdHRoZXcgZGlkbid0IGxpa2UgdGhlIF91bmxpa2VseSgpIHByZWZpeC4NCj4gPiAN
Cj4gPiBXaGljaCBtZWFudCB3ZSBzaG91bGQganVzdCBtb3ZlIHRoZSBleGlzdGluZyBoZWxwZXIg
aW50cm9kdWNlZCBpbg0KPiA+IHRoZQ0KPiA+IG1lcmdlIHdpbmRvdy4NCj4gPiANCj4gPiBQYXRj
aCAxLzI6IA0KPiA+IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAyMTA3MDUxMDMyMjkuODUw
NS0yLXllZS5sZWVAbWVkaWF0ZWsuY29tDQo+IA0KPiBHb3QgaXQuIFRoYW5rIHlvdSwgTWFyY28h
DQo=

