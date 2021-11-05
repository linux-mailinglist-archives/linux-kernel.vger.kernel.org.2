Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D9F44656E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 16:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233384AbhKEPHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 11:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbhKEPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 11:07:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F639C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 08:04:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso6921154wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 08:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5/EILAZi32RZSp2zg/j6nErSFv+SMsU8fhqSYdegBSY=;
        b=Ep9sCLh1qOGuPrXs4xirmQkSRRzA6BICBEXQat7K7pztdR/ZcQQywFvf4S+a+/btb7
         Je95yBQcL84ohhxfYY1cVth2fB8vI0psaElN3/c8hvE09oNEse0fhXniAu44/miDs14v
         XnWT2FmxrBw5M/spcDEAxdcJW3TlL3/yI+ihZbsL2lQW9qGdFl1avsnNSvzm/8saKDSQ
         Z5jqxkDpIzMMA0T7mYdA6GdODAdfNjLbMMLivvuv/b91x8pArUj3Twh1un9QMf1zUrz7
         Wf99uJvs4b8OTWGHgTLrz1eBAT4uUGSB31ROcsuaARjiE4XD3CSwSayB5v5t8FqmJ7JS
         nvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5/EILAZi32RZSp2zg/j6nErSFv+SMsU8fhqSYdegBSY=;
        b=xZab+1VauEygFjq52BifsN1AICRV8sThsEMVIudecnsb//OYTYrOdyF1T1ioMD7XeH
         j27aMqbfOWx0dULFAqEyhaEE7UI5RAjt8Y2AwVQCSqZtXgA7r7GvpYQtRaGTJk5L+YNO
         uu24kEQyXP/Fv9iy1i9MqQLUhhadsemHUHarfvy3Icxcb0Ipx1ZUeDLuEcUyNoamBtv7
         JdnyAid+2X3gCuxN1dBPNVkEB0tpp5FqlzxQfPrltMw8CrRm8ol7VN4FsJCqWiqAmMCH
         OijIqm6ES3wnv7fCHuyu5f83+V4o93WTu4g6/0fr+GtgQRg46u1hQR4b9yE53S8Luylk
         A49g==
X-Gm-Message-State: AOAM532BWkLdXFakrCZJrUjrWjpYpsAurC5ACF32/OQFMYcMIzkf2/EK
        8U/+oVVgYp/Wr18SmRnMYWJsjyRSZ8bDyBoTIc0odWgKUXL/lZMdeWI=
X-Google-Smtp-Source: ABdhPJxLpYfwVU8FoOZXqNQOShUdqFw1wcBSSlrTRkatI85oUQXDR1gNI0aIh/DjE2I/3iAEE0YRZrLvbm7vHAB8s6o=
X-Received: by 2002:a05:600c:296:: with SMTP id 22mr31806942wmk.135.1636124688531;
 Fri, 05 Nov 2021 08:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20211028092702.1099653-1-xiehuan09@gmail.com> <20211105004704.3f4aa456c2c537a56f64e65a@kernel.org>
 <CAEr6+EAGnYn337KAS3Sgx4m84vScxdRrS_yscofxErDugXOeSg@mail.gmail.com> <20211105225040.7e3d90b30c735ea72cf78e9b@kernel.org>
In-Reply-To: <20211105225040.7e3d90b30c735ea72cf78e9b@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Fri, 5 Nov 2021 23:04:36 +0800
Message-ID: <CAEr6+ECzHjmRKFsVGFCBAmdV2GO0cz8022PJqmOzySoSjbaOgg@mail.gmail.com>
Subject: Re: [RFC] [PATCH v3] trace: Add trace any kernel object
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Fri, Nov 5, 2021 at 9:50 PM Masami Hiramatsu <mhiramat@kernel.org> wrote=
:
>
> Hi Jeff,
>
> On Fri, 5 Nov 2021 17:11:27 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > Hi Masami,
> >
> > Thank you very much for your patient guidance and help, It helped me a =
lot.
> >
> > On Thu, Nov 4, 2021 at 11:47 PM Masami Hiramatsu <mhiramat@kernel.org> =
wrote:
> > >
> > > Hi Jeff,
> > >
> > > Thank you for updating!
> > >
> > > On Thu, 28 Oct 2021 17:27:02 +0800
> > > Jeff Xie <xiehuan09@gmail.com> wrote:
> > >
> > > > Introduce a method based on function tracer and kprobe/uprobe/trace=
_event/
> > > > to trace any object in the linux kernel.
> > > >
> > > > Usage:
> > > > When using kprobe/uprobe/trace_event/ we can use a new trigger(objt=
race)
> > > > to set object and trigger object trace.
> > > >
> > > > For example:
> > > >
> > > > For the function bio_add_page, we can trace the first argument:
> > > >
> > > > int bio_add_page(struct bio *bio, struct page *page,
> > > >                               unsigned int len, unsigned int offset=
)
> > > >
> > > > [root@JeffXie ]# cd /sys/kernel/debug/tracing/
> > > > [root@JeffXie tracing]# echo 'p bio_add_page arg1=3D$arg1' > kprobe=
_events
> > > > [root@JeffXie tracing]# cd events/kprobes/p_bio_add_page_0/
> > > > [root@JeffXie p_bio_add_page_0]# echo 'objtrace:arg1:1 if comm =3D=
=3D "cat"' > ./trigger
> > > > [root@JeffXie p_bio_add_page_0]# cat /test.txt
> > > > [root@JeffXie p_bio_add_page_0]# cd /sys/kernel/debug/tracing/
> > > > [root@JeffXie tracing]# cat ./trace
> > > > # tracer: nop
> > > > #
> > > > # entries-in-buffer/entries-written: 81/81   #P:4
> > > > #
> > > > #                                _-----=3D> irqs-off
> > > > #                               / _----=3D> need-resched
> > > > #                              | / _---=3D> hardirq/softirq
> > > > #                              || / _--=3D> preempt-depth
> > > > #                              ||| / _-=3D> migrate-disable
> > > > #                              |||| /     delay
> > > > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > > > #              | |         |   |||||     |         |
> > > >              cat-122     [001] .....   111.193997: bio_add_page <-e=
xt4_mpage_readpages object:0xffff888102a4b900
> > > >              cat-122     [001] .....   111.193998: __bio_try_merge_=
page <-bio_add_page object:0xffff888102a4b900
> > > >              cat-122     [001] .....   111.193998: __bio_add_page <=
-bio_add_page object:0xffff888102a4b900
> > > >              cat-122     [001] .....   111.193998: submit_bio <-ext=
4_mpage_readpages object:0xffff888102a4b900
> > > >              cat-122     [001] .....   111.193998: submit_bio_noacc=
t <-ext4_mpage_readpages object:0xffff888102a4b900
> > > >              cat-122     [001] .....   111.193999: __submit_bio <-s=
ubmit_bio_noacct object:0xffff888102a4b900
> > > >              cat-122     [001] .....   111.193999: submit_bio_check=
s <-__submit_bio object:0xffff888102a4b900
> > > >              cat-122     [001] .....   111.193999: __cond_resched <=
-submit_bio_checks object:0xffff888102a4b900
> > > >              cat-122     [001] .....   111.193999: rcu_all_qs <-__c=
ond_resched object:0xffff888102a4b900
> > > >              cat-122     [001] .....   111.194000: should_fail_bio =
<-submit_bio_checks object:0xffff888102a4b900
> > > >              cat-122     [001] .....   111.194001: blk_mq_submit_bi=
o <-__submit_bio object:0xffff888102a4b900
> > > >              cat-122     [001] .....   111.194001: blk_attempt_plug=
_merge <-blk_mq_submit_bio object:0xffff888102a4b900
> > > >              cat-122     [001] .....   111.194001: __blk_mq_sched_b=
io_merge <-blk_mq_submit_bio object:0xffff888102a4b900
> > > >              cat-122     [001] .....   111.194002: __blk_mq_alloc_r=
equest <-blk_mq_submit_bio object:0xffff888102a4b900
> > > >              cat-122     [001] .....   111.194002: blk_mq_get_tag <=
-__blk_mq_alloc_request object:0xffff888102a4b900
> > > >              cat-122     [001] .....   111.194003: blk_account_io_s=
tart <-blk_mq_submit_bio object:0xffff888102a4b900
> > > >           <idle>-0       [001] d....   111.194212: bio_advance <-bl=
k_update_request object:0xffff888102a4b900
> > > >           <idle>-0       [001] d....   111.194213: bio_endio <-blk_=
update_request object:0xffff888102a4b900
> > > >           <idle>-0       [001] d....   111.194213: mpage_end_io <-b=
lk_update_request object:0xffff888102a4b900
> > > >           <idle>-0       [001] d....   111.194213: __read_end_io <-=
blk_update_request object:0xffff888102a4b900
> > > >           <idle>-0       [001] d....   111.194218: bio_put <-blk_up=
date_request object:0xffff888102a4b900
> > > >           <idle>-0       [001] d....   111.194218: bio_free <-blk_u=
pdate_request object:0xffff888102a4b900
> > > >           <idle>-0       [001] d....   111.194218: bio_free <-blk_u=
pdate_request object:0xffff888102a4b900
> > > >           <idle>-0       [001] d....   111.194218: bvec_free <-bio_=
free object:0xffff888102a4b900
> > > >           <idle>-0       [001] d....   111.194219: mempool_free <-b=
lk_update_request object:0xffff888102a4b900
> > > >           <idle>-0       [001] d....   111.194219: mempool_free <-b=
lk_update_request object:0xffff888102a4b900
> > > >           <idle>-0       [001] d....   111.194219: mempool_free_sla=
b <-blk_update_request object:0xffff888102a4b900
> > > >           <idle>-0       [001] d....   111.194219: mempool_free_sla=
b <-blk_update_request object:0xffff888102a4b900
> > > >           <idle>-0       [001] d....   111.194219: kmem_cache_free =
<-blk_update_request object:0xffff888102a4b900
> > > >           <idle>-0       [001] d....   111.194219: kmem_cache_free =
<-blk_update_request object:0xffff888102a4b900
> > > >
> > > > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > > > ---
> > > > Currently only showing all the code I have, But I think that there =
are main three tasks
> > > > to be completed next:
> > > >
> > > > 1. Masami suggested:
> > > >
> > > > <snip>
> > > > objfilter:add:arg1
> > > >
> > > > and the exit event
> > > >
> > > > objfilter:del:arg1
> > > >
> > > > then user will only see the trace between the entrance and exit eve=
nts.
> > > > </snip>
> > > >
> > > > Actually, I don=E2=80=99t have a good idea to implement it now ;-)
> > > > Looking for related existing code logic.
> > >
> > > Even though, please support 'add' command at least (no problem even i=
f
> > > there is only 'add' supported) because it defines its syntax.
> > > It seems a bit redundant now, but if there is 'add', we can extend it=
 to
> > > support 'del', 'clear' or 'update' etc.
> > >
> >
> > Thanks, I will add the "add" command.
>
> Thanks!
>
> >
> > >
> > > >
> > > > 2. Steven suggested:
> > > > <snip>
> > > > For example:
> > > >
> > > >       obj =3D arg1 + 0x64
> > > >       if (copy_from_kernel_nofault(&val, arg1 + 0x64, sizeof(val)))
> > > >               // faulted
> > > >               return;
> > > >
> > > > Now val has the content of __bi_cnt and we can print that!
> > > > </snip>
> > > >
> > > > We need to implement a more complex parsing and also record the siz=
e of a arg
> > > > or other related members.it may change the way I record the object.
> > >
> > > That can be done in additional patch in a series. I recommend you to =
send a
> > > series of patches, which simply add a feature (or extend existing fea=
ture),
> > > step by step.
> >
> > This is a good suggestion, although I have never submitted a patchset.
> > I will try it. ;-=EF=BC=89
> >
> > > >
> > > >
> > > > 3. Update trigger documentation
> > > >
> > > > https://lore.kernel.org/lkml/20211026225234.549ec8e9eb59f1fd1671edb=
c@kernel.org/T/#t
> > > >
> > > > I'm very happy to work with you all, and got a lot of knowledge fro=
m your help.
> > > >
> > > > At present, I am the only person writing code using the free time, =
I usually need to do
> > > > other work about linux and take care of a three-month-old boy. unli=
ke a group, the progress
> > > > of submitting patches may be slower.
> > >
> > > That is OK. You can start sowing the seeds, then we can grow it. :-)
> >
> > I never thought that my idea might become a relatively large project.
> > With my current level of kernel programming, I might not be able to
> > complete it alone.
> >
> > > And also, please add a (set of) testcase for this feature under
> > > tools/testing/selftests/ftrace/test.d/, so that the future changes wi=
ll not
> > > cause any regression. You don't have to check the trace result (if yo=
u can,
> > > it is recommended) but at least the usage (e.g. accepting correct syn=
tax,
> > > and rejecting wrong syntax) test case is helpful.
> >
> > ok, I will add a set of testcase.
>
> Good :)
>
>
> [...]
> > > > +static void obj_refill_fn(struct work_struct *refill_work)
> > > > +{
> > > > +     void **new_obj_element;
> > > > +     unsigned long flags;
> > > > +     int new_min_nr, new_curr_nr;
> > > > +     int used_nr;
> > > > +
> > > > +     new_min_nr =3D obj_pool.min_nr * 2;
> > >
> > > This can easily cause OOM. I think we need a limit to cap.
> > > Anyway, at the first step, you can drop this "refill" routine and
> > > simply use fixed size array (or hash table?).
> > > Anyway if the array becomes huge, your kernel may slow down.
> >
> > If we limit the max size, should be able to solve the OOM.
> > The logic of this refill should look normal, But in order to simplify
> > the implementation of the first step,
> > I can remove the refill routine.
>
> I would like to ask you to focus on the performance side, since
> the search (object_exist) will be run on every function call.
> You can make it a lockless, kretprobe_instance pool (in kernel/kprobes.c)
> will be a good example for you.

Thanks, I will learn from this example.

>
> [...]
> > > > +
> > > > +static void
> > > > +trace_object_trigger(struct event_trigger_data *data,
> > > > +                struct trace_buffer *buffer,  void *rec,
> > > > +                struct ring_buffer_event *event)
> > > > +{
> > > > +
> > > > +     struct ftrace_event_field *field =3D data->private_data;
> > > > +     void *obj =3D NULL;
> > > > +
> > > > +     memcpy(&obj, (char *)rec + field->offset, field->size);
> > >
> > > Please use 'sizeof(obj)' instead of 'field->size' because 'field->siz=
e'
> > > can be longer than that.
> > >
> > This is only one  I can't understand.
> >
> > The field->size should be (1(u8/s8), 2(u16/s16), 4(u32/s32),
> > 8(u64/s64)) , the sizeof(obj) is 8
> > and it should never be longer than sizeof(obj).
>
> You may forget 32bit CPUs..., and you don't need smaller values too,
> since it will easily cause false positive. So tracing an object
> address is good.

In this case, it is indeed better to use sizeof(obj) ;-)

Actually I have submitted the [RFC][PATCH V4], I will also modify it.

> Thank you!
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>

Thanks,
---
JeffXie
