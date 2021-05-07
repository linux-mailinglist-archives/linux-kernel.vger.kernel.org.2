Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7158A376332
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 11:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbhEGKAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 06:00:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:58918 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233487AbhEGKAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 06:00:32 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-124-XIgOuarZNwyN-c2JrDVmUg-1; Fri, 07 May 2021 10:59:29 +0100
X-MC-Unique: XIgOuarZNwyN-c2JrDVmUg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 7 May 2021 10:59:27 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.015; Fri, 7 May 2021 10:59:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Price' <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        "Suzuki K Poulose" <suzuki.poulose@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: RE: [PATCH v11 5/6] KVM: arm64: ioctl to fetch/store tags in a guest
Thread-Topic: [PATCH v11 5/6] KVM: arm64: ioctl to fetch/store tags in a guest
Thread-Index: AQHXQyWd0YdlNuDzYEavAjiQNQoHN6rXyCEQ
Date:   Fri, 7 May 2021 09:59:27 +0000
Message-ID: <42fd9c5ceb974be3b2aae5dd288507e8@AcuMS.aculab.com>
References: <20210416154309.22129-1-steven.price@arm.com>
 <20210416154309.22129-6-steven.price@arm.com>
 <20210427175844.GB17872@arm.com>
 <340d35c2-46ed-35ea-43fa-e5cb64c27230@arm.com> <YJGIBTor+blelKKT@arm.com>
 <25c85740-0119-549e-6ddb-aea69c5efc76@arm.com>
In-Reply-To: <25c85740-0119-549e-6ddb-aea69c5efc76@arm.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RldmVuIFByaWNlIDxzdGV2ZW4ucHJpY2VAYXJtLmNvbT4NCj4gU2VudDogMDcgTWF5
IDIwMjEgMTA6NDUNCj4gDQo+IE9uIDA0LzA1LzIwMjEgMTg6NDQsIENhdGFsaW4gTWFyaW5hcyB3
cm90ZToNCj4gPiBPbiBUaHUsIEFwciAyOSwgMjAyMSBhdCAwNTowNjowN1BNICswMTAwLCBTdGV2
ZW4gUHJpY2Ugd3JvdGU6DQo+ID4+IE9uIDI3LzA0LzIwMjEgMTg6NTgsIENhdGFsaW4gTWFyaW5h
cyB3cm90ZToNCj4gPj4+IE9uIEZyaSwgQXByIDE2LCAyMDIxIGF0IDA0OjQzOjA4UE0gKzAxMDAs
IFN0ZXZlbiBQcmljZSB3cm90ZToNCj4gPj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9pbmNs
dWRlL3VhcGkvYXNtL2t2bS5oIGIvYXJjaC9hcm02NC9pbmNsdWRlL3VhcGkvYXNtL2t2bS5oDQo+
ID4+Pj4gaW5kZXggMjQyMjNhZGFlMTUwLi4yYjg1YTA0N2MzN2QgMTAwNjQ0DQo+ID4+Pj4gLS0t
IGEvYXJjaC9hcm02NC9pbmNsdWRlL3VhcGkvYXNtL2t2bS5oDQo+ID4+Pj4gKysrIGIvYXJjaC9h
cm02NC9pbmNsdWRlL3VhcGkvYXNtL2t2bS5oDQo+ID4+Pj4gQEAgLTE4NCw2ICsxODQsMjAgQEAg
c3RydWN0IGt2bV92Y3B1X2V2ZW50cyB7DQo+ID4+Pj4gICAgCV9fdTMyIHJlc2VydmVkWzEyXTsN
Cj4gPj4+PiAgICB9Ow0KPiA+Pj4+ICtzdHJ1Y3Qga3ZtX2FybV9jb3B5X210ZV90YWdzIHsNCj4g
Pj4+PiArCV9fdTY0IGd1ZXN0X2lwYTsNCj4gPj4+PiArCV9fdTY0IGxlbmd0aDsNCj4gPj4+PiAr
CXVuaW9uIHsNCj4gPj4+PiArCQl2b2lkIF9fdXNlciAqYWRkcjsNCj4gPj4+PiArCQlfX3U2NCBw
YWRkaW5nOw0KPiA+Pj4+ICsJfTsNCj4gPj4+PiArCV9fdTY0IGZsYWdzOw0KPiA+Pj4+ICsJX191
NjQgcmVzZXJ2ZWRbMl07DQo+ID4+Pj4gK307DQo+ID4gWy4uLl0NCj4gPj4+IE1heWJlIGFkZCB0
aGUgdHdvIHJlc2VydmVkDQo+ID4+PiB2YWx1ZXMgdG8gdGhlIHVuaW9uIGluIGNhc2Ugd2Ugd2Fu
dCB0byBzdG9yZSBzb21ldGhpbmcgZWxzZSBpbiB0aGUNCj4gPj4+IGZ1dHVyZS4NCj4gPj4NCj4g
Pj4gSSdtIG5vdCBzdXJlIHdoYXQgeW91IG1lYW4gaGVyZS4gV2hhdCB3b3VsZCB0aGUgcmVzZXJ2
ZWQgZmllbGRzIGJlIHVuaW9uZWQNCj4gPj4gd2l0aD8gQW5kIHN1cmVseSB0aGV5IGFyZSBubyBs
b25nZXIgcmVzZXJ2ZWQgaW4gdGhhdCBjYXNlPw0KPiA+DQo+ID4gSW4gY2FzZSB5b3Ugd2FudCB0
byBrZWVwIHRoZSBzdHJ1Y3R1cmUgc2l6ZSB0aGUgc2FtZSBmb3IgZnV0dXJlDQo+ID4gZXhwYW5z
aW9uIGFuZCB0aGUgZXhwYW5zaW9uIG9ubHkgaGFwcGVucyB2aWEgdGhlIHVuaW9uLCB5b3UnZCBh
ZGQgc29tZQ0KPiA+IHBhZGRpbmcgaW4gdGhlcmUganVzdCBpbiBjYXNlLiBXZSBkbyB0aGlzIGZv
ciBzdHJ1Y3Qgc2lnaW5mbyB3aXRoIGFuDQo+ID4gX3NpX3BhZFtdIGFycmF5IGluIHRoZSB1bmlv
bi4NCj4gPg0KPiANCj4gQWggSSBzZWUgd2hhdCB5b3UgbWVhbi4gSW4gdGhpcyBjYXNlICJwYWRk
aW5nIiBpcyBqdXN0IGEgc2l6ZXIgdG8gZW5zdXJlDQo+IHRoYXQgZmxhZ3MgaXMgYWx3YXlzIHRo
ZSBzYW1lIGFsaWdubWVudCAtIGl0J3Mgbm90IGludGVuZGVkIHRvIGJlIHVzZWQuDQo+IEFzIEkg
bm90ZWQgcHJldmlvdXNseSB0aG91Z2ggaXQncyBjb21wbGV0ZWx5IHBvaW50bGVzcyBhcyB0aGlz
IG9ubHkgb24NCj4gYXJtNjQgYW5kIGV2ZW4gMzIgYml0IEFybSB3b3VsZCBuYXR1cmFsbHkgYWxp
Z24gdGhlIGZvbGxvd2luZyBfX3U2NC4NCg0KSXQgaXMgbmljZSB0byBiZSBleHBsaWNpdCB0aG91
Z2guDQpZb3UgYWxzbyBoYXZlIHRoZSBwcm9ibGVtIHRoYXQgYSAzMmJpdCAoTEUpIGFwcGxpY2F0
aW9uIHdvdWxkIGxlYXZlIHRoZQ0KaGlnaCBiaXRzIG9mIHRoZSB1c2VyIGFkZHJlc3MgdW5kZWZp
bmVkLg0KDQpBbGwgbW9vdCBhbmQgcG9pbnRsZXNzIGlmIDY0Yml0IG9ubHkgdGhvdWdoLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K

