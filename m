Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0778A3E1B69
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241363AbhHEShB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241350AbhHEShA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:37:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10089601FF;
        Thu,  5 Aug 2021 18:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628188606;
        bh=jjJGKtQTGYwGJC5Qpg2vszircTQVq4pRg2okgmJ5ItQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PS0GhCzFB7gOewfiGRL1QXCy3eh329CohOaME/70H4eTrFdCVB/v98wpKXf789lND
         DU1l4jbiZnl3IJJqjx5QlWhmIgMxbuvvfp2Wm3m3Iedhq8kTXOTTipqwFQa65HBJEf
         5PecPJ2LoabK7Ou10n/N6D6co0IbEtoDM7/ArF0sLz/wle9nUHjSmFFjwMbz0FEUtj
         l+jvY0AmYhRPYl8sepqmleTCFtiydpNai/J4w5ccXJIHZLQfgcFPa0XVPHExq6uWfj
         61x4lMEhlNSgZ4NqXT5v3pt475ZyBW/lE/3gLhoxiyT/8QcEJTVyOf8aWDW9FMXMXV
         7l4niFHLX200A==
Date:   Thu, 5 Aug 2021 11:36:44 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [RFC v3] f2fs: extent cache: support unaligned extent
Message-ID: <YQwvvEh8gzEFDH1c@google.com>
References: <20210804022348.1414543-1-chao@kernel.org>
 <YQsIj0wKk6YbN/FJ@google.com>
 <YQsmfm3ibU6bhvZr@google.com>
 <bb635f86-b29b-384b-cfe0-c8b78e3c9ec5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb635f86-b29b-384b-cfe0-c8b78e3c9ec5@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05, Chao Yu wrote:
> On 2021/8/5 7:45, Jaegeuk Kim wrote:
> > Chao,
> > 
> > How about this?
> > https://github.com/jaegeuk/f2fs/commit/d6bbe121bc24dfabfedc07ba7cb6e921fb70ece0
> > 
> > I'm digging one bug in __insert_extent_tree w/ the patch tho.
> > 
> > On 08/04, Jaegeuk Kim wrote:
> > > On 08/04, Chao Yu wrote:
> > > > Compressed inode may suffer read performance issue due to it can not
> > > > use extent cache, so I propose to add this unaligned extent support
> > > > to improve it.
> > > > 
> > > > Currently, it only works in readonly format f2fs image.
> > > > 
> > > > Unaligned extent: in one compressed cluster, physical block number
> > > > will be less than logical block number, so we add an extra physical
> > > > block length in extent info in order to indicate such extent status.
> > > > 
> > > > The idea is if one whole cluster blocks are contiguous physically,
> > > > once its mapping info was readed at first time, we will cache an
> > > > unaligned (or aligned) extent info entry in extent cache, it expects
> > > > that the mapping info will be hitted when rereading cluster.
> > > > 
> > > > Merge policy:
> > > > - Aligned extents can be merged.
> > > > - Aligned extent and unaligned extent can not be merged.
> > > > 
> > > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > > ---
> > > > v3:
> > > > - avoid CONFIG_F2FS_FS_COMPRESSION as much as possible
> > > > - clean up codes
> > > >   fs/f2fs/compress.c     | 24 ++++++++++++
> > > >   fs/f2fs/data.c         | 28 +++++++++++---
> > > >   fs/f2fs/extent_cache.c | 88 +++++++++++++++++++++++++++++++++++++-----
> > > >   fs/f2fs/f2fs.h         | 42 +++++++++++++++++---
> > > >   fs/f2fs/node.c         | 18 +++++++++
> > > >   5 files changed, 179 insertions(+), 21 deletions(-)
> > > > 
> > > > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > > > index 4aa166d3d9bf..296ff37d4b08 100644
> > > > --- a/fs/f2fs/compress.c
> > > > +++ b/fs/f2fs/compress.c
> > > > @@ -1719,6 +1719,30 @@ void f2fs_put_page_dic(struct page *page)
> > > >   	f2fs_put_dic(dic);
> > > >   }
> > > > +/*
> > > > + * check whether cluster blocks are contiguous, and add extent cache entry
> > > > + * only if cluster blocks are logically and physically contiguous.
> > > > + */
> > > > +int f2fs_cluster_blocks_are_contiguous(struct dnode_of_data *dn)
> > > > +{
> > > > +	bool compressed = f2fs_data_blkaddr(dn) == COMPRESS_ADDR;
> > > > +	int i = compressed ? 1 : 0;
> > > > +	block_t first_blkaddr = data_blkaddr(dn->inode, dn->node_page,
> > > > +						dn->ofs_in_node + i);
> > > > +
> > > > +	for (i += 1; i < F2FS_I(dn->inode)->i_cluster_size; i++) {
> > > > +		block_t blkaddr = data_blkaddr(dn->inode, dn->node_page,
> > > > +						dn->ofs_in_node + i);
> > > > +
> > > > +		if (!__is_valid_data_blkaddr(blkaddr))
> > > > +			break;
> > > > +		if (first_blkaddr + i - 1 != blkaddr)
> > > > +			return 0;
> 
> The merge condition looks wrong, shouldn't be:
> 
> if (first_blkaddr + i - compressed ? 1 : 0 != blkaddr)
> 	return 0;

Great. This works. I've queued up the patch with this fix.

Thanks,

> 
> Thanks,
