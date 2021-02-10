Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8775D31627F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhBJJjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:39:18 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3438 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhBJJfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:35:47 -0500
Received: from dggeme707-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DbF1r5DX7z5R3r;
        Wed, 10 Feb 2021 17:33:36 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme707-chm.china.huawei.com (10.1.199.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Wed, 10 Feb 2021 17:35:00 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Wed, 10 Feb 2021 17:35:00 +0800
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
Subject: RE: [PATCH v3] sched/topology: fix the issue groups don't span
 domain->span for NUMA diameter > 2
Thread-Topic: [PATCH v3] sched/topology: fix the issue groups don't span
 domain->span for NUMA diameter > 2
Thread-Index: AQHW/r1iCNiOCsYIq0ajhSZ9I7SnE6pPPcqAgAHfBAA=
Date:   Wed, 10 Feb 2021 09:35:00 +0000
Message-ID: <0f612bc83ebf40b8bf2453a30486b88f@hisilicon.com>
References: <20210209082125.22176-1-song.bao.hua@hisilicon.com>
 <d091f321-540c-acc7-4340-72b80cbe7296@linux.ee>
In-Reply-To: <d091f321-540c-acc7-4340-72b80cbe7296@linux.ee>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.77]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWVlbGlzIFJvb3MgW21h
aWx0bzptcm9vc0BsaW51eC5lZV0NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAxMCwgMjAy
MSAxOjQwIEFNDQo+IFRvOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcpIDxzb25nLmJhby5odWFA
aGlzaWxpY29uLmNvbT47DQo+IHZhbGVudGluLnNjaG5laWRlckBhcm0uY29tOyB2aW5jZW50Lmd1
aXR0b3RAbGluYXJvLm9yZzsgbWdvcm1hbkBzdXNlLmRlOw0KPiBtaW5nb0BrZXJuZWwub3JnOyBw
ZXRlcnpAaW5mcmFkZWFkLm9yZzsgZGlldG1hci5lZ2dlbWFubkBhcm0uY29tOw0KPiBtb3J0ZW4u
cmFzbXVzc2VuQGFybS5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxp
bnV4YXJtQG9wZW5ldWxlci5vcmc7IHh1d2VpIChPKSA8eHV3ZWk1QGh1YXdlaS5jb20+OyBMaWd1
b3podSAoS2VubmV0aCkNCj4gPGxpZ3Vvemh1QGhpc2lsaWNvbi5jb20+OyB0aWFudGFvIChIKSA8
dGlhbnRhbzZAaGlzaWxpY29uLmNvbT47IHdhbmdodWlxaWFuZw0KPiA8d2FuZ2h1aXFpYW5nQGh1
YXdlaS5jb20+OyBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsgSm9uYXRo
YW4NCj4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsgZ3VvZG9uZy54dUBs
aW5hcm8ub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIHNjaGVkL3RvcG9sb2d5OiBmaXgg
dGhlIGlzc3VlIGdyb3VwcyBkb24ndCBzcGFuDQo+IGRvbWFpbi0+c3BhbiBmb3IgTlVNQSBkaWFt
ZXRlciA+IDINCj4gDQo+IEkgZGlkIGEgcnVkaW1lbnRhcnkgYmVuY2htYXJrIG9uIHRoZSBzYW1l
IDgtbm9kZSBTdW4gRmlyZSBYNDYwMC1NMiwgb24gdG9wIG9mDQo+IHRvZGF5cyAgNS4xMS4wLXJj
Ny0wMDAwMi1nZTA3NTZjZmM3ZDdjLg0KPiANCj4gVGhlIHRlc3Q6IGJ1aWxkaW5nIGNsZWFuIGtl
cm5lbCB3aXRoIG1ha2UgLWo2NCBhZnRlciBtYWtlIGNsZWFuIGFuZCBkcm9wX2NhY2hlcy4NCj4g
DQo+IFdoaWxlIHJ1bm5pbmcgY2xlYW4ga2VybmVsIC8gMyB0cmllcyk6DQo+IA0KPiByZWFsICAg
IDJtMzguNTc0cw0KPiB1c2VyICAgIDQ2bTE4LjM4N3MNCj4gc3lzICAgICA2bTguNzI0cw0KPiAN
Cj4gcmVhbCAgICAybTM3LjY0N3MNCj4gdXNlciAgICA0Nm0zNC4xNzFzDQo+IHN5cyAgICAgNm0x
MS45OTNzDQo+IA0KPiByZWFsICAgIDJtMzcuODMycw0KPiB1c2VyICAgIDQ2bTM0LjkxMHMNCj4g
c3lzICAgICA2bTEyLjAxM3MNCj4gDQo+IA0KPiBXaGlsZSBydW5uaW5nIHBhdGNoZWQga2VybmVs
Og0KPiANCj4gcmVhbCAgICAybTQwLjA3MnMNCj4gdXNlciAgICA0Nm0yMi42MTBzDQo+IHN5cyAg
ICAgNm02LjY1OHMNCj4gDQo+IA0KPiBmb3IgcmVhbCB0aW1lLCBzZWVtcyB0byBiZSAxLjVzLTJz
IHNsb3dlciBvdXQgb2YgMTYwcyAobm9pc2U/KSBVc2VyIGFuZCBzeXN0ZW0NCj4gdGltZSBhcmUg
c2xpZ2h0bHkgbGVzcywgb24gdGhlIG90aGVyIGhhbmQsIHNvIHNlZW1zIGdvb2QgdG8gbWUuDQoN
CkkgcmFuIHRoZSBzYW1lIHRlc3Qgb24gdGhlIG1hY2hpbmUgd2l0aCB0aGUgYmVsb3cgdG9wb2xv
Z3k6DQpudW1hY3RsIC0taGFyZHdhcmUNCmF2YWlsYWJsZTogNCBub2RlcyAoMC0zKQ0Kbm9kZSAw
IGNwdXM6IDAtMzENCm5vZGUgMCBzaXplOiA2NDE0NCBNQg0Kbm9kZSAwIGZyZWU6IDYyMzU2IE1C
DQpub2RlIDEgY3B1czogMzItNjMNCm5vZGUgMSBzaXplOiA2NDUwOSBNQg0Kbm9kZSAxIGZyZWU6
IDYyOTk2IE1CDQpub2RlIDIgY3B1czogNjQtOTUNCm5vZGUgMiBzaXplOiA2NDUwOSBNQg0Kbm9k
ZSAyIGZyZWU6IDYzMDIwIE1CDQpub2RlIDMgY3B1czogOTYtMTI3DQpub2RlIDMgc2l6ZTogNjM5
OTEgTUINCm5vZGUgMyBmcmVlOiA2MjY0NyBNQg0Kbm9kZSBkaXN0YW5jZXM6DQpub2RlICAgMCAg
IDEgICAyICAgMyANCiAgMDogIDEwICAxMiAgMjAgIDIyIA0KICAxOiAgMTIgIDEwICAyMiAgMjQg
DQogIDI6ICAyMCAgMjIgIDEwICAxMiANCiAgMzogIDIyICAyNCAgMTIgIDEwDQoNCkJhc2ljYWxs
eSB0aGUgaW5mbHVlbmNlIHRvIGtlcm5lbCBidWlsZCBpcyBub2lzZSBieQ0KdGhlIGNvbW1hbmRz
IEkgcmFuIGEgY291cGxlIG9mIHJvdW5kczoNCg0KbWFrZSBjbGVhbg0KZWNobyAzID4gL3Byb2Mv
c3lzL3ZtL2Ryb3BfY2FjaGVzDQptYWtlIEltYWdlIC1qMTAwDQoNCncvIHBhdGNoOiAgICAgICAg
ICAgICAgIHcvbyBwYXRjaDoNCg0KcmVhbAkxbTE3LjY0NHMgICAgICAgICAgcmVhbAkxbTE5LjUx
MHMNCnVzZXIJMzJtMTIuMDc0cyAgICAgICAgIHVzZXIJMzJtMTQuMTMzcw0Kc3lzCTRtMzUuODI3
cyAgICAgICAgICAgc3lzCTRtMzguMTk4cw0KDQpyZWFsCTFtMTUuODU1cyAgICAgICAgICByZWFs
CTFtMTcuMzAzcw0KdXNlcgkzMm03LjcwMHMgICAgICAgICAgdXNlcgkzMm0xNC4xMjhzDQpzeXMJ
NG0zNS44NjhzICAgICAgICAgICBzeXMJNG00MC4wOTRzDQoNCnJlYWwJMW0xOC45MThzICAgICAg
ICAgIHJlYWwJMW0xOS41ODNzDQp1c2VyCTMybTEzLjM1MnMgICAgICAgICB1c2VyCTMybTEzLjIw
NXMNCnN5cwk0bTQwLjE2MXMgICAgICAgICAgIHN5cwk0bTQwLjY5NnMNCg0KcmVhbAkxbTIwLjMy
OXMgICAgICAgICAgcmVhbAkxbTE3LjgxOXMNCnVzZXIJMzJtNy4yNTVzICAgICAgICAgIHVzZXIJ
MzJtMTEuNzUzcw0Kc3lzCTRtMzYuNzA2cyAgICAgICAgICAgc3lzCTRtNDEuMzcxcw0KDQpyZWFs
CTFtMTcuNzczcyAgICAgICAgICByZWFsCTFtMTYuNzYzcw0KdXNlcgkzMm0xOS45MTJzICAgICAg
ICAgdXNlcgkzMm0xNS42MDdzDQpzeXMJNG0zNi45ODlzICAgICAgICAgICBzeXMJNG00MS4yOTdz
DQoNCnJlYWwJMW0xNC45NDNzICAgICAgICAgIHJlYWwJMW0xOC41NTFzDQp1c2VyCTMybTE0LjU0
OXMgICAgICAgICB1c2VyCTMybTE4LjUyMXMNCnN5cwk0bTM4LjY3MHMgICAgICAgICAgIHN5cwk0
bTQxLjM5MnMNCg0KcmVhbAkxbTE2LjQzOXMgICAgICAgICAgcmVhbAkxbTE4LjE1NHMNCnVzZXIJ
MzJtMTIuODY0cyAgICAgICAgIHVzZXIJMzJtMTQuNTQwcw0Kc3lzCTRtMzkuNDI0cyAgICAgICAg
ICAgc3lzCTRtNDAuMzY0cw0KDQpvdXIgdGVhbSBndXlzIHdobyB1c2VkIHRoZSAzLWhvcHMtZml4
IHBhdGNoIHRvIHJ1biB1bml4YmVuY2gNCnJlcG9ydGVkIHNvbWUgZGF0YSBvZiB1bml4YmVuY2gg
c2NvcmUgYXMgYmVsb3coMyByb3VuZHMpOg0KDQp3L28gcGF0Y2g6ICAgIHcvIHBhdGNoOg0KMTIy
OC42ICAgICAgICAxMjU0LjkNCjEyMzEuNCAgICAgICAgMTI2NS43DQoxMjI2LjEgICAgICAgIDEy
NjYuMQ0KDQpPbmUgaW50ZXJlc3RpbmcgdGhpbmcgaXMgdGhhdCBpZiB3ZSBjaGFuZ2UgdGhlIGtl
cm5lbCB0bw0KZGlzYWxsb3cgdGhlIGJlbG93IEJBTEFOQ0lORyBmbGFncyBmb3IgdGhlIGxhc3Qg
aG9wLA0KCQkJc2QtPmZsYWdzICY9IH4oU0RfQkFMQU5DRV9FWEVDIHwNCgkJCQkgICAgICAgU0Rf
QkFMQU5DRV9GT1JLIHwNCgkJCQkgICAgICAgU0RfV0FLRV9BRkZJTkUpOw0KDQpXZSBhcmUgc2Vl
aW5nIGZ1cnRoZXIgaW5jcmVhc2Ugb2YgdW5peGJlbmNoLiBTbyBzb3VuZHMgbGlrZQ0KdGhvc2Ug
YmFsYW5jaW5nIHNob3VsZG4ndCBnbyB0aGF0IGZhci4gQnV0IGl0IGlzIGEgZGlmZmVyZW50DQp0
b3BpYy4NCg0KPiANCj4gLS0NCj4gTWVlbGlzIFJvb3MgPG1yb29zQGxpbnV4LmVlPg0KDQpUaGFu
a3MNCkJhcnJ5DQoNCg==
