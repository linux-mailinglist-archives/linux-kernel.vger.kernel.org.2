Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8C43D9DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 08:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbhG2Gc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 02:32:58 -0400
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net ([209.97.182.222]:36212
        "HELO zg8tmja5ljk3lje4mi4ymjia.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S234079AbhG2Gc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 02:32:57 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Jul 2021 02:32:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Message-ID:Subject:From:To:Cc:
        Date:In-Reply-To:Content-Type:User-Agent:MIME-Version:
        Content-Transfer-Encoding; bh=4pYo2P+z6W9nuwjuJxarPM7VOIN56+10mm
        lJH9CAsPI=; b=iaKo9egXwKn7hDCfeY1GQBa+JjMC3rl4fwvXvaWWk1Zdz8Lpb8
        2t2naPDZDH8SkoUjskZHAzEUEvSbGBgGoRi22+8u8OgvPx+IHkuBSK0dXVi9K2a3
        oFy0pmCLtlAb+Z/wRSLFwwRC69bkqiCPgqm+SK5nkKcJVaXowGngFVYXU=
Received: from [172.31.209.114] (unknown [222.29.156.242])
        by front02 (Coremail) with SMTP id 54FpogC3vrKtSQJhZ3l_AQ--.15093S2;
        Thu, 29 Jul 2021 14:24:45 +0800 (CST)
Message-ID: <600fdad9d3955671b1a5af12d40a4e409bc7ba5f.camel@pku.edu.cn>
Subject: Re: [PATCH] x86/fault: Fix wrong signal when vsyscall fails with
 pkey
From:   Jiashuo Liang <liangjs@pku.edu.cn>
To:     dave.hansen@intel.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        liangjs@pku.edu.cn, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        x86@kernel.org
Date:   Thu, 29 Jul 2021 14:24:45 +0800
In-Reply-To: <87c4acb3-c3a9-c682-138b-0f85246e9cb8@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: 54FpogC3vrKtSQJhZ3l_AQ--.15093S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1DAw1DKw1fWw4xArWUArb_yoWrXw45pF
        yrCayDKFZ7Xr9I9an7X34UZ34F9ay7KF1DKr1xta4a93s8ZrySvr10vw48ury7A397t3WU
        tF40vw1DWa1kXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU901xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4
        x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY02Avz4vE14v_
        GF1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VWkJr1UJwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
        MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
        VFxhVjvjDU0xZFpf9x0JU-J5rUUUUU=
X-CM-SenderInfo: isqqijqrtqmio6sn3hxhgxhubq/1tbiAwERBVPy7sZOGwABsL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-07-28 at 10:57 -0700, Dave Hansen wrote:
>> When emulating vsyscall, the kernel may fail to access user-given memory
>> pages that are protected by pkey. In such a case, the kernel should send a
>> SIGSEGV signal with si_code=SEGV_PKUERR and si_pkey=pkey.
> 
> This could use a bit more context.
> 
> First of all this is for user address space faults in the
> do_user_addr_fault() path.  Second, the buggy code is under a
> !user_mode() check, so this must be a kernel fault in the user address
> space.  Third, the only notice this problem when the page fault handler
> ends up delivering a signal as a result of the fault.  Most cases will
> simply return an error code to the faulting kernel code which will see
> -EFAULT come back from copy_to/from_user() and friends.
> 
> The *only* condition in which we generate that signal from the fault
> handler is when current->thread.sig_on_uaccess_err=1, and the only place
> that gets used is in emulate_vsyscall().
> 
> This makes me want to add some code that tickles vsyscall emulation in
> the pkey selftests, but I think I'll resist the urge for now. :)
> 
> Is that all correct?

Right.

>> So a new parameter "pkey" is added to kernelmode_fixup_or_oops to fix it.
> 
> Yeah, I think that's the right fix.  You also need this:
> 
> Fixes: 5042d40a264c ("x86/fault: Bypass no_context() for implicit kernel
> faults from usermode")
> 
> I believe that's where this issue originated.

Yeah, we need to add it.

> How did you find this, by the way?

I was learning about memory protection key. So I read the related code in
kernel and spotted this.

>>  arch/x86/mm/fault.c | 23 +++++++++++++++--------
>>  1 file changed, 15 insertions(+), 8 deletions(-)
>> 
>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
>> index b2eefdefc108..883294282e1e 100644
>> --- a/arch/x86/mm/fault.c
>> +++ b/arch/x86/mm/fault.c
>> @@ -710,7 +710,8 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
>>  
>>  static noinline void
>>  kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
>> -			 unsigned long address, int signal, int si_code)
>> +			 unsigned long address, int signal, int si_code,
>> +			 u32 pkey)
>>  {
>>  	WARN_ON_ONCE(user_mode(regs));
>>  
>> @@ -735,8 +736,12 @@ kernelmode_fixup_or_oops(struct pt_regs *regs, unsigned long error_code,
>>  
>>  			set_signal_archinfo(address, error_code);
>>  
>> -			/* XXX: hwpoison faults will set the wrong code. */
>> -			force_sig_fault(signal, si_code, (void __user *)address);
>> +			if (si_code == SEGV_PKUERR) {
>> +				force_sig_pkuerr((void __user *)address, pkey);
>> +			} else {
>> +				/* XXX: hwpoison faults will set the wrong code. */
>> +				force_sig_fault(signal, si_code, (void __user *)address);
>> +			}
>>  		}
>>  
>>  		/*
>> @@ -798,7 +803,8 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
>>  	struct task_struct *tsk = current;
>>  
>>  	if (!user_mode(regs)) {
>> -		kernelmode_fixup_or_oops(regs, error_code, address, pkey, si_code);
>> +		kernelmode_fixup_or_oops(regs, error_code, address,
>> +					 SIGSEGV, si_code, pkey);
>>  		return;
>>  	}
>>  
>> @@ -930,7 +936,8 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
>>  {
>>  	/* Kernel mode? Handle exceptions or die: */
>>  	if (!user_mode(regs)) {
>> -		kernelmode_fixup_or_oops(regs, error_code, address, SIGBUS, BUS_ADRERR);
>> +		kernelmode_fixup_or_oops(regs, error_code, address,
>> +					 SIGBUS, BUS_ADRERR, 0);
>>  		return;
>>  	}
> 
> Could we please use ARCH_DEFAULT_PKEY instead of 0's in all these call
> sites?  I just detest seeing mystery functions with lots of 0's and 1's
> as parameters.

I agree that using ARCH_DEFAULT_PKEY is better. I think I am supposed to
send a patch v2 for the update?

By the way, the magic pkey number 0 also appears when bad_area_nosemaphore
calls __bad_area_nosemaphore and bad_area calls __bad_area. Do they need to
be changed to ARCH_DEFAULT_PKEY as well?

Thanks!

Jiashuo Liang


