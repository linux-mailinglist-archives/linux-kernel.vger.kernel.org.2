Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4163D3A0763
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 01:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhFHXGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 19:06:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:11143 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234272AbhFHXGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 19:06:43 -0400
IronPort-SDR: 7OiaCEtoo0lbCt8zqgMS8xlOaXr3zQAAeSg71orLTIjqDIMMzAlpLNvglNEklNJq/wPkirYHha
 eKMWL7wfwwOw==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="192281785"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="192281785"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 16:04:48 -0700
IronPort-SDR: Est3ejA8vtQVDnCdKwCG8sRhCrVLBWJ2jf32J9EBP2uQmIuRVa6JJh4XtKecE/csgN8zq1D4vt
 gvWGbw6ho51g==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="402236905"
Received: from dabarred-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.185.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 16:04:48 -0700
Subject: Re: [RFC v2-fix-v3 1/1] x86/tdx: Skip WBINVD instruction for TDX
 guest
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
References: <CAPcyv4jQ=Fcga3jyUzthjPW9O962vhy3L5XUM6jqR5Z_Zq83LQ@mail.gmail.com>
 <20210608213527.739474-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <ec55256c-3a44-5265-fea8-018a229e92da@intel.com>
 <bc41d48e-b001-f870-e421-7c5cbc6ec1c4@linux.intel.com>
 <d28a4ece-744e-1d43-90c8-e8c36def9be6@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <3960cd4d-9dc6-9f74-720e-4aa6c1ca1d21@linux.intel.com>
Date:   Tue, 8 Jun 2021 16:04:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <d28a4ece-744e-1d43-90c8-e8c36def9be6@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/21 3:53 PM, Dave Hansen wrote:
> On 6/8/21 3:36 PM, Kuppuswamy, Sathyanarayanan wrote:
>> On 6/8/21 3:17 PM, Dave Hansen wrote:
>>> On 6/8/21 2:35 PM, Kuppuswamy Sathyanarayanan wrote:

> 
> A kernel driver using WBINVD will "sigfault"?  I'm not sure what that
> means.  How does the kernel "sigfault"?

Sorry, un-supported #VE is handled similar to #GP fault.

> 
>> In this patch we only create exception for ACPI sleep driver code. If
>> commit log is confusing, I can remove information about other unsupported
>> feature (with WBINVD usage).
> 
> Yes, the changelog is horribly confusing.  But simply removing this
> information is insufficient to rectify the deficiency.

I will remove all the unrelated information from this commit log. As long as
commit log *only* talks and handles the exception for ACPI sleep driver, it
should be acceptable for you right? I will also add a note about, if any
other feature with WBINVD usage is enabled, it would lead to #GP fault.

> 
> I've lost trust that due diligence will be performed on this series on
> its own.  I've seen too many broken promises and too many holes.
> 
> Here's what I want to see: a list of all of the unique call sites for
> WBINVD in the kernel.  I want a written down methodology for how the
> list of call sites was generated.  I want to see an item-by-item list of
> why those call sites are unreachable with the TDX guest code.  It might
> be because they've been patched in this patch, or the driver has been
> disabled, or because the TDX architecture spec would somehow prohibit
> the situation where it might be needed.  But, there needs to be a list,
> and you have to show your work.  If you refer to code from this series
> as helping to prevent WBINVD, then it has to be earlier in this series,
> not in some other series and not later in this series.
> 
> Just eyeballing it, there are ~50 places in the kernel that need auditing.
> 
> Right now, we mostly have indiscriminate hand-waving about this not
> being a problem.  It's a hard NAK from me on this patch until this audit
> is in place.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
