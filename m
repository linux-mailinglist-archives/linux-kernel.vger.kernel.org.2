Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044BE36782F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 06:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhDVEEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 00:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhDVEEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 00:04:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F5B1613CC;
        Thu, 22 Apr 2021 04:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619064244;
        bh=vs3ayIaBY68FqZS//4WZP7ftXNR4rRy3qqwmFLiugpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vKLbE6T5+jN47C/PGbTCN6CmFwsH7i17h/qAlfAM+z7Ar5+qCVPjF9Moyr8DcR8xq
         E/o818HE1z3zqtK8/s3afrUcPBVWKZ71BsO7FqqdtnDAADgzwpwHHa1MTdkpyBu2gc
         I71Nr/VjufUu1SzBNDZEptGOnZsUo1okRrWV1tCUSAWgCTqEGQE+NZVLhTLIEMwBgC
         z9PXv496oiprc6UpvvQtDdpIwDU5wUnyIwpqlGrt93BxOQc6iKxnSucaMaT6XrEm5s
         z9gRE2cz906bwMOBWGkGsqZMLrCiAy29DYpCRRcj1A+QS117+Tq2JI/HnMSmC7LXEi
         7z2B3zUUScbVA==
Date:   Wed, 21 Apr 2021 21:04:02 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: compress: remove unneed check condition
Message-ID: <YID1sqemJVeBcdqD@google.com>
References: <20210421083941.66371-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421083941.66371-1-yuchao0@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/21, Chao Yu wrote:
> In only call path of __cluster_may_compress(), __f2fs_write_data_pages()
> has checked SBI_POR_DOING condition, and also cluster_may_compress()
> has checked CP_ERROR_FLAG condition, so remove redundant check condition
> in __cluster_may_compress() for cleanup.

I think cp_error can get any time without synchronization. Is it safe to say
it's redundant?

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/compress.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 3c9d797dbdd6..532c311e3a89 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -906,11 +906,6 @@ static bool __cluster_may_compress(struct compress_ctx *cc)
>  
>  		f2fs_bug_on(sbi, !page);
>  
> -		if (unlikely(f2fs_cp_error(sbi)))
> -			return false;
> -		if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> -			return false;
> -
>  		/* beyond EOF */
>  		if (page->index >= nr_pages)
>  			return false;
> -- 
> 2.29.2
