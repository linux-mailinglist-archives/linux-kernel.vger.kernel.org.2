Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6E3350C64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 04:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233451AbhDACIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 22:08:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51260 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233028AbhDACIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 22:08:18 -0400
X-UUID: 47acad642a104fb2a14041a079cb813c-20210401
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=xxoJj4PzGeFeHxkVicdKTYcSt15G5RUjI0591TbB/Mc=;
        b=dvMoHBxp2+B60fJvac56osF3A+YFYzNYeApi6qe6NeBGp/h0I4cdCDUIvvHT84Aob9riMX78N+DmGDJ+9LYvYsmCdTKjgg0ARPvyaEnhrP2SVbehPeM5Bo3TAF4WP3i4DNDgYINdmmsDpwp9t+oVPjoAvgtlk3L8RJzlDqEYLlU=;
X-UUID: 47acad642a104fb2a14041a079cb813c-20210401
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1636523368; Thu, 01 Apr 2021 10:08:13 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 1 Apr 2021 10:08:12 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 1 Apr 2021 10:08:12 +0800
Message-ID: <1617242892.14305.5.camel@mtksdaap41>
Subject: Re: [PATCH 3/3] drm/mediatek: dpi: add bus format negociation
From:   CK Hu <ck.hu@mediatek.com>
To:     Jitao Shi <jitao.shi@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <stonea168@163.com>,
        <huijuan.xie@mediatek.com>, <rex-bc.chen@mediatek.com>
Date:   Thu, 1 Apr 2021 10:08:12 +0800
In-Reply-To: <20210330155330.28759-4-jitao.shi@mediatek.com>
References: <20210330155330.28759-1-jitao.shi@mediatek.com>
         <20210330155330.28759-4-jitao.shi@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEppdGFvOg0KDQpPbiBUdWUsIDIwMjEtMDMtMzAgYXQgMjM6NTMgKzA4MDAsIEppdGFvIFNo
aSB3cm90ZToNCj4gQWRkIHRoZSBhdG9taWNfZ2V0X291dHB1dF9idXNfZm10cywgYXRvbWljX2dl
dF9pbnB1dF9idXNfZm10cyB0byBuZWdvY2lhdGUNCj4gdGhlIHBvc3NpYmxlIG91dHB1dCBhbmQg
aW5wdXQgZm9ybWF0cyBmb3IgdGhlIGN1cnJlbnQgbW9kZSBhbmQgbW9uaXRvciwNCj4gYW5kIHVz
ZSB0aGUgbmVnb3RpYXRlZCBmb3JtYXRzIGluIGEgYmFzaWMgYXRvbWljX2NoZWNrIGNhbGxiYWNr
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29t
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgfCA5NiArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkx
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHBpLmMNCj4gaW5kZXggODdiYjI3NjQ5YzRjLi40ZTQ1ZDFiMDFiMGMgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMNCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcGkuYw0KPiBAQCAtODEsNiArODEsOCBAQCBzdHJ1Y3QgbXRr
X2RwaSB7DQo+ICAJc3RydWN0IHBpbmN0cmwgKnBpbmN0cmw7DQo+ICAJc3RydWN0IHBpbmN0cmxf
c3RhdGUgKnBpbnNfZ3BpbzsNCj4gIAlzdHJ1Y3QgcGluY3RybF9zdGF0ZSAqcGluc19kcGk7DQo+
ICsJdW5zaWduZWQgaW50IGluX2J1c19mb3JtYXQ7DQo+ICsJdW5zaWduZWQgaW50IG91dF9idXNf
Zm9ybWF0Ow0KDQpXaHkgZG8geW91IGtlZXAgdGhlc2UgdHdvIHZhbHVlPyBZb3UgZG9lcyBub3Qg
dXNlIHRoZW0uDQoNCj4gIAlib29sIGRkcl9lZGdlX3NlbDsNCj4gIAlpbnQgcmVmY291bnQ7DQo+
ICB9Ow0KPiBAQCAtNTM0LDYgKzUzNiw5MiBAQCBzdGF0aWMgaW50IG10a19kcGlfc2V0X2Rpc3Bs
YXlfbW9kZShzdHJ1Y3QgbXRrX2RwaSAqZHBpLA0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+
ICsjZGVmaW5lIE1BWF9PVVRQVVRfU0VMX0ZPUk1BVFMJMg0KPiArDQo+ICtzdGF0aWMgdTMyICpt
dGtfZHBpX2JyaWRnZV9hdG9taWNfZ2V0X291dHB1dF9idXNfZm10cyhzdHJ1Y3QgZHJtX2JyaWRn
ZSAqYnJpZGdlLA0KPiArCQkJCQlzdHJ1Y3QgZHJtX2JyaWRnZV9zdGF0ZSAqYnJpZGdlX3N0YXRl
LA0KPiArCQkJCQlzdHJ1Y3QgZHJtX2NydGNfc3RhdGUgKmNydGNfc3RhdGUsDQo+ICsJCQkJCXN0
cnVjdCBkcm1fY29ubmVjdG9yX3N0YXRlICpjb25uX3N0YXRlLA0KPiArCQkJCQl1bnNpZ25lZCBp
bnQgKm51bV9vdXRwdXRfZm10cykNCj4gK3sNCj4gKwlzdHJ1Y3QgZHJtX2Rpc3BsYXlfbW9kZSAq
bW9kZSA9ICZjcnRjX3N0YXRlLT5tb2RlOw0KPiArCXUzMiAqb3V0cHV0X2ZtdHM7DQo+ICsJc3Ry
dWN0IG10a19kcGkgKmRwaSA9IGJyaWRnZV90b19kcGkoYnJpZGdlKTsNCj4gKw0KPiArCSpudW1f
b3V0cHV0X2ZtdHMgPSAwOw0KPiArDQo+ICsJb3V0cHV0X2ZtdHMgPSBrY2FsbG9jKE1BWF9PVVRQ
VVRfU0VMX0ZPUk1BVFMsIHNpemVvZigqb3V0cHV0X2ZtdHMpLA0KPiArCQkJICAgICAgR0ZQX0tF
Uk5FTCk7DQo+ICsJaWYgKCFvdXRwdXRfZm10cykNCj4gKwkJcmV0dXJuIE5VTEw7DQo+ICsNCj4g
KwkvKiBEZWZhdWx0IDhiaXQgUkdCIGZhbGxiYWNrICovDQo+ICsJaWYgKGRwaS0+Y29uZi0+ZHVh
bF9lZGdlKSB7DQo+ICsJCW91dHB1dF9mbXRzWzBdID0gIE1FRElBX0JVU19GTVRfUkdCODg4XzJY
MTJfTEU7DQo+ICsJCW91dHB1dF9mbXRzWzFdID0gIE1FRElBX0JVU19GTVRfUkdCODg4XzJYMTJf
QkU7DQoNClNvIG10ODE4MyBkb2VzIG5vdCBzdXBwb3J0IE1FRElBX0JVU19GTVRfUkdCODg4XzFY
MjQ/DQoNCj4gKwkJKm51bV9vdXRwdXRfZm10cyA9IDI7DQo+ICsJfSBlbHNlIHsNCj4gKwkJb3V0
cHV0X2ZtdHNbMF0gPSAgTUVESUFfQlVTX0ZNVF9SR0I4ODhfMVgyNDsNCj4gKwkJKm51bV9vdXRw
dXRfZm10cyA9IDE7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIG91dHB1dF9mbXRzOw0KPiArfQ0K
PiArDQo+ICsjZGVmaW5lIE1BWF9JTlBVVF9TRUxfRk9STUFUUwkxDQo+ICsNCj4gK3N0YXRpYyB1
MzIgKm10a19kcGlfYnJpZGdlX2F0b21pY19nZXRfaW5wdXRfYnVzX2ZtdHMoc3RydWN0IGRybV9i
cmlkZ2UgKmJyaWRnZSwNCj4gKwkJCQkJc3RydWN0IGRybV9icmlkZ2Vfc3RhdGUgKmJyaWRnZV9z
dGF0ZSwNCj4gKwkJCQkJc3RydWN0IGRybV9jcnRjX3N0YXRlICpjcnRjX3N0YXRlLA0KPiArCQkJ
CQlzdHJ1Y3QgZHJtX2Nvbm5lY3Rvcl9zdGF0ZSAqY29ubl9zdGF0ZSwNCj4gKwkJCQkJdTMyIG91
dHB1dF9mbXQsDQo+ICsJCQkJCXVuc2lnbmVkIGludCAqbnVtX2lucHV0X2ZtdHMpDQo+ICt7DQo+
ICsJdTMyICppbnB1dF9mbXRzOw0KPiArDQo+ICsJKm51bV9pbnB1dF9mbXRzID0gMDsNCj4gKw0K
PiArCWlucHV0X2ZtdHMgPSBrY2FsbG9jKE1BWF9JTlBVVF9TRUxfRk9STUFUUywgc2l6ZW9mKCpp
bnB1dF9mbXRzKSwNCj4gKwkJCSAgICAgR0ZQX0tFUk5FTCk7DQo+ICsJaWYgKCFpbnB1dF9mbXRz
KQ0KPiArCQlyZXR1cm4gTlVMTDsNCj4gKw0KPiArCSpudW1faW5wdXRfZm10cyA9IDE7DQo+ICsJ
aW5wdXRfZm10c1swXSA9IE1FRElBX0JVU19GTVRfUkdCODg4XzFYMjQ7DQo+ICsNCj4gKwlyZXR1
cm4gaW5wdXRfZm10czsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBtdGtfZHBpX2JyaWRnZV9h
dG9taWNfY2hlY2soc3RydWN0IGRybV9icmlkZ2UgKmJyaWRnZSwNCj4gKwkJCQkgICAgICAgc3Ry
dWN0IGRybV9icmlkZ2Vfc3RhdGUgKmJyaWRnZV9zdGF0ZSwNCj4gKwkJCQkgICAgICAgc3RydWN0
IGRybV9jcnRjX3N0YXRlICpjcnRjX3N0YXRlLA0KPiArCQkJCSAgICAgICBzdHJ1Y3QgZHJtX2Nv
bm5lY3Rvcl9zdGF0ZSAqY29ubl9zdGF0ZSkNCj4gK3sNCj4gKwlzdHJ1Y3QgbXRrX2RwaSAqZHBp
ID0gYnJpZGdlLT5kcml2ZXJfcHJpdmF0ZTsNCj4gKw0KPiArCWRwaS0+b3V0X2J1c19mb3JtYXQg
PSBicmlkZ2Vfc3RhdGUtPm91dHB1dF9idXNfY2ZnLmZvcm1hdDsNCj4gKw0KPiArCWRwaS0+aW5f
YnVzX2Zvcm1hdCA9IGJyaWRnZV9zdGF0ZS0+aW5wdXRfYnVzX2NmZy5mb3JtYXQ7DQo+ICsNCj4g
KwlkZXZfZGJnKGRwaS0+ZGV2LCAiaW5wdXQgZm9ybWF0IDB4JTA0eCwgb3V0cHV0IGZvcm1hdCAw
eCUwNHhcbiIsDQo+ICsJCWJyaWRnZV9zdGF0ZS0+aW5wdXRfYnVzX2NmZy5mb3JtYXQsDQo+ICsJ
CWJyaWRnZV9zdGF0ZS0+b3V0cHV0X2J1c19jZmcuZm9ybWF0KTsNCj4gKw0KPiArCWlmIChkcGkt
Pm91dF9idXNfZm9ybWF0ID09IE1FRElBX0JVU19GTVRfUkdCODg4XzJYMTJfTEUgfHwNCj4gKwkg
ICAgZHBpLT5vdXRfYnVzX2Zvcm1hdCA9PSBNRURJQV9CVVNfRk1UX1JHQjg4OF8yWDEyX0JFKSB7
DQoNCkkgdGhpbmsgeW91IGNvdWxkIHJlbW92ZSB0aGlzICdpZicgY2hlY2tpbmcuDQoNClJlZ2Fy
ZHMsDQpDSy4NCg0KPiArCQlkcGktPmRkcl9lZGdlX3NlbCA9DQo+ICsJCQkoZHBpLT5vdXRfYnVz
X2Zvcm1hdCA9PSBNRURJQV9CVVNfRk1UX1JHQjg4OF8yWDEyX0xFKSA/DQo+ICsJCQkgdHJ1ZSA6
IGZhbHNlOw0KPiArCX0NCj4gKw0KPiArCWRwaS0+Yml0X251bSA9IE1US19EUElfT1VUX0JJVF9O
VU1fOEJJVFM7DQo+ICsJZHBpLT5jaGFubmVsX3N3YXAgPSBNVEtfRFBJX09VVF9DSEFOTkVMX1NX
QVBfUkdCOw0KPiArCWRwaS0+eWNfbWFwID0gTVRLX0RQSV9PVVRfWUNfTUFQX1JHQjsNCj4gKwlk
cGktPmNvbG9yX2Zvcm1hdCA9IE1US19EUElfQ09MT1JfRk9STUFUX1JHQjsNCj4gKw0KPiArCXJl
dHVybiAwOw0KPiArfQ0KPiArDQo+ICBzdGF0aWMgaW50IG10a19kcGlfYnJpZGdlX2F0dGFjaChz
dHJ1Y3QgZHJtX2JyaWRnZSAqYnJpZGdlLA0KPiAgCQkJCSBlbnVtIGRybV9icmlkZ2VfYXR0YWNo
X2ZsYWdzIGZsYWdzKQ0KPiAgew0KPiBAQCAtNTcyLDYgKzY2MCw5IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgZHJtX2JyaWRnZV9mdW5jcyBtdGtfZHBpX2JyaWRnZV9mdW5jcyA9IHsNCj4gIAkubW9k
ZV9zZXQgPSBtdGtfZHBpX2JyaWRnZV9tb2RlX3NldCwNCj4gIAkuZGlzYWJsZSA9IG10a19kcGlf
YnJpZGdlX2Rpc2FibGUsDQo+ICAJLmVuYWJsZSA9IG10a19kcGlfYnJpZGdlX2VuYWJsZSwNCj4g
KwkuYXRvbWljX2NoZWNrID0gbXRrX2RwaV9icmlkZ2VfYXRvbWljX2NoZWNrLA0KPiArCS5hdG9t
aWNfZ2V0X291dHB1dF9idXNfZm10cyA9IG10a19kcGlfYnJpZGdlX2F0b21pY19nZXRfb3V0cHV0
X2J1c19mbXRzLA0KPiArCS5hdG9taWNfZ2V0X2lucHV0X2J1c19mbXRzID0gbXRrX2RwaV9icmlk
Z2VfYXRvbWljX2dldF9pbnB1dF9idXNfZm10cywNCj4gIH07DQo+ICANCj4gIHN0YXRpYyB2b2lk
IG10a19kcGlfc3RhcnQoc3RydWN0IG10a19kZHBfY29tcCAqY29tcCkNCj4gQEAgLTYyMSwxMSAr
NzEyLDYgQEAgc3RhdGljIGludCBtdGtfZHBpX2JpbmQoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1
Y3QgZGV2aWNlICptYXN0ZXIsIHZvaWQgKmRhdGEpDQo+ICAJCWdvdG8gZXJyX2NsZWFudXA7DQo+
ICAJfQ0KPiAgDQo+IC0JZHBpLT5iaXRfbnVtID0gTVRLX0RQSV9PVVRfQklUX05VTV84QklUUzsN
Cj4gLQlkcGktPmNoYW5uZWxfc3dhcCA9IE1US19EUElfT1VUX0NIQU5ORUxfU1dBUF9SR0I7DQo+
IC0JZHBpLT55Y19tYXAgPSBNVEtfRFBJX09VVF9ZQ19NQVBfUkdCOw0KPiAtCWRwaS0+Y29sb3Jf
Zm9ybWF0ID0gTVRLX0RQSV9DT0xPUl9GT1JNQVRfUkdCOw0KPiAtDQo+ICAJcmV0dXJuIDA7DQo+
ICANCj4gIGVycl9jbGVhbnVwOg0KDQo=

