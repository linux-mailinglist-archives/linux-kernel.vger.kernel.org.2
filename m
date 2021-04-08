Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDB3357C0F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 07:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhDHF6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 01:58:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:34666 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229534AbhDHF6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 01:58:37 -0400
X-UUID: 340c60f63bd24233a634a4060606529a-20210408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=lMu54n3WM7h13T4KRXSxF20E2a6a7I6PmSwVbYUM2ys=;
        b=Bi6SOH460znrXWsR0YJziqBdrrZX6/YoEV+URq1eC4BUN2kxDlzJTH9q0I+7bD3UdP8834lCeKj+mAZWKnZ7rwppzkBQqEqo25bWYmTeTuLJv6fliY2yWF2U+Kg1Hfe2dBq/1/LmLOyju5EpfYC/QZUaXLX078HIsYmV+HMP6RY=;
X-UUID: 340c60f63bd24233a634a4060606529a-20210408
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <nina-cm.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 619939171; Thu, 08 Apr 2021 13:58:23 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 8 Apr 2021 13:58:21 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 8 Apr 2021 13:58:21 +0800
Message-ID: <1617861501.8874.4.camel@mtksdccf07>
Subject: Re: [PATCH v2 4/6] soc: mediatek: devapc: rename variable for new
 IC support
From:   Nina Wu <nina-cm.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <Jackson-kt.Chang@mediatek.com>
Date:   Thu, 8 Apr 2021 13:58:21 +0800
In-Reply-To: <a76686d1-3544-fcb9-4c3e-1498ec29ff47@gmail.com>
References: <1617259087-5502-1-git-send-email-nina-cm.wu@mediatek.com>
         <1617259087-5502-4-git-send-email-nina-cm.wu@mediatek.com>
         <a76686d1-3544-fcb9-4c3e-1498ec29ff47@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hdHRoaWFzDQoNCk9uIFR1ZSwgMjAyMS0wNC0wNiBhdCAxNTo0MyArMDIwMCwgTWF0dGhp
YXMgQnJ1Z2dlciB3cm90ZToNCj4gUmVnYXJkaW5nIHRoZSBjb21taXQgc3ViamVjdDoNCj4gInNv
YzogbWVkaWF0ZWs6IGRldmFwYzogcmVuYW1lIHZhcmlhYmxlIGZvciBuZXcgSUMgc3VwcG9ydCIN
Cj4gbWF5YmUgc29tZXRoaW5nIGxpa2U6DQo+ICJzb2M6IG1lZGlhdGVrOiBkZXZhcGM6IHJlbmFt
ZSByZWdpc3RlciB2YXJpYWJsZSBpbmZyYV9iYXNlIg0KPiANCj4gT3RoZXIgdGhlbiB0aGF0IGxv
b2tzIGdvb2QgdG8gbWUuDQo+IA0KDQpPSy4gSSB3aWxsIGZpeCBpdCBpbiB0aGUgbmV4dCB2ZXJz
aW9uLg0KDQpUaGFua3MNCg0KPiBPbiAwMS8wNC8yMDIxIDA4OjM4LCBOaW5hIFd1IHdyb3RlOg0K
PiA+IEZyb206IE5pbmEgV3UgPE5pbmEtQ00uV3VAbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEZv
ciBuZXcgSUNzLCB0aGVyZSBhcmUgbXVsdGlwbGUgZGV2YXBjIEhXcyBmb3IgZGlmZmVyZW50IHN1
YnN5cy4NCj4gPiBGb3IgZXhhbXBsZSwgdGhlcmUgaXMgZGV2YXBjIHJlc3BlY3RpdmVseSBmb3Ig
aW5mcmEsIHBlcmksIHBlcmkyLCBldGMuDQo+ID4gU28gd2UgcmVuYW1lIHRoZSB2YXJpYWJsZSAn
aW5mcmFfYmFzZScgdG8gJ2Jhc2UnIGZvciBjb2RlIHJlYWRhYmlsaXR5Lg0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IE5pbmEgV3UgPE5pbmEtQ00uV3VAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstZGV2YXBjLmMgfCAyNCArKysrKysrKysrKyst
LS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEyIGRl
bGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstZGV2YXBjLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstZGV2YXBjLmMNCj4gPiBpbmRl
eCA2OGMzZTM1Li5iY2Y2ZTNjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ay1kZXZhcGMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1kZXZhcGMu
Yw0KPiA+IEBAIC00NSw3ICs0NSw3IEBAIHN0cnVjdCBtdGtfZGV2YXBjX2RhdGEgew0KPiA+ICAN
Cj4gPiAgc3RydWN0IG10a19kZXZhcGNfY29udGV4dCB7DQo+ID4gIAlzdHJ1Y3QgZGV2aWNlICpk
ZXY7DQo+ID4gLQl2b2lkIF9faW9tZW0gKmluZnJhX2Jhc2U7DQo+ID4gKwl2b2lkIF9faW9tZW0g
KmJhc2U7DQo+ID4gIAl1MzIgdmlvX2lkeF9udW07DQo+ID4gIAlzdHJ1Y3QgY2xrICppbmZyYV9j
bGs7DQo+ID4gIAljb25zdCBzdHJ1Y3QgbXRrX2RldmFwY19kYXRhICpkYXRhOw0KPiA+IEBAIC01
Niw3ICs1Niw3IEBAIHN0YXRpYyB2b2lkIGNsZWFyX3Zpb19zdGF0dXMoc3RydWN0IG10a19kZXZh
cGNfY29udGV4dCAqY3R4KQ0KPiA+ICAJdm9pZCBfX2lvbWVtICpyZWc7DQo+ID4gIAlpbnQgaTsN
Cj4gPiAgDQo+ID4gLQlyZWcgPSBjdHgtPmluZnJhX2Jhc2UgKyBjdHgtPmRhdGEtPnZpb19zdGFf
b2Zmc2V0Ow0KPiA+ICsJcmVnID0gY3R4LT5iYXNlICsgY3R4LT5kYXRhLT52aW9fc3RhX29mZnNl
dDsNCj4gPiAgDQo+ID4gIAlmb3IgKGkgPSAwOyBpIDwgVklPX01PRF9UT19SRUdfSU5EKGN0eC0+
dmlvX2lkeF9udW0gLSAxKTsgaSsrKQ0KPiA+ICAJCXdyaXRlbChHRU5NQVNLKDMxLCAwKSwgcmVn
ICsgNCAqIGkpOw0KPiA+IEBAIC03MSw3ICs3MSw3IEBAIHN0YXRpYyB2b2lkIG1hc2tfbW9kdWxl
X2lycShzdHJ1Y3QgbXRrX2RldmFwY19jb250ZXh0ICpjdHgsIGJvb2wgbWFzaykNCj4gPiAgCXUz
MiB2YWw7DQo+ID4gIAlpbnQgaTsNCj4gPiAgDQo+ID4gLQlyZWcgPSBjdHgtPmluZnJhX2Jhc2Ug
KyBjdHgtPmRhdGEtPnZpb19tYXNrX29mZnNldDsNCj4gPiArCXJlZyA9IGN0eC0+YmFzZSArIGN0
eC0+ZGF0YS0+dmlvX21hc2tfb2Zmc2V0Ow0KPiA+ICANCj4gPiAgCWlmIChtYXNrKQ0KPiA+ICAJ
CXZhbCA9IEdFTk1BU0soMzEsIDApOw0KPiA+IEBAIC0xMTMsMTEgKzExMywxMSBAQCBzdGF0aWMg
aW50IGRldmFwY19zeW5jX3Zpb19kYmcoc3RydWN0IG10a19kZXZhcGNfY29udGV4dCAqY3R4KQ0K
PiA+ICAJaW50IHJldDsNCj4gPiAgCXUzMiB2YWw7DQo+ID4gIA0KPiA+IC0JcGRfdmlvX3NoaWZ0
X3N0YV9yZWcgPSBjdHgtPmluZnJhX2Jhc2UgKw0KPiA+ICsJcGRfdmlvX3NoaWZ0X3N0YV9yZWcg
PSBjdHgtPmJhc2UgKw0KPiA+ICAJCQkgICAgICAgY3R4LT5kYXRhLT52aW9fc2hpZnRfc3RhX29m
ZnNldDsNCj4gPiAtCXBkX3Zpb19zaGlmdF9zZWxfcmVnID0gY3R4LT5pbmZyYV9iYXNlICsNCj4g
PiArCXBkX3Zpb19zaGlmdF9zZWxfcmVnID0gY3R4LT5iYXNlICsNCj4gPiAgCQkJICAgICAgIGN0
eC0+ZGF0YS0+dmlvX3NoaWZ0X3NlbF9vZmZzZXQ7DQo+ID4gLQlwZF92aW9fc2hpZnRfY29uX3Jl
ZyA9IGN0eC0+aW5mcmFfYmFzZSArDQo+ID4gKwlwZF92aW9fc2hpZnRfY29uX3JlZyA9IGN0eC0+
YmFzZSArDQo+ID4gIAkJCSAgICAgICBjdHgtPmRhdGEtPnZpb19zaGlmdF9jb25fb2Zmc2V0Ow0K
PiA+ICANCj4gPiAgCS8qIEZpbmQgdGhlIG1pbmltdW0gc2hpZnQgZ3JvdXAgd2hpY2ggaGFzIHZp
b2xhdGlvbiAqLw0KPiA+IEBAIC0xNTksOCArMTU5LDggQEAgc3RhdGljIHZvaWQgZGV2YXBjX2V4
dHJhY3RfdmlvX2RiZyhzdHJ1Y3QgbXRrX2RldmFwY19jb250ZXh0ICpjdHgpDQo+ID4gIAl2b2lk
IF9faW9tZW0gKnZpb19kYmcwX3JlZzsNCj4gPiAgCXZvaWQgX19pb21lbSAqdmlvX2RiZzFfcmVn
Ow0KPiA+ICANCj4gPiAtCXZpb19kYmcwX3JlZyA9IGN0eC0+aW5mcmFfYmFzZSArIGN0eC0+ZGF0
YS0+dmlvX2RiZzBfb2Zmc2V0Ow0KPiA+IC0JdmlvX2RiZzFfcmVnID0gY3R4LT5pbmZyYV9iYXNl
ICsgY3R4LT5kYXRhLT52aW9fZGJnMV9vZmZzZXQ7DQo+ID4gKwl2aW9fZGJnMF9yZWcgPSBjdHgt
PmJhc2UgKyBjdHgtPmRhdGEtPnZpb19kYmcwX29mZnNldDsNCj4gPiArCXZpb19kYmcxX3JlZyA9
IGN0eC0+YmFzZSArIGN0eC0+ZGF0YS0+dmlvX2RiZzFfb2Zmc2V0Ow0KPiA+ICANCj4gPiAgCXZp
b19kYmdzLnZpb19kYmcwID0gcmVhZGwodmlvX2RiZzBfcmVnKTsNCj4gPiAgCXZpb19kYmdzLnZp
b19kYmcxID0gcmVhZGwodmlvX2RiZzFfcmVnKTsNCj4gPiBAQCAtMTk4LDcgKzE5OCw3IEBAIHN0
YXRpYyBpcnFyZXR1cm5fdCBkZXZhcGNfdmlvbGF0aW9uX2lycShpbnQgaXJxX251bWJlciwgdm9p
ZCAqZGF0YSkNCj4gPiAgICovDQo+ID4gIHN0YXRpYyB2b2lkIHN0YXJ0X2RldmFwYyhzdHJ1Y3Qg
bXRrX2RldmFwY19jb250ZXh0ICpjdHgpDQo+ID4gIHsNCj4gPiAtCXdyaXRlbChCSVQoMzEpLCBj
dHgtPmluZnJhX2Jhc2UgKyBjdHgtPmRhdGEtPmFwY19jb25fb2Zmc2V0KTsNCj4gPiArCXdyaXRl
bChCSVQoMzEpLCBjdHgtPmJhc2UgKyBjdHgtPmRhdGEtPmFwY19jb25fb2Zmc2V0KTsNCj4gPiAg
DQo+ID4gIAltYXNrX21vZHVsZV9pcnEoY3R4LCBmYWxzZSk7DQo+ID4gIH0NCj4gPiBAQCAtMjEw
LDcgKzIxMCw3IEBAIHN0YXRpYyB2b2lkIHN0b3BfZGV2YXBjKHN0cnVjdCBtdGtfZGV2YXBjX2Nv
bnRleHQgKmN0eCkNCj4gPiAgew0KPiA+ICAJbWFza19tb2R1bGVfaXJxKGN0eCwgdHJ1ZSk7DQo+
ID4gIA0KPiA+IC0Jd3JpdGVsKEJJVCgyKSwgY3R4LT5pbmZyYV9iYXNlICsgY3R4LT5kYXRhLT5h
cGNfY29uX29mZnNldCk7DQo+ID4gKwl3cml0ZWwoQklUKDIpLCBjdHgtPmJhc2UgKyBjdHgtPmRh
dGEtPmFwY19jb25fb2Zmc2V0KTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgc3RhdGljIGNvbnN0IHN0
cnVjdCBtdGtfZGV2YXBjX2RhdGEgZGV2YXBjX210Njc3OSA9IHsNCj4gPiBAQCAtMjQ5LDggKzI0
OSw4IEBAIHN0YXRpYyBpbnQgbXRrX2RldmFwY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPiA+ICAJY3R4LT5kYXRhID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCZwZGV2
LT5kZXYpOw0KPiA+ICAJY3R4LT5kZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICANCj4gPiAtCWN0eC0+
aW5mcmFfYmFzZSA9IG9mX2lvbWFwKG5vZGUsIDApOw0KPiA+IC0JaWYgKCFjdHgtPmluZnJhX2Jh
c2UpDQo+ID4gKwljdHgtPmJhc2UgPSBvZl9pb21hcChub2RlLCAwKTsNCj4gPiArCWlmICghY3R4
LT5iYXNlKQ0KPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+ICANCj4gPiAgCWlmIChvZl9wcm9w
ZXJ0eV9yZWFkX3UzMihub2RlLCAidmlvX2lkeF9udW0iLCAmY3R4LT52aW9faWR4X251bSkpDQo+
ID4gDQoNCg==

