Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29CB3E9AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 00:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbhHKWUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 18:20:13 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53919 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbhHKWUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 18:20:11 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 4411B806B5;
        Thu, 12 Aug 2021 10:19:45 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1628720385;
        bh=8vynoMaFGPE3kasjlouXBQZjhpOSRyXnsmWF3Db6QJs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=Y9MHNErCKIH1e0nz0mfAbSzuh4FLdl8f2252EKHWA4JfbCuhJRz2BJBye76lRNhli
         OQoWXhy38zBBnrshRK4/iynrjcAQ5dgb8Bbi+DSMiUCequKWJaARPWIllm31TJakzB
         OVukyIjtDdhdtjH1S7+v4/uJOHpsdfn3//j27h3tGcJ2MlR886LE5s0opZ7+Fm2VUx
         VEkxYZlvBHsWsOycAJwJKei6Wz5yLraWwyw0PhGy2ER3h4HbC2mr/2RdiAFpI0jFde
         Czh4F7paSyDEo+MdjbnwLAakewpcFcyvBmEk1oLSnBQ7+p+a0vqJWF1l+93Ww2Gmpp
         Xlypd7qzhIyhQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B61144d010001>; Thu, 12 Aug 2021 10:19:45 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 12 Aug 2021 10:19:44 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.023; Thu, 12 Aug 2021 10:19:44 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: (pmbus/bpa-rs600) Add workaround for incorrect
 Pin max
Thread-Topic: [PATCH 2/2] hwmon: (pmbus/bpa-rs600) Add workaround for
 incorrect Pin max
Thread-Index: AQHXjmfUNc4+vas2/kuulmAunRfAUqtt7x+AgAAo3wA=
Date:   Wed, 11 Aug 2021 22:19:44 +0000
Message-ID: <b02c3a4d-4d91-0506-7833-6266efc0a2fc@alliedtelesis.co.nz>
References: <20210811041738.15061-1-chris.packham@alliedtelesis.co.nz>
 <20210811041738.15061-3-chris.packham@alliedtelesis.co.nz>
 <20210811195327.GA966160@roeck-us.net>
In-Reply-To: <20210811195327.GA966160@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <163B9E70CE24B645ADE9054E930EFE14@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=aqTM9hRV c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=MhDmnRu9jo8A:10 a=_VQZrd9NldDDbWZ-76UA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMi8wOC8yMSA3OjUzIGFtLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0KPiBPbiBXZWQsIEF1
ZyAxMSwgMjAyMSBhdCAwNDoxNzozOFBNICsxMjAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4g
QlBELVJTNjAwIG1vZHVsZXMgcnVubmluZyBmaXJtd2FyZSB2NS43MCBtaXNyZXBvcnQgdGhlIE1G
Ul9QSU5fTUFYLg0KPj4gVGhlIGluZGljYXRlIGEgbWF4aW11bSBvZiAxNjQwVyBpbnN0ZWFkIG9m
IDcwMFcuIERldGVjdCB0aGUgaW52YWxpZA0KPj4gcmVhZGluZyBhbmQgcmV0dXJuIGEgc2Vuc2li
bGUgdmFsdWUgaW5zdGVhZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQYWNraGFtIDxj
aHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy9o
d21vbi9wbWJ1cy9icGEtcnM2MDAuYyB8IDIxICsrKysrKysrKysrKysrKysrKysrLQ0KPj4gICAx
IGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9uL3BtYnVzL2JwYS1yczYwMC5jIGIvZHJpdmVycy9od21v
bi9wbWJ1cy9icGEtcnM2MDAuYw0KPj4gaW5kZXggZDQ5NWZhYTg5Nzk5Li5mNGJhZWQ5Y2U4YTQg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2h3bW9uL3BtYnVzL2JwYS1yczYwMC5jDQo+PiArKysg
Yi9kcml2ZXJzL2h3bW9uL3BtYnVzL2JwYS1yczYwMC5jDQo+PiBAQCAtNjUsNiArNjUsMjQgQEAg
c3RhdGljIGludCBicGFfcnM2MDBfcmVhZF92aW4oc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCkN
Cj4+ICAgCXJldHVybiByZXQ7DQo+PiAgIH0NCj4+ICAgDQo+PiArLyoNCj4+ICsgKiBUaGUgZmly
bXdhcmUgb24gc29tZSBCUEQtUlM2MDAgbW9kZWxzIGluY29ycmVjdGx5IHJlcG9ydHMgMTY0MFcN
Cj4+ICsgKiBmb3IgTUZSX1BJTl9NQVguIERlYWwgd2l0aCB0aGlzIGJ5IHJldHVybmluZyBhIHNl
bnNpYmxlIHZhbHVlLg0KPj4gKyAqLw0KPj4gK3N0YXRpYyBpbnQgYnBhX3JzNjAwX3JlYWRfcGlu
X21heChzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQ0KPj4gK3sNCj4+ICsJaW50IHJldDsNCj4+
ICsNCj4+ICsJcmV0ID0gcG1idXNfcmVhZF93b3JkX2RhdGEoY2xpZW50LCAwLCAweGZmLCBQTUJV
U19NRlJfUElOX01BWCk7DQo+PiArCWlmIChyZXQgPCAwKQ0KPj4gKwkJcmV0dXJuIHJldDsNCj4+
ICsNCj4+ICsJaWYgKHJldCA9PSAweDBiMzQpDQo+PiArCQlyZXR1cm4gMHgwOTVlOw0KPiBUaGUg
Y29tbWVudHMgZnJvbSB0aGUgZGVzY3Jpb3Rpb24gbmVlZCB0byBiZSBoZXJlLg0Kd2lsbCB1cGRh
dGUNCj4gVGhhbmtzLA0KPiBHdWVudGVyDQo+DQo+PiArDQo+PiArCXJldHVybiByZXQ7DQo+PiAr
fQ0KPj4gKw0KPj4gICBzdGF0aWMgaW50IGJwYV9yczYwMF9yZWFkX3dvcmRfZGF0YShzdHJ1Y3Qg
aTJjX2NsaWVudCAqY2xpZW50LCBpbnQgcGFnZSwgaW50IHBoYXNlLCBpbnQgcmVnKQ0KPj4gICB7
DQo+PiAgIAlpbnQgcmV0Ow0KPj4gQEAgLTkyLDcgKzExMCw4IEBAIHN0YXRpYyBpbnQgYnBhX3Jz
NjAwX3JlYWRfd29yZF9kYXRhKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsIGludCBwYWdlLCBp
bnQgcGhhDQo+PiAgIAkJcmV0ID0gcG1idXNfcmVhZF93b3JkX2RhdGEoY2xpZW50LCAwLCAweGZm
LCBQTUJVU19NRlJfSU9VVF9NQVgpOw0KPj4gICAJCWJyZWFrOw0KPj4gICAJY2FzZSBQTUJVU19Q
SU5fT1BfV0FSTl9MSU1JVDoNCj4+IC0JCXJldCA9IHBtYnVzX3JlYWRfd29yZF9kYXRhKGNsaWVu
dCwgMCwgMHhmZiwgUE1CVVNfTUZSX1BJTl9NQVgpOw0KPj4gKwljYXNlIFBNQlVTX01GUl9QSU5f
TUFYOg0KPj4gKwkJcmV0ID0gYnBhX3JzNjAwX3JlYWRfcGluX21heChjbGllbnQpOw0KPiBTbyB0
aGUgaWRlYSBpcyB0byByZXR1cm4gdGhlIHNhbWUgdmFsdWUgZm9yIFBNQlVTX1BJTl9PUF9XQVJO
X0xJTUlUDQo+IChtYXhfYWxhcm0pIGFuZCBQTUJVU19NRlJfUElOX01BWCAocmF0ZWRfbWF4KSA/
IFRoYXQgZG9lc24ndCByZWFsbHkNCj4gbWFrZSBzZW5zZS4gVGhlIG1lYW5pbmcgb2YgdGhvc2Ug
bGltaXRzIGlzIGRpc3RpbmN0bHkgZGlmZmVyZW50Lg0KRm9yIHRoZSBCUEEtUlM2MDAvQlBELVJT
NjAwIHRoZXNlIGFwcGVhciB0byBiZSB0cmVhdGVkIHRoZSBzYW1lLg0KPg0KPiBHdWVudGVyDQo+
DQo+PiAgIAkJYnJlYWs7DQo+PiAgIAljYXNlIFBNQlVTX1BPVVRfT1BfV0FSTl9MSU1JVDoNCj4+
ICAgCQlyZXQgPSBwbWJ1c19yZWFkX3dvcmRfZGF0YShjbGllbnQsIDAsIDB4ZmYsIFBNQlVTX01G
Ul9QT1VUX01BWCk7DQo+PiAtLSANCj4+IDIuMzIuMA0KPj4=
