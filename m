Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2351E39B6EE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 12:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhFDKXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 06:23:55 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45315 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229625AbhFDKXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:23:53 -0400
X-UUID: 68feef41179049348cf75fc2fabb35d5-20210604
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ejuq5SlmfT6xWK2lKEuK37+s2rh96rXwkYOgTP8rwM8=;
        b=reDmGyp7LkkMAbv4ho1Yv6ufmFFxJHZJfHckQF+mrc3CGfDWHvZntMjBnj8Vy5xb1LujBfYIsl3ILBnSlMkYHMh/SwXRlENtTQC34vgIcO6jidIDs88GYerosKR/DQ/gl8AM66qr/IGDd3jdg/hkoCX8Ij/MEDcncjAH8qJ9RnQ=;
X-UUID: 68feef41179049348cf75fc2fabb35d5-20210604
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <wendell.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 771641668; Fri, 04 Jun 2021 18:22:03 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Jun 2021 18:22:01 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Jun 2021 18:22:01 +0800
Message-ID: <1622802121.26830.22.camel@mtkswgap22>
Subject: Re: [PATCH 1/1] clk: Export clk_register_composite
From:   Wendell Lin <wendell.lin@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        ARM/Mediatek SoC support <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Fri, 4 Jun 2021 18:22:01 +0800
In-Reply-To: <20210604082524.GF2435141@dell>
References: <1595493126-21611-1-git-send-email-wendell.lin@mediatek.com>
         <1597052186.27843.1.camel@mtkswgap22>
         <CAF2Aj3hZB08d8x6XOqsP4m5fv76fWH48U95j8ugLt-YWFJ-kkA@mail.gmail.com>
         <162276982204.1835121.10976600065855289763@swboyd.mtv.corp.google.com>
         <20210604082427.GE2435141@dell> <20210604082524.GF2435141@dell>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA2LTA0IGF0IDA5OjI1ICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+IE9u
IEZyaSwgMDQgSnVuIDIwMjEsIExlZSBKb25lcyB3cm90ZToNCj4gDQo+ID4gT24gVGh1LCAwMyBK
dW4gMjAyMSwgU3RlcGhlbiBCb3lkIHdyb3RlOg0KPiA+IA0KPiA+ID4gUXVvdGluZyBMZWUgSm9u
ZXMgKDIwMjEtMDUtMjAgMDk6MDc6NDIpDQo+ID4gPiA+IE9uIE1vbiwgMTAgQXVnIDIwMjAgYXQg
MTA6MzYsIFdlbmRlbGwgTGluIDx3ZW5kZWxsLmxpbkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+
ID4gPiANCj4gPiA+ID4gICAgIEhpIE1hdHRoaWFzIGFuZCBhbGwsDQo+ID4gPiA+IA0KPiA+ID4g
PiAgICAgR2VudGxlIHBpbmcgb24gdGhpcyBwYXRjaC4NCj4gPiA+ID4gDQo+ID4gPiA+IA0KPiA+
ID4gPiBXaGF0IGFib3V0IGEgbm90LXNvLWdlbnRsZSBwaW5nIG9uIHRoaXMgcGF0Y2g/ICBHcnJy
ci4uLiA6KQ0KPiA+ID4gPiANCj4gPiA+ID4gRllJLCB0aGlzIGlzIHN0aWxsIHJlcXVpcmVkIGJ5
IG1vcmUgdGhhbiBvbmUgc291cmNlLg0KPiA+ID4gPiANCj4gPiA+ID4gUGxlYXNlIGhlbHAgZ2V0
IHRoaXMgb3V0IG9mIGFsbCBvZiB0aGUgdmVuZG9yIHRyZWVzIHBsZWFzZS4NCj4gPiA+ID4gDQo+
ID4gPiANCj4gPiA+IElzIHRoZXJlIGFuIGluLWtlcm5lbCB1c2VyPw0KPiA+IA0KPiA+IEhvdyBj
YW4gdGhlcmUgYmU/ICBJdCdzIG5vdCBleHBvcnRlZCB5ZXQuIDopDQo+ID4gDQo+ID4gSG93ZXZl
ciB0aGVyZSBzaG91bGRuJ3QgYmUgYW55IGJhcnJpZXJzIGZvciB2ZW5kb3JzIHJlcHJlc2VudGVk
IGluDQo+ID4gTWFpbmxpbmUgdG8gYnVpbGQgdGhlaXIgZHJpdmVycyBhcyBtb2R1bGVzIGlmIHRo
ZXkgc28gd2lzaC4gIElmL3doZW4NCj4gPiB0aGV5IGRvLCB0aGlzIHdpbGwgbmVlZCB0byBiZSBl
eHBvcnRlZC4NCj4gDQo+IFdlbmRlbGwgTGluLCBpcyB0aGlzIHdoYXQgeW91IHdpc2ggdG8gZG8g
d2l0aCB0aGUgaW4ta2VybmVsIE1lZGlhVGVrDQo+IGRyaXZlcj8NCj4gDQpUaGlzIGlzIGJlY2F1
c2UgTWVkaWF0ZWsgY2xvY2sgZHJpdmVyIHdvdWxkIGJlIGJ1aWx0IGFzIGtlcm5lbCBtb2R1bGUs
DQpzbyBjbGtfcmVnaXN0ZXJfY29tcG9zaXRlKCkgdXNlZCBzaG91bGQgYmUgZXhwb3J0ZWQsIHRo
ZW4gd2UgY291bGQgdXNlDQppdC4gDQoNClBsZWFzZSByZWZlcjoNCltQQVRDSCAyLzJdIGNsazog
bWVkaWF0ZWs6IEFkZCBFWFBPUlRfU1lNQk9MIGZvciBrZXJuZWwgbW9kdWxlIHN1cHBvcnQgDQpo
dHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC83LzEvMTI0DQorRVhQT1JUX1NZTUJPTChtdGtfY2xr
X3JlZ2lzdGVyX2NvbXBvc2l0ZXMpOw0KDQpjbGtfcmVnaXN0ZXJfY29tcG9zaXRlKCkgaXMgdXNl
ZCBieSBNZWRpYXRlayBjbGsga2VybmVsIG1vZHVsZS4NCkZyb20gZXhwb3J0IHN5bWJvbDogbXRr
X2Nsa19yZWdpc3Rlcl9jb21wb3NpdGVzLiANCg0K

