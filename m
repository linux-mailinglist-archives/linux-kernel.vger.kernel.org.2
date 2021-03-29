Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B6534C232
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 05:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhC2DX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 23:23:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48975 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229861AbhC2DWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 23:22:49 -0400
X-UUID: 293a5fa709164a81af83d3dda8597568-20210329
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=S7e6/7OOnIOS0svOawoNSqRYHZwfkX/E2FkAsDNvQJg=;
        b=JtMQEuBF0bmIh4zlb2xUrI/IbCrqbLVD/fTwE/Ggb5y6Ocy0b5w+YGauYRj7+c/A3nRTa62WNrFYZyyjRoHTLPvWNGiLdPTBrrxKdSRKniCbBkUQdtMT5CHccTHAKbl7xs370C9OuQ8Vz7DbikC1398rTyiEkBnidxiHYrQicss=;
X-UUID: 293a5fa709164a81af83d3dda8597568-20210329
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1183461133; Mon, 29 Mar 2021 11:22:44 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 29 Mar 2021 11:22:42 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 29 Mar 2021 11:22:42 +0800
Message-ID: <1616988162.26412.32.camel@mtksdccf07>
Subject: Re: [PATCH 1/2] dt-bindings: devapc: Update bindings
From:   Nina Wu <nina-cm.wu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <Jackson-kt.Chang@mediatek.com>,
        <nina-cm.wu@mediatek.com>
Date:   Mon, 29 Mar 2021 11:22:42 +0800
In-Reply-To: <20210326195802.GA3761703@robh.at.kernel.org>
References: <1616743871-8087-1-git-send-email-nina-cm.wu@mediatek.com>
         <20210326195802.GA3761703@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B841F752D2FA1811A4B02DAD58ECC1AD0F980378278587B19E66D9AA2158CFD92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYg0KDQoNCk9uIEZyaSwgMjAyMS0wMy0yNiBhdCAxMzo1OCAtMDYwMCwgUm9iIEhlcnJp
bmcgd3JvdGU6DQo+IE9uIEZyaSwgTWFyIDI2LCAyMDIxIGF0IDAzOjMxOjEwUE0gKzA4MDAsIE5p
bmEgV3Ugd3JvdGU6DQo+ID4gRnJvbTogTmluYSBXdSA8TmluYS1DTS5XdUBtZWRpYXRlay5jb20+
DQo+ID4gDQo+ID4gVG8gc3VwcG9ydCBuZXdlciBoYXJkd2FyZSBhcmNoaXRlY3R1cmUgb2YgZGV2
YXBjLA0KPiA+IHVwZGF0ZSBkZXZpY2UgdHJlZSBiaW5kaW5ncy4NCj4gPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBOaW5hIFd1IDxOaW5hLUNNLld1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAg
Li4uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy55YW1sICAgfCA0MSAr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0MSBpbnNlcnRpb25z
KCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9zb2MvbWVkaWF0ZWsvZGV2YXBjLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc29jL21lZGlhdGVrL2RldmFwYy55YW1sDQo+ID4gaW5kZXggMzFlNGQzYy4uNDg5
ZjZhOSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c29jL21lZGlhdGVrL2RldmFwYy55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kZXZhcGMueWFtbA0KPiA+IEBAIC0yMCw5ICsyMCwy
NyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgIGNvbXBhdGlibGU6DQo+ID4gICAgICBlbnVtOg0KPiA+
ICAgICAgICAtIG1lZGlhdGVrLG10Njc3OS1kZXZhcGMNCj4gPiArICAgICAgLSBtZWRpYXRlayxt
dDgxOTItZGV2YXBjDQo+ID4gKw0KPiA+ICsgIHZlcnNpb246DQo+ID4gKyAgICBkZXNjcmlwdGlv
bjogVGhlIHZlcnNpb24gb2YgdGhlIGhhcmR3YXJlIGFyY2hpdGVjdHVyZQ0KPiANCj4gVGhpcyBz
aG91bGQgYmUgaW1wbGllZCBieSB0aGUgY29tcGF0aWJsZSBzdHJpbmcuDQoNClRoZSB2ZXJzaW9u
IGF0dHJpYnV0ZSBpcyB1c2VkIHRvIGRlY2lkZSBob3cgd2UgaW50ZXJwcmV0IHRoZSBkZWJ1ZyBp
bmZvDQpnb3QgZnJvbSByZWdpc3RlcnMuDQpBcyB5b3UgbWVudGlvbmVkLCB3ZSBjYW4ga25vdyB0
aGUgdmVyc2lvbiBvZiB0aGUgYXJjaGl0ZWN0dXJlIGZyb20gdGhlDQpjb21wYXRpYmxlLCBidXQg
SSB0aGluayB0aGVyZSB3aWxsIGJlIGNvZGUgbGlrZSB0aGlzOg0KDQppZiAoY29tcGF0aWJsZSBp
cyBtdDY3NzkpIHZlcnNpb24gPSAxDQplbHNlIGlmIChjb21wYXRpYmxlIGlzIG10ODE5MikgdmVy
c2lvbiA9IDINCg0KQW5kIG9uY2Ugd2UgaGF2ZSBtb3JlIGNoaXBzIHRvIHN1cHBvcnQsIHRoZSBj
b2RlIHdpbGwgYmUgcXVpdGUgbG9uZy4NClNvIEkgcHJlZmVyIHRvIGFkZCBhICd2ZXJzaW9uJyBo
ZXJlLg0KDQoNCj4gDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0
aW9ucy91aW50MzINCj4gPiArICAgIGVudW06IFsxLCAyXQ0KPiA+ICsgICAgbWF4SXRlbXM6IDEN
Cj4gPiArDQo+ID4gKyAgc2xhdmVfdHlwZV9udW06DQo+IA0KPiB2ZW5kb3IgcHJlZml4IG5lZWRl
ZCBhbmQgcy9fLy0vDQoNCkkgd2lsbCBmaXhlZCBpbiBuZXh0IHZlcnNpb24uDQoNCj4gDQo+ID4g
KyAgICBkZXNjcmlwdGlvbjogVGhlIG51bWJlciBvZiB0aGUgZGV2YXBjIHNldA0KPiANCj4gV2hh
dD8NCg0KRm9yIG10ODE5MiwgdGhlcmUgYXJlIG11bHRpcGxlIHBpZWNlcyBvZiBkZXZhcGMgSFcg
Zm9yIGRpZmZlcmVudCBzdWJzeXMuDQpFWDogaW5mcmEgZGV2YXBjLCBwZXJpIGRldmFwYywgZXRj
Lg0KJ3NsYXZlX3R5cGVfbnVtJyBpcyB0aGUgdG90YWwgbnVtYmVyIG9mIHRoZSBkZXZhcGMgSFcu
DQpJIGNhbm5vdCBjb21lIHVwIHdpdGggYW4gYWNjdXJhdGUgZGVzY3JpcHRpb24sIHRob3VnaC4N
Cg0KDQo+IA0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMv
dWludDMyDQo+ID4gKyAgICBlbnVtOiBbMSwgNF0NCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4g
IA0KPiA+ICAgIHJlZzoNCj4gPiAgICAgIGRlc2NyaXB0aW9uOiBUaGUgYmFzZSBhZGRyZXNzIG9m
IGRldmFwYyByZWdpc3RlciBiYW5rDQo+ID4gKyAgICBtYXhJdGVtczogNA0KPiANCj4gTmVlZCB0
byBkZWZpbmUgd2hhdCBlYWNoIHJlZ2lvbiBpcy4NCg0KSSB3aWxsIGZpeCBpdCBpbiB0aGUgbmV4
dCB2ZXJzaW9uLg0KDQo+IA0KPiA+ICsNCj4gPiArICB2aW9faWR4X251bToNCj4gDQo+IHZlbmRv
ciBwcmVmaXggbmVlZGVkIGFuZCBzL18vLS8NCg0KT0ssIHdpbGwgYmUgZml4ZWQgaW4gdGhlIG5l
eHQgdmVyc2lvbi4NCg0KPiANCj4gPiArICAgIGRlc2NyaXB0aW9uOiBUaGUgbnVtYmVyIG9mIHRo
ZSBkZXZpY2VzIGNvbnRyb2xsZWQgYnkgZGV2YXBjDQo+IA0KPiBObyBuZWVkIHRvIGtub3cgd2hp
Y2ggZGV2aWNlcz8NCg0KeWVzLCB0aGUgY3VycmVudCBkcml2ZXIgZG9lcyBub3QgY2FyZSBlYWNo
IG9mIHRoZW0uDQoNCj4gDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZp
bml0aW9ucy91aW50MzItYXJyYXkNCj4gPiAgICAgIG1heEl0ZW1zOiAxDQo+IA0KPiB1aW50MzIt
YXJyYXkgd2l0aCAnbWF4SXRlbXM6IDEnIGlzIGp1c3QgJ3VpbnQzMicNCj4gDQoNCmdvdCBpdCwg
c28gaXQgc2hvdWxkIGJlICdtYXhJdGVtczogNCcNCg0KPiA+ICANCj4gPiAgICBpbnRlcnJ1cHRz
Og0KPiA+IEBAIC0zOSw3ICs1NywxMCBAQCBwcm9wZXJ0aWVzOg0KPiA+ICANCj4gPiAgcmVxdWly
ZWQ6DQo+ID4gICAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSB2ZXJzaW9uDQo+ID4gKyAgLSBzbGF2
ZV90eXBlX251bQ0KPiA+ICAgIC0gcmVnDQo+ID4gKyAgLSB2aW9faWR4X251bQ0KPiA+ICAgIC0g
aW50ZXJydXB0cw0KPiA+ICAgIC0gY2xvY2tzDQo+ID4gICAgLSBjbG9jay1uYW1lcw0KPiA+IEBA
IC01Myw4ICs3NCwyOCBAQCBleGFtcGxlczoNCj4gPiAgDQo+ID4gICAgICBkZXZhcGM6IGRldmFw
Y0AxMDIwNzAwMCB7DQo+ID4gICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Nzc5LWRl
dmFwYyI7DQo+ID4gKyAgICAgIHZlcnNpb24gPSA8MT47DQo+ID4gKyAgICAgIHNsYXZlX3R5cGVf
bnVtID0gPDE+Ow0KPiA+ICAgICAgICByZWcgPSA8MHgxMDIwNzAwMCAweDEwMDA+Ow0KPiA+ICsg
ICAgICB2aW9faWR4X251bSA9IDw1MTE+Ow0KPiA+ICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19T
UEkgMTY4IElSUV9UWVBFX0xFVkVMX0xPVz47DQo+ID4gICAgICAgIGNsb2NrcyA9IDwmaW5mcmFj
ZmdfYW8gQ0xLX0lORlJBX0RFVklDRV9BUEM+Ow0KPiA+ICAgICAgICBjbG9jay1uYW1lcyA9ICJk
ZXZhcGMtaW5mcmEtY2xvY2siOw0KPiA+ICAgICAgfTsNCj4gPiArICAtIHwNCj4gPiArICAgICNp
bmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4g
KyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTkyLWNsay5oPg0KPiA+ICsNCj4g
PiArICAgIGRldmFwYzogZGV2YXBjQDEwMjA3MDAwIHsNCj4gPiArICAgICAgICBjb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE5Mi1kZXZhcGMiOw0KPiA+ICsgICAgICAgIHZlcnNpb24gPSA8Mj47
DQo+ID4gKyAgICAgICAgc2xhdmVfdHlwZV9udW0gPSA8ND47DQo+ID4gKyAgICAgICAgcmVnID0g
PDAgMHgxMDIwNzAwMCAwIDB4MTAwMD4sDQo+ID4gKyAgICAgICAgICAgIDwwIDB4MTAyNzQwMDAg
MCAweDEwMDA+LA0KPiA+ICsgICAgICAgICAgICA8MCAweDEwMjc1MDAwIDAgMHgxMDAwPiwNCj4g
PiArICAgICAgICAgICAgPDAgMHgxMTAyMDAwMCAwIDB4MTAwMD47DQo+ID4gKyAgICAgICAgdmlv
X2lkeF9udW0gPSA8MzY3IDI5MiAyNDIgNTg+Ow0KPiANCj4gSXMgdGhlIGxlbmd0aCBvZiB0aGlz
IHRoZSBzYW1lIGFzIHRoZSB2YWx1ZSBvZiBzbGF2ZV90eXBlX251bT8gSWYgc28sIA0KPiBkb24n
dCBuZWVkIGJvdGguDQo+IA0KDQp5ZXMsIHRoZSBsZW5ndGggaXMgZXF1YWwgdG8gc2xhdmVfdHlw
ZV9udW0uDQpJIHdpbGwgdHJ5IHRvIHJlbW92ZSBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+
ID4gKyAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDE4NyBJUlFfVFlQRV9MRVZFTF9ISUdI
PjsNCj4gPiArICAgICAgICBjbG9ja3MgPSA8JmluZnJhY2ZnX2FvIENMS19JTkZSQV9ERVZJQ0Vf
QVBDPjsNCj4gPiArICAgICAgICBjbG9jay1uYW1lcyA9ICJkZXZhcGMtaW5mcmEtY2xvY2siOw0K
PiA+ICsgICAgfTsNCj4gPiAtLSANCj4gPiAyLjYuNA0KPiA+IA0KDQo=

