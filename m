Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8F8398A40
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhFBNR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:17:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhFBNRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:17:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50142613AA;
        Wed,  2 Jun 2021 13:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622639740;
        bh=lwKrecKcJKNFVsU9TwT03G9BqwDpfC8cRTpAZyGp5RM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BL82hrhTMXEkEU6Y0w1kWH3N5vH+nJCZVaYAm2lK1kArfrtE3pS7DC3bfhkZK15TR
         VZHvHpiJxTp57L42kOkyzzc2bd3QMIpqJCPNzSC2I9lyoC2xF1oaF8NHn40+p1D+Es
         OrR9fpqmH82LO+BHE6mbVImRbfUDyAwXw5h0P5cgcPylsL4pB+SPT0tTcYM27kB0Qc
         8ogxNvHkE2RpZSKaogsugpRq4U5fspXzJcH+w4BABCY4pV3UcE2QIotTrAgtYl482p
         2MMEIJjclNPIfJLbtw3COyROIZ25LWueHx9RQrggpW85KdXRSMV8PyUgv6aGO1oL2t
         xnRw1GzPOOWGQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 59D0D40EFC; Wed,  2 Jun 2021 10:15:37 -0300 (-03)
Date:   Wed, 2 Jun 2021 10:15:37 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf probe: Provide more detail with relocation warning
Message-ID: <YLeEeQkXd6vxZo0A@kernel.org>
References: <20210525043744.193297-1-ravi.bangoria@linux.ibm.com>
 <20210525214858.33a66846ac09e499c3268a63@kernel.org>
 <05e32c82-1009-03ba-d973-8b1bc0582ce2@linux.ibm.com>
 <20210526153340.a49ba8292f201493990f210c@kernel.org>
 <YK5FfaxFKUNdDBWz@kernel.org>
 <20210526232020.c1632c2285af811c7531b3cc@kernel.org>
 <YLdxCdjcLr9HDNra@kernel.org>
 <20210602211248.1e3e9b4f65261ec17c549406@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602211248.1e3e9b4f65261ec17c549406@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jun 02, 2021 at 09:12:48PM +0900, Masami Hiramatsu escreveu:
> On Wed, 2 Jun 2021 08:52:41 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Em Wed, May 26, 2021 at 11:20:20PM +0900, Masami Hiramatsu escreveu:
> > > On Wed, 26 May 2021 09:56:29 -0300 Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > I.e. go the extra step and show what the current value is and what it
> > > > needs to be to achieve what is being attempted.

> > > > IOW combine error message with relevant documentation, to save steps.

> > > > See what 'perf top' does for an unpriv user:

> > > >   $ perf top --stdio
> > > >   Error:
> > > >   Access to performance monitoring and observability operations is limited.
> > > >   Enforced MAC policy settings (SELinux) can limit access to performance
> > > >   monitoring and observability operations. Inspect system audit records for
> > > >   more perf_event access control information and adjusting the policy.
> > > >   Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open
> > > >   access to performance monitoring and observability operations for processes
> > > >   without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.
> > > >   More information can be found at 'Perf events and tool security' document:
> > > >   https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html
> > > >   perf_event_paranoid setting is 2:
> > > >     -1: Allow use of (almost) all events by all users
> > > >         Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK
> > > >   >= 0: Disallow raw and ftrace function tracepoint access
> > > >   >= 1: Disallow CPU event access
> > > >   >= 2: Disallow kernel profiling
> > > >   To make the adjusted perf_event_paranoid setting permanent preserve it
> > > >   in /etc/sysctl.conf (e.g. kernel.perf_event_paranoid = <setting>)

> > > Hmm, I would rather like pointing manpages...

> > Man pages are long, if you quote the relevant part of it when the
> > problem takes place, IMHO it helps the user.

> OK, but please also update man pages (*), which can provide a summarized information
> for users if they noticed that. And for each place, I will add some messages
> for letting them know.

Sure, its not one or the other, its both, i.e. man pages are interesting
as the standard reference for a command, while making tools provide
information about a specific problem with actionable advice on how to
fix the problem at hand is important as well.

> (*) https://lore.kernel.org/lkml/162204068898.388434.16842705842611255787.stgit@devnote2/

I saw your patch to the man page and asked Ravi for an Ack/Reviewed-by,

Thanks for all your continued work on this! :-)

- Arnaldo
