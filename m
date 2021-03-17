Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A246E33E8C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 06:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhCQFKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 01:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhCQFJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 01:09:59 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97A0C06174A;
        Tue, 16 Mar 2021 22:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=m8QVdcQPSVPQdZIbGrnzI9bE2kW8lDZNxbGvXWKwhjI=; b=fNdmK/oca0pT9+hz1gN/sVAugw
        xz1+yOCwkzAZdkEuhHfazwit7b/o5ADyHSj/yfv41z3r/eSJFEeJKAnfHCa9Gt39sbThsT5CX+xls
        PMm80Ys8LqbPorBr3vV8UyinT1N7IUgx61GgqojjQDDMEWsXgd7gRBi4Ss6ww1AoA+r9mQmWgG39C
        mXsxkE1x0K2k51qCAdhlt+PnK0mDLLKZzbRwCAzbFj1Rq+TD6m6+sa+jjSE5+zpqVYyIrsl9q8BOU
        a/WSHx/A8IcfOQSDupwC3nQLuIEWqTqlqd04ANy9stF0ksIaTDEBGipffNbholINqQPMkuOEwB6Bd
        Tp9hRXAg==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lMORQ-001bS9-5o; Wed, 17 Mar 2021 05:09:56 +0000
Subject: Re: [PATCH] ia64: hp: common: A typo fix in the file sba_iommu.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mpe@ellerman.id.au,
        huawei@kernel.org, schnelle@linux.ibm.com, nicoleotsuka@gmail.com,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210317031420.3136958-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <41387595-f4d0-40a5-93ff-6f8cc7797dc5@infradead.org>
Date:   Tue, 16 Mar 2021 22:09:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317031420.3136958-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/21 8:14 PM, Bhaskar Chowdhury wrote:
> 
> 
> s/minium/minimum/
> 
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/ia64/hp/common/sba_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/ia64/hp/common/sba_iommu.c b/arch/ia64/hp/common/sba_iommu.c
> index 9148ddbf02e5..3dcb8c35faad 100644
> --- a/arch/ia64/hp/common/sba_iommu.c
> +++ b/arch/ia64/hp/common/sba_iommu.c
> @@ -828,7 +828,7 @@ mark_clean (void *addr, size_t size)
>   * corresponding IO TLB entry. The PCOM (Purge Command Register)
>   * is to purge stale entries in the IO TLB when unmapping entries.
>   *
> - * The PCOM register supports purging of multiple pages, with a minium
> + * The PCOM register supports purging of multiple pages, with a minimum
>   * of 1 page and a maximum of 2GB. Hardware requires the address be
>   * aligned to the size of the range being purged. The size of the range
>   * must be a power of 2. The "Cool perf optimization" in the
> --


-- 
~Randy

