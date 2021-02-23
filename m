Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA573225C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 07:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhBWGUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 01:20:52 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:4632 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhBWGUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 01:20:11 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Dl83k2cfyzYBlD;
        Tue, 23 Feb 2021 14:17:38 +0800 (CST)
Received: from dggemi712-chm.china.huawei.com (10.3.20.111) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Tue, 23 Feb 2021 14:19:03 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi712-chm.china.huawei.com (10.3.20.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 23 Feb 2021 14:19:03 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Tue, 23 Feb 2021 14:19:03 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        Mel Gorman <mgorman@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: RE: [Linuxarm]  Re: [PATCH] Documentation/features: mark
 BATCHED_UNMAP_TLB_FLUSH doesn't apply to ARM64
Thread-Topic: [Linuxarm]  Re: [PATCH] Documentation/features: mark
 BATCHED_UNMAP_TLB_FLUSH doesn't apply to ARM64
Thread-Index: AQHXCXw6OdGSogcGZ0yLlSm/gfAbZqpku/6AgACFGrA=
Date:   Tue, 23 Feb 2021 06:19:03 +0000
Message-ID: <808ef1de466a4d9990bf69199dd59944@hisilicon.com>
References: <20210223003230.11976-1-song.bao.hua@hisilicon.com>
 <09dd1026-9e3f-b9be-b5a5-82771642348d@arm.com>
In-Reply-To: <09dd1026-9e3f-b9be-b5a5-82771642348d@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5zaHVtYW4gS2hhbmR1
YWwgW21haWx0bzphbnNodW1hbi5raGFuZHVhbEBhcm0uY29tXQ0KPiBTZW50OiBUdWVzZGF5LCBG
ZWJydWFyeSAyMywgMjAyMSA3OjEwIFBNDQo+IFRvOiBTb25nIEJhbyBIdWEgKEJhcnJ5IFNvbmcp
IDxzb25nLmJhby5odWFAaGlzaWxpY29uLmNvbT47IGNvcmJldEBsd24ubmV0Ow0KPiBsaW51eC1k
b2NAdmdlci5rZXJuZWwub3JnOyBha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnOyBsaW51eC1tbUBr
dmFjay5vcmcNCj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXhhcm1Ab3BlbmV1bGVyLm9yZzsgTWVs
IEdvcm1hbiA8bWdvcm1hbkBzdXNlLmRlPjsgQW5keSBMdXRvbWlyc2tpDQo+IDxsdXRvQGtlcm5l
bC5vcmc+OyBDYXRhbGluIE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPjsgV2lsbCBE
ZWFjb24NCj4gPHdpbGxAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogW0xpbnV4YXJtXSBSZTogW1BB
VENIXSBEb2N1bWVudGF0aW9uL2ZlYXR1cmVzOiBtYXJrDQo+IEJBVENIRURfVU5NQVBfVExCX0ZM
VVNIIGRvZXNuJ3QgYXBwbHkgdG8gQVJNNjQNCj4gDQo+IA0KPiANCj4gT24gMi8yMy8yMSA2OjAy
IEFNLCBCYXJyeSBTb25nIHdyb3RlOg0KPiA+IEJBVENIRURfVU5NQVBfVExCX0ZMVVNIIGlzIHVz
ZWQgb24geDg2IHRvIGRvIGJhdGNoZWQgdGxiIHNob290ZG93biBieQ0KPiA+IHNlbmRpbmcgb25l
IElQSSB0byBUTEIgZmx1c2ggYWxsIGVudHJpZXMgYWZ0ZXIgdW5tYXBwaW5nIHBhZ2VzIHJhdGhl
cg0KPiA+IHRoYW4gc2VuZGluZyBhbiBJUEkgdG8gZmx1c2ggZWFjaCBpbmRpdmlkdWFsIGVudHJ5
Lg0KPiA+IE9uIGFybTY0LCB0bGIgc2hvb3Rkb3duIGlzIGRvbmUgYnkgaGFyZHdhcmUuIEZsdXNo
IGluc3RydWN0aW9ucyBhcmUNCj4gPiBpbm5lcnNoYXJlYWJsZS4gVGhlIGxvY2FsIGZsdXNoZXMg
YXJlIGxpbWl0ZWQgdG8gdGhlIGJvb3QgKDEgcGVyIENQVSkNCj4gPiBhbmQgd2hlbiBhIHRhc2sg
aXMgZ2V0dGluZyBhIG5ldyBBU0lELg0KPiANCj4gSXMgdGhlcmUgYW55IHByZXZpb3VzIGRpc2N1
c3Npb24gYXJvdW5kIHRoaXMgPw0KDQpJIGNvcGllZCB0aGUgZGVjbGFyYXRpb24gb2YgbG9jYWwg
Zmx1c2hlcyBmcm9tOg0KDQoiQVJNNjQgTGludXgga2VybmVsIGlzIFNNUC1hd2FyZSAobm8gcG9z
c2liaWxpdHkgdG8gYnVpbGQgb25seSBmb3IgVVApLg0KTW9zdCBvZiB0aGUgZmx1c2ggaW5zdHJ1
Y3Rpb25zIGFyZSBpbm5lcnNoYXJlYWJsZS4gVGhlIGxvY2FsIGZsdXNoZXMgYXJlDQpsaW1pdGVk
IHRvIHRoZSBib290ICgxIHBlciBDUFUpIGFuZCB3aGVuIGEgdGFzayBpcyBnZXR0aW5nIGEgbmV3
IEFTSUMuIg0KDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QveGVuLWRldmVs
L3BhdGNoLzE0NjE3NTYxNzMtMTAzMDAtMS1naXQtc2VuZC1lbWFpbC1qdWxpZW4uZ3JhbGxAYXJt
LmNvbS8NCg0KSSBhbSBub3Qgc3VyZSBpZiBnZXR0aW5nIGEgbmV3IGFzaWQgYW5kIHRoZSBib290
IGFyZSB0aGUgb25seSB0d28NCmNhc2VzIG9mIGxvY2FsIGZsdXNoZXMgd2hpbGUgSSB0aGluayB0
aGlzIGlzIHByb2JhYmx5IHRydWUuDQoNCkJ1dCBldmVuIHdlIGZpbmQgbW9yZSBjb3JuZXIgY2Fz
ZXMsIGhhcmRseSB0aGUgdHJlbmQgYXJtNjQgZG9lc24ndA0KbmVlZCBCQVRDSEVEX1VOTUFQX1RM
Ql9GTFVTSCB3aWxsIGJlIGNoYW5nZWQuDQoNCj4gDQo+ID4gU28gbWFya2luZyB0aGlzIGZlYXR1
cmUgYXMgIlRPRE8iIGlzIG5vdCBwcm9wZXIuICIuLiIgaXNuJ3QgZ29vZCBhcw0KPiA+IHdlbGwu
IFNvIHRoaXMgcGF0Y2ggYWRkcyBhICJOL0EiIGZvciB0aGlzIGtpbmQgb2YgZmVhdHVyZXMgd2hp
Y2ggYXJlDQo+ID4gbm90IG5lZWRlZCBvbiBzb21lIGFyY2hpdGVjdHVyZXMuDQo+ID4NCj4gPiBD
YzogTWVsIEdvcm1hbiA8bWdvcm1hbkBzdXNlLmRlPg0KPiA+IENjOiBBbmR5IEx1dG9taXJza2kg
PGx1dG9Aa2VybmVsLm9yZz4NCj4gPiBDYzogQ2F0YWxpbiBNYXJpbmFzIDxjYXRhbGluLm1hcmlu
YXNAYXJtLmNvbT4NCj4gPiBDYzogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBCYXJyeSBTb25nIDxzb25nLmJhby5odWFAaGlzaWxpY29uLmNvbT4NCj4g
PiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9mZWF0dXJlcy9hcmNoLXN1cHBvcnQudHh0ICAgICAg
ICB8IDEgKw0KPiA+ICBEb2N1bWVudGF0aW9uL2ZlYXR1cmVzL3ZtL1RMQi9hcmNoLXN1cHBvcnQu
dHh0IHwgMiArLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZmVhdHVyZXMvYXJj
aC1zdXBwb3J0LnR4dA0KPiBiL0RvY3VtZW50YXRpb24vZmVhdHVyZXMvYXJjaC1zdXBwb3J0LnR4
dA0KPiA+IGluZGV4IGQyMmExMDk1ZTY2MS4uMTE4YWUwMzE4NDBiIDEwMDY0NA0KPiA+IC0tLSBh
L0RvY3VtZW50YXRpb24vZmVhdHVyZXMvYXJjaC1zdXBwb3J0LnR4dA0KPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZmVhdHVyZXMvYXJjaC1zdXBwb3J0LnR4dA0KPiA+IEBAIC04LDQgKzgsNSBAQCBU
aGUgbWVhbmluZyBvZiBlbnRyaWVzIGluIHRoZSB0YWJsZXMgaXM6DQo+ID4gICAgICB8IG9rIHwg
ICMgZmVhdHVyZSBzdXBwb3J0ZWQgYnkgdGhlIGFyY2hpdGVjdHVyZQ0KPiA+ICAgICAgfFRPRE98
ICAjIGZlYXR1cmUgbm90IHlldCBzdXBwb3J0ZWQgYnkgdGhlIGFyY2hpdGVjdHVyZQ0KPiA+ICAg
ICAgfCAuLiB8ICAjIGZlYXR1cmUgY2Fubm90IGJlIHN1cHBvcnRlZCBieSB0aGUgaGFyZHdhcmUN
Cj4gPiArICAgIHwgTi9BfCAgIyBmZWF0dXJlIGRvZXNuJ3QgYXBwbHkgdG8gdGhlIGFyY2hpdGVj
dHVyZQ0KPiANCj4gTkEgbWlnaHQgYmUgYmV0dGVyIGhlcmUuIHMvZG9lc24ndCBhcHBseS9ub3Qg
YXBwbGljYWJsZS8gaW4gb3JkZXIgdG8gbWF0Y2ggTkEuDQo+IFN0aWxsIHdvbmRlcmluZyBpZiBO
QSBpcyByZWFsbHkgbmVlZGVkIHdoZW4gdGhlcmUgaXMgYWxyZWFkeSAiLi4iID8gUmVnYXJkbGVz
cw0KPiBlaXRoZXIgd2F5IHNob3VsZCBiZSBmaW5lLg0KDQpJIGRvbid0IHRoaW5rICIuLiIgaXMg
cHJvcGVyIGhlcmUuICIuLiIgbWVhbnMgaGFyZHdhcmUgZG9lc24ndCBzdXBwb3J0DQp0aGUgZmVh
dHVyZS4gQnV0IGhlcmUgaXQgaXMganVzdCBvcHBvc2l0ZSwgYXJtNjQgaGFzIHRoZSBoYXJkd2Fy
ZQ0Kc3VwcG9ydCBvZiB0bGIgc2hvb3Rkb3duIHJhdGhlciB0aGFuIGRlcGVuZGluZyBvbiBhIHNv
ZnR3YXJlIElQSS4NCg0KPiANCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Zl
YXR1cmVzL3ZtL1RMQi9hcmNoLXN1cHBvcnQudHh0DQo+IGIvRG9jdW1lbnRhdGlvbi9mZWF0dXJl
cy92bS9UTEIvYXJjaC1zdXBwb3J0LnR4dA0KPiA+IGluZGV4IDMwZjc1YTc5Y2UwMS4uMGQwNzBm
OWY5OGQ4IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZmVhdHVyZXMvdm0vVExCL2Fy
Y2gtc3VwcG9ydC50eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2ZlYXR1cmVzL3ZtL1RMQi9h
cmNoLXN1cHBvcnQudHh0DQo+ID4gQEAgLTksNyArOSw3IEBADQo+ID4gICAgICB8ICAgICAgIGFs
cGhhOiB8IFRPRE8gfA0KPiA+ICAgICAgfCAgICAgICAgIGFyYzogfCBUT0RPIHwNCj4gPiAgICAg
IHwgICAgICAgICBhcm06IHwgVE9ETyB8DQo+ID4gLSAgICB8ICAgICAgIGFybTY0OiB8IFRPRE8g
fA0KPiA+ICsgICAgfCAgICAgICBhcm02NDogfCBOL0EgIHwNCj4gPiAgICAgIHwgICAgICAgICBj
Nng6IHwgIC4uICB8DQo+ID4gICAgICB8ICAgICAgICBjc2t5OiB8IFRPRE8gfA0KPiA+ICAgICAg
fCAgICAgICBoODMwMDogfCAgLi4gIHwNCj4gPg0KVGhhbmtzDQpCYXJyeQ0KDQo=
