Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB5730CFDC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 00:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbhBBXZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 18:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbhBBXZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 18:25:50 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883A1C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 15:25:10 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id w124so24747278oia.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 15:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/gSLnZEPcAuV/awfY6UzZKwpDjyBokFy8hWOpAWUFI8=;
        b=gN8bLfv9mwDrYvGm5hqd8P+CR6S4cYSBSl1tck8Op+Pu/pVI7M4uWo9rxosimmiycL
         0Wly21iRhAci9ZIivfL1Ayzj++rnv/HE7hl/4SFLWGBPxlyrcTnEjoyKy5F398RvInnF
         ZVqTpwU0wINXNl39fYPkNKiFbmV1/BKnDaLQ6HBNZ94HZOZuXYAdixETXDHoZiPy5XPE
         gU0UnA+DL17oKz7mpT73edqPAp30xzZiS7x1xBz3jJ1vqzE+QHtpsMoxtr6SX7qsZMix
         ssM6SmUKLGLSGlnLR2Ab4wOVUdttlBtINR5EkxoKvYN+2RdlGZ76uDM7Nfc1CEjBkXQr
         wOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/gSLnZEPcAuV/awfY6UzZKwpDjyBokFy8hWOpAWUFI8=;
        b=E1GiEgdq5OwSunTwk3QiXYMb9MORpPmHVg3wXC/WCOwwULVADcR5CD3RLifQ83fsjR
         Rd/7FnPKd7iSQV/P+juLHLBt+YKK2kvOuyGsS0A1Zi7I1xTE+nHOM05zeUkHtMaEZn/S
         1N1Te3k0Kus7dPHTHe+9ZWC4WAAYKXgh1s4JI2IXF/3cKF4Q5WpfHhkE/IaPfAnd6dH1
         kt7IB1gF9t4hKs/WRAa79QJyPE0/mtgqDi1GnJGAbbPXGtoow/TW+3YqYVUlV8jlMBmA
         Z16lPV34e9hMowVFB5kSSPf/JD9oI3JwY5ErGso9tDgXCtp5eB1mr/62iOBwsBkg7dFS
         ZWWg==
X-Gm-Message-State: AOAM533Yp9iNe1kqAcSSDxPf8NMgyjSp1/qH3CCxE0Rixn/JvSaPrJQD
        j+K8K2bzkfR8tFGYbZsyAVC+rA==
X-Google-Smtp-Source: ABdhPJwm6bJER42qUgmaVSlEMU7XhKJA3Gi7ENTmsiKtMWgrVtpa4B4SmwR+4WmD1/Wfda6Lh5pOrw==
X-Received: by 2002:a05:6808:2d7:: with SMTP id a23mr136950oid.161.1612308309724;
        Tue, 02 Feb 2021 15:25:09 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id s6sm63522oou.46.2021.02.02.15.25.08
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 02 Feb 2021 15:25:09 -0800 (PST)
Date:   Tue, 2 Feb 2021 15:24:56 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] userfaultfd: hugetlbfs: only compile UFFD helpers if
 config enabled
In-Reply-To: <CAJHvVchxb3bemEZSKmUhPhyWmd8rQBT3UEchV38H8vWj1f=aTg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2102021510460.2964@eggly.anvils>
References: <20210202203127.3596707-1-axelrasmussen@google.com> <alpine.LSU.2.11.2102021248250.2436@eggly.anvils> <CAJHvVchxb3bemEZSKmUhPhyWmd8rQBT3UEchV38H8vWj1f=aTg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021, Axel Rasmussen wrote:
> On Tue, Feb 2, 2021 at 1:03 PM Hugh Dickins <hughd@google.com> wrote:
> > On Tue, 2 Feb 2021, Axel Rasmussen wrote:
> >
> > > For background, mm/userfaultfd.c provides a general mcopy_atomic
> > > implementation. But some types of memory (e.g., hugetlb and shmem) need
> > > a slightly different implementation, so they provide their own helpers
> > > for this. In other words, userfaultfd is the only caller of this
> > > function.
> > >
> > > This patch achieves two things:
> > >
> > > 1. Don't spend time compiling code which will end up never being
> > > referenced anyway (a small build time optimization).
> > >
> > > 2. In future patches (e.g. [1]), we plan to extend the signature of
> > > these helpers with UFFD-specific state (e.g., enums or structs defined
> > > conditionally in userfaultfd_k.h). Once this happens, this patch will be
> > > needed to avoid build errors (or, we'd need to define more UFFD-only
> > > stuff unconditionally, which seems messier to me).
> > >
> > > Peter Xu suggested this be sent as a standalone patch, in the mailing
> > > list discussion for [1].
> > >
> > > [1] https://patchwork.kernel.org/project/linux-mm/list/?series=424091
> > >
> > > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> > > ---
> > >  include/linux/hugetlb.h | 4 ++++
> > >  mm/hugetlb.c            | 2 ++
> > >  2 files changed, 6 insertions(+)
> >
> > Hi Axel, please also do the same to mm/shmem.c (perhaps you missed
> > it because I did that long ago to our internal copy of mm/shmem.c).
> 
> I had been largely ignoring shmem up to this point because my minor
> fault handling series doesn't (yet) deal with it. But, I'll need to do
> this later when I support shmem anyway, so happy to add it here.

Oh, if this patch is going into a hugetlbfs series, skip mm/shmem.c for
now (or keep it in, whichever's easiest for you): I caught sight of the
"(e.g., hugetlb and shmem)" in the commit message above, and thought
you had inadvertently missed out the shmem part - but now see that
the patch title does say "userfaultfd: hugetlbfs:".

Hugh
