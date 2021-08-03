Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9E63DE47C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 04:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbhHCCmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 22:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:34666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233197AbhHCCmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 22:42:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BD80660EE8;
        Tue,  3 Aug 2021 02:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627958530;
        bh=xXMRW/WDePCFaDeizqziaVM0jOmidKkj8W5d5Jyazwo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EDQpDTrYyA6wHEV6hLIhGqF3bmlG2ajVIzj9NvGtdXiN3fAKhm+aN2X3zHGEptMtV
         dCAH8AmLckZONV3Rw8KMZlram3ql5hRXOY5w6HOPj1qDosVJowbRXpIZrZ/Nfs9QV0
         7djtGEf4iVtQUueHfxN5E5gwDCiSvPs/oLOT19+wbp11L9uin3FNgNPL5UoS9ji4rX
         nxiWJeXHz6t4VMAIejoEbJQ+FHxJ7zk6f3BX1bSFGrjRfQ0RYf9V1SkvUk1w+lVv5z
         7231aUbSuqY73FLi8f2ueaZgpiH8T35rxFqwP3KHQkVh6sfzGdSEpfGXveQ9KMyZQL
         YSMX8CR/W0GxQ==
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add sysfs node to control ra_pages
 for fadvise seq file
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Daeho Jeong <daehojeong@google.com>
References: <20210802175703.895964-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <448ec877-7486-c02b-e6ba-3c32aafff9bf@kernel.org>
Date:   Tue, 3 Aug 2021 10:42:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210802175703.895964-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/3 1:57, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> fadvise() allows the user to expand the readahead window to double with
> POSIX_FADV_SEQUENTIAL, now. But, in some use cases, it is not that
> sufficient and we need to meet the need in a restricted way. We can
> control the multiplier value of bdi device readahead between 2 (default)
> and 256 for POSIX_FADV_SEQUENTIAL advise option.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> ---
> v2: fix minor style issues
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs |  6 +++++
>   fs/f2fs/f2fs.h                          |  2 ++
>   fs/f2fs/file.c                          | 30 +++++++++++++++++++++++++
>   fs/f2fs/super.c                         |  1 +
>   fs/f2fs/sysfs.c                         | 13 +++++++++++
>   5 files changed, 52 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 845c4be535b0..73211f77d11e 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -507,3 +507,9 @@ Date:		July 2021
>   Contact:	"Daeho Jeong" <daehojeong@google.com>
>   Description:	You can control for which gc mode the "gc_reclaimed_segments" node shows.
>   		Refer to the description of the modes in "gc_reclaimed_segments".
> +
> +What:		/sys/fs/f2fs/<disk>/seq_file_ra_mul
> +Date:		July 2021
> +Contact:	"Daeho Jeong" <daehojeong@google.com>
> +Description:	You can	control the multiplier value of	bdi device readahead window size
> +		between 2 (default) and 256 for POSIX_FADV_SEQUENTIAL advise option.
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 8459b6d5a2f8..5d16486feb8f 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1738,6 +1738,8 @@ struct f2fs_sb_info {
>   	unsigned int gc_segment_mode;		/* GC state for reclaimed segments */
>   	unsigned int gc_reclaimed_segs[MAX_GC_MODE];	/* Reclaimed segs for each mode */
>   
> +	unsigned long seq_file_ra_mul;		/* multiplier for ra_pages of seq. files in fadvise */
> +
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>   	struct kmem_cache *page_array_slab;	/* page array entry */
>   	unsigned int page_array_slab_size;	/* default page array slab size */
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index b1cb5b50faac..1a631e6d3e9b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -23,6 +23,7 @@
>   #include <linux/nls.h>
>   #include <linux/sched/signal.h>
>   #include <linux/fileattr.h>
> +#include <linux/fadvise.h>
>   
>   #include "f2fs.h"
>   #include "node.h"
> @@ -4332,6 +4333,34 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	return ret;
>   }
>   
> +static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
> +		int advice)
> +{
> +	struct inode *inode;
> +	struct address_space *mapping;
> +	struct backing_dev_info *bdi;
> +
> +	if (advice == POSIX_FADV_SEQUENTIAL) {
> +		inode = file_inode(filp);
> +		if (S_ISFIFO(inode->i_mode))
> +			return -ESPIPE;
> +
> +		mapping = filp->f_mapping;
> +		if (!mapping || len < 0)
> +			return -EINVAL;
> +
> +		bdi = inode_to_bdi(mapping->host);
> +		filp->f_ra.ra_pages = bdi->ra_pages *
> +			F2FS_I_SB(inode)->seq_file_ra_mul;
> +		spin_lock(&filp->f_lock);
> +		filp->f_mode &= ~FMODE_RANDOM;
> +		spin_unlock(&filp->f_lock);
> +		return 0;
> +	}
> +
> +	return generic_fadvise(filp, offset, len, advice);
> +}
> +
>   #ifdef CONFIG_COMPAT
>   struct compat_f2fs_gc_range {
>   	u32 sync;
> @@ -4460,4 +4489,5 @@ const struct file_operations f2fs_file_operations = {
>   #endif
>   	.splice_read	= generic_file_splice_read,
>   	.splice_write	= iter_file_splice_write,
> +	.fadvise	= f2fs_file_fadvise,
>   };
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 72eb9d70969f..41765e90caa2 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3422,6 +3422,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>   	sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
>   	sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
>   	sbi->migration_granularity = sbi->segs_per_sec;
> +	sbi->seq_file_ra_mul = 2;

sbi->seq_file_ra_mul = MIN_RA_MUL;

Otherwise, it looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


>   
>   	sbi->dir_level = DEF_DIR_LEVEL;
>   	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index b1725620c07d..44b086e5b607 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -50,6 +50,9 @@ struct f2fs_attr {
>   	int id;
>   };
>   
> +#define MIN_RA_MUL	2
> +#define MAX_RA_MUL	256
> +
>   static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
>   			     struct f2fs_sb_info *sbi, char *buf);
>   
> @@ -538,6 +541,14 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "seq_file_ra_mul")) {
> +		if (t >= MIN_RA_MUL && t <= MAX_RA_MUL)
> +			sbi->seq_file_ra_mul = t;
> +		else
> +			return -EINVAL;
> +		return count;
> +	}
> +
>   	*ui = (unsigned int)t;
>   
>   	return count;
> @@ -763,6 +774,7 @@ F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_candidate_count, max_candidate_cou
>   F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_weight, age_weight);
>   F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_threshold, age_threshold);
>   
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, seq_file_ra_mul, seq_file_ra_mul);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_segment_mode, gc_segment_mode);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_reclaimed_segments, gc_reclaimed_segs);
>   
> @@ -838,6 +850,7 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(atgc_candidate_count),
>   	ATTR_LIST(atgc_age_weight),
>   	ATTR_LIST(atgc_age_threshold),
> +	ATTR_LIST(seq_file_ra_mul),
>   	ATTR_LIST(gc_segment_mode),
>   	ATTR_LIST(gc_reclaimed_segments),
>   	NULL,
> 
