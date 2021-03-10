Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F8133491D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 21:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhCJUtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 15:49:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:59072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230491AbhCJUtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:49:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 208F664FC6;
        Wed, 10 Mar 2021 20:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615409362;
        bh=8Lubpt2RtIi1IKD8AnfhhcFsPyM8ZlZWqojFGL66AEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQhX5z72m4tWNc1wPcJL4+eNCCqDixQzxar0vIqh+ktQmQmEMsYW2KARrqaR/sQz4
         xpu0uPizxIRDEbDLwNJkkihaImSz+OqHzM6htvp4AHC9W4ll/3jEg2WbWoZ4tyAOl7
         XkRO6Dg4iZygdESiVlzkh5G4V3li+h3I0Uc84TN4rj3JWGIf9McWsQP4FCfYvLSofw
         5I86XkYXRXb76K/gPmswQCXUYxkai7RHD5vZ+HhgNvAVVe3QWJcbOZ2uzdhuntCUMp
         kAy8FBMwT8QmYbaoMNw70iSw8ElSfrOJ14GwFobOzWND+101iubMUZkqpDuoL4TXua
         2uqd9ngJtrxig==
Date:   Wed, 10 Mar 2021 12:49:20 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Weichao Guo <guoweichao@oppo.com>, rpalethorpe@suse.de,
        kernel test robot <oliver.sang@intel.com>, lkp@intel.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        Chao Yu <yuchao0@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        ltp@lists.linux.it
Subject: Re: [LTP] [f2fs] 02eb84b96b: ltp.swapon03.fail
Message-ID: <YEkw0J9VEg66AgIt@google.com>
References: <20210308072510.GA902@xsang-OptiPlex-9020>
 <87h7llhnfe.fsf@suse.de>
 <c75229cc-e325-1c8b-0afa-fd236db8319c@oppo.com>
 <20210309040144.GH3479805@casper.infradead.org>
 <c84bf5c9-501e-6c25-1728-a7c6281093fd@oppo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c84bf5c9-501e-6c25-1728-a7c6281093fd@oppo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/10, Huang Jianan wrote:
> Hi Richard,
> 
> On 2021/3/9 12:01, Matthew Wilcox wrote:
> > On Tue, Mar 09, 2021 at 10:23:35AM +0800, Weichao Guo wrote:
> > > Hi Richard,
> > > 
> > > On 2021/3/8 19:53, Richard Palethorpe wrote:
> > > > Hello,
> > > > 
> > > > > kern  :err   : [  187.461914] F2FS-fs (sda1): Swapfile does not align to section
> > > > > commit 02eb84b96bc1b382dd138bf60724edbefe77b025
> > > > > Author: huangjianan@oppo.com <huangjianan@oppo.com>
> > > > > Date:   Mon Mar 1 12:58:44 2021 +0800
> > > > >       f2fs: check if swapfile is section-alligned
> > > > >       If the swapfile isn't created by pin and fallocate, it can't be
> > > > >       guaranteed section-aligned, so it may be selected by f2fs gc. When
> > > > >       gc_pin_file_threshold is reached, the address of swapfile may change,
> > > > >       but won't be synchronized to swap_extent, so swap will write to wrong
> > > > >       address, which will cause data corruption.
> > > > >       Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > > > >       Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> > > > >       Reviewed-by: Chao Yu <yuchao0@huawei.com>
> > > > >       Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > The test uses fallocate to preallocate the swap file and writes zeros to
> > > > it. I'm not sure what pin refers to?
> > > 'pin' refers to pinned file feature in F2FS, the LBA(Logical Block Address)
> > > of a file is fixed after pinned. Without this operation before fallocate,
> > > the LBA may not align with section(F2FS GC unit), some LBA of the file may
> > > be changed by F2FS GC in some extreme cases.
> > > 
> > > For this test case, how about pin the swap file before fallocate for F2FS as
> > > following:
> > > 
> > > ioctl(fd, F2FS_IOC_SET_PIN_FILE, true);
> > No special ioctl should be needed.  f2fs_swap_activate() should pin the
> > file, just like it converts inline inodes and disables compression.
> 
> Now f2fs_swap_activate() will pin the file. The problem is that when
> f2fs_swap_activate()
> 
> is executed, the file has been created and may not be section-aligned.
> 
> So I think it would be better to consider aligning the swapfile during
> f2fs_swap_activate()?

Does it make sense to reallocate blocks like
in f2fs_swap_activate(),
	set_inode_flag(inode, FI_PIN_FILE);
	truncate_pagecache(inode, 0);
	f2fs_truncate_blocks(inode, 0, true);
	expand_inode_data();
