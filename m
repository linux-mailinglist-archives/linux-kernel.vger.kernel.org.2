Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A8432CE8D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 09:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbhCDIdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 03:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbhCDIcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:32:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C746C061756
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 00:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=DMcYLXBe8hXZ3aPL5ES1lzJxbIGorWKwhPqPVEThNzM=; b=ILlcBd38P19XJhLPYgk9bEjVpi
        z8qVQKaS4/7wRwCMSh7n6ExztG1XD07n+GslQjOatF5JFqwwZyd9uAr0QxjtddXjxIQWfMjsMD0GX
        1TCth8LVQulElqyS4077qQDJLyfb01nFMOY0rp9Qkg4vNphjSFc72Fqgo0+gkzzjOPerLk190HR3+
        FPlpo2/WrpzjGJM0eZ3+yudIPC02clpYFau1gRQxVRTMgpmBGdcT/tbuycUAvEPQSjMPY/hHXjZuI
        itVlZOL1rSl9BSVJ+cwqmWkrqQhDb2kvNOAod6oHlhrUxFHYMK6fn0XbcQKUVWWs336d5ab2fxW3H
        Y1rAolow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lHjOB-006FBX-06; Thu, 04 Mar 2021 08:31:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E26B930018A;
        Thu,  4 Mar 2021 09:31:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F9DA20B10DCB; Thu,  4 Mar 2021 09:31:15 +0100 (CET)
Date:   Thu, 4 Mar 2021 09:31:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Clement Courbet <courbet@google.com>,
        Oleg Rombakh <olegrom@google.com>
Subject: Re: [PATCH v2] sched: Optimize __calc_delta.
Message-ID: <YECa09WaFMpwKWjz@hirez.programming.kicks-ass.net>
References: <YD9dUkGhlRT8vvcy@hirez.programming.kicks-ass.net>
 <20210303224653.2579656-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210303224653.2579656-1-joshdon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 02:46:53PM -0800, Josh Don wrote:
> From: Clement Courbet <courbet@google.com>
> 
> A significant portion of __calc_delta time is spent in the loop
> shifting a u64 by 32 bits. Use `fls` instead of iterating.
> 
> This is ~7x faster on benchmarks.
> 
> The generic `fls` implementation (`generic_fls`) is still ~4x faster
> than the loop.
> Architectures that have a better implementation will make use of it. For
> example, on X86 we get an additional factor 2 in speed without dedicated
> implementation.
> 
> On gcc, the asm versions of `fls` are about the same speed as the
> builtin. On clang, the versions that use fls are more than twice as
> slow as the builtin. This is because the way the `fls` function is
> written, clang puts the value in memory:
> https://godbolt.org/z/EfMbYe. This bug is filed at
> https://bugs.llvm.org/show_bug.cgi?id=49406.
> 
> ```
> name                                   cpu/op
> BM_Calc<__calc_delta_loop>             9.57ms ±12%
> BM_Calc<__calc_delta_generic_fls>      2.36ms ±13%
> BM_Calc<__calc_delta_asm_fls>          2.45ms ±13%
> BM_Calc<__calc_delta_asm_fls_nomem>    1.66ms ±12%
> BM_Calc<__calc_delta_asm_fls64>        2.46ms ±13%
> BM_Calc<__calc_delta_asm_fls64_nomem>  1.34ms ±15%
> BM_Calc<__calc_delta_builtin>          1.32ms ±11%
> ```
> 
> Signed-off-by: Clement Courbet <courbet@google.com>
> Signed-off-by: Josh Don <joshdon@google.com>

Thanks!
