Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CCA340CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhCRSVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbhCRSV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:21:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F395C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=1fIw1IgvOl24l4m8f/gEO0YRNbX9Gkq8Y62gf03c89g=; b=eL4oAaAXCABdvFm15nw0+eHRVn
        kaEyQIX1+V81BfF5/upqEDsRFk5ePkyqD8ZMkHw9BSI7yTZ71d8xGiXMgH9qhVWJ8zehLpHX06jLP
        E7a+FRX5+cWkRz30cVZ/Eh/vfSAx1kt6G8d5T6vd2mNrO2IXSKv1NwWGBrpwUXCZcH+rMUPgogzKJ
        l/LaAfl7vmw06ilJZay2Cb6DP5rmEZLztubeVcYUD+V5e0r7248wWpFoJ3k3Y4meUVbh343mN8CJq
        yCkRMv/4v1zX4rMMJK4TxsAJcElHDoyikA5B43wnneYPd2kSLSeF4sAKn9BPpxRi4tQ39wKx+OBKy
        gvX3hODg==;
Received: from [2601:1c0:6280:3f0::9757]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMxGZ-003LLH-BB; Thu, 18 Mar 2021 18:21:07 +0000
Subject: Re: [PATCH] x86/mm: Fixed couple of typos
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
References: <20210318064751.19226-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <50c0a512-2af0-efdf-fa77-93e3695febaa@infradead.org>
Date:   Thu, 18 Mar 2021 11:20:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210318064751.19226-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/21 11:47 PM, Bhaskar Chowdhury wrote:
> 
> s/compied/compiled/
> s/preseve/preserve/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/x86/mm/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index dd694fb93916..0212e831d388 100644
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
> @@ -756,7 +756,7 @@ void __init init_mem_mapping(void)
> 
>  #ifdef CONFIG_X86_64
>  	if (max_pfn > max_low_pfn) {
> -		/* can we preseve max_low_pfn ?*/
> +		/* can we preserve max_low_pfn ?*/
>  		max_low_pfn = max_pfn;
>  	}
>  #else
> --


-- 
~Randy

