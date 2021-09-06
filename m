Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FED401FE8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbhIFSwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:52:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:31951 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhIFSw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:52:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="200235642"
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; 
   d="scan'208";a="200235642"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 11:51:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; 
   d="scan'208";a="691769926"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga006.fm.intel.com with ESMTP; 06 Sep 2021 11:51:24 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 6 Sep 2021 11:51:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 6 Sep 2021 11:51:23 -0700
Received: from orsmsx610.amr.corp.intel.com ([10.22.229.23]) by
 ORSMSX610.amr.corp.intel.com ([10.22.229.23]) with mapi id 15.01.2242.012;
 Mon, 6 Sep 2021 11:51:23 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "Zhang, Cathy" <cathy.zhang@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 5/6] x86/sgx: Hook sgx_memory_failure() into mainline
 code
Thread-Topic: [PATCH v4 5/6] x86/sgx: Hook sgx_memory_failure() into mainline
 code
Thread-Index: AQHXm32N+zFqinyIzkeTnR6PEPyjK6uSU9kAgAAMBgCABQikEA==
Date:   Mon, 6 Sep 2021 18:51:23 +0000
Message-ID: <25db682402d14c34af9ba525cffe85c5@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
         <20210827195543.1667168-1-tony.luck@intel.com>
         <20210827195543.1667168-6-tony.luck@intel.com>
         <49fccddbbf92279f575409851a9c682495146ad8.camel@kernel.org>
 <681d530d72de842c8bf43733c11f3c3f2ebf8c6e.camel@kernel.org>
In-Reply-To: <681d530d72de842c8bf43733c11f3c3f2ebf8c6e.camel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIxLTA5LTAzIGF0IDA5OjEyICswMzAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
DQo+IE9uIEZyaSwgMjAyMS0wOC0yNyBhdCAxMjo1NSAtMDcwMCwgVG9ueSBMdWNrIHdyb3RlOg0K
PiA+ICsjaWZkZWYgQ09ORklHX1g4Nl9TR1gNCj4gPiAraW50IHNneF9tZW1vcnlfZmFpbHVyZSh1
bnNpZ25lZCBsb25nIHBmbiwgaW50IGZsYWdzKTsNCj4gPiArYm9vbCBzZ3hfaXNfZXBjX3BhZ2Uo
dTY0IHBhZGRyKTsNCj4gPiArI2Vsc2UNCj4gPiArc3RhdGljIGlubGluZSBpbnQgc2d4X21lbW9y
eV9mYWlsdXJlKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3MpDQo+ID4gK3sNCj4gPiArCXJl
dHVybiAtRU5YSU87DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbmxpbmUgYm9vbCBzZ3hf
aXNfZXBjX3BhZ2UodTY0IHBhZGRyKQ0KPiA+ICt7DQo+ID4gKwlyZXR1cm4gZmFsc2U7DQo+ID4g
K30NCj4gPiArI2VuZGlmDQo+IA0KPiBUaGVzZSBkZWNsJ3Mgc2hvdWxkIGJlIGluIGFyY2gveDg2
L2luY2x1ZGUvYXNtL3NneC5oLCBhbmQgYXMgcGFydCBvZg0KPiBwYXRjaCB0aGF0IGNvbnRhaW5z
IHRoZSBpbXBsZW1lbnRhdGlvbnMuDQoNCkJ1dCBJIG5lZWQgdG8gdXNlIHRoZXNlIGZ1bmN0aW9u
cyBpbiBhcmNoIGluZGVwZW5kZW50IGNvZGUuICBTcGVjaWZpY2FsbHkgaW4NCm1tL21lbW9yeS1m
YWlsdXJlLmMgYW5kIGRyaXZlcnMvYWNwaS9hcGVpL2VpbmouYw0KDQpJZiBJIGp1c3QgI2luY2x1
ZGUgPGFzbS9zZ3guaD4gaW4gdGhvc2UgZmlsZXMgSSdsbCBicmVhayB0aGUgYnVpbGQgZm9yIG90
aGVyDQphcmNoaXRlY3R1cmVzLg0KDQotVG9ueQ0K
