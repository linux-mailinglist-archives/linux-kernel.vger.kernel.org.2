Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF21D43F290
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 00:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhJ1WTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 18:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhJ1WTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 18:19:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745E0C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=20Ez0uRb5n6BpCOe3+lCGZyRkcnhbgFabAKkBjIKcSg=; b=R5xViDxnCtoCzVKFG3mUZWugsZ
        mUaUwk+A8/a8O7MGs5lx6oottmKnxqKu9n56dc17r7bvqm1Oz3FVZ8W7cQt40jDmSGNcxmXZNefXC
        O90EuE2GjUOuFoQA72yFctZ2hbWfZFWSoYugBmhtYn+1mDNKdZ6F8OkcwqNSEdcfENrQGwb2R8Y1i
        K4Y0wA33h2c4dyY66oH0HOANe2NRTb02xq0a0PKVKmNKqyVH87nnrmYcFz6A0iiDvL+tyftqH/ENW
        5m+2XMvvf71dnLvoKaI04d3diVGm+soo6vT4EpmtEXuyJcT/I2nBrEJJjdrzFeYGry0/6gfN9XPu6
        GrCAmhIg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgDhO-009EWW-8I; Thu, 28 Oct 2021 22:16:38 +0000
Subject: Re: [PATCH linux-next] include/linux/zstd.h: Fix spelling errors in
 comments
To:     luo penghao <cgel.zte@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>
References: <20211028072202.12532-1-luo.penghao@zte.com.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6aa1b6e4-55bf-8cb8-f6c0-b4143ca21307@infradead.org>
Date:   Thu, 28 Oct 2021 15:16:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028072202.12532-1-luo.penghao@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/21 12:22 AM, luo penghao wrote:
> It’s just a small problem. Although it doesn’t affect reading,
> it seems that it should be revised.

Hi,

Probably related to this:

https://en.wikipedia.org/wiki/If_and_only_if


> Reported-by: luo penghao <luo.penghao@zte.com.cn>
> Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
> ---
>   include/linux/zstd.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/zstd.h b/include/linux/zstd.h
> index e87f78c..a093e18 100644
> --- a/include/linux/zstd.h
> +++ b/include/linux/zstd.h
> @@ -90,7 +90,7 @@ size_t ZSTD_compressBound(size_t srcSize);
>    * ZSTD_isError() - tells if a size_t function result is an error code
>    * @code:  The function result to check for error.
>    *
> - * Return: Non-zero iff the code is an error.
> + * Return: Non-zero if the code is an error.
>    */
>   static __attribute__((unused)) unsigned int ZSTD_isError(size_t code)
>   {
> 


-- 
~Randy
