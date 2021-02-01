Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAA230AD79
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhBARKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:10:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhBARKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:10:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7026D64EA9;
        Mon,  1 Feb 2021 17:10:09 +0000 (UTC)
Date:   Mon, 1 Feb 2021 12:10:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Ingo Molnar <mingo@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matt Mullins <mmullins@mmlx.us>, paulmck <paulmck@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5] tracepoint: Do not fail unregistering a probe due to
 memory failure
Message-ID: <20210201121007.51c0ac59@gandalf.local.home>
In-Reply-To: <13608cdc-2068-6340-6795-28944c9fe3ca@ozlabs.ru>
References: <20210127170721.58bce7cc@gandalf.local.home>
        <ac000ed4-3eeb-60df-f896-c05cabb4c1c9@ozlabs.ru>
        <20210130093626.0b7b3b1b@oasis.local.home>
        <20210130094211.719f03a6@oasis.local.home>
        <13608cdc-2068-6340-6795-28944c9fe3ca@ozlabs.ru>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 12:18:34 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> > Just curious, does the following patch fix it for v5?  
> 
> 
> Yes it does!

Thanks for verifying.

> 
> 
> > 
> > -- Steve
> > 
> > diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> > index 7261fa0f5e3c..cf3a6d104fdb 100644
> > --- a/kernel/tracepoint.c
> > +++ b/kernel/tracepoint.c
> > @@ -306,6 +306,7 @@ static int tracepoint_remove_func(struct tracepoint *tp,
> >   			tp->unregfunc();
> >   
> >   		static_key_disable(&tp->key);
> > +		tracepoint_synchronize_unregister();
> >   		rcu_assign_pointer(tp->funcs, tp_funcs);
> >   	} else {
> >   		rcu_assign_pointer(tp->funcs, tp_funcs);
> >   

OK, since it would be expensive to do a synchronization on every removal
like that, but the tp->funcs should not be reset.

It appears that your check is still required, since the iterator has been
added.

The quick fix is the check you gave.

But I think we could optimize this (not having to dereference the array
twice, and do the check twice) by making the iterator part of the tp_funcs
array, and having the rest of the array as its argument. But that can be a
separate update.

The check you added should be a patch and marked for stable. Care to send
it, and mark it for stable as well as:

Fixes: d25e37d89dd2f ("tracepoint: Optimize using static_call()")

Thanks!

-- Steve
