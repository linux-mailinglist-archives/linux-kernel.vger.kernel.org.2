Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56120391987
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbhEZOJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:09:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232948AbhEZOJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:09:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4328261026;
        Wed, 26 May 2021 14:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622038078;
        bh=J02+pU3JIEq0JtoXBzc9BMBOEA013guqaGeCpZBVkks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUfbfxqWeV0hI0SdN+sAGWTk48RT4sqdzfZ9/Ho2qDZQCzCy9omxpmu+QmlTES2KE
         l3HrEyR4TWUgXeCGwhu3iJqLgTkp8LgQq4n1iSJlGopBkZrtJdRZ1PW2d1BEkbjtJ6
         Z3iuofFFw9qB/6d/o7uRjxrhMfOvmZn2glrXi3AYt6txdoCzelbPt5gbeOFcoxr/1W
         D0WP2Uzp6dFJ7ZEgiHTby1WW9TuihSI2qhFBxjPDtPOmUsRWj6UWgNWMh8+Uxce8r3
         59mXcxgVr1sgBbL0qzrUQFSBivPQ+1anhFFeD9W6Y7ub8EjrG8g/v3oUhYNVaVfIBM
         Ikc06PIayvgRA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4DCE04011C; Wed, 26 May 2021 11:07:55 -0300 (-03)
Date:   Wed, 26 May 2021 11:07:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Denys Zagorui <dzagorui@cisco.com>
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Subject: Re: [PATCH v7 1/3] perf report: compile tips.txt in perf binary
Message-ID: <YK5WO3is6EW9TNrX@kernel.org>
References: <20210522062016.84677-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210522062016.84677-1-dzagorui@cisco.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, May 21, 2021 at 11:20:14PM -0700, Denys Zagorui escreveu:
> It seems there is some need to have an ability to invoke perf from
> build directory without installation
> (84cfac7f05e1: perf tools: Set and pass DOCDIR to builtin-report.c)
> DOCDIR definition contains an absolute path to kernel source directory.
> It is build machine related info and it makes perf binary unreproducible.
> 
> This can be avoided by compiling tips.txt in perf directly.
> 
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> ---
>  tools/perf/Build               |  2 +-
>  tools/perf/Documentation/Build |  9 +++++++++
>  tools/perf/builtin-report.c    | 34 +++++++++++++++++++++++++---------
>  tools/perf/util/util.c         | 28 ----------------------------
>  tools/perf/util/util.h         |  2 --
>  5 files changed, 35 insertions(+), 40 deletions(-)
>  create mode 100644 tools/perf/Documentation/Build
> 
> diff --git a/tools/perf/Build b/tools/perf/Build
> index db61dbe2b543..3a2e768d7576 100644
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -45,12 +45,12 @@ CFLAGS_perf.o              += -DPERF_HTML_PATH="BUILD_STR($(htmldir_SQ))"	\
>  			      -DPREFIX="BUILD_STR($(prefix_SQ))"
>  CFLAGS_builtin-trace.o	   += -DSTRACE_GROUPS_DIR="BUILD_STR($(STRACE_GROUPS_DIR_SQ))"
>  CFLAGS_builtin-report.o	   += -DTIPDIR="BUILD_STR($(tipdir_SQ))"
> -CFLAGS_builtin-report.o	   += -DDOCDIR="BUILD_STR($(srcdir_SQ)/Documentation)"
>  
>  perf-y += util/
>  perf-y += arch/
>  perf-y += ui/
>  perf-y += scripts/
>  perf-$(CONFIG_TRACE) += trace/beauty/
> +perf-y += Documentation/
>  
>  gtk-y += ui/gtk/
> diff --git a/tools/perf/Documentation/Build b/tools/perf/Documentation/Build
> new file mode 100644
> index 000000000000..83e16764caa4
> --- /dev/null
> +++ b/tools/perf/Documentation/Build
> @@ -0,0 +1,9 @@
> +perf-y += tips.o
> +
> +quiet_cmd_ld_tips = LD       $@
> +      cmd_ld_tips = $(LD) -r -b binary -o $@ $<
> +
> +$(OUTPUT)Documentation/tips.o: Documentation/tips.txt FORCE
> +	$(call rule_mkdir)
> +	$(call if_changed,ld_tips)
> +
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 36f9ccfeb38a..4f2c7ee8fea1 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -47,7 +47,6 @@
>  #include "util/time-utils.h"
>  #include "util/auxtrace.h"
>  #include "util/units.h"
> -#include "util/util.h" // perf_tip()
>  #include "ui/ui.h"
>  #include "ui/progress.h"
>  #include "util/block-info.h"
> @@ -109,6 +108,9 @@ struct report {
>  	int			nr_block_reports;
>  };
>  
> +extern char _binary_Documentation_tips_txt_start[];
> +extern char _binary_Documentation_tips_txt_end[];
> +
>  static int report__config(const char *var, const char *value, void *cb)
>  {
>  	struct report *rep = cb;
> @@ -614,19 +616,33 @@ static int report__gtk_browse_hists(struct report *rep, const char *help)
>  	return hist_browser(rep->session->evlist, help, NULL, rep->min_percent);
>  }
>  
> +static const char *perf_tip(void)
> +{
> +	char *start = _binary_Documentation_tips_txt_start;
> +	char *tok, *tmp, *prev;
> +	int pick, size;
> +
> +	size = _binary_Documentation_tips_txt_end - start;
> +	pick = random() % size;
> +
> +	_binary_Documentation_tips_txt_start[size - 1] = 0;
> +
> +	for (tok = strtok_r(start, "\n", &tmp); tok;
> +	     tok = strtok_r(NULL, "\n", &tmp)) {
> +		if (pick < (tok - start))
> +			return prev;
> +		prev = tok;
> +	}
> +
> +	return prev;
> +}


[perfbuilder@five ~]$ export PERF_TARBALL=http://192.168.100.2/perf/perf-5.13.0-rc3.tar.xz
[perfbuilder@five ~]$ time dm
Wed May 26 11:04:00 AM -03 2021
# export PERF_TARBALL=http://192.168.100.2/perf/perf-5.13.0-rc3.tar.xz
# dm
   1     9.39 alpine:3.4                    : FAIL gcc version 5.3.0 (Alpine 5.3.0)
    builtin-report.c: In function 'cmd_report':
    builtin-report.c:560:3: error: 'prev' may be used uninitialized in this function [-Werror=maybe-uninitialized]
       fprintf(stdout, "#\n# (%s)\n#\n", help);
       ^
    builtin-report.c:622:20: note: 'prev' was declared here
      char *tok, *tmp, *prev;
<SNIP>

  10    13.35 alpine:3.13                   : FAIL gcc version 10.2.1 20201203 (Alpine 10.2.1_pre1)
    builtin-report.c: In function 'cmd_report':
    builtin-report.c:560:3: error: 'prev' may be used uninitialized in this function [-Werror=maybe-uninitialized]
      560 |   fprintf(stdout, "#\n# (%s)\n#\n", help);
          |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    builtin-report.c:622:20: note: 'prev' was declared here
      622 |  char *tok, *tmp, *prev;
          |                    ^~~~
    cc1: all warnings being treated as errors
  11    13.77 alpine:edge                   : FAIL gcc version 10.3.1 20210424 (Alpine 10.3.1_git20210424)
    builtin-report.c: In function 'cmd_report':
    builtin-report.c:560:3: error: 'prev' may be used uninitialized in this function [-Werror=maybe-uninitialized]
      560 |   fprintf(stdout, "#\n# (%s)\n#\n", help);
          |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    builtin-report.c:622:20: note: 'prev' was declared here
      622 |  char *tok, *tmp, *prev;
          |                    ^~~~
    cc1: all warnings being treated as errors


I'll check later...

>  static int report__browse_hists(struct report *rep)
>  {
>  	int ret;
>  	struct perf_session *session = rep->session;
>  	struct evlist *evlist = session->evlist;
> -	const char *help = perf_tip(system_path(TIPDIR));
> -
> -	if (help == NULL) {
> -		/* fallback for people who don't install perf ;-) */
> -		help = perf_tip(DOCDIR);
> -		if (help == NULL)
> -			help = "Cannot load tips.txt file, please install perf!";
> -	}
> +	const char *help = perf_tip();
>  
>  	switch (use_browser) {
>  	case 1:
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 37a9492edb3e..3bba74e431ed 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -379,34 +379,6 @@ fetch_kernel_version(unsigned int *puint, char *str,
>  	return 0;
>  }
>  
> -const char *perf_tip(const char *dirpath)
> -{
> -	struct strlist *tips;
> -	struct str_node *node;
> -	char *tip = NULL;
> -	struct strlist_config conf = {
> -		.dirname = dirpath,
> -		.file_only = true,
> -	};
> -
> -	tips = strlist__new("tips.txt", &conf);
> -	if (tips == NULL)
> -		return errno == ENOENT ? NULL :
> -			"Tip: check path of tips.txt or get more memory! ;-p";
> -
> -	if (strlist__nr_entries(tips) == 0)
> -		goto out;
> -
> -	node = strlist__entry(tips, random() % strlist__nr_entries(tips));
> -	if (asprintf(&tip, "Tip: %s", node->s) < 0)
> -		tip = (char *)"Tip: get more memory! ;-)";
> -
> -out:
> -	strlist__delete(tips);
> -
> -	return tip;
> -}
> -
>  char *perf_exe(char *buf, int len)
>  {
>  	int n = readlink("/proc/self/exe", buf, len);
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index ad737052e597..80b194ee6c7d 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -39,8 +39,6 @@ int fetch_kernel_version(unsigned int *puint,
>  #define KVER_FMT	"%d.%d.%d"
>  #define KVER_PARAM(x)	KVER_VERSION(x), KVER_PATCHLEVEL(x), KVER_SUBLEVEL(x)
>  
> -const char *perf_tip(const char *dirpath);
> -
>  #ifndef HAVE_SCHED_GETCPU_SUPPORT
>  int sched_getcpu(void);
>  #endif
> -- 
> 2.26.2.Cisco
> 

-- 

- Arnaldo
