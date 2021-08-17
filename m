Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E119B3EE53F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 05:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbhHQDzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 23:55:50 -0400
Received: from mx21.baidu.com ([220.181.3.85]:58256 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233832AbhHQDzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 23:55:48 -0400
Received: from BJHW-Mail-Ex15.internal.baidu.com (unknown [10.127.64.38])
        by Forcepoint Email with ESMTPS id 5D366BABB1A3A351EAF1;
        Tue, 17 Aug 2021 11:55:09 +0800 (CST)
Received: from BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) by
 BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 17 Aug 2021 11:55:09 +0800
Received: from BJHW-Mail-Ex15.internal.baidu.com ([100.100.100.38]) by
 BJHW-Mail-Ex15.internal.baidu.com ([100.100.100.38]) with mapi id
 15.01.2308.014; Tue, 17 Aug 2021 11:55:09 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.co" <bristot@redhat.co>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        =?utf-8?B?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF1bUkZDXSBzY2hlZC9jcHVhY2N0OiBG?=
 =?utf-8?Q?ix_cpuacct_charge?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0hdW1JGQ10gc2NoZWQvY3B1YWNjdDogRml4IGNwdWFj?=
 =?utf-8?Q?ct_charge?=
Thread-Index: AQHXhGNHnHFIMTHAy0CLZm3Kh0/OWKtbLEpQgBq6PYCAAUdCUA==
Date:   Tue, 17 Aug 2021 03:55:08 +0000
Message-ID: <06265d4d0df7410786d0ddb9bdbc4e4c@baidu.com>
References: <20210720060441.22550-1-lirongqing@baidu.com>
 <YQKAzWT/bdwgepbU@hirez.programming.kicks-ass.net>
 <4bf6cd58adb5411e989530e1443f9698@baidu.com>
 <20210816162103.dup2hbho24wtmsgs@oracle.com>
In-Reply-To: <20210816162103.dup2hbho24wtmsgs@oracle.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.194.51]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex15_2021-08-17 11:55:09:269
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvY3B1YWNjdC5jIGIva2VybmVsL3NjaGVkL2Nw
dWFjY3QuYyBpbmRleA0KPiA+IDg5M2VlY2UuLjQ4YjExN2UgMTAwNjQ0DQo+ID4gLS0tIGEva2Vy
bmVsL3NjaGVkL2NwdWFjY3QuYw0KPiA+ICsrKyBiL2tlcm5lbC9zY2hlZC9jcHVhY2N0LmMNCj4g
PiBAQCAtMzQwLDcgKzM0MCwxMiBAQCB2b2lkIGNwdWFjY3RfY2hhcmdlKHN0cnVjdCB0YXNrX3N0
cnVjdCAqdHNrLCB1NjQNCj4gPiBjcHV0aW1lKSAgew0KPiA+ICAgICAgICAgc3RydWN0IGNwdWFj
Y3QgKmNhOw0KPiA+ICAgICAgICAgaW50IGluZGV4ID0gQ1BVQUNDVF9TVEFUX1NZU1RFTTsNCj4g
PiAtICAgICAgIHN0cnVjdCBwdF9yZWdzICpyZWdzID0gZ2V0X2lycV9yZWdzKCkgPyA6IHRhc2tf
cHRfcmVncyh0c2spOw0KPiA+ICsgICAgICAgc3RydWN0IHB0X3JlZ3MgKnJlZ3M7DQo+ID4gKw0K
PiA+ICsgICAgICAgaWYgKHRhc2tfY3B1KHRzaykgPT0gcmF3X3NtcF9wcm9jZXNzb3JfaWQoKSkN
Cj4gPiArICAgICAgICAgICAgICAgcmVncyA9IGdldF9pcnFfcmVncygpID8gOiB0YXNrX3B0X3Jl
Z3ModHNrKTsNCj4gPiArICAgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgICAgcmVncyA9IHRh
c2tfcHRfcmVncyh0c2spOw0KPiA+DQo+ID4gICAgICAgICBpZiAocmVncyAmJiB1c2VyX21vZGUo
cmVncykpDQo+ID4gICAgICAgICAgICAgICAgIGluZGV4ID0gQ1BVQUNDVF9TVEFUX1VTRVI7DQo+
IA0KPiBJdCBzdGlsbCBzdWZmZXJzIGZyb20gdGFza19wdF9yZWdzKCkuDQo+IA0KPiBXaHkgbm90
IG1ha2UgY3B1YWNjdCB1c2UgY2dyb3VwMidzIGFwcHJvYWNoPyAgUmVtZW1iZXIgb25seSBkZWx0
YV9leGVjDQo+IGhlcmUsIHRoZW4gb24gcmVhZGluZyBjcHVhY2N0LnVzYWdlXyosIHVzZSBjcHV0
aW1lX2FkanVzdCgpIHRvIHNjYWxlIHRoZQ0KPiB1c2VyL3N5cyBmcm9tIGNwdWFjY3RfYWNjb3Vu
dF9maWVsZCgpLg0KPiANCg0KSSB0aGluayB5b3VyIHN1Z2dlc3Rpb24gaXMgcmVhc29uYWJsZSwg
Q291bGQgeW91IHNlbmQgYSBwYXRjaA0KDQoNCj4gSXQncyBhcmd1YWJseSBtb3JlIHRoYW4ganVz
dCBhIGZpeCBmb3IgY2dyb3VwMSwgYnV0IHRoZXJlIGhhdmUgYmVlbiBhIGZldw0KPiBjb21wbGFp
bnRzIGFib3V0IHRoaXMgZnVuY3Rpb24gbGF0ZWx5Lg0KPiANCj4gPiAgICAgICAgIHJjdV9yZWFk
X2xvY2soKTsNCj4gPg0KPiA+ICAgICAgICAgZm9yIChjYSA9IHRhc2tfY2EodHNrKTsgY2E7IGNh
ID0gcGFyZW50X2NhKGNhKSkNCj4gPiAgICAgICAgICAgICAgIF9fdGhpc19jcHVfYWRkKGNhLT5j
cHV1c2FnZS0+dXNhZ2VzW2luZGV4XSwgY3B1dGltZSk7DQo+ID4NCj4gPiAgICAgICAgIHJjdV9y
ZWFkX3VubG9jaygpOw0KPiANCj4gQnkgdGhlIHdheSwgSSB0aGluayB0aGUgX190aGlzX2NwdV9h
ZGQoKSBjYW4gYmUgd3JvbmcgaW4gY2FzZXMgbGlrZSB5b3Ugb3JpZ2luYWxseQ0KPiBkZXNjcmli
ZS4gIFNlZW1zIGxpa2UgYSBidWcgaW4gNzNlNmFhZmQ5ZWE4ICgic2NoZWQvY3B1YWNjdDoNCj4g
U2ltcGxpZnkgdGhlIGNwdWFjY3QgY29kZSIpLg0KDQpXZSBmaW5kIHRoaXMgaXNzdWUgdG9vLg0K
DQotTGkNCg==
