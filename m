Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD10390062
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 13:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhEYL4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 07:56:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231770AbhEYL4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 07:56:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6A6161260;
        Tue, 25 May 2021 11:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621943691;
        bh=1kgF2uL/dHB1asBQritC0d5do+lurkO6lWXKq9gtfUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJzjHB8TIqkgfCTfTdMiZjuiXGAmdlkcnGkp2bWnR4Hk8KOqV1628owxWzdXndAFU
         ut9NAwMZXmOT91idh2nhzHn2C7wrMXyy/IypBFASyRKToi3ANd9XtUIDi2xtJ8wmlf
         qlQ9FLGe976K2gPVc1CgcNL0iFTiV/7W+MpTKfVw=
Date:   Tue, 25 May 2021 13:54:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        glittao@gmail.com, vinmenon@codeaurora.org
Subject: Re: [PATCH v7] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <YKzlia5b/vaDaul9@kroah.com>
References: <1621928285-751-1-git-send-email-faiyazm@codeaurora.org>
 <YKys873HUNp/ZMqV@kroah.com>
 <7324d56f-c5fe-05fa-55f2-7dd2dbf9bce0@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7324d56f-c5fe-05fa-55f2-7dd2dbf9bce0@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 02:27:15PM +0530, Faiyaz Mohammed wrote:
> 
> 
> On 5/25/2021 1:23 PM, Greg KH wrote:
> > On Tue, May 25, 2021 at 01:08:05PM +0530, Faiyaz Mohammed wrote:
> >> alloc_calls and free_calls implementation in sysfs have two issues,
> >> one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
> >> to "one value per file" rule.
> >>
> >> To overcome this issues, move the alloc_calls and free_calls implemeation
> >> to debugfs.
> >>
> >> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
> >> to be inline with what it does.
> >>
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> >> ---
> >> changes in V7:
> >>         - Drop the older alloc_calls and free_calls interface.
> >> changes in v6:
> >>         - https://lore.kernel.org/linux-mm/1621341949-26762-1-git-send-email-faiyazm@codeaurora.org/
> >>
> >> changes in v5:
> >>         - https://lore.kernel.org/linux-mm/1620296523-21922-1-git-send-email-faiyazm@codeaurora.org/
> >>
> >> changes in v4:
> >>         - https://lore.kernel.org/linux-mm/1618583239-18124-1-git-send-email-faiyazm@codeaurora.org/
> >>
> >> changes in v3:
> >>         - https://lore.kernel.org/linux-mm/1617712064-12264-1-git-send-email-faiyazm@codeaurora.org/
> >>
> >> changes in v2:
> >>         - https://lore.kernel.org/linux-mm/3ac1d3e6-6207-96ad-16a1-0f5139d8b2b5@codeaurora.org/
> >>
> >> changes in v1:
> >>         - https://lore.kernel.org/linux-mm/1610443287-23933-1-git-send-email-faiyazm@codeaurora.org/
> >>
> >>  include/linux/slub_def.h |   8 ++
> >>  mm/slab_common.c         |   9 ++
> >>  mm/slub.c                | 353 ++++++++++++++++++++++++++++++++++-------------
> >>  3 files changed, 276 insertions(+), 94 deletions(-)
> >>
> >> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> >> index dcde82a..b413ebe 100644
> >> --- a/include/linux/slub_def.h
> >> +++ b/include/linux/slub_def.h
> >> @@ -159,6 +159,14 @@ static inline void sysfs_slab_release(struct kmem_cache *s)
> >>  }
> >>  #endif
> >>  
> >> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
> >> +#define SLAB_SUPPORTS_DEBUGFS
> >> +void debugfs_slab_release(struct kmem_cache *);
> >> +#else
> >> +static inline void debugfs_slab_release(struct kmem_cache *s)
> >> +{
> >> +}
> >> +#endif
> >>  void object_err(struct kmem_cache *s, struct page *page,
> >>  		u8 *object, char *reason);
> >>  
> >> diff --git a/mm/slab_common.c b/mm/slab_common.c
> >> index a4a5714..873dd79 100644
> >> --- a/mm/slab_common.c
> >> +++ b/mm/slab_common.c
> >> @@ -455,6 +455,9 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
> >>  #else
> >>  		slab_kmem_cache_release(s);
> >>  #endif
> >> +#ifdef SLAB_SUPPORTS_DEBUGFS
> >> +		debugfs_slab_release(s);
> >> +#endif
> > 
> > Why do you need these #ifdef if your slub_dev.h file already provides an
> > "empty" function for this?
> > 
> We are not including slub_def.h directly. mm/slab.h includes the
> slub_def.h if CONFIG_SLUB enable,
> 
> from mm/slab.h
> #ifdef CONFIG_SLAB
> #include <linux/slab_def.h>
> #endif
> 
> #ifdef CONFIG_SLUB
> #include <linux/slub_def.h>
> #endif
> 
> so if CONFIG_SLAB is enable then mm/slab.h includes slab_def.h, to avoid
> undefined reference error added SLAB_SUPPORTS_DEBUGFS like
> SLAB_SUPPORTS_SYSFS.

Ick, ok, messy code, I'll stop complaining now if this really is the
only way to do it (still feels wrong to me...)

greg k-h
