Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8D3437C04
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhJVRhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhJVRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:37:44 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB72C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:35:25 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id t16so8026660eds.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 10:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0LsY62/6ngRxgBm83XOe/sLH1xiASl+MCqBfNsQpWM4=;
        b=OrVfoA3XmZ4DoVxt5np5xkuJvsdRgNM+UFT10jbqCO3nX6qm4x6HQEA90/sCdygDpT
         x9L4JL2uMUZ18jS201ebx2cgl272C+5+vU+Blj+bNf79jatrZLRlDsJuS7vNohx0qIGF
         ro6/INmr/McVV3fEDqZ1PIQsvaGRv8KHvuJBqDuPqWw8W65RoBw+9wAxgKCv0GrLEsck
         jQf21P4eOSh90YUHDt7aDPjg/5R+cvkH16L4iyVxw7xAPMhl7Tkt9Yh6RhtlL1Nkv9XC
         gmC/BpTTcEvbRjfacy910dNPGtq6M0jDgg88m9UMpMTy8DzXhFljy3oOUO2wnip82QEH
         9TMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0LsY62/6ngRxgBm83XOe/sLH1xiASl+MCqBfNsQpWM4=;
        b=xAUy5csXpJVEw6XtpgysEtkoXa6mKpAiXaXgbRtDVOHRVlqZGzXFms5NC2Ep5+XfXh
         L0FWQ6lkhxccKpjckivQeIm5emYJv5tUJ31d8yJya0xGk1OmnZET45ZaKgfwjsf6NItv
         /Dp5+0xpwVqYn/X7HKwI69cU0l6j7n7QjGuLZsByyoMen/o9+0wrpyAuYlwNRBCxqyYj
         cJBvxt3tgj/AWTiEDRA6eeiBDI1YFp/Y2/LLYjxUnutfK0MEkxaES+1e8VwYriOiJ4Jk
         Z7afLihaYjJ4E23OvfggD2ys1cthxEXZpnPL9jc6VlKJS/Dk+oHM4rgXc7xCWopHgGpw
         Fixg==
X-Gm-Message-State: AOAM530qG0L2hJBdMUOzQIKEZbxauYrw/xgjKZYT00ewpjSN8hTqSOKJ
        nrYsrTetXqPUrKT5+E9weqZldg5x2a0jP/b7I1Q=
X-Google-Smtp-Source: ABdhPJxxf08bQnWK9iyBxH6jyfKFHYh+LVlZXczmhWgCNu3dgWfTfUnavjgLaGgEBdD9QI3Y2JliEFvL7gZNv9sWBe0=
X-Received: by 2002:aa7:de83:: with SMTP id j3mr1809459edv.312.1634924124380;
 Fri, 22 Oct 2021 10:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211022064748.4173718-1-arnd@kernel.org>
In-Reply-To: <20211022064748.4173718-1-arnd@kernel.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 22 Oct 2021 10:35:12 -0700
Message-ID: <CAHbLzkrQVcVL6UtDf6cwvTshFT25uGZVn_DKL_=RCU7KR=wV3w@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem: fix uninitialized variable use in me_pagecache_clean()
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Oscar Salvador <osalvador@suse.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 11:47 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> It appears that the has_extra_refcount() is now in the wrong place:
>
> mm/memory-failure.c:892:6: error: variable 'extra_pins' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (!mapping) {
>             ^~~~~~~~
> mm/memory-failure.c:915:32: note: uninitialized use occurs here
>         if (has_extra_refcount(ps, p, extra_pins))
>                                       ^~~~~~~~~~
> mm/memory-failure.c:892:2: note: remove the 'if' if its condition is always false
>         if (!mapping) {
>         ^~~~~~~~~~~~~~~
> mm/memory-failure.c:879:6: error: variable 'extra_pins' is used uninitialized whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (PageAnon(p)) {
>             ^~~~~~~~~~~
> mm/memory-failure.c:915:32: note: uninitialized use occurs here
>         if (has_extra_refcount(ps, p, extra_pins))
>                                       ^~~~~~~~~~
> mm/memory-failure.c:879:2: note: remove the 'if' if its condition is always false
>         if (PageAnon(p)) {
>         ^~~~~~~~~~~~~~~~~~
> mm/memory-failure.c:871:17: note: initialize the variable 'extra_pins' to silence this warning
>         bool extra_pins;
>                        ^
>                         = 0
>
> In both of those cases, we already set an error code and don't
> need to override that one.

Hi Arnd,

Thanks for catching this. There has been a fix
(https://lore.kernel.org/linux-mm/20211021180336.2328086-1-nathan@kernel.org/).
But I think yours makes more sense. It seems better to have the "out:"
label after has_extra_refcount().

Andrew,

Could you please take this patch? And either keeping or dropping
Nathan's patch is fine to me. Thanks.

>
> Fixes: d882a43a0011 ("mm: shmem: don't truncate page if memory failure happens")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is caused by a commit im -mm, so the commit ID is not stable.
> If the fix is correct, I'd suggest folding it into the original
> change
> ---
>  mm/memory-failure.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 3b04f0361a58..e8c38e27b753 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -909,12 +909,12 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
>          * Open: to take i_rwsem or not for this? Right now we don't.
>          */
>         ret = truncate_error_page(p, page_to_pfn(p), mapping);
> -out:
> -       unlock_page(p);
> -
>         if (has_extra_refcount(ps, p, extra_pins))
>                 ret = MF_FAILED;
>
> +out:
> +       unlock_page(p);
> +
>         return ret;
>  }
>
> --
> 2.29.2
>
