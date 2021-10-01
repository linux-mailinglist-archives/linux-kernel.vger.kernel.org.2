Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8F341F63F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 22:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354985AbhJAUWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 16:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354977AbhJAUWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 16:22:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93974C061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 13:20:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633119617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xx4boFsP3j2k61TbRcsBY08l76GCU2YApMFEFazc/b8=;
        b=3huvxp1ULI1F5KDIirxWGKYVZI+r804cpdn15gfLm5z7TsytgFKNEv3L53Gf0x+ZNOjs4y
        RIhkx8CSk3NFrI9tz5D2r3MTQw/whbpOTLgdTtFVY9IJ+te2wwavlx45DQDI5WkI0hQzQI
        ELBcJHmmpOlTOUE816A0QusGSNu30JAAP4cTYqLWVuEPLKtk9ujrMi3DiQJ1lYjO6km4rs
        DbqJ/SjWsQr1AasWJCEQTPvz434YWx1HUZ6UD/mKRdkDTw+E+NC92HUhg6HmhhcT01Pmrq
        7K6hE0pMaudObX6wL2WLG3rnBJC3gYnpJpoa4C7lUzZwbFmQo+DUlqIojAOsiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633119617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xx4boFsP3j2k61TbRcsBY08l76GCU2YApMFEFazc/b8=;
        b=ERgozT4JHKXwZjmJrusbt9JluuK/+VgCIjVc1uysNUYKPhxTg8WkMUne5QjQrxbnQAsnjt
        fJc85HjQtMo+b0Dg==
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
Date:   Fri, 01 Oct 2021 22:20:16 +0200
Message-ID: <87ee944hvj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chang,

On Fri, Oct 01 2021 at 17:02, Thomas Gleixner wrote:
> On Wed, Aug 25 2021 at 08:53, Chang S. Bae wrote:
>> +/**
>> + * xfd_switch - Switches the MSR IA32_XFD context if needed.
>> + * @prev:	The previous task's struct fpu pointer
>> + * @next:	The next task's struct fpu pointer
>> + */
>> +static inline void xfd_switch(struct fpu *prev, struct fpu *next)
>> +{
>> +	u64 prev_xfd_mask, next_xfd_mask;
>> +
>> +	if (!cpu_feature_enabled(X86_FEATURE_XFD) || !xfeatures_mask_user_dynamic)
>> +		return;
>
> This is context switch, so this wants to be a static key which is turned
> on during init when the CPU supports XFD and user dynamic features are
> available.
>
>> +
>> +	prev_xfd_mask = prev->state_mask & xfeatures_mask_user_dynamic;
>> +	next_xfd_mask = next->state_mask & xfeatures_mask_user_dynamic;
>> +
>> +	if (unlikely(prev_xfd_mask != next_xfd_mask))
>> +		wrmsrl_safe(MSR_IA32_XFD, xfeatures_mask_user_dynamic ^ next_xfd_mask);
>> +}
>> +
>>  /*
>>   * Delay loading of the complete FPU state until the return to userland.
>>   * PKRU is handled separately.
>>   */
>> -static inline void switch_fpu_finish(struct fpu *new_fpu)
>> +static inline void switch_fpu_finish(struct fpu *old_fpu, struct fpu *new_fpu)
>>  {
>> -	if (cpu_feature_enabled(X86_FEATURE_FPU))
>> +	if (cpu_feature_enabled(X86_FEATURE_FPU)) {
>>  		set_thread_flag(TIF_NEED_FPU_LOAD);
>> +		xfd_switch(old_fpu, new_fpu);
>
> Why has this to be done on context switch? Zero explanation provided.
>
> Why can't this be done in exit_to_user() where the FPU state restore is
> handled?

DEFINE_PER_CPU(xfd_state);

update_xfd(fpu)
{
	if (__this_cpu_read(xfd_state) != fpu->xfd_state) {
		wrmsrl(XFD, fpu->xfd_state);
		__this_cpu_write(xfd_state, fpu->xfd_state);
	}
}

fpregs_restore_userregs()
{
	if (!fpregs_state_valid(fpu, cpu)) {
        	if (static_branch_unlikely(xfd_switching_enabled))
                	update_xfd(fpu);
	...
	}
}

Hmm?

Thanks,

        tglx
