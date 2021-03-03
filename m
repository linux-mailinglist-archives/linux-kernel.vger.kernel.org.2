Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFE432BF77
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835509AbhCCSDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382245AbhCCPWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:22:23 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0F0C0613D8
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 07:20:51 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u14so24113704wri.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 07:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kayPbw8A7iB7X1IwkMYnahJ/vHZk8i/lpZLyVsXqadA=;
        b=Ki76JYgQVoIG2qdRj46qe9zGPIt1dFW3VmcoWPhPLJol6teZDpGdkRtGVRsg1NONMo
         /nzZlCiLuZEmd5NeMXOm9/EWJMouz+HxwCpoIJ4t19npSVB6kuW6lefopzni0T7NewTZ
         UhJLToGAcqUhB+mYzJDk8G8UrGWhTAqPfJT+yomO3PTOOxQbceuuh7113nfCaYGHTOmm
         kOyCGkay0k5PH0zy5zrdWlwbKx5R7wIMkKLnDeQ3zvz173nT0p3PrbRaAbWgt1aYMQKE
         WjGxGcwUi3qFZFajvMA0g4hPhCbokx8p32FAtzAg9ReGcgP2jftet/uiMBZ2EITeLHVC
         VuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kayPbw8A7iB7X1IwkMYnahJ/vHZk8i/lpZLyVsXqadA=;
        b=MUIzWcd6ahqDkrWx1r+czX/h5I5QEcf1b7CiTPtN17KG8Jz5auO2X3N5RL8ATWkNcg
         sDR5xDAG3rhNgUOiVHes08a4Hj0oneogVSvpvW89A3cAOqsJTbbNBg/hEuF8F9bTpN9l
         H+9aeD6SoOJTgEwNcf5KvluvXmN0Nb3/BHffiOL7f+doAJ7xxctMU3FwlUmIbU6cOXzL
         E/2L6mdKu9hBPljgFdwcXdKn+GNJixCn0KQVoRPFlFxT3iQJO+UQJuV53I7juZTvdyeM
         3SEuLz6DOyA3WfET0sUjlrnJthCgwFDs/yw18jcZKgczm2EO0GRmo/eTrM2u0qfDHZ8V
         bxnQ==
X-Gm-Message-State: AOAM533GrP1jSTBYF0wPd+zZvTM+/AZXvy8YU14oBe1ergSmcUrEGizT
        NH9y7L4JTsNHnAMmuSVQJcRRWQ==
X-Google-Smtp-Source: ABdhPJwpE9naZxZIaRqiO69zCJbnioXYpQz9cNXCdFzrUs7TnwrWJjq6RN+kUn8bHstSCC3mq+o5tQ==
X-Received: by 2002:adf:fecc:: with SMTP id q12mr27405465wrs.317.1614784849639;
        Wed, 03 Mar 2021 07:20:49 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:811:228c:e84:3381])
        by smtp.gmail.com with ESMTPSA id m6sm32306902wrv.73.2021.03.03.07.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 07:20:49 -0800 (PST)
Date:   Wed, 3 Mar 2021 16:20:43 +0100
From:   Marco Elver <elver@google.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] powerpc: Include running function as first entry in
 save_stack_trace() and friends
Message-ID: <YD+o5QkCZN97mH8/@elver.google.com>
References: <e2e8728c4c4553bbac75a64b148e402183699c0c.1614780567.git.christophe.leroy@csgroup.eu>
 <CANpmjNOvgbUCf0QBs1J-mO0yEPuzcTMm7aS1JpPB-17_LabNHw@mail.gmail.com>
 <1802be3e-dc1a-52e0-1754-a40f0ea39658@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1802be3e-dc1a-52e0-1754-a40f0ea39658@csgroup.eu>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 03:52PM +0100, Christophe Leroy wrote:
> Le 03/03/2021 à 15:38, Marco Elver a écrit :
> > On Wed, 3 Mar 2021 at 15:09, Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> > > 
> > > It seems like all other sane architectures, namely x86 and arm64
> > > at least, include the running function as top entry when saving
> > > stack trace.
> > > 
> > > Functionnalities like KFENCE expect it.
> > > 
> > > Do the same on powerpc, it allows KFENCE to properly identify the faulting
> > > function as depicted below. Before the patch KFENCE was identifying
> > > finish_task_switch.isra as the faulting function.
> > > 
> > > [   14.937370] ==================================================================
> > > [   14.948692] BUG: KFENCE: invalid read in test_invalid_access+0x54/0x108
> > > [   14.948692]
> > > [   14.956814] Invalid read at 0xdf98800a:
> > > [   14.960664]  test_invalid_access+0x54/0x108
> > > [   14.964876]  finish_task_switch.isra.0+0x54/0x23c
> > > [   14.969606]  kunit_try_run_case+0x5c/0xd0
> > > [   14.973658]  kunit_generic_run_threadfn_adapter+0x24/0x30
> > > [   14.979079]  kthread+0x15c/0x174
> > > [   14.982342]  ret_from_kernel_thread+0x14/0x1c
> > > [   14.986731]
> > > [   14.988236] CPU: 0 PID: 111 Comm: kunit_try_catch Tainted: G    B             5.12.0-rc1-01537-g95f6e2088d7e-dirty #4682
> > > [   14.999795] NIP:  c016ec2c LR: c02f517c CTR: c016ebd8
> > > [   15.004851] REGS: e2449d90 TRAP: 0301   Tainted: G    B              (5.12.0-rc1-01537-g95f6e2088d7e-dirty)
> > > [   15.015274] MSR:  00009032 <EE,ME,IR,DR,RI>  CR: 22000004  XER: 00000000
> > > [   15.022043] DAR: df98800a DSISR: 20000000
> > > [   15.022043] GPR00: c02f517c e2449e50 c1142080 e100dd24 c084b13c 00000008 c084b32b c016ebd8
> > > [   15.022043] GPR08: c0850000 df988000 c0d10000 e2449eb0 22000288
> > > [   15.040581] NIP [c016ec2c] test_invalid_access+0x54/0x108
> > > [   15.046010] LR [c02f517c] kunit_try_run_case+0x5c/0xd0
> > > [   15.051181] Call Trace:
> > > [   15.053637] [e2449e50] [c005a68c] finish_task_switch.isra.0+0x54/0x23c (unreliable)
> > > [   15.061338] [e2449eb0] [c02f517c] kunit_try_run_case+0x5c/0xd0
> > > [   15.067215] [e2449ed0] [c02f648c] kunit_generic_run_threadfn_adapter+0x24/0x30
> > > [   15.074472] [e2449ef0] [c004e7b0] kthread+0x15c/0x174
> > > [   15.079571] [e2449f30] [c001317c] ret_from_kernel_thread+0x14/0x1c
> > > [   15.085798] Instruction dump:
> > > [   15.088784] 8129d608 38e7ebd8 81020280 911f004c 39000000 995f0024 907f0028 90ff001c
> > > [   15.096613] 3949000a 915f0020 3d40c0d1 3d00c085 <8929000a> 3908adb0 812a4b98 3d40c02f
> > > [   15.104612] ==================================================================
> > > 
> > > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > 
> > Acked-by: Marco Elver <elver@google.com>
> > 
> > Thank you, I think this looks like the right solution. Just a question below:
> > 
> ...
> 
> > > @@ -59,23 +70,26 @@ void save_stack_trace(struct stack_trace *trace)
> > > 
> > >          sp = current_stack_frame();
> > > 
> > > -       save_context_stack(trace, sp, current, 1);
> > > +       save_context_stack(trace, sp, (unsigned long)save_stack_trace, current, 1);
> > 
> > This causes ip == save_stack_trace and also below for
> > save_stack_trace_tsk. Does this mean save_stack_trace() is included in
> > the trace? Looking at kernel/stacktrace.c, I think the library wants
> > to exclude itself from the trace, as it does '.skip = skipnr + 1' (and
> > '.skip   = skipnr + (current == tsk)' for the _tsk variant).
> > 
> > If the arch-helper here is included, should this use _RET_IP_ instead?
> > 
> 
> Don't really know, I was inspired by arm64 which has:
> 
> void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
> 		     struct task_struct *task, struct pt_regs *regs)
> {
> 	struct stackframe frame;
> 
> 	if (regs)
> 		start_backtrace(&frame, regs->regs[29], regs->pc);
> 	else if (task == current)
> 		start_backtrace(&frame,
> 				(unsigned long)__builtin_frame_address(0),
> 				(unsigned long)arch_stack_walk);
> 	else
> 		start_backtrace(&frame, thread_saved_fp(task),
> 				thread_saved_pc(task));
> 
> 	walk_stackframe(task, &frame, consume_entry, cookie);
> }
> 
> But looking at x86 you may be right, so what should be done really ?

x86:

[    2.843292] calling stack_trace_save:
[    2.843705]  test_func+0x6c/0x118
[    2.844184]  do_one_initcall+0x58/0x270
[    2.844618]  kernel_init_freeable+0x1da/0x23a
[    2.845110]  kernel_init+0xc/0x166
[    2.845494]  ret_from_fork+0x22/0x30

[    2.867525] calling stack_trace_save_tsk:
[    2.868017]  test_func+0xa9/0x118
[    2.868530]  do_one_initcall+0x58/0x270
[    2.869003]  kernel_init_freeable+0x1da/0x23a
[    2.869535]  kernel_init+0xc/0x166
[    2.869957]  ret_from_fork+0x22/0x30

arm64:

[    3.786911] calling stack_trace_save:
[    3.787147]  stack_trace_save+0x50/0x78
[    3.787443]  test_func+0x84/0x13c
[    3.787738]  do_one_initcall+0x5c/0x310
[    3.788099]  kernel_init_freeable+0x214/0x294
[    3.788363]  kernel_init+0x18/0x164
[    3.788585]  ret_from_fork+0x10/0x30

[    3.803615] calling stack_trace_save_tsk:
[    3.804266]  stack_trace_save_tsk+0x9c/0x100
[    3.804541]  test_func+0xc4/0x13c
[    3.804803]  do_one_initcall+0x5c/0x310
[    3.805031]  kernel_init_freeable+0x214/0x294
[    3.805284]  kernel_init+0x18/0x164
[    3.805505]  ret_from_fork+0x10/0x30

+Cc arm64 folks.

So I think the arm64 version also has a bug, because I think a user of
<linux/stacktrace.h> really doesn't care about the library function
itself. And from reading kernel/stacktrace.c I think it wants to exclude
itself entirely.

It's a shame that <linux/stacktrace.h> isn't better documented, but I'm
pretty sure that including the library functions in the trace is not
useful.

For the ppc version, let's do what x86 does and start with the caller.

Thanks,
-- Marco
