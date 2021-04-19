Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A25364D3A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 23:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239959AbhDSVmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 17:42:08 -0400
Received: from mga09.intel.com ([134.134.136.24]:56056 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229730AbhDSVmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 17:42:07 -0400
IronPort-SDR: zTCKSNs6jnDwEOexzO975KZ30GGrbF+OQzflbNtC5tFpkpQ2fc4ECLmtKN96zDWEby3EiPapDp
 XarMYa4EDFSw==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="195517144"
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="195517144"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 14:41:36 -0700
IronPort-SDR: 2OaWIEUTmIJ3M608awv7e3D6e1gst7R6pksFyVlL4qqweW8Y1OCkGrw8ATD4OMHBwlC52A7tRv
 rrgPYaIlslEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="454483187"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 19 Apr 2021 14:41:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Apr 2021 14:41:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Apr 2021 14:41:34 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2106.013;
 Mon, 19 Apr 2021 14:41:34 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jue Wang <juew@google.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "yaoaili@kingsoft.com" <yaoaili@kingsoft.com>
Subject: RE: [PATCH 4/4] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Topic: [PATCH 4/4] x86/mce: Avoid infinite loop for copy from user
 recovery
Thread-Index: AQHXNWL5puxasW7m1UqRuKa2ceHC8qq8XBRA
Date:   Mon, 19 Apr 2021 21:41:33 +0000
Message-ID: <c2241025107a4f168070348b21d7bb78@intel.com>
References: <CAPcxDJ6SgSagJrF7u576WUb6p7Hg7+beYVoCpJ86Ocsb-mCHmQ@mail.gmail.com>
In-Reply-To: <CAPcxDJ6SgSagJrF7u576WUb6p7Hg7+beYVoCpJ86Ocsb-mCHmQ@mail.gmail.com>
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

Pj4gQnV0IHRoZXJlIGFyZSBwbGFjZXMgaW4gdGhlIGtlcm5lbCB3aGVyZSB0aGUgY29kZSBhc3N1
bWVzIHRoYXQgdGhpcw0KPj4gRUZBVUxUIHJldHVybiB3YXMgc2ltcGx5IGJlY2F1c2Ugb2YgYSBw
YWdlIGZhdWx0LiBUaGUgY29kZSB0YWtlcyBzb21lDQo+PiBhY3Rpb24gdG8gZml4IHRoYXQsIGFu
ZCB0aGVuIHJldHJpZXMgdGhlIGFjY2Vzcy4gVGhpcyByZXN1bHRzIGluIGEgc2Vjb25kDQo+PiBt
YWNoaW5lIGNoZWNrLg0KPg0KPiBXaGF0IGFib3V0IHJldHVybiBFSFdQT0lTT04gaW5zdGVhZCBv
ZiBFRkFVTFQgYW5kIHVwZGF0ZSB0aGUgY2FsbGVycw0KPiB0byBoYW5kbGUgRUhXUE9JU09OIGV4
cGxpY2l0bHk6IGkuZS4sIG5vdCByZXRyeSBidXQgZ2l2ZSB1cCBvbiB0aGUgcGFnZT8NCg0KVGhh
dCBzZWVtcyBsaWtlIGEgZ29vZCBpZGVhIHRvIG1lLiBCdXQgSSBnb3Qgc29tZSBwdXNoYmFjayB3
aGVuIEkgc3RhcnRlZA0Kb24gdGhpcyBwYXRoIGVhcmxpZXIgd2l0aCBzb21lIHBhdGNoZXMgdG8g
dGhlIGZ1dGV4IGNvZGUuICBCdXQgYmFjayB0aGVuIEkNCndhc24ndCB1c2luZyBlcnJvciByZXR1
cm4gb2YgRUhXUE9JU09OIC4uLiBwb3NzaWJseSB0aGUgY29kZSB3b3VsZCBsb29rDQpsZXNzIGhh
Y2t5IHdpdGggdGhhdCBleHBsaWNpdGx5IGNhbGxlZCBvdXQuDQoNClRoZSBmdXRleCBjYXNlIHdh
cyBzcGVjaWZpY2FsbHkgZm9yIGNvZGUgdXNpbmcgcGFnZWZhdWx0X2Rpc2FibGUoKS4gTGlrZWx5
DQphbGwgdGhlIG90aGVyIGNhbGxlcnMgd291bGQgbmVlZCB0byBiZSBhdWRpdGVkIChidXQgdGhl
cmUgYXJlIG9ubHkgYSBmZXcgZG96ZW4NCnBsYWNlcywgc28gbm90IHRvbyBiaWcgb2YgYSBkZWFs
KS4NCg0KPiBNeSBtYWluIGNvbmNlcm4gaXMgdGhhdCB0aGUgc3Ryb25nIGFzc3VtcHRpb25zIHRo
YXQgdGhlIGtlcm5lbCBjYW4ndCBoaXQgbW9yZQ0KPiB0aGFuIGEgZml4ZWQgbnVtYmVyIG9mIHBv
aXNvbmVkIGNhY2hlIGxpbmVzIGJlZm9yZSB0dXJuaW5nIHRvIHVzZXIgc3BhY2UNCj4gbWF5IHNp
bXBseSBub3QgYmUgdHJ1ZS4NCg0KQWdyZWVkLg0KDQo+IFdoZW4gRElNTSBnb2VzIGJhZCwgaXQg
Y2FuIGVhc2lseSBhZmZlY3QgYW4gZW50aXJlIGJhbmsgb3IgZW50aXJlIHJhbSBkZXZpY2UNCj4g
Y2hpcC4gRXZlbiB3aXRoIG1lbW9yeSBpbnRlcmxlYXZpbmcsIGl0J3MgcG9zc2libGUgdGhhdCBh
IGtlcm5lbCBjb250cm9sIHBhdGgNCj4gdG91Y2hlcyBsb3RzIG9mIHBvaXNvbmVkIGNhY2hlIGxp
bmVzIGluIHRoZSBidWZmZXIgaXQgaXMgd29ya2luZyB0aHJvdWdoLg0KDQpUaGVzZSBsYXJnZXIg
ZmFpbHVyZXMgaGF2ZSBvdGhlciBwcm9ibGVtcyAuLi4gZG96ZW5zIG9mIHVucmVsYXRlZCBwYWdl
cw0KbWF5IGJlIGFmZmVjdGVkLiBJbiBhIHBlcmZlY3Qgd29ybGQgTGludXggd291bGQgYmUgdG9s
ZCBvbiB0aGUgZmlyc3QgZXJyb3INCnRoYXQgdGhpcyBpcyBqdXN0IG9uZSBvZiBtYW55IGVycm9y
cyAuLi4gYW5kIGJlIGdpdmVuIGEgbGlzdC4gQnV0IGluIHRoZSByZWFsDQp3b3JsZCB0aGF0IGlz
bid0IGxpa2VseSB0byBoYXBwZW4gOi0oDQoNCi1Ub255DQo=
