Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4143E3171CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 21:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhBJU7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 15:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhBJU7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 15:59:17 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148ECC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 12:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=0ms0vRESu8Bcv/sTPxLl8Qf1dWGUSO1Esx/tp2a3D2M=; b=nwOVo08sh1d4Mxb7zQIbuHbpFG
        ZXcHiTfEsofJpK2P/c40W+sOaW16CEHohMDQ0aXFf4+JHPLriwuUcfGDgzQaauCVL4vO06NY4QOpL
        1FnI3ZJW1w9UzbgDxsWNsJmz9OwBrid30eWYxbPmNTTh1/PAsKfwAg13egidO/hFgpN8Pr8Vm2/Xk
        UKZqxvLzwNW/D9TlUremjMvjtOuZhv6St89QC+n3u2gisnCvM9F3XEkPzUxjUfXVNp5rR41mFGhLh
        lGOYNS4m0a8uGkvw4yy1Tb83NBqZQsxARZvKWW6mz9ByG1aO1FVuaPp66d8Pldwr5h7K4HXWAR/rw
        0HGwJIAg==;
Received: from [2601:1c0:6280:3f0::cf3b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l9wZG-0004Ku-VT; Wed, 10 Feb 2021 20:58:35 +0000
Subject: Re: [PATCH] include: uapi: linux: Fix the spelling simulatneous to
 simultaneous in the file capi.h
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20210209141445.3927167-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e1c73570-3734-5548-cbf2-63bf58a9a40f@infradead.org>
Date:   Wed, 10 Feb 2021 12:58:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210209141445.3927167-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/21 6:14 AM, Bhaskar Chowdhury wrote:
> 
> s/simulatneous/simultaneous/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

but you need to Cc: a maintainer who can merge this.

> ---
>  include/uapi/linux/capi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/capi.h b/include/uapi/linux/capi.h
> index 31f946f8a88d..4dcdb628d98b 100644
> --- a/include/uapi/linux/capi.h
> +++ b/include/uapi/linux/capi.h
> @@ -24,7 +24,7 @@
>   */
> 
>  typedef struct capi_register_params {	/* CAPI_REGISTER */
> -	__u32 level3cnt;	/* No. of simulatneous user data connections */
> +	__u32 level3cnt;	/* No. of simultaneous user data connections */
>  	__u32 datablkcnt;	/* No. of buffered data messages */
>  	__u32 datablklen;	/* Size of buffered data messages */
>  } capi_register_params;
> --


-- 
~Randy

