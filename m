Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0FC3E17F1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242419AbhHEP0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:26:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241999AbhHEPXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628176948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IA+4RKTutjjT6+xBdUuRMt2F0gxJTqOfA9zYLfjJZAA=;
        b=bKlbWWDp2glMv7wXozTJJrwfGG9xGu//SZUs/eK5xxJ48q8olGidk4LXoC6Woc+fMBb/bx
        hOB/GOavbj4wdDKThdlvgnONCdVpV8umd7cYndp+AYTSZBXWjd8V0Vlc3iH9etMNwoBJUU
        Z3Wyu0nc/cj0122l2SP+pWozLjkhnHU=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-_VhDmdr2OwaG4GL2MLcMUg-1; Thu, 05 Aug 2021 11:22:27 -0400
X-MC-Unique: _VhDmdr2OwaG4GL2MLcMUg-1
Received: by mail-il1-f200.google.com with SMTP id x16-20020a9206100000b02902166568c213so2917909ilg.22
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 08:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IA+4RKTutjjT6+xBdUuRMt2F0gxJTqOfA9zYLfjJZAA=;
        b=Yhr5sLwPa5I6GKl5zJJSCTVMjrHI60aLU2xoiTFlpyzuYnpvbwvWkI/QM35xb9zeqT
         sUhCJjdLx1K5PKM4zQtvJkBL+ILWkbELSaSsl/9dhPQc7KI7ZnG4Ue93xfwFvuQajxgP
         BhMixlnsFNOavbDuD7eqEmBqBx+RGImBxQHk6z0fXVNivTy1TSYlmUS/4fnvwAytiaNj
         X/X8VNITbmHohU2kuYoOhze4jwdIIISJtIbGbRGeSD7UL/D63F70kMxreknvV+dNGKy1
         CMkDO+iROFqj5qSKvR/B2VrtGtyEgHwbu/eX+5omXmTRQm9lReVKMBV26utFpiX6xKb/
         qysg==
X-Gm-Message-State: AOAM532hqpUh7TUoexCz2cS7KKlIiQ1WDqcFae29aMjnxaWUr5a6YFSt
        P9nqKNv1q6PA1+6k6j318rPz+Aip8MVd8+q4qz8283LwJgdd79xpH0kcAQvbhEAkPYIuXtMY/zY
        QNtqPY3Y5y2EVfLkh6g/jKpI5
X-Received: by 2002:a92:511:: with SMTP id q17mr602621ile.210.1628176946990;
        Thu, 05 Aug 2021 08:22:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGGzMlWpM0e/XOhmB/Iwqo8wbB4kISf21qWti3r2z91V/VcHNxe+6h6QNzr2uePygtr5DyJw==
X-Received: by 2002:a92:511:: with SMTP id q17mr602612ile.210.1628176946821;
        Thu, 05 Aug 2021 08:22:26 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id v14sm1516182ilh.54.2021.08.05.08.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 08:22:25 -0700 (PDT)
Date:   Thu, 5 Aug 2021 10:22:21 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] init: Suppress wrong warning for bootconfig cmdline
 parameter
Message-ID: <20210805152221.33ssjh6qvgbj2pt5@halaneylaptop>
References: <162812945097.77369.1849780946468010448.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162812945097.77369.1849780946468010448.stgit@devnote2>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 11:10:51AM +0900, Masami Hiramatsu wrote:
> Since the 'bootconfig' command line parameter is handled before
> parsing the command line, it doesn't use early_param(). But in
> this case, kernel shows a wrong warning message about it.
> 
> [    0.013714] Kernel command line: ro console=ttyS0  bootconfig console=tty0
> [    0.013741] Unknown command line parameters: bootconfig
> 
> To suppress this message, add a dummy handler for 'bootconfig'.
> 
> Fixes: 86d1919a4fb0 ("init: print out unknown kernel parameters")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  init/main.c |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index f5b8246e8aa1..8d97aba78c3a 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -397,6 +397,12 @@ static int __init bootconfig_params(char *param, char *val,
>  	return 0;
>  }
>  
> +static int __init warn_bootconfig(char *str)
> +{
> +	/* The 'bootconfig' has been handled by bootconfig_params(). */
> +	return 0;
> +}
> +
>  static void __init setup_boot_config(void)
>  {
>  	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
> @@ -475,9 +481,8 @@ static int __init warn_bootconfig(char *str)
>  	pr_warn("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOT_CONFIG is not set.\n");
>  	return 0;
>  }
> -early_param("bootconfig", warn_bootconfig);
> -
>  #endif
> +early_param("bootconfig", warn_bootconfig);
>  
>  /* Change NUL term back to "=", to make "param" the whole string. */
>  static void __init repair_env_string(char *param, char *val)
> 

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

Thanks Masami, this is one of the corner case command line parameters
that I was trying to highlight when I made the original commit (but I
didn't catch this one).

I _think_ the only other one is dyndbg based on some grepping. I'm
debating if it makes sense to do something similar there or to actually
use a callback to do some of the work it needs in stealing from the CLI.

For this case though I don't see how you could do anything other than
what you've done here -- you can't modify the params once we've started
processing, and that's what bootconfig needs to do.

Thanks,
Andrew

