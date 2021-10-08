Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1064262BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 05:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhJHDMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 23:12:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28896 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhJHDMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 23:12:30 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HQY425yG3zbn0G;
        Fri,  8 Oct 2021 11:06:10 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 11:10:34 +0800
Received: from dggpeml100016.china.huawei.com (7.185.36.216) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 11:10:34 +0800
Received: from dggpeml100016.china.huawei.com ([7.185.36.216]) by
 dggpeml100016.china.huawei.com ([7.185.36.216]) with mapi id 15.01.2308.008;
 Fri, 8 Oct 2021 11:10:34 +0800
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
Thread-Index: AQHXtgOraFU9tinyd0CEjjIpTs+60KvIby1w
Date:   Fri, 8 Oct 2021 03:10:34 +0000
Message-ID: <dae48783927d4c8f916bfe0776a4a341@huawei.com>
References: <20210901051143.2752-1-longpeng2@huawei.com>
 <20210930140118.z352cj3uzjscctcb@linutronix.de>
In-Reply-To: <20210930140118.z352cj3uzjscctcb@linutronix.de>
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
ZWogU2lld2lvciBbbWFpbHRvOmJpZ2Vhc3lAbGludXRyb25peC5kZV0NCj4gU2VudDogVGh1cnNk
YXksIFNlcHRlbWJlciAzMCwgMjAyMSAxMDowMSBQTQ0KPiBUbzogTG9uZ3BlbmcgKE1pa2UsIENs
b3VkIEluZnJhc3RydWN0dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0LikNCj4gPGxvbmdwZW5nMkBo
dWF3ZWkuY29tPg0KPiBDYzogcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IHZhbGVudGluLnNjaG5laWRl
ckBhcm0uY29tOyBtaW5nb0BrZXJuZWwub3JnOw0KPiB0Z2x4QGxpbnV0cm9uaXguZGU7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEdvbmdsZWkgKEFyZWkpDQo+IDxhcmVpLmdvbmdsZWlA
aHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkNdIGNwdS9ob3RwbHVnOiBhbGxvdyB0aGUg
Y3B1IGluIFVQX1BSRVBBUkUgc3RhdGUgdG8gYnJpbmd1cA0KPiBhZ2Fpbg0KPiANCj4gT24gMjAy
MS0wOS0wMSAxMzoxMTo0MyBbKzA4MDBdLCBMb25ncGVuZyhNaWtlKSB3cm90ZToNCj4gPiBUaGUg
Y3B1J3MgY3B1X2hvdHBsdWdfc3RhdGUgd2lsbCBiZSBzZXQgdG8gQ1BVX1VQX1BSRVBBUkUgYmVm
b3JlDQo+ID4gdGhlIGNwdSBpcyB3YWtlbiB1cCwgYnV0IGl0IHdvbid0IGJlIHJlc2V0IHdoZW4g
dGhlIGZhaWx1cmUgb2NjdXJzLg0KPiA+IFRoZW4gdGhlIHVzZXIgY2Fubm90IHRvIG1ha2UgdGhl
IGNwdSBvbmxpbmUgYW55bW9yZSwgYmVjYXVzZSB0aGUNCj4gPiBDUFVfVVBfUFJFUEFSRSBzdGF0
ZSBtYWtlcyBjcHVfY2hlY2tfdXBfcHJlcGFyZSgpIHVuaGFwcHkuDQo+ID4NCj4gPiBXZSBzaG91
bGQgYWxsb3cgdGhlIHVzZXIgdG8gdHJ5IGFnYWluIGluIHRoaXMgY2FzZS4NCj4gDQo+IENhbiB5
b3UgcGxlYXNlIGRlc2NyaWJlIHdoZXJlIGl0IGZhaWxlZCAvIHdoYXQgZGlkIHlvdSByZWFjaCB0
aGF0IHN0YXRlPw0KPiANCg0KbmF0aXZlX2NwdV91cA0KICBjcHVfY2hlY2tfdXBfcHJlcGFyZQ0K
ICBkb19ib290X2NwdQ0KICAgIC8qIFdhaXQgMTBzIHRvdGFsIGZvciBmaXJzdCBzaWduIG9mIGxp
ZmUgZnJvbSBBUCAqLw0KDQpJdCB3aWxsIGZhaWwgaWYgdGhlIEFQIGRvZXNuJ3QgcmVzcG9uc2Ug
aW4gMTBzIGFuZCB0aGVuIGNwdV9ob3RwbHVnX3N0YXRlDQp3aWxsIHN0YXkgaW4gQ1BVX1VQX1BS
RVBBUkUgc3RhdGUuDQoNClRoaXMgY291bGQgaGFwcGVuIG9uIGEgdmlydHVhbGl6ZWQgc3lzdGVt
LCBlc3BlY2lhbGx5IGluIHNvbWUgc3BlY2lhbCB1c2FnZXMsDQplLmcuIFNvZnR3YXJlIEVuY2xh
dmVzIFsxXVsyXQ0KDQpbMV0gaHR0cHM6Ly9kb2NzLmF3cy5hbWF6b24uY29tL2VuY2xhdmVzL2xh
dGVzdC91c2VyL25pdHJvLWVuY2xhdmUuaHRtbA0KWzJdIGh0dHBzOi8vd3d3LmFsaWJhYmFjbG91
ZC5jb20vaGVscC9kb2MtZGV0YWlsLzIwMzQzMy5odG0/c3BtPWEzYzBpLjIzOTg2NzQyLjY5ODE3
NjE1MjAuMS43ZTMwNzE1ZVpDUlhtaw0KDQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBMb25ncGVuZyhN
aWtlKSA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+DQo+ID4gLS0tDQo+ID4gIGtlcm5lbC9zbXBib290
LmMgfCA3ICsrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9zbXBib290LmMgYi9rZXJuZWwvc21wYm9vdC5jDQo+
ID4gaW5kZXggZjZiYzBiYy4uZDE4ZjhmZiAxMDA2NDQNCj4gPiAtLS0gYS9rZXJuZWwvc21wYm9v
dC5jDQo+ID4gKysrIGIva2VybmVsL3NtcGJvb3QuYw0KPiA+IEBAIC0zOTIsNiArMzkyLDEzIEBA
IGludCBjcHVfY2hlY2tfdXBfcHJlcGFyZShpbnQgY3B1KQ0KPiA+ICAJCSAqLw0KPiA+ICAJCXJl
dHVybiAtRUFHQUlOOw0KPiA+DQo+ID4gKwljYXNlIENQVV9VUF9QUkVQQVJFOg0KPiA+ICsJCS8q
DQo+ID4gKwkJICogVGhlIENQVSBmYWlsZWQgdG8gYnJpbmd1cCBsYXN0IHRpbWUsIGFsbG93IHRo
ZSB1c2VyDQo+ID4gKwkJICogY29udGludWUgdG8gdHJ5IHRvIHN0YXJ0IGl0IHVwLg0KPiA+ICsJ
CSAqLw0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsNCj4gPiAgCWRlZmF1bHQ6DQo+ID4NCj4gPiAg
CQkvKiBTaG91bGQgbm90IGhhcHBlbi4gIEZhbW91cyBsYXN0IHdvcmRzLiAqLw0KPiA+IC0tDQo+
ID4gMS44LjMuMQ0KPiANCj4gU2ViYXN0aWFuDQo=
