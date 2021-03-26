Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC73534A32B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 09:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhCZIau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 04:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhCZIaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 04:30:21 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94CCC0613AA;
        Fri, 26 Mar 2021 01:30:19 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id h7so3717447qtx.3;
        Fri, 26 Mar 2021 01:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=ppL7UiNM5EPKfhLUPGFJ4yXtucoRX+YtBylsrtnlBdE=;
        b=di39DjzhlYR8Gjr50cOQwsXXkVS+TpVmYSc3oiiZi1qAHrkuPRLq83UOW3CbD1MhDB
         9z73Ga3AnoKjK8hSmHcRqsnBp3EPbS/CC7JEMh28tjFtdPziTQJBrYgBHPiJJTP906mC
         tENTzbvn1wzwVjkgN+ND9+gOsnxASqMFa3sSfiTzrm7JTaMo1/Y2RBKq/MV/TDV+IheN
         yVYNYQ1P7EKDwOGZEc1VPY93AV7jn/cukQ84O7YLLXreKYghGE+QI8xN6VmNpVzX9v3z
         qJwidjcvS1xNpwkI5lLh+ytUtQG4t3+GPMdhrg8CCM8G/689QwVdErcxRkUXOn0QQ41G
         DpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=ppL7UiNM5EPKfhLUPGFJ4yXtucoRX+YtBylsrtnlBdE=;
        b=pzffE9RBnu6u45SA9t7Tc1NEc2joXqP870/MC1CA4iJy2hIWcG9divyPQK/uxXZz7H
         VIcvZveD0KwhZf/r4Zdpk0g1kkO51aShTX0V+Eziyt0UT1Y/Nrp2jZSCcHPFY8+Djkdd
         GNW3qkGL0UtcxPQJ0f/rr2+MENy4PxdVsra8UIHyDB7ClZ0gT7gnrhzieJ/rCdPuCzce
         AuzYLJD77ODfiGrxgcnZhLU3n8rKsBnI5HyQX8zzzNbLUNemgjQGe46PDY4Yf37ctayh
         h/Pm1X42Suy5xAyEzPAsfVWWZIZpoyAjVlG3uOsGppvWc3HZnuVoCcethlLjYQNq8PIi
         Litw==
X-Gm-Message-State: AOAM530hkQPwFihv9SyqLjXPbq8fmRcvwBIT3TMplpeUwLgNrdkisp6z
        PZkmPbpJ8R2kWh2SkxHJOGI=
X-Google-Smtp-Source: ABdhPJzyC5HVoXZykmjhxQedeg28FjiAzubzL2hZWu6TjP/kcUlHx/xOvjRK851fo9AtTuyZhy8OaA==
X-Received: by 2002:ac8:4d95:: with SMTP id a21mr10933477qtw.304.1616747419130;
        Fri, 26 Mar 2021 01:30:19 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id s28sm6190883qkj.73.2021.03.26.01.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 01:30:18 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     sj38.park@gmail.com
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@Huawei.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendanhiggins@google.com,
        corbet@lwn.net, david@redhat.com, dwmw@amazon.com,
        elver@google.com, fan.du@intel.com, foersleo@amazon.de,
        gthelen@google.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        snu@amazon.de, vbabka@suse.cz, vdavydov.dev@gmail.com,
        zgf574564920@gmail.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        guoju.fgj@alibaba-inc.com
Subject: Re: [PATCH v25 05/13] mm/damon: Implement primitives for the virtual memory address spaces
Date:   Fri, 26 Mar 2021 08:30:06 +0000
Message-Id: <20210326083006.5632-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210318100856.34715-6-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Thu, 18 Mar 2021 10:08:48 +0000 sj38.park@gmail.com wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> This commit introduces a reference implementation of the address space
> specific low level primitives for the virtual address space, so that
> users of DAMON can easily monitor the data accesses on virtual address
> spaces of specific processes by simply configuring the implementation to
> be used by DAMON.
> 
> The low level primitives for the fundamental access monitoring are
> defined in two parts:
> 
> 1. Identification of the monitoring target address range for the address
>    space.
> 2. Access check of specific address range in the target space.
> 
> The reference implementation for the virtual address space does the
> works as below.
> 
> PTE Accessed-bit Based Access Check
> -----------------------------------
> 
> The implementation uses PTE Accessed-bit for basic access checks.  That
> is, it clears the bit for the next sampling target page and checks
> whether it is set again after one sampling period.  This could disturb
> the reclaim logic.  DAMON uses ``PG_idle`` and ``PG_young`` page flags
> to solve the conflict, as Idle page tracking does.
> 
> VMA-based Target Address Range Construction
> -------------------------------------------
> 
> Only small parts in the super-huge virtual address space of the
> processes are mapped to physical memory and accessed.  Thus, tracking
> the unmapped address regions is just wasteful.  However, because DAMON
> can deal with some level of noise using the adaptive regions adjustment
> mechanism, tracking every mapping is not strictly required but could
> even incur a high overhead in some cases.  That said, too huge unmapped
> areas inside the monitoring target should be removed to not take the
> time for the adaptive mechanism.
> 
> For the reason, this implementation converts the complex mappings to
> three distinct regions that cover every mapped area of the address
> space.  Also, the two gaps between the three regions are the two biggest
> unmapped areas in the given address space.  The two biggest unmapped
> areas would be the gap between the heap and the uppermost mmap()-ed
> region, and the gap between the lowermost mmap()-ed region and the stack
> in most of the cases.  Because these gaps are exceptionally huge in
> usual address spaces, excluding these will be sufficient to make a
> reasonable trade-off.  Below shows this in detail::
> 
>     <heap>
>     <BIG UNMAPPED REGION 1>
>     <uppermost mmap()-ed region>
>     (small mmap()-ed regions and munmap()-ed regions)
>     <lowermost mmap()-ed region>
>     <BIG UNMAPPED REGION 2>
>     <stack>
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> ---
>  include/linux/damon.h |  13 +
>  mm/damon/Kconfig      |   9 +
>  mm/damon/Makefile     |   1 +
>  mm/damon/vaddr.c      | 579 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 602 insertions(+)
>  create mode 100644 mm/damon/vaddr.c
> 
[...]
> +
> +/*
> + * Update regions for current memory mappings
> + */
> +void damon_va_update(struct damon_ctx *ctx)
> +{
> +	struct damon_addr_range three_regions[3];
> +	struct damon_target *t;
> +
> +	damon_for_each_target(t, ctx) {
> +		if (damon_va_three_regions(t, three_regions))
> +			continue;
> +		damon_va_apply_three_regions(ctx, t, three_regions);
> +	}
> +}
> +
> +static void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm,
> +			     unsigned long addr)
> +{
> +	bool referenced = false;
> +	struct page *page = pte_page(*pte);

The 'pte' could be a special mapping which has no associated 'struct page'.  In
the case, 'page' would be invalid.  Guoju from Alibaba found the problem from
his GPU setup and reported the problem to via Github[1].  I made a fix and
waiting for his test results.  I will squash the fix in the next version of
this patch.

[1] https://github.com/sjp38/linux/pull/3/commits/12eeebc6ffc8b5d2a6aba7a2ec9fb85d3c1663af
[2] https://github.com/sjp38/linux/commit/f1fa22b6375ceb9ae53e9370452de0d62efd4df5


Thanks,
SeongJae Park

> +
> +	if (pte_young(*pte)) {
> +		referenced = true;
> +		*pte = pte_mkold(*pte);
> +	}
> +
> +#ifdef CONFIG_MMU_NOTIFIER
> +	if (mmu_notifier_clear_young(mm, addr, addr + PAGE_SIZE))
> +		referenced = true;
> +#endif /* CONFIG_MMU_NOTIFIER */
> +
> +	if (referenced)
> +		set_page_young(page);
> +
> +	set_page_idle(page);
> +}
> +
[...]
> +
> +static void damon_va_mkold(struct mm_struct *mm, unsigned long addr)
> +{
> +	pte_t *pte = NULL;
> +	pmd_t *pmd = NULL;
> +	spinlock_t *ptl;
> +
> +	if (follow_invalidate_pte(mm, addr, NULL, &pte, &pmd, &ptl))
> +		return;
> +
> +	if (pte) {
> +		damon_ptep_mkold(pte, mm, addr);
> +		pte_unmap_unlock(pte, ptl);
> +	} else {
> +		damon_pmdp_mkold(pmd, mm, addr);
> +		spin_unlock(ptl);
> +	}
> +}
> +
[...]
