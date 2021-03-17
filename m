Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6958933F7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 18:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhCQR4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 13:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhCQR4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 13:56:14 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29E9C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 10:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=JD6DfhzlxHt/W60lBWVJyFcG2x+gwqEVVkFJO6VU0UI=; b=ICdCW1pjIhVGB7eUY6NwQVxOts
        syJUF0IVcJgd9GU0rJR9cc5eHqr1mJx0z7RnHUviicGAc9+QI/n4wg3BhGVxp7zbf0emKOvcx7YJS
        +u7tpJIQPtf2douFe4T29zbVID9/IfBd8cNMly2NaW2S1G7dU0Pbijj2JsFun0EMSFm0FZSf8R+vw
        p4pZrrz5DPRd5h5mJqcJncHleCWIrbLqZhi0tJQ+1R+VbgFd0RdOmX58jp2N/6K2v3nJzdrCc6R18
        wVQMb70u86NmCWZINEGBx2WuEr6Jg5V7wO3zak+tOJqpF8nEWlYJdvIuRJilAMnlOjb2VZdsLtQKn
        8FRvXzmg==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMaOt-001fgJ-3Y; Wed, 17 Mar 2021 17:56:07 +0000
Subject: Re: [PATCH] powerpc: kernel: Trivial typo fix in the file kgdb.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, jniethe5@gmail.com,
        alistair@popple.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20210317090413.120891-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eb64824a-2871-5046-01df-8ffead699e28@infradead.org>
Date:   Wed, 17 Mar 2021 10:56:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317090413.120891-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 2:04 AM, Bhaskar Chowdhury wrote:
> 
> s/procesing/processing/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/powerpc/kernel/kgdb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 409080208a6c..7dd2ad3603ad 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -376,7 +376,7 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc)
>  }
> 
>  /*
> - * This function does PowerPC specific procesing for interfacing to gdb.
> + * This function does PowerPC specific processing for interfacing to gdb.
>   */
>  int kgdb_arch_handle_exception(int vector, int signo, int err_code,
>  			       char *remcom_in_buffer, char *remcom_out_buffer,
> --


-- 
~Randy

