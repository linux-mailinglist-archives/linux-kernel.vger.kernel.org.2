Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBDC36F29D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 00:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhD2Wd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 18:33:26 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:3347 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhD2WdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 18:33:25 -0400
Received: from dggeme760-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FWVX51FmMz19J7R;
        Fri, 30 Apr 2021 06:28:37 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme760-chm.china.huawei.com (10.3.19.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 30 Apr 2021 06:32:35 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Fri, 30 Apr 2021 06:32:30 +0800
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
Thread-Index: AQHXPMXH0SQBD1qG+ECo3ZrOidSRtqrLBimAgADzHOD//4cYAIAAjhuw
Date:   Thu, 29 Apr 2021 22:32:30 +0000
Message-ID: <4bf6870f7f3942398e4d1fdaa42184c7@hisilicon.com>
References: <1619679819-45256-1-git-send-email-tiantao6@hisilicon.com>
 <1619679819-45256-2-git-send-email-tiantao6@hisilicon.com>
 <146e051b-603c-a6d3-43d8-d083cf2c8119@intel.com>
 <602918a1e2214ea7bd0890a751975566@hisilicon.com>
 <7c663f7e-07e0-6d95-3012-6e31a1b78f7e@intel.com>
In-Reply-To: <7c663f7e-07e0-6d95-3012-6e31a1b78f7e@intel.com>
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
MjEgOTozOSBBTQ0KPiBUbzogU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSA8c29uZy5iYW8uaHVh
QGhpc2lsaWNvbi5jb20+OyB0aWFudGFvIChIKQ0KPiA8dGlhbnRhbzZAaGlzaWxpY29uLmNvbT47
IGNvcmJldEBsd24ubmV0OyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZw0KPiBDYzogbGludXgt
ZG9jQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgUmFmYWVs
IEouDQo+IFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVy
ekBpbmZyYWRlYWQub3JnPjsgVmFsZW50aW4NCj4gU2NobmVpZGVyIDx2YWxlbnRpbi5zY2huZWlk
ZXJAYXJtLmNvbT47IERhdmUgSGFuc2VuDQo+IDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+
OyBEYW5pZWwgQnJpc3RvdCBkZSBPbGl2ZWlyYSA8YnJpc3RvdEByZWRoYXQuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDEvMl0gQ1BVLCBOVU1BIHRvcG9sb2d5IEFCSXM6IGNsYXJpZnkgdGhl
IG92ZXJmbG93IGlzc3VlDQo+IG9mIHN5c2ZzIHBhZ2VidWYNCj4gDQo+IE9uIDQvMjkvMjEgMjow
OCBQTSwgU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKSB3cm90ZToNCj4gPj4gRG8gd2UgdGhpbmsg
PlBBR0VfU0laRSBkYXRhIG91dCBvZiBhIHN5c2ZzIGZpbGUgaXMgYSB3b3JzZSBBQkkgYnJlYWsg
b3INCj4gPj4gc29tZXRoaW5nPw0KPiA+IFRoaXMga2luZCBvZiBjcHUgbGlzdCBBQklzIGhhdmUg
YmVlbiB0aGVyZSBmb3IgbWFueSB5ZWFycyBidXQgaGF2ZQ0KPiA+IG5ldmVyIGJlZW4gZG9jdW1l
bnRlZCB3ZWxsLg0KPiA+DQo+ID4gV2UgaGF2ZSB0d28gQUJJczoNCj4gPiB4eHhfY3B1cyAtIGlu
IGZvcm1hdCBsaWtlIDMzMzMzMzMzMzMNCj4gPiB4eHhfY3B1c19saXN0IC0gaW4gZm9ybWF0IGxp
a2UgMCwzLDUsNyw5LDExLDEzLi4uLg0KPiA+DQo+ID4geHh4X2NwdXNfbGlzdCBpcyBhbm90aGVy
IGh1bWFuLXJlYWRhYmxlIHZlcnNpb24gb2YgeHh4X2NwdXMuIEl0IGRvZXNuJ3QNCj4gPiBpbmNs
dWRlIGFueSBtb3JlIHVzZWZ1bCBpbmZvcm1hdGlvbiB0aGFuIHh4eF9jcHVzLg0KPiA+DQo+ID4g
eHh4X2NwdXMgd29uJ3Qgb3ZlcmZsb3cgYmFzZWQgb24gQlVJTERfQlVHX09OIGFuZCBtYXhpbXVt
IE5SX0NQVVMNCj4gPiBpbiBrY29uZmlnIG5vd2FkYXlzLg0KPiA+DQo+ID4gaWYgcGVvcGxlIGFs
bCBhZ3JlZSB0aGUgdHJpbW1lZCBsaXN0IGlzIGEgYnJlYWsgb2YgQUJJLCBJIHRoaW5rIHdlIG1h
eQ0KPiA+IHRvdGFsbHkgcmVtb3ZlIHRoaXMgbGlzdC4gRm9yIHRoZXNlIGRheXMsIHRoaXMgbGlz
dCBwcm9iYWJseSBoYXMgbmV2ZXINCj4gPiBvdmVyZmxvd2VkIGJ1dCBsaXRlcmFsbHkgdGhpcyBj
b3VsZCBoYXBwZW4uDQo+ID4NCj4gPiB0aG91Z2h0cz8NCj4gDQo+IEZyb20gd2hhdCBHcmVnIHNh
aWQsIGl0IHNvdW5kcyBsaWtlIHJlbW92aW5nIHRoZSBCVUlMRF9CVUdfT04oKSwgbWFraW5nDQo+
IGl0IGEgYmluYXJ5IHN5c2ZzIGZpbGUsIGFuZCBtYWtpbmcgaXQgc3VwcG9ydCBhcmJpdHJhcnkg
bGVuZ3RocyBpcyB0aGUNCj4gd2F5IHRvIGdvLg0KDQpJIGFtIGFjdHVhbGx5IG1vcmUgY29uY2Vy
bmVkIG9uIHh4eF9jcHVzX2xpc3QgdGhhbiB4eHhfY3B1cy4NCg0KeHh4X2NwdXMgaGFzIG5ldmVy
IG92ZXJmbG93ZWQuIFRob3VnaCB0aGVyZSBpcyBhIEJVSUxEX0JVR19PTigpLCBidXQgdGhlDQpt
YXhpbXVtIE5SX0NQVVMgaXMgODA5NiwgaXQgaXMgc3RpbGwgZmFyIGZyb20gb3ZlcmZsb3cuDQo4
MDk2IC8zMiAqIDkgPSAyMjc3DQphcyAyMjc3IDwgNDA5Ng0KDQpXaGlsZSBOUl9DUFVTIGdldHMg
dG8gfjE0NTAwLCBmb3IgYSA0S0IgcGFnZSwgeHh4X2NwdXMgd2lsbCBvdmVyZmxvdy4NCkJ1dCBJ
IGRvbid0IGtub3cgd2hlbiBoYXJkd2FyZSB3aWxsIHJlYWNoIHRoZXJlLiBJZiB3ZSByZWFjaCB0
aGVyZSwNCnRoZSBleGlzdGluZyBjb2RlIHRvIGRlc2NyaWJlIHRvcG9sb2d5IGFuZCBzY2hlZHVs
ZSB0YXNrcyBtaWdodCBhbHNvDQpuZWVkIHJld29yay4NCg0KT24gdGhlIG90aGVyIGhhbmQsIGxz
Y3B1LCBod2xvYywgbnVtYWN0bCBldGMgYXJlIHVzaW5nIHRoZSBleGlzdGluZw0KaGV4IGJpdG1h
cCBBQkk6DQoNCiQgc3RyYWNlIGxzY3B1ICAyPiYxIHwgZ3JlcCB0b3BvbG9neQ0KZmFjY2Vzc2F0
KEFUX0ZEQ1dELA0KIi9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L2NwdTAvdG9wb2xvZ3kvdGhyZWFk
X3NpYmxpbmdzIiwgRl9PSykgPSAwDQpvcGVuYXQoQVRfRkRDV0QsDQoiL3N5cy9kZXZpY2VzL3N5
c3RlbS9jcHUvY3B1MC90b3BvbG9neS90aHJlYWRfc2libGluZ3MiLA0KT19SRE9OTFl8T19DTE9F
WEVDKSA9IDMNCm9wZW5hdChBVF9GRENXRCwNCiIvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUw
L3RvcG9sb2d5L2NvcmVfc2libGluZ3MiLA0KT19SRE9OTFl8T19DTE9FWEVDKSA9IDMNCmZhY2Nl
c3NhdChBVF9GRENXRCwNCiIvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHUwL3RvcG9sb2d5L2Jv
b2tfc2libGluZ3MiLCBGX09LKSA9IC0xDQpFTk9FTlQgKE5vIHN1Y2ggZmlsZSBvciBkaXJlY3Rv
cnkpDQpmYWNjZXNzYXQoQVRfRkRDV0QsDQoiL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1MS90
b3BvbG9neS90aHJlYWRfc2libGluZ3MiLCBGX09LKSA9IDANCm9wZW5hdChBVF9GRENXRCwNCi4u
Lg0KDQokIHN0cmFjZSBudW1hY3RsIC0taGFyZHdhcmUgIDI+JjEgfCBncmVwIGNwdQ0Kb3BlbmF0
KEFUX0ZEQ1dELCAiL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUiLA0KT19SRE9OTFl8T19OT05CTE9D
S3xPX0RJUkVDVE9SWXxPX0NMT0VYRUMpID0gMw0Kb3BlbmF0KEFUX0ZEQ1dELCAiL3N5cy9kZXZp
Y2VzL3N5c3RlbS9ub2RlL25vZGUwL2NwdW1hcCIsIE9fUkRPTkxZKSA9IDMNCm9wZW5hdChBVF9G
RENXRCwgIi9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlMS9jcHVtYXAiLCBPX1JET05MWSkg
PSAzDQpvcGVuYXQoQVRfRkRDV0QsICIvc3lzL2RldmljZXMvc3lzdGVtL25vZGUvbm9kZTIvY3B1
bWFwIiwgT19SRE9OTFkpID0gMw0Kb3BlbmF0KEFUX0ZEQ1dELCAiL3N5cy9kZXZpY2VzL3N5c3Rl
bS9ub2RlL25vZGUzL2NwdW1hcCIsIE9fUkRPTkxZKSA9IDMNCg0KSWYgd2UgbW92ZSB0byBiaW5h
cnksIGl0IG1lYW5zIHdlIGhhdmUgdG8gY2hhbmdlIHRob3NlIGFwcGxpY2F0aW9ucy4NCg0KRm9y
IHRoaXMgbW9tZW50LCBJJ2QgYXJndWUgd2Uga2VlcCBjcHUgYml0bWFwIEFCSSBhcyBpcyBhbmQg
ZGVmZXIgdGhpcw0KaXNzdWUgdG8gd2hlbiB3ZSByZWFsbHkgZ2V0IHNvIG1hbnkgY29yZXMuDQoN
ClRoYW5rcw0KQmFycnkNCg==
