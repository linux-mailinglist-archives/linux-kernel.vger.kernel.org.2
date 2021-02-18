Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA3D31F21B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 23:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhBRWIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 17:08:45 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3029 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhBRWIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 17:08:41 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DhTLw1WMJzRD7r;
        Fri, 19 Feb 2021 06:06:32 +0800 (CST)
Received: from dggemm752-chm.china.huawei.com (10.1.198.58) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 19 Feb 2021 06:07:55 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemm752-chm.china.huawei.com (10.1.198.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Fri, 19 Feb 2021 06:07:54 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Fri, 19 Feb 2021 06:07:54 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "morten.rasmussen@arm.com" <morten.rasmussen@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "xuwei (O)" <xuwei5@huawei.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        Meelis Roos <mroos@linux.ee>
Subject: RE: [Linuxarm]  Re: [PATCH v2] sched/topology: fix the issue groups
 don't span domain->span for NUMA diameter > 2
Thread-Topic: [Linuxarm]  Re: [PATCH v2] sched/topology: fix the issue groups
 don't span domain->span for NUMA diameter > 2
Thread-Index: AQHW+h42U7QNiWetGE+PWD4uLCFytKpPS20AgAEC7uCAAHUfAIACIcmAgArN4hD//7kYgIABGpMA
Date:   Thu, 18 Feb 2021 22:07:54 +0000
Message-ID: <23914b8d7bb74aa9996c1a45b4bb0aed@hisilicon.com>
References: <20210203111201.20720-1-song.bao.hua@hisilicon.com>
 <YCKGVBnXzRsE6/Er@hirez.programming.kicks-ass.net>
 <4bdaa3e1a54f445fa8e629ea392e7bce@hisilicon.com>
 <YCPByAdQ+rZFzYWp@hirez.programming.kicks-ass.net>
 <jhjblcqtm5c.mognet@arm.com> <ae3bf4dc465040a4b31e4010fd800408@hisilicon.com>
 <jhj7dn5sg4q.mognet@arm.com>
In-Reply-To: <jhj7dn5sg4q.mognet@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.200]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmFsZW50aW4gU2NobmVp
ZGVyIFttYWlsdG86dmFsZW50aW4uc2NobmVpZGVyQGFybS5jb21dDQo+IFNlbnQ6IEZyaWRheSwg
RmVicnVhcnkgMTksIDIwMjEgMTo0MSBBTQ0KPiBUbzogU29uZyBCYW8gSHVhIChCYXJyeSBTb25n
KSA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+OyBQZXRlciBaaWpsc3RyYQ0KPiA8cGV0ZXJ6
QGluZnJhZGVhZC5vcmc+DQo+IENjOiB2aW5jZW50Lmd1aXR0b3RAbGluYXJvLm9yZzsgbWdvcm1h
bkBzdXNlLmRlOyBtaW5nb0BrZXJuZWwub3JnOw0KPiBkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb207
IG1vcnRlbi5yYXNtdXNzZW5AYXJtLmNvbTsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgbGludXhhcm1Ab3BlbmV1bGVyLm9yZzsgeHV3ZWkgKE8pDQo+IDx4dXdlaTVAaHVhd2VpLmNv
bT47IExpZ3Vvemh1IChLZW5uZXRoKSA8bGlndW96aHVAaGlzaWxpY29uLmNvbT47IHRpYW50YW8g
KEgpDQo+IDx0aWFudGFvNkBoaXNpbGljb24uY29tPjsgd2FuZ2h1aXFpYW5nIDx3YW5naHVpcWlh
bmdAaHVhd2VpLmNvbT47IFplbmd0YW8gKEIpDQo+IDxwcmltZS56ZW5nQGhpc2lsaWNvbi5jb20+
OyBKb25hdGhhbiBDYW1lcm9uIDxqb25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+Ow0KPiBndW9k
b25nLnh1QGxpbmFyby5vcmc7IE1lZWxpcyBSb29zIDxtcm9vc0BsaW51eC5lZT4NCj4gU3ViamVj
dDogW0xpbnV4YXJtXSBSZTogW1BBVENIIHYyXSBzY2hlZC90b3BvbG9neTogZml4IHRoZSBpc3N1
ZSBncm91cHMgZG9uJ3QNCj4gc3BhbiBkb21haW4tPnNwYW4gZm9yIE5VTUEgZGlhbWV0ZXIgPiAy
DQo+IA0KPiANCj4gSGkgQmFycnksDQo+IA0KPiBPbiAxOC8wMi8yMSAwOToxNywgU29uZyBCYW8g
SHVhIChCYXJyeSBTb25nKSB3cm90ZToNCj4gPiBIaSBWYWxlbnRpbiwNCj4gPg0KPiA+IEkgdW5k
ZXJzdGFuZCBQZXRlcidzIGNvbmNlcm4gaXMgdGhhdCB0aGUgbG9jYWwgZ3JvdXAgaGFzIGRpZmZl
cmVudA0KPiA+IHNpemUgd2l0aCByZW1vdGUgZ3JvdXBzLiBJcyB0aGlzIHBhdGNoIHJlc29sdmlu
ZyBQZXRlcidzIGNvbmNlcm4/DQo+ID4gVG8gbWUsIGl0IHNlZW1zIG5vdCA6LSkNCj4gPg0KPiAN
Cj4gSWYgeW91IHJlbW92ZSB0aGUgJyYmIGkgIT0gY3B1JyBpbiBidWlsZF9vdmVybGFwX3NjaGVk
X2dyb3VwcygpIHlvdSBnZXQgdGhhdCwNCj4gYnV0IHRoZW4geW91IGFsc28gZ2V0IHNvbWUgZXh0
cmEgd2FybmluZ3MgOi0pDQo+IA0KPiBOb3cgeWVzLCBzaG91bGRfd2VfYmFsYW5jZSgpIG9ubHkg
bWF0dGVycyBmb3IgdGhlIGxvY2FsIGdyb3VwLiBIb3dldmVyIEknbQ0KPiBzb21ld2hhdCB3YXJ5
IG9mIG1lc3Npbmcgd2l0aCB0aGUgbG9jYWwgZ3JvdXBzOyBmb3Igb25lIGl0IG1lYW5zIHlvdSB3
b3VsZCBoYXZlDQo+IG1vcmUgdGhhbiBvbmUgdGwgbm93IGFjY2Vzc2luZyB0aGUgc2FtZSBzZ2Mt
Pm5leHRfdXBkYXRlLCBzZ2MtPnttaW4sDQo+IG1heH1jYXBhY2l0eSwgc2djLT5ncm91cF9pbWJh
bGFuY2UgKGFzIFZpbmNlbnQgaGFkIHBvaW50ZWQgb3V0KS4NCj4gDQo+IEJ5IGVuc3VyaW5nIG9u
bHkgcmVtb3RlIChpLmUuICFsb2NhbCkgZ3JvdXBzIGFyZSBtb2RpZmllZCAod2hpY2ggaXMgd2hh
dCB5b3VyDQo+IHBhdGNoIGRvZXMpLCB3ZSBhYnNvbHZlIG91cnNlbHZlcyBvZiB0aGlzIGlzc3Vl
LCB3aGljaCBpcyB3aHkgSSBwcmVmZXIgdGhpcw0KPiBhcHByb2FjaCBBVE0uDQoNClllcC4gVGhl
IGdyYW5kY2hpbGQgYXBwcm9hY2ggc2VlbXMgc3RpbGwgdG8gdGhlIGZlYXNpYmxlIHdheSBmb3Ig
dGhpcyBtb21lbnQuDQoNCj4gDQo+ID4gVGhvdWdoIEkgZG9u4oCZdCB1bmRlcnN0YW5kIHdoeSBk
aWZmZXJlbnQgZ3JvdXAgc2l6ZXMgd2lsbCBiZSBoYXJtZnVsDQo+ID4gc2luY2UgYWxsIGdyb3Vw
cyBhcmUgY2FsY3VsYXRpbmcgYXZnX2xvYWQgYW5kIGdyb3VwX3R5cGUgYmFzZWQgb24NCj4gPiB0
aGVpciBvd24gY2FwYWNpdGllcy4gVGh1cywgZm9yIGEgc21hbGxlciBncm91cCwgaXRzIGNhcGFj
aXR5IHdvdWxkIGJlDQo+ID4gc21hbGxlci4NCj4gPg0KPiA+IElzIGl0IGJlY2F1c2UgYSBiaWdn
ZXIgZ3JvdXAgaGFzIHJlbGF0aXZlbHkgbGVzcyBjaGFuY2UgdG8gcHVsbCwgc28NCj4gPiBsb2Fk
IGJhbGFuY2luZyB3aWxsIGJlIGNvbXBsZXRlZCBtb3JlIHNsb3dseSB3aGlsZSBzbWFsbCBncm91
cHMgaGF2ZQ0KPiA+IGhpZ2ggbG9hZD8NCj4gPg0KPiANCj4gUGV0ZXIncyBwb2ludCBpcyB0aGF0
LCBpZiBhdCBhIGdpdmVuIHRsIHlvdSBoYXZlIGdyb3VwcyB0aGF0IGxvb2sgbGlrZQ0KPiANCj4g
ZzA6IDAtNCwgZzE6IDUtNiwgZzI6IDctOA0KPiANCj4gVGhlbiBnMCBpcyBoYWxmIGFzIGxpa2Vs
eSB0byBwdWxsIHRhc2tzIHdpdGggbG9hZF9iYWxhbmNlKCkgdGhhbiBnMSBvciBnMiAoZHVlDQo+
IHRvIHRoZSBncm91cCBzaXplIHZzIHNob3VsZF93ZV9iYWxhbmNlKCkpDQoNClllcC4gdGhlIGRp
ZmZlcmVuY2UgaXMgdGhhdCBnMSBhbmQgZzIgd29uJ3QgYmUgbG9jYWwgZ3JvdXBzIG9mIGFueSBD
UFUgaW4NCnRoaXMgdGwuDQpUaGUgc21hbGxlciBncm91cHMgZzEgYW5kIGcyIGFyZSBvbmx5IHJl
bW90ZSBncm91cHMsICBzbyBzaG91bGRfd2VfYmFsYW5jZSgpDQpkb2Vzbid0IG1hdHRlciBoZXJl
IGZvciB0aGVtLg0KDQo+IA0KPiANCj4gSG93ZXZlciwgSSBzdXBwb3NlIG9uZSAidHJpY2siIHRv
IGJlIGF3YXJlIG9mIGhlcmUgaXMgdGhhdCBzaW5jZSB5b3VyIHBhdGNoDQo+ICpkb2Vzbid0KiBj
aGFuZ2UgdGhlIGxvY2FsIGdyb3VwLCB3ZSBkbyBoYXZlIGUuZy4gb24gQ1BVMDoNCj4gDQo+IFsg
ICAgMC4zNzQ4NDBdICAgIGRvbWFpbi0yOiBzcGFuPTAtNSBsZXZlbD1OVU1BDQo+IFsgICAgMC4z
NzUwNTRdICAgICBncm91cHM6IDA6eyBzcGFuPTAtMyBjYXA9NDAwMyB9LCA0Onsgc3Bhbj00LTUg
Y2FwPTE5ODggfQ0KPiANCj4gKmJ1dCogb24gQ1BVNCB3ZSBnZXQ6DQo+IA0KPiBbICAgIDAuMzg3
MDE5XSAgICBkb21haW4tMjogc3Bhbj0wLTEsNC03IGxldmVsPU5VTUENCj4gWyAgICAwLjM4NzIx
MV0gICAgIGdyb3VwczogNDp7IHNwYW49NC03IGNhcD0zOTg0IH0sIDA6eyBzcGFuPTAtMSBjYXA9
MjAxMyB9DQo+IA0KPiBJT1csIGF0IGEgZ2l2ZW4gdGwsIGFsbCAqbG9jYWwqIGdyb3VwcyBoYXZl
IC9yb3VnaGx5LyB0aGUgc2FtZSBzaXplIGFuZCB0aHVzDQo+IHNpbWlsYXIgcHVsbCBwcm9iYWJp
bGl0eSAoaXQgdG9vayBtZSB3cml0aW5nIHRoaXMgbWFpbCB0byBzZWUgaXQgdGhhdCB3YXkpLg0K
PiBTbyBwZXJoYXBzIHRoaXMgaXMgYWxsIGZpbmUgYWxyZWFkeT8NCg0KWWVwLiBzaW5jZSBzaG91
bGRfd2VfYmFsYW5jZSgpIG9ubHkgbWF0dGVycyBmb3IgbG9jYWwgZ3JvdXBzIGFuZCB3ZSBoYXZl
bid0DQpjaGFuZ2VkIHRoZSBzaXplIG9mIGxvY2FsIGdyb3VwcyBpbiB0aGUgZ3JhbmRjaGlsZCBh
cHByb2FjaCwgYWxsIGxvY2FsIGdyb3Vwcw0KYXJlIHN0aWxsIGdldHRpbmcgc2ltaWxhciBwdWxs
IHByb2JhYmlsaXR5IGluIHRoaXMgdG9wb2xvZ3kgbGV2ZWwuDQoNClNpbmNlIHdlIHN0aWxsIHBy
ZWZlciB0aGUgZ3JhbmRjaGlsZCBhcHByb2FjaCBBVE0sIGlmIFBldGVyIGhhcyBubyBtb3JlIGNv
bmNlcm4NCm9uIHRoZSB1bmVxdWFsIHNpemUgYmV0d2VlbiBsb2NhbCBncm91cHMgYW5kIHJlbW90
ZSBncm91cHMsIEkgd291bGQgYmUgZ2xhZA0KdG8gc2VuZCB2NCBvZiBncmFuZGNoaWxkIGFwcHJv
YWNoIGJ5IHJld3JpdGluZyBjaGFuZ2Vsb2cgdG8gZXhwbGFpbiB0aGUgdXBkYXRlDQppc3N1ZSBv
ZiBzZ2MtPm5leHRfdXBkYXRlLCBzZ2MtPnttaW4sIG1heH1jYXBhY2l0eSwgc2djLT5ncm91cF9p
bWJhbGFuY2UNClZpbmNlbnQgcG9pbnRlZCBvdXQgYW5kIGFsc28gZGVzY3JpYmUgdGhlIGxvY2Fs
X2dyb3VwcyBhcmUgbm90IHRvdWNoZWQsIHRodXMNCnN0aWxsIGluIHRoZSBlcXVhbCBzaXplLg0K
DQpUaGFua3MNCkJhcnJ5DQoNCg==
