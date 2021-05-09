Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681D5377621
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 11:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhEIJ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 05:59:23 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:44631 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229560AbhEIJ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 05:59:22 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id E17321959;
        Sun,  9 May 2021 05:58:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 09 May 2021 05:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=5SeL7QF4hLIH3Q+P/mbUXP/amB4
        k9Z5qU8DdN4AWHYA=; b=D0lJJuYKeu86uDzD7AVdj+P0dVbqbOF7gTww3ctYxq2
        VYUtmL79Qb/+5usqLG7ba9aklufK+j0o4HAbGOQshK7NQapMsO99e6kqtSRxKFEv
        UugTucUWqIqhNmS6ZqAvYtpbpl/gr9zGJ906IDeVqs9lQrK5+01ngY87Qnub7q7U
        UszqNzUSGlY7zSnAAEfkL4P2FK4FXutPDYnmI14bJk0q4CA+/yYvCdM8RypkGmqj
        9N9nsupyDIEVxwVclhGidII+XkLMxsduZk8JtAK7FYlGuJCfMAu6tQrwtXQA0+QP
        8D/POp4b2vLrUWMgU+c+IwKLqVE4NVgK9tOXbSihCgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5SeL7Q
        F4hLIH3Q+P/mbUXP/amB4k9Z5qU8DdN4AWHYA=; b=ShqgoxWgEnGUMo79mAxvDR
        908TMDDvvLbbg8GnCqbZR9oqNu/v9pT9XWsqVbDqXXUQcckQ6XRL0hlAuwE1Rm9p
        eh8fiiMkdAIENG7mkrKOowypHWLFZCCe5rlVjQtWvJZXALNlPxS9tW2stPCIgQ5Y
        oH8JdMKpY2Hj/blAzfmGfwFmTsoWnWqwjAljsypLXDeRQUtc94yACemr1Jkm1VBp
        tyHFlxRjrFEseQWDt52sflTSF7qALW4wzGT2+J1NYJ5Ag14GbTewpxr03j6WnQK/
        BHnzCt1s9F6M4b5UlkXq1eieGUhcVt1WA7RmsbSVzZOcdmDZE6v0tYS3zdX3tKnQ
        ==
X-ME-Sender: <xms:OrKXYJZ2NvSm54jmOGhPHleBnf6z8HSokN--nU0uXYhv41nhYECs2A>
    <xme:OrKXYAZe-ZdNzr7UE223gN81rsc0P2cYdwh2nOGjMviYYHZQ-uua0YRWVfvRcZPP4
    2Jz-UAVzyZz-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegiedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheq
    necuggftrfgrthhtvghrnhepueelledtheekleethfeludduvdfhffeuvdffudevgeehke
    egieffveehgeeftefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:OrKXYL_EjpgQuMgET-cXJC7-nCIxlshmWRms9fUSi0PFYXtiMtKy5Q>
    <xmx:OrKXYHrLhIALaCuRcO8KPeWI3GT4YindqiqItEq-uU0G6Ys53rvTbQ>
    <xmx:OrKXYEoDFqRLXxQlFjzKhrA89xq-l9rop9a74Eq3DYHUj3t1eOnr2Q>
    <xmx:OrKXYPVq1IoTTDXZ8LHzEP9vALuRQy1RbrBS_gz4qupiuTzmNKow5Q>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Sun,  9 May 2021 05:58:17 -0400 (EDT)
Date:   Sun, 9 May 2021 11:58:15 +0200
From:   Greg KH <greg@kroah.com>
To:     linux-kernel@vger.kernel.org
Cc:     bingjingc@synology.com, stable-commits@vger.kernel.org
Subject: Re: Patch "btrfs: fix a potential hole punching failure" has been
 added to the 5.4-stable tree
Message-ID: <YJeyNyxPnwpvj746@kroah.com>
References: <20210508161014.3D8AF611BD@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210508161014.3D8AF611BD@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2021 at 12:10:13PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     btrfs: fix a potential hole punching failure
> 
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      btrfs-fix-a-potential-hole-punching-failure.patch
> and it can be found in the queue-5.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 3744bdfd37eaa635ddb70f15fe5d3bde233e54f0
> Author: BingJing Chang <bingjingc@synology.com>
> Date:   Thu Mar 25 09:56:22 2021 +0800
> 
>     btrfs: fix a potential hole punching failure
>     
>     [ Upstream commit 3227788cd369d734d2d3cd94f8af7536b60fa552 ]
>     
>     In commit d77815461f04 ("btrfs: Avoid trucating page or punching hole
>     in a already existed hole."), existing holes can be skipped by calling
>     find_first_non_hole() to adjust start and len. However, if the given len
>     is invalid and large, when an EXTENT_MAP_HOLE extent is found, len will
>     not be set to zero because (em->start + em->len) is less than
>     (start + len). Then the ret will be 1 but len will not be set to 0.
>     The propagated non-zero ret will result in fallocate failure.
>     
>     In the while-loop of btrfs_replace_file_extents(), len is not updated
>     every time before it calls find_first_non_hole(). That is, after
>     btrfs_drop_extents() successfully drops the last non-hole file extent,
>     it may fail with ENOSPC when attempting to drop a file extent item
>     representing a hole. The problem can happen. After it calls
>     find_first_non_hole(), the cur_offset will be adjusted to be larger
>     than or equal to end. However, since the len is not set to zero, the
>     break-loop condition (ret && !len) will not be met. After it leaves the
>     while-loop, fallocate will return 1, which is an unexpected return
>     value.
>     
>     We're not able to construct a reproducible way to let
>     btrfs_drop_extents() fail with ENOSPC after it drops the last non-hole
>     file extent but with remaining holes left. However, it's quite easy to
>     fix. We just need to update and check the len every time before we call
>     find_first_non_hole(). To make the while loop more readable, we also
>     pull the variable updates to the bottom of loop like this:
>       while (cur_offset < end) {
>               ...
>               // update cur_offset & len
>               // advance cur_offset & len in hole-punching case if needed
>       }
>     
>     Reported-by: Robbie Ko <robbieko@synology.com>
>     Fixes: d77815461f04 ("btrfs: Avoid trucating page or punching hole in a already existed hole.")
>     CC: stable@vger.kernel.org # 4.4+
>     Reviewed-by: Robbie Ko <robbieko@synology.com>
>     Reviewed-by: Chung-Chiang Cheng <cccheng@synology.com>
>     Reviewed-by: Filipe Manana <fdmanana@suse.com>
>     Signed-off-by: BingJing Chang <bingjingc@synology.com>
>     Signed-off-by: David Sterba <dsterba@suse.com>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index f8e5c47b95e4..dc6f4bfd9a45 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2642,8 +2642,6 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
>  			clone_info->file_offset += clone_len;
>  		}
>  
> -		cur_offset = drop_end;
> -
>  		ret = btrfs_update_inode(trans, root, inode);
>  		if (ret)
>  			break;
> @@ -2663,7 +2661,9 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
>  		BUG_ON(ret);	/* shouldn't happen */
>  		trans->block_rsv = rsv;
>  
> -		if (!clone_info) {
> +		cur_offset = drop_args.drop_end;
> +                len = end - cur_offset;
> +		if (!clone_info && len) {
>  			ret = find_first_non_hole(inode, &cur_offset, &len);
>  			if (unlikely(ret < 0))
>  				break;

This broke the build, so I'm dropping it :(
