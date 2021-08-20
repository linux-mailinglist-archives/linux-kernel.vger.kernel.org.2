Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBA73F31AB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 18:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhHTQni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 12:43:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:5650 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230295AbhHTQnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 12:43:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="204001447"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="204001447"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 09:42:59 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="506519677"
Received: from jmorauga-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.135.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 09:42:58 -0700
Subject: Re: [PATCH v5 04/12] x86/tdx: Add protected guest support for TDX
 guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQsNpG55v7dhFqIb@google.com>
 <9c576f24-e6de-f816-623d-408a4a2ae747@intel.com>
 <4f28fe6e-a8ce-e444-51db-d0eb564eca8f@linux.intel.com>
 <YQsX54MPVYFuLmFr@google.com>
 <ca4aa25c-7d88-9812-4852-ced3274493a8@linux.intel.com>
 <YRTTZU3Pzm/1tH9M@zn.tnic>
 <486afc0e-0396-e57b-63fe-31a8433bd603@linux.intel.com>
 <YR+78mxnKW0T9Vdv@zn.tnic>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d419406e-749a-f851-f65e-a6582462c8a2@linux.intel.com>
Date:   Fri, 20 Aug 2021 09:42:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YR+78mxnKW0T9Vdv@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/21 7:28 AM, Borislav Petkov wrote:
> On Thu, Aug 12, 2021 at 10:18:39AM -0700, Kuppuswamy, Sathyanarayanan wrote:
>> I can implement intel_prot_guest_has() in arch/x86/kernel/cpu/intel.c.
>> And call tdx_prot_guest_has() from it.
> 
> No, you should simply implement intel_prot_guest_has() or whatever we
> end up calling it and have the generic routine call it. Not two routines
> - tdx_* and intel_*
> 

Reason for suggesting seperate function for tdx_* specific protected guest
check is, we will be adding some exceptions for TDX features (like command
line option used to override the default flags or when device filter
support is disabled). Our current final version looks like below. Such
customization are not good in generic intel_* function right?

bool tdx_prot_guest_has(unsigned long flag)
{
         bool tdx_guest_enabled = cpu_feature_enabled(X86_FEATURE_TDX_GUEST);

         if (flag == tdg_disable_prot)
                 return false;

         switch (flag) {
         case PATTR_GUEST_TDX:
         case PATTR_GUEST_UNROLL_STRING_IO:
         case PATTR_GUEST_MEM_ENCRYPT:
         case PATTR_GUEST_SHARED_MAPPING_INIT:
         case PATTR_MEM_ENCRYPT:
         case PATTR_GUEST_SECURE_TIME:
         case PATTR_GUEST_CPUID_FILTER:
         case PATTR_GUEST_RAND_LOOP:
                 return tdx_guest_enabled;
         case PATTR_GUEST_DRIVER_FILTER:
                 return tdg_filter_enabled() && tdx_guest_enabled;
         }

         return false;
}


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
