Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EA03C2B4E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 00:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhGIWXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 18:23:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhGIWXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 18:23:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB4BD6135D;
        Fri,  9 Jul 2021 22:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1625869225;
        bh=YxOGHnFK7zHo3ZQ1uL7Ew9G7n9/Bc/0BlbJmvQtw/0g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O61Fj30YeJr0FncTJMCR8+Vwu+hqNy9pPStQCkOhJyQUaA3huJaNZxglYU60lMmm+
         7iDazENg1KolkNRqd7BqFaJo94jdbj2HHmjzXsRdPVSgxw87TmiKicgqErzvKSWqtf
         a4TOZQZEvrD5pnCVVrMrCB00Fd5vchK2y1xoZW7Y=
Date:   Fri, 9 Jul 2021 15:20:24 -0700
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
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: Enable suspend-only swap spaces
Message-Id: <20210709152024.36f650dfec4c66ef3a60a845@linux-foundation.org>
In-Reply-To: <20210709105012.v2.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
References: <20210709105012.v2.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Jul 2021 10:50:48 -0700 Evan Green <evgreen@chromium.org> wrote:

> Currently it's not possible to enable hibernation without also enabling
> generic swap for a given swap area. These two use cases are not the
> same. For example there may be users who want to enable hibernation,
> but whose drives don't have the write endurance for generic swap
> activities.
> 
> Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
> generic swapping to it. This region can still be wired up for use in
> suspend-to-disk activities, but will never have regular pages swapped to
> it.
> 
> Swap regions with SWAP_FLAG_NOSWAP set will not appear in /proc/meminfo
> under SwapTotal and SwapFree, since they are not usable as general swap.
> 

This patch doesn't appear to set SWAP_FLAG_NOSWAP anywhere.  Perhaps
there's another patch somewhere which changes the hibernation code?  If
so, can we please have both patches in a series?

Once we have a description of how this thing gets set, please let's
discuss what happens if someone tries to enable generic swap onto that
device after hibernation has set SWAP_FLAG_NOSWAP (I'm basically
guessing now).  Will it work?  Is there a backward-compatibility issue
here?
