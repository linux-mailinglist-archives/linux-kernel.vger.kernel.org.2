Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DCE3A740B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 04:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFOCgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 22:36:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48848 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229809AbhFOCgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 22:36:46 -0400
X-UUID: b244fbb211c9499e8c058deaf065f444-20210615
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=JNXKNmpy51jBAsMEkhMZ98xjcuU+lc4j1vj8Rx5Ai8I=;
        b=pGi71SOzJXO1tj0nUNmn32NhoizTYmfootxQ2xckZVUdU2xFVvllMrFugcJ87D9CmVpL9c26088cfc/PJAah0GkL22rKI8CRTUxbxez/KcJNGLvnHLM5K3Up/oBR1wiuZKZjXOMr77ls8v6yiX+HkasoK/VZeSwrHBu3zVIC6RU=;
X-UUID: b244fbb211c9499e8c058deaf065f444-20210615
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1001541838; Tue, 15 Jun 2021 10:34:38 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 15 Jun 2021 10:34:37 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Jun 2021 10:34:37 +0800
Message-ID: <c8e8535cef67adeaefcfe943bbd8287806921e03.camel@mediatek.com>
Subject: Re: [PATCH v9 01/22] dt-bindings: ARM: Mediatek: Add new document
 bindings of imp i2c wrapper controller
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>
CC:     Nicolas Boichat <drinkcat@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Date:   Tue, 15 Jun 2021 10:34:37 +0800
In-Reply-To: <de082c64-ace3-30b5-7404-1f4b607a83e1@gmail.com>
References: <20210524122053.17155-1-chun-jie.chen@mediatek.com>
         <20210524122053.17155-2-chun-jie.chen@mediatek.com>
         <20210602171201.GA3566462@robh.at.kernel.org>
         <66e017401ab93aa02c5d2bbf11be9589b36649ac.camel@mediatek.com>
         <1f59ed31-4a0e-9719-bf84-1fe4cdd6c57d@gmail.com>
         <162334689784.9598.2709970788186333494@swboyd.mtv.corp.google.com>
         <de082c64-ace3-30b5-7404-1f4b607a83e1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA2LTExIGF0IDExOjU2ICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTAvMDYvMjAyMSAxOTo0MSwgU3RlcGhlbiBCb3lkIHdyb3RlOg0KPiA+IFF1
b3RpbmcgTWF0dGhpYXMgQnJ1Z2dlciAoMjAyMS0wNi0wOCAwNzo0NTo0OSkNCj4gPiA+IA0KPiA+
ID4gDQo+ID4gPiBPbiAwNy8wNi8yMDIxIDA3OjIwLCBDaHVuLUppZSBDaGVuIHdyb3RlOg0KPiA+
ID4gPiBPbiBXZWQsIDIwMjEtMDYtMDIgYXQgMTI6MTIgLTA1MDAsIFJvYiBIZXJyaW5nIHdyb3Rl
Og0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ID4gPiA+ID4g
KyAgVGhlIE1lZGlhdGVrIGltcCBpMmMgd3JhcHBlciBjb250cm9sbGVyIHByb3ZpZGVzDQo+ID4g
PiA+ID4gPiBmdW5jdGlvbmFsDQo+ID4gPiA+ID4gPiBjb25maWd1cmF0aW9ucyBhbmQgY2xvY2tz
IHRvIHRoZSBzeXN0ZW0uDQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArcHJvcGVydGllczoN
Cj4gPiA+ID4gPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gPiA+ID4gPiArICAgIGl0ZW1zOg0KPiA+
ID4gPiA+ID4gKyAgICAgIC0gZW51bToNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgLSBtZWRpYXRl
ayxtdDgxOTItaW1wX2lpY193cmFwX2MNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgLSBtZWRpYXRl
ayxtdDgxOTItaW1wX2lpY193cmFwX2UNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgLSBtZWRpYXRl
ayxtdDgxOTItaW1wX2lpY193cmFwX3MNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgLSBtZWRpYXRl
ayxtdDgxOTItaW1wX2lpY193cmFwX3dzDQo+ID4gPiA+ID4gPiArICAgICAgICAgIC0gbWVkaWF0
ZWssbXQ4MTkyLWltcF9paWNfd3JhcF93DQo+ID4gPiA+ID4gPiArICAgICAgICAgIC0gbWVkaWF0
ZWssbXQ4MTkyLWltcF9paWNfd3JhcF9uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gTG9va3MgdG8g
bWUgbGlrZSB0aGVzZSBhcmUgYWxsIHRoZSBzYW1lIGgvdywgYnV0IGp1c3QgaGF2ZQ0KPiA+ID4g
PiA+IGRpZmZlcmluZyANCj4gPiA+ID4gPiBzZXRzIG9mIGNsb2Nrcy4gVGhhdCdzIG5vdCByZWFs
bHkgYSByZWFzb24gdG8gaGF2ZSBkaWZmZXJlbnQgDQo+ID4gPiA+ID4gY29tcGF0aWJsZXMuIA0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IElmIHlvdSBuZWVkIHRvIGtub3cgd2hhdCBjbG9ja3MgYXJl
IHByZXNlbnQsIHlvdSBjYW4gd2FsayB0aGUNCj4gPiA+ID4gPiBEVCBmb3IgDQo+ID4gPiA+ID4g
YWxsICdjbG9ja3MnIHByb3BlcnRpZXMgbWF0Y2hpbmcgdGhpcyBjbG9jayBjb250cm9sbGVyDQo+
ID4gPiA+ID4gaW5zdGFuY2UuIE9yDQo+ID4gPiA+ID4gdXNlIA0KPiA+ID4gPiA+ICdjbG9jay1p
bmRpY2VzJyB0byBkZWZpbmUgd2hpY2ggb25lcyBhcmUgcHJlc2VudC4NCj4gPiANCj4gPiBJcyB0
aGUgaWRlYSB0byB1c2UgY2xvY2staW5kaWNlcyBhbmQgdGhlbiBsaXN0IGFsbCB0aGUgY2xvY2sg
aWRzIGluDQo+ID4gdGhlcmUgYW5kIG1hdGNoIHRoZW0gdXAgYXQgZHJpdmVyIHByb2JlIHRpbWUg
dG8gcmVnaXN0ZXIgdGhlIGNsb2Nrcw0KPiA+IHByb3ZpZGVkIGJ5IHRoZSBJTyByZWdpb24/IEZl
ZWxzIGxpa2Ugd2UnbGwgZG8gYSBsb3Qgb2YgcGFyc2luZyBhdA0KPiA+IGVhY2gNCj4gPiBib290
IHRvIG1hdGNoIHVwIHN0cnVjdHVyZXMgYW5kIHJlZ2lzdGVyIGNsa3Mgd2l0aCB0aGUgY2xrDQo+
ID4gZnJhbWV3b3JrLg0KPiA+IA0KPiA+IElmIGl0J3MgbGlrZSBvdGhlciBTb0NzIHRoZW4gdGhl
IGNsayBpZCBtYXBzIHRvIGEgaGFyZCBtYWNybyBmb3IgYQ0KPiA+IHR5cGUNCj4gPiBvZiBjbGss
IGFuZCB0aG9zZSBoYXJkIG1hY3JvcyBoYXZlIGJlZW4gZ2x1ZWQgdG9nZXRoZXIgd2l0aCBvdGhl
cg0KPiA+IGNsa3MNCj4gPiBhbmQgdGhlbiBwYXJ0aXRpb25lZCBpbnRvIGRpZmZlcmVudCBJTyBy
ZWdpb25zIHRvIG1ha2UgdXAgYSBjbG9jaw0KPiA+IGNvbnRyb2xsZXIuIE9yIG1heWJlIGluIHRo
aXMgY2FzZSwgdGhvc2UgY2xrIGhhcmQgbWFjcm9zIGhhdmUgYmVlbg0KPiA+IHNjYXR0ZXJlZCBp
bnRvIGVhY2ggSVAgYmxvY2sgbGlrZSBTUEksIGkyYywgdWFydCwgZXRjLiBzbyB0aGF0IHRoZQ0K
PiA+IGNsb2NrDQo+ID4gY29udHJvbGxlciBkb2Vzbid0IHJlYWxseSBleGlzdCBhbmQgbWVyZWx5
IHRoZSBnYXRlcyBhbmQgcmF0ZQ0KPiA+IGNvbnRyb2wNCj4gPiAobXV4L2RpdmlkZXIpIGZvciB0
aGUgY2xrIHRoYXQncyBjbG9ja2luZyBzb21lIHBhcnRpY3VsYXIgSVAgYmxvY2sNCj4gPiBhbGwN
Cj4gPiBsaXZlIGluc2lkZSB0aGUgSVAgd3JhcHBlci4gSWYgaXQncyB0aGlzIGNhc2UgdGhlbiBJ
IGhvcGUgdGhlcmUgYXJlDQo+ID4gYQ0KPiA+IGJ1bmNoIG9mIFBMTHMgdGhhdCBhcmUgZml4ZWQg
cmF0ZSBzbyB0aGF0IHRoZSBpMmMgY2xrIGRvZXNuJ3QgaGF2ZQ0KPiA+IHRvIGdvDQo+ID4gb3V0
c2lkZSB0aGUgd3JhcHBlciB0byBjaGFuZ2UgZnJlcXVlbmN5IChvZiB3aGljaCB0aGVyZSBzaG91
bGQgYmUNCj4gPiB0d28NCj4gPiAic3RhbmRhcmQiIGZyZXF1ZW5jaWVzIGFueXdheSkuDQo+ID4g
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gUm9iDQo+ID4gPiA+IA0KPiA+ID4gPiBTb21lIG1vZHVs
ZSBpcyBkaXZpZGVkIHRvIHN1Yi1tb2R1bGVzIHdoaWNoIGFyZSBkZXNpZ25lZCBpbg0KPiA+ID4g
PiBkaWZmZXJlbnQNCj4gPiA+ID4gaC93IGJsb2NrcyBmb3IgZGlmZmVyZW50IHVzYWdlLCBhbmQg
aWYgd2Ugd2FudCB0byB1c2UgdGhlIHNhbWUNCj4gPiA+ID4gY29tcGF0aWJsZSB0byBwcmVzZW50
IHRoZXNlIGgvdyBibG9ja3MsIHdlIG5lZWQgdG8gbW92ZSB0aGUNCj4gPiA+ID4gY2xvY2sgZGF0
YQ0KPiA+ID4gPiBwcm92aWRlZCBieSB0aGVzZSBoL3cgYmxvY2tzIHRvIGR0cywgYnV0IHdlIHVz
dWFsbHkgdXNlDQo+ID4gPiA+IGRpZmZlcmVudA0KPiA+ID4gPiBjb21wYXRpYmxlIHRvIGdldCB0
aGUgaC93IGJsb2NrcyBkYXRhIGluDQo+ID4gPiA+IE1lZGlhdGVrJ3MgY2xvY2sgZHJpdmVyLCBz
byBkbyB5b3Ugc3VnZ2VzdCB0byByZWdpc3RlciBjbG9jaw0KPiA+ID4gPiBwcm92aWRlZA0KPiA+
ID4gPiBieSBkaWZmZXJlbnQgaC93IGJsb2NrcyB1c2luZyBzYW1lIGNvbXBhdGlibGU/DQo+ID4g
PiA+IA0KPiA+ID4gDQo+ID4gPiBUaGUgbWFwcGluZyBvZiB0aGVtIGlzIGFzIGZvbGxvd2luZzoN
Cj4gPiA+IGltcF9paWNfd3JhcF9jOiAgMTEwMDcwMDANCj4gPiA+IGltcF9paWNfd3JhcF9lOiAg
MTFjYjEwMDANCj4gPiA+IGltcF9paWNfd3JhcF9zOiAgMTFkMDMwMDANCj4gPiA+IGltcF9paWNf
d3JhcF93czogMTFkMjMwMDANCj4gPiA+IGltcF9paWNfd3JhcF93OiAgMTFlMDEwMDANCj4gPiA+
IGltcF9paWNfd3JhcF9uOiAgMTFmMDIwMDANCj4gPiA+IA0KPiA+IA0KPiA+IFN1cmUuIFdoYXQg
aXMgdGhlaXIgcHVycG9zZSB0aG91Z2g/IEFyZSB0aGV5IHNpbXBseSBhIGJ1bmNoIG9mDQo+ID4g
ZGlmZmVyZW50DQo+ID4gaTJjIGNsa3M/DQo+ID4gDQo+IA0KPiBUaGF0IHdvdWxkIGJlIG5lZWQg
dG8gYmUgYW5zd2VyZWQgYnkgTWVkaWFUZWsgYXMgSSBkb24ndCBoYXZlIGFjY2Vzcw0KPiB0byBh
bnkNCj4gZG9jdW1lbnRhdGlvbi4NCj4gDQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFzDQoNCldlIGRl
c2NyaWJlIHdoaWNoIGNsb2NrIGNvbnRyb2xsZXJzIGFyZSBleGlzdCBpbiBkdHMgYW5kDQpnZXQg
dGhlIGNsb2NrIGRhdGEgcHJvdmlkZWQgYnkgY2xvY2sgY29udHJvbGxlciBpbiBkcml2ZXIgZGF0
YQ0KYnkgbWF0Y2hpbmcgZGV2aWNlIGNvbXBhdGlibGUuDQoNClRoZSBjbG9jayBkYXRhIGNvbnRh
aW5zIHNldmVyYWwgY2xvY2tzIHdoaWNoIGluY2x1ZGVzIHRoZSBjbG9jayBpbmRleCwNCnBhcmVu
dCBjbG9jayBzb3VyY2UgYW5kIHRoZSBkZXRhaWxzIG9mIHJlZyBjb250cm9sIGluc2lkZSB0aGUg
SVAgYmxvY2sNCm9mIGNsb2NrIGNvbnRyb2xsZXIuDQoNCkluIE1UODE5MiBwbGF0Zm9ybSwgc29t
ZSBJUCBibG9jayBpcyBkaXZpZGUgdG8gc2V2ZXJhbCBzdWItYmxvY2tzIGFuZA0KZWFjaCBzdWIt
YmxvY2sgcHJvdmlkZXMgY2xvY2sgY29udHJvbCBieSBpdHNlbGYuDQoNCkJlc3QgUmVnYXJkcywN
CkNodW4tSmllDQo=

