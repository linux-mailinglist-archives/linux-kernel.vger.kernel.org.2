Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF12D37FE1E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbhEMTao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:30:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:60114 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhEMTai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:30:38 -0400
IronPort-SDR: +6zhGkO8WijOe8vJL3k6r0H1CAT9dj5jFWHka4rCkcUrbL4nOY42U0hPj6iFBec7YNSCTLKmaR
 hsg2sMv/oZqA==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="200085360"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="200085360"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 12:29:25 -0700
IronPort-SDR: J9OlAAfkrLiYJtR1vf+1vq6ksQK7DWG3RupnyQwJyGp+BQ3bCYa9fGprJX4K3IElNslnNovNxE
 fueoPwkSIeyg==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="437780447"
Received: from dleves-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.146.134])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 12:29:23 -0700
Subject: Re: [RFC v2 10/32] x86/tdx: Wire up KVM hypercalls
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
 <25e248b2-06f7-a450-4c9f-e90e0f0be56e@linux.intel.com>
 <75e63641-6dea-b339-444e-42bedbd28a1b@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f2efec32-3317-89ae-bc50-748707b11837@linux.intel.com>
Date:   Thu, 13 May 2021 12:29:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <75e63641-6dea-b339-444e-42bedbd28a1b@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/12/21 7:29 AM, Dave Hansen wrote:
> On 5/12/21 7:10 AM, Kuppuswamy, Sathyanarayanan wrote:
>> On 5/12/21 6:00 AM, Kirill A. Shutemov wrote:
>>> This has to be compiled only for TDX+KVM.
>>
>> Got it. So if we want to remove the "C" file include, we will have to
>> add #ifdef CONFIG_KVM_GUEST in Makefile.
>>
>> ifdef CONFIG_KVM_GUEST
>> obj-$(CONFIG_INTEL_TDX_GUEST) += tdx-kvm.o
>> #endif
> 
> Is there truly no dependency between CONFIG_KVM_GUEST and
> CONFIG_INTEL_TDX_GUEST?

We want to re-use TDX code with other hypervisors/guests as well. So
we can't create direct dependency with CONFIG_KVM_GUEST in Kconfig.

> 
> If there isn't, then the way we do it is adding another (invisible)
> Kconfig variable to express the dependency for tdx-kvm.o:
> 
> config INTEL_TDX_GUEST_KVM
> 	bool
> 	depends on KVM_GUEST && INTEL_TDX_GUEST

Currently it will only be used for KVM hypercall code. Will it to be
overkill to create a new config over #ifdefs for this use case ? But,
if this is the preferred approach, I will go with this suggestion.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
