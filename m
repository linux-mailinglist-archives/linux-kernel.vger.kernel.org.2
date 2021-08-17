Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A43E3EE0F0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 02:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhHQAdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 20:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:32964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233009AbhHQAdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 20:33:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6821B60F39;
        Tue, 17 Aug 2021 00:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629160352;
        bh=j9rX+xWK9KMeYx91b9UKRhQlkitsFLhEMA1h2yBt8nY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tYENyk89HM2TbfLyJp5wREcKgeWDA/6SghlpVDulriDNQnbxcmGqe9JLpjTFWt3Rf
         LgcxQycD9bQTIEnziKejljpSHURIQizMyTM5sxslnwj+cWh0uYm5nr/MKoubwnkmIJ
         icBIRjRUlgKeg4ga6ERcLeo5uRZx6sdXKRDgBptipRqjTeyw7O+ZJmroIKVvyt/9OA
         PMi9oO/kWono4aZ9Tr7rz63lgQmP0KByY+f26kY/ABoDPJaDsOgbNE56f8s8HO74IF
         KlPkPaHkYO/dZ6k9qOa4EJKQLgmwrWkNNsMj5aG+VTopwafJW2/eImZvI2KcBG6K1s
         zYGV0HmF5zf0w==
Date:   Mon, 16 Aug 2021 17:32:31 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: always call f2fs_issue_checkpoint() in
 f2fs_sync_fs()
Message-ID: <YRsDnwWZwTBFvD0/@google.com>
References: <20210816132248.276865-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816132248.276865-1-frank.li@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16, Yangtao Li wrote:
> Sync is always 1, so delete the check of the value.

I don't think so.

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/super.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 98727e04d271..b823c7e3f303 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1553,7 +1553,6 @@ static void f2fs_put_super(struct super_block *sb)
>  int f2fs_sync_fs(struct super_block *sb, int sync)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> -	int err = 0;
>  
>  	if (unlikely(f2fs_cp_error(sbi)))
>  		return 0;
> @@ -1565,10 +1564,7 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>  		return -EAGAIN;
>  
> -	if (sync)
> -		err = f2fs_issue_checkpoint(sbi);
> -
> -	return err;
> +	return f2fs_issue_checkpoint(sbi);
>  }
>  
>  static int f2fs_freeze(struct super_block *sb)
> -- 
> 2.32.0
