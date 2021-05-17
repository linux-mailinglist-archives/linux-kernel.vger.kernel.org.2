Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E164386D94
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 01:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbhEQXMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 19:12:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:63482 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237185AbhEQXMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 19:12:49 -0400
IronPort-SDR: B4tFPy6ZVFeBqej51wBlHa4zlNJFgFt9n/6cyUnyMflcjJSk1pay2GGMmWyZOFRs1TUaT62Gkf
 T4g3plA1asbw==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="286115488"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="286115488"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 16:11:32 -0700
IronPort-SDR: lLrNzRwfUO0QaW2leedeBStcPX0hYpbs5W+vkw80G23VtFRN3Nw1u1Fd5LpsjauD+5cqteKKMw
 3ip0mNTLNOlg==
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="411019682"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.163.36]) ([10.212.163.36])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 16:11:32 -0700
Subject: Re: [RFC v2 26/32] x86/mm: Move force_dma_unencrypted() to common
 code
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <bbcb688c-5aa0-eeb1-192a-45edaccc2f32@intel.com>
 <20210512130821.7r2rtzcyjltecun7@box.shutemov.name>
 <e8886298-83fa-212e-ab3a-5e5b21a7ab6c@intel.com>
 <YJv6EWJmDYQL4Eqt@google.com>
 <c6b40305-d643-6023-907b-e6858d422a36@linux.intel.com>
 <943645b7-3974-bf05-073c-03ef4f889379@intel.com>
 <a72bce3a-d7da-c595-9456-cfda42d9cdc3@linux.intel.com>
 <YKKzCOW9u6q06E5I@google.com>
 <d5fb2565-110e-17d1-ea00-35cf4d196f1e@linux.intel.com>
 <5cc06488-09fe-17b5-077b-02c4ba9ca198@intel.com>
 <YKK4AHhfv1nrYiw2@google.com>
 <37da11b3-0313-982d-5a2b-af592db6f9e8@linux.intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <52909cda-37c6-44ed-6dca-f13d2c1f3108@linux.intel.com>
Date:   Mon, 17 May 2021 16:11:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <37da11b3-0313-982d-5a2b-af592db6f9e8@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/17/2021 3:32 PM, Kuppuswamy, Sathyanarayanan wrote:
>
>
> On 5/17/21 11:37 AM, Sean Christopherson wrote:
>>> Just remember, a "common framework" doesn't mean that it can't be 
>>> backed
>>> by extremely arch-specific mechanisms.
>>>
>>> For instance, there's a lot of pkey-specific code in mm/mprotect.c.  It
>>> still gets optimized away on x86 with all the goodness of X86_FEATUREs.
>> Ya, exactly.  Ideally, generic code shouldn't have to differentiate 
>> between SEV,
>> SEV-ES, SEV-SNP, TDX, etc..., a vanilla "bool 
>> is_protected_guest(void)" should
>> suffice.  Under the hood, x86's implementation for 
>> is_protected_guest() can be
>> boot_cpu_has() checks (if we want).
>
> What about the use case of protected_guest_has(flag)? Do you want to 
> call it with
> with X86_FEATURE_* flags outside arch/x86 code ?


I don't think we need any flags in the generic code. Just a simple bool 
is enough.


-Andi

