Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598E83E021E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbhHDNfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238266AbhHDNf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:35:29 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D44EC0613D5;
        Wed,  4 Aug 2021 06:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=4hk+HApOCK63oaKmJFSctQEwtZoOxqs0pPNX/2Vu9NQ=; b=bR4T43FsUV/4qxec5DQLuuGUU7
        7YJ275gzeIhu7I+BKww2Q2mu2pwBfz5gxW7FfTKS3ovZQplGWM9hqOOk0zNI5BsVd7LVFZMQUiJR3
        WyF/MfWQyvYDZlpywa2svU7VUUETwhCi7p9HgeDtqcmUvDwJK9IJ8m96P5MlVieHCqwgEmwW7F+HU
        JpeSOyvBfzACIBLtMjzngircc64R/5Pqp6JA9TTCh5pQ3afEHZadHe7S8aDq+axGS32A4KdQxdcZO
        /L55Fk+z8hphHi4luNU439MKXcZd3yY4qzCKdeqNvU3xlugCSKDWPq+3e+EN8G/TADmA2z3hdfSBl
        K5fBJb6A==;
Received: from [2601:1c0:6280:3f0:e65e:37ff:febd:ee53]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mBH3C-005kix-60; Wed, 04 Aug 2021 13:35:14 +0000
Subject: Re: [PATCH][next] kernel/user.c: Fix spelling mistake "cpunter" ->
 "counter"
To:     Colin King <colin.king@canonical.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210804120658.110124-1-colin.king@canonical.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e67d1ff8-f872-c1af-7f1c-03ac9e9d7d2e@infradead.org>
Date:   Wed, 4 Aug 2021 06:35:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804120658.110124-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/21 5:06 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a panic message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   kernel/user.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/user.c b/kernel/user.c
> index a2673f940506..7fc40af8d8ac 100644
> --- a/kernel/user.c
> +++ b/kernel/user.c
> @@ -223,7 +223,7 @@ static int __init uid_cache_init(void)
>   		INIT_HLIST_HEAD(uidhash_table + n);
>   
>   	if (percpu_counter_init(&root_user.epoll_watches, 0, GFP_KERNEL))
> -		panic("percpu cpunter alloc failed");
> +		panic("percpu counter alloc failed");
>   
>   	/* Insert the root user immediately (init already runs as root) */
>   	spin_lock_irq(&uidhash_lock);
> 

Nick Piggin has reworded that panic message text in a patch
yesterday so this patch isn't needed.

https://lore.kernel.org/lkml/1628051945.fens3r99ox.astroid@bobo.none/


thanks.
-- 
~Randy

