Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8C635BAB6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 09:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbhDLHTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 03:19:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37928 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236745AbhDLHTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 03:19:48 -0400
X-UUID: f9c370dcbca343a9a175ac8cc5963b49-20210412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=IhR0w7fkxv9QLOyDCj64kNBA7EE1dIlzyNRNY8w1a0w=;
        b=dLPWpx6wT8oLrLoarFUAoruHTv5L9gWxemzw1WyTYeW1mre4BLYBfXZoXcmtjRnWZQsrB5PohkfBzwMvAFkb978RAluoyVz9Ua2RPh/v7Y7vczuAwL3lgNmSAkyKpYC5Pu6sZ6MFmYMrSqJxNzCotbQ60hSl997iWCvbSh2UbL4=;
X-UUID: f9c370dcbca343a9a175ac8cc5963b49-20210412
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1439433201; Mon, 12 Apr 2021 15:19:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 12 Apr 2021 15:19:25 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Apr 2021 15:19:25 +0800
Message-ID: <1618211965.25062.34.camel@mtksdccf07>
Subject: Re: [PATCH 3/8] dt-bindings: apu: Add MT8192 APU power domain
From:   Flora Fu <flora.fu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        Flora Fu <flora.fu@mediatek.com>
Date:   Mon, 12 Apr 2021 15:19:25 +0800
In-Reply-To: <20210409182338.GA3895583@robh.at.kernel.org>
References: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
         <1617766086-5502-4-git-send-email-flora.fu@mediatek.com>
         <20210409182338.GA3895583@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E6D439E09D1D32AB80FED7FFF7DDF6F5225F21D18AC1F0D6CB82EE2986E5CDF52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYiwNCg0KSW4gbXQ4MTkyIGhhcmR3YXJlLCB3ZSBvbmx5IGNvbnRyb2wgdG9wIHBvd2Vy
IGRvbWFpbiBpbiBrZXJuZWwuDQpJdCBpcyB1bm5lY2Vzc2FyeSB0byBjcmVhdGUgYSBzcGVjaWZp
YyBoZWFkZXIganVzdCBmb3Igc3VjaCBwdXJwb3NlLiANCkkgd2lsbCB1cGRhdGUgdGhlIHBhdGNo
IGluIHRoZSBuZXh0IHZlcnNpb24uDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3Lg0KDQpUaGFua3Ms
DQpGbG9yYQ0KDQoNCk9uIEZyaSwgMjAyMS0wNC0wOSBhdCAxMzoyMyAtMDUwMCwgUm9iIEhlcnJp
bmcgd3JvdGU6DQo+IE9uIFdlZCwgQXByIDA3LCAyMDIxIGF0IDExOjI4OjAxQU0gKzA4MDAsIEZs
b3JhIEZ1IHdyb3RlOg0KPiA+IENyZWF0ZSBNVDgxOTIgQVBVIHBvd2VyIGRvbWFpbiBiaW5kaW5n
cy4NCj4gPiBBZGQgdG9wIHBvd2VyIGRvbWFpbiBpZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBGbG9yYSBGdSA8ZmxvcmEuZnVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBpbmNsdWRl
L2R0LWJpbmRpbmdzL3Bvd2VyL210ODE5Mi1hcHUtcG93ZXIuaCB8IDExICsrKysrKysrKysrDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210ODE5Mi1hcHUtcG93ZXIuaA0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2VyL210ODE5Mi1hcHUtcG93
ZXIuaCBiL2luY2x1ZGUvZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTkyLWFwdS1wb3dlci5oDQo+ID4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmI4MjFiZDQ4MTFh
Ng0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL3Bvd2Vy
L210ODE5Mi1hcHUtcG93ZXIuaA0KPiA+IEBAIC0wLDAgKzEsMTEgQEANCj4gPiArLyogU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiArICoNCj4gPiArICogQ29weXJpZ2h0IChj
KSAyMDIxIE1lZGlhVGVrIEluYy4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaWZuZGVmIF9EVF9C
SU5ESU5HU19QT1dFUl9NVDgxOTJfQVBVX1BPV0VSX0gNCj4gPiArI2RlZmluZSBfRFRfQklORElO
R1NfUE9XRVJfTVQ4MTkyX0FQVV9QT1dFUl9IDQo+ID4gKw0KPiA+ICsjZGVmaW5lIE1UODE5Ml9Q
T1dFUl9ET01BSU5fQVBVU1lTX1RPUAkwDQo+IA0KPiBSZWFsbHksIHlvdSBkb24ndCBrbm93IHdo
YXQgdGhlIG90aGVyIHBvd2VyIGRvbWFpbnMgYXJlPyBQbGVhc2UgbWFrZSANCj4gdGhpcyBhcyBj
b21wbGV0ZSBhcyBwb3NzaWJsZS4gVGhlc2UgaGVhZGVycyBjcmVhdGUgYSBtZXJnZSBtZXNzLg0K
PiANCj4gUm9iDQoNCg==

