Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AD937552F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbhEFNzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:55:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30436 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233982AbhEFNzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:55:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620309287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BcQUfqyBxndJOtzyA1QLGzQ50JbXAyqeLeyUDhJzKlQ=;
        b=fTQ6VuMZZhw1XlaaO8y/VVaiOTxrzaFTeZSePsSsF3OmOolIr2QZYwwqCootnysHILHcfL
        jmRtd3guCMz4IgvyaMpw3IBEr2xQNFU099FAW67XFplJvnuNVQi59lkmox6h1vT34W6wu5
        wExi+hyHQqDOXmLm8Ckm8MgSunvuEoc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-K7u6eQB1Pi-C-gtqhWUupA-1; Thu, 06 May 2021 09:54:43 -0400
X-MC-Unique: K7u6eQB1Pi-C-gtqhWUupA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B94D8014D8;
        Thu,  6 May 2021 13:54:41 +0000 (UTC)
Received: from krava (unknown [10.40.193.227])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9A69260862;
        Thu,  6 May 2021 13:54:38 +0000 (UTC)
Date:   Thu, 6 May 2021 15:54:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Denys Zagorui <dzagorui@cisco.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org
Subject: Re: [PATCH v4 1/3] perf report: compile tips.txt in perf binary
Message-ID: <YJP1HfjAd6hEirmg@krava>
References: <20210430133350.20504-1-dzagorui@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430133350.20504-1-dzagorui@cisco.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 06:33:48AM -0700, Denys Zagorui wrote:
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
>  tools/perf/Documentation/Build |  9 ++++++++
>  tools/perf/builtin-report.c    | 39 ++++++++++++++++++++++++++--------
>  tools/perf/util/util.c         | 28 ------------------------
>  tools/perf/util/util.h         |  2 --
>  5 files changed, 40 insertions(+), 40 deletions(-)
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

nice, I had no idea ld could do it like this ;-)

> +
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 2a845d6cac09..88375ed76d53 100644
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
> @@ -107,6 +106,9 @@ struct report {
>  	int			nr_block_reports;
>  };
>  
> +extern char _binary_Documentation_tips_txt_start[];
> +extern char _binary_Documentation_tips_txt_end[];
> +
>  static int report__config(const char *var, const char *value, void *cb)
>  {
>  	struct report *rep = cb;
> @@ -604,19 +606,38 @@ static int report__gtk_browse_hists(struct report *rep, const char *help)
>  	return hist_browser(rep->session->evlist, help, NULL, rep->min_percent);
>  }
>  
> +#define MAX_TIPS        60
> +
> +static const char *perf_tip(void)
> +{
> +	char *str[MAX_TIPS];
> +	int i = 0;
> +
> +	_binary_Documentation_tips_txt_start[_binary_Documentation_tips_txt_end -
> +		_binary_Documentation_tips_txt_start - 1] = 0;
> +
> +	str[i] = strtok(_binary_Documentation_tips_txt_start, "\n");
> +	if (!str[i])
> +		return "Tips cannot be found!";
> +
> +	i++;
> +
> +	while (i < MAX_TIPS) {
> +		str[i] = strtok(NULL, "\n");
> +		if (!str[i])
> +			break;
> +		i++;
> +	}

I dont mind to keep static count of tips, but would be great
to have some check when there are more tips in the tips.txt

or perhaps pick tip with random index within the tips data size?
you would just do strtok until you reach the string that has the
random index inside.. you wouldn't need str pointers then

jirka

