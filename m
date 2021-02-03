Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8843C30D6C6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhBCJzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:55:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:39380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233105AbhBCJzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:55:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612346064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W5joaEFyKEmxsNgxXWQzVbFGdC1MUWlZwutGUmy8/jo=;
        b=Czj/9S9jYfh4hGtMrHwynewDHibaO+tpS/h6ERXNMaoz1jYV/uhHFpHE2yDZz6KyMATppF
        NkhjXUqOa0e6u386/k5tHN7+AMLcNBxeH5vlpkQgWDz64rfh2bsevcp4CwgxzQVR5Xib8y
        Be/JT6VIXttyduSzKWy+gH/Dntbt7lY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 203F8AF4C;
        Wed,  3 Feb 2021 09:54:24 +0000 (UTC)
Date:   Wed, 3 Feb 2021 10:54:23 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Timur Tabi <timur@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        akinobu.mita@gmail.com
Subject: Re: [PATCH][RESEND] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <YBpyzxBYIYapHaDT@alley>
References: <20210202213633.755469-1-timur@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202213633.755469-1-timur@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-02-02 15:36:33, Timur Tabi wrote:
> If the make-printk-non-secret command-line parameter is set, then
> printk("%p") will print addresses as unhashed.  This is useful for
> debugging purposes.
> 
> A large warning message is displayed if this option is enabled,
> because unhashed addresses, while useful for debugging, exposes
> kernel addresses which can be a security risk.
> 
> Signed-off-by: Timur Tabi <timur@kernel.org>
> ---
>  lib/vsprintf.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)

Please, add also entry into
Documentation/admin-guide/kernel-parameters.txt.

If we agree that the parameter is acceptable then let's make
it properly.

> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3b53c73580c5..b9f87084afb0 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2090,6 +2090,30 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
>  	return widen_string(buf, buf - buf_start, end, spec);
>  }
>  
> +/* Disable pointer hashing if requested */
> +static bool debug_never_hash_pointers __ro_after_init;
> +
> +static int __init debug_never_hash_pointers_enable(char *str)
> +{
> +	debug_never_hash_pointers = true;
> +	pr_warn("**********************************************************\n");
> +	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> +	pr_warn("**                                                      **\n");
> +	pr_warn("** All pointers that are printed to the console will    **\n");
> +	pr_warn("** be printed as unhashed.                              **\n");
> +	pr_warn("**                                                      **\n");
> +	pr_warn("** Kernel memory addresses are exposed, which may       **\n");
> +	pr_warn("** compromise security on your system.                  **\n");
> +	pr_warn("**                                                      **\n");
> +	pr_warn("** If you see this message and you are not debugging    **\n");
> +	pr_warn("** the kernel, report this immediately to your vendor!  **\n");

It is a boot parameter. So it should be "system administrtor" instead
of vendor.

Otherwise, it looks good to me.

Best Regards,
Petr
