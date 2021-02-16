Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBC431C86E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhBPJwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:52:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:54982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230310AbhBPJty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:49:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613468944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5p5HhukqNqcjKhr4IQ4ddmUOr2qvSydw6AhXFy2p8c0=;
        b=Ny9Mna1FeDcRId/gVTmp4C49CMO3N+tt2yDKvGNlt6eq6uP8C9QC1jnRgJUMTCxFKXVCts
        PCuCUdDRZjQ38nojptetzKAXYjy+hDJYGdoNJPUM5MrvdZdJwx8lDGNVwX5xRSX3BJkMFf
        cbohObrk5JlQSlbUwTncMNf51Y3saT0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 780C5AD29;
        Tue, 16 Feb 2021 09:49:04 +0000 (UTC)
Date:   Tue, 16 Feb 2021 10:49:04 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        it+linux-x86@molgen.mpg.de,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: smpboot: CPU numbers printed as warning
Message-ID: <YCuVEDXyIu+yE4c1@alley>
References: <e964b2ae-7a15-a510-e76a-56d704949d62@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e964b2ae-7a15-a510-e76a-56d704949d62@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-02-15 20:22:34, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> Using Linux 5.10.13 (and before), looking at the Linux kernel warnings, the
> CPU numbers show up. For example with 12 cpus/threads:
>
> ```
> $ sudo dmesg --level=warn
> [    0.216103]   #2
> [    0.220105]   #3
> [    0.224103]   #4
> [    0.228104]   #5
> [    0.232110]   #6
> [    0.236101]   #7
> [    0.240102]   #8
> [    0.244102]   #9
> [    0.248100]  #10
> [    0.252098]  #11
> ```

Is this the exact output from sudo dmesg --level=warn?
It is strange that each CPU number is printed on itw own line.

Anyway, it might be affected by the new lockless ringbuffer.
The original code decided whether to connect the lines only by
"current" task pointer. The lockless ring buffer takes into account
also CPU number.

Well, it has never been reliable. For example, I see here:

<6>[    0.238262][    T1] smp: Bringing up secondary CPUs ...
<6>[    0.239340][    T1] x86: Booting SMP configuration:
<6>[    0.239794][    T1] .... node  #0, CPUs:      #1
<6>[    0.113946][    T0] kvm-clock: cpu 1, msr 6ba01041, secondary cpu clock
<6>[    0.113946][    T0] smpboot: CPU 1 Converting physical 0 to logical die 1
<6>[    0.246056][   T16] kvm-guest: stealtime: cpu 1, msr 17f9f2080
<4>[    0.246679][    T1]  #2
<6>[    0.113946][    T0] kvm-clock: cpu 2, msr 6ba01081, secondary cpu clock
<6>[    0.113946][    T0] smpboot: CPU 2 Converting physical 0 to logical die 2
<6>[    0.250023][   T21] kvm-guest: stealtime: cpu 2, msr 17fbf2080
<4>[    0.250648][    T1]  #3
<6>[    0.113946][    T0] kvm-clock: cpu 3, msr 6ba010c1, secondary cpu clock
<6>[    0.113946][    T0] smpboot: CPU 3 Converting physical 0 to logical die 3
<6>[    0.254026][   T26] kvm-guest: stealtime: cpu 3, msr 17fdf2080
<6>[    0.254568][    T1] smp: Brought up 1 node, 4 CPUs
<6>[    0.254597][    T1] smpboot: Max logical packages: 4
<6>[    0.255097][    T1] smpboot: Total of 4 processors activated (16896.11 BogoMIPS)

There are another messages printed in between that obviously break pr_cont().

> If I am not mistaken, this is from `announce_cpu()` in
> `arch/x86/kernel/smpboot.c`, and the `pr_cont()` in their “forgets” the log
> level it belongs to, maybe because of SMP and other messages are printed in
> between.
> 
> ```
>         if (system_state < SYSTEM_RUNNING) {
>                 if (node != current_node) {
>                         if (current_node > (-1))
>                                 pr_cont("\n");
>                         current_node = node;
> 
>                         printk(KERN_INFO ".... node %*s#%d, CPUs:  ",
>                                node_width - num_digits(node), " ", node);
>                 }
> 
>                 /* Add padding for the BSP */
>                 if (cpu == 1)
>                         pr_cont("%*s", width + 1, " ");
> 
>                 pr_cont("%*s#%d", width - num_digits(cpu), " ", cpu);
> 
>         } else
>                 pr_info("Booting Node %d Processor %d APIC 0x%x\n",
>                         node, cpu, apicid);
> ```

> Would using `pr_info()` instead be an acceptable fix?

Makes sense to me.

Also you should add '\n' into the previous string to make the behavior
clear. It will always be printed on a new line when pr_info()
is used.

Best Regards,
Petr
