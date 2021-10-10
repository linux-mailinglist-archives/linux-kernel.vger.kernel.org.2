Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8200B428419
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 00:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhJJWp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 18:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhJJWpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 18:45:55 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C438C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 15:43:56 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 75so9015468pga.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 15:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=wIBUW6zc6MUbXhHNaYoyVQ0gurfpKZ2/JrmRwbRJyjw=;
        b=Cq3SX6S5HlMNcDmorjSLbAWhkIOGV1dZn6r/k2GUH4TzkYiBXzAr2jhidjKet5xBGP
         Q6KXRzwqvatmTMzuy7LjqSUZUM2rjRekZ1JtSfsAvbV67uAuFXpqXjr5QZf0Tr8Y4rL+
         hAj1rsokigc3Y2l3z8ieVfpZ70nqwmErdxfbO43WoJYVxnF459Fh1a+dgqW9ybvuKKGg
         G9Mwgdq4gma9bs612jYAQXB5IEluHUGQ/OqxbZt9nMCgH9jdUM2QtWQ5I8+IuBhy3n0s
         eheA4hU2iSTpnvL8aqYgJZZirj4/GHdYYa383MSpHuQfPkf/AfHknETN1giEPqKrv0E2
         H77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=wIBUW6zc6MUbXhHNaYoyVQ0gurfpKZ2/JrmRwbRJyjw=;
        b=p3rbb1XuWAYVnOr5hD3l5u6SHWWo+wB6uPA8zZe23cWuFyhZ5mUxopxIQhPxMEpd3y
         mKS+n+1jd7b7pxdywMJLx5Y7ET5LrwBhzSgf+ea3KcCqhKHXZhoREeGieBjKbHYicrYI
         wIoJBHihonazhRxj4IhfVnsEf69K6o3NKN5HVIgLUNme3bqrWbE5JuxjNwXeYltTc/0D
         hRWW+6F24A/LYti3f/3mbVZpkM6ZMqcIgardunF9M+ZVjgECqyoyFnD1Aauoee5UJ6+f
         xKbNJqnep1HFL2wSER/PFAlnYjbT7W/dNTn2jWYOFZjtw+2M0ZicDGi1QjP8d4Z+HWMS
         ZmdA==
X-Gm-Message-State: AOAM532HZC48thKrDmYHRhkIF2TqDywq990Yo2Uce0iRlJ14ShRf0hlD
        RSZ1FPADnP1qby/g12uZDI6IlA==
X-Google-Smtp-Source: ABdhPJyk2OEzkPPtqpWI6h3nLJiITXPlStEa+F4iRzbceJ+h5AtvReQT3QJszcRIt6AXfWgMCiUhmA==
X-Received: by 2002:a63:4f:: with SMTP id 76mr15353398pga.457.1633905835385;
        Sun, 10 Oct 2021 15:43:55 -0700 (PDT)
Received: from [2620:15c:17:3:3280:1d46:7d55:1fbb] ([2620:15c:17:3:3280:1d46:7d55:1fbb])
        by smtp.gmail.com with ESMTPSA id z11sm5398218pfk.204.2021.10.10.15.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 15:43:54 -0700 (PDT)
Date:   Sun, 10 Oct 2021 15:43:53 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Hao Peng <flyingpenghao@gmail.com>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm/huge_memory.c: disable THP with large THP size on
 small present memory
In-Reply-To: <CAPm50a+E6mm_qA9h9MSvh4K+WA8Qf6mU=2yig5GyVw9GFJzr8g@mail.gmail.com>
Message-ID: <aece8474-4881-4c9-362-a7cb211e5933@google.com>
References: <CAPm50aLPxJCiVTqqwiz00oMNiqHggB84sXB3x=tv_HUAd5UktQ@mail.gmail.com> <20211008095123.73b4bubwrpdj6tuz@box.shutemov.name> <CAPm50a+E6mm_qA9h9MSvh4K+WA8Qf6mU=2yig5GyVw9GFJzr8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Oct 2021, Hao Peng wrote:

> > > After setting the page size to 64k on ARM64, the supported huge page
> > > size is 512M and 1TB. Therefore, if the thp is enabled, the size
> > > of the thp is 512M. But if THP is enabled, min_free_kbytes will
> > > be recalculated. At this time, min_free_kbytes is calculated based
> > > on the size of THP.
> > >
> > > On an arm64 server with 64G memory, the page size is 64k, with thp
> > > enabled.
> > > cat /proc/sys/vm/min_free_kbytes
> > > 3335104
> > >
> > > Therefore, when judging whether to enable THP by default, consider
> > > the size of thp.
> > >
> > > V2: title suggested by David Hildenbrand
> > >
> > > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> > > ---
> > >  mm/huge_memory.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > > index 5e9ef0fc261e..03c7f571b3ae 100644
> > > --- a/mm/huge_memory.c
> > > +++ b/mm/huge_memory.c
> > > @@ -437,7 +437,7 @@ static int __init hugepage_init(void)
> > >          * where the extra memory used could hurt more than TLB overhead
> > >          * is likely to save.  The admin can still enable it through /sys.
> > >          */
> > > -       if (totalram_pages() < (512 << (20 - PAGE_SHIFT))) {
> > > +       if (totalram_pages() < (512 << (HPAGE_PMD_SHIFT - PAGE_SHIFT))) {
> >
> > On x86-64 HPAGE_PMD_SHIFT is 21, so you double the amount of memory
> > required to enabled THP by default. It doesn't seem to be the intent of
> > the patch.
> >
> > What about something like
> >
> >         if (totalram_pages() < 256 * HPAGE_PMD_NR)
> >
> > ?
> >
> I think that setting the threshold to 512M here is also a rough
> estimate. If it is 512M
> of memory and 2M of THP is used, there are only 256 pages in total.
> This is actually
> too small.

So does this mean that the original intent of the patch is what you 
proposed?  It's not discussed in the changelog so it's unclear.

The "extra memory used could hurt more..." statement in the comment 
depends on other system-wide settings like max_ptes_none and whether you 
default to faulting hugepages if eligible.  There are scenarios where 
there is no extra memory used, so I think the intent is for sane default 
behavior and, as you mention, it can always be enabled at runtime as well.

By using 64KB native page sizes on small memory capacity systems, you're 
already opting into this memory bloat.

If we are trying to avoid memory bloat then we likely shouldn't be 
defaulting max_ptes_none to 511 either and that would be a bigger 
consideration than a minimum memory capacity to enable thp.

Or maybe you are questioning the adjustment to min_free_kbytes and whether 
that is rational or not for small machine sizes (but large page sizes).

> In addition, THP is disabled by default, but you can also enable THP
> dynamically.
> Thanks.

