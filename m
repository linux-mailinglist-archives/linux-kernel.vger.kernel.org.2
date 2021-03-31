Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384BD349FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 03:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhCZCjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 22:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhCZCja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 22:39:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D326C06174A;
        Thu, 25 Mar 2021 19:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=dRDn89/WfNNhjgMswmG9icK/GBvlAj2Xt5rE/IZtB3k=; b=jAoQrdbzbAdiFLAVsu4NhKvJme
        ISVMkHR7GaJte0cpTZfRsPEQhhoGiYBFCeg2YfSKhAsAvUN1Oe3JXX+qwu3iG0PA7BUwN4iyD4shF
        Cy1ymqg44EBlcxk2S86kPdZvADSnjJFL1iYB136XlBBtigWlnBvO4F4O+w3wQkRSP8N4G352weYMm
        2BSRIhYVSaHVKehSFxTdVThXfmkXPRlf4CYrLBNqgb/5gLBF2D4m/fQgEUEa+qjB8Y2uxkQMxB1ZF
        dgkf/KJIhrhYTH3KWlVxcSPLd8jNmYSq5UvbgobpClMeVk/BfBdljWE5g6j2XXH5b54jSP8/26UDu
        bV+UffFg==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPcNh-002dcA-OR; Fri, 26 Mar 2021 02:39:26 +0000
Subject: Re: [PATCH] crypto: async_tx/async_xor.c: Few mundane spello fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        dan.j.williams@intel.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, songliubraving@fb.com, yuyufen@huawei.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210326023406.11091-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7ffc3231-eaae-59d4-1d2c-7aaf1331a79b@infradead.org>
Date:   Thu, 25 Mar 2021 19:39:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210326023406.11091-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/21 7:34 PM, Bhaskar Chowdhury wrote:
> 
> s/eninges/engines/  ...two different places.
> s/explicity/explicitly/  ....two different places.
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  crypto/async_tx/async_xor.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/crypto/async_tx/async_xor.c b/crypto/async_tx/async_xor.c
> index a057ecb1288d..fee33f76cdd9 100644
> --- a/crypto/async_tx/async_xor.c
> +++ b/crypto/async_tx/async_xor.c
> @@ -170,8 +170,8 @@ dma_xor_aligned_offsets(struct dma_device *device, unsigned int offset,
>   *
>   * xor_blocks always uses the dest as a source so the
>   * ASYNC_TX_XOR_ZERO_DST flag must be set to not include dest data in
> - * the calculation.  The assumption with dma eninges is that they only
> - * use the destination buffer as a source when it is explicity specified
> + * the calculation.  The assumption with dma engines is that they only
> + * use the destination buffer as a source when it is explicitly specified
>   * in the source list.
>   *
>   * src_list note: if the dest is also a source it must be at index zero.
> @@ -259,8 +259,8 @@ EXPORT_SYMBOL_GPL(async_xor_offs);
>   *
>   * xor_blocks always uses the dest as a source so the
>   * ASYNC_TX_XOR_ZERO_DST flag must be set to not include dest data in
> - * the calculation.  The assumption with dma eninges is that they only
> - * use the destination buffer as a source when it is explicity specified
> + * the calculation.  The assumption with dma engines is that they only
> + * use the destination buffer as a source when it is explicitly specified
>   * in the source list.
>   *
>   * src_list note: if the dest is also a source it must be at index zero.
> --


-- 
~Randy

