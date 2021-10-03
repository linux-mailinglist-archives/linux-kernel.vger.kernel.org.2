Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB724202AB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 18:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhJCQ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 12:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbhJCQ3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 12:29:08 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB57C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 09:27:20 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p80so17513551iod.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gGz/7798TEe0PuD2hstTWSueeSofOrfEOZMUAoLV9NI=;
        b=WV0sN6CkWLEjLdwaqH+RRv/QPo1wzQrpUkFDjo/lEM+rDQGc2vPvUhIJLz2y/wKY6g
         gfZt16J8rvw5By+OcqK+o8M9mKb0o9uePR94TvsLfmwsN70xSQHf222+9AgqkpjsOUT+
         tNm6DcJhsWlX8fRujhaCcXR1POGSIdvRxwP1uCdBHzxqJKYfUveUVN0OIKeMhyxaKU6T
         Onf8YTdlCeQefd38znfzSpkM+MX9ki1I5FLMLHmKquuWCT9on+1xZpktQXrQjeP9Kbom
         ke5zQ5uAGlOCm/0toZB/udeRGm1ExKu2sYVJ9IGHpVb2Uj3Pc6l8oF2RSJzHcmqMHvhm
         kpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gGz/7798TEe0PuD2hstTWSueeSofOrfEOZMUAoLV9NI=;
        b=0mn62Lww9nHlDYxoz2vDzDqED8GS64xzX38IsmtKW+gijfj4BuPPwILN8GMoE5h6L4
         HDYyWxj8/FHBoq0I0aTHj12D+wgEy4wVVRlt0S2MLbEcN1VreuzoiOPQl2TbfqSpH84d
         UkOw2wyCxed/kAPxJ2wjzAlK51889IvHbvfk51xmbOrMbSBsVCdB/sDzvtOM8a9jtRr+
         S+z1NZ1FYXEpb7N0PGWzh2xBpujPwyr1N7jdXPCmPyxHqvNJoMJOUO/SEt+JwhIIhqlP
         HeGpvF0lOQC9k0JjuW69g375g/1Kp03ysD3YOQth4nB4hzXcy4eUqQ3/4OcMGyAgDUkb
         M+Bw==
X-Gm-Message-State: AOAM533oqPxU3nH3LXc5PlsGw2CTjV/SyhOvZ2sH0Ygc2acknOd+Cz99
        1xS7pvYs5PNAe6u0jCBaVY15ZJt6g1T05np/N2w=
X-Google-Smtp-Source: ABdhPJwJ4NlNl/UT98Bv7qSDY/uujcrXZHzqmF3GH8oLkQdIoJYtV0c28VvBpNU+1poxsUyNx8qX1pgDqblDPkMqkQA=
X-Received: by 2002:a02:7b01:: with SMTP id q1mr7320811jac.121.1633278439943;
 Sun, 03 Oct 2021 09:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211001024105.3217339-1-willy@infradead.org> <CA+fCnZfSUxToYKUfHwQT0r3bC9NYZNc2iC3PXv+GciuW0Fm79A@mail.gmail.com>
 <YVcVtNLnyJModOhn@casper.infradead.org>
In-Reply-To: <YVcVtNLnyJModOhn@casper.infradead.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 3 Oct 2021 18:27:09 +0200
Message-ID: <CA+fCnZd7dGOz2T3eVwbJzAEmXMB7YezB5FoZt5a0D92mPPv74g@mail.gmail.com>
Subject: Re: [PATCH] kasan: Fix tag for large allocations when using CONFIG_SLAB
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 4:06 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Oct 01, 2021 at 03:29:29PM +0200, Andrey Konovalov wrote:
> > On Fri, Oct 1, 2021 at 4:42 AM Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > >
> > > If an object is allocated on a tail page of a multi-page slab, kasan
> > > will get the wrong tagbecause page->s_mem is NULL for tail pages.
> >
> > Interesting. Is this a known property of tail pages? Why does this
> > happen? I failed to find this exception in the code.
>
> Yes, it's a known property of tail pages.  kmem_getpages() calls
> __alloc_pages_node() which returns a pointer to the head page.
> All the tail pages are initialised to point to the head page.
> Then in alloc_slabmgmt(), we set ->s_mem of the head page, but
> we never set ->s_mem of the tail pages.  Instead, we rely on
> people always passing in the head page.  I have a patch in the works
> to change the type from struct page to struct slab so you can't
> make this mistake.  That was how I noticed this problem.

Ah, so it's not "the tail page", it's "a tail page". Meaning any page
but the head page. Got it.

> > The tag value won't really be "wrong", just unexpected. But if s_mem
> > is indeed NULL for tail pages, your fix makes sense.
> >
> > > I'm not quite sure what the user-visible effect of this might be.
> >
> > Everything should work, as long as tag values are assigned
> > consistently based on the object address.
>
> OK, maybe this doesn't need to be backported then?  Actually, why
> subtract s_mem in the first place?  Can we just avoid that for all
> tag calculations?

We could avoid it. To me, it seems cleaner to assign tags based on the
object index rather than on the absolute address. But either way
should work.

There's no security nor stability impact from this issue, so probably
not so much incentive to backport. But the patch makes sense.

Thanks!
