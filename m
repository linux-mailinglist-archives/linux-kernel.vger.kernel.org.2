Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1643DF8A2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 01:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbhHCXtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 19:49:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:32391 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234543AbhHCXtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:49:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10065"; a="213844551"
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="213844551"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 16:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,292,1620716400"; 
   d="scan'208";a="670710688"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 03 Aug 2021 16:49:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 3 Aug 2021 16:49:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 3 Aug 2021 16:49:36 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.010;
 Tue, 3 Aug 2021 16:49:36 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "Hansen, Dave" <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v3 2/7] x86/sgx: Add infrastructure to identify SGX EPC
 pages
Thread-Topic: [PATCH v3 2/7] x86/sgx: Add infrastructure to identify SGX EPC
 pages
Thread-Index: AQHXg/G30fZF4uOm90WtR2lkv24P8qtZas0AgAG4/oCAAQ5zgIAAAVyA//+qPoCAAJSLAP//ufVQgAafygD//7BoUA==
Date:   Tue, 3 Aug 2021 23:49:35 +0000
Message-ID: <5B1DB882-124D-4218-9522-760AB69F6A3F@intel.com>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-3-tony.luck@intel.com>
 <141602a3-ef61-01f0-4a3c-69f8e7012fcd@intel.com>
 <20210730003809.hp3nmqmgyysa45nz@kernel.org> <YQQsz/tvrQpqAbpX@google.com>
 <b7b6aabd-1f10-1b21-eaeb-102ead2989cd@intel.com>
 <20210730184400.GA1521057@agluck-desk2.amr.corp.intel.com>
 <c75cf4b5-fe56-54cf-681f-6e5b6b83d0e2@intel.com>
 <259e12df49b9495cb6b326e52c9ffe51@intel.com>,<YQm2ZM9+cWmBFJH7@casper.infradead.org>
In-Reply-To: <YQm2ZM9+cWmBFJH7@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNClNlbnQgZnJvbSBteSBpUGhvbmUNCg0KPiBPbiBBdWcgMywgMjAyMSwgYXQgMTQ6NDcsIE1h
dHRoZXcgV2lsY294DQo+IA0KPiBMaWFtIGFuZCBJIGFyZSB3b3JraW5nIG9uIGEgbmV3IHJlcGxh
Y2VtZW50IGRhdGEgc3RydWN0dXJlIGNhbGxlZCB0aGUNCj4gTWFwbGUgVHJlZSwgYnV0IGl0J3Mg
bm90IHlldCByZWFkeSB0byByZXBsYWNlIHRoZSByYWRpeCB0cmVlIGJhY2sgZW5kLg0KPiBJdCBs
b29rcyBsaWtlIGl0IHdvdWxkIGJlIHBlcmZlY3QgZm9yIHlvdXIgY2FzZTsgdGhlcmUgd291bGQg
YmUgZml2ZQ0KPiBlbnRyaWVzIGluIGl0LCBzdG9yZWQgaW4gb25lIDI1Ni1ieXRlIG5vZGU6DQo+
IA0KPiAgICBOVUxMDQo+IDB4ODAwMGJmZmZmZg0KPiAgICBwMQ0KPiAweDgwN2Y3ZmZmZmYNCj4g
ICAgTlVMTA0KPiAweDEwMDAwYzAwMDAwDQo+ICAgIHAyDQo+IDB4MTAwN2ZmZmZmZmYNCj4gICAg
TlVMTA0KPiAweGZmZmYnZmZmZidmZmZmJ2ZmZmYNCj4gDQo+IEl0IHdvdWxkIGFjdHVhbGx5IHR1
cm4gaW50byBhIGxpbmVhciBzY2FuLCBiZWNhdXNlIHRoYXQncyBqdXN0IHRoZQ0KPiBmYXN0ZXN0
IHdheSB0byBmaW5kIHNvbWV0aGluZyBpbiBhIGxpc3Qgb2YgZml2ZSBlbGVtZW50cy4gIEEgdGhp
cmQNCj4gcmFuZ2Ugd291bGQgdGFrZSB1cyB0byBhIGxpc3Qgb2Ygc2V2ZW4gZWxlbWVudHMsIHdo
aWNoIHN0aWxsIGZpdHMNCj4gaW4gYSBzaW5nbGUgbm9kZS4gIE9uY2Ugd2UgZ2V0IHRvIG1vcmUg
dGhhbiB0aGF0LCB5b3UnZCBoYXZlIGENCj4gdHdvLWxldmVsIHRyZWUsIHdoaWNoIHdvdWxkIHdv
cmsgdW50aWwgeW91IGhhdmUgbW9yZSB0aGFuIH4yMCByYW5nZXMuDQo+IA0KPiBXZSBjb3VsZCBk
byBiZXR0ZXIgZm9yIHlvdXIgY2FzZSBieSBzdG9yaW5nIDEweCAoc3RhcnQsIGVuZCwgcCkgaW4g
ZWFjaA0KPiBsZWFmIG5vZGUsIGJ1dCB3ZSdyZSAoY3VycmVudGx5KSBvcHRpbWlzaW5nIGZvciBW
TUFzIHdoaWNoIHRlbmQgdG8gYmUNCj4gdGlnaHRseSBwYWNrZWQsIG1lYW5pbmcgdGhhdCBhbiBp
bXBsaWNpdCAnc3RhcnQnIGVsZW1lbnQgaXMgYSBiZXR0ZXINCj4gY2hvaWNlIGFzIGl0IGdpdmVz
IHVzIDE1eCAoZW5kLCBwKSBwYWlycy4NCg0KVGhhdOKAmXMgZ29vZCB0byBrbm93LiBXaGlsZSBj
dXJyZW50IHhhcnJheQ0KaW1wbGVtZW50YXRpb24gbWlnaHQgYmUgYSBiaXQgd2FzdGVmdWxbMV0s
DQp0aGluZ3Mgd2lsbCBnZXQgYmV0dGVyLg0KDQpJ4oCZbSBzdGlsbCBnb2luZyB3aXRoIHhhcnJh
eSB0byBrZWVwIHRoZSBzb3VyY2UNCnNpbXBsZS4NCg0KLVRvbnkNCg0KWzFdIEEgZmV3IEtCeXRl
cyBleHRyYSBkb2VzbuKAmXQgZXZlbiBzb3VuZA0KdG9vIHRlcnJpYmxlIHRvIG1hbmFnZSB0ZW5z
IG9mIE1CeXRlcyAob3INCm1vcmUpIG9mIFNHWCBFUEMgbWVtb3J5IG9uIGEgc3lzdGVtDQp3aXRo
IGEgaGFsZiBUQnl0ZSB0b3RhbCBtZW1vcnkuDQoNCg0K
