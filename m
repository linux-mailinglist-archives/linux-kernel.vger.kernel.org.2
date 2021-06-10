Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B363A3413
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFJTeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229941AbhFJTeU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:34:20 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B71613F1;
        Thu, 10 Jun 2021 19:32:23 +0000 (UTC)
Date:   Thu, 10 Jun 2021 15:32:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-trace Users <linux-trace-users@vger.kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [RFC PATCH] libtraceevent: Increase libtraceevent logging when
 verbose
Message-ID: <20210610153221.476063dc@oasis.local.home>
In-Reply-To: <CAP-5=fVWCpuC98O=Y3HWCEJspSMWmLwAjhBChStT4APkNboDeQ@mail.gmail.com>
References: <20210610060643.595673-1-irogers@google.com>
        <20210610103927.44462e35@oasis.local.home>
        <CAP-5=fVWCpuC98O=Y3HWCEJspSMWmLwAjhBChStT4APkNboDeQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 11:50:00 -0700
Ian Rogers <irogers@google.com> wrote:

> #if LIBTRACE_EVENT_API > 123
> ...
> #endif
> 
> so that we can make sure perf is taking advantage of the improvements
> in the libtraceevent API?

Yes, and trace-cmd did that.

In the Makefile:

LIBTRACEEVENT_MIN_VERSION = 1.2.3
TEST_LIBTRACEEVENT = $(shell sh -c "$(PKG_CONFIG) --atleast-version $(LIBTRACEEVENT_MIN_VERSION) libtraceevent > /dev/null 2>&1 && echo y")

ifeq ("$(TEST_LIBTRACEEVENT)", "y")
CFLAGS += -DHAVE_TRACEVEVENT_API
endif

Then you can use in perf

#ifdef HAVE_TRACEEVENT_API
...
#endif

That's just one example of what you could do.

-- Steve
