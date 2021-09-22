Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE84414CE8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 17:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236401AbhIVPXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 11:23:33 -0400
Received: from mga05.intel.com ([192.55.52.43]:63974 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236319AbhIVPXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 11:23:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="309171962"
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; 
   d="scan'208";a="309171962"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 08:22:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,314,1624345200"; 
   d="scan'208";a="613581039"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2021 08:22:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 08:22:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 22 Sep 2021 08:22:01 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.012;
 Wed, 22 Sep 2021 08:22:01 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Yazen Ghannam <yazen.ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] x86/mce: Get rid of msr_ops
Thread-Topic: [PATCH 3/4] x86/mce: Get rid of msr_ops
Thread-Index: AQHXq7JaRGlGvEV5GEmaz9UoRNBQZqusXfOAgAC0BICAA2NsgIAAEp8AgAAI3AD//6J5AA==
Date:   Wed, 22 Sep 2021 15:22:01 +0000
Message-ID: <f73c2f6790d6428393348869bc7c7e73@intel.com>
References: <YUsesVeZ8PPC5iV5@zn.tnic>
 <2B1FFC77-A740-41AE-BF8C-FB238B9DF7F5@intel.com> <YUs1vu7lxevL1EpO@zn.tnic>
In-Reply-To: <YUs1vu7lxevL1EpO@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gTG9va3MgbmljZS4gSSBkb27igJl0IHRoaW5rIHlvdSBuZWVkIHRob3NlIOKAnGJyZWFrO+KA
nSBhZnRlciBlYWNoIOKAnHJldHVybiDigKY74oCdDQo+DQo+IFlhaCwgYWxsIGdvbmUuDQoNCkFs
c286DQoNCglzd2l0Y2ggKGVudW0pIHsNCglhY3Rpb25zIGZvciBldmVyeSB2YWx1ZSBvZiB0aGF0
IGVudW0NCgl9DQoNCmRvZXNuJ3QgbmVlZCBhIGRlZmF1bHQ6IG9wdGlvbg0KDQotVG9ueQ0K
