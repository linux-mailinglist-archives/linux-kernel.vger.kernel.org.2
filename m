Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B705A3C3B2D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 10:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbhGKIcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 04:32:55 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:19547 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229758AbhGKIcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 04:32:54 -0400
X-UUID: af929080615347d7addfaa6af8e1dd1c-20210711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=t9mLnCFBNPQ+QFBApPB3w3g/T+cWtNxPL3HGdUb3WsA=;
        b=iyijnGoDBCAKLaJbAoNDrkvq1J5QEqOoWQ401AkZkzyB8w4mmgc3XKcPgP9RYdgRj3/Ei5iVY8zXeDsvKVT5jPDagwKv9YV3ym4jg0i1S6mRM62hotVS5ovbsvGlv5YdSxVh8SmpL/iv6gXb7iPmkZaEUxx50oQhTADLPOJH8c4=;
X-UUID: af929080615347d7addfaa6af8e1dd1c-20210711
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1398523848; Sun, 11 Jul 2021 16:30:02 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 11 Jul
 2021 16:29:59 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 11 Jul 2021 16:29:59 +0800
Message-ID: <1625992199.22309.15.camel@mhfsdcap03>
Subject: Re: [PATCH 3/9] memory: mtk-smi: Use clk_bulk instead of the clk ops
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Joerg Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <ming-fan.chen@mediatek.com>,
        <yi.kuo@mediatek.com>, <anthony.huang@mediatek.com>
Date:   Sun, 11 Jul 2021 16:29:59 +0800
In-Reply-To: <4047dfaf-f2f8-b6b2-52fd-41821475b162@canonical.com>
References: <20210616114346.18812-1-yong.wu@mediatek.com>
         <20210616114346.18812-4-yong.wu@mediatek.com>
         <4047dfaf-f2f8-b6b2-52fd-41821475b162@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 755D024FD7727026C23CB3E6A5D8D9521A587CF4AB7DEEF2F8C0332526F861752000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTA3LTA4IGF0IDExOjMyICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiBPbiAxNi8wNi8yMDIxIDEzOjQzLCBZb25nIFd1IHdyb3RlOg0KPiA+IHNtaSBoYXZl
IG1hbnkgY2xvY2tzOiBhcGIvc21pL2dhbHMuDQo+ID4gVGhpcyBwYXRjaCB1c2UgY2xrX2J1bGsg
aW50ZXJmYWNlIGluc3RlYWQgb2YgdGhlIG9yZ2luYWwgb25lIHRvIHNpbXBseQ0KPiA+IHRoZSBj
b2RlLg0KPiA+IA0KPiA+IGdhbHMgaXMgb3B0aW9uYWwgY2xrKHNvbWUgbGFyYnMgbWF5IGRvbid0
IGhhdmUgZ2FscykuIHVzZSBjbGtfYnVsa19vcHRpb25hbA0KPiA+IGluc3RlYWQuIGFuZCB0aGVu
IHJlbW92ZSB0aGUgaGFzX2dhbHMgZmxhZy4NCj4gPiANCj4gPiBBbHNvIHJlbW92ZSBjbGsgZmFp
bCBsb2dzIHNpbmNlIGJ1bGsgaW50ZXJmYWNlIGFscmVhZHkgb3V0cHV0IGZhaWwgbG9nLg0KPiA+
IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL21lbW9yeS9tdGstc21pLmMgfCAxMjQgKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRp
b25zKCspLCA5MCBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
ZW1vcnkvbXRrLXNtaS5jIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQo+ID4gaW5kZXggYzVm
YjUxZjczYjM0Li5iY2QyYmYxMzA2NTUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tZW1vcnkv
bXRrLXNtaS5jDQo+ID4gKysrIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQo+ID4gQEAgLTYw
LDkgKzYwLDE4IEBAIGVudW0gbXRrX3NtaV9nZW4gew0KPiA+ICAJTVRLX1NNSV9HRU4yDQo+ID4g
IH07DQo+ID4gIA0KPiA+ICsjZGVmaW5lIE1US19TTUlfQ0xLX05SX01BWAkJCTQNCj4gPiArDQo+
ID4gK3N0YXRpYyBjb25zdCBjaGFyICogY29uc3QgbXRrX3NtaV9jb21tb25fY2xvY2tzW10gPSB7
DQo+ID4gKwkiYXBiIiwgInNtaSIsICJnYWxzMCIsICJnYWxzMSIsIC8qIGdsYXMgaXMgb3B0aW9u
YWwgKi8NCj4gDQo+IFR5cG8gaGVyZSAtIGdsYXMuDQoNCldpbGwgRml4LiBUaGFua3MuDQoNCj4g
DQo+ID4gK307DQo+ID4gKw0KDQpbc25pcF0NCg0KPiA+IEBAIC00OTMsNyArNDQ5LDcgQEAgc3Rh
dGljIGludCBtdGtfc21pX2NvbW1vbl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiA+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiAgCXN0cnVjdCBt
dGtfc21pICpjb21tb247DQo+ID4gIAlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCj4gPiAtCWludCBy
ZXQ7DQo+ID4gKwlpbnQgaSwgcmV0Ow0KPiA+ICANCj4gPiAgCWNvbW1vbiA9IGRldm1fa3phbGxv
YyhkZXYsIHNpemVvZigqY29tbW9uKSwgR0ZQX0tFUk5FTCk7DQo+ID4gIAlpZiAoIWNvbW1vbikN
Cj4gPiBAQCAtNTAxLDIzICs0NTcsMTMgQEAgc3RhdGljIGludCBtdGtfc21pX2NvbW1vbl9wcm9i
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJY29tbW9uLT5kZXYgPSBkZXY7
DQo+ID4gIAljb21tb24tPnBsYXQgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsNCj4g
PiAgDQo+ID4gLQljb21tb24tPmNsa19hcGIgPSBkZXZtX2Nsa19nZXQoZGV2LCAiYXBiIik7DQo+
ID4gLQlpZiAoSVNfRVJSKGNvbW1vbi0+Y2xrX2FwYikpDQo+ID4gLQkJcmV0dXJuIFBUUl9FUlIo
Y29tbW9uLT5jbGtfYXBiKTsNCj4gPiAtDQo+ID4gLQljb21tb24tPmNsa19zbWkgPSBkZXZtX2Ns
a19nZXQoZGV2LCAic21pIik7DQo+ID4gLQlpZiAoSVNfRVJSKGNvbW1vbi0+Y2xrX3NtaSkpDQo+
ID4gLQkJcmV0dXJuIFBUUl9FUlIoY29tbW9uLT5jbGtfc21pKTsNCj4gPiArCWNvbW1vbi0+Y2xr
X251bSA9IEFSUkFZX1NJWkUobXRrX3NtaV9jb21tb25fY2xvY2tzKTsNCj4gPiArCWZvciAoaSA9
IDA7IGkgPCBjb21tb24tPmNsa19udW07IGkrKykNCj4gPiArCQljb21tb24tPmNsa3NbaV0uaWQg
PSBtdGtfc21pX2NvbW1vbl9jbG9ja3NbaV07DQo+ID4gIA0KPiA+IC0JaWYgKGNvbW1vbi0+cGxh
dC0+aGFzX2dhbHMpIHsNCj4gPiAtCQljb21tb24tPmNsa19nYWxzMCA9IGRldm1fY2xrX2dldChk
ZXYsICJnYWxzMCIpOw0KPiA+IC0JCWlmIChJU19FUlIoY29tbW9uLT5jbGtfZ2FsczApKQ0KPiA+
IC0JCQlyZXR1cm4gUFRSX0VSUihjb21tb24tPmNsa19nYWxzMCk7DQo+ID4gLQ0KPiA+IC0JCWNv
bW1vbi0+Y2xrX2dhbHMxID0gZGV2bV9jbGtfZ2V0KGRldiwgImdhbHMxIik7DQo+ID4gLQkJaWYg
KElTX0VSUihjb21tb24tPmNsa19nYWxzMSkpDQo+ID4gLQkJCXJldHVybiBQVFJfRVJSKGNvbW1v
bi0+Y2xrX2dhbHMxKTsNCj4gPiAtCX0NCj4gPiArCXJldCA9IGRldm1fY2xrX2J1bGtfZ2V0X29w
dGlvbmFsKGRldiwgY29tbW9uLT5jbGtfbnVtLCBjb21tb24tPmNsa3MpOw0KPiA+ICsJaWYgKHJl
dCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiANCj4gSG93IGRvIHlvdSBoYW5kbGUgbm93IG1pc3Np
bmcgcmVxdWlyZWQgY2xvY2tzPw0KDQpJdCBsb29rcyB0aGlzIGlzIGEgY29tbW9uIGlzc3VlIGZv
ciB0aGlzIGZ1bmN0aW9uIHdoaWNoIHN1cHBvcnRzIGFsbCB0aGUNCmNsb2NrcyBjb3VsZCBiZSBv
cHRpb25hbC4gSXMgdGhlcmUgY29tbW9uIHN1Z2dlc3Rpb24gZm9yIHRoaXM/DQoNCkZvciBvdXIg
Y2FzZSwgdGhlIGFwYi9zbWkgY2xvY2tzIGFyZSByZXF1aXJlZCB3aGlsZSAiZ2FscyIgYXJlIG9w
dGlvbmFsLg0KDQp0aHVzLCB3ZSBzaG91bGQgdXNlIGRldm1fY2xrX2J1bGtfZ2V0IGZvciB0aGUg
bmVjZXNzYXJ5IGNsb2NrcyBhbmQNCmRldm1fY2xrX2J1bGtfZ2V0X29wdGlvbmFsIGZvciB0aGUg
b3B0aW9uYWwgb25lcy4gcmlnaHQ/DQoNCj4gDQo+ID4gIA0KPiA+ICAJLyoNCj4gPiAgCSAqIGZv
ciBtdGsgc21pIGdlbiAxLCB3ZSBuZWVkIHRvIGdldCB0aGUgYW8oYWx3YXlzIG9uKSBiYXNlIHRv
IGNvbmZpZw0KPiA+IEBAIC01NjEsMTEgKzUwNyw5IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVz
ZWQgbXRrX3NtaV9jb21tb25fcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgCXUzMiBi
dXNfc2VsID0gY29tbW9uLT5wbGF0LT5idXNfc2VsOw0KPiA+ICAJaW50IHJldDsNCj4gPiAgDQo+
ID4gLQlyZXQgPSBtdGtfc21pX2Nsa19lbmFibGUoY29tbW9uKTsNCj4gPiAtCWlmIChyZXQpIHsN
Cj4gPiAtCQlkZXZfZXJyKGNvbW1vbi0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBjbG9jayglZCku
XG4iLCByZXQpOw0KPiA+ICsJcmV0ID0gY2xrX2J1bGtfcHJlcGFyZV9lbmFibGUoY29tbW9uLT5j
bGtfbnVtLCBjb21tb24tPmNsa3MpOw0KPiA+ICsJaWYgKHJldCkNCj4gPiAgCQlyZXR1cm4gcmV0
Ow0KPiA+IC0JfQ0KPiA+ICANCj4gPiAgCWlmIChjb21tb24tPnBsYXQtPmdlbiA9PSBNVEtfU01J
X0dFTjIgJiYgYnVzX3NlbCkNCj4gPiAgCQl3cml0ZWwoYnVzX3NlbCwgY29tbW9uLT5iYXNlICsg
U01JX0JVU19TRUwpOw0KPiA+IEBAIC01NzYsNyArNTIwLDcgQEAgc3RhdGljIGludCBfX21heWJl
X3VudXNlZCBtdGtfc21pX2NvbW1vbl9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAg
ew0KPiA+ICAJc3RydWN0IG10a19zbWkgKmNvbW1vbiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0K
PiA+ICANCj4gPiAtCW10a19zbWlfY2xrX2Rpc2FibGUoY29tbW9uKTsNCj4gPiArCWNsa19idWxr
X2Rpc2FibGVfdW5wcmVwYXJlKGNvbW1vbi0+Y2xrX251bSwgY29tbW9uLT5jbGtzKTsNCj4gPiAg
CXJldHVybiAwOw0KPiA+ICB9DQo+ID4gIA0KPiA+IA0KPiANCj4gDQo+IEJlc3QgcmVnYXJkcywN
Cj4gS3J6eXN6dG9mDQoNCg==

