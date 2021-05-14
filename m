Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099AC380F37
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 19:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbhENRtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 13:49:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhENRtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 13:49:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAC55613EC;
        Fri, 14 May 2021 17:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621014504;
        bh=a2Lf/s9pS2AbNJ05MvIWyGXG/TI/DKSvCkpHiv0i2Oo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GR4deiUKmR3hcwLhTbJZMLVSJw5ACynGwuXnVCEI/+gZ/Hpo0k5+g5m8WNIhfGX1S
         TjRcCC9I2qx8F6rvIy9hgHuMQgsmtGVjTobx9zBM8E4GTxe4JsfFMYC8GGJN61GzEv
         KiCk5INxFn8KUHihlZaq1dQYvsURZ6XA/Xe4PLdiJYrenBI79VKl7meePcvHxjnOxP
         fHM2UKv17p2lRlCElTRGm/WqhwttWF0YgJ5K6h7Ugx9XOBqM2Wk+TpRIJmRLlvZ2S8
         71/vdgJuAyGI2bBSMloBvzYkafUl2wLKe2PGymvvRAbEsqZD3lPgJO4IiuOmzH5Bu3
         I9yqqvOyCb9Dw==
Subject: Re: [PATCH] mm/shuffle: fix section mismatch warning
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20210514135952.2928094-1-arnd@kernel.org>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <1904893e-1e7f-b1a4-454c-6999f8ac670a@kernel.org>
Date:   Fri, 14 May 2021 10:48:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514135952.2928094-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/2021 6:59 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang sometimes decides not to inline shuffle_zone(), but it calls
> a __meminit function. Without the extra __meminit annotation we get
> this warning:
> 
> WARNING: modpost: vmlinux.o(.text+0x2a86d4): Section mismatch in reference from the function shuffle_zone() to the function .meminit.text:__shuffle_zone()
> The function shuffle_zone() references
> the function __meminit __shuffle_zone().
> This is often because shuffle_zone lacks a __meminit
> annotation or the annotation of __shuffle_zone is wrong.
> 
> shuffle_free_memory() did not show the same problem in my tests, but
> it could happen in theory as well, so mark both as __meminit.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>   mm/shuffle.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/shuffle.h b/mm/shuffle.h
> index 71b784f0b7c3..cec62984f7d3 100644
> --- a/mm/shuffle.h
> +++ b/mm/shuffle.h
> @@ -10,7 +10,7 @@
>   DECLARE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
>   extern void __shuffle_free_memory(pg_data_t *pgdat);
>   extern bool shuffle_pick_tail(void);
> -static inline void shuffle_free_memory(pg_data_t *pgdat)
> +static inline void __meminit shuffle_free_memory(pg_data_t *pgdat)
>   {
>   	if (!static_branch_unlikely(&page_alloc_shuffle_key))
>   		return;
> @@ -18,7 +18,7 @@ static inline void shuffle_free_memory(pg_data_t *pgdat)
>   }
>   
>   extern void __shuffle_zone(struct zone *z);
> -static inline void shuffle_zone(struct zone *z)
> +static inline void __meminit shuffle_zone(struct zone *z)
>   {
>   	if (!static_branch_unlikely(&page_alloc_shuffle_key))
>   		return;
> 

