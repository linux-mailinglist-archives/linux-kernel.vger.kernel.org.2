Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D90CB336F3C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbhCKJuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:50:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232124AbhCKJu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:50:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDD2664D74;
        Thu, 11 Mar 2021 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615456225;
        bh=zh1VvqMlh+EveUf6JHW7TjAWB/CFqYj4bN/4N9pUf3I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qYTnl710VGwg4cp/N9a00zuwtMl4msfUznkhlFSRJepw9i8o8+/x/dh7miXhggqhu
         vH+u8/GX9XZyG1eMb93AYRUJhTFY47ALyDKl+FcK/uBmRLokk11TubZX5OH/93+h1I
         uB/ijF3BT7tyrlIhL+X6PSIk67Kz+hlfi+MSKnueWsDWdIHgNwgfDxSg8HnXPliJ81
         Nsd5TC9Re3AYcR/sFtSzV0VWvhmiDuNEnsc/2WGoKrWj1htDVoAzXSwNTFmgtXm/dy
         Z0vclRdkA1Gkug091rsSIfHLW8Yg0IceC3XpFKKBKnlzrWcPGlUVW0sJ6Ebbbjm7lG
         Lgm8JChQx97xw==
Date:   Thu, 11 Mar 2021 18:50:21 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Cao jin <jojing64@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        akpm@linux-foundation.org, rostedt@goodmis.org,
        keescook@chromium.org, vbabka@suse.cz
Subject: Re: [PATCH] bootconfig: Update prototype of setup_boot_config()
Message-Id: <20210311185021.cd7a42057c8500755e3732a7@kernel.org>
In-Reply-To: <20210311085213.27680-1-jojing64@gmail.com>
References: <20210311085213.27680-1-jojing64@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 16:52:13 +0800
Cao jin <jojing64@gmail.com> wrote:

> Parameter "cmdline" has no use, drop it.

OK, this looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Cao jin <jojing64@gmail.com>
> ---
>  init/main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index c68d784376ca..621a11ed18fb 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -404,7 +404,7 @@ static int __init bootconfig_params(char *param, char *val,
>  	return 0;
>  }
>  
> -static void __init setup_boot_config(const char *cmdline)
> +static void __init setup_boot_config(void)
>  {
>  	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
>  	const char *msg;
> @@ -471,7 +471,7 @@ static void __init setup_boot_config(const char *cmdline)
>  
>  #else
>  
> -static void __init setup_boot_config(const char *cmdline)
> +static void __init setup_boot_config(void)
>  {
>  	/* Remove bootconfig data from initrd */
>  	get_boot_config_from_initrd(NULL, NULL);
> @@ -869,7 +869,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
>  	pr_notice("%s", linux_banner);
>  	early_security_init();
>  	setup_arch(&command_line);
> -	setup_boot_config(command_line);
> +	setup_boot_config();
>  	setup_command_line(command_line);
>  	setup_nr_cpu_ids();
>  	setup_per_cpu_areas();
> -- 
> 2.29.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
