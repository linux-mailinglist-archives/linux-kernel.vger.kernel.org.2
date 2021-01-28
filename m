Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AD93070AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhA1IEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:04:51 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55386 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232084AbhA1IA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:00:27 -0500
X-UUID: fd93b3983dec4240893c9cb6e9998f5d-20210128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=Lnc8VT2CriWR+GAsibOY7CQsw0NvPhbAaREGs5DpoNM=;
        b=QC37+pYMS9/C3qu9t8OFP+j+D99Py4zh4CuXEdwEdIfbOQyEOV3UkLzxCjcD5EbqcWXqX6gUyY27ykQImFI1S44MpMcBjiO9mRQSuoW6YPMNTy2Do+gUVAMUF68OA/ErRqavtaU4EQfqbp518RIh4/Hn14JWTYn4eRxYguv0YAM=;
X-UUID: fd93b3983dec4240893c9cb6e9998f5d-20210128
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1256122777; Thu, 28 Jan 2021 15:59:34 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs05n1.mediatek.inc
 (172.21.101.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 28 Jan
 2021 15:59:32 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Jan 2021 15:59:30 +0800
Message-ID: <1611820770.1947.8.camel@mhfsdcap03>
Subject: Re: [PATCH v11 7/9] drm/mediatek: enable dither function
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 28 Jan 2021 15:59:30 +0800
In-Reply-To: <1611819766.16091.4.camel@mtksdaap41>
References: <20210128072802.830971-1-hsinyi@chromium.org>
         <20210128072802.830971-8-hsinyi@chromium.org>
         <1611819766.16091.4.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTI4IGF0IDE1OjQyICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIEhz
aW4tWWk6DQo+IA0KPiBPbiBUaHUsIDIwMjEtMDEtMjggYXQgMTU6MjggKzA4MDAsIEhzaW4tWWkg
V2FuZyB3cm90ZToNCj4gPiBGcm9tOiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlh
dGVrLmNvbT4NCj4gPiANCj4gPiBmb3IgNSBvciA2IGJwYyBwYW5lbCwgd2UgbmVlZCBlbmFibGUg
ZGl0aGVyIGZ1bmN0aW9uDQo+ID4gdG8gaW1wcm92ZSB0aGUgZGlzcGxheSBxdWFsaXR5DQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRpYXRl
ay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSHNpbi1ZaSBXYW5nIDxoc2lueWlAY2hyb21pdW0u
b3JnPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBf
Y29tcC5jIHwgNDQgKysrKysrKysrKysrKysrKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0
MyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgYi9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+ID4gaW5kZXggODE3M2Y3MDkyNzJiZS4u
ZTg1NjI1NzA0ZDYxMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9kZHBfY29tcC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fZGRwX2NvbXAuYw0KPiA+IEBAIC01Myw3ICs1Myw5IEBADQo+ID4gICNkZWZpbmUgRElU
SEVSX0VOCQkJCUJJVCgwKQ0KPiA+ICAjZGVmaW5lIERJU1BfRElUSEVSX0NGRwkJCQkweDAwMjAN
Cj4gPiAgI2RlZmluZSBESVRIRVJfUkVMQVlfTU9ERQkJCUJJVCgwKQ0KPiA+ICsjZGVmaW5lIERJ
VEhFUl9FTkdJTkVfRU4JCQlCSVQoMSkNCj4gPiAgI2RlZmluZSBESVNQX0RJVEhFUl9TSVpFCQkJ
MHgwMDMwDQo+ID4gKyNkZWZpbmUgRElUSEVSX1JFRyhpZHgpCQkJCSgweDEwMCArIChpZHgpICog
NCkNCj4gPiAgDQo+ID4gICNkZWZpbmUgTFVUXzEwQklUX01BU0sJCQkJMHgwM2ZmDQo+ID4gIA0K
PiA+IEBAIC0zMTMsOCArMzE1LDQ4IEBAIHN0YXRpYyB2b2lkIG10a19kaXRoZXJfY29uZmlnKHN0
cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcsDQo+ID4gIHsNCj4gPiAgCXN0cnVjdCBt
dGtfZGRwX2NvbXBfZGV2ICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gIA0KPiA+
ICsJYm9vbCBlbmFibGUgPSBmYWxzZTsNCj4gPiArDQo+ID4gKwkvKiBkZWZhdWx0IHZhbHVlIGZv
ciBkaXRoZXIgcmVnIDUgdG8gMTQgKi8NCj4gPiArCWNvbnN0IHUzMiBkaXRoZXJfc2V0dGluZ1td
ID0gew0KPiA+ICsJCTB4MDAwMDAwMDAsIC8qIDUgKi8NCj4gPiArCQkweDAwMDAzMDAyLCAvKiA2
ICovDQo+ID4gKwkJMHgwMDAwMDAwMCwgLyogNyAqLw0KPiA+ICsJCTB4MDAwMDAwMDAsIC8qIDgg
Ki8NCj4gPiArCQkweDAwMDAwMDAwLCAvKiA5ICovDQo+ID4gKwkJMHgwMDAwMDAwMCwgLyogMTAg
Ki8NCj4gPiArCQkweDAwMDAwMDAwLCAvKiAxMSAqLw0KPiA+ICsJCTB4MDAwMDAwMTEsIC8qIDEy
ICovDQo+ID4gKwkJMHgwMDAwMDAwMCwgLyogMTMgKi8NCj4gPiArCQkweDAwMDAwMDAwLCAvKiAx
NCAqLw0KPiANCj4gQ291bGQgeW91IGV4cGxhaW4gd2hhdCBpcyB0aGlzPw0KDQp0aGlzIGlzIGRp
dGhlciA1IHRvIGRpdGhlciAxNCBzZXR0aW5nDQp0aGlzIHdpbGwgYmUgdXNlbGVzcywgd2UganVz
dCBuZWVkIHNldCBkaXRoZXIgNSBhbmQgZGl0aGVyIDcgbGlrZSANCm10a19kZHBfd3JpdGUoY21k
cV9wa3QsIDAsIGNvbXAsIERJU1BfRElUSEVSXzUpOw0KbXRrX2RkcF93cml0ZShjbWRxX3BrdCwg
MCwgY29tcCwgRElTUF9ESVRIRVJfNyk7DQpvdGhlciB2YWx1ZSBpcyBzYW1lIHdpdGggaGFyZHdh
cmUgZGVmYXVsdCB2YWx1ZS4NCg0KDQo+IA0KPiA+ICsJfTsNCj4gPiArDQo+ID4gKwlpZiAoYnBj
ID09IDUgfHwgYnBjID09IDYpIHsNCj4gPiArCQllbmFibGUgPSB0cnVlOw0KPiA+ICsJCW10a19k
ZHBfd3JpdGUoY21kcV9wa3QsDQo+ID4gKwkJCSAgICAgIERJVEhFUl9MU0JfRVJSX1NISUZUX1Io
TVRLX01BWF9CUEMgLSBicGMpIHwNCj4gPiArCQkJICAgICAgRElUSEVSX0FERF9MU0hJRlRfUihN
VEtfTUFYX0JQQyAtIGJwYykgfA0KPiA+ICsJCQkgICAgICBESVRIRVJfTkVXX0JJVF9NT0RFLA0K
PiA+ICsJCQkgICAgICAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsIERJVEhFUl9SRUcoMTUp
KTsNCj4gPiArCQltdGtfZGRwX3dyaXRlKGNtZHFfcGt0LA0KPiA+ICsJCQkgICAgICBESVRIRVJf
TFNCX0VSUl9TSElGVF9CKE1US19NQVhfQlBDIC0gYnBjKSB8DQo+ID4gKwkJCSAgICAgIERJVEhF
Ul9BRERfTFNISUZUX0IoTVRLX01BWF9CUEMgLSBicGMpIHwNCj4gPiArCQkJICAgICAgRElUSEVS
X0xTQl9FUlJfU0hJRlRfRyhNVEtfTUFYX0JQQyAtIGJwYykgfA0KPiA+ICsJCQkgICAgICBESVRI
RVJfQUREX0xTSElGVF9HKE1US19NQVhfQlBDIC0gYnBjKSwNCj4gDQo+IFRoaXMgcmVzdWx0IGlu
IDB4NTA1MDUwNTAsIGJ1dCBwcmV2aW91cyB2ZXJzaW9uIGlzIDB4NTA1MDQwNDAsIHNvIHRoaXMN
Cj4gdmVyc2lvbiBpcyBjb3JyZWN0IGFuZCBwcmV2aW91cyB2ZXJzaW9uIGlzIGluY29ycmVjdD8N
Cg0KdGhlIG5ldyB2ZXJzaW9uIHNldCByIGcgYiAzIGNoYW5uZWwgc2FtZSwgc2VhbXMgbW9yZSBy
ZWFzb25hYmxlDQoNCg0KPiANCj4gUmVnYXJkcywNCj4gQ0sNCj4gDQo+ID4gKwkJCSAgICAgICZw
cml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywgRElUSEVSX1JFRygxNikpOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiArDQo+ID4gKwlpZiAoZW5hYmxlKSB7DQo+ID4gKwkJdTMyIGlkeDsNCj4gPiArDQo+
ID4gKwkJZm9yIChpZHggPSAwOyBpZHggPCBBUlJBWV9TSVpFKGRpdGhlcl9zZXR0aW5nKTsgaWR4
KyspDQo+ID4gKwkJCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIGRpdGhlcl9zZXR0aW5nW2lkeF0s
ICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywNCj4gPiArCQkJCSAgICAgIERJVEhFUl9SRUco
aWR4ICsgNSkpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgCW10a19kZHBfd3JpdGUoY21kcV9wa3Qs
IGggPDwgMTYgfCB3LCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsIERJU1BfRElUSEVSX1NJ
WkUpOw0KPiA+IC0JbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgRElUSEVSX1JFTEFZX01PREUsICZw
cml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywgRElTUF9ESVRIRVJfQ0ZHKTsNCj4gPiArICAgICAg
ICBtdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCBlbmFibGUgPyBESVRIRVJfRU5HSU5FX0VOIDogRElU
SEVSX1JFTEFZX01PREUsICZwcml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywgRElTUF9ESVRIRVJf
Q0ZHKTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgc3RhdGljIHZvaWQgbXRrX2RpdGhlcl9zdGFydChz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+IA0KPiANCg0K

