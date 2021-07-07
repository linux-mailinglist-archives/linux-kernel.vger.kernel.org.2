Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9820C3BE04B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 02:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhGGAi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 20:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbhGGAi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 20:38:26 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2063661C98;
        Wed,  7 Jul 2021 00:35:46 +0000 (UTC)
Date:   Tue, 6 Jul 2021 20:35:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v2] tracing: Add linear buckets to histogram logic
Message-ID: <20210706203544.6ef9a04e@rorschach.local.home>
In-Reply-To: <ed01dc3a4219611316e3e08756553dce415c2edc.camel@kernel.org>
References: <20210706154315.3567166e@gandalf.local.home>
        <ed01dc3a4219611316e3e08756553dce415c2edc.camel@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Jul 2021 17:09:24 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -120,6 +120,7 @@ struct hist_field {
> >  	unsigned int			size;
> >  	unsigned int			offset;
> >  	unsigned int                    is_signed;
> > +	unsigned long			grouping;  
> 
> Just wondering if it would be more consistent to name this 'buckets' or
> even 'bucket_size'.

I originally did change it to that, but thought against it. I guess I
could change that.

Thanks!

-- Steve


> 
> >  	const char			*type;
> >  	struct hist_field		*operands[HIST_FIELD_OPERANDS_MAX];
> >  	struct hist_trigger_data	*hist_data;
> > @@ -218,6 +219,27 @@ static u64 hist_field_log2(struct hist_field
> > *hist_field,
> >  	return (u64) ilog2(roundup_pow_of_two(val));
> >  }
> >  
