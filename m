Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4250A45E6CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 05:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358563AbhKZEXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 23:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243783AbhKZEVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 23:21:31 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397D7C061191
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 19:31:22 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id c32so20845735lfv.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 19:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvdY5wI//P2q44HSsEXPLAPlxbCrWzDVqYZZI1tG+Q4=;
        b=an7o/GdBo9noKKDoxaUOyvptN195/2NF9HNGi+HNsrwtVf28nLMtWkQJedQi0sXVdv
         bI8RQplA6PGsqGhryxvdyLOEY4qIsxtfN5Gl5ZM0vdRs3/wrKv82hd7x1wdb/jbTjsQR
         JmFYdhoiRUZOK9NY3UYjYyRpp5Y4mlQjWlBuzkIQBXrMsVaRH7obD27jX6ZIyalUpUFq
         3fOW7wQ3HlhI0Ed6q+wzVpWBnj3QvLlsdZzfp6c0h11Rdqdgsp5lp3zzheRlaghH1FTr
         C06t+z96TRLt54p6npHuymfXpNpJbPZemqxhYQAR7xoR0ipNilR75HcbEAWkZ6V5Cj1w
         QKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvdY5wI//P2q44HSsEXPLAPlxbCrWzDVqYZZI1tG+Q4=;
        b=c++BotfOlBaSk+WX2ZKDgAJm0+smyfG4nkdjKrThd5RpMHl2gltJvOsZTP9nUM5e0u
         EN+E4tfOaeWTRzf/scVmvm8ZWaFaKv/Z6mcazkuly0RG5XuDONFcep82W+E1SY+LH0X3
         IHmTs/PC/iLfb1jMFpCf3/8GbjQAYappyeLIl488S7mqbBUBGuI7k1Zz7DTj+jDKVn72
         MIxgYe8rrHooqKVf2URoIaHPK04PbUGSh0kLOLpec3Nt5F7KxD15czp7Zx/VwLapP09k
         90JDoXpLQTHeXWjJfxrd2mtolZN6iaXK9O354TFmGFEJflW5oPycFWHL54frBw4/i5Sf
         d9lg==
X-Gm-Message-State: AOAM5302ffp4qecL/pupA7xjSE1w8AaTYnihnCYgyHHx30dZjMad/Bx9
        q0QdNihpnXBNF6OQqx8VDDKxFov8sCik1CHaXVxmJg==
X-Google-Smtp-Source: ABdhPJyfN8zNmA8euaWFafeyUlbbfd3ZPHRcLhJAZoI8V3wTh0A2gsvk4r7oDvjPoG5hri62zvuNdW84oQb59+z3OCo=
X-Received: by 2002:a05:6512:5c2:: with SMTP id o2mr26710763lfo.8.1637897480251;
 Thu, 25 Nov 2021 19:31:20 -0800 (PST)
MIME-Version: 1.0
References: <20211125024523.2468946-1-shakeelb@google.com> <e21a3088-e7fc-0601-3171-f710d644b27d@redhat.com>
In-Reply-To: <e21a3088-e7fc-0601-3171-f710d644b27d@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 25 Nov 2021 19:31:08 -0800
Message-ID: <CALvZod7zeLRJQ2rw5AmEULGPVASrqobwmGS4tNSXeXcp5u_EOw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: split thp synchronously on MADV_DONTNEED and munmap
To:     David Hildenbrand <david@redhat.com>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Peter Xu <peterx@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 12:39 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 25.11.21 03:45, Shakeel Butt wrote:
> > Many applications do sophisticated management of their heap memory for
> > better performance but with low cost. We have a bunch of such
> > applications running on our production and examples include caching and
> > data storage services. These applications keep their hot data on the
> > THPs for better performance and release the cold data through
> > MADV_DONTNEED to keep the memory cost low.
> >
> > The kernel defers the split and release of THPs until there is memory
> > pressure. This complicates the memory management of these sophisticated
> > applications which then needs to look into low level kernel handling of
> > THPs to better gauge their headroom for expansion.
> >
> > More specifically these applications monitor their cgroup usage to decide
> > if they can expand the memory footprint or release some (unneeded/cold)
> > buffer. They uses madvise(MADV_DONTNEED) to release the memory which
> > basically puts the THP into defer list. These deferred THPs are still
> > charged to the cgroup which leads to bloated usage read by the application
> > and making wrong decisions. In addition these applications are very
> > latency sensitive and would prefer to not face memory reclaim due to
> > non-deterministic nature of reclaim.
> >
> > Internally we added a cgroup interface to trigger the split of deferred
> > THPs for that cgroup but this is hacky and exposing kernel internals to
> > users. This patch solves this problem in a more general way for the users
> > by splitting the THPS synchronously on MADV_DONTNEED. This patch does
> > the same for munmap() too.
> >
>
> I'll have to defer diving into the code.
>
> Just a comment: It might be good to add that there are still cases where
> splitting the compound page can fail -- for example, if the page is
> still pinned/referenced.
>
> So if you have a THP and intended to only pin/reference e.g., the first
> 4k of it (e.g., O_DIRECT, io_uring fixed buffers), MADV_DONTNEED/unmap
> e.g., the last 4k of it will not split synchronously.
>
> In addition to explicit user action on a compound page; I remember there
> might be other kernel-internal temporary references that could
> theoretically block splitting, but maybe most of them are at least for
> now limited to !compound pages.
>

Hi David,

Thanks for your time (and apologies) but I have to rescind this patch
for now due to mistaken performance impact. Let's move the discussion
to the other thread and decide next steps there.

thanks,
Shakeel
