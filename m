Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E5E307102
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhA1IOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:14:02 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:10159 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231267AbhA1II6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:08:58 -0500
X-UUID: 172936644968457cb39b00e4a6b166fc-20210128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=6CR30uPgSC0vGefHc+o3hW4Gm8WLXb0k3nn8teLGDfM=;
        b=LEzwaOyZpy1TvRWG8yNnKKQwg5KHPXYEOwgrTg5OKvbpN/Ln5HwyEvZGf/WqWIZQhnexubvY7J25qILnnQHwxkd592dX2D/S9wcD1LKU2HsChN2uuS/rQjV4yt7100/62pg0gYCTtRZxp/p/bS5//TwOGKsMT99tDKVrT9igGXA=;
X-UUID: 172936644968457cb39b00e4a6b166fc-20210128
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1695815952; Thu, 28 Jan 2021 16:07:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Jan 2021 16:07:13 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Jan 2021 16:07:13 +0800
Message-ID: <1611821233.18369.4.camel@mtksdaap41>
Subject: Re: [PATCH v11 7/9] drm/mediatek: enable dither function
From:   CK Hu <ck.hu@mediatek.com>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 28 Jan 2021 16:07:13 +0800
In-Reply-To: <1611820770.1947.8.camel@mhfsdcap03>
References: <20210128072802.830971-1-hsinyi@chromium.org>
         <20210128072802.830971-8-hsinyi@chromium.org>
         <1611819766.16091.4.camel@mtksdaap41> <1611820770.1947.8.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7125373E3B05CDB4A4B87CA844441DE521C7CB8D09FF63D4F85D2EC32626AA782000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTI4IGF0IDE1OjU5ICswODAwLCBZb25ncWlhbmcgTml1IHdyb3RlOg0K
PiBPbiBUaHUsIDIwMjEtMDEtMjggYXQgMTU6NDIgKzA4MDAsIENLIEh1IHdyb3RlOg0KPiA+IEhp
LCBIc2luLVlpOg0KPiA+IA0KPiA+IE9uIFRodSwgMjAyMS0wMS0yOCBhdCAxNToyOCArMDgwMCwg
SHNpbi1ZaSBXYW5nIHdyb3RlOg0KPiA+ID4gRnJvbTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5n
Lm5pdUBtZWRpYXRlay5jb20+DQo+ID4gPiANCj4gPiA+IGZvciA1IG9yIDYgYnBjIHBhbmVsLCB3
ZSBuZWVkIGVuYWJsZSBkaXRoZXIgZnVuY3Rpb24NCj4gPiA+IHRvIGltcHJvdmUgdGhlIGRpc3Bs
YXkgcXVhbGl0eQ0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5
b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEhzaW4tWWkg
V2FuZyA8aHNpbnlpQGNocm9taXVtLm9yZz4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgfCA0NCArKysrKysrKysrKysrKysrKysr
Ky0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fZGRwX2NvbXAuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9j
b21wLmMNCj4gPiA+IGluZGV4IDgxNzNmNzA5MjcyYmUuLmU4NTYyNTcwNGQ2MTEgMTAwNjQ0DQo+
ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+
ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+
ID4gPiBAQCAtNTMsNyArNTMsOSBAQA0KPiA+ID4gICNkZWZpbmUgRElUSEVSX0VOCQkJCUJJVCgw
KQ0KPiA+ID4gICNkZWZpbmUgRElTUF9ESVRIRVJfQ0ZHCQkJCTB4MDAyMA0KPiA+ID4gICNkZWZp
bmUgRElUSEVSX1JFTEFZX01PREUJCQlCSVQoMCkNCj4gPiA+ICsjZGVmaW5lIERJVEhFUl9FTkdJ
TkVfRU4JCQlCSVQoMSkNCj4gPiA+ICAjZGVmaW5lIERJU1BfRElUSEVSX1NJWkUJCQkweDAwMzAN
Cj4gPiA+ICsjZGVmaW5lIERJVEhFUl9SRUcoaWR4KQkJCQkoMHgxMDAgKyAoaWR4KSAqIDQpDQo+
ID4gPiAgDQo+ID4gPiAgI2RlZmluZSBMVVRfMTBCSVRfTUFTSwkJCQkweDAzZmYNCj4gPiA+ICAN
Cj4gPiA+IEBAIC0zMTMsOCArMzE1LDQ4IEBAIHN0YXRpYyB2b2lkIG10a19kaXRoZXJfY29uZmln
KHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcsDQo+ID4gPiAgew0KPiA+ID4gIAlz
dHJ1Y3QgbXRrX2RkcF9jb21wX2RldiAqcHJpdiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+
ID4gIA0KPiA+ID4gKwlib29sIGVuYWJsZSA9IGZhbHNlOw0KPiA+ID4gKw0KPiA+ID4gKwkvKiBk
ZWZhdWx0IHZhbHVlIGZvciBkaXRoZXIgcmVnIDUgdG8gMTQgKi8NCj4gPiA+ICsJY29uc3QgdTMy
IGRpdGhlcl9zZXR0aW5nW10gPSB7DQo+ID4gPiArCQkweDAwMDAwMDAwLCAvKiA1ICovDQo+ID4g
PiArCQkweDAwMDAzMDAyLCAvKiA2ICovDQo+ID4gPiArCQkweDAwMDAwMDAwLCAvKiA3ICovDQo+
ID4gPiArCQkweDAwMDAwMDAwLCAvKiA4ICovDQo+ID4gPiArCQkweDAwMDAwMDAwLCAvKiA5ICov
DQo+ID4gPiArCQkweDAwMDAwMDAwLCAvKiAxMCAqLw0KPiA+ID4gKwkJMHgwMDAwMDAwMCwgLyog
MTEgKi8NCj4gPiA+ICsJCTB4MDAwMDAwMTEsIC8qIDEyICovDQo+ID4gPiArCQkweDAwMDAwMDAw
LCAvKiAxMyAqLw0KPiA+ID4gKwkJMHgwMDAwMDAwMCwgLyogMTQgKi8NCj4gPiANCj4gPiBDb3Vs
ZCB5b3UgZXhwbGFpbiB3aGF0IGlzIHRoaXM/DQo+IA0KPiB0aGlzIGlzIGRpdGhlciA1IHRvIGRp
dGhlciAxNCBzZXR0aW5nDQo+IHRoaXMgd2lsbCBiZSB1c2VsZXNzLCB3ZSBqdXN0IG5lZWQgc2V0
IGRpdGhlciA1IGFuZCBkaXRoZXIgNyBsaWtlIA0KPiBtdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCAw
LCBjb21wLCBESVNQX0RJVEhFUl81KTsNCj4gbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgMCwgY29t
cCwgRElTUF9ESVRIRVJfNyk7DQo+IG90aGVyIHZhbHVlIGlzIHNhbWUgd2l0aCBoYXJkd2FyZSBk
ZWZhdWx0IHZhbHVlLg0KPiANCj4gDQo+ID4gDQo+ID4gPiArCX07DQo+ID4gPiArDQo+ID4gPiAr
CWlmIChicGMgPT0gNSB8fCBicGMgPT0gNikgew0KPiA+ID4gKwkJZW5hYmxlID0gdHJ1ZTsNCj4g
PiA+ICsJCW10a19kZHBfd3JpdGUoY21kcV9wa3QsDQo+ID4gPiArCQkJICAgICAgRElUSEVSX0xT
Ql9FUlJfU0hJRlRfUihNVEtfTUFYX0JQQyAtIGJwYykgfA0KPiA+ID4gKwkJCSAgICAgIERJVEhF
Ul9BRERfTFNISUZUX1IoTVRLX01BWF9CUEMgLSBicGMpIHwNCj4gPiA+ICsJCQkgICAgICBESVRI
RVJfTkVXX0JJVF9NT0RFLA0KPiA+ID4gKwkJCSAgICAgICZwcml2LT5jbWRxX3JlZywgcHJpdi0+
cmVncywgRElUSEVSX1JFRygxNSkpOw0KPiA+ID4gKwkJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwN
Cj4gPiA+ICsJCQkgICAgICBESVRIRVJfTFNCX0VSUl9TSElGVF9CKE1US19NQVhfQlBDIC0gYnBj
KSB8DQo+ID4gPiArCQkJICAgICAgRElUSEVSX0FERF9MU0hJRlRfQihNVEtfTUFYX0JQQyAtIGJw
YykgfA0KPiA+ID4gKwkJCSAgICAgIERJVEhFUl9MU0JfRVJSX1NISUZUX0coTVRLX01BWF9CUEMg
LSBicGMpIHwNCj4gPiA+ICsJCQkgICAgICBESVRIRVJfQUREX0xTSElGVF9HKE1US19NQVhfQlBD
IC0gYnBjKSwNCj4gPiANCj4gPiBUaGlzIHJlc3VsdCBpbiAweDUwNTA1MDUwLCBidXQgcHJldmlv
dXMgdmVyc2lvbiBpcyAweDUwNTA0MDQwLCBzbyB0aGlzDQo+ID4gdmVyc2lvbiBpcyBjb3JyZWN0
IGFuZCBwcmV2aW91cyB2ZXJzaW9uIGlzIGluY29ycmVjdD8NCj4gDQo+IHRoZSBuZXcgdmVyc2lv
biBzZXQgciBnIGIgMyBjaGFubmVsIHNhbWUsIHNlYW1zIG1vcmUgcmVhc29uYWJsZQ0KPiANCj4g
DQoNClNvIGFsbCB0aGUgc2V0dGluZyBvZiBESVNQX0RJVEhFUl81LCBESVNQX0RJVEhFUl83LCBE
SVNQX0RJVEhFUl8xNSwNCkRJU1BfRElUSEVSXzE2IGlzIGlkZW50aWNhbCB0byBtdGtfZGl0aGVy
X3NldCgpLCBzbyBjYWxsDQptdGtfZGl0aGVyX3NldCgpIGluc3RlYWQgb2YgZHVwbGljYXRpb24g
aGVyZS4NCg0KUmVnYXJkcywNCkNLDQo+ID4gDQo+ID4gUmVnYXJkcywNCj4gPiBDSw0KPiA+IA0K
PiA+ID4gKwkJCSAgICAgICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywgRElUSEVSX1JFRygx
NikpOw0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiArDQo+ID4gPiArCWlmIChlbmFibGUpIHsN
Cj4gPiA+ICsJCXUzMiBpZHg7DQo+ID4gPiArDQo+ID4gPiArCQlmb3IgKGlkeCA9IDA7IGlkeCA8
IEFSUkFZX1NJWkUoZGl0aGVyX3NldHRpbmcpOyBpZHgrKykNCj4gPiA+ICsJCQltdGtfZGRwX3dy
aXRlKGNtZHFfcGt0LCBkaXRoZXJfc2V0dGluZ1tpZHhdLCAmcHJpdi0+Y21kcV9yZWcsIHByaXYt
PnJlZ3MsDQo+ID4gPiArCQkJCSAgICAgIERJVEhFUl9SRUcoaWR4ICsgNSkpOw0KPiA+ID4gKwl9
DQo+ID4gPiArDQo+ID4gPiAgCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIGggPDwgMTYgfCB3LCAm
cHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsIERJU1BfRElUSEVSX1NJWkUpOw0KPiA+ID4gLQlt
dGtfZGRwX3dyaXRlKGNtZHFfcGt0LCBESVRIRVJfUkVMQVlfTU9ERSwgJnByaXYtPmNtZHFfcmVn
LCBwcml2LT5yZWdzLCBESVNQX0RJVEhFUl9DRkcpOw0KPiA+ID4gKyAgICAgICAgbXRrX2RkcF93
cml0ZShjbWRxX3BrdCwgZW5hYmxlID8gRElUSEVSX0VOR0lORV9FTiA6IERJVEhFUl9SRUxBWV9N
T0RFLCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsIERJU1BfRElUSEVSX0NGRyk7DQo+ID4g
PiAgfQ0KPiA+ID4gIA0KPiA+ID4gIHN0YXRpYyB2b2lkIG10a19kaXRoZXJfc3RhcnQoc3RydWN0
IGRldmljZSAqZGV2KQ0KPiA+IA0KPiA+IA0KPiANCj4gDQoNCg==

