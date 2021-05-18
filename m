Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EEE387622
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 12:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348371AbhERKLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 06:11:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241553AbhERKLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 06:11:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2AF78611AD;
        Tue, 18 May 2021 10:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621332587;
        bh=zUaWX2mb0C3ryhkJQpsmWO0ofJTjLJ83Q9UbOek1xa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=seikdRNTh/YjhJmN1mLIit2f8CzTC0hpm+j3Me1DCLIwlxL5hpJNiq7vZ7p2p2+tD
         oZ06ZHlF/ZXs/0uT2r1e1GKkJHQLfowmEREdxs+2xnB6V9JaBmumkdEGkfxXDcEOiH
         RsV9DpbM95zyW2jxzOFQ9hLEshmDcf3/70BfuSHGgZqtMluY0//x8eglF2XVNHll0U
         qouflSyuM8dD14CncgtOMwpLCAro5ksNWUby5Iz9fCn5Z3OwzXrD74uUZFCzIMe4hS
         VI5tWQok4kPubt5sNql3WPHfHil3fKmPv2GI0APWcftjkjFOgPNduBPTLmmEZKIOIt
         Bl6qe2U5wZr/A==
Date:   Tue, 18 May 2021 13:09:40 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dongas86@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/5] mm/sparse: free section usage memory in case
 populate_section_memmap failed
Message-ID: <YKOSZELQWd6o7cva@kernel.org>
References: <20210517112044.233138-1-aisheng.dong@nxp.com>
 <20210517112044.233138-3-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517112044.233138-3-aisheng.dong@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 07:20:41PM +0800, Dong Aisheng wrote:
> Free section usage memory in case populate_section_memmap failed.
> We use map_count to track the remain unused memory to be freed.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  mm/sparse.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 7ac481353b6b..98bfacc763da 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -549,12 +549,14 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
>  			       __func__, nid);
>  			pnum_begin = pnum;
>  			sparse_buffer_fini();
> +			memblock_free_early(__pa(usage), map_count * mem_section_usage_size());

I'd move both sparse_buffer_fini() and freeing of 'usage' memory after the
failed label.

>  			goto failed;
>  		}
>  		check_usemap_section_nr(nid, usage);
>  		sparse_init_one_section(__nr_to_section(pnum), pnum, map, usage,
>  				SECTION_IS_EARLY);
>  		usage = (void *) usage + mem_section_usage_size();
> +		map_count--;
>  	}
>  	sparse_buffer_fini();
>  	return;
> -- 
> 2.25.1
> 
> 

-- 
Sincerely yours,
Mike.
