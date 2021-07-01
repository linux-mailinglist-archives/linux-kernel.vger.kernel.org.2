Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26023B9543
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 19:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhGARMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 13:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhGARMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:12:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D70661405;
        Thu,  1 Jul 2021 17:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625159422;
        bh=xdnAA7baVCohcq+q0n62eDKdetlkpnI4UjNwJ3Ih8CU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M+RhoUajTF1gDgnHS60QrdV574dAeRY/sXEy1jFcWO6rPhV07SByNFM8vKZH/auLT
         PSINIJLIG8yzSgOA8LTGfMk9heo0H5qbFim6132xUPayb9R7uvBIpgyqLis9Ej4EsF
         9FyE4zlnLw8iKeQ1hTPUN+k1IkgUcvtEhesKv3I7Lj8WyHQemeLMz1onksshmlA/jd
         0udbOX+Nwau9XcbhVdimeNGmjoeang+5BLX2GU+MHCGhbpYqGsz9dNnrGD+VQGunkF
         Vasq0rXWNNzqRrXkgsSLuzvyNZA0hlN2fMQ/ZNM331EC2MI+WcJCEAuz86T21tQOwj
         wD2WPOszA+gKA==
Date:   Thu, 1 Jul 2021 10:10:20 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v2 RFC] f2fs: fix to force keeping write barrier for
 strict fsync mode
Message-ID: <YN32/NsjqJONbvz7@google.com>
References: <20210601101024.119356-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601101024.119356-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01, Chao Yu wrote:
> [1] https://www.mail-archive.com/linux-f2fs-devel@lists.sourceforge.net/msg15126.html
> 
> As [1] reported, if lower device doesn't support write barrier, in below
> case:
> 
> - write page #0; persist
> - overwrite page #0
> - fsync
>  - write data page #0 OPU into device's cache
>  - write inode page into device's cache
>  - issue flush

Well, we have preflush for node writes, so I don't think this is the case.

 fio.op_flags |= REQ_PREFLUSH | REQ_FUA;

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
>  fs/f2fs/file.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 7d5311d54f63..238ca2a733ac 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -301,6 +301,20 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>  				f2fs_exist_written_data(sbi, ino, UPDATE_INO))
>  			goto flush_out;
>  		goto out;
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
>  	}
>  go_write:
>  	/*
> -- 
> 2.29.2
