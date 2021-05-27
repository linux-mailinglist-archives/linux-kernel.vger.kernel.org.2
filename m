Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733FC393265
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbhE0P0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:26:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:51115 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235017AbhE0P0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:26:52 -0400
IronPort-SDR: WSPuou58lZto3/lIXv+rbk171bVf3o1DMH33ZmhzzW5PeLh6C+3eXNiYFLwMESUdepFkezyfZf
 /3WJbrJ6SnOg==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="263960612"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="263960612"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 08:25:18 -0700
IronPort-SDR: EyDJ59j1DX/f1fMCKGVOYC6j18om8AfkLU7eIDiIjUrWwxAmdBTeRrCDPlD9eS9UbTAStNpYoP
 lC1OoEaQDZRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="472559815"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by FMSMGA003.fm.intel.com with ESMTP; 27 May 2021 08:25:17 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 27 May 2021 08:25:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 27 May 2021 08:25:16 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.008;
 Thu, 27 May 2021 08:25:16 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC v2-fix-v2 1/1] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Thread-Topic: [RFC v2-fix-v2 1/1] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
Thread-Index: AQHXUo+HGWahrGi/A0SEFraSQ6BB26r3cj8A
Date:   Thu, 27 May 2021 15:25:16 +0000
Message-ID: <974d8050cb974d6d80b0033e4b9fd0bf@intel.com>
References: <77545da6-d534-e4c2-a60b-085705e3f0b7@linux.intel.com>
 <20210527003033.3632700-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210527003033.3632700-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

PiBHdWVzdHMgY29tbXVuaWNhdGUgd2l0aCBWTU1zIHdpdGggaHlwZXJjYWxscy4gSGlzdG9yaWNh
bGx5LCB0aGVzZQ0KPiBhcmUgaW1wbGVtZW50ZWQgdXNpbmcgaW5zdHJ1Y3Rpb25zIHRoYXQgYXJl
IGtub3duIHRvIGNhdXNlIFZNRVhJVHMNCj4gbGlrZSB2bWNhbGwsIHZtbGF1bmNoLCBldGMuIEhv
d2V2ZXIsIHdpdGggVERYLCBWTUVYSVRzIG5vIGxvbmdlcg0KPiBleHBvc2UgZ3Vlc3Qgc3RhdGUg
dG8gdGhlIGhvc3QuIMKgVGhpcyBwcmV2ZW50cyB0aGUgb2xkIGh5cGVyY2FsbA0KPiBtZWNoYW5p
c21zIGZyb20gd29ya2luZy4gU28gdG8gY29tbXVuaWNhdGUgd2l0aCBWTU0sIFREWA0KPiBzcGVj
aWZpY2F0aW9uIGRlZmluZXMgYSBuZXcgaW5zdHJ1Y3Rpb24gY2FsbGVkICJ0ZGNhbGwiLg0KDQpZ
b3UgdXNlIGFsbCBjYXBzIFREQ0FMTCBldmVyeXdoZXJlIGVsc2UgaW4gdGhpcyBjb21taXQgbWVz
c2FnZS4NCkxvb2tzIG9kZCB0byBoYXZlIHF1b3RlZCBsb3dlciBjYXNlIGhlcmUuDQoNCj4gSW4g
YSBURFggYmFzZWQgVk0sIHNpbmNlIFZNTSBpcyBhbiB1bnRydXN0ZWQgZW50aXR5LCBhIGludGVy
bWVkaWFyeQ0KPiBsYXllciAoVERYIG1vZHVsZSkgZXhpc3RzIGJldHdlZW4gaG9zdCBhbmQgZ3Vl
c3QgdG8gZmFjaWxpdGF0ZSB0aGUNCj4gc2VjdXJlIGNvbW11bmljYXRpb24uIFREWCBndWVzdHMg
Y29tbXVuaWNhdGUgd2l0aCB0aGUgVERYIG1vZHVsZSBhbmQNCj4gd2l0aCB0aGUgVk1NIHVzaW5n
IGEgbmV3IGluc3RydWN0aW9uOiBURENBTEwuDQoNClNlZW1zIGJvdGggcmVwZWF0IHdoYXQgd2Fz
IGluIHRoZSBmaXJzdCBwYXJhZ3JhcGgsIGJ1dCBhbHNvIGZhaWwgdG8NCmV4cGxhaW4gaG93IHRo
aXMgVERDQUxMIGlzIGRpZmZlcmVudCBmcm9tIHRoYXQgZmlyc3QgVERDQUxMLg0KDQo+IEltcGxl
bWVudCBjb21tb24gaGVscGVyIGZ1bmN0aW9ucyB0byBjb21tdW5pY2F0ZSB3aXRowqB0aGUgVERY
IE1vZHVsZQ0KPiBhbmQgVk1NICh1c2luZyBURENBTEwgaW5zdHJ1Y3Rpb24pLg0KPsKgIMKgDQo+
IF9fdGR4X2h5cGVyY2FsbCgpICAgIC0gcmVxdWVzdCBzZXJ2aWNlc8KgZnJvbSB0aGUgVk1NLg0K
PiBfX3RkeF9tb2R1bGVfY2FsbCgpwqAgLSBjb21tdW5pY2F0ZSB3aXRoIHRoZSBURFggTW9kdWxl
Lg0KDQpMb29raW5nIGF0IHRoZSBjb2RlLCB0aGUgaHlwZXJjYWxsIGNhbiByZXR1cm4gYW4gZXJy
b3IgaWYgVERDQUxMIGZhaWxzLA0KYnV0IG1vZHVsZV9jYWxsIGZvcmNlcyBhIHBhbmljIHdpdGgg
VUQyIG9uIGVycm9yLiBUaGlzIGRpZmZlcmVuY2UgaXNuJ3QNCmV4cGxhaW5lZCBhbnl3aGVyZS4N
Cg0KLVRvbnkNCg==
