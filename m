Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA5C39F4C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 13:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhFHLTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 07:19:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47354 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbhFHLTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:19:40 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623151066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5T+GMiDIBmF3KCptbG4LCBZPtno08qjjlXw+ihnp/3U=;
        b=JAFMmN8ZsbfhOh9eH/fDvii4UPfJpAv/zlezyK2IK64AdfkGiq8W4VyUxtF7HIK2pbQR/y
        Y3kn8g83ahP9p8xb0GQh0NBr9OzhdGCkO52GOg3y+tSfhpRIo9DXGVuwVHtY0U9c21kqMh
        qWX24B7lpExr52tgzt1khiFrcY6RtiwlNWYaveOwryGMyOuNfJiat1fGK4zW0+ODl+TUIl
        VNg0h3GLtDOUKkLcn0d90C4x8/5+TJYf2qOr6PNmBorGbHbs2Ss8G4PRGOCH/tPLJAgoJD
        kmZ4RFaUo1XKnAXvpi+i2CwgkIklbwqbBaUY5bmhMWEH35PHahP2meBweUf9gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623151066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5T+GMiDIBmF3KCptbG4LCBZPtno08qjjlXw+ihnp/3U=;
        b=CdLoEFPSKH3zNAFOGbH32Xi2iM5UlzLOWX/1UBVyBPQLt7KNoXnzp8UxApo+eMHTg7jpSa
        dIFiGGKEdoOx7rCw==
To:     Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch V2 00/14] x86/fpu: Mop up XSAVES and related damage
In-Reply-To: <37df631f-9d3d-3035-6eeb-85ef33e580d5@intel.com>
References: <20210605234742.712464974@linutronix.de> <87h7i9zv3r.ffs@nanos.tec.linutronix.de> <eca0add1-849e-6a1a-8ea6-f6b72650c9c8@intel.com> <87eeddzs0l.ffs@nanos.tec.linutronix.de> <37df631f-9d3d-3035-6eeb-85ef33e580d5@intel.com>
Date:   Tue, 08 Jun 2021 13:17:46 +0200
Message-ID: <878s3kzjtx.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07 2021 at 09:38, Dave Hansen wrote:
> On 6/7/21 7:08 AM, Thomas Gleixner wrote:
>>> By the way, are you talking specifically about the _error_ paths where
>>> the kernel is unable to XRSTOR the signal XSAVE buffer for some reason,
>>> and tries to apply either init_fpu or the hardware init state instead?
>> 
>> 1) Successful XRSTOR from user if the PKRU feature bit in the
>>    sigframe xsave.header.xfeatures is cleared. Both fast and slow path.
>
> It seems like the suggestion here is to inject 'init_pkru_value' in all
> cases where the kernel would be injecting the hardware init value.  I
> don't think we should go that far.
>
> If a signal handler sets xsave.header.xfeatures[PKRU]=0, I can't imagine
> any other intent than wanting the hardware init value.

Fine. But PKRU=0 is broken today...

T1 in user space
     wrpkru(0)

T1 -> kernel
     schedule()
       XSAVE(S) -> T1->xsave.header.xfeatures[PKRU] == 0
       T1->flags |= TIF_NEED_FPU_LOAD;
       
       wrpkru();

     schedule()
       ...
       pk = get_xsave_addr(&T1->fpu->state.xsave, XFEATURE_PKRU);
       if (pk)
         wrpkru(pk->pkru);
       else
         wrpkru(DEFAULT_PKRU);

But because PKRU of T1 was 0, the xfeatures bit is 0 and therefore the
value in the xsave storage is not valid. Which makes get_xsave_addr()
return NULL and switch_to() writes the default PKRU.

So that wreckages any copy_to/from_user() on the way back to user space
which hits memory which is protected by the default PKRU value.

Assumed that this does not fail (pure luck) then T1 goes back to user
space and because TIF_NEED_FPU_LOAD is set it ends up in

switch_fpu_return()
    __fpregs_load_activate()
      if (!fpregs_state_valid()) {
         load_XSTATE_from_task();
      }

But because nothing touched the FPU between schedule out and schedule in
of T1 the fpregs_state is valid so switch_fpu_return() does nothing and
just clears TIF_NEED_FPU_LOAD. Back to user space with DEFAULT_PKRU
loaded. FAIL!

XSTATE sucks.

Thanks,

        tglx
