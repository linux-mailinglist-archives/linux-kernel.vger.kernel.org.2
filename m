Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72491391C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhEZPrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:47:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232913AbhEZPrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:47:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D172C613D4;
        Wed, 26 May 2021 15:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622043928;
        bh=k0Z16PnAGWgtbfdGjm736ZVNlOsxvIS5i1Cg1Exl5mI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ETteBPHZLAzQJQdBEdCU2xWqFjjVQ6SWCFB1azeqOfM9/akpwnPhoSv1sYWBKSLcM
         MlOTysRj4nfNYspf7KdVpblp16JEjgLG3poWRxJZ6nk/jlw9wvxE7vgiPR62DdNOmI
         Hi753/7Ibw6rWAYtZZ5mNkROGWq+BnZfOXPA2xjsfvrBVfyaATGpoYgVyUIhSZnf7/
         lWGW/2gQQ7Ngxn4S6MPVhGxD+VXFjxS4wNzYMm/oCyKBNeXAkA7IWXtXzcXmI5Qmfn
         XYzH8iPvPOHZe2uek0VS8NfFtlpdDtfpNAWgDslnni+m38TekP9HEtlcraARHihLEh
         eCooRiSigECqQ==
Date:   Wed, 26 May 2021 08:45:27 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Chao Yu <yuchao0@huawei.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: support RO feature
Message-ID: <YK5tF4D9gnIHEhBO@google.com>
References: <20210521190217.2484099-1-jaegeuk@kernel.org>
 <20210521190217.2484099-2-jaegeuk@kernel.org>
 <984caf0c-ddec-930a-cbc6-084c8a9b67e5@huawei.com>
 <YK5UHr4fV1Hg8MoO@google.com>
 <ebbc8cae-7e1f-f9f4-17b8-c59f99c7f043@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebbc8cae-7e1f-f9f4-17b8-c59f99c7f043@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/26, Chao Yu wrote:
> On 2021/5/26 21:58, Jaegeuk Kim wrote:
> > On 05/26, Chao Yu wrote:
> > > On 2021/5/22 3:02, Jaegeuk Kim wrote:
> > > > Given RO feature in superblock, we don't need to check provisioning/reserve
> > > > spaces and SSA area.
> > > > 
> > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > ---
> > > >    fs/f2fs/f2fs.h    |  2 ++
> > > >    fs/f2fs/segment.c |  3 +++
> > > >    fs/f2fs/super.c   | 35 +++++++++++++++++++++++++++++++----
> > > >    3 files changed, 36 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > > index c0bead0df66a..2c6913261586 100644
> > > > --- a/fs/f2fs/f2fs.h
> > > > +++ b/fs/f2fs/f2fs.h
> > > > @@ -168,6 +168,7 @@ struct f2fs_mount_info {
> > > >    #define F2FS_FEATURE_SB_CHKSUM		0x0800
> > > >    #define F2FS_FEATURE_CASEFOLD		0x1000
> > > >    #define F2FS_FEATURE_COMPRESSION	0x2000
> > > > +#define F2FS_FEATURE_RO			0x4000
> > > >    #define __F2FS_HAS_FEATURE(raw_super, mask)				\
> > > >    	((raw_super->feature & cpu_to_le32(mask)) != 0)
> > > > @@ -939,6 +940,7 @@ static inline void set_new_dnode(struct dnode_of_data *dn, struct inode *inode,
> > > >    #define	NR_CURSEG_DATA_TYPE	(3)
> > > >    #define NR_CURSEG_NODE_TYPE	(3)
> > > >    #define NR_CURSEG_INMEM_TYPE	(2)
> > > > +#define NR_CURSEG_RO_TYPE	(2)
> > > >    #define NR_CURSEG_PERSIST_TYPE	(NR_CURSEG_DATA_TYPE + NR_CURSEG_NODE_TYPE)
> > > >    #define NR_CURSEG_TYPE		(NR_CURSEG_INMEM_TYPE + NR_CURSEG_PERSIST_TYPE)
> > > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > > index 8668df7870d0..67cec8f858a2 100644
> > > > --- a/fs/f2fs/segment.c
> > > > +++ b/fs/f2fs/segment.c
> > > > @@ -4674,6 +4674,9 @@ static int sanity_check_curseg(struct f2fs_sb_info *sbi)
> > > >    {
> > > >    	int i;
> > > > +	if (__F2FS_HAS_FEATURE(sbi->raw_super, F2FS_FEATURE_RO))
> > > > +		return 0;
> > > 
> > > We need to skip this sanity check because .next_blkoff may point to end position
> > > of image?
> > 
> > Since we only use hot data and node. Let me check them only.
> > 
> > > 
> > > > +
> > > >    	/*
> > > >    	 * In LFS/SSR curseg, .next_blkoff should point to an unused blkaddr;
> > > >    	 * In LFS curseg, all blkaddr after .next_blkoff should be unused.
> > > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > > index b29de80ab60e..312bfab54693 100644
> > > > --- a/fs/f2fs/super.c
> > > > +++ b/fs/f2fs/super.c
> > > > @@ -1819,7 +1819,11 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
> > > >    static void default_options(struct f2fs_sb_info *sbi)
> > > >    {
> > > >    	/* init some FS parameters */
> > > > -	F2FS_OPTION(sbi).active_logs = NR_CURSEG_PERSIST_TYPE;
> > > > +	if (__F2FS_HAS_FEATURE(sbi->raw_super, F2FS_FEATURE_RO))
> > > > +		F2FS_OPTION(sbi).active_logs = NR_CURSEG_RO_TYPE;
> > > > +	else
> > > > +		F2FS_OPTION(sbi).active_logs = NR_CURSEG_PERSIST_TYPE;
> > > > +
> > > >    	F2FS_OPTION(sbi).inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
> > > >    	F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
> > > >    	F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_DEFAULT;
> > > > @@ -1994,6 +1998,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
> > > >    	err = parse_options(sb, data, true);
> > > >    	if (err)
> > > >    		goto restore_opts;
> > > > +
> > > > +	if (__F2FS_HAS_FEATURE(sbi->raw_super, F2FS_FEATURE_RO) &&
> > > > +					!(*flags & SB_RDONLY))
> > > 
> > > err = -EROFS; ?
> > 
> > Done.
> > 
> > > 
> > > > +		goto restore_opts;
> > > > +
> > > >    	checkpoint_changed =
> > > >    			disable_checkpoint != test_opt(sbi, DISABLE_CHECKPOINT);
> > > > @@ -3137,16 +3146,18 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
> > > >    	ovp_segments = le32_to_cpu(ckpt->overprov_segment_count);
> > > >    	reserved_segments = le32_to_cpu(ckpt->rsvd_segment_count);
> > > > +	if (__F2FS_HAS_FEATURE(sbi->raw_super, F2FS_FEATURE_RO))
> > > > +		goto no_reserved;
> > > >    	if (unlikely(fsmeta < F2FS_MIN_META_SEGMENTS ||
> > > >    			ovp_segments == 0 || reserved_segments == 0)) {
> > > >    		f2fs_err(sbi, "Wrong layout: check mkfs.f2fs version");
> > > >    		return 1;
> > > >    	}
> > > 
> > > Well, why not:
> > > 
> > > if (!F2FS_HAS_FEATURE(, RO) && unlikely()) {
> > > }
> > 
> > Done.
> > 
> > > 
> > > > -
> > > > +no_reserved:
> > > >    	user_block_count = le64_to_cpu(ckpt->user_block_count);
> > > >    	segment_count_main = le32_to_cpu(raw_super->segment_count_main);
> > > >    	log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
> > > > -	if (!user_block_count || user_block_count >=
> > > > +	if (!user_block_count || user_block_count >
> > > 
> > > Does this change related to RO feature? if so, let's split condition for
> > > RO feature here?
> > 
> > Done.
> > 
> > > 
> > > >    			segment_count_main << log_blocks_per_seg) {
> > > >    		f2fs_err(sbi, "Wrong user_block_count: %u",
> > > >    			 user_block_count);
> > > > @@ -3175,6 +3186,10 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
> > > >    		if (le32_to_cpu(ckpt->cur_node_segno[i]) >= main_segs ||
> > > >    			le16_to_cpu(ckpt->cur_node_blkoff[i]) >= blocks_per_seg)
> > > >    			return 1;
> > > > +
> > > > +		if (__F2FS_HAS_FEATURE(sbi->raw_super, F2FS_FEATURE_RO))
> > > > +			goto check_data;
> > > > +
> > > >    		for (j = i + 1; j < NR_CURSEG_NODE_TYPE; j++) {
> > > >    			if (le32_to_cpu(ckpt->cur_node_segno[i]) ==
> > > >    				le32_to_cpu(ckpt->cur_node_segno[j])) {
> > > > @@ -3185,10 +3200,15 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
> > > >    			}
> > > >    		}
> > > >    	}
> > > > +check_data:
> > > >    	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
> > > >    		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
> > > >    			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
> > > >    			return 1;
> > > > +
> > > > +		if (__F2FS_HAS_FEATURE(sbi->raw_super, F2FS_FEATURE_RO))
> > > > +			goto skip_cross;
> > > > +
> > > >    		for (j = i + 1; j < NR_CURSEG_DATA_TYPE; j++) {
> > > >    			if (le32_to_cpu(ckpt->cur_data_segno[i]) ==
> > > >    				le32_to_cpu(ckpt->cur_data_segno[j])) {
> > > > @@ -3210,7 +3230,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
> > > >    			}
> > > >    		}
> > > >    	}
> > > > -
> > > > +skip_cross:
> > > >    	sit_bitmap_size = le32_to_cpu(ckpt->sit_ver_bitmap_bytesize);
> > > >    	nat_bitmap_size = le32_to_cpu(ckpt->nat_ver_bitmap_bytesize);
> > > > @@ -3703,6 +3723,13 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> > > >    	if (err)
> > > >    		goto free_options;
> > > > +	if (__F2FS_HAS_FEATURE(sbi->raw_super, F2FS_FEATURE_RO) &&
> > > > +					!f2fs_readonly(sbi->sb)) {
> > > > +		f2fs_info(sbi, "Allow to mount readonly mode only");
> > > > +		err = -EINVAL;
> > > > +		goto free_options;
> > > > +	}
> > > 
> > > How about relocating this to parse_options() like other features did, then
> > > we don't need to handle this in both fill_super() and remount()?
> > 
> > Done. But not sure what you mean "we don't need to handle both".
> 
> Oh, I mean both fill_super() and remount() will call parse_options(),
> so if we want to avoid mounting ro image with rw mountoption, we just
> need to add one condition check in parse_option().

1. mount forced mounting ro only.
2. remount needs to check rw mount after parse_options.

> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> > > 
> > > Thanks,
> > > 
> > > > +
> > > >    	sb->s_maxbytes = max_file_blocks(NULL) <<
> > > >    				le32_to_cpu(raw_super->log_blocksize);
> > > >    	sb->s_max_links = F2FS_LINK_MAX;
> > > > 
> > 
> > 
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
