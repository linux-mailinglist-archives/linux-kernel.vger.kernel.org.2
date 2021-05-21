Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C82A38BC55
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238458AbhEUCSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbhEUCSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:18:38 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE58BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:17:16 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so16710385otg.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 19:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=t/w/mdGLNnOXLQYr7jv5WVlJPz9gV76Ic4ZwCQsYHQU=;
        b=HzVlX4/PKsp5/djiXIBO3cFtOzAIgz8yEz+K3cDYNdeO77HnFJFieGJJMSGKm5p0CC
         FhNKkQyJNAMlSSR29Qe1EAXeal+tpq1B7m0ZwRTwQRePfoOXQTUT0L9zpm5R+Y249nDM
         5HenaywadS5Hzq2C6dtkZqPPbAnMIbj/G03hWtzch+U5hHaG+T6Ru/WsebK5mevSwLuq
         /3xYj3gaiw432cb8q39+bhuiAyAQNGbF8iIsNWr4oTy1pqQRQo+X4YbLDQEVOeb2krZL
         SM64vSXO+xZaBmTbg8EjRUTUNq4ookKlYJdzQzBh0fHDTOlkG/9Y2iOIVQk1uTSPhLR+
         Iqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=t/w/mdGLNnOXLQYr7jv5WVlJPz9gV76Ic4ZwCQsYHQU=;
        b=OVhBYwQ7GO6jx5HXkaPYPwTWJML+40So2nxYVtPOrQXe3IJiOIiLMjZsI6wk7v4m6X
         7qEgjy8tWouFk3tHLbO8xyIWtElmuhh/qjTXFQkCEhMo9pvOgXH4pwytUJVFNOpED7x9
         JQGdS2VQZYuMJmMpBh1TnCdXHznfFZs4Dhb4NxcXAhcTyC6XahVkCHs+HQ6/xaT5scnv
         LlbKoR3DlYjamSUjr8j4HvBtox9ShZ9gGIpAepPgHwcR/f/XprwTDGD/VaGheuOCtErQ
         +A4xWYTpF1j/NJqDoHJxLjd3de6xC3jkxrqLHR7KLumjeSCBejI8hiFAmXQ8swOpaiPf
         lsGQ==
X-Gm-Message-State: AOAM5320wNbsKyubb/t6oOaBEv9KQXdAELUkDnjC3Xb2YMtmfNaI09Vw
        rQ6mqiHxjUly8+DvpgyUx7UmJw==
X-Google-Smtp-Source: ABdhPJyPe5NNa0oHjXXPCVjOcLXSuJznZBJixxDYKqVRO/BeBB3wxknifz63gY1s4kmcrkYCmgAAlQ==
X-Received: by 2002:a9d:6081:: with SMTP id m1mr6206081otj.226.1621563435953;
        Thu, 20 May 2021 19:17:15 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p5sm904983oip.35.2021.05.20.19.17.14
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 20 May 2021 19:17:15 -0700 (PDT)
Date:   Thu, 20 May 2021 19:17:04 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Anshuman Khandual <anshuman.khandual@arm.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/thp: Update mm_struct's MM_ANONPAGES stat for huge
 zero pages
In-Reply-To: <1621313300-1118-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <alpine.LSU.2.11.2105201852230.5752@eggly.anvils>
References: <1621313300-1118-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 May 2021, Anshuman Khandual wrote:

> Although the zero huge page is being shared across various processes, each
> mapping needs to update its mm_struct's MM_ANONPAGES stat by HPAGE_PMD_NR
> to be consistent. This just updates the stats in set_huge_zero_page() after
> the mapping gets created and in zap_huge_pmd() when mapping gets destroyed.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

NAK.

For consistency with what? In the all the years that the huge zero page
has existed, it has been intentionally exempted from rss accounting:
consistent with the small zero page, which itself has always been
intentionally exempted from rss accounting. In fact, that's a good part
of the reason the huge zero page was introduced (see 4a6c1297268c).

To change that now will break any users depending on it.

Not to mention the
BUG: Bad rss-counter state mm:00000000aa61ef82 type:MM_ANONPAGES val:512
I just got from mmotm.

Hugh

> ---
> This applies on v5.13-rc2.
> 
> Changes in V1:
> 
> - Updated MM_ANONPAGES stat in zap_huge_pmd()
> - Updated the commit message
> 
> Changes in RFC:
> 
> https://lore.kernel.org/linux-mm/1620890438-9127-1-git-send-email-anshuman.khandual@arm.com/
> 
>  mm/huge_memory.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 63ed6b25deaa..306d0a41bf75 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -706,6 +706,7 @@ static void set_huge_zero_page(pgtable_t pgtable, struct mm_struct *mm,
>  	if (pgtable)
>  		pgtable_trans_huge_deposit(mm, pmd, pgtable);
>  	set_pmd_at(mm, haddr, pmd, entry);
> +	add_mm_counter(mm, MM_ANONPAGES, HPAGE_PMD_NR);
>  	mm_inc_nr_ptes(mm);
>  }
>  
> @@ -1678,6 +1679,7 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  			tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
>  	} else if (is_huge_zero_pmd(orig_pmd)) {
>  		zap_deposited_table(tlb->mm, pmd);
> +		add_mm_counter(tlb->mm, MM_ANONPAGES, -HPAGE_PMD_NR);
>  		spin_unlock(ptl);
>  		tlb_remove_page_size(tlb, pmd_page(orig_pmd), HPAGE_PMD_SIZE);
>  	} else {
> -- 
> 2.20.1
