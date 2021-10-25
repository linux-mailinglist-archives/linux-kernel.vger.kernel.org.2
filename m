Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E850438DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 06:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhJYEGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 00:06:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55208 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229379AbhJYEGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 00:06:22 -0400
X-UUID: 6658fb226bc848409323020410b70184-20211025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ccPzK7FNitJAyHQG9gzX9D65Nz6meMuwCPEHC4/A0GA=;
        b=r5seQ1fGfzsuTK8P0fgBSzHG20y0QJCY6I3lVZpilypgZhQW7W/sJ56QAib/aRno9IthBvuzl8Aym7bKLG7kXC4YrnHSiei8y3P+8Fdqt6iolRRP/ECQKKcmVAAxIZhAPUK5fDgfPuti4Q8DPOdq71dS/GOKfAu93IXb7q1jvss=;
X-UUID: 6658fb226bc848409323020410b70184-20211025
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1449531537; Mon, 25 Oct 2021 12:03:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 25 Oct 2021 12:03:54 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Oct 2021 12:03:53 +0800
Message-ID: <f0e2ebf98481ee2ae8b88565a337e773532ddffd.camel@mediatek.com>
Subject: Re: [PATCH v3 13/33] iommu/mediatek: Remove the power status
 checking in tlb flush all
From:   Yong Wu <yong.wu@mediatek.com>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <yen-chang.chen@mediatek.com>,
        Collabora Kernel ML <kernel@collabora.com>
Date:   Mon, 25 Oct 2021 12:03:53 +0800
In-Reply-To: <6cff0b97-b861-e02d-e76f-2510c962c452@collabora.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
         <20210923115840.17813-14-yong.wu@mediatek.com>
         <6cff0b97-b861-e02d-e76f-2510c962c452@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTEwLTIyIGF0IDE2OjAzICswMjAwLCBEYWZuYSBIaXJzY2hmZWxkIHdyb3Rl
Og0KPiBIaQ0KPiANCj4gDQo+IE9uIDIzLjA5LjIxIDEzOjU4LCBZb25nIFd1IHdyb3RlOg0KPiA+
IFRvIHNpbXBsaWZ5IHRoZSBjb2RlLCBSZW1vdmUgdGhlIHBvd2VyIHN0YXR1cyBjaGVja2luZyBp
biB0aGUNCj4gPiB0bGJfZmx1c2hfYWxsLCByZW1vdmUgdGhpczoNCj4gPiAgICAgaWYgKHBtX3J1
bnRpbWVfZ2V0X2lmX2luX3VzZShkYXRhLT5kZXYpIDw9IDApDQo+ID4gCSAgICBjb250aW51ZTsN
Cj4gPiANCj4gPiBBZnRlciB0aGlzIHBhdGNoLCB0aGUgbXRrX2lvbW11X3RsYl9mbHVzaF9hbGwg
d2lsbCBiZSBjYWxsZWQgZnJvbQ0KPiA+IGEpIGlzcg0KPiA+IGIpIHBtIHJ1bnRpbWUgcmVzdW1l
IGNhbGxiYWNrDQo+ID4gYykgdGxiIGZsdXNoIHJhbmdlIGZhaWwgY2FzZQ0KPiA+IGQpIGlvbW11
X2NyZWF0ZV9kZXZpY2VfZGlyZWN0X21hcHBpbmdzDQo+ID4gICAgIC0+IGlvbW11X2ZsdXNoX2lv
dGxiX2FsbA0KPiA+IEluIGZpcnN0IHRocmVlIGNhc2VzLCB0aGUgcG93ZXIgYW5kIGNsb2NrIGFs
d2F5cyBhcmUgZW5hYmxlZDsgZCkgaXMNCj4gPiBkaXJlY3QNCj4gDQo+IFJlZ2FyZGluZyBjYXNl
ICJjKSB0bGIgZmx1c2ggcmFuZ2UgZmFpbCBjYXNlIiwgSSBmb3VuZCBvdXQgdGhhdCB0aGlzDQo+
IG9mdGVuIGhhcHBlbnMgd2hlbiB0aGUgaW9tbXUgaXMgdXNlZCB3aGlsZSBpdCBpcyBydW50aW1l
IHN1c3BlbmRlZC4gDQoNCldoaWNoIFNvQyBhbmQgYnJhbmNoIGFyZSB5b3UgdGVzdGluZyBvbj8N
Cg0KPiBGb3IgZXhhbXBsZSB0aGUgbXRrLXZjb2RlYyBlbmNvZGVyIGRyaXZlciBjYWxscw0KPiAi
cG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCIgb25seSB3aGVuIGl0IHN0YXJ0cw0KPiBzdHJlYW1p
bmcgYnV0DQo+IGJ1ZmZlcnMgYWxsb2NhdGlvbiBpcyBkb25lIGluICd2NGwyX3JlcWJ1ZnMnIGJl
Zm9yZQ0KPiAicG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCIgaXMgY2FsbGVkDQoNClRoaXMgaXMg
dGhlIGNhc2UgSSB0cmllZCB0byBmaXggaW4gWzE0LzMzXS4NCnBtX3J1bnRpbWVfZ2V0X2lmX2lu
X3VzZSBzaG91bGQgcmV0dXJuIHdoZW4gdGhlIGlvbW11IGRldmljZSdzIHBtIGlzDQpub3QgYWN0
aXZlIHdoZW4gdmNvZGVjIGFsbG9jYXRlIGJ1ZmZlciBiZWZvcmUgcG1fcnVudGltZV9yZXN1bWVf
YW5kDQpnZXQuDQoNCkRvIHlvdSBoYXZlIHRoZSBkZXZpY2VsaW5rIHBhdGNoc2V0IGluIHlvdXIg
YnJhbmNoPyBpZiBub3QsIHRoZSB2Y29kZWMNCnNob3VsZCBjYWxsIG10a19zbWlfbGFyYl9nZXQg
dG8gZW5hYmxlIHRoZSBwb3dlci9jbG9jayBmb3IgbGFyYnMsIHRoZW4NCnRoZSBpb21tdSdzIGRl
dmljZSBpcyBhY3RpdmUgdmlhIGRldmljZWxpbmsgYmV0d2VlbiBzbWkgYW5kIGlvbW11DQpkZXZp
Y2UuDQoNCj4gYW5kIHRoZW4gSSBzZWUgdGhlIHdhcm5pbmcgIlBhcnRpYWwgVExCIGZsdXNoIHRp
bWVkIG91dCwgZmFsbGluZyBiYWNrDQo+IHRvIGZ1bGwgZmx1c2giDQo+IEkgYW0gbm90IHN1cmUg
aG93IHRvIGZpeCB0aGF0IGlzc3VlLCBidXQgaXQgc2VlbXMgdGhhdCBjYXNlICdjKScNCj4gbWln
aHQgaW5kaWNhdGUgdGhhdA0KPiBwb3dlciBhbmQgY2xvY2sgYXJlIGFjdHVhbGx5IG5vdCBlbmFi
bGVkLg0KPiANCj4gPiBtYXBwaW5nLCB0aGUgdGxiIGZsdXNoIGlzIHVubmVjZXNzYXkgc2luY2Ug
d2UgYWxyZWFkeSBoYXZlDQo+ID4gdGxiX2ZsdXNoX2FsbA0KPiA+IGluIHRoZSBwbV9ydW50aW1l
X3Jlc3VtZSBjYWxsYmFjay4gV2hlbiB0aGUgaW9tbXUncyBwb3dlciBzdGF0dXMgaXMNCj4gPiBj
aGFuZ2VkIHRvIGFjdGl2ZSwgdGhlIHRsYiBhbHdheXMgaXMgY2xlYW4uDQo+ID4gDQo+ID4gSW4g
YWRkaXRpb24sIHRoZXJlIHN0aWxsIGFyZSAyIHJlYXNvbnMgdGhhdCBkb24ndCBhZGQgUE0gc3Rh
dHVzDQo+ID4gY2hlY2tpbmcNCj4gPiBpbiB0aGUgdGxiIGZsdXNoIGFsbDoNCj4gPiBhKSBXcml0
ZSB0bGIgZmx1c2ggYWxsIHJlZ2lzdGVyIGFsc28gaXMgb2sgZXZlbiB0aG91Z2ggdGhlIEhXIGhh
cw0KPiA+IG5vDQo+ID4gcG93ZXIgYW5kIGNsb2Nrcy4gV3JpdGUgaWdub3JlLg0KPiA+IGIpIHBt
X3J1bnRpbWVfZ2V0X2lmX2luX3VzZShtNHVkZXYpIGlzIDAgd2hlbiB0aGUgdGxiX2ZsdXNoX2Fs
bA0KPiA+IGlzIGNhbGxlZCBmcm0gcG1fcnVudGltZV9yZXN1bWUgY2IuIEZyb20gdGhpcyBwb2lu
dCwgd2UgY2FuIG5vdCBhZGQNCj4gPiB0aGlzIGNvZGUgYWJvdmUgaW4gdGhpcyB0bGJfZmx1c2hf
YWxsLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDIwICsrKysr
KystLS0tLS0tLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAx
MyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiBpbmRleCBlOWU5NDk0NGVk
OTEuLjRhMzNiNmM2YjFkYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21t
dS5jDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiA+IEBAIC0yMDQsMTAg
KzIwNCwxNCBAQCBzdGF0aWMgc3RydWN0IG10a19pb21tdV9kb21haW4NCj4gPiAqdG9fbXRrX2Rv
bWFpbihzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb20pDQo+ID4gICAJcmV0dXJuIGNvbnRhaW5lcl9v
Zihkb20sIHN0cnVjdCBtdGtfaW9tbXVfZG9tYWluLCBkb21haW4pOw0KPiA+ICAgfQ0KPiA+ICAg
DQo+ID4gLXN0YXRpYyB2b2lkIG10a19pb21tdV90bGJfZG9fZmx1c2hfYWxsKHN0cnVjdCBtdGtf
aW9tbXVfZGF0YQ0KPiA+ICpkYXRhKQ0KPiA+ICtzdGF0aWMgdm9pZCBtdGtfaW9tbXVfdGxiX2Zs
dXNoX2FsbChzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEpDQo+ID4gICB7DQo+ID4gICAJdW5z
aWduZWQgbG9uZyBmbGFnczsNCj4gPiAgIA0KPiA+ICsJLyoNCj4gPiArCSAqIE5vIG5lZWQgZ2V0
IHBvd2VyIHN0YXR1cyBzaW5jZSB0aGUgSFcgUE0gc3RhdHVzIG5lYXJseSBpcw0KPiA+IGFjdGl2
ZQ0KPiA+ICsJICogd2hlbiBlbnRlcmluZyBoZXJlLg0KPiA+ICsJICovDQo+ID4gICAJc3Bpbl9s
b2NrX2lycXNhdmUoJmRhdGEtPnRsYl9sb2NrLCBmbGFncyk7DQo+ID4gICAJd3JpdGVsX3JlbGF4
ZWQoRl9JTlZMRF9FTjEgfCBGX0lOVkxEX0VOMCwNCj4gPiAgIAkJICAgICAgIGRhdGEtPmJhc2Ug
KyBkYXRhLT5wbGF0X2RhdGEtPmludl9zZWxfcmVnKTsNCj4gPiBAQCAtMjE2LDE2ICsyMjAsNiBA
QCBzdGF0aWMgdm9pZCBtdGtfaW9tbXVfdGxiX2RvX2ZsdXNoX2FsbChzdHJ1Y3QNCj4gPiBtdGtf
aW9tbXVfZGF0YSAqZGF0YSkNCj4gPiAgIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkYXRhLT50
bGJfbG9jaywgZmxhZ3MpOw0KPiA+ICAgfQ0KPiA+ICAgDQo+ID4gLXN0YXRpYyB2b2lkIG10a19p
b21tdV90bGJfZmx1c2hfYWxsKHN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSkNCj4gPiAtew0K
PiA+IC0JaWYgKHBtX3J1bnRpbWVfZ2V0X2lmX2luX3VzZShkYXRhLT5kZXYpIDw9IDApDQo+ID4g
LQkJcmV0dXJuOw0KPiA+IC0NCj4gPiAtCW10a19pb21tdV90bGJfZG9fZmx1c2hfYWxsKGRhdGEp
Ow0KPiA+IC0NCj4gPiAtCXBtX3J1bnRpbWVfcHV0KGRhdGEtPmRldik7DQo+ID4gLX0NCj4gPiAt
DQo+ID4gICBzdGF0aWMgdm9pZCBtdGtfaW9tbXVfdGxiX2ZsdXNoX3JhbmdlX3N5bmModW5zaWdu
ZWQgbG9uZyBpb3ZhLA0KPiA+IHNpemVfdCBzaXplLA0KPiA+ICAgCQkJCQkgICBzdHJ1Y3QgbXRr
X2lvbW11X2RhdGEgKmRhdGEpDQo+ID4gICB7DQo+ID4gQEAgLTI2Myw3ICsyNTcsNyBAQCBzdGF0
aWMgdm9pZA0KPiA+IG10a19pb21tdV90bGJfZmx1c2hfcmFuZ2Vfc3luYyh1bnNpZ25lZCBsb25n
IGlvdmEsIHNpemVfdCBzaXplLA0KPiA+ICAgCQlpZiAocmV0KSB7DQo+ID4gICAJCQlkZXZfd2Fy
bihkYXRhLT5kZXYsDQo+ID4gICAJCQkJICJQYXJ0aWFsIFRMQiBmbHVzaCB0aW1lZCBvdXQsIGZh
bGxpbmcNCj4gPiBiYWNrIHRvIGZ1bGwgZmx1c2hcbiIpOw0KPiA+IC0JCQltdGtfaW9tbXVfdGxi
X2RvX2ZsdXNoX2FsbChkYXRhKTsNCj4gPiArCQkJbXRrX2lvbW11X3RsYl9mbHVzaF9hbGwoZGF0
YSk7DQo+ID4gICAJCX0NCj4gPiAgIA0KPiA+ICAgCQlpZiAoaGFzX3BtKQ0KPiA+IEBAIC05OTMs
NyArOTg3LDcgQEAgc3RhdGljIGludCBfX21heWJlX3VudXNlZA0KPiA+IG10a19pb21tdV9ydW50
aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gICAJICoNCj4gPiAgIAkgKiBUaHVz
LCBNYWtlIHN1cmUgdGhlIHRsYiBhbHdheXMgaXMgY2xlYW4gYWZ0ZXIgZWFjaCBQTQ0KPiA+IHJl
c3VtZS4NCj4gPiAgIAkgKi8NCj4gPiAtCW10a19pb21tdV90bGJfZG9fZmx1c2hfYWxsKGRhdGEp
Ow0KPiA+ICsJbXRrX2lvbW11X3RsYl9mbHVzaF9hbGwoZGF0YSk7DQo+ID4gICANCj4gPiAgIAkv
Kg0KPiA+ICAgCSAqIFVwcG9uIGZpcnN0IHJlc3VtZSwgb25seSBlbmFibGUgdGhlIGNsayBhbmQg
cmV0dXJuLCBzaW5jZQ0KPiA+IHRoZSB2YWx1ZXMgb2YgdGhlDQo+ID4gDQo=

