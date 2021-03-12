Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696163397C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 20:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbhCLTtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 14:49:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234406AbhCLTsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 14:48:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8E0D64F60;
        Fri, 12 Mar 2021 19:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615578524;
        bh=06Q+laTvyEIwM8UJogI0MOe/s6ThIzqmug9TktetOp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZyTjJSX+2NulmGMgB8PFcpAa2zYURFv8W1YAjfWR0zHEPl32HPTr4M77gqE4+KfU
         3Q3xyWVyfYaG4O97xVQ/WV+VOBDzP1Ar5B+OtFq9u7JnPG4rF5D9FaFfkP5I+8HMHz
         bHE0fXdHUahhLuutI/r17H/TQlU+oVJ2oSXHqpuT8E6aJ8d1rx+WVWhkmtSjgT7zGj
         GdK+YHZp0bUDJrnJLFpZxmi5BRyGEtDfqKALQ6ZjM9ijWtVvjR5fA01HFGk+Us4Q3z
         qPdTVHLbfTSR6OG8H9fI8TJqprbvNu6rbnf2KYlbvhVffh1y1f7thKKUgS7U+HFzLk
         dwmGzr9PMFdvg==
Date:   Fri, 12 Mar 2021 21:48:38 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove default DISCONTIGMEM_MANUAL
Message-ID: <YEvFluStWt575u/G@kernel.org>
References: <20210312141208.3465520-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312141208.3465520-1-geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Geert,

On Fri, Mar 12, 2021 at 03:12:08PM +0100, Geert Uytterhoeven wrote:
> Commit 214496cb18700fd7 ("ia64: make SPARSEMEM default and disable
> DISCONTIGMEM") removed the last enabler of ARCH_DISCONTIGMEM_DEFAULT,
> hence the memory model can no longer default to DISCONTIGMEM_MANUAL.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> DISCONTIGMEM_MANUAL depends on ARCH_DISCONTIGMEM_ENABLE, which in turns
> depends on BROKEN, so probably all discontig memory support can be
> removed, too?

I'm planning to remove DISCONTIGMEM entirely after 2 or 3 releases to let
the dust settle a bit after the last users of DISCONTIGMEM were switched to
other memory models.

> ---
>  mm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 24c045b24b95069b..579254f10fb1bac6 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -9,7 +9,6 @@ config SELECT_MEMORY_MODEL
>  choice
>  	prompt "Memory model"
>  	depends on SELECT_MEMORY_MODEL
> -	default DISCONTIGMEM_MANUAL if ARCH_DISCONTIGMEM_DEFAULT
>  	default SPARSEMEM_MANUAL if ARCH_SPARSEMEM_DEFAULT
>  	default FLATMEM_MANUAL
>  	help
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
