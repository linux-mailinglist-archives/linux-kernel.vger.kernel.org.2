Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64093356DA3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347500AbhDGNnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:43:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:57186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245734AbhDGNnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:43:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617802991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PTt2INgvl8GKTENrHC2C616TI8/OOmgd1MLV/x97y8g=;
        b=uy9k/YmtbPYUcRj8rwAiP9UdmKSdV0NvutC7siS97WestyjG3SzfHzCPJmyeFuzP/D9n/i
        B/3AsuYRLIYCoHqcYujCcgoZfPQ7/1igRnjNjDwrrQ5F50Mu0nvm4Y80IG4tN2Dr1GPbp4
        VHUcNOUdVRU2eReuBmW31uT4B6r2+Is=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11976B132;
        Wed,  7 Apr 2021 13:43:11 +0000 (UTC)
Date:   Wed, 7 Apr 2021 15:42:38 +0200
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
Subject: Re: [PATCH v3 03/12] dump_stack: Add vmlinux build ID to stack traces
Message-ID: <YG22znIOouERDND0@alley>
References: <20210331030520.3816265-1-swboyd@chromium.org>
 <20210331030520.3816265-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210331030520.3816265-4-swboyd@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-03-30 20:05:11, Stephen Boyd wrote:
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
> diff --git a/lib/dump_stack.c b/lib/dump_stack.c
> index f5a33b6f773f..07e0214c2d4d 100644
> --- a/lib/dump_stack.c
> +++ b/lib/dump_stack.c
> @@ -45,13 +52,14 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
>   */
>  void dump_stack_print_info(const char *log_lvl)
>  {
> -	printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s\n",
> +	printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s" BUILD_ID_STR "\n",
>  	       log_lvl, raw_smp_processor_id(), current->pid, current->comm,
>  	       kexec_crash_loaded() ? "Kdump: loaded " : "",
>  	       print_tainted(),
>  	       init_utsname()->release,
>  	       (int)strcspn(init_utsname()->version, " "),
> -	       init_utsname()->version);
> +	       init_utsname()->version,
> +	       IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) ? vmlinux_build_id : "");

I get the following warning when CONFIG_STACKTRACE_BUILD_ID is not
enabled:

  CC      lib/dump_stack.o
lib/dump_stack.c: In function ‘dump_stack_print_info’:
lib/dump_stack.c:62:67: warning: pointer type mismatch in conditional expression
         IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) ? vmlinux_build_id : "");
                                                                   ^
lib/dump_stack.c:55:9: warning: format ‘%s’ expects argument of type ‘char *’, but argument 11 has type ‘void *’ [-Wformat=]
  printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s" BUILD_ID_STR "\n",
         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/dump_stack.c:43:24: note: format string is defined here
 #define BUILD_ID_STR "%s"
                       ~^
                       %p

and this when the options is enabled:

  CC      lib/dump_stack.o
lib/dump_stack.c: In function ‘dump_stack_print_info’:
lib/dump_stack.c:62:67: warning: pointer type mismatch in conditional expression
         IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID) ? vmlinux_build_id : "");


I think that you need to use something like:

#ifdef CONFIG_STACKTRACE_BUILD_ID
#define BUILD_ID_FTM " %20phN"
#define BUILD_ID_VAL vmlinux_build_id
#else
#define BUILD_ID_FTM "%s"
#define BUILD_ID_VAL ""
#endif

	printk("%sCPU: %d PID: %d Comm: %.20s %s%s %s %.*s" BUILD_ID_FTM "\n",
	       log_lvl, raw_smp_processor_id(), current->pid, current->comm,
	       kexec_crash_loaded() ? "Kdump: loaded " : "",
	       print_tainted(),
	       init_utsname()->release,
	       (int)strcspn(init_utsname()->version, " "),
	       init_utsname()->version,
	       BUILD_ID_VAL);


Best Regards,
Petr
