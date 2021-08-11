Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AA63E9B38
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 01:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhHKX03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 19:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhHKX02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 19:26:28 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B55AC061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 16:26:04 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 656DF806B5;
        Thu, 12 Aug 2021 11:25:59 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1628724359;
        bh=/RXt84H1kRW0Fqsh9TUjLpBSLI5Ak3n0sBHDLz9p43g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=gwH1qMdjpCHUTQA5l9gmXhgbtVpuZGLqVH++1uiCd7Ilb9e68GZwW79ysGMdQ44Yt
         6MZxNkwiCR/i8GS5Dc+DwGd8xrMB/L8evWCgoIo7K0zWkkubTFIEEiNUTWF6TXbg5o
         t4x0uZ8HtVitoYe5tOBpxzdMAuzdTOtx8WuJLe0Lj6hCNF+6avu6gdhgLMx9gzTnMf
         OHkGSdmieFipR5Da0z386LY30m0vS7gaFH+il1pahhwmq5VZ7EnXTCtqohKjFm7LLO
         6L+rQv3SuAPmmcijj7Q7NlcUMhk68BqvUqF4y/DNc+uRL2B/Eu+4nHlqrwB7rqPRl6
         RQG4CoI02PtRg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B61145c870001>; Thu, 12 Aug 2021 11:25:59 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 12 Aug 2021 11:25:59 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.023; Thu, 12 Aug 2021 11:25:59 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: (pmbus/bpa-rs600) Add workaround for incorrect
 Pin max
Thread-Topic: [PATCH 2/2] hwmon: (pmbus/bpa-rs600) Add workaround for
 incorrect Pin max
Thread-Index: AQHXjmfUNc4+vas2/kuulmAunRfAUqtt7x+AgAAo3wCAABBOgIAAAjQA
Date:   Wed, 11 Aug 2021 23:25:58 +0000
Message-ID: <f6d3654f-c1b1-65d2-2593-392e2cc2f0d2@alliedtelesis.co.nz>
References: <20210811041738.15061-1-chris.packham@alliedtelesis.co.nz>
 <20210811041738.15061-3-chris.packham@alliedtelesis.co.nz>
 <20210811195327.GA966160@roeck-us.net>
 <b02c3a4d-4d91-0506-7833-6266efc0a2fc@alliedtelesis.co.nz>
 <20210811231805.GA1095781@roeck-us.net>
In-Reply-To: <20210811231805.GA1095781@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B5F5B718BD98E45874EBA0D4323AEB5@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=aqTM9hRV c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=MhDmnRu9jo8A:10 a=2bS1ULTEAjVO_qZoSjYA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMi8wOC8yMSAxMToxOCBhbSwgR3VlbnRlciBSb2VjayB3cm90ZToNCj4gT24gV2VkLCBB
dWcgMTEsIDIwMjEgYXQgMTA6MTk6NDRQTSArMDAwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+
IE9uIDEyLzA4LzIxIDc6NTMgYW0sIEd1ZW50ZXIgUm9lY2sgd3JvdGU6DQo+Pj4gT24gV2VkLCBB
dWcgMTEsIDIwMjEgYXQgMDQ6MTc6MzhQTSArMTIwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+
Pj4gQlBELVJTNjAwIG1vZHVsZXMgcnVubmluZyBmaXJtd2FyZSB2NS43MCBtaXNyZXBvcnQgdGhl
IE1GUl9QSU5fTUFYLg0KPj4+PiBUaGUgaW5kaWNhdGUgYSBtYXhpbXVtIG9mIDE2NDBXIGluc3Rl
YWQgb2YgNzAwVy4gRGV0ZWN0IHRoZSBpbnZhbGlkDQo+Pj4+IHJlYWRpbmcgYW5kIHJldHVybiBh
IHNlbnNpYmxlIHZhbHVlIGluc3RlYWQuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IENocmlz
IFBhY2toYW0gPGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5uej4NCj4+Pj4gLS0tDQo+
Pj4+ICAgIGRyaXZlcnMvaHdtb24vcG1idXMvYnBhLXJzNjAwLmMgfCAyMSArKysrKysrKysrKysr
KysrKysrKy0NCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vcG1idXMvYnBh
LXJzNjAwLmMgYi9kcml2ZXJzL2h3bW9uL3BtYnVzL2JwYS1yczYwMC5jDQo+Pj4+IGluZGV4IGQ0
OTVmYWE4OTc5OS4uZjRiYWVkOWNlOGE0IDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL2h3bW9u
L3BtYnVzL2JwYS1yczYwMC5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvaHdtb24vcG1idXMvYnBhLXJz
NjAwLmMNCj4+Pj4gQEAgLTY1LDYgKzY1LDI0IEBAIHN0YXRpYyBpbnQgYnBhX3JzNjAwX3JlYWRf
dmluKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQpDQo+Pj4+ICAgIAlyZXR1cm4gcmV0Ow0KPj4+
PiAgICB9DQo+Pj4+ICAgIA0KPj4+PiArLyoNCj4+Pj4gKyAqIFRoZSBmaXJtd2FyZSBvbiBzb21l
IEJQRC1SUzYwMCBtb2RlbHMgaW5jb3JyZWN0bHkgcmVwb3J0cyAxNjQwVw0KPj4+PiArICogZm9y
IE1GUl9QSU5fTUFYLiBEZWFsIHdpdGggdGhpcyBieSByZXR1cm5pbmcgYSBzZW5zaWJsZSB2YWx1
ZS4NCj4+Pj4gKyAqLw0KPj4+PiArc3RhdGljIGludCBicGFfcnM2MDBfcmVhZF9waW5fbWF4KHN0
cnVjdCBpMmNfY2xpZW50ICpjbGllbnQpDQo+Pj4+ICt7DQo+Pj4+ICsJaW50IHJldDsNCj4+Pj4g
Kw0KPj4+PiArCXJldCA9IHBtYnVzX3JlYWRfd29yZF9kYXRhKGNsaWVudCwgMCwgMHhmZiwgUE1C
VVNfTUZSX1BJTl9NQVgpOw0KPj4+PiArCWlmIChyZXQgPCAwKQ0KPj4+PiArCQlyZXR1cm4gcmV0
Ow0KPj4+PiArDQo+Pj4+ICsJaWYgKHJldCA9PSAweDBiMzQpDQo+Pj4+ICsJCXJldHVybiAweDA5
NWU7DQo+Pj4gVGhlIGNvbW1lbnRzIGZyb20gdGhlIGRlc2NyaW90aW9uIG5lZWQgdG8gYmUgaGVy
ZS4NCj4+IHdpbGwgdXBkYXRlDQo+Pj4gVGhhbmtzLA0KPj4+IEd1ZW50ZXINCj4+Pg0KPj4+PiAr
DQo+Pj4+ICsJcmV0dXJuIHJldDsNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiAgICBzdGF0aWMgaW50
IGJwYV9yczYwMF9yZWFkX3dvcmRfZGF0YShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50LCBpbnQg
cGFnZSwgaW50IHBoYXNlLCBpbnQgcmVnKQ0KPj4+PiAgICB7DQo+Pj4+ICAgIAlpbnQgcmV0Ow0K
Pj4+PiBAQCAtOTIsNyArMTEwLDggQEAgc3RhdGljIGludCBicGFfcnM2MDBfcmVhZF93b3JkX2Rh
dGEoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwgaW50IHBhZ2UsIGludCBwaGENCj4+Pj4gICAg
CQlyZXQgPSBwbWJ1c19yZWFkX3dvcmRfZGF0YShjbGllbnQsIDAsIDB4ZmYsIFBNQlVTX01GUl9J
T1VUX01BWCk7DQo+Pj4+ICAgIAkJYnJlYWs7DQo+Pj4+ICAgIAljYXNlIFBNQlVTX1BJTl9PUF9X
QVJOX0xJTUlUOg0KPj4+PiAtCQlyZXQgPSBwbWJ1c19yZWFkX3dvcmRfZGF0YShjbGllbnQsIDAs
IDB4ZmYsIFBNQlVTX01GUl9QSU5fTUFYKTsNCj4+Pj4gKwljYXNlIFBNQlVTX01GUl9QSU5fTUFY
Og0KPj4+PiArCQlyZXQgPSBicGFfcnM2MDBfcmVhZF9waW5fbWF4KGNsaWVudCk7DQo+Pj4gU28g
dGhlIGlkZWEgaXMgdG8gcmV0dXJuIHRoZSBzYW1lIHZhbHVlIGZvciBQTUJVU19QSU5fT1BfV0FS
Tl9MSU1JVA0KPj4+IChtYXhfYWxhcm0pIGFuZCBQTUJVU19NRlJfUElOX01BWCAocmF0ZWRfbWF4
KSA/IFRoYXQgZG9lc24ndCByZWFsbHkNCj4+PiBtYWtlIHNlbnNlLiBUaGUgbWVhbmluZyBvZiB0
aG9zZSBsaW1pdHMgaXMgZGlzdGluY3RseSBkaWZmZXJlbnQuDQo+PiBGb3IgdGhlIEJQQS1SUzYw
MC9CUEQtUlM2MDAgdGhlc2UgYXBwZWFyIHRvIGJlIHRyZWF0ZWQgdGhlIHNhbWUuDQo+IFdoYXQg
YSBtZXNzLg0KKnNpZ2gqIEkga25vdy4gSSd2ZSBhbHNvIGdvdCBhbm90aGVyIDIgQmx1VGVrIHN1
cHBsaWVzIEkgaGF2ZW4ndCBnb3QgDQpyb3VuZCB0byBkZWFsaW5nIHdpdGggeWV0Lg0KPiBUaGlz
IG5lZWRzIHRvIGJlIGRvY3VtZW50ZWQgaW4gdGhlIGRyaXZlciwgaW5jbHVkaW5nIHRoZQ0KPiBi
ZWhhdmlvciBpZiBhbnkgb2YgdGhvc2UgYXR0cmlidXRlcyBpcyB3cml0dGVuIGludG8uDQoNCk1l
cmNpZnVsbHkgdGhlc2UgYXR0cmlidXRlcyBhcmUgYWxsIHJlYWQtb25seS4gU28gYXQgbGVhc3Qg
d2UgZG9uJ3QgaGF2ZSANCnRvIGRlYWwgd2l0aCB0aGF0Lg0KDQpJdCdzIHByb2JhYmx5IG5vdCB0
b28gbGF0ZSB0byByZXR1cm4gLUVOWElPIGZvciB0aGUgV0FSTl9MSU1JVHMgYW5kIGhhdmUgDQps
bS1zZW5zb3JzIGRpc3BsYXkgdGhlIHJhdGVkX21heCAod2UgYWxzbyBoYXZlIGEgY3VzdG9tIGNv
bnN1bWVyIG9mIHRoZSANCnN5c2ZzIEFQSSB0aGF0IEknZCBuZWVkIHRvIHNvcnQgb3V0KS4NCg0K
Pg0KPiBHdWVudGVyDQo+DQo+Pj4gR3VlbnRlcg0KPj4+DQo+Pj4+ICAgIAkJYnJlYWs7DQo+Pj4+
ICAgIAljYXNlIFBNQlVTX1BPVVRfT1BfV0FSTl9MSU1JVDoNCj4+Pj4gICAgCQlyZXQgPSBwbWJ1
c19yZWFkX3dvcmRfZGF0YShjbGllbnQsIDAsIDB4ZmYsIFBNQlVTX01GUl9QT1VUX01BWCk7DQo+
Pj4+IC0tIA0KPj4+PiAyLjMyLjANCj4+Pj4=
