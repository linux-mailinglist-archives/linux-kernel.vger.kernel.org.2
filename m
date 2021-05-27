Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AC63932E6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbhE0PyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:54:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:49092 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236227AbhE0PyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:54:11 -0400
IronPort-SDR: UwZf/3mp6vXlX/zVhBep9dSocf0jicKdDIK7jelv8oIs7sYSatoUpKzELq5DksF1WrU6kC5XhF
 cEPOKxtHJ+ew==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="182423953"
X-IronPort-AV: E=Sophos;i="5.83,334,1616482800"; 
   d="scan'208";a="182423953"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 08:52:32 -0700
IronPort-SDR: vi1sBJKGxSpVz71rOrh75KRpaRsqlzBadY0+7RMY/QxUJXaumVUuf/3+yJXONBQd2YhMUZ+zB3
 1QvcyrzhkZ4A==
X-IronPort-AV: E=Sophos;i="5.83,334,1616482800"; 
   d="scan'208";a="409790638"
Received: from clblake-mobl-x280.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.5.237])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 08:52:31 -0700
Subject: Re: [RFC v2-fix-v2 1/1] x86/tdx: Add __tdx_module_call() and
 __tdx_hypercall() helper functions
To:     "Luck, Tony" <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <77545da6-d534-e4c2-a60b-085705e3f0b7@linux.intel.com>
 <20210527003033.3632700-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <974d8050cb974d6d80b0033e4b9fd0bf@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <e644695a-849e-53d6-f84a-4fcb84988911@linux.intel.com>
Date:   Thu, 27 May 2021 08:52:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <974d8050cb974d6d80b0033e4b9fd0bf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/27/21 8:25 AM, Luck, Tony wrote:
>> Guests communicate with VMMs with hypercalls. Historically, these
>> are implemented using instructions that are known to cause VMEXITs
>> like vmcall, vmlaunch, etc. However, with TDX, VMEXITs no longer
>> expose guest state to the host.  This prevents the old hypercall
>> mechanisms from working. So to communicate with VMM, TDX
>> specification defines a new instruction called "tdcall".
> 
> You use all caps TDCALL everywhere else in this commit message.
> Looks odd to have quoted lower case here.

I will use TDCALL uniformly.

> 
>> In a TDX based VM, since VMM is an untrusted entity, a intermediary
>> layer (TDX module) exists between host and guest to facilitate the
>> secure communication. TDX guests communicate with the TDX module and
>> with the VMM using a new instruction: TDCALL.
> 
> Seems both repeat what was in the first paragraph, but also fail to
> explain how this TDCALL is different from that first TDCALL.

Both cases uses TDCALL instruction. Arguments we pass confirms the
type of TDCALL ( one used to communicate with TDX module vs one used
to communicate with VMM).

I can modify the description to convey the difference between both
cases.

> 
>> Implement common helper functions to communicate with the TDX Module
>> and VMM (using TDCALL instruction).
>>     
>> __tdx_hypercall()    - request services from the VMM.
>> __tdx_module_call()  - communicate with the TDX Module.
> 
> Looking at the code, the hypercall can return an error if TDCALL fails,
> but module_call forces a panic with UD2 on error. This difference isn't
> explained anywhere.

I think you meant hypercall will panic vs module call will not.

In hypercall case, since we use same TDCALL instruction, we will have two
return values. One is for TDCALL failure (at the TDX module level) and
other is return value from VMM. So in hypercall case, we return VMM value
to the user but panic for TDCALL failures. As per TDX spec, for hypercall
use case, if everything is in order, TDCALL will never fail. If we notice
TDCALL failure error then it means, we are working with the broken TDX module.
So we panic.

> -Tony
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
