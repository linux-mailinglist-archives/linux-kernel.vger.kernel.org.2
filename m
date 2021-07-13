Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741C43C6B33
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhGMH2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhGMH2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:28:41 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3259EC0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 00:25:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1110883wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 00:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kLualirFuyhQUpkaVrxmK4ztlGCjktHhBFIVEYAPxQA=;
        b=B6JoVQ10aBH7JgQIPgclYZz/ClgL8rZS6NnNn0MJJx5542fP+YvEhJuBp8gX/OHzYU
         tAHBSrs6ehVkF3aAzxUi6wpTooE7i8UFm+tQHDs1Zryv9LO03qAxRUmcw/PEYkwhhfdV
         CPUC4th7fTEU0KrX1cHvPwSPA5HuBPyPTB/2J6P3RhK3Rtbypp1OsSnCYXFFkGZRcmWj
         /5Ed+1GtccitTvrmqzkYKIkSNCElk90Vtsp/vMdMLAOrlgN9jcWyqixQrXGtK4JkPMuI
         DfY9I0JvR5DF68cEGRNMakc3C63my1ooWqTEP04pLx52uZr6HRsxbM42Hr0KTmasB7+0
         +jRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kLualirFuyhQUpkaVrxmK4ztlGCjktHhBFIVEYAPxQA=;
        b=J9x008jtgaeuVItdnzwze5/DTblmA4qqVy/xjg0A83kKAo3t7o1lsA7DplLGJPNV2L
         XqTQb83dA+p/ncV+/+TrqLnQl7CkilMt/03Ki8wWA5U6hH6q9B9z0004kVi5xXKHFJ3W
         3aeH9o8/Q9j5jCCvV3RjoudMQ/spufUbbeka3TJRwRCMJ09BMqlrj9igNfeUNoHy9cl2
         keN/6dn+r7j8wm9KkIyEE75cHFy217UsKL+3aX10YhWM91/CKBPe2hBJcdknDtueg6xK
         +lBjjVIy2j4wxMWKz8ObJLB4biJ54FX2pWSt/RbQQyRLFvudwxV3bXxx0Gvu3mB0a4Fl
         Ulbg==
X-Gm-Message-State: AOAM532/HSTfTGplnTy3R/N3RaqgeMdNx2bt8m7qH4v9NrVaD6bLrBSE
        VSWESg83c3Q551zGuvKaVadxXh53+mSF9ZHGCvBjTw==
X-Google-Smtp-Source: ABdhPJy7wtIfW5cpn6NEXGfuHWRX0BJTvr5N+bXGIcHsnRGt8TIWuqQu2RmlLybXvnHW9/zzVKVV0WmKkaGbrEsQM+E=
X-Received: by 2002:a05:600c:2197:: with SMTP id e23mr3397905wme.101.1626161150645;
 Tue, 13 Jul 2021 00:25:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210710100329.49174-1-linmiaohe@huawei.com> <20210710100329.49174-2-linmiaohe@huawei.com>
 <CAOUHufZpU4uQOBb4p10uCXs-40MeETRUmGiqy96Eim1w3o_dgQ@mail.gmail.com> <022f2f7c-fc03-182a-1f8f-4b77c0731d4f@huawei.com>
In-Reply-To: <022f2f7c-fc03-182a-1f8f-4b77c0731d4f@huawei.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 13 Jul 2021 01:25:39 -0600
Message-ID: <CAOUHufaEPKj4VU1qbjuqsr53rjVwhEXdRCC_C=LBOF0KTveBfQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm/vmscan: put the redirtied MADV_FREE pages back to
 anonymous LRU list
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Alex Shi <alexs@kernel.org>, apopple@nvidia.com,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>, shli@fb.com,
        hillf.zj@alibaba-inc.com, Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 1:12 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2021/7/11 7:22, Yu Zhao wrote:
> > On Sat, Jul 10, 2021 at 4:03 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
> >>
> >> If the MADV_FREE pages are redirtied before they could be reclaimed, put
> >> the pages back to anonymous LRU list by setting SwapBacked flag and the
> >> pages will be reclaimed in normal swapout way. Otherwise MADV_FREE pages
> >> won't be reclaimed as expected.
> >>
> >> Fixes: 802a3a92ad7a ("mm: reclaim MADV_FREE pages")
> >
> > This is not a bug -- the dirty check isn't needed but it was copied
> > from __remove_mapping().
>
> Yes, this is not a bug and harmless. When we reach here, page should not be
> dirtied because PageDirty is handled above and there is no way to redirty it
> again as pagetable references are all gone and it's not in the swap cache.
>
> >
> > The page has only one reference left, which is from the isolation.
> > After the caller puts the page back on lru and drops the reference,
> > the page will be freed anyway. It doesn't matter which lru it goes.
>
> But it looks buggy as it didn't perform the expected ops from code view.
> Should I drop the Fixes tag and send a v2 version?

I don't understand the logic here -- it looks pretty obvious to me
that, if we want to change anything, we should delete the dirty check,
not add another line that would enforce the belief that the dirty
check is needed.

>
> Many thanks for reply!
>
> >
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  mm/vmscan.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/mm/vmscan.c b/mm/vmscan.c
> >> index a7602f71ec04..6483fe0e2065 100644
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -1628,6 +1628,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
> >>                         if (!page_ref_freeze(page, 1))
> >>                                 goto keep_locked;
> >>                         if (PageDirty(page)) {
> >> +                               SetPageSwapBacked(page);
> >>                                 page_ref_unfreeze(page, 1);
> >>                                 goto keep_locked;
> >>                         }
> >> --
> >> 2.23.0
> >>
> >>
> > .
> >
>
