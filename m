Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF5E43B5CD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbhJZPnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbhJZPml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:42:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3916EC061243
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:40:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id p14so14053492wrd.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gePi6+TPmZdDYlmQwiKRPa1IXCbfIXiDKVvUp0KV1dk=;
        b=kE1rxiespvWKMp6929B+b7VBTV3OwweARXdocrjgmW0eNMH39Re6H+to/46iAB2k3E
         ST7TvPIGaMA4KG2iiHivUFFrjuTf7UZb19vsGPCwI0BuPfpVwTC/MTs1LGVRWBel3Aoq
         jySzkHqVYvIBXCuAc0hec6mqrxHEUsLSJXkKCd7P6v5gxqv6nnqFB4O2hIUS+vshY43c
         k07zV94SfiXalv34wAHkUXr+NJMLmRFFyjUC669lYj7JZekyKxvBrXgjFGpd55Jk2DA7
         BQCrJAgwVhdkuVPqMkRRbofzkadbF6Kqp8aSQbcNJvitB3GP66RAgmsgDd9KdZ4rPejw
         PtRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gePi6+TPmZdDYlmQwiKRPa1IXCbfIXiDKVvUp0KV1dk=;
        b=HS/3FJnCBSVPJoRAticJKaWJOesZTawoBrqdnv/LmHxvZxT9jmPlbfe8XEZJt/r4Qq
         hsx7hmL1ktA06YNHM7JND+OvkqB8JZzN5kqAWqZUHmDNujIaiJv1yU8NGz12RL4pfb8s
         X4p5s+eRQXyrgGRgq3Oo3PIu4Y/OH9W83qDryPKmmsb7PDaly0Ze+DwCnpAtGkWdxWvU
         4Rc3LX3xNnYNNzG7LkUhqTDBnMlVPcxjvjxo36PRwUCzAt5fn6Kv7vfTZnV0cThcQEbx
         6U3V3kk4JoMne9BAiQOQqTxhlBO5D/UtgbOKCpL5XYX8mEiVG4aXLmjyGsl2OfJtWnLE
         j2fg==
X-Gm-Message-State: AOAM532T4e4TVBwXizypCd3hysuMItGBprggFYOs51mjBW5CVmZuHpUI
        jdQ1v2j1iYwo5kvwSR+W1p2lbgQXitM7uWtM2JLHAzHJBFW0liqS
X-Google-Smtp-Source: ABdhPJxb0G4Gc1+Dty2VsaBtrIR7fYPcBPLKjsmZk9+J6COKJ0nz3k1HS/jiG8Jc9esfOQM6Osc9MxogrSsRAqAkfRA=
X-Received: by 2002:a05:6000:144c:: with SMTP id v12mr32626851wrx.142.1635262815445;
 Tue, 26 Oct 2021 08:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211021185335.380810-1-xiehuan09@gmail.com> <20211022180752.0ed07b35@gandalf.local.home>
 <CAEr6+EBq_v+DGSDeiX5Dqc0RgD0sPpbhzpi=T2=r7M2oh90Fpg@mail.gmail.com> <20211026104720.03ad26c2@gandalf.local.home>
In-Reply-To: <20211026104720.03ad26c2@gandalf.local.home>
From:   Huan Xie <xiehuan09@gmail.com>
Date:   Tue, 26 Oct 2021 23:40:03 +0800
Message-ID: <CAEr6+EDn=g+Q4FfxKn96K5CPcVT9B3FqJA0w4MMfo45DH8oShw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] trace: Add trace any kernel object
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, mingo@redhat.com,
        chenhuacai@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 10:47 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 26 Oct 2021 16:50:46 +0800
> Huan Xie <xiehuan09@gmail.com> wrote:
>
> > > > +static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
> > > > +                              unsigned long object)
> > > > +{
> > > > +
> > > > +     struct trace_buffer *buffer;
> > > > +     struct ring_buffer_event *event;
> > > > +     struct trace_object_entry *entry;
> > > > +     int pc;
> > > > +
> > > > +     pc = preempt_count();
> > > > +     event = trace_event_buffer_lock_reserve(&buffer, &event_trace_file,
> > > > +                     TRACE_OBJECT, sizeof(*entry), pc);
> > > > +     if (!event)
> > > > +             return;
> > > > +     entry   = ring_buffer_event_data(event);
> > > > +     entry->ip                       = ip;
> > > > +     entry->parent_ip                = parent_ip;
> > > > +     entry->object                   = object;
> > >
> > > So here we are just recording the value we saw at the kprobe (not very
> > > interesting).
> > >
> > > I think we want the content of the object:
> > >
> > >         long val;
> > >
> > >         ret = copy_from_kernel_nofault(&val, object, sizeof(val));
> > >         if (ret)
> > >                 val = 0;
> >
> > This place is the only thing I don't understand, don't know  why and
> > where to use the copy_from_kernel_nofault.
>
>
> If we have the address of the symbol, we want to read what's at that
> address, right?
>
> >
> > we can only get the struct pt_regs from the  __kprobe_trace_fun() ,
> > and use it on the  trace_object_trigger() ,
> > so need to save the pt_regs using a struct:
> >
> > struct object_trigger_param {
> >         struct pt_regs *regs;
> >         int param;
> > };
> >
> > /* Kprobe handler */
> > static nokprobe_inline void __kprobe_trace_func(struct trace_kprobe
> > *tk, struct pt_regs *regs,
> >                     struct trace_event_file *trace_file)
> >
> >
> > static void trace_object_trigger(struct event_trigger_data *data,
> > struct trace_buffer *buffer,  void *rec,
> >                    struct ring_buffer_event *event)
>
>
> OK, so let me ask this question. What is it that you want to see?

Thanks, I got your point now,  my original idea was to just track the
flow of objects.

> If we have (using your example):
>
> int bio_add_page(struct bio *bio, struct page *page,
>                                 unsigned int len, unsigned int offset)
>
> And we want to trace "bio" right?
>
> Doing:
>
>   echo 'p bio_add_page arg1=$arg1' > kprobe_events
>
> Will make "arg1" be assigned the pointer that was passed in.
>
>   0xffff888102a4b900
>
> Which is a local variable that holds an address to some structure bio.
>
> Your current example just keeps showing us that same pointer address and
> not the content of bio, and will never change until the bio_add_page
> function is called again, in which case, you will now be tracing the
> next address of the structure that was passed into the function. There's
> nothing more to learn from this over just tracing that function and giving
> us the address passed in.
>
> Now if I look at struct bio, I see:
>
> struct bio {
>         [..]
>         atomic_t                __bi_cnt;       /* pin count */
>         [..]
> };
>
> And let's say I want to monitor that __bi_cnt while functions are being
> traced. What would be *really cool*, is to mark that value!

This is really cool to  get the change of the value. And is a good
feature enhancement.

>
> // find the offset of __bi_cnt in struct bio:
> $ gdb vmlinux
> (gdb) p &((struct bio *)0)->__bi_cnt
> $1 = (atomic_t *) 0x64
>
>  # echo 'objfilter:0x64(arg1) if comm == "cat"' > ./trigger
>
> Which would then read that arg1=0xffff888102a4b900 and offset it by 0x64,
> and give me the value at that location:
>
>   *(0xffff888102a4b900 + 0x64)
>
> at every function. Then I could watch the __bi_cnt change over time. But to
> dereference memory safely, we need to use copy_from_kernel_nofault()
> because that address "0xffff888102a4b900 + 0x64" could point to nothing
> and fault / crash the kernel.
>
>         obj = arg1 + 0x64
>         if (copy_from_kernel_nofault(&val, arg1 + 0x64, sizeof(val)))
>                 // faulted
>                 return;
>
> Now val has the content of __bi_cnt and we can print that!
>
> -- Steve
>
>
>
> >
> > > Then we can see what changed during this time.
