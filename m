Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450153991DB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhFBRpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhFBRpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:45:15 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C239C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 10:43:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ei4so2060087pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 10:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G8ET6pK/GA9CY7A9iG3Jh3ADNoVfklYCS1t6yZMaMP4=;
        b=IC01eVnmlvReDcFNjaQYwbNJ9B4jADqmw/pquL0w7weeO9ipiyOrxO1o+XTtNjRciM
         X+WaZtIU0fgK9GiLy4PSdhzq56YHBqLHpziSNsThFPYq9CGi9jo/yLAdCeTlp4dZPnc9
         ioC3RQgsxaB4xOMxpjvlCa9Odwn+aODcGQMs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G8ET6pK/GA9CY7A9iG3Jh3ADNoVfklYCS1t6yZMaMP4=;
        b=UX4H7t+KWabfuZk0DAdv83SokruIUOfUoKxpQZA/xiu5N76oLv+dFGUxmSFnzF5L3b
         Nenp2CjNOzVqeFxffBgenfBCIDyhcsZ2Nyoaw9khXz9yz/cU/1DtSOotbIl4sU6sbRhN
         D//P2Y2sa1LUqHJ59MvhDfGTvpB55SukK+qo0qW3qc9ftvtZguOH5hxImPbAbL8YsJDN
         B/2PW5JiK0kOOJgvi7POrH4PEjTsBKuy3W6E5d3Q1w20N8XnQRIn0b7souyW0TSKql7M
         VORpslDuck4j1wifzja5N6dliDHC6fXkWN/5byUMbr1jpO5LwGCC8T1tLvWnJrOX88tL
         T20w==
X-Gm-Message-State: AOAM5339TE04BNXNlzrq/X0x0iQNaXqBscfftHyBjq93UNi33ooWmGhn
        igLQGUSPjlmdAdjoMOYsMQGKWXaeWNzCYg==
X-Google-Smtp-Source: ABdhPJwTRYMzl1tx7IW48aScfihUIeXsIRp/sYLowKHR0vlqWvGUbws+sLr1Vgg1h8sGIZlWHHwFiQ==
X-Received: by 2002:a17:902:d20c:b029:fd:a3ef:adf with SMTP id t12-20020a170902d20cb02900fda3ef0adfmr32146234ply.22.1622655810761;
        Wed, 02 Jun 2021 10:43:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v6sm244310pfi.46.2021.06.02.10.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 10:43:30 -0700 (PDT)
Date:   Wed, 2 Jun 2021 10:43:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Zhengyejian (Zetta)" <zhengyejian1@huawei.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     rostedt@goodmis.org, ccross@android.com,
        linux-kernel@vger.kernel.org, Zhangjinhao <zhangjinhao2@huawei.com>
Subject: Re: [BUG] I found a bug when try to enable record_ftrace
Message-ID: <202106021042.8527F3AB30@keescook>
References: <01472d0f-55c1-15ea-9beb-5d64b322bb44@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01472d0f-55c1-15ea-9beb-5d64b322bb44@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Jun 02, 2021 at 03:42:23PM +0800, Zhengyejian (Zetta) wrote:
> Hello,
> 
> There may be a deadlock caused by ftrace recursion when try to enable
> record_ftrace.

Hi,

Thanks for the report. Joel, is this something you can take a look at?

-Kees

> I'd like to known if the patchset
> (https://lore.kernel.org/lkml/20201106023235.367190737@goodmis.org/) is
> trying to fix it.
> 
> Procedure for reproducing the problem is:
>   1) this problem appears both in 5.13-rc4 and 5.10;
> 
>   2) my work environment is:
>     qemu-arm version 4.0.0
>     arm-linux-gnueabi-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
> 
>   3) then try to enable record_ftrace:
>     / # mount -t pstore pstore /sys/fs/pstore
>     / # echo 1 > /sys/kernel/debug/pstore/record_ftrace
> 
>   4) then system appears to be stuck, and use arm-linux-gnueabi-gdb dump the
> following call stack:
>     #0  arch_spin_lock (lock=0x811a0f98) at
> /home/zyj/Linux/linux-master/arch/arm/include/asm/spinlock.h:74
>     #1  do_raw_spin_lock_flags (flags=<synthetic pointer>, lock=0x811a0f98)
> at /home/zyj/Linux/linux-master/include/linux/spinlock.h:195
>     #2  __raw_spin_lock_irqsave (lock=0x811a0f98) at
> /home/zyj/Linux/linux-master/include/linux/spinlock_api_smp.h:119
>     #3  _raw_spin_lock_irqsave (lock=lock@entry=0x811a0f98) at
> /home/zyj/Linux/linux-master/kernel/locking/spinlock.c:159
>     #4  0x8046c6e0 in buffer_size_add (prz=prz@entry=0x811a0f80,
> a=a@entry=16) at /home/zyj/Linux/linux-master/fs/pstore/ram_core.c:82
>     #5  0x8046cc20 in persistent_ram_write (prz=0x811a0f80, s=0x81137b80,
> count=16) at /home/zyj/Linux/linux-master/fs/pstore/ram_core.c:327
>     #6  0x8046b438 in ramoops_pstore_write (record=0x81137b90) at
> /home/zyj/Linux/linux-master/fs/pstore/ram.c:331
>     #7  0x8046add8 in pstore_ftrace_call (ip=2156609456,
> parent_ip=2152122068, op=<optimized out>, fregs=<optimized out>)
>         at /home/zyj/Linux/linux-master/fs/pstore/ftrace.c:54
>     #8  0x801dd580 in __ftrace_ops_list_func (ignored=0x0, fregs=0x0,
> parent_ip=2152122068, ip=2156609456) at
> /home/zyj/Linux/linux-master/kernel/trace/ftrace.c:7003
>     #9  ftrace_ops_list_func (ip=2156609456, parent_ip=2152122068,
> op=<optimized out>, fregs=0x0) at
> /home/zyj/Linux/linux-master/kernel/trace/ftrace.c:7028
>     #10 0x801109f8 in ftrace_caller () at
> /home/zyj/Linux/linux-master/arch/arm/kernel/entry-ftrace.S:224
>     #11 0x808b3fb4 in _raw_spin_unlock_irqrestore
> (lock=lock@entry=0x811a0f98, flags=1610612883) at
> /home/zyj/Linux/linux-master/kernel/locking/spinlock.c:190
>     #12 0x8046c6d4 in buffer_size_add (prz=prz@entry=0x811a0f80,
> a=a@entry=16) at /home/zyj/Linux/linux-master/fs/pstore/ram_core.c:95
>     #13 0x8046cc20 in persistent_ram_write (prz=0x811a0f80, s=0x81137cf8,
> count=16) at /home/zyj/Linux/linux-master/fs/pstore/ram_core.c:327
>     #14 0x8046b438 in ramoops_pstore_write (record=0x81137d08) at
> /home/zyj/Linux/linux-master/fs/pstore/ram.c:331
>     #15 0x8046add8 in pstore_ftrace_call (ip=2148632188,
> parent_ip=2148601660, op=<optimized out>, fregs=<optimized out>)
>         at /home/zyj/Linux/linux-master/fs/pstore/ftrace.c:54
>     #16 0x801dd580 in __ftrace_ops_list_func (ignored=0x0, fregs=0x0,
> parent_ip=2148601660, ip=2148632188) at
> /home/zyj/Linux/linux-master/kernel/trace/ftrace.c:7003
>     #17 ftrace_ops_list_func (ip=2148632188, parent_ip=2148601660,
> op=<optimized out>, fregs=0x0) at
> /home/zyj/Linux/linux-master/kernel/trace/ftrace.c:7028
>     #18 0x801109f8 in ftrace_caller () at
> /home/zyj/Linux/linux-master/arch/arm/kernel/entry-ftrace.S:224
>     #19 0x80118680 in __set_fixmap (idx=idx@entry=FIX_TEXT_POKE0,
> phys=phys@entry=0, prot=prot@entry=0) at
> /home/zyj/Linux/linux-master/arch/arm/mm/mmu.c:385
>     #20 0x80110f3c in patch_unmap (flags=<synthetic pointer>, fixmap=129) at
> /home/zyj/Linux/linux-master/arch/arm/kernel/patch.c:45
>     #21 __patch_text_real (addr=addr@entry=0x808b3fb0
> <_raw_spin_unlock_irqrestore+16>, insn=insn@entry=3957420680,
> remap=remap@entry=true)
>         at /home/zyj/Linux/linux-master/arch/arm/kernel/patch.c:104
>     #22 0x80110b40 in __patch_text (insn=3957420680, addr=0x808b3fb0
> <_raw_spin_unlock_irqrestore+16>) at
> /home/zyj/Linux/linux-master/arch/arm/include/asm/patch.h:10
>     #23 ftrace_modify_code (pc=2156609456, old=3904716800, new=3957420680,
> validate=true) at /home/zyj/Linux/linux-master/arch/arm/kernel/ftrace.c:95
>     #24 0x80110cf4 in ftrace_make_call (rec=rec@entry=0x81007ce0,
> addr=addr@entry=2148600280) at
> /home/zyj/Linux/linux-master/arch/arm/kernel/ftrace.c:132
>     #25 0x801dda40 in __ftrace_replace_code (rec=rec@entry=0x81007ce0,
> enable=enable@entry=true) at
> /home/zyj/Linux/linux-master/kernel/trace/ftrace.c:2524
>     #26 0x801de17c in ftrace_replace_code (mod_flags=mod_flags@entry=1) at
> /home/zyj/Linux/linux-master/kernel/trace/ftrace.c:2554
>     #27 0x801de39c in ftrace_modify_all_code (command=5) at
> /home/zyj/Linux/linux-master/kernel/trace/ftrace.c:2698
>     #28 0x80110ad8 in __ftrace_modify_code (data=<optimized out>) at
> /home/zyj/Linux/linux-master/arch/arm/kernel/ftrace.c:39
>     #29 0x801d4da4 in multi_cpu_stop (data=data@entry=0x81c69d84) at
> /home/zyj/Linux/linux-master/kernel/stop_machine.c:240
>     #30 0x801d4a14 in cpu_stopper_thread (cpu=<optimized out>) at
> /home/zyj/Linux/linux-master/kernel/stop_machine.c:511
>     #31 0x8014de3c in smpboot_thread_fn (data=0x810c1c80) at
> /home/zyj/Linux/linux-master/kernel/smpboot.c:165
>     #32 0x8014a0dc in kthread (_create=0x810c1d40) at
> /home/zyj/Linux/linux-master/kernel/kthread.c:313
>     #33 0x80100150 in ret_from_fork () at
> /home/zyj/Linux/linux-master/arch/arm/kernel/entry-common.S:158
>     Backtrace stopped: previous frame identical to this frame (corrupt
> stack?)
> 
> See above #7~#15, there is a recursion in function pstore_ftrace_call(), and
> a spin_lock(lock=0x811a0f98) is hold since unlock operation in above #11 not
> finished. Then in above #0, trying to acquire same lock cause a deadlock.
> 
> Enabling 'record_ftrace' seems a basic operation of pstore/ftrace, Does it
> mean this feature is not available for a while?
> 
> Best Regards,
> Zheng

-- 
Kees Cook
