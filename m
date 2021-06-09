Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1493A210D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 01:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhFIX5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 19:57:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:6472 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFIX5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 19:57:32 -0400
IronPort-SDR: 3c7LDz8qZccAM9oR0bN4w1zM32yK2Be9Lkn1qjQgX7I9LYmUoYWdiGFW/kNMVHUi58A3CqvVW7
 OSrCFFKYkS7w==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="290825124"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="290825124"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 16:55:36 -0700
IronPort-SDR: KauKf6IsPc5n6KYQ0P6qvuqbJzjDfmwTwpjnLEF9LUs+zWCr8Ol+FJc8h97EtbfnrGS3Y2Tt9+
 hHAU6EKOERqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="441006589"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 09 Jun 2021 16:55:36 -0700
Received: from shsmsx601.ccr.corp.intel.com (10.109.6.141) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 9 Jun 2021 16:55:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 SHSMSX601.ccr.corp.intel.com (10.109.6.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 10 Jun 2021 07:55:32 +0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.008;
 Wed, 9 Jun 2021 16:55:30 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>, lkp <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: RE: arch/x86/lib/copy_mc.c:30:1: warning: no previous prototype for
 'copy_mc_fragile_handle_tail'
Thread-Topic: arch/x86/lib/copy_mc.c:30:1: warning: no previous prototype for
 'copy_mc_fragile_handle_tail'
Thread-Index: AQHXXYDpRWvCGEUFekCEZ2tmEUfop6sMzNGA//+M3QA=
Date:   Wed, 9 Jun 2021 23:55:30 +0000
Message-ID: <10c9fdc0ace04013b7d4999643aa8b21@intel.com>
References: <202106100613.JQBEtsqj-lkp@intel.com>
 <CAPcyv4jAkutNExqao0Q1HYL-pQxrSbAN3F5N9Uj=09KDa_uynw@mail.gmail.com>
In-Reply-To: <CAPcyv4jAkutNExqao0Q1HYL-pQxrSbAN3F5N9Uj=09KDa_uynw@mail.gmail.com>
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

PiBUaGlzIHJvdXRpbmUgaXMgb25seSBldmVyIGNhbGxlZCBmcm9tIEFTTSBjb2RlLCBzbyB0aGUg
ZmFjdCB0aGF0IHRoZXJlDQo+IGlzIG5vIEMgZGVjbGFyYXRpb24gaXMgZXhwZWN0ZWQuDQoNCkRv
ZXMgdGhlIGFzbSBjb2RlIHJlYWxseSBuZWVkIHRvIGNhbGwgYmFjayBpbnRvIEM/DQoNCkNvdWxk
IHlvdSBqdXN0IGhhdmUgdGhlIGFzbSBjb2RlIGRvICJqbXAgLkxfcmVhZF90cmFpbGluZ19ieXRl
cyIgKG1pZ2h0IG5lZWQgdG8gb25seSBkbyB0aGF0IGlmICVlY3ggaXMgbm9uLXplcm8pPw0KDQot
VG9ueQ0K
