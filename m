Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF03306FD3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhA1Hks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:40:48 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:18000 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232080AbhA1HkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:40:14 -0500
X-UUID: 5ab0d80cf6a1473d88016470d4d4767f-20210128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=5Sfop1PtYGQUduRyL0SKK4UxMHpv4G8/L7ZQ91LlTok=;
        b=YdrKKkQ4E8A0QUr7Q/gR/rA/wT9E2fYe9jmo8ofz1/64vV0rE3Iomv3EuA1mMJVvBPlIjq1CAK/5p0nPLA/NwG8io2mMC3ropOhcUnjgD1Fv8co5Z+ayjOpmZ2ZE90kE9YDc0GC/P04C/4A7tSyven+eg8c5tVnKGxbZT7hcWu8=;
X-UUID: 5ab0d80cf6a1473d88016470d4d4767f-20210128
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1987687882; Thu, 28 Jan 2021 15:39:20 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Jan 2021 15:39:12 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Jan 2021 15:39:12 +0800
Message-ID: <1611819552.16091.1.camel@mtksdaap41>
Subject: Re: [PATCH v11 4/9] drm/mediatek: add mtk_dither_set_common()
 function
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Date:   Thu, 28 Jan 2021 15:39:12 +0800
In-Reply-To: <20210128072802.830971-5-hsinyi@chromium.org>
References: <20210128072802.830971-1-hsinyi@chromium.org>
         <20210128072802.830971-5-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 079BE8C6A619A54B65635DC05D10741DADDEA17ADE9AC0EA5D43112F5A34835F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTI4IGF0IDE1OjI3ICswODAwLCBIc2luLVlpIFdhbmcgd3JvdGU6DQo+
IEN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgbXRrX2RpdGhlcl9zZXQoKSBjYXN0IGRldiBkYXRh
IHRvDQo+IHN0cnVjdCBtdGtfZGRwX2NvbXBfZGV2LiBCdXQgb3RoZXIgZGV2aWNlcyB3aXRoIGRp
ZmZlcmVudCBkZXYgZGF0YQ0KPiB3b3VsZCBhbHNvIGNhbGwgdGhpcyBmdW5jdGlvbi4NCj4gDQo+
IFNlcGFyYXRlIG5lY2Vzc2FyeSBwYXJhbWV0ZXJzIG91dCBzbyBvdGhlciBkZXZpY2UgY29tcG9u
ZW50cyAoZGl0aGVyLA0KPiBnYW1tYSkgY2FuIGNhbGwgdGhpcyBmdW5jdGlvbi4NCg0KUmV2aWV3
ZWQtYnk6IENLIEh1IDxjay5odUBtZWRpYXRlay5jb20+DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEhzaW4tWWkgV2FuZyA8aHNpbnlpQGNocm9taXVtLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgIHwgIDQgKysrKw0KPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYyB8IDI1ICsrKysrKysrKysrKystLS0t
LS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9k
cnYuaCBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiBpbmRleCA0
NmQxOTliN2I0YTI5Li5jNTBkNWZjOWZkMzQ5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kaXNwX2Rydi5oDQo+IEBAIC0xNyw2ICsxNywxMCBAQCB2b2lkIG10a19jb2xvcl9j
b25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgdywNCj4gIAkJICAgICAgdW5z
aWduZWQgaW50IGJwYywgc3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCk7DQo+ICB2b2lkIG10a19j
b2xvcl9zdGFydChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgDQo+ICt2b2lkIG10a19kaXRoZXJf
c2V0X2NvbW1vbih2b2lkIF9faW9tZW0gKnJlZ3MsIHN0cnVjdCBjbWRxX2NsaWVudF9yZWcgKmNt
ZHFfcmVnLA0KPiArCQkJICAgdW5zaWduZWQgaW50IGJwYywgdW5zaWduZWQgaW50IENGRywNCj4g
KwkJCSAgIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QpOw0KPiArDQo+ICB2b2lkIG10a19kcGlf
c3RhcnQoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gIHZvaWQgbXRrX2RwaV9zdG9wKHN0cnVjdCBk
ZXZpY2UgKmRldik7DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2RkcF9jb21wLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9k
ZHBfY29tcC5jDQo+IGluZGV4IDdiNTI5MzQyOTQyNmQuLjUzZDI1ODIzYTM3Y2MgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gKysr
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBAQCAtMTUx
LDMzICsxNTEsNDAgQEAgc3RhdGljIHZvaWQgbXRrX2RkcF9jbGtfZGlzYWJsZShzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ICAJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHByaXYtPmNsayk7DQo+ICB9DQo+
ICANCj4gLXN0YXRpYyB2b2lkIG10a19kaXRoZXJfc2V0KHN0cnVjdCBkZXZpY2UgKmRldiwgdW5z
aWduZWQgaW50IGJwYywNCj4gLQkJICAgIHVuc2lnbmVkIGludCBDRkcsIHN0cnVjdCBjbWRxX3Br
dCAqY21kcV9wa3QpDQo+IC17DQo+IC0Jc3RydWN0IG10a19kZHBfY29tcF9kZXYgKnByaXYgPSBk
ZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gIA0KPiArdm9pZCBtdGtfZGl0aGVyX3NldF9jb21tb24o
dm9pZCBfX2lvbWVtICpyZWdzLCBzdHJ1Y3QgY21kcV9jbGllbnRfcmVnICpjbWRxX3JlZywNCj4g
KwkJCSAgIHVuc2lnbmVkIGludCBicGMsIHVuc2lnbmVkIGludCBDRkcsIHN0cnVjdCBjbWRxX3Br
dCAqY21kcV9wa3QpDQo+ICt7DQo+ICAJLyogSWYgYnBjIGVxdWFsIHRvIDAsIHRoZSBkaXRoZXJp
bmcgZnVuY3Rpb24gZGlkbid0IGJlIGVuYWJsZWQgKi8NCj4gIAlpZiAoYnBjID09IDApDQo+ICAJ
CXJldHVybjsNCj4gIA0KPiAgCWlmIChicGMgPj0gTVRLX01JTl9CUEMpIHsNCj4gLQkJbXRrX2Rk
cF93cml0ZShjbWRxX3BrdCwgMCwgJnByaXYtPmNtZHFfcmVnLCBwcml2LT5yZWdzLCBESVNQX0RJ
VEhFUl81KTsNCj4gLQkJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgMCwgJnByaXYtPmNtZHFfcmVn
LCBwcml2LT5yZWdzLCBESVNQX0RJVEhFUl83KTsNCj4gKwkJbXRrX2RkcF93cml0ZShjbWRxX3Br
dCwgMCwgY21kcV9yZWcsIHJlZ3MsIERJU1BfRElUSEVSXzUpOw0KPiArCQltdGtfZGRwX3dyaXRl
KGNtZHFfcGt0LCAwLCBjbWRxX3JlZywgcmVncywgRElTUF9ESVRIRVJfNyk7DQo+ICAJCW10a19k
ZHBfd3JpdGUoY21kcV9wa3QsDQo+ICAJCQkgICAgICBESVRIRVJfTFNCX0VSUl9TSElGVF9SKE1U
S19NQVhfQlBDIC0gYnBjKSB8DQo+ICAJCQkgICAgICBESVRIRVJfQUREX0xTSElGVF9SKE1US19N
QVhfQlBDIC0gYnBjKSB8DQo+ICAJCQkgICAgICBESVRIRVJfTkVXX0JJVF9NT0RFLA0KPiAtCQkJ
ICAgICAgJnByaXYtPmNtZHFfcmVnLCBwcml2LT5yZWdzLCBESVNQX0RJVEhFUl8xNSk7DQo+ICsJ
CQkgICAgICBjbWRxX3JlZywgcmVncywgRElTUF9ESVRIRVJfMTUpOw0KPiAgCQltdGtfZGRwX3dy
aXRlKGNtZHFfcGt0LA0KPiAgCQkJICAgICAgRElUSEVSX0xTQl9FUlJfU0hJRlRfQihNVEtfTUFY
X0JQQyAtIGJwYykgfA0KPiAgCQkJICAgICAgRElUSEVSX0FERF9MU0hJRlRfQihNVEtfTUFYX0JQ
QyAtIGJwYykgfA0KPiAgCQkJICAgICAgRElUSEVSX0xTQl9FUlJfU0hJRlRfRyhNVEtfTUFYX0JQ
QyAtIGJwYykgfA0KPiAgCQkJICAgICAgRElUSEVSX0FERF9MU0hJRlRfRyhNVEtfTUFYX0JQQyAt
IGJwYyksDQo+IC0JCQkgICAgICAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsIERJU1BfRElU
SEVSXzE2KTsNCj4gLQkJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgRElTUF9ESVRIRVJJTkcsICZw
cml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywgQ0ZHKTsNCj4gKwkJCSAgICAgIGNtZHFfcmVnLCBy
ZWdzLCBESVNQX0RJVEhFUl8xNik7DQo+ICsJCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIERJU1Bf
RElUSEVSSU5HLCBjbWRxX3JlZywgcmVncywgQ0ZHKTsNCj4gIAl9DQo+ICB9DQo+ICANCj4gK3N0
YXRpYyB2b2lkIG10a19kaXRoZXJfc2V0KHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50
IGJwYywNCj4gKwkJICAgIHVuc2lnbmVkIGludCBDRkcsIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9w
a3QpDQo+ICt7DQo+ICsJc3RydWN0IG10a19kZHBfY29tcF9kZXYgKnByaXYgPSBkZXZfZ2V0X2Ry
dmRhdGEoZGV2KTsNCj4gKw0KPiArCW10a19kaXRoZXJfc2V0X2NvbW1vbihwcml2LT5yZWdzLCAm
cHJpdi0+Y21kcV9yZWcsIGJwYywgQ0ZHLCBjbWRxX3BrdCk7DQo+ICt9DQo+ICsNCj4gIHN0YXRp
YyB2b2lkIG10a19vZF9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgdywN
Cj4gIAkJCSAgdW5zaWduZWQgaW50IGgsIHVuc2lnbmVkIGludCB2cmVmcmVzaCwNCj4gIAkJCSAg
dW5zaWduZWQgaW50IGJwYywgc3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCkNCg0K

