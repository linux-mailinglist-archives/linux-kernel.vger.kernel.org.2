Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EEB30B2C8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 23:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBAWee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 17:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:59826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhBAWea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 17:34:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3685164E93;
        Mon,  1 Feb 2021 22:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612218830;
        bh=6ifs07SoPwNCF09AduweLP8VSa2eET6rB/VZr8wQPrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hjc/+kX+QPWvs0PD/OViXtjsrmNHauL9Vd0DOYpMijrTS29Wm87KohdYqQqLWuwSm
         FhbIY4PvPkeCwz7nLF8fb6wbrFsrwuJCZPQ6ysZyFidn/W3lViZJ2Y5UhLHU7v9ag6
         TGExqJGtp6hFB4E8lVUp34nS5Z966yrYvM7CEZCVGJ6KLwFLKh17KMj8WpHHKx6LIa
         e+0HYVsvx05hKmsRIwpTLRyg3HaRo+znAXLOBj0On2a+LgO785NVNP7/jBWfSqVlVc
         A9HEIwpC2sYWsL3NRKzIT94yaabrSOsNo9IMatWOXf7TQTAG9OVqY7l9jffQIpSs3K
         s+Kcz1abhVeUw==
Date:   Mon, 1 Feb 2021 14:33:48 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [PATCH] f2fs: prevent setting ioprio of thread not in merge mode
Message-ID: <YBiBzP2YC3j1Q8Ry@google.com>
References: <20210201005749.2980575-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201005749.2980575-1-daeho43@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.
Merged into the original patch.

On 02/01, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> It causes a crash to change the ioprio of checkpoint thread not in
> checkpoint=merge. I fixed that to prevent setting the ioprio of the
> thread when checkpoint=merge is not enabled.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/sysfs.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 100608bcd517..e38a7f6921dd 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -357,8 +357,12 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  			return -EINVAL;
>  
>  		cprc->ckpt_thread_ioprio = IOPRIO_PRIO_VALUE(class, data);
> -		ret = set_task_ioprio(cprc->f2fs_issue_ckpt,
> -				cprc->ckpt_thread_ioprio);
> +		if (test_opt(sbi, MERGE_CHECKPOINT)) {
> +			ret = set_task_ioprio(cprc->f2fs_issue_ckpt,
> +					cprc->ckpt_thread_ioprio);
> +			if (ret)
> +				return ret;
> +		}
>  
>  		return count;
>  	}
> -- 
> 2.30.0.365.g02bc693789-goog
