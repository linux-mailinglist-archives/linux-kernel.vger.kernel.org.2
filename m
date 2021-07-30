Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928563DC197
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 01:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbhG3Xfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 19:35:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:23287 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233500AbhG3Xfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 19:35:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10061"; a="200356280"
X-IronPort-AV: E=Sophos;i="5.84,283,1620716400"; 
   d="scan'208";a="200356280"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2021 16:35:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,283,1620716400"; 
   d="scan'208";a="418658230"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 30 Jul 2021 16:35:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 30 Jul 2021 16:35:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 30 Jul 2021 16:35:38 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.010;
 Fri, 30 Jul 2021 16:35:38 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>
CC:     Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: RE: [PATCH v3 2/7] x86/sgx: Add infrastructure to identify SGX EPC
 pages
Thread-Topic: [PATCH v3 2/7] x86/sgx: Add infrastructure to identify SGX EPC
 pages
Thread-Index: AQHXg/G30fZF4uOm90WtR2lkv24P8qtZas0AgAG4/oCAAQ5zgIAAAVyA//+qPoCAAJSLAP//ufVQ
Date:   Fri, 30 Jul 2021 23:35:38 +0000
Message-ID: <259e12df49b9495cb6b326e52c9ffe51@intel.com>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-3-tony.luck@intel.com>
 <141602a3-ef61-01f0-4a3c-69f8e7012fcd@intel.com>
 <20210730003809.hp3nmqmgyysa45nz@kernel.org> <YQQsz/tvrQpqAbpX@google.com>
 <b7b6aabd-1f10-1b21-eaeb-102ead2989cd@intel.com>
 <20210730184400.GA1521057@agluck-desk2.amr.corp.intel.com>
 <c75cf4b5-fe56-54cf-681f-6e5b6b83d0e2@intel.com>
In-Reply-To: <c75cf4b5-fe56-54cf-681f-6e5b6b83d0e2@intel.com>
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

Pgl4YV9zdG9yZV9yYW5nZSgmZXBjX3BhZ2VfcmFuZ2VzLA0KPgkJICAgICAgIHNlY3Rpb24tPnBo
eXNfYWRkciwNCj4JCSAgICAgICBzZWN0aW9uLT5lbmRfcGh5c19hZGRyLCAuLi4pOw0KPg0KPiAu
Li4geW91IGRpZCBpdCBiYXNlZCBvbiBQRk5zOg0KPg0KPgl4YV9zdG9yZV9yYW5nZSgmZXBjX3Bh
Z2VfcmFuZ2VzLA0KPgkJICAgICAgIHNlY3Rpb24tPnBoeXNfYWRkciAgICAgPj4gUEFHRV9TSElG
VCwNCj4JCSAgICAgICBzZWN0aW9uLT5lbmRfcGh5c19hZGRyID4+IFBBR0VfU0hJRlQsIC4uLik7
DQo+DQo+IFNHWCBzZWN0aW9ucyBhcmUgYXQgKmxlYXN0KiBwYWdlLWFsaWduZWQsIHNvIHRoaXMg
c2hvdWxkIGJlIGZpbmUuDQoNCkkgZm91bmQgeGFfZHVtcCgpIChoaWRkZW4gaW5zaWRlICNpZmRl
ZiBYQV9ERUJVRykNCg0KVHJ5aW5nIGJvdGggd2l0aCBhbmQgd2l0aG91dCB0aGUgPj4gUEFHRV9T
SElGVCBtYWRlIG5vIGRpZmZlcmVuY2UNCnRvIHRoZSBudW1iZXIgb2YgbGluZXMgb2YgY29uc29s
ZSBvdXRwdXQgdGhhdCB4YV9kdW1wKCkgc3BpdHMgb3V0Lg0KMjY2IGVpdGhlciB3YXkuDQoNClRo
ZXJlIGFyZSBvbmx5IHR3byByYW5nZXMgb24gdGhpcyBzeXN0ZW0NCg0KWyAgIDExLjkzNzU5Ml0g
c2d4OiBFUEMgc2VjdGlvbiAweDgwMDBjMDAwMDAtMHg4MDdmN2ZmZmZmDQpbICAgMTEuOTQ1ODEx
XSBzZ3g6IEVQQyBzZWN0aW9uIDB4MTAwMDBjMDAwMDAtMHgxMDA3ZmZmZmZmZg0KDQpTbyBJJ20g
YSBsaXR0bGUgYml0IHNhZCB0aGF0IHhhcnJheSBhcHBlYXJzIHRvIGhhdmUgYnJva2VuIHRoZW0g
dXANCmludG8gYSBidW5jaCBvZiBwaWVjZXMuDQoNCi1Ub255DQo=
