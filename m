Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5CF366D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242983AbhDUN4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:56:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:33864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235434AbhDUN4H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:56:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7613DB12C;
        Wed, 21 Apr 2021 13:55:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4396B1F2B69; Wed, 21 Apr 2021 15:55:33 +0200 (CEST)
Date:   Wed, 21 Apr 2021 15:55:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Wenwen Wang <wang6495@umn.edu>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 087/190] Revert "udf: fix an uninitialized read bug and
 remove dead code"
Message-ID: <20210421135533.GV8706@quack2.suse.cz>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-88-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-88-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 21-04-21 14:59:22, Greg Kroah-Hartman wrote:
> This reverts commit 39416c5872db69859e867fa250b9cbb3f1e0d185.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: Wenwen Wang <wang6495@umn.edu>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi Greg!

I'm pretty confident this particular report & fix was valid (in fact it was
me who suggested the particular change). So I don't see point in reverting
it...

								Honza

> ---
>  fs/udf/namei.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/fs/udf/namei.c b/fs/udf/namei.c
> index f146b3089f3d..77906b679187 100644
> --- a/fs/udf/namei.c
> +++ b/fs/udf/namei.c
> @@ -304,6 +304,21 @@ static struct dentry *udf_lookup(struct inode *dir, struct dentry *dentry,
>  	if (dentry->d_name.len > UDF_NAME_LEN)
>  		return ERR_PTR(-ENAMETOOLONG);
>  
> +#ifdef UDF_RECOVERY
> +	/* temporary shorthand for specifying files by inode number */
> +	if (!strncmp(dentry->d_name.name, ".B=", 3)) {
> +		struct kernel_lb_addr lb = {
> +			.logicalBlockNum = 0,
> +			.partitionReferenceNum =
> +				simple_strtoul(dentry->d_name.name + 3,
> +						NULL, 0),
> +		};
> +		inode = udf_iget(dir->i_sb, lb);
> +		if (IS_ERR(inode))
> +			return inode;
> +	} else
> +#endif /* UDF_RECOVERY */
> +
>  	fi = udf_find_entry(dir, &dentry->d_name, &fibh, &cfi);
>  	if (IS_ERR(fi))
>  		return ERR_CAST(fi);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
