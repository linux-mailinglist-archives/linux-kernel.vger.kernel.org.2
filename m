Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348E33F7F40
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 02:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234853AbhHZARB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 20:17:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234205AbhHZARA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 20:17:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35B3160F39;
        Thu, 26 Aug 2021 00:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629936973;
        bh=0ngJr9PpMHfpAYd6Uit3Fbbi1EtpGFDiQCW/shNirk4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=GEDWdVTn1JAJ8v2Z18tJPMDEjntyAxEDV3AVH91IBl7pGNBI/QOBanw1L9MuRFtK1
         3D6uFqQPhI1DMTHsshtvydeo06QPKw8Nv+fdS329n29L9pq/aITwfwzDDyheyUL0S1
         mTQVtSMwD+Eey4MfcoG4t8JVJkzfV1gIXAqDPBTrBEIJKj4H3T/XqBM/WFpq68XnNU
         bhC8seMC1LcESlfooRJALK0br01Gnv7Q74DeQU0yvOkBTo9KQgf2S04Qapj7J9Jcsl
         olDzgeAlfpcPaNiFiHFI2FYXpa0yW5qLdsMTkQtAB1Kf0/C+exE/Zzy4vTDrwOu6ph
         4Yvxr3WZoziCw==
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: don't ignore writing pages on fsync
 during checkpoint=disable
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20210823170151.1434772-1-jaegeuk@kernel.org>
 <YSa3DPBIFZ5P17vt@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <bc9840f7-6fee-1ba4-ed82-b149f18934c9@kernel.org>
Date:   Thu, 26 Aug 2021 08:16:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YSa3DPBIFZ5P17vt@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/26 5:33, Jaegeuk Kim wrote:
> We must flush all the dirty data when enabling checkpoint back. Let's guarantee
> that first. In order to mitigate any failure, let's flush data in fsync as well
> during checkpoint=disable.

It needs to update comments a bit with respect to update part of v2?

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> v2 from v1:
>   - handle sync_inodes_sb() failure
> 
>   fs/f2fs/file.c  |  5 ++---
>   fs/f2fs/super.c | 11 ++++++++++-
>   2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index cc2080866c54..3330efb41f22 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -263,8 +263,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>   	};
>   	unsigned int seq_id = 0;
>   
> -	if (unlikely(f2fs_readonly(inode->i_sb) ||
> -				is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> +	if (unlikely(f2fs_readonly(inode->i_sb)))
>   		return 0;
>   
>   	trace_f2fs_sync_file_enter(inode);
> @@ -278,7 +277,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>   	ret = file_write_and_wait_range(file, start, end);
>   	clear_inode_flag(inode, FI_NEED_IPU);
>   
> -	if (ret) {
> +	if (ret || is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
>   		trace_f2fs_sync_file_exit(inode, cp_reason, datasync, ret);
>   		return ret;
>   	}
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 49e153fd8183..d2f97dfb17af 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2088,8 +2088,17 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
>   
>   static void f2fs_enable_checkpoint(struct f2fs_sb_info *sbi)
>   {
> +	int retry = DEFAULT_RETRY_IO_COUNT;
> +
>   	/* we should flush all the data to keep data consistency */
> -	sync_inodes_sb(sbi->sb);
> +	do {
> +		sync_inodes_sb(sbi->sb);
> +		cond_resched();
> +		congestion_wait(BLK_RW_ASYNC, DEFAULT_IO_TIMEOUT);
> +	} while (get_pages(sbi, F2FS_DIRTY_DATA) && retry--);
> +
> +	if (unlikely(!retry))

Well, if we break the loop due to retry-- == 0, value of retry will be -1 here.

So should be:

if (unlikely(retry < 0))

Thanks,

> +		f2fs_warn(sbi, "checkpoint=enable has some unwritten data.");
>   
>   	down_write(&sbi->gc_lock);
>   	f2fs_dirty_to_prefree(sbi);
> 
