Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037413E0A49
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 00:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhHDWX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 18:23:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:14736 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhHDWXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 18:23:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="194300043"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="194300043"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 15:23:08 -0700
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="512252564"
Received: from bguvendi-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.99.93])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 15:23:07 -0700
Subject: Re: [PATCH v5 11/12] x86/tdx: Don't write CSTAR MSR on Intel
To:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter H Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20210804181329.2899708-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210804181329.2899708-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YQrdFLPaUnC8Q5bn@google.com>
 <4c1ee7b9-9941-fdc4-73f5-3d2ef0530556@linux.intel.com>
 <2f2f0bfa-4881-81dc-65a3-1e5c7cbf85c0@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <a177ac69-552d-9cd1-7125-6cb92d07d604@linux.intel.com>
Date:   Wed, 4 Aug 2021 15:23:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2f2f0bfa-4881-81dc-65a3-1e5c7cbf85c0@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/4/21 2:48 PM, Dave Hansen wrote:
>> No, #GP is triggered by guest.
> ...
>>> Regardless of #GP versus #VE, "Table 16.2 MSR Virtualization" needs
>>> to state the actual behavior.
>> Even in this case, it will trigger #VE. But since CSTAR MSR is not
>> supported, write to it will fail and leads to #VE fault.
> Sathya, I think there might be a mixup of terminology here that's
> confusing.  I'm confused by this exchange.
> 
> In general, we refer to hardware exceptions by their architecture names:
> #GP for general protection fault, #PF for page fault, #VE for
> Virtualization Exception.
> 
> Those hardware exceptions are wired up to software handlers:
> #GP lands in asm_exc_general_protection
> #PF ends up in exc_page_fault
> #VE ends up in exc_virtualization_exception
> ... and more of course
> 
> But, to add to the confusion, the #VE handler
> (exc_virtualization_exception()) itself calls (or did once upon a time
> call) do_general_protection() when it can't handle something.
> do_general_protection() is (was?)*ALSO*  called by the #GP handler.
> 
> So, is that what you meant?  By "#GP is triggered by guest", you mean
> that a write to the CSTAR MSR and the resulting #VE will end up being
> handled in a way that is similar to how a #GP hardware exception would
> have been handled?
> 
> If that's what you meant, I'm not_sure_  that's totally accurate.  Could
> you elaborate on this a bit?  It also would be really handy if you were
> able to adopt the terminology I talked about above.  It will really make
> things less confusing.


In TDX guest, MSR write will trigger #VE which will be handled by
exc_virtualization_exception()->tdg_handle_virtualization_exception().
Internally this exception handler emulates the "MSR write" using
hypercalls. But if the hypercall returns failure, then it means we
failed to handle the #VE exception. In such cases,
exc_virtualization_exception() handler will trigger #GP like behavior
using ve_raise_fault(). ve_raise_fault() is the customized version of
do_general_protection(). This what I meant by guest triggers #GP(0).

Since CSTAR_MSR is not supported/used in Intel platforms, instead of
going through all these processes before triggering the failure, we
have added the exception for it before it is used.

Following are the implementation details:

static void ve_raise_fault(struct pt_regs *regs, long error_code)
{
         struct task_struct *tsk = current;

         if (user_mode(regs)) {
                 tsk->thread.error_code = error_code;
                 tsk->thread.trap_nr = X86_TRAP_VE;

                 /*
                  * Not fixing up VDSO exceptions similar to #GP handler
                  * because we don't expect the VDSO to trigger #VE.
                  */
                 show_signal(tsk, SIGSEGV, "", VEFSTR, regs, error_code);
                 force_sig(SIGSEGV);
                 return;
         }

         if (fixup_exception(regs, X86_TRAP_VE, error_code, 0))
                 return;

         tsk->thread.error_code = error_code;
         tsk->thread.trap_nr = X86_TRAP_VE;

         /*
          * To be potentially processing a kprobe fault and to trust the result
          * from kprobe_running(), we have to be non-preemptible.
          */
         if (!preemptible() &&
             kprobe_running() &&
             kprobe_fault_handler(regs, X86_TRAP_VE))
                 return;

         notify_die(DIE_GPF, VEFSTR, regs, error_code, X86_TRAP_VE, SIGSEGV);

         die_addr(VEFSTR, regs, error_code, 0);
}


DEFINE_IDTENTRY(exc_virtualization_exception)
{
         struct ve_info ve;
         int ret;

         RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");

         inc_irq_stat(tdg_ve_count);

         /*
          * NMIs/Machine-checks/Interrupts will be in a disabled state
          * till TDGETVEINFO TDCALL is executed. This prevents #VE
          * nesting issue.
          */
         ret = tdg_get_ve_info(&ve);

         cond_local_irq_enable(regs);

         if (!ret)
                 ret = tdg_handle_virtualization_exception(regs, &ve);
         /*
          * If tdg_handle_virtualization_exception() could not process
          * it successfully, treat it as #GP(0) and handle it.
          */
         if (ret)
                 ve_raise_fault(regs, 0);

         cond_local_irq_disable(regs);

}
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
