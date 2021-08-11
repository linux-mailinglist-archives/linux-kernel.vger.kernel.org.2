Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA4B3E8999
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 07:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhHKFLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 01:11:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:49298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233813AbhHKFLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 01:11:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5407C60F13;
        Wed, 11 Aug 2021 05:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628658645;
        bh=vtfachGX2HaQKQQ+eKZlQAp5s4358iBlM/gx9iFw89w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJERWMdNw8yHZE+h1TaCX40nXl9dQZAyGGZpl5gu96UEoAWKVdjgejNhWEzy5gLzH
         15qohJQHhwiN54wKVsqipLECWOfF0q6NzoZMx/ZRKUL0vDlq8x6zzwDcxW/p2lwh7L
         WfKEE4ssTF3pnksDYpqK9IVpImgGvI5y7Tt/qbrCZ/U11aQGJm/JsUDYRE2ES2E8M/
         Y69c++lNaezHlR28vjS4gJHLB+NVjIOntCRaWKZm0Am6lXfaGk3Rnuaeprgv2/AoTO
         RGQTO4Sf2jkKietY/D0QLOoynON/zwNW0VFjYIwNp/TIFWslQmgRJLbe8oHRWbAhFi
         jwwC+hTx+1FQw==
Date:   Wed, 11 Aug 2021 08:10:40 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Anshuman Khandual <anshuman.khandual@arm.com>,
        Vineet Gupta <vgupta@kernel.com>
Subject: Re: [PATCH 03/18] ARC: mm: move mmu/cache externs out to setup.h
Message-ID: <YRNb0EbPzejXJdax@kernel.org>
References: <20210811004258.138075-1-vgupta@kernel.org>
 <20210811004258.138075-4-vgupta@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811004258.138075-4-vgupta@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineet,

On Tue, Aug 10, 2021 at 05:42:43PM -0700, Vineet Gupta wrote:
> Signed-off-by: Vineet Gupta <vgupta@kernel.com>

Hmm, this one seems odd. Try https://www.kernel.com/ ;-)

> Signed-off-by: Vineet Gupta <vgupta@kernel.org>
> ---
>  arch/arc/include/asm/cache.h |  4 ----
>  arch/arc/include/asm/mmu.h   |  4 ----
>  arch/arc/include/asm/setup.h | 12 ++++++++++--

A sentence about why these move would have been nice.

>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arc/include/asm/cache.h b/arch/arc/include/asm/cache.h
> index d8ece4292388..f0f1fc5d62b6 100644
> --- a/arch/arc/include/asm/cache.h
> +++ b/arch/arc/include/asm/cache.h
> @@ -62,10 +62,6 @@
>  #define ARCH_SLAB_MINALIGN	8
>  #endif
>  
> -extern void arc_cache_init(void);
> -extern char *arc_cache_mumbojumbo(int cpu_id, char *buf, int len);
> -extern void read_decode_cache_bcr(void);
> -
>  extern int ioc_enable;
>  extern unsigned long perip_base, perip_end;
>  
> diff --git a/arch/arc/include/asm/mmu.h b/arch/arc/include/asm/mmu.h
> index 38a036508699..762cfe66e16b 100644
> --- a/arch/arc/include/asm/mmu.h
> +++ b/arch/arc/include/asm/mmu.h
> @@ -64,10 +64,6 @@ typedef struct {
>  	unsigned long asid[NR_CPUS];	/* 8 bit MMU PID + Generation cycle */
>  } mm_context_t;
>  
> -void arc_mmu_init(void);
> -extern char *arc_mmu_mumbojumbo(int cpu_id, char *buf, int len);
> -void read_decode_mmu_bcr(void);
> -
>  static inline int is_pae40_enabled(void)
>  {
>  	return IS_ENABLED(CONFIG_ARC_HAS_PAE40);
> diff --git a/arch/arc/include/asm/setup.h b/arch/arc/include/asm/setup.h
> index 01f85478170d..028a8cf76206 100644
> --- a/arch/arc/include/asm/setup.h
> +++ b/arch/arc/include/asm/setup.h
> @@ -2,8 +2,8 @@
>  /*
>   * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
>   */
> -#ifndef __ASMARC_SETUP_H
> -#define __ASMARC_SETUP_H
> +#ifndef __ASM_ARC_SETUP_H
> +#define __ASM_ARC_SETUP_H
>  
>  
>  #include <linux/types.h>
> @@ -34,4 +34,12 @@ long __init arc_get_mem_sz(void);
>  #define IS_AVAIL2(v, s, cfg)	IS_AVAIL1(v, s), IS_AVAIL1(v, IS_USED_CFG(cfg))
>  #define IS_AVAIL3(v, v2, s)	IS_AVAIL1(v, s), IS_AVAIL1(v, IS_DISABLED_RUN(v2))
>  
> +extern void arc_mmu_init(void);
> +extern char *arc_mmu_mumbojumbo(int cpu_id, char *buf, int len);
> +extern void read_decode_mmu_bcr(void);
> +
> +extern void arc_cache_init(void);
> +extern char *arc_cache_mumbojumbo(int cpu_id, char *buf, int len);
> +extern void read_decode_cache_bcr(void);
> +
>  #endif /* __ASMARC_SETUP_H */
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
