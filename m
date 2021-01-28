Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B385F30798F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 16:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhA1PVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 10:21:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:35816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231783AbhA1PTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 10:19:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2853DACB7;
        Thu, 28 Jan 2021 15:18:24 +0000 (UTC)
Subject: Re: [PATCH][next] mm/zswap: fix potential uninitialized pointer read
 on tmp
To:     Colin King <colin.king@canonical.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210128141728.639030-1-colin.king@canonical.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <2dee1f77-863b-e7aa-a3d2-bb4591d4f720@suse.cz>
Date:   Thu, 28 Jan 2021 16:18:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210128141728.639030-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/21 3:17 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where zpool_can_sleep_mapped(pool) returns 0
> then tmp is not allocated and tmp is then an uninitialized
> pointer. Later if entry is null, tmp is freed, hence free'ing
> an uninitialized pointer. Fix this by ensuring tmp is initialized
> to NULL.
> 
> Addresses-Coverity: ("Uninitialized pointer read")
> Fixes: 908aa806dba0 ("mm/zswap: fix potential memory leak")

That's a linux-next hash, patch is in mmotm [1] *) You know what it means...

*) actually it's not there, yet it is in -next. What's going on?

[1]
https://ozlabs.org/~akpm/mmotm/broken-out/mm-zswap-fix-potential-memory-leak.patch

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  mm/zswap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 8d1381b1178d..578d9f256920 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -935,7 +935,7 @@ static int zswap_writeback_entry(struct zpool *pool, unsigned long handle)
>  	struct scatterlist input, output;
>  	struct crypto_acomp_ctx *acomp_ctx;
>  
> -	u8 *src, *tmp;
> +	u8 *src, *tmp = NULL;
>  	unsigned int dlen;
>  	int ret;
>  	struct writeback_control wbc = {
> 

