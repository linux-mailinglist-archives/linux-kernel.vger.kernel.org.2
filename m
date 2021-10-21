Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD8C435E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 11:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhJUJsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 05:48:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhJUJsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 05:48:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E545560D42;
        Thu, 21 Oct 2021 09:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634809545;
        bh=NuZx+U/WxTn5Q2ibHJGCY7ADWDnU5+tPf1X/TctvQJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=q0wx56PS65O5Q9/2a6JpJWoLvO+J1VzrNqqfaIHulEaKiPZBLxJ0qJFoiyWIDfAmz
         wq+4baxbyTech5ooBruqWOdQ1GDKTLyEEXz3OG+u3j9pr89plD8b/CV/aAXWZv2djf
         9iNofABqAqPTZobAOGtocqQGd95SY0BRkkHoE7gJ8hkqpaTzvSRn9yBL0mzico2XsY
         6+yD4zWvRA8rcJDkA6GPJtwJ32A6OqbjBZD/dL/3iP68VtlhpHTApRXjSiNw/QssC8
         FG9dDHFI/ZsYujdRVrKJGcfBfTdEKMdSXQKwz6siLKMUn5POODmiyJay6RQzC3SJi2
         3WpRf9KYEyJug==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon/dbgfs: Optimize target_ids interface write operation
Date:   Thu, 21 Oct 2021 09:45:43 +0000
Message-Id: <20211021094543.1846-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211021085611.81211-1-xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xin,

On Thu, 21 Oct 2021 16:56:11 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> When writing some pids to target_ids interface, calling scanf()
> to get 'id' may be failed. If the value of '*nr_ids' is 0 at this time,
> there is no need to return 'ids' here, we just need to release it and
> return NULL pointer to improve related code operation efficiency.

Thank you for the patch!  But, I don't think this patch makes sense, because
the case (*nr_ids == 0) means not error but an ask to remove previously set
target ids.  For example, it works as below now:

    # echo 42 > target_ids
    # cat target_ids
    42
    # echo > target_ids
    # cat target_ids

    #

But, with your patch, the behavior will be changed as below:

    # echo 42 > target_ids
    # cat target_ids
    42
    # echo > target_ids
    bash: echo: write error: Cannot allocate memory
    # cat target_ids
    42
    #

Also, this patch makes the DAMON selftest fails as below:

    $ sudo make -C tools/testing/selftests/damon run_tests
    make: Entering directory '/home/sjpark/linux/tools/testing/selftests/damon'
    TAP version 13
    1..2
    # selftests: damon: debugfs_attrs.sh
    # ./debugfs_attrs.sh: line 11: echo: write error: Invalid argument
    # ./debugfs_attrs.sh: line 11: echo: write error: Invalid argument
    # ./debugfs_attrs.sh: line 11: echo: write error: Invalid argument
    # ./debugfs_attrs.sh: line 11: echo: write error: Invalid argument
    # ./debugfs_attrs.sh: line 11: echo: write error: Invalid argument
    # ./debugfs_attrs.sh: line 11: echo: write error: Cannot allocate memory
    # writing abc 2 3 to /sys/kernel/debug/damon/target_ids doesn't return 0
    # expected because: the file allows wrong input
    not ok 1 selftests: damon: debugfs_attrs.sh # exit=1

If I'm missing something, please let me know.


Thanks,
SJ

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  mm/damon/dbgfs.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> index a02cf6bee8e8..2d77bf579ffb 100644
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -308,21 +308,25 @@ static unsigned long *str_to_target_ids(const char *str, ssize_t len,
>  	unsigned long *ids;
>  	const int max_nr_ids = 32;
>  	unsigned long id;
> -	int pos = 0, parsed, ret;
> +	int pos = 0, parsed;
>  
>  	*nr_ids = 0;
>  	ids = kmalloc_array(max_nr_ids, sizeof(id), GFP_KERNEL);
>  	if (!ids)
>  		return NULL;
>  	while (*nr_ids < max_nr_ids && pos < len) {
> -		ret = sscanf(&str[pos], "%lu%n", &id, &parsed);
> -		pos += parsed;
> -		if (ret != 1)
> +		if (sscanf(&str[pos], "%lu%n", &id, &parsed) != 1)
>  			break;
> +		pos += parsed;
>  		ids[*nr_ids] = id;
>  		*nr_ids += 1;
>  	}
>  
> +	if (!*nr_ids) {
> +		kfree(ids);
> +		return NULL;
> +	}
> +
>  	return ids;
>  }
>  
> -- 
> 2.31.0
