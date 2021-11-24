Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FE145CED1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 22:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbhKXVUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 16:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhKXVUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 16:20:31 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B34C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 13:17:20 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w1so16329116edc.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 13:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oI7l8M/MEztUdZBSwfddwsly9qSkYWDc6QESfM+2LzA=;
        b=AG3W+5L1wMKmjV6RP8hADtwGPbtJ+WMtO9Unm4Jp9JnSa7MVLiXBig+JddU7A0oE2P
         cd7S8Ym5IYrJRRDxOvACxqY2Q6XeI6/ys13O+ryiL/LHu+aiu5WGDBxszxAZSGtpTLYg
         mAGP28JGxHCvEkDaA7840eh9zO+L5VgJyoENEzn00qtwB3epRmfsgJWcWgdXjIiyoibo
         tEEjBLijWoMvmAHSxp507eHBA/uFvZoebb5lI9Qv2/4NJfTgePy3+Bp2bCtN/rvCPDaS
         Mei6xZTlLOZT+dhox3h9Ady5zPqSsnbU9jIQY5jNRV9Pj3cBqR2TKPEZKurSRS4kXl+E
         QtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oI7l8M/MEztUdZBSwfddwsly9qSkYWDc6QESfM+2LzA=;
        b=qPPknezN/ZzV53jxWZrrVSQ+GDJ738WJ9JbC8eIbofa6zv6M/Yhs+IBtW2CFHCMIST
         9bmCF4WH/118Pz1hQ/coxcKTT/TGqJxbVX2WkAfnDNfzOHylQokzuQ1/5L+PFA6m2LP4
         cmN2+pn18dPNe6mYV4F5Mls/O6nS6n82HjtVXXojXeenmx1y5yhyt4XPHgqKccBsIHe/
         vd2JuYDiOTTKFwlE3nNq06OmiFm2PZRykFsPWaoWeYK7FWlurUWRC3vc1IuHTZffTYon
         9AyAw8RTboh6G3JqA3jEk64n+Df2ck75BqlO5h9KLfjob4L1hJIurXR4IFY/kwPqobVq
         E1QA==
X-Gm-Message-State: AOAM533Y9LIK/74m+K8jYUHaRa7x0gI0HUqg/QK9fAq9ccSJc8Cfj0ju
        yiMY7khCrUJ43l4eju6sBixS//nYOCsuq+nr8JE=
X-Google-Smtp-Source: ABdhPJyAItHMNcckUspIZ+8HMmX9FtNJ7te1nmG1ApEaJwryCCwwvMdgqwUMolD/OIxXtkExonVhuEAkf/AYUiHJoWo=
X-Received: by 2002:a05:6402:510e:: with SMTP id m14mr30782968edd.312.1637788639370;
 Wed, 24 Nov 2021 13:17:19 -0800 (PST)
MIME-Version: 1.0
References: <20211123190916.1738458-1-shakeelb@google.com> <20211124201238.3xzpy2b5zcv7j23s@box.shutemov.name>
 <CALvZod6zUsCajhYcQOod+Nf0Y34x_sS1nnc7zAXUwZX0w3jzTw@mail.gmail.com>
In-Reply-To: <CALvZod6zUsCajhYcQOod+Nf0Y34x_sS1nnc7zAXUwZX0w3jzTw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 24 Nov 2021 13:17:07 -0800
Message-ID: <CAHbLzkqmTks5dGn=yCykKSwqtmsCKVqLx_bU9D1=fTvEgX06xw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: thp: update split_queue_len correctly
To:     Shakeel Butt <shakeelb@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 12:44 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Wed, Nov 24, 2021 at 12:12 PM Kirill A. Shutemov
> <kirill@shutemov.name> wrote:
> >
> > On Tue, Nov 23, 2021 at 11:09:16AM -0800, Shakeel Butt wrote:
> > > The deferred THPs are split on memory pressure through shrinker
> > > callback and splitting of THP during reclaim can fail for several
> > > reasons like unable to lock the THP, under writeback or unexpected
> > > number of pins on the THP. Such pages are put back on the deferred split
> > > list for consideration later. However kernel does not update the
> > > deferred queue size on putting back the pages whose split was failed.
> > > This patch fixes that.
> >
> > Hm. No. split_huge_page_to_list() updates the queue size on split success.
> >
>
> Right. This is really convoluted. split_huge_page_to_list() is just
> assuming that if the given page is on a deferred list then it must be
> on the list returned by get_deferred_split_queue(page). The
> interaction of move_charge and deferred split seems broken.

Because memcg code doesn't move charge for PTE mapped THP at all. See
the below comment from mem_cgroup_move_charge_pte_range():

"We can have a part of the split pmd here. Moving it can be done but
it would be too convoluted so simply ignore such a partial THP and
keep it in original memcg. There should be somebody mapping the head."

BTW, did you run into any problem related to this?

>
> Andrew, can you please drop this patch?
