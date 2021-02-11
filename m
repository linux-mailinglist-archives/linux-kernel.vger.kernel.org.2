Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D6E3193D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 21:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhBKUCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 15:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:39226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229918AbhBKT5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 14:57:31 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B25B964E57;
        Thu, 11 Feb 2021 19:56:49 +0000 (UTC)
Date:   Thu, 11 Feb 2021 14:56:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add the latency-collector to tools
Message-ID: <20210211145648.1e1e1325@gandalf.local.home>
In-Reply-To: <20210211161742.25386-1-Viktor.Rosendahl@bmw.de>
References: <20210126142652.41b961f2@gandalf.local.home>
        <20210211161742.25386-1-Viktor.Rosendahl@bmw.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Feb 2021 17:17:42 +0100
Viktor Rosendahl <Viktor.Rosendahl@bmw.de> wrote:

> It seems to work but I discovered during testing that it seems like newer
> kernels have a tendency to lose some latencies in longer bursts. I guess this
> is likely to be another regression in the preemptirqsoff tracer.

Not sure what you mean by the above. I'd be interested in fixing it if is
really a problem.

> diff --git a/tools/tracing/Makefile b/tools/tracing/Makefile
> new file mode 100644
> index 000000000000..f53859765154
> --- /dev/null
> +++ b/tools/tracing/Makefile
> @@ -0,0 +1,23 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Makefile for vm tools
> +#
> +VAR_CFLAGS := $(shell pkg-config --cflags libtracefs 2>/dev/null)
> +VAR_LDLIBS := $(shell pkg-config --libs libtracefs 2>/dev/null)
> +
> +TARGETS = latency-collector
> +CFLAGS = -Wall -Wextra -g -O2 $(VAR_CFLAGS)
> +LDFLAGS = -lpthread $(VAR_LDLIBS)
> +
> +all: $(TARGETS)
> +
> +%: %.c
> +	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
> +
> +clean:
> +	$(RM) latency-collector
> +
> +sbindir ?= /usr/sbin

I wonder if it should default to /usr/local?

 prefix ?= /usr/local
 sbindir ?= ${prefix}/sbin

> +
> +install: all
> +	install -d $(DESTDIR)$(sbindir)
> +	install -m 755 -p $(TARGETS) $(DESTDIR)$(sbindir)
> diff --git a/tools/tracing/latency-collector.c b/tools/tracing/latency-collector.c
> new file mode 100644
> index 000000000000..e9aa7a47a8a3
> --- /dev/null
> +++ b/tools/tracing/latency-collector.c
> @@ -0,0 +1,2102 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2017, 2018, 2019, 2021 BMW Car IT GmbH
> + * Author: Viktor Rosendahl (viktor.rosendahl@bmw.de)
> + */
> +
> +#define _GNU_SOURCE
> +#define _POSIX_C_SOURCE 200809L
> +
> +#include <ctype.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include <err.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <getopt.h>
> +#include <sched.h>
> +#include <linux/unistd.h>
> +#include <signal.h>
> +#include <sys/inotify.h>
> +#include <unistd.h>
> +#include <pthread.h>
> +#include <tracefs.h>
> +
> +static const char *prg_name;
> +static const char *prg_unknown = "unknown program name";
> +
> +static int fd_stdout;
> +
> +static int sched_policy;
> +static bool sched_policy_set;
> +
> +static int sched_pri;
> +static bool sched_pri_set;
> +
> +static bool trace_enable = true;
> +static bool setup_ftrace = true;
> +static bool use_random_sleep;
> +
> +enum traceopt {
> +	OPTIDX_FUNC_TR = 0,
> +	OPTIDX_DISP_GR,
> +	OPTIDX_NR
> +};
> +
> +/* Should be in the order of enum traceopt */
> +static  const char * const optstr[] = {
> +	"function-trace", /* OPTIDX_FUNC_TR  */
> +	"display-graph",  /* OPTIDX_DISP_GR  */
> +	NULL
> +};

A trick to force the enum and string order is this:


#define TRACE_OPTS		\
  C(FUNC_TR, "function-trace"),	\
  C(DISP_GR, "display-graph")

#undef C
#define C(a, b) OPTIDX_##a

enum traceopt {
	TRACE_OPTS,
	OPTIDX_NR
};

#undef C
#define C(a, b)  b

static const char *cost optstr[] = {
	TRACE_OPTS,
	NULL
};


> +
> +enum errhandling {
> +	ERR_EXIT = 0,
> +	ERR_WARN,
> +	ERR_CLEANUP,
> +};

I didn't look too deeply at the rest, just skimmed it basically, and I
tried it out.

I'm fine with pulling this into my queue, as it's just a tool and wont
cause any other issues. I can move some of the files in scripts that deals
with tracing into the tools/tracing directory too. Maybe this should be
placed in a sub directory? tools/tracing/latency/ ?

Feel free to submit a proper patch (proper change log, etc).

Thanks,

-- Steve
