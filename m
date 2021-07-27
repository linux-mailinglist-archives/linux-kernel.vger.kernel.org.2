Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F083D6BA4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 03:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbhG0BNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 21:13:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:46038 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhG0BNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 21:13:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="273429288"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="273429288"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 18:54:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="434564661"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2021 18:54:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 26 Jul 2021 18:54:05 -0700
Received: from irsmsx605.ger.corp.intel.com (163.33.146.138) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 26 Jul 2021 18:54:04 -0700
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138]) by
 IRSMSX605.ger.corp.intel.com ([163.33.146.138]) with mapi id 15.01.2242.010;
 Tue, 27 Jul 2021 02:54:02 +0100
From:   "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "seanjc@google.com" <seanjc@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 0/6] Basic recovery for machine checks inside SGX
Thread-Topic: [PATCH v2 0/6] Basic recovery for machine checks inside SGX
Thread-Index: AQHXfMq6r6tbFAZfSk6nbTlc0h1OdqtWCjIA
Date:   Tue, 27 Jul 2021 01:54:02 +0000
Message-ID: <725178dae805211fdcf658dee33110de8342d274.camel@intel.com>
References: <20210708181423.1312359-1-tony.luck@intel.com>
         <20210719182009.1409895-1-tony.luck@intel.com>
In-Reply-To: <20210719182009.1409895-1-tony.luck@intel.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="utf-8"
Content-ID: <382C908792BD4F459EC7954134828D52@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA3LTE5IGF0IDExOjIwIC0wNzAwLCBUb255IEx1Y2sgd3JvdGU6DQo+IFZl
cnkgZGlmZmVyZW50IGZyb20gdmVyc2lvbiAxIGJhc2VkIG9uIGZlZWRiYWNrLg0KPiANCj4gU2Vh
bjoJRGlkbid0IGxpa2UgdHJhY2tpbmcgdHlwZXMgb2YgU0dYIHBhZ2VzLCBzbyB0aGF0J3MgYWxs
IGdvbmUgbm93LiBJDQo+IAlkbyB0cmFjayB0aGUgbGlmZSBjeWNsZSAoaW4gcGF0Y2ggMSkgdXNp
bmcgdGhlICJvd25lciIgZmllbGQgdG8NCj4gCWRldGVybWluZSB3aGV0aGVyIGEgcGFnZSBpcyBp
biB1c2UgdnMuIGRpcnR5L2ZyZWUuIEN1cnJlbnRseQ0KPiAJdGhpcyBzZXJpZXMgZG9lc24ndCBt
YWtlIHVzZSBvZiB0aGF0IC4uLiBzbyBwYXRjaCAxIGNvdWxkIGJlDQo+IAlkcm9wcGVkLiBCdXQg
aXQgaXMgdmVyeSBzbWFsbCwgYW5kIEkgdGhpbmsgYSBwcmUtcmVxdWlzaXRlIGZvcg0KPiAJZnV0
dXJlIGltcHJvdmVtZW50cyB0byB0YWtlIHByZS1lbXB0aXZlIGFjdGlvbiBmb3IgYXN5bmNoIHBv
aXNvbg0KPiAJbm90aWZpY2F0aW9uIChyYXRoZXIgdGhhdCBqdXN0IGhvcGluZyB0aGF0IHRoZSBl
bmNsYXZlIHdpbGwgZXhpdA0KPiAJd2l0aG91dCBhY2Nlc3NpbmcgcG9pc29uLCBvciB0aGF0IGlm
IGl0IGRvZXMgY29uc3VtZSB0aGUgcG9pc29uDQo+IAl0aGUgZXJyb3Igd2lsbCBiZSByZWNvdmVy
YWJsZSkuDQo+IA0KPiAJSSB0aGluayB3ZSBzaG91bGQgZGVmZXIgdGhlIHdob2xlIGFzeW5jaCBh
Y3Rpb24gdG8gYSBzdWJzZXF1ZW50DQo+IAlzZXJpZXMgdGhhdCBjYW4gYnVpbGQgb24gdG9wIG9m
IHRoaXMgKGFuZCBkbyBpdCBwcm9wZXJseSAuLi4NCj4gCW15IHZlcnNpb24gMSBzZW50IG91dCBT
SUdCVVMgc2lnbmFscyB3aXRob3V0IHJlZ2FyZCBmb3Igc3lzdGVtDQo+IAkoL3Byb2Mvc3lzL3Zt
L21lbW9yeV9mYWlsdXJlX2Vhcmx5X2tpbGwpIG9yIHBlci10YXNrIChwcmN0bA0KPiAJUFJfTUNF
X0tJTEwpIHBvbGljaWVzKS4NCj4gDQo+IEphcmtrbzoJU2FpZCBwb2lzb24gcGFnZXMgc2hvdWxk
IG5vdCBqdXN0IGJlIGRyb3BwZWQgb24gdGhlIGZsb29yLiBUaGV5DQo+IAlzaG91bGQgYmUgYWRk
ZWQgdG8gYSBsaXN0IGZvciBmdXR1cmUgdG9vbHMgdG8gZXhhbWluZS4gSSB0cmllZA0KPiAJdGhl
IGxpc3QgYXBwcm9hY2gsIGJ1dCBzYWZlbHkgcmVtb3ZpbmcgcGFnZXMgZnJvbSBmcmVlL2RpcnR5
DQo+IAlsaXN0cyBpbnZvbHZlZCBzb21lIGNvbXBsZXggbG9ja2luZywgc28gSSBza2lwcGVkIGFo
ZWFkIHRvIHRoZQ0KPiAJInRvb2xzIiBpZGVhIGFuZCBqdXN0IGFkZGVkIGZpbGVzIGluIGRlYnVn
ZnMgdG8gc2hvdyB0aGUgY291bnQNCj4gCW9mIHBvaXNvbiBwYWdlcyBhbmQgYSBsaXN0IG9mIGFk
ZHJlc3NlcyAobWF5YmUgdGhlIGNvdW50IGlzDQo+IAlyZWR1bmRhbnQ/IENvdWxkIGp1c3QgIndj
IC1sIHBvaXNvbl9wYWdlX2xpc3QiPykuDQo+IA0KPiBPdGhlcjoJSSBnb3QgYSBjb21wbGFpbnQg
dGhhdCBhZnRlciBhIHBvaXNvbiBwYWdlIGlzIGhhbmRsZWQgTGludXgNCj4gCXNwaXRzIG91dCB0
aGlzIG1lc3NhZ2U6DQo+IAkJQ291bGQgbm90IGludmFsaWRhdGUgcGZuPTB4MjAwMGM0ZCBmcm9t
IDE6MSBtYXANCj4gCXRoaXMgaXMgZnJvbSBzZXRfbWNlX25vc3BlYygpIGFuZCBoYXBwZW5zIGJl
Y2F1c2UgRVBDIHBhZ2VzDQo+IAlhcmUgbm90IGluIHRoZSAxOjEgbWFwLiBBZGQgY29kZSB0byBj
aGVjayBhbmQgaWdub3JlIHRoZW0uDQo+IA0KPiBUb255IEx1Y2sgKDYpOg0KPiAgIHg4Ni9zZ3g6
IFByb3ZpZGUgaW5kaWNhdGlvbiBvZiBsaWZlLWN5Y2xlIG9mIEVQQyBwYWdlcw0KPiAgIHg4Ni9z
Z3g6IEFkZCBpbmZyYXN0cnVjdHVyZSB0byBpZGVudGlmeSBTR1ggRVBDIHBhZ2VzDQo+ICAgeDg2
L3NneDogSW5pdGlhbCBwb2lzb24gaGFuZGxpbmcgZm9yIGRpcnR5IGFuZCBmcmVlIHBhZ2VzDQo+
ICAgeDg2L3NneDogQWRkIFNHWCBpbmZyYXN0cnVjdHVyZSB0byByZWNvdmVyIGZyb20gcG9pc29u
DQo+ICAgeDg2L3NneDogSG9vayBzZ3hfbWVtb3J5X2ZhaWx1cmUoKSBpbnRvIG1haW5saW5lIGNv
ZGUNCj4gICB4ODYvc2d4OiBBZGQgaG9vayB0byBlcnJvciBpbmplY3Rpb24gYWRkcmVzcyB2YWxp
ZGF0aW9uDQo+IA0KPiAgLi4uL2Zpcm13YXJlLWd1aWRlL2FjcGkvYXBlaS9laW5qLnJzdCAgICAg
ICAgIHwgIDE5ICsrKw0KPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vc2V0X21lbW9yeS5oICAgICAg
ICAgICAgIHwgICA0ICsNCj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvc2d4L2VuY2wuYyAgICAgICAg
ICAgICAgICB8ICAgMiArLQ0KPiAgYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvbWFpbi5jICAgICAg
ICAgICAgICAgIHwgMTM3ICsrKysrKysrKysrKysrKysrLQ0KPiAgYXJjaC94ODYva2VybmVsL2Nw
dS9zZ3gvc2d4LmggICAgICAgICAgICAgICAgIHwgICA2ICstDQo+ICBkcml2ZXJzL2FjcGkvYXBl
aS9laW5qLmMgICAgICAgICAgICAgICAgICAgICAgfCAgIDMgKy0NCj4gIGluY2x1ZGUvbGludXgv
bW0uaCAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNSArKw0KPiAgbW0vbWVtb3J5LWZh
aWx1cmUuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE5ICsrLQ0KPiAgOCBmaWxlcyBj
aGFuZ2VkLCAxOTUgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+IA0KPiANCj4gYmFz
ZS1jb21taXQ6IDI3MzRkNmMxYjFhMDg5ZmI1OTNlZjZhMjNkNGI3MDkwMzUyNmZlMGMNCg0KVXNl
IGphcmtrb0BrZXJuZWwub3JnIGluIGZ1dHVyZSB2ZXJzaW9ucy4NCg0KL0phcmtrbw0KDQo=
