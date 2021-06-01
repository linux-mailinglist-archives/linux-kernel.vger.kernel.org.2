Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1845397A0B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbhFASZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbhFASZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:25:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6DFC061756
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=WfOZ3V4g32hQLYqNuwJoe94mFBVb+pU0gP/kIfMcj9g=; b=ZoGweOhZ9tfQrf19aa/HAUPCia
        n6FD1kVghUyoQsoLLxULd0NC+hTJmOiLW9jnN6W7LGV9wWrGziFIwQUu0RE0pVyth/XyE3O28LvhU
        z9/BpbFw2Y7NwbkfmH+4FzyYQHDGlwoDovJ1/MWy8Ngy/wCOcF4RK9T/bleTJaFNFnH9Gb2X1jPEK
        +346FdCwGRAwkuq6Wc+eHDS2uxUWgsp0DnMYAp18o0WfUzqMwFrpfz41bpSNRM0ekF977gsupv1Ai
        kldZpzn2rPcs2zZIdAzTuw1dWz4C0TEwR61uH509kGyVCsIxAzv2jrTUZJl2DqwFpTmalk6Q1bTAL
        WcPMaBMA==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lo93k-000LKT-DM; Tue, 01 Jun 2021 18:24:12 +0000
Subject: Re: [PATCH -next] lib: crc64: Fix kernel-doc warning
To:     YueHaibing <yuehaibing@huawei.com>, colyli@suse.de,
        akpm@linux-foundation.org, grandmaster@al2klimov.de
Cc:     linux-kernel@vger.kernel.org
References: <20210601135851.15444-1-yuehaibing@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <68b5af53-d4c3-b5cd-8c2b-1d306d1fdb07@infradead.org>
Date:   Tue, 1 Jun 2021 11:24:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210601135851.15444-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/21 6:58 AM, YueHaibing wrote:
> Fix W=1 kernel build warning:
> 
> lib/crc64.c:40: warning:
>  bad line:         or the previous crc64 value if computing incrementally.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>


Thanks.

> ---
>  lib/crc64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/crc64.c b/lib/crc64.c
> index 47cfa054827f..9f852a89ee2a 100644
> --- a/lib/crc64.c
> +++ b/lib/crc64.c
> @@ -37,7 +37,7 @@ MODULE_LICENSE("GPL v2");
>  /**
>   * crc64_be - Calculate bitwise big-endian ECMA-182 CRC64
>   * @crc: seed value for computation. 0 or (u64)~0 for a new CRC calculation,
> -	or the previous crc64 value if computing incrementally.
> + *       or the previous crc64 value if computing incrementally.
>   * @p: pointer to buffer over which CRC64 is run
>   * @len: length of buffer @p
>   */
> 


-- 
~Randy
