Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39A4308345
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 02:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhA2BeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 20:34:23 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:7585 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231451AbhA2Bd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 20:33:57 -0500
X-UUID: 0ae9d5946d4046ae93f30ae54c3f474b-20210129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=osPAg0K5Yd7X9cjShUvPGC/GtiMhGLI3vpW3QQq8WXs=;
        b=SVbp7fctsNo7VFTjJqTqn78oe51H5KAUusyw1m52NIs+N/2N9YjYM/NQqd0jfwnBv67qgdLa1Blkzbt70bLt8z8HRpZjfndb0/kSaIdqHBYRwTFEAk3z/boc52W5XqumjhhYghTm+4Ysx3djUOVCzYS9rEm/N9GT9loVjV+HEH4=;
X-UUID: 0ae9d5946d4046ae93f30ae54c3f474b-20210129
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 639592366; Fri, 29 Jan 2021 09:33:07 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 29 Jan 2021 09:33:02 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 29 Jan 2021 09:33:02 +0800
Message-ID: <1611883982.5226.12.camel@mtksdaap41>
Subject: Re: [PATCH v12 6/8] drm/mediatek: enable dither function
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
Date:   Fri, 29 Jan 2021 09:33:02 +0800
In-Reply-To: <20210128112314.1304160-7-hsinyi@chromium.org>
References: <20210128112314.1304160-1-hsinyi@chromium.org>
         <20210128112314.1304160-7-hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 61173972B03CFC5DDB5831DC8F9D30A79FD4418A4F9F31FD79A0881E77BA28132000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaW4tWWk6DQoNCk9uIFRodSwgMjAyMS0wMS0yOCBhdCAxOToyMyArMDgwMCwgSHNpbi1Z
aSBXYW5nIHdyb3RlOg0KPiBGcm9tOiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlh
dGVrLmNvbT4NCj4gDQo+IGZvciA1IG9yIDYgYnBjIHBhbmVsLCB3ZSBuZWVkIGVuYWJsZSBkaXRo
ZXIgZnVuY3Rpb24NCj4gdG8gaW1wcm92ZSB0aGUgZGlzcGxheSBxdWFsaXR5DQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogSHNpbi1ZaSBXYW5nIDxoc2lueWlAY2hyb21pdW0ub3JnPg0KPiAtLS0N
Cj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMgfCAxNSArKysr
KysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHJtX2RkcF9jb21wLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29t
cC5jDQo+IGluZGV4IGFjMmNiMjU2MjAzNTcuLjZjOGYyNDYzODBhNzQgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBAQCAtNTMsNiArNTMs
NyBAQA0KPiAgI2RlZmluZSBESVRIRVJfRU4JCQkJQklUKDApDQo+ICAjZGVmaW5lIERJU1BfRElU
SEVSX0NGRwkJCQkweDAwMjANCj4gICNkZWZpbmUgRElUSEVSX1JFTEFZX01PREUJCQlCSVQoMCkN
Cj4gKyNkZWZpbmUgRElUSEVSX0VOR0lORV9FTgkJCUJJVCgxKQ0KPiAgI2RlZmluZSBESVNQX0RJ
VEhFUl9TSVpFCQkJMHgwMDMwDQo+ICANCj4gICNkZWZpbmUgTFVUXzEwQklUX01BU0sJCQkJMHgw
M2ZmDQo+IEBAIC0zMTQsOSArMzE1LDE5IEBAIHN0YXRpYyB2b2lkIG10a19kaXRoZXJfY29uZmln
KHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IHcsDQo+ICAJCQkgICAgICB1bnNpZ25l
ZCBpbnQgYnBjLCBzdHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0KQ0KPiAgew0KPiAgCXN0cnVjdCBt
dGtfZGRwX2NvbXBfZGV2ICpwcml2ID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ICsJYm9vbCBl
bmFibGUgPSAoYnBjID09IDUgfHwgYnBjID09IDYpOw0KDQpJIHN0cm9uZ2x5IGJlbGlldmUgdGhh
dCBkaXRoZXIgZnVuY3Rpb24gaW4gZGl0aGVyIGlzIGlkZW50aWNhbCB0byB0aGUNCm9uZSBpbiBn
YW1tYSBhbmQgb2QsIGFuZCBpbiBtdGtfZGl0aGVyX3NldF9jb21tb24oKSwgJ2JwYyA+PQ0KTVRL
X01JTl9CUEMnIGlzIHZhbGlkLCBzbyBJIGJlbGlldmUgd2UgbmVlZCBub3QgdG8gbGltaXQgYnBj
IHRvIDUgb3IgNi4NCkJ1dCB3ZSBzaG91bGQgY29uc2lkZXIgdGhlIGNhc2UgdGhhdCBicGMgaXMg
aW52YWxpZCBpbg0KbXRrX2RpdGhlcl9zZXRfY29tbW9uKCkuIEludmFsaWQgY2FzZSBpbiBnYW1t
YSBhbmQgb2QgdXNlIGRpZmZlcmVudCB3YXkNCnRvIHByb2Nlc3MuIEZvciBnYW1tYSwgZGl0aGVy
IGlzIGRlZmF1bHQgcmVsYXkgbW9kZSwgc28gaW52YWxpZCBicGMNCndvdWxkIGRvIG5vdGhpbmcg
aW4gbXRrX2RpdGhlcl9zZXRfY29tbW9uKCkgYW5kIHJlc3VsdCBpbiByZWxheSBtb2RlLg0KRm9y
IG9kLCBpdCBzZXQgdG8gcmVsYXkgbW9kZSBmaXJzdCwgdGhlbSBpbnZhbGlkIGJwYyB3b3VsZCBk
byBub3RoaW5nIGluDQptdGtfZGl0aGVyX3NldF9jb21tb24oKSBhbmQgcmVzdWx0IGluIHJlbGF5
IG1vZGUuIEkgd291bGQgbGlrZSBkaXRoZXIsDQpnYW1tYSBhbmQgb2QgdG8gcHJvY2VzcyBpbnZh
bGlkIGJwYyBpbiB0aGUgc2FtZSB3YXkuIE9uZSBzb2x1dGlvbiBpcyB0bw0Kc2V0IHJlbGF5IG1v
ZGUgaW4gbXRrX2RpdGhlcl9zZXRfY29tbW9uKCkgZm9yIGludmFsaWQgYnBjLg0KDQpSZWdhcmRz
LA0KQ0sNCg0KPiAgDQo+IC0JbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgaCA8PCAxNiB8IHcsICZw
cml2LT5jbWRxX3JlZywgcHJpdi0+cmVncywgRElTUF9ESVRIRVJfU0laRSk7DQo+IC0JbXRrX2Rk
cF93cml0ZShjbWRxX3BrdCwgRElUSEVSX1JFTEFZX01PREUsICZwcml2LT5jbWRxX3JlZywgcHJp
di0+cmVncywgRElTUF9ESVRIRVJfQ0ZHKTsNCj4gKwlpZiAoZW5hYmxlKSB7DQo+ICsJCW10a19k
aXRoZXJfc2V0X2NvbW1vbihwcml2LT5yZWdzLCAmcHJpdi0+Y21kcV9yZWcsIGJwYywNCj4gKwkJ
CQkgICAgICBESVNQX0RJVEhFUl9DRkcsIERJVEhFUl9FTkdJTkVfRU4sDQo+ICsJCQkJICAgICAg
Y21kcV9wa3QpOw0KPiArCX0gZWxzZSB7DQo+ICsJCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIERJ
VEhFUl9SRUxBWV9NT0RFLCAmcHJpdi0+Y21kcV9yZWcsDQo+ICsJCQkgICAgICBwcml2LT5yZWdz
LCBESVNQX0RJVEhFUl9DRkcpOw0KPiArCX0NCj4gKw0KPiArCW10a19kZHBfd3JpdGUoY21kcV9w
a3QsIGggPDwgMTYgfCB3LCAmcHJpdi0+Y21kcV9yZWcsIHByaXYtPnJlZ3MsDQo+ICsJCSAgICAg
IERJU1BfRElUSEVSX1NJWkUpOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMgdm9pZCBtdGtfZGl0aGVy
X3N0YXJ0KHN0cnVjdCBkZXZpY2UgKmRldikNCg0K

