Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26866340C37
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhCRRyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbhCRRyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:54:21 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12259C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:54:21 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id q29so5912764lfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w1oPFphg57L7sKY8E1r5PCzrWzBNsxoEQAATZVD3hgA=;
        b=l9E1bj0g3MduMzjWqj+A9CW3VpVKUNZFOoxRnPrmPthOW7VFLBGflmrOr5m0Xk0k3b
         6/AS1LT9eiU56I6ayLhio6mlLoSQWJ0cCQ/6SGY7W2i6MTkVaATL39n+9BHzqgSYqv78
         GUmzyva0m9ohnjC4GM64UWXVrw7kteaJdSLC0Svr+kRuJbiSf50HrtMwQcBr1PruNYJU
         Z/jd1sMvKIEMTXLbjdY/ld691bUoouezgDObfUaxNuYWWuOFRz1/66obCR7Nj8yjlSic
         NQIi8A0hFU/EMNnKfH5gU7df2F/a0DpTuxzE7B3BsIdL6GzNmoHri89WhQZFGORjnoly
         TzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1oPFphg57L7sKY8E1r5PCzrWzBNsxoEQAATZVD3hgA=;
        b=KF4eKox8R0i4PIXYqycn6WaWS+5H8lbc52dzYO00veqaVy+qphqHfg893Y2uQIbWf3
         J6bRadrbzrqDkQU7k9cPPhPA3Km4yR1ONrE2dUIkwojbe6VecpNU7asDFgY7D1WIEkbZ
         aEhWfeMTLDsfOBwJnkjHnvrPnA+s9t79662sEJeWuATLqNt/Ecq38quujVpQx7oqQPho
         Yr/vnWAIBjwfK0Dl95dan8iLn1nDAzOrKM55+qD2iVbntrGhFkOyDAnbAtdWLPZazhx5
         1Ws7z5ryknPequiSKHCEwjxMO40DAJj9njm231/L6pbpjI55TrDJyCWMLrjsTuSS9xVY
         p1aQ==
X-Gm-Message-State: AOAM530mOKN0xxy7C3AtcmAzJNQvvD0kFNhOSbNLaPalp/HD1a3tKCHR
        S8jkY+KfAYoNIaxVge57yhIZWmbZMUWg35oDxGZwcw==
X-Google-Smtp-Source: ABdhPJx48LkaTKcfJuDXxDL4wH2SxQKU34E29bTgFkad1AodSgUxuvgjjShP6mRtZiSQISRaUK2vJpqUE56pEbbrE14=
X-Received: by 2002:a19:e0d:: with SMTP id 13mr5976627lfo.549.1616090059182;
 Thu, 18 Mar 2021 10:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210318171720.61a3f59c@canb.auug.org.au>
In-Reply-To: <20210318171720.61a3f59c@canb.auug.org.au>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 18 Mar 2021 10:54:08 -0700
Message-ID: <CALvZod7iPJ1h0MVpBwNkqJBfNNWPb+x93q59okdK5oxevzbP_g@mail.gmail.com>
Subject: Re: linux-next: manual merge of the akpm-current tree with the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 11:17 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the akpm-current tree got a conflict in:
>
>   mm/memcontrol.c
>
> between commit:
>
>   06d69d4c8669 ("mm: Charge active memcg when no mm is set")
>
> from the block tree and commit:
>
>   674788258a66 ("memcg: charge before adding to swapcache on swapin")
>
> from the akpm-current tree.
>
> I fixed it up (I think - see below) and can carry the fix as necessary.
> This is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc mm/memcontrol.c
> index f05501669e29,668d1d7c2645..000000000000
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@@ -6691,65 -6549,73 +6550,80 @@@ out
>    * @gfp_mask: reclaim mode
>    *
>    * Try to charge @page to the memcg that @mm belongs to, reclaiming
>  - * pages according to @gfp_mask if necessary.
>  + * pages according to @gfp_mask if necessary. if @mm is NULL, try to
>  + * charge to the active memcg.
>    *
> +  * Do not use this for pages allocated for swapin.
> +  *
>    * Returns 0 on success. Otherwise, an error code is returned.
>    */
>   int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
>   {
> -       unsigned int nr_pages = thp_nr_pages(page);
> -       struct mem_cgroup *memcg = NULL;
> -       int ret = 0;
> +       struct mem_cgroup *memcg;
> +       int ret;
>
>         if (mem_cgroup_disabled())
> -               goto out;
> +               return 0;
>
> -       if (PageSwapCache(page)) {
> -               swp_entry_t ent = { .val = page_private(page), };
> -               unsigned short id;
>  -      memcg = get_mem_cgroup_from_mm(mm);
> ++      if (!mm) {
> ++              memcg = get_mem_cgroup_from_current();
> ++              if (!memcg)
> ++                      memcg = get_mem_cgroup_from_mm(current->mm);
> ++      } else {
> ++              memcg = get_mem_cgroup_from_mm(mm);
> ++      }
> +       ret = __mem_cgroup_charge(page, memcg, gfp_mask);
> +       css_put(&memcg->css);

Things are more complicated than this. First we need a similar change
in mem_cgroup_swapin_charge_page() but I am thinking of making
get_mem_cgroup_from_mm() more general and not make any changes in
these two functions.

Is it possible to get Dan's patch series in mm tree? More specifically
the above two patches in the same tree then one of us can make their
patch rebase over the other (I am fine with doing this myself).
