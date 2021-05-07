Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AF9375ED8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 04:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhEGCf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 22:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbhEGCf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 22:35:27 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4375C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 19:34:26 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id u20so9605404lja.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 19:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v5T1rycNE4HG9oZUkYXvP5llXs2aWf6PeX0NDr3FT7o=;
        b=g8wIE8bJtPt/5As/LkKG+NNYK+6QslXCgx/RIl27/cKjeAPerak5tfmzD1KDmSxsw+
         NB+H/eAsLHWDUSIxBapdT4cpjnTRn+ggi5kWlTPnx7QEnMOcG82cBcukDZXrVcPvkxSW
         s7hdCOAKGTPKgRkbKO3HZt1mLv5NflNScJwJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v5T1rycNE4HG9oZUkYXvP5llXs2aWf6PeX0NDr3FT7o=;
        b=g5wqgdJ0SidfkCrb+1ZkUJhkfxUKzq91sSlSKWSVNOK5rXDdfw8LSYM7Gg0J4j0pM6
         TXAfgE1ReBE19PiXYtkq2m6uLF5IuUgO7RmmNtYLrXrHfKqzcGe2Ywh1x9IWBjRVt7tC
         HiZ3e1Zl3pQZs2dsr7uuBPxxipwlLo6vYzZIVSoY9bKkEu5lFwhH9pNym9Cddd2ZSXbt
         092woySu1w/AthPAaWzq0sJVJko9Fzhsvq+nr00vuQvsC9GQW56P/XFNnNsXmZ1F8GhI
         tgaHe4sW044gUulj2WsHr8H+RxyD93p2XS2o36FUEOHx1NG9wcdeBTDbCDYqGjQeahRN
         nqFQ==
X-Gm-Message-State: AOAM531oiWxKLRYcoZlG0Wk0VNFk2vfVFh3gAO3cFMhnZWnP3RWMDr2e
        PCHCV9HQ6NtLN6IxBBP2XuEPC+QyCsOcj2ni
X-Google-Smtp-Source: ABdhPJxS9Fk9ISkwUCzCU64ga8KMeGe5erA2m2A0+aKdZeIL9XYPUsuHjx+C8SJeWFSLAxLRVB9pzQ==
X-Received: by 2002:a2e:bb9e:: with SMTP id y30mr2437134lje.135.1620354865313;
        Thu, 06 May 2021 19:34:25 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id y22sm1111704lfl.36.2021.05.06.19.34.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 19:34:24 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id e12so9650774ljn.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 19:34:23 -0700 (PDT)
X-Received: by 2002:a2e:954a:: with SMTP id t10mr5646469ljh.411.1620354863575;
 Thu, 06 May 2021 19:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210506232537.165788-1-peterx@redhat.com> <20210506232537.165788-3-peterx@redhat.com>
In-Reply-To: <20210506232537.165788-3-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 May 2021 19:34:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNwNz33SEdZixX62XyEx4ZPPbkkNw+V4nn+9=YLc2Acw@mail.gmail.com>
Message-ID: <CAHk-=wiNwNz33SEdZixX62XyEx4ZPPbkkNw+V4nn+9=YLc2Acw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: gup: allow FOLL_PIN to scale in SMP
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 6, 2021 at 4:25 PM Peter Xu <peterx@redhat.com> wrote:
>
> +       if (flags & FOLL_PIN && !atomic_read(&mm->has_pinned))

Please add parentheses to clarify code like this and make the grouping
much more visually obvious.

Yes, yes, '&' has higher precedence than '&&'. This is not about the
compiler, this is about the humans reading it. So please write it as

        if ((flags & FOLL_PIN) && !atomic_read(&mm->has_pinned))

instead (this problem remains - and the fix is the same - in the 3/3 patch).

Otherwise the series looks fine to me (although admittedly I do find
the commit message to be ridiculously verbose for such a trivial patch
- at some point the actual _point_ if it all gets hidden in the long
commit message).

             Linus
