Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB90241CA08
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 18:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345714AbhI2Q0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 12:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345534AbhI2Q0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:26:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36D3461440;
        Wed, 29 Sep 2021 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632932673;
        bh=w4VJ0cTrcVdnFPOz099Y8UG/uO+ZbS2A3UhOj01R4SI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=boVv8N2dksnZXdTCWUBJUd4AG5QEJsKyjisvpIIvRYNyjyxLOHvLxSS4ZoSFOQB/D
         G+tWMSoaQCgfJ5BABvIP8m6wvc5R/+MTW7PmuM0otR9fKnh1ij6wgXbOCtwWFND66b
         EEwc2vo5okag4C6ZXEbv+6o+1AJ05Y/kmkTqR9mjFX/RzRGoSamKwWFr3E6ifpgHcH
         jY0yzP+ZkMWorb2JjcyaBIHVjt+lR+f7D2chVjxfPnLBHWIOF3OHzB2uKPstckMJPA
         FFl9E0tG2kaHzFoHFVSSsO5Cbfvjzedc17Bu29DLiCMIzZ2R9gOtXankzvRY91cK/3
         R2/C4U1t20AGw==
Date:   Wed, 29 Sep 2021 17:24:28 +0100
From:   Will Deacon <will@kernel.org>
To:     Coiby Xu <coiby.xu@gmail.com>
Cc:     kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        Coiby Xu <coxu@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: kexec_file: use more system keyrings to
 verify kernel image signature
Message-ID: <20210929162428.GG22029@willie-the-truck>
References: <20210927005004.36367-1-coiby.xu@gmail.com>
 <20210927005004.36367-3-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927005004.36367-3-coiby.xu@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 08:50:04AM +0800, Coiby Xu wrote:
> From: Coiby Xu <coxu@redhat.com>
> 
> This allows to verify arm64 kernel image signature using not only
> .builtin_trusted_keys but also .secondary_trusted_keys and .platform keyring.
> 
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  arch/arm64/kernel/kexec_image.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/kexec_image.c b/arch/arm64/kernel/kexec_image.c
> index 9ec34690e255..2357ee2f229a 100644
> --- a/arch/arm64/kernel/kexec_image.c
> +++ b/arch/arm64/kernel/kexec_image.c
> @@ -14,7 +14,6 @@
>  #include <linux/kexec.h>
>  #include <linux/pe.h>
>  #include <linux/string.h>
> -#include <linux/verification.h>
>  #include <asm/byteorder.h>
>  #include <asm/cpufeature.h>
>  #include <asm/image.h>
> @@ -133,8 +132,7 @@ static void *image_load(struct kimage *image,
>  #ifdef CONFIG_KEXEC_IMAGE_VERIFY_SIG
>  static int image_verify_sig(const char *kernel, unsigned long kernel_len)
>  {
> -	return verify_pefile_signature(kernel, kernel_len, NULL,
> -				       VERIFYING_KEXEC_PE_SIGNATURE);
> +	return arch_kexec_kernel_verify_pe_sig(kernel, kernel_len);

I'm fine with this in principle, but it looks like the first patch is the
important one.

So for the arm64 bit:

Acked-by: Will Deacon <will@kernel.org>

Will
