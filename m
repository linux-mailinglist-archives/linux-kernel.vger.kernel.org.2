Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0631F30E4FC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhBCVcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:32:12 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3416 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhBCVcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:32:00 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DWFFd35DWz5Lvq;
        Thu,  4 Feb 2021 05:29:57 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 4 Feb 2021 05:31:16 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Thu, 4 Feb 2021 05:31:16 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Meelis Roos <mroos@linux.ee>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>
Subject: RE: [PATCH v2] sched/topology: fix the issue groups don't span
 domain->span for NUMA diameter > 2
Thread-Topic: [PATCH v2] sched/topology: fix the issue groups don't span
 domain->span for NUMA diameter > 2
Thread-Index: AQHW+h42U7QNiWetGE+PWD4uLCFytKpFzSyAgAEcTEA=
Date:   Wed, 3 Feb 2021 21:31:15 +0000
Message-ID: <c7f231bf830b4c94adb6a34cc8a4b930@hisilicon.com>
References: <20210203111201.20720-1-song.bao.hua@hisilicon.com>
 <d3ec7706-6560-70dd-d968-26460ce0c666@linux.ee>
In-Reply-To: <d3ec7706-6560-70dd-d968-26460ce0c666@linux.ee>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.63]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWVlbGlzIFJvb3MgW21h
aWx0bzptcm9vc0BsaW51eC5lZV0NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDQsIDIwMjEg
MTI6NTggQU0NCj4gVG86IFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgPHNvbmcuYmFvLmh1YUBo
aXNpbGljb24uY29tPjsNCj4gdmFsZW50aW4uc2NobmVpZGVyQGFybS5jb207IHZpbmNlbnQuZ3Vp
dHRvdEBsaW5hcm8ub3JnOyBtZ29ybWFuQHN1c2UuZGU7DQo+IG1pbmdvQGtlcm5lbC5vcmc7IHBl
dGVyekBpbmZyYWRlYWQub3JnOyBkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb207DQo+IG1vcnRlbi5y
YXNtdXNzZW5AYXJtLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogbGlu
dXhhcm1Ab3BlbmV1bGVyLm9yZzsgeHV3ZWkgKE8pIDx4dXdlaTVAaHVhd2VpLmNvbT47IExpZ3Vv
emh1IChLZW5uZXRoKQ0KPiA8bGlndW96aHVAaGlzaWxpY29uLmNvbT47IHRpYW50YW8gKEgpIDx0
aWFudGFvNkBoaXNpbGljb24uY29tPjsgd2FuZ2h1aXFpYW5nDQo+IDx3YW5naHVpcWlhbmdAaHVh
d2VpLmNvbT47IFplbmd0YW8gKEIpIDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+OyBKb25hdGhh
bg0KPiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+OyBndW9kb25nLnh1QGxp
bmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2Ml0gc2NoZWQvdG9wb2xvZ3k6IGZpeCB0
aGUgaXNzdWUgZ3JvdXBzIGRvbid0IHNwYW4NCj4gZG9tYWluLT5zcGFuIGZvciBOVU1BIGRpYW1l
dGVyID4gMg0KPiANCj4gMDMuMDIuMjEgMTM6MTIgQmFycnkgU29uZyB3cm90ZToNCj4gPiBrZXJu
ZWwvc2NoZWQvdG9wb2xvZ3kuYyB8IDg1ICsrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgMzIgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL3NjaGVkL3RvcG9sb2d5LmMg
Yi9rZXJuZWwvc2NoZWQvdG9wb2xvZ3kuYw0KPiA+IGluZGV4IDVkMzY3NWM3YTc2Yi4uOTY0ZWQ4
OTAwMWZlIDEwMDY0NA0KPiA+IC0tLSBhL2tlcm5lbC9zY2hlZC90b3BvbG9neS5jDQo+ID4gKysr
IGIva2VybmVsL3NjaGVkL3RvcG9sb2d5LmMNCj4gDQo+IFRoaXMgb25lIHN0aWxsIHdvcmtzIG9u
IHRoZSBTdW4gWDQ2MDAtTTIsIG9uIHRvcCBvZiB2NS4xMS1yYzYtNTUtZzNhYWYwYTI3ZmZjMi4N
Cj4gDQo+IA0KPiBQZXJmb3JtYW5jZS13aXNlIC0gaXMgdGhlIHNvbWUgc2ltcGxlIGJlbmhtYXJr
IHRvIHJ1biB0byBtZWF1cmUgdGhlIGltcGFjdD8NCj4gQ29tcGFyZWQgdG8gd2hhdCAtIDUuMTAu
MCBvciB0aGUga2VybmVsIHdpdGggdGhlIHdhcm5pbmc/DQoNCkhpIE1lZWxpcywNClRoYW5rcyBm
b3IgcmV0ZXN0aW5nLg0KDQpDb21wYXJpbmcgdG8gdGhlIGtlcm5lbCB3aXRoIHRoZSB3YXJuaW5n
IGlzIGVub3VnaC4gQXMgSSBtZW50aW9uZWQgaGVyZToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xrbWwvMjAyMTAxMTUyMDM2MzIuMzQzOTYtMS1zb25nLmJhby5odWFAaGlzaWxpY29uLmNvbS8N
Cg0KSSBoYXZlIHNlZW4gdHdvIG1ham9yIGlzc3VlcyB0aGUgYnJva2VuIHNjaGVkX2dyb3VwIGhh
czoNCg0KKiBpbiBsb2FkX2JhbGFuY2UoKSBhbmQgZmluZF9idXNpZXN0X2dyb3VwKCkNCmtlcm5l
bCBpcyBjYWxjdWxhdGluZyB0aGUgYXZnX2xvYWQgYW5kIGdyb3VwX3R5cGUgYnk6DQoNCnN1bShs
b2FkIG9mIGNwdXMgd2l0aGluIHNjaGVkX2RvbWFpbikNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KY2FwYWNpdHkgb2YgdGhlIHdob2xlIHNjaGVkX2dyb3VwDQoNCnNpbmNl
IHNjaGVkX2dyb3VwIGlzbid0IGEgc3Vic2V0IG9mIHNjaGVkX2RvbWFpbiwgc28gdGhlIGxvYWQg
b2YNCnRoZSBwcm9ibGVtYXRpYyBncm91cCBpcyBzZXZlcmVseSB1bmRlcmVzdGltYXRlZC4NCg0K
c2NoZWRfZG9tYWluDQoNCiAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rDQog
IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0KICB8ICAgICAgICAgICstLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKw0KICB8ICAgICAgICAgIHwg
Ky0tLS0tLS0rICArLS0tLS0tKyAgIHwgICAgICAgICAgICAgICAgICAgfA0KICB8ICAgICAgICAg
IHwgfCBjcHUwICB8ICB8IGNwdTEgfCAgIHwgICAgICAgICAgICAgICAgICAgfA0KICB8ICAgICAg
ICAgIHwgKy0tLS0tLS0rICArLS0tLS0tKyAgIHwgICAgICAgICAgICAgICAgICAgfA0KICArLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsgICAgICAgICAgICAgICAgICAgfA0KICAg
ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfA0K
ICAgICAgICAgICAgIHwgICAgICArLS0tLS0tLSsgICAgICArLS0tLS0tLSsgICAgICAgICAgICAg
fA0KICAgICAgICAgICAgIHwgICAgICB8Y3B1MiAgIHwgICAgICB8Y3B1MyAgIHwgICAgICAgICAg
ICAgfA0KICAgICAgICAgICAgIHwgICAgICArLS0tLS0tLSsgICAgICArLS0tLS0tLSsgICAgICAg
ICAgICAgfA0KICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfA0KICAgICAgICAgICAgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tKw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIHByb2JsZW1hdGljICBz
Y2hlZF9ncm91cA0KDQoNCkZvciB0aGUgYWJvdmUgZXhhbXBsZSwga2VybmVsIHdpbGwgZGl2aWRl
ICJ0aGUgc3VtIGxvYWQgb2YNCmNwdTAgYW5kIGNwdTEiIGJ5ICJ0aGUgY2FwYWNpdHkgb2YgdGhl
IHdob2xlIGdyb3VwIGluY2x1ZGluZw0KY3B1MCwxLDIgYW5kIDMiLg0KDQoqIGluIHNlbGVjdF90
YXNrX3JxX2ZhaXIoKSBhbmQgZmluZF9pZGxlc3RfZ3JvdXAoKQ0KS2VybmVsIGNvdWxkIHB1c2gg
YSBmb3JrZWQvZXhlYy1lZCB0YXNrIHRvIHRoZSBvdXRzaWRlIG9mIHRoZQ0Kc2NoZWRfZG9tYWlu
LCBidXQgc3RpbGwgaW5zaWRlIHRoZSBzY2hlZF9ncm91cC4gRm9yIHRoZSBhYm92ZQ0KZGlhZ3Jh
bSwgd2hpbGUga2VybmVsIHdhbnRzIHRvIGZpbmQgdGhlIGlkbGVzdCBjcHUgaW4gdGhlDQpzY2hl
ZF9kb21haW4sIGl0IGNhbiByZXN1bHQgaW4gcGlja2luZyBjcHUyIG9yIGNwdTMuDQoNCkkgZ3Vl
c3MgdGhlc2UgdHdvIGlzc3VlcyBjYW4gcG90ZW50aWFsbHkgYWZmZWN0IG1hbnkgYmVuY2htYXJr
cy4NCk91ciB0ZWFtIGhhdmUgc2VlbiA1JSB1bml4YmVuY2ggc2NvcmUgaW5jcmVhc2Ugd2l0aCB0
aGUgZml4IGluDQpzb21lIG1hY2hpbmVzIHRob3VnaCB0aGUgcmVhbCBpbXBhY3QgbWlnaHQgYmUg
Y2FzZS1ieS1jYXNlLg0KDQo+IA0KPiBkcm9wIGNhY2hlcyBhbmQgdGltZSB0aGUgYnVpbGQgdGlt
ZSBvZiBsaW51eCBrZXJuZWwgd2l0aCBtYWtlIC1qNjQ/DQo+IA0KPiAtLQ0KPiBNZWVsaXMgUm9v
cw0KDQpUaGFua3MNCkJhcnJ5DQo=
