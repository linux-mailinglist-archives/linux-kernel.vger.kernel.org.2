Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC43C402DEC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhIGRsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:48:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:7371 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhIGRsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:48:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="305835430"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="305835430"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 10:46:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="605362112"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 07 Sep 2021 10:46:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 7 Sep 2021 10:46:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 7 Sep 2021 10:46:53 -0700
Received: from orsmsx610.amr.corp.intel.com ([10.22.229.23]) by
 ORSMSX610.amr.corp.intel.com ([10.22.229.23]) with mapi id 15.01.2242.012;
 Tue, 7 Sep 2021 10:46:53 -0700
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
Thread-Index: AQHXm32N+zFqinyIzkeTnR6PEPyjK6uSU9kAgAAMBgCABQikEIABuSsA//+Z1mCAAHdJgP//tWJA
Date:   Tue, 7 Sep 2021 17:46:53 +0000
Message-ID: <e0280b82cf964a0797293b0c8e302777@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
         <20210827195543.1667168-1-tony.luck@intel.com>
         <20210827195543.1667168-6-tony.luck@intel.com>
         <49fccddbbf92279f575409851a9c682495146ad8.camel@kernel.org>
         <681d530d72de842c8bf43733c11f3c3f2ebf8c6e.camel@kernel.org>
         <25db682402d14c34af9ba525cffe85c5@intel.com>
         <848905ffa20cf234446b16682cbbcf1e56853950.camel@kernel.org>
         <40da1a9a7d5f41bb9b82ea2cbebce73a@intel.com>
 <250de8f97efe2458afc39f080c3ef6a55f42623c.camel@kernel.org>
In-Reply-To: <250de8f97efe2458afc39f080c3ef6a55f42623c.camel@kernel.org>
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

PiBXb3VsZCBpdCBiZSB0b28gb2Jub3hpb3VzIHRvIGZsYWcgdGhhdCBpbmNsdWRlIGluIHRob3Nl
IGZpbGVzPw0KDQpKYXJra28sDQoNCllvdSBtZWFuOg0KDQojaWZkZWYgQ09ORklHX1g4Nl9TR1gN
CiNpbmNsdWRlIDxhc20vc2d4Lmg+DQojZW5kaWYNCg0KaW4gbW0vbWVtb3J5LWZhaWx1cmUuaD8N
Cg0KVGhhdCB3b3VsZG4ndCBoZWxwLiBJIG5lZWQgdGhlIGRvLW5vdGhpbmcgc3R1YiBkZWZpbml0
aW9uIG9uIG90aGVyIGFyY2hpdGVjdHVyZXMuDQoNCkknbSBnb2luZyB0byBleHBsb3JlIERhdmUn
cyBzdWdnZXN0aW9uIG9mIGNoYW5naW5nIHRoZSBuYW1lcyB0byBzb21ldGhpbmcgbGVzcyBzZ3gg
c3BlY2lmaWMuDQoNCi1Ub255DQo=
