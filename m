Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8E131AE44
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 23:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbhBMWTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 17:19:55 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2840 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhBMWTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 17:19:52 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DdPq42815z13tD9;
        Sun, 14 Feb 2021 06:16:48 +0800 (CST)
Received: from dggemi712-chm.china.huawei.com (10.3.20.111) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Sun, 14 Feb 2021 06:19:08 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi712-chm.china.huawei.com (10.3.20.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Sun, 14 Feb 2021 06:18:31 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Sun, 14 Feb 2021 06:18:31 +0800
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
Thread-Index: AdcA2xDwQTa7W6j6SmS4J3iBnsSynAAcRXSAABFJYBD//354gP//dYEggAGu1ID//yBa4A==
Date:   Sat, 13 Feb 2021 22:18:31 +0000
Message-ID: <5961c215d36244a6ad5854ee17f2f496@hisilicon.com>
References: <c46ddb954cfe45d9849c911271d7ec23@hisilicon.com>
 <CAK8P3a2adJsz5hRT_eMzSoHnUBC+aK9HZ18=oAYCZ-gisEkd1w@mail.gmail.com>
 <24e0652b3afa48cdbf7c83287e43c087@hisilicon.com>
 <CAK8P3a0fwMe9LaXMfKjH46yvt6o-euZJZ4HXtVRPhYbKvAUPKg@mail.gmail.com>
 <0b766dba0b004ced94131e158cd8e67d@hisilicon.com>
 <CAK8P3a2ZnKeeZ-zEWO+vHogs0DdLuDrZet61cSmJe_UMYhtaWQ@mail.gmail.com>
In-Reply-To: <CAK8P3a2ZnKeeZ-zEWO+vHogs0DdLuDrZet61cSmJe_UMYhtaWQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.102]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiBb
bWFpbHRvOmFybmRAa2VybmVsLm9yZ10NCj4gU2VudDogU3VuZGF5LCBGZWJydWFyeSAxNCwgMjAy
MSA1OjMyIEFNDQo+IFRvOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIDxzb25nLmJhby5odWFA
aGlzaWxpY29uLmNvbT4NCj4gQ2M6IHRnbHhAbGludXRyb25peC5kZTsgZ3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmc7IGFybmRAYXJuZGIuZGU7DQo+IGdlZXJ0QGxpbnV4LW02OGsub3JnOyBmdW5h
aG9AanVyYWkub3JnOyBwaGlsYkBnbnUub3JnOyBjb3JiZXRAbHduLm5ldDsNCj4gbWluZ29AcmVk
aGF0LmNvbTsgbGludXgtbTY4a0BsaXN0cy5saW51eC1tNjhrLm9yZzsNCj4gZnRoYWluQHRlbGVn
cmFwaGljcy5jb20uYXU7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDog
UmU6IFtSRkNdIElSUSBoYW5kbGVycyBydW4gd2l0aCBzb21lIGhpZ2gtcHJpb3JpdHkgaW50ZXJy
dXB0cyhub3QgTk1JKQ0KPiBlbmFibGVkIG9uIHNvbWUgcGxhdGZvcm0NCj4gDQo+IE9uIFNhdCwg
RmViIDEzLCAyMDIxIGF0IDEyOjUwIEFNIFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykNCj4gPHNv
bmcuYmFvLmh1YUBoaXNpbGljb24uY29tPiB3cm90ZToNCj4gDQo+ID4gU28gSSB3YXMgYWN0dWFs
bHkgdHJ5aW5nIHRvIHdhcm4gdGhpcyB1bnVzdWFsIGNhc2UgLSBpbnRlcnJ1cHRzDQo+ID4gZ2V0
IG5lc3RlZCB3aGlsZSBib3RoIGluX2hhcmRpcnEoKSBhbmQgaXJxc19kaXNhYmxlZCgpIGFyZSB0
cnVlLg0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvaGFyZGlycS5oIGIvaW5j
bHVkZS9saW51eC9oYXJkaXJxLmgNCj4gPiBpbmRleCA3YzlkNmEyZDdlOTAuLmI4Y2EyNzU1NWM3
NiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2hhcmRpcnEuaA0KPiA+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvaGFyZGlycS5oDQo+ID4gQEAgLTMyLDYgKzMyLDcgQEAgc3RhdGljIF9fYWx3
YXlzX2lubGluZSB2b2lkIHJjdV9pcnFfZW50ZXJfY2hlY2tfdGljayh2b2lkKQ0KPiA+ICAgKi8N
Cj4gPiAgI2RlZmluZSBfX2lycV9lbnRlcigpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwNCj4gPiAgICAgICAgIGRvIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwNCj4gPiArICAgICAgICAgICAgICAgV0FSTl9PTkNFKGluX2hhcmRpcnEoKSAm
JiBpcnFzX2Rpc2FibGVkKCksICJuZXN0ZWQNCj4gPiBpbnRlcnJ1cHRzXG4iKTsgXA0KPiA+ICAg
ICAgICAgICAgICAgICBwcmVlbXB0X2NvdW50X2FkZChIQVJESVJRX09GRlNFVCk7ICAgICAgXA0K
PiANCj4gVGhhdCBzZWVtcyB0byBiZSBhIHJhdGhlciBoZWF2eXdlaWdodCBjaGFuZ2UgaW4gYSBj
cml0aWNhbCBwYXRoLg0KPiANCj4gQSBtb3JlIHVzZWZ1bCBjaGFuZ2UgbWlnaHQgYmUgdG8gaW1w
bGVtZW50IGxvY2tkZXAgc3VwcG9ydCBmb3IgbTY4aw0KPiBhbmQgc2VlIGlmIHRoYXQgd2FybnMg
YWJvdXQgYW55IGFjdHVhbCBwcm9ibGVtcy4gSSdtIG5vdCBzdXJlDQo+IHdoYXQgaXMgYWN0dWFs
bHkgbWlzc2luZyBmb3IgdGhhdCwgYnV0IHRoZXNlIGFyZSB0aGUgY29tbWl0cyB0aGF0DQo+IGFk
ZGVkIGl0IGZvciBvdGhlciBhcmNoaXRlY3R1cmVzIGluIHRoZSBwYXN0Og0KPiANCj4gM2M0Njk3
OTgyOTgyICgicmlzY3Y6IEVuYWJsZSBMT0NLREVQX1NVUFBPUlQgJiBmaXh1cCBUUkFDRV9JUlFG
TEFHU19TVVBQT1JUIikNCj4gMDAwNTkxZjFjYTMzICgiY3NreTogRW5hYmxlIExPQ0tERVBfU1VQ
UE9SVCIpDQo+IDc4Y2RmYjVjZjE1ZSAoIm9wZW5yaXNjOiBlbmFibGUgTE9DS0RFUF9TVVBQT1JU
IGFuZCBpcnFmbGFncyB0cmFjaW5nIikNCj4gOGYzNzFjNzUyMTU0ICgieHRlbnNhOiBlbmFibGUg
bG9ja2RlcCBzdXBwb3J0IikNCj4gYmYyZDgwOTY2ODkwICgibWljcm9ibGF6ZTogTG9ja2RlcCBz
dXBwb3J0IikNCj4gDQoNClllcy4gTTY4ayBsYWNrcyBsb2NrZGVwIHN1cHBvcnQgd2hpY2ggbWln
aHQgYmUgYWRkZWQuDQoNCj4gPiBBbmQgSSBhbHNvIHRoaW5rIGl0IGlzIGJldHRlciBmb3IgbTY4
aydzIGFyY2hfaXJxc19kaXNhYmxlZCgpIHRvDQo+ID4gcmV0dXJuIHRydWUgb25seSB3aGVuIGJv
dGggbG93IGFuZCBoaWdoIHByaW9yaXR5IGludGVycnVwdHMgYXJlDQo+ID4gZGlzYWJsZWQgcmF0
aGVyIHRoYW4gdHJ5IHRvIG11dGUgdGhpcyB3YXJuIGluIGdlbmlycSBieSBhIHdlYWtlcg0KPiA+
IGNvbmRpdGlvbjoNCj4gPiAgICAgICAgICAgICAgaWYgKFdBUk5fT05DRSghaXJxc19kaXNhYmxl
ZCgpLCJpcnEgJXUgaGFuZGxlciAlcFMgZW5hYmxlZA0KPiBpbnRlcnJ1cHRzXG4iLA0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaXJxLCBhY3Rpb24tPmhhbmRsZXIpKQ0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgbG9jYWxfaXJxX2Rpc2FibGUoKTsNCj4gPiB9DQo+ID4NCj4g
PiBUaGlzIHdhcm4gaXMgbm90IGFjdGl2YXRlZCBvbiBtNjhrIGJlY2F1c2UgaXRzIGFyY2hfaXJx
c19kaXNhYmxlZCgpIHJldHVybg0KPiA+IHRydWUgdGhvdWdoIGl0cyBoaWdoLXByaW9yaXR5IGlu
dGVycnVwdHMgYXJlIHN0aWxsIGVuYWJsZWQuDQo+IA0KPiBUaGVuIGl0IHdvdWxkIGp1c3QgZW5k
IHVwIGFsd2F5cyB3YXJuaW5nIHdoZW4gYSBuZXN0ZWQgaGFyZGlycSBoYXBwZW5zLA0KPiByaWdo
dD8gVGhhdCBzZWVtcyBubyBkaWZmZXJlbnQgdG8gZHJvcHBpbmcgc3VwcG9ydCBmb3IgbmVzdGVk
IGhhcmRpcnFzDQo+IG9uIG02OGsgYWx0b2dldGhlciwgd2hpY2ggb2YgY291cnNlIGlzIHdoYXQg
eW91IHN1Z2dlc3RlZCBhbHJlYWR5Lg0KDQpUaGlzIHdvbid0IGVuZCB1cCBhIHdhcm5pbmcgb24g
b3RoZXIgYXJjaGl0ZWN0dXJlcyBsaWtlIGFybSxhcm02NCwgeDg2IGV0Yw0KYXMgaW50ZXJydXB0
cyB3b24ndCBjb21lIHdoaWxlIGFyY2hfaXJxc19kaXNhYmxlZCgpIGlzIHRydWUgaW4gaGFyZElS
US4NCkZvciBleGFtcGxlLCBJX0JJVCBvZiBDUFNSIG9mIEFSTSBpcyBzZXQ6DQpzdGF0aWMgaW5s
aW5lIGludCBhcmNoX2lycXNfZGlzYWJsZWRfZmxhZ3ModW5zaWduZWQgbG9uZyBmbGFncykNCnsN
CglyZXR1cm4gZmxhZ3MgJiBJUlFNQVNLX0lfQklUOw0KfQ0KDQpTbyBpdCB3b3VsZCBvbmx5IGdp
dmUgYSBiYWNrdHJhY2Ugb24gcGxhdGZvcm1zIHdob3NlIGFyY2hfaXJxc19kaXNhYmxlZCgpDQpy
ZXR1cm4gdHJ1ZSB3aGlsZSBvbmx5IHNvbWUgaW50ZXJydXB0cyBhcmUgZGlzYWJsZWQgYW5kIHNv
bWUgb3RoZXJzDQphcmUgc3RpbGwgb3BlbiwgdGh1cyBuZXN0ZWQgaW50ZXJydXB0cyBjYW4gY29t
ZSB3aXRob3V0IGFueSBleHBsaWNpdA0KY29kZSB0byBlbmFibGUgaW50ZXJydXB0cy4NCg0KVGhp
cyB3YXJuIHNlZW1zIHRvIGdpdmUgY29uc2lzdGVudCBpbnRlcnByZXRhdGlvbiBvbiB3aGF0J3Mg
IlJ1biBpcnENCmhhbmRsZXJzIHdpdGggaW50ZXJydXB0cyBkaXNhYmxlZCIgaW4gY29tbWl0IGU1
OGFhM2QyZDBjYyAoIiBnZW5pcnE6DQpSdW4gaXJxIGhhbmRsZXJzIHdpdGggaW50ZXJydXB0cyBk
aXNhYmxlZCIpDQoNCj4gDQo+ICAgICAgICBBcm5kDQoNClRoYW5rcw0KQmFycnkNCg==
