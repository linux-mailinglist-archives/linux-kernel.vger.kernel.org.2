Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1060A41F0A9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354909AbhJAPML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:12:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58142 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354784AbhJAPMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:12:09 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633101024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b+a23XRD7uU4p22X7KfXj5YQzPH/GT531H4urCIWAV8=;
        b=AePmzBoAYC3d2ni2OpWApffymvGLK2oEVm1mT1xaVzLo1Gcf4QvnxA8rA+MhxIqOpQ/ik3
        UY/DTJAby70M3qp6LThmN0fViE+IrdlI/lTUoZAhV+kH1pXKRPsy9oEIJAPwRwOcYHM9IL
        A3ORstNS/e11koReXZG8TLh67GkQvBv/ojLS9HWcUITM5biVKIZf553YBm0i7KxkL8vbDO
        3Rywh0uoqABmNKukjhALtgraJEnHE53ixnZE1fc4f8DgOu5f8YL6H6zgUnTzxm3ib+BnM5
        EYoGXaLSzTyOj7RH+70+Qo5W7QteTRW1nweA9DDi3kJgVFv3ImgNiOz5/p+BBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633101024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b+a23XRD7uU4p22X7KfXj5YQzPH/GT531H4urCIWAV8=;
        b=u3LSiu/rBuzrlGVbL7NXpPWKcOdN8Z3fWlOsvGePvR4t0+/xRPSMu6FXhlO6DR9FJLmtpy
        wJ3iyBFlv2YD4lBw==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v10 13/28] x86/fpu/xstate: Use feature disable (XFD) to
 protect dynamic user state
In-Reply-To: <871r546b52.ffs@tglx>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
 <20210825155413.19673-14-chang.seok.bae@intel.com> <871r546b52.ffs@tglx>
Date:   Fri, 01 Oct 2021 17:10:23 +0200
Message-ID: <87wnmw4w80.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 01 2021 at 17:02, Thomas Gleixner wrote:
> On Wed, Aug 25 2021 at 08:53, Chang S. Bae wrote:
>>  DEFINE_IDTENTRY(exc_device_not_available)
>>  {
>>  	unsigned long cr0 = read_cr0();
>
>> +	if (handle_xfd_event(&current->thread.fpu, regs))
>> +		return;
>
> As I said before, this is wrong because at that point interrupts are disabled.

So you want something like this:

static bool handle_xfd_event(struct pt_regs *regs)
{
	u64 xfd_err, xfd_event, xfd, mask;
	struct fpu *fpu;

	if (!cpu_feature_enabled(X86_FEATURE_XFD))
		return false;

	rdmsrl_safe(MSR_IA32_XFD_ERR, &xfd_err);
	if (!xfd_err)
		return false;

	wrmsrl_safe(MSR_IA32_XFD_ERR, 0);

	xfd_event = xfd_err & xfeatures_mask_user_dynamic;

	/* Die if a non-handled feature raised the exception */
	if (WARN_ON(!xfd_event))
		return true;

	/* Die if that happens in kernel space */
	if (WARN_ON(!user_mode(regs)))
		return false;

	local_irq_enable();

	/* Make sure that dynamic buffer expansion is permitted. */
	if (dynamic_state_permitted(current, xfd_event) &&
	    !realloc_xstate_buffer(current, xfd_event)) {
		mask = xfeatures_mask_user_dynamic;
                fpu = &current->thread.fpu;
		xfd_write((fpu->state_mask & mask) ^ mask);
	} else {
		force_sig_fault(SIGILL, ILL_ILLOPC, error_get_trap_addr(regs));
	}

	local_irq_disable();
	return true;
}

Along with a correct implementation of realloc_xstate_buffer().

Thanks,

        tglx
