Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3050A3EDE94
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 22:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhHPUZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 16:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbhHPUZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 16:25:11 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768B8C061764
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:24:39 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bq25so24004979ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sXYkpEIBbTRqbu2ccbqpOzzUrzgOM/KwayJpCu9iw+g=;
        b=u6tt21vd6EagJz//PQCD+JbTYKIj7NXVCZZBbObmv2vKKL2DShAV/l4PfBDA93tYcW
         MD4eWUBKGzxXgFu1eyOlI0phqRckANQiXkkATyAdwoDDH4FY66Exjd9JFbW0v0Jpsnqq
         3B1pLf28Tf6qEZtTPMW6IEYwY3AufFSZB5bOrbnDTOp9rXKohthGMYyuDnwQ+GOqmWaH
         LaqxFbXui4ulJeSWKUAY2dVBQcW4cP7Qmy2jJf4NsQmt/t8kt59nXjCr86d/7L1mqwTQ
         XsQYSFl2t9cxqnGfdIgCoAkryLV8e/SQw3pvz3/KbIf24lfsjA0pkX4SXyoycrcIDRDr
         TXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sXYkpEIBbTRqbu2ccbqpOzzUrzgOM/KwayJpCu9iw+g=;
        b=L4r024guIoOhZbkVYxA2+V9WVnsYsXaAHp/zlz1cliAp83Pv1CGkOx8/uJyHDdZSwz
         JVUqEkZNklAPiU0ofpHWTbbBfI8EaEDaD0RP4Hf9iza6e1iH1UKjmZBFJhcOYqrqYNJA
         z4vlRzsiV/HBm4earfnTzmp0GnupA7jxNIoSUHtpvcgsyPtL/YVcek9T60CNHojQoUWi
         kOqmNLlj1teQE0Y5uQ0vvKWOXlq3RvVi8oeIhvfGdDpreZNG9E8PHA+/oJJZraO6OzQg
         eI0Xo/N/7H8xyc8uzk6RqPTuDUv7O9TdLKSGpb28VZ0ziojMFmcpc8muNqTnBlkNPRIi
         Ku7A==
X-Gm-Message-State: AOAM530kTLTVD3Z719MrWUP00ZNKQNpY3/SDEP+pCvjMeW1usIR4AM9+
        fyeU006R6df7lQTwKSVEHY0YTzLaQMFMM1CKJ+ABNcI5vt7i6Q==
X-Google-Smtp-Source: ABdhPJwL4La/Jm+xPr1GT3nSytXa50mjZQ4RhVC7yFc/HZ4dpvqezib3/5Cxzoc2qewwsk/sbs4LQ1+4eSv89GuBV40=
X-Received: by 2002:a17:906:ae51:: with SMTP id lf17mr245428ejb.161.1629145478108;
 Mon, 16 Aug 2021 13:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210816180909.3603-1-shy828301@gmail.com> <YRq+kCOW4zb4vfxA@casper.infradead.org>
In-Reply-To: <YRq+kCOW4zb4vfxA@casper.infradead.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 16 Aug 2021 13:24:25 -0700
Message-ID: <CAHbLzkoE6h9dmRp6zfaKdLjq2y24+PV-yBUv6RMXtzKvPFdBkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: hwpoison: don't drop slab caches for offlining
 non-LRU page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        tdmackey@twitter.com, Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 12:38 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Aug 16, 2021 at 11:09:08AM -0700, Yang Shi wrote:
> > But the most disappointing thing is all the effort doesn't make the page
> > offline, it just returns:
> >
> > soft_offline: 0x1469f2: unknown non LRU page type 5ffff0000000000 ()
>
> It's a shame it doesn't call dump_page().  There might be more
> interesting information somewhere in struct page that would help us
> figure out what kind of page it was in your environment.  For example,
> it might be a page table page or a page allocated for vmalloc(), and
> in both those cases, there are things we might be able to do (we'd
> certainly be able to figure out that it isn't worth shrinking slab!)

Yes,  dump_page() could provide more information to us. I could add a
new patch or just update this patch to call dump_page() if offline is
failed if the hwpoison maintainer agrees to this as well.
