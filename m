Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF55346711
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhCWR7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhCWR66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:58:58 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7811DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:58:58 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r12so28586264ejr.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hcso62Cwuwa8e074vVIkc2Y/lBuLyaEVj57l1knVuck=;
        b=kSu1qZu/6KIwGQOL78KtzGiGXVngtGo32objrxmPa99ZKbN+0ks597f3rZiIdISZoy
         Y/y50+y3Vw/p1yCApyQA8nHVe6Z7nILZe7FJcfH4XGGe+uVXdfUZkt0RMBIT9jWktrmN
         ewhLtOHhervZs5hP63XmYCxfEXWzt8Io9Xedy//7w4WIzb9KvFAwKyzTpeKIztPloMJy
         03Rjxw825hOSiA4ICwYNIwPJMZehDQjA/lFRjOMfUQuPn3NljnEYO0tqg5PeqBW585Bw
         2lb+QFVY5v0/pBBhDnV/ykctWhKKbyFwsW01o/a+4EeVQSz+Z9mc9wN9N/CW7CbXD2+C
         DFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hcso62Cwuwa8e074vVIkc2Y/lBuLyaEVj57l1knVuck=;
        b=anm/xxYNf+SxFY+X1rmdVoNvJJI8hz6J2eTK/UOqllmUZonOFqbE9kXMKFPeDdjlWr
         sF1DLa6vDoddkpSDQoYC5k7T9d0zrvVPCFXvO9seiNoTNWFSzJBrP19xT0B7T7Wl3Jsj
         +7LxrjGqryPcSwuB3BA0oa8tlpzs97Ng63HL9w5YGqHpfA99xDEhRWP0XeTuVb6xJpPl
         VZOk7ACd6098l1e+jUgmmywfz6MVFLzPiGUah63rEq/mAmJCunwCdRjl1sVPFAdmvZ+Z
         bASHSEdz5qRLCMxhiQ30Rm6L6v5giGBKQO4WHDYadJWRhJ9IxN49iXBtLvVHul5Hw+AQ
         5YLg==
X-Gm-Message-State: AOAM5334F8qZX2Tvx7XEY9Tg7oLU3iLCEAf00SG8rFEcf1J6Kz93fb2S
        kI34QMp12Hh5+tHeq5FDJXljehw/fASvNBnbNlB1PL2fKpg=
X-Google-Smtp-Source: ABdhPJyChTK0RiirCrD6IZ+vQGYCcPU/l3grbGZmk73eHVPYuK/g8Jb28ZnzKnPLt6CPQaewml8UzL692IW58C2UmVM=
X-Received: by 2002:a17:906:789:: with SMTP id l9mr6079486ejc.161.1616522337166;
 Tue, 23 Mar 2021 10:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210323135405.65059-1-linmiaohe@huawei.com> <20210323135405.65059-2-linmiaohe@huawei.com>
In-Reply-To: <20210323135405.65059-2-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 23 Mar 2021 10:58:45 -0700
Message-ID: <CAHbLzkrde4fMZtt7g+5HJ8PftwwDBvg-8b=W4F_64_EK-CusUA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mm/migrate.c: remove unnecessary VM_BUG_ON_PAGE on putback_movable_page()
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 6:54 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> The !PageLocked() check is implicitly done in PageMovable(). Remove this
> explicit one.

TBH, I'm a little bit reluctant to have this kind change. If "locked"
check is necessary we'd better make it explicit otherwise just remove
it.

And why not just remove all the 3 VM_BUG_ON_PAGE since
putback_movable_page() is just called by putback_movable_pages() and
we know the page is locked and both PageMovable and PageIsolated is
checked right before calling putback_movable_page().

And you also could make putback_movable_page() static.

> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/migrate.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 47df0df8f21a..facec65c7374 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -145,7 +145,6 @@ void putback_movable_page(struct page *page)
>  {
>         struct address_space *mapping;
>
> -       VM_BUG_ON_PAGE(!PageLocked(page), page);
>         VM_BUG_ON_PAGE(!PageMovable(page), page);
>         VM_BUG_ON_PAGE(!PageIsolated(page), page);
>
> --
> 2.19.1
>
