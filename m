Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFEB31A828
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 00:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhBLXB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 18:01:26 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3024 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbhBLXBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 18:01:23 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Dcppd2N3szRDVg;
        Sat, 13 Feb 2021 06:59:21 +0800 (CST)
Received: from dggemi709-chm.china.huawei.com (10.3.20.108) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Sat, 13 Feb 2021 07:00:39 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi709-chm.china.huawei.com (10.3.20.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sat, 13 Feb 2021 07:00:39 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Sat, 13 Feb 2021 07:00:39 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "funaho@jurai.org" <funaho@jurai.org>,
        "philb@gnu.org" <philb@gnu.org>, "corbet@lwn.net" <corbet@lwn.net>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] IRQ handlers run with some high-priority interrupts(not
 NMI) enabled on some platform
Thread-Topic: [RFC] IRQ handlers run with some high-priority interrupts(not
 NMI) enabled on some platform
Thread-Index: AdcA2xDwQTa7W6j6SmS4J3iBnsSynAAcRXSAABFJYBA=
Date:   Fri, 12 Feb 2021 23:00:39 +0000
Message-ID: <24e0652b3afa48cdbf7c83287e43c087@hisilicon.com>
References: <c46ddb954cfe45d9849c911271d7ec23@hisilicon.com>
 <CAK8P3a2adJsz5hRT_eMzSoHnUBC+aK9HZ18=oAYCZ-gisEkd1w@mail.gmail.com>
In-Reply-To: <CAK8P3a2adJsz5hRT_eMzSoHnUBC+aK9HZ18=oAYCZ-gisEkd1w@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.105]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiBb
bWFpbHRvOmFybmRAa2VybmVsLm9yZ10NCj4gU2VudDogU2F0dXJkYXksIEZlYnJ1YXJ5IDEzLCAy
MDIxIDExOjM0IEFNDQo+IFRvOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIDxzb25nLmJhby5o
dWFAaGlzaWxpY29uLmNvbT4NCj4gQ2M6IHRnbHhAbGludXRyb25peC5kZTsgZ3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc7IGFybmRAYXJuZGIuZGU7DQo+IGdlZXJ0QGxpbnV4LW02OGsub3JnOyBm
dW5haG9AanVyYWkub3JnOyBwaGlsYkBnbnUub3JnOyBjb3JiZXRAbHduLm5ldDsNCj4gbWluZ29A
cmVkaGF0LmNvbTsgbGludXgtbTY4a0BsaXN0cy5saW51eC1tNjhrLm9yZzsNCj4gZnRoYWluQHRl
bGVncmFwaGljcy5jb20uYXU7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUmU6IFtSRkNdIElSUSBoYW5kbGVycyBydW4gd2l0aCBzb21lIGhpZ2gtcHJpb3JpdHkgaW50
ZXJydXB0cyhub3QgTk1JKQ0KPiBlbmFibGVkIG9uIHNvbWUgcGxhdGZvcm0NCj4gDQo+IE9uIEZy
aSwgRmViIDEyLCAyMDIxIGF0IDI6MTggQU0gU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKQ0KPiA8
c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+IHdyb3RlOg0KPiANCj4gPiBTbyBJIGFtIHJlcXVl
c3RpbmcgY29tbWVudHMgb246DQo+ID4gMS4gYXJlIHdlIGV4cGVjdGluZyBhbGwgaW50ZXJydXB0
cyBleGNlcHQgTk1JIHRvIGJlIGRpc2FibGVkIGluIGlycSBoYW5kbGVyLA0KPiA+IG9yIGRvIHdl
IGFjdHVhbGx5IGFsbG93IHNvbWUgaGlnaC1wcmlvcml0eSBpbnRlcnJ1cHRzIGJldHdlZW4gbG93
IGFuZCBOTUkNCj4gdG8NCj4gPiBjb21lIGluIHNvbWUgcGxhdGZvcm1zPw0KPiANCj4gSSB0cmll
ZCB0byBjb21lIHRvIGFuIGFuc3dlciBidXQgdGhpcyBkb2VzIG5vdCBzZWVtIHBhcnRpY3VsYXJs
eSB3ZWxsLWRlZmluZWQuDQo+IFRoZXJlIGFyZSBhIGZldyB0aGluZ3MgSSBub3RpY2VkOg0KPiAN
Cj4gLSBnb2luZyB0aHJvdWdoIHRoZSBsb2NhbF9pcnFfc2F2ZSgpL3Jlc3RvcmUoKSBpbXBsZW1l
bnRhdGlvbnMgb24gYWxsDQo+ICAgYXJjaGl0ZWN0dXJlcywgSSBkaWQgbm90IGZpbmQgYW55IG90
aGVyIG9uZXMgYmVzaWRlcyBtNjhrIHRoYXQgbGVhdmUNCj4gICBoaWdoLXByaW9yaXR5IGludGVy
cnVwdHMgZW5hYmxlZC4gSSBkaWQgc2VlIHRoYXQgYXQgbGVhc3QgYWxwaGEgYW5kIG9wZW5yaXNj
DQo+ICAgYXJlIGRlc2lnbmVkIHRvIHN1cHBvcnQgdGhhdCBpbiBoYXJkd2FyZSwgYnV0IHRoZSBj
b2RlIGp1c3QgbGVhdmVzIHRoZQ0KPiAgIGludGVycnVwdHMgZGlzYWJsZWQuDQoNClRoZSBjYXNl
IGlzIGEgbGl0dGxlIGRpZmZlcmVudC4gRXhwbGljaXQgbG9jYWxfaXJxX3NhdmUoKSBkb2VzIGRp
c2FibGUgYWxsDQpoaWdoIHByaW9yaXR5IGludGVycnVwdHMgb24gbTY4ay4gVGhlIG9ubHkgZGlm
ZmVyZW5jZSBpcyBhcmNoX2lycXNfZGlzYWJsZWQoKQ0Kb2YgbTY4ayB3aWxsIHJldHVybiB0cnVl
IHdoaWxlIGxvdy1wcmlvcml0eSBpbnRlcnJ1cHRzIGFyZSBtYXNrZWQgYW5kIGhpZ2gNCi1wcmlv
cml0eSBhcmUgc3RpbGwgb3Blbi4gTTY4aydzIGhhcmRJUlEgYWxzbyBydW5zIGluIHRoaXMgY29u
dGV4dCB3aXRoIGhpZ2gNCnByaW9yaXR5IGludGVycnVwdHMgZW5hYmxlZC4NCg0KPiANCj4gLSBU
aGUgZ2VuZXJpYyBjb2RlIGlzIGNsZWFybHkgcHJlcGFyZWQgdG8gaGFuZGxlIG5lc3RlZCBoYXJk
aXJxcywgYW5kDQo+ICAgIHRoZSBpcnFfZW50ZXIoKS9pcnFfZXhpdCgpIGZ1bmN0aW9ucyBoYXZl
IGEgY291bnRlciBpbiBwcmVlbXB0X2NvdW50DQo+ICAgIGZvciB0aGUgbmVzdGluZyBsZXZlbCwg
dXNpbmcgYSA0LWJpdCBudW1iZXIgZm9yIGhhcmRpcnEsIHBsdXMgYW5vdGhlcg0KPiAgICA0LWJp
dCBudW1iZXIgZm9yIE5NSS4NCg0KWWVzLCBJIHVuZGVyc3RhbmQgbmVzdGVkIGludGVycnVwdHMg
YXJlIHN1cHBvcnRlZCBieSBhbiBleHBsaWNpdCANCmxvY2FsX2lycV9lbmFibGVfaW5faGFyZGly
cSgpLiBNazY4aydzIGNhc2UgaXMgZGlmZmVyZW50LCBuZXN0ZWQNCmludGVycnVwdHMgY2FuIGNv
bWUgd2l0aCBhcmNoX2lycXNfZGlzYWJsZWQoKSBpcyB0cnVlIGFuZCB3aGlsZQ0Kbm9ib2R5IGhh
cyBjYWxsZWQgbG9jYWxfaXJxX2VuYWJsZV9pbl9oYXJkaXJxKCkgaW4gdGhlIHByZXZpb3VzDQpo
YXJkSVJRIGJlY2F1c2UgaGFyZElSUSBrZWVwcyBoaWdoLXByaW9yaXR5IGludGVycnVwdHMgb3Bl
bi4NCg0KPiANCj4gLSBUaGVyZSBhcmUgYSBjb3VwbGUgb2YgKGFuY2llbnQpIGRyaXZlcnMgdGhh
dCBlbmFibGUgaW50ZXJydXB0cyBpbiB0aGVpcg0KPiAgICBpbnRlcnJ1cHQgaGFuZGxlcnMsIHNl
ZSB0aGUgZm91ciBjYWxsZXJzIG9mIGxvY2FsX2lycV9lbmFibGVfaW5faGFyZGlycSgpDQo+ICAg
IChhbGwgaW4gdGhlIG9sZCBkcml2ZXJzL2lkZSBzdGFjaykgYW5kIGFyY2gvaWE2NC9rZXJuZWwv
dGltZS5jLCB3aGljaA0KPiAgICBlbmFibGVzIGludGVydXB0cyBpbiBpdHMgdGltZXIgZnVuY3Rp
b24gKEkgcmVjZW50bHkgdHJpZWQgcmVtb3ZpbmcgdGhpcw0KPiAgICBhbmQgbXkgcGF0Y2ggYnJv
a2UgaWE2NCB0aW1lcnMsIGJ1dCBJJ20gbm90IHN1cmUgaWYgdGhlIGNhdXNlIHdhcw0KPiAgICB0
aGUgbG9jYWxfaXJxX2VuYWJsZSgpIG9yIHNvbWV0aGluZyBlbHNlKS4NCj4gDQo+IC0gVGhlIGxv
Y2FsX2lycV9lbmFibGVfaW5faGFyZGlycSgpIGZ1bmN0aW9uIGl0c2VsZiB0dXJucyBpbnRvIGEg
bm9wDQo+ICAgd2hlbiBsb2NrZGVwIGlzIGVuYWJsZWQsIHNpbmNlIGQ3ZTk2MjlkZTA1MSAoIltQ
QVRDSF0gbG9ja2RlcDoNCj4gICBhZGQgbG9jYWxfaXJxX2VuYWJsZV9pbl9oYXJkaXJxKCkgQVBJ
IikuIEFjY29yZGluZyB0byB0aGUgY29tbWVudA0KPiAgIGluIHRoZXJlLCBsb2NrZGVwIGFscmVh
ZHkgZW5mb3JjZXMgdGhlIGJlaGF2aW9yIHlvdSBzdWdnZXN0LiBOb3RlIHRoYXQNCj4gICBsb2Nr
ZGVwIHN1cHBvcnQgaXMgbWlzc2luZyBvbiBtNjhrIChhbmQgYWxzbyBhbHBoYSwgaDgzMDAsIGlh
NjQsIG5pb3MyLA0KPiAgIGFuZCBwYXJpc2MpLg0KPiANCj4gPiAyLiBJZiBlaXRoZXIgc2lkZSBp
cyB0cnVlLCBJIHRoaW5rIHdlIG5lZWQgdG8gZG9jdW1lbnQgaXQgc29tZXdoZXJlIGFzIHRoZXJl
DQo+ID4gaXMgYWx3YXlzIGNvbmZ1c2lvbiBhYm91dCB0aGlzLg0KPiA+DQo+ID4gUGVyc29uYWxs
eSwgSSB3b3VsZCBleHBlY3QgYWxsIGludGVycnVwdHMgdG8gYmUgZGlzYWJsZWQgYW5kIEkgbGlr
ZSB0aGUgd2F5DQo+ID4gb2YgQVJNNjQgdG8gb25seSB1c2UgaGlnaC1wcmlvcml0eSBpbnRlcnJ1
cHQgYXMgcHNldWRvIE5NSToNCj4gPiBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvNzU1OTA2Lw0K
PiA+IFRob3VnaCBGaW5uIGFyZ3VlZCB0aGF0IHRoaXMgd2lsbCBjb250cmlidXRlIHRvIGxvc2Ug
aGFyZHdhcmUgZmVhdHVyZSBvZiBtNjhrLg0KPiANCj4gUmVnYXJkbGVzcyBvZiB3aGF0IGlzIGRv
Y3VtZW50ZWQsIEkgd291bGQgYXJndWUgdGhhdCBhbnkgcGxhdGZvcm0NCj4gdGhhdCByZWxpZXMg
b24gdGhpcyBpcyBhdCB0aGUgbWluaW11bSBkb2luZyBzb21ldGhpbmcgcmlza3kgYmVjYXVzZSBh
dA0KPiB0aGUgbWluaW11bSB0aGlzIHJ1bnMgaW50byBoYXJkIHRvIGRlYnVnIGNvZGUgcGF0aHMg
dGhhdCBhcmUgbm90DQo+IGV4ZXJjaXNlZCBvbiBhbnkgb2YgdGhlIGNvbW1vbiBhcmNoaXRlY3R1
cmVzLg0KPiANCj4gICAgICAgICBBcm5kDQoNCg0KVGhhbmtzDQpCYXJyeQ0KDQo=
