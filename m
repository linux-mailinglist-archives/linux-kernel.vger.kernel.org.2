Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067193BDFB8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 01:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhGFXW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 19:22:59 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:39556 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhGFXW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 19:22:59 -0400
Received: by mail-lj1-f181.google.com with SMTP id a18so238545ljk.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 16:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLiNIktGsIYrAYHVc0A/twMv4C7v392bTFkqe3jIDsA=;
        b=l4/80WJqE6ZluwUqU6zd7jAmHdU+492B2+xzVkY8NGCQypSEW1m9vESvY99RJe8Y87
         y10nO9S4+GIX9MQGP6Vb+UEEXpRCCTTO5gpqpiVdCDtUjkZbB7oIAa1ybfA4BgJPH5xy
         JNBpejFJCdR+QX+ILB3F6Tm03oO/aEdF8JC1L9fLGGKG5W97AVo4cAZnrigwHPzHrtYl
         btkBCsZoDI6j6oxDKBAguERAXRvOdpLrdyYZUAUlbBOCZ1kx68p5abNYhmjF/EmFDT3R
         6+1j/d5/vxES91CDGRpHAOCkhqSBA00vnm2a2sNVOrT9MAcvr5Gm9BUac6VyLgO+tHgm
         H2bA==
X-Gm-Message-State: AOAM533e/SbhdMWjRbKuDLA30mQWq59IYNzSM8KTvtv2nSuX3Zek5o/r
        fOxt0SJPBPMhmj5mi3UKiWjsvzIFkkiUtg7YO/g=
X-Google-Smtp-Source: ABdhPJyl5opYl7cY7U9lN4/ZgQ/Qv1xkVT/MXsYCLQHEsojJvgm1GfxKGQJ4N4yJNW1xdKIdYnPq2N73XX9cFjjJpbk=
X-Received: by 2002:a2e:5c42:: with SMTP id q63mr16691863ljb.23.1625613618789;
 Tue, 06 Jul 2021 16:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210706154315.3567166e@gandalf.local.home>
In-Reply-To: <20210706154315.3567166e@gandalf.local.home>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 6 Jul 2021 16:20:07 -0700
Message-ID: <CAM9d7chmHmm3tjJik5EQDOJOdn7G0D3W9EJUogf_POnyTe6tcA@mail.gmail.com>
Subject: Re: [PATCH v2] tracing: Add linear buckets to histogram logic
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Daniel Bristot de Oliveira Subject: [PATCH] tracing:" 
        <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Tue, Jul 6, 2021 at 12:43 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> There's been several times I wished the histogram logic had a "grouping"
> feature for the buckets. Currently, each bucket has a size of one. That
> is, if you trace the amount of requested allocations, each allocation is
> its own bucket, even if you are interested in what allocates 100 bytes or
> less, 100 to 200, 200 to 300, etc.
>
> Also, without grouping, it fills up the allocated histogram buckets
> quickly. If you are tracking latency, and don't care if something is 200
> microseconds off, or 201 microseconds off, but want to track them by say
> 10 microseconds each. This can not currently be done.
>
> There is a log2 but that grouping get's too big too fast for a lot of
> cases.
>
> Introduce a "buckets=SIZE" command to each field where it will record in a
> rounded number. For example:
>
>  ># echo 'hist:keys=bytes_req.buckets=100:sort=bytes_req' > events/kmem/kmalloc/trigger
>  ># cat events/kmem/kmalloc/hist
>  # event histogram
>  #
>  # trigger info:
>  hist:keys=bytes_req.buckets=100:vals=hitcount:sort=bytes_req.buckets=100:size=2048
>  [active]
>  #
>
>  { bytes_req: ~ 0-99 } hitcount:       3149
>  { bytes_req: ~ 100-199 } hitcount:       1468
>  { bytes_req: ~ 200-299 } hitcount:         39
>  { bytes_req: ~ 300-399 } hitcount:        306
>  { bytes_req: ~ 400-499 } hitcount:        364
>  { bytes_req: ~ 500-599 } hitcount:         32
>  { bytes_req: ~ 600-699 } hitcount:         69
>  { bytes_req: ~ 700-799 } hitcount:         37
>  { bytes_req: ~ 1200-1299 } hitcount:         16
>  { bytes_req: ~ 1400-1499 } hitcount:         30
>  { bytes_req: ~ 2000-2099 } hitcount:          6
>  { bytes_req: ~ 4000-4099 } hitcount:       2168
>  { bytes_req: ~ 5000-5099 } hitcount:          6

For consistency with the log2 histogram, I'd like to see

  { bytes_req: ~ 100 } hitcount:  3149
  { bytes_req: ~ 200 } hitcount:  1468
  { bytes_req: ~ 300 } hitcount:    39
  ...

Or, if you really care about the value range

  { bytes_req: 0 ~ 99 } hitcount:  3149
  { bytes_req: 100 ~ 199 } hitcount:  1468
  { bytes_req: 200 ~ 299 } hitcount:    39
  ...

Thanks,
Namhyung


>
>  Totals:
>      Hits: 7690
>      Entries: 13
>      Dropped: 0
>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> Changes since v1:
>
>  - Used modifier notation of ".buckets=SIZE" instead of hyphen (Namhyung Kim)
>  - Incorporated it to be more like the ".log2" modifier (Tom Zanussi)
>  - Used "~" notation like the log2 modifier.
>
>  kernel/trace/trace_events_hist.c | 65 ++++++++++++++++++++++++++++----
>  1 file changed, 58 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index ba03b7d84fc2..607d0fb291ea 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -120,6 +120,7 @@ struct hist_field {
>         unsigned int                    size;
>         unsigned int                    offset;
>         unsigned int                    is_signed;
> +       unsigned long                   grouping;
>         const char                      *type;
>         struct hist_field               *operands[HIST_FIELD_OPERANDS_MAX];
>         struct hist_trigger_data        *hist_data;
> @@ -218,6 +219,27 @@ static u64 hist_field_log2(struct hist_field *hist_field,
>         return (u64) ilog2(roundup_pow_of_two(val));
>  }
>
> +static u64 hist_field_bucket(struct hist_field *hist_field,
> +                            struct tracing_map_elt *elt,
> +                            struct trace_buffer *buffer,
> +                            struct ring_buffer_event *rbe,
> +                            void *event)
> +{
> +       struct hist_field *operand = hist_field->operands[0];
> +       unsigned long grouping = hist_field->grouping;
> +
> +       u64 val = operand->fn(operand, elt, buffer, rbe, event);
> +
> +       if (WARN_ON_ONCE(!grouping))
> +               return val;
> +
> +       if (val >= LONG_MAX)
> +               val = div64_ul(val, grouping);
> +       else
> +               val = (u64)((unsigned long)val / grouping);
> +       return val * grouping;
> +}
> +
>  static u64 hist_field_plus(struct hist_field *hist_field,
>                            struct tracing_map_elt *elt,
>                            struct trace_buffer *buffer,
> @@ -317,6 +339,7 @@ enum hist_field_flags {
>         HIST_FIELD_FL_VAR_REF           = 1 << 14,
>         HIST_FIELD_FL_CPU               = 1 << 15,
>         HIST_FIELD_FL_ALIAS             = 1 << 16,
> +       HIST_FIELD_FL_BUCKET            = 1 << 17,
>  };
>
>  struct var_defs {
> @@ -1108,7 +1131,8 @@ static const char *hist_field_name(struct hist_field *field,
>         if (field->field)
>                 field_name = field->field->name;
>         else if (field->flags & HIST_FIELD_FL_LOG2 ||
> -                field->flags & HIST_FIELD_FL_ALIAS)
> +                field->flags & HIST_FIELD_FL_ALIAS ||
> +                field->flags & HIST_FIELD_FL_BUCKET)
>                 field_name = hist_field_name(field->operands[0], ++level);
>         else if (field->flags & HIST_FIELD_FL_CPU)
>                 field_name = "cpu";
> @@ -1469,6 +1493,8 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
>                 flags_str = "syscall";
>         else if (hist_field->flags & HIST_FIELD_FL_LOG2)
>                 flags_str = "log2";
> +       else if (hist_field->flags & HIST_FIELD_FL_BUCKET)
> +               flags_str = "buckets";
>         else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP_USECS)
>                 flags_str = "usecs";
>
> @@ -1650,9 +1676,10 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
>                 goto out;
>         }
>
> -       if (flags & HIST_FIELD_FL_LOG2) {
> -               unsigned long fl = flags & ~HIST_FIELD_FL_LOG2;
> -               hist_field->fn = hist_field_log2;
> +       if (flags & (HIST_FIELD_FL_LOG2 | HIST_FIELD_FL_BUCKET)) {
> +               unsigned long fl = flags & ~(HIST_FIELD_FL_LOG2 | HIST_FIELD_FL_BUCKET);
> +               hist_field->fn = flags & HIST_FIELD_FL_LOG2 ? hist_field_log2 :
> +                       hist_field_bucket;
>                 hist_field->operands[0] = create_hist_field(hist_data, field, fl, NULL);
>                 hist_field->size = hist_field->operands[0]->size;
>                 hist_field->type = kstrdup(hist_field->operands[0]->type, GFP_KERNEL);
> @@ -1943,7 +1970,7 @@ static struct hist_field *parse_var_ref(struct hist_trigger_data *hist_data,
>
>  static struct ftrace_event_field *
>  parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
> -           char *field_str, unsigned long *flags)
> +           char *field_str, unsigned long *flags, unsigned long *grouping)
>  {
>         struct ftrace_event_field *field = NULL;
>         char *field_name, *modifier, *str;
> @@ -1970,7 +1997,22 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
>                         *flags |= HIST_FIELD_FL_LOG2;
>                 else if (strcmp(modifier, "usecs") == 0)
>                         *flags |= HIST_FIELD_FL_TIMESTAMP_USECS;
> -               else {
> +               else if (strncmp(modifier, "bucket", 6) == 0) {
> +                       int ret;
> +
> +                       modifier += 6;
> +
> +                       if (*modifier == 's')
> +                               modifier++;
> +                       if (*modifier != '=')
> +                               goto error;
> +                       modifier++;
> +                       ret = kstrtoul(modifier, 0, grouping);
> +                       if (ret || !(*grouping))
> +                               goto error;
> +                       *flags |= HIST_FIELD_FL_BUCKET;
> +               } else {
> + error:
>                         hist_err(tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(modifier));
>                         field = ERR_PTR(-EINVAL);
>                         goto out;
> @@ -2029,6 +2071,7 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
>         char *s, *ref_system = NULL, *ref_event = NULL, *ref_var = str;
>         struct ftrace_event_field *field = NULL;
>         struct hist_field *hist_field = NULL;
> +       unsigned long grouping = 0;
>         int ret = 0;
>
>         s = strchr(str, '.');
> @@ -2066,7 +2109,7 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
>         } else
>                 str = s;
>
> -       field = parse_field(hist_data, file, str, flags);
> +       field = parse_field(hist_data, file, str, flags, &grouping);
>         if (IS_ERR(field)) {
>                 ret = PTR_ERR(field);
>                 goto out;
> @@ -2077,6 +2120,7 @@ static struct hist_field *parse_atom(struct hist_trigger_data *hist_data,
>                 ret = -ENOMEM;
>                 goto out;
>         }
> +       hist_field->grouping = grouping;
>
>         return hist_field;
>   out:
> @@ -4657,6 +4701,11 @@ static void hist_trigger_print_key(struct seq_file *m,
>                 } else if (key_field->flags & HIST_FIELD_FL_LOG2) {
>                         seq_printf(m, "%s: ~ 2^%-2llu", field_name,
>                                    *(u64 *)(key + key_field->offset));
> +               } else if (key_field->flags & HIST_FIELD_FL_BUCKET) {
> +                       unsigned long grouping = key_field->grouping;
> +                       uval = *(u64 *)(key + key_field->offset);
> +                       seq_printf(m, "%s: ~ %llu-%llu", field_name,
> +                                  uval, uval + grouping -1);
>                 } else if (key_field->flags & HIST_FIELD_FL_STRING) {
>                         seq_printf(m, "%s: %-50s", field_name,
>                                    (char *)(key + key_field->offset));
> @@ -5096,6 +5145,8 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
>                                 seq_printf(m, ".%s", flags);
>                 }
>         }
> +       if (hist_field->grouping)
> +               seq_printf(m, "=%ld", hist_field->grouping);
>  }
>
>  static int event_hist_trigger_print(struct seq_file *m,
> --
> 2.31.1
>
>
