Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE362433CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 18:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbhJSQxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 12:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229789AbhJSQxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 12:53:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8D0161175;
        Tue, 19 Oct 2021 16:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634662291;
        bh=DfTQJs64LQ8BFMva0fsuPqpILcNUsBEcTHtydyZExOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Va78o910x+zTOVrNzgaURxPgJkVqKi+sM2NXvpj6TvxZ9GuO2e8fQ4zc53qS9W0G4
         sdKrjckd77aMgt40aDLPWO9T1960oAgwqboSaRTIpNzoXPs0rSs7I4XwYXjh76LYNs
         zJaIjJqr6SyRF2XvQpyVsbFZXqdJgRA4GYPehxxbLTP0SWGTCwSt6eVCDUNWtEngcX
         EZQvzoTGDXiGQIuW5to2O/dIh2ldzxnSYEmaPtaTpA4IjoWiKNmy3uLNJ+iLOe63Yc
         yQYc1rLfq/KMj3jmaLYC6Gg0+SHqtrR11JRJberBAYyxdttKlTaqoQ0ZuUcq4d5pfp
         FQf7k6fPP3ZCA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 91D54410A1; Tue, 19 Oct 2021 13:51:27 -0300 (-03)
Date:   Tue, 19 Oct 2021 13:51:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Yafang Shao <laoar.shao@gmail.com>, rostedt <rostedt@goodmis.org>,
        kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        lkp <lkp@lists.01.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qiang Zhang <qiang.zhang@windriver.com>,
        robdclark@chromium.org, christian@brauner.io,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        bristot <bristot@redhat.com>,
        aubrey li <aubrey.li@linux.intel.com>,
        yu c chen <yu.c.chen@intel.com>
Subject: Re: [sched.h] 317419b91e:
 perf-sanity-tests.Parse_sched_tracepoints_fields.fail
Message-ID: <YW73j66QbG9i0MV+@kernel.org>
References: <20211010102429.99577-4-laoar.shao@gmail.com>
 <20211014072707.GA18719@xsang-OptiPlex-9020>
 <CALOAHbD540exB5DDfB8DDh8WXvsag9JsdMmC0yxriWMaoAVfOg@mail.gmail.com>
 <1529739526.13983.1634215325995.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529739526.13983.1634215325995.JavaMail.zimbra@efficios.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Oct 14, 2021 at 08:42:05AM -0400, Mathieu Desnoyers escreveu:
> ----- On Oct 14, 2021, at 5:24 AM, Yafang Shao laoar.shao@gmail.com wrote:
> > On Thu, Oct 14, 2021 at 3:08 PM kernel test robot <oliver.sang@intel.com> wrote:
> > That issue is caused by another hardcode 16 ...

> > Seems we should make some change as below,

> > diff --git a/tools/perf/tests/evsel-tp-sched.c
> > b/tools/perf/tests/evsel-tp-sched.c
> > index f9e34bd26cf3..401a737b1d85 100644
> > --- a/tools/perf/tests/evsel-tp-sched.c
> > +++ b/tools/perf/tests/evsel-tp-sched.c
> > @@ -42,7 +42,7 @@ int test__perf_evsel__tp_sched_test(struct test
> > *test __maybe_unused, int subtes
> >                return -1;
> >        }

> > -       if (evsel__test_field(evsel, "prev_comm", 16, false))
> > +       if (evsel__test_field(evsel, "prev_comm", TASK_COMM_LEN, false))
> 
> tools/perf/tests/* contains userspace test programs. This means it gets the
> TASK_COMM_LEN from the uapi. The fix you propose won't do any good here.

That specific test is just checking if the parsing is being done as
expected, i.e. we know beforehand that COMMs have 16 bytes, so the test
expects that.

Now that it can have a different size, then the test should accept the
two sizes as possible and pass if it is 16 or 24.

Like in this patch:

diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index f9e34bd26cf33536..182328f3f7f70e0e 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -5,7 +5,7 @@
 #include "tests.h"
 #include "debug.h"
 
-static int evsel__test_field(struct evsel *evsel, const char *name, int size, bool should_be_signed)
+static int evsel__test_field_alt(struct evsel *evsel, const char *name, int size, int alternate_size, bool should_be_signed)
 {
 	struct tep_format_field *field = evsel__field(evsel, name);
 	int is_signed;
@@ -23,15 +23,23 @@ static int evsel__test_field(struct evsel *evsel, const char *name, int size, bo
 		ret = -1;
 	}
 
-	if (field->size != size) {
-		pr_debug("%s: \"%s\" size (%d) should be %d!\n",
+	if (field->size != size && field->size != alternate_size) {
+		pr_debug("%s: \"%s\" size (%d) should be %d",
 			 evsel->name, name, field->size, size);
+		if (alternate_size > 0)
+			pr_debug(" or %d", alternate_size);
+		pr_debug("!\n");
 		ret = -1;
 	}
 
 	return ret;
 }
 
+static int evsel__test_field(struct evsel *evsel, const char *name, int size, bool should_be_signed)
+{
+	return evsel__test_field_alt(evsel, name, size, -1, should_be_signed);
+}
+
 int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
 	struct evsel *evsel = evsel__newtp("sched", "sched_switch");
@@ -42,7 +50,7 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
 		return -1;
 	}
 
-	if (evsel__test_field(evsel, "prev_comm", 16, false))
+	if (evsel__test_field_alt(evsel, "prev_comm", 16, 24, false))
 		ret = -1;
 
 	if (evsel__test_field(evsel, "prev_pid", 4, true))
@@ -54,7 +62,7 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
 	if (evsel__test_field(evsel, "prev_state", sizeof(long), true))
 		ret = -1;
 
-	if (evsel__test_field(evsel, "next_comm", 16, false))
+	if (evsel__test_field_alt(evsel, "next_comm", 16, 24, false))
 		ret = -1;
 
 	if (evsel__test_field(evsel, "next_pid", 4, true))
@@ -72,7 +80,7 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
 		return -1;
 	}
 
-	if (evsel__test_field(evsel, "comm", 16, false))
+	if (evsel__test_field_alt(evsel, "comm", 16, 24, false))
 		ret = -1;
 
 	if (evsel__test_field(evsel, "pid", 4, true))
