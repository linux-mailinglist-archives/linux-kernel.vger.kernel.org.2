Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54EDE318BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbhBKNMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:12:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231209AbhBKMwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 07:52:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22BD164E08;
        Thu, 11 Feb 2021 12:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613047928;
        bh=0R3pW2EmjrX1ocLLRW7YVSQVF3AM5YQu4du6c2wq2Cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PmdRJVmbDzuGBw+u/rzWf1P9+iKVbnK6Nj3+S1sARxrulssIcd2kYPxysRj0cHUOh
         ePGR4HEdllFuum1T/CCIBt37r3xQWX2WUov+YVEvFhdvA262YtIg4JwEZjOYJLFTiR
         +HwcwwYe5xVODEoJgyuAi+9+yxiEnvUwAXoT4ppj9VN65qFSiIwB5+kAxVNOrnC4sj
         mO+eQDBmpZ7DzEmh8erLxODifQB8iFDiDGB6gAOAntipjh/iORkF2utCgSyVnth5Dn
         80vLeNoXQw68wQ7oJy2+tvpJharSY8VEltnxMonyIYGzVCvt7IZ6NwDSHzK/N8h6pg
         EevTyyG+jNDsw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6F9E240513; Thu, 11 Feb 2021 09:52:05 -0300 (-03)
Date:   Thu, 11 Feb 2021 09:52:05 -0300
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
        Alexei Budankov <abudankov@huawei.com>
Subject: Re: [PATCH 05/24] perf daemon: Add client socket support
Message-ID: <20210211125205.GA1131885@kernel.org>
References: <20210208200908.1019149-1-jolsa@kernel.org>
 <20210208200908.1019149-6-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208200908.1019149-6-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 08, 2021 at 09:08:49PM +0100, Jiri Olsa escreveu:
> +__maybe_unused
> +static int send_cmd(struct daemon *daemon, union cmd *cmd)
> +{
> +	int ret = -1, fd;
> +	char *line = NULL;
> +	size_t len = 0;
> +	ssize_t nread;
> +	FILE *in = NULL;
> +
> +	if (setup_client_config(daemon))
> +		return -1;
> +
> +	fd = setup_client_socket(daemon);
> +	if (fd < 0)
> +		return -1;
> +
> +	if (sizeof(*cmd) != writen(fd, cmd, sizeof(*cmd))) {
> +		perror("failed: write");
> +		goto out;
> +	}
> +
> +	in = fdopen(fd, "r");
> +	if (!in) {
> +		perror("failed: fdopen");
> +		goto out;
> +	}
> +
> +	while ((nread = getline(&line, &len, in)) != -1) {
> +		fwrite(line, nread, 1, stdout);
> +		fflush(stdout);
> +	}
> +
> +	ret = 0;
> +	fclose(in);
> +out:
> +	/* If in is defined, then fd is closed via fclose. */
> +	if (!in)
> +		close(fd);
> +	return ret;
> +}
> +

So I had to add the patch below to deal with this in some systems:

  cc1: warnings being treated as errors
  builtin-daemon.c: In function 'send_cmd':  MKDIR    /tmp/build/perf/bench/
  
  builtin-daemon.c:1368: error: ignoring return value of 'fwrite', declared with attribute warn_unused_result
    MKDIR    /tmp/build/perf/tests/
  make[3]: *** [/tmp/build/perf/builtin-daemon.o] Error 1

And also to not leak the 'line' buffer allocated by getline(), since you
initialized line to NULL and len to zero, man page says:

	 If *lineptr is set to NULL and *n is set 0 before the call,
	 then getline() will allocate a buffer for storing the line.
	 This buffer should be freed by the user program even if
	 getline() failed.


diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index e0880c5ee39c89bd..0a282c4e23a9fd9a 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -344,12 +344,15 @@ static int send_cmd(struct daemon *daemon, union cmd *cmd)
 	}
 
 	while ((nread = getline(&line, &len, in)) != -1) {
-		fwrite(line, nread, 1, stdout);
+		if (fwrite(line, nread, 1, stdout) != 1)
+			goto out_fclose;
 		fflush(stdout);
 	}
 
 	ret = 0;
+out_fclose:
 	fclose(in);
+	free(line);
 out:
 	/* If in is defined, then fd is closed via fclose. */
 	if (!in)
