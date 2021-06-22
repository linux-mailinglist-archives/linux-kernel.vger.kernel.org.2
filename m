Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75293B0D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbhFVSpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:45:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59734 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbhFVSpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:45:34 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624387397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oybOdYXCqWYeZ/5b0inlbheGPwXsyP77hruRcepjW/c=;
        b=JrH780rsRTYi2MRAQfRP2O6Yw0GXvDa0IGCjysJSIGDkoRewFGic8a6Lf7bBuCVAVFIm8U
        dd12AQVnv5cjgl73ng4HIUyQkL969y6lrXO1YB+flHhDni26/Qd8W5XSyRDGjcOewwBdyj
        u+WlmxzA4t/Vy4DGmM4m+2+mJAVKuSsesyn7DBwIsJoaRvLAOHEwmFlF0xKEmxIMqBlzhP
        0nEVM6rZUiEh0x562FkwXadKa8DQzSpFdivoHlnfi0mMqO4B8F4oSojh7Wtyy+ssiY+uwn
        Yj8IPtmIkLBcUJT5bT+umbhSIjMGWeulqRuKW3banOnIWsZFvPqTXSgG6Xf1vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624387397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oybOdYXCqWYeZ/5b0inlbheGPwXsyP77hruRcepjW/c=;
        b=cg3xIVaT5z4riTbPTML1JX6iEMMLiakV2QjZPyAZbxLgRX0IYR9OtyQtU5La0swRctwK9V
        eQPBisjrxitCaUCg==
To:     Borislav Petkov <bp@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch V3 59/66] x86/fpu/signal: Move initial checks into fpu__sig_restore()
In-Reply-To: <87h7hpeoda.ffs@nanos.tec.linutronix.de>
References: <20210618141823.161158090@linutronix.de> <20210618143451.099973627@linutronix.de> <YNIfdidWt/nRwIPa@zn.tnic> <87h7hpeoda.ffs@nanos.tec.linutronix.de>
Date:   Tue, 22 Jun 2021 20:43:16 +0200
Message-ID: <87eecteo57.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22 2021 at 20:38, Thomas Gleixner wrote:

> On Tue, Jun 22 2021 at 19:35, Borislav Petkov wrote:
>> On Fri, Jun 18, 2021 at 04:19:22PM +0200, Thomas Gleixner wrote:
>>>  
>>> +	if (unlikely(!buf)) {
>>> +		fpu__clear_user_states(&current->thread.fpu);
>>
>> You could declare
>>
>> 	struct fpu *fpu = &tsk->thread.fpu;
>>
>> above so that it is easier to read, as this call is done twice.
>>
>> Also, you can do:
>>
>> 	int ret = 0;
>>
>> 	if (unlikely(!buf))
>> 		goto out;
>>
>> so that the exit paths converge at the end.
>
> I pondered, but look at the condition there. It gets unreadable.
>
> So I kept is as is because this is an intentional clear which returns
> success and the other is on error.
>
>>> +	if (!IS_ENABLED(CONFIG_X86_64) && !static_cpu_has(X86_FEATURE_FPU)) {
>>
>> cpu_feature_enabled()
>>
>>> +		return fpregs_soft_set(current, NULL, 0,
>>> +				       sizeof(struct user_i387_ia32_struct),
>>> +				       NULL, buf);
>>
>> Err, don't you need to catch retval into ret here and goto out, like
>> before, so that you can call fpu__clear_user_states() on error?
>
> Yes. Actually we should do that as a separate patch way earlier in the
> series. Sigh.

Bah, no. I screwed that up. Blush
