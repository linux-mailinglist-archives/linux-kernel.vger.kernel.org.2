Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209F335A0BB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 16:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhDIOL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 10:11:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232615AbhDIOL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 10:11:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617977504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F65FN3bXG04vQx79zPSTnv758c5T+VchrylwBxQ1dLg=;
        b=TBAYQswfUfQHb/CCXJnSPiu1tf10KnzX8WzLILq172WiBVokrrUcuE2JqwOe9dcR8XPItb
        NpTS2ot8w0/0UgeEUb0TbkniB9iWg1I3wAebWX9rHzjHsr09Sb1+TlNXeOS+LxspVvAQL6
        ySo49kuphN76QdxaIC7nrTfXS/WDPQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-b399KCHfMOO1u26-_ry1-Q-1; Fri, 09 Apr 2021 10:11:42 -0400
X-MC-Unique: b399KCHfMOO1u26-_ry1-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C957884B9A1;
        Fri,  9 Apr 2021 14:11:40 +0000 (UTC)
Received: from krava (unknown [10.40.195.216])
        by smtp.corp.redhat.com (Postfix) with SMTP id F29D119C66;
        Fri,  9 Apr 2021 14:11:38 +0000 (UTC)
Date:   Fri, 9 Apr 2021 16:11:38 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Denys Zagorui <dzagorui@cisco.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Subject: Re: [PATCH v3] perf: build reproducibility improvements
Message-ID: <YHBgmopzUg4cMQhs@krava>
References: <20210408125135.8445-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408125135.8445-1-dzagorui@cisco.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 05:51:35AM -0700, Denys Zagorui wrote:
> This patch helps to make perf build more reproducible
> 
> It seems there is some need to have an ability to invoke
> perf from build directory without installation
> (84cfac7f05e1: perf tools: Set and pass DOCDIR to builtin-report.c)
> DOCDIR contains an absolute path to kernel source directory.
> This path can be read from .config-detected that is stored in the
> same dir as perf executable.
> 
> There is also python binding test where PYTHONPATH is used to store
> absolute path to python/perf.so library. This path can be
> also determined in runtime.
> 
> bison stores full paths in generated files. This can be
> remapped by using --file-prefix-map option that is available
> starting from version 3.7.1.
> 
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> ---
>  tools/perf/Build              |  1 -
>  tools/perf/Makefile.config    |  9 +++++
>  tools/perf/builtin-report.c   | 13 +++++++-
>  tools/perf/tests/Build        |  2 +-
>  tools/perf/tests/python-use.c | 14 +++++++-
>  tools/perf/util/Build         |  6 ++--
>  tools/perf/util/util.c        | 62 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/util.h        |  5 +++
>  8 files changed, 105 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/Build b/tools/perf/Build
> index db61dbe2b543..56d0189f1029 100644
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -45,7 +45,6 @@ CFLAGS_perf.o              += -DPERF_HTML_PATH="BUILD_STR($(htmldir_SQ))"	\
>  			      -DPREFIX="BUILD_STR($(prefix_SQ))"
>  CFLAGS_builtin-trace.o	   += -DSTRACE_GROUPS_DIR="BUILD_STR($(STRACE_GROUPS_DIR_SQ))"
>  CFLAGS_builtin-report.o	   += -DTIPDIR="BUILD_STR($(tipdir_SQ))"
> -CFLAGS_builtin-report.o	   += -DDOCDIR="BUILD_STR($(srcdir_SQ)/Documentation)"
>  
>  perf-y += util/
>  perf-y += arch/
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index d8e59d31399a..2035bae6d5c5 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -195,6 +195,12 @@ ifeq ($(call get-executable,$(BISON)),)
>    dummy := $(error Error: $(BISON) is missing on this system, please install it)
>  endif
>  
> +ifneq ($(OUTPUT),)
> +  ifeq ($(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 371), 1)
> +    BISON_FILE_PREFIX_MAP := --file-prefix-map=$(OUTPUT)=
> +  endif
> +endif

please move all the flex, tips and python changes into separate patches

SNIP

> index 98c6d474aa6f..930aa4c6264e 100644
> --- a/tools/perf/tests/python-use.c
> +++ b/tools/perf/tests/python-use.c
> @@ -8,16 +8,28 @@
>  #include <linux/compiler.h>
>  #include "tests.h"
>  #include "util/debug.h"
> +#include "util/util.h"
>  
>  int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
>  	char *cmd;
>  	int ret;
> +	char *exec_path;
> +	char *pythonpath;
> +
> +	exec_path = perf_exe_path();
> +	if (exec_path == NULL)
> +		return -1;
> +
> +	if (asprintf(&pythonpath, "%spython", exec_path) < 0)
> +		return -1;

please check if the pythonpath exists and don't use it if does not..
with perf from rpm and python perf.so module the path is already there
so we don't care

SNIP

> +
> +int perf_src_doc(const char *exec_path, char **strp)
> +{
> +	FILE *file;
> +	char *line = NULL;
> +	size_t line_len = 0;
> +	ssize_t nread;
> +	int ret = -1;
> +	char *config_detected = NULL;
> +	static const char srcdir[] = "srcdir_SQ";
> +
> +	if (asprintf(&config_detected, "%s.config-detected", exec_path) < 0)
> +		return -1;
> +
> +	file = fopen(config_detected, "r");
> +	if (!file)
> +		goto out;
> +
> +	while (!feof(file)) {
> +		nread = getline(&line, &line_len, file);
> +		if (nread < 0)
> +			break;
> +
> +		if (!strncmp(line, srcdir, sizeof(srcdir) - 1)) {
> +
> +			if (line[nread - 1] == '\n')
> +				line[nread - 1] = 0;
> +
> +			if (asprintf(strp, "%s/Documentation", &line[sizeof(srcdir)]) != -1)
> +				ret = 0;
> +
> +			break;
> +		}
> +	}
> +
> +	fclose(file);
> +out:
> +	free(line);
> +	free(config_detected);
> +	return ret;
> +}

it's lot of tricky code because of one file, how about we compile
tips.txt in perf binary directly? it might be even less code changes

thanks,
jirka

