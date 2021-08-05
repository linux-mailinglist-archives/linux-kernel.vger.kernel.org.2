Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60833E1AC8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 19:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240774AbhHERub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 13:50:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240773AbhHERu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 13:50:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A16E610A2;
        Thu,  5 Aug 2021 17:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628185814;
        bh=wjBRVxO8jdKoCDcVyzcPVbnCHpnRjav0JoepHQGbZeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iaL2aCjDQMBZDKstadNI13hPy1JWPY/U4ufLM/IJ8WFrpZyC6VWAB/hoPF0uPRSgc
         31lBf61IUbZ9DaG+cXgHcApUk3wUc6hj7KxYLqLiG1Wo5Mf3Ufy/cRsL+6HZstUAnE
         SqQhNEk0IH3PpVrTtF/5PnbrVps0DrSxbM3VpdVR0e8+e+rg1oFKraulSc/4uEZpC5
         j3GA/z/jH28vkqeJ/cDZcC9tANLQyKTC6hq8Hep3s9+L3Iz/fvLoMi+Ym7GXxYXaQ1
         I8pwt33x+pZKqAnlUGkWDqdJ76FkSf+Kp2N5Ds+5cXEngAOPsGn9i5sswdYP/OQZJd
         SpTkEkbsrXZCQ==
Date:   Thu, 5 Aug 2021 10:50:12 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao.yu@linux.dev>
Subject: Re: [PATCH] f2fs: compress: do sanity check on cluster
Message-ID: <YQwk1BuaXxsZI27o@google.com>
References: <20210803103952.737222-1-chao@kernel.org>
 <YQmKQVxQwJL2GU09@google.com>
 <275b4ec7-d7fd-b169-ff43-3ceec37b47b9@kernel.org>
 <YQn1fchZOJlQeiW+@google.com>
 <709b3653-372b-e809-d98b-56d18a7544cd@kernel.org>
 <YQsZv1dqP6XMe1C2@google.com>
 <0aa2b1ec-8dd9-d15d-87dc-54c0bf068a18@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aa2b1ec-8dd9-d15d-87dc-54c0bf068a18@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05, Chao Yu wrote:
> On 2021/8/5 6:50, Jaegeuk Kim wrote:
> > On 08/04, Chao Yu wrote:
> > > On 2021/8/4 10:03, Jaegeuk Kim wrote:
> > > > On 08/04, Chao Yu wrote:
> > > > > On 2021/8/4 2:26, Jaegeuk Kim wrote:
> > > > > > On 08/03, Chao Yu wrote:
> > > > > > > This patch adds f2fs_sanity_check_cluster() to support doing
> > > > > > > sanity check on cluster of compressed file, it will be triggered
> > > > > > > from below two paths:
> > > > > > > 
> > > > > > > - __f2fs_cluster_blocks()
> > > > > > > - f2fs_map_blocks(F2FS_GET_BLOCK_FIEMAP)
> > > > > > > 
> > > > > > > And it can detect below three kind of cluster insanity status.
> > > > > > > 
> > > > > > > C: COMPRESS_ADDR
> > > > > > > N: NULL_ADDR or NEW_ADDR
> > > > > > > V: valid blkaddr
> > > > > > > *: any value
> > > > > > > 
> > > > > > > 1. [*|C|*|*]
> > > > > > > 2. [C|*|C|*]
> > > > > > > 3. [C|N|N|V]
> > > > > > > 
> > > > > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > > > > ---
> > > > > > >     fs/f2fs/compress.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
> > > > > > >     fs/f2fs/data.c     | 21 ++++++++++++------
> > > > > > >     fs/f2fs/f2fs.h     |  1 +
> > > > > > >     3 files changed, 68 insertions(+), 7 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > > > > > > index 455561826c7d..4aa166d3d9bf 100644
> > > > > > > --- a/fs/f2fs/compress.c
> > > > > > > +++ b/fs/f2fs/compress.c
> > > > > > > @@ -898,6 +898,54 @@ static bool cluster_has_invalid_data(struct compress_ctx *cc)
> > > > > > >     	return false;
> > > > > > >     }
> > > > > > > +bool f2fs_sanity_check_cluster(struct dnode_of_data *dn)
> > > > > > > +{
> > > > > > > +	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
> > > > > > > +	unsigned int cluster_size = F2FS_I(dn->inode)->i_cluster_size;
> > > > > > > +	bool compressed = dn->data_blkaddr == COMPRESS_ADDR;
> > > > > > > +	int cluster_end = 0;
> > > > > > > +	int i;
> > > > > > > +	char *reason = "";
> > > > > > > +
> > > > > > > +	if (!compressed)
> > > > > > > +		return false;
> > > > > > > +
> > > > > > > +	/* [..., COMPR_ADDR, ...] */
> > > > > > > +	if (dn->ofs_in_node % cluster_size) {
> > > > > > > +		reason = "[*|C|*|*]";
> > > > > > > +		goto out;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	for (i = 1; i < cluster_size; i++) {
> > > > > > > +		block_t blkaddr = data_blkaddr(dn->inode, dn->node_page,
> > > > > > > +							dn->ofs_in_node + i);
> > > > > > > +
> > > > > > > +		/* [COMPR_ADDR, ..., COMPR_ADDR] */
> > > > > > > +		if (blkaddr == COMPRESS_ADDR) {
> > > > > > > +			reason = "[C|*|C|*]";
> > > > > > > +			goto out;
> > > > > > > +		}
> > > > > > > +		if (compressed) {
> > > > > > > +			if (!__is_valid_data_blkaddr(blkaddr)) {
> > > > > > > +				if (!cluster_end)
> > > > > > > +					cluster_end = i;
> > > > > > > +				continue;
> > > > > > > +			}
> > > > > > > +			/* [COMPR_ADDR, NULL_ADDR or NEW_ADDR, valid_blkaddr] */
> > > > > > > +			if (cluster_end) {
> > > > > > > +				reason = "[C|N|N|V]";
> > > > > > > +				goto out;
> > > > > > > +			}
> > > > > > > +		}
> > > > > > > +	}
> > > > > > > +	return false;
> > > > > > > +out:
> > > > > > > +	f2fs_warn(sbi, "access invalid cluster, ino:%lu, nid:%u, ofs_in_node:%u, reason:%s",
> > > > > > > +			dn->inode->i_ino, dn->nid, dn->ofs_in_node, reason);
> > > > > > > +	set_sbi_flag(sbi, SBI_NEED_FSCK);
> > > > > > > +	return true;
> > > > > > > +}
> > > > > > > +
> > > > > > >     static int __f2fs_cluster_blocks(struct inode *inode,
> > > > > > >     				unsigned int cluster_idx, bool compr)
> > > > > > >     {
> > > > > > > @@ -915,6 +963,11 @@ static int __f2fs_cluster_blocks(struct inode *inode,
> > > > > > >     		goto fail;
> > > > > > >     	}
> > > > > > > +	if (f2fs_sanity_check_cluster(&dn)) {
> > > > > > > +		ret = -EFSCORRUPTED;
> > > > > > > +		goto fail;
> > > > > > > +	}
> > > > > > > +
> > > > > > >     	if (dn.data_blkaddr == COMPRESS_ADDR) {
> > > > > > >     		int i;
> > > > > > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > > > > > index 948083c88d17..75dda2035f68 100644
> > > > > > > --- a/fs/f2fs/data.c
> > > > > > > +++ b/fs/f2fs/data.c
> > > > > > > @@ -1558,13 +1558,20 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
> > > > > > >     			}
> > > > > > >     			if (flag == F2FS_GET_BLOCK_PRECACHE)
> > > > > > >     				goto sync_out;
> > > > > > > -			if (flag == F2FS_GET_BLOCK_FIEMAP &&
> > > > > > > -						blkaddr == NULL_ADDR) {
> > > > > > > -				if (map->m_next_pgofs)
> > > > > > > -					*map->m_next_pgofs = pgofs + 1;
> > > > > > > -				goto sync_out;
> > > > > > > -			}
> > > > > > > -			if (flag != F2FS_GET_BLOCK_FIEMAP) {
> > > > > > > +			if (flag == ) {
> > > > > > > +				if (blkaddr == NULL_ADDR) {
> > > > > > > +					if (map->m_next_pgofs)
> > > > > > > +						*map->m_next_pgofs = pgofs + 1;
> > > > > > > +					goto sync_out;
> > > > > > > +				}
> > > > > > > +#ifdef CONFIG_F2FS_FS_COMPRESSION
> > > > > > > +				if (f2fs_compressed_file(inode) &&
> > > > > > > +					f2fs_sanity_check_cluster(&dn)) {
> > > > > > > +					err = -EFSCORRUPTED;
> > > > > > 
> > > > > > I prefer to give the block map as is instead of giving an error, since this\
> > > > > 
> > > > > It looks the policy is not consistent with the one we did in
> > > > > f2fs_is_valid_blkaddr().
> > > > 
> > > > Why FIEMAP only? Do we need to check in other cases likewise
> > > > f2fs_is_valid_blkaddr()?
> > > 
> > > Agreed, let me cover all missing pieces.
> > > 
> > > > 
> > > > > 
> > > > > > takes away to debug the problem from user-land.
> > > > > 
> > > > > We can debug through "dump.f2fs -i" command? also once f2fs_sanity_check_cluster()
> > > > > fails, it will print kernel message for further debuging.
> > > > 
> > > > My concern here is how to debug and get out of this endless fiemap error before
> > > > recovered.
> > > 
> > > Got your concern.
> > > 
> > > For debug purpose, maybe we can add a new ioctl under CONFIG_F2FS_CHECK_FS to dump
> > > original mapping? or support dump.f2fs -f to dump all blkaddrs of target file?
> > 
> > How about giving EFSCORRUPTED if CONFIG_F2FS_CHECK_FS is enabled? Sometimes it's
> 
> Hmm... if original mapping is useful for debuging, shouldn't we return original one
> if CONFIG_F2FS_CHECK_FS is enabled? since commonly we will enable CONFIG_F2FS_CHECK_FS
> in eng version of Android to get more debug info.

My concern was when debugging any from field, which we need to ask normal users.

> 
> Thanks,
> 
> > useful to ask fiemap to users.
> > 
> > > 
> > > Thanks
> > > 
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > > 
> > > > > > > +					goto sync_out;
> > > > > > > +				}
> > > > > > > +#endif
> > > > > > > +			} else {
> > > > > > >     				/* for defragment case */
> > > > > > >     				if (map->m_next_pgofs)
> > > > > > >     					*map->m_next_pgofs = pgofs + 1;
> > > > > > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > > > > > index 20389b9b3eac..86d416ffad61 100644
> > > > > > > --- a/fs/f2fs/f2fs.h
> > > > > > > +++ b/fs/f2fs/f2fs.h
> > > > > > > @@ -4060,6 +4060,7 @@ void f2fs_end_read_compressed_page(struct page *page, bool failed,
> > > > > > >     							block_t blkaddr);
> > > > > > >     bool f2fs_cluster_is_empty(struct compress_ctx *cc);
> > > > > > >     bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
> > > > > > > +bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
> > > > > > >     void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct page *page);
> > > > > > >     int f2fs_write_multi_pages(struct compress_ctx *cc,
> > > > > > >     						int *submitted,
> > > > > > > -- 
> > > > > > > 2.22.1
