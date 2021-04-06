Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F8C355177
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245318AbhDFLBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhDFLBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:01:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B662C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 04:01:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617706863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S2O1k9yZlYySt7+8gnNrDK/Yp/8kwoWX62PxlbcqwbA=;
        b=nl9GFkH778lC7VCrJOuaoV80FdfH0mtXyzGk6zcuRJPpzUbwbdCttQk6fZN0TWXbTNFRHS
        9OP4F05zxprZGg/xrYgT3Dc78sX2wQoXJufiMTarERPRiF1HwtW87KNXnnLCLPBwAEUI8l
        Lyi4cptRgwjQyWy4f5OzjrnYIUFDU3znx7RetH9ffo5pac9HdBj/wgI4zvpLnhJw7e2oAi
        h34q2YaMqx653oO2+7Tqu8iGaVsxQwJhHRPYLrqPOAfOpobaf1NbF3s91jgtawE7IIWdKE
        UV94lIL4ee0lGL/6gJg9KEoMtmeOBzCgkHyqOsp+irX0SlOmZB2rI9/coqhytg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617706863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S2O1k9yZlYySt7+8gnNrDK/Yp/8kwoWX62PxlbcqwbA=;
        b=yzGkWAKS3iH7xchc7y3QLe7xFMXuhjofzIxtdxB9f2DojJ4aTiCvWNPgQVcmr4T/abFsf7
        grBHNd4e9TDvqEDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alistair Popple <alistair@popple.id.au>,
        Jordan Niethe <jniethe5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Yue Hu <huyue2@yulong.com>, Rafael Aquini <aquini@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: Re: [PATCH printk v2 2/5] printk: remove safe buffers
In-Reply-To: <YGXV8LJarjUJDhvy@alley>
References: <20210330153512.1182-1-john.ogness@linutronix.de> <20210330153512.1182-3-john.ogness@linutronix.de> <YGW63/elFr/gYW1u@alley> <87a6qiqgzr.fsf@jogness.linutronix.de> <YGXV8LJarjUJDhvy@alley>
Date:   Tue, 06 Apr 2021 13:01:02 +0200
Message-ID: <87im4zoexd.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-01, Petr Mladek <pmladek@suse.com> wrote:
>> Caller-id solves this problem and is easy to sort for anyone with
>> `grep'. Yes, it is a shame that `dmesg' does not show it, but
>> directly using any of the printk interfaces does show it (kmsg_dump,
>> /dev/kmsg, syslog, console).
>
> True but frankly, the current situation is _far_ from convenient:
>
>    + consoles do not show it by default
>    + none userspace tool (dmesg, journalctl, crash) is able to show it
>    + grep is a nightmare, especially if you have more than handful of CPUs
>
> Yes, everything is solvable but not easily.
>
>> >     I get this with "echo l >/proc/sysrq-trigger" and this patchset:
>> 
>> Of course. Without caller-id, it is a mess. But this has nothing to do
>> with NMI. The same problem exists for WARN_ON() on multiple CPUs
>> simultaneously. If the user is not using caller-id, they are
>> lost. Caller-id is the current solution to the interlaced logs.
>
> Sure. But in reality, the risk of mixed WARN_ONs is small. While
> this patch makes backtraces from all CPUs always unusable without
> caller_id and non-trivial effort.

I would prefer we solve the situation for non-NMI as well, not just for
the sysrq "l" case.

>> For the long term, we should introduce a printk-context API that allows
>> callers to perfectly pack their multi-line output into a single
>> entry. We discussed [0][1] this back in August 2020.
>
> We need a "short" term solution. There are currently 3 solutions:
>
> 1. Keep nmi_safe() and all the hacks around.
>
> 2. Serialize nmi_cpu_backtrace() by a spin lock and later by
>    the special lock used also by atomic consoles.
>
> 3. Tell complaining people how to sort the messed logs.

Or we look into the long term solution now. If caller-id's cannot not be
used as the solution (because nobody turns it on, nobody knows about it,
and/or distros do not enable it), then we should look at how to make at
least the backtraces contiguous. I have a few ideas here.

John Ogness
