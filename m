Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E3A3A2899
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 11:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFJJok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 05:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhFJJoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 05:44:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60964C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:42:30 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i10so2233501lfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 02:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BY5gWDPGhOOh05MTbHBqo44JzZHQYM/4bR652Xf+XDw=;
        b=MQJOLlGKsxYhRQMSTHDQKDS/AVvXuBjwfTv9RCF7lTgYMCjlJXuPv2NB2INM4Y0okK
         kCZ/AODnXxuPill0Rg9SOsoak10eZ//EuEuFIWPsWI8qWmcxZyjq9UsjjmQngCD9Bv4m
         j35ZnHt+xDTCPwsfIf225yEnlhYQD7yvZrJIaYQhXKAK/NuzdGpzkh9Dddax7q5Ss2/R
         IeHsHUGxMx9MSID4VTxqSrX35MfjGsmUD5UBbKULAOzcPK3vi/ZUjJQpNKNuX+1AIsOC
         CBgXHbYsW7sGSh3pwYPZDQ/s0NNK+XpYKwC+/t+HdV/uRIruWJVapVcjMm8xWN9vN2mi
         +y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BY5gWDPGhOOh05MTbHBqo44JzZHQYM/4bR652Xf+XDw=;
        b=ZC2m8yWjtg3S/XidFsVDrJL7vP9eTb/tPgr/nLFHiJr048BQb4JGKEiZCY16e4g/rS
         CDmpzUrLOnBVgiXYuUhfTmOJ1+E+idvzjIygw0jRygLPCc8Fr//rQ8q+tI5bRB8+rQaF
         ecp484GcaIUTI3rPqmBI4n1xQMJvb/nvWnv0lKis+igmc6aaoN9GuGkR/koi9nH7Rmit
         5N6JuEmwGI4VEyXbpI1yyBiWxVdHOyaoVhX51jLTJtB0oJQ/Z9+MeIKXRcHVTUrZ81hl
         4ZxrN+Qs26EVWPBDRKVipLdAeLXevw75xQ1A1F1RvcmWSlg29xFJ3e0kHaDrU9E0Z6Ac
         6zLQ==
X-Gm-Message-State: AOAM532QKVfmGUEaruUogYbCMBdWI8iF/snZfKS1Aq8uOFTJR2UAGtlW
        tN/TLEdKbMqjxE53z00QT6g63A==
X-Google-Smtp-Source: ABdhPJwhWkdCWL07hD3+jqD/nEThG6Ks4sJk7HAe3z3eTSHsg2KK0YXyQLa/vmRIT3d2XoPH5D96pA==
X-Received: by 2002:a19:8645:: with SMTP id i66mr1345707lfd.332.1623318148740;
        Thu, 10 Jun 2021 02:42:28 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o21sm246947lfr.253.2021.06.10.02.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 02:42:28 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 23BDF1027EE; Thu, 10 Jun 2021 12:42:44 +0300 (+03)
Date:   Thu, 10 Jun 2021 12:42:44 +0300
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
Subject: Re: [PATCH 10/11] mm/thp: fix page_vma_mapped_walk() if THP mapped
 by ptes
Message-ID: <20210610094244.ag3gp5pnu3ulhhgu@box.shutemov.name>
References: <589b358c-febc-c88e-d4c2-7834b37fa7bf@google.com>
 <fedb8632-1798-de42-f39e-873551d5bc81@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fedb8632-1798-de42-f39e-873551d5bc81@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2021 at 11:52:37PM -0700, Hugh Dickins wrote:
> Running certain tests with a DEBUG_VM kernel would crash within hours,
> on the total_mapcount BUG() in split_huge_page_to_list(), while trying
> to free up some memory by punching a hole in a shmem huge page: split's
> try_to_unmap() was unable to find all the mappings of the page (which,
> on a !DEBUG_VM kernel, would then keep the huge page pinned in memory).
> 
> Crash dumps showed two tail pages of a shmem huge page remained mapped
> by pte: ptes in a non-huge-aligned vma of a gVisor process, at the end
> of a long unmapped range; and no page table had yet been allocated for
> the head of the huge page to be mapped into.
> 
> Although designed to handle these odd misaligned huge-page-mapped-by-pte
> cases, page_vma_mapped_walk() falls short by returning false prematurely
> when !pmd_present or !pud_present or !p4d_present or !pgd_present: there
> are cases when a huge page may span the boundary, with ptes present in
> the next.
> 
> Restructure page_vma_mapped_walk() as a loop to continue in these cases,
> while keeping its layout much as before. Add a step_forward() helper to
> advance pvmw->address across those boundaries: originally I tried to use
> mm's standard p?d_addr_end() macros, but hit the same crash 512 times
> less often: because of the way redundant levels are folded together,
> but folded differently in different configurations, it was just too
> difficult to use them correctly; and step_forward() is simpler anyway.
> 
> Fixes: ace71a19cec5 ("mm: introduce page_vma_mapped_walk()")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
