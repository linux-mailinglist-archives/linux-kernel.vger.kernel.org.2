Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188F840C488
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 13:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbhIOLri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 07:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbhIOLrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 07:47:31 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD1CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 04:46:12 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id j12so516187ljg.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 04:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4uYqvhZeHXv+ssAcqC18NkCUO7S23+uQI3/MrtalBV0=;
        b=jyiV1pAooDObXMWnm3SrBe9VySDlVMgGIdz0ZOAqYFqHTDbGSqfGlclgEpgSJnLk9Q
         DFka1G8+6sSoD3HNSqa0AppZDm2J1kkZRyV+Ekj0m8uHjXRySHiMBmH7WY9nhKnUr/VT
         35oCwlYebNGuHog/4c3gCuRkJXVh/bIk6Tdk5zhvhNarQQSivcYCtFgJSW/Rz12DW7GL
         jUh7hMukNOAQHN5HvXwrMx8rRg97dA6+kwG/LTGpn5AomPepMFIPfwm6cWNOVFkW6QI6
         7bHQrFQgbUXL52514a9fKrhGs8YBnPNc3rmHQ/wM43OJGLye+GKaW5qLT1AkYcVARpnv
         qFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4uYqvhZeHXv+ssAcqC18NkCUO7S23+uQI3/MrtalBV0=;
        b=P6GT+i7EmE2UD+VgYSEHaUhMm0ULxhrR4C2KbVSfCOYdQAG6jA/WyL2wszUSRhF7Xj
         sxxz8jMZcw0pmeyYoKbpfy73UDSdNJDjLIH2Bl9qB2mID2rHahlkfJ/LXn26RFAZs3xg
         py4/0hvZ91H0ppDNAaG8+2SRnWI5AxjZ4so55K9EEoxBoZwQSMCd2nH6LNpJf9lyVSpA
         LK9kHI8DK9n73Ud7qgETZMUbTZe26zVas6THpBZw/xkJX5/8J8osLWezW+Ql0rxryTFR
         z2+wPZ0Da9sJ7jutsiJgmI151SjzCYzxr+ogL/7jiwq2nuMUosF12Nt9Rx1FUIzhpCdD
         taaA==
X-Gm-Message-State: AOAM530qEEG7Y6N2lccReJB+WmIQNCZwcG0ECIjfUC4sV3Xo6iMfTh6g
        Lm9DqEI3z1DO0fVuduiPzCG4zw==
X-Google-Smtp-Source: ABdhPJwCBpDqQI2MR/6gQuQDuaPc18SeGMEV9d5/MeeH65Opge+QdGLHvzx00+xc1e2k20cqP9RBww==
X-Received: by 2002:a2e:a546:: with SMTP id e6mr20030432ljn.117.1631706370471;
        Wed, 15 Sep 2021 04:46:10 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y14sm107725lfk.237.2021.09.15.04.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 04:46:10 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 310A7102F4D; Wed, 15 Sep 2021 14:46:13 +0300 (+03)
Date:   Wed, 15 Sep 2021 14:46:13 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     naoya.horiguchi@nec.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, willy@infradead.org,
        osalvador@suse.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] mm: filemap: check if any subpage is hwpoisoned for
 PMD page fault
Message-ID: <20210915114613.lo26l64iqjz2qo6a@box.shutemov.name>
References: <20210914183718.4236-1-shy828301@gmail.com>
 <20210914183718.4236-2-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914183718.4236-2-shy828301@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 11:37:15AM -0700, Yang Shi wrote:
> diff --git a/mm/memory.c b/mm/memory.c
> index 25fc46e87214..1765bf72ed16 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3920,8 +3920,17 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  	if (unlikely(!pmd_none(*vmf->pmd)))
>  		goto out;
>  
> -	for (i = 0; i < HPAGE_PMD_NR; i++)
> +	for (i = 0; i < HPAGE_PMD_NR; i++) {
> +		/*
> +		 * Just backoff if any subpage of a THP is corrupted otherwise
> +		 * the corrupted page may mapped by PMD silently to escape the
> +		 * check.  This kind of THP just can be PTE mapped.  Access to
> +		 * the corrupted subpage should trigger SIGBUS as expected.
> +		 */
> +		if (PageHWPoison(page + i))
> +			goto out;
>  		flush_icache_page(vma, page + i);
> +	}

This is somewhat costly.

flush_icache_page() is empty on most archs so compiler makes the loop go
away before the change. Also page->flags for most of the pages will not
necessary be hot.

I wounder if we should consider making PG_hwpoison to cover full compound
page. On marking page hwpoison we try to split it and mark relevant base
page, if split fails -- mark full compound page.

As alternative we can have one more flag that indicates that the compound
page contains at least one hwpoisoned base page. We should have enough
space in the first tail page.

-- 
 Kirill A. Shutemov
