Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B27A3B5E87
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 14:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhF1M7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 08:59:33 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41858 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232613AbhF1M7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 08:59:31 -0400
X-UUID: a881c5cdaab645838801bd269b2eaabf-20210628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=GL+Mjjx8Quv417PA3VfwMr1zQDua99oGX3zukE+Amuo=;
        b=Y8Bq90wgQaXu48ZkWANJLdqNwixUSzCHS9hjxlMW5JaQz8rTndR4O5U5OZxkv1Kk0yjpMKd8uyd7T3Z/XGKSzXTL0+iFTmF+4tDX4mmeJGGsmix9KOgwqvQAek9NDefXO4Nvtezeesizjp45M37WKdzpa32wVuUv/3ZLS8vDEyU=;
X-UUID: a881c5cdaab645838801bd269b2eaabf-20210628
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1925755508; Mon, 28 Jun 2021 20:56:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 28 Jun 2021 20:56:52 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Jun 2021 20:56:52 +0800
Message-ID: <cb333907c9ddc33aa95b96b8352a4f670fd32147.camel@mediatek.com>
Subject: Re: [PATCH v9 01/22] dt-bindings: ARM: Mediatek: Add new document
 bindings of imp i2c wrapper controller
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Rob Herring <robh@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, <Kewei.Xu@mediatek.com>
Date:   Mon, 28 Jun 2021 20:56:52 +0800
In-Reply-To: <5c0a88c7-7f64-fd00-4e0c-2b3163926f71@gmail.com>
References: <20210524122053.17155-1-chun-jie.chen@mediatek.com>
         <20210524122053.17155-2-chun-jie.chen@mediatek.com>
         <20210602171201.GA3566462@robh.at.kernel.org>
         <66e017401ab93aa02c5d2bbf11be9589b36649ac.camel@mediatek.com>
         <1f59ed31-4a0e-9719-bf84-1fe4cdd6c57d@gmail.com>
         <162334689784.9598.2709970788186333494@swboyd.mtv.corp.google.com>
         <de082c64-ace3-30b5-7404-1f4b607a83e1@gmail.com>
         <c8e8535cef67adeaefcfe943bbd8287806921e03.camel@mediatek.com>
         <CAGXv+5HcV6jbyDdZGzRX-2NHMztSONBKxmLxLQX6k+aQrwJ1ww@mail.gmail.com>
         <5c0a88c7-7f64-fd00-4e0c-2b3163926f71@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA2LTE4IGF0IDE1OjUwICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTgvMDYvMjAyMSAwODozMiwgQ2hlbi1ZdSBUc2FpIHdyb3RlOg0KPiA+IE9u
IFdlZCwgSnVuIDE2LCAyMDIxIGF0IDI6MzQgQU0gQ2h1bi1KaWUgQ2hlbg0KPiA+IDxjaHVuLWpp
ZS5jaGVuQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gPiANCj4gPiA+IE9uIEZyaSwgMjAyMS0w
Ni0xMSBhdCAxMTo1NiArMDIwMCwgTWF0dGhpYXMgQnJ1Z2dlciB3cm90ZToNCj4gPiA+ID4gDQo+
ID4gPiA+IE9uIDEwLzA2LzIwMjEgMTk6NDEsIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4gPiA+ID4g
PiBRdW90aW5nIE1hdHRoaWFzIEJydWdnZXIgKDIwMjEtMDYtMDggMDc6NDU6NDkpDQo+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gT24gMDcvMDYvMjAyMSAwNzoyMCwgQ2h1
bi1KaWUgQ2hlbiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gT24gV2VkLCAyMDIxLTA2LTAyIGF0IDEy
OjEyIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+
ID4gPiA+ID4gPiA+ICtkZXNjcmlwdGlvbjoNCj4gPiA+ID4gPiA+ID4gPiA+ICsgIFRoZSBNZWRp
YXRlayBpbXAgaTJjIHdyYXBwZXIgY29udHJvbGxlciBwcm92aWRlcw0KPiA+ID4gPiA+ID4gPiA+
ID4gZnVuY3Rpb25hbA0KPiA+ID4gPiA+ID4gPiA+ID4gY29uZmlndXJhdGlvbnMgYW5kIGNsb2Nr
cyB0byB0aGUgc3lzdGVtLg0KPiA+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ID4g
K3Byb3BlcnRpZXM6DQo+ID4gPiA+ID4gPiA+ID4gPiArICBjb21wYXRpYmxlOg0KPiA+ID4gPiA+
ID4gPiA+ID4gKyAgICBpdGVtczoNCj4gPiA+ID4gPiA+ID4gPiA+ICsgICAgICAtIGVudW06DQo+
ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLWltcF9paWNfd3Jh
cF9jDQo+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTkyLWltcF9p
aWNfd3JhcF9lDQo+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTky
LWltcF9paWNfd3JhcF9zDQo+ID4gPiA+ID4gPiA+ID4gPiArICAgICAgICAgIC0gbWVkaWF0ZWss
bXQ4MTkyLWltcF9paWNfd3JhcF93cw0KPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAtIG1l
ZGlhdGVrLG10ODE5Mi1pbXBfaWljX3dyYXBfdw0KPiA+ID4gPiA+ID4gPiA+ID4gKyAgICAgICAg
ICAtIG1lZGlhdGVrLG10ODE5Mi1pbXBfaWljX3dyYXBfbg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gPiA+IExvb2tzIHRvIG1lIGxpa2UgdGhlc2UgYXJlIGFsbCB0aGUgc2FtZSBoL3cs
IGJ1dCBqdXN0DQo+ID4gPiA+ID4gPiA+ID4gaGF2ZQ0KPiA+ID4gPiA+ID4gPiA+IGRpZmZlcmlu
Zw0KPiA+ID4gPiA+ID4gPiA+IHNldHMgb2YgY2xvY2tzLiBUaGF0J3Mgbm90IHJlYWxseSBhIHJl
YXNvbiB0byBoYXZlDQo+ID4gPiA+ID4gPiA+ID4gZGlmZmVyZW50DQo+ID4gPiA+ID4gPiA+ID4g
Y29tcGF0aWJsZXMuDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gSWYgeW91IG5l
ZWQgdG8ga25vdyB3aGF0IGNsb2NrcyBhcmUgcHJlc2VudCwgeW91IGNhbg0KPiA+ID4gPiA+ID4g
PiA+IHdhbGsgdGhlDQo+ID4gPiA+ID4gPiA+ID4gRFQgZm9yDQo+ID4gPiA+ID4gPiA+ID4gYWxs
ICdjbG9ja3MnIHByb3BlcnRpZXMgbWF0Y2hpbmcgdGhpcyBjbG9jayBjb250cm9sbGVyDQo+ID4g
PiA+ID4gPiA+ID4gaW5zdGFuY2UuIE9yDQo+ID4gPiA+ID4gPiA+ID4gdXNlDQo+ID4gPiA+ID4g
PiA+ID4gJ2Nsb2NrLWluZGljZXMnIHRvIGRlZmluZSB3aGljaCBvbmVzIGFyZSBwcmVzZW50Lg0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IElzIHRoZSBpZGVhIHRvIHVzZSBjbG9jay1pbmRpY2VzIGFu
ZCB0aGVuIGxpc3QgYWxsIHRoZSBjbG9jaw0KPiA+ID4gPiA+IGlkcyBpbg0KPiA+ID4gPiA+IHRo
ZXJlIGFuZCBtYXRjaCB0aGVtIHVwIGF0IGRyaXZlciBwcm9iZSB0aW1lIHRvIHJlZ2lzdGVyIHRo
ZQ0KPiA+ID4gPiA+IGNsb2Nrcw0KPiA+ID4gPiA+IHByb3ZpZGVkIGJ5IHRoZSBJTyByZWdpb24/
IEZlZWxzIGxpa2Ugd2UnbGwgZG8gYSBsb3Qgb2YNCj4gPiA+ID4gPiBwYXJzaW5nIGF0DQo+ID4g
PiA+ID4gZWFjaA0KPiA+ID4gPiA+IGJvb3QgdG8gbWF0Y2ggdXAgc3RydWN0dXJlcyBhbmQgcmVn
aXN0ZXIgY2xrcyB3aXRoIHRoZSBjbGsNCj4gPiA+ID4gPiBmcmFtZXdvcmsuDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gSWYgaXQncyBsaWtlIG90aGVyIFNvQ3MgdGhlbiB0aGUgY2xrIGlkIG1hcHMg
dG8gYSBoYXJkIG1hY3JvDQo+ID4gPiA+ID4gZm9yIGENCj4gPiA+ID4gPiB0eXBlDQo+ID4gPiA+
ID4gb2YgY2xrLCBhbmQgdGhvc2UgaGFyZCBtYWNyb3MgaGF2ZSBiZWVuIGdsdWVkIHRvZ2V0aGVy
IHdpdGgNCj4gPiA+ID4gPiBvdGhlcg0KPiA+ID4gPiA+IGNsa3MNCj4gPiA+ID4gPiBhbmQgdGhl
biBwYXJ0aXRpb25lZCBpbnRvIGRpZmZlcmVudCBJTyByZWdpb25zIHRvIG1ha2UgdXAgYQ0KPiA+
ID4gPiA+IGNsb2NrDQo+ID4gPiA+ID4gY29udHJvbGxlci4gT3IgbWF5YmUgaW4gdGhpcyBjYXNl
LCB0aG9zZSBjbGsgaGFyZCBtYWNyb3MgaGF2ZQ0KPiA+ID4gPiA+IGJlZW4NCj4gPiA+ID4gPiBz
Y2F0dGVyZWQgaW50byBlYWNoIElQIGJsb2NrIGxpa2UgU1BJLCBpMmMsIHVhcnQsIGV0Yy4gc28N
Cj4gPiA+ID4gPiB0aGF0IHRoZQ0KPiA+ID4gPiA+IGNsb2NrDQo+ID4gPiA+ID4gY29udHJvbGxl
ciBkb2Vzbid0IHJlYWxseSBleGlzdCBhbmQgbWVyZWx5IHRoZSBnYXRlcyBhbmQgcmF0ZQ0KPiA+
ID4gPiA+IGNvbnRyb2wNCj4gPiA+ID4gPiAobXV4L2RpdmlkZXIpIGZvciB0aGUgY2xrIHRoYXQn
cyBjbG9ja2luZyBzb21lIHBhcnRpY3VsYXIgSVANCj4gPiA+ID4gPiBibG9jaw0KPiA+ID4gPiA+
IGFsbA0KPiA+ID4gPiA+IGxpdmUgaW5zaWRlIHRoZSBJUCB3cmFwcGVyLiBJZiBpdCdzIHRoaXMg
Y2FzZSB0aGVuIEkgaG9wZQ0KPiA+ID4gPiA+IHRoZXJlIGFyZQ0KPiA+ID4gPiA+IGENCj4gPiA+
ID4gPiBidW5jaCBvZiBQTExzIHRoYXQgYXJlIGZpeGVkIHJhdGUgc28gdGhhdCB0aGUgaTJjIGNs
ayBkb2Vzbid0DQo+ID4gPiA+ID4gaGF2ZQ0KPiA+ID4gPiA+IHRvIGdvDQo+ID4gPiA+ID4gb3V0
c2lkZSB0aGUgd3JhcHBlciB0byBjaGFuZ2UgZnJlcXVlbmN5IChvZiB3aGljaCB0aGVyZQ0KPiA+
ID4gPiA+IHNob3VsZCBiZQ0KPiA+ID4gPiA+IHR3bw0KPiA+ID4gPiA+ICJzdGFuZGFyZCIgZnJl
cXVlbmNpZXMgYW55d2F5KS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+ID4gPiBSb2INCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFNvbWUgbW9kdWxlIGlz
IGRpdmlkZWQgdG8gc3ViLW1vZHVsZXMgd2hpY2ggYXJlIGRlc2lnbmVkDQo+ID4gPiA+ID4gPiA+
IGluDQo+ID4gPiA+ID4gPiA+IGRpZmZlcmVudA0KPiA+ID4gPiA+ID4gPiBoL3cgYmxvY2tzIGZv
ciBkaWZmZXJlbnQgdXNhZ2UsIGFuZCBpZiB3ZSB3YW50IHRvIHVzZSB0aGUNCj4gPiA+ID4gPiA+
ID4gc2FtZQ0KPiA+ID4gPiA+ID4gPiBjb21wYXRpYmxlIHRvIHByZXNlbnQgdGhlc2UgaC93IGJs
b2Nrcywgd2UgbmVlZCB0byBtb3ZlDQo+ID4gPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+ID4gPiBj
bG9jayBkYXRhDQo+ID4gPiA+ID4gPiA+IHByb3ZpZGVkIGJ5IHRoZXNlIGgvdyBibG9ja3MgdG8g
ZHRzLCBidXQgd2UgdXN1YWxseSB1c2UNCj4gPiA+ID4gPiA+ID4gZGlmZmVyZW50DQo+ID4gPiA+
ID4gPiA+IGNvbXBhdGlibGUgdG8gZ2V0IHRoZSBoL3cgYmxvY2tzIGRhdGEgaW4NCj4gPiA+ID4g
PiA+ID4gTWVkaWF0ZWsncyBjbG9jayBkcml2ZXIsIHNvIGRvIHlvdSBzdWdnZXN0IHRvIHJlZ2lz
dGVyDQo+ID4gPiA+ID4gPiA+IGNsb2NrDQo+ID4gPiA+ID4gPiA+IHByb3ZpZGVkDQo+ID4gPiA+
ID4gPiA+IGJ5IGRpZmZlcmVudCBoL3cgYmxvY2tzIHVzaW5nIHNhbWUgY29tcGF0aWJsZT8NCj4g
PiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoZSBtYXBwaW5nIG9mIHRo
ZW0gaXMgYXMgZm9sbG93aW5nOg0KPiA+ID4gPiA+ID4gaW1wX2lpY193cmFwX2M6ICAxMTAwNzAw
MA0KPiA+ID4gPiA+ID4gaW1wX2lpY193cmFwX2U6ICAxMWNiMTAwMA0KPiA+ID4gPiA+ID4gaW1w
X2lpY193cmFwX3M6ICAxMWQwMzAwMA0KPiA+ID4gPiA+ID4gaW1wX2lpY193cmFwX3dzOiAxMWQy
MzAwMA0KPiA+ID4gPiA+ID4gaW1wX2lpY193cmFwX3c6ICAxMWUwMTAwMA0KPiA+ID4gPiA+ID4g
aW1wX2lpY193cmFwX246ICAxMWYwMjAwMA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gU3VyZS4gV2hhdCBpcyB0aGVpciBwdXJwb3NlIHRob3VnaD8gQXJlIHRoZXkgc2ltcGx5
IGEgYnVuY2gNCj4gPiA+ID4gPiBvZg0KPiA+ID4gPiA+IGRpZmZlcmVudA0KPiA+ID4gPiA+IGky
YyBjbGtzPw0KPiA+ID4gPiA+IA0KPiA+ID4gPiANCj4gPiA+ID4gVGhhdCB3b3VsZCBiZSBuZWVk
IHRvIGJlIGFuc3dlcmVkIGJ5IE1lZGlhVGVrIGFzIEkgZG9uJ3QgaGF2ZQ0KPiA+ID4gPiBhY2Nl
c3MNCj4gPiA+ID4gdG8gYW55DQo+ID4gPiA+IGRvY3VtZW50YXRpb24uDQo+ID4gPiA+IA0KPiA+
ID4gPiBSZWdhcmRzLA0KPiA+ID4gPiBNYXR0aGlhcw0KPiA+ID4gDQo+ID4gPiBXZSBkZXNjcmli
ZSB3aGljaCBjbG9jayBjb250cm9sbGVycyBhcmUgZXhpc3QgaW4gZHRzIGFuZA0KPiA+ID4gZ2V0
IHRoZSBjbG9jayBkYXRhIHByb3ZpZGVkIGJ5IGNsb2NrIGNvbnRyb2xsZXIgaW4gZHJpdmVyIGRh
dGENCj4gPiA+IGJ5IG1hdGNoaW5nIGRldmljZSBjb21wYXRpYmxlLg0KPiA+ID4gDQo+ID4gPiBU
aGUgY2xvY2sgZGF0YSBjb250YWlucyBzZXZlcmFsIGNsb2NrcyB3aGljaCBpbmNsdWRlcyB0aGUg
Y2xvY2sNCj4gPiA+IGluZGV4LA0KPiA+ID4gcGFyZW50IGNsb2NrIHNvdXJjZSBhbmQgdGhlIGRl
dGFpbHMgb2YgcmVnIGNvbnRyb2wgaW5zaWRlIHRoZSBJUA0KPiA+ID4gYmxvY2sNCj4gPiA+IG9m
IGNsb2NrIGNvbnRyb2xsZXIuDQo+ID4gPiANCj4gPiA+IEluIE1UODE5MiBwbGF0Zm9ybSwgc29t
ZSBJUCBibG9jayBpcyBkaXZpZGUgdG8gc2V2ZXJhbCBzdWItYmxvY2tzIA0KPiA+ID4gYW5kDQo+
ID4gPiBlYWNoIHN1Yi1ibG9jayBwcm92aWRlcyBjbG9jayBjb250cm9sIGJ5IGl0c2VsZi4NCj4g
PiANCj4gPiBTb21lIG1vcmUgaW5mb3JtYXRpb246DQo+ID4gDQo+ID4gQmFzZWQgb24gd2hhdCBJ
IHJlYWQgaW4gdGhlIGRhdGFzaGVldHMsIEknbSBndWVzc2luZyB0aGF0IE1lZGlhVGVrDQo+ID4g
Z3JvdXBzDQo+ID4gdGhlIEkyQyBjb250cm9sbGVycyBpbnRvIHNldmVyYWwgZ3JvdXBzIGFuZCBw
bGFjZXMgdGhlbSBpbg0KPiA+IGRpZmZlcmVudCBwYXJ0cw0KPiA+IG9mIHRoZSBkaWUuIFRoZSBz
dWZmaXggb2YgaW1wX2lpY193cmFwX1hYWCBpcyBsaWtlbHkgcG9pbnRpbmcgdG8NCj4gPiB0aGUN
Cj4gPiBwbGFjZW1lbnQgb2YgdGhlIGdyb3VwLiBBbmQgdGhlIGltcF9paWNfd3JhcF9YWFggaXMg
d2hhdCB0aGUgbmFtZQ0KPiA+IHN1Z2dlc3RzDQo+ID4gYSB3cmFwcGVyIGFyb3VuZCB0aGUgZ3Jv
dXAgb2YgSTJDIGNvbnRyb2xsZXJzLiBUaGUgd3JhcHBlciBjb250YWlucw0KPiA+IGNsb2NrDQo+
ID4gYW5kIHJlc2V0IGNvbnRyb2xzLCBhcyB3ZWxsIGFzIG90aGVyIHRoaW5ncyB0aGF0IEkgY2Fu
J3QgbWFrZSBvdXQuDQo+ID4gDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLiBJ
ZiB0aGUgd3JhcHBlciBjb250YWlucyBtb3JlIHRoZW4ganVzdA0KPiBjbG9ja3MsDQo+IHRoZW4g
cHJvYmFibHkgd2Ugd2lsbCBuZWVkIGEgc29sdXRpb24gYXMgZG9uZSBieSBNTVNZUyBzdWJzeXN0
ZW0uDQo+IFdvdWxkIGJlIGdvb2QNCj4gaWYgeW91IGNvdWxkIHdvcmsgd2l0aCBNZWRpYVRlayB0
byBmaW5kIG91dCB3aGF0IGV4YWN0bHkgdGhpcw0KPiB3cmFwcGVycyBjb250YWluLA0KPiB0byBn
ZXQgYSBiZXR0ZXIgcGljdHVyZSBvZiBpZiB3ZSBuZWVkIGFuIGFkZGl0aW9uYWwgZHJpdmVyIG9y
IG5vdC4NCj4gDQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFzDQoNCisgS2V3ZWkNCg0KSGkgTWF0dGhp
YXMsDQoNCkFmdGVyIGRpc2N1c3Mgd2l0aCBpMmMgb3dlbnIoS2V3ZWkpIGluIG1lZGlhdGVrLCBh
bHRob3VnaCB0aGUgSFcgYmxvY2sNCm9mIGltcF9paWNfd3JhcF9YWFggY29udGFpbnMgbW9yZSB0
aGFuIGp1c3QgY2xvY2ssIGJ1dCB3ZSBvbmx5IHVzZSB0aGUNCmNsb2NrIHBhcnQgaW4gdGhpcyBI
VyBibG9jayBhbmQganVzdCBjb25zaWRlciB0aGF0IGltcF9paWNfd3JhcF9YWFggaXMNCmEgcHVy
ZSBjbG9jayBwcm92aWRlci4NCg0KVGhhbmtzIQ0KQmVzdCBSZWdhcmRzLA0KQ2h1bi1KaWUNCg==

