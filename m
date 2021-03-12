Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 903FD3393C3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbhCLQmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232880AbhCLQle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:41:34 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D302AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 08:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=NjO5e3NHxlfLBPFzxRL/627oFgY8z8FkhHekhopo2VY=; b=dY53Jxah5kMEb2PGNAmWb0SzKP
        gZ0ZjGbQwOxh/bpVmAx0Vu0XmnCsOOhiybXokrnaVeDkmC1EqHpqEElhZd5QCWdSUToD8/pVJJ32T
        SuYfuBbNMr6cD/oqhG/gjshO16+NnhL7e7+5+Yrq3BdOpfWmzslhQKR/8XMiXQOrp5ns+9uTAxjY3
        VDUYwmLZagGQWSWBinh+x2Eg1RqPt0AUFUlDl6vW7LRwKs1kGlnuYdZ6HPLGR1SK2xmjJsA9+q6EW
        C5m8KKIfgnFAUtPTSVjedpd6NdQWkbzhcMSD5g7FtsJUZz2dV37cHHuPv7rvhP4mtr/GSVpawhaiE
        MqpDf43Q==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKkqv-0014IL-Um; Fri, 12 Mar 2021 16:41:30 +0000
Subject: Re: [PATCH] powerpc: mm: book3s64: Fix a typo in the file
 mmu_context.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20210312112537.4585-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7a2b6ee3-33cf-00a3-fb5c-f8bcf404f29c@infradead.org>
Date:   Fri, 12 Mar 2021 08:41:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210312112537.4585-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/21 3:25 AM, Bhaskar Chowdhury wrote:
> 
> s/detalis/details/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/powerpc/mm/book3s64/mmu_context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/mmu_context.c b/arch/powerpc/mm/book3s64/mmu_context.c
> index 0c8557220ae2..c10fc8a72fb3 100644
> --- a/arch/powerpc/mm/book3s64/mmu_context.c
> +++ b/arch/powerpc/mm/book3s64/mmu_context.c
> @@ -119,7 +119,7 @@ static int hash__init_new_context(struct mm_struct *mm)
>  		/* This is fork. Copy hash_context details from current->mm */
>  		memcpy(mm->context.hash_context, current->mm->context.hash_context, sizeof(struct hash_mm_context));
>  #ifdef CONFIG_PPC_SUBPAGE_PROT
> -		/* inherit subpage prot detalis if we have one. */
> +		/* inherit subpage prot details if we have one. */
>  		if (current->mm->context.hash_context->spt) {
>  			mm->context.hash_context->spt = kmalloc(sizeof(struct subpage_prot_table),
>  								GFP_KERNEL);
> --


-- 
~Randy

