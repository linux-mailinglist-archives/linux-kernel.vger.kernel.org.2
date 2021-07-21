Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFFB3D119C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 16:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239274AbhGUOFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 10:05:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57662 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbhGUOFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 10:05:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7FB702255F;
        Wed, 21 Jul 2021 14:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626878781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GKBbRf6M5YRpXhRu4kWBBslSOKw3EM2yD26p1YHSL1g=;
        b=Qw4qDueueWpWmpsvX1l2RGTlFdu9jNaZLYPSfsfOwMnHO2W//fPPyh24R3vXbZFKdj6Fbl
        KK141wzLn9oFsgrz1cwnIwmZn5iOicYNFZ3d6+vVoAwubILbrEJQZ1T/H1CvGKAKPQ9Eo6
        9P1ob9tEcUHAc8XsEN0bWhrVVTW0rS0=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 330B1A3B92;
        Wed, 21 Jul 2021 14:46:21 +0000 (UTC)
Date:   Wed, 21 Jul 2021 16:46:21 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/2] printk: Add printk.console_verbose boot parameter
Message-ID: <20210721144621.ddvxouzxpp6sn4ec@pathway.suse.cz>
References: <20210713011511.215808-1-dima@arista.com>
 <20210713011511.215808-3-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713011511.215808-3-dima@arista.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-07-13 02:15:11, Dmitry Safonov wrote:
> console_verbose() increases console loglevel to CONSOLE_LOGLEVEL_MOTORMOUTH,
> which provides more information to debug a panic/oops.
> 
> Unfortunately, in Arista we maintain some DUTs (Device Under Test) that
> are configured to have 9600 baud rate. While verbose console messages
> have their value to post-analyze crashes, on such setup they:
> - may prevent panic/oops messages being printed
> - take too long to flush on console resulting in watchdog reboot
> 
> In all our setups we use kdump which saves dmesg buffer after panic,
> so in reality those extra messages on console provide no additional value,
> but rather add risk of not getting to __crash_kexec().

Yup, it makes sense.

> Provide printk.console_verbose boot parameter, which allows to switch off
> printk being verbose on oops/panic/lockdep (making it boot parameter
> instead of compile-option suggested-by Petr).
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 9 +++++++++
>  include/linux/printk.h                          | 4 +++-
>  kernel/printk/printk.c                          | 6 ++++++
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index bdb22006f713..9fae19b1edd8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4167,6 +4167,15 @@
>  			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
>  			default: disabled
>  
> +	printk.console_verbose=
> +			Raise console loglevel to highest on oops, panic or
> +			lockdep-detected issues (only if lock debug is on).
> +			With an exception to setups with low baudrate on
> +			serial console, keeping this enabled is a good choice
> +			in order to provide more debug information.
> +			Format: <bool>  (1/Y/y=enable, 0/N/n=disable)
> +			default: enabled

Hmm, the name suggests that the console should always be verbose.
It looks like a counterpart to the "quiet" option.

It actually is a counter part to the existing "quiet" option
except that it triggers in some situations only.

Hence, I would call it "no_auto_verbose":

   + "verbose" follows the simple naming scheme of the existing
     "quiet" option (no "printk" and no "console" in the name)

   + "no_auto" suggests that it disables some auto-verbose behavior
     which is exactly what it does.

Any better idea?

> +
>  	printk.devkmsg={on,off,ratelimit}
>  			Control writing to /dev/kmsg.
>  			on - unlimited logging to /dev/kmsg from userspace
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index a63f468a8239..9d0b8133a03c 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -70,9 +70,11 @@ extern int console_printk[];
>  #define minimum_console_loglevel (console_printk[2])
>  #define default_console_loglevel (console_printk[3])
>  
> +extern bool printk_console_verbose;
> +
>  static inline void console_verbose(void)
>  {
> -	if (console_loglevel)
> +	if (console_loglevel && printk_console_verbose)
>  		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
>  }
>  
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 142a58d124d9..e321ee78855d 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2404,6 +2404,12 @@ module_param_named(console_suspend, console_suspend_enabled,
>  MODULE_PARM_DESC(console_suspend, "suspend console during suspend"
>  	" and hibernate operations");
>  
> +bool printk_console_verbose = true;

I would call it "console_auto_verbose".

> +EXPORT_SYMBOL(printk_console_verbose);

I would prefer to move console_verbose() into printk.c
and export the function instead of this variable.

> +module_param_named(console_verbose, printk_console_verbose, bool, 0644);
> +MODULE_PARM_DESC(console_verbose, "Raise console loglevel to highest on oops/panic/etc");

Best Regards,
Petr
