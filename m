Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4866E30E4A1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbhBCVFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:05:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232131AbhBCVFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:05:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C1DC64F5F;
        Wed,  3 Feb 2021 21:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612386268;
        bh=qsbKc8aThntRBC7TogbJV5CusIEYBF5lycpVC9RdzFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LQ69KK9UzZYangL7RKk86dbbWO8t9HUQTxp8f5U3KrCI9vE9o8+FBVwtbnwVLorgM
         RhCZF2OVSMEpgP4SeEgi3uPtxL8frgTx7KecybGu9wkANVqSPezsL3JWEEg0wbvdCo
         P20ZTLwZ1/zbJ2advxhv1CofRH/8sCElDdEpO9TeIbfusjXKqjHdbGFBGhqp4WNprq
         e9IAvNzTxJSfOvS8HibTK86JRwcUtwLihRucSpAwy2gxYCuVund5lEbicNsGHxEpKa
         5kDv2JNop8nkJqE9psZ30XDuJplDdkupLKCNFHz2I4RPhGwTNwXBRFu5iBvAqL3ATg
         DFbx4YiUkMO2Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D48E340513; Wed,  3 Feb 2021 18:04:23 -0300 (-03)
Date:   Wed, 3 Feb 2021 18:04:23 -0300
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
Subject: Re: [PATCH 04/24] perf daemon: Add server socket support
Message-ID: <20210203210423.GQ854763@kernel.org>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-5-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130234856.271282-5-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 31, 2021 at 12:48:36AM +0100, Jiri Olsa escreveu:
> Add support to create server socket that listens for client
> commands and process them.
> 
> This patch adds only the core support, all commands using
> this functionality are coming in following patches.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-daemon.c | 101 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 100 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 8d0ac44ec808..756d60616d7d 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <subcmd/parse-options.h>
> +#include <api/fd/array.h>
>  #include <linux/limits.h>
>  #include <string.h>
>  #include <signal.h>
> @@ -7,6 +8,10 @@
>  #include <stdio.h>
>  #include <unistd.h>
>  #include <errno.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include <sys/un.h>
> +#include <poll.h>
>  #include "builtin.h"
>  #include "perf.h"
>  #include "debug.h"
> @@ -37,6 +42,78 @@ static void sig_handler(int sig __maybe_unused)
>  	done = true;
>  }
>  
> +static int setup_server_socket(struct daemon *daemon)
> +{
> +	struct sockaddr_un addr;
> +	char path[100];
> +	int fd;
> +
> +	fd = socket(AF_UNIX, SOCK_STREAM, 0);

Minor, combine decl with use, since line isn't long and its one after
the other, i.e.:

	int fd = socket(AF_UNIX, SOCK_STREAM, 0);

> +	if (fd < 0) {
> +		fprintf(stderr, "socket: %s\n", strerror(errno));
> +		return -1;
> +	}
> +
> +	fcntl(fd, F_SETFD, FD_CLOEXEC);

Don't we have to check its return?

> +
> +	scnprintf(path, PATH_MAX, "%s/control", daemon->base);

Humm the safe thing here is to use:

	scnprintf(path, sizeof(path), "%s/control", daemon->base);

Using it like that would avoid the bug in your code, as path has only
100 bytes, not PATH_MAX bytes ;-)

> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.sun_family = AF_UNIX;
> +
> +	strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);

strncpy may end up not adding the final \0 see the NOTES in its man
page. Consider using strlcpy instead. See:

  bef0b8970f27da5c ("perf probe: Fix unchecked usage of strncpy()")

> +	unlink(path);
> +
> +	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) == -1) {
> +		perror("failed: bind");
> +		return -1;
> +	}
> +
> +	if (listen(fd, 1) == -1) {
> +		perror("failed: listen");
> +		return -1;
> +	}
> +
> +	return fd;
> +}
> +
> +union cmd {
> +	int cmd;
> +};
> +
> +static int handle_server_socket(struct daemon *daemon __maybe_unused, int sock_fd)
> +{
> +	int ret = -EINVAL, fd;
> +	union cmd cmd;
> +	FILE *out;
> +
> +	fd = accept(sock_fd, NULL, NULL);
> +	if (fd < 0) {
> +		fprintf(stderr, "accept: %s\n", strerror(errno));
> +		return -1;
> +	}
> +
> +	if (sizeof(cmd) != read(fd, &cmd, sizeof(cmd))) {
> +		fprintf(stderr, "read: %s\n", strerror(errno));

close fd

> +		return -1;
> +	}
> +
> +	out = fdopen(fd, "w");
> +	if (!out) {
> +		perror("failed: fdopen");

close fd

I.e. goto out_close;

> +		return -1;
> +	}
> +
> +	switch (cmd.cmd) {
> +	default:
> +		break;
> +	}
> +
> +	fclose(out);

out_close:

> +	close(fd);
> +	return ret;
> +}
> +
>  static void daemon__free(struct daemon *daemon)
>  {
>  	free(daemon->config_real);
> @@ -82,6 +159,9 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>  		OPT_PARENT(parent_options),
>  		OPT_END()
>  	};
> +	int sock_fd = -1;
> +	int sock_pos;
> +	struct fdarray fda;
>  	int err = 0;
>  
>  	argc = parse_options(argc, argv, start_options, daemon_usage, 0);
> @@ -98,15 +178,34 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>  
>  	pr_info("daemon started (pid %d)\n", getpid());
>  
> +	fdarray__init(&fda, 1);
> +
> +	sock_fd = setup_server_socket(daemon);
> +	if (sock_fd < 0)
> +		goto out;
> +
> +	sock_pos = fdarray__add(&fda, sock_fd, POLLIN|POLLERR|POLLHUP, 0);
> +	if (sock_pos < 0)
> +		goto out;
> +
>  	signal(SIGINT, sig_handler);
>  	signal(SIGTERM, sig_handler);
>  
>  	while (!done && !err) {
> -		sleep(1);
> +		if (fdarray__poll(&fda, -1)) {
> +			if (fda.entries[sock_pos].revents & POLLIN)
> +				err = handle_server_socket(daemon, sock_fd);
> +		}
>  	}
>  
> +out:
> +	fdarray__exit(&fda);
> +
>  	daemon__exit(daemon);
>  
> +	if (sock_fd != -1)
> +		close(sock_fd);
> +
>  	pr_info("daemon exited\n");
>  	fclose(daemon->out);
>  	return err;
> -- 
> 2.29.2
> 

-- 

- Arnaldo
