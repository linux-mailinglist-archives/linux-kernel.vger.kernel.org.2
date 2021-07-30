Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837483DB4F4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 10:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbhG3IRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 04:17:03 -0400
Received: from mx20.baidu.com ([111.202.115.85]:50072 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237905AbhG3IRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:17:01 -0400
Received: from BJHW-Mail-Ex15.internal.baidu.com (unknown [10.127.64.38])
        by Forcepoint Email with ESMTPS id A450A2F309AB4AE9BE34;
        Fri, 30 Jul 2021 16:16:54 +0800 (CST)
Received: from BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) by
 BJHW-Mail-Ex15.internal.baidu.com (10.127.64.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 30 Jul 2021 16:16:54 +0800
Received: from BJHW-Mail-Ex15.internal.baidu.com ([100.100.100.38]) by
 BJHW-Mail-Ex15.internal.baidu.com ([100.100.100.38]) with mapi id
 15.01.2308.014; Fri, 30 Jul 2021 16:16:54 +0800
From:   "Li,Rongqing" <lirongqing@baidu.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.co" <bristot@redhat.co>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXVtSRkNdIHNjaGVkL2NwdWFjY3Q6IEZpeCBjcHVhY2N0?=
 =?gb2312?Q?_charge?=
Thread-Topic: [PATCH][RFC] sched/cpuacct: Fix cpuacct charge
Thread-Index: AQHXhGNHnHFIMTHAy0CLZm3Kh0/OWKtbLEpQ
Date:   Fri, 30 Jul 2021 08:16:54 +0000
Message-ID: <4bf6cd58adb5411e989530e1443f9698@baidu.com>
References: <20210720060441.22550-1-lirongqing@baidu.com>
 <YQKAzWT/bdwgepbU@hirez.programming.kicks-ass.net>
In-Reply-To: <YQKAzWT/bdwgepbU@hirez.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.193.253]
x-baidu-bdmsfe-datecheck: 1_BJHW-Mail-Ex15_2021-07-30 16:16:54:560
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS3Tyrz+1K28/i0tLS0tDQo+ILeivP7IyzogUGV0ZXIgWmlqbHN0cmEgPHBldGVy
ekBpbmZyYWRlYWQub3JnPg0KPiC3osvNyrG85DogMjAyMcTqN9TCMjnI1SAxODoyMA0KPiDK1bz+
yMs6IExpLFJvbmdxaW5nIDxsaXJvbmdxaW5nQGJhaWR1LmNvbT4NCj4gs63LzTogbWluZ29AcmVk
aGF0LmNvbTsganVyaS5sZWxsaUByZWRoYXQuY29tOyB2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9y
ZzsNCj4gZGlldG1hci5lZ2dlbWFubkBhcm0uY29tOyByb3N0ZWR0QGdvb2RtaXMub3JnOyBic2Vn
YWxsQGdvb2dsZS5jb207DQo+IG1nb3JtYW5Ac3VzZS5kZTsgYnJpc3RvdEByZWRoYXQuY287IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IHNvbmdtdWNodW5AYnl0ZWRhbmNlLmNvbQ0K
PiDW98ziOiBSZTogW1BBVENIXVtSRkNdIHNjaGVkL2NwdWFjY3Q6IEZpeCBjcHVhY2N0IGNoYXJn
ZQ0KPiANCj4gT24gVHVlLCBKdWwgMjAsIDIwMjEgYXQgMDI6MDQ6NDFQTSArMDgwMCwgTGkgUm9u
Z1Fpbmcgd3JvdGU6DQo+ID4gZ2V0X2lycV9yZWdzIG9ubHkgd29yayBmb3IgY3VycmVudCBydW5u
aW5nIGNwdSwgYnV0IHRoZSB0YXNrLCB3aG9zZQ0KPiA+IGNwdWFjY3Qgd2lsbCBiZSBjaGFyZ2Vk
LCBtYXliZSBydW4gZGlmZmVyZW50IGNwdSwgbGlrZSBDcHUgMiB3YWtlIHVwIGENCj4gPiBrZXJu
ZWwgdGhyZWFkIHRvIENQVSAzLCBjYXVzZSBDUFUgMyB0YXNrIGFyZSBjaGFyZ2VkIHdpdGggdGhl
DQo+ID4gZm9sbG93aW5nIHN0YWNrDQo+ID4NCj4gPiAgIGNwdWFjY3RfY2hhcmdlKzB4ZDgvMHgx
MDANCj4gPiAgIHVwZGF0ZV9jdXJyKzB4ZTEvMHgxZTANCj4gPiAgIGVucXVldWVfZW50aXR5KzB4
MTQ0LzB4NmUwDQo+ID4gICBlbnF1ZXVlX3Rhc2tfZmFpcisweDkzLzB4OTAwDQo+ID4gICB0dHd1
X2RvX2FjdGl2YXRlKzB4NGIvMHg5MA0KPiA+ICAgdHJ5X3RvX3dha2VfdXArMHgyMGIvMHg1MzAN
Cj4gPiAgID8gdXBkYXRlX2RsX3JxX2xvYWRfYXZnKzB4MTBmLzB4MjEwDQo+ID4gICBzd2FrZV91
cF9sb2NrZWQucGFydC4xKzB4MTMvMHg0MA0KPiA+ICAgc3dha2VfdXBfb25lKzB4MjcvMHg0MA0K
PiA+ICAgcmN1X3Byb2Nlc3NfY2FsbGJhY2tzKzB4NDg0LzB4NGYwDQo+ID4gICA/IHJ1bl9yZWJh
bGFuY2VfZG9tYWluc19idCsweDVhLzB4MTgwDQo+ID4gICBfX2RvX3NvZnRpcnErMHhlMy8weDMw
OA0KPiA+ICAgaXJxX2V4aXQrMHhmMC8weDEwMA0KPiA+ICAgc21wX2FwaWNfdGltZXJfaW50ZXJy
dXB0KzB4NzQvMHgxNjANCj4gPiAgIGFwaWNfdGltZXJfaW50ZXJydXB0KzB4Zi8weDIwDQo+ID4g
ICA8L0lSUT4NCj4gPiAgUklQOiAwMDMzOjB4NDU2OTQ3DQo+ID4NCj4gPiBzbyBkZWZpbmUgYSBn
ZXRfaXJxX3JlZ3NfY3B1IHdoaWNoIHJldHVybnMgdGhlIHJlcXVpcmVkIGNwdSBpcnENCj4gPiBy
ZWdpc3RlcnMNCj4gPg0KPiA+IEJVVCBpdCBzaG91bGQgYmUgbm90IHNhZmUsIGFuZCBkbyBub3Qg
a25vdyB3aGF0IGl0IHNob3VsZCBiZSBsaWtlIGluIE1JUFM/DQo+ID4NCj4gPiBGaXhlczogZGJl
OTMzNzEwOWMyICIoc2NoZWQvY3B1YWNjdDogRml4IGNoYXJnZSBjcHVhY2N0LnVzYWdlX3N5cyki
DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBaaGFvIEppZSA8emhhb2ppZTE3QGJhaWR1LmNvbT4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBaaGFvIEppZSA8emhhb2ppZTE3QGJhaWR1LmNvbT4NCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBMaSBSb25nUWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+DQo+ID4gLS0tDQo+
ID4gIGluY2x1ZGUvYXNtLWdlbmVyaWMvaXJxX3JlZ3MuaCB8IDUgKysrKysNCj4gPiAga2VybmVs
L3NjaGVkL2NwdWFjY3QuYyAgICAgICAgIHwgMyArKy0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2FzbS1nZW5lcmljL2lycV9yZWdzLmgNCj4gPiBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvaXJx
X3JlZ3MuaCBpbmRleCAyZTdjNmU4Li45M2UyNTc5IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUv
YXNtLWdlbmVyaWMvaXJxX3JlZ3MuaA0KPiA+ICsrKyBiL2luY2x1ZGUvYXNtLWdlbmVyaWMvaXJx
X3JlZ3MuaA0KPiA+IEBAIC0yMSw2ICsyMSwxMSBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBwdF9y
ZWdzICpnZXRfaXJxX3JlZ3Modm9pZCkNCj4gPiAgCXJldHVybiBfX3RoaXNfY3B1X3JlYWQoX19p
cnFfcmVncyk7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW5saW5lIHN0cnVjdCBwdF9yZWdz
ICpnZXRfaXJxX3JlZ3NfY3B1KGludCBjcHUpIHsNCj4gPiArCXJldHVybiBwZXJfY3B1KF9faXJx
X3JlZ3MsIGNwdSk7DQo+ID4gK30NCj4gDQo+IFRoaXMgcHJpbWl0aXZlIGp1c3QgY2Fubm90IGJl
IHJpZ2h0Li4uIGl0J2xsIGdldCB5b3Ugc29tZSByYW5kb20gZGF0YS4NCg0KVHJ1ZQ0KDQpTZWVt
IG5vIGVhc3kgdG8gZml4LiBIb3cgYWJvdXQgYSBwYXJ0aWFsIGZpeA0KDQoNCmRpZmYgLS1naXQg
YS9rZXJuZWwvc2NoZWQvY3B1YWNjdC5jIGIva2VybmVsL3NjaGVkL2NwdWFjY3QuYw0KaW5kZXgg
ODkzZWVjZS4uNDhiMTE3ZSAxMDA2NDQNCi0tLSBhL2tlcm5lbC9zY2hlZC9jcHVhY2N0LmMNCisr
KyBiL2tlcm5lbC9zY2hlZC9jcHVhY2N0LmMNCkBAIC0zNDAsNyArMzQwLDEyIEBAIHZvaWQgY3B1
YWNjdF9jaGFyZ2Uoc3RydWN0IHRhc2tfc3RydWN0ICp0c2ssIHU2NCBjcHV0aW1lKQ0KIHsNCiAg
ICAgICAgc3RydWN0IGNwdWFjY3QgKmNhOw0KICAgICAgICBpbnQgaW5kZXggPSBDUFVBQ0NUX1NU
QVRfU1lTVEVNOw0KLSAgICAgICBzdHJ1Y3QgcHRfcmVncyAqcmVncyA9IGdldF9pcnFfcmVncygp
ID8gOiB0YXNrX3B0X3JlZ3ModHNrKTsNCisgICAgICAgc3RydWN0IHB0X3JlZ3MgKnJlZ3M7DQor
DQorICAgICAgIGlmICh0YXNrX2NwdSh0c2spID09IHJhd19zbXBfcHJvY2Vzc29yX2lkKCkpDQor
ICAgICAgICAgICAgICAgcmVncyA9IGdldF9pcnFfcmVncygpID8gOiB0YXNrX3B0X3JlZ3ModHNr
KTsNCisgICAgICAgZWxzZQ0KKyAgICAgICAgICAgICAgIHJlZ3MgPSB0YXNrX3B0X3JlZ3ModHNr
KTsNCg0KICAgICAgICBpZiAocmVncyAmJiB1c2VyX21vZGUocmVncykpDQogICAgICAgICAgICAg
ICAgaW5kZXggPSBDUFVBQ0NUX1NUQVRfVVNFUjsNCg==
