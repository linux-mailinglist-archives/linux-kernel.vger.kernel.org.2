Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1CB3D418D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 22:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhGWTvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 15:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhGWTvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 15:51:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0319A60F26;
        Fri, 23 Jul 2021 20:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1627072328;
        bh=mgvXZmWU1qMssr40Q47q7dBlpo8I6IgSLickUNfhLhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r7SJg3nBpXGSjcGhV2vUTjfpLGhbQ83OiFJgZkf8A9ZSOmJNlRXTnPy6S5vW152dD
         qNSF57XqXGA2vgFJPVi/mDxMy8Hl6GEjGzLU8zIigwfUwf10jR5ZDEgw6Kcucxv/Zt
         qxck9Un20pZXydwfI7E+FTA3baouab25/B7ALiQU=
Date:   Fri, 23 Jul 2021 13:32:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm/doc: Include highmem.h in kernel-doc
Message-Id: <20210723133206.9b3bc1edcc30f431269c9304@linux-foundation.org>
In-Reply-To: <20210722021843.2336117-1-willy@infradead.org>
References: <20210722021843.2336117-1-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2021 03:18:42 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> There is lots of good documentation in highmem.h that isn't being pulled
> into the html documentation.  Fix up a couple of minor glitches and
> include it.
> 
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
>
> ...
>
> @@ -156,6 +156,7 @@ static inline void *kmap_atomic(struct page *page);
>   * the side effects of kmap_atomic(), i.e. reenabling pagefaults and
>   * preemption.
>   */
> +static inline void kunmap_atomic(void *addr);
>  
>  /* Highmem related interfaces for management code */
>  static inline unsigned int nr_free_highpages(void);

This hunk broke the i386 allmodconfig build.


In file included from ./include/linux/highmem.h:14,
                 from ./include/linux/bio.h:8,
                 from ./include/linux/blkdev.h:18,
                 from ./include/linux/blk-cgroup.h:23,
                 from ./include/linux/writeback.h:14,
                 from ./include/linux/memcontrol.h:22,
                 from ./include/linux/swap.h:9,
                 from ./include/linux/suspend.h:5,
                 from arch/x86/kernel/asm-offsets.c:13:
./include/linux/highmem-internal.h:216:1: error: expected identifier or '(' before 'do'
  216 | do {        \
      | ^~
./include/linux/highmem.h:122:20: note: in expansion of macro 'kunmap_atomic'
  122 | static inline void kunmap_atomic(void *addr);
      |                    ^~~~~~~~~~~~~
./include/linux/highmem-internal.h:219:3: error: expected identifier or '(' before 'while'
  219 | } while (0)
      |   ^~~~~
./include/linux/highmem.h:122:20: note: in expansion of macro 'kunmap_atomic'
  122 | static inline void kunmap_atomic(void *addr);
      |                    ^~~~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1
make: *** [Makefile:1213: prepare0] Error 2

I think I can see what you were trying to do there.  How about we
instead move the kunmap_atomic() kerneldoc to an appropriate place?

