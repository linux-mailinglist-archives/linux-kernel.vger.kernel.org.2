Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9F241B2A9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 17:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241518AbhI1PLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 11:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241511AbhI1PLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 11:11:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37026C061746
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 08:09:31 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y26so54727568lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gd9aW239q/YhSWzuMjswj8d/RtAC3PBQOLCe3Y0Z9ys=;
        b=fL1b2viol9Jp98joQ5vyJowkZz6IP2I8rZ4pv5qfA6Lg1eYEdwrcLte/1JTWSFPoMp
         AqgnpWbzqHiSsJbKJrUAmsLif2LBakQaiJwUveTr9YXGY7HLqpghGB9dmrcLZSL11xW8
         Ob6xDbiNBUrVlDctmCEpOjsUOsgaBlLpnz9I6fFR7c9R5I7xHNpvwTATvGL1mwyCJfd2
         RmGt+c22QiEPp0RYEUuWQqkrra3JTgw6KcFo57jDHyvNqI3k1vW9wlgDvwtLCqvZqeQk
         WugkiZ6c2yr58uHyW8vfBbND/RSB85tTkCVU/j/IYbQ1RIpCBe2/LcgObWQ9gb93YbsK
         qf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gd9aW239q/YhSWzuMjswj8d/RtAC3PBQOLCe3Y0Z9ys=;
        b=AJuADUjVd3YkgWtsHiv4T/RyWGxlXyMNDqlsFL7NtkG4edCpkZgE8yv0aTiVT22Lpn
         576Ma/LSUOXwhM9jp7Fz2pLFfERjFd79xdezpMkQuk2nAAswVssu8gvnxPfWYopFjp3o
         KaJxV4fkiU4B8trl+Rqf2L85hfbdXJyrezRxB2A7eNkXhKYJ0kW2k61GRvHLIqj2Qytj
         WjlZS7kmtrCNXB5uXCfMykOSJbYkFUKaVdOIcNsAWFH8mjNzmwVS4xPbxioF8XZ3yezx
         2HVTECgCAtd9r3/KSfvooqRTIhDiHVixHFpQtO5JPKrYHd1XGfvZeXHJgZuHIOaMBOVm
         2+kw==
X-Gm-Message-State: AOAM530+xuOpp8dWqdHg27Xc/vZnmKSyCoBcEU2whbS1WO6FejHfDcjs
        hrJUdHxorb9UXvk9zvxwEyijcWZ4lSI1tlpLLtNsNg==
X-Google-Smtp-Source: ABdhPJz7y7Ri4Kt1pHJT1qGblaLtZEU8d3lQS2bBywZIf/J0eHDf7OnYJ6rXLIspQ2U/kA8XzIkT3OMF6lVZz/F3LD0=
X-Received: by 2002:a2e:9591:: with SMTP id w17mr495968ljh.40.1632841769323;
 Tue, 28 Sep 2021 08:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210927122646.91934-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20210927122646.91934-1-wangkefeng.wang@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Sep 2021 08:09:17 -0700
Message-ID: <CALvZod568vL3Eg54srOKVg+TMtuPpLJhxbqGi7HS2oaMLUXvAQ@mail.gmail.com>
Subject: Re: [PATCH v2] slub: Add back check for free nonslab objects
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 5:24 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> After commit ("f227f0faf63b slub: fix unreclaimable slab stat for bulk
> free"), the check for free nonslab page is replaced by VM_BUG_ON_PAGE,
> which only check with CONFIG_DEBUG_VM enabled, but this config may
> impact performance, so it only for debug.
>
> Commit ("0937502af7c9 slub: Add check for kfree() of non slab objects.")
> add the ability, which should be needed in any configs to catch the
> invalid free, they even could be potential issue, eg, memory corruption,
> use after free and double-free, so replace VM_BUG_ON_PAGE to WARN_ON, add
> dump_page() and object address printing to help use to debug the issue.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> v2: Add object address printing suggested by Matthew Wilcox
>
>  mm/slub.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 3095b889fab4..157973e22faf 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3522,7 +3522,11 @@ static inline void free_nonslab_page(struct page *page, void *object)
>  {
>         unsigned int order = compound_order(page);
>
> -       VM_BUG_ON_PAGE(!PageCompound(page), page);
> +       if (WARN_ON(!PageCompound(page))) {

If there is a problem then this would be too noisy. Why not WARN_ON_ONCE()?

> +               dump_page(page, "invalid free nonslab page");
> +               pr_warn("object pointer: 0x%p\n", object);

Actually why not add 'once' semantics for the whole if-block?

> +       }
> +
>         kfree_hook(object);
>         mod_lruvec_page_state(page, NR_SLAB_UNRECLAIMABLE_B, -(PAGE_SIZE << order));
>         __free_pages(page, order);
> --
> 2.26.2
>
