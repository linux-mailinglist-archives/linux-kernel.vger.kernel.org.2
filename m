Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3E53EE0E7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhHQAbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:31:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232929AbhHQAbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:31:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58C5E60F55;
        Tue, 17 Aug 2021 00:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629160235;
        bh=EdCrxzsMmkwYwBRpv9mB8ATfiVlhXsxkIRGxlrChfes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z/OxiQOpk/MWnSzb7t+AfFk4DY6FTSC86PcX4E1IpF6EPejYKZGilb1Oc5Ps47w0+
         k0MxtsE0IMhDy+yXcdlPk8m5eIKDvFYQRdK7ugBmZvUB47HnWNoqx3Xw7KLNSKzRWd
         S2wnX2hYQEH54X3y/J7tZD0XJGq6SEmod1F5EmFbZtb9M/kEm6XNfQlSaH+riw10ah
         7aq7u7Uwywk838nIPspwgOwx4sah0Su+by2w7kBqnY2UWx+FnNCroH1X/042ubLLy5
         9xBYNN53s6Vx494pOZiOrYXtiw+a6uMzvSti1Hh06XYG7ZoNPNJ3W2rxHw2osh3OIZ
         Df+/idgGiHQYw==
Date:   Mon, 16 Aug 2021 17:30:33 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: change value of recovery to bool
Message-ID: <YRsDKWcghjEXr1Ro@google.com>
References: <20210816122807.71400-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816122807.71400-1-frank.li@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, I don't see a great benefit of this patch. Do we have a chance to use
integer to get more specifics of the recovery reason in future?

On 08/16, Yangtao Li wrote:
> Recovery has only two values, 0 and 1, let's change it to bool type.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/super.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 8fecd3050ccd..98727e04d271 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3541,7 +3541,7 @@ static int init_blkz_info(struct f2fs_sb_info *sbi, int devi)
>   */
>  static int read_raw_super_block(struct f2fs_sb_info *sbi,
>  			struct f2fs_super_block **raw_super,
> -			int *valid_super_block, int *recovery)
> +			int *valid_super_block, bool *recovery)
>  {
>  	struct super_block *sb = sbi->sb;
>  	int block;
> @@ -3559,7 +3559,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
>  			f2fs_err(sbi, "Unable to read %dth superblock",
>  				 block + 1);
>  			err = -EIO;
> -			*recovery = 1;
> +			*recovery = true;
>  			continue;
>  		}
>  
> @@ -3569,7 +3569,7 @@ static int read_raw_super_block(struct f2fs_sb_info *sbi,
>  			f2fs_err(sbi, "Can't find valid F2FS filesystem in %dth superblock",
>  				 block + 1);
>  			brelse(bh);
> -			*recovery = 1;
> +			*recovery = true;
>  			continue;
>  		}
>  
> @@ -3784,15 +3784,16 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  	int err;
>  	bool skip_recovery = false, need_fsck = false;
>  	char *options = NULL;
> -	int recovery, i, valid_super_block;
> +	int i, valid_super_block;
>  	struct curseg_info *seg_i;
>  	int retry_cnt = 1;
> +	bool recovery;
>  
>  try_onemore:
>  	err = -EINVAL;
>  	raw_super = NULL;
>  	valid_super_block = -1;
> -	recovery = 0;
> +	recovery = false;
>  
>  	/* allocate memory for f2fs-specific super block info */
>  	sbi = kzalloc(sizeof(struct f2fs_sb_info), GFP_KERNEL);
> -- 
> 2.32.0
