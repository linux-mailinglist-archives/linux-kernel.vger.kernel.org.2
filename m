Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0553417C14
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 21:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348296AbhIXUBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 16:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348292AbhIXUBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 16:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632513576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fkb5V1jxKjOW0w30aVi0k+S3Ap2kOL1t5uX8+Txh3Lk=;
        b=R63vfxOSORznBydHfGObQmiNRjdGZ3lrMJ1u8Klj4ZacpHIc8qTo8hX9VSNl3tqjgS5Isq
        +ukse8Tsu8Mp0KqUWPXp+g/O37Yme+cwIvfWidbBngkWSe5xhH9pHBgLQRkpS6VeJhZPU1
        Qg+uo/H4XDhDI0+otaQkZnbTFbouBSU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-kV8i1DZXNWSrz6m5KXSgKw-1; Fri, 24 Sep 2021 15:59:35 -0400
X-MC-Unique: kV8i1DZXNWSrz6m5KXSgKw-1
Received: by mail-qt1-f199.google.com with SMTP id m26-20020ac87b5a000000b002a6b3744ae6so32362237qtu.22
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 12:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fkb5V1jxKjOW0w30aVi0k+S3Ap2kOL1t5uX8+Txh3Lk=;
        b=XOBjLWJcEGo8DJFBwtHUKys8jun7xKT9KHXGheeZkDYG4hA6IduS1vD4oM/PC+A8dh
         fBXZuJeACnpRgMsOCjLiJ05xkB2N44KWCcFRZPwiiML3KsNQ4jft+u76qiHh0tN4cyJD
         DKesvHWqoAx2gHAp/xy+WNL0sznWmUHflN+9ktMJ6yrKE4JfaSmexiybarTEWIkyvJy/
         lAWO14MTO7zfK69LsQoHoAWbZZQRSmRkJSTf958OU3lSVFG1cHKdx5weIsiulYWtgFxY
         MQk3Oh26Wzz8/fprIET4aIDSX5M3FEPg9m/cvJa8m1kvMSWLIeoNPXa2/obOleLD+47G
         ybPw==
X-Gm-Message-State: AOAM532Yk4epi0hv6jhiuZX4wBQJmd8mAirKPd8L6r772oFe1XgIwAJY
        lLsWSl4b63iqTu5Jg2J+3lDqCrShR7NKXYVowNqcljtadeCBOAaAVgICbueDo6Bmn18hvqqb82j
        KkycOwvAC3KLMSb7gAUGtP4sD
X-Received: by 2002:ad4:49c5:: with SMTP id j5mr4092373qvy.4.1632513574889;
        Fri, 24 Sep 2021 12:59:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweeqq4+kBGkggxeqXp/1y2/jyMtv0/bMMsIQiahlx2ty6tYQUjL3Br/cz80YAVexQZo7pRQw==
X-Received: by 2002:ad4:49c5:: with SMTP id j5mr4092318qvy.4.1632513574303;
        Fri, 24 Sep 2021 12:59:34 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id v7sm7509431qkd.41.2021.09.24.12.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 12:59:33 -0700 (PDT)
Date:   Fri, 24 Sep 2021 15:59:32 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>, Li Wang <liwan@redhat.com>
Subject: Re: [PATCH] mm/userfaultfd: selftests: Fix memory corruption with
 thp enabled
Message-ID: <YU4uJLJHsHLVsS2w@t490s>
References: <20210923232512.210092-1-peterx@redhat.com>
 <CAJHvVci8ig4WCY2aK-GvmHP=Uw3s8DrGahk-Yh37GX2kR35kww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVci8ig4WCY2aK-GvmHP=Uw3s8DrGahk-Yh37GX2kR35kww@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 10:21:30AM -0700, Axel Rasmussen wrote:
> On Thu, Sep 23, 2021 at 4:25 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > In RHEL's gating selftests we've encountered memory corruption in the uffd
> > event test even with upstream kernel:
> >
> >         # ./userfaultfd anon 128 4
> >         nr_pages: 32768, nr_pages_per_cpu: 32768
> >         bounces: 3, mode: rnd racing read, userfaults: 6240 missing (6240) 14729 wp (14729)
> >         bounces: 2, mode: racing read, userfaults: 1444 missing (1444) 28877 wp (28877)
> >         bounces: 1, mode: rnd read, userfaults: 6055 missing (6055) 14699 wp (14699)
> >         bounces: 0, mode: read, userfaults: 82 missing (82) 25196 wp (25196)
> >         testing uffd-wp with pagemap (pgsize=4096): done
> >         testing uffd-wp with pagemap (pgsize=2097152): done
> >         testing events (fork, remap, remove): ERROR: nr 32427 memory corruption 0 1 (errno=0, line=963)
> >         ERROR: faulting process failed (errno=0, line=1117)
> >
> > It can be easily reproduced when global thp enabled, which is the default for
> > RHEL.
> >
> > It's also known as a side effect of commit 0db282ba2c12 ("selftest: use mmap
> > instead of posix_memalign to allocate memory", 2021-07-23), which is imho right
> > itself on using mmap() to make sure the addresses will be untagged even on arm.
> >
> > The problem is, for each test we allocate buffers using two allocate_area()
> > calls.  We assumed these two buffers won't affect each other, however they
> > could, because mmap() could have found that the two buffers are near each other
> > and having the same VMA flags, so they got merged into one VMA.
> >
> > It won't be a big problem if thp is not enabled, but when thp is agressively
> > enabled it means when initializing the src buffer it could accidentally setup
> > part of the dest buffer too when there's a shared THP that overlaps the two
> > regions.  Then some of the dest buffer won't be able to be trapped by
> > userfaultfd missing mode, then it'll cause memory corruption as described.
> >
> > To fix it, do release_pages() after initializing the src buffer.
> 
> But, if I understand correctly, release_pages() will just free the
> physical pages, but not touch the VMA(s). So, with the right
> max_ptes_none setting, why couldn't khugepaged just decide to
> re-collapse (with zero pages) immediately after we release the pages,
> causing the same problem? It seems to me this change just
> significantly narrows the race window (which explains why we see less
> of the issue), but doesn't fix it fundamentally.

Did you mean you can reproduce the issue even with this patch?

It is a good point anyway, indeed I don't see anything stops it from happening.

I wanted to prepare a v2 by releasing the pages after uffdio registration where
we'll do the vma split, but it won't simply work because release_pages() will
cause the process to hang death since that test registers with EVENT_REMOVE,
and release_pages() upon the thp will trigger synchronous EVENT_REMOVE which
cannot be handled by anyone.

Another solution is to map some PROT_NONE regions between the buffers, to make
sure they won't share a VMA.  I'll need to think more about which is better..

-- 
Peter Xu

