Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F75133FE4F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 05:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCREqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 00:46:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:5095 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhCREqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 00:46:43 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4F1Dw82zKLzYLLY;
        Thu, 18 Mar 2021 12:44:56 +0800 (CST)
Received: from dggpemm100012.china.huawei.com (7.185.36.212) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 18 Mar 2021 12:46:41 +0800
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpemm100012.china.huawei.com (7.185.36.212) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 12:46:41 +0800
Received: from dggpeml500016.china.huawei.com ([7.185.36.70]) by
 dggpeml500016.china.huawei.com ([7.185.36.70]) with mapi id 15.01.2106.013;
 Thu, 18 Mar 2021 12:46:41 +0800
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
CC:     "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        chenjiashang <chenjiashang@huawei.com>,
        "Subo (Subo, Cloud Infrastructure Service Product Dept.)" 
        <subo7@huawei.com>
Subject: =?utf-8?B?UkU6IEEgcHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8=?=
Thread-Topic: =?utf-8?B?QSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw==?=
Thread-Index: AQHXGtwEduPlUZeCNUCbiy3s/+KwAaqHHa0AgACoBQCAAMOgAIAAjhNw
Date:   Thu, 18 Mar 2021 04:46:40 +0000
Message-ID: <a0ca6dd974be42878a8f51b0a7bbe00f@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <692186fd-42b8-4054-ead2-f6c6b1bf5b2d@linux.intel.com>
 <20210317091820.5f4ab69e@omen.home.shazbot.org>
 <87a5f90a-d1ea-fe7a-2577-fdfdf25f8fd7@linux.intel.com>
In-Reply-To: <87a5f90a-d1ea-fe7a-2577-fdfdf25f8fd7@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.151.207]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgZ3V5cywNCg0KSSBwcm92aWRlIG1vcmUgaW5mb3JtYXRpb24sIHBsZWFzZSBzZWUgYmVsb3cN
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdSBCYW9sdSBbbWFpbHRv
OmJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDE4LCAy
MDIxIDEwOjU5IEFNDQo+IFRvOiBBbGV4IFdpbGxpYW1zb24gPGFsZXgud2lsbGlhbXNvbkByZWRo
YXQuY29tPg0KPiBDYzogYmFvbHUubHVAbGludXguaW50ZWwuY29tOyBMb25ncGVuZyAoTWlrZSwg
Q2xvdWQgSW5mcmFzdHJ1Y3R1cmUgU2VydmljZSBQcm9kdWN0DQo+IERlcHQuKSA8bG9uZ3Blbmcy
QGh1YXdlaS5jb20+OyBkd213MkBpbmZyYWRlYWQub3JnOyBqb3JvQDhieXRlcy5vcmc7DQo+IHdp
bGxAa2VybmVsLm9yZzsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IExLTUwNCj4g
PGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBHb25nbGVpIChBcmVpKSA8YXJlaS5nb25n
bGVpQGh1YXdlaS5jb20+Ow0KPiBjaGVuamlhc2hhbmcgPGNoZW5qaWFzaGFuZ0BodWF3ZWkuY29t
Pg0KPiBTdWJqZWN0OiBSZTogQSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw0K
PiANCj4gSGkgQWxleCwNCj4gDQo+IE9uIDMvMTcvMjEgMTE6MTggUE0sIEFsZXggV2lsbGlhbXNv
biB3cm90ZToNCj4gPj4+ICAgICAgICAgICB7TUFQLCAgIDB4MCwgMHhjMDAwMDAwMH0sIC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSAoYikNCj4gPj4+ICAgICAgICAgICAgICAgICAg
IHVzZSBHREIgdG8gcGF1c2UgYXQgaGVyZSwgYW5kIHRoZW4gRE1BIHJlYWQNCj4gPj4+IElPVkE9
MCwNCj4gPj4gSU9WQSAwIHNlZW1zIHRvIGJlIGEgc3BlY2lhbCBvbmUuIEhhdmUgeW91IHZlcmlm
aWVkIHdpdGggb3RoZXINCj4gPj4gYWRkcmVzc2VzIHRoYW4gSU9WQSAwPw0KPiA+IEl0IGlzPz8/
ICBUaGF0IHdvdWxkIGJlIGEgcHJvYmxlbS4NCj4gPg0KPiANCj4gTm8gcHJvYmxlbSBmcm9tIGhh
cmR3YXJlIHBvaW50IG9mIHZpZXcgYXMgZmFyIGFzIEkgY2FuIHNlZS4gSnVzdCB0aG91Z2h0IGFi
b3V0DQo+IHNvZnR3YXJlIG1pZ2h0IGhhbmRsZSBpdCBzcGVjaWFsbHkuDQo+IA0KDQpXZSBzaW1w
bGlmeSB0aGUgcmVwcm9kdWNlciwgdXNlIHRoZSBmb2xsb3dpbmcgbWFwL3VubWFwIHNlcXVlbmNl
cyBjYW4gYWxzbyANCnJlcHJvZHVjZSB0aGUgcHJvYmxlbS4NCg0KMS4gdXNlIDJNIGh1Z2V0bGJm
cyB0byBtbWFwIDRHIG1lbW9yeQ0KDQoyLiBydW4gdGhlIHdoaWxlIGxvb3A6DQpXaGlsZSAoMSkg
ew0KICAgIERNQSBNQVAgKDAsIDB4YTAwMDApIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLShh
KQ0KICAgIERNQSBVTk1BUCAoMCwgMHhhMDAwMCkgLSAtIC0gLSAtIC0gLSAtIC0gLSAtIChiKQ0K
ICAgICAgICAgIE9wZXJhdGlvbi0xIDogZHVtcCBETUFSIHRhYmxlDQoJRE1BIE1BUCAoMCwgMHhj
MDAwMDAwMCkgLSAtIC0gLSAtIC0gLSAtIC0gLSAtKGMpDQogICAgICAgICAgT3BlcmF0aW9uLTIg
Og0KICAgICAgICAgICAgIHVzZSBHREIgdG8gcGF1c2UgYXQgaGVyZSwgdGhlbiBETUEgcmVhZCBJ
T1ZBPTAsDQogICAgICAgICAgICAgc29tZXRpbWVzIERNQSBzdWNjZXNzIChhcyBleHBlY3RlZCks
DQogICAgICAgICAgICAgYnV0IHNvbWV0aW1lcyBETUEgZXJyb3IgKHJlcG9ydCBub3QtcHJlc2Vu
dCkuDQogICAgICAgICAgT3BlcmF0aW9uLTMgOiBkdW1wIERNQVIgdGFibGUNCiAgICAgICAgICBP
cGVyYXRpb24tNCAod2hlbiBETUEgZXJyb3IpIDogcGxlYXNlIHNlZSBiZWxvdw0KICAgIERNQSBV
Tk1BUCAoMCwgMHhjMDAwMDAwMCkgLSAtIC0gLSAtIC0gLSAtIC0oZCkNCn0NCg0KVGhlIERNQVIg
dGFibGUgb2YgT3BlcmF0aW9uLTEgaXMgKG9ubHkgc2hvdyB0aGUgZW50cmllcyBhYm91dCBJT1ZB
IDApOg0KDQpQTUw0OiAweCAgICAgIDFhMzRmYmIwMDMNCiAgUERQRTogMHggICAgICAxYTM0ZmJi
MDAzDQogICBQREU6IDB4ICAgICAgMWEzNGZiZjAwMw0KICAgIFBURTogMHggICAgICAgICAgICAg
ICAwDQoNCkFuZCB0aGUgdGFibGUgb2YgT3BlcmF0aW9uLTMgaXM6DQoNClBNTDQ6IDB4ICAgICAg
MWEzNGZiYjAwMw0KICBQRFBFOiAweCAgICAgIDFhMzRmYmIwMDMNCiAgIFBERTogMHggICAgICAg
MTVlYzAwODgzIDwgLSAtIDJNIHN1cGVycGFnZQ0KDQpTbyB3ZSBjYW4gc2VlIHRoZSBJT1ZBIDAg
aXMgbWFwcGVkLCBidXQgdGhlIERNQSByZWFkIGlzIGVycm9yOg0KDQpkbWFyX2ZhdWx0OiAxMzE3
NTcgY2FsbGJhY2tzIHN1cHByZXNzZWQNCkRSSEQ6IGhhbmRsaW5nIGZhdWx0IHN0YXR1cyByZWcg
NDAyDQpbRE1BIFJlYWRdIFJlcXVlc3QgZGV2aWNlIFs4NjowNS42XSBmYXVsdCBhZGRyIDAgW2Zh
dWx0IHJlYXNvbiAwNl0gUFRFIFJlYWQgYWNjZXNzIGlzIG5vdCBzZXQNCltETUEgUmVhZF0gUmVx
dWVzdCBkZXZpY2UgWzg2OjA1LjZdIGZhdWx0IGFkZHIgMCBbZmF1bHQgcmVhc29uIDA2XSBQVEUg
UmVhZCBhY2Nlc3MgaXMgbm90IHNldA0KRFJIRDogaGFuZGxpbmcgZmF1bHQgc3RhdHVzIHJlZyA2
MDANCkRSSEQ6IGhhbmRsaW5nIGZhdWx0IHN0YXR1cyByZWcgNjAyDQpbRE1BIFJlYWRdIFJlcXVl
c3QgZGV2aWNlIFs4NjowNS42XSBmYXVsdCBhZGRyIDAgW2ZhdWx0IHJlYXNvbiAwNl0gUFRFIFJl
YWQgYWNjZXNzIGlzIG5vdCBzZXQNCltETUEgUmVhZF0gUmVxdWVzdCBkZXZpY2UgWzg2OjA1LjZd
IGZhdWx0IGFkZHIgMCBbZmF1bHQgcmVhc29uIDA2XSBQVEUgUmVhZCBhY2Nlc3MgaXMgbm90IHNl
dA0KW0RNQSBSZWFkXSBSZXF1ZXN0IGRldmljZSBbODY6MDUuNl0gZmF1bHQgYWRkciAwIFtmYXVs
dCByZWFzb24gMDZdIFBURSBSZWFkIGFjY2VzcyBpcyBub3Qgc2V0DQoNCk5PVEUsIHRoZSBtYWdp
Y2FsIHRoaW5nIGhhcHBlbi4uLigqT3BlcmF0aW9uLTQqKSB3ZSB3cml0ZSB0aGUgUFRFDQpvZiBP
cGVyYXRpb24tMSBmcm9tIDAgdG8gMHgzIHdoaWNoIG1lYW5zIGNhbiBSZWFkL1dyaXRlLCBhbmQg
dGhlbg0Kd2UgdHJpZ2dlciBETUEgcmVhZCBhZ2FpbiwgaXQgc3VjY2VzcyBhbmQgcmV0dXJuIHRo
ZSBkYXRhIG9mIEhQQSAwICEhDQoNCldoeSB3ZSBtb2RpZnkgdGhlIG9sZGVyIHBhZ2UgdGFibGUg
d291bGQgbWFrZSBzZW5zZSA/IEFzIHdlDQpoYXZlIGRpc2N1c3NlZCBwcmV2aW91c2x5LCB0aGUg
Y2FjaGUgZmx1c2ggcGFydCBvZiB0aGUgZHJpdmVyIGlzIGNvcnJlY3QsDQppdCBjYWxsIGZsdXNo
X2lvdGxiIGFmdGVyIChiKSBhbmQgbm8gbmVlZCB0byBmbHVzaCBhZnRlciAoYykuIEJ1dCB0aGUg
cmVzdWx0DQpvZiB0aGUgZXhwZXJpbWVudCBzaG93cyB0aGUgb2xkZXIgcGFnZSB0YWJsZSBvciBv
bGRlciBjYWNoZXMgaXMgZWZmZWN0aXZlDQphY3R1YWxseS4NCg0KQW55IGlkZWFzID8NCg0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IGJhb2x1DQo=
