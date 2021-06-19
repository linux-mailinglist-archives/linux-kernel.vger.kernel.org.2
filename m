Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C87FB3ADBC6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 23:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhFSVYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 17:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhFSVYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 17:24:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3233AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 14:22:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624137728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ybseCEkhglvLk2wB5sT0IQom10HeFQDbBrMQNfSpj8=;
        b=iAS4hSTPbS2YBOU0uE2wcVmpF8YZDHkv5C91bMpAO+xqFwzXIAe2DB44pbCYkDNfK3EjZ2
        OSfkvildHF8YTaGeVyGp6GuqaUThT1+EHjraXBOQayV2NVofUMJqgXcVp7RrO3knrLtX1+
        lxGgLo3NJR1oouVPu9OFVv/Ehoz9p2HdPx2UL+jw6sYWAsThyYCqMSSFPMJe4SamDy7/7V
        4rjC1f9JBRuR33fkx5fyYQn55+lsC1BOvgKFjBgc4+uZcg7PJJAtPzuL6O5YsCntPTuQ1e
        KO5qA8dxWAbebuByPto+40dVvuUS152XBVJP9Bc8Uwigesn+S/8QtkqleQYmeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624137728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ybseCEkhglvLk2wB5sT0IQom10HeFQDbBrMQNfSpj8=;
        b=wZ753qjYKTra1pYAwCU2clzEncUViMNWdUNGfpgY3njrQKYqwQCfcTBfBZa2qPjRpotjWJ
        8n1Ke6Qij7wCyADQ==
To:     Yaohui Wang <yaohuiwang@linux.alibaba.com>,
        dave.hansen@linux.intel.com
Cc:     luto@kernel.org, peterz@infradead.org, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, linux-kernel@vger.kernel.org,
        Ben Luo <luoben@linux.alibaba.com>,
        Yahui Wang <yaohuiwang@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] mm: fix the pfn calculation mistake in __ioremap_check_ram
In-Reply-To: <20210611042147.80744-2-yaohuiwang@linux.alibaba.com>
References: <20210611042147.80744-1-yaohuiwang@linux.alibaba.com> <20210611042147.80744-2-yaohuiwang@linux.alibaba.com>
Date:   Sat, 19 Jun 2021 23:22:08 +0200
Message-ID: <87r1gxh7nj.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yaohui!

On Fri, Jun 11 2021 at 12:21, Yaohui Wang wrote:

A few formal things upfront. The prefix of the subject is incorrect. It
should be "x86/ioremap:" git log $FILE helps to figure that out.

Looking at the Signed-off-by chain below this misses either a

From: Ben Luo <luoben@linux.alibaba.com> 

right at the top of the changelog or a Co-Developed-by tag. See
Documentation/process/

> In arch/x86/mm/ioremap.c:__ioremap_check_ram, the original pfn
> wrapping

Just "In __ioremap_check_ram() ..." please. The file name is
uninteresting and we want the '()' at the end of the symbol so it's
obvious that this is a function.

> calculation may cause the pfn range to ignore the very start page, if
> res->start is not page-aligned, or the very end page, if res->end is not
> page aligned.
>
> So start_pfn should wrap down the res->start address, and end_pfn should
> wrap up the res->end address. This makes the pfn range completely
> contain [res->start, res->end] ram range. This check is more strict and is
> more reasonable.

This lacks a "Fixes:" tag

> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
> Signed-off-by: Yahui Wang <yaohuiwang@linux.alibaba.com>
> ---
>  arch/x86/mm/ioremap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 9e5ccc56f..79adf0d2d 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -74,8 +74,8 @@ static unsigned int __ioremap_check_ram(struct resource *res)
>  	if ((res->flags & IORESOURCE_SYSTEM_RAM) != IORESOURCE_SYSTEM_RAM)
>  		return 0;
>  
> -	start_pfn = (res->start + PAGE_SIZE - 1) >> PAGE_SHIFT;
> -	stop_pfn = (res->end + 1) >> PAGE_SHIFT;
> +	start_pfn = res->start >> PAGE_SHIFT;
> +	stop_pfn = (res->end + PAGE_SIZE) >> PAGE_SHIFT;

Please make that:

       start_pfn = PFN_DOWN(res->start);
       stop_pfn = PFN_UP(res->end);

which gives you the first and the last PFN of that range. That obviously
requires to fix the below as well, but that code is unreadable anyway.

>  	if (stop_pfn > start_pfn) {
>  		for (i = 0; i < (stop_pfn - start_pfn); ++i)
>  			if (pfn_valid(start_pfn + i) &&

	npages = stop_pfn - start_pfn + 1;
	for (i = 0; i < npages; i++) {
       		if (.....)
        }

you get the idea, right?

Thanks,

        tglx
