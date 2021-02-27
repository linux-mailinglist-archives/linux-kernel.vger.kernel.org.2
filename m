Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15B24326F7D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 23:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhB0W7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 17:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhB0W7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 17:59:06 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D85C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 14:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=eLlypnALBbOfuw0IVuXZ3OPY4/qiRtCgmsmrREX7Pcs=; b=Escec6Th8qc7ww3pQS0NgLHsCQ
        f3gU7vCgq0yyxAQk/L7qj2Mi68je8GdLgiOy8CXfsPCpriJJ2K2AOpqaKWVdvNUPMu2Vf8nNbbUz7
        M3UHmzwmDu6jWXWSs/ZaifCIwh1MAEmTzHRO7fZeYD0dqRffBv5XLN/LoGIMQc47QlqX+na5Rlstr
        45rhCG0+wUOfE2Z8bKAEnABpU7pSsdQN1A1hM0ZRSKdYBep1dAri6zUr6wtx4/1SrKNEiW/b8bl3l
        bnjtKgQh12snlm2oqa0PcL67zH8JdyP2mmUKZIvudrCuYc4hf2Rm8Aa4FQfaZ953CiutJGIU85Tau
        ayPP0kEQ==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lG8XX-0002Kj-6T; Sat, 27 Feb 2021 22:58:23 +0000
Subject: Re: [PATCH] tools: include: nolibc: Fix a typo occured to occurred in
 the file nolibc.h
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, w@1wt.eu,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     colin.king@canonical.com
References: <20210227224435.21315-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3a9e310f-2a5b-9fc2-cd5a-222e2ed353e4@infradead.org>
Date:   Sat, 27 Feb 2021 14:58:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210227224435.21315-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/21 2:44 PM, Bhaskar Chowdhury wrote:
> 
> s/occured/occurred/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  Stolen result from Colin's finding and share from the other places. :)
> 
>  tools/include/nolibc/nolibc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
> index e61d36cd4e50..fc998c359607 100644
> --- a/tools/include/nolibc/nolibc.h
> +++ b/tools/include/nolibc/nolibc.h
> @@ -1054,7 +1054,7 @@ struct sys_stat_struct {
>   *     scall32-o32.S in the kernel sources.
>   *   - the system call is performed by calling "syscall"
>   *   - syscall return comes in v0, and register a3 needs to be checked to know
> - *     if an error occured, in which case errno is in v0.
> + *     if an error occurred, in which case errno is in v0.
>   *   - the arguments are cast to long and assigned into the target registers
>   *     which are then simply passed as registers to the asm code, so that we
>   *     don't have to experience issues with register constraints.
> --


-- 
~Randy

