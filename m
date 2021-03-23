Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D62345EB8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhCWM6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231486AbhCWM5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:57:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21011619B9;
        Tue, 23 Mar 2021 12:57:44 +0000 (UTC)
Date:   Tue, 23 Mar 2021 08:57:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] ftrace: shut up -Wcast-function-type warning for
 ftrace_ops_no_ops
Message-ID: <20210323085742.18477aad@gandalf.local.home>
In-Reply-To: <YFmbHI4hnKg5UH2M@hirez.programming.kicks-ass.net>
References: <20210322215006.1028517-1-arnd@kernel.org>
        <YFmbHI4hnKg5UH2M@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 08:39:08 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> > index 4d8e35575549..d8fc87a17421 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -125,7 +125,7 @@ static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
> >  #else
> >  /* See comment below, where ftrace_ops_list_func is defined */
> >  static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
> > -#define ftrace_ops_list_func ((ftrace_func_t)ftrace_ops_no_ops)
> > +#define ftrace_ops_list_func ((ftrace_func_t)(void *)ftrace_ops_no_ops)  
> 
> So now we're making perfectly fine code worse, because GCC is stupid?
> 
> Please just kill the warning, like we do with so many other warnings.
> It's broken!

[ Adding Kees ]

Well, from what I understand is that typecasting functions to other types
of functions is one of the mistakes that cause security bugs to happen. And
there's been a few of them in the kernel. Which is why the compilers have
now been flagging them.

This particular instance of the typecasting is unique and there's a bit of
magic involved. Adding this little work around here is fine. Probably needs
a better comment though.

-- Steve
