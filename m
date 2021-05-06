Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A198D3755C9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 16:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhEFOlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 10:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234694AbhEFOlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 10:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620312012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I+6e6IJwQMWg9nzfOfA+qtdnGN/AsqAvgKqcEhV3ImQ=;
        b=VTNx5rsPrWh+Q12aCIvveLqstAPLTItvhAvEjbOEbFi92a5yi9XQBVZ/1fuhbvhJbSmepM
        GnUt4yddoFUAH54wvq90zGkiLclXNKWODRjjRKMXNDYp+UwmoHzlP6X+dfWy9XOZ8yxtOo
        pK0BO7SI1OeEDthtgk1yVmjcIsfqnNY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-KdjuqoalOhSMoBAiDc1Ilw-1; Thu, 06 May 2021 10:40:04 -0400
X-MC-Unique: KdjuqoalOhSMoBAiDc1Ilw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D81BB6D5C8;
        Thu,  6 May 2021 14:40:02 +0000 (UTC)
Received: from krava (unknown [10.40.193.227])
        by smtp.corp.redhat.com (Postfix) with SMTP id E69BE10027A5;
        Thu,  6 May 2021 14:40:00 +0000 (UTC)
Date:   Thu, 6 May 2021 16:40:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Denys Zagorui <dzagorui@cisco.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Subject: Re: [PATCH v4 2/3] perf tests: avoid storing an absolute path in
 perf binary
Message-ID: <YJP/wDx/cIKLkpLk@krava>
References: <20210430133350.20504-1-dzagorui@cisco.com>
 <20210430133350.20504-2-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430133350.20504-2-dzagorui@cisco.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 06:33:49AM -0700, Denys Zagorui wrote:
> python binding test uses PYTHONPATH definition to find python/perf.so
> library. This definition is an absolute path that makes perf binary
> unreproducible. This path can be found during runtime execution.
> 
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> ---
>  tools/perf/tests/Build        |  2 +-
>  tools/perf/tests/python-use.c | 19 ++++++++++++++++++-
>  tools/perf/util/util.c        | 21 +++++++++++++++++++++
>  tools/perf/util/util.h        |  2 ++
>  4 files changed, 42 insertions(+), 2 deletions(-)
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
> index 98c6d474aa6f..c7a0c9b5366f 100644
> --- a/tools/perf/tests/python-use.c
> +++ b/tools/perf/tests/python-use.c
> @@ -8,18 +8,35 @@
>  #include <linux/compiler.h>
>  #include "tests.h"
>  #include "util/debug.h"
> +#include "util/util.h"
> +#include <sys/stat.h>
>  
>  int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
>  	char *cmd;
>  	int ret;
> +	char *exec_path;
> +	char *pythonpath;
> +	struct stat sb;
> +
> +	exec_path = perf_exe_path();
> +	if (exec_path == NULL)
> +		return -1;

should we return TEST_SKIP in here?

> +
> +	if (asprintf(&pythonpath, "%spython", exec_path) < 0)
> +		return -1;

leaking exec_path

> +
> +	if (stat(pythonpath, &sb) || !S_ISDIR(sb.st_mode))
> +		pythonpath[0] = 0;
>  
>  	if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); import perf\" | %s %s",
> -		     PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
> +		     pythonpath, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
>  		return -1;

leaking exec_path and pythonpath

>  
>  	pr_debug("python usage test: \"%s\"\n", cmd);
>  	ret = system(cmd) ? -1 : 0;
>  	free(cmd);
> +	free(exec_path);
> +	free(pythonpath);
>  	return ret;
>  }
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 3bba74e431ed..54e80452887c 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -388,3 +388,24 @@ char *perf_exe(char *buf, int len)
>  	}
>  	return strcpy(buf, "perf");
>  }
> +
> +char *perf_exe_path(void)
> +{
> +	int i;
> +	char *buf;
> +
> +	buf = malloc(PATH_MAX);

need to check buf != NULL

> +	buf = perf_exe(buf, PATH_MAX);
> +
> +	for (i = strlen(buf) - 1; i != 0 && buf[i] != '/'; i--)
> +		;

could we call dirname for this?

thanks,
jirka

> +
> +	if (!i) {
> +		free(buf);
> +		return NULL;
> +	}
> +
> +	buf[i + 1] = 0;
> +
> +	return buf;
> +}
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index 80b194ee6c7d..4e871e890ef8 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -49,6 +49,8 @@ void perf_set_singlethreaded(void);
>  void perf_set_multithreaded(void);
>  
>  char *perf_exe(char *buf, int len);
> +/* perf_exe_path return malloc'd string on success, caller must free it */
> +char *perf_exe_path(void);
>  
>  #ifndef O_CLOEXEC
>  #ifdef __sparc__
> -- 
> 2.26.2.Cisco
> 

