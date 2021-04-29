Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CB636F2B8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 00:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhD2WtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 18:49:12 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3972 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhD2WtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 18:49:07 -0400
Received: from dggeme760-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FWVw55cB6zYdM5;
        Fri, 30 Apr 2021 06:45:57 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme760-chm.china.huawei.com (10.3.19.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 30 Apr 2021 06:48:16 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2176.012;
 Fri, 30 Apr 2021 06:48:15 +0800
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
Thread-Index: AQHXPMXH0SQBD1qG+ECo3ZrOidSRtqrLBimAgADzHOD//4cYAIAAjhuw//+CrICAAIZiwA==
Date:   Thu, 29 Apr 2021 22:48:15 +0000
Message-ID: <1daf0e3e1bc342c091304f1d168491a3@hisilicon.com>
References: <1619679819-45256-1-git-send-email-tiantao6@hisilicon.com>
 <1619679819-45256-2-git-send-email-tiantao6@hisilicon.com>
 <146e051b-603c-a6d3-43d8-d083cf2c8119@intel.com>
 <602918a1e2214ea7bd0890a751975566@hisilicon.com>
 <7c663f7e-07e0-6d95-3012-6e31a1b78f7e@intel.com>
 <4bf6870f7f3942398e4d1fdaa42184c7@hisilicon.com>
 <fd78ac30-dd3b-a7d7-eae8-193b09a7d49a@intel.com>
In-Reply-To: <fd78ac30-dd3b-a7d7-eae8-193b09a7d49a@intel.com>
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
MjEgMTA6MzkgQU0NCj4gVG86IFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgPHNvbmcuYmFvLmh1
YUBoaXNpbGljb24uY29tPjsgdGlhbnRhbyAoSCkNCj4gPHRpYW50YW82QGhpc2lsaWNvbi5jb20+
OyBjb3JiZXRAbHduLm5ldDsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcNCj4gQ2M6IGxpbnV4
LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFJhZmFl
bCBKLg0KPiBXeXNvY2tpIDxyYWZhZWxAa2VybmVsLm9yZz47IFBldGVyIFppamxzdHJhIDxwZXRl
cnpAaW5mcmFkZWFkLm9yZz47IFZhbGVudGluDQo+IFNjaG5laWRlciA8dmFsZW50aW4uc2NobmVp
ZGVyQGFybS5jb20+OyBEYXZlIEhhbnNlbg0KPiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29t
PjsgRGFuaWVsIEJyaXN0b3QgZGUgT2xpdmVpcmEgPGJyaXN0b3RAcmVkaGF0LmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCAxLzJdIENQVSwgTlVNQSB0b3BvbG9neSBBQklzOiBjbGFyaWZ5IHRo
ZSBvdmVyZmxvdyBpc3N1ZQ0KPiBvZiBzeXNmcyBwYWdlYnVmDQo+IA0KPiBPbiA0LzI5LzIxIDM6
MzIgUE0sIFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgd3JvdGU6DQo+ID4gJCBzdHJhY2UgbnVt
YWN0bCAtLWhhcmR3YXJlICAyPiYxIHwgZ3JlcCBjcHUNCj4gPiBvcGVuYXQoQVRfRkRDV0QsICIv
c3lzL2RldmljZXMvc3lzdGVtL2NwdSIsDQo+ID4gT19SRE9OTFl8T19OT05CTE9DS3xPX0RJUkVD
VE9SWXxPX0NMT0VYRUMpID0gMw0KPiA+IG9wZW5hdChBVF9GRENXRCwgIi9zeXMvZGV2aWNlcy9z
eXN0ZW0vbm9kZS9ub2RlMC9jcHVtYXAiLCBPX1JET05MWSkgPSAzDQo+ID4gb3BlbmF0KEFUX0ZE
Q1dELCAiL3N5cy9kZXZpY2VzL3N5c3RlbS9ub2RlL25vZGUxL2NwdW1hcCIsIE9fUkRPTkxZKSA9
IDMNCj4gPiBvcGVuYXQoQVRfRkRDV0QsICIvc3lzL2RldmljZXMvc3lzdGVtL25vZGUvbm9kZTIv
Y3B1bWFwIiwgT19SRE9OTFkpID0gMw0KPiA+IG9wZW5hdChBVF9GRENXRCwgIi9zeXMvZGV2aWNl
cy9zeXN0ZW0vbm9kZS9ub2RlMy9jcHVtYXAiLCBPX1JET05MWSkgPSAzDQo+ID4NCj4gPiBJZiB3
ZSBtb3ZlIHRvIGJpbmFyeSwgaXQgbWVhbnMgd2UgaGF2ZSB0byBjaGFuZ2UgdGhvc2UgYXBwbGlj
YXRpb25zLg0KPiANCj4gSSB0aG91Z2h0IEdyZWcgd2FzIHNheWluZyB0byB1c2luZyBhIHN5c2Zz
IGJpbmFyeSBhdHRyaWJ1dGUgdXNpbmcNCj4gc29tZXRoaW5nIGxpa2UgbGlrZSBzeXNmc19jcmVh
dGVfYmluX2ZpbGUoKS4gIFRob3NlIGRvbid0IGhhdmUgdGhlDQo+IFBBR0VfU0laRSBsaW1pdGF0
aW9uLiAgQnV0LCB0aGVyZSdzIGFsc28gbm90aGluZyB0byBrZWVwIHVzIGZyb20gc3Bld2luZw0K
PiBuaWNlIGh1bWFuLXJlYWRhYmxlIHRleHQgdmlhIHRoZSAiYmluYXJ5IiBmaWxlLg0KPiANCj4g
V2UgZG9uJ3QgbmVlZCB0byBjaGFuZ2UgdGhlIGZpbGUgZm9ybWF0LCBqdXN0IHRoZSBpbnRlcm5h
bCBrZXJuZWwgQVBJDQo+IHRoYXQgd2UgcHJvZHVjZSB0aGUgZmlsZXMgd2l0aC4NCg0KRGF2ZSwg
dGhhbmtzIGZvciBjbGFyaWZpY2F0aW9uLiBTb3VuZHMgYSB3YXkgdG8gZ28uDQoNCkJhcnJ5DQo=
