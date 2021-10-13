Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D191042C464
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbhJMPGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:06:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233969AbhJMPGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:06:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B19E360F21;
        Wed, 13 Oct 2021 15:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634137458;
        bh=OrypIYAhYXa9wGUSvO8g91htORfmmNplHozAJSPJRq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=QMTmOAgehbBmBkuxpLwRuJQCocj1XYq90veQBVwSShzLDXMHz/dxQ6vXXb2+lMe1b
         So1xk0b70W/AwWB/m0LLU+chUlBtQJ+agLP8TMyBih4dB69CvJKZZi9pwiEWfyNg5p
         U/LZBsApH5FivMO8AkykYNRpvyHBq9Fok4JzZuTB5rL+6CSd/ZGCyw5ZtfWHzAtL6G
         ckb9SAwdOhrtEc2h4ac5LqjOHbbmIqK31jdb58wvKtdsRWZiW187DIGN7vEVz4cfVN
         HL42BEYQWOSA0NamQXYv7cS4kB7jg7fhp8Mj8KSYeNt2DnjmaV2mxxMn7dDCr5G2ga
         qx0XFsdU0HCUQ==
From:   SeongJae Park <sj@kernel.org>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, sj@kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/damon/dbgfs: remove unnecessary variables
Date:   Wed, 13 Oct 2021 15:04:13 +0000
Message-Id: <20211013150413.23027-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211013130901.1017-1-rongwei.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rongwei,


Thank you for this patch!  Looks good to me overall.  I left a couple of
nitpicks below, though.

On Wed, 13 Oct 2021 21:09:01 +0800 Rongwei Wang <rongwei.wang@linux.alibaba.com> wrote:

[...]
> @@ -352,7 +350,7 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
>  
>  	nrs = kbuf;
>  
> -	targets = str_to_target_ids(nrs, ret, &nr_targets);
> +	targets = str_to_target_ids(nrs, count, &nr_targets);
>  	if (!targets) {
>  		ret = -ENOMEM;
>  		goto out;
> @@ -378,12 +376,12 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
>  		goto unlock_out;
>  	}
>  
> -	err = damon_set_targets(ctx, targets, nr_targets);
> -	if (err) {
> +	ret = damon_set_targets(ctx, targets, nr_targets);
> +	if (ret < 0) {

I'd prefer 'if (ret) {', to be consistent with other part.

>  		if (targetid_is_pid(ctx))
>  			dbgfs_put_pids(targets, nr_targets);
> -		ret = err;
> -	}
> +	} else
> +		ret = count;

I'd prefer this to have braces:
https://docs.kernel.org/process/coding-style.html#placing-braces-and-spaces

>  
>  unlock_out:
>  	mutex_unlock(&ctx->kdamond_lock);
> @@ -548,8 +546,7 @@ static ssize_t dbgfs_mk_context_write(struct file *file,
[...]


Thanks,
SJ
