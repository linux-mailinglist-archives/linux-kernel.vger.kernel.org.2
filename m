Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABAE453C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhKPXPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 18:15:25 -0500
Received: from foss.arm.com ([217.140.110.172]:50330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhKPXPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 18:15:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 728FA6D;
        Tue, 16 Nov 2021 15:12:26 -0800 (PST)
Received: from [10.57.82.45] (unknown [10.57.82.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E97C63F766;
        Tue, 16 Nov 2021 15:12:24 -0800 (PST)
Message-ID: <7096e4d4-d27a-42f5-34d0-11ce7156a8f1@arm.com>
Date:   Tue, 16 Nov 2021 23:12:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] arm64: clear_page: use stnp non-temporal instruction for
 performance optimizing
Content-Language: en-GB
To:     Guanghui Feng <guanghuifeng@linux.alibaba.com>,
        catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        qperret@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        zhangliguang@linux.alibaba.com
References: <1637075294-30747-1-git-send-email-guanghuifeng@linux.alibaba.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1637075294-30747-1-git-send-email-guanghuifeng@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-16 15:08, Guanghui Feng wrote:
> When clear page mem, there is no need to alloc cache for storing these
> mem value. And the copy_page.S have used stnp instruction for optimizing.
> So I rewrite the clear_page.S with stnp. At the same time, I have tested it
> with stnp instruction which will get about twice the performance improvement.
> 
> Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
> ---
>   arch/arm64/lib/clear_page.S | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/lib/clear_page.S b/arch/arm64/lib/clear_page.S
> index b84b179..e9dc2d6 100644
> --- a/arch/arm64/lib/clear_page.S
> +++ b/arch/arm64/lib/clear_page.S
> @@ -15,13 +15,18 @@
>    *	x0 - dest
>    */
>   SYM_FUNC_START_PI(clear_page)
> -	mrs	x1, dczid_el0
> -	and	w1, w1, #0xf
> -	mov	x2, #4
> -	lsl	x1, x2, x1
> -
> -1:	dc	zva, x0
> -	add	x0, x0, x1
> +	mov	x1, #0
> +	mov	x2, #0

Regardless of the bigger question around the architectural intent that 
DC ZVA is supposed to be the best way to clear memory (sanity check: 
this wasn't under virtualisation with HCR_EL2.TDZ set, was it?) - out of 
curiosity, why do this and not just "stnp xzr, xzr, ..."?

Note also that this is liable to conflict with the patch for respecting 
DCZID_EL0.DZP. On which note, is DC {GVA,GZVA} performance also a 
concern, or does your platform not have MTE? If the performance anomaly 
does turn out to be platform-specific, maybe it might be better to quirk 
those platforms to set DZP, rather than changing the code for everyone?

Robin.

> +1:
> +	stnp	x1, x2, [x0]
> +	stnp	x1, x2, [x0, #16]
> +	stnp	x1, x2, [x0, #32]
> +	stnp	x1, x2, [x0, #48]
> +	stnp	x1, x2, [x0, #64]
> +	stnp	x1, x2, [x0, #80]
> +	stnp	x1, x2, [x0, #96]
> +	stnp	x1, x2, [x0, #112]
> +	add	x0, x0, #128
>   	tst	x0, #(PAGE_SIZE - 1)
>   	b.ne	1b
>   	ret
> 
