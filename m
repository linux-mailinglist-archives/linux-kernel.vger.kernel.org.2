Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0126B3933AB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbhE0Q1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:27:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:52113 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229696AbhE0Q1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:27:18 -0400
IronPort-SDR: LzGqo17ynzD7b7JnFsSkzGJCBxWY8ANeEKFA/L0ePUHWSM3+JiexFxbjndMcNZvr3zrywkEzby
 yn7c/Zy2yCXg==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="182433251"
X-IronPort-AV: E=Sophos;i="5.83,227,1616482800"; 
   d="scan'208";a="182433251"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 09:25:43 -0700
IronPort-SDR: NSijAumnIAB9t0qJ6jjwzCEiXkzJXsTPSIn90BqWLX8cTAz5HG1r9M+GmNTPlnPIgpuFwxrZ9k
 sP4IcQ9V6ezQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,227,1616482800"; 
   d="scan'208";a="398260081"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 27 May 2021 09:25:43 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 27 May 2021 09:25:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 27 May 2021 09:25:42 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.008;
 Thu, 27 May 2021 09:25:42 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Kuppuswamy, Sathyanarayanan" 
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
Thread-Index: AQHXUo+HGWahrGi/A0SEFraSQ6BB26r3cj8AgAB+koD//5Lc8A==
Date:   Thu, 27 May 2021 16:25:42 +0000
Message-ID: <a40602af50a2473a9260dc0af9a9fd6e@intel.com>
References: <77545da6-d534-e4c2-a60b-085705e3f0b7@linux.intel.com>
 <20210527003033.3632700-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <974d8050cb974d6d80b0033e4b9fd0bf@intel.com>
 <e644695a-849e-53d6-f84a-4fcb84988911@linux.intel.com>
In-Reply-To: <e644695a-849e-53d6-f84a-4fcb84988911@linux.intel.com>
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

Pj4gTG9va2luZyBhdCB0aGUgY29kZSwgdGhlIGh5cGVyY2FsbCBjYW4gcmV0dXJuIGFuIGVycm9y
IGlmIFREQ0FMTCBmYWlscywNCj4+IGJ1dCBtb2R1bGVfY2FsbCBmb3JjZXMgYSBwYW5pYyB3aXRo
IFVEMiBvbiBlcnJvci4gVGhpcyBkaWZmZXJlbmNlIGlzbid0DQo+PiBleHBsYWluZWQgYW55d2hl
cmUuDQo+DQo+IEkgdGhpbmsgeW91IG1lYW50IGh5cGVyY2FsbCB3aWxsIHBhbmljIHZzIG1vZHVs
ZSBjYWxsIHdpbGwgbm90Lg0KDQp5ZXMNCg0KPiBJbiBoeXBlcmNhbGwgY2FzZSwgc2luY2Ugd2Ug
dXNlIHNhbWUgVERDQUxMIGluc3RydWN0aW9uLCB3ZSB3aWxsIGhhdmUgdHdvDQo+IHJldHVybiB2
YWx1ZXMuIE9uZSBpcyBmb3IgVERDQUxMIGZhaWx1cmUgKGF0IHRoZSBURFggbW9kdWxlIGxldmVs
KSBhbmQNCj4gb3RoZXIgaXMgcmV0dXJuIHZhbHVlIGZyb20gVk1NLiBTbyBpbiBoeXBlcmNhbGwg
Y2FzZSwgd2UgcmV0dXJuIFZNTSB2YWx1ZQ0KPiB0byB0aGUgdXNlciBidXQgcGFuaWMgZm9yIFRE
Q0FMTCBmYWlsdXJlcy4gQXMgcGVyIFREWCBzcGVjLCBmb3IgaHlwZXJjYWxsDQo+IHVzZSBjYXNl
LCBpZiBldmVyeXRoaW5nIGlzIGluIG9yZGVyLCBURENBTEwgd2lsbCBuZXZlciBmYWlsLiBJZiB3
ZSBub3RpY2UNCj4gVERDQUxMIGZhaWx1cmUgZXJyb3IgdGhlbiBpdCBtZWFucywgd2UgYXJlIHdv
cmtpbmcgd2l0aCB0aGUgYnJva2VuIFREWCBtb2R1bGUuDQo+IFNvIHdlIHBhbmljLg0KDQpBZGQg
YSBjb21tZW50IGluIHRoZSAuUyBmaWxlIHJpZ2h0IGJlZm9yZSB0aGF0IHVkMiBleHBsYWluaW5n
IHRoaXMuIFRoYXQNCnNob3VsZCBoZWxwIGFueW9uZSB0cmFja2luZyBkb3duIHRoYXQgcGFuaWMg
dW5kZXJzdGFuZCB0aGF0IHRoZSBwcm9ibGVtDQppcyBpbiB0aGUgVERYIG1vZHVsZS4NCg0KT3Ro
ZXJ3aXNlIGxvb2tzIG9rLg0KDQpSZXZpZXdlZC1ieTogVG9ueSBMdWNrIDx0b255Lmx1Y2tAaW50
ZWwuY29tPg0KDQotVG9ueQ0K
