Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86423A0486
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 21:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbhFHTgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 15:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237639AbhFHT2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 15:28:42 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA453C061148
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 12:16:48 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id l17so12000427qtq.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 12:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uHTFoDD2O3XxUu2ApfYaRifJcD/a1u00RJeF5PwVfbg=;
        b=oMS6y0+QT6JcTo3EG3x1H5kMSriSWn6ed6ob97ZYl3wfbHAMikabk+rnPCdbhEE2QS
         EN/EzeK59Cm1I/+CHGwIZf8zaPBbvS6kNfksZg/O3Mvc/64UUqQQGkh41I7kMVe24Xs2
         Eb4EpmX3MFNCsRZ5ShOHt38L1a6YtfRmfxxYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uHTFoDD2O3XxUu2ApfYaRifJcD/a1u00RJeF5PwVfbg=;
        b=fRpTt6c27C2n8DLaAL18ohKaRDVcPbgGTMHPijfP66cBH+aFRL2BXVeDS/6zogB2ll
         YpMtGchOvSrCqOxtL7gVKvIHhGPZufgRrhLpIx48SrnutQwJCI8yYoaHRAhSOpoBuW6m
         0OGrRtJZoGsP7iz8JcfYRJVI3WJPwIerJ3252RGY+9ThONbh3AC2/CX5njKWH/hR42Hf
         vV/yQJ6wuVYVKXz3WepQnAhCbE0oO5kPSZM+0aSgFXPWZukCUgOofQgaYzQM0C+H5Uy6
         IxzGYu9z/jx1ltwAUn5a5kL03jXVjc8/SYl7x8gmYUx2XYPiF0q8NnGMajTLiSsXH/GV
         GkHg==
X-Gm-Message-State: AOAM533u+Ed4ANFc69PnhENgVKRLJdSna2/DJpg7MJj26z9EYFQy5Ope
        MvNFYYAEEv1f9moGgM+/OlRG+A==
X-Google-Smtp-Source: ABdhPJwn5hXYB4alVXuSZL3TLzcwRvW2ym9D9JRLn90Sf5mVfDOUc9IFdcbp67/IgsMccSQt5m2euQ==
X-Received: by 2002:ac8:7699:: with SMTP id g25mr16462363qtr.309.1623179805492;
        Tue, 08 Jun 2021 12:16:45 -0700 (PDT)
Received: from localhost ([2620:15c:6:411:e3b6:6e12:5019:bd58])
        by smtp.gmail.com with ESMTPSA id a134sm10691083qkg.114.2021.06.08.12.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:16:44 -0700 (PDT)
Date:   Tue, 8 Jun 2021 15:16:44 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Zhengyejian (Zetta)" <zhengyejian1@huawei.com>,
        rostedt@goodmis.org, ccross@android.com,
        linux-kernel@vger.kernel.org, Zhangjinhao <zhangjinhao2@huawei.com>
Subject: Re: [BUG] I found a bug when try to enable record_ftrace
Message-ID: <YL/CHEbw5L2Selfm@google.com>
References: <01472d0f-55c1-15ea-9beb-5d64b322bb44@huawei.com>
 <202106021042.8527F3AB30@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106021042.8527F3AB30@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 10:43:29AM -0700, Kees Cook wrote:
> 
> On Wed, Jun 02, 2021 at 03:42:23PM +0800, Zhengyejian (Zetta) wrote:
> > Hello,
> > 
> > There may be a deadlock caused by ftrace recursion when try to enable
> > record_ftrace.
> 
> Hi,
> 
> Thanks for the report. Joel, is this something you can take a look at?

Kees,

Sorry for late reply. Right now I am dealing with a production-stop bug and
would not likely get time. Plus I feel a bit less motivated, because the
ftrace in pstore the way it stands now is unusable due to perf issues anyway
(I wonder if anyone uses it at all now). I would rather someone who has time
to work on this try to revive: https://lkml.org/lkml/2020/9/2/1075 . Should
we just delete pstore function tracing till then?

-Joel


> -Kees
> 
> > I'd like to known if the patchset
> > (https://lore.kernel.org/lkml/20201106023235.367190737@goodmis.org/) is
> > trying to fix it.
> > 
> > Procedure for reproducing the problem is:
> >   1) this problem appears both in 5.13-rc4 and 5.10;
> > 
> >   2) my work environment is:
> >     qemu-arm version 4.0.0
> >     arm-linux-gnueabi-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
> > 
> >   3) then try to enable record_ftrace:
> >     / # mount -t pstore pstore /sys/fs/pstore
> >     / # echo 1 > /sys/kernel/debug/pstore/record_ftrace
> > 
> >   4) then system appears to be stuck, and use arm-linux-gnueabi-gdb dump the
> > following call stack:
> >     #0  arch_spin_lock (lock=0x811a0f98) at
> > /home/zyj/Linux/linux-master/arch/arm/include/asm/spinlock.h:74
> >     #1  do_raw_spin_lock_flags (flags=<synthetic pointer>, lock=0x811a0f98)
> > at /home/zyj/Linux/linux-master/include/linux/spinlock.h:195
> >     #2  __raw_spin_lock_irqsave (lock=0x811a0f98) at
> > /home/zyj/Linux/linux-master/include/linux/spinlock_api_smp.h:119
> >     #3  _raw_spin_lock_irqsave (lock=lock@entry=0x811a0f98) at
> > /home/zyj/Linux/linux-master/kernel/locking/spinlock.c:159
> >     #4  0x8046c6e0 in buffer_size_add (prz=prz@entry=0x811a0f80,
> > a=a@entry=16) at /home/zyj/Linux/linux-master/fs/pstore/ram_core.c:82
> >     #5  0x8046cc20 in persistent_ram_write (prz=0x811a0f80, s=0x81137b80,
> > count=16) at /home/zyj/Linux/linux-master/fs/pstore/ram_core.c:327
> >     #6  0x8046b438 in ramoops_pstore_write (record=0x81137b90) at
> > /home/zyj/Linux/linux-master/fs/pstore/ram.c:331
> >     #7  0x8046add8 in pstore_ftrace_call (ip=2156609456,
> > parent_ip=2152122068, op=<optimized out>, fregs=<optimized out>)
> >         at /home/zyj/Linux/linux-master/fs/pstore/ftrace.c:54
> >     #8  0x801dd580 in __ftrace_ops_list_func (ignored=0x0, fregs=0x0,
> > parent_ip=2152122068, ip=2156609456) at
> > /home/zyj/Linux/linux-master/kernel/trace/ftrace.c:7003
> >     #9  ftrace_ops_list_func (ip=2156609456, parent_ip=2152122068,
> > op=<optimized out>, fregs=0x0) at
> > /home/zyj/Linux/linux-master/kernel/trace/ftrace.c:7028
> >     #10 0x801109f8 in ftrace_caller () at
> > /home/zyj/Linux/linux-master/arch/arm/kernel/entry-ftrace.S:224
> >     #11 0x808b3fb4 in _raw_spin_unlock_irqrestore
> > (lock=lock@entry=0x811a0f98, flags=1610612883) at
> > /home/zyj/Linux/linux-master/kernel/locking/spinlock.c:190
> >     #12 0x8046c6d4 in buffer_size_add (prz=prz@entry=0x811a0f80,
> > a=a@entry=16) at /home/zyj/Linux/linux-master/fs/pstore/ram_core.c:95
> >     #13 0x8046cc20 in persistent_ram_write (prz=0x811a0f80, s=0x81137cf8,
> > count=16) at /home/zyj/Linux/linux-master/fs/pstore/ram_core.c:327
> >     #14 0x8046b438 in ramoops_pstore_write (record=0x81137d08) at
> > /home/zyj/Linux/linux-master/fs/pstore/ram.c:331
> >     #15 0x8046add8 in pstore_ftrace_call (ip=2148632188,
> > parent_ip=2148601660, op=<optimized out>, fregs=<optimized out>)
> >         at /home/zyj/Linux/linux-master/fs/pstore/ftrace.c:54
> >     #16 0x801dd580 in __ftrace_ops_list_func (ignored=0x0, fregs=0x0,
> > parent_ip=2148601660, ip=2148632188) at
> > /home/zyj/Linux/linux-master/kernel/trace/ftrace.c:7003
> >     #17 ftrace_ops_list_func (ip=2148632188, parent_ip=2148601660,
> > op=<optimized out>, fregs=0x0) at
> > /home/zyj/Linux/linux-master/kernel/trace/ftrace.c:7028
> >     #18 0x801109f8 in ftrace_caller () at
> > /home/zyj/Linux/linux-master/arch/arm/kernel/entry-ftrace.S:224
> >     #19 0x80118680 in __set_fixmap (idx=idx@entry=FIX_TEXT_POKE0,
> > phys=phys@entry=0, prot=prot@entry=0) at
> > /home/zyj/Linux/linux-master/arch/arm/mm/mmu.c:385
> >     #20 0x80110f3c in patch_unmap (flags=<synthetic pointer>, fixmap=129) at
> > /home/zyj/Linux/linux-master/arch/arm/kernel/patch.c:45
> >     #21 __patch_text_real (addr=addr@entry=0x808b3fb0
> > <_raw_spin_unlock_irqrestore+16>, insn=insn@entry=3957420680,
> > remap=remap@entry=true)
> >         at /home/zyj/Linux/linux-master/arch/arm/kernel/patch.c:104
> >     #22 0x80110b40 in __patch_text (insn=3957420680, addr=0x808b3fb0
> > <_raw_spin_unlock_irqrestore+16>) at
> > /home/zyj/Linux/linux-master/arch/arm/include/asm/patch.h:10
> >     #23 ftrace_modify_code (pc=2156609456, old=3904716800, new=3957420680,
> > validate=true) at /home/zyj/Linux/linux-master/arch/arm/kernel/ftrace.c:95
> >     #24 0x80110cf4 in ftrace_make_call (rec=rec@entry=0x81007ce0,
> > addr=addr@entry=2148600280) at
> > /home/zyj/Linux/linux-master/arch/arm/kernel/ftrace.c:132
> >     #25 0x801dda40 in __ftrace_replace_code (rec=rec@entry=0x81007ce0,
> > enable=enable@entry=true) at
> > /home/zyj/Linux/linux-master/kernel/trace/ftrace.c:2524
> >     #26 0x801de17c in ftrace_replace_code (mod_flags=mod_flags@entry=1) at
> > /home/zyj/Linux/linux-master/kernel/trace/ftrace.c:2554
> >     #27 0x801de39c in ftrace_modify_all_code (command=5) at
> > /home/zyj/Linux/linux-master/kernel/trace/ftrace.c:2698
> >     #28 0x80110ad8 in __ftrace_modify_code (data=<optimized out>) at
> > /home/zyj/Linux/linux-master/arch/arm/kernel/ftrace.c:39
> >     #29 0x801d4da4 in multi_cpu_stop (data=data@entry=0x81c69d84) at
> > /home/zyj/Linux/linux-master/kernel/stop_machine.c:240
> >     #30 0x801d4a14 in cpu_stopper_thread (cpu=<optimized out>) at
> > /home/zyj/Linux/linux-master/kernel/stop_machine.c:511
> >     #31 0x8014de3c in smpboot_thread_fn (data=0x810c1c80) at
> > /home/zyj/Linux/linux-master/kernel/smpboot.c:165
> >     #32 0x8014a0dc in kthread (_create=0x810c1d40) at
> > /home/zyj/Linux/linux-master/kernel/kthread.c:313
> >     #33 0x80100150 in ret_from_fork () at
> > /home/zyj/Linux/linux-master/arch/arm/kernel/entry-common.S:158
> >     Backtrace stopped: previous frame identical to this frame (corrupt
> > stack?)
> > 
> > See above #7~#15, there is a recursion in function pstore_ftrace_call(), and
> > a spin_lock(lock=0x811a0f98) is hold since unlock operation in above #11 not
> > finished. Then in above #0, trying to acquire same lock cause a deadlock.
> > 
> > Enabling 'record_ftrace' seems a basic operation of pstore/ftrace, Does it
> > mean this feature is not available for a while?
> > 
> > Best Regards,
> > Zheng
> 
> -- 
> Kees Cook
