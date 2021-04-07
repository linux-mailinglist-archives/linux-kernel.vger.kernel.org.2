Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2476335783D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 01:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhDGXFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 19:05:54 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:55574 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhDGXFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 19:05:52 -0400
Received: by sf.home (Postfix, from userid 1000)
        id 5ABD95A22061; Thu,  8 Apr 2021 00:05:37 +0100 (BST)
Date:   Thu, 8 Apr 2021 00:05:37 +0100
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: page_poison: print page owner info when corruption
 is caught
Message-ID: <YG46walP8KBD1yG2@sf>
References: <20210404141735.2152984-1-slyfox@gentoo.org>
 <2f0d1127-8868-f8a3-203f-2c3d473bd496@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f0d1127-8868-f8a3-203f-2c3d473bd496@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 02:15:50PM +0200, Vlastimil Babka wrote:
> On 4/4/21 4:17 PM, Sergei Trofimovich wrote:
> > When page_poison detects page corruption it's useful to see who
> > freed a page recently to have a guess where write-after-free
> > corruption happens.
> > 
> > After this change corruption report has extra page_owner data.
> > Example report from real corruption:
> > 
> >     pagealloc: memory corruption
> >     e00000014cd61d10: 11 00 00 00 00 00 00 00 30 1d d2 ff ff 0f 00 60
> >     e00000014cd61d20: b0 1d d2 ff ff 0f 00 60 90 fe 1c 00 08 00 00 20
> >     ...
> >     CPU: 1 PID: 220402 Comm: cc1plus Not tainted 5.12.0-rc5-00107-g9720c6f59ecf #245
> >     Hardware name: hp server rx3600, BIOS 04.03 04/08/2008
> >     ...
> >     Call Trace:
> >      [<a000000100015210>] show_stack+0x90/0xc0
> >      [<a000000101163390>] dump_stack+0x150/0x1c0
> >      [<a0000001003f1e90>] __kernel_unpoison_pages+0x410/0x440
> >      [<a0000001003c2460>] get_page_from_freelist+0x1460/0x2ca0
> >      [<a0000001003c6be0>] __alloc_pages_nodemask+0x3c0/0x660
> >      [<a0000001003ed690>] alloc_pages_vma+0xb0/0x500
> >      [<a00000010037deb0>] __handle_mm_fault+0x1230/0x1fe0
> >      [<a00000010037ef70>] handle_mm_fault+0x310/0x4e0
> >      [<a00000010005dc70>] ia64_do_page_fault+0x1f0/0xb80
> >      [<a00000010000ca00>] ia64_leave_kernel+0x0/0x270
> >     page_owner tracks the page as freed
> >     page allocated via order 0, migratetype Movable,
> >       gfp_mask 0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO), pid 37, ts 8173444098740
> >      __reset_page_owner+0x40/0x200
> >      free_pcp_prepare+0x4d0/0x600
> >      free_unref_page+0x20/0x1c0
> >      __put_page+0x110/0x1a0
> >      migrate_pages+0x16d0/0x1dc0
> >      compact_zone+0xfc0/0x1aa0
> >      proactive_compact_node+0xd0/0x1e0
> >      kcompactd+0x550/0x600
> >      kthread+0x2c0/0x2e0
> >      call_payload+0x50/0x80
> > 
> > Here we can see that page was freed by page migration but something
> > managed to write to it afterwards.
> > 
> > CC: Andrew Morton <akpm@linux-foundation.org>
> > CC: linux-mm@kvack.org
> > Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> > ---
> >  mm/page_poison.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/page_poison.c b/mm/page_poison.c
> > index 65cdf844c8ad..ef2a1eab13d7 100644
> > --- a/mm/page_poison.c
> > +++ b/mm/page_poison.c
> > @@ -4,6 +4,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/highmem.h>
> >  #include <linux/page_ext.h>
> > +#include <linux/page_owner.h>
> >  #include <linux/poison.h>
> >  #include <linux/ratelimit.h>
> >  #include <linux/kasan.h>
> > @@ -45,7 +46,7 @@ static bool single_bit_flip(unsigned char a, unsigned char b)
> >  	return error && !(error & (error - 1));
> >  }
> >  
> > -static void check_poison_mem(unsigned char *mem, size_t bytes)
> > +static void check_poison_mem(struct page *page, unsigned char *mem, size_t bytes)
> >  {
> >  	static DEFINE_RATELIMIT_STATE(ratelimit, 5 * HZ, 10);
> >  	unsigned char *start;
> > @@ -70,6 +71,7 @@ static void check_poison_mem(unsigned char *mem, size_t bytes)
> >  	print_hex_dump(KERN_ERR, "", DUMP_PREFIX_ADDRESS, 16, 1, start,
> >  			end - start + 1, 1);
> >  	dump_stack();
> > +	dump_page_owner(page);
> 
> OK but why not a full dump_page()?

Oh, I did not know it existed! Looks even better.
Will send a v2 with dump_page().

> >  }
> >  
> >  static void unpoison_page(struct page *page)
> > @@ -82,7 +84,7 @@ static void unpoison_page(struct page *page)
> >  	 * that is freed to buddy. Thus no extra check is done to
> >  	 * see if a page was poisoned.
> >  	 */
> > -	check_poison_mem(addr, PAGE_SIZE);
> > +	check_poison_mem(page, addr, PAGE_SIZE);
> >  	kunmap_atomic(addr);
> >  }
> >  
> > 
> 

-- 

  Sergei
