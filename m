Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E549645F0DE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378032AbhKZPoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbhKZPmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:42:45 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5E6C06137E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 07:33:07 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so7076939wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 07:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wuBhmBZFoDHK6BPlQuiZcr0M1PDOI29lt5ZZslUzvM8=;
        b=TgCHEpvQ0bpFdbyhSPTPA2wqBpFqRqgL++lEvEqe/flWuTWz58NdqQG+UslmNnmV3F
         6O8ligplAB0f1J+4YIVJWB2AP0Vv/Zo9e0YKKwbv9E4NXtQT2mfwiOF9jcQhzCxvPr6h
         XV8EITKS1Z2WLCKlFqanDIaCe/u2PqHk+nDXxrOAldImnZ+oThCZUERmpMlUrvzggbOj
         jWq8dA4HWNvLTWk4nPqtuSmTW/dDmGVkWTlELqdblFDplUuPleWdEXEZigyjAQKMK9n9
         GfmhzA87Ql9daqR9+1T1WR4WPsDvXBR00gZqbzZ4Zcy1Q+s+5we25vq2581BtLzDRmy0
         5xyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wuBhmBZFoDHK6BPlQuiZcr0M1PDOI29lt5ZZslUzvM8=;
        b=Sr4ffPP/ilQgSRvyRrFCuk1NLS/bOqVSLgY0ptgf2z353G2SsEp0EJO5q6b5j1em0p
         W+WK2mfmuUB2Szch7Gi2QKKUsQn0sVzcunKmjtRrC1bvM+htdkMX9MLkp538QcaCFlC0
         QEj5XDidjl43o0JHiVel+EjlRR/yZKDJya1ihfsqEhpQowKDFbSW5odon2qqUuf0Z/Mr
         N3uYdXf6xJpv+iQztMGTfoO2Y8orRNycg0d0gQ9oBZIYzcnI3LoCdWJUFEeJNQztuNXo
         DjLQuBpJjYm0gqOkJ6/odzPgTwCwlaSU3V5NkOhfSGdpZVQDkhB6Vm72DUZe30CVOLk1
         AFKw==
X-Gm-Message-State: AOAM531M782O9Tu1pHiLLcR9l7bSVLknph6IS26eqVGeI0x2ky/AfIaz
        v3+4AyMCM8akZuWYiI9bntLL3m9Y/4oxHOfe1yY=
X-Google-Smtp-Source: ABdhPJzVC1Q57IdrXH8Ii/YZIDzErfTJjyqpkb7eKs6mI86CnNn/72Kl6/vTZRPMoNsKjJrj8xEgG6FXjnW5BEIS5ZE=
X-Received: by 2002:a05:600c:104b:: with SMTP id 11mr16733652wmx.54.1637940786003;
 Fri, 26 Nov 2021 07:33:06 -0800 (PST)
MIME-Version: 1.0
References: <20211113120632.94754-1-xiehuan09@gmail.com> <20211113120632.94754-2-xiehuan09@gmail.com>
 <20211119230118.2f8689d630817cb103161402@kernel.org> <CAEr6+EAcfhF15vsYrkBWsjZEFe=LZ4ZfbgPM2BC9sGpweofEfA@mail.gmail.com>
 <CAEr6+EAjtk2TA5bDP7-D=VhwwXzL2Pq172NCbr7XnNT9ynPpow@mail.gmail.com> <20211127001905.22f521e44f4e89c78dc03e8c@kernel.org>
In-Reply-To: <20211127001905.22f521e44f4e89c78dc03e8c@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Fri, 26 Nov 2021 23:32:52 +0800
Message-ID: <CAEr6+EB4XeRdo5rY8wKyAHMdOsOcq8w8dWHpaFQPEyymZ8xzQQ@mail.gmail.com>
Subject: Re: [RFC][PATCH v5 2/4] trace/objtrace: get the value of the object
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Fri, Nov 26, 2021 at 11:19 PM Masami Hiramatsu <mhiramat@kernel.org> wro=
te:
>
> Hello Jeff,
>
> On Fri, 26 Nov 2021 21:47:24 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > Hi Masami,
> >
> > On Mon, Nov 22, 2021 at 1:15 AM Jeff Xie <xiehuan09@gmail.com> wrote:
> > >
> > > Hi Masami,
> > >
> > > On Fri, Nov 19, 2021 at 10:01 PM Masami Hiramatsu <mhiramat@kernel.or=
g> wrote:
> > > >
> > > > Hi Jeff,
> > > >
> > > > On Sat, 13 Nov 2021 20:06:30 +0800
> > > > Jeff Xie <xiehuan09@gmail.com> wrote:
> > > >
> > > > Please describe here what feature this patch adds.
> > > > How to use, and new syntax, etc.
> > > >
> > > > BTW, the syntax for this value trace is a bit confusing.
> > > >
> > > > objtrace:add:OFFS(OBJ):TYPE[:COUNT]
> > > >
> > > > This trace "OBJ", but from the user point of view, this seems to tr=
ace
> > > > "OFFS(OBJ)".
> > > >
> > > > I rather like make it optional and split from OBJ as below;
> > > >
> > > > objtrace:add:OBJ[,OFFS:TYPE][:COUNT]
> >
> > I have been thinking about this place for a long time, would it be
> > better if it like below?
> > objtrace:add:OBJ[,OFFS][:TYPE][:COUNT]
> >
> > If the user does not specify the type, the default type will be u64.
>
> u64 or ulong? In kprobe event, I chose ulong (u32 for 32bit arch and
> u64 for 64bit arch). If the object or the data at offs is a pointer,
> it is better to use appropriate type for each arch.

It is ulong, I will never forget a 32-bit architecture =EF=BC=9B-=EF=BC=89

Thanks.

> Thank you,
>
>
>
> >
> > > >
> > > > (Note that the part braced by [] is optional.)
> > >
> > > Thank you for your suggestion, it does seem clearer, I will modify it=
 like this.
> > >
> > > > Thank you,
> > > >
> > > > > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > > > > ---
> > > > >  kernel/trace/trace_entries.h |   5 +-
> > > > >  kernel/trace/trace_object.c  | 121 +++++++++++++++++++++++++++++=
------
> > > > >  kernel/trace/trace_output.c  |   6 +-
> > > > >  3 files changed, 107 insertions(+), 25 deletions(-)
> > > > >
> > > > > diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_en=
tries.h
> > > > > index bb120d9498a9..2407c45a568c 100644
> > > > > --- a/kernel/trace/trace_entries.h
> > > > > +++ b/kernel/trace/trace_entries.h
> > > > > @@ -413,8 +413,9 @@ FTRACE_ENTRY(object, trace_object_entry,
> > > > >               __field(        unsigned long,          ip         =
     )
> > > > >               __field(        unsigned long,          parent_ip  =
     )
> > > > >               __field(        unsigned long,          object     =
     )
> > > > > +             __field(        unsigned long,          value      =
     )
> > > > >       ),
> > > > >
> > > > > -     F_printk(" %ps <-- %ps object:%lx\n",
> > > > > -              (void *)__entry->ip, (void *)__entry->parent_ip, _=
_entry->object)
> > > > > +     F_printk(" %ps <-- %ps object:%lx value:%lx\n", (void *)__e=
ntry->ip,
> > > > > +            (void *)__entry->parent_ip, __entry->object, __entry=
->value)
> > > > >  );
> > > > > diff --git a/kernel/trace/trace_object.c b/kernel/trace/trace_obj=
ect.c
> > > > > index 69465c2ffb7e..14993f7d0e5a 100644
> > > > > --- a/kernel/trace/trace_object.c
> > > > > +++ b/kernel/trace/trace_object.c
> > > > > @@ -11,14 +11,25 @@
> > > > >
> > > > >  static DEFINE_PER_CPU(atomic_t, trace_object_event_disable);
> > > > >  static struct trace_event_file event_trace_file;
> > > > > -static const int max_args_num =3D 6;
> > > > >  static const int max_obj_pool =3D 10;
> > > > >  static atomic_t trace_object_ref;
> > > > >  static int exit_trace_object(void);
> > > > >  static int init_trace_object(void);
> > > > >
> > > > > +struct objtrace_trigger_data {
> > > > > +     struct ftrace_event_field *field;
> > > > > +     long offset;
> > > > > +     int type_size;
> > > > > +};
> > > > > +
> > > > > +struct objtrace_fetch_type {
> > > > > +     char *name;
> > > > > +     int type_size;
> > > > > +};
> > > > > +
> > > > >  struct object_instance {
> > > > >       void *object;
> > > > > +     int obj_type_size;
> > > > >       struct freelist_node freelist;
> > > > >  };
> > > > >
> > > > > @@ -59,8 +70,7 @@ static bool object_empty(void)
> > > > >       return ret;
> > > > >  }
> > > > >
> > > > > -
> > > > > -static void set_trace_object(void *obj)
> > > > > +static void set_trace_object(void *obj, int type_size)
> > > > >  {
> > > > >       struct freelist_node *fn;
> > > > >       struct object_instance *ins;
> > > > > @@ -79,6 +89,7 @@ static void set_trace_object(void *obj)
> > > > >
> > > > >       ins =3D container_of(fn, struct object_instance, freelist);
> > > > >       ins->object =3D obj;
> > > > > +     ins->obj_type_size =3D type_size;
> > > > >
> > > > >       freelist_add(&ins->freelist, &obj_pool->customer_freelist);
> > > > >       atomic_inc(&obj_pool->nobject);
> > > > > @@ -135,7 +146,7 @@ static int init_object_pool(void)
> > > > >  }
> > > > >
> > > > >  static void submit_trace_object(unsigned long ip, unsigned long =
parent_ip,
> > > > > -                              unsigned long object)
> > > > > +                              unsigned long object, unsigned lon=
g value)
> > > > >  {
> > > > >
> > > > >       struct trace_buffer *buffer;
> > > > > @@ -152,6 +163,7 @@ static void submit_trace_object(unsigned long=
 ip, unsigned long parent_ip,
> > > > >       entry->ip                       =3D ip;
> > > > >       entry->parent_ip                =3D parent_ip;
> > > > >       entry->object                   =3D object;
> > > > > +     entry->value                    =3D value;
> > > > >
> > > > >       event_trigger_unlock_commit(&event_trace_file, buffer, even=
t,
> > > > >               entry, pc);
> > > > > @@ -161,10 +173,11 @@ static void
> > > > >  trace_object_events_call(unsigned long ip, unsigned long parent_=
ip,
> > > > >               struct ftrace_ops *op, struct ftrace_regs *fregs)
> > > > >  {
> > > > > -     struct pt_regs *pt_regs =3D ftrace_get_regs(fregs);
> > > > > -     unsigned long obj;
> > > > > +     struct freelist_node *node;
> > > > > +     struct object_instance *inst;
> > > > > +     unsigned long val =3D 0;
> > > > >       long disabled;
> > > > > -     int cpu, n;
> > > > > +     int cpu;
> > > > >
> > > > >       preempt_disable_notrace();
> > > > >
> > > > > @@ -177,10 +190,14 @@ trace_object_events_call(unsigned long ip, =
unsigned long parent_ip,
> > > > >       if (object_empty())
> > > > >               goto out;
> > > > >
> > > > > -     for (n =3D 0; n < max_args_num; n++) {
> > > > > -             obj =3D regs_get_kernel_argument(pt_regs, n);
> > > > > -             if (object_exist((void *)obj))
> > > > > -                     submit_trace_object(ip, parent_ip, obj);
> > > > > +     node =3D obj_pool->customer_freelist.head;
> > > > > +
> > > > > +     while (node) {
> > > > > +             inst =3D container_of(node, struct object_instance,=
 freelist);
> > > > > +             if (copy_from_kernel_nofault(&val, inst->object, in=
st->obj_type_size))
> > > > > +                     goto out;
> > > > > +             submit_trace_object(ip, parent_ip, (unsigned long)i=
nst->object, val);
> > > > > +             node =3D node->next;
> > > > >       }
> > > > >
> > > > >  out:
> > > > > @@ -198,12 +215,14 @@ trace_object_trigger(struct event_trigger_d=
ata *data,
> > > > >                  struct trace_buffer *buffer,  void *rec,
> > > > >                  struct ring_buffer_event *event)
> > > > >  {
> > > > > +     struct objtrace_trigger_data *obj_data =3D data->private_da=
ta;
> > > > > +     struct ftrace_event_field *field;
> > > > > +     void *obj, *val =3D NULL;
> > > > >
> > > > > -     struct ftrace_event_field *field =3D data->private_data;
> > > > > -     void *obj =3D NULL;
> > > > > -
> > > > > -     memcpy(&obj, rec + field->offset, sizeof(obj));
> > > > > -     set_trace_object(obj);
> > > > > +     field =3D obj_data->field;
> > > > > +     memcpy(&val, rec + field->offset, sizeof(val));
> > > > > +     obj =3D val + obj_data->offset;
> > > > > +     set_trace_object(obj, obj_data->type_size);
> > > > >  }
> > > > >
> > > > >  static void
> > > > > @@ -350,6 +369,22 @@ static void unregister_object_trigger(char *=
glob, struct event_trigger_ops *ops,
> > > > >       }
> > > > >  }
> > > > >
> > > > > +static const struct objtrace_fetch_type objtrace_fetch_types[] =
=3D {
> > > > > +     {"u8", 1},
> > > > > +     {"s8", 1},
> > > > > +     {"x8", 1},
> > > > > +     {"u16", 2},
> > > > > +     {"s16", 2},
> > > > > +     {"x16", 2},
> > > > > +     {"u32", 4},
> > > > > +     {"s32", 4},
> > > > > +     {"x32", 4},
> > > > > +     {"u64", 8},
> > > > > +     {"s64", 8},
> > > > > +     {"x64", 8},
> > > > > +     {}
> > > > > +};
> > > > > +
> > > > >  static int
> > > > >  event_object_trigger_callback(struct event_command *cmd_ops,
> > > > >                      struct trace_event_file *file,
> > > > > @@ -357,13 +392,15 @@ event_object_trigger_callback(struct event_=
command *cmd_ops,
> > > > >  {
> > > > >       struct event_trigger_data *trigger_data;
> > > > >       struct event_trigger_ops *trigger_ops;
> > > > > +     struct objtrace_trigger_data *obj_data;
> > > > >       struct trace_event_call *call;
> > > > >       struct ftrace_event_field *field;
> > > > >       char *objtrace_cmd;
> > > > > +     long offset =3D 0;
> > > > >       char *trigger =3D NULL;
> > > > > -     char *arg;
> > > > > +     char *arg, *type, *tr, *tr_end;
> > > > >       char *number;
> > > > > -     int ret;
> > > > > +     int ret, i, type_size =3D 0;
> > > > >
> > > > >       ret =3D -EINVAL;
> > > > >       if (!param)
> > > > > @@ -386,6 +423,38 @@ event_object_trigger_callback(struct event_c=
ommand *cmd_ops,
> > > > >       arg =3D strsep(&trigger, ":");
> > > > >       if (!arg)
> > > > >               goto out;
> > > > > +
> > > > > +     tr =3D strchr(arg, '(');
> > > > > +     /* now force to get the value of the val. */
> > > > > +     if (!tr)
> > > > > +             goto out;
> > > > > +     tr_end =3D strchr(tr, ')');
> > > > > +     if (!tr_end)
> > > > > +             goto out;
> > > > > +     *tr++ =3D '\0';
> > > > > +     *tr_end =3D '\0';
> > > > > +     ret =3D kstrtol(arg, 0, &offset);
> > > > > +     if (ret)
> > > > > +             goto out;
> > > > > +     arg =3D tr;
> > > > > +     ret =3D -EINVAL;
> > > > > +     if (!trigger)
> > > > > +             goto out;
> > > > > +
> > > > > +     type =3D strsep(&trigger, ":");
> > > > > +     if (!type)
> > > > > +             goto out;
> > > > > +     for (i =3D 0; objtrace_fetch_types[i].name; i++) {
> > > > > +             if (strcmp(objtrace_fetch_types[i].name, type) =3D=
=3D 0) {
> > > > > +                     type_size =3D objtrace_fetch_types[i].type_=
size;
> > > > > +                     break;
> > > > > +             }
> > > > > +     }
> > > > > +
> > > > > +     if (type_size =3D=3D 0)
> > > > > +             goto out;
> > > > > +
> > > > > +
> > > > >       call =3D file->event_call;
> > > > >       field =3D trace_find_event_field(call, arg);
> > > > >       if (!field)
> > > > > @@ -394,19 +463,30 @@ event_object_trigger_callback(struct event_=
command *cmd_ops,
> > > > >       trigger_ops =3D cmd_ops->get_trigger_ops(cmd, trigger);
> > > > >
> > > > >       ret =3D -ENOMEM;
> > > > > +     obj_data =3D kzalloc(sizeof(*obj_data), GFP_KERNEL);
> > > > > +     if (!obj_data)
> > > > > +             goto out;
> > > > > +
> > > > > +     obj_data->field =3D field;
> > > > > +     obj_data->offset =3D offset;
> > > > > +     obj_data->type_size =3D type_size;
> > > > > +
> > > > >       trigger_data =3D kzalloc(sizeof(*trigger_data), GFP_KERNEL)=
;
> > > > > -     if (!trigger_data)
> > > > > +     if (!trigger_data) {
> > > > > +             kfree(obj_data);
> > > > >               goto out;
> > > > > +     }
> > > > >
> > > > >       trigger_data->count =3D -1;
> > > > >       trigger_data->ops =3D trigger_ops;
> > > > >       trigger_data->cmd_ops =3D cmd_ops;
> > > > > -     trigger_data->private_data =3D field;
> > > > > +     trigger_data->private_data =3D obj_data;
> > > > >       INIT_LIST_HEAD(&trigger_data->list);
> > > > >       INIT_LIST_HEAD(&trigger_data->named_list);
> > > > >
> > > > >       if (glob[0] =3D=3D '!') {
> > > > >               cmd_ops->unreg(glob+1, trigger_ops, trigger_data, f=
ile);
> > > > > +             kfree(obj_data);
> > > > >               kfree(trigger_data);
> > > > >               ret =3D 0;
> > > > >               goto out;
> > > > > @@ -461,6 +541,7 @@ event_object_trigger_callback(struct event_co=
mmand *cmd_ops,
> > > > >   out_free:
> > > > >       if (cmd_ops->set_filter)
> > > > >               cmd_ops->set_filter(NULL, trigger_data, NULL);
> > > > > +     kfree(obj_data);
> > > > >       kfree(trigger_data);
> > > > >       goto out;
> > > > >  }
> > > > > diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_out=
put.c
> > > > > index 76ca560af693..c8c427c23127 100644
> > > > > --- a/kernel/trace/trace_output.c
> > > > > +++ b/kernel/trace/trace_output.c
> > > > > @@ -1562,6 +1562,7 @@ static enum print_line_t trace_object_print=
(struct trace_iterator *iter, int fla
> > > > >       trace_assign_type(field, iter->ent);
> > > > >       print_fn_trace(s, field->ip, field->parent_ip, flags);
> > > > >       trace_seq_printf(s, " object:0x%lx", field->object);
> > > > > +     trace_seq_printf(s, " value:0x%lx", field->value);
> > > > >       trace_seq_putc(s, '\n');
> > > > >
> > > > >       return trace_handle_return(s);
> > > > > @@ -1574,9 +1575,8 @@ static enum print_line_t trace_object_raw(s=
truct trace_iterator *iter, int flags
> > > > >
> > > > >       trace_assign_type(field, iter->ent);
> > > > >
> > > > > -     trace_seq_printf(&iter->seq, "%lx %lx\n",
> > > > > -                      field->ip,
> > > > > -                      field->parent_ip);
> > > > > +     trace_seq_printf(&iter->seq, "%lx %lx %lx %lx\n", field->ip=
,
> > > > > +                     field->parent_ip, field->object, field->val=
ue);
> > > > >
> > > > >       return trace_handle_return(&iter->seq);
> > > > >  }
> > > > > --
> > > > > 2.25.1
> > > > >
> > > >
> > > >
> > > > --
> > > > Masami Hiramatsu <mhiramat@kernel.org>
> > >
> > > Thanks,
> > > ---
> > > JeffXie
> >
> > ---
> > JeffXie
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
---
JeffXie
