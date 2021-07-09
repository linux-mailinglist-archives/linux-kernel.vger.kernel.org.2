Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34E43C2BA2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 01:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhGIX0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 19:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbhGIX0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 19:26:41 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AF0C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 16:23:56 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id o10so12120483ils.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 16:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3wl6RUe64j2ktudh1QXGUWI+b37bnu1qQ0VROOBcwc=;
        b=mP4kT1ln+2gZKQefMzT9fgCMsUN+T9AvXJqutn9W9hbWQtQ9SU37TzrJzFETRl2tlS
         R+pydXnVQpx0K0csHb5wQRYqHuaMC5owLErCUGdUIzDBjR5yjw//hHsU8eFMocO/BYVf
         gQpt9eclrzW6i+cWbegfovVbWWS6g+C6f+UR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3wl6RUe64j2ktudh1QXGUWI+b37bnu1qQ0VROOBcwc=;
        b=e24s5ya02JU0IWer1CwS8dcTMVbVQpfogfrlvKyeLeYB7q9/RdKblFrunxzVTMrtb8
         w67BDw+hbtVBGNvPEI7KyZWQdtp6lFtNPcbNofWOqj0IOGQp7SrjAE3A5kuWbM0Ot8rt
         UwAG6S1ti+a8bqr0GglkCXscpgVE3cv2Aa7p2RSGl6UawlzTZbGgUgZRCXuvQ9GKUOds
         AsFZ7VfqVDlradxX9716t8j5peHQ/yHHnmIq8iyGMo9V8NS4WNw3Y6woRReWuH7l4xBa
         a7JZte9CZZDcjNxEE2KKQUt4aiiVY99FTENkafcJewkF2qKtaMksvtfXFFggjY2KpPpv
         ukHw==
X-Gm-Message-State: AOAM532MOkk9EymPgKLIYF80cFLT3S/cUHqkJvdJrjvCWWHSrILvCZJ1
        OhNiAyXt/S4SejLHUhYmrMsB7yQg6yRYpA==
X-Google-Smtp-Source: ABdhPJxXM72EC3IuxWha2zHx+CDLuzamThAET+/m9bKW0SptKjBD+W46SbYgREGm2lXNTX0ycTuhwg==
X-Received: by 2002:a92:c504:: with SMTP id r4mr3331414ilg.131.1625873035304;
        Fri, 09 Jul 2021 16:23:55 -0700 (PDT)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com. [209.85.166.44])
        by smtp.gmail.com with ESMTPSA id c19sm3713263ili.62.2021.07.09.16.23.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jul 2021 16:23:54 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id 62so2342096iob.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 16:23:54 -0700 (PDT)
X-Received: by 2002:a05:6638:d93:: with SMTP id l19mr20497179jaj.46.1625873034167;
 Fri, 09 Jul 2021 16:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210709105012.v2.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <20210709152024.36f650dfec4c66ef3a60a845@linux-foundation.org>
In-Reply-To: <20210709152024.36f650dfec4c66ef3a60a845@linux-foundation.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 9 Jul 2021 16:23:18 -0700
X-Gmail-Original-Message-ID: <CAE=gft48qBiq_cbdf2AZa_Ap1eB3BBvrLLD3m2cBwkYPy3b8Nw@mail.gmail.com>
Message-ID: <CAE=gft48qBiq_cbdf2AZa_Ap1eB3BBvrLLD3m2cBwkYPy3b8Nw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Enable suspend-only swap spaces
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 9, 2021 at 3:20 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri,  9 Jul 2021 10:50:48 -0700 Evan Green <evgreen@chromium.org> wrote:
>
> > Currently it's not possible to enable hibernation without also enabling
> > generic swap for a given swap area. These two use cases are not the
> > same. For example there may be users who want to enable hibernation,
> > but whose drives don't have the write endurance for generic swap
> > activities.
> >
> > Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
> > generic swapping to it. This region can still be wired up for use in
> > suspend-to-disk activities, but will never have regular pages swapped to
> > it.
> >
> > Swap regions with SWAP_FLAG_NOSWAP set will not appear in /proc/meminfo
> > under SwapTotal and SwapFree, since they are not usable as general swap.
> >
>
> This patch doesn't appear to set SWAP_FLAG_NOSWAP anywhere.  Perhaps
> there's another patch somewhere which changes the hibernation code?  If
> so, can we please have both patches in a series?

There's no other patch, in the kernel at least. SWAP_FLAG_* is exposed
to usermode, which would set it when calling swapon(2). Once this
patch is accepted, I'll have to add the option into util-linux [1], so
that I can use it in my init scripts.

Said a different way, this patch isn't about altering how hibernate
behaves, but about giving usermode the freedom to set up hibernate and
swap independently.

[1] https://github.com/karelzak/util-linux/blob/b4533177aeac287e0b0563cd1b9ee61bce29ee88/sys-utils/swapon.c#L710

>
> Once we have a description of how this thing gets set, please let's
> discuss what happens if someone tries to enable generic swap onto that
> device after hibernation has set SWAP_FLAG_NOSWAP (I'm basically
> guessing now).  Will it work?  Is there a backward-compatibility issue
> here?

The above paragraph maybe cleared this up. The hibernate code will
still happily do I/O to any region handed to it by the swap code. That
could be a region already peppered with active swap (the normal case
today), or a NOSWAP region which swap otherwise stays out of (but
still manages). If we did swapoff and swapon with a different setting
for NOSWAP, that should all work fine, since hibernate leaves it to
the swapfile code to be in charge of sector allocs/frees.

There shouldn't be any backward compatibility issues because
SWAP_FLAGS_VALID enforced that usermode had been keeping the
unallocated bits as 0.

-Evan
