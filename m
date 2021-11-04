Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8590444DB3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 04:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhKDDbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 23:31:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50170 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229893AbhKDDbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 23:31:20 -0400
X-UUID: c97709e09f3e451281f0b753048bd9b8-20211104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=obhkLKakLCXFFdtMrvJQpCX8waFJ6arRjOpKnMlEJDY=;
        b=U6zaoP1mGU96Nokuy8oq1aI2tau0zHNR3Yxt4Y7okHdW2UZR7EqlN9PsDuksG1w2D6vRJw3bVpp4P962Juelz95P5eTZgZnomeBRu5D3Jttd11X3Y0bnZotvFGpy+JauBYOg+BzddzK4f0h6+kMjnk7YTxN0EwBqfSN37+jfPFw=;
X-UUID: c97709e09f3e451281f0b753048bd9b8-20211104
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 564425789; Thu, 04 Nov 2021 11:28:41 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 4 Nov 2021 11:28:39 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs10n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 4 Nov 2021 11:28:38 +0800
Message-ID: <e099c6e8af0b184f8e823fac325ea36329cb5709.camel@mediatek.com>
Subject: Re: [PATCH v3 13/33] iommu/mediatek: Remove the power status
 checking in tlb flush all
From:   Yong Wu <yong.wu@mediatek.com>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
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
        Collabora Kernel ML <kernel@collabora.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>
Date:   Thu, 4 Nov 2021 11:28:38 +0800
In-Reply-To: <f0e2ebf98481ee2ae8b88565a337e773532ddffd.camel@mediatek.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
         <20210923115840.17813-14-yong.wu@mediatek.com>
         <6cff0b97-b861-e02d-e76f-2510c962c452@collabora.com>
         <f0e2ebf98481ee2ae8b88565a337e773532ddffd.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTEwLTI1IGF0IDEyOjAzICswODAwLCBZb25nIFd1IHdyb3RlOg0KPiBPbiBG
cmksIDIwMjEtMTAtMjIgYXQgMTY6MDMgKzAyMDAsIERhZm5hIEhpcnNjaGZlbGQgd3JvdGU6DQo+
ID4gSGkNCj4gPiANCj4gPiANCj4gPiBPbiAyMy4wOS4yMSAxMzo1OCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiA+IFRvIHNpbXBsaWZ5IHRoZSBjb2RlLCBSZW1vdmUgdGhlIHBvd2VyIHN0YXR1cyBjaGVj
a2luZyBpbiB0aGUNCj4gPiA+IHRsYl9mbHVzaF9hbGwsIHJlbW92ZSB0aGlzOg0KPiA+ID4gICAg
IGlmIChwbV9ydW50aW1lX2dldF9pZl9pbl91c2UoZGF0YS0+ZGV2KSA8PSAwKQ0KPiA+ID4gCSAg
ICBjb250aW51ZTsNCj4gPiA+IA0KPiA+ID4gQWZ0ZXIgdGhpcyBwYXRjaCwgdGhlIG10a19pb21t
dV90bGJfZmx1c2hfYWxsIHdpbGwgYmUgY2FsbGVkIGZyb20NCj4gPiA+IGEpIGlzcg0KPiA+ID4g
YikgcG0gcnVudGltZSByZXN1bWUgY2FsbGJhY2sNCj4gPiA+IGMpIHRsYiBmbHVzaCByYW5nZSBm
YWlsIGNhc2UNCj4gPiA+IGQpIGlvbW11X2NyZWF0ZV9kZXZpY2VfZGlyZWN0X21hcHBpbmdzDQo+
ID4gPiAgICAgLT4gaW9tbXVfZmx1c2hfaW90bGJfYWxsDQo+ID4gPiBJbiBmaXJzdCB0aHJlZSBj
YXNlcywgdGhlIHBvd2VyIGFuZCBjbG9jayBhbHdheXMgYXJlIGVuYWJsZWQ7IGQpDQo+ID4gPiBp
cw0KPiA+ID4gZGlyZWN0DQo+ID4gDQo+ID4gUmVnYXJkaW5nIGNhc2UgImMpIHRsYiBmbHVzaCBy
YW5nZSBmYWlsIGNhc2UiLCBJIGZvdW5kIG91dCB0aGF0DQo+ID4gdGhpcw0KPiA+IG9mdGVuIGhh
cHBlbnMgd2hlbiB0aGUgaW9tbXUgaXMgdXNlZCB3aGlsZSBpdCBpcyBydW50aW1lDQo+ID4gc3Vz
cGVuZGVkLiANCj4gDQo+IFdoaWNoIFNvQyBhbmQgYnJhbmNoIGFyZSB5b3UgdGVzdGluZyBvbj8N
Cj4gDQo+ID4gRm9yIGV4YW1wbGUgdGhlIG10ay12Y29kZWMgZW5jb2RlciBkcml2ZXIgY2FsbHMN
Cj4gPiAicG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCIgb25seSB3aGVuIGl0IHN0YXJ0cw0KPiA+
IHN0cmVhbWluZyBidXQNCj4gPiBidWZmZXJzIGFsbG9jYXRpb24gaXMgZG9uZSBpbiAndjRsMl9y
ZXFidWZzJyBiZWZvcmUNCj4gPiAicG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCIgaXMgY2FsbGVk
DQo+IA0KPiBUaGlzIGlzIHRoZSBjYXNlIEkgdHJpZWQgdG8gZml4IGluIFsxNC8zM10uDQo+IHBt
X3J1bnRpbWVfZ2V0X2lmX2luX3VzZSBzaG91bGQgcmV0dXJuIHdoZW4gdGhlIGlvbW11IGRldmlj
ZSdzIHBtIGlzDQo+IG5vdCBhY3RpdmUgd2hlbiB2Y29kZWMgYWxsb2NhdGUgYnVmZmVyIGJlZm9y
ZSBwbV9ydW50aW1lX3Jlc3VtZV9hbmQNCj4gZ2V0Lg0KPiANCj4gRG8geW91IGhhdmUgdGhlIGRl
dmljZWxpbmsgcGF0Y2hzZXQgaW4geW91ciBicmFuY2g/IGlmIG5vdCwgdGhlDQo+IHZjb2RlYw0K
PiBzaG91bGQgY2FsbCBtdGtfc21pX2xhcmJfZ2V0IHRvIGVuYWJsZSB0aGUgcG93ZXIvY2xvY2sg
Zm9yIGxhcmJzLA0KPiB0aGVuDQo+IHRoZSBpb21tdSdzIGRldmljZSBpcyBhY3RpdmUgdmlhIGRl
dmljZWxpbmsgYmV0d2VlbiBzbWkgYW5kIGlvbW11DQo+IGRldmljZS4NCj4gDQo+ID4gYW5kIHRo
ZW4gSSBzZWUgdGhlIHdhcm5pbmcgIlBhcnRpYWwgVExCIGZsdXNoIHRpbWVkIG91dCwgZmFsbGlu
Zw0KPiA+IGJhY2sNCj4gPiB0byBmdWxsIGZsdXNoIg0KPiA+IEkgYW0gbm90IHN1cmUgaG93IHRv
IGZpeCB0aGF0IGlzc3VlLCBidXQgaXQgc2VlbXMgdGhhdCBjYXNlICdjKScNCg0KSGF2ZSB5b3Vy
IGlzc3VlIGJlZW4gZml4ZWQ/IG9yIG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgaXQuDQoNClRoYW5r
cy4NCg0KPiA+IG1pZ2h0IGluZGljYXRlIHRoYXQNCj4gPiBwb3dlciBhbmQgY2xvY2sgYXJlIGFj
dHVhbGx5IG5vdCBlbmFibGVkLg0KPiA+IA0KPiA+ID4gbWFwcGluZywgdGhlIHRsYiBmbHVzaCBp
cyB1bm5lY2Vzc2F5IHNpbmNlIHdlIGFscmVhZHkgaGF2ZQ0KPiA+ID4gdGxiX2ZsdXNoX2FsbA0K
PiA+ID4gaW4gdGhlIHBtX3J1bnRpbWVfcmVzdW1lIGNhbGxiYWNrLiBXaGVuIHRoZSBpb21tdSdz
IHBvd2VyIHN0YXR1cw0KPiA+ID4gaXMNCj4gPiA+IGNoYW5nZWQgdG8gYWN0aXZlLCB0aGUgdGxi
IGFsd2F5cyBpcyBjbGVhbi4NCj4gPiA+IA0KPiA+ID4gSW4gYWRkaXRpb24sIHRoZXJlIHN0aWxs
IGFyZSAyIHJlYXNvbnMgdGhhdCBkb24ndCBhZGQgUE0gc3RhdHVzDQo+ID4gPiBjaGVja2luZw0K
PiA+ID4gaW4gdGhlIHRsYiBmbHVzaCBhbGw6DQo+ID4gPiBhKSBXcml0ZSB0bGIgZmx1c2ggYWxs
IHJlZ2lzdGVyIGFsc28gaXMgb2sgZXZlbiB0aG91Z2ggdGhlIEhXIGhhcw0KPiA+ID4gbm8NCj4g
PiA+IHBvd2VyIGFuZCBjbG9ja3MuIFdyaXRlIGlnbm9yZS4NCj4gPiA+IGIpIHBtX3J1bnRpbWVf
Z2V0X2lmX2luX3VzZShtNHVkZXYpIGlzIDAgd2hlbiB0aGUgdGxiX2ZsdXNoX2FsbA0KPiA+ID4g
aXMgY2FsbGVkIGZybSBwbV9ydW50aW1lX3Jlc3VtZSBjYi4gRnJvbSB0aGlzIHBvaW50LCB3ZSBj
YW4gbm90DQo+ID4gPiBhZGQNCj4gPiA+IHRoaXMgY29kZSBhYm92ZSBpbiB0aGlzIHRsYl9mbHVz
aF9hbGwuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVk
aWF0ZWsuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMg
fCAyMCArKysrKysrLS0tLS0tLS0tLS0tLQ0KPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNl
cnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkNCg==

