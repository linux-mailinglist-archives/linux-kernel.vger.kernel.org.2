Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9AC30A573
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhBAKgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:36:32 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4603 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhBAKga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:36:30 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4DTkpL1QNBzY4pk;
        Mon,  1 Feb 2021 18:34:34 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 1 Feb 2021 18:35:43 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi759-chm.china.huawei.com (10.1.198.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 1 Feb 2021 18:35:43 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Mon, 1 Feb 2021 18:35:43 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "mgorman@suse.de" <mgorman@suse.de>
Subject: RE: [PATCH 1/1] sched/topology: Make sched_init_numa() use a set for
 the deduplicating sort
Thread-Topic: [PATCH 1/1] sched/topology: Make sched_init_numa() use a set for
 the deduplicating sort
Thread-Index: AQHW8LvLAz5G3mjdME+poUenwzVodapCmLiAgACND8A=
Date:   Mon, 1 Feb 2021 10:35:43 +0000
Message-ID: <8b15c0fe619640808e1e26aa7c845bb9@hisilicon.com>
References: <20210122123943.1217-1-valentin.schneider@arm.com>
 <20210122123943.1217-2-valentin.schneider@arm.com>
 <6000e39e-7d28-c360-9cd6-8798fd22a9bf@arm.com>
In-Reply-To: <6000e39e-7d28-c360-9cd6-8798fd22a9bf@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.222]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGlldG1hciBFZ2dlbWFu
biBbbWFpbHRvOmRpZXRtYXIuZWdnZW1hbm5AYXJtLmNvbV0NCj4gU2VudDogTW9uZGF5LCBGZWJy
dWFyeSAxLCAyMDIxIDEwOjU0IFBNDQo+IFRvOiBWYWxlbnRpbiBTY2huZWlkZXIgPHZhbGVudGlu
LnNjaG5laWRlckBhcm0uY29tPjsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogbWluZ29Aa2VybmVsLm9yZzsgcGV0ZXJ6QGluZnJhZGVhZC5vcmc7IHZpbmNlbnQuZ3VpdHRv
dEBsaW5hcm8ub3JnOw0KPiBtb3J0ZW4ucmFzbXVzc2VuQGFybS5jb207IG1nb3JtYW5Ac3VzZS5k
ZTsgU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKQ0KPiA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8xXSBzY2hlZC90b3BvbG9neTogTWFrZSBzY2hl
ZF9pbml0X251bWEoKSB1c2UgYSBzZXQgZm9yDQo+IHRoZSBkZWR1cGxpY2F0aW5nIHNvcnQNCj4g
DQo+IE9uIDIyLzAxLzIwMjEgMTM6MzksIFZhbGVudGluIFNjaG5laWRlciB3cm90ZToNCj4gDQo+
IFsuLi5dDQo+IA0KPiA+IEBAIC0xNzA1LDcgKzE3MDIsNyBAQCB2b2lkIHNjaGVkX2luaXRfbnVt
YSh2b2lkKQ0KPiA+ICAJLyogQ29tcHV0ZSBkZWZhdWx0IHRvcG9sb2d5IHNpemUgKi8NCj4gPiAg
CWZvciAoaSA9IDA7IHNjaGVkX2RvbWFpbl90b3BvbG9neVtpXS5tYXNrOyBpKyspOw0KPiA+DQo+
ID4gLQl0bCA9IGt6YWxsb2MoKGkgKyBsZXZlbCArIDEpICoNCj4gPiArCXRsID0ga3phbGxvYygo
aSArIG5yX2xldmVscykgKg0KPiA+ICAJCQlzaXplb2Yoc3RydWN0IHNjaGVkX2RvbWFpbl90b3Bv
bG9neV9sZXZlbCksIEdGUF9LRVJORUwpOw0KPiA+ICAJaWYgKCF0bCkNCj4gPiAgCQlyZXR1cm47
DQo+IA0KPiBUaGlzIGh1bmsgY3JlYXRlcyBpc3N1ZXMgZHVyaW5nIHN0YXJ0dXAgb24gbXkgQXJt
NjQganVubyBib2FyZCBvbiB0aXAvc2NoZWQvY29yZS4NCg0KSSBhbHNvIHJlcG9ydGVkIHRoaXMg
a2VybmVsIHBhbmljIGhlcmU6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sL2JmYjcwMzI5
NGIyMzRlMWU5MjZhNjhmY2I3M2RiZWUzQGhpc2lsaWNvbi5jb20vI3QNCg0KPiANCj4gLS0tODwt
LS0NCj4gDQo+IEZyb206IERpZXRtYXIgRWdnZW1hbm4gPGRpZXRtYXIuZWdnZW1hbm5AYXJtLmNv
bT4NCj4gRGF0ZTogTW9uLCAxIEZlYiAyMDIxIDA5OjU4OjA0ICswMTAwDQo+IFN1YmplY3Q6IFtQ
QVRDSF0gc2NoZWQvdG9wb2xvZ3k6IEZpeCBzY2hlZF9kb21haW5fdG9wb2xvZ3lfbGV2ZWwgYWxs
b2MgaW4NCj4gIHNjaGVkX2luaXRfbnVtYQ0KPiANCj4gQ29tbWl0ICJzY2hlZC90b3BvbG9neTog
TWFrZSBzY2hlZF9pbml0X251bWEoKSB1c2UgYSBzZXQgZm9yIHRoZQ0KPiBkZWR1cGxpY2F0aW5n
IHNvcnQiIGFsbG9jYXRlcyAnaSArIG5yX2xldmVscyAobGV2ZWwpJyBpbnN0ZWFkIG9mDQo+ICdp
ICsgbnJfbGV2ZWxzICsgMScgc2NoZWRfZG9tYWluX3RvcG9sb2d5X2xldmVsLg0KPiANCj4gVGhp
cyBsZWQgdG8gYW4gT29wcyAob24gQXJtNjQganVubyB3aXRoIENPTkZJR19TQ0hFRF9ERUJVRyk6
DQo+IA0KPiBzY2hlZF9pbml0X2RvbWFpbnMNCj4gICBidWlsZF9zY2hlZF9kb21haW5zKCkNCj4g
ICAgIF9fZnJlZV9kb21haW5fYWxsb2NzKCkNCj4gICAgICAgX19zZHRfZnJlZSgpIHsNCj4gCS4u
Lg0KPiAgICAgICAgIGZvcl9lYWNoX3NkX3RvcG9sb2d5KHRsKQ0KPiAJICAuLi4NCj4gICAgICAg
ICAgIHNkID0gKnBlcl9jcHVfcHRyKHNkZC0+c2QsIGopOyA8LS0NCj4gCSAgLi4uDQo+ICAgICAg
IH0NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERpZXRtYXIgRWdnZW1hbm4gPGRpZXRtYXIuZWdnZW1h
bm5AYXJtLmNvbT4NCj4gLS0tDQoNClRoaXMgcGF0Y2ggYWxzbyByZXNvbHZlZCBteSBwYW5pYy4g
U286DQoNClRlc3RlZC1ieTogQmFycnkgU29uZyA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+
DQoNClRoYW5rcw0KQmFycnkNCg0K
