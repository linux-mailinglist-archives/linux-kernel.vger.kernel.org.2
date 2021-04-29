Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750CE36F190
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 23:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbhD2VJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 17:09:41 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3096 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbhD2VJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 17:09:40 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FWSgS12HrzWZ7B;
        Fri, 30 Apr 2021 05:04:52 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 30 Apr 2021 05:08:51 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Fri, 30 Apr 2021 05:08:50 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Valentin Schneider" <valentin.schneider@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: RE: [PATCH 1/2] CPU, NUMA topology ABIs: clarify the overflow issue
 of sysfs pagebuf
Thread-Topic: [PATCH 1/2] CPU, NUMA topology ABIs: clarify the overflow issue
 of sysfs pagebuf
Thread-Index: AQHXPMXH0SQBD1qG+ECo3ZrOidSRtqrLBimAgADzHOA=
Date:   Thu, 29 Apr 2021 21:08:50 +0000
Message-ID: <602918a1e2214ea7bd0890a751975566@hisilicon.com>
References: <1619679819-45256-1-git-send-email-tiantao6@hisilicon.com>
 <1619679819-45256-2-git-send-email-tiantao6@hisilicon.com>
 <146e051b-603c-a6d3-43d8-d083cf2c8119@intel.com>
In-Reply-To: <146e051b-603c-a6d3-43d8-d083cf2c8119@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.93]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2ZSBIYW5zZW4gW21h
aWx0bzpkYXZlLmhhbnNlbkBpbnRlbC5jb21dDQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMzAsIDIw
MjEgMjoyMSBBTQ0KPiBUbzogdGlhbnRhbyAoSCkgPHRpYW50YW82QGhpc2lsaWNvbi5jb20+OyBj
b3JiZXRAbHduLm5ldDsNCj4gZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IFNvbmcgQmFvIEh1
YSAoQmFycnkgU29uZykNCj4gPHNvbmcuYmFvLmh1YUBoaXNpbGljb24uY29tPg0KPiBDYzogbGlu
dXgtZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgUmFm
YWVsIEouDQo+IFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBl
dGVyekBpbmZyYWRlYWQub3JnPjsgVmFsZW50aW4NCj4gU2NobmVpZGVyIDx2YWxlbnRpbi5zY2hu
ZWlkZXJAYXJtLmNvbT47IERhdmUgSGFuc2VuDQo+IDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5j
b20+OyBEYW5pZWwgQnJpc3RvdCBkZSBPbGl2ZWlyYSA8YnJpc3RvdEByZWRoYXQuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIDEvMl0gQ1BVLCBOVU1BIHRvcG9sb2d5IEFCSXM6IGNsYXJpZnkg
dGhlIG92ZXJmbG93IGlzc3VlDQo+IG9mIHN5c2ZzIHBhZ2VidWYNCj4gDQo+IE9uIDQvMjkvMjEg
MTI6MDMgQU0sIFRpYW4gVGFvIHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L0FCSS9zdGFibGUvc3lzZnMtZGV2aWNlcy1ub2RlDQo+IGIvRG9jdW1lbnRhdGlvbi9BQkkvc3Rh
YmxlL3N5c2ZzLWRldmljZXMtbm9kZQ0KPiA+IGluZGV4IDQ4NGZjMDQuLjgyZGZlNjQgMTAwNjQ0
DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9BQkkvc3RhYmxlL3N5c2ZzLWRldmljZXMtbm9kZQ0K
PiA+ICsrKyBiL0RvY3VtZW50YXRpb24vQUJJL3N0YWJsZS9zeXNmcy1kZXZpY2VzLW5vZGUNCj4g
PiBAQCAtNDcsNyArNDcsMTAgQEAgV2hhdDoJCS9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2Rl
WC9jcHVsaXN0DQo+ID4gIERhdGU6CQlPY3RvYmVyIDIwMDINCj4gPiAgQ29udGFjdDoJTGludXgg
TWVtb3J5IE1hbmFnZW1lbnQgbGlzdCA8bGludXgtbW1Aa3ZhY2sub3JnPg0KPiA+ICBEZXNjcmlw
dGlvbjoNCj4gPiAtCQlUaGUgQ1BVcyBhc3NvY2lhdGVkIHRvIHRoZSBub2RlLg0KPiA+ICsJCVRo
ZSBDUFVzIGFzc29jaWF0ZWQgdG8gdGhlIG5vZGUuIFRoZSBmb3JtYXQgaXMgbGlrZSAwLTMsDQo+
ID4gKwkJOC0xMSwgMTQsMTcuIG1heGltdW0gc2l6ZSBpcyBQQUdFX1NJWkUsIHNvIHRoZSB0YWls
DQo+ID4gKwkJb2YgdGhlIHN0cmluZyB3aWxsIGJlIHRyaW1tZWQgd2hpbGUgaXRzIHNpemUgaXMg
bGFyZ2VyDQo+ID4gKwkJdGhhbiBQQUdFX1NJWkUuDQo+IA0KPiBJIHRoaW5rIGl0J3MgcHJldHR5
IGFyZ3VhYmxlIHRoYXQgdHJ1bmNhdGluZyBvdXRwdXQgb24gYSByZWFsIHN5c3RlbSBpcw0KPiBh
biBBQkkgYnJlYWsuICBEb2luZyB0aGlzIHdvdWxkIG1ha2UgdGhlIGludGVyZmFjZSByYXRoZXIg
dXNlbGVzcy4NCj4gDQo+IERvbid0IHdlIG5lZWQgYSByZWFsIHNvbHV0aW9uIHJhdGhlciB0aGFu
IHRocm93aW5nIHVwIG91ciBoYW5kcz8NCj4gDQo+IERvIHdlIHRoaW5rID5QQUdFX1NJWkUgZGF0
YSBvdXQgb2YgYSBzeXNmcyBmaWxlIGlzIGEgd29yc2UgQUJJIGJyZWFrIG9yDQo+IHNvbWV0aGlu
Zz8NCg0KVGhpcyBraW5kIG9mIGNwdSBsaXN0IEFCSXMgaGF2ZSBiZWVuIHRoZXJlIGZvciBtYW55
IHllYXJzIGJ1dCBoYXZlIA0KbmV2ZXIgYmVlbiBkb2N1bWVudGVkIHdlbGwuDQoNCldlIGhhdmUg
dHdvIEFCSXM6DQp4eHhfY3B1cyAtIGluIGZvcm1hdCBsaWtlIDMzMzMzMzMzMzMNCnh4eF9jcHVz
X2xpc3QgLSBpbiBmb3JtYXQgbGlrZSAwLDMsNSw3LDksMTEsMTMuLi4uDQoNCnh4eF9jcHVzX2xp
c3QgaXMgYW5vdGhlciBodW1hbi1yZWFkYWJsZSB2ZXJzaW9uIG9mIHh4eF9jcHVzLiBJdCBkb2Vz
bid0DQppbmNsdWRlIGFueSBtb3JlIHVzZWZ1bCBpbmZvcm1hdGlvbiB0aGFuIHh4eF9jcHVzLg0K
DQp4eHhfY3B1cyB3b24ndCBvdmVyZmxvdyBiYXNlZCBvbiBCVUlMRF9CVUdfT04gYW5kIG1heGlt
dW0gTlJfQ1BVUw0KaW4ga2NvbmZpZyBub3dhZGF5cy4NCg0KaWYgcGVvcGxlIGFsbCBhZ3JlZSB0
aGUgdHJpbW1lZCBsaXN0IGlzIGEgYnJlYWsgb2YgQUJJLCBJIHRoaW5rIHdlIG1heQ0KdG90YWxs
eSByZW1vdmUgdGhpcyBsaXN0LiBGb3IgdGhlc2UgZGF5cywgdGhpcyBsaXN0IHByb2JhYmx5IGhh
cyBuZXZlcg0Kb3ZlcmZsb3dlZCBidXQgbGl0ZXJhbGx5IHRoaXMgY291bGQgaGFwcGVuLg0KDQp0
aG91Z2h0cz8NCg0KVGhhbmtzDQpCYXJyeQ0K
