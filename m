Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5013139FEBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 20:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhFHSOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 14:14:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:45594 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231652AbhFHSOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 14:14:44 -0400
IronPort-SDR: 27xYeBIv45qHg5aThElVla4MzTQkFtD/R/+tYSshUvEFIJ7Yz+QLheheC4Utic7JMYYskWKWUA
 /Exv4qD+ZVCw==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="268759607"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="268759607"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 11:12:50 -0700
IronPort-SDR: Qr/JpfWv9OcHVH7zHoKkx6FMb91zwWrT7KKtl14D3eEKNzLcEE4pptjdA2Qp9XY6/m20TwO48G
 MtEdFuCYemYA==
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="551701528"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.24.11]) ([10.209.24.11])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 11:12:49 -0700
Subject: Re: [RFC v2 08/32] x86/traps: Add #VE support for TDX guest
To:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <8a1d6930f784cb57c957cf20cea870947db91e05.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <fe05830e-e82b-f338-2ba1-02651cb8087e@intel.com>
 <YL+tfGOMWEvDJTwc@google.com>
 <42f6b603-7c21-28fa-b6ec-e53268aa6ff7@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <3afaebee-77dc-83ff-c397-aa64991c52be@linux.intel.com>
Date:   Tue, 8 Jun 2021 11:12:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <42f6b603-7c21-28fa-b6ec-e53268aa6ff7@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/8/2021 10:53 AM, Dave Hansen wrote:
> On 6/8/21 10:48 AM, Sean Christopherson wrote:
>> On Tue, Jun 08, 2021, Dave Hansen wrote:
>>> On 4/26/21 11:01 AM, Kuppuswamy Sathyanarayanan wrote:
>>>> +#ifdef CONFIG_INTEL_TDX_GUEST
>>>> +DEFINE_IDTENTRY(exc_virtualization_exception)
>>>> +{
>>>> +	struct ve_info ve;
>>>> +	int ret;
>>>> +
>>>> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
>>>> +
>>>> +	/*
>>>> +	 * Consume #VE info before re-enabling interrupts. It will be
>>>> +	 * re-enabled after executing the TDGETVEINFO TDCALL.
>>>> +	 */
>>>> +	ret = tdg_get_ve_info(&ve);
>>> Is it safe to have *anything* before the tdg_get_ve_info()?  For
>>> instance, say that RCU_LOCKDEP_WARN() triggers.  Will anything in there
>>> do MMIO?
>> I doubt it's safe, anything that's doing printing has the potential to trigger
>> #VE.  Even if we can prove it's safe for all possible paths, I can't think of a
>> reason to allow anything that's not absolutely necessary before retrieving the
>> #VE info.
> What about tracing?  Can I plop a kprobe in here or turn on ftrace?

I believe neither does mmio/msr normally (except maybe ftrace+tp_printk, 
but that will likely work because it shouldn't recurse more than once 
due to ftrace's reentry protection)

-Andi

