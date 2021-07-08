Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F153BFA4A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhGHMgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229862AbhGHMgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:36:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D60CC61424;
        Thu,  8 Jul 2021 12:33:24 +0000 (UTC)
Subject: Re: [PATCH] m68k/nommu: prevent setting ROMKERNEL when ROM is not set
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     linux-m68k@lists.linux-m68k.org, uclinux-dev@uclinux.org
References: <20210707163729.30388-1-rdunlap@infradead.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <a429671e-927e-e5c8-cc33-ab4310446792@linux-m68k.org>
Date:   Thu, 8 Jul 2021 22:33:22 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707163729.30388-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 8/7/21 2:37 am, Randy Dunlap wrote:
> When CONFIG_ROMKERNEL is set but CONFIG_ROM is not set, the linker
> complains:
>    m68k-linux-ld:./arch/m68k/kernel/vmlinux.lds:5: undefined symbol `CONFIG_ROMSTART' referenced in expression
> 
> # CONFIG_ROM is not set
> # CONFIG_RAMKERNEL is not set
> CONFIG_ROMKERNEL=y
> 
> Since ROMSTART depends on ROM, make ROMKERNEL also depend on ROM.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Greg Ungerer <gerg@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: uclinux-dev@uclinux.org

Looks good, thanks.
I will apply to for-next branch of m68knommu git tree when the current
merge window closes.

Regards
Greg


> ---
>   arch/m68k/Kconfig.machine |    1 +
>   1 file changed, 1 insertion(+)
> 
> --- linux-next-20210701.orig/arch/m68k/Kconfig.machine
> +++ linux-next-20210701/arch/m68k/Kconfig.machine
> @@ -464,6 +464,7 @@ config RAMKERNEL
>   
>   config ROMKERNEL
>   	bool "ROM"
> +	depends on ROM
>   	help
>   	  The kernel will be resident in FLASH/ROM when running. This is
>   	  often referred to as Execute-in-Place (XIP), since the kernel
> 
