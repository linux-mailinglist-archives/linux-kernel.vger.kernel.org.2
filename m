Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDE03467E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbhCWSjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232103AbhCWSji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:39:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A1BC60200;
        Tue, 23 Mar 2021 18:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616524778;
        bh=0kSLNKQSz2QSG9wMkW2lNiXkYaK/wjl031Wzl1gMSKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+LdZ8jkgyoBNkl83dF6ABdg/ZAXCReS5ebQzZcimeguVxw6jp7cQTGb6c0Db7r99
         GZJAEQ7YfS2KrOl4HkBLzCN1DE6vprvuDg9kVKBExKM0gZC+Y0Ijd8bEbBzCWtH5D+
         EonLO53/BAJgRoayhuNDGua77kW4mqUYrp7AaZcIuc0qm9ZJcEQRBZm3+sIB42/aDn
         goZI52amaT7XobuN7JfHmxZPJEedh0Ya9OlUScXW3HXj4UQAE/+NOylE4izexRvI5U
         JtrUjQyjUjjLSxt2j/yVVes+xkcafqTIJ1ixW0cl+sZEks9yFsJV4j4vGIM8otrOaK
         V/u1ywkOeddKw==
Date:   Tue, 23 Mar 2021 11:39:36 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] Revert "f2fs: give a warning only for readonly partition"
Message-ID: <YFo16ADpWJ7OUAvK@google.com>
References: <20210323064155.12582-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323064155.12582-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23, Chao Yu wrote:
> This reverts commit 938a184265d75ea474f1c6fe1da96a5196163789.
> 
> Because that commit fails generic/050 testcase which expect failure
> during mount a recoverable readonly partition.

I think we need to change generic/050, since f2fs can recover this partition,
even though using it as readonly. And, valid checkpoint can allow for user to
read all the data without problem.

> 
> Fixes: 938a184265d7 ("f2fs: give a warning only for readonly partition")
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index b48281642e98..2b78ee11f093 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3952,10 +3952,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  		 * previous checkpoint was not done by clean system shutdown.
>  		 */
>  		if (f2fs_hw_is_readonly(sbi)) {
> -			if (!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG))
> +			if (!is_set_ckpt_flags(sbi, CP_UMOUNT_FLAG)) {
> +				err = -EROFS;
>  				f2fs_err(sbi, "Need to recover fsync data, but write access unavailable");
> -			else
> -				f2fs_info(sbi, "write access unavailable, skipping recovery");
> +				goto free_meta;
> +			}
> +			f2fs_info(sbi, "write access unavailable, skipping recovery");
>  			goto reset_checkpoint;
>  		}
>  
> -- 
> 2.29.2
