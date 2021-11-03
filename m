Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954D9444A8C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 22:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhKCWBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 18:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbhKCWBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 18:01:36 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59170C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 14:58:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u11so8034781lfs.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 14:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uN9ka6URkJS6ixs04WuJ/27MVS7/vwxluTQETDjSYCk=;
        b=IMGsgE0BCuyM2vlijqI4eZO874OVQRr+hEt6PU8LsDKaVnsoPsBmOJ4KsxsY/Uvhlt
         SVNU+Yos/BkIRGeB6z20tZBGGGviEA3DeFPTIulmGVNy7ycrD4FAdjK67/bQDPEs3ku1
         OT5/j7BlA/btSnP2ZrJ7ZxLnKrfzGNO5GNTAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uN9ka6URkJS6ixs04WuJ/27MVS7/vwxluTQETDjSYCk=;
        b=tg9ZsfsoeTYQ71SN3zXOgz3rnILZdYhuGUR5zkd7BsjdUmv4q3KMOaQoFMCg1xKY+Q
         uamvPHI55w7uHba1EI+dmxtH3po2xorldWcXEh7pApHEvemawWgiG0GOMvS8ZFaOef4+
         VnzekO9sIVaS5SDlimBKb7Iesry6HydiXXV4EFLKRV3bfJ0ee6v9pRKchJT89A8hLMQR
         GsDIcVv/UxNf/aMg/0sFOQjReWm3Xe0BBYgrGQCJR2hUkkVSnVi9A7StNjkzigUDrYXw
         EZuSlxU4L3QD5TweO2Wz0mZGpPFX41AfhNCZx5Klwa9NTL6mhcuN5AvMDjyrdaGjbu5E
         aT+A==
X-Gm-Message-State: AOAM530/Wd71y89rMrhvcP74UZal2xCcYGFyf9q22n+LfTDlf7QXmzvS
        ARInDs/gOSmL7DEm4MNEZTYhoNifQVuj219Y
X-Google-Smtp-Source: ABdhPJx+9w2neUfuXwheRlizGJxS2A+VsPFL7SkYQYuDSVUdxoPh/qFFUhROi4V5CuMwfEdBeDbEHQ==
X-Received: by 2002:a05:6512:1594:: with SMTP id bp20mr25911054lfb.145.1635976737288;
        Wed, 03 Nov 2021 14:58:57 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id s16sm16415lfp.82.2021.11.03.14.58.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 14:58:56 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id v23so6220856ljk.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 14:58:56 -0700 (PDT)
X-Received: by 2002:a2e:89d4:: with SMTP id c20mr50850645ljk.191.1635976735794;
 Wed, 03 Nov 2021 14:58:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211103163340.435ba5b1@gandalf.local.home>
In-Reply-To: <20211103163340.435ba5b1@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Nov 2021 14:58:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi63LDzMV1sSiPuH8q38tMZ0_b+w9bUVW=P_O1+rkW28A@mail.gmail.com>
Message-ID: <CAHk-=wi63LDzMV1sSiPuH8q38tMZ0_b+w9bUVW=P_O1+rkW28A@mail.gmail.com>
Subject: Re: [STACK DUMP][5.16-rc?] from (cpufreq: intel_pstate: Process HWP
 Guaranteed change notification)
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        pablomh@gmail.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 3, 2021 at 1:33 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The RIP of cpuidle_enter_state+0xd6/0x3a0 gives me in gdb:

That's not actually the error address - it's not an oops. That's just
the register data at the interrupt entry.

The error was that triggered this was that

    unchecked MSR access error:
        WRMSR to 0x773 (tried to write 0x0000000000000000)
        at rIP: 0xffffffffab06e824 (native_write_msr+0x4/0x20)

and then it prints the stack frame - because we shouldn't be doing
random MSR writes.

And part of printing the stack frame is printing the register state at
kernel entries when switching to an interrupt or exception stack.

So that RIP you point to is not really interesting, and it looks like
it's an entirely random harmless instruction, it's just that it is
preceded by that

        sti
        nopw

so it's not surprising that it's an interrupt point, because it's
exactly one instruction after interrupts were enabled on that CPU (the
one instruction being the sti shadow that itself doesn't take
interrupts).

So cpuidle_enter_state() itself is entirely harmless, and you see that
in the call chain presumably simply because the CPU was idle when the
interrupt happened. Again, that's a very reasonable place for an
interrupt to happen.

End result: all of this is simply due to an unexpected MSR write, and
the real issue is that interrupt from an IPI that caused the WRMSR
write on another CPU:

    __wrmsr_on_cpu+0x33/0x40
    flush_smp_call_function_queue+0x122/0x1a0
    __sysvec_call_function_single+0x29/0xc0
    sysvec_call_function_single+0x9d/0xd0

and the rest of the call chain is just noise from "whatever that CPU
happened to do when it got the IPI".

You don't get the call chain of whatever actually did the IPI, I'm
afraid. That's the actual _cause_ of all this, but that happens on
another CPU entirely.

> I bisected it down to:
>
>  57577c996d73 ("cpufreq: intel_pstate: Process HWP Guaranteed change notification")
>
> Removing the commit makes the issue go away. Adding it back brings it back'

That commit does various odd things.

The code seems to depend on the 'hwp_notify_lock' spinlock, but then
it does some work outside that locked region (exactly because that
work triggers an interrupt that needs that lock):

      wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);

and that's exactly what will then warn because that MSR hasn't been
enabled on that CPU.

But it also does randomly do some READ_ONCE/WRITE_ONCE magic that all
seems entirely bogus. Those values should be protected by the lock.

The way it cancels delayed work is also very questionable: it does

        spin_lock_irqsave(&hwp_notify_lock, flags);
        if (cpumask_test_and_clear_cpu(cpudata->cpu, &hwp_intr_enable_mask))
                cancel_delayed_work(&cpudata->hwp_notify_work);
        spin_unlock_irqrestore(&hwp_notify_lock, flags);

but if the delayed work was already started on that cpu, then it will
continue running concurrently, even if the caller now thinks it's all
disabled.

You need the "sync" version to make sure the work is also waited on,
but you can't do that under the spinlock that the work in question may
need, of course.

> So I'm guessing that this commit calls some code that does not expect to be
> called on powering off, at least in debug mode, and is triggering this
> stack dump. Probably because there was some static call or something that
> isn't shutdown properly.

It actually looks more direct than that to me: the code literally
seems to do that wrmsrl_on_cpu() that triggers the IPI that actually
causes the unchecked MSR write.

I don't know this hardware, and I don't know that code, but there are
certainly a few red flags here.

Srinivas?

              Linus
