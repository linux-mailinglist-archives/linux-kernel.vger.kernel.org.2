Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA643F9403
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 07:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbhH0F1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 01:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhH0F11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 01:27:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DCE760F4C;
        Fri, 27 Aug 2021 05:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630041989;
        bh=FBmNSAmhYL1ZVElKyZX49jE7psvhuV0gJ/StadT7LPM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=E3e4cT+kwTd+lEIz2oxt8066+ihUJYP/UBTE2oSDSEtN14ieRcgsdlj4MmgrVBsoq
         jxGWvIr/UtuyfCfBmqtYBXhwQNpxPAAk11cBUxKi6MVvMRun+PwEtLBWcM+YBvx/C2
         UK+wP60BBzpIyDg8JVmh9aX+qgXaKjjysOsvpBlwe4GY759P9rtq3kuqIJq6XKdk7S
         rWVYtZhut3qeVovwwfD8e28bcOCEOhSEosujDaVuB8TZptKKtnLCqsGE9l3qTbD3JP
         AXvPdXWsF2Ry+sEeQs9hcOPLXHD8GQr5euO2KVb7qyTmHhDSPtsNOK5SVLoj+7hj3e
         /lig56jPquFmw==
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce fragment allocation mode
 mount option
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20210825185747.1627497-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <1f1e6d38-6bd1-17ea-b8ca-a45d1244728f@kernel.org>
Date:   Fri, 27 Aug 2021 13:26:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210825185747.1627497-1-daeho43@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/26 2:57, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added two options into "mode=" mount option to make it possible for
> developers to make the filesystem fragmented or simulate filesystem
> fragmentation/after-GC situation itself. The developers use these modes
> to understand filesystem fragmentation/after-GC condition well,
> and eventually get some insights to handle them better.
> 
> "fragment:segment": f2fs allocates a new segment in ramdom position.
>                      With this, we can simulate the after-GC condition.
> "fragment:block"  : We can scatter block allocation with
>                      "fragment_chunk_max" and "fragment_hole_max" sysfs
>                      nodes. f2fs will allocate 1..<fragment_chunk_max>
>                      blocks in a chunk and make a hole in the length of
>                      1..<fragment_hole_max> by turns in a newly allocated
>                      free segment.

I'd like to add a fixed chunk/hole fragmentation mode in addition, then
userspace can control the fragmented chunk/hole with fixed size.

How do you think of renaming "fragment:block" to "fragment:rand_block", and
then I can add "fragment:fixed_block" option and its logic in addition?

> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v2: changed mode name and added sysfs nodes to control the fragmentation
>      pattern.
> ---
>   Documentation/ABI/testing/sysfs-fs-f2fs | 18 ++++++++++++++++++
>   Documentation/filesystems/f2fs.rst      | 16 ++++++++++++++++
>   fs/f2fs/f2fs.h                          | 16 ++++++++++++++++
>   fs/f2fs/gc.c                            |  5 ++++-
>   fs/f2fs/segment.c                       | 17 +++++++++++++++--
>   fs/f2fs/super.c                         | 11 +++++++++++
>   fs/f2fs/sysfs.c                         | 20 ++++++++++++++++++++
>   7 files changed, 100 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index f627e705e663..dba3997895ef 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -512,3 +512,21 @@ Date:		July 2021
>   Contact:	"Daeho Jeong" <daehojeong@google.com>
>   Description:	You can	control the multiplier value of	bdi device readahead window size
>   		between 2 (default) and 256 for POSIX_FADV_SEQUENTIAL advise option.
> +
> +What:		/sys/fs/f2fs/<disk>/fragment_chunk_max
> +Date:		August 2021
> +Contact:	"Daeho Jeong" <daehojeong@google.com>
> +Description:	With "mode=fragment:block" mount option, we can scatter block allocation.
> +		Using this node, f2fs will allocate 1..<fragment_chunk_max> blocks in a chunk
> +		and make a hole in the length of 1..<fragment_hole_max> by turns in a newly
> +		allocated free segment. This value can be set between 1..512 and the default
> +		value is 4.
> +
> +What:		/sys/fs/f2fs/<disk>/fragment_hole_max
> +Date:		August 2021
> +Contact:	"Daeho Jeong" <daehojeong@google.com>
> +Description:	With "mode=fragment:block" mount option, we can scatter block allocation.
> +		Using this node, f2fs will allocate 1..<fragment_chunk_max> blocks in a chunk
> +		and make a hole in the length of 1..<fragment_hole_max> by turns in a newly
> +		allocated free segment. This value can be set between 1..512 and the default
> +		value is 4.
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 09de6ebbbdfa..d2ddc1273f67 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -201,6 +201,22 @@ fault_type=%d		 Support configuring fault injection type, should be
>   mode=%s			 Control block allocation mode which supports "adaptive"
>   			 and "lfs". In "lfs" mode, there should be no random
>   			 writes towards main area.
> +			 "fragment:segment" and "fragment:block" are newly added here.
> +			 These are developer options for experiments to make the filesystem
> +			 fragmented or simulate filesystem fragmentation/after-GC situation
> +			 itself. The developers use these modes to understand filesystem
> +			 fragmentation/after-GC condition well, and eventually get some
> +			 insights to handle them better.
> +			 In "fragment:segment", f2fs allocates a new segment in ramdom
> +			 position. With this, we can simulate the after-GC condition.
> +			 In "fragment:block", we can scatter block allocation with
> +			 "fragment_chunk_max" and "fragment_hole_max" sysfs nodes. f2fs will
> +			 allocate 1..<fragment_chunk_max> blocks in a chunk and make
> +			 a hole in the length of 1..<fragment_hole_max> by turns in a newly
> +			 allocated free segment. With this, the newly allocated blocks will
> +			 be scattered throughout the whole partition. Please, use these
> +			 options for your experiments and we strongly recommend to re-format
> +			 the filesystem after using these options.
>   io_bits=%u		 Set the bit size of write IO requests. It should be set
>   			 with "mode=lfs".
>   usrquota		 Enable plain user disk quota accounting.
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index c24f03e054cb..4e591fc75ee7 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1287,6 +1287,8 @@ enum {
>   enum {
>   	FS_MODE_ADAPTIVE,	/* use both lfs/ssr allocation */
>   	FS_MODE_LFS,		/* use lfs allocation only */
> +	FS_MODE_FRAGMENT_SEG,	/* segment fragmentation mode */
> +	FS_MODE_FRAGMENT_BLK,	/* block fragmentation mode */
>   };
>   
>   enum {
> @@ -1757,6 +1759,10 @@ struct f2fs_sb_info {
>   
>   	unsigned long seq_file_ra_mul;		/* multiplier for ra_pages of seq. files in fadvise */
>   
> +	int fragment_chunk_max;		/* the maximum chunk size for fragment:block allocation mode */
> +	int fragment_hole_max;		/* the maximum hole size for fragment:block allocation mode */
> +	int fragment_remained_chunk;	/* remained size to make a full chunk */
> +
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>   	struct kmem_cache *page_array_slab;	/* page array entry */
>   	unsigned int page_array_slab_size;	/* default page array slab size */
> @@ -3517,6 +3523,16 @@ unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
>   unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
>   			unsigned int segno);
>   
> +#define DEF_FRAGMENT_SIZE	4
> +#define MIN_FRAGMENT_SIZE	1
> +#define MAX_FRAGMENT_SIZE	512
> +
> +static inline bool f2fs_fragment_mode(struct f2fs_sb_info *sbi)
> +{
> +	return F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_SEG ||
> +		F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK;
> +}
> +
>   /*
>    * checkpoint.c
>    */
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 2c18443972b6..14046fb19a20 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -14,6 +14,7 @@
>   #include <linux/delay.h>
>   #include <linux/freezer.h>
>   #include <linux/sched/signal.h>
> +#include <linux/random.h>
>   
>   #include "f2fs.h"
>   #include "node.h"
> @@ -257,7 +258,9 @@ static void select_policy(struct f2fs_sb_info *sbi, int gc_type,
>   		p->max_search = sbi->max_victim_search;
>   
>   	/* let's select beginning hot/small space first in no_heap mode*/
> -	if (test_opt(sbi, NOHEAP) &&
> +	if (f2fs_fragment_mode(sbi))
> +		p->offset = prandom_u32() % (MAIN_SECS(sbi) * sbi->segs_per_sec);
> +	else if (test_opt(sbi, NOHEAP) &&
>   		(type == CURSEG_HOT_DATA || IS_NODESEG(type)))
>   		p->offset = 0;
>   	else
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index a135d2247415..0063c8ce18ac 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -15,6 +15,7 @@
>   #include <linux/timer.h>
>   #include <linux/freezer.h>
>   #include <linux/sched/signal.h>
> +#include <linux/random.h>
>   
>   #include "f2fs.h"
>   #include "segment.h"
> @@ -2630,6 +2631,8 @@ static unsigned int __get_next_segno(struct f2fs_sb_info *sbi, int type)
>   	unsigned short seg_type = curseg->seg_type;
>   
>   	sanity_check_seg_type(sbi, seg_type);
> +	if (f2fs_fragment_mode(sbi))
> +		return prandom_u32() % (MAIN_SECS(sbi) * sbi->segs_per_sec);
>   
>   	/* if segs_per_sec is large than 1, we need to keep original policy. */
>   	if (__is_large_section(sbi))
> @@ -2707,12 +2710,22 @@ static int __next_free_blkoff(struct f2fs_sb_info *sbi,
>   static void __refresh_next_blkoff(struct f2fs_sb_info *sbi,
>   				struct curseg_info *seg)
>   {
> -	if (seg->alloc_type == SSR)
> +	if (seg->alloc_type == SSR) {
>   		seg->next_blkoff =
>   			__next_free_blkoff(sbi, seg->segno,
>   						seg->next_blkoff + 1);
> -	else
> +	} else {
>   		seg->next_blkoff++;
> +		/* To allocate block chunks in different sizes, use random number */
> +		if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK) {
> +			if (--sbi->fragment_remained_chunk <= 0) {

Do we need to consider multiple thread scenario? in such case,
.fragment_remained_chunk may update randomly.

In addition, multiple log headers share one .fragment_remained_chunk,
it may cause unexpected result, it means there may be continuous holes
or chunks in locality due to swithing between different log headers.

Thanks,

> +				sbi->fragment_remained_chunk =
> +				    prandom_u32() % sbi->fragment_chunk_max + 1;
> +				seg->next_blkoff +=
> +				    prandom_u32() % sbi->fragment_hole_max + 1;
> +			}
> +		}
> +	}
>   }
>   
>   bool f2fs_segment_has_free_slot(struct f2fs_sb_info *sbi, int segno)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 49e153fd8183..112b50bed186 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -817,6 +817,10 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   				F2FS_OPTION(sbi).fs_mode = FS_MODE_ADAPTIVE;
>   			} else if (!strcmp(name, "lfs")) {
>   				F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
> +			} else if (!strcmp(name, "fragment:segment")) {
> +				F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_SEG;
> +			} else if (!strcmp(name, "fragment:block")) {
> +				F2FS_OPTION(sbi).fs_mode = FS_MODE_FRAGMENT_BLK;
>   			} else {
>   				kfree(name);
>   				return -EINVAL;
> @@ -1897,6 +1901,10 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>   		seq_puts(seq, "adaptive");
>   	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_LFS)
>   		seq_puts(seq, "lfs");
> +	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_SEG)
> +		seq_puts(seq, "fragment:segment");
> +	else if (F2FS_OPTION(sbi).fs_mode == FS_MODE_FRAGMENT_BLK)
> +		seq_puts(seq, "fragment:block");
>   	seq_printf(seq, ",active_logs=%u", F2FS_OPTION(sbi).active_logs);
>   	if (test_opt(sbi, RESERVE_ROOT))
>   		seq_printf(seq, ",reserve_root=%u,resuid=%u,resgid=%u",
> @@ -3515,6 +3523,9 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
>   	sbi->max_victim_search = DEF_MAX_VICTIM_SEARCH;
>   	sbi->migration_granularity = sbi->segs_per_sec;
>   	sbi->seq_file_ra_mul = MIN_RA_MUL;
> +	sbi->fragment_chunk_max = DEF_FRAGMENT_SIZE;
> +	sbi->fragment_hole_max = DEF_FRAGMENT_SIZE;
> +	sbi->fragment_remained_chunk = DEF_FRAGMENT_SIZE;
>   
>   	sbi->dir_level = DEF_DIR_LEVEL;
>   	sbi->interval_time[CP_TIME] = DEF_CP_INTERVAL;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index a1a3e0f6d658..42c41efd21d3 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -551,6 +551,22 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>   		return count;
>   	}
>   
> +	if (!strcmp(a->attr.name, "fragment_chunk_max")) {
> +		if (t >= MIN_FRAGMENT_SIZE && t <= MAX_FRAGMENT_SIZE)
> +			sbi->fragment_chunk_max = t;
> +		else
> +			return -EINVAL;
> +		return count;
> +	}
> +
> +	if (!strcmp(a->attr.name, "fragment_hole_max")) {
> +		if (t >= MIN_FRAGMENT_SIZE && t <= MAX_FRAGMENT_SIZE)
> +			sbi->fragment_hole_max = t;
> +		else
> +			return -EINVAL;
> +		return count;
> +	}
> +
>   	*ui = (unsigned int)t;
>   
>   	return count;
> @@ -781,6 +797,8 @@ F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_age_threshold, age_threshold);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, seq_file_ra_mul, seq_file_ra_mul);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_segment_mode, gc_segment_mode);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, gc_reclaimed_segments, gc_reclaimed_segs);
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, fragment_chunk_max, fragment_chunk_max);
> +F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, fragment_hole_max, fragment_hole_max);
>   
>   #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
>   static struct attribute *f2fs_attrs[] = {
> @@ -859,6 +877,8 @@ static struct attribute *f2fs_attrs[] = {
>   	ATTR_LIST(seq_file_ra_mul),
>   	ATTR_LIST(gc_segment_mode),
>   	ATTR_LIST(gc_reclaimed_segments),
> +	ATTR_LIST(fragment_chunk_max),
> +	ATTR_LIST(fragment_hole_max),
>   	NULL,
>   };
>   ATTRIBUTE_GROUPS(f2fs);
> 
