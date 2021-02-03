Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B153630E4E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbhBCVY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:24:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:38370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229684AbhBCVYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:24:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E15F64F5F;
        Wed,  3 Feb 2021 21:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612387452;
        bh=+yGVN1eJppsSFUv6v0WRCRYj625Aj0So1ZYkq+IZE2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYiu6YUgI2v38aeUg6FxVMyhzuFUsm1GxBTCbp5bVO/QJ3TARyvYmoFJ9Lw6CfCsn
         BqY6fIhzX3JVgNb0vrUIhk+m9ukcEWxltc7J9in7k8dYs2f8zdI6xBnJNOeUWGVP5L
         9jwVR+z/dwtBEzlYT6F2+prE5izaKdOrD+229+5LPaCPpVTLkVuHB4aW15B8C0sWDg
         9uVTBCY1a+p3BaiA7dGlreufXyXx7d0K5Vg2jOdCqEwpfbrqrb3EhrMNAhlEVT5HkJ
         9ubeWopxKnX36qLTYhR+0yI0foIk6UyRCM71Z6RekY7s4JbJI+DoLSRB1CvuHAtLar
         l8TxPWNgNX0DQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3B60C40513; Wed,  3 Feb 2021 18:24:09 -0300 (-03)
Date:   Wed, 3 Feb 2021 18:24:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Budankov <abudankov@huawei.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 09/24] perf daemon: Add signalfd support
Message-ID: <20210203212409.GW854763@kernel.org>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-10-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130234856.271282-10-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 31, 2021 at 12:48:41AM +0100, Jiri Olsa escreveu:
> Using signalfd fd for tracking SIGCHLD signals as
> notification for perf session termination.
> 
> This way we don't need to actively check for child
> status, but we are notified if there's change.
> 
> Suggested-by: Alexei Budankov <abudankov@huawei.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-daemon.c | 147 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 141 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 324666058842..69d3af70b642 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -7,6 +7,7 @@
>  #include <string.h>
>  #include <signal.h>
>  #include <stdlib.h>
> +#include <time.h>
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <errno.h>
> @@ -16,6 +17,8 @@
>  #include <sys/socket.h>
>  #include <sys/un.h>
>  #include <sys/stat.h>
> +#include <sys/signalfd.h>
> +#include <sys/wait.h>
>  #include <poll.h>
>  #include <sys/stat.h>
>  #include "builtin.h"
> @@ -81,6 +84,7 @@ struct daemon {
>  	struct list_head	 sessions;
>  	FILE			*out;
>  	char			 perf[PATH_MAX];
> +	int			 signal_fd;
>  };
>  
>  static struct daemon __daemon = {
> @@ -351,6 +355,103 @@ static int session__run(struct session *session, struct daemon *daemon)
>  	return -1;
>  }
>  
> +static pid_t handle_signalfd(struct daemon *daemon)
> +{
> +	struct signalfd_siginfo si;
> +	struct session *session;
> +	ssize_t err;
> +	int status;
> +	pid_t pid;
> +
> +	err = read(daemon->signal_fd, &si, sizeof(struct signalfd_siginfo));


I saw these and recalled we have a readn() function, shouldn't we be
usint it in this series?

Its even in tools/lib/perf/lib.c

> +	if (err != sizeof(struct signalfd_siginfo))
> +		return -1;
> +
> +	list_for_each_entry(session, &daemon->sessions, list) {
> +
> +		if (session->pid != (int) si.ssi_pid)
> +			continue;
> +
> +		pid = waitpid(session->pid, &status, 0);
> +		if (pid == session->pid) {
> +			if (WIFEXITED(status)) {
> +				pr_info("session '%s' exited, status=%d\n",
> +					session->name, WEXITSTATUS(status));
> +			} else if (WIFSIGNALED(status)) {
> +				pr_info("session '%s' killed (signal %d)\n",
> +					session->name, WTERMSIG(status));
> +			} else if (WIFSTOPPED(status)) {
> +				pr_info("session '%s' stopped (signal %d)\n",
> +					session->name, WSTOPSIG(status));
> +			} else {
> +				pr_info("session '%s' Unexpected status (0x%x)\n",
> +					session->name, status);
> +			}
> +		}
> +
> +		session->state = SESSION_STATE__KILL;
> +		session->pid = -1;
> +		return pid;
> +	}
> +
> +	return 0;
> +}
> +
> +static int session__wait(struct session *session, struct daemon *daemon, int secs)
> +{
> +	struct pollfd pollfd = {
> +		.fd	= daemon->signal_fd,
> +		.events	= POLLIN,
> +	};
> +	pid_t wpid = 0, pid = session->pid;
> +	time_t start;
> +
> +	start = time(NULL);


	time_t start = time(NULL);
> +
> +	do {
> +		if (poll(&pollfd, 1, 1000))
> +			wpid = handle_signalfd(daemon);

Shouldn't we check for -1 and handle that differently?

> +
> +		if (start + secs < time(NULL))
> +			return -1;
> +	} while (wpid != pid);
> +
> +	return 0;
> +}
> +
> +static bool daemon__has_alive_session(struct daemon *daemon)
> +{
> +	struct session *session;
> +
> +	list_for_each_entry(session, &daemon->sessions, list) {
> +		if (session->pid != -1)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int daemon__wait(struct daemon *daemon, int secs)
> +{
> +	struct pollfd pollfd = {
> +		.fd	= daemon->signal_fd,
> +		.events	= POLLIN,
> +	};
> +	time_t start;
> +
> +	start = time(NULL);
> +
> +	do {
> +		if (poll(&pollfd, 1, 1000))
> +			handle_signalfd(daemon);

ditto

> +
> +		if (start + secs < time(NULL))
> +			return -1;
> +	} while (daemon__has_alive_session(daemon));
> +
> +	return 0;
> +}
> +
>  static int setup_server_socket(struct daemon *daemon)
>  {
>  	struct sockaddr_un addr;
> @@ -456,9 +557,13 @@ static int session__signal(struct session *session, int sig)
>  	return kill(session->pid, sig);
>  }
>  
> -static void session__kill(struct session *session)
> +static void session__kill(struct session *session, struct daemon *daemon)
>  {
>  	session__signal(session, SIGTERM);
> +	if (session__wait(session, daemon, 10)) {
> +		session__signal(session, SIGKILL);
> +		session__wait(session, daemon, 10);
> +	}
>  }
>  
>  static void daemon__signal(struct daemon *daemon, int sig)
> @@ -486,6 +591,10 @@ static void session__remove(struct session *session)
>  static void daemon__kill(struct daemon *daemon)
>  {
>  	daemon__signal(daemon, SIGTERM);
> +	if (daemon__wait(daemon, 10)) {
> +		daemon__signal(daemon, SIGKILL);
> +		daemon__wait(daemon, 10);
> +	}
>  }
>  
>  static void __daemon__free(struct daemon *daemon)
> @@ -523,7 +632,7 @@ static int daemon__reconfig(struct daemon *daemon)
>  		/* Remove session. */
>  		if (session->state == SESSION_STATE__KILL) {
>  			if (session->pid > 0) {
> -				session__kill(session);
> +				session__kill(session, daemon);
>  				pr_info("reconfig: session '%s' killed\n", session->name);
>  			}
>  			session__remove(session);
> @@ -532,7 +641,7 @@ static int daemon__reconfig(struct daemon *daemon)
>  
>  		/* Reconfig session. */
>  		if (session->pid > 0) {
> -			session__kill(session);
> +			session__kill(session, daemon);
>  			pr_info("reconfig: session '%s' killed\n", session->name);
>  		}
>  		if (session__run(session, daemon))
> @@ -690,6 +799,20 @@ static int go_background(struct daemon *daemon)
>  	return 0;
>  }
>  
> +static int setup_signalfd(struct daemon *daemon)
> +{
> +	sigset_t mask;
> +
> +	sigemptyset(&mask);
> +	sigaddset(&mask, SIGCHLD);
> +
> +	if (sigprocmask(SIG_BLOCK, &mask, NULL) == -1)
> +		return -1;
> +
> +	daemon->signal_fd = signalfd(-1, &mask, SFD_NONBLOCK|SFD_CLOEXEC);
> +	return daemon->signal_fd;
> +}
> +
>  static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>  		       int argc, const char **argv)
>  {
> @@ -699,8 +822,8 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>  		OPT_PARENT(parent_options),
>  		OPT_END()
>  	};
> -	int sock_fd = -1, conf_fd = -1;
> -	int sock_pos, file_pos;
> +	int sock_fd = -1, conf_fd = -1, signal_fd = -1;
> +	int sock_pos, file_pos, signal_pos;
>  	struct fdarray fda;
>  	int err = 0;
>  
> @@ -732,7 +855,7 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>  
>  	pr_info("daemon started (pid %d)\n", getpid());
>  
> -	fdarray__init(&fda, 2);
> +	fdarray__init(&fda, 3);
>  
>  	sock_fd = setup_server_socket(daemon);
>  	if (sock_fd < 0)
> @@ -742,6 +865,10 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>  	if (conf_fd < 0)
>  		goto out;
>  
> +	signal_fd = setup_signalfd(daemon);
> +	if (signal_fd < 0)
> +		goto out;
> +
>  	sock_pos = fdarray__add(&fda, sock_fd, POLLIN|POLLERR|POLLHUP, 0);
>  	if (sock_pos < 0)
>  		goto out;
> @@ -750,6 +877,10 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>  	if (file_pos < 0)
>  		goto out;
>  
> +	signal_pos = fdarray__add(&fda, signal_fd, POLLIN|POLLERR|POLLHUP, 0);
> +	if (signal_pos < 0)
> +		goto out;
> +
>  	signal(SIGINT, sig_handler);
>  	signal(SIGTERM, sig_handler);
>  
> @@ -763,6 +894,8 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>  				err = handle_server_socket(daemon, sock_fd);
>  			if (fda.entries[file_pos].revents & POLLIN)
>  				err = handle_config_changes(daemon, conf_fd, &reconfig);
> +			if (fda.entries[signal_pos].revents & POLLIN)
> +				err = handle_signalfd(daemon) < 0;
>  
>  			if (reconfig)
>  				err = setup_server_config(daemon);
> @@ -778,6 +911,8 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>  		close(sock_fd);
>  	if (conf_fd != -1)
>  		close(conf_fd);
> +	if (conf_fd != -1)
> +		close(signal_fd);
>  
>  	pr_info("daemon exited\n");
>  	fclose(daemon->out);
> -- 
> 2.29.2
> 

-- 

- Arnaldo
