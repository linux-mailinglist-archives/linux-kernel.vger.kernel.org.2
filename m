Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7BD357C26
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 08:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhDHGJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 02:09:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45282 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229534AbhDHGJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 02:09:50 -0400
X-UUID: 8d8b8fd3c0cf4307ba5ed5db2872e22e-20210408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=EJEGrtJeH59qQNQHwYtSxuFXpFKOfiBvVZE4IMKw+UI=;
        b=UsTCpPMvfYiOkL2VHzgv6WKbUAMQH6RFhyRvvqDhgiIv6Bi/AAMMH4w3EqIS6isiMjpthY8Ed+UtZ4MxUoiOsqDQBMq5m5P+KCfHesA8/ndodQtV4/QUBrVyxm1TD1FT1A6TVbnxWEgRHG8rZMeQ+0uyq+lVubnCnF50C22Ki5Q=;
X-UUID: 8d8b8fd3c0cf4307ba5ed5db2872e22e-20210408
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1071343655; Thu, 08 Apr 2021 14:09:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 8 Apr 2021 14:09:28 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Apr 2021 14:09:28 +0800
Message-ID: <1617862168.8874.13.camel@mtksdccf07>
Subject: Re: [PATCH v2 5/6] soc: mediatek: devapc: add debug register for
 new IC support
From:   Nina Wu <nina-cm.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <Jackson-kt.Chang@mediatek.com>
Date:   Thu, 8 Apr 2021 14:09:28 +0800
In-Reply-To: <23c0d15c-6cc2-dc40-e45a-c2fb749cec1f@gmail.com>
References: <1617259087-5502-1-git-send-email-nina-cm.wu@mediatek.com>
         <1617259087-5502-5-git-send-email-nina-cm.wu@mediatek.com>
         <23c0d15c-6cc2-dc40-e45a-c2fb749cec1f@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7CAFF274F06E74740FF1A0901266ECC9C36F1710CE7BB4806B874DD48507ED1D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hdHRoaWFzDQoNCk9uIFR1ZSwgMjAyMS0wNC0wNiBhdCAxNTo1MyArMDIwMCwgTWF0dGhp
YXMgQnJ1Z2dlciB3cm90ZToNCj4gDQo+IE9uIDAxLzA0LzIwMjEgMDg6MzgsIE5pbmEgV3Ugd3Jv
dGU6DQo+ID4gRnJvbTogTmluYSBXdSA8TmluYS1DTS5XdUBtZWRpYXRlay5jb20+DQo+ID4gDQo+
ID4gVGhlcmUgYXJlIDMgZGVidWcgaW5mbyByZWdpc3RlcnMgaW4gbmV3IElDcyB3aGlsZSBpbiBs
ZWdhY3kgb25lcywNCj4gPiB3ZSBoYXZlIG9ubHkgMi4gV2hlbiBkdW1waW5nIHRoZSBkZWJ1ZyBp
bmZvLCB3ZSBuZWVkIHRvIGNoZWNrIGZpcnN0DQo+ID4gaWYgdGhlIDNyZCBkZWJ1ZyByZWdpc3Rl
ciBleGlzdHMgYW5kIHRoZW4gd2UgY2FuIGtvbncgaG93IHRvIGRlY2lwaGVyDQo+ID4gdGhlIGRl
YnVnIGluZm8uDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTmluYSBXdSA8TmluYS1DTS5XdUBt
ZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvc29jL21lZGlhdGVrL210ay1kZXZh
cGMuYyB8IDMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1kZXZhcGMuYyBiL2RyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1kZXZhcGMuYw0KPiA+IGluZGV4IGJjZjZlM2MuLmFmNTVjMDEgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWRldmFwYy5jDQo+ID4gKysrIGIvZHJp
dmVycy9zb2MvbWVkaWF0ZWsvbXRrLWRldmFwYy5jDQo+ID4gQEAgLTI2LDkgKzI2LDE5IEBAIHN0
cnVjdCBtdGtfZGV2YXBjX3Zpb19kYmdzIHsNCj4gPiAgCQkJdTMyIGFkZHJfaDo0Ow0KPiA+ICAJ
CQl1MzIgcmVzdjo0Ow0KPiA+ICAJCX0gZGJnMF9iaXRzOw0KPiA+ICsNCj4gPiArCQkvKiBOb3Qg
dXNlZCwgcmVmZXJlbmNlIG9ubHkgKi8NCj4gPiArCQlzdHJ1Y3Qgew0KPiA+ICsJCQl1MzIgZG1u
aWQ6NjsNCj4gPiArCQkJdTMyIHZpb193OjE7DQo+ID4gKwkJCXUzMiB2aW9fcjoxOw0KPiA+ICsJ
CQl1MzIgYWRkcl9oOjQ7DQo+ID4gKwkJCXUzMiByZXN2OjIwOw0KPiA+ICsJCX0gZGJnMF9iaXRz
X3ZlcjI7DQo+ID4gIAl9Ow0KPiA+ICANCj4gPiAgCXUzMiB2aW9fZGJnMTsNCj4gPiArCXUzMiB2
aW9fZGJnMjsNCj4gPiAgfTsNCj4gPiAgDQo+ID4gIHN0cnVjdCBtdGtfZGV2YXBjX2RhdGEgew0K
PiA+IEBAIC0zNyw2ICs0Nyw3IEBAIHN0cnVjdCBtdGtfZGV2YXBjX2RhdGEgew0KPiA+ICAJdTMy
IHZpb19zdGFfb2Zmc2V0Ow0KPiA+ICAJdTMyIHZpb19kYmcwX29mZnNldDsNCj4gPiAgCXUzMiB2
aW9fZGJnMV9vZmZzZXQ7DQo+ID4gKwl1MzIgdmlvX2RiZzJfb2Zmc2V0Ow0KPiA+ICAJdTMyIGFw
Y19jb25fb2Zmc2V0Ow0KPiA+ICAJdTMyIHZpb19zaGlmdF9zdGFfb2Zmc2V0Ow0KPiA+ICAJdTMy
IHZpb19zaGlmdF9zZWxfb2Zmc2V0Ow0KPiA+IEBAIC0xNTgsMTIgKzE2OSwyOSBAQCBzdGF0aWMg
dm9pZCBkZXZhcGNfZXh0cmFjdF92aW9fZGJnKHN0cnVjdCBtdGtfZGV2YXBjX2NvbnRleHQgKmN0
eCkNCj4gPiAgCXN0cnVjdCBtdGtfZGV2YXBjX3Zpb19kYmdzIHZpb19kYmdzOw0KPiA+ICAJdm9p
ZCBfX2lvbWVtICp2aW9fZGJnMF9yZWc7DQo+ID4gIAl2b2lkIF9faW9tZW0gKnZpb19kYmcxX3Jl
ZzsNCj4gPiArCXZvaWQgX19pb21lbSAqdmlvX2RiZzJfcmVnOw0KPiA+ICsJdTMyIHZpb19hZGRy
LCBidXNfaWQ7DQo+ID4gIA0KPiA+ICAJdmlvX2RiZzBfcmVnID0gY3R4LT5iYXNlICsgY3R4LT5k
YXRhLT52aW9fZGJnMF9vZmZzZXQ7DQo+ID4gIAl2aW9fZGJnMV9yZWcgPSBjdHgtPmJhc2UgKyBj
dHgtPmRhdGEtPnZpb19kYmcxX29mZnNldDsNCj4gPiArCXZpb19kYmcyX3JlZyA9IGN0eC0+YmFz
ZSArIGN0eC0+ZGF0YS0+dmlvX2RiZzJfb2Zmc2V0Ow0KPiANCj4gV2Ugc2hvdWxkIHJlYWQgdGhp
cyBvbmx5IGlmIHdlIGhhdmUgdmVyc2lvbjIgb2YgdGhlIGRldmFwYy4NCj4gDQoNCllvdSdyZSBy
aWdodC4NCkl0IGlzIG5vdCBnb29kIHRvIHJlYWQgdmlvX2RiZzJfcmVnIGluIHZlcnNpb24gb25l
LiBFdmVuIHRob3VnaCB3ZSB3aWxsDQpvbmx5IGdldCB0aGUgdmFsdWUgZnJvbSBvZmZzZXQgMCAo
d2hpY2ggaXMgbm90IGV4cGVjdGVkKSBpbnN0ZWFkIG9mDQpkb2luZyBhbnkgcmVhbCBoYXJtLiAo
bGlrZSBjYXVzaW5nIGJ1cyBoYW5nKQ0KDQoNCj4gPiAgDQo+ID4gIAl2aW9fZGJncy52aW9fZGJn
MCA9IHJlYWRsKHZpb19kYmcwX3JlZyk7DQo+ID4gIAl2aW9fZGJncy52aW9fZGJnMSA9IHJlYWRs
KHZpb19kYmcxX3JlZyk7DQo+ID4gKwl2aW9fZGJncy52aW9fZGJnMiA9IHJlYWRsKHZpb19kYmcy
X3JlZyk7DQo+ID4gKw0KPiA+ICsJaWYgKCFjdHgtPmRhdGEtPnZpb19kYmcyX29mZnNldCkgew0K
PiANCj4gSSB0aGluayB3ZSBzaG91bGQgYWRkIGEgdmVyc2lvbiBmaWVsZCB0byBtdGtfZGV2YXBj
X2RhdGEgdG8gZGlzdGluZ3Vpc2ggdGhlIHR3bw0KPiBvZiB0aGVtLg0KDQpPSy4NCkkgd2lsbCB0
cnkgdG8gYWRkIHRoaXMgZmllbGQgaW4gdGhlIG5leHQgdmVyc2lvbg0KDQo+IA0KPiA+ICsJCS8q
IGFyY2ggdmVyc2lvbiAxICovDQo+ID4gKwkJYnVzX2lkID0gdmlvX2RiZ3MuZGJnMF9iaXRzLm1z
dGlkOw0KPiA+ICsJCXZpb19hZGRyID0gdmlvX2RiZ3MudmlvX2RiZzE7DQo+ID4gKwl9IGVsc2Ug
ew0KPiA+ICsJCS8qIGFyY2ggdmVyc2lvbiAyICovDQo+ID4gKwkJYnVzX2lkID0gdmlvX2RiZ3Mu
dmlvX2RiZzE7DQo+ID4gKwkJdmlvX2FkZHIgPSB2aW9fZGJncy52aW9fZGJnMjsNCj4gPiArDQo+
ID4gKwkJLyogVG8gYWxpZ24gd2l0aCB0aGUgYml0IGRlZmluaXRpb24gb2YgYXJjaF92ZXIgMSAq
Lw0KPiA+ICsJCXZpb19kYmdzLnZpb19kYmcwID0gKHZpb19kYmdzLnZpb19kYmcwIDw8IDE2KTsN
Cj4gDQo+IFRoYXQncyBtYWdpYywgYmV0dGVyIGFkZCBhbm90aGVyIHZhcmlhYmxlIGRvbWFpbl9p
ZCBhbmQgZG8gaGVyZToNCj4gZG9tYWluX2lkID0gdmlvX2RnYnMuZGJnMF9iaXRzX3ZlcjIuZG1u
aWQ7DQo+IA0KDQpPSy4NCkkgd2lsbCBmaXggaXQgdXAgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0K
VGhhbmtzDQoNCj4gPiArCX0NCj4gPiAgDQo+ID4gIAkvKiBQcmludCB2aW9sYXRpb24gaW5mb3Jt
YXRpb24gKi8NCj4gPiAgCWlmICh2aW9fZGJncy5kYmcwX2JpdHMudmlvX3cpDQo+ID4gQEAgLTE3
Miw4ICsyMDAsNyBAQCBzdGF0aWMgdm9pZCBkZXZhcGNfZXh0cmFjdF92aW9fZGJnKHN0cnVjdCBt
dGtfZGV2YXBjX2NvbnRleHQgKmN0eCkNCj4gPiAgCQlkZXZfaW5mbyhjdHgtPmRldiwgIlJlYWQg
VmlvbGF0aW9uXG4iKTsNCj4gPiAgDQo+ID4gIAlkZXZfaW5mbyhjdHgtPmRldiwgIkJ1cyBJRDow
eCV4LCBEb20gSUQ6MHgleCwgVmlvIEFkZHI6MHgleFxuIiwNCj4gPiAtCQkgdmlvX2RiZ3MuZGJn
MF9iaXRzLm1zdGlkLCB2aW9fZGJncy5kYmcwX2JpdHMuZG1uaWQsDQo+ID4gLQkJIHZpb19kYmdz
LnZpb19kYmcxKTsNCj4gPiArCQkgYnVzX2lkLCB2aW9fZGJncy5kYmcwX2JpdHMuZG1uaWQsIHZp
b19hZGRyKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgLyoNCj4gPiANCg0K

