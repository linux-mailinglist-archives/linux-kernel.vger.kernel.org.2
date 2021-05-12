Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C1937BF70
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhELOMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:12:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:7585 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230362AbhELOMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:12:01 -0400
IronPort-SDR: fR0jTeeCDJ3CiXTwFbSoUTbtTB1bQIFVuWF2ymvQBMM9s1UDQEukDn5N5zsz1IOcepi/fpqAB3
 gJhbieWoY80A==
X-IronPort-AV: E=McAfee;i="6200,9189,9981"; a="263641632"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="263641632"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 07:10:53 -0700
IronPort-SDR: pPM6Ks1tTrsh/C9IVMkbeqF8eeye6flzD/iMLsvaeRPLZpT3njUD0pnZfJSiqy+YdlCREjaexT
 sbOHC/GUOJRQ==
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; 
   d="scan'208";a="625403316"
Received: from shepark-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.166.42])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 07:10:44 -0700
Subject: Re: [RFC v2 10/32] x86/tdx: Wire up KVM hypercalls
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <04de6cd6549eee0b77fe3b0937c4b4b7f0e3ff2e.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <bc2e6da5-f35d-6574-52d0-82d996e56920@intel.com>
 <b836a6a2-3bbe-d568-50f0-0b6b8dbe3133@linux.intel.com>
 <20210512130004.gxiaxj6wlzcjcem5@box.shutemov.name>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <25e248b2-06f7-a450-4c9f-e90e0f0be56e@linux.intel.com>
Date:   Wed, 12 May 2021 07:10:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512130004.gxiaxj6wlzcjcem5@box.shutemov.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/21 6:00 AM, Kirill A. Shutemov wrote:
> This has to be compiled only for TDX+KVM.

Got it. So if we want to remove the "C" file include, we will have to
add #ifdef CONFIG_KVM_GUEST in Makefile.

ifdef CONFIG_KVM_GUEST
obj-$(CONFIG_INTEL_TDX_GUEST) += tdx-kvm.o
#endif

Dave, do you prefer above change over "C" file include?

  25 #ifdef CONFIG_KVM_GUEST
  26 #include "tdx-kvm.c"
  27 #endif

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
