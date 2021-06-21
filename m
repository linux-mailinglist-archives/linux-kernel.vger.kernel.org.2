Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4543AF6B6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 22:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhFUURt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 16:17:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52510 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFUURq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 16:17:46 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624306531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=81ScfF7FRAJff1SENxfuOxVRZ7AB9lK/9rJ87bopY34=;
        b=o2tl+9Wgwu78nJ6qh+EyfQA+HveHDiSv5iu3BS3sCKzPokBf3SA2HQq86UswRswVtHzahi
        vgrEJrbesbCUdi1hln/tZacWB1DERhrCNWRayiIBMRBcciqxnZi+EpGNvngUiTH0DMFurD
        UEZUhrB4JY1CW4Da0fbunPW+aZawsNl3zZ3Sh1Phv/3EI7fSRMX51Vs54btIRTX/pKC7b6
        5+rLtvUGdxO8USKJM0x2OI3AwMpBIko73MINe9cI/SZEgl8lUaRhfiMUcvfJ2HGaUE32Z2
        R0vJHOWe28nAUdokbW3nWyuiXMGKVQRuvBVGeKIBLLu1iPpXSacblvKhZBiRTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624306531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=81ScfF7FRAJff1SENxfuOxVRZ7AB9lK/9rJ87bopY34=;
        b=VC5pvCGPeT1xp3yeu7XV8KRMBAjtsRVXP8fF0l7p9oYKYmxXfhLoPgpaIzRxiyHV/t8p59
        Uuo0QhprvXcWpxCA==
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
Subject: Re: [patch V3 22/66] x86/fpu: Move fpu__write_begin() to regset
In-Reply-To: <YNCwf72K3LH6J8/T@zn.tnic>
References: <20210618141823.161158090@linutronix.de> <20210618143446.905002907@linutronix.de> <YNCwf72K3LH6J8/T@zn.tnic>
Date:   Mon, 21 Jun 2021 22:15:30 +0200
Message-ID: <87a6njezz1.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21 2021 at 17:30, Borislav Petkov wrote:
>> @@ -89,7 +108,7 @@ int xfpregs_set(struct task_struct *targ
>>  	if (newstate.mxcsr & ~mxcsr_feature_mask)
>>  		ret = -EINVAL;
> 		^^^^^^^^^^^^^^
>
> Don't forget to fix that thing, btw.

Fixed localy at the right spot already.

>> -	fpu__prepare_write(fpu);
>> +	fpu_force_restore(fpu);
>>  
>>  	/* Copy the state  */
>>  	memcpy(&fpu->state.fxsave, &newstate, sizeof(newstate));
>> @@ -147,7 +166,7 @@ int xstateregs_set(struct task_struct *t
>>  		}
>>  	}
>>  
>> -	fpu__prepare_write(fpu);
>> +	fpu_force_restore(fpu);
>>  	ret = copy_kernel_to_xstate(&fpu->state.xsave, kbuf ?: tmpbuf);
>
> Ok, this here:
>
> fpu_force_restore() will unconditionally invalidate the fpregs but the
> following copy_kernel_to_xstate() call can return -EINVAL when the
> xstate header validation fails or mxcsr has reserved bits set so we will
> not have copied anything to the target thread.

Then the task has to restore FPU on the way to user space. Not a big
deal, it's traced - so what?

Thanks,

        tglx
