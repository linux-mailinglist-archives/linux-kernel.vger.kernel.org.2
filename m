Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3024642E08C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 19:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhJNRyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 13:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232773AbhJNRyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 13:54:20 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19B8960C4A;
        Thu, 14 Oct 2021 17:52:15 +0000 (UTC)
Date:   Thu, 14 Oct 2021 13:52:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Huan Xie <xiehuan09@gmail.com>
Cc:     mingo@redhat.com, chenhuacai@kernel.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] trace: Add trace any kernel object
Message-ID: <20211014135212.08e56626@gandalf.local.home>
In-Reply-To: <CAEr6+ED8S10TuNuQaUqxNuh7za4JJ3Pib1JaVvK4mUXZ0Aco_w@mail.gmail.com>
References: <20211014014445.5734-1-xiehuan09@gmail.com>
        <20211013222056.312bec0c@oasis.local.home>
        <CAEr6+ED8S10TuNuQaUqxNuh7za4JJ3Pib1JaVvK4mUXZ0Aco_w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 01:35:05 +0800
Huan Xie <xiehuan09@gmail.com> wrote:

> > That said, we are going to have to work with you to come up with a
> > better and more flexible interface, and make sure locking and
> > synchronization works.  
> 
> Thank you very much for your help .I am not currently a full-time
> Linux kernel developer, and hope to work hard to submit
> more quality kernel patches.I view the kernel code almost every day.
> However, few patches have been submitted so far:).
> I have viewed the ftrace source code for about half a year and am very
> interested in and watched all the videos about ftrace
> you published on the internet.

It's good to hear people are still working on the kernel as a "hobbyist".
That's basically how I started.


> > Honestly, I don't think this should be implemented by a file. What
> > could work, and Masami let me know your thoughts, is to add something
> > to the kprobe/uprobe/eprobe interface. That is:
> >
> >  # echo 'p bio_add_page arg1=$arg1:trace' > kprobe_events  
> 
> Great, this one looks more advanced.
> 
> # echo 'p bio_add_page arg1=$arg1:trace' > kprobe_events

Right, I think this is the way I would like to go. But as Masami is the
maintainer of kprobes, he has final say.

> >
> > Or something, that we explicitly set on the kprobe itself, and then we
> > can pick what we want to trace, especially if we only want to trace
> > one item in the list.  
> 
> If we only want to trace one function or pick what we want to trace, we can
> set the file set_ftrace_filter in my understanding.

Sorta ;-)

The way you have the code right now, no that is not the case. But it can be
fixed by attaching it to the hash of the trace array. I'll have to help you
doing that because it is not very trivial.

I should add helpers to make it easier.


> > > +void set_trace_object(void *obj)
> > > +{
> > > +     int i;
> > > +
> > > +     if (!obj || global_trace_count == MAX_TRACE_OBJ_NUM)
> > > +             goto out;
> > > +
> > > +     for (i = 0; i < global_trace_count; i++) {
> > > +             if (global_trace_obj[i] == (unsigned long)obj)
> > > +                     goto out;
> > > +     }
> > > +     mutex_lock(&object_mutex_lock);  
> >
> > As stated above, this can be called from atomic context, and you can't
> > have a mutex here.  
> 
> I'm so sorry, I ignored it.

No problem. This is a learning process. You will likely still need a lock,
but it just can not be a mutex. A raw_spin_lock() (or RCU) will be more
appropriate. Again, I can help you with this.

> 
> >  
> > > +
> > > +     global_trace_obj[global_trace_count++] = (unsigned long)obj;
> > > +
> > > +     mutex_unlock(&object_mutex_lock);
> > > +out:
> > > +     return;
> > > +}
> > > +

-- Steve
