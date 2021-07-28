Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453923D99B9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 01:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhG1XsT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Jul 2021 19:48:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:51286 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232641AbhG1XsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 19:48:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="199988469"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="199988469"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 16:48:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="464860836"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP; 28 Jul 2021 16:48:16 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 28 Jul 2021 16:48:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 28 Jul 2021 16:48:14 -0700
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.2242.010;
 Wed, 28 Jul 2021 16:48:14 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     Jarkko Sakkinen <jarkko@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/7] x86/sgx: Provide indication of life-cycle of EPC
 pages
Thread-Topic: [PATCH v3 1/7] x86/sgx: Provide indication of life-cycle of EPC
 pages
Thread-Index: AQHXg/G3voDWmDqCq06DL34grJaPratZaKWA//+WanCAAHqDAIAABZsA//+MGqA=
Date:   Wed, 28 Jul 2021 23:48:14 +0000
Message-ID: <b05acb65cebc4718a5cc2503ced7455d@intel.com>
References: <20210719182009.1409895-1-tony.luck@intel.com>
 <20210728204653.1509010-1-tony.luck@intel.com>
 <20210728204653.1509010-2-tony.luck@intel.com>
 <17054ca5-0ef7-4b28-ab26-b1b96aa7403f@intel.com>
 <f2685d7c8dc14792a4e0f9807f742ea6@intel.com>
 <fd8f8e79-f63f-7d6f-277e-1ad08ab7b6b8@intel.com>
 <YQHpGq0GyAsYpE+D@google.com>
In-Reply-To: <YQHpGq0GyAsYpE+D@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -       epc_page = sgx_alloc_epc_page(NULL, true);
> +       epc_page = sgx_alloc_epc_page(va_page, true);

Providing a real value for the owner seems much better than all the hacks
to invent a value to use instead of NULL.

Can you add a "Signed-off-by"? Then I'll replace my part 0001 with your version.

-Tony

[Just need to coax you into re-writing all the other parts for me now :-) ]
