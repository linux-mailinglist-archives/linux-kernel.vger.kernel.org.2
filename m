Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF693DE661
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 07:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhHCF4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 01:56:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:58556 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230096AbhHCF4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 01:56:02 -0400
X-UUID: bbba513bc73b4d04b62552d945b14081-20210803
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=nnUKDbyFZW3JVZ0V6b9Q1wtkI9K03QZZSPTEVvJYTFo=;
        b=QFaoDQ1BiEh/SEPueX3+f9tyxPEJ3eds/jJ/UwJzqn/DBfXWFm9LGPvgj8107VBLSs+hjYAZp3qIeC4yx73yHZf6cyT1v9KsfB0sndOi/f7/3MaLA57XxTtzfqwILz87mGL0NqY/04jDDCVraPN1sbOQEOmLxGHJD2gjSFRnCLI=;
X-UUID: bbba513bc73b4d04b62552d945b14081-20210803
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 593171222; Tue, 03 Aug 2021 13:55:48 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 3 Aug 2021 13:55:47 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 Aug 2021 13:55:47 +0800
Message-ID: <a200fcaf086b590d5c675eea8e0546fa9db9849e.camel@mediatek.com>
Subject: Re: [PATCH v3 1/1] arm64/cpufeature: Optionally disable MTE via
 command-line
From:   Yee Lee <yee.lee@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <nicholas.Tang@mediatek.com>,
        <Kuan-Ying.lee@mediatek.com>, <chinwen.chang@mediatek.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marc Zyngier <maz@kernel.org>,
        David Brazdil <dbrazdil@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fuad Tabba <tabba@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 3 Aug 2021 13:55:47 +0800
In-Reply-To: <20210802153036.GH18685@arm.com>
References: <20210730144957.30938-1-yee.lee@mediatek.com>
         <20210730144957.30938-2-yee.lee@mediatek.com>
         <20210802153036.GH18685@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA4LTAyIGF0IDE2OjMwICswMTAwLCBDYXRhbGluIE1hcmluYXMgd3JvdGU6
DQo+IE9uIEZyaSwgSnVsIDMwLCAyMDIxIGF0IDEwOjQ5OjUzUE0gKzA4MDAsIHllZS5sZWVAbWVk
aWF0ZWsuY29tIHdyb3RlOg0KPiA+IEZyb206IFllZSBMZWUgPHllZS5sZWVAbWVkaWF0ZWsuY29t
Pg0KPiA+IA0KPiA+IEZvciBzb21lIGxvdy1lbmQgZGV2aWNlcyB3aXRoIGxpbWl0ZWQgcmVzb3Vy
Y2VzLA0KPiA+IE1URSBuZWVkcyB0byBiZSBvcHRpb25hbGx5IGRpc2FibGVkIHRvIHNhdmUgc3lz
dGVtDQo+ID4gY29zdHMgc3VjaCBhcyB0YWcgbWVtb3J5IGFuZCBmaXJtd2FyZSBjb250cm9scy4N
Cj4gDQo+IEkgdW5kZXJzdGFuZCB0aGUgY29zdCBvZiB1c2luZyBNVEUgYnV0IEkgZG9uJ3QgZnVs
bHkgZ2V0IHdoYXQgeW91DQo+IG1lYW4NCj4gYnkgZmlybXdhcmUgY29udHJvbHMuIElmIHRoZSBJ
RF9BQTY0UEZSMV9FTDEuTVRFIHJlcG9ydHMgdGhhdCBNVEUgaXMNCj4gcHJlc2VudCwgdGhlIGZp
cm13YXJlIHNob3VsZCBoYXZlIGluaXRpYWxpc2VkIE1URSBjb3JyZWN0bHkgKGUuZy4gdGFnDQo+
IGFsbG9jYXRpb24gc3RvcmFnZSwgU0NSX0VMMy5BVEEpIGFuZCBub3QgcmVseSBvbiBhIGtlcm5l
bCBjb21tYW5kDQo+IGxpbmUNCj4gYXJndW1lbnQgdGhhdCBtYXkgb3IgbWF5IG5vdCBiZSBwcmVz
ZW50Lg0KDQpUaGFua3MgZm9yIHRoZSByZW1pbmRpbmcuIA0KWWVzLCBpdCBzZWVtcyBub3QgYWJs
ZSB0byBmdWxseSBkaXNhYmxlIE1URS4NClRoaXMgc3RpbGwgcHJvdmlkZXMgYW4gb3B0aW9uIGlu
IHJ1bnRpbWUgZm9yIGV2YWx1YXRpb24gYW5kIHRlc3QuDQpBbmQgaXQgaXMgYWxzbyB1c2VmdWwg
Zm9yIGZpcm13YXJlIGRldmVsb3BtZW50IGFuZCBodyBpc3N1ZSB3b3JrYXJvdW5kLg0KPiANCj4g
PiBUaGlzIGFsbG93cyBJRF9BQTY0UEZSMV9FTDEuTVRFIHRvIGJlIG92ZXJyaWRkZW4gb24gDQo+
ID4gaXRzIHNoYWRvdyB2YWx1ZSBieSBnaXZpbmcgImFybTY0Lm5vbXRlIiBvbiBjbWRsaW5lLA0K
PiA+IGFuZCB0byBzdXBwcmVzcyBNVEUgZmVhdHVyZS4NCj4gPiANCj4gPiBTdWdnZXN0ZWQtYnk6
IE1hcmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBTdXp1a2kg
SyBQb3Vsb3NlIDxzdXp1a2kucG91bG9zZUBhcm0uY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFll
ZSBMZWUgPHllZS5sZWVAbWVkaWF0ZWsuY29tPg0KPiANCj4gV2hpbGUgdGhpcyBwYXRjaCBhcHBl
YXJzIHRvIGRpc2FibGUgTVRFLCBJIGRvbid0IHRoaW5rIGl0IGNhbiBmdWxseQ0KPiBwcmV2ZW50
IHRoZSBhY2Nlc3MgdG8gdGhlIGFsbG9jYXRpb24gdGFnIHN0b3JhZ2UsIHNvIHRoZSBmaXJtd2Fy
ZQ0KPiBtdXN0DQo+IHN0aWxsIGluaXRpYWxpc2UgaXQgY29ycmVjdGx5Lg0KPiANCj4gVGhlIGlz
c3VlIGlzIHRoYXQgX19jcHVfc2V0dXAgYWxyZWFkeSBjb25maWd1cmVzIHRoZSBNQUlSX0VMMQ0K
PiByZWdpc3Rlcg0KPiB0byB1c2UgTm9ybWFsIFRhZ2dlZCBtZW1vcnkgZm9yIHRoZSBrZXJuZWwg
bWFwcGluZyBhbmQgU0NUTFJfRUwxLkFUQQ0KPiBpcw0KPiBzZXQuIFRoZSBUQ0YgZmllbGQgaXMg
emVybywgc28gbm8gdGFnIGNoZWNraW5nLCBidXQgSSBjb3VsZG4ndCBmaWd1cmUNCj4gb3V0IGZy
b20gdGhlIEFSTSBBUk0gd2hldGhlciB0aGlzIGFsc28gcHJldmVudHMgTERSL1NUUiBmcm9tDQo+
IGF0dGVtcHRpbmcNCj4gdG8gZmV0Y2ggdGhlIGFsbG9jYXRpb24gdGFncy4gSSB0aGluayBpdCdz
IG9ubHkgdGhlIEFUQSBiaXQgYW5kIHRoZQ0KPiBNQUlSDQo+IGNvbmZpZ3VyYXRpb24uDQo+IA0K
PiBXaXRoIHRoaXMgcGF0Y2gsIEtBU0FOX0hXX1RBR1MgKGlmIGNvbmZpZ3VyZWQpIHdvbid0IGJl
IHVzZWQgYW5kIE1URQ0KPiB3aWxsIG5vdCBiZSBwcmVzZW50ZWQgdG8gdXNlciBhcHBsaWNhdGlv
bnMsIGlmIHRoYXQncyB3aGF0IHlvdSB3YW50LA0KPiBidXQNCj4gZG9lcyBub3QgZnVsbHkgZGlz
YWJsZSBNVEUuDQo+IA0KPiBTaW5jZSBNYXkgdGhpcyB5ZWFyLCB0aGUgQVJNIEFSTSB3YXMgdXBk
YXRlZCBzbyB0aGF0DQo+IFNDVExSX0VMMS5BVEEvQVRBMA0KPiBhcmUgbm90IHBlcm1pdHRlZCB0
byBiZSBjYWNoZWQgaW4gdGhlIFRMQi4gV2UgY291bGQgdGhlcmVmb3JlIG1vdmUNCj4gdGhlDQo+
IHNldHRpbmcgdG8gY3B1X2VuYWJsZV9tdGUoKS4gU29tZXRoaW5nIGxpa2UgYmVsb3csIHVudGVz
dGVkICh0byBiZQ0KPiBmb2xkZWQgaW50byB5b3VyIHBhdGNoKToNCj4gDQpvay4gd2lsbCBiZSBp
bnRlZ3JhdGVkIGluIHY0IGFuZCB0ZXN0ZWQuDQoNCkJSLA0KWWVlDQoNCj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vc3lzcmVnLmgNCj4gYi9hcmNoL2FybTY0L2luY2x1ZGUv
YXNtL3N5c3JlZy5oDQo+IGluZGV4IGFhNTM5NTRjMmY2Yi4uY2FjMjM0NTVhMmI1IDEwMDY0NA0K
PiAtLS0gYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL3N5c3JlZy5oDQo+ICsrKyBiL2FyY2gvYXJt
NjQvaW5jbHVkZS9hc20vc3lzcmVnLmgNCj4gQEAgLTY5OCw4ICs2OTgsNyBAQA0KPiAgCShTQ1RM
Ul9FTHhfTSAgICB8IFNDVExSX0VMeF9DICAgIHwgU0NUTFJfRUx4X1NBICAgfA0KPiBTQ1RMUl9F
TDFfU0EwICAgfCBcDQo+ICAJIFNDVExSX0VMMV9TRUQgIHwgU0NUTFJfRUx4X0kgICAgfCBTQ1RM
Ul9FTDFfRFpFICB8DQo+IFNDVExSX0VMMV9VQ1QgICB8IFwNCj4gIAkgU0NUTFJfRUwxX05UV0Ug
fCBTQ1RMUl9FTHhfSUVTQiB8IFNDVExSX0VMMV9TUEFOIHwNCj4gU0NUTFJfRUx4X0lURlNCIHwg
XA0KPiAtCSBTQ1RMUl9FTHhfQVRBICB8IFNDVExSX0VMMV9BVEEwIHwgRU5ESUFOX1NFVF9FTDEg
fA0KPiBTQ1RMUl9FTDFfVUNJICAgfCBcDQo+IC0JIFNDVExSX0VMMV9FUEFOIHwgU0NUTFJfRUwx
X1JFUzEpDQo+ICsJIEVORElBTl9TRVRfRUwxIHwgU0NUTFJfRUwxX1VDSSAgfCBTQ1RMUl9FTDFf
RVBBTiB8DQo+IFNDVExSX0VMMV9SRVMxKQ0KPiANCj4gIC8qIE1BSVJfRUx4IG1lbW9yeSBhdHRy
aWJ1dGVzICh1c2VkIGJ5IExpbnV4KSAqLw0KPiAgI2RlZmluZSBNQUlSX0FUVFJfREVWSUNFX25H
blJuRQkJVUwoMHgwMCkNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQva2VybmVsL2NwdWZlYXR1
cmUuYw0KPiBiL2FyY2gvYXJtNjQva2VybmVsL2NwdWZlYXR1cmUuYw0KPiBpbmRleCA5MDM1YzM2
N2QwOGIuLjIzYjFlM2Q4MzYwMyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9rZXJuZWwvY3B1
ZmVhdHVyZS5jDQo+ICsrKyBiL2FyY2gvYXJtNjQva2VybmVsL2NwdWZlYXR1cmUuYw0KPiBAQCAt
MTg0MSw2ICsxODQxLDkgQEAgc3RhdGljIHZvaWQgYnRpX2VuYWJsZShjb25zdCBzdHJ1Y3QNCj4g
YXJtNjRfY3B1X2NhcGFiaWxpdGllcyAqX191bnVzZWQpDQo+ICAjaWZkZWYgQ09ORklHX0FSTTY0
X01URQ0KPiAgc3RhdGljIHZvaWQgY3B1X2VuYWJsZV9tdGUoc3RydWN0IGFybTY0X2NwdV9jYXBh
YmlsaXRpZXMgY29uc3QgKmNhcCkNCj4gIHsNCj4gKwlzeXNyZWdfY2xlYXJfc2V0KHNjdGxyX2Vs
MSwgMCwgU0NUTFJfRUx4X0FUQSB8IFNDVExSX0VMMV9BVEEwKTsNCj4gKwlpc2IoKTsNCj4gKw0K
PiAgCS8qDQo+ICAJICogQ2xlYXIgdGhlIHRhZ3MgaW4gdGhlIHplcm8gcGFnZS4gVGhpcyBuZWVk
cyB0byBiZSBkb25lIHZpYQ0KPiB0aGUNCj4gIAkgKiBsaW5lYXIgbWFwIHdoaWNoIGhhcyB0aGUg
VGFnZ2VkIGF0dHJpYnV0ZS4NCj4gDQo=

