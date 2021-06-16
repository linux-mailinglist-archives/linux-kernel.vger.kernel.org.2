Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C033A8E60
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 03:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbhFPBcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 21:32:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57741 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230371AbhFPBcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 21:32:16 -0400
X-UUID: f15dd2272bc74643881fb656e8335aeb-20210616
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=bN1zFdu+kgnFsjJiRGRT8DKoz4fiLgKY4mbL1c8VCqU=;
        b=qqQg9rdv09NK1kVK9mzM0bPxsZP1WSKYAWETMCKF2x77NhyCQfmWVm/eMgWFXAY3ueSHIGEGWbuaFHn0iir2VBIKJI80J1CYhxI5vRQWojUJJ74cGARuAOygb+Bps8JVZ3sMuksx2//k3gGFUohUhNLg3tk2UruyHb3xe3f6d8k=;
X-UUID: f15dd2272bc74643881fb656e8335aeb-20210616
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1764266801; Wed, 16 Jun 2021 09:30:05 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs02n2.mediatek.inc
 (172.21.101.101) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Jun
 2021 09:30:03 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 09:30:02 +0800
Message-ID: <1623807002.15910.8.camel@mhfsdcap03>
Subject: Re: [PATCH 12/27] arm64: dts: mt8195: fix mmc driver
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
CC:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <seiya.wang@mediatek.com>, <wenst@google.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 16 Jun 2021 09:30:02 +0800
In-Reply-To: <20210615173233.26682-12-tinghan.shen@mediatek.com>
References: <20210615173233.26682-1-tinghan.shen@mediatek.com>
         <20210615173233.26682-12-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTE2IGF0IDAxOjMyICswODAwLCBUaW5naGFuIFNoZW4gd3JvdGU6DQo+
IEZyb206IFdlbmJpbiBNZWkgPHdlbmJpbi5tZWlAbWVkaWF0ZWsuY29tPg0KPiANCj4gZml4IG1t
YyBkcml2ZXIgd2l0aCBwcm9wZXIgY2xvY2sgZm9yIG10ODE5NSBTb0MuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBXZW5iaW4gTWVpIDx3ZW5iaW4ubWVpQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBh
cmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5NS5kdHNpIHwgMTggKysrKysrKysrKysr
KystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5
NS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxOTUuZHRzaQ0KPiBpbmRl
eCA1MzlmNDA1YTRmM2QuLjMyN2ZmMWI4NTZkMiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9i
b290L2R0cy9tZWRpYXRlay9tdDgxOTUuZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L21lZGlhdGVrL210ODE5NS5kdHNpDQo+IEBAIC05MjYsMjIgKzkyNiwzMiBAQA0KPiAgCQl9Ow0K
PiAgDQo+ICAJCW1tYzA6IG1tY0AxMTIzMDAwMCB7DQo+IC0JCQljb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10ODE5NS1tbWMiLCAibWVkaWF0ZWssbXQ4MTkyLW1tYyI7DQo+ICsJCQljb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE5NS1tbWMiLA0KPiArCQkJCSAgICAgIm1lZGlhdGVrLG10ODE5Mi1t
bWMiLA0KPiArCQkJCSAgICAgIm1lZGlhdGVrLG10ODE4My1tbWMiOw0KSSBoYXZlIHN1Ym1pdHRl
ZCBhIHBhdGNoIHRvIGZpeCB0aGUNCmR0LWJpbmRpbmdzKGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL3BpcGVybWFpbC9saW51eC1tZWRpYXRlay8yMDIxLUp1bmUvMDI1NDU2Lmh0bWwpLCBOb3cg
d2hpY2ggc2hvdWxkIGJlOg0KCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LW1tYyIsICJt
ZWRpYXRlayxtdDgxODMtbW1jIjsNCj4gIAkJCXJlZyA9IDwwIDB4MTEyMzAwMDAgMCAweDEwMDAw
PiwNCj4gIAkJCSAgICAgIDwwIDB4MTFmNTAwMDAgMCAweDEwMDA+Ow0KPiAgCQkJaW50ZXJydXB0
cyA9IDxHSUNfU1BJIDEzMSBJUlFfVFlQRV9MRVZFTF9ISUdIIDA+Ow0KPiAtCQkJY2xvY2tzID0g
PCZjbGsyNm0+LCA8JmNsazI2bT4sIDwmY2xrMjZtPjsNCj4gKwkJCWNsb2NrcyA9IDwmdG9wY2tn
ZW4gQ0xLX1RPUF9NU0RDNTBfMF9TRUw+LA0KPiArCQkJCSA8JmluZnJhY2ZnX2FvIENMS19JTkZS
QV9BT19NU0RDMD4sDQo+ICsJCQkJIDwmaW5mcmFjZmdfYW8gQ0xLX0lORlJBX0FPX01TREMwX1NS
Qz47DQo+ICAJCQljbG9jay1uYW1lcyA9ICJzb3VyY2UiLCAiaGNsayIsICJzb3VyY2VfY2ciOw0K
PiAgCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gIAkJfTsNCj4gIA0KPiAgCQltbWMxOiBtbWNA
MTEyNDAwMDAgew0KPiAtCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtbW1jIiwgIm1l
ZGlhdGVrLG10ODE5Mi1tbWMiOw0KPiArCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUt
bW1jIiwNCj4gKwkJCQkgICAgICJtZWRpYXRlayxtdDgxOTItbW1jIiwNCj4gKwkJCQkgICAgICJt
ZWRpYXRlayxtdDgxODMtbW1jIjsNCkRpdHRvLCB0aGlzIHNob3VsZCBiZToNCgljb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE5NS1tbWMiLCAibWVkaWF0ZWssbXQ4MTgzLW1tYyI7DQo+ICAJCQly
ZWcgPSA8MCAweDExMjQwMDAwIDAgMHgxMDAwPiwNCj4gIAkJCSAgICAgIDwwIDB4MTFjNzAwMDAg
MCAweDEwMDA+Ow0KPiAgCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDEzNSBJUlFfVFlQRV9MRVZF
TF9ISUdIIDA+Ow0KPiAtCQkJY2xvY2tzID0gPCZjbGsyNm0+LCA8JmNsazI2bT4sIDwmY2xrMjZt
PjsNCj4gKwkJCWNsb2NrcyA9IDwmdG9wY2tnZW4gQ0xLX1RPUF9NU0RDMzBfMV9TRUw+LA0KPiAr
CQkJCSA8JmluZnJhY2ZnX2FvIENMS19JTkZSQV9BT19NU0RDMT4sDQo+ICsJCQkJIDwmaW5mcmFj
ZmdfYW8gQ0xLX0lORlJBX0FPX01TREMxX1NSQz47DQo+ICAJCQljbG9jay1uYW1lcyA9ICJzb3Vy
Y2UiLCAiaGNsayIsICJzb3VyY2VfY2ciOw0KPiArCQkJYXNzaWduZWQtY2xvY2tzID0gPCZ0b3Bj
a2dlbiBDTEtfVE9QX01TREMzMF8xX1NFTD47DQo+ICsJCQlhc3NpZ25lZC1jbG9jay1wYXJlbnRz
ID0gPCZ0b3Bja2dlbiBDTEtfVE9QX01TRENQTExfRDI+Ow0KPiAgCQkJc3RhdHVzID0gImRpc2Fi
bGVkIjsNCj4gIAkJfTsNCj4gIA0KDQo=

