Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF11F3CCB3C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 00:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhGRWEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 18:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhGRWEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 18:04:08 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87C3C061764
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 15:01:08 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id e14so4637818ljo.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jul 2021 15:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pTmQxf6zy7tgDXAHQZQ/3w3DBTHv9qcRwctrA/DmgL8=;
        b=ImGexmtBpNIhLOFUDX+Hg4fdEhz+9f0lA73zW6A4nVTg9Lq+3XMNPk+lksh0Tc1Uvs
         j773FbOGuzdb5rICHJu0x/mR4MfPLgPeYN7jGFIQb7hCwTDtxw2l6D96Zkt/54mGUPDQ
         pBdyl/SDjkV983FCXrlNk6b344/0UqOD/0HKkg1Dv2+huQ6JxBpBdNWpmt/EI1AZwAIE
         mGCdULjCwrVJWFICGTXAr1qQhLfaVpEdiWK7XOtbL7+x4oqfw955VQHoGzGMZ1bmbVsA
         7frUOHLj1tAVss5x0h0d0d/waxKEKM8OQmBy885O9ObnvdJswiKEu0NehWcYymF6qLqS
         7hGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pTmQxf6zy7tgDXAHQZQ/3w3DBTHv9qcRwctrA/DmgL8=;
        b=IOVuPBqQH37FMDY3pYfAFu1tRj5AGBvhPa1/1B3pC11BuUbAgREQExQ+3vmK2/M1hQ
         trrjSoBwVA2/MI9zPEMmQHWSifBSjxzhA0kqxC5VjxfTY+O2/XpSSeAf3H1ph1JPptxS
         /LbSa03vjyRPsoWemxC+d4kU7UigK8igsg5m0H4XeqTyD4JOUAfp9fKtK/K1ON8JQNRX
         e+5mpT7CNZONrL/Ly/W4aC+hvza0juSE0pcnsBjUEhYGN6FAv2lZ237IGt11MZqJDWj0
         SIe/Zg4ikQSOl880zuqS1oGky9A29NsLcLcE1Bwq0CsQQCCF55xkGjgLnxwhoEklc41A
         dR3A==
X-Gm-Message-State: AOAM532XXH2OHcWqv9x0Q5ftO0v2OmI1GbZw8L+lqGQX1TfaBo4XJ83F
        sGEt86OeVC8lX4GC4HAHxrfXFg==
X-Google-Smtp-Source: ABdhPJyWP9/MCe/uj5yxXTZGFXBCLWxqnl6ztQZHqM5uxO9/Yt0DWcwAcoVo3+PYJan0pjRig6b9mQ==
X-Received: by 2002:a2e:530e:: with SMTP id h14mr19763188ljb.454.1626645667141;
        Sun, 18 Jul 2021 15:01:07 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v16sm1874484ljn.93.2021.07.18.15.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 15:01:06 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5F6CD10260F; Mon, 19 Jul 2021 01:01:10 +0300 (+03)
Date:   Mon, 19 Jul 2021 01:01:10 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com
Subject: Re: [PATCH 5/7] mm: free user PTE page table pages
Message-ID: <20210718220110.nqcd73luncf3v7mk@box.shutemov.name>
References: <20210718043034.76431-1-zhengqi.arch@bytedance.com>
 <20210718043034.76431-6-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718043034.76431-6-zhengqi.arch@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 18, 2021 at 12:30:31PM +0800, Qi Zheng wrote:
> Some malloc libraries(e.g. jemalloc or tcmalloc) usually
> allocate the amount of VAs by mmap() and do not unmap
> those VAs. They will use madvise(MADV_DONTNEED) to free
> physical memory if they want. But the page tables do not
> be freed by madvise(), so it can produce many page tables
> when the process touches an enormous virtual address space.
> 
> The following figures are a memory usage snapshot of one
> process which actually happened on our server:
> 
>         VIRT:  55t
>         RES:   590g
>         VmPTE: 110g
> 
> As we can see, the PTE page tables size is 110g, while the
> RES is 590g. In theory, the process only need 1.2g PTE page
> tables to map those physical memory. The reason why PTE page
> tables occupy a lot of memory is that madvise(MADV_DONTNEED)
> only empty the PTE and free physical memory but doesn't free
> the PTE page table pages. So we can free those empty PTE page
> tables to save memory. In the above cases, we can save memory
> about 108g(best case). And the larger the difference between
> the size of VIRT and RES, the more memory we save.
> 
> In this patch series, we add a pte_refcount field to the
> struct page of page table to track how many users of PTE page
> table. Similar to the mechanism of page refcount, the user of
> PTE page table should hold a refcount to it before accessing.
> The PTE page table page will be freed when the last refcount
> is dropped.

The patch is very hard to review.

Could you split up introduction of the new API in the separate patch? With
a proper documentation of the API.

Why pte_refcount is atomic? Looks like you do everything under pmd_lock().
Do I miss something?

And performance numbers should be included. I don't expect pmd_lock() in
all hotpaths to scale well.

-- 
 Kirill A. Shutemov
