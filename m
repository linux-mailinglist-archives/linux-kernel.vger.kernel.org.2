Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F2839A52D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 18:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbhFCQCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 12:02:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229623AbhFCQCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 12:02:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36CCE613E4;
        Thu,  3 Jun 2021 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622736029;
        bh=M9GUJBcQqn8H5w/RTpySxCTtdT8isktpYnd50U1/Vmc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=myqghbSx06FqpWxgcCThF9ESiJDrnltHdhLkxrkVPLCdKCjxuLDgZRXaiWbHFnoO5
         /30vLT4QDqqgFgz3Cp7OfbyMffC4aMAIO+Q/9oBThvdqLDUdFwTVOgFhc6soToQBMZ
         6hZdAXOxzLHHdUrLXO7L9bTw01YvNpap9Eqd3Nzxhg8XwcpUVYgd1AIZ78TVItfSm8
         0Ptyrq30WuDHtB0caHU9fBXRhIu+IyMtGfNfA8TikMYU9zhc0xSqlIpc8TJ/0j6eJi
         Z7QQY6DhffX6kEzfl/qFQEfIvh9SJGyWmJ1V/Vxenv7t82q56bTvgYgnYGMo6sxvv9
         sQGqQDGn/V01w==
Subject: Re: [PATCH v2 RFC] f2fs: fix to force keeping write barrier for
 strict fsync mode
To:     Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20210601101024.119356-1-yuchao0@huawei.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <9b43a461-e348-f16c-31da-fb70e064d6f8@kernel.org>
Date:   Fri, 4 Jun 2021 00:00:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601101024.119356-1-yuchao0@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jaegeuk,

Any comments on this patch?

On 2021/6/1 18:10, Chao Yu wrote:
> [1] https://www.mail-archive.com/linux-f2fs-devel@lists.sourceforge.net/msg15126.html
> 
> As [1] reported, if lower device doesn't support write barrier, in below
> case:
> 
> - write page #0; persist
> - overwrite page #0
> - fsync
>   - write data page #0 OPU into device's cache
>   - write inode page into device's cache
>   - issue flush
> 
> If SPO is triggered during flush command, inode page can be persisted
> before data page #0, so that after recovery, inode page can be recovered
> with new physical block address of data page #0, however there may
> contains dummy data in new physical block address.
> 
> Then what user will see is: after overwrite & fsync + SPO, old data in
> file was corrupted, if any user do care about such case, we can suggest
> user to use STRICT fsync mode, in this mode, we will force to trigger
> preflush command to persist data in device cache in prior to node
> writeback, it avoids potential data corruption during fsync().
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
> v2:
> - fix this by adding additional preflush command rather than using
> atomic write flow.
>   fs/f2fs/file.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 7d5311d54f63..238ca2a733ac 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -301,6 +301,20 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>   				f2fs_exist_written_data(sbi, ino, UPDATE_INO))
>   			goto flush_out;
>   		goto out;
> +	} else {
> +		/*
> +		 * for OPU case, during fsync(), node can be persisted before
> +		 * data when lower device doesn't support write barrier, result
> +		 * in data corruption after SPO.
> +		 * So for strict fsync mode, force to trigger preflush to keep
> +		 * data/node write order to avoid potential data corruption.
> +		 */
> +		if (F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT &&
> +								!atomic) {
> +			ret = f2fs_issue_flush(sbi, inode->i_ino);
> +			if (ret)
> +				goto out;
> +		}
>   	}
>   go_write:
>   	/*
> 
