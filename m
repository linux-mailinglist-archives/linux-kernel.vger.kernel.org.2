Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F08347FE1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbhCXR4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237051AbhCXR4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:56:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8510C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=ZhZASYSbguhCr5yST07GdMHOQuGtuk0NO9ceFH0Jslk=; b=SAlKvzc+TbZ3sfI+BUu0nQsRrl
        YCsIvTuyiKSv5WWo9NwN/4Fr+lGTU4UcakYnRRpBLEC7gQ6x1kU//70Z36LyykAIg05bgH+heNnaA
        bFCPZUPxgUpW5/GgEfAZBsZ8tC14Z+RhaCETkN2w7xADWbJs3PLE+UIvBz5o3OnBqpOzO+gWqivNk
        vd7TYNbXpyLqbq/p+163F+aRbAUq63Qh8ZpncCNicxarqOpYubLMo11aXlkFP4Dv8audL3cYkxrmw
        y4RxiUbfHXVTa5J6WVS6mLUAttPYycKXspVpVMkC1GVvOAogrF5cw3cMrkwsN+fBlqnbM601xhW0S
        mREtpxMw==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP7jh-00Hb6m-Kj; Wed, 24 Mar 2021 17:56:06 +0000
Subject: Re: [PATCH] arc/kernel/signal.c: Fix couple of typos
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, vgupta@synopsys.com,
        axboe@kernel.dk, gustavoars@kernel.org, tglx@linutronix.de,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210324055213.26775-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6bdf8409-48cf-a68d-b4f1-172206753871@infradead.org>
Date:   Wed, 24 Mar 2021 10:56:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324055213.26775-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 10:52 PM, Bhaskar Chowdhury wrote:
> 
> s/unconditonally/unconditionally/
> s/gaurantees/guarantees/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/arc/kernel/signal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
> index a78d8f745a67..cf1788fd3812 100644
> --- a/arch/arc/kernel/signal.c
> +++ b/arch/arc/kernel/signal.c
> @@ -259,7 +259,7 @@ setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
>  		regs->r2 = (unsigned long)&sf->uc;
> 
>  		/*
> -		 * small optim to avoid unconditonally calling do_sigaltstack
> +		 * small optim to avoid unconditionally calling do_sigaltstack
>  		 * in sigreturn path, now that we only have rt_sigreturn
>  		 */
>  		magic = MAGIC_SIGALTSTK;
> @@ -391,7 +391,7 @@ void do_signal(struct pt_regs *regs)
>  void do_notify_resume(struct pt_regs *regs)
>  {
>  	/*
> -	 * ASM glue gaurantees that this is only called when returning to
> +	 * ASM glue guarantees that this is only called when returning to
>  	 * user mode
>  	 */
>  	if (test_thread_flag(TIF_NOTIFY_RESUME))
> --


-- 
~Randy

