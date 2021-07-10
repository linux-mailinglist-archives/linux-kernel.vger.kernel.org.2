Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172E13C3373
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 09:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhGJHUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 03:20:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34170 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229754AbhGJHUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 03:20:36 -0400
X-UUID: 6df1280e67ec454aa7ce3b128ce7ba81-20210710
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=/okFO/76ZahoifasUdc1lyHwQCsHpNseD/T4awn0nFE=;
        b=lU+1/lbM5TBkGTMhMniGqcfmaEEtsAB2Igz7Q0/OjLYIsJ4/NUJEstqEM255k3+wvedFAGrsIh8oX4UXHveRX055W9/Vk2P7gjP1vBZ/H5vRLJszvycmMBytTbWCP2iE5IsM2uG4QU+ViFzO2zaxzCdEoIW7KSPT5ck07g8IzHY=;
X-UUID: 6df1280e67ec454aa7ce3b128ce7ba81-20210710
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1064743693; Sat, 10 Jul 2021 15:17:47 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 10 Jul 2021 15:17:46 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 10 Jul 2021 15:17:46 +0800
Message-ID: <d841973cfac17f67b1716a861a433bbddf92058b.camel@mediatek.com>
Subject: Re: [PATCH v1 09/17] drm/mediatek: add OVL support multi-layer
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     <chunkuang.hu@kernel.org>, <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <fshao@google.com>, <nancy.lin@mediatek.com>,
        <singo.chang@mediatek.com>
Date:   Sat, 10 Jul 2021 15:17:46 +0800
In-Reply-To: <1625636614.7824.19.camel@mtksdaap41>
References: <20210707041249.29816-1-jason-jh.lin@mediatek.com>
         <20210707041249.29816-10-jason-jh.lin@mediatek.com>
         <1625636614.7824.19.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA3LTA3IGF0IDEzOjQzICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIEph
c29uOg0KPiANCj4gT24gV2VkLCAyMDIxLTA3LTA3IGF0IDEyOjEyICswODAwLCBqYXNvbi1qaC5s
aW4gd3JvdGU6DQo+ID4gQWRkIGRhdGFwYXRoX2NvbiBzZXR0aW5ncyB0byBzdXBwb3J0IG11bHRp
LWxheWVyIG91dHB1dC4NCj4gDQo+IA0KPiBXaGF0IGlzIG11bHRpLWxheWVyIG91dHB1dD8gV2h5
IHdlIG5lZWQgdGhpcz8NCj4gDQpIaSBDSywNCg0KVGhpcyBwYXRjaCBpcyBub3QgdGhlIG11bHRp
LWxheWVyIG91dHB1dCBmaXggdXAgcGF0Y2guDQpUaGUgZml4IHVwIHBhdGNoIGlzIHRoaXMgb25l
Og0KDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9jaHVu
a3VhbmcuaHUvbGludXguZ2l0L2NvbW1pdC9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3Bfb3ZsLmM/aD1tZWRpYXRlay1kcm0tbmV4dCZpZD1kNDFmZjRkY2YwOTM4ODVkY2MyNTNlMzg2
MTgzNGVlYTI5NDgyN2NiDQoNClNvIHRoaXMgcGF0Y2ggaXMgbm90IG5lY2Vzc2FyeSBmb3IgbXQ4
MTk1IERSTSBzZXJpZXMgcGF0Y2hlcy4NCkknbGwgcmVtb3ZlIHRoaXMgcGF0Y2ggYXQgdGhlIG5l
eHQgdmVyc2lvbi4NCg0KQnkgdGhlIHdheSwgdGhpcyBwYXRjaGVzIGlzIGZvcjoNCjEuIElmIEdD
TEFTVCBpcyBub3QgZW5hYmxlZCwgU01JIHdpbGwgbm90IGtub3cgaWYgdGhlIGdyb3VwIGlzIG92
ZXIuDQpTTUkgd2lsbCB3YWl0IHVudGlsIHRoZSBsYXN0IHNpZ25hbCBpcyByZWNlaXZlZCBiZWZv
cmUgaXQgc3RhcnRzIHRvDQphY3QuDQpJdCBtYXkgY2F1c2UgT1ZMIGNhbiBub3QgcmVjZWl2ZSBh
bnkgZGF0YSBmcm9tIFNNSS4NCg0KVG8gc3VwcG9ydCBPVkwgbXVsdGktbGF5ZXIgb3V0cHV0LCBh
ZGQgZGF0YXBhdGhfY29uIHNldHRpbmdzIGJlbG93Og0KR0NMQVNUX0VOID0gQklUKDI0KSwgZW5h
YmxlIGxhc3QgU01JIHNpZ25hbCBvZiBvdmwgZ3JvdXANCkhEUl9HQ0xBU1RfRU4gPSBCSVQoMjUp
LCBlbmFibGUgbGFzdCBTTUkgc2lnbmFsIG9mIG92bCBBRkJDIGdyb3VwDQoNCjIuIEFmdGVyIE9V
VFBVVF9DTEFNUCBpcyBlbmFibGVkLCB0aGUgZGF0YSB3aWxsIGJlIHJvdW5kZWQgZnJvbSAxMi1i
aXQNCnRvIDEwLWJpdC4gQmVjYXVzZSB0aGUgbW9kdWxlcyBhZnRlciBPVkwgbmVlZCAxMC1iaXQg
aW5wdXQgY3VycmVudGx5Lg0KSXQgbWF5IGNhdXNlIHVuZGVyZmxvdyBwcm9ibGVtLCBpZiB0aGVy
ZSBpcyBubyByb3VuZGluZyB0byAxMC1iaXQuDQoNClRvIHN1cHBvcnQgMTBiaXQgZGF0YSByb3Vu
ZGluZywgYWRkIGRhdGFwYXRoX2NvbiBzZXR0aW5ncyBiZWxvdzoNCk9VVFBVVF9DTEFNUCA9IEJJ
VCgyNiksIHJvdW5kaW5nIGRhdGEgZnJvbSAxMi1iaXQgdG8gMTAtYml0DQoNClJlZ2FyZCwNCkph
c29uLUpILkxpbg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IGphc29uLWpoLmxpbiA8amFzb24t
amgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX292bC5jIHwgMTUgKysrKysrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiA+IGluZGV4IDc1MDRlODZiMTY3
YS4uOTVmZDVlMDBlYjkxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZGlzcF9vdmwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZGlzcF9vdmwuYw0KPiA+IEBAIC0xOCwxNCArMTgsMTcgQEANCj4gPiAgI2luY2x1ZGUgIm10a19k
cm1fZGRwX2NvbXAuaCINCj4gPiAgDQo+ID4gICNkZWZpbmUgRElTUF9SRUdfT1ZMX0lOVEVOCQkJ
MHgwMDA0DQo+ID4gLSNkZWZpbmUgT1ZMX0ZNRV9DUExfSU5UCQkJCQlCSVQoMSkNCj4gPiArI2Rl
ZmluZSBPVkxfRk1FX0NQTF9JTlQJCQkJQklUKDEpDQo+ID4gICNkZWZpbmUgRElTUF9SRUdfT1ZM
X0lOVFNUQQkJCTB4MDAwOA0KPiA+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9FTgkJCQkweDAwMGMN
Cj4gPiAgI2RlZmluZSBESVNQX1JFR19PVkxfUlNUCQkJMHgwMDE0DQo+ID4gICNkZWZpbmUgRElT
UF9SRUdfT1ZMX1JPSV9TSVpFCQkJMHgwMDIwDQo+ID4gICNkZWZpbmUgRElTUF9SRUdfT1ZMX0RB
VEFQQVRIX0NPTgkJMHgwMDI0DQo+ID4gLSNkZWZpbmUgT1ZMX0xBWUVSX1NNSV9JRF9FTgkJCQlC
SVQoMCkNCj4gPiAtI2RlZmluZSBPVkxfQkdDTFJfU0VMX0lOCQkJCUJJVCgyKQ0KPiA+ICsjZGVm
aW5lIE9WTF9MQVlFUl9TTUlfSURfRU4JCQlCSVQoMCkNCj4gPiArI2RlZmluZSBPVkxfQkdDTFJf
U0VMX0lOCQkJQklUKDIpDQo+ID4gKyNkZWZpbmUgT1ZMX0dDTEFTVF9FTgkJCQlCSVQoMjQpDQo+
ID4gKyNkZWZpbmUgT1ZMX0hEUl9HQ0xBU1RfRU4JCQlCSVQoMjUpDQo+ID4gKyNkZWZpbmUgT1ZM
X09VVFBVVF9DTEFNUAkJCUJJVCgyNikNCj4gPiAgI2RlZmluZSBESVNQX1JFR19PVkxfUk9JX0JH
Q0xSCQkJMHgwMDI4DQo+ID4gICNkZWZpbmUgRElTUF9SRUdfT1ZMX1NSQ19DT04JCQkweDAwMmMN
Cj4gPiAgI2RlZmluZSBESVNQX1JFR19PVkxfQ09OKG4pCQkJKDB4MDAzMCArIDB4MjANCj4gPiAq
IChuKSkNCj4gPiBAQCAtMjIyLDYgKzIyNSw3IEBAIHZvaWQgbXRrX292bF9sYXllcl9vbihzdHJ1
Y3QgZGV2aWNlICpkZXYsDQo+ID4gdW5zaWduZWQgaW50IGlkeCwNCj4gPiAgCXVuc2lnbmVkIGlu
dCBnbWNfdGhyc2hkX2w7DQo+ID4gIAl1bnNpZ25lZCBpbnQgZ21jX3RocnNoZF9oOw0KPiA+ICAJ
dW5zaWduZWQgaW50IGdtY192YWx1ZTsNCj4gPiArCXVuc2lnbmVkIGludCBkYXRhcGF0Y2hfY29u
Ow0KPiA+ICAJc3RydWN0IG10a19kaXNwX292bCAqb3ZsID0gZGV2X2dldF9kcnZkYXRhKGRldik7
DQo+ID4gIA0KPiA+ICAJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgMHgxLCAmb3ZsLT5jbWRxX3Jl
Zywgb3ZsLT5yZWdzLA0KPiA+IEBAIC0yMzcsNiArMjQxLDExIEBAIHZvaWQgbXRrX292bF9sYXll
cl9vbihzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gdW5zaWduZWQgaW50IGlkeCwNCj4gPiAgCQkJ
ICAgIGdtY190aHJzaGRfaCA8PCAxNiB8IGdtY190aHJzaGRfaCA8PCAyNDsNCj4gPiAgCW10a19k
ZHBfd3JpdGUoY21kcV9wa3QsIGdtY192YWx1ZSwNCj4gPiAgCQkgICAgICAmb3ZsLT5jbWRxX3Jl
Zywgb3ZsLT5yZWdzLA0KPiA+IERJU1BfUkVHX09WTF9SRE1BX0dNQyhpZHgpKTsNCj4gPiArDQo+
ID4gKwlkYXRhcGF0Y2hfY29uID0gT1ZMX0dDTEFTVF9FTiB8IE9WTF9IRFJfR0NMQVNUX0VOIHwN
Cj4gPiBPVkxfT1VUUFVUX0NMQU1QOw0KPiA+ICsJbXRrX2RkcF93cml0ZV9tYXNrKGNtZHFfcGt0
LCBkYXRhcGF0Y2hfY29uLCAmb3ZsLT5jbWRxX3JlZywNCj4gPiBvdmwtPnJlZ3MsDQo+ID4gKwkJ
CQkgRElTUF9SRUdfT1ZMX0RBVEFQQVRIX0NPTiwNCj4gPiBkYXRhcGF0Y2hfY29uKTsNCj4gDQo+
IEZvciBtdDgxNzMgb3Igb3RoZXIgU29DLCB0aGlzIGRvZXMgbm90IHR1cm4gb24uIE5vdyB5b3Ug
dHVybiBvbiB0aGlzLA0KPiB3b3VsZCB0aGlzIGluZmx1ZW5jZSBvdGhlciBTb0M/DQo+IA0KPiBS
ZWdhcmRzLA0KPiBDSw0KPiANCj4gPiArDQo+ID4gIAltdGtfZGRwX3dyaXRlX21hc2soY21kcV9w
a3QsIEJJVChpZHgpLCAmb3ZsLT5jbWRxX3JlZywgb3ZsLQ0KPiA+ID5yZWdzLA0KPiA+ICAJCQkg
ICBESVNQX1JFR19PVkxfU1JDX0NPTiwgQklUKGlkeCkpOw0KPiA+ICB9DQo+IA0KPiANCg==

