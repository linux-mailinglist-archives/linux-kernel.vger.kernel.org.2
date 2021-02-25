Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F321B324FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 13:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhBYMd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 07:33:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:48988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhBYMdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 07:33:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614256385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XvJmFVKgLH3Zq+UwtK6zreZtTUENbLMY4TwoGb5OSqc=;
        b=c6JnWVr1k3H5QZGz6olwvnugxjOdHkC4AfYXgmmjUSW17uzKJdskwbyBxN0xEeSwXttdz2
        WM4m3mLpP5+G1aTfS9P9zutVIQ25KWDyGoLQEDVzq3b8Vrald+RHjH+wujPVr87N9bdZcu
        0KUcpxtBOXiymtMD5NYqseyW6qpyp/Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F37CBAAAE;
        Thu, 25 Feb 2021 12:33:04 +0000 (UTC)
Date:   Thu, 25 Feb 2021 13:33:04 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: synchronization model: was: Re: [PATCH printk-rework 09/14]
 printk: introduce a kmsg_dump iterator
Message-ID: <YDeZAA08NKCHa4s/@alley>
References: <20210218081817.28849-1-john.ogness@linutronix.de>
 <20210218081817.28849-10-john.ogness@linutronix.de>
 <YC/79JPVKcVaSEEH@alley>
 <87eeh51wht.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eeh51wht.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-02-24 13:27:42, John Ogness wrote:
> On 2021-02-19, Petr Mladek <pmladek@suse.com> wrote:
> > This is likely beyond the scope of this patchset.
> 
> It would be beyond the scope of this patchset because it is not related
> to logbuf_lock removal.
> 
> > I am still scratching my head about the synchronization if these dumpers.
> >
> > There is the "active" flag. It has been introduced by the commit
> > e2ae715d66bf4becfb ("kmsg - kmsg_dump() use iterator to receive log
> > buffer content"). I do not see any explanation there.
> >
> > It might prevent some misuse of the API. But the synchronization
> > model is not much clear:
> >
> > 	+ cur_seq and next_seq might be manipulated by
> > 	  kmsg_dump_rewind() even when the flag is not set.
> >
> > 	+ It is possible to use the same dumper more times in parallel.
> > 	  The API will fill the provided buffer of all callers
> > 	  as long as the active flag is set.
> >
> > 	+ The "active" flag does not synchronize other operations with
> > 	  the provided buffer. The "dump" callback is responsible
> > 	  to provide some synchronization on its own.
> >
> > In fact, it is not much clear how struct kmsg_dumper_iter, struct kmsg_dumper,
> > and the used buffers are connected with each other and synchronized.
> 
> With this series applied, there is no connection between them. And
> actually you have made me realize that the iterator should be named
> "kmsg_dump_iter" instead. I will change that for v3.

Yup.

> > It might some sense to have the iterator in a separate structure.
> > But the only safe scenario seems to be when all these three things
> > (both structures and the buffer) are connected together and
> > synchronized by the same lock. Also the "active" flag does not look
> > much helpful and can be removed.
> 
> The @active flag is useless. It should be removed.
> 
> We have kmsg_dump_get_line(), kmsg_dump_get_buffer(), kmsg_dump_rewind()
> as an in-kernel interface to allow retrieving the kernel buffer
> contents. To use these interfaces, the caller only needs to have an
> iterator that is initialized using kmsg_dump_rewind(). These functions
> can be (and are) used, regardless if a dumper has been registered. And I
> think that is OK.
> 
> The used buffers (like the iterator) are local to the caller. So there
> is no need for the kmsg_dump_*() functions to be concerned about any
> synchronization there.

Yup, this use-case looks straightforward.

> Then we have kmsg_dump_register() and kmsg_dump_unregister() to allow
> for registration of a dump() callback, to be called when the kernel does
> panic/oops/emergency/shutdown. Presumably the registered callback would
> use the kmsg_dump_*() functions to access the kernel buffer. Again, no
> need for kmsg_dump_*() functions to be concerned about synchronization
> because the buffers are provided by the callbacks.

This is the scenario where the synchronization/logic looks weird to
me. I am not sure if I am able to describe is reasonably. Let me try:

1. The dump is triggered by kmsg_dump(). It is called in several
   code paths like panic/oops/emergency/shutdown. I am not completely
   sure if kmsg_dump() might be called more times in parallel.

   IMHO, it might be, for example, when Oops does not trigger panic
   immediately but the panic() happens in the middle of kmsg_dump()
   triggered by Oops. panic() will then trigger another kmsg_dump()
   that might run in parallel.

2. The iterator struct is provided by kmsg_dump() but the buffers
   are provided by the registered dumper->dump() callback.

3. dumper->dump() callback triggers reading the messages into
   the temporary buffers. But the buffers might later be proceed
   asynchronously, like for example, schedule_work(&cxt->work_write)
   in mtdoops_do_dump().


Now, the split of the iterator struct made it more safe. It allows
to iterate the log buffer more times in parallel. But the buffers
are likely the same even when there are more iterators.

IMHO, a better design would be:

1. dumper->dump() callback should have only one parameter @reason.
   The callback should define its own iterator, buffer, and
   do the dump.

2. dumpe->dump() callback should synchronize the entire operation
   using its own locks. Only the callback knows whether it is
   safe to do more dumps in parallel. Only the callback knows
   whether it is called only during panic() when no locks
   are needed.


> > As I said, this is likely beyond this patchset. This patch does more
> > or less just a refactoring and helps to understand the dependencies.
> 
> Aside from removing the useless @active flag, I am not sure what else
> you would want to change. Perhaps just fixup the comments/documentation
> to clarify these interfaces and what their purpose is.

IMHO, the best solution would be to use the above better design.
But I do not want to ask you to do it as part of the printk rework.
It is an old problem. And this patchset does not make it worse.

I will leave the decision up to you how much you want to invest
here. I could prepare patches for the rest of the clean up
on top of your changes.

Best Regards,
Petr

PS: Your view and the overview of all existing users helped me a lot
    when formulating the above.
    
