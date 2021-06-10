Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F2D3A2AED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 14:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFJMC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 08:02:26 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:26313 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230130AbhFJMCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 08:02:25 -0400
X-UUID: 827a8c7e72784590a93ccdd7abfe48bd-20210610
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=tlUPqFBYcu/rjIdxpBkPwMA/VWMkzOdQO1eIjrE31tg=;
        b=rU3BCHZWLwd+LKYt/jYpih3uoKBlREvBTWTuqfOnCDU+GLNFEta/DZGQLWQ6RJRA71PyWZN+Wj7RQ6optVVL8nhUF68S1VN3Pxa/6AeAVin1B75ZIiadGc+yV7Wn4xjQ23Fp7TRkwSeF6RV9hu9kZ7o9T4vrQEPz6asioHh7Ork=;
X-UUID: 827a8c7e72784590a93ccdd7abfe48bd-20210610
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 39873709; Thu, 10 Jun 2021 20:00:23 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Jun
 2021 20:00:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Jun 2021 20:00:18 +0800
Message-ID: <1623326418.23717.18.camel@mhfsdcap03>
Subject: Re: [PATCH v5 11/16] drm/mediatek: Get rid of mtk_smi_larb_get/put
From:   Yong Wu <yong.wu@mediatek.com>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, <anan.sun@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>,
        <yi.kuo@mediatek.com>, <eizan@chromium.org>,
        <acourbot@chromium.org>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Date:   Thu, 10 Jun 2021 20:00:18 +0800
In-Reply-To: <6f3bfbeb-e7d4-249e-b4f0-da1825fec461@collabora.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
         <20210410091128.31823-12-yong.wu@mediatek.com>
         <6f3bfbeb-e7d4-249e-b4f0-da1825fec461@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5BEB4821D74113F0BEB303285223F2F9684DE83B6E5B1323D11FBD40F26FC9382000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTA1LTI2IGF0IDA4OjQxICswMzAwLCBEYWZuYSBIaXJzY2hmZWxkIHdyb3Rl
Og0KPiBIaQ0KPiANCj4gT24gMTAuMDQuMjEgMTI6MTEsIFlvbmcgV3Ugd3JvdGU6DQo+ID4gTWVk
aWFUZWsgSU9NTVUgaGFzIGFscmVhZHkgYWRkZWQgdGhlIGRldmljZV9saW5rIGJldHdlZW4gdGhl
IGNvbnN1bWVyDQo+ID4gYW5kIHNtaS1sYXJiIGRldmljZS4gSWYgdGhlIGRybSBkZXZpY2UgY2Fs
bCB0aGUgcG1fcnVudGltZV9nZXRfc3luYywNCj4gPiB0aGUgc21pLWxhcmIncyBwbV9ydW50aW1l
X2dldF9zeW5jIGFsc28gYmUgY2FsbGVkIGF1dG9tYXRpY2FsbHkuDQo+ID4gDQo+ID4gQ0M6IENL
IEh1IDxjay5odUBtZWRpYXRlay5jb20+DQo+ID4gQ0M6IFBoaWxpcHAgWmFiZWwgPHAuemFiZWxA
cGVuZ3V0cm9uaXguZGU+DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRp
YXRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEV2YW4gR3JlZW4gPGV2Z3JlZW5AY2hyb21pdW0u
b3JnPg0KPiA+IEFja2VkLWJ5OiBDaHVuLUt1YW5nIEh1IDxjaHVua3VhbmcuaHVAa2VybmVsLm9y
Zz4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMu
YyAgICAgfCAgOSAtLS0tLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2RkcF9jb21wLmMgfCAzNSAtLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmggfCAgMSAtDQo+ID4gICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyAgICAgIHwgIDUgKy0tDQo+ID4gICA0IGZpbGVz
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0OSBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gaW5kZXggOTcxZWY1OGFjMWRj
Li5kNTkzNTNhZjQwMTkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fY3J0Yy5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fY3J0Yy5jDQo+ID4gQEAgLTEwLDcgKzEwLDYgQEANCj4gPiAgICNpbmNsdWRlIDxsaW51eC9z
b2MvbWVkaWF0ZWsvbXRrLW11dGV4Lmg+DQo+ID4gICANCj4gPiAgICNpbmNsdWRlIDxhc20vYmFy
cmllci5oPg0KPiA+IC0jaW5jbHVkZSA8c29jL21lZGlhdGVrL3NtaS5oPg0KPiA+ICAgDQo+ID4g
ICAjaW5jbHVkZSA8ZHJtL2RybV9hdG9taWMuaD4NCj4gPiAgICNpbmNsdWRlIDxkcm0vZHJtX2F0
b21pY19oZWxwZXIuaD4NCj4gPiBAQCAtNTQ0LDEyICs1NDMsNiBAQCBzdGF0aWMgdm9pZCBtdGtf
ZHJtX2NydGNfYXRvbWljX2VuYWJsZShzdHJ1Y3QgZHJtX2NydGMgKmNydGMsDQo+ID4gICANCj4g
PiAgIAlEUk1fREVCVUdfRFJJVkVSKCIlcyAlZFxuIiwgX19mdW5jX18sIGNydGMtPmJhc2UuaWQp
Ow0KPiA+ICAgDQo+ID4gLQlyZXQgPSBtdGtfc21pX2xhcmJfZ2V0KGNvbXAtPmxhcmJfZGV2KTsN
Cj4gPiAtCWlmIChyZXQpIHsNCj4gPiAtCQlEUk1fRVJST1IoIkZhaWxlZCB0byBnZXQgbGFyYjog
JWRcbiIsIHJldCk7DQo+ID4gLQkJcmV0dXJuOw0KPiA+IC0JfQ0KPiA+IC0NCj4gPiAgIAlyZXQg
PSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KGNvbXAtPmRldik7DQo+ID4gICAJaWYgKHJldCA8
IDApDQo+ID4gICAJCURSTV9ERVZfRVJST1IoY29tcC0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBw
b3dlciBkb21haW46ICVkXG4iLA0KPiA+IEBAIC01NTcsNyArNTUwLDYgQEAgc3RhdGljIHZvaWQg
bXRrX2RybV9jcnRjX2F0b21pY19lbmFibGUoc3RydWN0IGRybV9jcnRjICpjcnRjLA0KPiA+ICAg
DQo+ID4gICAJcmV0ID0gbXRrX2NydGNfZGRwX2h3X2luaXQobXRrX2NydGMpOw0KPiA+ICAgCWlm
IChyZXQpIHsNCj4gPiAtCQltdGtfc21pX2xhcmJfcHV0KGNvbXAtPmxhcmJfZGV2KTsNCj4gPiAg
IAkJcG1fcnVudGltZV9wdXQoY29tcC0+ZGV2KTsNCj4gPiAgIAkJcmV0dXJuOw0KPiA+ICAgCX0N
Cj4gPiBAQCAtNTk0LDcgKzU4Niw2IEBAIHN0YXRpYyB2b2lkIG10a19kcm1fY3J0Y19hdG9taWNf
ZGlzYWJsZShzdHJ1Y3QgZHJtX2NydGMgKmNydGMsDQo+ID4gICANCj4gPiAgIAlkcm1fY3J0Y192
Ymxhbmtfb2ZmKGNydGMpOw0KPiA+ICAgCW10a19jcnRjX2RkcF9od19maW5pKG10a19jcnRjKTsN
Cj4gPiAtCW10a19zbWlfbGFyYl9wdXQoY29tcC0+bGFyYl9kZXYpOw0KPiA+ICAgCXJldCA9IHBt
X3J1bnRpbWVfcHV0KGNvbXAtPmRldik7DQo+ID4gICAJaWYgKHJldCA8IDApDQo+ID4gICAJCURS
TV9ERVZfRVJST1IoY29tcC0+ZGV2LCAiRmFpbGVkIHRvIGRpc2FibGUgcG93ZXIgZG9tYWluOiAl
ZFxuIiwNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwX2NvbXAuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMN
Cj4gPiBpbmRleCA3NWJjMDBlMTdmYzQuLjZjMDE0OTJiYTRkZiAxMDA2NDQNCj4gPiAtLS0gYS9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jDQo+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiA+IEBAIC00NDksMzcg
KzQ0OSwxMiBAQCB1bnNpZ25lZCBpbnQgbXRrX2RybV9maW5kX3Bvc3NpYmxlX2NydGNfYnlfY29t
cChzdHJ1Y3QgZHJtX2RldmljZSAqZHJtLA0KPiA+ICAgCXJldHVybiByZXQ7DQo+ID4gICB9DQo+
ID4gICANCj4gPiAtc3RhdGljIGludCBtdGtfZGRwX2dldF9sYXJiX2RldihzdHJ1Y3QgZGV2aWNl
X25vZGUgKm5vZGUsIHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsDQo+ID4gLQkJCQlzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQo+ID4gLXsNCj4gPiAtCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbGFyYl9ub2Rl
Ow0KPiA+IC0Jc3RydWN0IHBsYXRmb3JtX2RldmljZSAqbGFyYl9wZGV2Ow0KPiA+IC0NCj4gPiAt
CWxhcmJfbm9kZSA9IG9mX3BhcnNlX3BoYW5kbGUobm9kZSwgIm1lZGlhdGVrLGxhcmIiLCAwKTsN
Cj4gPiAtCWlmICghbGFyYl9ub2RlKSB7DQo+ID4gLQkJZGV2X2VycihkZXYsICJNaXNzaW5nIG1l
ZGlhZGVrLGxhcmIgcGhhbmRsZSBpbiAlcE9GIG5vZGVcbiIsIG5vZGUpOw0KPiA+IC0JCXJldHVy
biAtRUlOVkFMOw0KPiA+IC0JfQ0KPiA+IC0NCj4gPiAtCWxhcmJfcGRldiA9IG9mX2ZpbmRfZGV2
aWNlX2J5X25vZGUobGFyYl9ub2RlKTsNCj4gPiAtCWlmICghbGFyYl9wZGV2KSB7DQo+ID4gLQkJ
ZGV2X3dhcm4oZGV2LCAiV2FpdGluZyBmb3IgbGFyYiBkZXZpY2UgJXBPRlxuIiwgbGFyYl9ub2Rl
KTsNCj4gPiAtCQlvZl9ub2RlX3B1dChsYXJiX25vZGUpOw0KPiA+IC0JCXJldHVybiAtRVBST0JF
X0RFRkVSOw0KPiA+IC0JfQ0KPiA+IC0Jb2Zfbm9kZV9wdXQobGFyYl9ub2RlKTsNCj4gPiAtCWNv
bXAtPmxhcmJfZGV2ID0gJmxhcmJfcGRldi0+ZGV2Ow0KPiA+IC0NCj4gPiAtCXJldHVybiAwOw0K
PiA+IC19DQo+ID4gLQ0KPiA+ICAgaW50IG10a19kZHBfY29tcF9pbml0KHN0cnVjdCBkZXZpY2Vf
bm9kZSAqbm9kZSwgc3RydWN0IG10a19kZHBfY29tcCAqY29tcCwNCj4gPiAgIAkJICAgICAgZW51
bSBtdGtfZGRwX2NvbXBfaWQgY29tcF9pZCkNCj4gPiAgIHsNCj4gPiAgIAlzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpjb21wX3BkZXY7DQo+ID4gICAJZW51bSBtdGtfZGRwX2NvbXBfdHlwZSB0eXBl
Ow0KPiA+ICAgCXN0cnVjdCBtdGtfZGRwX2NvbXBfZGV2ICpwcml2Ow0KPiA+IC0JaW50IHJldDsN
Cj4gSGksDQo+IA0KPiBUaGlzICdyZXQnIGlzIGFsc28gdXNlZCBpbnNpZGUgYGlmIElTX1JFQUNI
QUJMRShDT05GSUdfTVRLX0NNRFEpYA0KPiBzbyBpdCAgc2hvdWxkIG5vdCBiZSByZW1vdmVkLg0K
DQpIaSBEYWZuYSwNCg0KVGhhbmtzIHZlcnkgbXVjaCBmb3IgcG9pbnRpbmcgb3V0LiBBcHBhcmVu
dGx5IEkgZGlkbid0IGVuYWJsZSB0aGlzIHRvDQpidWlsZC4gU29ycnkgZm9yIHRoaXMuDQoNCkkg
d2lsbCBmaXggaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiBUaGFua3MsDQo+IERhZm5hDQo+
IA0KPiA+ICAgDQo+ID4gICAJaWYgKGNvbXBfaWQgPCAwIHx8IGNvbXBfaWQgPj0gRERQX0NPTVBP
TkVOVF9JRF9NQVgpDQo+ID4gICAJCXJldHVybiAtRUlOVkFMOw0KPiA+IEBAIC00OTUsMTYgKzQ3
MCw2IEBAIGludCBtdGtfZGRwX2NvbXBfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGUsIHN0
cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsDQo+ID4gICAJfQ0KPiA+ICAgCWNvbXAtPmRldiA9ICZj
b21wX3BkZXYtPmRldjsNCj4gPiAgIA0KPiA+IC0JLyogT25seSBETUEgY2FwYWJsZSBjb21wb25l
bnRzIG5lZWQgdGhlIExBUkIgcHJvcGVydHkgKi8NCj4gPiAtCWlmICh0eXBlID09IE1US19ESVNQ
X09WTCB8fA0KPiA+IC0JICAgIHR5cGUgPT0gTVRLX0RJU1BfT1ZMXzJMIHx8DQo+ID4gLQkgICAg
dHlwZSA9PSBNVEtfRElTUF9SRE1BIHx8DQo+ID4gLQkgICAgdHlwZSA9PSBNVEtfRElTUF9XRE1B
KSB7DQo+ID4gLQkJcmV0ID0gbXRrX2RkcF9nZXRfbGFyYl9kZXYobm9kZSwgY29tcCwgY29tcC0+
ZGV2KTsNCj4gPiAtCQlpZiAocmV0KQ0KPiA+IC0JCQlyZXR1cm4gcmV0Ow0KPiA+IC0JfQ0KPiA+
IC0NCj4gPiAgIAlpZiAodHlwZSA9PSBNVEtfRElTUF9CTFMgfHwNCj4gPiAgIAkgICAgdHlwZSA9
PSBNVEtfRElTUF9DQ09SUiB8fA0KPiA+ICAgCSAgICB0eXBlID09IE1US19ESVNQX0NPTE9SIHx8
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9j
b21wLmggYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5oDQo+ID4g
aW5kZXggYmI5MTRkOTc2Y2Y1Li4xYjU4MjI2MmI2ODIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaA0KPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgNCj4gPiBAQCAtNzAsNyArNzAsNiBA
QCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzIHsNCj4gPiAgIHN0cnVjdCBtdGtfZGRwX2NvbXAg
ew0KPiA+ICAgCXN0cnVjdCBkZXZpY2UgKmRldjsNCj4gPiAgIAlpbnQgaXJxOw0KPiA+IC0Jc3Ry
dWN0IGRldmljZSAqbGFyYl9kZXY7DQo+ID4gICAJZW51bSBtdGtfZGRwX2NvbXBfaWQgaWQ7DQo+
ID4gICAJY29uc3Qgc3RydWN0IG10a19kZHBfY29tcF9mdW5jcyAqZnVuY3M7DQo+ID4gICB9Ow0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jDQo+ID4gaW5kZXggYjAxM2Q1
NmQyNzc3Li42MjJkZTQ3MjM5ZWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9kcnYuYw0KPiA+IEBAIC01NzYsMTEgKzU3Niw4IEBAIHN0YXRpYyBpbnQgbXRrX2Ry
bV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgCXBtX3J1bnRpbWVf
ZGlzYWJsZShkZXYpOw0KPiA+ICAgZXJyX25vZGU6DQo+ID4gICAJb2Zfbm9kZV9wdXQocHJpdmF0
ZS0+bXV0ZXhfbm9kZSk7DQo+ID4gLQlmb3IgKGkgPSAwOyBpIDwgRERQX0NPTVBPTkVOVF9JRF9N
QVg7IGkrKykgew0KPiA+ICsJZm9yIChpID0gMDsgaSA8IEREUF9DT01QT05FTlRfSURfTUFYOyBp
KyspDQo+ID4gICAJCW9mX25vZGVfcHV0KHByaXZhdGUtPmNvbXBfbm9kZVtpXSk7DQo+ID4gLQkJ
aWYgKHByaXZhdGUtPmRkcF9jb21wW2ldLmxhcmJfZGV2KQ0KPiA+IC0JCQlwdXRfZGV2aWNlKHBy
aXZhdGUtPmRkcF9jb21wW2ldLmxhcmJfZGV2KTsNCj4gPiAtCX0NCj4gPiAgIAlyZXR1cm4gcmV0
Ow0KPiA+ICAgfQ0KPiA+ICAgDQo+ID4gDQoNCg==

