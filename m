Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685523F0DAD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 23:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhHRVuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 17:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbhHRVuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 17:50:22 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62760C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 14:49:47 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id w4so6239684ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 14:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJVkGRZsMGQxCh04dQEEetPATyoitTCuRRt3dR/OwaQ=;
        b=MBJrjaGztFAJR0qOLiTWThRt9z10srm4PeJK99NfdPS1VdWHes04bGEuCMJ3+81yKG
         xMmt1W/5VFXH3Y/rlf6JGj6KPQ5aqt6Bo2HysLVRmrbi/u8P9ZK6QtkU0Zxnv02rxAmg
         ETOd9msrKzgzXYudP8auMlhAHgLqL7dhfq+1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJVkGRZsMGQxCh04dQEEetPATyoitTCuRRt3dR/OwaQ=;
        b=Gf087C7VT9asL7bq8iWr8Y+ZTv/xrvylunpdtBog1iSA3twkNUEf3uCq5jYU1QVhvI
         8O7dpBPKfxcAqjVnlaha5BBCm38OcPqmBC4OpMJH2fqfRFDTk9e/fF1cA86FPSTXZZO7
         rTd6d6sBHGjy6hcTkJLH3Chu228cMgXs4ST26pYoxwAiXAZ1aiaLSF+iN/ogs97SHpBo
         uNUExQuZyEZUpMKboeIBRs+qvxIbcrI78kJ1y1VhpxoESUkVNcwQUXwzYU0XcVgHK1+N
         8+pcV3mFkmHEooSnGEYQieStXVsgXYQwBsJXs4xFj17oSeUD5XJ3QkuwMJnZP6IbCGfz
         9waQ==
X-Gm-Message-State: AOAM531yUyigUB3MrNZYxJl+jqlc2yIlCqGZlGXsjTi4pjikEv6JLHPd
        A6adQqWL7A10zud+03crayWjoM7VTxbB3x1n
X-Google-Smtp-Source: ABdhPJz+UJQrgcm8PcgmTrog3InsM9YwybupE3s+Ly9dOD+OgDyMOjLHhsyEAuZ5c+YuDhYFE0vSPA==
X-Received: by 2002:a2e:b605:: with SMTP id r5mr3759697ljn.283.1629323385645;
        Wed, 18 Aug 2021 14:49:45 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id l8sm85883lfg.218.2021.08.18.14.49.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 14:49:44 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id r9so7826184lfn.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 14:49:44 -0700 (PDT)
X-Received: by 2002:ac2:5a1a:: with SMTP id q26mr7636192lfn.41.1629323384436;
 Wed, 18 Aug 2021 14:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210803191818.993968-1-agruenba@redhat.com> <CAHk-=wj+_Y7NQ-NhhE0jk52c9ZB0VJbO1AjtMJFB8wP=PO+bdw@mail.gmail.com>
 <CAHc6FU6H5q20qiQ5FX1726i0FJHyh=Y46huWkCBZTR3sk+3Dhg@mail.gmail.com>
In-Reply-To: <CAHc6FU6H5q20qiQ5FX1726i0FJHyh=Y46huWkCBZTR3sk+3Dhg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Aug 2021 14:49:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBCm3G5yibbvQsTn00fA16a688NTU_geQV158DnRy+bQ@mail.gmail.com>
Message-ID: <CAHk-=whBCm3G5yibbvQsTn00fA16a688NTU_geQV158DnRy+bQ@mail.gmail.com>
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

[ Sorry for the delay, I was on the road and this fell through the cracks ]

On Mon, Aug 16, 2021 at 12:14 PM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> On Tue, Aug 3, 2021 at 9:45 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Hmm. Have you tried to figure out why that "still returns 0" happens?
>
> The call stack is:
>
> gup_pte_range
> gup_pmd_range
> gup_pud_range
> gup_p4d_range
> gup_pgd_range
> lockless_pages_from_mm
> internal_get_user_pages_fast
> get_user_pages_fast
> iov_iter_get_pages
> __bio_iov_iter_get_pages
> bio_iov_iter_get_pages
> iomap_dio_bio_actor
> iomap_dio_actor
> iomap_apply
> iomap_dio_rw
> gfs2_file_direct_write
>
> In gup_pte_range, pte_special(pte) is true and so we return 0.

Ok, so that is indeed something that the fast-case can't handle,
because some of the special code wants to have the mm_lock so that it
can look at the vma flags (eg "vm_normal_page()" and friends.

That said, some of these cases even the full GUP won't ever handle,
simply because a mapping doesn't necessarily even _have_ a 'struct
page' associated with it if it's a VM_IO mapping.

So it turns out that you can't just always do
fault_in_iov_iter_readable() and then assume that you can do
iov_iter_get_pages() and repeat until successful.

We could certainly make get_user_pages_fast() handle a few more cases,
but I get the feeling that we need to have separate error cases for
EFAULT - no page exists - and the "page exists, but cannot be mapped
as a 'struct page'" case.

I also do still think that even regardless of that, we want to just
add a FOLL_NOFAULT flag that just disables calling handle_mm_fault(),
and then you can use the regular get_user_pages().

That at least gives us the full _normal_ page handling stuff.

                   Linus
