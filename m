Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372C63DF5E7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 21:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240274AbhHCTpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 15:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240265AbhHCTph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 15:45:37 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA5AC061764
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 12:45:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id l4so29532577ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 12:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wgvkBYw+RpMWC0ZlFt+HsFq+ODf+zPXLM/hz4eQHmew=;
        b=JXcL+O49qXIpVWO2v82/bK2Nguhq/4gKuuyRIhHFQiNO+nADr2K7knCbBf7cWuR8O9
         Su7MUXHWRrfLjGcByBLkLLFSC+UO3HiUMQRTlWD6imkro7xyZsdMYdcoO8n0dSBP+MLE
         oVZGd8bFOHsu77L+lGd1WQhDhjskLbv9FSzsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wgvkBYw+RpMWC0ZlFt+HsFq+ODf+zPXLM/hz4eQHmew=;
        b=LiafvJz/UiitBO8IbfCANc4GHSCt5eTJ+BtcDyrYWpx9pM/32MDWfthL8TepOmQ3+N
         SbOgjuGmiHFu/NUpCp57cUij5vw/kI2pINuJ5R2sdxhwMfOvM2OqvyzRqOSyp0OtpoA4
         VUJiljlvdIjaWi1tKQCyonh+X06N4GY/dE61GF60q2PJNwK8ounCeUCDAIg8X00tR8W9
         aj9F4SZQu5DUKJBB/WCSULLUly/Oex89soODp3NJ1h/OchBXr5UTFnmEDkRVr29yFW98
         dQYq7Ac8n7tGZoPBCobiWZkcJv8eIeZyZ2wStUMh4YqiPXAgEF0HARSDLQs3ZpXNRAOc
         uCPw==
X-Gm-Message-State: AOAM533N9zA/0UolpqQQPeonXR1a+UJx+clHwsR9PPz5EI4XWnDBIcKG
        FXKIN8/T4RqxzM7Mq/Rf2f4fnZfHbGltzlvq
X-Google-Smtp-Source: ABdhPJwDujqVHWExGO85Eeka6qFHrpRogYQwEjHWPF3rTs9bwyWKVJif/v0T08I/WHDnv4lr8c3sqQ==
X-Received: by 2002:a05:651c:481:: with SMTP id s1mr15120744ljc.446.1628019922749;
        Tue, 03 Aug 2021 12:45:22 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id l11sm1178133ljj.82.2021.08.03.12.45.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 12:45:21 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id e5so29543827ljp.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 12:45:20 -0700 (PDT)
X-Received: by 2002:a2e:84c7:: with SMTP id q7mr15542412ljh.61.1628019920208;
 Tue, 03 Aug 2021 12:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210803191818.993968-1-agruenba@redhat.com>
In-Reply-To: <20210803191818.993968-1-agruenba@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Aug 2021 12:45:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+_Y7NQ-NhhE0jk52c9ZB0VJbO1AjtMJFB8wP=PO+bdw@mail.gmail.com>
Message-ID: <CAHk-=wj+_Y7NQ-NhhE0jk52c9ZB0VJbO1AjtMJFB8wP=PO+bdw@mail.gmail.com>
Subject: Re: [PATCH v5 00/12] gfs2: Fix mmap + page fault deadlocks
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 3, 2021 at 12:18 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
>
> With this patch queue, fstest generic/208 (aio-dio-invalidate-failure.c)
> endlessly spins in gfs2_file_direct_write.  It looks as if there's a bug
> in get_user_pages_fast when called with FOLL_FAST_ONLY:
>
>  (1) The test case performs an aio write into a 32 MB buffer.
>
>  (2) The buffer is initially not in memory, so when iomap_dio_rw() ->
>      ... -> bio_iov_iter_get_pages() is called with the iter->noio flag
>      set, we get to get_user_pages_fast() with FOLL_FAST_ONLY set.
>      get_user_pages_fast() returns 0, which causes
>      bio_iov_iter_get_pages to return -EFAULT.
>
>  (3) Then gfs2_file_direct_write faults in the entire buffer with
>      fault_in_iov_iter_readable(), which succeeds.
>
>  (4) With the buffer in memory, we retry the iomap_dio_rw() ->
>      ... -> bio_iov_iter_get_pages() -> ... -> get_user_pages_fast().
>      This should succeed now, but get_user_pages_fast() still returns 0.

Hmm. Have you tried to figure out why that "still returns 0" happens?

One option - for debugging only - would be to introduce a new flag to
get_user_pages_fast() tyhat says "print out reason if failed" and make
the retry (but not the original one) have that flag set.

There are a couple of things of note when it comes to "get_user_pages_fast()":

 (a) some architectures don't even enable it

 (b) it can be very picky about the page table contents, and wants the
accessed bit to already be set (or the dirty bit, in the case of a
write).

but (a) shouldn't be an issue on any common platform and (b) shouldn't
be an issue with  fault_in_iov_iter_readable() that actually does a
__get_user() so it will access through the page tables.

(It might be more of an issue with fault_in_iov_iter_writable() due to
walking the page tables by hand - if we don't do the proper
access/dirty setting, I could see get_user_pages_fast() failing).

Anyway, for reason (a) I do think that eventually we should probably
introduce FOLL_NOFAULT, and allow the full "slow" page table walk -
just not calling down to handle_mm_fault() if it fails.

But (a) should be a non-issue in your test environment, and so it
would be interesting to hear what it is that fails. Because scanning
through the patches, they all _look_ fine to me (apart from the one
comment about return values, which is more about being consistent with
copy_to/from_user() and making the code simpler - not about
correctness)

                       Linus
