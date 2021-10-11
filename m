Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABE84295A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 19:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhJKRcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 13:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230358AbhJKRcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 13:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633973418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CarqMeokx12krkM9wEuvIxg2HoIn+E5FTTSsUPbSeZI=;
        b=GO/RDa3BJdgR34/JfEPHIcMVave6I/8+uxKtqKrDxHGeeOZ4iBOhFPJBf4gjMRZA+QpjjL
        j6zEEgkduw7kPO9EC7mHH96LTqZsfJhXRVly1qvh8gpF2VPVUCTYm/Y5Y1heKx6EWQJmgJ
        qTD53O7fFKtrfKqexH268rcS6mbrmHQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-Wah77atdOO6RI_LW16QOdg-1; Mon, 11 Oct 2021 13:30:17 -0400
X-MC-Unique: Wah77atdOO6RI_LW16QOdg-1
Received: by mail-qk1-f199.google.com with SMTP id c16-20020a05620a0cf000b0045f1d55407aso10245088qkj.22
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 10:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CarqMeokx12krkM9wEuvIxg2HoIn+E5FTTSsUPbSeZI=;
        b=XN285X23FMkJeHJ1HEAREzLvYAQHGx44jvhHVSzMhVQjyKvINq4S/tUGxh9/BkClW6
         JgM+C4nRt4OnRSZ74OSrOwIksD1HKKJWqAXZ/+gr154Jx/A61dwVIxXHOKqBBduO+z3s
         U8+NZCNnNcYHrR/aCwvgmsyqvcO5SqW0NyjKupKDNkRtorNEieyiebYAD/WazcarHuoX
         z7TJpBQG3FFSWnG4FixfA9Rn3R+MPxTMNYWzPdNj5rqMH6of9blpbRPlsdrqIB1NKbO5
         d7Niw3ipHTfN5On9g2IRYf0kyjIHqSz/a2zy4Q+wU8WgvEcAoLSX0CN0HxHKTSZqBtnY
         YGxA==
X-Gm-Message-State: AOAM532r3BR8WJi9rZZiFYcmDEvoatDebvB90AqNgEsWNaoKiAGG3R7e
        SdnxRsBd3G+m+VDLRlba3/+VXEy+S2tTmzasOCrH75HMpywUEWtzq/PThlj4XeYPJl20u9C2uT5
        pHlrA3LMm8ejSDzwr2p2yKPv2
X-Received: by 2002:a37:9f4c:: with SMTP id i73mr5858120qke.323.1633973416561;
        Mon, 11 Oct 2021 10:30:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyv297PgpCOoUroSqnvv2DPpWU94toZJ/VIwdXoD3O5u8pCHTWuOmwhYOvJQwox/tggBYUXiQ==
X-Received: by 2002:a37:9f4c:: with SMTP id i73mr5858103qke.323.1633973416318;
        Mon, 11 Oct 2021 10:30:16 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id 128sm4491414qkl.111.2021.10.11.10.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 10:30:15 -0700 (PDT)
Date:   Mon, 11 Oct 2021 10:30:07 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+84fe685c02cd112a2ac3@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, inglorion@google.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>, tkjos@google.com
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in profile_pc
Message-ID: <20211011173007.ejj2zamtdsjljnds@treble>
References: <00000000000030293b05c39afd6f@google.com>
 <20210602230054.vyqama2q3koc4bpo@treble>
 <527ad07e-eec2-a211-03e7-afafe5196100@linux.intel.com>
 <YLjZYvXnuPnbXzOm@hirez.programming.kicks-ass.net>
 <20210603133914.j2aeadmvhncnlk5q@treble>
 <0b71d4f9-f707-3d39-c358-7c06c5689a9d@linux.intel.com>
 <YWQ3AzF+q2xeyQ/p@google.com>
 <20211011104319.7c6125cb@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211011104319.7c6125cb@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 10:43:19AM -0400, Steven Rostedt wrote:
> ==================================================================
> BUG: KASAN: stack-out-of-bounds in profile_pc+0xa4/0xe0 arch/x86/kernel/time.c:42
> Read of size 8 at addr ffffc90001c0f7a0 by task systemd-udevd/12323
> 
> CPU: 1 PID: 12323 Comm: systemd-udevd Not tainted 5.13.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x202/0x31e lib/dump_stack.c:120
>  print_address_description+0x5f/0x3b0 mm/kasan/report.c:233
>  __kasan_report mm/kasan/report.c:419 [inline]
>  kasan_report+0x15c/0x200 mm/kasan/report.c:436
>  profile_pc+0xa4/0xe0 arch/x86/kernel/time.c:42
>  profile_tick+0xcd/0x120 kernel/profile.c:408
>  tick_sched_handle kernel/time/tick-sched.c:227 [inline]
>  tick_sched_timer+0x287/0x420 kernel/time/tick-sched.c:1373
>  __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
>  __hrtimer_run_queues+0x4cb/0xa60 kernel/time/hrtimer.c:1601
>  hrtimer_interrupt+0x3b3/0x1040 kernel/time/hrtimer.c:1663
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
>  __sysvec_apic_timer_interrupt+0xf9/0x270 arch/x86/kernel/apic/apic.c:1106
>  sysvec_apic_timer_interrupt+0x8c/0xb0 arch/x86/kernel/apic/apic.c:1100
> 
> And the code has:
> 
>  profile_pc+0xa4/0xe0 arch/x86/kernel/time.c:42
> 
> unsigned long profile_pc(struct pt_regs *regs)
> {
> 	unsigned long pc = instruction_pointer(regs);
> 
> 	if (!user_mode(regs) && in_lock_functions(pc)) {
> #ifdef CONFIG_FRAME_POINTER
> 		return *(unsigned long *)(regs->bp + sizeof(long));
> #else
> 		unsigned long *sp = (unsigned long *)regs->sp;
> 		/*
> 		 * Return address is either directly at stack pointer
> 		 * or above a saved flags. Eflags has bits 22-31 zero,
> 		 * kernel addresses don't.
> 		 */
> 		if (sp[0] >> 22)
> 			return sp[0];  <== line 42
> 		if (sp[1] >> 22)
> 			return sp[1];
> #endif
> 	}
> 	return pc;
> }
> EXPORT_SYMBOL(profile_pc);
> 
> 
> It looks to me that the profiler is doing a trick to read the contents of
> the stack when the interrupt went off, but this triggers the KASAN
> instrumentation to think it's a mistake when it's not. aka "false positive".
> 
> How does one tell KASAN that it wants to go outside the stack, because it
> knows what its doing?

*If* the code knew what it were doing, it could use READ_ONCE_NOCHECK()
to skip KASAN checking.  But this code is horribly broken and dangerous.

-- 
Josh

