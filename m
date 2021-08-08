Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF1C3E3BF1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 19:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhHHR3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 13:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhHHR3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 13:29:09 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CD9C061760
        for <linux-kernel@vger.kernel.org>; Sun,  8 Aug 2021 10:28:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h14so18177534wrx.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 Aug 2021 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iatl/yvHUEXssqGaxmM3VVGCUZ13Zupn9QAYDy9G4Ic=;
        b=L8s5/CXK1BrLFzBCHTucpUv+lXw1DZcBfy1WmBT0IH2EugIraGzHYc/cXSG/W2Nh/5
         WD5/PfjLu5EHDGGDyEdnCqxnnnrVVYI+hJSS7kLtiJXz1gxT1dgZ3J1oRfrlR433D/GN
         IKR5L3D773alI6Z0HSdo6Dj4oVEdnv1eqjo3qaZvvowCkVGwc2SO6F7kqfq8mDoAoO4v
         LF+cvxllz5eVwq+kcFH9/9U6eNF1gec1Lp31i7X3HA6USrLTqQa4iqcfeO/2bCpWo4Nf
         IRWxgfj+4y/5JnVQCTlNRQ1PClYFP4nCkt86IqjTwSFHHw8j+zeI87QtYekF5ZhfO9V7
         /HwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iatl/yvHUEXssqGaxmM3VVGCUZ13Zupn9QAYDy9G4Ic=;
        b=UBXTz9wsnnoJRGgXfg7ZdUuqAs2CUCMNeW41yfzxe1tG3CWTFhxeFNZfB6kK0RLZVZ
         MiDPgMdbINb6DOfenZBLcz/9grYJkfyj0T4soBcHNQJLiD2uAqcre72+zDafwgM+REzJ
         zl7PbMQ4TWz9iP7EXRIUVsdhSyKqHhj4Hsy98C9f5EQukHdNtBwSREIUIWMS+/z+33s1
         2C7wKmUWZre1g6KTWYpjLbvoN/rP+E3NH7oiX8MQDh1NxttII6PVq5coobRvSJx+dsGP
         c0ZuuBJeAMQhh/Ng51DNPE2oKg8hEQGK3Y/PPyXCISRaphCb/f6dSAO0J9ovnfRYwDmI
         JVJA==
X-Gm-Message-State: AOAM5320hQHlt2klI/vDqGF7KMwsIe/l068vpKUy1jYzTKxv3cRs9TlO
        OWm6NiOf46ZhQ4rbx3zq3cM1V1s2MdQ20+dDRK2MmA==
X-Google-Smtp-Source: ABdhPJwIX7nUgxNitNxYTgIOm5Ad/d+mcp90wIYMeBSyeiulv8eOHmZzPAw7bHQDAaA26DPAifYHopw9d/vgLIgW2Gs=
X-Received: by 2002:adf:d087:: with SMTP id y7mr20381698wrh.323.1628443728684;
 Sun, 08 Aug 2021 10:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210731063938.1391602-1-yuzhao@google.com> <20210731063938.1391602-3-yuzhao@google.com>
 <20210804142257.tsgzpfc3zq7um7iu@box.shutemov.name>
In-Reply-To: <20210804142257.tsgzpfc3zq7um7iu@box.shutemov.name>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 8 Aug 2021 11:28:37 -0600
Message-ID: <CAOUHufZfMTi6_V_hw26WXapMpUuFgT6qnupYkcmkz=qGBWwHsw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: free zapped tail pages when splitting isolated thp
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shuang Zhai <zhais@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 8:22 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Sat, Jul 31, 2021 at 12:39:37AM -0600, Yu Zhao wrote:
> > @@ -2506,6 +2508,25 @@ static void __split_huge_page(struct page *page, struct list_head *list,
> >                       continue;
> >               unlock_page(subpage);
> >
> > +             /*
> > +              * If a tail page has only two references left, one inherited
> > +              * from the isolation of its head and the other from
> > +              * lru_add_page_tail() which we are about to drop, it means this
> > +              * tail page was concurrently zapped. Then we can safely free it
> > +              * and save page reclaim or migration the trouble of trying it.
> > +              */
> > +             if (list && page_ref_freeze(subpage, 2)) {
> > +                     VM_BUG_ON_PAGE(PageLRU(subpage), subpage);
> > +                     VM_BUG_ON_PAGE(PageCompound(subpage), subpage);
> > +                     VM_BUG_ON_PAGE(page_mapped(subpage), subpage);
> > +
> > +                     ClearPageActive(subpage);
> > +                     ClearPageUnevictable(subpage);
>
> Why touch PG_Active/PG_Unevictable?

Subpages may inherit these flags from their isolated head. Page
reclaim doesn't isolate active or unevictable. But migration does. If
we don't clear them here, we'll hit bad_page() later because both
flags are included in PAGE_FLAGS_CHECK_AT_FREE. Does it make sense?
Thanks.
