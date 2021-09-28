Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3834341B401
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241839AbhI1Qjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:39:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230251AbhI1Qjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:39:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E6D96124B;
        Tue, 28 Sep 2021 16:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632847076;
        bh=SMngk4vQyYJh6Ix2Aws/opaA6OUWDxu+nMCYjp9HT1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iQgVWDbxrCaIXjszezjeShLIeggiuTGcNQ1kUNhlzz7L0iQPQpzMj3GWe9wAa83nE
         xixsfm9d1hqwYDvSP6/GmrOO92hD7ltNJOXIhNKmkS+/il7busZ7WxoK/kqcpVsvDR
         e/kiO2wqfW7dkNV80GGgOUqZ5DdiBiAf9pcqjVks+d5QN1jqaRRa6IavDliHyL7UIn
         fKt0uLNwvrHFm31u8lclGjdcS8e8j/k6BHO9q19aFkxbvVwNswsqrL3WblpzcpP/Up
         /EXgGepiez2LFYK8xweyCGaxty38Acn3ySjTGv5fn/yqwWgK5w70RXxn0FYFF0uJo2
         21cKFAw9fxEsQ==
Date:   Tue, 28 Sep 2021 09:37:55 -0700
From:   Mike Rapoport <rppt@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        geert+renesas@glider.be, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] memblock: check memory total_size
Message-ID: <YVNE43IBP0iUmng5@kernel.org>
References: <20210928105057.3406-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928105057.3406-1-peng.fan@oss.nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 28, 2021 at 06:50:57PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> mem=[X][G|M] is broken on NXP i.MX ARM64 platform, there is cases that
> even type.cnt is 1, but total_size is not 0 because regions are merged
> into 1. So only check 'cnt' is not enough, total_size also needs to be
> taked into consideration, othersize bootargs 'mem=[X][G|B]' not work
> anymore.

I believe this is issue is not specific to i.MX but rather this could
happen on any arm64 platform. Can you please update the changelog?
 
> Fixes: e888fa7bb882 ("memblock: Check memory add/cap ordering")
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  mm/memblock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 184dcd2e5d99..ab67b82a9cce 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1687,7 +1687,7 @@ void __init memblock_cap_memory_range(phys_addr_t base, phys_addr_t size)
>  	if (!size)
>  		return;
>  
> -	if (memblock.memory.cnt <= 1) {
> +	if (memblock_memory->cnt <= 1 && !memblock_memory->total_size) {

The test for non-zero total size shold be sufficient here.

>  		pr_warn("%s: No memory registered yet\n", __func__);
>  		return;
>  	}
> -- 
> 2.30.0
> 

-- 
Sincerely yours,
Mike.
