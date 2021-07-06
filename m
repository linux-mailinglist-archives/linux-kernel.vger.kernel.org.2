Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F543BD956
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 17:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhGFPHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 11:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:46066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231755AbhGFPHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 11:07:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A601561983;
        Tue,  6 Jul 2021 15:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625583881;
        bh=OF2g3m43CxpV5pj7a3ZU8xGpNHxu6gviZN+9c7qpubg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dZdQdIfntAcsVvJMl7kyPVDDrtSpv3NoNgh3+ekYZkVNHM8qC6FxgN2NzpnqHei8K
         6vBePOObaqmmHtlyGttczNo5Tdg0GTHfdGWOF5hRAVkpXf9/I1Zp14Ydj3uXxyFs5O
         BeZ/E/3Qv0dF1ebFIBt2cEX2oiiormnqUFYmeirIVHTHz3Gouq7petRdBdLRdMsP4w
         QyYkq1KlhDbWA4s8wyOCqahc5VrGjGkqdoZQB4SSApFVXLY7Nwh2HwVrLh+A6K3MDW
         57imm6RgInkOcVs/zScI53dP5l53U0LQYbu5ZEmLvp+XCYsjvehMnehGE30ZIDEsO8
         sSZeWW9d3YOdA==
Message-ID: <7b7d447e9c7d2f0eaa63b66eca023944d23dcf96.camel@kernel.org>
Subject: Re: [PATCH] tracing: Add "grouping" to histogram logic
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Date:   Tue, 06 Jul 2021 10:04:39 -0500
In-Reply-To: <20210702175648.1172476c@gandalf.local.home>
References: <20210702175648.1172476c@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Fri, 2021-07-02 at 17:56 -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> There's been several times I wished the histogram logic had a
> "grouping"
> feature for the buckets. Currently, each bucket has a size of one.
> That
> is, if you trace the amount of requested allocations, each allocation
> is
> its own bucket, even if you are interested in what allocates 100
> bytes or
> less, 100 to 200, 200 to 300, etc.
> 
> Also, without grouping, it fills up the allocated histogram buckets
> quickly. If you are tracking latency, and don't care if something is
> 200
> microseconds off, or 201 microseconds off, but want to track them by
> say
> 10 microseconds each. This can not currently be done.
> 
> Introduce a "grouping" command to each field where it will record in
> a
> rounded number. For example:
> 
>  ># echo 'hist:keys=bytes_req-100:sort=bytes_req' > events/kmem/kmalloc/trigger

Very nice idea, makes a lot of sense to add this.

As for the syntax, it kinds of reads to me like subtraction.  If it
were possible to change it to 'x100' that would seem more like what
it's getting at - grouping things 'by 100'.  But since that would be
indistinguishable as to whether or not the 'x' was part of the variable
name, how about using '*100'?

>  ># cat events/kmem/kmalloc/hist
>  # event histogram
>  #
>  # trigger info:
>  hist:keys=bytes_req-100:vals=hitcount:sort=bytes_req-100:size=2048
>  [active]
>  #
> 
>  { bytes_req:          0-99 } hitcount:       7207
>  { bytes_req:        100-199 } hitcount:       1030
>  { bytes_req:        200-299 } hitcount:        602
>  { bytes_req:        300-399 } hitcount:        414
>  { bytes_req:        400-499 } hitcount:        584
>  { bytes_req:        500-599 } hitcount:         35
>  { bytes_req:        600-699 } hitcount:        361
>  { bytes_req:        700-799 } hitcount:         37
>  { bytes_req:        800-899 } hitcount:         26
>  { bytes_req:        900-999 } hitcount:         15
>  { bytes_req:       1100-1199 } hitcount:          4
>  { bytes_req:       1200-1299 } hitcount:        102
>  { bytes_req:       1300-1399 } hitcount:          2
>  { bytes_req:       1400-1499 } hitcount:         15
>  { bytes_req:       1500-1599 } hitcount:        100
>  { bytes_req:       1600-1699 } hitcount:          1
>  { bytes_req:       1700-1799 } hitcount:          3
>  { bytes_req:       1800-1899 } hitcount:         10
>  { bytes_req:       2000-2099 } hitcount:         19
>  { bytes_req:       2100-2199 } hitcount:          3
>  { bytes_req:       2500-2599 } hitcount:         72
>  { bytes_req:       2900-2999 } hitcount:          1
>  { bytes_req:       3300-3399 } hitcount:          4
>  { bytes_req:       3900-3999 } hitcount:          2
>  { bytes_req:       4000-4099 } hitcount:       1761
>  { bytes_req:       4600-4699 } hitcount:         65
>  { bytes_req:       5000-5099 } hitcount:          3
>  { bytes_req:       6500-6599 } hitcount:          1
>  { bytes_req:       8100-8199 } hitcount:          1
>  { bytes_req:       9800-9899 } hitcount:          1
> 
>  Totals:
>      Hits: 12481
>      Entries: 30
>      Dropped: 0
> 
> This finally makes the histograms actual histograms!
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c | 34 ++++++++++++++++++++++++++++
> ----
>  1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c
> b/kernel/trace/trace_events_hist.c
> index ba03b7d84fc2..d6e644df9506 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -120,6 +120,7 @@ struct hist_field {
>  	unsigned int			size;
>  	unsigned int			offset;
>  	unsigned int                    is_signed;
> +	unsigned long			grouping;
>  	const char			*type;
>  	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
>  	struct hist_trigger_data	*hist_data;
> @@ -3761,6 +3762,7 @@ static int create_key_field(struct
> hist_trigger_data *hist_data,
>  {
>  	struct trace_array *tr = hist_data->event_file->tr;
>  	struct hist_field *hist_field = NULL;
> +	char *field;
>  	unsigned long flags = 0;
>  	unsigned int key_size;
>  	int ret = 0;
> @@ -3768,14 +3770,16 @@ static int create_key_field(struct
> hist_trigger_data *hist_data,
>  	if (WARN_ON(key_idx >= HIST_FIELDS_MAX))
>  		return -EINVAL;
>  
> +	field = strsep(&field_str, "-");
> +
>  	flags |= HIST_FIELD_FL_KEY;
>  
> -	if (strcmp(field_str, "stacktrace") == 0) {
> +	if (strcmp(field, "stacktrace") == 0) {
>  		flags |= HIST_FIELD_FL_STACKTRACE;
>  		key_size = sizeof(unsigned long) *
> HIST_STACKTRACE_DEPTH;
>  		hist_field = create_hist_field(hist_data, NULL, flags,
> NULL);
>  	} else {
> -		hist_field = parse_expr(hist_data, file, field_str,
> flags,
> +		hist_field = parse_expr(hist_data, file, field, flags,
>  					NULL, 0);
>  		if (IS_ERR(hist_field)) {
>  			ret = PTR_ERR(hist_field);
> @@ -3783,7 +3787,7 @@ static int create_key_field(struct
> hist_trigger_data *hist_data,
>  		}
>  
>  		if (field_has_hist_vars(hist_field, 0))	{
> -			hist_err(tr, HIST_ERR_INVALID_REF_KEY,
> errpos(field_str));
> +			hist_err(tr, HIST_ERR_INVALID_REF_KEY,
> errpos(field));
>  			destroy_hist_field(hist_field, 0);
>  			ret = -EINVAL;
>  			goto out;
> @@ -3792,6 +3796,14 @@ static int create_key_field(struct
> hist_trigger_data *hist_data,
>  		key_size = hist_field->size;
>  	}
>  
> +	if (field_str) {
> +		unsigned long grouping;
> +
> +		ret = kstrtoul(field_str, 0, &grouping);
> +		if (!ret)
> +			hist_field->grouping = grouping;
> +	}
> +
>  	hist_data->fields[key_idx] = hist_field;
>  
>  	key_size = ALIGN(key_size, sizeof(u64));
> @@ -4548,8 +4560,18 @@ static void event_hist_trigger(struct
> event_trigger_data *data,
>  			if (key_field->flags & HIST_FIELD_FL_STRING) {
>  				key = (void *)(unsigned
> long)field_contents;
>  				use_compound_key = true;
> -			} else
> +			} else {
> +				if (key_field->grouping) {
> +					unsigned long grouping =
> key_field->grouping;
> +
> +					if (field_contents >= LONG_MAX)
> +						field_contents =
> div64_ul(field_contents, grouping);
> +					else
> +						field_contents =
> (u64)((unsigned long)field_contents / grouping);
> +					field_contents *= grouping;
> +				}
>  				key = (void *)&field_contents;
> +			}


As far as implementation, there's already something similar to how it
could operate, the log2 modifier.  If you followed that example, you
could put the above code into a hist_field_fn_t:

static u64 hist_field_grouped(struct hist_field *hist_field,
                              struct tracing_map_elt *elt,
                              struct ring_buffer_event *rbe,
                              void *event)
{
  ..
}

and also add a new HIST_FIELD_FL_GROUPED flag to enum hist_field_flags.

I know the code handling all this is kind of complicated - if you want
I can rework the patch to do this, just let me know if so.

Thanks,

Tom

>  		}
>  
>  		if (use_compound_key)
> @@ -4663,6 +4685,8 @@ static void hist_trigger_print_key(struct
> seq_file *m,
>  		} else {
>  			uval = *(u64 *)(key + key_field->offset);
>  			seq_printf(m, "%s: %10llu", field_name, uval);
> +			if (key_field->grouping)
> +				seq_printf(m, "-%llu", uval +
> key_field->grouping - 1);
>  		}
>  	}
>  
> @@ -5096,6 +5120,8 @@ static void hist_field_print(struct seq_file
> *m, struct hist_field *hist_field)
>  				seq_printf(m, ".%s", flags);
>  		}
>  	}
> +	if (hist_field->grouping)
> +		seq_printf(m, "-%ld", hist_field->grouping);
>  }
>  
>  static int event_hist_trigger_print(struct seq_file *m,

