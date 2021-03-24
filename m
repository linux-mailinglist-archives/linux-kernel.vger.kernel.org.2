Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9A834798C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbhCXNZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234574AbhCXNYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:24:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D78961A0A;
        Wed, 24 Mar 2021 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616592288;
        bh=NzXsUnfCw/JYiRz9XIz92axHuxlDiwE+UNiz043kwt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJfDlO0jXPBXD6o4sDzmQNTPO6d9krSUc4QfgGhMmLBZF2NPlgS7C82mPIvbTzp56
         ExgyDthrnjeMAOsEodVibR9m75QG2YzCaWYzLzSqzqK1HUSD2IQwOg3Mb2GRWPRKmz
         +6jCFc2PMxnnAiVa6Ktt91iRs+i3R48dV9y5JRAO41uZcOOFanNPJ2ICy/eZEaGHwx
         AuLWbM6mEnqhsgamkcpy2Zcz7dSaEJtzR5sRx0kCtOZrYhtIYasc4v1FUclbyxz3fo
         jI86oiIu58Xxiqx85wkFkOmF+fNywqDROrLCVgX0j3YdJHs2A022FsWaYdCWX+LRmK
         gezIbPvEC5tPA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 779F240647; Wed, 24 Mar 2021 10:24:46 -0300 (-03)
Date:   Wed, 24 Mar 2021 10:24:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 1/2] perf daemon: Force waipid for all session on SIGCHLD
 delivery
Message-ID: <YFs9nkXP46Olg5mZ@kernel.org>
References: <20210320221013.1619613-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320221013.1619613-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Mar 20, 2021 at 11:10:12PM +0100, Jiri Olsa escreveu:
> If we don't process SIGCHLD before another comes, we will
> see just one SIGCHLD as a result. In this case current code
> will miss exit notification for a session and wait forever.
> 
> Adding extra waitpid check for all sessions when SIGCHLD
> is received, to make sure we don't miss any session exit.
> 
> Also fix close condition for signal_fd.

Thanks, applied.

- Arnaldo

 
> Reported-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-daemon.c | 50 +++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index ace8772a4f03..4697493842f5 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -402,35 +402,42 @@ static pid_t handle_signalfd(struct daemon *daemon)
>  	int status;
>  	pid_t pid;
>  
> +	/*
> +	 * Take signal fd data as pure signal notification and check all
> +	 * the sessions state. The reason is that multiple signals can get
> +	 * coalesced in kernel and we can receive only single signal even
> +	 * if multiple SIGCHLD were generated.
> +	 */
>  	err = read(daemon->signal_fd, &si, sizeof(struct signalfd_siginfo));
> -	if (err != sizeof(struct signalfd_siginfo))
> +	if (err != sizeof(struct signalfd_siginfo)) {
> +		pr_err("failed to read signal fd\n");
>  		return -1;
> +	}
>  
>  	list_for_each_entry(session, &daemon->sessions, list) {
> +		if (session->pid == -1)
> +			continue;
>  
> -		if (session->pid != (int) si.ssi_pid)
> +		pid = waitpid(session->pid, &status, WNOHANG);
> +		if (pid <= 0)
>  			continue;
>  
> -		pid = waitpid(session->pid, &status, 0);
> -		if (pid == session->pid) {
> -			if (WIFEXITED(status)) {
> -				pr_info("session '%s' exited, status=%d\n",
> -					session->name, WEXITSTATUS(status));
> -			} else if (WIFSIGNALED(status)) {
> -				pr_info("session '%s' killed (signal %d)\n",
> -					session->name, WTERMSIG(status));
> -			} else if (WIFSTOPPED(status)) {
> -				pr_info("session '%s' stopped (signal %d)\n",
> -					session->name, WSTOPSIG(status));
> -			} else {
> -				pr_info("session '%s' Unexpected status (0x%x)\n",
> -					session->name, status);
> -			}
> +		if (WIFEXITED(status)) {
> +			pr_info("session '%s' exited, status=%d\n",
> +				session->name, WEXITSTATUS(status));
> +		} else if (WIFSIGNALED(status)) {
> +			pr_info("session '%s' killed (signal %d)\n",
> +				session->name, WTERMSIG(status));
> +		} else if (WIFSTOPPED(status)) {
> +			pr_info("session '%s' stopped (signal %d)\n",
> +				session->name, WSTOPSIG(status));
> +		} else {
> +			pr_info("session '%s' Unexpected status (0x%x)\n",
> +				session->name, status);
>  		}
>  
>  		session->state = KILL;
>  		session->pid = -1;
> -		return pid;
>  	}
>  
>  	return 0;
> @@ -443,7 +450,6 @@ static int daemon_session__wait(struct daemon_session *session, struct daemon *d
>  		.fd	= daemon->signal_fd,
>  		.events	= POLLIN,
>  	};
> -	pid_t wpid = 0, pid = session->pid;
>  	time_t start;
>  
>  	start = time(NULL);
> @@ -452,7 +458,7 @@ static int daemon_session__wait(struct daemon_session *session, struct daemon *d
>  		int err = poll(&pollfd, 1, 1000);
>  
>  		if (err > 0) {
> -			wpid = handle_signalfd(daemon);
> +			handle_signalfd(daemon);
>  		} else if (err < 0) {
>  			perror("failed: poll\n");
>  			return -1;
> @@ -460,7 +466,7 @@ static int daemon_session__wait(struct daemon_session *session, struct daemon *d
>  
>  		if (start + secs < time(NULL))
>  			return -1;
> -	} while (wpid != pid);
> +	} while (session->pid != -1);
>  
>  	return 0;
>  }
> @@ -1344,7 +1350,7 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>  		close(sock_fd);
>  	if (conf_fd != -1)
>  		close(conf_fd);
> -	if (conf_fd != -1)
> +	if (signal_fd != -1)
>  		close(signal_fd);
>  
>  	pr_info("daemon exited\n");
> -- 
> 2.30.2
> 

-- 

- Arnaldo
