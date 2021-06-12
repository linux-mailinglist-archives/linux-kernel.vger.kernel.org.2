Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC9A3A50C0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 23:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbhFLVHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 17:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLVHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 17:07:49 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F9BC061574
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 14:05:49 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsAp2-007R1x-4p; Sat, 12 Jun 2021 21:05:40 +0000
Date:   Sat, 12 Jun 2021 21:05:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC 4/9] gfs2: Fix mmap + page fault deadlocks (part 1)
Message-ID: <YMUhpI/ZIuxvKCt8@zeniv-ca.linux.org.uk>
References: <20210531170123.243771-1-agruenba@redhat.com>
 <20210531170123.243771-5-agruenba@redhat.com>
 <CAHk-=wiB9gvUsebmiOaRXzYVUxJDUt1SozGtRyxR_MDR=Nv7YQ@mail.gmail.com>
 <CAHc6FU4n_F9sPjP7getGRKLpB-KsZt_qhHctqwY5pJrxGxLr2w@mail.gmail.com>
 <YMOOZsBzg/6SKSzT@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMOOZsBzg/6SKSzT@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 04:25:10PM +0000, Al Viro wrote:
> On Wed, Jun 02, 2021 at 01:16:32PM +0200, Andreas Gruenbacher wrote:
> 
> > Well, iomap_file_buffered_write() does that by using
> > iov_iter_fault_in_readable() and iov_iter_copy_from_user_atomic() as
> > in iomap_write_actor(), but the read and direct I/O side doesn't seem
> > to have equivalents. I suspect we can't just wrap
> > generic_file_read_iter() and iomap_dio_rw() calls in
> > pagefault_disable().
> 
> And it will have zero effect on O_DIRECT case, so you get the same
> deadlocks right back.  Because there you hit
> 	iomap_dio_bio_actor()
> 		bio_iov_iter_get_pages()
> 			....
> 				get_user_pages_fast()
> 					....
> 						faultin_page()
> 							handle_mm_fault()
> and at no point had CPU hit an exception, so disable_pagefault() will
> have no effect whatsoever.  You can bloody well hit gfs2 readpage/mkwrite
> if the destination is in mmapped area of some GFS2 file.  Do that
> while holding GFS2 locks and you are fucked.
> 
> No amount of prefaulting will protect you, BTW - it might make the
> deadlock harder to reproduce, but that's it.

AFAICS, what we have is
	* handle_mm_fault() can hit gfs2_fault(), which grabs per-inode lock
shared
	* handle_mm_fault() for write can hit gfs2_page_mkwrite(), which grabs
per-inode lock exclusive
	* pagefault_disable() prevents that for real page faults, but not for
get_user_pages_fast()
	* normal write:
        with inode_lock(inode)
		in a loop
			with per-inode lock exclusive
				__gfs2_iomap_get
				possibly gfs2_iomap_begin_write
				in a loop
					fault-in [read faults]
					iomap_write_begin
					copy_page_from_iter_atomic() [pf disabled]
					iomap_write_end
				gfs2_iomap_end
	* O_DIRECT write:
	with inode_lock(inode) and per-inode lock deferred (?)
		in a loop
			__gfs2_iomap_get
			possibly gfs2_iomap_begin_write
			bio_iov_iter_get_pages(), map and submit [gup]
			gfs2_iomap_end
	* normal read:
		in a loop
			filemap_get_pages (grab pages and readpage them if needed)
			copy_page_to_iter() for each [write faults]
	* O_DIRECT read:
        with per-inode lock deferred
		in a loop
			__gfs2_iomap_get
			either iov_iter_zero() (on hole) [write faults]
			or bio_iov_iter_get_pages(), map and submit [gup]
			gfs2_iomap_end

... with some amount of waiting on buffered IO in case of O_DIRECT writes

Is the above an accurate description of the mainline situation there?
In particular, normal read doesn't seem to bother with locks at all.
What exactly are those cluster locks for in O_DIRECT read?
