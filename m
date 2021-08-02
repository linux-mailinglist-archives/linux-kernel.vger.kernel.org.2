Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C29D3DE146
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 23:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbhHBVLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 17:11:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232532AbhHBVLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 17:11:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B394260F93;
        Mon,  2 Aug 2021 21:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1627938674;
        bh=cm7muV9F/ODKslswuJhxzkBNiwyzG0gD+vtM60gPhbE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u3I2X+JYXJoZq0hA/qhUG9Ex6O8eXfSWXslSFRa+GFm0QkqtGzdxXkqdaSKXBCMe0
         cwuJ5YUeU5con606LctAJk6Pbfw32ShpUriVhaAvUF0/O1moipe2ByJEgcFwK9udsG
         9I/XiZkbegLXUcXcqc8IOHj1M679PDRnPvuhkvYw=
Date:   Mon, 2 Aug 2021 14:11:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org
Subject: Re: [PATCH] Add mmap_assert_locked() annotations to find_vma*()
Message-Id: <20210802141114.7fe599b17d87cecbc4d5b70b@linux-foundation.org>
In-Reply-To: <CAMOZA0+mAC-tHDehzqMVP4rd7wggY_DPofRdH=GMouZA9DRC1w@mail.gmail.com>
References: <20210731175341.3458608-1-lrizzo@google.com>
        <20210801123335.6a7f8e1ee1e52ea64db80323@linux-foundation.org>
        <CAMOZA0+mAC-tHDehzqMVP4rd7wggY_DPofRdH=GMouZA9DRC1w@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Aug 2021 02:16:14 +0200 Luigi Rizzo <lrizzo@google.com> wrote:

> > Well, it isn't cost-free.  find_vma() is called a lot and a surprising
> > number of systems apparently run with CONFIG_DEBUG_VM.  Why do you
> > think this cost is justified?
> 
> I assume you are concerned with the cost of mmap_assert_locked() ?
> 
> I'd say the justification is the same as for all asserts:
> at some point some code change may miss the required lock, and the
> asserts are there to catch elusive race conditions,
> 
> There are in fact already instances of mmap_locked_assert()
> right before find_vma() in walk_page_range(), and a couple before
> calls to __get_user_pages().
> 
> As for the cost, I'd think that if CONFIG_DEBUG_VM is set,
> one does it on purpose to catch errors and is prepared to pay
> the cost (in this case the atomic_read(counter) in rwsem_is_locked(),
> the counter should be hot).
> 
> FWIW I have instrumented find_vma() on a fast machine using kstats
> 
>    https://github.com/luigirizzo/lr-cstats
> 
> (load the module then enable the trace with
>   echo "trace pcpu:find_vma bits 3" > /sys/kernel/debug/kstats/_control
> and monitor the time with
>   watch "grep CPUS /sys/kernel/debug/kstats/find_vma"
> 
> I didn't run anything especially intensive except some network
> benchmarks, but I have collected ~2M samples with the following
> distribution of find_vma() time in nanoseconds in 3 configs:
> 
> CONFIGURATION         p10   p50   p90   p95   p98
> 
> no-debug               89   109   214   332    605
> debug                 331   369   603   862   1338
> debug+this patch      337   369   603   863   1339
> 
> As you can see, just compiling a debug kernel, even without this patch,
> makes the function 3x more expensive. The effect of this patch is
> not measurable (the differences are below measurement error).

Cool, thanks, that's convincing.
