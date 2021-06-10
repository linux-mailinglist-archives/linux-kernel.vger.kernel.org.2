Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A03F3A2E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhFJOl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:41:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231213AbhFJOl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:41:26 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B510613E3;
        Thu, 10 Jun 2021 14:39:29 +0000 (UTC)
Date:   Thu, 10 Jun 2021 10:39:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-users@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, eranian@google.com
Subject: Re: [RFC PATCH] libtraceevent: Increase libtraceevent logging when
 verbose
Message-ID: <20210610103927.44462e35@oasis.local.home>
In-Reply-To: <20210610060643.595673-1-irogers@google.com>
References: <20210610060643.595673-1-irogers@google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  9 Jun 2021 23:06:43 -0700
Ian Rogers <irogers@google.com> wrote:

> libtraceevent has added more levels of debug printout and with changes
> like:
> https://lore.kernel.org/linux-trace-devel/20210507095022.1079364-3-tz.stoyanov@gmail.com
> previously generated output like "registering plugin" is no longer
> displayed. This change makes it so that if perf's verbose debug output
> is enabled then the debug and info libtraceevent messages can be
> displayed.
> As this API isn't present in the deprecated tools version of
> libtracevent I'm uploading this as an RFC.

Thanks Ian,

We need to start porting perf to using the upstream libtraceevent
library. I think the best way to do that is what we did with trace-cmd.
That is to have the make files check if the minimum version of
libtraceevent is installed, and if so, use that instead of the local
version. If it is not installed, produce a message encouraging the
developer to install the upstream libtraceevent and warn that it will
be using a deprecated older versino, then build the deprecated local
version. After some time, we could simply remove it and make it a
dependency, but I want to do that when all the main distros being used
have it.

Currently its in the latest Debian, Ubuntu, and Fedora. I also believe
its in SUSE but have not checked. It's in Fedora 34, but it doesn't
appear to be in Fedora 33. As that's not too old, I don't think we
should make it a dependency as of yet.

-- Steve
