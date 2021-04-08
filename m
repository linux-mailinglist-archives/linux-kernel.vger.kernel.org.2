Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1631357C08
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 07:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhDHF5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 01:57:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:33900 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229506AbhDHF5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 01:57:15 -0400
X-UUID: 9ec0f36d79df4bbdade276e159f486fb-20210408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=NF6+KA1hmcxu8LOS4sh14AzA0G1CRSU3hyieSqe1wFQ=;
        b=rk4R+Bhuk0RgMXW6IW8wB7poaU/a0Lp42O7LQDSO4ysz1h12KNbbSwd7NgyoXKS4WLMt+CUdNHUYEwMVorL9ge/0cJLwlu1uGJ7AKym9ZrseU0J1htMIn9OBLZTaR5h+pcogN0G8SdCtb8sigCVLJzVblvPg0JPTj68BOJHpIpM=;
X-UUID: 9ec0f36d79df4bbdade276e159f486fb-20210408
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 270468067; Thu, 08 Apr 2021 13:57:02 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 8 Apr 2021 13:57:01 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Apr 2021 13:57:01 +0800
Message-ID: <1617861421.8874.3.camel@mtksdccf07>
Subject: Re: [PATCH v2 2/6] soc: mediatek: devapc: move 'vio_idx_num' info
 to DT
From:   Nina Wu <nina-cm.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <Jackson-kt.Chang@mediatek.com>
Date:   Thu, 8 Apr 2021 13:57:01 +0800
In-Reply-To: <39794302-7993-4f9c-b28c-577fdb0265a3@gmail.com>
References: <1617259087-5502-1-git-send-email-nina-cm.wu@mediatek.com>
         <1617259087-5502-2-git-send-email-nina-cm.wu@mediatek.com>
         <39794302-7993-4f9c-b28c-577fdb0265a3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hdHRoaWFzDQoNCg0KT24gVHVlLCAyMDIxLTA0LTA2IGF0IDE1OjQxICswMjAwLCBNYXR0
aGlhcyBCcnVnZ2VyIHdyb3RlOg0KPiANCj4gT24gMDEvMDQvMjAyMSAwODozOCwgTmluYSBXdSB3
cm90ZToNCj4gPiBGcm9tOiBOaW5hIFd1IDxOaW5hLUNNLld1QG1lZGlhdGVrLmNvbT4NCj4gPiAN
Cj4gPiBGb3IgbmV3IElDcywgdGhlcmUgYXJlIG11bHRpcGxlIGRldmFwYyBIV3MgZm9yIGRpZmZl
cmVudCBzdWJzeXMuDQo+ID4gVGhlIG51bWJlciBvZiBkZXZpY2VzIGNvbnRyb2xsZWQgYnkgZWFj
aCBkZXZhcGMgKGkuZS4gJ3Zpb19pZHhfbnVtJw0KPiA+IGluIHRoZSBjb2RlKSB2YXJpZXMuDQo+
ID4gV2UgbW92ZSB0aGlzIGluZm8gZnJvbSBjb21wYXRpYmxlIGRhdGEgdG8gRFQgc28gdGhhdCB3
ZSBkbyBub3QgbmVlZA0KPiA+IHRvIGFkZCBuIGNvbXBhdGlibGUgZm9yIGEgY2VydGFpbiBJQyB3
aGljaCBoYXMgbiBkZXZhcGMgSFdzIHdpdGgNCj4gPiBkaWZmZXJlbnQgJ3Zpb19pZHhfbnVtJywg
cmVzcGVjdGl2ZWx5Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE5pbmEgV3UgPE5pbmEtQ00u
V3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGst
ZGV2YXBjLmMgfCAxOCArKysrKysrKystLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDkg
aW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLWRldmFwYy5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LWRldmFwYy5jDQo+ID4gaW5kZXggZjFjZWEwNC4uYTBmNmZiZCAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL3NvYy9tZWRpYXRlay9tdGstZGV2YXBjLmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstZGV2YXBjLmMNCj4gPiBAQCAtMzIsOSArMzIsNiBAQCBzdHJ1Y3QgbXRrX2Rl
dmFwY192aW9fZGJncyB7DQo+ID4gIH07DQo+ID4gIA0KPiA+ICBzdHJ1Y3QgbXRrX2RldmFwY19k
YXRhIHsNCj4gPiAtCS8qIG51bWJlcnMgb2YgdmlvbGF0aW9uIGluZGV4ICovDQo+ID4gLQl1MzIg
dmlvX2lkeF9udW07DQo+ID4gLQ0KPiA+ICAJLyogcmVnIG9mZnNldCAqLw0KPiA+ICAJdTMyIHZp
b19tYXNrX29mZnNldDsNCj4gPiAgCXUzMiB2aW9fc3RhX29mZnNldDsNCj4gPiBAQCAtNDksNiAr
NDYsNyBAQCBzdHJ1Y3QgbXRrX2RldmFwY19kYXRhIHsNCj4gPiAgc3RydWN0IG10a19kZXZhcGNf
Y29udGV4dCB7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ID4gIAl2b2lkIF9faW9tZW0g
KmluZnJhX2Jhc2U7DQo+ID4gKwl1MzIgdmlvX2lkeF9udW07DQo+IA0KPiBXZSBzaG91bGQgdHJ5
IHRvIHN0YXkgYmFja3dhcmRzIGNvbXBhdGlibGUgKG5ld2VyIGtlcm5lbCB3aXRoIG9sZGVyIERU
UykuIEkNCj4gdGhpbmsgd2UgZG9uJ3QgbmVlZCB0byBtb3ZlIHZpb19pZHhfbnVtIHRvIG10a19k
ZXZhcGNfY29udGV4dC4gSnVzdCBkb24ndA0KPiBkZWNsYXJlIGl0IGluIHRoZSBwZXIgU29DIG1h
dGNoIGRhdGEuIE1vcmUgZGV0YWlscyBzZWUgYmVsb3cuLi4NCj4gDQo+ID4gIAlzdHJ1Y3QgY2xr
ICppbmZyYV9jbGs7DQo+ID4gIAljb25zdCBzdHJ1Y3QgbXRrX2RldmFwY19kYXRhICpkYXRhOw0K
PiA+ICB9Ow0KPiA+IEBAIC02MCwxMCArNTgsMTAgQEAgc3RhdGljIHZvaWQgY2xlYXJfdmlvX3N0
YXR1cyhzdHJ1Y3QgbXRrX2RldmFwY19jb250ZXh0ICpjdHgpDQo+ID4gIA0KPiA+ICAJcmVnID0g
Y3R4LT5pbmZyYV9iYXNlICsgY3R4LT5kYXRhLT52aW9fc3RhX29mZnNldDsNCj4gPiAgDQo+ID4g
LQlmb3IgKGkgPSAwOyBpIDwgVklPX01PRF9UT19SRUdfSU5EKGN0eC0+ZGF0YS0+dmlvX2lkeF9u
dW0pIC0gMTsgaSsrKQ0KPiA+ICsJZm9yIChpID0gMDsgaSA8IFZJT19NT0RfVE9fUkVHX0lORChj
dHgtPnZpb19pZHhfbnVtIC0gMSk7IGkrKykNCj4gPiAgCQl3cml0ZWwoR0VOTUFTSygzMSwgMCks
IHJlZyArIDQgKiBpKTsNCj4gPiAgDQo+ID4gLQl3cml0ZWwoR0VOTUFTSyhWSU9fTU9EX1RPX1JF
R19PRkYoY3R4LT5kYXRhLT52aW9faWR4X251bSkgLSAxLCAwKSwNCj4gPiArCXdyaXRlbChHRU5N
QVNLKFZJT19NT0RfVE9fUkVHX09GRihjdHgtPnZpb19pZHhfbnVtIC0gMSksIDApLA0KPiA+ICAJ
ICAgICAgIHJlZyArIDQgKiBpKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiBAQCAtODAsMTUgKzc4LDE1
IEBAIHN0YXRpYyB2b2lkIG1hc2tfbW9kdWxlX2lycShzdHJ1Y3QgbXRrX2RldmFwY19jb250ZXh0
ICpjdHgsIGJvb2wgbWFzaykNCj4gPiAgCWVsc2UNCj4gPiAgCQl2YWwgPSAwOw0KPiA+ICANCj4g
PiAtCWZvciAoaSA9IDA7IGkgPCBWSU9fTU9EX1RPX1JFR19JTkQoY3R4LT5kYXRhLT52aW9faWR4
X251bSkgLSAxOyBpKyspDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgVklPX01PRF9UT19SRUdfSU5E
KGN0eC0+dmlvX2lkeF9udW0gLSAxKTsgaSsrKQ0KPiA+ICAJCXdyaXRlbCh2YWwsIHJlZyArIDQg
KiBpKTsNCj4gPiAgDQo+ID4gIAl2YWwgPSByZWFkbChyZWcgKyA0ICogaSk7DQo+ID4gIAlpZiAo
bWFzaykNCj4gPiAtCQl2YWwgfD0gR0VOTUFTSyhWSU9fTU9EX1RPX1JFR19PRkYoY3R4LT5kYXRh
LT52aW9faWR4X251bSkgLSAxLA0KPiA+ICsJCXZhbCB8PSBHRU5NQVNLKFZJT19NT0RfVE9fUkVH
X09GRihjdHgtPnZpb19pZHhfbnVtIC0gMSksDQo+ID4gIAkJCSAgICAgICAwKTsNCj4gPiAgCWVs
c2UNCj4gPiAtCQl2YWwgJj0gfkdFTk1BU0soVklPX01PRF9UT19SRUdfT0ZGKGN0eC0+ZGF0YS0+
dmlvX2lkeF9udW0pIC0gMSwNCj4gPiArCQl2YWwgJj0gfkdFTk1BU0soVklPX01PRF9UT19SRUdf
T0ZGKGN0eC0+dmlvX2lkeF9udW0gLSAxKSwNCj4gPiAgCQkJCTApOw0KPiA+ICANCj4gPiAgCXdy
aXRlbCh2YWwsIHJlZyArIDQgKiBpKTsNCj4gPiBAQCAtMjE2LDcgKzIxNCw2IEBAIHN0YXRpYyB2
b2lkIHN0b3BfZGV2YXBjKHN0cnVjdCBtdGtfZGV2YXBjX2NvbnRleHQgKmN0eCkNCj4gPiAgfQ0K
PiA+ICANCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZGV2YXBjX2RhdGEgZGV2YXBjX210
Njc3OSA9IHsNCj4gPiAtCS52aW9faWR4X251bSA9IDUxMSwNCj4gPiAgCS52aW9fbWFza19vZmZz
ZXQgPSAweDAsDQo+ID4gIAkudmlvX3N0YV9vZmZzZXQgPSAweDQwMCwNCj4gPiAgCS52aW9fZGJn
MF9vZmZzZXQgPSAweDkwMCwNCj4gPiBAQCAtMjU2LDYgKzI1Myw5IEBAIHN0YXRpYyBpbnQgbXRr
X2RldmFwY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJaWYgKCFj
dHgtPmluZnJhX2Jhc2UpDQo+ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gIA0KPiA+ICsJaWYg
KG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5vZGUsICJ2aW9faWR4X251bSIsICZjdHgtPnZpb19pZHhf
bnVtKSkNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+IA0KPiAuLi5vbmx5IHJlYWQg
dGhlIHByb3BlcnR5IGlmICB2aW9faWR4X251bSA9PSAwLg0KPiBXaGF0IGRvIHlvdSB0aGluaz8N
Cj4gDQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFzDQo+IA0KDQpHb29kIGlkZWEuIEkgd2lsbCBmaXgg
aXQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzDQoNCg0KPiA+ICAJZGV2YXBjX2lycSA9
IGlycV9vZl9wYXJzZV9hbmRfbWFwKG5vZGUsIDApOw0KPiA+ICAJaWYgKCFkZXZhcGNfaXJxKQ0K
PiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+IA0KDQo=

