Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2A133C43F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236298AbhCORcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54449 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231169AbhCORci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615829557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c3UqSV1GhtnWM54bEayrEMlX1LYdiV3hvu2wjAzTrbM=;
        b=eXSmvCG1h35fiqzB7Yf0aTBpCXnlWsp7TYz4tZWdHNGFLu9edJfERakg+gvXD5hSt3qkHL
        NS+YyaF8nsahK20IO+vpwmJL8RYnrQrsiYjBdfKuVBtapsYC3l7jaVPKuzi1Sr6vk64Ma/
        kbpfdKDVAvQHii2wwEYF45uGd8DoSQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-_Cf8lqgDNm-S6Uy1A6zuhA-1; Mon, 15 Mar 2021 13:32:33 -0400
X-MC-Unique: _Cf8lqgDNm-S6Uy1A6zuhA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61630107ACCA;
        Mon, 15 Mar 2021 17:32:32 +0000 (UTC)
Received: from krava (unknown [10.40.196.50])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9D2CE5B698;
        Mon, 15 Mar 2021 17:32:30 +0000 (UTC)
Date:   Mon, 15 Mar 2021 18:32:29 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Denys Zagorui <dzagorui@cisco.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf: build reproducibility improvements
Message-ID: <YE+aLdhcXJv5jmKK@krava>
References: <20210315164635.119575-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315164635.119575-1-dzagorui@cisco.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 09:46:35AM -0700, Denys Zagorui wrote:
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
> starting from version 3.7.1.
> 
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> ---
>  tools/lib/subcmd/exec-cmd.c   | 21 +++++++++++++++++++++
>  tools/lib/subcmd/exec-cmd.h   |  1 +
>  tools/perf/Build              |  1 -
>  tools/perf/Makefile.perf      |  3 +++
>  tools/perf/builtin-report.c   | 21 ++++++++++++++++++---
>  tools/perf/tests/Build        |  2 +-
>  tools/perf/tests/python-use.c | 14 +++++++++++++-
>  tools/perf/util/Build         | 10 +++++++---
>  8 files changed, 64 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/lib/subcmd/exec-cmd.c b/tools/lib/subcmd/exec-cmd.c
> index 33e94fb83986..3116246ec629 100644
> --- a/tools/lib/subcmd/exec-cmd.c
> +++ b/tools/lib/subcmd/exec-cmd.c
> @@ -208,3 +208,24 @@ int execl_cmd(const char *cmd,...)
>  	argv[argc] = NULL;
>  	return execv_cmd(argv);
>  }
> +
> +/* The caller is responsible to free the returned buffer */
> +char *get_exec_abs_path(void)
> +{

we have perf_exe for the whole perf binary, so let's call this perf_exe_path

> +	int ret;
> +	int i;
> +	char *buf;
> +
> +	buf = malloc(PATH_MAX);
> +	ret = readlink("/proc/self/exe", buf, PATH_MAX - 1);
> +	if (ret <= 0) {
> +		free(buf);
> +		return NULL;
> +	}

you could call perf_exe for this ^^^

> +
> +	for (i = ret - 1; buf[i] != '/'; i--);
> +
> +	buf[i + 1] = 0;
> +
> +	return buf;
> +}
> diff --git a/tools/lib/subcmd/exec-cmd.h b/tools/lib/subcmd/exec-cmd.h
> index aba591b8d254..9dc98248dadf 100644
> --- a/tools/lib/subcmd/exec-cmd.h
> +++ b/tools/lib/subcmd/exec-cmd.h
> @@ -13,5 +13,6 @@ extern int execl_cmd(const char *cmd, ...);
>  /* get_argv_exec_path and system_path return malloc'd string, caller must free it */
>  extern char *get_argv_exec_path(void);
>  extern char *system_path(const char *path);
> +extern char *get_exec_abs_path(void);
>  
>  #endif /* __SUBCMD_EXEC_CMD_H */
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
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index f6e609673de2..c9e3aae6c47f 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -627,6 +627,9 @@ $(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_D
>  	  --quiet build_ext; \
>  	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
>  
> +_dummy := $(shell [ -d '$(OUTPUT)Documentation' ] || (mkdir -p '$(OUTPUT)Documentation' && \
> +		cp '$(srcdir)/Documentation/tips.txt' '$(OUTPUT)Documentation/'))
> +

why do we need this? also should be in Documentation make

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

are we sure there's always trailing '/' in exec_path ?

> +		return -1;
>  
>  	if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); import perf\" | %s %s",
> -		     PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
> +		     pythonpath, PYTHON, verbose > 0 ? "" : "2> /dev/null") < 0)
>  		return -1;
>  
> +	free(exec_path);
> +	free(pythonpath);
>  	pr_debug("python usage test: \"%s\"\n", cmd);
>  	ret = system(cmd) ? -1 : 0;
>  	free(cmd);
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index e3e12f9d4733..11ad0fdaf71e 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -197,6 +197,10 @@ CFLAGS_llvm-utils.o += -DPERF_INCLUDE_DIR="BUILD_STR($(perf_include_dir_SQ))"
>  # avoid compiler warnings in 32-bit mode
>  CFLAGS_genelf_debug.o  += -Wno-packed
>  
> +ifeq ($(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \>\= 371), 1)
> +  BISON_FILE_PREFIX_MAP := --file-prefix-map=$(OUTPUT)=
> +endif

seems too small for feature detection, but please add it to
Makefile.config and make new variable under .config-detected

thanks,
jirka

> +
>  $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-events.l $(OUTPUT)util/parse-events-bison.c
>  	$(call rule_mkdir)
>  	$(Q)$(call echo-cmd,flex)$(FLEX) -o $(OUTPUT)util/parse-events-flex.c \
> @@ -204,7 +208,7 @@ $(OUTPUT)util/parse-events-flex.c $(OUTPUT)util/parse-events-flex.h: util/parse-
>  
>  $(OUTPUT)util/parse-events-bison.c $(OUTPUT)util/parse-events-bison.h: util/parse-events.y
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
> +	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
>  		-o $(OUTPUT)util/parse-events-bison.c -p parse_events_
>  
>  $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/expr-bison.c
> @@ -214,7 +218,7 @@ $(OUTPUT)util/expr-flex.c $(OUTPUT)util/expr-flex.h: util/expr.l $(OUTPUT)util/e
>  
>  $(OUTPUT)util/expr-bison.c $(OUTPUT)util/expr-bison.h: util/expr.y
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
> +	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
>  		-o $(OUTPUT)util/expr-bison.c -p expr_
>  
>  $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-bison.c
> @@ -224,7 +228,7 @@ $(OUTPUT)util/pmu-flex.c $(OUTPUT)util/pmu-flex.h: util/pmu.l $(OUTPUT)util/pmu-
>  
>  $(OUTPUT)util/pmu-bison.c $(OUTPUT)util/pmu-bison.h: util/pmu.y
>  	$(call rule_mkdir)
> -	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) \
> +	$(Q)$(call echo-cmd,bison)$(BISON) -v $< -d $(PARSER_DEBUG_BISON) $(BISON_FILE_PREFIX_MAP) \
>  		-o $(OUTPUT)util/pmu-bison.c -p perf_pmu_
>  
>  FLEX_GE_26 := $(shell expr $(shell $(FLEX) --version | sed -e  's/flex \([0-9]\+\).\([0-9]\+\)/\1\2/g') \>\= 26)
> -- 
> 2.26.2.Cisco
> 

