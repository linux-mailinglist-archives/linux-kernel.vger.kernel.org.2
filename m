Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA9B392453
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 03:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbhE0Baj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 21:30:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34369 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232861AbhE0Bai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 21:30:38 -0400
X-UUID: 8164e5da91a7445f85576216b24389cf-20210527
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=nDV4+Q0St+9RugwqaQ3M5/UdGbXUypt9kmgTr0rwGic=;
        b=EH7anMN/AJ2UzpVZdnLXGH8vn2tnE4Ir7Gqlc52qyq0NXxoiJfYxRDZ84X7r9x+7Rxb+Lj76rTwK2SGqm+fHSfmDxzP+UxRtTshdgROWraPr1rdLGlw0tHY83g5UZnWpyLY7t6lB+UOfQrpaNAoYNfHJ3GjByAegKNKOU7bve00=;
X-UUID: 8164e5da91a7445f85576216b24389cf-20210527
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 962686196; Thu, 27 May 2021 09:29:03 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 27 May 2021 09:29:01 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 27 May 2021 09:29:01 +0800
Message-ID: <1622078941.17674.3.camel@mtksdaap41>
Subject: Re: [PATCH v8 2/4] dt-bindings: spmi: document binding for the
 Mediatek SPMI controller
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Stephen Boyd <sboyd@kernel.org>, <srv_heupstream@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 27 May 2021 09:29:01 +0800
In-Reply-To: <1622033763.799295.2377040.nullmailer@robh.at.kernel.org>
References: <1622025344-31888-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1622025344-31888-3-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1622033763.799295.2377040.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIFdlZCwgMjAyMS0wNS0yNiBhdCAwNzo1NiAtMDUwMCwgUm9iIEhlcnJpbmcgd3Jv
dGU6DQo+IE9uIFdlZCwgMjYgTWF5IDIwMjEgMTg6MzU6NDIgKzA4MDAsIEhzaW4tSHNpdW5nIFdh
bmcgd3JvdGU6DQo+ID4gVGhpcyBhZGRzIGRvY3VtZW50YXRpb24gZm9yIHRoZSBTUE1JIGNvbnRy
b2xsZXIgZm91bmQgb24gTWVkaWF0ZWsgU29Dcy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBI
c2luLUhzaXVuZyBXYW5nIDxoc2luLWhzaXVuZy53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0N
Cj4gPiBjaGFuZ2VzIHNpbmNlIHY3Og0KPiA+IC0gbm8gY2hhbmdlLg0KPiA+IC0tLQ0KPiA+ICAu
Li4vYmluZGluZ3Mvc3BtaS9tdGssc3BtaS1tdGstcG1pZi55YW1sICAgICAgICAgICB8IDc0ICsr
KysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDc0IGluc2VydGlvbnMo
KykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9zcG1pL210ayxzcG1pLW10ay1wbWlmLnlhbWwNCj4gPiANCj4gDQo+IE15IGJvdCBmb3Vu
ZCBlcnJvcnMgcnVubmluZyAnbWFrZSBEVF9DSEVDS0VSX0ZMQUdTPS1tIGR0X2JpbmRpbmdfY2hl
Y2snDQo+IG9uIHlvdXIgcGF0Y2ggKERUX0NIRUNLRVJfRkxBR1MgaXMgbmV3IGluIHY1LjEzKToN
Cj4gDQo+IHlhbWxsaW50IHdhcm5pbmdzL2Vycm9yczoNCj4gDQo+IGR0c2NoZW1hL2R0YyB3YXJu
aW5ncy9lcnJvcnM6DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcG1pL210
ayxzcG1pLW10ay1wbWlmLmV4YW1wbGUuZHRzOjE5OjE4OiBmYXRhbCBlcnJvcjogZHQtYmluZGlu
Z3MvY2xvY2svbXQ4MTkyLWNsay5oOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQo+ICAgIDE5
IHwgICAgICAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTkyLWNsay5oPg0KPiAg
ICAgICB8ICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4N
Cj4gY29tcGlsYXRpb24gdGVybWluYXRlZC4NCj4gbWFrZVsxXTogKioqIFtzY3JpcHRzL01ha2Vm
aWxlLmxpYjozODA6IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcG1pL210ayxz
cG1pLW10ay1wbWlmLmV4YW1wbGUuZHQueWFtbF0gRXJyb3IgMQ0KPiBtYWtlWzFdOiAqKiogV2Fp
dGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLg0KPiBtYWtlOiAqKiogW01ha2VmaWxlOjE0MTY6
IGR0X2JpbmRpbmdfY2hlY2tdIEVycm9yIDINCj4gDQo+IFNlZSBodHRwczovL3BhdGNod29yay5v
emxhYnMub3JnL3BhdGNoLzE0ODM5ODkNCj4gDQo+IFRoaXMgY2hlY2sgY2FuIGZhaWwgaWYgdGhl
cmUgYXJlIGFueSBkZXBlbmRlbmNpZXMuIFRoZSBiYXNlIGZvciBhIHBhdGNoDQo+IHNlcmllcyBp
cyBnZW5lcmFsbHkgdGhlIG1vc3QgcmVjZW50IHJjMS4NCj4gDQo+IElmIHlvdSBhbHJlYWR5IHJh
biAnbWFrZSBkdF9iaW5kaW5nX2NoZWNrJyBhbmQgZGlkbid0IHNlZSB0aGUgYWJvdmUNCj4gZXJy
b3IocyksIHRoZW4gbWFrZSBzdXJlICd5YW1sbGludCcgaXMgaW5zdGFsbGVkIGFuZCBkdC1zY2hl
bWEgaXMgdXAgdG8NCj4gZGF0ZToNCj4gDQo+IHBpcDMgaW5zdGFsbCBkdHNjaGVtYSAtLXVwZ3Jh
ZGUNCj4gDQo+IFBsZWFzZSBjaGVjayBhbmQgcmUtc3VibWl0Lg0KPiANCg0KVGhhbmtzLiBmb3Ig
dGhlIHJldmlldy4NClRoaXMgc2VyaWVzIGlzIGJhc2VkIG9uIENodW4tSmllJ3MgcGF0Y2hlc1sx
XS4NCg0KWzFdDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVk
aWF0ZWsvbGlzdC8/c2VyaWVzPTQ4ODIzOQ0KDQo=

