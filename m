Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29B936D061
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 03:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238548AbhD1BwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 21:52:05 -0400
Received: from [58.211.163.100] ([58.211.163.100]:63598 "EHLO
        mail.advantech.com.cn" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S230460AbhD1BwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 21:52:04 -0400
Received: from ACNMB1.ACN.ADVANTECH.CORP (unverified [172.21.128.147]) by ACNSWEEPER.acn.advantech.com.cn
 (Clearswift SMTPRS 5.6.0) with ESMTP id <Te6244c80dcac1580102738@ACNSWEEPER.acn.advantech.com.cn>;
 Wed, 28 Apr 2021 09:51:11 +0800
Received: from ACNMB2.ACN.ADVANTECH.CORP (172.21.128.148) by
 ACNMB1.ACN.ADVANTECH.CORP (172.21.128.147) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 28 Apr 2021 09:51:04 +0800
Received: from ACNMB2.ACN.ADVANTECH.CORP ([172.21.128.148]) by
 ACNMB2.ACN.ADVANTECH.CORP ([172.21.128.148]) with mapi id 15.00.1497.015;
 Wed, 28 Apr 2021 09:51:04 +0800
From:   =?utf-8?B?eXVlY2hhby56aGFvKOi1tei2iui2hSk=?= 
        <yuechao.zhao@advantech.com.cn>
To:     Pavel Machek <pavel@ucw.cz>
CC:     "345351830@qq.com" <345351830@qq.com>,
        =?utf-8?B?UmFpbmJvdy5aaGFuZyjlvLXnjokp?= 
        <Rainbow.Zhang@advantech.com.cn>,
        =?utf-8?B?eXVueGlhLmxpKOadjuS6kemcnik=?= 
        <yunxia.li@advantech.com.cn>,
        =?utf-8?B?SmlhLlN1aSjotL7nnaIp?= <Jia.Sui@advantech.com.cn>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [v2,1/1] adv_mix955x is a scheme that multiplexes PCA9554/PCA9555
 into LED and GPIO
Thread-Topic: [v2,1/1] adv_mix955x is a scheme that multiplexes
 PCA9554/PCA9555 into LED and GPIO
Thread-Index: AQHXO2zKvpGjHV02jEKJChySUhWmgKrJJ0yA
Date:   Wed, 28 Apr 2021 01:51:04 +0000
Message-ID: <859d8fcef654414c9ba55993adc93104@ACNMB2.ACN.ADVANTECH.CORP>
References: <tencent_17A7BBC4D15D331C1A25B4075294E5D67706@qq.com>
 <cb03b75a018e4bec83eac6898eb1d2af@ACNMB2.ACN.ADVANTECH.CORP>
 <20210427135356.GA2426@duo.ucw.cz>
In-Reply-To: <20210427135356.GA2426@duo.ucw.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.21.188.84]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUGF2ZWwNCkFzIGZvciAiIFBsZWFzZSBDYyBMRUQgZHJpdmVycyB0byB0aGUgTEVEIG1haW50
YWluZXJzLi4uIiwgZG9lcyBpdCBtZWFuIHRoYXQgSSBvbmx5IG5lZWQgdG8gQ2MgTEVEIGRyaXZl
cnMgdG8gTEVEIG1haW50YWluZXJzPw0KT3IgZG8gSSBuZWVkIHRvIHNlbmQgdGhpcyBkcml2ZXIg
dG8gbGludXgtbGVkc0B2Z2VyLmtlcm5lbC5vcmcgaW5zdGVhZCBvZiBwbGF0Zm9ybS1kcml2ZXIt
eDg2QHZnZXIua2VybmVsLm9yZy4NCg0KQmVzdCByZWdhcmRzDQpZdWVjaGFvIFpoYW8NCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFBhdmVsIE1hY2hlayBbbWFpbHRvOnBhdmVs
QHVjdy5jel0gDQpTZW50OiBUdWVzZGF5LCBBcHJpbCAyNywgMjAyMSA5OjU0IFBNDQpUbzogeXVl
Y2hhby56aGFvKOi1tei2iui2hSkgPHl1ZWNoYW8uemhhb0BhZHZhbnRlY2guY29tLmNuPg0KQ2M6
IDM0NTM1MTgzMEBxcS5jb207IFJhaW5ib3cuWmhhbmco5by1546JKSA8UmFpbmJvdy5aaGFuZ0Bh
ZHZhbnRlY2guY29tLmNuPjsgeXVueGlhLmxpKOadjuS6kemcnikgPHl1bnhpYS5saUBhZHZhbnRl
Y2guY29tLmNuPjsgSmlhLlN1aSjotL7nnaIpIDxKaWEuU3VpQGFkdmFudGVjaC5jb20uY24+OyBI
YW5zIGRlIEdvZWRlIDxoZGVnb2VkZUByZWRoYXQuY29tPjsgTWFyayBHcm9zcyA8bWdyb3NzQGxp
bnV4LmludGVsLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHBsYXRmb3JtLWRy
aXZlci14ODZAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW3YyLDEvMV0gYWR2X21peDk1
NXggaXMgYSBzY2hlbWUgdGhhdCBtdWx0aXBsZXhlcyBQQ0E5NTU0L1BDQTk1NTUgaW50byBMRUQg
YW5kIEdQSU8NCg0KT24gVHVlIDIwMjEtMDQtMjcgMDg6MzI6MDUsIHl1ZWNoYW8uemhhbyjotbXo
torotoUpIHdyb3RlOg0KPiBGcm9tOiBZdWVjaGFvIFpoYW8gPHl1ZWNoYW8uemhhb0BhZHZhbnRl
Y2guY29tLmNuPg0KPiANCj4gV2l0aCB0aGlzIGRyaXZlciwgd2UgY2FuIG11bHRpcGxleCBQQ0E5
NTU0L1BDQTk1NTUgaW50byBMRUQgYW5kIEdQSU8gYmFzZWQgb24gdGhlIEFDUEkgZGF0YSBvZiBC
SU9TLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogWXVlY2hhbyBaaGFvIDx5dWVjaGFvLnpoYW9AYWR2
YW50ZWNoLmNvbS5jbj4NCj4gU2lnbmVkLW9mZi1ieTogU3VpIEppYSA8amlhLnN1aUBhZHZhbnRl
Y2guY29tLmNuPg0KDQpQbGVhc2UgQ2MgTEVEIGRyaXZlcnMgdG8gdGhlIExFRCBtYWludGFpbmVy
cy4uLg0KDQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgdTggYW1peDk1NXhfc2V0X2JpdCh1OCB2YWws
IGludCBsZWRfaWQsIGVudW0gDQo+ICtBTUlYOTU1WF9MRUQNCj4gK3N0YXRlKSB7DQo+ICsJbGVk
X2lkICU9IEJBTktfU0laRTsNCj4gKw0KPiArCXN3aXRjaCAoc3RhdGUpIHsNCj4gKwljYXNlIEFN
SVg5NTVYX0xFRF9PTjoNCj4gKwkJdmFsICY9IH4oMSA8PCBsZWRfaWQpOyAvL0NsZWFyIGJpdA0K
PiArCQlicmVhazsNCj4gKwljYXNlIEFNSVg5NTVYX0xFRF9PRkY6DQo+ICsJCXZhbCB8PSAxIDw8
IGxlZF9pZDsgLy9TZXQgYml0DQo+ICsJCWJyZWFrOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiB2
YWw7DQoNClBsZWFzZSBjaGVjayBDb2RpbmdTdHlsZSwgYXZvaWQgdXNlbGVzcyBjb21tZW50cyBh
bmQgY2hlY2sgd29yZCB3cmFwcGluZyBpbiB5b3VyIGVtYWlsIHNldHRpbmdzLg0KDQpCZXN0IHJl
Z2FyZHMsDQoJCQkJCQkJCVBhdmVsDQoNCi0tDQpodHRwOi8vd3d3LmxpdmVqb3VybmFsLmNvbS9+
cGF2ZWxtYWNoZWsNCg==
