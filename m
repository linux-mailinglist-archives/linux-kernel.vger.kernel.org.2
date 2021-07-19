Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDDF3CED54
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383649AbhGSSAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 14:00:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347062AbhGSRrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 13:47:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B121C610FB;
        Mon, 19 Jul 2021 18:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626719282;
        bh=0sxDTKuzMH5LRU9yn81JSKxB0IFa5jilKBjNi76HKGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pb74NKvHOWrZ+tcjy3xo6ajtnQ3h8TfKH0NM2pwMApiV9m7PYeyqAb8OelS78/V3k
         MegyK15fdxqbWpotdLfZuXhExc/dB7csYzj7JOdxRXk8Wp9Ktu4G3igxLFXsJGrCyk
         K62abEorRM5Og365O4p0726I5ou3Kw7mETE8CloK+KuKrcxW7+pMAPdeLxjUeX6rQh
         Dj1ttfQ7F+hisLFVJKvfhq7B+KjwWeR38KC2WueMVXnem98tgmx+shIY/FOTxAWvlE
         QAD4GAte8wBzo/bk6zf9zpa5steQeoTvAzb8xUjrilFlP+B2GdT6nIKgrjMZ++xFIi
         ujTsIEk1s1bxw==
Date:   Mon, 19 Jul 2021 11:28:01 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
Subject: Re: [PATCH] f2fs: multidevice: support direct IO
Message-ID: <YPXEMU8nQdv8n4Dg@google.com>
References: <20210719084729.26117-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719084729.26117-1-chao@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19, Chao Yu wrote:
> Commit 3c62be17d4f5 ("f2fs: support multiple devices") missed
> to support direct IO for multiple device feature, this patch
> adds to support the missing part of multidevice feature.
> 
> In addition, for multiple device image, we should be aware of
> any issued direct write IO rather than just buffered write IO,
> so that fsync and syncfs can issue a preflush command to the
> device where direct write IO goes, to persist user data for
> posix compliant.

Is this aligned to Eric's iomap work?

> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c    | 52 +++++++++++++++++++++++++++++++++++++++++++++--
>  fs/f2fs/f2fs.h    | 24 +++++++++++++++++++---
>  fs/f2fs/segment.c | 29 +++++++++++++-------------
>  fs/f2fs/super.c   |  7 +++++++
>  4 files changed, 93 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 095350ccf80d..be65dca0de40 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1451,10 +1451,16 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  	struct extent_info ei = {0,0,0};
>  	block_t blkaddr;
>  	unsigned int start_pgofs;
> +	int bidx = 0;
> +	bool multidevice_dio;
>  
>  	if (!maxblocks)
>  		return 0;
>  
> +	multidevice_dio = f2fs_allow_multi_device_dio(sbi, flag);
> +	if (multidevice_dio)
> +		map->m_bdev = sbi->sb->s_bdev;
> +
>  	map->m_len = 0;
>  	map->m_flags = 0;
>  
> @@ -1477,6 +1483,16 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  		if (flag == F2FS_GET_BLOCK_DIO)
>  			f2fs_wait_on_block_writeback_range(inode,
>  						map->m_pblk, map->m_len);
> +
> +		if (multidevice_dio) {
> +			bidx = f2fs_target_device_index(sbi, map->m_pblk);
> +			if (bidx) {
> +				map->m_bdev = FDEV(bidx).bdev;
> +				map->m_pblk -= FDEV(bidx).start_blk;
> +				map->m_len = min(map->m_len,
> +					FDEV(bidx).end_blk + 1 - map->m_pblk);
> +			}
> +		}
>  		goto out;
>  	}
>  
> @@ -1574,6 +1590,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  	if (flag == F2FS_GET_BLOCK_PRE_AIO)
>  		goto skip;
>  
> +	if (multidevice_dio)
> +		bidx = f2fs_target_device_index(sbi, blkaddr);
> +
>  	if (map->m_len == 0) {
>  		/* preallocated unwritten block should be mapped for fiemap. */
>  		if (blkaddr == NEW_ADDR)
> @@ -1582,10 +1601,15 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  
>  		map->m_pblk = blkaddr;
>  		map->m_len = 1;
> +
> +		if (multidevice_dio && map->m_bdev != FDEV(bidx).bdev)
> +			map->m_bdev = FDEV(bidx).bdev;
>  	} else if ((map->m_pblk != NEW_ADDR &&
>  			blkaddr == (map->m_pblk + ofs)) ||
>  			(map->m_pblk == NEW_ADDR && blkaddr == NEW_ADDR) ||
>  			flag == F2FS_GET_BLOCK_PRE_DIO) {
> +		if (multidevice_dio && map->m_bdev != FDEV(bidx).bdev)
> +			goto sync_out;
>  		ofs++;
>  		map->m_len++;
>  	} else {
> @@ -1638,11 +1662,27 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  
>  sync_out:
>  
> -	/* for hardware encryption, but to avoid potential issue in future */
> -	if (flag == F2FS_GET_BLOCK_DIO && map->m_flags & F2FS_MAP_MAPPED)
> +	if (flag == F2FS_GET_BLOCK_DIO && map->m_flags & F2FS_MAP_MAPPED) {
> +		/*
> +		 * for hardware encryption, but to avoid potential issue
> +		 * in future
> +		 */
>  		f2fs_wait_on_block_writeback_range(inode,
>  						map->m_pblk, map->m_len);
>  
> +		if (multidevice_dio) {
> +			bidx = f2fs_target_device_index(sbi, map->m_pblk);
> +			if (bidx) {
> +				map->m_bdev = FDEV(bidx).bdev;
> +				map->m_pblk -= FDEV(bidx).start_blk;
> +				f2fs_bug_on(sbi,
> +					map->m_bdev != FDEV(bidx).bdev ||
> +					map->m_pblk + map->m_len >
> +						FDEV(bidx).end_blk + 1);
> +			}
> +		}
> +	}
> +
>  	if (flag == F2FS_GET_BLOCK_PRECACHE) {
>  		if (map->m_flags & F2FS_MAP_MAPPED) {
>  			unsigned int ofs = start_pgofs - map->m_lblk;
> @@ -1720,6 +1760,9 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
>  		map_bh(bh, inode->i_sb, map.m_pblk);
>  		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
>  		bh->b_size = blks_to_bytes(inode, map.m_len);
> +
> +		if (f2fs_allow_multi_device_dio(F2FS_I_SB(inode), flag))
> +			bh->b_bdev = map.m_bdev;
>  	}
>  	return err;
>  }
> @@ -3511,6 +3554,7 @@ static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
>  {
>  	struct f2fs_private_dio *dio;
>  	bool write = (bio_op(bio) == REQ_OP_WRITE);
> +	block_t blkaddr = SECTOR_TO_BLOCK(bio->bi_iter.bi_sector);
>  	unsigned int blkcnt = bio_sectors(bio) >> F2FS_LOG_SECTORS_PER_BLOCK;
>  
>  	dio = f2fs_kzalloc(F2FS_I_SB(inode),
> @@ -3527,6 +3571,10 @@ static void f2fs_dio_submit_bio(struct bio *bio, struct inode *inode,
>  	bio->bi_end_io = f2fs_dio_end_io;
>  	bio->bi_private = dio;
>  
> +	if (write)
> +		f2fs_update_device_state(F2FS_I_SB(inode), inode->i_ino,
> +							blkaddr, blkcnt);
> +
>  	inc_page_counts(F2FS_I_SB(inode),
>  			write ? F2FS_DIO_WRITE : F2FS_DIO_READ, dio->blkcnt);
>  
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 7369f8087f64..f3ac3cbad2e3 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -607,6 +607,7 @@ struct extent_tree {
>  				F2FS_MAP_UNWRITTEN)
>  
>  struct f2fs_map_blocks {
> +	struct block_device *m_bdev;	/* for multi-device */
>  	block_t m_pblk;
>  	block_t m_lblk;
>  	unsigned int m_len;
> @@ -1712,12 +1713,15 @@ struct f2fs_sb_info {
>  
>  	/* For shrinker support */
>  	struct list_head s_list;
> +	struct mutex umount_mutex;
> +	unsigned int shrinker_run_no;
> +
> +	/* For multi devices */
>  	int s_ndevs;				/* number of devices */
>  	struct f2fs_dev_info *devs;		/* for device list */
>  	unsigned int dirty_device;		/* for checkpoint data flush */
>  	spinlock_t dev_lock;			/* protect dirty_device */
> -	struct mutex umount_mutex;
> -	unsigned int shrinker_run_no;
> +	bool aligned_blksize;			/* all devices has the same logical blksize */
>  
>  	/* For write statistics */
>  	u64 sectors_written_start;
> @@ -3527,6 +3531,8 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  			block_t old_blkaddr, block_t *new_blkaddr,
>  			struct f2fs_summary *sum, int type,
>  			struct f2fs_io_info *fio);
> +void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
> +					block_t blkaddr, unsigned int blkcnt);
>  void f2fs_wait_on_page_writeback(struct page *page,
>  			enum page_type type, bool ordered, bool locked);
>  void f2fs_wait_on_block_writeback(struct inode *inode, block_t blkaddr);
> @@ -4334,6 +4340,16 @@ static inline int allow_outplace_dio(struct inode *inode,
>  				!block_unaligned_IO(inode, iocb, iter));
>  }
>  
> +static inline bool f2fs_allow_multi_device_dio(struct f2fs_sb_info *sbi,
> +								int flag)
> +{
> +	if (!f2fs_is_multi_device(sbi))
> +		return false;
> +	if (flag != F2FS_GET_BLOCK_DIO)
> +		return false;
> +	return sbi->aligned_blksize;
> +}
> +
>  static inline bool f2fs_force_buffered_io(struct inode *inode,
>  				struct kiocb *iocb, struct iov_iter *iter)
>  {
> @@ -4342,7 +4358,9 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
>  
>  	if (f2fs_post_read_required(inode))
>  		return true;
> -	if (f2fs_is_multi_device(sbi))
> +
> +	/* disallow direct IO if any of devices has unaligned blksize */
> +	if (f2fs_is_multi_device(sbi) && !sbi->aligned_blksize)
>  		return true;
>  	/*
>  	 * for blkzoned device, fallback direct IO to buffered IO, so
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 15cc89eef28d..6fcfd234108a 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3442,24 +3442,24 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
>  	up_read(&SM_I(sbi)->curseg_lock);
>  }
>  
> -static void update_device_state(struct f2fs_io_info *fio)
> +void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
> +					block_t blkaddr, unsigned int blkcnt)
>  {
> -	struct f2fs_sb_info *sbi = fio->sbi;
> -	unsigned int devidx;
> -
>  	if (!f2fs_is_multi_device(sbi))
>  		return;
>  
> -	devidx = f2fs_target_device_index(sbi, fio->new_blkaddr);
> +	for (; blkcnt > 0; blkcnt--, blkaddr++) {
> +		unsigned int devidx = f2fs_target_device_index(sbi, blkaddr);
>  
> -	/* update device state for fsync */
> -	f2fs_set_dirty_device(sbi, fio->ino, devidx, FLUSH_INO);
> +		/* update device state for fsync */
> +		f2fs_set_dirty_device(sbi, ino, devidx, FLUSH_INO);
>  
> -	/* update device state for checkpoint */
> -	if (!f2fs_test_bit(devidx, (char *)&sbi->dirty_device)) {
> -		spin_lock(&sbi->dev_lock);
> -		f2fs_set_bit(devidx, (char *)&sbi->dirty_device);
> -		spin_unlock(&sbi->dev_lock);
> +		/* update device state for checkpoint */
> +		if (!f2fs_test_bit(devidx, (char *)&sbi->dirty_device)) {
> +			spin_lock(&sbi->dev_lock);
> +			f2fs_set_bit(devidx, (char *)&sbi->dirty_device);
> +			spin_unlock(&sbi->dev_lock);
> +		}
>  	}
>  }
>  
> @@ -3486,7 +3486,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
>  		goto reallocate;
>  	}
>  
> -	update_device_state(fio);
> +	f2fs_update_device_state(fio->sbi, fio->ino, fio->new_blkaddr, 1);
>  
>  	if (keep_order)
>  		up_read(&fio->sbi->io_order_lock);
> @@ -3575,7 +3575,8 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
>  	else
>  		err = f2fs_submit_page_bio(fio);
>  	if (!err) {
> -		update_device_state(fio);
> +		f2fs_update_device_state(fio->sbi, fio->ino,
> +						fio->new_blkaddr, 1);
>  		f2fs_update_iostat(fio->sbi, fio->io_type, F2FS_BLKSIZE);
>  	}
>  
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 72eb9d70969f..dced7778d530 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3646,6 +3646,7 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  {
>  	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
>  	unsigned int max_devices = MAX_DEVICES;
> +	unsigned int logical_blksize;
>  	int i;
>  
>  	/* Initialize single device information */
> @@ -3666,6 +3667,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  	if (!sbi->devs)
>  		return -ENOMEM;
>  
> +	logical_blksize = bdev_logical_block_size(sbi->sb->s_bdev);
> +	sbi->aligned_blksize = true;
> +
>  	for (i = 0; i < max_devices; i++) {
>  
>  		if (i > 0 && !RDEV(i).path[0])
> @@ -3702,6 +3706,9 @@ static int f2fs_scan_devices(struct f2fs_sb_info *sbi)
>  		/* to release errored devices */
>  		sbi->s_ndevs = i + 1;
>  
> +		if (logical_blksize != bdev_logical_block_size(FDEV(i).bdev))
> +			sbi->aligned_blksize = false;
> +
>  #ifdef CONFIG_BLK_DEV_ZONED
>  		if (bdev_zoned_model(FDEV(i).bdev) == BLK_ZONED_HM &&
>  				!f2fs_sb_has_blkzoned(sbi)) {
> -- 
> 2.22.1
