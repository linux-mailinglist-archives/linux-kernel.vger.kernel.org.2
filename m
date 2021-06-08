Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E563539FD4E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 19:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhFHRPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 13:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232062AbhFHRPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 13:15:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AC856127A;
        Tue,  8 Jun 2021 17:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623172402;
        bh=/cfShuceEOnhp91rbgvZ09xPOmbKZKT42iaQAkJlmRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DVdUkBvMxv+zrtWl9uMm8l3OLuSMlep44bzKV28OF94Q7qpN/LW7tXB62nNXZfg8L
         VS6y2hf2tIbbejcjQtMX+5Iw0EeUKotI7B8FrjAg2mmER3QF08yLlNUnHDDaPiyK8U
         zPbt1a7s9xKbsDnk8z3SiOYrx9jAtOyOGjNE6loM6GM01h7hbtp00fwK7A8QInVmq6
         UBGuW9LCRNwUl9Xn/hLmiSQuso9rP6JwZzt+ZbDm7lNBkoBkMuNJvjIMHDM/v3N7oV
         63b+8DZ7Kbj9d1kNKzYncGpt6E4dT3Rf9gW2h6krc/27WwvcivOuBhwOzcIxV/9QFr
         fU+AnevpoTFSg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E05C940B1A; Tue,  8 Jun 2021 14:13:19 -0300 (-03)
Date:   Tue, 8 Jun 2021 14:13:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v2] perf/probe: Report permission error for tracefs access
Message-ID: <YL+lL91GkArQe4mu@kernel.org>
References: <20210605125650.acab55ee6c8e954541bfb85f@kernel.org>
 <162299456839.503471.13863002017089255222.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162299456839.503471.13863002017089255222.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 07, 2021 at 12:49:28AM +0900, Masami Hiramatsu escreveu:
> Report permission error for the tracefs open and rewrite
> whole the error message code around it.
> You'll see a hint according to what you want to do with
> perf probe as below.
> 
>   $ perf probe -l
>   No permission to read tracefs.
>   Please try 'sudo mount -o remount,mode=755 /sys/kernel/tracing/'
>     Error: Failed to show event list.
> 
>   $ perf probe -d \*
>   No permission to write tracefs.
>   Please run this command again with sudo.
>     Error: Failed to delete events.
> 
> This also fixes -ENOTSUP checking for mounting tracefs/debugfs.
> Actually open returns -ENOENT in that case and we have to check
> it with current mount point list. If we unmount debugfs and tracefs
> perf probe shows correct message as below.
> 
>   $ perf probe -l
>   Debugfs or tracefs is not mounted
>   Please try 'sudo mount -t tracefs nodev /sys/kernel/tracing/'
>     Error: Failed to show event list.

Thanks, applied.

- Arnaldo

 
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Changes in v2:
>   - Rewrite whole the error message for the tracefs access.
> ---
>  tools/perf/util/probe-file.c |   95 +++++++++++++++++++++++++++++-------------
>  1 file changed, 65 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> index 52273542e6ef..f9a6cbcd6415 100644
> --- a/tools/perf/util/probe-file.c
> +++ b/tools/perf/util/probe-file.c
> @@ -22,6 +22,7 @@
>  #include "symbol.h"
>  #include "strbuf.h"
>  #include <api/fs/tracing_path.h>
> +#include <api/fs/fs.h>
>  #include "probe-event.h"
>  #include "probe-file.h"
>  #include "session.h"
> @@ -31,44 +32,78 @@
>  /* 4096 - 2 ('\n' + '\0') */
>  #define MAX_CMDLEN 4094
>  
> -static void print_open_warning(int err, bool uprobe)
> +static bool print_common_warning(int err, bool readwrite)
>  {
> -	char sbuf[STRERR_BUFSIZE];
> +	if (err == -EACCES)
> +		pr_warning("No permission to %s tracefs.\nPlease %s\n",
> +			   readwrite ? "write" : "read",
> +			   readwrite ? "run this command again with sudo." :
> +				       "try 'sudo mount -o remount,mode=755 /sys/kernel/tracing/'");
> +	else
> +		return false;
>  
> -	if (err == -ENOENT) {
> -		const char *config;
> +	return true;
> +}
>  
> -		if (uprobe)
> -			config = "CONFIG_UPROBE_EVENTS";
> -		else
> -			config = "CONFIG_KPROBE_EVENTS";
> +static bool print_configure_probe_event(int kerr, int uerr)
> +{
> +	const char *config, *file;
> +
> +	if (kerr == -ENOENT && uerr == -ENOENT) {
> +		file = "{k,u}probe_events";
> +		config = "CONFIG_KPROBE_EVENTS=y and CONFIG_UPROBE_EVENTS=y";
> +	} else if (kerr == -ENOENT) {
> +		file = "kprobe_events";
> +		config = "CONFIG_KPROBE_EVENTS=y";
> +	} else if (uerr == -ENOENT) {
> +		file = "uprobe_events";
> +		config = "CONFIG_UPROBE_EVENTS=y";
> +	} else
> +		return false;
>  
> -		pr_warning("%cprobe_events file does not exist"
> -			   " - please rebuild kernel with %s.\n",
> -			   uprobe ? 'u' : 'k', config);
> -	} else if (err == -ENOTSUP)
> -		pr_warning("Tracefs or debugfs is not mounted.\n");
> +	if (!debugfs__configured() && !tracefs__configured())
> +		pr_warning("Debugfs or tracefs is not mounted\n"
> +			   "Please try 'sudo mount -t tracefs nodev /sys/kernel/tracing/'\n");
>  	else
> -		pr_warning("Failed to open %cprobe_events: %s\n",
> -			   uprobe ? 'u' : 'k',
> -			   str_error_r(-err, sbuf, sizeof(sbuf)));
> +		pr_warning("%s/%s does not exist.\nPlease rebuild kernel with %s.\n",
> +			   tracing_path_mount(), file, config);
> +
> +	return true;
> +}
> +
> +static void print_open_warning(int err, bool uprobe, bool readwrite)
> +{
> +	char sbuf[STRERR_BUFSIZE];
> +
> +	if (print_common_warning(err, readwrite))
> +		return;
> +
> +	if (print_configure_probe_event(uprobe ? 0 : err, uprobe ? err : 0))
> +		return;
> +
> +	pr_warning("Failed to open %s/%cprobe_events: %s\n",
> +		   tracing_path_mount(), uprobe ? 'u' : 'k',
> +		   str_error_r(-err, sbuf, sizeof(sbuf)));
>  }
>  
> -static void print_both_open_warning(int kerr, int uerr)
> +static void print_both_open_warning(int kerr, int uerr, bool readwrite)
>  {
> -	/* Both kprobes and uprobes are disabled, warn it. */
> -	if (kerr == -ENOTSUP && uerr == -ENOTSUP)
> -		pr_warning("Tracefs or debugfs is not mounted.\n");
> -	else if (kerr == -ENOENT && uerr == -ENOENT)
> -		pr_warning("Please rebuild kernel with CONFIG_KPROBE_EVENTS "
> -			   "or/and CONFIG_UPROBE_EVENTS.\n");
> -	else {
> -		char sbuf[STRERR_BUFSIZE];
> -		pr_warning("Failed to open kprobe events: %s.\n",
> +	char sbuf[STRERR_BUFSIZE];
> +
> +	if (kerr == uerr && print_common_warning(kerr, readwrite))
> +		return;
> +
> +	if (print_configure_probe_event(kerr, uerr))
> +		return;
> +
> +	if (kerr < 0)
> +		pr_warning("Failed to open %s/kprobe_events: %s.\n",
> +			   tracing_path_mount(),
>  			   str_error_r(-kerr, sbuf, sizeof(sbuf)));
> -		pr_warning("Failed to open uprobe events: %s.\n",
> +	if (uerr < 0)
> +		pr_warning("Failed to open %s/uprobe_events: %s.\n",
> +			   tracing_path_mount(),
>  			   str_error_r(-uerr, sbuf, sizeof(sbuf)));
> -	}
>  }
>  
>  int open_trace_file(const char *trace_file, bool readwrite)
> @@ -109,7 +144,7 @@ int probe_file__open(int flag)
>  	else
>  		fd = open_kprobe_events(flag & PF_FL_RW);
>  	if (fd < 0)
> -		print_open_warning(fd, flag & PF_FL_UPROBE);
> +		print_open_warning(fd, flag & PF_FL_UPROBE, flag & PF_FL_RW);
>  
>  	return fd;
>  }
> @@ -122,7 +157,7 @@ int probe_file__open_both(int *kfd, int *ufd, int flag)
>  	*kfd = open_kprobe_events(flag & PF_FL_RW);
>  	*ufd = open_uprobe_events(flag & PF_FL_RW);
>  	if (*kfd < 0 && *ufd < 0) {
> -		print_both_open_warning(*kfd, *ufd);
> +		print_both_open_warning(*kfd, *ufd, flag & PF_FL_RW);
>  		return *kfd;
>  	}
>  
> 

-- 

- Arnaldo
