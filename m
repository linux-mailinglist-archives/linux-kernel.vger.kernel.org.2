Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CEF3D6BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 04:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbhG0B1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 21:27:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:18113 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233731AbhG0B1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 21:27:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="297925996"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="297925996"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2021 19:08:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="417250517"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 26 Jul 2021 19:08:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 26 Jul 2021 19:08:03 -0700
Received: from irsmsx605.ger.corp.intel.com (163.33.146.138) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 26 Jul 2021 19:08:01 -0700
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138]) by
 IRSMSX605.ger.corp.intel.com ([163.33.146.138]) with mapi id 15.01.2242.010;
 Tue, 27 Jul 2021 03:08:00 +0100
From:   "Sakkinen, Jarkko" <jarkko.sakkinen@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "seanjc@google.com" <seanjc@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2 3/6] x86/sgx: Initial poison handling for dirty and
 free pages
Thread-Topic: [PATCH v2 3/6] x86/sgx: Initial poison handling for dirty and
 free pages
Thread-Index: AQHXfMq7VFyT7WBRK0qaGvBwrj/wr6tWDhiA
Date:   Tue, 27 Jul 2021 02:08:00 +0000
Message-ID: <f22ff4d1aa1240c6cb30db5c35d52ef49b2f6914.camel@intel.com>
References: <20210708181423.1312359-1-tony.luck@intel.com>
         <20210719182009.1409895-1-tony.luck@intel.com>
         <20210719182009.1409895-4-tony.luck@intel.com>
In-Reply-To: <20210719182009.1409895-4-tony.luck@intel.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EFE34ACADA57B4BAE06C09326ACBC31@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTA3LTE5IGF0IDExOjIwIC0wNzAwLCBUb255IEx1Y2sgd3JvdGU6DQo+ICsJ
ZGlyID0gZGVidWdmc19jcmVhdGVfZGlyKCJzZ3giLCBOVUxMKTsNCj4gKwlkZWJ1Z2ZzX2NyZWF0
ZV91MzIoInBvaXNvbl9wYWdlX2NvdW50IiwgMDQwMCwgZGlyLCAmcG9pc29uX3BhZ2VfY291bnQp
Ow0KPiArCWRlYnVnZnNfY3JlYXRlX2ZpbGUoInBvaXNvbl9wYWdlX2xpc3QiLCAwNDAwLCBkaXIs
IE5VTEwsICZwb2lzb25fbGlzdF9mb3BzKTsNCg0KSSdtIGFkZGluZyBkZWJ1Z2ZzIGF0dHJpYnV0
ZXMgaW4gbXkgcmVjbGFpbWVyIGtzZWxmdGVzdCBwYXRjaA0Kc2V0LiBUaGUgZmVlZGJhY2sgdGhh
dCBJIGdvdCBmcm9tIEJvcmlzIGZvciB0aGF0IGlzIHRoYXQgdGhlc2UNCm11c3QgYmUgZG9jdW1l
bnRlZCBpbiBEb2N1bWVudGF0aW9uL3g4Ni9zZ3gucnN0Lg0KDQovSmFya2tvDQo=
