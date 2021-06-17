Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A183AA92B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 04:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhFQCww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 22:52:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54088 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229845AbhFQCwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 22:52:50 -0400
X-UUID: c18e0f2872fa4f319ee9640e245b6393-20210617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=GL54Q18YRC1dzNU9f8BXHQIPKEDryvVZQ6oeewdXKKI=;
        b=ay7i3zVeMDYGDfZwnqHvZWxHZeaI+4vsTp/jvrbRBKHsWgR/Y1H6XK1kgUBNoD47vSwSOSucU34GFFEZMS4ckPdAyFKPGB1uDxLw0I9nDnoFrfNOZ1++09utwv6l08y0DC7h/F1Oo9wqcK08i/0B0iwRDrwcCq6q4y4D/P/7fMU=;
X-UUID: c18e0f2872fa4f319ee9640e245b6393-20210617
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1544105498; Thu, 17 Jun 2021 10:50:41 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs06n1.mediatek.inc
 (172.21.101.129) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Jun
 2021 10:50:39 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Jun 2021 10:50:38 +0800
Message-ID: <1623898238.28667.15.camel@mhfsdcap03>
Subject: Re: [PATCH 1/3] dt-bindings: phy: mediatek: tphy: add support
 hardware version 3
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Thu, 17 Jun 2021 10:50:38 +0800
In-Reply-To: <20210616232817.GA277610@robh.at.kernel.org>
References: <1622791880-20262-1-git-send-email-chunfeng.yun@mediatek.com>
         <20210616232817.GA277610@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTE2IGF0IDE3OjI4IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gRnJpLCBKdW4gMDQsIDIwMjEgYXQgMDM6MzE6MThQTSArMDgwMCwgQ2h1bmZlbmcgWXVuIHdy
b3RlOg0KPiA+IFRoZSBQSFlBIGFyY2hpdGVjdHVyZSBpcyB1cGRhdGVkLCBhbmQgZG9lc24ndCBz
dXBwb3J0IHNsZXcgcmF0ZQ0KPiA+IGNhbGlicmF0aW9uIGFueW1vcmUgb24gN25tIG9yIGFkdmFu
Y2VkIHByb2Nlc3MsIGFkZCBhIG5ldyB2ZXJzaW9uDQo+ID4gbnVtYmVyIHRvIHN1cHBvcnQgaXQu
DQo+ID4gTm90ZTogdGhlIEZyZXFNZXRlciBiYW5rIGlzIG5vdCB1c2VkIGJ1dCByZXNlcnZlZC4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRp
YXRlayx0cGh5LnlhbWwgICAgIHwgMTQgKysrKysrKysrLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx0cGh5Lnlh
bWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLHRwaHku
eWFtbA0KPiA+IGluZGV4IGI4YTc2NTFhM2Q5YS4uOTM5YzA5Mjk2YjVmIDEwMDY0NA0KPiA+IC0t
LSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdHBoeS55
YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRp
YXRlayx0cGh5LnlhbWwNCj4gPiBAQCAtMTUsNyArMTUsNyBAQCBkZXNjcmlwdGlvbjogfA0KPiA+
ICAgIGNvbnRyb2xsZXJzIG9uIE1lZGlhVGVrIFNvQ3MsIGluY2x1ZGVzIFVTQjIuMCwgVVNCMy4w
LCBQQ0llIGFuZCBTQVRBLg0KPiA+ICANCj4gPiAgICBMYXlvdXQgZGlmZmVyZW5jZXMgb2YgYmFu
a3MgYmV0d2VlbiBULVBIWSBWMSAobXQ4MTczL210MjcwMSkgYW5kDQo+ID4gLSAgVC1QSFkgVjIg
KG10MjcxMikgd2hlbiB3b3JrcyBvbiBVU0IgbW9kZToNCj4gPiArICBULVBIWSBWMiAobXQyNzEy
KSAvIFYzIChtdDgxOTUpIHdoZW4gd29ya3Mgb24gVVNCIG1vZGU6DQo+ID4gICAgLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgICBWZXJzaW9uIDE6DQo+ID4gICAgcG9y
dCAgICAgICAgb2Zmc2V0ICAgIGJhbmsNCj4gPiBAQCAtMzQsNyArMzQsNyBAQCBkZXNjcmlwdGlv
bjogfA0KPiA+ICAgIHUyIHBvcnQyICAgIDB4MTgwMCAgICBVMlBIWV9DT00NCj4gPiAgICAgICAg
ICAgICAgICAuLi4NCj4gPiAgDQo+ID4gLSAgVmVyc2lvbiAyOg0KPiA+ICsgIFZlcnNpb24gMi8z
Og0KPiA+ICAgIHBvcnQgICAgICAgIG9mZnNldCAgICBiYW5rDQo+ID4gICAgdTIgcG9ydDAgICAg
MHgwMDAwICAgIE1JU0MNCj4gPiAgICAgICAgICAgICAgICAweDAxMDAgICAgRk1SRUcNCj4gPiBA
QCAtNTksNyArNTksOCBAQCBkZXNjcmlwdGlvbjogfA0KPiA+ICANCj4gPiAgICBTUExMQyBzaGFy
ZWQgYnkgdTMgcG9ydHMgYW5kIEZNUkVHIHNoYXJlZCBieSB1MiBwb3J0cyBvbiBWMSBhcmUgcHV0
IGJhY2sNCj4gPiAgICBpbnRvIGVhY2ggcG9ydDsgYSBuZXcgYmFuayBNSVNDIGZvciB1MiBwb3J0
cyBhbmQgQ0hJUCBmb3IgdTMgcG9ydHMgYXJlDQo+ID4gLSAgYWRkZWQgb24gVjIuDQo+ID4gKyAg
YWRkZWQgb24gVjI7IHRoZSBGTVJFRyBiYW5rIGZvciBzbGV3IHJhdGUgY2FsaWJyYXRpb24gaXMg
bm90IHVzZWQgYW55bW9yZQ0KPiA+ICsgIGFuZCByZXNlcnZlZCBvbiBWMzsNCj4gPiAgDQo+ID4g
IHByb3BlcnRpZXM6DQo+ID4gICAgJG5vZGVuYW1lOg0KPiA+IEBAIC03OSw4ICs4MCwxMSBAQCBw
cm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQyNzEyLXRwaHkNCj4g
PiAgICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10NzYyOS10cGh5DQo+ID4gICAgICAgICAgICAg
ICAgLSBtZWRpYXRlayxtdDgxODMtdHBoeQ0KPiA+IC0gICAgICAgICAgICAgIC0gbWVkaWF0ZWss
bXQ4MTk1LXRwaHkNCj4gPiAgICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLGdlbmVyaWMtdHBo
eS12Mg0KPiANCj4gVGhpcyBkb2Vzbid0IGxvb2sgbGlrZSBhIGdvb2QgY2hhbmdlLg0KPiANCj4g
V2hhdCBoYXBwZW5zIGlmIGEgRFQgaGFzIHRoZSBhYm92ZS4gSXQgZGlkbid0IHdvcmsgb3IgZGlk
bid0IHN1cHBvcnQgbmV3IA0KPiBmZWF0dXJlcz8NCkl0IGRvZXMgbm90IGFmZmVjdCBmdW5jdGlv
biwgYnV0IHdpbGwgd2FzdGUgc29tZSB0aW1lIHRvIGNhbGlicmF0ZSBzbGV3DQpyYXRlIG9uIG10
ODE5NS4NCg0KPiAgUGxlYXNlIGNsYXJpZnkgaW4gdGhlIGNvbW1pdCB0aGUgaW1wbGljYXRpb25z
IG9mIGNoYW5naW5nIA0KPiB0aGlzLiBDaGFuZ2luZyBhIERUIHRvICdtZWRpYXRlayxnZW5lcmlj
LXRwaHktdjMnIHdpbGwgYnJlYWsgZXhpc3RpbmcgT1MgDQo+IGlmIGl0IHdhcyBsb29raW5nIGZv
ciB2Mi4NCk9uIG10ODE5NSwgaXQncyBiYWNrd2FyZCBjb21wYXRpYmxlIHdpdGggaHcgdjIsIHRo
ZSB1bnVzZWQgRk1SRUcgYmFuayBpcw0KcmV2ZXJzZWQsIGJ1dCBub29wIHdoZW4gVy9SIHJlZ2lz
dGVycy4NCj4gDQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGVudW06DQo+
ID4gKyAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTUtdHBoeQ0KPiA+ICsgICAgICAgICAg
LSBjb25zdDogbWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYzDQo+ID4gICAgICAgIC0gY29uc3Q6IG1l
ZGlhdGVrLG10MjcwMS11M3BoeQ0KPiA+ICAgICAgICAgIGRlcHJlY2F0ZWQ6IHRydWUNCj4gPiAg
ICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQyNzEyLXUzcGh5DQo+ID4gQEAgLTkxLDcgKzk1LDcg
QEAgcHJvcGVydGllczoNCj4gPiAgICAgIGRlc2NyaXB0aW9uOg0KPiA+ICAgICAgICBSZWdpc3Rl
ciBzaGFyZWQgYnkgbXVsdGlwbGUgcG9ydHMsIGV4Y2x1ZGUgcG9ydCdzIHByaXZhdGUgcmVnaXN0
ZXIuDQo+ID4gICAgICAgIEl0IGlzIG5lZWRlZCBmb3IgVC1QSFkgVjEsIHN1Y2ggYXMgbXQyNzAx
IGFuZCBtdDgxNzMsIGJ1dCBub3QgZm9yDQo+ID4gLSAgICAgIFQtUEhZIFYyLCBzdWNoIGFzIG10
MjcxMi4NCj4gPiArICAgICAgVC1QSFkgVjIvVjMsIHN1Y2ggYXMgbXQyNzEyLg0KPiA+ICAgICAg
bWF4SXRlbXM6IDENCj4gPiAgDQo+ID4gICAgIiNhZGRyZXNzLWNlbGxzIjoNCj4gPiAtLSANCj4g
PiAyLjE4LjANCg0K

