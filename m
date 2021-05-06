Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AA6375210
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 12:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhEFKM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 06:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhEFKMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 06:12:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED100C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 03:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xlhv1ia1iEUnAYb6RvKO2shIlkWWFE4kCXLfGsroUMM=; b=dfQLtmxATVgwxEwv3EZT3UXRy9
        Fn4c3O9dh6N3Wqv3owlU2TI5NyYsiTE9cbblfwcBbfkdI/AEcSVhGAGploA3mv65VlhrTScpgXqgn
        Jgj7XnoF+XvQPKXHZgO9ag81NIsLrRmqhsEvObx53z1/9KmZmDYgQDGcb1k0VcZdPmrZpYuJjqucv
        4f2ssGHMi+Xn8gPOOIUam192JGg4WAD1orSzm6fPgmuX4BkNLG21r/iW8e70CB8eghFAcvF7vSlAm
        AzGIZ0pEELnEgfKjezIWfqwVhYWRKUM+bsJARY2K3ZIhHYmpbu7haW04d+YFJZhqmjiKiPfP693Qe
        U6MXSRTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1leay7-003vIJ-0V; Thu, 06 May 2021 10:10:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25113300103;
        Thu,  6 May 2021 12:10:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC22E2D84CAD6; Thu,  6 May 2021 12:10:52 +0200 (CEST)
Date:   Thu, 6 May 2021 12:10:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Huang, Ying" <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        He Ying <heying24@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] [v2] smp: fix smp_call_function_single_async prototype
Message-ID: <YJPArKvd+GuiBwRk@hirez.programming.kicks-ass.net>
References: <20210505211300.3174456-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505211300.3174456-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 11:12:42PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> As of commit 966a967116e6 ("smp: Avoid using two cache lines for struct
> call_single_data"), the smp code prefers 32-byte aligned call_single_data
> objects for performance reasons, but the block layer includes an instance
> of this structure in the main 'struct request' that is more senstive
> to size than to performance here, see 4ccafe032005 ("block: unalign
> call_single_data in struct request").
> 
> The result is a violation of the calling conventions that clang correctly
> points out:
> 
> block/blk-mq.c:630:39: warning: passing 8-byte aligned argument to 32-byte aligned parameter 2 of 'smp_call_function_single_async' may result in an unaligned pointer access [-Walign-mismatch]
>                 smp_call_function_single_async(cpu, &rq->csd);
> 
> It does seem that the usage of the call_single_data without cache line
> alignment should still be allowed by the smp code, so just change the
> function prototype so it accepts both, but leave the default alignment
> unchanged for the other users. This seems better to me than adding
> a local hack to shut up an otherwise correct warning in the caller.
> 
> Link: https://lore.kernel.org/linux-block/20210330230249.709221-1-jiancai@google.com/
> Link: https://github.com/ClangBuiltLinux/linux/issues/1328
> Acked-by: Jens Axboe <axboe@kernel.dk>
> Cc: Jian Cai <jiancai@google.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks!
