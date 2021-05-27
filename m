Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290773931ED
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236818AbhE0PNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:13:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:7742 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235788AbhE0PNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:13:17 -0400
IronPort-SDR: rFOpIZAjulkoxkUCb/xjyprmE0xl0UZwWNDdSxVd/cNouFKr4uUKKEJYV5BAh5V2rdSqVRaAK3
 cOKHg0Rie47w==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="189874220"
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="189874220"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 08:11:43 -0700
IronPort-SDR: BgOMcABKIZdORcGngE+VqtcGU6XWGjfAObj/GZoywWZVmrdGJW6CCKZIqaiXefMz2+hhtTAkrz
 a8hiEijxJITA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,334,1613462400"; 
   d="scan'208";a="615414621"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2021 08:11:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 27 May 2021 08:11:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 27 May 2021 08:11:41 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.008;
 Thu, 27 May 2021 08:11:41 -0700
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
Subject: RE: [RFC v2-fix-v2 1/1] x86/traps: Add #VE support for TDX guest
Thread-Topic: [RFC v2-fix-v2 1/1] x86/traps: Add #VE support for TDX guest
Thread-Index: AQHXUo9kTyoWo9U3B0GfnhhWUgZVJqr3bxyg
Date:   Thu, 27 May 2021 15:11:41 +0000
Message-ID: <636067f3ed65429ab1094b851aae5256@intel.com>
References: <4031ffc2-a442-5da7-e793-ac1053533bb3@linux.intel.com>
 <20210527002931.3632581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20210527002931.3632581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
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

K3N0cnVjdCB2ZV9pbmZvIHsNCisJdTY0IGV4aXRfcmVhc29uOw0KKwl1NjQgZXhpdF9xdWFsOw0K
Kwl1NjQgZ2xhOw0KKwl1NjQgZ3BhOw0KKwl1MzIgaW5zdHJfbGVuOw0KKwl1MzIgaW5zdHJfaW5m
bzsNCit9Ow0KDQpJIGd1ZXNzIHRoYXQgImdsYSIgPSBHdWVzdCBMaW5lYXIgQWRkcmVzcyAuLi4g
d2hpY2ggaXMgYSB2ZXJ5ICJJbnRlbCIgd2F5IG9mDQpkZXNjcmliaW5nIHdoYXQgZXZlcnlvbmUg
ZWxzZSB3b3VsZCBjYWxsIGEgR3Vlc3QgVmlydHVhbCBBZGRyZXNzLg0KDQpJIGRvbid0IGZlZWwg
c3Ryb25nbHkgYWJvdXQgdGhpcyB0aG91Z2guIElmIHRoaXMgaGFzIGFscmVhZHkgYmVlbiBoYXNo
ZWQNCm91dCBhbHJlYWR5IHRoZW4gc3RpY2sgd2l0aCB0aGlzIG5hbWUuDQoNCk90aGVyd2lzZToN
Cg0KUmV2aWV3ZWQtYnk6IFRvbnkgTHVjayA8dG9ueS5sdWNrQGludGVsLmNvbT4NCg0KLVRvbnkN
Cg==
