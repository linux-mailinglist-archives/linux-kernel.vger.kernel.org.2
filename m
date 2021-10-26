Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FD643B4AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 16:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbhJZOtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 10:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236054AbhJZOtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 10:49:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B52F7603E5;
        Tue, 26 Oct 2021 14:47:21 +0000 (UTC)
Date:   Tue, 26 Oct 2021 10:47:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Huan Xie <xiehuan09@gmail.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, mingo@redhat.com,
        chenhuacai@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [RFC PATCH v2] trace: Add trace any kernel object
Message-ID: <20211026104720.03ad26c2@gandalf.local.home>
In-Reply-To: <CAEr6+EBq_v+DGSDeiX5Dqc0RgD0sPpbhzpi=T2=r7M2oh90Fpg@mail.gmail.com>
References: <20211021185335.380810-1-xiehuan09@gmail.com>
        <20211022180752.0ed07b35@gandalf.local.home>
        <CAEr6+EBq_v+DGSDeiX5Dqc0RgD0sPpbhzpi=T2=r7M2oh90Fpg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 16:50:46 +0800
Huan Xie <xiehuan09@gmail.com> wrote:

> > > +static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
> > > +                              unsigned long object)
> > > +{
> > > +
> > > +     struct trace_buffer *buffer;
> > > +     struct ring_buffer_event *event;
> > > +     struct trace_object_entry *entry;
> > > +     int pc;
> > > +
> > > +     pc = preempt_count();
> > > +     event = trace_event_buffer_lock_reserve(&buffer, &event_trace_file,
> > > +                     TRACE_OBJECT, sizeof(*entry), pc);
> > > +     if (!event)
> > > +             return;
> > > +     entry   = ring_buffer_event_data(event);
> > > +     entry->ip                       = ip;
> > > +     entry->parent_ip                = parent_ip;
> > > +     entry->object                   = object;  
> >
> > So here we are just recording the value we saw at the kprobe (not very
> > interesting).
> >
> > I think we want the content of the object:
> >
> >         long val;
> >
> >         ret = copy_from_kernel_nofault(&val, object, sizeof(val));
> >         if (ret)
> >                 val = 0;  
> 
> This place is the only thing I don't understand, don't know  why and
> where to use the copy_from_kernel_nofault.


If we have the address of the symbol, we want to read what's at that
address, right?

> 
> we can only get the struct pt_regs from the  __kprobe_trace_fun() ,
> and use it on the  trace_object_trigger() ,
> so need to save the pt_regs using a struct:
> 
> struct object_trigger_param {
>         struct pt_regs *regs;
>         int param;
> };
> 
> /* Kprobe handler */
> static nokprobe_inline void __kprobe_trace_func(struct trace_kprobe
> *tk, struct pt_regs *regs,
>                     struct trace_event_file *trace_file)
> 
> 
> static void trace_object_trigger(struct event_trigger_data *data,
> struct trace_buffer *buffer,  void *rec,
>                    struct ring_buffer_event *event)


OK, so let me ask this question. What is it that you want to see?

If we have (using your example):

int bio_add_page(struct bio *bio, struct page *page,
				unsigned int len, unsigned int offset)

And we want to trace "bio" right?

Doing:

  echo 'p bio_add_page arg1=$arg1' > kprobe_events

Will make "arg1" be assigned the pointer that was passed in.

  0xffff888102a4b900

Which is a local variable that holds an address to some structure bio.

Your current example just keeps showing us that same pointer address and
not the content of bio, and will never change until the bio_add_page
function is called again, in which case, you will now be tracing the
next address of the structure that was passed into the function. There's
nothing more to learn from this over just tracing that function and giving
us the address passed in.

Now if I look at struct bio, I see:

struct bio {
	[..]
	atomic_t		__bi_cnt;	/* pin count */
	[..]
};

And let's say I want to monitor that __bi_cnt while functions are being
traced. What would be *really cool*, is to mark that value!

// find the offset of __bi_cnt in struct bio:
$ gdb vmlinux
(gdb) p &((struct bio *)0)->__bi_cnt
$1 = (atomic_t *) 0x64

 # echo 'objfilter:0x64(arg1) if comm == "cat"' > ./trigger

Which would then read that arg1=0xffff888102a4b900 and offset it by 0x64,
and give me the value at that location:

  *(0xffff888102a4b900 + 0x64)

at every function. Then I could watch the __bi_cnt change over time. But to
dereference memory safely, we need to use copy_from_kernel_nofault()
because that address "0xffff888102a4b900 + 0x64" could point to nothing
and fault / crash the kernel.

	obj = arg1 + 0x64
	if (copy_from_kernel_nofault(&val, arg1 + 0x64, sizeof(val)))
		// faulted
		return;

Now val has the content of __bi_cnt and we can print that!

-- Steve



> 
> > Then we can see what changed during this time.
