Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1055A39C599
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 05:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFED6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 23:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229726AbhFED6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 23:58:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7341E613AA;
        Sat,  5 Jun 2021 03:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622865414;
        bh=Q8VsFXB6Ido9ZRVAhyS+4Vzd2/MVTUusk5gSX5437dQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M8PTPqW1yodkT7ffqE2iQQDAcJplcVKessw7SsAlU8qkzQfdw4OiS6Z2C9kLyYUNx
         Mogx+DYEKykcrlx6zEwNdVmDUhtdbV3jZ63C+bmcNS2NP4CAjy/X8mHhhjgIu73VeV
         sVVYq+1aecs/aHURO+5WzGk09TYDZLPXJKsBjKSrM6+cuUMn6TqpoOS2qoyB/YuEIi
         Kf43YK4vltV9h88FHrw3L0csSptRvPL7qA1cP3qsFNyoQnOLoV0k7ZRXDC4vpw0aNb
         j0DPxoGaTi0gMzIaAVG6cRQcpRyOB0lQxfwxgyRjreXrvCSv+TYJ/jJ4RfzvlLnuxB
         teQDsRdrXDY1g==
Date:   Sat, 5 Jun 2021 12:56:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 2/2] perf/probe: Report permission error for tracefs
 error
Message-Id: <20210605125650.acab55ee6c8e954541bfb85f@kernel.org>
In-Reply-To: <YLp8ipAslRq0wkOm@kernel.org>
References: <162282064848.448336.15589262399731095367.stgit@devnote2>
        <162282066829.448336.16156999655071988915.stgit@devnote2>
        <YLp8ipAslRq0wkOm@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Fri, 4 Jun 2021 16:18:34 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Sat, Jun 05, 2021 at 12:31:08AM +0900, Masami Hiramatsu escreveu:
> > Report permission error for the tracefs access error.
> > This can happen when non-superuser runs perf probe.
> > With this patch, perf probe shows the following message.
> > 
> >   $ perf probe -l
> >   No permission to access tracefs. Please run this command again with sudo.
> >     Error: Failed to show event list.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/perf/util/probe-file.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> > index 52273542e6ef..52d878f5a44d 100644
> > --- a/tools/perf/util/probe-file.c
> > +++ b/tools/perf/util/probe-file.c
> > @@ -48,6 +48,8 @@ static void print_open_warning(int err, bool uprobe)
> >  			   uprobe ? 'u' : 'k', config);
> >  	} else if (err == -ENOTSUP)
> >  		pr_warning("Tracefs or debugfs is not mounted.\n");
> > +	else if (err == -EACCES)
> > +		pr_warning("No permission to access tracefs. Please run this command again with sudo.\n");
> >  	else
> >  		pr_warning("Failed to open %cprobe_events: %s\n",
> >  			   uprobe ? 'u' : 'k',
> > @@ -62,6 +64,8 @@ static void print_both_open_warning(int kerr, int uerr)
> >  	else if (kerr == -ENOENT && uerr == -ENOENT)
> >  		pr_warning("Please rebuild kernel with CONFIG_KPROBE_EVENTS "
> >  			   "or/and CONFIG_UPROBE_EVENTS.\n");
> > +	else if (kerr == -EACCES && uerr == -EACCES)
> > +		pr_warning("No permission to access tracefs. Please run this command again with sudo.\n");
> >  	else {
> >  		char sbuf[STRERR_BUFSIZE];
> >  		pr_warning("Failed to open kprobe events: %s.\n",
> 
> This one doesn't look so helpful, as running as root usually will allow
> things to proceed.
> 
> 'perf trace' does:
> 
> ⬢[acme@toolbox pahole]$ perf trace ls
> Error:	No permissions to read /sys/kernel/tracing/events/raw_syscalls/sys_(enter|exit)
> Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/tracing/'
> 
> ⬢[acme@toolbox pahole]$
> 
> Which would be less drastic than requiring full superuser access.

Hmm, perf trace only read access to the tracefs, so that is easy to
suggest user to do remount it. However, perf probe usually requires
a write access. (Only perf probe -l requires read access)

I'll change this patch to check whether the read or write access and
switch the message. But if it is a write access, anyway it has to
requests superuser.

Let me update this patch.

Thank you,

> 
> - Arnaldo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
