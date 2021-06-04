Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD4739BBF9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhFDPhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:37:09 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:40472 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFDPhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:37:08 -0400
Received: by mail-lf1-f46.google.com with SMTP id w33so14721703lfu.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 08:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pxqXWpOMRKwzgShQLB13AAcIjid8zEdiCw/9s5AYCaI=;
        b=D/dHG9Vnq2ijnQ3b1ICqDvX320BcdijuRqiTrRIz3ioL/opYdhr7zmaV3ULky8qGQ0
         Zt87soWd/Lkhb2tZWNxm8fYnqFMQwAJIi/AO4CdqwVqRCv7BgkOdS2bMd92MowyQH/Vl
         ptAFLJ9XUDL0dmo3CLOax6LIfjCRb7pE9j1CYtPHwdhbrBzTAueOl7LshYamr0dSzvCQ
         xfYQEEzGE5GWGmB9oaGUciPjE4ntho6V05YfwTHRhPy61c74fszMPcbIfnTLiuu0IdFz
         p214mDLMjXo4z3MpTsIl/TKWnqrOi642O9YfAYWwpS3a57WPtUU10BcvyOMmrnoT4lIr
         4N3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pxqXWpOMRKwzgShQLB13AAcIjid8zEdiCw/9s5AYCaI=;
        b=FkYLDEeGMfKt0HeCkElx82QdTGB5z+XUXolJZ4e+n+Jt+s5R3qHRNWJA7rh5Pxai1l
         UngRsYxtTKkAiz/sk1abx6og2EuZLv0NyvDJus2EcgTU0ARiZBrycD5bJqkbAS3cPsH5
         Fogu2v4Ehji9MfQNTTfzKbjRTWHvZkiGNp4DuZjfmR+bs0D3hu5tHrY0TjkcKQqiAzF4
         Pq06y1SMdXY5ZcXhCQ21KQJaeBeR+uics1wR/i/wM8kB1M4LB+4rcOlMVicY2gqoOPR+
         AEET+vSE5UCuNxuMiIiW8O2/3TfCqRCFffCYngsvYBxbDmdSCdh8/yUfeEQTXxkDsNiI
         SkOQ==
X-Gm-Message-State: AOAM530mFOZAZnTY57NNsGbO7QU2Gls3wsYYn+Lff9cGLHCj16goeDU2
        9bJZqM3OjK226OU3HjHpVO4Quw==
X-Google-Smtp-Source: ABdhPJwF64JHO79JO+CwXdAObnwrYkDUCZlqqNhd4DWfbD8ng+o3wqj+KJ1Z0kj5Qfdc1NHEafcU2A==
X-Received: by 2002:ac2:4acd:: with SMTP id m13mr3037027lfp.620.1622820861219;
        Fri, 04 Jun 2021 08:34:21 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f10sm749818ljp.8.2021.06.04.08.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:34:20 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id F1DD51027A9; Fri,  4 Jun 2021 18:34:32 +0300 (+03)
Date:   Fri, 4 Jun 2021 18:34:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Matthew Wilcox <willy@infradead.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jue Wang <juew@google.com>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] mm/thp: fix __split_huge_pmd_locked() on shmem
 migration entry
Message-ID: <20210604153432.b4lck4q75z5oopym@box.shutemov.name>
References: <alpine.LSU.2.11.2106011353270.2148@eggly.anvils>
 <alpine.LSU.2.11.2106011403540.2148@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2106011403540.2148@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 02:05:45PM -0700, Hugh Dickins wrote:
> Stressing huge tmpfs page migration racing hole punch often crashed on the
> VM_BUG_ON(!pmd_present) in pmdp_huge_clear_flush(), with DEBUG_VM=y kernel;
> or shortly afterwards, on a bad dereference in __split_huge_pmd_locked()
> when DEBUG_VM=n.  They forgot to allow for pmd migration entries in the
> non-anonymous case.
> 
> Full disclosure: those particular experiments were on a kernel with more
> relaxed mmap_lock and i_mmap_rwsem locking, and were not repeated on the
> vanilla kernel: it is conceivable that stricter locking happens to avoid
> those cases, or makes them less likely; but __split_huge_pmd_locked()
> already allowed for pmd migration entries when handling anonymous THPs,
> so this commit brings the shmem and file THP handling into line.
> 
> Are there more places that need to be careful about pmd migration entries?
> None hit in practice, but several of those is_huge_zero_pmd() tests were
> done without checking pmd_present() first: I believe a pmd migration entry
> could end up satisfying that test.  Ah, the inversion of swap offset, to
> protect against L1TF, makes that impossible on x86; but other arches need
> the pmd_present() check, and even x86 ought not to apply pmd_page() to a
> swap-like pmd.  Fix those instances; __split_huge_pmd_locked() was not
> wrong to be checking with pmd_trans_huge() instead, but I think it's
> clearer to use pmd_present() in each instance.
> 
> And while there: make it clearer to the eye that the !vma_is_anonymous()
> and is_huge_zero_pmd() blocks make early returns (and don't return void).
> 
> Fixes: e71769ae5260 ("mm: enable thp migration for shmem thp")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Looks like a two fixes got squashed into one patch. Zero-page fix and
migration entries in __split_huge_pmd_locked() deserve separate patches,
no?

Maybe add VM_BUG_ON(!pmd_present()) in is_huge_zero_pmd()?

Also I wounder how much code we can remove if we would not establish
migration ptes for file pages. We can make these page table entries 'none'
on migration.

-- 
 Kirill A. Shutemov
