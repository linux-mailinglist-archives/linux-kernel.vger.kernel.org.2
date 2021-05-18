Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3076738818B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352232AbhERUnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:43:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234956AbhERUnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:43:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 567CB61059;
        Tue, 18 May 2021 20:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621370511;
        bh=aIgBwh8ikO9n9G42hk2Its108dIO1H+qNOHk38ZgjLk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aG21jQtYqlcxI5n380BGG/YRCkivqS3rHteMFSS5ekJWaMUDcF5IAbMKzDeehytga
         FwB7699dQbeuqRYyfqFyvb00y2VuuyGg6NCuFfZEi/aFCEKeCgab7Ybpgoxxh2cbZf
         n8stjw/J5+1K9Az7aNdYzi+BboXCFaWT/HzxQohchVrsnIoWGmmSmEjfZD+OaSjrlA
         clV9mNMOQ2IO6Le8Qc5SnzUE2Vr9keWifP6e4jwwiVqyeZnKRqMvpWm4MP0/GqXBTo
         J1YRHO4JvKuvoFaZfvIhFk8xnKT1W4Xw3LDAXYEyRALoVH1S1tpKrHt4UWFtUc1w4M
         888BhJMp9LqHA==
Subject: Re: [PATCH v2] powerpc/powernv/pci: fix header guard
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Oliver O'Halloran <oohall@gmail.com>,
        Joe Perches <joe@perches.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <87cztok1r5.fsf@mpe.ellerman.id.au>
 <20210518204044.2390064-1-ndesaulniers@google.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <4aa06438-7bea-a5a6-ff64-0cf8c28e2511@kernel.org>
Date:   Tue, 18 May 2021 13:41:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518204044.2390064-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/2021 1:40 PM, Nick Desaulniers wrote:
> While looking at -Wundef warnings, the #if CONFIG_EEH stood out as a
> possible candidate to convert to #ifdef CONFIG_EEH.
> 
> It seems that based on Kconfig dependencies it's not possible to build
> this file without CONFIG_EEH enabled, but based on upstream discussion,
> it's not clear yet that CONFIG_EEH should be enabled by default.
> 
> For now, simply fix the -Wundef warning.
> 
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Joe Perches <joe@perches.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/570
> Link: https://lore.kernel.org/lkml/67f6cd269684c9aa8463ff4812c3b4605e6739c3.camel@perches.com/
> Link: https://lore.kernel.org/lkml/CAOSf1CGoN5R0LUrU=Y=UWho1Z_9SLgCX8s3SbFJXwJXc5BYz4A@mail.gmail.com/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Makes sense, thanks for the patch!

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>   arch/powerpc/platforms/powernv/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index b18468dc31ff..6bb3c52633fb 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -711,7 +711,7 @@ int pnv_pci_cfg_write(struct pci_dn *pdn,
>   	return PCIBIOS_SUCCESSFUL;
>   }
>   
> -#if CONFIG_EEH
> +#ifdef CONFIG_EEH
>   static bool pnv_pci_cfg_check(struct pci_dn *pdn)
>   {
>   	struct eeh_dev *edev = NULL;
> 

