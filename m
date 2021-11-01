Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACE1441D70
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbhKAPeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231362AbhKAPeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:34:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1D6960EFF;
        Mon,  1 Nov 2021 15:31:30 +0000 (UTC)
Date:   Mon, 1 Nov 2021 11:31:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, kernel test robot <lkp@intel.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace/samples: Add missing prototype for
 my_direct_func
Message-ID: <20211101113127.19148268@gandalf.local.home>
In-Reply-To: <20211101152002.376369-1-jolsa@kernel.org>
References: <20211101152002.376369-1-jolsa@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Nov 2021 16:20:02 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> There's compilation fail reported kernel test robot for W=1 build:
> 
>   >> samples/ftrace/ftrace-direct-multi.c:8:6: warning: no previous  
>   prototype for function 'my_direct_func' [-Wmissing-prototypes]
>      void my_direct_func(unsigned long ip)
> 
> The inlined assembly is used outside function, so we can't make
> my_direct_func static and pass it as asm input argument.
> 
> However my_tramp is already extern so I think there's no problem
> keeping my_direct_func extern as well and just add its prototype.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 5fae941b9a6f ("ftrace/samples: Add multi direct interface test module")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  samples/ftrace/ftrace-direct-multi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
> index 2a5b1fb7ac14..e0ccf43da0c9 100644
> --- a/samples/ftrace/ftrace-direct-multi.c
> +++ b/samples/ftrace/ftrace-direct-multi.c
> @@ -10,6 +10,7 @@ void my_direct_func(unsigned long ip)
>  	trace_printk("ip %lx\n", ip);
>  }
>  
> +extern void my_direct_func(unsigned long ip);
>  extern void my_tramp(void *);

Except that I believe that the prototype must come before it is used.

I don't think this will fix the warning.

-- Steve


>  
>  asm (

