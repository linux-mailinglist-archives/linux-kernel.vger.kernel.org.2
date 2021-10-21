Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02376436907
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 19:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhJURcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 13:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhJURck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 13:32:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01D61619E8;
        Thu, 21 Oct 2021 17:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634837424;
        bh=Rw1sUa7yPrJ6jT4uN3r6flB0/5Xc0XmX8HOGGrPrPLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=SbyQFe08b594LDqPdBXhuhse2RGndFBFY6bY5mBe0luSs2efqt8V7JlyE/VF2a5nN
         5rbpe3FG2ZKQUgxOI6TtrOOHkPAo8AeQAzP4wPb1mxwhzXGKMn+s6JavKH/vZqmMol
         NJhh1P8oYFBanpnILpE0ZK35ik1aRK/unP4zOCfNQ5NkdVzDm+hlSsQXD8zhtYCztq
         wrP8Jzg8l5XZslvJjHWteKCZsutJSSbTRi5buTV2SWLXU9vnzZlxl/OoUV3CMYt845
         iZyw+UUFA9L+GjS3M5SeQ5UcaHziNfl5xwgc8W1kNBPmUtRAqXFNn8IL55wGhgiJ53
         Cg8QW5m70RYtQ==
From:   SeongJae Park <sj@kernel.org>
To:     Xin Hao <xhao@linux.alibaba.com>
Cc:     sjpark@amazon.de, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/damon/dbgfs: Optimize target_ids interface write operation
Date:   Thu, 21 Oct 2021 17:30:18 +0000
Message-Id: <20211021173018.15994-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <bc341f48b5558f6816dcef22eca4f4a590efdc67.1634834628.git.xhao@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Xin,

On Fri, 22 Oct 2021 00:44:16 +0800 Xin Hao <xhao@linux.alibaba.com> wrote:

> When we want to clear previously set target ids,
> For example, it works as below now:
>     # echo 42 > target_ids
>     # cat target_ids
>     42
>     # echo > target_ids
>     # cat target_ids
> 
> But in 'dbgfs_target_ids_write', there is no need to
> execute other codes, except call 'damon_set_targets'
> to clear previously set target ids. So there adds
> the 'nr_targets' judgment, if the value is 0, just
> call 'damon_set_targets', and then return.

It's true that it executes some unnecessary code.  However, I unsure if that is
a problem, as the code that will be additionally executed in this case are
quite simple ones, and therefore not supposed to incur viewable overhead.
After all, this is not a performance critical path.

Thanks,
SJ

> 
> Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
> ---
>  mm/damon/dbgfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
> index a02cf6bee8e8..1d83f4138fad 100644
> --- a/mm/damon/dbgfs.c
> +++ b/mm/damon/dbgfs.c
> @@ -362,6 +362,12 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
>  		goto out;
>  	}
> 
> +	if (!nr_targets) {
> +		/* remove targets with previously-set primitive */
> +		damon_set_targets(ctx, NULL, 0);
> +		goto free_targets_out;
> +	}
> +
>  	if (id_is_pid) {
>  		for (i = 0; i < nr_targets; i++) {
>  			targets[i] = (unsigned long)find_get_pid(
> --
> 2.31.0
