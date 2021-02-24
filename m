Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0854B32420F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhBXQZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234002AbhBXQZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:25:43 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF76CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=p1qkrxDjfDnEj5UvJiqqw4roI9nUL2HzQS/jxIkwPFM=; b=tkzNLiWZgK/StBmPaeSAr2Fc4l
        eIsIs2+1RTqaYNadVQkfCEYjpZsA3TbryT0zUsn0mWFMmRzOm1zKKv/j41LXUUpozrqEOSuOALYw4
        KT3ATSmlgVOjWg6PioEnS7oNwFJ6ByU/TUdcLLVdn6gKHJlpF6vkhzk4NxLLSYpAgGd+TZCvupFAv
        UI2KG490XBMWdkgpBi5MyIuBBGSvBFCO8r7aQwIpcdX6EBASEsZRLUvpOujSQ25e7LZSVa27X50jC
        HFm5qRJecux2gtC9WEONcs+uKl7T0/AwkIQUxZlY7e5evXN6kQSvKvf0xptnOGNDMczLwJIr80YPp
        fsSToZHA==;
Received: from [2601:1c0:6280:3f0::d05b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lEwyB-0002vc-Aw; Wed, 24 Feb 2021 16:24:59 +0000
Subject: Re: [PATCH] arch: x86: mm: Fix compied to compiled in the file init.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20210224082942.863874-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <47528e56-bd6b-12a6-8b05-94e8dd4954c4@infradead.org>
Date:   Wed, 24 Feb 2021 08:24:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210224082942.863874-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/21 12:29 AM, Bhaskar Chowdhury wrote:
> 
> s/compied/compiled/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/x86/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index dd694fb93916..34a1f1e19c86 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -29,7 +29,7 @@
> 
>  /*
>   * We need to define the tracepoints somewhere, and tlb.c
> - * is only compied when SMP=y.
> + * is only compiled when SMP=y.
>   */
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/tlb.h>
> --
> 2.30.1
> 


-- 
~Randy

