Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9884530CE39
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 22:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhBBVxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 16:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbhBBVw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 16:52:59 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036BBC061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 13:52:19 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id z21so15814825pgj.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 13:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3AmuxU7ywET2oWhQ7TVzCDQ74ODSudJlgeUAo7patck=;
        b=FNR5fqRzqyhtvwocB+X4kQzgidtUnariiCXEH94qfOFqYFzWJqpEIMD1TPblypPxU/
         E6tT4HpAeTcwc4M/2+xr5zw2QeD6xIYAkKGypOCrnmqTtKs++mVzLncKGNbyRQP7BQMl
         kh1bPcPDrgE8rEH5ZUQfirHEOYAbRWl16wP5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3AmuxU7ywET2oWhQ7TVzCDQ74ODSudJlgeUAo7patck=;
        b=B8/k8BPZbkgPTYZ1wJhtmF43jxzF+pIdzf9ryzyvr7m2DMyzOdmaWLvzU11oP4+hCc
         w68lX9npldsUeKysniXILpc/+gfq9kvCXxhZ3bjKbF5S9Xn4BhTF069+nTw0Mh58ZusO
         KoFtfpqz6Tj9s9sMtcr9qTGCz73l0tPueCBvYhQnfIg0zseoDA7/dVJkYQbsSfcM7yYt
         Clz/JytZ2FGR3heZxbU/NeCo+HhLpUcfSTI7d/8KZicjAVpgsClvIdoaTY5G2aVDWoUy
         9Iex9WdmXcZW1+fjOWZ1FBNnqTvYozgsMx2gUrHC4eexvLUkDwR6+HLskYXWNENbwHKd
         vsuw==
X-Gm-Message-State: AOAM532C7fMpT66JCD+0iwNeTi91CFHQvOst/kgK3GRi0up3DQnPjELm
        FJP/08iqtO1FS8uYXmQ6nq15zg==
X-Google-Smtp-Source: ABdhPJzvZOYbm8y5fAyTH74CGl9GPQb22ScyZeyUe5QXZKjQkqKn7bw1QDYEqg0aZjux0FutxpcQ5g==
X-Received: by 2002:a05:6a00:2ac:b029:1cb:7775:4b1e with SMTP id q12-20020a056a0002acb02901cb77754b1emr16911126pfs.25.1612302738554;
        Tue, 02 Feb 2021 13:52:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z21sm17952437pgk.15.2021.02.02.13.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 13:52:17 -0800 (PST)
Date:   Tue, 2 Feb 2021 13:52:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Timur Tabi <timur@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        john.ogness@linutronix.de, akinobu.mita@gmail.com
Subject: Re: [PATCH] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <202102021351.AEDE896AB3@keescook>
References: <20210202201846.716915-1-timur@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202201846.716915-1-timur@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 02:18:46PM -0600, Timur Tabi wrote:
> If the make-printk-non-secret command-line parameter is set, then
> printk("%p") will print addresses as unhashed.  This is useful for
> debugging purposes.
> 
> A large warning message is displayed if this option is enabled,
> because unhashed addresses, while useful for debugging, exposes
> kernel addresses which can be a security risk.

Linus has expressly said "no" to things like this in the past:
https://lore.kernel.org/lkml/CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com/

-Kees

> 
> Signed-off-by: Timur Tabi <timur@kernel.org>
> ---
>  lib/vsprintf.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
> 
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
> +	pr_warn("**                                                      **\n");
> +	pr_warn("**   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **\n");
> +	pr_warn("**********************************************************\n");
> +	return 0;
> +}
> +early_param("make-printk-non-secret", debug_never_hash_pointers_enable);
> +
>  /*
>   * Show a '%p' thing.  A kernel extension is that the '%p' is followed
>   * by an extra set of alphanumeric characters that are extended format
> @@ -2297,8 +2321,14 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>  		}
>  	}
>  
> -	/* default is to _not_ leak addresses, hash before printing */
> -	return ptr_to_id(buf, end, ptr, spec);
> +	/*
> +	 * default is to _not_ leak addresses, so hash before printing, unless
> +	 * make-printk-non-secret is specified on the command line.
> +	 */
> +	if (unlikely(debug_never_hash_pointers))
> +		return pointer_string(buf, end, ptr, spec);
> +	else
> +		return ptr_to_id(buf, end, ptr, spec);
>  }
>  
>  /*
> -- 
> 2.25.1
> 

-- 
Kees Cook
