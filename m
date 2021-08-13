Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3203EB5F5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 15:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240599AbhHMNIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 09:08:55 -0400
Received: from foss.arm.com ([217.140.110.172]:53478 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240565AbhHMNIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 09:08:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 038001042;
        Fri, 13 Aug 2021 06:08:27 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6204E3F718;
        Fri, 13 Aug 2021 06:08:25 -0700 (PDT)
Subject: Re: [PATCH 2/5] arm64: Handle UNDEF in the EL2 stub vectors
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
References: <20210812190213.2601506-1-maz@kernel.org>
 <20210812190213.2601506-3-maz@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <2f6bf17f-d235-8311-13d5-dcb3d00e23c4@arm.com>
Date:   Fri, 13 Aug 2021 14:08:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210812190213.2601506-3-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-12 20:02, Marc Zyngier wrote:
> As we want to handle the silly case where HVC has been disabled
> from EL3, augment our ability to handle exception at EL2.
> 
> Check for unknown exceptions (usually UNDEF) coming from EL2,
> and treat them as a failing HVC call into the stubs. While
> this isn't great and obviously doesn't catter for the gigantic
> range of possible exceptions, it isn't any worse than what we
> have today.
> 
> Just don't try and use it for anything else.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>   arch/arm64/kernel/hyp-stub.S | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
> index 43d212618834..026a34515b21 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -46,7 +46,16 @@ SYM_CODE_END(__hyp_stub_vectors)
>   	.align 11
>   
>   SYM_CODE_START_LOCAL(elx_sync)
> -	cmp	x0, #HVC_SET_VECTORS
> +	mrs	x4, spsr_el2
> +	and	x4, x4, #PSR_MODE_MASK
> +	orr	x4, x4, #1
> +	cmp	x4, #PSR_MODE_EL2h
> +	b.ne	0f
> +	mrs	x4, esr_el2
> +	eor	x4, x4, #ESR_ELx_IL
> +	cbz	x4, el2_undef

Hmm, might it be neater to check ESR_EL2.ISS to see if we landed here 
for any reason *other* than a successfully-executed HVC?

Robin.

> +
> +0:	cmp	x0, #HVC_SET_VECTORS
>   	b.ne	1f
>   	msr	vbar_el2, x1
>   	b	9f
> @@ -71,6 +80,14 @@ SYM_CODE_START_LOCAL(elx_sync)
>   
>   9:	mov	x0, xzr
>   	eret
> +
> +el2_undef:
> +	// Assumes this was a HVC that went really wrong...
> +	mrs	x0, elr_el2
> +	add	x0, x0, #4
> +	msr	elr_el2, x0
> +	mov_q	x0, HVC_STUB_ERR
> +	eret
>   SYM_CODE_END(elx_sync)
>   
>   // nVHE? No way! Give me the real thing!
> 
