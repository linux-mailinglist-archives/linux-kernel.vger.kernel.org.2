Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C51537FE64
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbhEMTsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:48:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:22210 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230135AbhEMTsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:48:21 -0400
IronPort-SDR: a8p0Q93fM7+saD7DqJHH6aAOp4fwej2SiBZhdGU8uEM0St36q5k08RUDWwyPL0zQZBRIl/lX5z
 pqroI+gt3FpQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="196945757"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="196945757"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 12:47:08 -0700
IronPort-SDR: QoPSEtLyEdfA5ldwortAGAZIgBcR+jfn/KWI6NOSaBDydTI8du9EOGMEutVJzt2hGozj+4xD+r
 Ll8gFYU73vXg==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="401145820"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.17.244]) ([10.209.17.244])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 12:47:05 -0700
Subject: Re: [RFC v2 08/32] x86/traps: Add #VE support for TDX guest
To:     Dave Hansen <dave.hansen@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <8a1d6930f784cb57c957cf20cea870947db91e05.1619458733.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <afd85e8f-ab26-aa3b-e4e9-a0b3bfd472c8@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <73752227-6eaf-2de6-3ac6-5ee280980c18@linux.intel.com>
Date:   Thu, 13 May 2021 12:47:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <afd85e8f-ab26-aa3b-e4e9-a0b3bfd472c8@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/7/2021 2:36 PM, Dave Hansen wrote:
> On 4/26/21 11:01 AM, Kuppuswamy Sathyanarayanan wrote:
> ...
>> The #VE cannot be nested before TDGETVEINFO is called, if there is any
>> reason for it to nest the TD would shut down. The TDX module guarantees
>> that no NMIs (or #MC or similar) can happen in this window. After
>> TDGETVEINFO the #VE handler can nest if needed, although we don’t expect
>> it to happen normally.
> I think this description really needs some work.  Does "The #VE cannot
> be nested" mean that "hardware guarantees that #VE will not be
> generated", or "the #VE must not be nested"?

The next half sentence answers this question..

"if there is any reason for it to nest the TD would shut down."

So it cannot nest.


>
> What does "the TD would shut down" mean?  I think you mean that instead
> of delivering a nested #VE the hardware would actually exit to the host
> and TDX would prevent the guest from being reentered.  Right?


Yes that's a shutdown. I Suppose we could add your sentence.


> I find that description a bit unsatisfying.  Could we make this a bit
> more concrete?


I don't see what could be added. If you have concrete suggestions please 
just propose something.


>   By the way, what about *normal* interrupts?


Normal interrupts are blocked of course like in every other exception or 
interrupt entry.

>
> Maybe we should talk about this in terms of *rules* that folks need to
> follow.  Maybe:
>
> 	NMIs and machine checks are suppressed.  Before this point any
> 	#VE is fatal.  After this point, NMIs and additional #VEs are
> 	permitted.

Okay that's fine for me.


-Andi



