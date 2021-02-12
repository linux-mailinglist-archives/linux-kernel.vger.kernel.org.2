Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95D631A3AB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 18:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhBLRa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 12:30:29 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3441 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbhBLR3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 12:29:23 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DcgRM2rSbz5RKj;
        Sat, 13 Feb 2021 01:27:11 +0800 (CST)
Received: from dggemm751-chm.china.huawei.com (10.1.198.57) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Sat, 13 Feb 2021 01:28:37 +0800
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggemm751-chm.china.huawei.com (10.1.198.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sat, 13 Feb 2021 01:28:36 +0800
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.2106.006; Fri, 12 Feb 2021 17:28:34 +0000
From:   Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "will@kernel.org" <will@kernel.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
Subject: RE: [PATCH v2] iommu: Check dev->iommu in iommu_dev_xxx functions
Thread-Topic: [PATCH v2] iommu: Check dev->iommu in iommu_dev_xxx functions
Thread-Index: AdcBTrfjz4ngs6VWSn6F9Rp3qrl5mQADsiaAAAAQ0NAAAVXqEA==
Date:   Fri, 12 Feb 2021 17:28:34 +0000
Message-ID: <33cf95925cfb47dda3ee472e00b9846c@huawei.com>
References: <c82f6d0cced74c43947714e7de576d5a@huawei.com>
 <d541ebeb-5b89-7a9d-50a2-3867f9cf78b3@arm.com> 
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.89.255]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhbWVlcmFsaSBLb2xv
dGh1bSBUaG9kaQ0KPiBTZW50OiAxMiBGZWJydWFyeSAyMDIxIDE2OjQ1DQo+IFRvOiAnUm9iaW4g
TXVycGh5JyA8cm9iaW4ubXVycGh5QGFybS5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOw0KPiBpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZw0KPiBDYzogam9yb0A4Ynl0
ZXMub3JnOyBqZWFuLXBoaWxpcHBlQGxpbmFyby5vcmc7IHdpbGxAa2VybmVsLm9yZzsgWmVuZ3Rh
byAoQikNCj4gPHByaW1lLnplbmdAaGlzaWxpY29uLmNvbT47IGxpbnV4YXJtQG9wZW5ldWxlci5v
cmcNCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2Ml0gaW9tbXU6IENoZWNrIGRldi0+aW9tbXUgaW4g
aW9tbXVfZGV2X3h4eCBmdW5jdGlvbnMNCj4gDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+IEZyb206IFJvYmluIE11cnBoeSBbbWFpbHRvOnJvYmluLm11cnBoeUBh
cm0uY29tXQ0KPiA+IFNlbnQ6IDEyIEZlYnJ1YXJ5IDIwMjEgMTY6MzkNCj4gPiBUbzogU2hhbWVl
cmFsaSBLb2xvdGh1bSBUaG9kaSA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29t
PjsNCj4gPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZw0KPiA+IENjOiBqb3JvQDhieXRlcy5vcmc7IGplYW4tcGhpbGlwcGVAbGlu
YXJvLm9yZzsgd2lsbEBrZXJuZWwub3JnOyBaZW5ndGFvIChCKQ0KPiA+IDxwcmltZS56ZW5nQGhp
c2lsaWNvbi5jb20+OyBsaW51eGFybUBvcGVuZXVsZXIub3JnDQo+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2Ml0gaW9tbXU6IENoZWNrIGRldi0+aW9tbXUgaW4gaW9tbXVfZGV2X3h4eA0KPiBmdW5j
dGlvbnMNCj4gPg0KPiA+IE9uIDIwMjEtMDItMTIgMTQ6NTQsIFNoYW1lZXJhbGkgS29sb3RodW0g
VGhvZGkgd3JvdGU6DQo+ID4gPiBIaSBSb2Jpbi9Kb2VyZywNCj4gPiA+DQo+ID4gPj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+PiBGcm9tOiBTaGFtZWVyIEtvbG90aHVtDQo+IFtt
YWlsdG86c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBodWF3ZWkuY29tXQ0KPiA+ID4+IFNlbnQ6
IDAxIEZlYnJ1YXJ5IDIwMjEgMTI6NDENCj4gPiA+PiBUbzogbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcNCj4gPiA+PiBDYzogam9y
b0A4Ynl0ZXMub3JnOyByb2Jpbi5tdXJwaHlAYXJtLmNvbTsgamVhbi1waGlsaXBwZUBsaW5hcm8u
b3JnOw0KPiA+ID4+IHdpbGxAa2VybmVsLm9yZzsgWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlz
aWxpY29uLmNvbT47DQo+ID4gPj4gbGludXhhcm1Ab3BlbmV1bGVyLm9yZw0KPiA+ID4+IFN1Ympl
Y3Q6IFtMaW51eGFybV0gW1BBVENIIHYyXSBpb21tdTogQ2hlY2sgZGV2LT5pb21tdSBpbg0KPiA+
IGlvbW11X2Rldl94eHgNCj4gPiA+PiBmdW5jdGlvbnMNCj4gPiA+Pg0KPiA+ID4+IFRoZSBkZXZp
Y2UgaW9tbXUgcHJvYmUvYXR0YWNoIG1pZ2h0IGhhdmUgZmFpbGVkIGxlYXZpbmcgZGV2LT5pb21t
dQ0KPiA+ID4+IHRvIE5VTEwgYW5kIGRldmljZSBkcml2ZXJzIG1heSBzdGlsbCBpbnZva2UgdGhl
c2UgZnVuY3Rpb25zIHJlc3VsdGluZw0KPiA+ID4+IGluIGEgY3Jhc2ggaW4gaW9tbXUgdmVuZG9y
IGRyaXZlciBjb2RlLiBIZW5jZSBtYWtlIHN1cmUgd2UgY2hlY2sgdGhhdC4NCj4gPiA+Pg0KPiA+
ID4+IEFsc28gYWRkZWQgaW9tbXVfb3BzIHRvIHRoZSAic3RydWN0IGRldl9pb21tdSIgYW5kIHNl
dCBpdCBpZiB0aGUgZGV2DQo+ID4gPj4gaXMgc3VjY2Vzc2Z1bGx5IGFzc29jaWF0ZWQgd2l0aCBh
biBpb21tdS4NCj4gPiA+Pg0KPiA+ID4+IEZpeGVzOsKgYTNhMTk1OTI5ZDQwICgiaW9tbXU6IEFk
ZCBBUElzIGZvciBtdWx0aXBsZSBkb21haW5zIHBlcg0KPiBkZXZpY2UiKQ0KPiA+ID4+IFNpZ25l
ZC1vZmYtYnk6IFNoYW1lZXIgS29sb3RodW0NCj4gPiA8c2hhbWVlcmFsaS5rb2xvdGh1bS50aG9k
aUBodWF3ZWkuY29tPg0KPiA+ID4+IC0tLQ0KPiA+ID4+IHYxIC0tPiB2MjoNCj4gPiA+PiAgIC1B
ZGRlZCBpb21tdV9vcHMgdG8gc3RydWN0IGRldl9pb21tdSBiYXNlZCBvbiB0aGUgZGlzY3Vzc2lv
biB3aXRoDQo+ID4gUm9iaW4uDQo+ID4gPj4gICAtUmViYXNlZCBhZ2FpbnN0IGlvbW11LXRyZWUg
Y29yZSBicmFuY2guDQo+ID4gPg0KPiA+ID4gQSBnZW50bGUgcGluZyBvbiB0aGlzLi4uDQo+ID4N
Cj4gPiBJcyB0aGVyZSBhIGNvbnZpbmNpbmcganVzdGlmaWNhdGlvbiBmb3IgbWFpbnRhaW5pbmcg
eWV0IGFub3RoZXIgY29weSBvZg0KPiA+IHRoZSBvcHMgcG9pbnRlciByYXRoZXIgdGhhbiBzaW1w
bHkgZGVyZWZlcmVuY2luZyBpb21tdV9kZXYtPm9wcyBhdCBwb2ludA0KPiA+IG9mIHVzZT8NCj4g
Pg0KPiANCj4gVEJILCBub3RoaW5nIEkgY2FuIHRoaW5rIG9mIG5vdy4gVGhhdCB3YXMgbWFpbmx5
IHRoZSB3YXkgSSBpbnRlcnByZXRlZCB5b3VyDQo+IHN1Z2dlc3Rpb24NCj4gZnJvbSB0aGUgdjEu
ICBOb3cgaXQgbG9va3MgbGlrZSB5b3UgZGlkbuKAmXQgbWVhbiBpdCA6KS4gSSBhbSBPayB0byBy
ZXdvcmsgaXQgdG8NCj4gZGVyZWZlcmVuY2UNCj4gaXQgZnJvbSBpb21tdV9kZXYuIFBsZWFzZSBs
ZXQgbWUga25vdy4NCg0KU28gd2UgY2FuIGRvIHNvbWV0aGluZyBsaWtlIHRoaXMsDQoNCmluZGV4
IGZkNzZlMmY1NzlmZS4uNWZkMzFhM2NlYzE4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9p
b21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L2lvbW11LmMNCkBAIC0yODY1LDEwICsyODY1LDEy
IEBAIEVYUE9SVF9TWU1CT0xfR1BMKGlvbW11X2Z3c3BlY19hZGRfaWRzKTsNCiAgKi8NCiBpbnQg
aW9tbXVfZGV2X2VuYWJsZV9mZWF0dXJlKHN0cnVjdCBkZXZpY2UgKmRldiwgZW51bSBpb21tdV9k
ZXZfZmVhdHVyZXMgZmVhdCkNCiB7DQotICAgICAgIGNvbnN0IHN0cnVjdCBpb21tdV9vcHMgKm9w
cyA9IGRldi0+YnVzLT5pb21tdV9vcHM7DQorICAgICAgIGlmIChkZXYtPmlvbW11ICYmIGRldi0+
aW9tbXUtPmlvbW11X2RldiAmJiBkZXYtPmlvbW11LT5pb21tdV9kZXYtPm9wcykNCisgICAgICAg
ICAgICAgICBzdHJ1Y3QgaW9tbXVfb3BzICAqb3BzID0gZGV2LT5pb21tdS0+aW9tbXVfZGV2LT5v
cHM7DQogDQotICAgICAgIGlmIChvcHMgJiYgb3BzLT5kZXZfZW5hYmxlX2ZlYXQpDQotICAgICAg
ICAgICAgICAgcmV0dXJuIG9wcy0+ZGV2X2VuYWJsZV9mZWF0KGRldiwgZmVhdCk7DQorICAgICAg
ICAgICAgICAgaWYgKG9wcy0+ZGV2X2VuYWJsZV9mZWF0KQ0KKyAgICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIG9wcy0+ZGV2X2VuYWJsZV9mZWF0KGRldiwgZmVhdCk7DQorICAgICAgIH0NCiAN
CiAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQogfQ0KDQpBZ2Fpbiwgbm90IHN1cmUgd2UgbmVlZCB0
byBkbyB0aGUgY2hlY2tpbmcgZm9yIGlvbW11LT5kZXYgYW5kIG9wcyBoZXJlLiBJZiB0aGUNCmRl
di0+aW9tbXUgaXMgc2V0LCBpcyBpdCBzYWZlIHRvIGFzc3VtZSB0aGF0IHdlIGhhdmUgYSB2YWxp
ZCBpb21tdS0+aW9tbXVfZGV2DQphbmQgb3BzIGFsd2F5cz8gKE1heSBiZSBpdCBpcyBzYWZlciB0
byBkbyB0aGUgY2hlY2tpbmcgaW4gY2FzZSBzb21ldGhpbmcNCmVsc2UgYnJlYWtzIHRoaXMgYXNz
dW1wdGlvbiBpbiBmdXR1cmUpLiBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cy4NCg0K
VGhhbmtzLA0KU2hhbWVlcg0KDQoNCg==
