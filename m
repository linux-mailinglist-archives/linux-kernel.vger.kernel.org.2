Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0655419D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbhI0RsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbhI0RsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:48:01 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94378C04A509
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 10:34:42 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id s20so23804910ioa.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 10:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ju0i6KmuCXf0Y8f28twVBwRvi9cYB/Cv7YJM46OaRDg=;
        b=Xb2P1lUNNyTkjRvl/Od0jpIuYij3PEuS44FpO6RCeuYQARbhXQAlrzHisVd7g21dx+
         i31HTNXkTxYl2cxhmyakx2CSMtkGqvj2uh8eFi4kLLRd1PhJ/4n6Jotw/2ywe/P7Lrb3
         VGCJ9o7MjPX8YO55/Ej1uZ2039hZ4U7DhMjFQmHEYYvzrOU+xXfOs8dRU1dDr+cV6Nwz
         9GCHY+941Nw0t4puq7Ff5Qjv5egduRn9q9YHH6+5efJUqgZueZQ3uFRrRWiyWMujfl6V
         0e+J2UlyjyQufjlc6BcHb3n2gqrzII+2AT0fgzeVRTaZDOi/6p3M7t4nm+MBjgtuhfVO
         Jmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ju0i6KmuCXf0Y8f28twVBwRvi9cYB/Cv7YJM46OaRDg=;
        b=MXf/+SwjOuCBZfP7j6ao0hBo5Cyq9mpmDsL3XIOf1aTpyZioMA12enOKmskEJLz40O
         ewj5HJiGIJp3jsuuNF77CYIP6JRYZJjat5PEk0+vVActMFezVteNK8GooYZlw0KAwnOK
         dgMIrQxyg6sffUJ00CgRVryfMkY8mip7pB+36aAB2bnp+BlS+mRF7HbC5KxTShIPKpu+
         nkpyUy8K9QGRunLQcN+2BSNjSlrmweco0S/HdjkZnyH4rMPcCab0DrnfHTUwhlL8Ff7R
         YXw2SMsvKuwrNx60jBKy0GOM7WSAlWAhk0Swf/mOMbCGHz9PFBtjPEAPa6bGLHGgVVzF
         S5KQ==
X-Gm-Message-State: AOAM53132Jk/uET32hQ+cZqo1uhJlnGIEyt6V0aOFJLWhoS/noFi+v60
        D/hHfTKfAdzUlYD6K3oKXgA0OjQDvTQRMndkrc0o8hwWlIs=
X-Google-Smtp-Source: ABdhPJzbJA1evZE5AUAluhy7MYFmrXxwibyO9sgFGsJIj89IVO2Sx27SLZ1c5HaP9OmFZ66G2up63sYwKhVA/GUqEUM=
X-Received: by 2002:a5e:db0c:: with SMTP id q12mr699484iop.32.1632764081836;
 Mon, 27 Sep 2021 10:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210923232512.210092-1-peterx@redhat.com> <CAJHvVci8ig4WCY2aK-GvmHP=Uw3s8DrGahk-Yh37GX2kR35kww@mail.gmail.com>
 <YU4uJLJHsHLVsS2w@t490s>
In-Reply-To: <YU4uJLJHsHLVsS2w@t490s>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Mon, 27 Sep 2021 10:34:06 -0700
Message-ID: <CAJHvVcjniq3TS=69O2tkAVD02tRCnRtw1Xf5Hu2Me4deQbq9sQ@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: selftests: Fix memory corruption with thp enabled
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>, Li Wang <liwan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 12:59 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Sep 24, 2021 at 10:21:30AM -0700, Axel Rasmussen wrote:
> > On Thu, Sep 23, 2021 at 4:25 PM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > In RHEL's gating selftests we've encountered memory corruption in the uffd
> > > event test even with upstream kernel:
> > >
> > >         # ./userfaultfd anon 128 4
> > >         nr_pages: 32768, nr_pages_per_cpu: 32768
> > >         bounces: 3, mode: rnd racing read, userfaults: 6240 missing (6240) 14729 wp (14729)
> > >         bounces: 2, mode: racing read, userfaults: 1444 missing (1444) 28877 wp (28877)
> > >         bounces: 1, mode: rnd read, userfaults: 6055 missing (6055) 14699 wp (14699)
> > >         bounces: 0, mode: read, userfaults: 82 missing (82) 25196 wp (25196)
> > >         testing uffd-wp with pagemap (pgsize=4096): done
> > >         testing uffd-wp with pagemap (pgsize=2097152): done
> > >         testing events (fork, remap, remove): ERROR: nr 32427 memory corruption 0 1 (errno=0, line=963)
> > >         ERROR: faulting process failed (errno=0, line=1117)
> > >
> > > It can be easily reproduced when global thp enabled, which is the default for
> > > RHEL.
> > >
> > > It's also known as a side effect of commit 0db282ba2c12 ("selftest: use mmap
> > > instead of posix_memalign to allocate memory", 2021-07-23), which is imho right
> > > itself on using mmap() to make sure the addresses will be untagged even on arm.
> > >
> > > The problem is, for each test we allocate buffers using two allocate_area()
> > > calls.  We assumed these two buffers won't affect each other, however they
> > > could, because mmap() could have found that the two buffers are near each other
> > > and having the same VMA flags, so they got merged into one VMA.
> > >
> > > It won't be a big problem if thp is not enabled, but when thp is agressively
> > > enabled it means when initializing the src buffer it could accidentally setup
> > > part of the dest buffer too when there's a shared THP that overlaps the two
> > > regions.  Then some of the dest buffer won't be able to be trapped by
> > > userfaultfd missing mode, then it'll cause memory corruption as described.
> > >
> > > To fix it, do release_pages() after initializing the src buffer.
> >
> > But, if I understand correctly, release_pages() will just free the
> > physical pages, but not touch the VMA(s). So, with the right
> > max_ptes_none setting, why couldn't khugepaged just decide to
> > re-collapse (with zero pages) immediately after we release the pages,
> > causing the same problem? It seems to me this change just
> > significantly narrows the race window (which explains why we see less
> > of the issue), but doesn't fix it fundamentally.
>
> Did you mean you can reproduce the issue even with this patch?

No, I haven't actually seen this happen after the patch. I suspect
with this patch the window for it to happen is small, so reproducing
may be hard. But from a theoretical standpoint, I don't see why it
couldn't happen.

>
> It is a good point anyway, indeed I don't see anything stops it from happening.
>
> I wanted to prepare a v2 by releasing the pages after uffdio registration where
> we'll do the vma split, but it won't simply work because release_pages() will
> cause the process to hang death since that test registers with EVENT_REMOVE,
> and release_pages() upon the thp will trigger synchronous EVENT_REMOVE which
> cannot be handled by anyone.
>
> Another solution is to map some PROT_NONE regions between the buffers, to make
> sure they won't share a VMA.  I'll need to think more about which is better..

One possibility would be to MADV_NOHUGEPAGE the regions, which at
least would fix the immediate flakiness. Then we could spend some time
adding a test case which specifically targets THP interactions? (I do
think we want test coverage of that in the end, but with the current
tests it's kind of "accidental".)

>
> --
> Peter Xu
>
