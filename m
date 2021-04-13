Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAE335E64E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 20:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347674AbhDMSY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 14:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232679AbhDMSYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 14:24:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F586613BD;
        Tue, 13 Apr 2021 18:24:32 +0000 (UTC)
Date:   Tue, 13 Apr 2021 14:24:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Yordan Karadzhov (VMware)" <y.karadz@gmail.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org
Subject: Re: [PATCH v3 3/5] tracing: Add method for recording "func_repeats"
 events
Message-ID: <20210413142431.79331c5a@gandalf.local.home>
In-Reply-To: <20210409181031.26772-4-y.karadz@gmail.com>
References: <20210409181031.26772-1-y.karadz@gmail.com>
        <20210409181031.26772-4-y.karadz@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Apr 2021 21:10:29 +0300
"Yordan Karadzhov (VMware)" <y.karadz@gmail.com> wrote:

> @@ -342,6 +342,12 @@ FTRACE_ENTRY(hwlat, hwlat_entry,
>  #define FUNC_REPEATS_GET_DELTA_TS(entry)			\
>  (((u64)entry->top_delta_ts << 32) | entry->bottom_delta_ts)	\
>  
> +#define FUNC_REPEATS_SET_DELTA_TS(entry, delta)			\
> +	do {							\
> +		entry->bottom_delta_ts = delta & U32_MAX;	\
> +		entry->top_delta_ts = (delta >> 32);		\
> +	} while (0);						\
> +

This needs the parenthesis around the parameters as well.

Or just make it into a static inline function. The GET_DELTA_TS is used in
printing to of the event for user space where it makes sense to have it as
a macro (it will be expanded in the "print fmt" of the format file for the
event). But the setting doesn't have that limitation.

static inline void
func_repeats_set_delta_ts(struct func_repeats_entry *entry,
			  unsigned long long delta)
{
	entry->bottom_delta_ts = delta & U32_MAX;
	entry->top_delta_ts = (delta >> 32);
}

And then you can have the compiler type check everything for you. Macros
are nasty when it comes to build errors.

-- Steve


>  FTRACE_ENTRY(func_repeats, func_repeats_entry,
>  
>  	TRACE_FUNC_REPEATS,
> -- 
