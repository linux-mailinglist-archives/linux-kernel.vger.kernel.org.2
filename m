Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B82345DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbhCWMJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:09:43 -0400
Received: from foss.arm.com ([217.140.110.172]:45298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231297AbhCWMI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:08:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1D84D6E;
        Tue, 23 Mar 2021 05:08:58 -0700 (PDT)
Received: from [10.57.50.37] (unknown [10.57.50.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4F683F719;
        Tue, 23 Mar 2021 05:08:57 -0700 (PDT)
Subject: Re: [PATCH 2/3] arm64: lib: improve copy performance when size is ge
 128 bytes
To:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, guohanjun@huawei.com
References: <20210323073432.3422227-1-yangyingliang@huawei.com>
 <20210323073432.3422227-3-yangyingliang@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <03ac41af-c433-cd66-8195-afbf9c49554c@arm.com>
Date:   Tue, 23 Mar 2021 12:08:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210323073432.3422227-3-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-23 07:34, Yang Yingliang wrote:
> When copy over 128 bytes, src/dst is added after
> each ldp/stp instruction, it will cost more time.
> To improve this, we only add src/dst after load
> or store 64 bytes.

This breaks the required behaviour for copy_*_user(), since the fault 
handler expects the base address to be up-to-date at all times. Say 
you're copying 128 bytes and fault on the 4th store, it should return 80 
bytes not copied; the code below would return 128 bytes not copied, even 
though 48 bytes have actually been written to the destination.

We've had a couple of tries at updating this code (because the whole 
template is frankly a bit terrible, and a long way from the 
well-optimised code it was derived from), but getting the fault-handling 
behaviour right without making the handler itself ludicrously complex 
has proven tricky. And then it got bumped down the priority list while 
the uaccess behaviour in general was in flux - now that the dust has 
largely settled on that I should probably try to find time to pick this 
up again...

Robin.

> Copy 4096 bytes cost on Kunpeng920 (ms):
> Without this patch:
> memcpy: 143.85 copy_from_user: 172.69 copy_to_user: 199.23
> 
> With this patch:
> memcpy: 107.12 copy_from_user: 157.50 copy_to_user: 198.85
> 
> It's about 25% improvement in memcpy().
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   arch/arm64/lib/copy_template.S | 36 +++++++++++++++++++---------------
>   1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/lib/copy_template.S b/arch/arm64/lib/copy_template.S
> index 488df234c49a..c3cd6f84c9c0 100644
> --- a/arch/arm64/lib/copy_template.S
> +++ b/arch/arm64/lib/copy_template.S
> @@ -152,29 +152,33 @@ D_h	.req	x14
>   	.p2align	L1_CACHE_SHIFT
>   .Lcpy_body_large:
>   	/* pre-get 64 bytes data. */
> -	ldp1	A_l, A_h, src, #16
> -	ldp1	B_l, B_h, src, #16
> -	ldp1	C_l, C_h, src, #16
> -	ldp1	D_l, D_h, src, #16
> +	ldp2	A_l, A_h, src, #0,  #8
> +	ldp2	B_l, B_h, src, #16, #24
> +	ldp2	C_l, C_h, src, #32, #40
> +	ldp2	D_l, D_h, src, #48, #56
> +	add	src, src, #64
>   1:
>   	/*
>   	* interlace the load of next 64 bytes data block with store of the last
>   	* loaded 64 bytes data.
>   	*/
> -	stp1	A_l, A_h, dst, #16
> -	ldp1	A_l, A_h, src, #16
> -	stp1	B_l, B_h, dst, #16
> -	ldp1	B_l, B_h, src, #16
> -	stp1	C_l, C_h, dst, #16
> -	ldp1	C_l, C_h, src, #16
> -	stp1	D_l, D_h, dst, #16
> -	ldp1	D_l, D_h, src, #16
> +	stp2	A_l, A_h, dst, #0,  #8
> +	ldp2	A_l, A_h, src, #0,  #8
> +	stp2	B_l, B_h, dst, #16, #24
> +	ldp2	B_l, B_h, src, #16, #24
> +	stp2	C_l, C_h, dst, #32, #40
> +	ldp2	C_l, C_h, src, #32, #40
> +	stp2	D_l, D_h, dst, #48, #56
> +	ldp2	D_l, D_h, src, #48, #56
> +	add	src, src, #64
> +	add	dst, dst, #64
>   	subs	count, count, #64
>   	b.ge	1b
> -	stp1	A_l, A_h, dst, #16
> -	stp1	B_l, B_h, dst, #16
> -	stp1	C_l, C_h, dst, #16
> -	stp1	D_l, D_h, dst, #16
> +	stp2	A_l, A_h, dst, #0,  #8
> +	stp2	B_l, B_h, dst, #16, #24
> +	stp2	C_l, C_h, dst, #32, #40
> +	stp2	D_l, D_h, dst, #48, #56
> +	add	dst, dst, #64
>   
>   	tst	count, #0x3f
>   	b.ne	.Ltail63
> 
