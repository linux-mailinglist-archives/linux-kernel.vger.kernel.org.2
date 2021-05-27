Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04D95393455
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236500AbhE0Qze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234803AbhE0Qzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:55:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA9E360D07;
        Thu, 27 May 2021 16:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622134439;
        bh=WbSLA+038O8hNxB4Xk789D8nn0kmf/W99WEIFpZZzuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YcZEIuGkYUOmWATo6Q6MX11VLsD3QZ9Uwt9z6BX5WadB8Q1FCRUHz0mVzN81zFxki
         9JGmsCOH885+nB04Suy9fwsuxIu2D85aDBEEw+OFJwVsA/7ISHZo6hnzOXfWsP8cMz
         9IdHpL3dKF3oAAPhVcYkLLl8bH2/ZDQt5szs9z9Dg6R1/k+cDYNWSrYvPhwIOKExi5
         H1GNZjot/WBu9tiAWY0IQXXUY+EaYhpJglj6l/2nX+1pzoGZw4GqntTDSAJyw48VDw
         TlxwgorqMEa4QT0nu05PwawrAEGQFXzr+fuYFANjmgI4AtWQV0LEtKv8vQ56OWE8i9
         DzYZmTby+F6zA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A81844011C; Thu, 27 May 2021 13:53:56 -0300 (-03)
Date:   Thu, 27 May 2021 13:53:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Denys Zagorui <dzagorui@cisco.com>
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Subject: Re: [PATCH v8 2/3] perf tests: avoid storing an absolute path in
 perf binary
Message-ID: <YK/OpLStd2zPdHS9@kernel.org>
References: <20210524111514.65713-1-dzagorui@cisco.com>
 <20210524111514.65713-2-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210524111514.65713-2-dzagorui@cisco.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 24, 2021 at 04:15:13AM -0700, Denys Zagorui escreveu:
> python binding test uses PYTHONPATH definition to find python/perf.so
> library. This definition is an absolute path that makes perf binary
> unreproducible. This path can be found during runtime execution.
> 
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> ---
>  tools/perf/tests/Build        |  2 +-
>  tools/perf/tests/python-use.c | 25 ++++++++++++++++++++++---
>  2 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 650aec19d490..a20098dcdbc4 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -98,5 +98,5 @@ perf-$(CONFIG_DWARF_UNWIND) += dwarf-unwind.o
>  endif
>  
>  CFLAGS_attr.o         += -DBINDIR="BUILD_STR($(bindir_SQ))" -DPYTHON="BUILD_STR($(PYTHON_WORD))"
> -CFLAGS_python-use.o   += -DPYTHONPATH="BUILD_STR($(OUTPUT)python)" -DPYTHON="BUILD_STR($(PYTHON_WORD))"
> +CFLAGS_python-use.o   += -DPYTHON="BUILD_STR($(PYTHON_WORD))"
>  CFLAGS_dwarf-unwind.o += -fno-optimize-sibling-calls
> diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.c
> index 98c6d474aa6f..32af71300aa3 100644
> --- a/tools/perf/tests/python-use.c
> +++ b/tools/perf/tests/python-use.c
> @@ -8,18 +8,37 @@
>  #include <linux/compiler.h>
>  #include "tests.h"
>  #include "util/debug.h"
> +#include "util/util.h"
> +#include <sys/stat.h>
> +#include <limits.h>
> +#include <libgen.h>
>  
>  int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
>  	char *cmd;
> -	int ret;
> +	int ret = -1;
> +	char *exec_path;
> +	char buf[PATH_MAX];
> +	char *pythonpath;
> +	struct stat sb;
> +
> +	perf_exe(buf, PATH_MAX);
> +	exec_path = dirname(buf);
> +
> +	if (asprintf(&pythonpath, "%s/python", exec_path) < 0)
> +		return ret;
> +
> +	if (stat(pythonpath, &sb) || !S_ISDIR(sb.st_mode))
> +		pythonpath[0] = 0;
>  
>  	if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); import perf\" | %s %s",
> -		     PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
> -		return -1;
> +		     pythonpath, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
> +		goto out;
>  
>  	pr_debug("python usage test: \"%s\"\n", cmd);
>  	ret = system(cmd) ? -1 : 0;
>  	free(cmd);
> +out:
> +	free(pythonpath);
>  	return ret;
>  }
> -- 
> 2.26.2.Cisco
> 

I noticed this is failing the test, nothing is being appended. I'll
investigate later. Can you try to reproduce this? I build perf with:

alias m='perf stat -e cycles:u,instructions:u make -k CORESIGHT=1 BUILD_BPF_SKEL=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin && perf test python'


⬢[acme@toolbox perf]$ perf test python
19: 'import perf' in python                                         : FAILED!
⬢[acme@toolbox perf]$ perf test -v python
Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
19: 'import perf' in python                                         :
--- start ---
test child forked, pid 347155
python usage test: "echo "import sys ; sys.path.append(''); import perf" | '/usr/bin/python3' "
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
ModuleNotFoundError: No module named 'perf'
test child finished with -1
---- end ----
'import perf' in python: FAILED!
⬢[acme@toolbox perf]$ git log --oneline -3
60cdbfd0586e53c3 (HEAD) perf tests: Avoid storing an absolute path in perf binary
f7fc0d1c915a74ff perf inject: Do not inject BUILD_ID record if MMAP2 has it
0c3f7b38d72b9247 perf inject: Call dso__put() even if dso->hit is set
⬢[acme@toolbox perf]$
