Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E6439C050
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFDTUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 15:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229501AbhFDTUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 15:20:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36C9E60FF2;
        Fri,  4 Jun 2021 19:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622834317;
        bh=Td3cMR7nK45iiYWoP6uacaO9FLRb5ILHWTk6aKSJcvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2Ul2eWYwpy3DE6+0Vb1KYIB3jdCQIBvz9LXDfs7hC6HsJDopAQGGlrL1vEa/2Io4
         pj/On0QNyXRaRdRABiwcQrtwwKzXCqYn4nuDGzwxiEJ/NWF+/5N5JQxl8qpP14G3e4
         FtW4YQaKCh20QO36EkhDiRKe9EtedfGK0eUzXmmAEr5Jt+BMjNMKV+V70HjwzlDLQ1
         0p8zRYdvYU5dEfC5oEX88u1+O/tbdngu3sk6TAM6Q0JGjmLYBBSB3NUl9+D8sCQx2J
         lKUZG2NU6uCQC6RCCcX3GdYEDHYwVoMBKSZd73AbvofdTwyGilrFJzHsbLI6EJ+CAK
         9y2i5JiKv8Xyw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 80F2440EFC; Fri,  4 Jun 2021 16:18:34 -0300 (-03)
Date:   Fri, 4 Jun 2021 16:18:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 2/2] perf/probe: Report permission error for tracefs error
Message-ID: <YLp8ipAslRq0wkOm@kernel.org>
References: <162282064848.448336.15589262399731095367.stgit@devnote2>
 <162282066829.448336.16156999655071988915.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <162282066829.448336.16156999655071988915.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 05, 2021 at 12:31:08AM +0900, Masami Hiramatsu escreveu:
> Report permission error for the tracefs access error.
> This can happen when non-superuser runs perf probe.
> With this patch, perf probe shows the following message.
> 
>   $ perf probe -l
>   No permission to access tracefs. Please run this command again with sudo.
>     Error: Failed to show event list.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/util/probe-file.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> index 52273542e6ef..52d878f5a44d 100644
> --- a/tools/perf/util/probe-file.c
> +++ b/tools/perf/util/probe-file.c
> @@ -48,6 +48,8 @@ static void print_open_warning(int err, bool uprobe)
>  			   uprobe ? 'u' : 'k', config);
>  	} else if (err == -ENOTSUP)
>  		pr_warning("Tracefs or debugfs is not mounted.\n");
> +	else if (err == -EACCES)
> +		pr_warning("No permission to access tracefs. Please run this command again with sudo.\n");
>  	else
>  		pr_warning("Failed to open %cprobe_events: %s\n",
>  			   uprobe ? 'u' : 'k',
> @@ -62,6 +64,8 @@ static void print_both_open_warning(int kerr, int uerr)
>  	else if (kerr == -ENOENT && uerr == -ENOENT)
>  		pr_warning("Please rebuild kernel with CONFIG_KPROBE_EVENTS "
>  			   "or/and CONFIG_UPROBE_EVENTS.\n");
> +	else if (kerr == -EACCES && uerr == -EACCES)
> +		pr_warning("No permission to access tracefs. Please run this command again with sudo.\n");
>  	else {
>  		char sbuf[STRERR_BUFSIZE];
>  		pr_warning("Failed to open kprobe events: %s.\n",

This one doesn't look so helpful, as running as root usually will allow
things to proceed.

'perf trace' does:

⬢[acme@toolbox pahole]$ perf trace ls
Error:	No permissions to read /sys/kernel/tracing/events/raw_syscalls/sys_(enter|exit)
Hint:	Try 'sudo mount -o remount,mode=755 /sys/kernel/tracing/'

⬢[acme@toolbox pahole]$

Which would be less drastic than requiring full superuser access.

- Arnaldo
