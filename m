Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D52433AF7E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 11:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbhCOKCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 06:02:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:46976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhCOKCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 06:02:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615802557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lC33yesXT/l1eNWRzOrRWoHnCkXcgUYP9aLI65SFJOw=;
        b=q6dhqGsaxBFD1siL5hSWQrfR3B829Xx0nJnjXLvRmkiUn8eYS7CTXlmlkMrxT2TxAJwIlv
        8i0oxH9jr6ykdD3NP71Y7aYwUz5pyaJkmkbA5uVBAIUjzqnJ2W0rx6gt9xXWHhBl/ZaObj
        pFPdhqIz57HLdrQvWjtGKxXmRUXZd84=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E4029AD74;
        Mon, 15 Mar 2021 10:02:36 +0000 (UTC)
Date:   Mon, 15 Mar 2021 11:02:36 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YE8wvGHhbV4nAGGI@alley>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <YEtNKMF3KH1kUDxY@alley>
 <YEtyUM07gsqR6ltG@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEtyUM07gsqR6ltG@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-03-12 13:53:20, Chris Down wrote:
> Ack to all unmentioned suggestions. :-)
> 
> Petr Mladek writes:
> > > +	  changed or no longer present.
> > > +
> > > +	  There is no additional runtime cost to printk with this enabled.
> > > +
> > >  #
> > >  # Architectures with an unreliable sched_clock() should select this:
> > >  #
> > > diff --git a/kernel/module.c b/kernel/module.c
> > > index 1e5aad812310..44df2913a046 100644
> > > --- a/kernel/module.c
> > > +++ b/kernel/module.c
> > > @@ -1064,6 +1064,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
> > >  	blocking_notifier_call_chain(&module_notify_list,
> > >  				     MODULE_STATE_GOING, mod);
> > >  	klp_module_going(mod);
> > > +	pi_sec_remove(mod);
> > 
> > Is there any particular reason why this is not done via the module
> > notifier, please?
> > 
> > Other subsystems hardcode their callbacks here only when they
> > require some special ordering that could not be achieved by
> > the notifiers.
> > 
> > The hardcoded callbacks complicate the error paths in
> > the module loader code.
> 
> Oh! That's exactly what I feel as well, but I mistakenly thought that's what
> you were asking for in the feedback for v4. Turns out I misread your
> statement about storing the pointer to `struct module` (hence my message
> last time querying whether it was sensible or not) as being about not using
> the module notifier. Mea culpa.
> 
> > > +static void *pi_next(struct seq_file *s, void *v, loff_t *pos)
> > > +{
> > > +	const struct pi_sec *ps = s->file->f_inode->i_private;
> > > +	struct pi_object *pi = NULL;
> > 
> > Please, call the variables by the content and not by prefix.
> > A variable called "pi" might include anything used by "pi" API.
> > 
> > [...]
> > 
> > Please, try to put more effort into creating the function and
> > variable names. I know that I am probably too picky about it.
> > But you seem to be the other extreme.
> > 
> > Inconsistent, ambiguous, or meaningless names might make even few
> > lines of code hard to follow. It makes it write-only.
> > It is hard to review and maintain.
> 
> Hmm, I'd even say that I agree with this statement, but as I understand it a
> `pi` variable always means pi_object, and `ps` always means pi_sec. I'm not
> immediately seeing it as meaningless or ambiguous (although maybe your
> concern was more abstractly aesthetic with overlapping the `pi_` prefix?).

"incosistent" was more about the previous (v4) version. v5 was fine
from this POV.

"ambiguous" and "meaningless" was primary about "pi" variable. "pi"
was used as prefix for all functions and structure names in the API.
The variable "pi" might mean any piece of information from this API.
For me it had similar meaning as "x" in the meaning of anything.
Better name would have been "object" because it was a pointer
to struct pi_object.

Another problematic name was "struct pi_sec". It makes sense for
storing start and end pointers to the elf section. But the dentry
pointer has nothing to do with an elf section.

> The "content" here is pretty abstract, so I'm not quite sure what your
> suggestion for naming them based on content is. Maybe (assuming it doesn't
> just disappear, which it seems it will) a pi_sec named sec

My problem with pi_sec is explained above. Anyway, it seems that it
will disappear.

> , and the pi_object named fmt_index?

I do not see "fmt_index" mentioned anywhere in v5 or v4. I suggested
to use "pi_entry" instead of "pi_object".

I agree that "object" and "entry" are equally abstract. As I said,
I prefer "entry" because I maintain also kernel/livepatch code
and we use "object" there in other meaning.

Alternative names would be struct pi_fmt_info or pi_fmt_rec like
metainformation or record about the printk format. They are
more specific than "entry".

> I don't feel strongly that this is more clear though, so maybe you
> mean something else?

I was pretty tired when reviewing the patch. It was not easy for me
to create the mental model of the code. I felt that some other names
would have made it easier.

Also the tricky pi_next() implementation did not help much. It looks
like you changed the code many times to get it working and did not
clean it at the end.

Best Regards,
Petr
