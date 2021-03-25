Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61488348842
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 06:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhCYFND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 01:13:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:50258 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhCYFM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 01:12:57 -0400
IronPort-SDR: u4JsjNzrI8bJ4I3BVOUy6zXj4kMzUFXas0we/HV7w9gjvn5OWdTwTSb5/q7JAswsUfriBO6LBI
 kNokurAoFH3w==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="252207900"
X-IronPort-AV: E=Sophos;i="5.81,276,1610438400"; 
   d="scan'208";a="252207900"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 22:12:56 -0700
IronPort-SDR: HkBRqIy0QuW1efZYoeF3uEBVVQWEboG9pnRaHdUZmGnFjPiMr6JtLqimd1rruYsf4nbzrwy5aD
 VqIldjSw14rQ==
X-IronPort-AV: E=Sophos;i="5.81,276,1610438400"; 
   d="scan'208";a="409186681"
Received: from unknown (HELO [10.238.130.187]) ([10.238.130.187])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 22:12:52 -0700
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
To:     Len Brown <lenb@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        X86 ML <x86@kernel.org>, Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-15-chang.seok.bae@intel.com>
 <87o8fda2ye.fsf@nanos.tec.linutronix.de>
 <CALCETrVaCmG4jzLCSuy7WYP2K7r-MVZntfugWa8HiVxQ7LpF_A@mail.gmail.com>
 <CAJvTdKmz7aePcpi4i+d3vnqLuNAJEuJCjpGDv5WTYcSUfuxoDg@mail.gmail.com>
 <6ed9d725-a6cb-4147-9c8a-2fe240e4bb10@linux.intel.com>
 <CAJvTdKm_uP-RqoprWWatg725WZOm3T-BHZU8S08dpWe2=1apGw@mail.gmail.com>
From:   "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <87fb254f-a904-303e-daee-c9a3e9bf13b7@linux.intel.com>
Date:   Thu, 25 Mar 2021 13:12:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAJvTdKm_uP-RqoprWWatg725WZOm3T-BHZU8S08dpWe2=1apGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/2021 5:09 AM, Len Brown wrote:
> On Tue, Mar 23, 2021 at 11:15 PM Liu, Jing2 <jing2.liu@linux.intel.com> wrote:
>
>>> IMO, the problem with AVX512 state
>>> is that we guaranteed it will be zero for XINUSE=0.
>>> That means we have to write 0's on saves.
>> why "we have to write 0's on saves" when XINUSE=0.
>>
>> Since due to SDM, if XINUSE=0, the XSAVES will *not* save the data and
>> xstate_bv bit is 0; if use XSAVE, it need save the state but
>> xstate_bv bit is also 0.
>>>    It would be better
>>> to be able to skip the write -- even if we can't save the space
>>> we can save the data transfer.  (This is what we did for AMX).
>> With XFD feature that XFD=1, XSAVE command still has to save INIT state
>> to the area. So it seems with XINUSE=0 and XFD=1, the XSAVE(S) commands
>> do the same that both can help save the data transfer.
> Hi Jing, Good observation!
>
> There are 3 cases.
Hi Len, thanks for your reply.
>
> 1. Task context switch save into the context switch buffer.
> Here we use XSAVES, and as you point out, XSAVES includes
> the compaction optimization feature tracked by XINUSE.
> So when AMX is enabled, but clean, XSAVES doesn't write zeros.
> Further, it omits the buffer space for AMX in the destination altogether!
> However, since XINUSE=1 is possible, we have to *allocate* a buffer
> large enough to handle the dirty data for when XSAVES can not
> employ that optimization.
Yes, I agree with you about the first case.
>
> 2. Entry into user signal handler saves into the user space sigframe.
> Here we use XSAVE, and so the hardware will write zeros for XINUSE=0,
> and for AVX512, we save neither time or space.
>
> My understanding that for application compatibility, we can *not* compact
> the destination buffer that user-space sees.  This is because existing code
> may have adopted fixed size offsets.  (which is unfortunate).

> And so, for AVX512, we both reserve the space, and we write zeros
> for clean AVX512 state.
By XSAVE, I think this is true if we assume setting EDX:EAX AVX512 bits 
as 1,
which means XSAVE will write zeros when XINUSE=0. Is this the same 
assumption
with yours?...
> For AMX, we must still reserve the space, but we are not going to write zeros
> for clean state.  We so this in software by checking XINUSE=0, and clearing
> the xstate_bf for the XSAVE.  As a result, for XINUSE=0, we can skip
> writing the zeros, even though we can't compress the space.
So my understanding is that clearing xstate_bv will not help prevent saving
zeros, but only not masking EDX:EAX, since the following logic. Not sure if
this is just what you mean. :)

RFBM ← XCR0 AND EDX:EAX; /* bitwise logical AND */
OLD_BV ← XSTATE_BV field from XSAVE header;
...
FOR i ← 2 TO 62
IF RFBM[i] = 1
THEN save XSAVE state component i at offset n from base of XSAVE area;
FI;
ENDFOR;

XSTATE_BV field in XSAVE header ← (OLD_BV AND NOT RFBM) OR (XINUSE AND 
RFBM);

> 3. user space always uses fully uncompacted XSAVE buffers.
>
>> The reason I'm interested in XINUSE denotation is that it might be helpful
>> for the XFD MSRs context switch cost during vmexit and vmenter.
> As the guest OS may be using XFD, the VMM can not use it for itself.
> Rather, the VMM must context switch it when it switches between guests.
> (or not expose it to guests at all)

My understand is that KVM cannot assume that userspace qemu uses XFD or not,
so KVM need context switch XFD between vcpu threads when vmexit/vmenter.

That's why I am thinking about detecting XINUSE when vmexit, otherwise, a
wrong armed IA32_XFD will impact XSAVES/XRSTORS causing guest AMX states
lost.

Thanks,
Jing
>
> cheers,
> -Len
>
>
> cheers,
> Len Brown, Intel Open Source Technology Center

