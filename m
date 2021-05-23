Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5C138DBEE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 18:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhEWQcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 12:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231800AbhEWQcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 12:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621787452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ADAA9zigXtYO1sAk+xMXop6hGbdge9PJeQSz/68njFw=;
        b=Hg5wkz2jCimEhYNWRgJoAO559CAeSdMfzS0zX9gTbOwgnSIEZHFGD+mcr4Id1kG4RPByIK
        pfZymTREXtBCFkhFuHBpDn1Q/4eKbC1GyRDqr6LlcR7CmYmxLBCorecoBbWc2igFaeUIvJ
        UqiyJ9eoi6v/YHtAfswIcWO7U3BnTFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-eZxu3EB9MUye7VIUOkMT6w-1; Sun, 23 May 2021 12:30:48 -0400
X-MC-Unique: eZxu3EB9MUye7VIUOkMT6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3DFAD801106;
        Sun, 23 May 2021 16:30:47 +0000 (UTC)
Received: from krava (unknown [10.40.192.56])
        by smtp.corp.redhat.com (Postfix) with SMTP id 648EB60937;
        Sun, 23 May 2021 16:30:45 +0000 (UTC)
Date:   Sun, 23 May 2021 18:30:44 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Denys Zagorui <dzagorui@cisco.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Subject: Re: [PATCH v7 2/3] perf tests: avoid storing an absolute path in
 perf binary
Message-ID: <YKqDNJbKOR5NqloD@krava>
References: <20210522062016.84677-1-dzagorui@cisco.com>
 <20210522062016.84677-2-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522062016.84677-2-dzagorui@cisco.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 11:20:15PM -0700, Denys Zagorui wrote:
> python binding test uses PYTHONPATH definition to find python/perf.so
> library. This definition is an absolute path that makes perf binary
> unreproducible. This path can be found during runtime execution.
> 
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> ---
>  tools/perf/tests/Build        |  2 +-
>  tools/perf/tests/python-use.c | 32 ++++++++++++++++++++++++++++++--
>  2 files changed, 31 insertions(+), 3 deletions(-)
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
> index 98c6d474aa6f..e196faf1140d 100644
> --- a/tools/perf/tests/python-use.c
> +++ b/tools/perf/tests/python-use.c
> @@ -8,18 +8,46 @@
>  #include <linux/compiler.h>
>  #include "tests.h"
>  #include "util/debug.h"
> +#include "util/util.h"
> +#include <sys/stat.h>
> +#include <limits.h>
> +#include <libgen.h>

sry, did not notice there was new version.. looks good, 2 nits below

thanks,
jirka


>  
>  int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
>  	char *cmd;
>  	int ret;
> +	char *exec_path;
> +	char *buf;
> +	char *pythonpath = NULL;
> +	struct stat sb;
>  
> -	if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); import perf\" | %s %s",
> -		     PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
> +	buf = malloc(PATH_MAX);

why bother with dynamic allocation here, we normaly do that on stack

> +	if (buf == NULL)
>  		return -1;
>  
> +	perf_exe(buf, PATH_MAX);
> +	exec_path = dirname(buf);
> +
> +	if (asprintf(&pythonpath, "%s/python", exec_path) < 0) {
> +		ret = -1;

you could initialize ret with -1

> +		goto out;
> +	}
> +
> +	if (stat(pythonpath, &sb) || !S_ISDIR(sb.st_mode))
> +		pythonpath[0] = 0;
> +
> +	if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); import perf\" | %s %s",
> +		     pythonpath, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0) {
> +		ret = -1;
> +		goto out;
> +	}
> +
>  	pr_debug("python usage test: \"%s\"\n", cmd);
>  	ret = system(cmd) ? -1 : 0;
>  	free(cmd);
> +out:
> +	free(buf);
> +	free(pythonpath);
>  	return ret;
>  }
> -- 
> 2.26.2.Cisco
> 

