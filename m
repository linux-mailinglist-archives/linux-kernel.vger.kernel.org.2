Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585A04031FF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 02:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344861AbhIHBAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 21:00:20 -0400
Received: from mga03.intel.com ([134.134.136.65]:8423 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232947AbhIHBAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 21:00:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="220408039"
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="220408039"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 17:59:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="503304251"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga008.fm.intel.com with ESMTP; 07 Sep 2021 17:59:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 7 Sep 2021 17:59:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 7 Sep 2021 17:59:10 -0700
Received: from orsmsx610.amr.corp.intel.com ([10.22.229.23]) by
 ORSMSX610.amr.corp.intel.com ([10.22.229.23]) with mapi id 15.01.2242.012;
 Tue, 7 Sep 2021 17:59:10 -0700
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
Thread-Index: AQHXm32N+zFqinyIzkeTnR6PEPyjK6uSU9kAgAAMBgCABQikEIABuSsA//+Z1mCAAHdJgP//tWJAgAB3/pA=
Date:   Wed, 8 Sep 2021 00:59:10 +0000
Message-ID: <9ee70d2db97c4f719fd23d68741069db@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
         <20210827195543.1667168-1-tony.luck@intel.com>
         <20210827195543.1667168-6-tony.luck@intel.com>
         <49fccddbbf92279f575409851a9c682495146ad8.camel@kernel.org>
         <681d530d72de842c8bf43733c11f3c3f2ebf8c6e.camel@kernel.org>
         <25db682402d14c34af9ba525cffe85c5@intel.com>
         <848905ffa20cf234446b16682cbbcf1e56853950.camel@kernel.org>
         <40da1a9a7d5f41bb9b82ea2cbebce73a@intel.com>
 <250de8f97efe2458afc39f080c3ef6a55f42623c.camel@kernel.org>
 <e0280b82cf964a0797293b0c8e302777@intel.com>
In-Reply-To: <e0280b82cf964a0797293b0c8e302777@intel.com>
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

PiBJJ20gZ29pbmcgdG8gZXhwbG9yZSBEYXZlJ3Mgc3VnZ2VzdGlvbiBvZiBjaGFuZ2luZyB0aGUg
bmFtZXMgdG8gc29tZXRoaW5nIGxlc3Mgc2d4IHNwZWNpZmljLg0KDQpTbyBub3cgSSBoYXZlIHRo
ZSB0d28gZnVuY3Rpb25zIHJlbmFtZWQgdG8NCg0KCWFyY2hfbWVtb3J5X2ZhaWx1cmUoKSBhbmQg
YXJjaF9pc19wbGF0Zm9ybV9wYWdlKCkNCg0KaW4gYXJjaC94ODYva2VybmVsL2NwdS9zZ3gvbWFp
bi5jDQoNCkluIGFyY2gveDg2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oDQoNCisjaWZkZWYgQ09O
RklHX1g4Nl9TR1gNCitpbnQgYXJjaF9tZW1vcnlfZmFpbHVyZSh1bnNpZ25lZCBsb25nIHBmbiwg
aW50IGZsYWdzKTsNCisjZGVmaW5lIGFyY2hfbWVtb3J5X2ZhaWx1cmUgYXJjaF9tZW1vcnlfZmFp
bHVyZQ0KKw0KK2Jvb2wgYXJjaF9pc19wbGF0Zm9ybV9wYWdlKHU2NCBwYWRkcik7DQorI2RlZmlu
ZSBhcmNoX2lzX3BsYXRmb3JtX3BhZ2UgYXJjaF9pc19wbGF0Zm9ybV9wYWdlDQorI2VuZGlmDQoN
CmFuZCBpbiBpbmNsdWRlL2xpbnV4L21tLmgNCg0KKyNpZm5kZWYgYXJjaF9tZW1vcnlfZmFpbHVy
ZQ0KK3N0YXRpYyBpbmxpbmUgaW50IGFyY2hfbWVtb3J5X2ZhaWx1cmUodW5zaWduZWQgbG9uZyBw
Zm4sIGludCBmbGFncykNCit7DQorICAgICAgIHJldHVybiAtRU5YSU87DQorfQ0KKyNlbmRpZg0K
KyNpZm5kZWYgYXJjaF9pc19wbGF0Zm9ybV9wYWdlDQorc3RhdGljIGlubGluZSBib29sIGFyY2hf
aXNfcGxhdGZvcm1fcGFnZSh1NjQgcGFkZHIpDQorew0KKyAgICAgICByZXR1cm4gZmFsc2U7DQor
fQ0KKyNlbmRpZg0KDQpEYXZlOiBJcyB0aGF0IHdoYXQgeW91IHdhbnRlZD8gIElmIHNvIEkgY2Fu
IGZvbGQgdGhlc2UgYml0cyBiYWNrIGludG8gdGhlDQphcHByb3ByaWF0ZSBiaXRzIG9mIHRoZSBz
ZXJpZXMuIEFkZHJlc3Mgb3RoZXIgY29tbWVudHMuIGFuZCBwb3N0IHY1Lg0KDQpTZWFuOiBJZiB5
b3UgaGF2ZSBzdHVmZiB0aGF0IG5lZWRzIGF0dGVudGlvbiBpbiB2NCBwbGVhc2UgaG9sbGVyIHNv
b24uDQoNCi1Ub255DQo=
