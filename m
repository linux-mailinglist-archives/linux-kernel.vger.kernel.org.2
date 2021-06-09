Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1584B3A110F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbhFIK1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbhFIK11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:27:27 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9731C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 03:25:32 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c11so30998345ljd.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5QAkRGFxSLqzS5cp+G+f5UsgmtkiWfavXgqFMrT3FAg=;
        b=hI4SCQbNR5mLaucodttiBAsDnvdq9Yjha4Cjz29yi30hhWLRtzIXvjm0ahVAu/o996
         JLE7hNKw/rAXPrFpGG4L4ZX4TqnC81tpABRN2fGfkZJERPyByfUYJjGZoiyTPX2fY7mu
         eiBgVRfobCh/NO+TV3WN3+pAmGUZeZP5TkuYnNB5HqYfuo0lhsHaVKoElAFgOoScj3Z+
         vbxTRlmfg4NayqIH1789vPQI3gmtbLzI9BUn6X3O+Is9qKXGfsCecjyLMLaZBeZoYV0M
         VLxPnLUKs5qO1Ijzx+mFzk0GVVAa6R3Sy7yJZ6blSwM9Ju9vL+S2jUcoxNNYeH5Pa0C2
         Pl1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5QAkRGFxSLqzS5cp+G+f5UsgmtkiWfavXgqFMrT3FAg=;
        b=ghqG2ttxPkTyabEGN3cQ4CRRXbuE4IHe+bqdXXZps4dznR2rYunuC6Xks+dj2MDqZV
         nSUeisRtiSP8aU9zaF5/qFUqRQqrqnnKedtvAjSbmHm5tDjEWnGVe5Rt1MrTtBXKwT1w
         nMQNeuvRTQExs/x8Kz4pmbP8/ZiknAcCTaMEyDv8Rn1enUMQmyhsuxh8HqkhetEn9PQ7
         0vP/IPl0F+tu6lhSJmYChzKWtyFj3HrpRJjy2VzA5QxMkIXdNyVNFBVoTnqACPEATJxT
         KU4E3c59aEvYVVcnZhCOgwCSq7nvTPX/tRoCPsUOdrUT4Hnzs7FJkWuGUAMy1BN0buQL
         G2yg==
X-Gm-Message-State: AOAM5305wcMcrSAGkzouL7cq8xryaGT9hZQizTCAxGcPIyqxChgeNpmc
        kSmyC2DOn2vQGKbIKSYhpYB0sp+cPO2u4Q==
X-Google-Smtp-Source: ABdhPJwn0lN3cnohZ4egedVX2Hw1kok4FVdZXXrSaCNAZdZlNr8yjXo+slWN28x3RPvckTQGK7L6tQ==
X-Received: by 2002:a2e:3c08:: with SMTP id j8mr22256643lja.481.1623234329797;
        Wed, 09 Jun 2021 03:25:29 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v15sm279009ljd.5.2021.06.09.03.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:25:29 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 88C9D10265B; Wed,  9 Jun 2021 13:25:44 +0300 (+03)
Date:   Wed, 9 Jun 2021 13:25:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] mm/thp: try_to_unmap() use TTU_SYNC for safe
 splitting (fwd)
Message-ID: <20210609102544.lua6zb6j5g4gpsxx@box.shutemov.name>
References: <6b2b6683-d9a7-b7d0-a3e5-425b96338d63@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b2b6683-d9a7-b7d0-a3e5-425b96338d63@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 09:12:20PM -0700, Hugh Dickins wrote:
> 
> 
> ---------- Forwarded message ----------
> Date: Tue, 8 Jun 2021 21:10:19 -0700 (PDT)
> From: Hugh Dickins <hughd@google.com>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hugh Dickins <hughd@google.com>,
>     Kirill A. Shutemov <kirill.shutemov@linux.intel.com>,
>     Yang Shi <shy828301@gmail.com>, Wang Yugui <wangyugui@e16-tech.com>,
>     Matthew Wilcox <willy@infradead.org>,
>     Naoya Horiguchi <naoya.horiguchi@nec.com>,
>     Alistair Popple <apopple@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>,
>     Zi Yan <ziy@nvidia.com>, Miaohe Lin <linmiaohe@huawei.com>,
>     Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
>     Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
>     Shakeel Butt <shakeelb@google.com>, Oscar Salvador <osalvador@suse.de>
> Subject: [PATCH v2 03/10] mm/thp: try_to_unmap() use TTU_SYNC for safe splitting
> 
> Stressing huge tmpfs often crashed on unmap_page()'s VM_BUG_ON_PAGE
> (!unmap_success): with dump_page() showing mapcount:1, but then its
> raw struct page output showing _mapcount ffffffff i.e. mapcount 0.
> 
> And even if that particular VM_BUG_ON_PAGE(!unmap_success) is removed,
> it is immediately followed by a VM_BUG_ON_PAGE(compound_mapcount(head)),
> and further down an IS_ENABLED(CONFIG_DEBUG_VM) total_mapcount BUG():
> all indicative of some mapcount difficulty in development here perhaps.
> But the !CONFIG_DEBUG_VM path handles the failures correctly and silently.
> 
> I believe the problem is that once a racing unmap has cleared pte or pmd,
> try_to_unmap_one() may skip taking the page table lock, and emerge from
> try_to_unmap() before the racing task has reached decrementing mapcount.
> 
> Instead of abandoning the unsafe VM_BUG_ON_PAGE(), and the ones that
> follow, use PVMW_SYNC in try_to_unmap_one() in this case: adding TTU_SYNC
> to the options, and passing that from unmap_page().
> 
> When CONFIG_DEBUG_VM, or for non-debug too?  Consensus is to do the same
> for both: the slight overhead added should rarely matter, except perhaps
> if splitting sparsely-populated multiply-mapped shmem.  Once confident
> that bugs are fixed, TTU_SYNC here can be removed, and the race tolerated.
> 
> Fixes: fec89c109f3a ("thp: rewrite freeze_page()/unfreeze_page() with generic rmap walkers")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
