Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11BF434FAE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhJTQHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhJTQHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:07:07 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE08C061749
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:04:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id o24so12689526wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dpt/MsviA+hGt4xSGSALXsvWeStZ/QYo7eit7xqAOS0=;
        b=N/MmyrA9NX356K/R/t+QAUNr/rG39Iqprq5Pzv5SUbo7lSLh7LX0ebrl3aTAr7VorN
         i9YQtl5lg+3boH79uiCJnH8VXiKKaOYWFgHMaE/7ns1MY5rTUV2vud8/fxsPcbSWcwU3
         B44LplvolWOg5MKHHwr/Ofq3d4qKQSszJs6V9Mp2BK8H0XuoHJcC5w6h19XvpMBU9uI3
         cgvBxkQ7QEsA/YzAx8CU8WfsEKVDLHE3Mlat2NHxDrF8g4iX6m6VQL7QvOgsRzfnHDXp
         laicBW1gef0d26GtoYBa9/jldpZ/6UeiXrgSkWxx5pB9wbqn6ZQ0QKY8WcmL0K4LcoY4
         60nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dpt/MsviA+hGt4xSGSALXsvWeStZ/QYo7eit7xqAOS0=;
        b=eRtEx7eBmz6dneZqfn45X7cL+mSY9vEBcyXrWSaL6K+TqxGnE1px2PKvwgYfAyhi1O
         M6BZzpmsGuu7oZq18H7x4ehRN4mztuZFgUZGJZSNYX/nBbfSbCvPTiQr4jGXwTVwM+z3
         yYxb/g4lmzkiZ3OSCXzA9JYxRqGQDiAa+I3ALBN46jp8LyjvZHkTX0e5FavCRGxKnW3F
         WI3V4q0BDJNasReD3W4wS1kSlwrfOWvJyI5hhdfQi5QZ7+i4e38KXNhcwqiMtQP2QfkV
         x3ib8PjT8Fc4HCb7FO8tJErMtoWr0TZTQU/YCZawxBMu5H69uPa9z6G9Jn17ugoNBWBN
         CHfA==
X-Gm-Message-State: AOAM5336+xtMnnfYkIHwkA9rQyY4zQY6QYKmKfkpbwbRCHEXuivf99g1
        vM4fP/nXsYHQt09rXf4rEfqBzh09/EbwWktyz9U=
X-Google-Smtp-Source: ABdhPJwHD9WHFWLxBHzLadtrONJmWE8yG0kDUBmHidiMdZSvG3ZE1QNFcvtsAdP73BvHzDVmDjlBpfbqP+TdzPcUZgI=
X-Received: by 2002:adf:e390:: with SMTP id e16mr69370wrm.217.1634745891526;
 Wed, 20 Oct 2021 09:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20211014014445.5734-1-xiehuan09@gmail.com> <20211013222056.312bec0c@oasis.local.home>
 <20211015220832.f9a13bd4ebbc4881b1e68163@kernel.org>
In-Reply-To: <20211015220832.f9a13bd4ebbc4881b1e68163@kernel.org>
From:   Huan Xie <xiehuan09@gmail.com>
Date:   Thu, 21 Oct 2021 00:04:40 +0800
Message-ID: <CAEr6+EDf1hcm2SawO07+69KnBrODmiM05AqeeBwN+4wuyME=6w@mail.gmail.com>
Subject: Re: [PATCH] trace: Add trace any kernel object
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        chenhuacai@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 9:08 PM Masami Hiramatsu <mhiramat@kernel.org> wrot=
e:
>
> On Wed, 13 Oct 2021 22:20:56 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > [ Added Masami ]
> >
> > On Thu, 14 Oct 2021 09:44:45 +0800
> > Jeff Xie <xiehuan09@gmail.com> wrote:
> >
> > > Introduce a method based on function tracer and kprobe event
> > > to trace any object in the linux kernel.
> >
> > I first want to say that this looks really interesting, and something
> > that can help out a lot!
> >
> > That said, we are going to have to work with you to come up with a
> > better and more flexible interface, and make sure locking and
> > synchronization works.
>
> Agreed. This is really interesting. I used to try to add hwbreak event
> but the problem is how to set up the hw breakpoint when I found the
> interesting one dynamically from kprobes.
>
> > >
> > > Usage:
> > > When using the kprobe event, only need to enable trace_object,
> > > we can trace any function argument or the return value. When
> > > the object passes through a function, it can be traced.
>
> With this idea, we don't have to have a hwbreak but just focus on
> the parameters etc.
>
> > >
> > > For example:
> > >
> > > For the function bio_add_page, we can trace the first argument:
> > >
> > > int bio_add_page(struct bio *bio, struct page *page,
> > >                             unsigned int len, unsigned int offset)
> > >
> > >     #cd /sys/kernel/debug/tracing
> > >     #echo 1 > ./trace_object
>
> Hmm, so what happen if there are several events in parallel?
>
> > >     #echo 'p bio_add_page arg1=3D$arg1' > kprobe_events
> > >     #echo 1 > ./events/kprobes/p_bio_add_page_0/enable
>
> what about adding a "objfilter" trigger action to update the object
> list? e.g.
>
> echo objfilter:add:arg1:1 if comm =3D=3D "sync" >> ./events/kprobes/p_bio=
_add_page_0/trigger
>
> This will "add the value of 'arg1' to objfilter 1 time if the process
> name is sync".

Thanks. The trigger seems to work in combination with kprobe/uprobe/eprobe.

I have been trying to implement this feature in recent days, But my
code does not look very elegant at the moment :-)

It seems the result of 'cat  trace' should also need to be filtered,
Because it will output the functions we don=E2=80=99t want to care about.

I didn't expect this idea to be a relatively large project. :-)

>
> And maybe before that, we need a "objtrace" tracer because
> as far as I can see, the trace output below is not compatible
> with function/fgraph tracer.
>
> Anyway, this is a great work!
>
> Thank you!
>
> > >     #sync
> > >     #cat ./trace
> > >
> > >     # tracer: nop
> > >     #
> > >     # entries-in-buffer/entries-written: 367/367   #P:4
> > >     #
> > >     #                                _-----=3D> irqs-off
> > >     #                               / _----=3D> need-resched
> > >     #                              | / _---=3D> hardirq/softirq
> > >     #                              || / _--=3D> preempt-depth
> > >     #                              ||| / _-=3D> migrate-disable
> > >     #                              |||| /     delay
> > >     #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > >     #              | |         |   |||||     |         |
> > >     kworker/u8:5-89      [000] .....    60.310385: p_bio_add_page_0: =
(bio_add_page+0x0/0x90) arg1=3D0xffff888102bde780
> > >     kworker/u8:5-89      [000] .....    60.310386: bio_add_page <-ext=
4_bio_write_page object:0xffff888102bde780
> > >     kworker/u8:5-89      [000] .....    60.310387: __bio_try_merge_pa=
ge <-bio_add_page object:0xffff888102bde780
> > >     kworker/u8:5-89      [000] .....    60.310387: __bio_add_page <-b=
io_add_page object:0xffff888102bde780
> > >     kworker/u8:5-89      [000] .....    60.310389: submit_bio <-ext4_=
io_submit object:0xffff888102bde780
> > >     kworker/u8:5-89      [000] .....    60.310389: submit_bio <-ext4_=
io_submit object:0xffff888102bde780
> > >     kworker/u8:5-89      [000] .....    60.310389: submit_bio_noacct =
<-ext4_io_submit object:0xffff888102bde780
> > >     kworker/u8:5-89      [000] .....    60.310389: submit_bio_checks =
<-submit_bio_noacct object:0xffff888102bde780
> > >     kworker/u8:5-89      [000] .....    60.310390: __cond_resched <-s=
ubmit_bio_checks object:0xffff888102bde780
> > >     kworker/u8:5-89      [000] .....    60.310390: rcu_all_qs <-__con=
d_resched object:0xffff888102bde780
> > >     kworker/u8:5-89      [000] .....    60.310390: should_fail_bio <-=
submit_bio_checks object:0xffff888102bde780
> > >     kworker/u8:5-89      [000] .....    60.310391: blk_mq_submit_bio =
<-submit_bio_noacct object:0xffff888102bde780
> > >     kworker/u8:5-89      [000] .....    60.310392: blk_attempt_plug_m=
erge <-blk_mq_submit_bio object:0xffff888102bde780
> > >     kworker/u8:5-89      [000] .....    60.310392: __blk_mq_sched_bio=
_merge <-blk_mq_submit_bio object:0xffff888102bde780
> > >     kworker/u8:5-89      [000] .....    60.310392: __blk_mq_alloc_req=
uest <-blk_mq_submit_bio object:0xffff888102bde780
> > >     kworker/u8:5-89      [000] .....    60.310393: blk_mq_get_tag <-_=
_blk_mq_alloc_request object:0xffff888102bde780
> > >     kworker/u8:5-89      [000] .....    60.310394: blk_account_io_sta=
rt <-blk_mq_submit_bio object:0xffff888102bde780
> > >           <idle>-0       [000] d....    60.311264: bio_advance <-blk_=
update_request object:0xffff888102bde780
> > >           <idle>-0       [000] d....    60.311265: bio_endio <-blk_up=
date_request object:0xffff888102bde780
> > >           <idle>-0       [000] d....    60.311265: ext4_end_bio <-blk=
_update_request object:0xffff888102bde780
> > >           <idle>-0       [000] d....    60.311266: ext4_finish_bio <-=
ext4_end_bio object:0xffff888102bde780
> > >           <idle>-0       [000] d....    60.311274: bio_put <-ext4_end=
_bio object:0xffff888102bde780
> > >           <idle>-0       [000] d....    60.311274: bio_free <-ext4_en=
d_bio object:0xffff888102bde780
> > >           <idle>-0       [000] d....    60.311274: bio_free <-ext4_en=
d_bio object:0xffff888102bde780
> > >           <idle>-0       [000] d....    60.311274: bvec_free <-bio_fr=
ee object:0xffff888102bde780
> > >           <idle>-0       [000] d....    60.311275: mempool_free <-bio=
_free object:0xffff888102bde780
> > >           <idle>-0       [000] d....    60.311275: mempool_free_slab =
<-bio_free object:0xffff888102bde780
> > >           <idle>-0       [000] d....    60.311275: mempool_free <-ext=
4_end_bio object:0xffff888102bde780
> > >           <idle>-0       [000] d....    60.311275: mempool_free_slab =
<-ext4_end_bio object:0xffff888102bde780
> > >           <idle>-0       [000] d....    60.311275: kmem_cache_free <-=
ext4_end_bio object:0xffff888102bde780
> > >           <idle>-0       [000] d....    60.311276: kmem_cache_free <-=
ext4_end_bio object:0xffff888102bde780
> > >     ...
> > >
> >
> > So if I understand the above, if you set this "trace_object" then
> > whatever gets placed into a kprobe parameter ($arg1?) or a return value
> > of a kretprobe, gets traced at every other function call?
> >
> >
> > > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > > ---
> > >  include/linux/ftrace.h       |   6 ++
> > >  kernel/trace/Kconfig         |   7 ++
> > >  kernel/trace/Makefile        |   1 +
> > >  kernel/trace/trace.c         |  69 +++++++++++++++++++
> > >  kernel/trace/trace.h         |   2 +
> > >  kernel/trace/trace_entries.h |  17 +++++
> > >  kernel/trace/trace_kprobe.c  |   6 ++
> > >  kernel/trace/trace_object.c  | 128 +++++++++++++++++++++++++++++++++=
++
> > >  kernel/trace/trace_output.c  |  40 +++++++++++
> > >  9 files changed, 276 insertions(+)
> > >  create mode 100644 kernel/trace/trace_object.c
> > >
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>

--
JeffXie
