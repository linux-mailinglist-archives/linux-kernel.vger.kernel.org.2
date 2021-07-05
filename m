Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449383BC363
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 22:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhGEUfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 16:35:44 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:38624 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhGEUfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 16:35:43 -0400
Received: by mail-lj1-f170.google.com with SMTP id t30so6116755ljo.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 13:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZMAwlc3NyUemDGKpzWf4/j+hQn2HilOi2t8XItebZXo=;
        b=f5GD31tyMqo/Z0GawxqHOMykrgmoAx0dFDf+C7RU5TKriTKnaiZYZQ6rbzuRGmd3pM
         lnyJIQ3UK0aYxbNvHaWc39pYitT+2vAXpDwgyK6ZCJ9Vj9IK8NXoUpZRX5w9GjK6bL8c
         ZJ2a5iSU5uQApYhpSSPvV9uCv6BoifxjIr3mE1tnxbZmPTrMabhGcwmwrINFUJjW+LCN
         KkcCF+Njw9CKLorjyVnPdQzxDxe6BfjsOOl0aEv5uLelMNli7kCrRpWedgvLQH/qxSXb
         xBoddDB+N1/nL7w1upXVmYKQQaq0DlzvLWKBbTVnfm00/E1A007qm7DL9nQ1FuK8U7rf
         ExUg==
X-Gm-Message-State: AOAM531aSPQbFt/kP78DrFDp/Kzxfa4/R/DVgPLnawhe+V7BQUKl2cgj
        3Pz7y5DQfxh7oZx2QIQgdNxmx13Zpa1Daj0sqq5iH5VcVsw=
X-Google-Smtp-Source: ABdhPJzkYPWCcVnWZyCKwmcMnNiE17AoPRs8Gel2K2gOOo/wGkmn0EyPjx1nbba2t7O2XVVnhslRhAgvSI/2WlaqQVo=
X-Received: by 2002:a2e:8e6d:: with SMTP id t13mr12199006ljk.26.1625517185228;
 Mon, 05 Jul 2021 13:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210702175648.1172476c@gandalf.local.home> <20210703190725.8082fc92c244e26abec0bf8b@kernel.org>
 <20210703082713.3643b4d6@rorschach.local.home>
In-Reply-To: <20210703082713.3643b4d6@rorschach.local.home>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 5 Jul 2021 13:32:53 -0700
Message-ID: <CAM9d7chNNYdg5OPir=1QuyQ0OqdZJ=jbW5iy+6o9kSNuqZ1i_A@mail.gmail.com>
Subject: Re: [PATCH] tracing: Add "grouping" to histogram logic
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve and Masami,

On Sat, Jul 3, 2021 at 5:27 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat, 3 Jul 2021 19:07:25 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> > On Fri, 2 Jul 2021 17:56:48 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > >
> > > There's been several times I wished the histogram logic had a "grouping"
> > > feature for the buckets. Currently, each bucket has a size of one. That
> > > is, if you trace the amount of requested allocations, each allocation is
> > > its own bucket, even if you are interested in what allocates 100 bytes or
> > > less, 100 to 200, 200 to 300, etc.
> >
> > Great! So is that a kind of "unit" of the keys?
>
> Not sure if "unit" is the write word. Just a division.

What about just "bucket" then?

>
> >
> > > Also, without grouping, it fills up the allocated histogram buckets
> > > quickly. If you are tracking latency, and don't care if something is 200
> > > microseconds off, or 201 microseconds off, but want to track them by say
> > > 10 microseconds each. This can not currently be done.
> > >
> > > Introduce a "grouping" command to each field where it will record in a
> > > rounded number. For example:
> >
> > BTW, the separator seems a bit confusing. Is it "keys=FIELD-UNIT"?
> > I prefer to use '/' as "keys=FIELD/UNIT" so that the FIELD is
> > grouped by UNIT units. What would you think?
>
> Yeah, I just picked '-' but then realized it would conflict with other
> key words.

Also we already have ".log2" flag for a logarithmic histrogram.
Then we might have something like "keys=FIELD.bucket=SIZE"
for linear histograms.

Thanks,
Namhyung


> >
> > Also, could you also update README file?
>
> Agreed. BTW, I forgot to add [RFC] to the subject, because that's what
> this patch is.
>
> Thanks!
>
> -- Steve
>
>
> >
> > Thank you,
> >
> > >
> > >  ># echo 'hist:keys=bytes_req-100:sort=bytes_req' > events/kmem/kmalloc/trigger
> > >  ># cat events/kmem/kmalloc/hist
> > >  # event histogram
> > >  #
> > >  # trigger info:
> > >  hist:keys=bytes_req-100:vals=hitcount:sort=bytes_req-100:size=2048
> > >  [active]
> > >  #
> > >
> > >  { bytes_req:          0-99 } hitcount:       7207
> > >  { bytes_req:        100-199 } hitcount:       1030
> > >  { bytes_req:        200-299 } hitcount:        602
> > >  { bytes_req:        300-399 } hitcount:        414
> > >  { bytes_req:        400-499 } hitcount:        584
> > >  { bytes_req:        500-599 } hitcount:         35
> > >  { bytes_req:        600-699 } hitcount:        361
> > >  { bytes_req:        700-799 } hitcount:         37
> > >  { bytes_req:        800-899 } hitcount:         26
> > >  { bytes_req:        900-999 } hitcount:         15
> > >  { bytes_req:       1100-1199 } hitcount:          4
> > >  { bytes_req:       1200-1299 } hitcount:        102
> > >  { bytes_req:       1300-1399 } hitcount:          2
> > >  { bytes_req:       1400-1499 } hitcount:         15
> > >  { bytes_req:       1500-1599 } hitcount:        100
> > >  { bytes_req:       1600-1699 } hitcount:          1
> > >  { bytes_req:       1700-1799 } hitcount:          3
> > >  { bytes_req:       1800-1899 } hitcount:         10
> > >  { bytes_req:       2000-2099 } hitcount:         19
> > >  { bytes_req:       2100-2199 } hitcount:          3
> > >  { bytes_req:       2500-2599 } hitcount:         72
> > >  { bytes_req:       2900-2999 } hitcount:          1
> > >  { bytes_req:       3300-3399 } hitcount:          4
> > >  { bytes_req:       3900-3999 } hitcount:          2
> > >  { bytes_req:       4000-4099 } hitcount:       1761
> > >  { bytes_req:       4600-4699 } hitcount:         65
> > >  { bytes_req:       5000-5099 } hitcount:          3
> > >  { bytes_req:       6500-6599 } hitcount:          1
> > >  { bytes_req:       8100-8199 } hitcount:          1
> > >  { bytes_req:       9800-9899 } hitcount:          1
> > >
> > >  Totals:
> > >      Hits: 12481
> > >      Entries: 30
> > >      Dropped: 0
> > >
> > > This finally makes the histograms actual histograms!
> > >
> > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > ---
> > >  kernel/trace/trace_events_hist.c | 34 ++++++++++++++++++++++++++++----
> > >  1 file changed, 30 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > > index ba03b7d84fc2..d6e644df9506 100644
> > > --- a/kernel/trace/trace_events_hist.c
> > > +++ b/kernel/trace/trace_events_hist.c
> > > @@ -120,6 +120,7 @@ struct hist_field {
> > >     unsigned int                    size;
> > >     unsigned int                    offset;
> > >     unsigned int                    is_signed;
> > > +   unsigned long                   grouping;
> > >     const char                      *type;
> > >     struct hist_field               *operands[HIST_FIELD_OPERANDS_MAX];
> > >     struct hist_trigger_data        *hist_data;
> > > @@ -3761,6 +3762,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
> > >  {
> > >     struct trace_array *tr = hist_data->event_file->tr;
> > >     struct hist_field *hist_field = NULL;
> > > +   char *field;
> > >     unsigned long flags = 0;
> > >     unsigned int key_size;
> > >     int ret = 0;
> > > @@ -3768,14 +3770,16 @@ static int create_key_field(struct hist_trigger_data *hist_data,
> > >     if (WARN_ON(key_idx >= HIST_FIELDS_MAX))
> > >             return -EINVAL;
> > >
> > > +   field = strsep(&field_str, "-");
> > > +
> > >     flags |= HIST_FIELD_FL_KEY;
> > >
> > > -   if (strcmp(field_str, "stacktrace") == 0) {
> > > +   if (strcmp(field, "stacktrace") == 0) {
> > >             flags |= HIST_FIELD_FL_STACKTRACE;
> > >             key_size = sizeof(unsigned long) * HIST_STACKTRACE_DEPTH;
> > >             hist_field = create_hist_field(hist_data, NULL, flags, NULL);
> > >     } else {
> > > -           hist_field = parse_expr(hist_data, file, field_str, flags,
> > > +           hist_field = parse_expr(hist_data, file, field, flags,
> > >                                     NULL, 0);
> > >             if (IS_ERR(hist_field)) {
> > >                     ret = PTR_ERR(hist_field);
> > > @@ -3783,7 +3787,7 @@ static int create_key_field(struct hist_trigger_data *hist_data,
> > >             }
> > >
> > >             if (field_has_hist_vars(hist_field, 0)) {
> > > -                   hist_err(tr, HIST_ERR_INVALID_REF_KEY, errpos(field_str));
> > > +                   hist_err(tr, HIST_ERR_INVALID_REF_KEY, errpos(field));
> > >                     destroy_hist_field(hist_field, 0);
> > >                     ret = -EINVAL;
> > >                     goto out;
> > > @@ -3792,6 +3796,14 @@ static int create_key_field(struct hist_trigger_data *hist_data,
> > >             key_size = hist_field->size;
> > >     }
> > >
> > > +   if (field_str) {
> > > +           unsigned long grouping;
> > > +
> > > +           ret = kstrtoul(field_str, 0, &grouping);
> > > +           if (!ret)
> > > +                   hist_field->grouping = grouping;
> > > +   }
> > > +
> > >     hist_data->fields[key_idx] = hist_field;
> > >
> > >     key_size = ALIGN(key_size, sizeof(u64));
> > > @@ -4548,8 +4560,18 @@ static void event_hist_trigger(struct event_trigger_data *data,
> > >                     if (key_field->flags & HIST_FIELD_FL_STRING) {
> > >                             key = (void *)(unsigned long)field_contents;
> > >                             use_compound_key = true;
> > > -                   } else
> > > +                   } else {
> > > +                           if (key_field->grouping) {
> > > +                                   unsigned long grouping = key_field->grouping;
> > > +
> > > +                                   if (field_contents >= LONG_MAX)
> > > +                                           field_contents = div64_ul(field_contents, grouping);
> > > +                                   else
> > > +                                           field_contents = (u64)((unsigned long)field_contents / grouping);
> > > +                                   field_contents *= grouping;
> > > +                           }
> > >                             key = (void *)&field_contents;
> > > +                   }
> > >             }
> > >
> > >             if (use_compound_key)
> > > @@ -4663,6 +4685,8 @@ static void hist_trigger_print_key(struct seq_file *m,
> > >             } else {
> > >                     uval = *(u64 *)(key + key_field->offset);
> > >                     seq_printf(m, "%s: %10llu", field_name, uval);
> > > +                   if (key_field->grouping)
> > > +                           seq_printf(m, "-%llu", uval + key_field->grouping - 1);
> > >             }
> > >     }
> > >
> > > @@ -5096,6 +5120,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
> > >                             seq_printf(m, ".%s", flags);
> > >             }
> > >     }
> > > +   if (hist_field->grouping)
> > > +           seq_printf(m, "-%ld", hist_field->grouping);
> > >  }
> > >
> > >  static int event_hist_trigger_print(struct seq_file *m,
> > > --
> > > 2.31.1
> > >
> >
> >
>
