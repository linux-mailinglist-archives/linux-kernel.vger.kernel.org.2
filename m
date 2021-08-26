Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892943F8A16
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 16:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242864AbhHZO2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 10:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242737AbhHZO2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:28:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7E9060F58;
        Thu, 26 Aug 2021 14:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629988073;
        bh=rmgSFvnVYQ6/fJk/PtsVp+kA+k9vpwcUD6eCn4s7mIQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=j8ewU2LQwOArbyRke6JdGC59MsfDGPcODk9CvQcMJbPROwrJMJfDx258QD13koStV
         Qfk/+SJL/EcpMhhtJM8juOO1hP8rfYrxZch/8PdwffXEjtt3WDe81dswrxFV/ORF3g
         QOWQQ3QPk761VateDMtuMbtocfLXoptH9gepjlJ3qYnLzxuDOAXrKZRZ81VcaQwZXr
         smfw6zAdSe0n2KFn0IQMZri06hym3j8yvhPrauc5+DrYLE3cFGJDS+0QYEYMkiEjOj
         /3h7dOXtfe2bS7xTUEHwjGGw9UQ364vEvUMQZcu3xqst/bYTMapfrYb4feQZx93e6X
         BaVjrDzEKRlFQ==
Date:   Thu, 26 Aug 2021 23:27:51 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] init: bootconfig: Remove all bootconfig data when
 the init memory is removed
Message-Id: <20210826232751.614f9be6c5ea0a48c5cebd04@kernel.org>
In-Reply-To: <162996912688.236535.4047855429538984099.stgit@devnote2>
References: <162996911932.236535.7533708592332223449.stgit@devnote2>
        <162996912688.236535.4047855429538984099.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2021 18:12:07 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Since the bootconfig is used only in the init functions,
> it doesn't need to keep the data after boot. Free it when
> the init memory is removed.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  init/main.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/init/main.c b/init/main.c
> index 8d97aba78c3a..d9b0a99bb2dd 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1493,6 +1493,7 @@ static int __ref kernel_init(void *unused)
>  	kprobe_free_init_mem();
>  	ftrace_free_init_mem();
>  	kgdb_free_init_mem();
> +	xbc_destroy_all();

Oops, xbc_destroy_all() is not defined if CONFIG_BOOT_CONFIG=n.
Let me fix that.

Thanks,

>  	free_initmem();
>  	mark_readonly();
>  
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
