Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC3C45876A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 01:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhKVA3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 19:29:14 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:26344 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhKVA3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 19:29:13 -0500
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Hy7Gp334PzbhqJ;
        Mon, 22 Nov 2021 08:21:06 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (7.185.36.136) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 08:26:05 +0800
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpemm500008.china.huawei.com (7.185.36.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 08:26:05 +0800
Received: from dggpeml100016.china.huawei.com ([7.185.36.216]) by
 dggpeml100016.china.huawei.com ([7.185.36.216]) with mapi id 15.01.2308.020;
 Mon, 22 Nov 2021 08:26:04 +0800
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: RE: [RFC] cpu/hotplug: allow the cpu in UP_PREPARE state to bringup
 again
Thread-Topic: [RFC] cpu/hotplug: allow the cpu in UP_PREPARE state to bringup
 again
Thread-Index: AQHX3WwMv84OVnHmcUuBNMrzmOUoLawOsBAA
Date:   Mon, 22 Nov 2021 00:26:04 +0000
Message-ID: <92909842c43f4d0bbeaa56f34f45cdba@huawei.com>
References: <20210901051143.2752-1-longpeng2@huawei.com>
 <20210930140118.z352cj3uzjscctcb@linutronix.de>
 <dae48783927d4c8f916bfe0776a4a341@huawei.com>
 <20211119173633.ktoxddq63zklquev@linutronix.de>
In-Reply-To: <20211119173633.ktoxddq63zklquev@linutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.148.223]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ViYXN0aWFuIEFuZHJ6
ZWogU2lld2lvciBbbWFpbHRvOmJpZ2Vhc3lAbGludXRyb25peC5kZV0NCj4gU2VudDogU2F0dXJk
YXksIE5vdmVtYmVyIDIwLCAyMDIxIDE6MzcgQU0NCj4gVG86IExvbmdwZW5nIChNaWtlLCBDbG91
ZCBJbmZyYXN0cnVjdHVyZSBTZXJ2aWNlIFByb2R1Y3QgRGVwdC4pDQo+IDxsb25ncGVuZzJAaHVh
d2VpLmNvbT4NCj4gQ2M6IHBldGVyekBpbmZyYWRlYWQub3JnOyB2YWxlbnRpbi5zY2huZWlkZXJA
YXJtLmNvbTsgbWluZ29Aa2VybmVsLm9yZzsNCj4gdGdseEBsaW51dHJvbml4LmRlOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBHb25nbGVpIChBcmVpKQ0KPiA8YXJlaS5nb25nbGVpQGh1
YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUkZDXSBjcHUvaG90cGx1ZzogYWxsb3cgdGhlIGNw
dSBpbiBVUF9QUkVQQVJFIHN0YXRlIHRvIGJyaW5ndXANCj4gYWdhaW4NCj4gDQo+IFNvcnJ5IGZv
ciBmb3JnZXR0aW5n4oCmDQo+IA0KPiBPbiAyMDIxLTEwLTA4IDAzOjEwOjM0IFsrMDAwMF0sIExv
bmdwZW5nIChNaWtlLCBDbG91ZCBJbmZyYXN0cnVjdHVyZSBTZXJ2aWNlDQo+IFByb2R1Y3QgRGVw
dC4pIHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206
IFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3IgW21haWx0bzpiaWdlYXN5QGxpbnV0cm9uaXguZGVd
DQo+ID4gPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDMwLCAyMDIxIDEwOjAxIFBNDQo+ID4g
PiBUbzogTG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJhc3RydWN0dXJlIFNlcnZpY2UgUHJvZHVj
dCBEZXB0LikNCj4gPiA+IDxsb25ncGVuZzJAaHVhd2VpLmNvbT4NCj4gPiA+IENjOiBwZXRlcnpA
aW5mcmFkZWFkLm9yZzsgdmFsZW50aW4uc2NobmVpZGVyQGFybS5jb207IG1pbmdvQGtlcm5lbC5v
cmc7DQo+ID4gPiB0Z2x4QGxpbnV0cm9uaXguZGU7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IEdvbmdsZWkgKEFyZWkpDQo+ID4gPiA8YXJlaS5nb25nbGVpQGh1YXdlaS5jb20+DQo+ID4g
PiBTdWJqZWN0OiBSZTogW1JGQ10gY3B1L2hvdHBsdWc6IGFsbG93IHRoZSBjcHUgaW4gVVBfUFJF
UEFSRSBzdGF0ZSB0byBicmluZ3VwDQo+ID4gPiBhZ2Fpbg0KPiA+ID4NCj4gPiA+IE9uIDIwMjEt
MDktMDEgMTM6MTE6NDMgWyswODAwXSwgTG9uZ3BlbmcoTWlrZSkgd3JvdGU6DQo+ID4gPiA+IFRo
ZSBjcHUncyBjcHVfaG90cGx1Z19zdGF0ZSB3aWxsIGJlIHNldCB0byBDUFVfVVBfUFJFUEFSRSBi
ZWZvcmUNCj4gPiA+ID4gdGhlIGNwdSBpcyB3YWtlbiB1cCwgYnV0IGl0IHdvbid0IGJlIHJlc2V0
IHdoZW4gdGhlIGZhaWx1cmUgb2NjdXJzLg0KPiA+ID4gPiBUaGVuIHRoZSB1c2VyIGNhbm5vdCB0
byBtYWtlIHRoZSBjcHUgb25saW5lIGFueW1vcmUsIGJlY2F1c2UgdGhlDQo+ID4gPiA+IENQVV9V
UF9QUkVQQVJFIHN0YXRlIG1ha2VzIGNwdV9jaGVja191cF9wcmVwYXJlKCkgdW5oYXBweS4NCj4g
PiA+ID4NCj4gPiA+ID4gV2Ugc2hvdWxkIGFsbG93IHRoZSB1c2VyIHRvIHRyeSBhZ2FpbiBpbiB0
aGlzIGNhc2UuDQo+ID4gPg0KPiA+ID4gQ2FuIHlvdSBwbGVhc2UgZGVzY3JpYmUgd2hlcmUgaXQg
ZmFpbGVkIC8gd2hhdCBkaWQgeW91IHJlYWNoIHRoYXQgc3RhdGU/DQo+ID4gPg0KPiA+DQo+ID4g
bmF0aXZlX2NwdV91cA0KPiA+ICAgY3B1X2NoZWNrX3VwX3ByZXBhcmUNCj4gPiAgIGRvX2Jvb3Rf
Y3B1DQo+ID4gICAgIC8qIFdhaXQgMTBzIHRvdGFsIGZvciBmaXJzdCBzaWduIG9mIGxpZmUgZnJv
bSBBUCAqLw0KPiA+DQo+ID4gSXQgd2lsbCBmYWlsIGlmIHRoZSBBUCBkb2Vzbid0IHJlc3BvbnNl
IGluIDEwcyBhbmQgdGhlbiBjcHVfaG90cGx1Z19zdGF0ZQ0KPiA+IHdpbGwgc3RheSBpbiBDUFVf
VVBfUFJFUEFSRSBzdGF0ZS4NCj4gPg0KPiA+IFRoaXMgY291bGQgaGFwcGVuIG9uIGEgdmlydHVh
bGl6ZWQgc3lzdGVtLCBlc3BlY2lhbGx5IGluIHNvbWUgc3BlY2lhbCB1c2FnZXMsDQo+ID4gZS5n
LiBTb2Z0d2FyZSBFbmNsYXZlcyBbMV1bMl0NCj4gDQo+IFNvIHdha2V1cF9jcHVfdmlhX2luaXRf
bm1pKCkgLyB3YWtldXBfc2Vjb25kYXJ5X2NwdSgpIHN1Y2NlZWRzIGJ1dCB0aGUNCj4gQ1BVIGRv
ZXMgbm90IHNob3cgdXAgd2l0aCAxMCBzZWNvbmRzLg0KPiBEb2VzIHRoZSBDUFUgY29tZSBpbiBs
YXRlciBhbmQgc3BpbnMgaW4gd2FpdF9mb3JfbWFzdGVyX2NwdSgpIG9yIGlzIHRoZQ0KPiBDUFUg
Y29tcGxldGVseSBtaXNzaW5nPw0KPiANCg0KVGhlIGNwdSBpcyBjb21wbGV0ZWx5IG1pc3Npbmcg
YXQgdGhlIG1vbWVudCBzaW5jZSB0aGUgaHlwZXJ2aXNvciBjYW4gcmVqZWN0DQphbGwgZXZlbnRz
IHRoYXQgc2VuZCB0byB0aGlzIGNwdSB3aGVuIHRoZSBlbmNsYXZlIHZtIGlzIHJ1bm5pbmcuDQoN
CkJ1dCB0aGUgY3B1IGNhbiByZWNlaXZlIHRoZSBldmVudHMgYW5kIGJyaW5nIHVwIGFnYWluIGlm
IHRoZSBlbmNsYXZlIHZtIGlzDQp0ZXJtaW5hdGVkLg0KDQoNCj4gPiBbMV0gaHR0cHM6Ly9kb2Nz
LmF3cy5hbWF6b24uY29tL2VuY2xhdmVzL2xhdGVzdC91c2VyL25pdHJvLWVuY2xhdmUuaHRtbA0K
PiA+IFsyXQ0KPiBodHRwczovL3d3dy5hbGliYWJhY2xvdWQuY29tL2hlbHAvZG9jLWRldGFpbC8y
MDM0MzMuaHRtP3NwbT1hM2MwaS4yMzk4Njc0Mi4NCj4gNjk4MTc2MTUyMC4xLjdlMzA3MTVlWkNS
WG1rDQo+ID4NCj4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMb25ncGVuZyhNaWtlKSA8bG9u
Z3BlbmcyQGh1YXdlaS5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAga2VybmVsL3NtcGJvb3Qu
YyB8IDcgKysrKysrKw0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0K
PiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL3NtcGJvb3QuYyBiL2tlcm5lbC9z
bXBib290LmMNCj4gPiA+ID4gaW5kZXggZjZiYzBiYy4uZDE4ZjhmZiAxMDA2NDQNCj4gPiA+ID4g
LS0tIGEva2VybmVsL3NtcGJvb3QuYw0KPiA+ID4gPiArKysgYi9rZXJuZWwvc21wYm9vdC5jDQo+
ID4gPiA+IEBAIC0zOTIsNiArMzkyLDEzIEBAIGludCBjcHVfY2hlY2tfdXBfcHJlcGFyZShpbnQg
Y3B1KQ0KPiA+ID4gPiAgCQkgKi8NCj4gPiA+ID4gIAkJcmV0dXJuIC1FQUdBSU47DQo+ID4gPiA+
DQo+ID4gPiA+ICsJY2FzZSBDUFVfVVBfUFJFUEFSRToNCj4gPiA+ID4gKwkJLyoNCj4gPiA+ID4g
KwkJICogVGhlIENQVSBmYWlsZWQgdG8gYnJpbmd1cCBsYXN0IHRpbWUsIGFsbG93IHRoZSB1c2Vy
DQo+ID4gPiA+ICsJCSAqIGNvbnRpbnVlIHRvIHRyeSB0byBzdGFydCBpdCB1cC4NCj4gPiA+ID4g
KwkJICovDQo+ID4gPiA+ICsJCXJldHVybiAwOw0KPiA+ID4gPiArDQo+ID4gPiA+ICAJZGVmYXVs
dDoNCj4gPiA+ID4NCj4gPiA+ID4gIAkJLyogU2hvdWxkIG5vdCBoYXBwZW4uICBGYW1vdXMgbGFz
dCB3b3Jkcy4gKi8NCj4gDQo+IFNlYmFzdGlhbg0K
