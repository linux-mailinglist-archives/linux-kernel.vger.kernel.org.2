Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274073C2BA8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 01:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhGIXgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 19:36:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhGIXgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 19:36:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AC18613B2;
        Fri,  9 Jul 2021 23:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1625873609;
        bh=c3dBoyMfVBLCJti6dHJj/Ms1ixBcQtOC4N6iCNXj6Ss=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DPTfJNOq1dKrT5NcrotV4jMhMD8ekZARI+Uh/AEUDBQSlYo7z7zYuApVcayEfKScW
         DFBrscT19kQiP9vkqLALUFmlNwV+r7b186+8Rx27WyYjfLPmkbo1n5oxSQFLJHLM+a
         CIWSQec7RLqtndk9i4MFG35ke7i/Am6Vvd7fByLg=
Date:   Fri, 9 Jul 2021 16:33:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Evan Green <evgreen@chromium.org>
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
Subject: Re: [PATCH v2] mm: Enable suspend-only swap spaces
Message-Id: <20210709163328.16fcdd3601d1ba0b93baad65@linux-foundation.org>
In-Reply-To: <CAE=gft48qBiq_cbdf2AZa_Ap1eB3BBvrLLD3m2cBwkYPy3b8Nw@mail.gmail.com>
References: <20210709105012.v2.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
        <20210709152024.36f650dfec4c66ef3a60a845@linux-foundation.org>
        <CAE=gft48qBiq_cbdf2AZa_Ap1eB3BBvrLLD3m2cBwkYPy3b8Nw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Jul 2021 16:23:18 -0700 Evan Green <evgreen@chromium.org> wrote:

> On Fri, Jul 9, 2021 at 3:20 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri,  9 Jul 2021 10:50:48 -0700 Evan Green <evgreen@chromium.org> wrote:
> >
> > > Currently it's not possible to enable hibernation without also enabling
> > > generic swap for a given swap area. These two use cases are not the
> > > same. For example there may be users who want to enable hibernation,
> > > but whose drives don't have the write endurance for generic swap
> > > activities.
> > >
> > > Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
> > > generic swapping to it. This region can still be wired up for use in
> > > suspend-to-disk activities, but will never have regular pages swapped to
> > > it.
> > >
> > > Swap regions with SWAP_FLAG_NOSWAP set will not appear in /proc/meminfo
> > > under SwapTotal and SwapFree, since they are not usable as general swap.
> > >
> >
> > This patch doesn't appear to set SWAP_FLAG_NOSWAP anywhere.  Perhaps
> > there's another patch somewhere which changes the hibernation code?  If
> > so, can we please have both patches in a series?
> 
> There's no other patch, in the kernel at least. SWAP_FLAG_* is exposed
> to usermode, which would set it when calling swapon(2). Once this
> patch is accepted, I'll have to add the option into util-linux [1], so
> that I can use it in my init scripts.
> 
> Said a different way, this patch isn't about altering how hibernate
> behaves, but about giving usermode the freedom to set up hibernate and
> swap independently.

OK, can we please get this into the changelog?  And it would be helpful
to describe how this will be invoked via swapon(8).

And I expect an update to the swapon syscall's manpage will be in order.

