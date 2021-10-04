Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1B44217B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 21:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238968AbhJDThW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 15:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhJDThV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:37:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3BEC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 12:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9JkIX3iV7LcagoNgdOuRnSBh193yinQov3pA52HYMWc=; b=QylC6gSV3rj6BMRu8PrFbCkO+b
        gPPEnTKrL6ASDORbhwOdJzWQWzreVBcvljqfQdDY2AmNt0XyMHCjfyBH94QAEbS+0EgD8CvGOeooZ
        a5k+1NCVh8XqEuFLv0bobJlGjWhtprsc5xFedSrf+G2IiGHALXW2K7iSRESQuoG1GV5tEUpMGV7Dj
        YkuaypSAurknBanN1bIV6FP9xolu7C3YpPN1NUy8cPqZLeWuW8whfxSx0YSmcpnBmtCjPLmo7p12g
        25NMkhDOpfG5ShjtVwtQ/9cy1VyaXV2MInu9Mx+H2RpHYTlegtxbUv2PeMTcV70/7AsyiNOUDGT5V
        d5OuCl/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXTgD-00HEpV-Kt; Mon, 04 Oct 2021 19:31:54 +0000
Date:   Mon, 4 Oct 2021 20:31:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Hao Sun <sunhao.th@gmail.com>, Hugh Dickins <hughd@google.com>,
        Song Liu <song@kernel.org>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
Message-ID: <YVtWhVNFhLbA9+Tl@casper.infradead.org>
References: <YVSopxYWegtQJ3iD@casper.infradead.org>
 <CAPhsuW6_2_LxQRrs7xF3omgO22+6goDR=bEjKGRopaS-pHJB2Q@mail.gmail.com>
 <67906bf5-4de9-8433-3d70-cc8fc5cc2347@linux.alibaba.com>
 <CAPhsuW4_-ju9QgB7J4imrhQvH6ZqoOkVtVOVX11Yk_ZRakwQ+A@mail.gmail.com>
 <3d264ed9-f8fd-60d4-7125-f9f745ebeb52@google.com>
 <YVXXq0ssvW6P525J@casper.infradead.org>
 <f889db88-7b7d-ddb0-a7ed-3eda85d3eb96@google.com>
 <CAHbLzkq7=FsXtp4YcjeruJwbYyhsRGCq+eC8uwC-Tg06JBTUUA@mail.gmail.com>
 <YViSGYhn+zTShwFP@casper.infradead.org>
 <CAHbLzkosZr_ugNAMbXreUumSyAUMH1hPhTaiXXXRUNx88J9Xsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkosZr_ugNAMbXreUumSyAUMH1hPhTaiXXXRUNx88J9Xsw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 11:28:45AM -0700, Yang Shi wrote:
> On Sat, Oct 2, 2021 at 10:09 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Sep 30, 2021 at 10:39:14AM -0700, Yang Shi wrote:
> > > On Thu, Sep 30, 2021 at 9:49 AM Hugh Dickins <hughd@google.com> wrote:
> > > > I assume you're thinking of one of the fuzzer blkdev ones:
> > > > https://lore.kernel.org/linux-mm/CACkBjsbtF_peC7N_4mRfHML_BeiPe+O9DahTfr84puSG_J9rcQ@mail.gmail.com/
> > > > or
> > > > https://lore.kernel.org/lkml/CACkBjsYwLYLRmX8GpsDpMthagWOjWWrNxqY6ZLNQVr6yx+f5vA@mail.gmail.com/
> > > >
> > > > I haven't started on those ones yet: yes, I imagine one or both of those
> > > > will need a further fix (S_ISREG() check somewhere if we're lucky; but
> > > > could well be nastier); but for the bug in this thread, I expect
> > >
> > > Makes sense to me. We should be able to check S_ISREG() in khugepaged,
> > > if it is not a regular file, just bail out. Sounds not that nasty to
> > > me AFAIU.
> >
> > I don't see why we should have an S_ISREG() check.  I agree it's not the
> > intended usecase, but it ought to work fine.  Unless there's something
> > I'm missing?
> 
> Check out this bug report:
> https://lore.kernel.org/lkml/CACkBjsYwLYLRmX8GpsDpMthagWOjWWrNxqY6ZLNQVr6yx+f5vA@mail.gmail.com/
> and the patch from me:
> https://lore.kernel.org/linux-mm/20210917205731.262693-1-shy828301@gmail.com/
> 
> I don't think we handle buffers correctly for file THP, right? My
> patch is ad hoc, so I thought Hugh's suggestion makes some sense to
> me. Why do we have THP collapsed for unintended usecase in the first
> place?

OK, I've done some more digging.  I think what's going on with this
report is userspace opens the block device RO, causes the page cache to
be loaded with data, then khugepaged comes in and creates THPs.
What confuses me is that these THPs have private data attached to them.
I don't know how that happens.  If it's block device specific, then
yes, something like your S_ISREG() idea should work fine.  Otherwise,
we might need to track down another problem.

Hao Sun, can you try this patch and see what comes out of it?

diff --git a/fs/buffer.c b/fs/buffer.c
index c615387aedca..fefe05a9973d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -872,6 +872,7 @@ link_dev_buffers(struct page *page, struct buffer_head *head)
 		bh = bh->b_this_page;
 	} while (bh);
 	tail->b_this_page = head;
+	VM_BUG_ON_PAGE(PageCompound(page), page);
 	attach_page_private(page, head);
 }
 
@@ -1577,6 +1578,7 @@ void create_empty_buffers(struct page *page,
 			bh = bh->b_this_page;
 		} while (bh != head);
 	}
+	VM_BUG_ON_PAGE(PageCompound(page), page);
 	attach_page_private(page, head);
 	spin_unlock(&page->mapping->private_lock);
 }
@@ -2565,6 +2567,7 @@ static void attach_nobh_buffers(struct page *page, struct buffer_head *head)
 			bh->b_this_page = head;
 		bh = bh->b_this_page;
 	} while (bh != head);
+	VM_BUG_ON_PAGE(PageCompound(page), page);
 	attach_page_private(page, head);
 	spin_unlock(&page->mapping->private_lock);
 }
