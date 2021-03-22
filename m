Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01EF344821
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhCVOvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:51:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:49868 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230140AbhCVOti (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616424576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3DbpKA9OBqO3XfNQwyv7fij4KDSvOgOatNqN0b+8D2c=;
        b=Yj7L9okmiPiykV9gepg/YwHFiQBflhdBjAdWcshdxGrsE9gOabJ/wSuLLLUQbrMjdyoXc9
        zrlp9eCXwWiGSLUjtNN8kzjEogYFBwcz093bHrtf0OMgvMtn8SeLDq1GLjte9QMYTiZqHc
        alVSDXlO8/gojufz/K0Q0DA3LNFghSA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8655AC1F;
        Mon, 22 Mar 2021 14:49:35 +0000 (UTC)
Date:   Mon, 22 Mar 2021 15:49:35 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v1 1/3] printk: track/limit recursion
Message-ID: <YFiuf/Kn9iLOwgNx@alley>
References: <20210316233326.10778-1-john.ogness@linutronix.de>
 <20210316233326.10778-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316233326.10778-2-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2021-03-17 00:33:24, John Ogness wrote:
> Track printk() recursion and limit it to 3 levels per-CPU and per-context.

Please, explain why it is added. I mean that it will
allow remove printk_safe that provides recursion protection at the
moment.

> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 80 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 77 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 2f829fbf0a13..c666e3e43f0c 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1940,6 +1940,71 @@ static void call_console_drivers(const char *ext_text, size_t ext_len,
>  	}
>  }
>  
> +/*
> + * Recursion is tracked separately on each CPU. If NMIs are supported, an
> + * additional NMI context per CPU is also separately tracked. Until per-CPU
> + * is available, a separate "early tracking" is performed.
> + */
> +#ifdef CONFIG_PRINTK_NMI

CONFIG_PRINTK_NMI is a shortcut for CONFIG_PRINTK && CONFIG_HAVE_NMI.
It should be possible to use CONFIG_HAVE_NMI here because this should
be in section where CONFIG_PRINTK is defined.

This would make sense if it allows to remove CONFIG_PRINTK_NMI
entirely. IMHO, it would be nice to remove one layer in the
config options of possible.


> +#define PRINTK_CTX_NUM 2
> +#else
> +#define PRINTK_CTX_NUM 1
> +#endif
> +static DEFINE_PER_CPU(char [PRINTK_CTX_NUM], printk_count);
> +static char printk_count_early[PRINTK_CTX_NUM];
> +
> +/*
> + * Recursion is limited to keep the output sane. printk() should not require
> + * more than 1 level of recursion (allowing, for example, printk() to trigger
> + * a WARN), but a higher value is used in case some printk-internal errors
> + * exist, such as the ringbuffer validation checks failing.
> + */
> +#define PRINTK_MAX_RECURSION 3
> +
> +/* Return a pointer to the dedicated counter for the CPU+context of the caller. */
> +static char *printk_recursion_counter(void)
> +{
> +	int ctx = 0;
> +
> +#ifdef CONFIG_PRINTK_NMI
> +	if (in_nmi())
> +		ctx = 1;
> +#endif
> +	if (!printk_percpu_data_ready())
> +		return &printk_count_early[ctx];
> +	return &((*this_cpu_ptr(&printk_count))[ctx]);
> +}

It is not a big deal. But using an array for two contexts looks strange
especially when only one is used on some architectures.
Also &((*this_cpu_ptr(&printk_count))[ctx]) is quite tricky ;-)

What do you think about the following, please?

static DEFINE_PER_CPU(u8 printk_count);
static u8 printk_count_early;

#ifdef CONFIG_HAVE_NMI
static DEFINE_PER_CPU(u8 printk_count_nmi);
static u8 printk_count_nmi_early;
#endif

static u8 *printk_recursion_counter(void)
{
	if (IS_ENABLED(CONFIG_HAVE_NMI) && in_nmi()) {
		if (printk_cpu_data_ready())
			return this_cpu_ptr(&printk_count_nmi);
		return printk_count_nmi_early;
	}

	if (printk_cpu_data_ready())
		return this_cpu_ptr(&printk_count);
	return printk_count_early;
}


Otherwise, it looks good to me. I like the simplicity.

Best Regards,
Petr
