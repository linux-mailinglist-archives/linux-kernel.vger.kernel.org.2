Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB003E3309
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 05:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhHGDvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 23:51:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38530 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230144AbhHGDvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 23:51:40 -0400
X-UUID: 11b4f14afcaa43639879aa32b0437f36-20210807
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xbNG7nvc2tiwREXnAuN36W+NorCMrtpqAbkcTeVJiiY=;
        b=fgNeYqq1+CCTZ/LQYe+hOZRUJZX73l5Vlt0v/qJeAsp9utx4F8DFwat89XwRoPbRxSh023q43+lMzkQQFZeVlO/JoVYC5bBBwTjiYYUJOyIgKWuQSsBIC/h5dPqox991VVJa+/GdIZqhjs5izyblt0A7ITUJ9yqVFR+LqoGaTzA=;
X-UUID: 11b4f14afcaa43639879aa32b0437f36-20210807
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1016640068; Sat, 07 Aug 2021 11:51:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 7 Aug 2021 11:51:18 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 7 Aug 2021 11:51:18 +0800
Message-ID: <1628308278.23588.3.camel@mtksdaap41>
Subject: Re: [PATCH v10 4/5] spmi: mediatek: Add support for MT8195
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
Date:   Sat, 7 Aug 2021 11:51:18 +0800
In-Reply-To: <162827215909.1975443.852277412377742323@swboyd.mtv.corp.google.com>
References: <1627972461-2627-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1627972461-2627-5-git-send-email-hsin-hsiung.wang@mediatek.com>
         <162827215909.1975443.852277412377742323@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQpzb3JyeSBmb3IgbWlzc2luZyBvdGhlciBjb21tZW50cywgSSB3aWxsIGNvbmZpcm0gaXQg
aW50ZXJuYWxseSBhbmQNCnVwZGF0ZSBpdC4NCg0KVGhhbmtzIGEgbG90Lg0KDQpPbiBGcmksIDIw
MjEtMDgtMDYgYXQgMTA6NDkgLTA3MDAsIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4gUXVvdGluZyBI
c2luLUhzaXVuZyBXYW5nICgyMDIxLTA4LTAyIDIzOjM0OjIwKQ0KPiA+IEZyb206IEhlbnJ5IENo
ZW4gPGhlbnJ5Yy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiANCj4gPiBBZGQgc3BtaSBzdXBwb3J0
IGZvciBNVDgxOTUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSGVucnkgQ2hlbiA8aGVucnlj
LmNoZW5AbWVkaWF0ZWsuY29tPg0KPiANCj4gTWlzc2luZyBTaWduZWQtb2ZmLWJ5IGZyb20gaHNp
bi1oc2l1bmcud2FuZyBoZXJlDQo+IA0KPiA+IC0tLQ0KPiA+IGNoYW5nZXMgc2luY2Ugdjk6DQo+
ID4gLSBObyBjaGFuZ2UuDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvc3BtaS9zcG1pLW10ay1wbWlm
LmMgfCA5MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDkwIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9zcG1pL3NwbWktbXRrLXBtaWYuYyBiL2RyaXZlcnMvc3BtaS9zcG1pLW10ay1wbWlmLmMNCj4g
PiBpbmRleCA5NGM0NWQ0NmFiMGMuLjBjMzIwODAxYzlkNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL3NwbWkvc3BtaS1tdGstcG1pZi5jDQo+ID4gKysrIGIvZHJpdmVycy9zcG1pL3NwbWktbXRr
LXBtaWYuYw0KPiA+IEBAIC0zNDgsNiArNDI3LDE0IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcG1p
Zl9kYXRhIG10Njg3M19wbWlmX2FyYiA9IHsNCj4gPiAgICAgICAgIC5zb2NfY2hhbiA9IDIsDQo+
ID4gIH07DQo+ID4gIA0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHBtaWZfZGF0YSBtdDgxOTVf
cG1pZl9hcmJbXSA9IHsNCj4gDQo+IFRoaXMgaXMgYW4gYXJyYXkgb2YgdHlwZSBwbWlmX2RhdGEu
DQo+IA0KPiA+ICsgICAgICAgew0KPiA+ICsgICAgICAgICAgICAgICAucmVncyA9IG10ODE5NV9y
ZWdzLA0KPiA+ICsgICAgICAgICAgICAgICAuc3BtaW1zdF9yZWdzID0gbXQ4MTk1X3NwbWlfcmVn
cywNCj4gPiArICAgICAgICAgICAgICAgLnNvY19jaGFuID0gMiwNCj4gPiArICAgICAgIH0sDQo+
ID4gK307DQo+ID4gKw0KPiA+ICBzdGF0aWMgaW50IG10a19zcG1pX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gIHsNCj4gPiAgICAgICAgIHN0cnVjdCBwbWlmICphcmI7
DQo+ID4gQEAgLTQ0NCw2ICs1MzEsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9p
ZCBtdGtfc3BtaV9tYXRjaF90YWJsZVtdID0gew0KPiA+ICAgICAgICAgew0KPiA+ICAgICAgICAg
ICAgICAgICAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY4NzMtc3BtaSIsDQo+ID4gICAgICAg
ICAgICAgICAgIC5kYXRhID0gJm10Njg3M19wbWlmX2FyYiwNCj4gDQo+IG10Njg3M19wbWlmX2Fy
YiBpcyBub3QgYW4gYXJyYXksIHNlZSB0aGUgY29udGV4dCBoZWFkZXIgYWJvdmUuDQo+IA0KPiBI
b3cgZG9lcyB0aGlzIHdvcms/IEhhcyB0aGlzIGJlZW4gdGVzdGVkPw0KPiANCj4gPiArICAgICAg
IH0sIHsNCj4gPiArICAgICAgICAgICAgICAgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1
LXNwbWkiLA0KPiA+ICsgICAgICAgICAgICAgICAuZGF0YSA9ICZtdDgxOTVfcG1pZl9hcmIsDQo+
ID4gICAgICAgICB9LCB7DQo+ID4gICAgICAgICAgICAgICAgIC8qIHNlbnRpbmVsICovDQo+ID4g
ICAgICAgICB9LA0KPiA+IC0tIA0KPiA+IDIuMTguMA0KPiA+DQoNCg==

