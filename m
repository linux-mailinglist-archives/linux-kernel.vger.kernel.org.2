Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A8041A03A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 22:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbhI0Ui7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 16:38:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235865AbhI0Ui5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:38:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632775038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kVhbRAJmKSprlQgg0jXpRAyAty2Z7WA2uiN0tVCX8Ys=;
        b=gL/puVNQO3KYaGtpamy4HtjmX06nmvWR+xvDwj4rzZBTZ7jY7Hpu5vc+v7Q4R+HIbkSQ95
        ZJOujZCwjTvpWuf0c2sR5ed3kQTo6pblVzmRAOuIyifKabBF7zOKi2pRgyqTj7+7R0L0Ex
        uCex6lDr5u2aC3tTdTzobUnPWqSyeCo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-M5_YEQCLNzi4jgOt8B5mnA-1; Mon, 27 Sep 2021 16:37:15 -0400
X-MC-Unique: M5_YEQCLNzi4jgOt8B5mnA-1
Received: by mail-qk1-f200.google.com with SMTP id r5-20020a05620a298500b0045dac5fb940so60899934qkp.17
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 13:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kVhbRAJmKSprlQgg0jXpRAyAty2Z7WA2uiN0tVCX8Ys=;
        b=e3jkG1XQ4YoNbVmjFc/aQ8svYd62yslj0TC2S4QSEQYViIrxc4zHdirsEhbdCRKEGE
         nAlIrd05/bBE5vtLTKtrEY8KGWJLua27bXOl83VCtB9WnGJHfVZLCV1rwCl9H97wGoYh
         xM7YVQD3wN0YMmRtwGbbRewUyv14JwMfyeBhJ2wE5MJEfY0vEjG0zBQBbljvGiKqkSn5
         W77SBoaNuaPkPyI089pngFIsbl6zgwhoNEhwB3NnO3+qyCyfPdVe+tE+VhU5Tj6xi2ta
         vfYT0UcztvNEfj59FLPgWlGO5cTGtcPSiqt2gz8I2iR8vuq3mwUuxb7CqdX7UJNvMjib
         BjbA==
X-Gm-Message-State: AOAM5339fAYFAB+h3ODa8xuflT5Uf2agWBESPtxKSqy52Tmx7NZPmKko
        iZtVdB6zkvE2VdXEF8YWMwtht2FAb6RZ9Wx0CEVRTyWC+nX5TZ4sgaTv9MbPRZPTUIig6Atl3jt
        ry6ghbmn5FH2btK4bNEMLqdrK
X-Received: by 2002:a37:9c12:: with SMTP id f18mr2000950qke.18.1632775035140;
        Mon, 27 Sep 2021 13:37:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgG4CZqC/O53dsfz8veZQDVuVytxC0nWOpDZX1csnQsSimgxnlUx4eZ2tkw/L+ekLBM11Mgg==
X-Received: by 2002:a37:9c12:: with SMTP id f18mr2000928qke.18.1632775034799;
        Mon, 27 Sep 2021 13:37:14 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id j14sm11851289qtv.36.2021.09.27.13.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 13:37:14 -0700 (PDT)
Date:   Mon, 27 Sep 2021 16:37:12 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>, Li Wang <liwan@redhat.com>
Subject: Re: [PATCH] mm/userfaultfd: selftests: Fix memory corruption with
 thp enabled
Message-ID: <YVIreLvxtoW3awYr@t490s>
References: <20210923232512.210092-1-peterx@redhat.com>
 <CAJHvVci8ig4WCY2aK-GvmHP=Uw3s8DrGahk-Yh37GX2kR35kww@mail.gmail.com>
 <YU4uJLJHsHLVsS2w@t490s>
 <YVIBCh+jrZABo3xS@t490s>
 <CAJHvVcj976vz5xC=CzDQvVY7Yf8ZoDnt9jv_SwPtUKs_1LjATA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcj976vz5xC=CzDQvVY7Yf8ZoDnt9jv_SwPtUKs_1LjATA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:49:39AM -0700, Axel Rasmussen wrote:
> One small comment:
> 
> I'd prefer to keep the "uffd_test_ops->release_pages(area_src);"
> above, to ensure the src region is empty. It's not immediately obvious
> to me that we overwrite *all* of the bytes in src when we initialize
> it. (I'd have to go look at the definition of area_count and read the
> loop carefully.) It may not be technically needed, but it makes the
> guarantee that we're starting with a clean slate, free from any
> changes from previous test cases, very clear + explicit.

I think there're only two fields used, area_mutex and area_count.  I'm not sure
what's the initial idea from Andrea when the test case is merged, but IMHO it
can be written as a struct too instead of using the long macros; struct could
make it easier to undertand.

And note again that we have your uffd_test_ctx_clear() called which contains
munmap() of all the buffers before the release_pages() calls.  It means at
least for anon and shmem the pages won't be there 100% sure to me.  hugetlbfs
is the only one that may still keep the pages as the fs should hold another
refcount on the inode, however as all the two fields got re-written anyway, so
I think it'll be still very safe to drop the two release_pages().

> 
> Moving the release_pages(area_dst) down as you've done seems correct to me.
> 
> Either way you can take:
> 
> Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
> 
> >
> > It's just that after the weekend when I look back I still don't see a 100%
> > clean way to fix it yet.  Mapping 4K PROT_NONE before/after each allocation is
> > the most ideal but still looks tricky to me.
> >
> > Would you have time on looking for a better solution, so as to (see it a way
> > to) complete what commit 8ba6e8640844 whats to do afterwards?
> 
> Sure, it seems related to the other THP investigations we talked about
> in the other thread, so I'm happy to look into it.
> 
> Just to set expectations, progress may be slightly slow as I'm
> balancing other work my employer wants done, and some upcoming time
> off. But, I think with your patch the test is at least stable (not
> flaky) enough that there is no *urgent* need for this, so it should be
> fine.

Thanks a lot on both reviewing the patch and willing to look into it.  As long
as we don't get any report for khugepaged (if it happens, I'll provide the
PROT_NONE hack instead - that'll work 100% I believe but less clean; but for
now IMHO we don't need to bother) then we don't need to rush on that.

-- 
Peter Xu

