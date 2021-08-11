Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E568E3E9AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 23:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhHKV6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 17:58:37 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:53864 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhHKV6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 17:58:36 -0400
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 180FC806B5;
        Thu, 12 Aug 2021 09:58:10 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1628719090;
        bh=2g69oJmhKIbZmryHEfSzcMtai9c7zzuRwWygMPy9p8A=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=107jsKrgzbViQNOEj9DuvenB2rlct0ZMSOBQH0mIh80FSmQ26Anc3REiTjt0US96w
         3D33hw4MeibnrGSO0VmAvcBxP+R05KHDxFgE2LBWCVR1ZFNtl4IlhTXRHCgiZy4RAE
         hEpUkaB3UigfDoU/npSqKgckbOmj2rAVksEioZbRyiheHEanQWkswLcFHLlORDqflg
         jYstWZkDQa8Wa46gW2mx3nZCpiEH1XXUkXhEj+F6RVw+xiTj1ADggaqfTNHA1cgoax
         irjto6mKF12/D1SZRIB89XxgaoD9qb/dWjnNm0QGQtaCbeUPZ3kPdR6BVF3/XvIgJm
         Ap2gI4C4nrGVA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B611447f20000>; Thu, 12 Aug 2021 09:58:10 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.23; Thu, 12 Aug 2021 09:58:09 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.023; Thu, 12 Aug 2021 09:58:09 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] hwmon: (pmbus/bpa-rs600) Remove duplicate
 defininitions
Thread-Topic: [PATCH 1/2] hwmon: (pmbus/bpa-rs600) Remove duplicate
 defininitions
Thread-Index: AQHXjmfUYfzSIYG02k2lCOoSaoUyGqtt7zYAgAAiwYA=
Date:   Wed, 11 Aug 2021 21:58:09 +0000
Message-ID: <0c6673a3-d364-d677-d711-2062285633c6@alliedtelesis.co.nz>
References: <20210811041738.15061-1-chris.packham@alliedtelesis.co.nz>
 <20210811041738.15061-2-chris.packham@alliedtelesis.co.nz>
 <20210811195346.GA966404@roeck-us.net>
In-Reply-To: <20210811195346.GA966404@roeck-us.net>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D38980DFD9F1D4DB0EB1CECA3A4E2F1@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=aqTM9hRV c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=MhDmnRu9jo8A:10 a=XTs4swXrssY7E7n5E2MA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxMi8wOC8yMSA3OjUzIGFtLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0KPiBPbiBXZWQsIEF1
ZyAxMSwgMjAyMSBhdCAwNDoxNzozN1BNICsxMjAwLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPj4g
Q29tbWl0IDc4N2MwOTVlZGFhOSAoImh3bW9uOiAocG1idXMvY29yZSkgQWRkIHN1cHBvcnQgZm9y
IHJhdGVkDQo+PiBhdHRyaWJ1dGVzIikgYWRkZWQgZGVmaW5pdGlvbnMgZm9yIE1GUl9WSU5fTUlO
IGV0YyBzbyB3ZSBjYW4gcmVtb3ZlIHRoZQ0KPj4gbG9jYWwgZGVmaW5pdGlvbnMgb2YgdGhlc2Ug
ZnJvbSB0aGUgYnBhLXJzNjAwIGRyaXZlci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpcyBQ
YWNraGFtIDxjaHJpcy5wYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+PiAtLS0NCj4+ICAg
ZHJpdmVycy9od21vbi9wbWJ1cy9icGEtcnM2MDAuYyB8IDI1ICsrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaHdtb24vcG1idXMvYnBhLXJzNjAwLmMg
Yi9kcml2ZXJzL2h3bW9uL3BtYnVzL2JwYS1yczYwMC5jDQo+PiBpbmRleCBkMjA1YjQxNTQwY2Uu
LmQ0OTVmYWE4OTc5OSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaHdtb24vcG1idXMvYnBhLXJz
NjAwLmMNCj4+ICsrKyBiL2RyaXZlcnMvaHdtb24vcG1idXMvYnBhLXJzNjAwLmMNCj4+IEBAIC0x
MiwxNSArMTIsNiBAQA0KPj4gICAjaW5jbHVkZSA8bGludXgvcG1idXMuaD4NCj4+ICAgI2luY2x1
ZGUgInBtYnVzLmgiDQo+PiAgIA0KPj4gLSNkZWZpbmUgQlBBUlM2MDBfTUZSX1ZJTl9NSU4JMHhh
MA0KPj4gLSNkZWZpbmUgQlBBUlM2MDBfTUZSX1ZJTl9NQVgJMHhhMQ0KPj4gLSNkZWZpbmUgQlBB
UlM2MDBfTUZSX0lJTl9NQVgJMHhhMg0KPj4gLSNkZWZpbmUgQlBBUlM2MDBfTUZSX1BJTl9NQVgJ
MHhhMw0KPj4gLSNkZWZpbmUgQlBBUlM2MDBfTUZSX1ZPVVRfTUlOCTB4YTQNCj4+IC0jZGVmaW5l
IEJQQVJTNjAwX01GUl9WT1VUX01BWAkweGE1DQo+PiAtI2RlZmluZSBCUEFSUzYwMF9NRlJfSU9V
VF9NQVgJMHhhNg0KPj4gLSNkZWZpbmUgQlBBUlM2MDBfTUZSX1BPVVRfTUFYCTB4YTcNCj4+IC0N
Cj4+ICAgZW51bSBjaGlwcyB7IGJwYV9yczYwMCwgYnBkX3JzNjAwIH07DQo+PiAgIA0KPj4gICBz
dGF0aWMgaW50IGJwYV9yczYwMF9yZWFkX2J5dGVfZGF0YShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xp
ZW50LCBpbnQgcGFnZSwgaW50IHJlZykNCj4+IEBAIC04MywyOCArNzQsMjggQEAgc3RhdGljIGlu
dCBicGFfcnM2MDBfcmVhZF93b3JkX2RhdGEoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwgaW50
IHBhZ2UsIGludCBwaGENCj4+ICAgDQo+PiAgIAlzd2l0Y2ggKHJlZykgew0KPj4gICAJY2FzZSBQ
TUJVU19WSU5fVVZfV0FSTl9MSU1JVDoNCj4+IC0JCXJldCA9IHBtYnVzX3JlYWRfd29yZF9kYXRh
KGNsaWVudCwgMCwgMHhmZiwgQlBBUlM2MDBfTUZSX1ZJTl9NSU4pOw0KPj4gKwkJcmV0ID0gcG1i
dXNfcmVhZF93b3JkX2RhdGEoY2xpZW50LCAwLCAweGZmLCBQTUJVU19NRlJfVklOX01JTik7DQo+
PiAgIAkJYnJlYWs7DQo+PiAgIAljYXNlIFBNQlVTX1ZJTl9PVl9XQVJOX0xJTUlUOg0KPj4gLQkJ
cmV0ID0gcG1idXNfcmVhZF93b3JkX2RhdGEoY2xpZW50LCAwLCAweGZmLCBCUEFSUzYwMF9NRlJf
VklOX01BWCk7DQo+PiArCQlyZXQgPSBwbWJ1c19yZWFkX3dvcmRfZGF0YShjbGllbnQsIDAsIDB4
ZmYsIFBNQlVTX01GUl9WSU5fTUFYKTsNCj4+ICAgCQlicmVhazsNCj4+ICAgCWNhc2UgUE1CVVNf
Vk9VVF9VVl9XQVJOX0xJTUlUOg0KPj4gLQkJcmV0ID0gcG1idXNfcmVhZF93b3JkX2RhdGEoY2xp
ZW50LCAwLCAweGZmLCBCUEFSUzYwMF9NRlJfVk9VVF9NSU4pOw0KPj4gKwkJcmV0ID0gcG1idXNf
cmVhZF93b3JkX2RhdGEoY2xpZW50LCAwLCAweGZmLCBQTUJVU19NRlJfVk9VVF9NSU4pOw0KPj4g
ICAJCWJyZWFrOw0KPj4gICAJY2FzZSBQTUJVU19WT1VUX09WX1dBUk5fTElNSVQ6DQo+PiAtCQly
ZXQgPSBwbWJ1c19yZWFkX3dvcmRfZGF0YShjbGllbnQsIDAsIDB4ZmYsIEJQQVJTNjAwX01GUl9W
T1VUX01BWCk7DQo+PiArCQlyZXQgPSBwbWJ1c19yZWFkX3dvcmRfZGF0YShjbGllbnQsIDAsIDB4
ZmYsIFBNQlVTX01GUl9WT1VUX01BWCk7DQo+PiAgIAkJYnJlYWs7DQo+PiAgIAljYXNlIFBNQlVT
X0lJTl9PQ19XQVJOX0xJTUlUOg0KPj4gLQkJcmV0ID0gcG1idXNfcmVhZF93b3JkX2RhdGEoY2xp
ZW50LCAwLCAweGZmLCBCUEFSUzYwMF9NRlJfSUlOX01BWCk7DQo+PiArCQlyZXQgPSBwbWJ1c19y
ZWFkX3dvcmRfZGF0YShjbGllbnQsIDAsIDB4ZmYsIFBNQlVTX01GUl9JSU5fTUFYKTsNCj4+ICAg
CQlicmVhazsNCj4+ICAgCWNhc2UgUE1CVVNfSU9VVF9PQ19XQVJOX0xJTUlUOg0KPj4gLQkJcmV0
ID0gcG1idXNfcmVhZF93b3JkX2RhdGEoY2xpZW50LCAwLCAweGZmLCBCUEFSUzYwMF9NRlJfSU9V
VF9NQVgpOw0KPj4gKwkJcmV0ID0gcG1idXNfcmVhZF93b3JkX2RhdGEoY2xpZW50LCAwLCAweGZm
LCBQTUJVU19NRlJfSU9VVF9NQVgpOw0KPj4gICAJCWJyZWFrOw0KPj4gICAJY2FzZSBQTUJVU19Q
SU5fT1BfV0FSTl9MSU1JVDoNCj4+IC0JCXJldCA9IHBtYnVzX3JlYWRfd29yZF9kYXRhKGNsaWVu
dCwgMCwgMHhmZiwgQlBBUlM2MDBfTUZSX1BJTl9NQVgpOw0KPj4gKwkJcmV0ID0gcG1idXNfcmVh
ZF93b3JkX2RhdGEoY2xpZW50LCAwLCAweGZmLCBQTUJVU19NRlJfUElOX01BWCk7DQo+PiAgIAkJ
YnJlYWs7DQo+PiAgIAljYXNlIFBNQlVTX1BPVVRfT1BfV0FSTl9MSU1JVDoNCj4+IC0JCXJldCA9
IHBtYnVzX3JlYWRfd29yZF9kYXRhKGNsaWVudCwgMCwgMHhmZiwgQlBBUlM2MDBfTUZSX1BPVVRf
TUFYKTsNCj4+ICsJCXJldCA9IHBtYnVzX3JlYWRfd29yZF9kYXRhKGNsaWVudCwgMCwgMHhmZiwg
UE1CVVNfTUZSX1BPVVRfTUFYKTsNCj4gSWYgdGhlIGFib3ZlIGlzIGNvcnJlY3QsIHRoZSBkcml2
ZXIgcmVwb3J0cyB0aGUgd3JvbmcgYXR0cmlidXRlcy4gRm9yIGV4YW1wbGUsDQo+IFBNQlVTX01G
Ul9QSU5fTUFYIGlzIHN1cHBvc2VkIHRvIHJlcG9ydCB0aGUgcmF0ZWQgbGltaXQsIG5vdCB0aGUg
d2FybmluZyBsaW1pdC4NCj4gV2hhdCBkb2VzIHRoZSBkYXRhc2hlZXQgc2F5ID8NCg0KVGhlIGRh
dGFzaGVldCBkb2Vzbid0IGxpc3QgUE1CVVNfVklOX1VWX1dBUk5fTElNSVQgZXRjIGF0IGFsbC4g
SXQgZG9lcyANCnNheSB0aGF0IE1GUl9WSU5feHh4IGlzIHRoZSAicmF0ZWQiIHZhbHVlIGJ1dCBp
biBteSB0ZXN0aW5nIHRoaXMgYWxzbyANCmFwcGVhcnMgdGhhdCB0aGlzIGlzIHRoZSBzYW1lIHRo
cmVzaG9sZCBhdCB3aGljaCB0aGUgQUxFUlQgcGluIGlzIGFzc2VydGVkLg0KDQpXaGVuIEkgZGlk
IHRoZSBpbml0aWFsIGltcGxlbWVudGF0aW9uIEkgZGVjaWRlZCB0byBtYXAgdGhlIFdBUk5fTElN
SVRzIA0KdG8gd2hhdCBJIHRob3VnaHQgd2VyZSByZWFzb25hYmxlIG1hbnVmYWN0dXJlciBzcGVj
aWZpYyBlcXVpdmFsZW50cy4gDQpUaGlzIGFsc28gbWVhbnMgdGhhdCB0aGUgdGhyZXNob2xkcyBj
YW4gYmUgZGlzcGxheWVkIGJ5IGV4aXN0aW5nIA0KdXNlcnNwYWNlIHRvb2xzIHRoYXQgY29uc3Vt
ZSB0aGUgc3lzZnMgQUJJLg0KDQo+IEd1ZW50ZXINCj4NCj4+ICAgCQlicmVhazsNCj4+ICAgCWNh
c2UgUE1CVVNfVklOX1VWX0ZBVUxUX0xJTUlUOg0KPj4gICAJY2FzZSBQTUJVU19WSU5fT1ZfRkFV
TFRfTElNSVQ6DQo+PiAtLSANCj4+IDIuMzIuMA0KPj4=
