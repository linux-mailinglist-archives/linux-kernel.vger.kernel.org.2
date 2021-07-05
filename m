Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831793BC275
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 20:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhGESHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 14:07:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhGESG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 14:06:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A39E61960;
        Mon,  5 Jul 2021 18:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625508262;
        bh=SRd1GZBTCuo++RPTBqiScUUN2xrO3AaUUN5D9qs3T2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FA6cdRCaN0Sau3UQE6S0Gp/0vlQbXFjjTVAAoo+RQ2Tpvj/TFe8y2IhFIG977C97g
         /X6EDRoi81LypTIHJtf2dZ+X6J1ca2Cxm6p8aGuVKddCy4NEVUpL0K5WGe4ygGR063
         YEF3YhcgPEPln39h4ZJXbKrw3GZt9AiQeGBCwICuAkdeEufwiSe/Hzn9a6BCPLD4MM
         jPga6q5SNA2DTE0ZSMXjlX8PdNGroj6WAyguU1LKzO6W57fyZH7lc9jwe/Hb70TOgW
         IQDzI8jij7jKvSu9qOSAAZjDthZ2HCoh1dnRXuzA7K7oe+xB0v/LU7CsuLO95qth0s
         tDlf5UYJ6YyNQ==
Date:   Mon, 5 Jul 2021 11:04:21 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize page->private when using for
 our internal use
Message-ID: <YONJpQapR7BRnW/J@google.com>
References: <20210705052216.831989-1-jaegeuk@kernel.org>
 <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
 <YOLJW0IgCagMk2tF@google.com>
 <e2fdf628-f25c-7495-cfd1-952899f7ff9a@kernel.org>
 <YOLxZAnaKSwBIlK9@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOLxZAnaKSwBIlK9@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05, Matthew Wilcox wrote:
> On Mon, Jul 05, 2021 at 07:33:35PM +0800, Chao Yu wrote:
> > On 2021/7/5 16:56, Jaegeuk Kim wrote:
> > > On 07/05, Chao Yu wrote:
> > > > On 2021/7/5 13:22, Jaegeuk Kim wrote:
> > > > > We need to guarantee it's initially zero. Otherwise, it'll hurt entire flag
> > > > > operations.
> > > > 
> > > > Oops, I didn't get the point, shouldn't .private be zero after page was
> > > > just allocated by filesystem? What's the case we will encounter stall
> > > > private data left in page?
> > > 
> > > I'm seeing f2fs_migrate_page() has the newpage with some value without Private
> > > flag. That causes a kernel panic later due to wrong private flag used in f2fs.
> > 
> > I'm not familiar with that part of codes, so Cc mm mailing list for help.
> > 
> > My question is newpage in .migrate_page() may contain non-zero value in .private
> > field but w/o setting PagePrivate flag, is it a normal case?
> 
> I think freshly allocated pages have a page->private of 0.  ie this
> code in mm/page_alloc.c:
> 
>                 page = rmqueue(ac->preferred_zoneref->zone, zone, order,
>                                 gfp_mask, alloc_flags, ac->migratetype);
>                 if (page) {
>                         prep_new_page(page, order, gfp_mask, alloc_flags);
> 
> where prep_new_page() calls post_alloc_hook() which contains:
>         set_page_private(page, 0);
> 
> Now, I do see in __buffer_migrate_page() (mm/migrate.c):
> 
>         attach_page_private(newpage, detach_page_private(page));
> 
> but as far as I can tell, f2fs doesn't call any of the
> buffer_migrate_page() paths.  So I'm not sure why you're seeing
> a non-zero page->private.

Hmm, I can see it in 4.14 and 5.10 kernel.

The trace is on:

 30875 [ 1065.118750] c3     87  f2fs_migrate_page+0x354/0x45c
 30876 [ 1065.123872] c3     87  move_to_new_page+0x70/0x30c
 30877 [ 1065.128813] c3     87  migrate_pages+0x3a0/0x964
 30878 [ 1065.133583] c3     87  compact_zone+0x608/0xb04
 30879 [ 1065.138257] c3     87  kcompactd+0x378/0x4ec
 30880 [ 1065.142664] c3     87  kthread+0x11c/0x12c
 30881 [ 1065.146897] c3     87  ret_from_fork+0x10/0x18

 It seems compaction_alloc() gets a free page which doesn't reset the fields?
