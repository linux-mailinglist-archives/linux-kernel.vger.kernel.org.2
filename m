Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8770D39A501
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhFCPyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:54:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhFCPyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:54:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE4E2613DA;
        Thu,  3 Jun 2021 15:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622735551;
        bh=ALfngd/AzLPASHcVjomPrxMSCKAg7yfJ1wHcHYwvtBc=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=TbgpQ8Qf5W45YxV+0l+irYqf6fVnbcO4dg/osTPpoqHf2M5AlW5/JJdNzFhuwZj2B
         5WEKfQpq442LQy9sBf/x5BIhYKaPMjLi2Ftvo67BxOcpwZ6nqkDdRwa328Svt97RyY
         ePcT6qqXawvVtt3i+q7gcsuxephEKc5vO56P9jRhQc2Ty2xYGEvo4V/24nIJs9DxB6
         m4Dkb5IAXVoeuUyyN/vwto97IdWy1K+iUmjX7rp8BZS7RcN1iiuk+AmtcdLQPOircm
         rrI2wi5vsFmCpfl2YrGnGtntCLdzdoEajlAV246dfr6xoZPTRGvA00whQO9JJ2v+Xx
         asuOh3rAArwGA==
Subject: Re: [f2fs-dev] [PATCH 2/2 v4] f2fs: support RO feature
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210521190217.2484099-1-jaegeuk@kernel.org>
 <20210521190217.2484099-2-jaegeuk@kernel.org> <YK5UOfzwdZni7c5W@google.com>
 <YK5edM0igwfd47LV@google.com> <YLfV4EPW5Yw6wP+v@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <900914f9-aedc-7379-e14d-1ddd5092d710@kernel.org>
Date:   Thu, 3 Jun 2021 23:52:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLfV4EPW5Yw6wP+v@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/6/3 3:02, Jaegeuk Kim wrote:
> Given RO feature in superblock, we don't need to check provisioning/reserve
> spaces and SSA area.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> 
> Change log from v3:
>   - add feature sysfs entries
> 
>   fs/f2fs/f2fs.h    |  3 +++
>   fs/f2fs/segment.c |  4 ++++
>   fs/f2fs/super.c   | 37 +++++++++++++++++++++++++++++++------
>   fs/f2fs/sysfs.c   |  8 ++++++++
>   4 files changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index eaf57b5f3c4b..8903c43091f8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -168,6 +168,7 @@ struct f2fs_mount_info {
>   #define F2FS_FEATURE_SB_CHKSUM		0x0800
>   #define F2FS_FEATURE_CASEFOLD		0x1000
>   #define F2FS_FEATURE_COMPRESSION	0x2000
> +#define F2FS_FEATURE_RO			0x4000
>   
>   #define __F2FS_HAS_FEATURE(raw_super, mask)				\
>   	((raw_super->feature & cpu_to_le32(mask)) != 0)
> @@ -940,6 +941,7 @@ static inline void set_new_dnode(struct dnode_of_data *dn, struct inode *inode,
>   #define	NR_CURSEG_DATA_TYPE	(3)
>   #define NR_CURSEG_NODE_TYPE	(3)
>   #define NR_CURSEG_INMEM_TYPE	(2)
> +#define NR_CURSEG_RO_TYPE	(2)
>   #define NR_CURSEG_PERSIST_TYPE	(NR_CURSEG_DATA_TYPE + NR_CURSEG_NODE_TYPE)
>   #define NR_CURSEG_TYPE		(NR_CURSEG_INMEM_TYPE + NR_CURSEG_PERSIST_TYPE)
>   
> @@ -4128,6 +4130,7 @@ F2FS_FEATURE_FUNCS(verity, VERITY);
>   F2FS_FEATURE_FUNCS(sb_chksum, SB_CHKSUM);
>   F2FS_FEATURE_FUNCS(casefold, CASEFOLD);
>   F2FS_FEATURE_FUNCS(compression, COMPRESSION);
> +F2FS_FEATURE_FUNCS(readonly, RO);

If so, we'd better to use f2fs_sb_has_readonly() instead of F2FS_HAS_FEATURE()?

Thanks,

>   
>   #ifdef CONFIG_BLK_DEV_ZONED
>   static inline bool f2fs_blkz_is_seq(struct f2fs_sb_info *sbi, int devi,
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 380ef34e1a59..376c33ab71e2 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -4683,6 +4683,10 @@ static int sanity_check_curseg(struct f2fs_sb_info *sbi)
>   		struct seg_entry *se = get_seg_entry(sbi, curseg->segno);
>   		unsigned int blkofs = curseg->next_blkoff;
>   
> +		if (F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_RO) &&
> +			i != CURSEG_HOT_DATA && i != CURSEG_HOT_NODE)
> +			continue;
> +
>   		sanity_check_seg_type(sbi, curseg->seg_type);
>   
>   		if (f2fs_test_bit(blkofs, se->cur_valid_map))
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 2fa59c674cd9..fb490383c767 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -555,7 +555,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   	int ret;
>   
>   	if (!options)
> -		return 0;
> +		goto default_check;
>   
>   	while ((p = strsep(&options, ",")) != NULL) {
>   		int token;
> @@ -1090,6 +1090,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   			return -EINVAL;
>   		}
>   	}
> +default_check:
>   #ifdef CONFIG_QUOTA
>   	if (f2fs_check_quota_options(sbi))
>   		return -EINVAL;
> @@ -1162,6 +1163,11 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>   	 */
>   	if (F2FS_OPTION(sbi).active_logs != NR_CURSEG_TYPE)
>   		F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
> +
> +	if (F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_RO) && !f2fs_readonly(sbi->sb)) {
> +		f2fs_err(sbi, "Allow to mount readonly mode only");
> +		return -EROFS;
> +	}
>   	return 0;
>   }
>   
> @@ -1819,7 +1825,11 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
>   static void default_options(struct f2fs_sb_info *sbi)
>   {
>   	/* init some FS parameters */
> -	F2FS_OPTION(sbi).active_logs = NR_CURSEG_PERSIST_TYPE;
> +	if (F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_RO))
> +		F2FS_OPTION(sbi).active_logs = NR_CURSEG_RO_TYPE;
> +	else
> +		F2FS_OPTION(sbi).active_logs = NR_CURSEG_PERSIST_TYPE;
> +
>   	F2FS_OPTION(sbi).inline_xattr_size = DEFAULT_INLINE_XATTR_ADDRS;
>   	F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
>   	F2FS_OPTION(sbi).alloc_mode = ALLOC_MODE_DEFAULT;
> @@ -2001,6 +2011,11 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
>   	if (f2fs_readonly(sb) && (*flags & SB_RDONLY))
>   		goto skip;
>   
> +	if (F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_RO) && !(*flags & SB_RDONLY)) {
> +		err = -EROFS;
> +		goto restore_opts;
> +	}
> +
>   #ifdef CONFIG_QUOTA
>   	if (!f2fs_readonly(sb) && (*flags & SB_RDONLY)) {
>   		err = dquot_suspend(sb, -1);
> @@ -3134,14 +3149,15 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>   	ovp_segments = le32_to_cpu(ckpt->overprov_segment_count);
>   	reserved_segments = le32_to_cpu(ckpt->rsvd_segment_count);
>   
> -	if (unlikely(fsmeta < F2FS_MIN_META_SEGMENTS ||
> +	if (!F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_RO) &&
> +			unlikely(fsmeta < F2FS_MIN_META_SEGMENTS ||
>   			ovp_segments == 0 || reserved_segments == 0)) {
>   		f2fs_err(sbi, "Wrong layout: check mkfs.f2fs version");
>   		return 1;
>   	}
> -
>   	user_block_count = le64_to_cpu(ckpt->user_block_count);
> -	segment_count_main = le32_to_cpu(raw_super->segment_count_main);
> +	segment_count_main = le32_to_cpu(raw_super->segment_count_main) +
> +			(F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_RO) ? 1 : 0);
>   	log_blocks_per_seg = le32_to_cpu(raw_super->log_blocks_per_seg);
>   	if (!user_block_count || user_block_count >=
>   			segment_count_main << log_blocks_per_seg) {
> @@ -3172,6 +3188,10 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>   		if (le32_to_cpu(ckpt->cur_node_segno[i]) >= main_segs ||
>   			le16_to_cpu(ckpt->cur_node_blkoff[i]) >= blocks_per_seg)
>   			return 1;
> +
> +		if (F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_RO))
> +			goto check_data;
> +
>   		for (j = i + 1; j < NR_CURSEG_NODE_TYPE; j++) {
>   			if (le32_to_cpu(ckpt->cur_node_segno[i]) ==
>   				le32_to_cpu(ckpt->cur_node_segno[j])) {
> @@ -3182,10 +3202,15 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>   			}
>   		}
>   	}
> +check_data:
>   	for (i = 0; i < NR_CURSEG_DATA_TYPE; i++) {
>   		if (le32_to_cpu(ckpt->cur_data_segno[i]) >= main_segs ||
>   			le16_to_cpu(ckpt->cur_data_blkoff[i]) >= blocks_per_seg)
>   			return 1;
> +
> +		if (F2FS_HAS_FEATURE(sbi, F2FS_FEATURE_RO))
> +			goto skip_cross;
> +
>   		for (j = i + 1; j < NR_CURSEG_DATA_TYPE; j++) {
>   			if (le32_to_cpu(ckpt->cur_data_segno[i]) ==
>   				le32_to_cpu(ckpt->cur_data_segno[j])) {
> @@ -3207,7 +3232,7 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>   			}
>   		}
>   	}
> -
> +skip_cross:
>   	sit_bitmap_size = le32_to_cpu(ckpt->sit_ver_bitmap_bytesize);
>   	nat_bitmap_size = le32_to_cpu(ckpt->nat_ver_bitmap_bytesize);
>   
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 09e3f258eb52..62fbe4f20dd6 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -158,6 +158,9 @@ static ssize_t features_show(struct f2fs_attr *a,
>   	if (f2fs_sb_has_casefold(sbi))
>   		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
>   				len ? ", " : "", "casefold");
> +	if (f2fs_sb_has_readonly(sbi))
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
> +				len ? ", " : "", "readonly");
>   	if (f2fs_sb_has_compression(sbi))
>   		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
>   				len ? ", " : "", "compression");
> @@ -578,6 +581,7 @@ enum feat_id {
>   	FEAT_SB_CHECKSUM,
>   	FEAT_CASEFOLD,
>   	FEAT_COMPRESSION,
> +	FEAT_RO,
>   	FEAT_TEST_DUMMY_ENCRYPTION_V2,
>   };
>   
> @@ -599,6 +603,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
>   	case FEAT_SB_CHECKSUM:
>   	case FEAT_CASEFOLD:
>   	case FEAT_COMPRESSION:
> +	case FEAT_RO:
>   	case FEAT_TEST_DUMMY_ENCRYPTION_V2:
>   		return sprintf(buf, "supported\n");
>   	}
> @@ -723,12 +728,14 @@ F2FS_FEATURE_RO_ATTR(sb_checksum, FEAT_SB_CHECKSUM);
>   #ifdef CONFIG_UNICODE
>   F2FS_FEATURE_RO_ATTR(casefold, FEAT_CASEFOLD);
>   #endif
> +F2FS_FEATURE_RO_ATTR(readonly, FEAT_RO);
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>   F2FS_FEATURE_RO_ATTR(compression, FEAT_COMPRESSION);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_written_block, compr_written_block);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_saved_block, compr_saved_block);
>   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_new_inode, compr_new_inode);
>   #endif
> +
>   /* For ATGC */
>   F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_candidate_ratio, candidate_ratio);
>   F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_candidate_count, max_candidate_count);
> @@ -834,6 +841,7 @@ static struct attribute *f2fs_feat_attrs[] = {
>   #ifdef CONFIG_UNICODE
>   	ATTR_LIST(casefold),
>   #endif
> +	ATTR_LIST(readonly),
>   #ifdef CONFIG_F2FS_FS_COMPRESSION
>   	ATTR_LIST(compression),
>   #endif
> 
