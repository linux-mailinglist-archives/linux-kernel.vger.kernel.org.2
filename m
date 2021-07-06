Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7708E3BDF49
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 00:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhGFWMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 18:12:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229781AbhGFWMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 18:12:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44ED961C40;
        Tue,  6 Jul 2021 22:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625609365;
        bh=0nz1oQPBHdt8oyx+y/pzQlDn0E1mR/g1uCA53wFsU/A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BRTMCLu5Bef5CAfQyMFAAbQSlUHjTJ2NZ0j8P3DLrmi10oxImABUy5vcf6lhiHk+8
         afJRfKkQ1gaUIUF+y4ZBknYuZdSNAxm/423c8deeLZkx5bVmNuZeUM1IIPI1amcxXp
         3WBYcuxmnvaXsgaGWVPXNHsDylCDTV4KWsbGMFg7KA/KmabH14Q2YvjLfF/WjCwXNi
         5ncjpBNwiL4nzRMlT2HISmeX5Q98RkSEgcS2Z5NDv4cylTMjC1Ef+7vO1r2UMeJXyr
         hiXEKjVIKr5Oh4NxdpBZc0rgYX5BZYg0DLstVcDiDGq5jWkqDFcBJI2Zoa9W1xfhzC
         JQOmWJexlhqpg==
Message-ID: <ed01dc3a4219611316e3e08756553dce415c2edc.camel@kernel.org>
Subject: Re: [PATCH v2] tracing: Add linear buckets to histogram logic
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Date:   Tue, 06 Jul 2021 17:09:24 -0500
In-Reply-To: <20210706154315.3567166e@gandalf.local.home>
References: <20210706154315.3567166e@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Looks good to me, just a couple nits below.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

On Tue, 2021-07-06 at 15:43 -0400, Steven Rostedt wrote:
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
> There is a log2 but that grouping get's too big too fast for a lot of
> cases.
> 
> Introduce a "buckets=SIZE" command to each field where it will record
> in a
> rounded number. For example:
> 
>  ># echo 'hist:keys=bytes_req.buckets=100:sort=bytes_req' >
> events/kmem/kmalloc/trigger
>  ># cat events/kmem/kmalloc/hist
>  # event histogram
>  #
>  # trigger info:
>  hist:keys=bytes_req.buckets=100:vals=hitcount:sort=bytes_req.buckets
> =100:size=2048
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
>  - Used modifier notation of ".buckets=SIZE" instead of hyphen
> (Namhyung Kim)
>  - Incorporated it to be more like the ".log2" modifier (Tom Zanussi)
>  - Used "~" notation like the log2 modifier.
> 
>  kernel/trace/trace_events_hist.c | 65 ++++++++++++++++++++++++++++
> ----
>  1 file changed, 58 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c
> b/kernel/trace/trace_events_hist.c
> index ba03b7d84fc2..607d0fb291ea 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -120,6 +120,7 @@ struct hist_field {
>  	unsigned int			size;
>  	unsigned int			offset;
>  	unsigned int                    is_signed;
> +	unsigned long			grouping;

Just wondering if it would be more consistent to name this 'buckets' or
even 'bucket_size'.

>  	const char			*type;
>  	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
>  	struct hist_trigger_data	*hist_data;
> @@ -218,6 +219,27 @@ static u64 hist_field_log2(struct hist_field
> *hist_field,
>  	return (u64) ilog2(roundup_pow_of_two(val));
>  }
>  
> 
> 

[snip]

> @@ -4657,6 +4701,11 @@ static void hist_trigger_print_key(struct
> seq_file *m,
>  		} else if (key_field->flags & HIST_FIELD_FL_LOG2) {
>  			seq_printf(m, "%s: ~ 2^%-2llu", field_name,
>  				   *(u64 *)(key + key_field->offset));
> +		} else if (key_field->flags & HIST_FIELD_FL_BUCKET) {
> +			unsigned long grouping = key_field->grouping;
> +			uval = *(u64 *)(key + key_field->offset);
> +			seq_printf(m, "%s: ~ %llu-%llu", field_name,
> +				   uval, uval + grouping -1);

Need a space before 1 i.e. 'grouping - 1'?

Thanks,

Tom


