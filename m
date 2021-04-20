Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FD53662B3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 02:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhDUAAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 20:00:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:55062 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234223AbhDUAAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 20:00:35 -0400
IronPort-SDR: iDD+iTuin04fcB6CUd7CUwAV7hUNs1Kien+MtAVOfvkw80rnwSPmrRbke2WE9dUh082lPcwRu5
 9FvqtmC/QRsA==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="256927568"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="256927568"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 16:59:05 -0700
IronPort-SDR: jUkior5xQyrz6qh/VtxpNir9WsdC3JKwD1Fc6OM5K0kJi+Q3EpQP3Nc5/ScCFF8lDkFdcU5yD7
 C+tc9vfKMU7g==
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="427278339"
Received: from jjagger-mobl1.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.197.239])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 16:59:04 -0700
Subject: Re: [PATCH v2 1/1] x86/tdx: Add __tdcall() and __tdvmcall() helper
 functions
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <8723950c-e07c-9a03-503a-ab232701d1e9@linux.intel.com>
 <c015093fdbc8e6a5aa9fc43f78fec8d9c38295c7.1616801167.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <77a13ae9-0220-030e-7ae4-fd26edd7b110@intel.com>
 <2a3f6b3d-cd80-0734-ce83-c067666c8326@linux.intel.com>
 <14332abf-c78c-3bc2-9a7c-ceacfa7a0661@intel.com>
 <596175e3-9d1e-6c9c-fadb-ad02c396e3ad@linux.intel.com>
 <CAPcyv4hmA=V+wQA7JsvBNYnm+dHkRZtJSSxSZM8b2Xwnjq2kWQ@mail.gmail.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <8aebc35e-f1ff-e70d-2f44-54d17f6fe555@linux.intel.com>
Date:   Tue, 20 Apr 2021 16:59:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hmA=V+wQA7JsvBNYnm+dHkRZtJSSxSZM8b2Xwnjq2kWQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/20/21 4:53 PM, Dan Williams wrote:
> On Tue, Apr 20, 2021 at 4:12 PM Kuppuswamy, Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> [..]
>>>>> Also, do you *REALLY* need to do this from assembly?  Can't it be done
>>>>> in the C wrapper?
>>>> Its common for all use cases of TDVMCALL (vendor specific, in/out, etc).
>>>> so added
>>>> it here.
>>>
> 
> Can I ask a favor?
> 
> Please put a line break between quoted lines and your reply.

will do

> 
>>> That's not a good reason.  You could just as easily have a C wrapper
>>> which all uses of TDVMCALL go through.
> 
> ...because this runs together when reading otherwise.
> 
>> Any reason for not preferring it in assembly code?
>> Also, using wrapper will add more complication for in/out instruction
>> substitution use case. please check the use case in following patch.
>> https://github.com/intel/tdx/commit/1b73f60aa5bb93554f3b15cd786a9b10b53c1543
> 
> This commit still has open coded assembly for the TDVMCALL? I thought
> we talked about it being unified with the common definition, or has
> this patch not been reworked with that feedback yet? I expect there is
> no performance reason why in/out need to get their own custom coded
> TDVMCALL implementation. It should also be the case the failure should
> behave the same as native in/out failure i.e. all ones on read
> failure, and silent drops on write failure.
> 

That link is for older version. My next version addresses your review
comments (re-uses TDVMCALL() function). Although the patch is ready, I am
waiting to fix other review comments before sending the next version. I
have just shared that link to explain about the use case.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
