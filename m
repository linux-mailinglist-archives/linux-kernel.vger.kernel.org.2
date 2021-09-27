Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AB54193B1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 13:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhI0L4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 07:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbhI0L4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 07:56:48 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210D7C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 04:55:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i4so76290996lfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 04:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DS5KVI0MI3urzxy+Dr1c8uCppaGchpddwzrmXVrMjZw=;
        b=cQvdOnUkyhSPNzgh4Wudd6h8B02zdpU4K7tSFEUUhp0dws6UouuWJi+cxD0kvJFMoZ
         NwMiIC/K24a4LRk6LE2ewO8tO1YgqceTgui7RHon2GlaZ5bk6v4bL+wBVX6EpJoQkPaV
         WYyhwxWv6r40e6cMQyPT8+qPaCfj//7a8RGg8O905rCqUvL/ufW+fx1w8BDNuxA7uSe9
         FRF8+xgRNxR25AFQpGRRobbWp+VWribppnUjhJQ5mvbL1arcTkfJ74mcT9qmxhEPnOvW
         F/+w0VEXbr3dOVwplmKTzVnFkgQbKd8o5P9vj9dH6lj10g6Vxri4I7yg90cGTxMEXZiI
         7kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DS5KVI0MI3urzxy+Dr1c8uCppaGchpddwzrmXVrMjZw=;
        b=D7e3+oaqzudw+bxyzhd2CD/YniH3CVWih2pXLT0E3mJBQamCcBBzrT3sRh6QQ0G+qi
         OqISM2/PsSoRzW6hafQQmaYjrJrm7ZA6FfUnrOtdsg3Yz3ZWORGczMciBQmuI8UVwdzH
         FXTNTlFAcKrjB3KhldyZ2yn8vkK7EBD66w6/juFThDJ1ZRw2pfsErqzTpkrKT/KSvrEt
         GhnFSi31ln9gKcSrPNewFte0WmDm0nK2bKsYTAjA3NkZJuGlo2Y4HBjmfksDVjnt6p09
         mBMbuxfDCC0v11MjmF5gEnn4Yg05v8ZW45Nf0ipsBawSRQapIT/ku7EnIUicaO9j1LpY
         a4nA==
X-Gm-Message-State: AOAM533V9AxMtkm6yax9BfnGbRqCgyy55he+b0XTlMX+o8tQnJTMKu8x
        /TCscVpYXzwOFbovyFFYcn8dDA==
X-Google-Smtp-Source: ABdhPJxk5GpozFMxWdpW/k7DbdIGJqQW2CyjZzhWKCVp8cH1dBvyXn+qf5X9RIP4VUFMj9EiPhdCKw==
X-Received: by 2002:a05:6512:b0f:: with SMTP id w15mr23568038lfu.164.1632743708091;
        Mon, 27 Sep 2021 04:55:08 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v26sm1954224lja.22.2021.09.27.04.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 04:55:07 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 1AD8F102FD9; Mon, 27 Sep 2021 14:55:07 +0300 (+03)
Date:   Mon, 27 Sep 2021 14:55:07 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Colin Cross <ccross@google.com>,
        Suren Baghdasarya <surenb@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/8] mm/madvise: propagate vma->vm_end changes
Message-ID: <20210927115507.6xfpugeg3swookbh@box>
References: <20210926161259.238054-1-namit@vmware.com>
 <20210926161259.238054-2-namit@vmware.com>
 <20210927090852.sc5u65ufwvfx57rl@box.shutemov.name>
 <A923D77C-8C45-41B0-A1B2-55F68168D058@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A923D77C-8C45-41B0-A1B2-55F68168D058@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 03:11:20AM -0700, Nadav Amit wrote:
> 
> > On Sep 27, 2021, at 2:08 AM, Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > 
> > On Sun, Sep 26, 2021 at 09:12:52AM -0700, Nadav Amit wrote:
> >> From: Nadav Amit <namit@vmware.com>
> >> 
> >> The comment in madvise_dontneed_free() says that vma splits that occur
> >> while the mmap-lock is dropped, during userfaultfd_remove(), should be
> >> handled correctly, but nothing in the code indicates that it is so: prev
> >> is invalidated, and do_madvise() will therefore continue to update VMAs
> >> from the "obsolete" end (i.e., the one before the split).
> >> 
> >> Propagate the changes to end from madvise_dontneed_free() back to
> >> do_madvise() and continue the updates from the new end accordingly.
> > 
> > Could you describe in details a race that would lead to wrong behaviour?
> 
> Thanks for the quick response.
> 
> For instance, madvise(MADV_DONTNEED) can race with mprotect() and cause
> the VMA to split.
> 
> Something like:
> 
>   CPU0				CPU1
>   ----				----
>   madvise(0x10000, 0x2000, MADV_DONTNEED)
>   -> userfaultfd_remove()
>    [ mmap-lock dropped ]
> 				mprotect(0x11000, 0x1000, PROT_READ)
> 				[splitting the VMA]
> 
> 				read(uffd)
> 				[unblocking userfaultfd_remove()]
> 
>    [ resuming ]
>    end = vma->vm_end
>    [end == 0x11000]
> 
>    madvise_dontneed_single_vma(vma, 0x10000, 0x11000)
> 
>   Following this operation, 0x11000-0x12000 would not be zapped.

Okay, fair enough.

Wouldn't something like this work too:

diff --git a/mm/madvise.c b/mm/madvise.c
index 0734db8d53a7..0898120c5c04 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -796,6 +796,7 @@ static long madvise_dontneed_free(struct vm_area_struct *vma,
 			 */
 			return -ENOMEM;
 		}
+		*prev = vma;
 		if (!can_madv_lru_vma(vma))
 			return -EINVAL;
 		if (end > vma->vm_end) {
-- 
 Kirill A. Shutemov
