Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DFC41C6C5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344499AbhI2OhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344505AbhI2OdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:33:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC06C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:31:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x7so9262391edd.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WsCHCHxDakoTG9Y2g1K3Qe4rx6KtRBr1u+T1pzACydY=;
        b=BtiXOGYER9YrYAItEdOx0vNMy5uSTK/hX3RVgLSZ3uQrBewz42OlOQXLZszFMwonC6
         2CnMtHZIq9XG8Nt1q8iLw4zDw8rRX+a5W8qSx3KVzHKVnyy0V0CXnzWlBcMzwQ+rM5vx
         ZnhnWV6a7A4lj9HnXH//5QhKS9VPUzFZ5MLVKxk99FpaWTNfwt18rxzzmrjP8yw2Yv9p
         SyhZ3h5uoIOSVKmYPwYTcX3MFAxdzRAyi8OjHFmsJAHjzreZOVFiM5cNBzLDjegyptdm
         Di5UKwwORMBZimUezYaBz4lknCBuyWkvm9Jn919e75jLHolpEnzUADr0B1MMEFK9UX6x
         RvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsCHCHxDakoTG9Y2g1K3Qe4rx6KtRBr1u+T1pzACydY=;
        b=aRLwv4r0hG5pLK7NO6cSSse3R2es4MmAKkHz1E4Nweub6RXLypQbgCfGinFxZP9zmw
         qmly3tyqDxOi3jmRRltTupP0Pli1tBEThqJOaGraweAcjFexl41DzxmrBSuam5dvybKg
         hCj/EcDhL/5wQdqmlUVVOKlEgYJGfSa1J570WOZiMCRa94u197208UCGMjmgfaiiQbGG
         FZHFOnzVoXOsCb35KrJt+55lynJFFYzDbQp2JRagwkxqk75NswxnpwgmB/REml20ayJs
         qYPrWSTDxA3+m90noYb84m8k2TCOlTXmDntPpl94Xh8/eZdUVu77IrHQA3S3LwqpExYa
         1Ywg==
X-Gm-Message-State: AOAM532HLX3c2/JWloTwasu0n89VulOP6jMLL8IioHJxEpMlVsLbFylx
        hGM9oB9bH62hoOBGbKpTrPJfCzj+oGkdZzAYRgUFTow5dniCQw==
X-Google-Smtp-Source: ABdhPJxZxYvDMm2YqTW1OjhvnqIVaBbe/F7hJ78SGcL9elgVQbdIzJFG1E61pzl9QLo4Znd0OxJJWvujOsMAvjgeCg0=
X-Received: by 2002:a05:6402:142e:: with SMTP id c14mr207037edx.209.1632925850454;
 Wed, 29 Sep 2021 07:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210908132727.16165-1-david@redhat.com> <CA+KHdyWadbqZ=xVBv6uZwxpZSEndAAk_inK+0962VcntY+mnSA@mail.gmail.com>
 <CA+KHdyUTQLwN0YASOX8XJoWCD_x1QwRmz81BGShCzb_8jZ93XQ@mail.gmail.com>
 <ea75df96-f381-6949-5627-1382a370dc71@redhat.com> <20210916193403.GA1940@pc638.lan>
 <221e38c1-4b8a-8608-455a-6bde544adaf0@redhat.com> <20210921221337.GA60191@pc638.lan>
 <7f62d710-ca85-7d33-332a-25ff88b5452f@redhat.com> <20210922104141.GA27011@pc638.lan>
 <e378e60a-319b-e9aa-7e30-3e280c4431da@redhat.com>
In-Reply-To: <e378e60a-319b-e9aa-7e30-3e280c4431da@redhat.com>
From:   Uladzislau Rezki <urezki@gmail.com>
Date:   Wed, 29 Sep 2021 16:30:39 +0200
Message-ID: <CA+KHdyWZ9T2GEuUENXD_OYHX1JxKfZuW5YzmDtqXUYSgkQd8fQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm/vmalloc: fix exact allocations with an alignment > 1
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ping Fang <pifang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> So the idea is that once we run into a dead end because we took a left
> subtree, we rollback to the next possible rigth subtree and try again.
> If we run into another dead end, we repeat ... thus, this can now happen
> more than once.
>
> I assume the only implication is that this can now be slower in some
> corner cases with larger alignment, because it might take longer to find
> something suitable. Fair enough.
>
Yep, your understanding is correct regarding the tree traversal. If no
suitable block
is found in left sub-tree we roll-back and check right one. So it can
be(the scanning)
more than one time.

I did some performance analyzing using vmalloc test suite to figure
out a performance
loss for allocations with specific alignment. On that syntactic test i
see approx. 30%
of degradation:

2.225 microseconds vs 1.496 microseconds. That time includes both
vmalloc() and vfree()
calls. I do not consider it as a big degrade, but from the other hand
we can still adjust the
search length for alignments > one page:

# add it on top of previous proposal and search length instead of size
length = align > PAGE_SIZE ? size + align:size;

in that case we solve a KASAN issue + do not introduce a degrade. For
the PAGE_SIZE
alignment all free blocks are aligned to it anyway. As for users which
uses a fixed range
that is same as a requested size and at the same time want to apply a
special alignment
is not considered as a common case, also we do not have such users.

Thoughts?

> >
> > Could you please help and test the KASAN use case?
>
> Just tried it, works just fine with KASAN and makes sense in general,
> thanks!
>
Good!

Sorry for the delay.

--
Uladzislau Rezki
