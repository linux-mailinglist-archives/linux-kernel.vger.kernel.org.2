Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A201030E4D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhBCVQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:16:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:37100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230220AbhBCVQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:16:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1C3764F5F;
        Wed,  3 Feb 2021 21:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612386973;
        bh=qyGKk/hQEG6cbek94cgXEKTdL+C7jug+hSr3zZqKl14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YmSrbTvINCRC/Al+nZkEFLFAo9RhnkBU2TV5gyXLAZTa0DyAZk3nHZn9xlxF5a24a
         UiFSzcQ1zYhMhQLl935YFFFyeo4RcjjbqIRAmUNSD2QrD2XfQ892f7vlMNtCLocU+k
         YjM1re+JwC2ALEvo6qq6OtNjJAOxClIWMghmyJ3gazHcq1xEIXOjRA8B4sg9dqdIjB
         T+D7H06Ks89mpPjpr4clSionOrzZnstYqr/INawYGYd+LK/BuJoUNY3RHUwOwS3I+O
         bXRMhdpg8FEWiA/+vTtJXHPutZlAwjAbHMvDS+GzycHMvDXg9gwllhK9FH0QNdDChx
         bc3/6xh8asNKg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7FDE940513; Wed,  3 Feb 2021 18:16:11 -0300 (-03)
Date:   Wed, 3 Feb 2021 18:16:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 08/24] perf daemon: Add background support
Message-ID: <20210203211611.GU854763@kernel.org>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-9-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130234856.271282-9-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 31, 2021 at 12:48:40AM +0100, Jiri Olsa escreveu:
> Adding support to put daemon process in the background.
> 
> It's now enabled by default and -f option is added to
> keep daemon process on the console for debugging.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-daemon.c | 66 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 63 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index d0a0a998e073..324666058842 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -488,6 +488,13 @@ static void daemon__kill(struct daemon *daemon)
>  	daemon__signal(daemon, SIGTERM);
>  }
>  
> +static void __daemon__free(struct daemon *daemon)
> +{
> +	free(daemon->config_real);
> +	free(daemon->config_base);
> +	free(daemon->base);
> +}

Please use zfree(), and also please rename it to __daemon__delete(), in
other cases this pattern would be daemon__exit(), as the daemon
structure itself is not being freed, just its members, ditto for
foo__new() calling foo__init().

> +
>  static void daemon__free(struct daemon *daemon)
>  {
>  	struct session *session, *h;
> @@ -495,9 +502,7 @@ static void daemon__free(struct daemon *daemon)
>  	list_for_each_entry_safe(session, h, &daemon->sessions, list)
>  		session__remove(session);
>  
> -	free(daemon->config_real);
> -	free(daemon->config_base);
> -	free(daemon->base);
> +	__daemon__free(daemon);
>  }
>  
>  static void daemon__exit(struct daemon *daemon)
> @@ -643,10 +648,54 @@ static int setup_config(struct daemon *daemon)
>  	return daemon->config_real ? 0 : -1;
>  }
>  
> +static int go_background(struct daemon *daemon)
> +{
> +	int pid, fd;
> +
> +	pid = fork();
> +	if (pid < 0)
> +		return -1;
> +
> +	if (pid > 0)
> +		return 1;
> +
> +	if (setsid() < 0)
> +		return -1;
> +
> +	umask(0);
> +
> +	if (chdir(daemon->base)) {
> +		perror("failed: chdir");
> +		return -1;
> +	}
> +
> +	fd = open("output", O_RDWR|O_CREAT|O_TRUNC, 0644);
> +	if (fd < 0) {
> +		perror("failed: open");
> +		return -1;
> +	}
> +
> +	fcntl(fd, F_SETFD, FD_CLOEXEC);
> +
> +	close(0);
> +	dup2(fd, 1);
> +	dup2(fd, 2);
> +	close(fd);
> +
> +	daemon->out = fdopen(1, "w");
> +	if (!daemon->out)
> +		return -1;
> +
> +	setbuf(daemon->out, NULL);
> +	return 0;
> +}
> +
>  static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>  		       int argc, const char **argv)
>  {
> +	bool foreground = false;
>  	struct option start_options[] = {
> +		OPT_BOOLEAN('f', "foreground", &foreground, "stay on console"),


You forgot to add the entry to the man page

>  		OPT_PARENT(parent_options),
>  		OPT_END()
>  	};
> @@ -667,6 +716,17 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>  	if (setup_server_config(daemon))
>  		return -1;
>  
> +	if (!foreground) {
> +		err = go_background(daemon);
> +		if (err) {
> +			/* original process, exit normally */
> +			if (err == 1)
> +				err = 0;
> +			__daemon__free(daemon);
> +			return err;
> +		}
> +	}
> +
>  	debug_set_file(daemon->out);
>  	debug_set_display_time(true);
>  
> -- 
> 2.29.2
> 

-- 

- Arnaldo
