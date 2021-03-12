Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6711338D4F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 13:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhCLMjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 07:39:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:33350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230389AbhCLMjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 07:39:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E866764FDC;
        Fri, 12 Mar 2021 12:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615552756;
        bh=hhVHjKtz+p/MRMENiTP6zT0HrTGyWx2LWy+PKO45tUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zvOWQKMpmQsqz3bY+T7sghSOQhnR5NTY6fLrVZZI8Mt9ihgKjpxM+KsAj21nwLzkW
         4Q/diDxYbShLKRfaJAwJsA1NkCefVYq7d4GJHYFX8sf2hjv9ww/iqvAJ7r3m1zIM0R
         u9gOd7NQrv204tEGnQJDSXmgoGJdjpURVWE2pku8=
Date:   Fri, 12 Mar 2021 13:39:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH v4] f2fs: add sysfs nodes to get runtime compression stat
Message-ID: <YEtg8U7whCVV2tQt@kroah.com>
References: <20210312122531.2717093-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312122531.2717093-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 09:25:31PM +0900, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> I've added new sysfs nodes to show runtime compression stat since mount.
> compr_written_block - show the block count written after compression
> compr_saved_block - show the saved block count with compression
> compr_new_inode - show the count of inode newly enabled for compression
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: thanks to kernel test robot <lkp@intel.com>, fixed compile issue
>     related to kernel config
> v3: changed sysfs nodes' names and made them runtime stat, not
>     persistent on disk
> v4: changed sysfs nodes' desctiption
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs | 24 ++++++++++
>  fs/f2fs/compress.c                      |  1 +
>  fs/f2fs/f2fs.h                          | 19 ++++++++
>  fs/f2fs/super.c                         |  7 +++
>  fs/f2fs/sysfs.c                         | 58 +++++++++++++++++++++++++
>  5 files changed, 109 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index cbeac1bebe2f..ddd4bd6116fc 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -409,3 +409,27 @@ Description:	Give a way to change checkpoint merge daemon's io priority.
>  		I/O priority "3". We can select the class between "rt" and "be",
>  		and set the I/O priority within valid range of it. "," delimiter
>  		is necessary in between I/O class and priority number.
> +
> +What:		/sys/fs/f2fs/<disk>/compr_written_block
> +Date:		March 2021
> +Contact:	"Daeho Jeong" <daehojeong@google.com>
> +Description:	Show the block count written after compression since mount. Note
> +		that when the compressed blocks are deleted, this count doesn't
> +		decrease. If you write "0" here, you can initialize
> +		compr_written_block and compr_saved_block to "0".
> +
> +What:		/sys/fs/f2fs/<disk>/compr_saved_block
> +Date:		March 2021
> +Contact:	"Daeho Jeong" <daehojeong@google.com>
> +Description:	Show the saved block count with compression since mount. Note
> +		that when the compressed blocks are deleted, this count doesn't
> +		decrease. If you write "0" here, you can initialize
> +		compr_written_block and compr_saved_block to "0".
> +
> +What:		/sys/fs/f2fs/<disk>/compr_new_inode
> +Date:		March 2021
> +Contact:	"Daeho Jeong" <daehojeong@google.com>
> +Description:	Show the count of inode newly enabled for compression since mount.
> +		Note that when the compression is disabled for the files, this count
> +		doesn't decrease. If you write "0" here, you can initialize
> +		compr_new_inode to "0".
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 77fa342de38f..3c9d797dbdd6 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -1353,6 +1353,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
>  	if (fio.compr_blocks)
>  		f2fs_i_compr_blocks_update(inode, fio.compr_blocks - 1, false);
>  	f2fs_i_compr_blocks_update(inode, cc->nr_cpages, true);
> +	add_compr_block_stat(inode, cc->nr_cpages);
>  
>  	set_inode_flag(cc->inode, FI_APPEND_WRITE);
>  	if (cc->cluster_idx == 0)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index e2d302ae3a46..2c989f8caf05 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1623,6 +1623,11 @@ struct f2fs_sb_info {
>  #ifdef CONFIG_F2FS_FS_COMPRESSION
>  	struct kmem_cache *page_array_slab;	/* page array entry */
>  	unsigned int page_array_slab_size;	/* default page array slab size */
> +
> +	/* For runtime compression statistics */
> +	atomic64_t compr_written_block;
> +	atomic64_t compr_saved_block;
> +	atomic_t compr_new_inode;

Why do you need these to be atomic?  What requires this?

> +#ifdef CONFIG_F2FS_FS_COMPRESSION
> +	if (!strcmp(a->attr.name, "compr_written_block")) {
> +		u64 bcount;
> +		int len;
> +
> +		bcount = atomic64_read(&sbi->compr_written_block);
> +
> +		len = scnprintf(buf, PAGE_SIZE, "%llu\n", bcount);

Please use sysfs_emit() for new sysfs entries like these.  Makes it much
simpler.

And look, you really do not need an atomic value as this is just a
random number you are sending to userspace that could be stale the
minute you read from it.

Please just use a normal u64 and save the cpu sync for stuff like this.

thanks,

greg k-h
