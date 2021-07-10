Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DF23C3742
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 01:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhGJXZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 19:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJXZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 19:25:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A209C0613DD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 16:22:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t5so4397366wrw.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jul 2021 16:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gcgwEK9v8zSJpfd9VO+CBZNaSHgtLXE//p5WtR3lQCE=;
        b=u7OZRqdEPoGfT0m2KXNCC3xIq9WDPM14rVfz8wiLwaDmE34H20bLYqlaYuPYf3mblc
         VzlOCBUn8Ty0sUSK6NsqCDxMqlaoDswLtdRnddlvWzS2ExOOiFCWYaZcSVTH99hIMQgQ
         2Zz04kYyCM3a2wtHQ49KqONAyYDbAmt+HKDPfkRlFygOrYjFDVB2MeLE4A/LlKrBJCCO
         Vtb5DAG0z9v5pQ4KaMvRluN618AMoAqVQG7ZoMSYUOkvIXc+u/9NPXiRn9H8yRtpzlB+
         5NK9g+fl3y571sInt9wucy6ZmjiRjfnHho+GIF88O9BFHj84yj/3RzEACasMWUlz1oVg
         IkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gcgwEK9v8zSJpfd9VO+CBZNaSHgtLXE//p5WtR3lQCE=;
        b=CqPRmcDMtGQ9cn+QMXFSw7UZKU7q2IHOBAz9CqnXb72xn2Rc/5N2fRZlb6rih0TrO/
         aLF6XCxAavpRw6Ted1Z8pax6CFtLuiFPbMHYB6UtsQVNfwIj9YvY4nmTznc6jp3pPZoK
         BtsWMED/EI4NdgGrMWyjX/ZMVhaF4Lh8Y+9qRanngF3CfuPx07fpeeOwVwMEnu9Iftyd
         N1zvgyJJIJbQyFVkmX1HZ9dtfTDBzrOAhJpQrh+TQ9/gLHFsMhulwTNa89yLIkgyHxpW
         t2/QoQdoH6ugVrAhxNhY/EJ7hNM+MioRDKNBhYiPLEBN1PtubDJudkRqkIXshq6LlpAQ
         VmkA==
X-Gm-Message-State: AOAM532N0WKO3fu4ybDWJwN5uwt4XHNcYyq1v5U8HfnpqXd7JDiy5QMZ
        JrKd4vwLc5Q8jzk2q9JZav+PA1PwrtuqPrFD6eMKrA==
X-Google-Smtp-Source: ABdhPJyjr2o2lYXOyUK90eGM8IbPtj8nRqDe5TB/NwNXIs0rrp5e2+ttpPWkCyymzklnKNiXGJscC0zFu6uE7PvUf84=
X-Received: by 2002:adf:cf10:: with SMTP id o16mr18394680wrj.426.1625959377659;
 Sat, 10 Jul 2021 16:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210710100329.49174-1-linmiaohe@huawei.com> <20210710100329.49174-2-linmiaohe@huawei.com>
In-Reply-To: <20210710100329.49174-2-linmiaohe@huawei.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 10 Jul 2021 17:22:46 -0600
Message-ID: <CAOUHufZpU4uQOBb4p10uCXs-40MeETRUmGiqy96Eim1w3o_dgQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm/vmscan: put the redirtied MADV_FREE pages back to
 anonymous LRU list
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, vbabka@suse.cz,
        mhocko@suse.com, axboe@kernel.dk, iamjoonsoo.kim@lge.com,
        alexs@kernel.org, apopple@nvidia.com, willy@infradead.org,
        minchan@kernel.org, david@redhat.com, shli@fb.com,
        hillf.zj@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 10, 2021 at 4:03 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> If the MADV_FREE pages are redirtied before they could be reclaimed, put
> the pages back to anonymous LRU list by setting SwapBacked flag and the
> pages will be reclaimed in normal swapout way. Otherwise MADV_FREE pages
> won't be reclaimed as expected.
>
> Fixes: 802a3a92ad7a ("mm: reclaim MADV_FREE pages")

This is not a bug -- the dirty check isn't needed but it was copied
from __remove_mapping().

The page has only one reference left, which is from the isolation.
After the caller puts the page back on lru and drops the reference,
the page will be freed anyway. It doesn't matter which lru it goes.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/vmscan.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a7602f71ec04..6483fe0e2065 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1628,6 +1628,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>                         if (!page_ref_freeze(page, 1))
>                                 goto keep_locked;
>                         if (PageDirty(page)) {
> +                               SetPageSwapBacked(page);
>                                 page_ref_unfreeze(page, 1);
>                                 goto keep_locked;
>                         }
> --
> 2.23.0
>
>
