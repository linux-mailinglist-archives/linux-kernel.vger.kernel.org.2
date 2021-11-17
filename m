Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81C05454B76
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbhKQQ7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:59:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230016AbhKQQ7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:59:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 017BA62F90;
        Wed, 17 Nov 2021 16:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637168206;
        bh=wYYq7JIGe7T++RofZFKvll3ULuqrZ5GmSq0XgEF6dLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJ64db7zU0rPyM9idZqgcTR6z4iaRgkd1bHhCLtECrpDeAe26x/IC9f7xE1HlXDsP
         ZgLHJFEJd7wrm9Bn1sqPFN79gu3CpqTpXF7NxkIOKit2jXZJyfxSN/UCkx0hUb7HtA
         DNGn9aR0pAElK8Og5IPhDFd/Tv5mviD/LgIumrrCKT5F5WSjF6mBf7EyDQzgo8S+ai
         +Ig4kGDZTIM6ZYCAeAxFmwKp/QWPgbBEg2mceBy23eoZc+/MyjDiApZp53andbLusA
         stur58N23gRrD1hxWyViiJKxEJrRHdlcodx8+JcQ0uauDKcHiyXOI+++WVYMwPZPC6
         YxDqdNfPovt9Q==
Date:   Wed, 17 Nov 2021 08:56:44 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     niuzhiguo84@gmail.com
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jing.Xia@unisoc.com
Subject: Re: [PATCH Vx 1/1] f2fs: Avoid deadlock between writeback and
 checkpoint
Message-ID: <YZU0TFBH6k2Q6fJZ@google.com>
References: <1636438608-27597-1-git-send-email-niuzhiguo84@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636438608-27597-1-git-send-email-niuzhiguo84@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09, niuzhiguo84@gmail.com wrote:
> From: Zhiguo Niu <zhiguo.niu@unisoc.com>
> 
> There could be a scenario as following:
> The inodeA and inodeB are in b_io queue of writeback
> inodeA : f2fs's node inode
> inodeB : a dir inode with only one dirty pages, and the node page
> of inodeB cached into inodeA
> 
> writeback:
> 
> wb_workfn
> wb_writeback
> blk_start_plug
>         loop {
>         queue_io
>         progress=__writeback_inodes_wb
>                 __writeback_single_inode
>                         do_writepages
>                                 f2fs_write_data_pages
>                                 wbc->pages_skipped +=get_dirty_pages
>                         inode->i_state &= ~dirty
>                 wrote++
>                 requeue_inode
>         }
> blk_finish_plug
> 
> checkpoint:
> 
> f2fs_write_checkpoint
> f2fs_sync_dirty_inodes
> filemap_fdatawrite
> do_writepages
> f2fs_write_data_pages
>         f2fs_write_single_data_page
>                 f2fs_do_write_data_page
>                         set_page_writeback
>                         f2fs_outplace_write_data
>                                 f2fs_update_data_blkaddr
>                                         f2fs_wait_on_page_writeback
>                 inode_dec_dirty_pages
> 
> 1. Writeback thread flush inodeA, and push it's bio request in task's plug;
> 2. Checkpoint thread writes inodeB's dirty page, and then wait its node
>     page writeback cached into inodeA which is in writeback task's plug
> 3. Writeback thread flush inodeB and skip writing the dirty page as
>     wb_sync_req[DATA] > 0.
> 4. As none of the inodeB's page is marked as PAGECACHE_TAG_DIRTY, writeback
>     thread clear inodeB's dirty state.
> 5. Then inodeB is moved from b_io to b_dirty because of pages_skipped > 0
>     as checkpoint thread is stuck before dec dirty_pages.
> 
> This patch collect correct pages_skipped according to the tag state in
> page tree of inode
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Jing Xia <jing.xia@unisoc.com>
> ---
>  fs/f2fs/data.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index f4fd6c246c9a..e98628e3868c 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -3237,7 +3237,9 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>  	return ret;
>  
>  skip_write:
> -	wbc->pages_skipped += get_dirty_pages(inode);
> +	wbc->pages_skipped +=
> +		mapping_tagged(inode->i_mapping, PAGECACHE_TAG_DIRTY) ?

Is there any race condition to get 0, if there's any dirty page? IOWs, it
seems the current condition is just requeuing the inode as dirty, but next
flushing time will remove it from dirty list. Is this giving too much overheads?

> +		get_dirty_pages(inode) : 0;
>  	trace_f2fs_writepages(mapping->host, wbc, DATA);
>  	return 0;
>  }
> -- 
> 2.28.0
