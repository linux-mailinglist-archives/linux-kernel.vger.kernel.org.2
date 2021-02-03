Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EC430E4A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 22:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhBCVGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 16:06:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232131AbhBCVGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 16:06:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DC3E664F5F;
        Wed,  3 Feb 2021 21:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612386350;
        bh=WB1uvXt/6zuuVUeEimfwRlopvPq2o4ZunEp87CGiu8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WiQmL/tJxN0s090I/sDgXKTMApJH891OUdUuMkQKnsQX5yanRv/vlUPKWmkTDc9+A
         AxcCjOH2jz++0mv/9bQrobQEh3++f6+ZiuUaCG43zMQvGwy2qNwr/4q+UY9kA+KNrP
         uasN4nlGVGqr7VzAOBnjIEWEkfE7oddRPh8I7TBDbKnvurTJcvEkyYh3W2N5hFww+/
         pDfhf1FyeLUpEWIcSe0ciQPoFrpWjNWIM9PBJvH6hRIxXyY8ZGNL16/QIMpxpclo8O
         SBBLhmyKph1LajUQMTRMVU/PR0JBo+S89grop5FBzfU7em4dVUMyPquS0TLnZgrT84
         OY2cScwLDOoMA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5E19B40513; Wed,  3 Feb 2021 18:05:47 -0300 (-03)
Date:   Wed, 3 Feb 2021 18:05:47 -0300
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
Subject: Re: [PATCH 05/24] perf daemon: Add client socket support
Message-ID: <20210203210547.GR854763@kernel.org>
References: <20210129134855.195810-1-jolsa@redhat.com>
 <20210130234856.271282-1-jolsa@kernel.org>
 <20210130234856.271282-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130234856.271282-6-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 31, 2021 at 12:48:37AM +0100, Jiri Olsa escreveu:
> Adding support for client socket side that will be used
> to send commands to daemon server socket.
> 
> This patch adds only the core support, all commands using
> this functionality are coming in following patches.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-daemon.c | 105 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
> index 756d60616d7d..eada3ceb9b0c 100644
> --- a/tools/perf/builtin-daemon.c
> +++ b/tools/perf/builtin-daemon.c
> @@ -11,6 +11,7 @@
>  #include <sys/types.h>
>  #include <sys/socket.h>
>  #include <sys/un.h>
> +#include <sys/stat.h>
>  #include <poll.h>
>  #include "builtin.h"
>  #include "perf.h"
> @@ -42,6 +43,50 @@ static void sig_handler(int sig __maybe_unused)
>  	done = true;
>  }
>  
> +static int client_config(const char *var, const char *value, void *cb)
> +{
> +	struct daemon *daemon = cb;
> +
> +	if (!strcmp(var, "daemon.base") && !daemon->base_user) {
> +		daemon->base = strdup(value);
> +		if (!daemon->base)
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int check_base(struct daemon *daemon)
> +{
> +	struct stat st;
> +
> +	if (!daemon->base) {
> +		pr_err("failed: base not defined\n");
> +		return -EINVAL;
> +	}
> +
> +	if (stat(daemon->base, &st)) {
> +		pr_err("failed: base '%s' does not exists\n", daemon->base);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int setup_client_config(struct daemon *daemon)
> +{
> +	struct perf_config_set *set;
> +	int err = -ENOMEM;
> +
> +	set = perf_config_set__load_file(daemon->config_real);

	struct perf_config_set *set = perf_config_set__load_file(daemon->config_real);

> +	if (set) {
> +		err = perf_config_set(set, client_config, daemon);
> +		perf_config_set__delete(set);
> +	}
> +
> +	return err ?: check_base(daemon);
> +}
> +
>  static int setup_server_socket(struct daemon *daemon)
>  {
>  	struct sockaddr_un addr;
> @@ -114,6 +159,32 @@ static int handle_server_socket(struct daemon *daemon __maybe_unused, int sock_f
>  	return ret;
>  }
>  
> +static int setup_client_socket(struct daemon *daemon)
> +{
> +	struct sockaddr_un addr;
> +	char path[100];
> +	int fd;
> +
> +	fd = socket(AF_UNIX, SOCK_STREAM, 0);

Ditto

> +	if (fd == -1) {
> +		perror("failed: socket");
> +		return -1;
> +	}
> +
> +	scnprintf(path, PATH_MAX, "%s/control", daemon->base);
> +
> +	memset(&addr, 0, sizeof(addr));
> +	addr.sun_family = AF_UNIX;
> +	strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
> +
> +	if (connect(fd, (struct sockaddr *) &addr, sizeof(addr)) == -1) {
> +		perror("failed: connect");

close fd

> +		return -1;
> +	}
> +
> +	return fd;
> +}
> +
>  static void daemon__free(struct daemon *daemon)
>  {
>  	free(daemon->config_real);
> @@ -211,6 +282,40 @@ static int __cmd_start(struct daemon *daemon, struct option parent_options[],
>  	return err;
>  }
>  
> +__maybe_unused
> +static int send_cmd(struct daemon *daemon, union cmd *cmd)
> +{
> +	char *line = NULL;
> +	size_t len = 0;
> +	ssize_t nread;
> +	FILE *in;
> +	int fd;
> +
> +	if (setup_client_config(daemon))
> +		return -1;
> +
> +	fd = setup_client_socket(daemon);
> +	if (fd < 0)
> +		return -1;
> +
> +	if (sizeof(*cmd) != write(fd, cmd, sizeof(*cmd)))

close fd

> +		return -1;
> +
> +	in = fdopen(fd, "r");
> +	if (!in) {
> +		perror("failed: fdopen");

close fd

> +		return -1;
> +	}
> +
> +	while ((nread = getline(&line, &len, in)) != -1) {
> +		fwrite(line, nread, 1, stdout);
> +		fflush(stdout);
> +	}
> +
> +	fclose(in);
> +	return 0;
> +}
> +
>  int cmd_daemon(int argc, const char **argv)
>  {
>  	struct option daemon_options[] = {
> -- 
> 2.29.2
> 

-- 

- Arnaldo
