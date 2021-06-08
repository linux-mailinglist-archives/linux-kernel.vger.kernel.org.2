Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C82A39F28B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 11:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFHJiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 05:38:02 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:35139 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229678AbhFHJiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 05:38:01 -0400
X-UUID: 3e9002f43fa04a4f8ece9a742ed08a52-20210608
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=+B2QImP6/+3dV4dUubTd73D2XzItTeRR9Dm1MA2u5aE=;
        b=lTgFCwz2jqS7rYdq8AlB3TCHlmdYVfQ0e5K23qnsgpDL/GfE9uYxvDarwe84n/tdOqc+4pPW3ggd/TMZXjTqj47PX3Wzzsc7rlxFRLi19BQJ1Ur5t7c/FUfbzxPH4cRKNLijkMFxkct2KhXzDc4C3DjU99jpcG29T8yzotJNs2I=;
X-UUID: 3e9002f43fa04a4f8ece9a742ed08a52-20210608
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1596794492; Tue, 08 Jun 2021 17:35:59 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Jun
 2021 17:35:54 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Jun 2021 17:35:52 +0800
Message-ID: <1623144943.7079.1.camel@mhfsdcap03>
Subject: Re: [PATCH v5 08/16] media: mtk-mdp: Get rid of mtk_smi_larb_get/put
From:   houlong wei <houlong.wei@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Youlin Pei =?UTF-8?Q?=28=E8=A3=B4=E5=8F=8B=E6=9E=97=29?= 
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Anan Sun =?UTF-8?Q?=28=E5=AD=99=E5=AE=89=E5=AE=89=29?= 
        <Anan.Sun@mediatek.com>,
        Chao Hao =?UTF-8?Q?=28=E9=83=9D=E8=B6=85=29?= 
        <Chao.Hao@mediatek.com>,
        Ming-Fan Chen =?UTF-8?Q?=28=E9=99=B3=E6=98=8E=E6=B1=8E=29?= 
        <Ming-Fan.Chen@mediatek.com>,
        Yi Kuo =?UTF-8?Q?=28=E9=83=AD=E6=87=BF=29?= 
        <Yi.Kuo@mediatek.com>, "eizan@chromium.org" <eizan@chromium.org>,
        "acourbot@chromium.org" <acourbot@chromium.org>,
        Minghsiu Tsai =?UTF-8?Q?=28=E8=94=A1=E6=98=8E=E4=BF=AE=29?= 
        <Minghsiu.Tsai@mediatek.com>
Date:   Tue, 8 Jun 2021 17:35:43 +0800
In-Reply-To: <20210410091128.31823-9-yong.wu@mediatek.com>
References: <20210410091128.31823-1-yong.wu@mediatek.com>
         <20210410091128.31823-9-yong.wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 73160F7F9D6C1295E7F9E9F7A0C989361B8103D51415275D79DD2191FBD6D2842000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIxLTA0LTEwIGF0IDE3OjExICswODAwLCBZb25nIFd1IHdyb3RlOg0KPiBNZWRp
YVRlayBJT01NVSBoYXMgYWxyZWFkeSBhZGRlZCB0aGUgZGV2aWNlX2xpbmsgYmV0d2VlbiB0aGUg
Y29uc3VtZXINCj4gYW5kIHNtaS1sYXJiIGRldmljZS4gSWYgdGhlIG1kcCBkZXZpY2UgY2FsbCB0
aGUgcG1fcnVudGltZV9nZXRfc3luYywNCj4gdGhlIHNtaS1sYXJiJ3MgcG1fcnVudGltZV9nZXRf
c3luYyBhbHNvIGJlIGNhbGxlZCBhdXRvbWF0aWNhbGx5Lg0KPiANCj4gQ0M6IE1pbmdoc2l1IFRz
YWkgPG1pbmdoc2l1LnRzYWlAbWVkaWF0ZWsuY29tPg0KPiBDQzogSG91bG9uZyBXZWkgPGhvdWxv
bmcud2VpQG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBt
ZWRpYXRlay5jb20+DQo+IFJldmlld2VkLWJ5OiBFdmFuIEdyZWVuIDxldmdyZWVuQGNocm9taXVt
Lm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1tZHAvbXRrX21kcF9j
b21wLmMgfCA0MCAtLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L210ay1tZHAvbXRrX21kcF9jb21wLmggfCAgMiAtDQo+ICBkcml2ZXJzL21lZGlhL3BsYXRmb3Jt
L210ay1tZHAvbXRrX21kcF9jb3JlLmMgfCAgMSAtDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDQzIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRr
LW1kcC9tdGtfbWRwX2NvbXAuYyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLW1kcC9tdGtf
bWRwX2NvbXAuYw0KPiBpbmRleCBiMzQyNmE1NTFiZWEuLjFlMzgzM2YxYzlhZSAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstbWRwL210a19tZHBfY29tcC5jDQo+ICsr
KyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLW1kcC9tdGtfbWRwX2NvbXAuYw0KPiBAQCAt
OSw3ICs5LDYgQEANCj4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L29mX2FkZHJlc3MuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPiAtI2lu
Y2x1ZGUgPHNvYy9tZWRpYXRlay9zbWkuaD4NCj4gIA0KPiAgI2luY2x1ZGUgIm10a19tZHBfY29t
cC5oIg0KPiAgDQo+IEBAIC0xOCwxNCArMTcsNiBAQCB2b2lkIG10a19tZHBfY29tcF9jbG9ja19v
bihzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBtdGtfbWRwX2NvbXAgKmNvbXApDQo+ICB7DQo+
ICAJaW50IGksIGVycjsNCj4gIA0KPiAtCWlmIChjb21wLT5sYXJiX2Rldikgew0KPiAtCQllcnIg
PSBtdGtfc21pX2xhcmJfZ2V0KGNvbXAtPmxhcmJfZGV2KTsNCj4gLQkJaWYgKGVycikNCj4gLQkJ
CWRldl9lcnIoZGV2LA0KPiAtCQkJCSJmYWlsZWQgdG8gZ2V0IGxhcmIsIGVyciAlZC4gdHlwZTol
ZFxuIiwNCj4gLQkJCQllcnIsIGNvbXAtPnR5cGUpOw0KPiAtCX0NCj4gLQ0KPiAgCWZvciAoaSA9
IDA7IGkgPCBBUlJBWV9TSVpFKGNvbXAtPmNsayk7IGkrKykgew0KPiAgCQlpZiAoSVNfRVJSKGNv
bXAtPmNsa1tpXSkpDQo+ICAJCQljb250aW51ZTsNCj4gQEAgLTQ2LDE3ICszNywxMiBAQCB2b2lk
IG10a19tZHBfY29tcF9jbG9ja19vZmYoc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgbXRrX21k
cF9jb21wICpjb21wKQ0KPiAgCQkJY29udGludWU7DQo+ICAJCWNsa19kaXNhYmxlX3VucHJlcGFy
ZShjb21wLT5jbGtbaV0pOw0KPiAgCX0NCj4gLQ0KPiAtCWlmIChjb21wLT5sYXJiX2RldikNCj4g
LQkJbXRrX3NtaV9sYXJiX3B1dChjb21wLT5sYXJiX2Rldik7DQo+ICB9DQo+ICANCj4gIGludCBt
dGtfbWRwX2NvbXBfaW5pdChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2Vfbm9kZSAq
bm9kZSwNCj4gIAkJICAgICAgc3RydWN0IG10a19tZHBfY29tcCAqY29tcCwNCj4gIAkJICAgICAg
ZW51bSBtdGtfbWRwX2NvbXBfdHlwZSBjb21wX3R5cGUpDQo+ICB7DQo+IC0Jc3RydWN0IGRldmlj
ZV9ub2RlICpsYXJiX25vZGU7DQo+IC0Jc3RydWN0IHBsYXRmb3JtX2RldmljZSAqbGFyYl9wZGV2
Ow0KPiAgCWludCByZXQ7DQo+ICAJaW50IGk7DQo+ICANCj4gQEAgLTc3LDMyICs2Myw2IEBAIGlu
dCBtdGtfbWRwX2NvbXBfaW5pdChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2Vfbm9k
ZSAqbm9kZSwNCj4gIAkJCWJyZWFrOw0KPiAgCX0NCj4gIA0KPiAtCS8qIE9ubHkgRE1BIGNhcGFi
bGUgY29tcG9uZW50cyBuZWVkIHRoZSBMQVJCIHByb3BlcnR5ICovDQo+IC0JY29tcC0+bGFyYl9k
ZXYgPSBOVUxMOw0KPiAtCWlmIChjb21wLT50eXBlICE9IE1US19NRFBfUkRNQSAmJg0KPiAtCSAg
ICBjb21wLT50eXBlICE9IE1US19NRFBfV0RNQSAmJg0KPiAtCSAgICBjb21wLT50eXBlICE9IE1U
S19NRFBfV1JPVCkNCj4gLQkJcmV0dXJuIDA7DQo+IC0NCj4gLQlsYXJiX25vZGUgPSBvZl9wYXJz
ZV9waGFuZGxlKG5vZGUsICJtZWRpYXRlayxsYXJiIiwgMCk7DQo+IC0JaWYgKCFsYXJiX25vZGUp
IHsNCj4gLQkJZGV2X2VycihkZXYsDQo+IC0JCQkiTWlzc2luZyBtZWRpYWRlayxsYXJiIHBoYW5k
bGUgaW4gJXBPRiBub2RlXG4iLCBub2RlKTsNCj4gLQkJcmV0ID0gLUVJTlZBTDsNCj4gLQkJZ290
byBwdXRfZGV2Ow0KPiAtCX0NCj4gLQ0KPiAtCWxhcmJfcGRldiA9IG9mX2ZpbmRfZGV2aWNlX2J5
X25vZGUobGFyYl9ub2RlKTsNCj4gLQlpZiAoIWxhcmJfcGRldikgew0KPiAtCQlkZXZfd2Fybihk
ZXYsICJXYWl0aW5nIGZvciBsYXJiIGRldmljZSAlcE9GXG4iLCBsYXJiX25vZGUpOw0KPiAtCQlv
Zl9ub2RlX3B1dChsYXJiX25vZGUpOw0KPiAtCQlyZXQgPSAtRVBST0JFX0RFRkVSOw0KPiAtCQln
b3RvIHB1dF9kZXY7DQo+IC0JfQ0KPiAtCW9mX25vZGVfcHV0KGxhcmJfbm9kZSk7DQo+IC0NCj4g
LQljb21wLT5sYXJiX2RldiA9ICZsYXJiX3BkZXYtPmRldjsNCj4gLQ0KPiAgCXJldHVybiAwOw0K
PiAgDQo+ICBwdXRfZGV2Og0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9t
dGstbWRwL210a19tZHBfY29tcC5oIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstbWRwL210
a19tZHBfY29tcC5oDQo+IGluZGV4IDFiZjAyNDJjY2U0Ni4uMzZiYzFiOGY2MjIyIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL210ay1tZHAvbXRrX21kcF9jb21wLmgNCj4g
KysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstbWRwL210a19tZHBfY29tcC5oDQo+IEBA
IC0yNywxNCArMjcsMTIgQEAgZW51bSBtdGtfbWRwX2NvbXBfdHlwZSB7DQo+ICAgKiBAbm9kZToJ
bGlzdCBub2RlIHRvIHRyYWNrIHNpYmluZyBNRFAgY29tcG9uZW50cw0KPiAgICogQGRldl9ub2Rl
Ogljb21wb25lbnQgZGV2aWNlIG5vZGUNCj4gICAqIEBjbGs6CWNsb2NrcyByZXF1aXJlZCBmb3Ig
Y29tcG9uZW50DQo+IC0gKiBAbGFyYl9kZXY6CVNNSSBkZXZpY2UgcmVxdWlyZWQgZm9yIGNvbXBv
bmVudA0KPiAgICogQHR5cGU6CWNvbXBvbmVudCB0eXBlDQo+ICAgKi8NCj4gIHN0cnVjdCBtdGtf
bWRwX2NvbXAgew0KPiAgCXN0cnVjdCBsaXN0X2hlYWQJbm9kZTsNCj4gIAlzdHJ1Y3QgZGV2aWNl
X25vZGUJKmRldl9ub2RlOw0KPiAgCXN0cnVjdCBjbGsJCSpjbGtbMl07DQo+IC0Jc3RydWN0IGRl
dmljZQkJKmxhcmJfZGV2Ow0KPiAgCWVudW0gbXRrX21kcF9jb21wX3R5cGUJdHlwZTsNCj4gIH07
DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLW1kcC9tdGtf
bWRwX2NvcmUuYyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbXRrLW1kcC9tdGtfbWRwX2NvcmUu
Yw0KPiBpbmRleCA5NzZhYTFmNDgyOWIuLjcwYThlYWIxNjg2MyAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9tZWRpYS9wbGF0Zm9ybS9tdGstbWRwL210a19tZHBfY29yZS5jDQo+ICsrKyBiL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vbXRrLW1kcC9tdGtfbWRwX2NvcmUuYw0KPiBAQCAtMTcsNyArMTcs
NiBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiAgI2luY2x1ZGUg
PGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gICNpbmNsdWRlIDxsaW51eC93b3JrcXVldWUuaD4NCj4g
LSNpbmNsdWRlIDxzb2MvbWVkaWF0ZWsvc21pLmg+DQo+ICANCj4gICNpbmNsdWRlICJtdGtfbWRw
X2NvcmUuaCINCj4gICNpbmNsdWRlICJtdGtfbWRwX20ybS5oIg0KDQpSZXZpZXdlZC1ieTogSG91
bG9uZyBXZWkgPGhvdWxvbmcud2VpQG1lZGlhdGVrLmNvbT4NCg0K

