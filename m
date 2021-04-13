Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1024235E1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343955AbhDMOll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:41:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:59738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231917AbhDMOlc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:41:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618324872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XrS3LvtoF2dKQLQn8cBGzZViUcGsw61UP94N7EYr7+k=;
        b=ForxJz/oBkA0zRzL34o2nMOj9qljmCDmJdOXj5KRxijTFuU26d/zSTJyAqggC08fCacpQ+
        3GqRC7No8e46XAJCiPpSORCzGjYZ04QsvvL9p87reE5HjYOlPNLYXWQ9AQvCrxw/f4aH62
        E0LUf9FsoBvDiJF3PaVhDnR/UHiDaQk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DB05BAF9E;
        Tue, 13 Apr 2021 14:41:11 +0000 (UTC)
Date:   Tue, 13 Apr 2021 16:41:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 04/13] dump_stack: Add vmlinux build ID to stack traces
Message-ID: <YHWthzF+l0iacMuw@alley>
References: <20210410015300.3764485-1-swboyd@chromium.org>
 <20210410015300.3764485-5-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410015300.3764485-5-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-04-09 18:52:51, Stephen Boyd wrote:
> Add the running kernel's build ID[1] to the stacktrace information
> header.  This makes it simpler for developers to locate the vmlinux with
> full debuginfo for a particular kernel stacktrace. Combined with
> scripts/decode_stracktrace.sh, a developer can download the correct
> vmlinux from a debuginfod[2] server and find the exact file and line
> number for the functions plus offsets in a stacktrace.
> 
> This is especially useful for pstore crash debugging where the kernel
> crashes are recorded in the pstore logs and the recovery kernel is
> different or the debuginfo doesn't exist on the device due to space
> concerns (the data can be large and a security concern). The stacktrace
> can be analyzed after the crash by using the build ID to find the
> matching vmlinux and understand where in the function something went
> wrong.
> 
> Example stacktrace from lkdtm:
> 
>  WARNING: CPU: 4 PID: 3255 at drivers/misc/lkdtm/bugs.c:83 lkdtm_WARNING+0x28/0x30 [lkdtm]
>  Modules linked in: lkdtm rfcomm algif_hash algif_skcipher af_alg xt_cgroup uinput xt_MASQUERADE
>  CPU: 4 PID: 3255 Comm: bash Not tainted 5.11 #3 aa23f7a1231c229de205662d5a9e0d4c580f19a1
>  Hardware name: Google Lazor (rev3+) with KB Backlight (DT)
>  pstate: 00400009 (nzcv daif +PAN -UAO -TCO BTYPE=--)
>  pc : lkdtm_WARNING+0x28/0x30 [lkdtm]
> 
> The hex string aa23f7a1231c229de205662d5a9e0d4c580f19a1 is the build ID,
> following the kernel version number. Put it all behind a config option,
> STACKTRACE_BUILD_ID, so that kernel developers can remove this
> information if they decide it is too much.
> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Link: https://fedoraproject.org/wiki/Releases/FeatureBuildId [1]
> Link: https://sourceware.org/elfutils/Debuginfod.html [2]
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

One comment below.

> ---
>  lib/Kconfig.debug | 11 +++++++++++
>  lib/dump_stack.c  | 13 +++++++++++--
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 2779c29d9981..5f883e50f406 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -35,6 +35,17 @@ config PRINTK_CALLER
>  	  no option to enable/disable at the kernel command line parameter or
>  	  sysfs interface.
>  
> +config STACKTRACE_BUILD_ID
> +	bool "Show build ID information in stacktraces"
> +	depends on PRINTK
> +	help
> +	  Selecting this option adds build ID information for symbols in
> +	  stacktraces printed with the printk format '%p[SR]b'.
> +
> +	  This option is intended for distros where debuginfo is not easily
> +	  accessible but can be downloaded given the build ID of the vmlinux or
> +	  kernel module where the function is located.
> +
>  config CONSOLE_LOGLEVEL_DEFAULT
>  	int "Default console loglevel (1-15)"
>  	range 1 15
> diff --git a/lib/dump_stack.c b/lib/dump_stack.c
> index f5a33b6f773f..d685331b065f 100644
> --- a/lib/dump_stack.c
> +++ b/lib/dump_stack.c
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/buildid.h>
>  #include <linux/export.h>
>  #include <linux/sched.h>
>  #include <linux/sched/debug.h>
> @@ -36,6 +37,14 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
>  	va_end(args);
>  }
>  
> +#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
> +#define BUILD_ID_FMT " %20phN"
> +#define BUILD_ID_VAL vmlinux_build_id
> +#else
> +#define BUILD_ID_FMT "%s"
> +#define BUILD_ID_VAL ""
> +#endif

3rd patch always defines and initializes vmlinux_build_id. But it is
used only when CONFIG_STACKTRACE_BUILD_ID is enabled.
Is it intentional, please?

It is not a big deal for vmlinux_build_id. But it is more questionable
for the per-module id. I am going to open this question for 5th patch
as well.

Best Regards,
Petr
