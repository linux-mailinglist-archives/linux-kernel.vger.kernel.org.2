Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C631F402B4A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbhIGPEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:04:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:39972 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231362AbhIGPEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:04:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="218358797"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="218358797"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 08:03:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="580001976"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 07 Sep 2021 08:03:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 7 Sep 2021 08:03:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 7 Sep 2021 08:03:03 -0700
Received: from orsmsx610.amr.corp.intel.com ([10.22.229.23]) by
 ORSMSX610.amr.corp.intel.com ([10.22.229.23]) with mapi id 15.01.2242.012;
 Tue, 7 Sep 2021 08:03:03 -0700
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
Thread-Index: AQHXm32N+zFqinyIzkeTnR6PEPyjK6uSU9kAgAAMBgCABQikEIABuSsA//+Z1mA=
Date:   Tue, 7 Sep 2021 15:03:03 +0000
Message-ID: <40da1a9a7d5f41bb9b82ea2cbebce73a@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
         <20210827195543.1667168-1-tony.luck@intel.com>
         <20210827195543.1667168-6-tony.luck@intel.com>
         <49fccddbbf92279f575409851a9c682495146ad8.camel@kernel.org>
         <681d530d72de842c8bf43733c11f3c3f2ebf8c6e.camel@kernel.org>
         <25db682402d14c34af9ba525cffe85c5@intel.com>
 <848905ffa20cf234446b16682cbbcf1e56853950.camel@kernel.org>
In-Reply-To: <848905ffa20cf234446b16682cbbcf1e56853950.camel@kernel.org>
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

Pj4gSWYgSSBqdXN0ICNpbmNsdWRlIDxhc20vc2d4Lmg+IGluIHRob3NlIGZpbGVzIEknbGwgYnJl
YWsgdGhlIGJ1aWxkIGZvciBvdGhlcg0KPj4gYXJjaGl0ZWN0dXJlcy4NCj4NCj4gV2hhdCBkb2Vz
IHNwZWNpZmljYWxseSBicmVhayB0aGUgYnVpbGQ/DQoNClRoZXJlIGlzIG5vIGZpbGUgbmFtZWQg
YXJjaC9hcm0vaW5jbHVkZS9hc20vc2d4LmggKGRpdHRvIGZvciBvdGhlciBhcmNoaXRlY3R1cmVz
IHRoYXQgYnVpbGQgbWVtb3J5LWZhaWx1cmUuYyBhbmQgZWluai5jKS4NCg0KLVRvbnkNCg==
