Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660583A10F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbhFIKUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:20:53 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:33663 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbhFIKUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:20:51 -0400
Received: by mail-lf1-f54.google.com with SMTP id bp38so1611906lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 03:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y5H3xdrFCtT+zIBCvSEw1ClNsNs33iJyTdKSFIVrrUQ=;
        b=I85F3WMKczUz3C59XfYhQ1TdD7kgKU3+AspHxTKvXvW8CbqCN5BYLwZvic+j7tKoIc
         CrehTi7wwg/dDURvFycGfPGo+0DPS5IkXtgiAmRN/8MrgJlM2Y+WHAXw9gJPS6eYM9Pp
         xStGkFmEU4OaZ9bMbrz+OGa5B87tYUtlBOd/Rtu5hELXFVNJajs2S1JPkEpKmWcPZ7SH
         Vt61TqoYVmMSDQL7xlJE6rUW1fZ/oIpJl04qTOXoPvzz824RDaiqg726Nlht0vmjs6xb
         rGSYKXAChqNkDdu6c90UCs04cA2pcq9/MUuUZY75remOSwwzDLfpW9ZclklCfxLnKUYX
         S6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y5H3xdrFCtT+zIBCvSEw1ClNsNs33iJyTdKSFIVrrUQ=;
        b=eykXvRFw6N0pXNSg9huQrJcuZ33cpyAfPYRUM7+NgEy6Cfd5+bm74AX4ZfUZCIAfp/
         +R/how3zVANJYCu9ZVFslgzxotLNwE4sVxaGhob515gU29ywYyAMG1PJ4YptDjWM5D7u
         22iCkzdxtLyOKrNTrBs6VOzizy0j0TtVFz+3TTy9ekFYtr6zWhxnfYiYe4ZAhY0xaq+l
         J1WpBPuj1SELRIPbUzg8b2a3I7e/nbjlvrB6X5JJXNAYYYF+JFub/UvJH8jP9Bo0b+wd
         DHeiTD34yUx2IKFrUewOB1dbD5sa8OYOpVme2PwBX8DITEj/uWiIA8Mz0ajRZZxPOc3U
         rM+w==
X-Gm-Message-State: AOAM532DN3r7aHm/B+KvrEcgRP5VUul+s1j9ga7KnjQ7eg1HZDt+fR1f
        MaYZ81FFWRdmsWPydHB2uL/G+vYaE1vNEQ==
X-Google-Smtp-Source: ABdhPJxrYPrs0ETTNrQOUz1CD8zTWl/qbGYryu5H0HHzHz45zziE8waXsB1Q+QyYDfK6vrZ5fv1wIA==
X-Received: by 2002:ac2:5448:: with SMTP id d8mr14796359lfn.100.1623233864931;
        Wed, 09 Jun 2021 03:17:44 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e29sm301738lfb.258.2021.06.09.03.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 03:17:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B19D910265B; Wed,  9 Jun 2021 13:17:59 +0300 (+03)
Date:   Wed, 9 Jun 2021 13:17:59 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] mm/thp: fix __split_huge_pmd_locked() on shmem
 migration entry (fwd)
Message-ID: <20210609101759.fygmcxcj2jcruoiv@box.shutemov.name>
References: <59d94b4-c0dd-310-894-be99416f3c92@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59d94b4-c0dd-310-894-be99416f3c92@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 09:05:21PM -0700, Hugh Dickins wrote:
> 
> 
> ---------- Forwarded message ----------
> Date: Tue, 8 Jun 2021 21:00:12 -0700 (PDT)
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
> Subject: [PATCH v2 01/10] mm/thp: fix __split_huge_pmd_locked() on shmem
>     migration entry
> 
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
> And while there: use old_pmd rather than _pmd, as in the following blocks;
> and make it clearer to the eye that the !vma_is_anonymous() block is
> self-contained, making an early return after accounting for unmapping.
> 
> Fixes: e71769ae5260 ("mm: enable thp migration for shmem thp")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: <stable@vger.kernel.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>


-- 
 Kirill A. Shutemov
