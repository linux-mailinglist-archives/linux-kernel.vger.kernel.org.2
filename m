Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC8E402B7B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345029AbhIGPPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:15:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:58348 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236041AbhIGPPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:15:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="199754551"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="199754551"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 08:07:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="648079190"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 07 Sep 2021 08:07:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 7 Sep 2021 08:07:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 7 Sep 2021 08:07:13 -0700
Received: from orsmsx610.amr.corp.intel.com ([10.22.229.23]) by
 ORSMSX610.amr.corp.intel.com ([10.22.229.23]) with mapi id 15.01.2242.012;
 Tue, 7 Sep 2021 08:07:13 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sean Christopherson <seanjc@google.com>
CC:     "Zhang, Cathy" <cathy.zhang@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 5/6] x86/sgx: Hook sgx_memory_failure() into mainline
 code
Thread-Topic: [PATCH v4 5/6] x86/sgx: Hook sgx_memory_failure() into mainline
 code
Thread-Index: AQHXm32N+zFqinyIzkeTnR6PEPyjK6uSU9kAgAAMBgCABQikEIABuSsAgAAB0wD//5jIoA==
Date:   Tue, 7 Sep 2021 15:07:13 +0000
Message-ID: <3f3af8cf3f85428ca95903446b7b7458@intel.com>
References: <20210728204653.1509010-1-tony.luck@intel.com>
 <20210827195543.1667168-1-tony.luck@intel.com>
 <20210827195543.1667168-6-tony.luck@intel.com>
 <49fccddbbf92279f575409851a9c682495146ad8.camel@kernel.org>
 <681d530d72de842c8bf43733c11f3c3f2ebf8c6e.camel@kernel.org>
 <25db682402d14c34af9ba525cffe85c5@intel.com>
 <848905ffa20cf234446b16682cbbcf1e56853950.camel@kernel.org>
 <30034c82-99fa-3592-c215-cb9c61f87456@intel.com>
In-Reply-To: <30034c82-99fa-3592-c215-cb9c61f87456@intel.com>
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

PiBCVFcsIEkgZG9uJ3Qgc2VlIHNneF9pc19lcGNfcGFnZSgpIGluIGFyY2gtZ2VuZXJpYyBjb2Rl
LiAgRG9lcyBpdCByZWFsbHkNCj4gbmVlZCB0byBiZSBpbiBtbS5oPw0KDQpJIHVzZSBpdCBpbiBk
cml2ZXJzL2FjcGkvYXBlaS9laW5qLmMNCg0KQXJtIGlzIGEgYmlnIHVzZXIgb2YgQUNQSS4gSSBk
b24ndCBzZWUgYW55IEtjb25maWcgZXhjbHVzaW9ucyBmb3IgQ09ORklHX0FDUElfQVBFSV9FSU5K
DQoNCi1Ub255DQo=
