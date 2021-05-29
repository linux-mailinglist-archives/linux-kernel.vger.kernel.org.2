Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B54E394E78
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 01:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhE2XJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 19:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhE2XJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 19:09:55 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CF0C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 16:08:18 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t21so3367078plo.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 16:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=qss0x+5sHCW7H4avOnfrc4/iwaDvuVYHTQ7IXox97jI=;
        b=FwnxWJLhicCZPG6FDqH6ssQblDovkkGj63nfCN2c9eZ0cVUk2N4D5mIYhjEPJKjVfW
         NqXBY8uuErmw/KEKK+/+bx/UGMmhonkcTlT5+Hd4fBSjtzzhyAyIS/cK3f0Ctm0A04mI
         vuMman8k2T1QvcXXZGM3wsXAPEPmTwnPaC/7OIyBzY4TXCsR00+sbQkTrVKDFCunq64x
         AcQe2B4lrAaQhCj0L8xaG7DVGaoqKGw9DXaYRNARQxlwbNXMBO1wgDyKqjixfwzU3eQf
         PsytkA6CSCuDrWeWYkhaUtPnNJK1PJ4iozQ7a1nm1OPL6+zHY/URtWXfDmAaJPDsA3ld
         cavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qss0x+5sHCW7H4avOnfrc4/iwaDvuVYHTQ7IXox97jI=;
        b=MlpDAybJXixCbCaUqQAFBdcZqOQ9c9eHRgb7xuQsWamQSVsGpj8s4eQ4KWngeEvEVS
         MP3dlIJoYNXEldHraaAUrYgNF1+BeFvHmzvHjlBAFaBJ9ihBrE6lxVvGmwaHnOF+e4E9
         p/gGWM6iqgaFG0kgFtOTYdaPPtx8qhbQiGOUXS3c+oQzALdyTJyr5cFt2NaxOrmdIdUa
         OsDN6qD1FYOLk7aERamYJqOamKxrxZR5E4Epd7/VUAbyqUt1Vwt9Wcx4jltG8+TH6eDq
         nPYLfpWIorfejuqL+nZ3dL/rLbZ+8EsljqTC5X3cLMSY1EWEfse3hVMWxS0CUuv13jZA
         63ow==
X-Gm-Message-State: AOAM5329Cp0q0wBqH/o4dhLVAttz21e/E9KS4aGUu+8nZy1oP3fkN3Yr
        lq1g/yBCE5AjueNindXuUQD8dQ==
X-Google-Smtp-Source: ABdhPJzrWRNEm5ifiRm0JTVwjK2OCpXjOulal+R0YAqOyyJ2AkYsuIY448mYbv2VRTVX+ccVnODgsA==
X-Received: by 2002:a17:902:ab95:b029:ee:f899:6fe8 with SMTP id f21-20020a170902ab95b02900eef8996fe8mr13937488plr.81.1622329697639;
        Sat, 29 May 2021 16:08:17 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i16sm7281143pji.30.2021.05.29.16.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 16:08:17 -0700 (PDT)
Date:   Sat, 29 May 2021 16:08:17 -0700 (PDT)
X-Google-Original-Date: Sat, 29 May 2021 16:07:41 PDT (-0700)
Subject:     Re: [PATCH] arch: Cleanup unused functions
In-Reply-To: <1621945234-37878-1-git-send-email-guoren@kernel.org>
CC:     guoren@kernel.org, Anup Patel <Anup.Patel@wdc.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        guoren@linux.alibaba.com, monstr@monstr.eu
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-93a12abf-0283-4ec3-a521-89b8d882654f@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021 05:20:34 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> These functions haven't been used, so just remove them. The patch
> has been tested with riscv, but I only use grep to check the
> microblaze's.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Christoph Hellwig <hch@lst.de>
> ---
>  arch/microblaze/include/asm/page.h |  3 ---
>  arch/riscv/include/asm/page.h      | 10 ----------
>  2 files changed, 13 deletions(-)
>
> diff --git a/arch/microblaze/include/asm/page.h b/arch/microblaze/include/asm/page.h
> index bf681f2..ce55097 100644
> --- a/arch/microblaze/include/asm/page.h
> +++ b/arch/microblaze/include/asm/page.h
> @@ -35,9 +35,6 @@
>
>  #define ARCH_SLAB_MINALIGN	L1_CACHE_BYTES
>
> -#define PAGE_UP(addr)	(((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
> -#define PAGE_DOWN(addr)	((addr)&(~((PAGE_SIZE)-1)))
> -
>  /*
>   * PAGE_OFFSET -- the first address of the first page of memory. With MMU
>   * it is set to the kernel start address (aligned on a page boundary).
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 6a7761c..a1b888f 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -37,16 +37,6 @@
>
>  #ifndef __ASSEMBLY__
>
> -#define PAGE_UP(addr)	(((addr)+((PAGE_SIZE)-1))&(~((PAGE_SIZE)-1)))
> -#define PAGE_DOWN(addr)	((addr)&(~((PAGE_SIZE)-1)))
> -
> -/* align addr on a size boundary - adjust address up/down if needed */
> -#define _ALIGN_UP(addr, size)	(((addr)+((size)-1))&(~((size)-1)))
> -#define _ALIGN_DOWN(addr, size)	((addr)&(~((size)-1)))
> -
> -/* align addr on a size boundary - adjust address up if needed */
> -#define _ALIGN(addr, size)	_ALIGN_UP(addr, size)
> -
>  #define clear_page(pgaddr)			memset((pgaddr), 0, PAGE_SIZE)
>  #define copy_page(to, from)			memcpy((to), (from), PAGE_SIZE)

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

It's generally easier if you split this sort of stuff up, as it'll be 
easier to merge if we don't have to coordinate between the trees.  I'm 
happy to take this, but I'd prefer an Ack from one of the microblaze 
folks first.
