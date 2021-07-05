Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25113BBC67
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 13:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhGELun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 07:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbhGELun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 07:50:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E834C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 04:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EwWN7+UAKQIxLsDpSIp+JET9XMdfQgDUShXvpWDBlhk=; b=eAwDlJOBU+Tx+dEU6uv0PcpZ5Z
        RasJ+GroFUsGWxd2fKjoXsLzNuziTWVLUWfQutkeScELYfij7yZ7HJykLLat5dLYOcHcAvrHwDQwU
        W1CdwKpLbG4hh5TtyOOLcasY8ml+FqSPjWqH8XaH8/hkTt4v96+Ef5IeS+AurC8CDoczbLR9f7ubh
        mGx5mtZ7RbC++4TlVSaPOwifGtDvKqJWcQiiQ3oAFxNyUYBX1J/INz+UfIMpO79Tcc67eKXlrKkG5
        cphdgL9rx/FDAFW4Z26AGNEqDbHAU/OgDLaArnEVfPfpK10O4WOojU0P9+IYI6yTwpEfBFK+ogBhX
        +itC8tLQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0N4m-00AD6s-JQ; Mon, 05 Jul 2021 11:47:50 +0000
Date:   Mon, 5 Jul 2021 12:47:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: initialize page->private when using for
 our internal use
Message-ID: <YOLxZAnaKSwBIlK9@casper.infradead.org>
References: <20210705052216.831989-1-jaegeuk@kernel.org>
 <c32642d6-6de2-eb2d-5771-c7cefa62fab5@kernel.org>
 <YOLJW0IgCagMk2tF@google.com>
 <e2fdf628-f25c-7495-cfd1-952899f7ff9a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2fdf628-f25c-7495-cfd1-952899f7ff9a@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 07:33:35PM +0800, Chao Yu wrote:
> On 2021/7/5 16:56, Jaegeuk Kim wrote:
> > On 07/05, Chao Yu wrote:
> > > On 2021/7/5 13:22, Jaegeuk Kim wrote:
> > > > We need to guarantee it's initially zero. Otherwise, it'll hurt entire flag
> > > > operations.
> > > 
> > > Oops, I didn't get the point, shouldn't .private be zero after page was
> > > just allocated by filesystem? What's the case we will encounter stall
> > > private data left in page?
> > 
> > I'm seeing f2fs_migrate_page() has the newpage with some value without Private
> > flag. That causes a kernel panic later due to wrong private flag used in f2fs.
> 
> I'm not familiar with that part of codes, so Cc mm mailing list for help.
> 
> My question is newpage in .migrate_page() may contain non-zero value in .private
> field but w/o setting PagePrivate flag, is it a normal case?

I think freshly allocated pages have a page->private of 0.  ie this
code in mm/page_alloc.c:

                page = rmqueue(ac->preferred_zoneref->zone, zone, order,
                                gfp_mask, alloc_flags, ac->migratetype);
                if (page) {
                        prep_new_page(page, order, gfp_mask, alloc_flags);

where prep_new_page() calls post_alloc_hook() which contains:
        set_page_private(page, 0);

Now, I do see in __buffer_migrate_page() (mm/migrate.c):

        attach_page_private(newpage, detach_page_private(page));

but as far as I can tell, f2fs doesn't call any of the
buffer_migrate_page() paths.  So I'm not sure why you're seeing
a non-zero page->private.
