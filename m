Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719D933B2BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 13:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhCOM3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 08:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229681AbhCOM24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 08:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615811335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YeOF78f/oP//Gzbca9Gu2SY2pGB+8bHZXbuucWF2dwo=;
        b=aNZKWja2hrNs71/kbiXSmE3T5vZaOciD+Nt9aHtE9FsY9CGrxzouaqLqKrUjfKQArNmaiR
        p0FHO0COF0oED/Qz8pnF58FLJmMhP9XF9wNCeqoKP4j35M0p9x7IZonQWagxnP/Kc9srox
        o/HuWMmTJq4eYimUdBdPLnqq4lzOelA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-lfY_vReeOnO10AIKbZqfBQ-1; Mon, 15 Mar 2021 08:28:53 -0400
X-MC-Unique: lfY_vReeOnO10AIKbZqfBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C8EE18D6A36;
        Mon, 15 Mar 2021 12:28:52 +0000 (UTC)
Received: from krava (unknown [10.40.196.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7357C5D71B;
        Mon, 15 Mar 2021 12:28:50 +0000 (UTC)
Date:   Mon, 15 Mar 2021 13:28:49 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Denys Zagorui <dzagorui@cisco.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: build reproducibility improvements
Message-ID: <YE9TAY05BtXbuHxq@krava>
References: <20210312151700.79714-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312151700.79714-1-dzagorui@cisco.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 03:17:00PM +0000, Denys Zagorui wrote:
> This patch helps to make perf build more reproducible
> 
> It seems there is some need to have an ability to invoke
> perf from build directory without installation
> (84cfac7f05e1: perf tools: Set and pass DOCDIR to builtin-report.c)
> DOCDIR contains an absolute path to kernel source directory.
> In such case this path can be determined in runtime by using
> /proc/self/exe link. In case of building perf with O=
> Documentation/tips.txt can be copied to output directory.
> 
> There is also python binding test where PYTHONPATH is used to store
> absolute path to python/perf.so library. This path can be
> also determined in runtime.
> 
> bison stores full paths in generated files. This can be
> remapped by using --file-prefix-map option that is available
> starting from version 3.6.3.
> 
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>

hi,
I'm getting build error:

[jolsa@krava perf]$ make JOBS=1
  BUILD:   Doing 'make -j1' parallel build
Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
Makefile.config:1026: No openjdk development package found, please install JDK package, e.g. openjdk-8-jdk, java-1.8.0-openjdk-devel
cp: '/home/jolsa/kernel/linux-perf/tools/perf/Documentation/tips.txt' and 'Documentation/tips.txt' are the same file
  BISON    util/parse-events-bison.c
bison: unrecognized option '--file-prefix-map=='
Try 'bison --help' for more information.
make[4]: *** [util/Build:211: util/parse-events-bison.c] Error 1
make[3]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:139: util] Error 2
make[2]: *** [Makefile.perf:653: perf-in.o] Error 2
make[1]: *** [Makefile.perf:236: sub-make] Error 2
make: *** [Makefile:70: all] Error 2


SNIP

> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f6e609673de2..2bebff69b064 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -627,6 +627,9 @@ $(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_D
>  	  --quiet build_ext; \
>  	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
>  
> +_dummy := $(shell [ -d '$(OUTPUT)Documentation' ] || mkdir -p '$(OUTPUT)Documentation' && \
> +		cp '$(srcdir)/Documentation/tips.txt' '$(OUTPUT)Documentation/')
> +
>  please_set_SHELL_PATH_to_a_more_modern_shell:
>  	$(Q)$$(:)
>  
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 2a845d6cac09..d9441055357e 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -610,12 +610,27 @@ static int report__browse_hists(struct report *rep)
>  	struct perf_session *session = rep->session;
>  	struct evlist *evlist = session->evlist;
>  	const char *help = perf_tip(system_path(TIPDIR));
> +	char *exec_path;
> +	char *docdir;
>  
>  	if (help == NULL) {
>  		/* fallback for people who don't install perf ;-) */
> -		help = perf_tip(DOCDIR);
> -		if (help == NULL)
> -			help = "Cannot load tips.txt file, please install perf!";
> +		exec_path = get_exec_abs_path();
> +		if (exec_path == NULL || asprintf(&docdir, "%sDocumentation", exec_path) < 0) {
> +			docdir = NULL;
> +			help = "Not enough memory or some other internal error occurred!";
> +		}

hum, do we actualy want this? I think we want the exact path
we used for compilation, no? what's the benefit?

> +
> +		if (docdir != NULL) {
> +			help = perf_tip(docdir);
> +			if (help == NULL)
> +				help = "Cannot load tips.txt file, please install perf!";
> +		}
> +
> +		if (exec_path)
> +			free(exec_path);
> +		if (docdir)
> +			free(docdir);
>  	}
>  
>  	switch (use_browser) {
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
> index 98c6d474aa6f..8b4865c90d5d 100644
> --- a/tools/perf/tests/python-use.c
> +++ b/tools/perf/tests/python-use.c
> @@ -8,16 +8,28 @@
>  #include <linux/compiler.h>
>  #include "tests.h"
>  #include "util/debug.h"
> +#include <subcmd/exec-cmd.h>
>  
>  int test__python_use(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
>  	char *cmd;
>  	int ret;
> +	char *exec_path = NULL;
> +	char *pythonpath;
> +
> +	exec_path = get_exec_abs_path();
> +	if (exec_path == NULL)
> +		return -1;
> +
> +	if (asprintf(&pythonpath, "%spython", exec_path) < 0)
> +		return -1;

same here, we want to be sure to use the python path
from the exact build laction no?

thanks,
jirka

