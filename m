Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B3A34015C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbhCRIyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:54:23 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3471 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhCRIyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:54:19 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4F1LPW2Nkqz5fJy;
        Thu, 18 Mar 2021 16:52:15 +0800 (CST)
Received: from dggpemm500012.china.huawei.com (7.185.36.89) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Thu, 18 Mar 2021 16:54:09 +0800
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 16:54:09 +0800
Received: from dggpeml500016.china.huawei.com ([7.185.36.70]) by
 dggpeml500016.china.huawei.com ([7.185.36.70]) with mapi id 15.01.2106.013;
 Thu, 18 Mar 2021 16:54:09 +0800
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>
CC:     chenjiashang <chenjiashang@huawei.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        "will@kernel.org" <will@kernel.org>
Subject: =?utf-8?B?UkU6IEEgcHJvYmxlbSBvZiBJbnRlbCBJT01NVSBoYXJkd2FyZSDvvJ8=?=
Thread-Topic: =?utf-8?B?QSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw==?=
Thread-Index: AQHXGtwEduPlUZeCNUCbiy3s/+KwAaqHJckAgADDZTCAAA0+AIABZ4Ng//+HOQCAAIduIP//fRsAgACIaxA=
Date:   Thu, 18 Mar 2021 08:54:09 +0000
Message-ID: <e27ceb3b87294950b9990ba8c087b0a5@huawei.com>
References: <670baaf8-4ff8-4e84-4be3-030b95ab5a5e@huawei.com>
 <FB4E11A5-84D4-4DAF-889E-FAA1BCD2E66F@gmail.com>
 <6a218e7fe42d41489d02f0b4e3ad2756@huawei.com>
 <98DB71EF-FF98-4509-85EC-26FF50825A58@gmail.com>
 <4d1c3bc0418e48b1b9d44799d65ea375@huawei.com>
 <MWHPR11MB18860801196A9319EBD96AF68C699@MWHPR11MB1886.namprd11.prod.outlook.com>
 <d7bb4ab26b8542c698926b7a0a3fc12c@huawei.com>
 <MWHPR11MB18865CD0C3B7A9CFD73D8E4C8C699@MWHPR11MB1886.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB18865CD0C3B7A9CFD73D8E4C8C699@MWHPR11MB1886.namprd11.prod.outlook.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGlhbiwgS2V2aW4gW21h
aWx0bzprZXZpbi50aWFuQGludGVsLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDE4LCAy
MDIxIDQ6NDMgUE0NCj4gVG86IExvbmdwZW5nIChNaWtlLCBDbG91ZCBJbmZyYXN0cnVjdHVyZSBT
ZXJ2aWNlIFByb2R1Y3QgRGVwdC4pDQo+IDxsb25ncGVuZzJAaHVhd2VpLmNvbT47IE5hZGF2IEFt
aXQgPG5hZGF2LmFtaXRAZ21haWwuY29tPg0KPiBDYzogY2hlbmppYXNoYW5nIDxjaGVuamlhc2hh
bmdAaHVhd2VpLmNvbT47IERhdmlkIFdvb2Rob3VzZQ0KPiA8ZHdtdzJAaW5mcmFkZWFkLm9yZz47
IGlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBMS01MDQo+IDxsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnPjsgYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IEdvbmdsZWkgKEFy
ZWkpDQo+IDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNvbT47IHdpbGxAa2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSRTogQSBwcm9ibGVtIG9mIEludGVsIElPTU1VIGhhcmR3YXJlIO+8nw0KPiANCj4gPiBG
cm9tOiBMb25ncGVuZyAoTWlrZSwgQ2xvdWQgSW5mcmFzdHJ1Y3R1cmUgU2VydmljZSBQcm9kdWN0
IERlcHQuKQ0KPiA+IDxsb25ncGVuZzJAaHVhd2VpLmNvbT4NCj4gPg0KPiA+DQo+ID4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogVGlhbiwgS2V2aW4gW21haWx0bzpr
ZXZpbi50aWFuQGludGVsLmNvbV0NCj4gPiA+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxOCwgMjAy
MSA0OjI3IFBNDQo+ID4gPiBUbzogTG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJhc3RydWN0dXJl
IFNlcnZpY2UgUHJvZHVjdCBEZXB0LikNCj4gPiA+IDxsb25ncGVuZzJAaHVhd2VpLmNvbT47IE5h
ZGF2IEFtaXQgPG5hZGF2LmFtaXRAZ21haWwuY29tPg0KPiA+ID4gQ2M6IGNoZW5qaWFzaGFuZyA8
Y2hlbmppYXNoYW5nQGh1YXdlaS5jb20+OyBEYXZpZCBXb29kaG91c2UNCj4gPiA+IDxkd213MkBp
bmZyYWRlYWQub3JnPjsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmc7IExLTUwNCj4g
PiA+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgYWxleC53aWxsaWFtc29uQHJlZGhh
dC5jb207IEdvbmdsZWkNCj4gPiAoQXJlaSkNCj4gPiA+IDxhcmVpLmdvbmdsZWlAaHVhd2VpLmNv
bT47IHdpbGxAa2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogUkU6IEEgcHJvYmxlbSBvZiBJbnRl
bCBJT01NVSBoYXJkd2FyZSDvvJ8NCj4gPiA+DQo+ID4gPiA+IEZyb206IGlvbW11IDxpb21tdS1i
b3VuY2VzQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnPiBPbiBCZWhhbGYNCj4gPiA+ID4gT2Yg
TG9uZ3BlbmcgKE1pa2UsIENsb3VkIEluZnJhc3RydWN0dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0
LikNCj4gPiA+ID4NCj4gPiA+ID4gPiAyLiBDb25zaWRlciBlbnN1cmluZyB0aGF0IHRoZSBwcm9i
bGVtIGlzIG5vdCBzb21laG93IHJlbGF0ZWQgdG8NCj4gPiA+ID4gPiBxdWV1ZWQgaW52YWxpZGF0
aW9ucy4gVHJ5IHRvIHVzZSBfX2lvbW11X2ZsdXNoX2lvdGxiKCkgaW5zdGVhZA0KPiA+ID4gPiA+
IG9mDQo+ID4gPiBxaV9mbHVzaF9pb3RsYigpLg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+
IEkgdHJpZWQgdG8gZm9yY2UgdG8gdXNlIF9faW9tbXVfZmx1c2hfaW90bGIoKSwgYnV0IG1heWJl
IHNvbWV0aGluZw0KPiA+ID4gPiB3cm9uZywgdGhlIHN5c3RlbSBjcmFzaGVkLCBzbyBJIHByZWZl
ciB0byBsb3dlciB0aGUgcHJpb3JpdHkgb2YNCj4gPiA+ID4gdGhpcw0KPiA+IG9wZXJhdGlvbi4N
Cj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBUaGUgVlQtZCBzcGVjIGNsZWFybHkgc2F5cyB0aGF0IHJl
Z2lzdGVyLWJhc2VkIGludmFsaWRhdGlvbiBjYW4gYmUNCj4gPiA+IHVzZWQgb25seQ0KPiA+IHdo
ZW4NCj4gPiA+IHF1ZXVlZC1pbnZhbGlkYXRpb25zIGFyZSBub3QgZW5hYmxlZC4gSW50ZWwtSU9N
TVUgZHJpdmVyIGRvZXNuJ3QNCj4gPiA+IHByb3ZpZGUNCj4gPiBhbg0KPiA+ID4gb3B0aW9uIHRv
IGRpc2FibGUgcXVldWVkLWludmFsaWRhdGlvbiB0aG91Z2gsIHdoZW4gdGhlIGhhcmR3YXJlIGlz
DQo+ID4gY2FwYWJsZS4gSWYgeW91DQo+ID4gPiByZWFsbHkgd2FudCB0byB0cnksIHR3ZWFrIHRo
ZSBjb2RlIGluIGludGVsX2lvbW11X2luaXRfcWkuDQo+ID4gPg0KPiA+DQo+ID4gSGkgS2V2aW4s
DQo+ID4NCj4gPiBUaGFua3MgdG8gcG9pbnQgb3V0IHRoaXMuIERvIHlvdSBoYXZlIGFueSBpZGVh
cyBhYm91dCB0aGlzIHByb2JsZW0gPyBJDQo+ID4gdHJpZWQgdG8gZGVzY3JpcHQgdGhlIHByb2Js
ZW0gbXVjaCBjbGVhciBpbiBteSByZXBseSB0byBBbGV4LCBob3BlIHlvdQ0KPiA+IGNvdWxkIGhh
dmUgYSBsb29rIGlmIHlvdSdyZSBpbnRlcmVzdGVkLg0KPiA+DQo+IA0KPiBJIGFncmVlIHdpdGgg
TmFkYXYuIExvb2tzIHRoaXMgaW1wbGllcyBzb21lIHN0YWxlIHBhZ2luZyBzdHJ1Y3R1cmUgY2Fj
aGUgZW50cnkgKGUuZy4NCj4gUE1EKSBpcyBub3QgaW52YWxpZGF0ZWQgcHJvcGVybHkuIEl0J3Mg
YmV0dGVyIGlmIEJhb2x1IGNhbiByZXByb2R1Y2UgdGhpcyBwcm9ibGVtIGluDQo+IGhpcyBsb2Nh
bCBlbnZpcm9ubWVudCBhbmQgdGhlbiBkbyBtb3JlIGRlYnVnIHRvIGlkZW50aWZ5IHdoZXRoZXIg
aXQncyBhIHNvZnR3YXJlIG9yDQo+IGhhcmR3YXJlIGRlZmVjdC4NCj4gDQo+IGJ0dyB3aGF0IGlz
IHRoZSBkZXZpY2UgdW5kZXIgdGVzdD8gRG9lcyBpdCBzdXBwb3J0IEFUUz8NCj4gDQoNClRoZSBk
ZXZpY2UgaXMgb3VyIG9mZmxvYWQgY2FyZCwgaXQgZG9lcyBub3Qgc3VwcG9ydCBBVFMgY2FwLg0K
DQo+IFRoYW5rcw0KPiBLZXZpbg0K
