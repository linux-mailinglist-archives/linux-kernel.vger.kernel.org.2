Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEF63A289F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhFJJpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:45:55 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:46742 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhFJJpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:45:53 -0400
Received: by mail-lj1-f175.google.com with SMTP id e11so3912661ljn.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FZtPqiacUMa3RR146lKg3ZwOABR6cRUS7jKKlWzO7H4=;
        b=H5Sa0qVjQ2xgyVmHndXCzmF7Ekl/Myz3sUzhz7fRE8DMJ+q6hL9fxVGm8HMyEpD5Pq
         sDqyNz7EgRWEhguXWOhfVzX/oqdjpTJDgw9Tu0aQj04ruORnmNSCUvD91KS36KjQaWzv
         JaCEejKWRs4Ex6vRaxZ9zZce+0tRxeskRat4zSA/8NZ+YWK9RHGfy8bf9/9FSczBy2B5
         SZmsukCbTs3vJdCKuq2AWtlu+tXHf0TxjpZhODhtjVV5dh5u+QJINfUcsxOLsDm1CreL
         FQCB17qdyLrdDe8H5m4+VZW9YIfXV6TCLnmjmVuGsVH883+MvbSnrFRwT64WpMJXnzEB
         Nx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FZtPqiacUMa3RR146lKg3ZwOABR6cRUS7jKKlWzO7H4=;
        b=oIb4UHYvNt5DbSgdYjuzc14fEYmzrlFKQBYCdX8vvHNp9ov7iKhQ+dPJT/SC0GkuSX
         aiYE2pvbrobfxFvQuBduP9ttoo/Y0J+wCVu/A5AcNQkrnUtoqO4liieGwBH3JCGpjQN6
         gYiJVbE2cog3DbQaiDf6BPYVSOd+emapfGhIsITPB7FZL+9UWDr1KhjY93tB1L0mxJA4
         6wSkjAzImguGONivpqsMgaILUrXOgykfwAZk2iFnB0HkcPbwKIu4Iv2UocyQbWqohD9O
         dKY4t/75plYfVIQOHV+a5CtbTUxUc1+wmG08x86UafXAiQzqsqjOBM17EXFW8GhQmbD8
         pj9A==
X-Gm-Message-State: AOAM530m4S1WGHul8/qOpWqBBk5R+Jyp27fRUx4iOvuA7XJ8Lm+lLhJI
        J41EZ2tVxKtUA38pZZnVEZyEFA==
X-Google-Smtp-Source: ABdhPJzlJTLZaCZNALHstNwyYrOK83yVaDPi5AM+4+CAkOVPrhmvIkRvQJVcwwM+1qOOHl8GjbRKCA==
X-Received: by 2002:a2e:5cc4:: with SMTP id q187mr1426076ljb.177.1623318177119;
        Thu, 10 Jun 2021 02:42:57 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 76sm277284ljj.32.2021.06.10.02.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:42:56 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BCC361027EE; Thu, 10 Jun 2021 12:43:12 +0300 (+03)
Date:   Thu, 10 Jun 2021 12:43:12 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] mm/thp: another PVMW_SYNC fix in
 page_vma_mapped_walk()
Message-ID: <20210610094312.kzhhqyz4abe2yizg@box.shutemov.name>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <1bdf384c-8137-a149-2a1e-475a4791c3c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bdf384c-8137-a149-2a1e-475a4791c3c@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:54:46PM -0700, Hugh Dickins wrote:
> Aha!  Shouldn't that quick scan over pte_none()s make sure that it holds
> ptlock in the PVMW_SYNC case?  That too might have been responsible for
> BUGs or WARNs in split_huge_page_to_list() or its unmap_page(), though
> I've never seen any.
> 
> Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
