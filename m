Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E7E419D0A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237759AbhI0Rjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:39:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238513AbhI0Rh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632764175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kx1DzZsvr2Xg6OJE0dxcX64G8Fhnxv7OEFrQ0oSnlMA=;
        b=LBf+rYl2/cm16PPSNHyM8xcYJobT7yiVhawvcL6jRMOcmqSfGX/TgW8g9om/izyS7jGgjy
        xegsVb5uukeHNjU5q4aY4/xR8y50rMCY1ioWaGTWJHNg9/Tcpg3y4dGRNK68i+2K0jeiqF
        I5+sf8m07bJBKAOrzcKYW9BEeLk7BTM=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-NVAHndy5P7CeIJVB7zje3Q-1; Mon, 27 Sep 2021 13:36:14 -0400
X-MC-Unique: NVAHndy5P7CeIJVB7zje3Q-1
Received: by mail-il1-f198.google.com with SMTP id t10-20020a056e02160a00b0022c6a64f952so19490558ilu.20
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 10:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kx1DzZsvr2Xg6OJE0dxcX64G8Fhnxv7OEFrQ0oSnlMA=;
        b=Qe8NALwlIKb/7dYC46vJzJMaGDYQ/QzwtqAtUPfLwFe1l56Yz82hxTyoR5BJfgIHDE
         iuGyJyAKPVXhYU6Vr5zZfej/AEpm5//dFupeKTytZq4r3GZ7yv94ROxnJQpsQVfnmg/p
         YCVUFJV8N9GX6AUuwBgIgkY9ub7POOmj5orGxZj7iZCM0oFS/HdT13cQO71RpF5Hl1UD
         cpKqsi2RNBRp/renSVmR8O8f6leIto42GxAscSQpiUm5yjsfk/yDb1s9IY4EdmFQTOJX
         Lf5Rw8ZvP1Ke0bGYC8Bkn51iFAU3ZKEKowNwbzTDuSQrdaCq7utrx3CIPahcGhj/sjD2
         LRcA==
X-Gm-Message-State: AOAM531AWAnxqCV9RzoEYTjH/X6N35ffzmOojvXxNebKUqRBQ+N+EqX8
        S3COQ5CMG9AB7nedAqcyZJ4Du2yvhPFLSP8P5cMTZEY8w8A68UDNA+kcKSciebKYc2EP8e9DWp3
        Bx0480UocYC6v7as777RRPoRs
X-Received: by 2002:a6b:f805:: with SMTP id o5mr638398ioh.131.1632764173455;
        Mon, 27 Sep 2021 10:36:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQvaPSgeWlbzwDiqYEYVMbq1Xj6c+GiHHrarcR7/YoxjzTe8wNONJynFvm0oNyk1dAFEsafw==
X-Received: by 2002:a6b:f805:: with SMTP id o5mr638377ioh.131.1632764173188;
        Mon, 27 Sep 2021 10:36:13 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id h5sm9318414ioz.31.2021.09.27.10.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 10:36:12 -0700 (PDT)
Date:   Mon, 27 Sep 2021 13:36:10 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>, Li Wang <liwan@redhat.com>
Subject: Re: [PATCH] mm/userfaultfd: selftests: Fix memory corruption with
 thp enabled
Message-ID: <YVIBCh+jrZABo3xS@t490s>
References: <20210923232512.210092-1-peterx@redhat.com>
 <CAJHvVci8ig4WCY2aK-GvmHP=Uw3s8DrGahk-Yh37GX2kR35kww@mail.gmail.com>
 <YU4uJLJHsHLVsS2w@t490s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4uJLJHsHLVsS2w@t490s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 03:59:32PM -0400, Peter Xu wrote:
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

Axel, let me know if you can reproduce an issue with this patch, or otherwise
would you mind we keep this patch in -mm and fix the issue first?  I can never
reproduce any issue with current patch even if I agree you're probably right,
however before the patch is mostly 100% reproducable to fail.

It's just that after the weekend when I look back I still don't see a 100%
clean way to fix it yet.  Mapping 4K PROT_NONE before/after each allocation is
the most ideal but still looks tricky to me.

Would you have time on looking for a better solution, so as to (see it a way
to) complete what commit 8ba6e8640844 whats to do afterwards?

Thanks,

-- 
Peter Xu

