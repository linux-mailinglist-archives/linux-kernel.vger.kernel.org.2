Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711023FDDFB
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 16:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhIAOuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 10:50:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:46629 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229748AbhIAOuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 10:50:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="304345466"
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="304345466"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 07:49:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="476209028"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 01 Sep 2021 07:48:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 1 Sep 2021 07:48:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 1 Sep 2021 07:48:54 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.010;
 Wed, 1 Sep 2021 07:48:54 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "Zhang, Cathy" <cathy.zhang@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 0/6] Basic recovery for machine checks inside SGX
Thread-Topic: [PATCH v4 0/6] Basic recovery for machine checks inside SGX
Thread-Index: AQHXm32MyPf8RXAnE0Sr1W4mUEjgwauO6mmAgABfXfA=
Date:   Wed, 1 Sep 2021 14:48:54 +0000
Message-ID: <febb021cc72140509cc47a89ce14dd09@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
         <20210827195543.1667168-1-tony.luck@intel.com>
 <bc4503dafe26269876057701ad6342bff73cbc45.camel@kernel.org>
In-Reply-To: <bc4503dafe26269876057701ad6342bff73cbc45.camel@kernel.org>
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

PiBXb3VsZCBiZSBuaWNlIHRvIGdldCB0aGlzIGFsc28gdG8gbGludXgtc2d4QHZnZXIua2VybmVs
Lm9yZyBpbg0KPiBmdXR1cmUuDQoNCldpbGwgYWRkIHRvIGxpc3QgZm9yIG5leHQgdmVyc2lvbi4N
Cg0KVGhhbmtzDQoNCi1Ub255DQo=
