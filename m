Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9272B45B5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240917AbhKXHvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:51:55 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:58022 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238609AbhKXHvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:51:47 -0500
X-UUID: b730eac1133e47b9a7f7dcb5a804854f-20211124
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=jmFRbgHXyWQM9FuS/EWE6h1VSjBn50PLdJLWIThLNL0=;
        b=Bo92atUM6tOsHv+8jYWbRJsgoU+CkbTpfbuHG2e+oQcmDKKYF/uNV8liUj3/KKnbm8layIiD7Rr5rKHd/COnwx078u3Mv36BU1vAe+mBLDw+JzSVWuOPJ/lxyClgt7OUiWnUuzHolffLdmFC2LSfF7PdkpgYLQ87OgRrpKKYnXM=;
X-UUID: b730eac1133e47b9a7f7dcb5a804854f-20211124
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 598854004; Wed, 24 Nov 2021 15:48:35 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 24 Nov 2021 15:48:34 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Nov 2021 15:48:33 +0800
Message-ID: <ba47b03019a2ee19bee058f6c08dc304c2b7c566.camel@mediatek.com>
Subject: Re: [PATCH 4/6] dt-bindings: phy: mediatek: tphy: support software
 efuse load
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yz Wu <yz.wu@mediatek.com>
Date:   Wed, 24 Nov 2021 15:48:33 +0800
In-Reply-To: <8aa7adbf-7367-1b3a-4d63-f9fe83e72117@linaro.org>
References: <20211107075646.4366-1-chunfeng.yun@mediatek.com>
         <20211107075646.4366-4-chunfeng.yun@mediatek.com>
         <71f83770-b12f-2452-d24b-ae1be9b5b075@linaro.org>
         <CAGXv+5GzP1SXi2ihhifK_Ui8Rt04UgeFyjivzHc532yvPFo3OA@mail.gmail.com>
         <8aa7adbf-7367-1b3a-4d63-f9fe83e72117@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTExLTIyIGF0IDA5OjIxICswMDAwLCBTcmluaXZhcyBLYW5kYWdhdGxhIHdy
b3RlOg0KPiANCj4gT24gMjIvMTEvMjAyMSAwNDowNSwgQ2hlbi1ZdSBUc2FpIHdyb3RlOg0KPiA+
IE9uIFNhdCwgTm92IDIwLCAyMDIxIGF0IDE6MTkgQU0gU3Jpbml2YXMgS2FuZGFnYXRsYQ0KPiA+
IDxzcmluaXZhcy5rYW5kYWdhdGxhQGxpbmFyby5vcmc+IHdyb3RlOg0KPiA+ID4gT24gMDcvMTEv
MjAyMSAwNzo1NiwgQ2h1bmZlbmcgWXVuIHdyb3RlOg0KPiA+ID4gPiBBZGQgb3B0aW9uYWwgcHJv
cGVydHkgbnZtZW0tY2VsbHMgYW5kIG52bWVtLWNlbGwtbmFtZXMgdG8NCj4gPiA+ID4gc3VwcG9y
dA0KPiA+ID4gPiBzb2Z0d2FyZSBlZnVzZSBsb2FkLCB0aGlzIGhlbHBzIHRvIGZpeCB0aGUgZWZ1
c2UgYml0IHNoaWZ0DQo+ID4gPiA+IGlzc3VlDQo+ID4gPiA+IG9uIG10ODE5NSBldGMuDQo+ID4g
PiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBt
ZWRpYXRlay5jb20+DQo+ID4gPiANCj4gPiA+IEFwcGxpZWQgdGhhbmtzLA0KPiA+IA0KPiA+IFRo
aXMgaXMgYSBQSFkgRFQgYmluZGluZyBjaGFuZ2UuIFNob3VsZG4ndCBpdCBnbyBpbiB3aXRoIHBh
dGNoIDUsDQo+ID4gdGhlDQo+ID4gcGh5IGRyaXZlciBwYXRjaCwgdGhyb3VnaCB0aGUgUEhZIHRy
ZWUgaW5zdGVhZD8NCj4gDQo+IFRoYXQncyB0cnVlLCB0aGlzIGlzIGRyb3BwZWQgZnJvbSBudm1l
bSB0cmVlIG5vdyENCg0KVGhhbmtzDQoNCj4gDQo+IC0tc3JpbmkNCj4gPiANCj4gPiBDaGVuWXUN
Cj4gPiANCj4gPiA+IC0tc3JpbmkNCj4gPiA+IA0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gICAgLi4u
L2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLHRwaHkueWFtbCB8IDE4DQo+ID4gPiA+
ICsrKysrKysrKysrKysrKysrKw0KPiA+ID4gPiAgICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0
aW9ucygrKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gPiBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssdHBoeS55YW1sDQo+ID4gPiA+
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayx0cGh5Lnlh
bWwNCj4gPiA+ID4gaW5kZXggOWU2YzBmNDNmMWM2Li4wNWVlMjc0YjRiNzEgMTAwNjQ0DQo+ID4g
PiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWss
dHBoeS55YW1sDQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9waHkvbWVkaWF0ZWssdHBoeS55YW1sDQo+ID4gPiA+IEBAIC0xNjAsNiArMTYwLDI0IEBAIHBh
dHRlcm5Qcm9wZXJ0aWVzOg0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgLSBQSFlfVFlQRV9Q
Q0lFDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAtIFBIWV9UWVBFX1NBVEENCj4gPiA+ID4g
DQo+ID4gPiA+ICsgICAgICBudm1lbS1jZWxsczoNCj4gPiA+ID4gKyAgICAgICAgaXRlbXM6DQo+
ID4gPiA+ICsgICAgICAgICAgLSBkZXNjcmlwdGlvbjogaW50ZXJuYWwgUiBlZnVzZSBmb3IgVTIg
UEhZIG9yDQo+ID4gPiA+IFUzL1BDSWUgUEhZDQo+ID4gPiA+ICsgICAgICAgICAgLSBkZXNjcmlw
dGlvbjogcnhfaW1wX3NlbCBlZnVzZSBmb3IgVTMvUENJZSBQSFkNCj4gPiA+ID4gKyAgICAgICAg
ICAtIGRlc2NyaXB0aW9uOiB0eF9pbXBfc2VsIGVmdXNlIGZvciBVMy9QQ0llIFBIWQ0KPiA+ID4g
PiArICAgICAgICBkZXNjcmlwdGlvbjogfA0KPiA+ID4gPiArICAgICAgICAgIFBoYW5kbGVzIHRv
IG52bWVtIGNlbGwgdGhhdCBjb250YWlucyB0aGUgZWZ1c2UgZGF0YTsNCj4gPiA+ID4gKyAgICAg
ICAgICBBdmFpbGFibGUgb25seSBmb3IgVTIgUEhZIG9yIFUzL1BDSWUgUEhZIG9mIHZlcnNpb24N
Cj4gPiA+ID4gMi8zLCB0aGVzZQ0KPiA+ID4gPiArICAgICAgICAgIHRocmVlIGl0ZW1zIHNob3Vs
ZCBiZSBwcm92aWRlZCBhdCB0aGUgc2FtZSB0aW1lIGZvcg0KPiA+ID4gPiBVMy9QQ0llIFBIWSwN
Cj4gPiA+ID4gKyAgICAgICAgICB3aGVuIHVzZSBzb2Z0d2FyZSB0byBsb2FkIGVmdXNlOw0KPiA+
ID4gPiArICAgICAgICAgIElmIHVuc3BlY2lmaWVkLCB3aWxsIHVzZSBoYXJkd2FyZSBhdXRvLWxv
YWQgZWZ1c2UuDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgIG52bWVtLWNlbGwtbmFtZXM6DQo+
ID4gPiA+ICsgICAgICAgIGl0ZW1zOg0KPiA+ID4gPiArICAgICAgICAgIC0gY29uc3Q6IGludHIN
Cj4gPiA+ID4gKyAgICAgICAgICAtIGNvbnN0OiByeF9pbXANCj4gPiA+ID4gKyAgICAgICAgICAt
IGNvbnN0OiB0eF9pbXANCj4gPiA+ID4gKw0KPiA+ID4gPiAgICAgICAgICAjIFRoZSBmb2xsb3dp
bmcgb3B0aW9uYWwgdmVuZG9yIHByb3BlcnRpZXMgYXJlIG9ubHkNCj4gPiA+ID4gZm9yIGRlYnVn
IG9yIEhRQSB0ZXN0DQo+ID4gPiA+ICAgICAgICAgIG1lZGlhdGVrLGV5ZS1zcmM6DQo+ID4gPiA+
ICAgICAgICAgICAgZGVzY3JpcHRpb246DQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+ID4gTGludXgtbWVk
aWF0ZWsgbWFpbGluZyBsaXN0DQo+ID4gPiBMaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQu
b3JnDQo+ID4gPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW1lZGlhdGVrDQo=

