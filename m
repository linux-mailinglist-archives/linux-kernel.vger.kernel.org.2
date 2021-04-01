Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C343522BF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 00:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhDAWZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 18:25:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:15743 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233789AbhDAWZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 18:25:24 -0400
IronPort-SDR: DiuTLWy5ks/iutoT3DkEKk/wwWWukTz5/IDHb70ZswwrhjuBB22NmbEzqnX/zFGPv8FQ+Zs88f
 OoVj3rVdzK4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="192446191"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="192446191"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:25:24 -0700
IronPort-SDR: H7wg1ZKmAqZo2RE31j8BZztOdcTcVFJ9QTcXyjzYgyev32YuHTWndqIo1usOEM36PbC3U1lZMo
 h+NSZdNDlS5Q==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="419389337"
Received: from maorache-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.213.170.140])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:25:23 -0700
Subject: Re: [RFC v1 03/26] x86/cpufeatures: Add is_tdx_guest() interface
To:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <cover.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <83c8fcff9ac09f73924104cfb534258747e98bff.1612563142.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <0116481d-581b-9433-3641-47e39550b99a@intel.com>
 <8f0bd4e5-195b-7e65-f780-f5e31d72cfe8@linux.intel.com>
 <3aee61d5-9cc2-2c3c-00ea-f3ec7d5f7e04@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <da2d332a-6d30-c102-9aa0-328d98401dae@linux.intel.com>
Date:   Thu, 1 Apr 2021 15:25:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3aee61d5-9cc2-2c3c-00ea-f3ec7d5f7e04@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/21 2:19 PM, Dave Hansen wrote:
> On 4/1/21 2:15 PM, Kuppuswamy, Sathyanarayanan wrote:
>> On 4/1/21 2:08 PM, Dave Hansen wrote:
>>> On 2/5/21 3:38 PM, Kuppuswamy Sathyanarayanan wrote:
>>>> +bool is_tdx_guest(void)
>>>> +{
>>>> +    return static_cpu_has(X86_FEATURE_TDX_GUEST);
>>>> +}
>>>
>>> Why do you need is_tdx_guest() as opposed to calling
>>> cpu_feature_enabled(X86_FEATURE_TDX_GUEST) everywhere?
>>
>> is_tdx_guest() is also implemented/used in compressed
>> code (which uses native_cpuid calls). I don't think
>> we can use cpu_feature_enabled(X86_FEATURE_TDX_GUEST) in
>> compressed code right? Also is_tdx_guest() looks easy
>> to read and use.
> 
> OK, but how many of the is_tdx_guest() uses are in the compressed code?
>   Why has its use spread beyond that?
Its only used in handling in/out instructions in compressed code. But this
code shared with in/out handling on non-compressed code.

#define __out(bwl, bw)                                                  \
do {                                                                    \
         if (is_tdx_guest()) {                                           \
                 asm volatile("call tdg_out" #bwl : :                    \
                                 "a"(value), "d"(port));                 \
         } else {                                                        \
                 asm volatile("out" #bwl " %" #bw "0, %w1" : :           \
                                 "a"(value), "Nd"(port));                \
         }                                                               \
} while (0)
#define __in(bwl, bw)                                                   \
do {                                                                    \
         if (is_tdx_guest()) {                                           \
                 asm volatile("call tdg_in" #bwl :                       \
                                 "=a"(value) : "d"(port));               \
         } else {                                                        \
                 asm volatile("in" #bwl " %w1, %" #bw "0" :              \
                                 "=a"(value) : "Nd"(port));              \
         }                                                               \
} while (0)

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
