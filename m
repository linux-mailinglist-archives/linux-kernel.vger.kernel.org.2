Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A893DFB1C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 07:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbhHDFfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 01:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhHDFfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 01:35:09 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69CAC0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 22:34:56 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id d3so615189qvq.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 22:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=AzPTuvmtk/GmKeGcg4Ye3QqV4cGp0sQpwmlvW0kRJJk=;
        b=RCPwO6hRr+av+1TT+ydq43h1ySz0YZWTtmBZqcDXziElHt/whPrqj9xq7JESmEcZQX
         3X+L9iF/HtcZZ7Oj4QZElfgxLS31qX3z68KdmJYzgYnx638HwSUeRCQGU0v8AWv0l+2H
         FM8eKXRz6GRRvWAA8VQjDh3/wMCJu31TO6D3dCrsJIyAsqqc7HwHqtAJ1rqmgZXee1sP
         SgNE9i7TDGNCSh7cWUpyIyozYQRrFg0k+6pbfxDZHbCvp1tL0TS5tdN7mRoXqMGKCu4b
         gVtRREJNTm7Sn2YF7cTmcJnkcnLp0p1scSTZ2xXY8j063ifmkQEcYZr0OxXsiYo5Kkd4
         cGZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=AzPTuvmtk/GmKeGcg4Ye3QqV4cGp0sQpwmlvW0kRJJk=;
        b=NzO/8DcGGj5AWOuE8GP+/F6ZrOYge/C4i1OT8K+XxUH29oAmFa7nwxs06+WIOv30q9
         eVUXYcplzwjrVtwFIOyplbXgniDsYh+XtrFDHUlqslnKwSrE1ndI1pDZ23Xmm4NPN3PC
         8z/1k/UA72S5v+MBwXnol8X3Nu2fo05qebNGkME6ZaC0YZrPSGPNIjO1qq4ejn3Bjv9i
         BW0ZhYshAxaPNJKKtRQazCUEd8/nG/PbnXZRyHouv5UQVDSGPExAYIhLhZ0iS20J9lrC
         ehBMqHMnre2qHlo4Hnax4xmc2CMfZrRvKSqZsJW41M1fxhfq5Kzh3pWO6xcO8Dj+wEz9
         iBaQ==
X-Gm-Message-State: AOAM533CeqDQsJdIzNcsu7lQXyTqOvcvC+DGPidWx0yb3DBdbs6S/8cp
        olFLZCmJNy6+CizB1UrWyaIm1Q==
X-Google-Smtp-Source: ABdhPJytPEx6Dv0bP6IEhekqVhpVIcpWjN5uD5TH0ScarA7l0AYpaYrDfMGvvj9ftMliIKmrv9b02w==
X-Received: by 2002:a05:6214:f0c:: with SMTP id gw12mr25258192qvb.33.1628055295705;
        Tue, 03 Aug 2021 22:34:55 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h68sm742610qkf.126.2021.08.03.22.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 22:34:54 -0700 (PDT)
Date:   Tue, 3 Aug 2021 22:34:52 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     "Huang, Ying" <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm,shmem: Fix a typo in shmem_swapin_page()
In-Reply-To: <YQkwBdpWTPjv4xIx@casper.infradead.org>
Message-ID: <704d597-443b-32f-84eb-524a58dd8ef@google.com>
References: <20210723080000.93953-1-ying.huang@intel.com> <24187e5e-069-9f3f-cefe-39ac70783753@google.com> <YPs6cQo7iG1JcOn8@casper.infradead.org> <8735rr54i9.fsf@yhuang6-desk2.ccr.corp.intel.com> <YQkwBdpWTPjv4xIx@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2021, Matthew Wilcox wrote:
> On Tue, Aug 03, 2021 at 04:14:38PM +0800, Huang, Ying wrote:
> > Matthew Wilcox <willy@infradead.org> writes:
> > > But I REALLY REALLY REALLY want a reproducer.  Right now, I have a hard
> > > time believing this, or any of the other races can really happen.
> > 
> > I think the race is only theoretical too.  Firstly, swapoff is a rare
> > operations in practice; secondly, the race window is really small.
> 
> So do something to provoke it.  Widen the window.  Put an msleep(1000)
> between *pagep = NULL and the call to get_swap_device().  That's assuming
> that the swapon/swapoff loop that I proposed doesn't work.  Did you
> try it?

I've been doing that swapon/swapoff loop for years, while running kernel
builds on tmpfs going out to swap; for better or worse on baremetal not VM.

You're right that few will ever need that level of reliability; but it
has caught problems from time to time, and I do insist on fixing them.

I'm not as insistent as you on wanting a reproducer; and we all take pride
sometimes in fixing ever more inconceivable bugs.  I'm not against that,
but it's easy to end up with a fix more dangerous than what it claims to
fix, rather like with random newbie cleanups.

I've never seen the swapoff race claimed by Miaohe, and don't expect to;
but he's probably right, given the current code.  I just dislike adding
unnecessary complexity, and siting it in the wrong place (mm/shmem.c).

Yang, is it possible that 5.1 commit 8fd2e0b505d1 ("mm: swap: check if
swap backing device is congested or not") was actually developed and
measured on 4.1 or earlier, which still had blk_set_queue_congested()?

I cannot explain its usefulness nowadays, on congested HDD anyway:
Matthew is right that NFS and a few others may still be setting
congested flags, but they're not what that commit was proposed for.

If it is still useful, then I contend (but Huang Ying will disagree)
that the get_swap_device() and put_swap_device() should be around
8fd2e0b505d1's inode_read_congested() block in swap_cluster_readahead(),
not encroaching into mm/shmem.c.

But if that block is not useful, then it should simply be removed (later).

Hugh
