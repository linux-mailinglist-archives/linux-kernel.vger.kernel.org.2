Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F3B3AA224
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 19:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhFPRMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 13:12:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51558 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhFPRMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 13:12:14 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 606C521A64;
        Wed, 16 Jun 2021 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623863407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPGfbGElVJ2SXppTW6aIgd8Twb2wKaHsMDX214lrojE=;
        b=mriEgvvv4Ne7kbJgIGJTo/dH0YdJ3uhhjjv1hHpbp0mmOWuw8r9YU2tvWj0r5mI+bsI1G8
        3upWXKO4cmFF3kx5YeMZk5aenv6HvI66ukxzlRXM9GFbYmvqNBll9XCKJZnNyuEMsmCO1x
        q0HIzLALFlL6rdPARBnR7QU0YdXg3n0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623863407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPGfbGElVJ2SXppTW6aIgd8Twb2wKaHsMDX214lrojE=;
        b=s76ZnqiB+uCytlEJOQ60UH/A3nnhZNuVPZcGOuB47RpaLjcpvPk81FnpcK3Lae3YQPv6yG
        kVEzlxW8cv9wgQAQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 3C73F118DD;
        Wed, 16 Jun 2021 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623863407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPGfbGElVJ2SXppTW6aIgd8Twb2wKaHsMDX214lrojE=;
        b=mriEgvvv4Ne7kbJgIGJTo/dH0YdJ3uhhjjv1hHpbp0mmOWuw8r9YU2tvWj0r5mI+bsI1G8
        3upWXKO4cmFF3kx5YeMZk5aenv6HvI66ukxzlRXM9GFbYmvqNBll9XCKJZnNyuEMsmCO1x
        q0HIzLALFlL6rdPARBnR7QU0YdXg3n0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623863407;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPGfbGElVJ2SXppTW6aIgd8Twb2wKaHsMDX214lrojE=;
        b=s76ZnqiB+uCytlEJOQ60UH/A3nnhZNuVPZcGOuB47RpaLjcpvPk81FnpcK3Lae3YQPv6yG
        kVEzlxW8cv9wgQAQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 1Hw8Dm8wymDdMgAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Wed, 16 Jun 2021 17:10:07 +0000
To:     Janghyuck Kim <janghyuck.kim@samsung.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Atish Patra <atish.patra@wdc.com>,
        Gavin Shan <gshan@redhat.com>,
        Zhengyuan Liu <liuzhengyuan@tj.kylinos.cn>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <CGME20210616081628epcas2p3f919d10029cbe01efa1212a5b861af38@epcas2p3.samsung.com>
 <20210616083745.14288-1-janghyuck.kim@samsung.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 1/2] mm: support fastpath if NUMA is enabled with numa off
Message-ID: <55a95320-f356-86d2-26e4-11407f60de84@suse.cz>
Date:   Wed, 16 Jun 2021 19:10:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210616083745.14288-1-janghyuck.kim@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/21 10:37 AM, Janghyuck Kim wrote:
> Architecture might support fake node when CONFIG_NUMA is enabled but any

I suppose you mean the dummy node, i.e. dummy_numa_init()?

Because fakenuma is something different and I think if someone defines fakenuma
nodes they actually would want for the mempolicies to be honored as if there was
a real NUMA setup.

> node settings were supported by ACPI or device tree. In this case,
> getting memory policy during memory allocation path is meaningless.
> 
> Moreover, performance degradation was observed in the minor page fault
> test, which is provided by (https://lkml.org/lkml/2006/8/29/294).
> Average faults/sec of enabling NUMA with fake node was 5~6 % worse than
> disabling NUMA. To reduce this performance regression, fastpath is

So you have measured this overhead is all due to mempolicy evaluation?
Interesting, sounds like a lot.

> introduced. fastpath can skip the memory policy checking if NUMA is
> enabled but it uses fake node. If architecture doesn't support fake
> node, fastpath affects nothing for memory allocation path.
> 
> Signed-off-by: Janghyuck Kim <janghyuck.kim@samsung.com>

Sounds like an interesting direction to improve CONFIG_NUMA built kernels on
single-node systems, but why restrict it only to arm64 and not make it generic
for all systems with a single node?
We could also probably use a static key instead of this #define.
That would even make it possible to switch in case memory hotplug onlines
another node, etc.

> ---
>  mm/internal.h  | 4 ++++
>  mm/mempolicy.c | 3 +++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 31ff935b2547..3b6c21814fbc 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -36,6 +36,10 @@ void page_writeback_init(void);
>  
>  vm_fault_t do_swap_page(struct vm_fault *vmf);
>  
> +#ifndef numa_off_fastpath
> +#define numa_off_fastpath()	false
> +#endif
> +
>  void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_vma,
>  		unsigned long floor, unsigned long ceiling);
>  
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index e32360e90274..21156671d941 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2152,6 +2152,9 @@ struct page *alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
>  	int preferred_nid;
>  	nodemask_t *nmask;
>  
> +	if (numa_off_fastpath())
> +		return __alloc_pages_nodemask(gfp, order, 0, NULL);
> +
>  	pol = get_vma_policy(vma, addr);
>  
>  	if (pol->mode == MPOL_INTERLEAVE) {
> 

