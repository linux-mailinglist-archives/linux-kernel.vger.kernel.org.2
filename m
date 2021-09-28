Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896A141BA60
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243120AbhI1WbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 18:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243111AbhI1Wa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:30:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 760DA61381;
        Tue, 28 Sep 2021 22:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632868159;
        bh=RlMnQHvKbCptPyDKXtqteND8kHNLrMbyeCBWyPInBOs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sCiB9foh9d7vxarJrKj4AviIhEy8mVERt4kZrHiXu7KhiwUaG/lbFAAC2+EfuSoyW
         waVWOrEDbGLBX2DgxeO7TN3gtjODplzmEDMh1q6v/KD0oOF3JDk5or45TGZX7MQHff
         qIoenboqrZ3CkrIBGv2mCkUE8PiHVYYLm+tWf1gY=
Date:   Tue, 28 Sep 2021 15:29:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liangcai Fan <liangcaifan19@gmail.com>
Cc:     liangcai.fan@unisoc.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, zhang.lyra@gmail.com
Subject: Re: [PATCH] mm: Set min_free_kbytes with user_min_free_kbytes when
 user_min_free_kbytes is preferred
Message-Id: <20210928152919.df87f6c8194316ff1407cdc7@linux-foundation.org>
In-Reply-To: <1632831797-32192-1-git-send-email-liangcaifan19@gmail.com>
References: <1632831797-32192-1-git-send-email-liangcaifan19@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 20:23:17 +0800 Liangcai Fan <liangcaifan19@gmail.com> wrote:

> The 'min_free_kbytes' and 'user_min_free_kbytes' maybe inconsistent
> after a few times of memory hotplug.

What does "inconsistent" mean here?

Please describe the problem in more detail, perhaps with examples.

> When 'new_min_free_kbytes' is not larger than 'user_min_free_kbytes',
> set 'min_free_kbytes' with 'user_min_free_kbytes' rather than leave
> it as the 'new_min_free_kbytes' calculated for the last time.
> 
> Signed-off-by: Liangcai Fan <liangcaifan19@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> ---
>  mm/page_alloc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b37435c..ddf9dc1 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8467,6 +8467,12 @@ int __meminit init_per_zone_wmark_min(void)
>  		if (min_free_kbytes > 262144)
>  			min_free_kbytes = 262144;
>  	} else {
> +		/*
> +		 * Set 'min_free_kbytes' with 'user_min_free_kbytes' rather than
> +		 * leave it as the 'new_min_free_kbytes' calculated for the last
> +		 * time.
> +		 */

This comment explains what the code is doing, which is almost always
obvious from reading the code!  A better comment will describe *why*
the code is doing whatever is does.   "why, not what", please.

> +		min_free_kbytes = user_min_free_kbytes;
>  		pr_warn("min_free_kbytes is not updated to %d because user defined value %d is preferred\n",
>  				new_min_free_kbytes, user_min_free_kbytes);
>  	}

