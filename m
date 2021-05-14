Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7826C380FA5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 20:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbhENSUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 14:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbhENSUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 14:20:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BB9C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 11:18:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621016325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OrPAQ0MvuanIbFhGukWyMzAMiIH4hXac42mqWV38eMo=;
        b=nylC2wppY4c9I9q63k0HvmTuZ+Aim8HkAEENDFbp7flwuJkXr9yYTIsaTSmi5TTT6VCyMc
        DZLimLXSjbxKhYCtmwcPaF0d5Yky6vac5NU/N1Y5gS6JlNpv+2+bCqw5pvPQlwRNAo+X6r
        aDZOMw8uBM+uYpyWFdV73xCxsgG+HXAMrrmGe/+FGfkt9ZstbViynxAD8N9GgFDv5par7R
        Rn4kSa/cEY/fgr5jyMVukQd1b0drV/ZE/5gFVfxLHn73Rl1lVXzh10zvVwHaKwVUQw2kWD
        xFq4raLbTUs/Wot/cbVXkVcMhEg40cTlNzAiN8XgIh8i85C+3hqMVLJ8hUMc/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621016325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OrPAQ0MvuanIbFhGukWyMzAMiIH4hXac42mqWV38eMo=;
        b=EQwlFl1vLZ++1K7rQcAPtrUBtjlNbY+xkecRv2HW49YinRNF2J5LwR1aUtAAkWM3baR/ln
        RVxHfFYGlq+LiTBA==
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, mingo@redhat.com,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/4] sched: make nr_running() return 32-bit
In-Reply-To: <YJz4TmZ7fmKFchRe@gmail.com>
References: <20210422200228.1423391-1-adobriyan@gmail.com> <87fsyr5wtj.ffs@nanos.tec.linutronix.de> <YJz4TmZ7fmKFchRe@gmail.com>
Date:   Fri, 14 May 2021 20:18:44 +0200
Message-ID: <87eee941rv.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13 2021 at 11:58, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> As to the numbers:
> -	/* size: 1704, cachelines: 27, members: 13 */
> -	/* sum members: 1696, holes: 1, sum holes: 4 */
> +	/* size: 1696, cachelines: 27, members: 13 */
> +	/* sum members: 1688, holes: 1, sum holes: 4 */
>  	/* padding: 4 */
> -	/* last cacheline: 40 bytes */
> +	/* last cacheline: 32 bytes */
>
> 'struct rt_rq' got shrunk from 1704 bytes to 1696 bytes, an 8 byte 
> reduction.

Amazing and it still occupies 27 cache lines

>   ffffffffxxxxxxxx:      e8 49 8e fb ff          call   ffffffffxxxxxxxx <nr_iowait_cpu>
> - ffffffffxxxxxxxx:      48 85 c0                test   %rax,%rax
>
>   ffffffffxxxxxxxx:      e8 64 8e fb ff          call   ffffffffxxxxxxxx <nr_iowait_cpu>
> + ffffffffxxxxxxxx:      85 c0                   test   %eax,%eax
>
> Note how the 'test %rax,%rax' lost the 0x48 64-bit REX prefix and the 
> generated code got one byte shorter from "48 85 c0" to "85 c0".

Which will surely be noticable big time. None of this truly matters
because once the data is in L1 the REX prefix is just noise.

> ( Note, my asm generation scripts filter out some of the noise to make it 
>   easier to diff generated asm, hence the ffffffffxxxxxxxx placeholder. )
>
> The nr_iowait() function itself got shorter by two bytes as well, due to:
>
> The size of nr_iowait() shrunk from 78 bytes to 76 bytes.

That's important because nr_iowait() is truly a hotpath function...

> The nr_running() function itself got shorter by 2 bytes, due to shorter 
> instruction sequences.

along with nr_running() which both feed /proc/stat. The latter feeds
/proc/loadavg as well.

Point well taken.

But looking at the /proc/stat usage there is obviously way bigger fish
to fry.

   seq_printf(...., nr_running(), nr_iowait());

which is outright stupid because both functions iterate over CPUs
instead of doing it once, which definitely would be well measurable on
large machines.

But looking at nr_running() and nr_iowait():

    nr_running() walks all CPUs in cpu_online_mask

    nr_iowait() walks all CPUs in cpu_possible_mask

The latter is because rq::nr_iowait is not transferred to an online CPU
when a CPU goes offline. Oh well.

That aside:

I'm not against the change per se, but I'm disagreeing with patches
which come with zero information, are clearly focussed on one
architecture and obviously nobody bothered to check whether there is an
impact on others.

Thanks,

        tglx



