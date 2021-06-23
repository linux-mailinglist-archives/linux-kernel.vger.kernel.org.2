Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7813B157B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 10:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFWINT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 04:13:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60684 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230004AbhFWINR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 04:13:17 -0400
X-UUID: 9b9dcc76c44b4ad1811df79c25a60cec-20210623
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=SKYmo8MiSbxF2eqHWz+6lxTmMnXCOR0tQK4sP3HO040=;
        b=rVG575ii9f1xM7j1pmpejioH7gVYeKy5k0I1vmBZYtxlCgigpgN2mTps7t1SMP5B6wcyIfsz8T2CcABLAVchfRzF5Vkz7glGqCoYhMTyLMBEFz7Ld1pDYf0my0C/ZbpKLSqkgfdAQzXYlq2SY57nwZJo3PIxEFYM0zoY20l1K+I=;
X-UUID: 9b9dcc76c44b4ad1811df79c25a60cec-20210623
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 754862258; Wed, 23 Jun 2021 16:10:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Jun 2021 16:10:56 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Jun 2021 16:10:56 +0800
Message-ID: <8344d089562052a6f9ee3245856bbc8516bb6619.camel@mediatek.com>
Subject: Re: [PATCH 6/8] dt-bindings: mediatek: mt8195: add audio afe
 document
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <broonie@kernel.org>, <bicycle.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <robh+dt@kernel.org>,
        <cychiang@google.com>, <jiaxin.yu@mediatek.com>, <tiwai@suse.com>,
        <matthias.bgg@gmail.com>
Date:   Wed, 23 Jun 2021 16:10:56 +0800
In-Reply-To: <1623965184.501241.3336112.nullmailer@robh.at.kernel.org>
References: <20210617054740.8081-1-trevor.wu@mediatek.com>
         <20210617054740.8081-7-trevor.wu@mediatek.com>
         <1623965184.501241.3336112.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA2LTE3IGF0IDE1OjI2IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVGh1LCAxNyBKdW4gMjAyMSAxMzo0NzozNyArMDgwMCwgVHJldm9yIFd1IHdyb3RlOg0KPiA+
IFRoaXMgcGF0Y2ggYWRkcyBtdDgxOTUgYXVkaW8gYWZlIGRvY3VtZW50Lg0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IFRyZXZvciBXdSA8dHJldm9yLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0N
Cj4gPiAgLi4uL2JpbmRpbmdzL3NvdW5kL210ODE5NS1hZmUtcGNtLnlhbWwgICAgICAgIHwgNzIN
Cj4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA3MiBpbnNlcnRp
b25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc291bmQvbXQ4MTk1LQ0KPiA+IGFmZS1wY20ueWFtbA0KPiA+IA0KPiANCj4gTXkg
Ym90IGZvdW5kIGVycm9ycyBydW5uaW5nICdtYWtlIERUX0NIRUNLRVJfRkxBR1M9LW0NCj4gZHRf
YmluZGluZ19jaGVjaycNCj4gb24geW91ciBwYXRjaCAoRFRfQ0hFQ0tFUl9GTEFHUyBpcyBuZXcg
aW4gdjUuMTMpOg0KPiANCj4geWFtbGxpbnQgd2FybmluZ3MvZXJyb3JzOg0KPiAuL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb3VuZC9tdDgxOTUtYWZlLXBjbS55YW1sOjEwOjQ6
DQo+IFt3YXJuaW5nXSB3cm9uZyBpbmRlbnRhdGlvbjogZXhwZWN0ZWQgMiBidXQgZm91bmQgMyAo
aW5kZW50YXRpb24pDQo+IC4vRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvdW5k
L210ODE5NS1hZmUtcGNtLnlhbWw6MTQ6NzoNCj4gW3dhcm5pbmddIHdyb25nIGluZGVudGF0aW9u
OiBleHBlY3RlZCA0IGJ1dCBmb3VuZCA2IChpbmRlbnRhdGlvbikNCj4gDQo+IGR0c2NoZW1hL2R0
YyB3YXJuaW5ncy9lcnJvcnM6DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
b3VuZC9tdDgxOTUtYWZlLQ0KPiBwY20uZXhhbXBsZS5kdHM6MTk6MTg6IGZhdGFsIGVycm9yOiBk
dC1iaW5kaW5ncy9jbG9jay9tdDgxOTUtY2xrLmg6DQo+IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3Rv
cnkNCj4gICAgMTkgfCAgICAgICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9jbG9jay9tdDgxOTUt
Y2xrLmg+DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fg0KPiBjb21waWxhdGlvbiB0ZXJtaW5hdGVkLg0KPiBtYWtlWzFdOiAqKiogW3Nj
cmlwdHMvTWFrZWZpbGUubGliOjM4MDoNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NvdW5kL210ODE5NS1hZmUtDQo+IHBjbS5leGFtcGxlLmR0LnlhbWxdIEVycm9yIDENCj4g
bWFrZVsxXTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4uLi4NCj4gbWFrZTogKioq
IFtNYWtlZmlsZToxNDE2OiBkdF9iaW5kaW5nX2NoZWNrXSBFcnJvciAyDQo+IFxuZG9jIHJlZmVy
ZW5jZSBlcnJvcnMgKG1ha2UgcmVmY2hlY2tkb2NzKToNCj4gDQo+IFNlZSBodHRwczovL3BhdGNo
d29yay5vemxhYnMub3JnL3BhdGNoLzE0OTMxOTcNCj4gDQo+IFRoaXMgY2hlY2sgY2FuIGZhaWwg
aWYgdGhlcmUgYXJlIGFueSBkZXBlbmRlbmNpZXMuIFRoZSBiYXNlIGZvciBhDQo+IHBhdGNoDQo+
IHNlcmllcyBpcyBnZW5lcmFsbHkgdGhlIG1vc3QgcmVjZW50IHJjMS4NCj4gDQo+IElmIHlvdSBh
bHJlYWR5IHJhbiAnbWFrZSBkdF9iaW5kaW5nX2NoZWNrJyBhbmQgZGlkbid0IHNlZSB0aGUgYWJv
dmUNCj4gZXJyb3IocyksIHRoZW4gbWFrZSBzdXJlICd5YW1sbGludCcgaXMgaW5zdGFsbGVkIGFu
ZCBkdC1zY2hlbWEgaXMgdXANCj4gdG8NCj4gZGF0ZToNCj4gDQo+IHBpcDMgaW5zdGFsbCBkdHNj
aGVtYSAtLXVwZ3JhZGUNCj4gDQo+IFBsZWFzZSBjaGVjayBhbmQgcmUtc3VibWl0Lg0KPiANCg0K
U29ycnksIEkgbWlzc2VkIHRoZSBkZXBlbmRlbmN5IGRlY2xhcmF0aW9uIGluIHRoZSBwYXRjaCBh
bmQgSSBkaWRuJ3QNCmluc3RhbGwgeW1hbGxpbnQsIHNvIEkgY291bGRuJ3QgZmluZCBpbmRlbnRh
dGlvbiBwcm9ibGVtcy4NCkkgd2lsbCBmaXggYWxsIGJpbmRpbmcgcHJvYmxlbXMgb24gdjIuDQoN
ClRoYW5rcywNClRyZXZvcg0K

