Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488A83DD2BE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 11:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhHBJQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 05:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:32846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232670AbhHBJQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 05:16:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60B5D604AC;
        Mon,  2 Aug 2021 09:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627895792;
        bh=zrg6mn9Pq04VnDfI2UrnZolDhRXQdluXenAFbQF9jHU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Tqj8mPldpWrnu4rjCKk5phzXBynV6V1p7/oywCQIqxwdrzS5EykLcMyj7hFQQY2a5
         Sg78pfAPHypTrFmjYgxlZWwLESFTPoPiA3CEnwSw7LQDqIKILDT3WKWoa/6mDrqyAH
         n0GZc4B7HZqjHGmvmvRzLnBDSDzYs1VU72sYSbH1gDRo3dImb2S179C04cPofrjMIi
         DQHE8xfNkgrKHbekVOY4dr99bbyH014Dpc0uhOssQPYEynYqgod/aLlX9l0P1Pembp
         f/u63isogqlOWs/0jTCneL//toOFImOqcl9dhS1qjoGoCqRh/U4655+AspGmQLqA9U
         0nhooHMNwLuNg==
Subject: Re: [f2fs-dev] [PATCH] f2fs: add sysfs node to control ra_pages for
 fadvise seq file
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20210722231358.611801-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <54865f0f-7072-c209-4b1d-06a9894dbd55@kernel.org>
Date:   Mon, 2 Aug 2021 17:16:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210722231358.611801-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/7/23 7:13, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> fadvise() allows the user to expand the readahead window to double with
> POSIX_FADV_SEQUENTIAL, now. But, in some use cases, it is not that
> sufficient and we need to meet the need in a restricted way. We can
> control the multiplier value of bdi device readahead between 2 (default)
> and 256 for POSIX_FADV_SEQUENTIAL advise option.

Minor things as below comments....

> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs |  6 +++++
>   fs/f2fs/f2fs.h                          |  2 ++
>   fs/f2fs/file.c                          | 32 +++++++++++++++++++++++++
>   fs/f2fs/super.c                         |  1 +
>   fs/f2fs/sysfs.c                         | 10 ++++++++
>   5 files changed, 51 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 3d1f853c6681..60f1f176374e 100644
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
> index 502e47936651..c59329dcb1f6 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1733,6 +1733,8 @@ struct f2fs_sb_info {
>   	unsigned int gc_segment_mode;		/* GC state for reclaimed segments */
>   	unsigned int gc_reclaimed_segs[MAX_GC_MODE];	/* Reclaimed segs for each mode */
>   
> +	unsigned long seq_file_ra_mul;		/* multiplier for ra_pages of seq. files in fadvise */
> +
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>   	struct kmem_cache *page_array_slab;	/* page array entry */
>   	unsigned int page_array_slab_size;	/* default page array slab size */
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 6afd4562335f..f71c90236815 100644
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
> @@ -4332,6 +4333,36 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	return ret;
>   }
>   
> +static int f2fs_file_fadvise(struct file *filp, loff_t offset, loff_t len,
> +		int advice)
> +{
> +	int ret;
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
> +		filp->f_ra.ra_pages = bdi->ra_pages * F2FS_I_SB(inode)->seq_file_ra_mul;

Exceed 80 columns...

> +		spin_lock(&filp->f_lock);
> +		filp->f_mode &= ~FMODE_RANDOM;
> +		spin_unlock(&filp->f_lock);
> +		return 0;
> +	}
> +
> +	ret = generic_fadvise(filp, offset, len, advice);
> +
> +	return ret;

return generic_fadvise(filp, offset, len, advice); ?

Then we can remove @ret definition.

> +}
> +
>   #ifdef CONFIG_COMPAT
>   struct compat_f2fs_gc_range {
>   	u32 sync;
> @@ -4460,4 +4491,5 @@ const struct file_operations f2fs_file_operations = {
>   #endif
>   	.splice_read	= generic_file_splice_read,
>   	.splice_write	= iter_file_splice_write,
> +	.fadvise	= f2fs_file_fadvise,
>   };
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 9089303f7f8c..ccb745807fe1 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3312,6 +3312,7 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>   	sbi->next_victim_seg[FG_GC] = NULL_SEGNO;
>   	sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
>   	sbi->migration_granularity = sbi->segs_per_sec;
> +	sbi->seq_file_ra_mul = 2;
>   
>   	sbi->dir_level = DEF_DIR_LEVEL;
>   	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 15fe30d3aeb5..9a21be63436d 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -538,6 +538,14 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "seq_file_ra_mul")) {
> +		if (t >= 2 && t <= 256)

Would it be better to use macro to instead number?

Thanks,

> +			sbi->seq_file_ra_mul = t;
> +		else
> +			return -EINVAL;
> +		return count;
> +	}
> +
>   	*ui = (unsigned int)t;
>   
>   	return count;
> @@ -763,6 +771,7 @@ F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_candidate_count, max_candidate_cou
>   F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_weight, age_weight);
>   F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_threshold, age_threshold);
>   
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, seq_file_ra_mul, seq_file_ra_mul);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_segment_mode, gc_segment_mode);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_reclaimed_segments, gc_reclaimed_segs);
>   
> @@ -838,6 +847,7 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(atgc_candidate_count),
>   	ATTR_LIST(atgc_age_weight),
>   	ATTR_LIST(atgc_age_threshold),
> +	ATTR_LIST(seq_file_ra_mul),
>   	ATTR_LIST(gc_segment_mode),
>   	ATTR_LIST(gc_reclaimed_segments),
>   	NULL,
> 
