Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B873D9920
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 00:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhG1W5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 18:57:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:16510 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232163AbhG1W5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 18:57:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="192359420"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="192359420"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 15:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="517824202"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jul 2021 15:57:08 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 28 Jul 2021 15:57:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 28 Jul 2021 15:57:07 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.010;
 Wed, 28 Jul 2021 15:57:07 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/7] x86/sgx: Provide indication of life-cycle of EPC
 pages
Thread-Topic: [PATCH v3 1/7] x86/sgx: Provide indication of life-cycle of EPC
 pages
Thread-Index: AQHXg/G3voDWmDqCq06DL34grJaPratZaKWA//+WanA=
Date:   Wed, 28 Jul 2021 22:57:07 +0000
Message-ID: <f2685d7c8dc14792a4e0f9807f742ea6@intel.com>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-2-tony.luck@intel.com>
 <17054ca5-0ef7-4b28-ab26-b1b96aa7403f@intel.com>
In-Reply-To: <17054ca5-0ef7-4b28-ab26-b1b96aa7403f@intel.com>
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

PiBXb3VsZG4ndCBpdCBiZSBzYWZlciB0byBkbyBzb21ldGhpbmcgbGlrZToNCj4NCj4JcGFnZS0+
b3duZXIgPSBvd25lciA/IG93bmVyIDogKHZvaWQgKiktMTsNCj4NCj4gLTEgaXMgbm9uLU5VTEws
IGJ1dCBhbHNvIGludmFsaWQsIHdoaWNoIG1ha2VzIGl0IGhhcmRlciBmb3IgdXMgdG8gcG9rZQ0K
PiBvdXJzZWx2ZXMgaW4gdGhlIGV5ZS4NCg0KRG9lcyBMaW51eCBoYXZlIHNvbWUgI2RlZmluZSBJ
TlZBTElEX1BPSU5URVIgdGhpbmcgdGhhdA0KcHJvdmlkZXMgYSBndWFyYW50ZWVkIGJhZCAoZS5n
LiBub24tY2Fub25pY2FsKSB2YWx1ZT8NCg0KKHZvaWQgKiktMSBzZWVtcyBoYWNreS4NCg0KLVRv
bnkNCg==
