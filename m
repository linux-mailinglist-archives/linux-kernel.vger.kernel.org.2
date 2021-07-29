Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FF03DA5FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 16:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239055AbhG2OKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 10:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239272AbhG2OId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 10:08:33 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F36C08EB5B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 07:03:31 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id x7so7677175ljn.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 07:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4HxCrPv2nHY4WojFwqRRKr/XuvP+P2kNyaf8CVbmQA=;
        b=UVfa+s2qTXOHLywI++x8/3rTAglgFws2bP4BUnE/ySOTZk6kJfTR+C9VivplKI7fYp
         eQpA+wZlN/eNBNkC8VBp4F3AwA5Xevn6TQpmUi+ckobTmkn6mh61dvKRziifrb8usds7
         g15YcY2thd8vbBaLw6zUd/MMWs6hG+xzp8ysoklza/PePYOA0RRSpRa1jaqFx1Ryh4a2
         eAkBcMarMtkP3pfIocGw7fkSZ0KLaseQXnu66r8OxehggNxrjF2AYhOkXkd6I2Co83iA
         UENT0ZK/GBnsx9ARBvffU6BDKSZu34bbq49bpH8hM1z1XSjTtHkLJ1qnVJWZwKKe8cK/
         8kGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4HxCrPv2nHY4WojFwqRRKr/XuvP+P2kNyaf8CVbmQA=;
        b=FOzCvJj5NW9KTR90sgJ7KUVMgo9TTkIjRsfHZkUkB388VnOfcWbfh/EC4K2wdI1d2L
         AfouLFnOrKqM/O3pYcNVxDm+m5l+307E6WaMTEYnuY2e2hsjsx4mv7WKY/BwIQRTct6Y
         veDoRZHN5/L+3yOo8TgUnBxv9Ts8zPzRe+mhSg6jiFb93Hfu9sj//ASpmqZDRsGv21Mt
         tg6M3yEDr05FQ7crj4X65c5ax22/4GwOV2XcdQl18ALa360a0tFf039u33IasNd/X1TG
         lsVR4hKt8C99oa0k9CyMBAaCh1uUWOkAJQy1GRDUAOXVjSQPJ4WBDyfcEeWbi6l+1jR/
         HT9g==
X-Gm-Message-State: AOAM533g0dC5d2F19PRWvLJb6EQGlIBJIDgWY1W7+8JwNUBbfLKhpJwO
        UvEyEVhXpYizty2xhmaVX8/ATyUZE0qstvZAoQRdvg==
X-Google-Smtp-Source: ABdhPJw3yQovWlC8B1n/adJ/irgUUq1IGOPYdaP+54tBXbWyF1uuvAizWPJwKvpBsDCJXh/62Qn7x6nqY41u+HPWev8=
X-Received: by 2002:a2e:8e24:: with SMTP id r4mr2975434ljk.34.1627567408888;
 Thu, 29 Jul 2021 07:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210728155354.3440560-1-shakeelb@google.com> <8c14efe2-69dc-6eab-3cd5-c042576770e7@huawei.com>
In-Reply-To: <8c14efe2-69dc-6eab-3cd5-c042576770e7@huawei.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 29 Jul 2021 07:03:17 -0700
Message-ID: <CALvZod6usxk99KFhQVXGxBadsYpUyQ3QuwfSDa_sbqSLjBEgnA@mail.gmail.com>
Subject: Re: [PATCH] slub: fix unreclaimable slab stat for bulk free
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Wang Hai <wanghai38@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 11:52 PM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>
> On 2021/7/28 23:53, Shakeel Butt wrote:
> > SLUB uses page allocator for higher order allocations and update
> > unreclaimable slab stat for such allocations. At the moment, the bulk
> > free for SLUB does not share code with normal free code path for these
> > type of allocations and have missed the stat update. So, fix the stat
> > update by common code. The user visible impact of the bug is the
> > potential of inconsistent unreclaimable slab stat visible through
> > meminfo and vmstat.
> >
> > Fixes: 6a486c0ad4dc ("mm, sl[ou]b: improve memory accounting")
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > ---
> >   mm/slub.c | 22 ++++++++++++----------
> >   1 file changed, 12 insertions(+), 10 deletions(-)
> >
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 6dad2b6fda6f..03770291aa6b 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3238,6 +3238,16 @@ struct detached_freelist {
> >       struct kmem_cache *s;
> >   };
> >
> > +static inline void free_nonslab_page(struct page *page)
> > +{
> > +     unsigned int order = compound_order(page);
> > +
> > +     VM_BUG_ON_PAGE(!PageCompound(page), page);
>
> Could we add WARN_ON here, or we got nothing when CONFIG_DEBUG_VM is
> disabled.

I don't have a strong opinion on this. Please send a patch with
reasoning if you want WARN_ON_ONCE here.
