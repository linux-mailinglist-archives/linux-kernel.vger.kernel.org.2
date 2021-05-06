Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3050374FE1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhEFHRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhEFHRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:17:22 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FACC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 00:16:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h7so2931965plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 00:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Dp5soMSHrCjUpZswZvxQlzWraT5prbwHNht9WSOKHdU=;
        b=UFK3IbmDg+TWOLSAgVrbm5DhgEgM4inla9cyzlq/T/wP5lRwdv+191Zfud9XfYFQra
         BXDcGXz9eX82HAu0kaQPDs4vnpXGu9B8uxEKgHFdS12DjnOPG++NF3Q1ycGRSlJVM5Pd
         Mfl3X1JjT9ftj7ARx2JqSvmGY1KJ6HbqIW4O0MQuCmeNmgIPUd7ALViS9lBsgHWwnmoK
         S579n0j5Z2pdbnnQ9zkjOc/8YhsvZNrUUrUa+n9JfU5OGo4gkciL1jQoN9PNHXy1hP7T
         foV5ljgVfDOgoFf9FlFvsioGoM4YHMBy69r3JcyQNEMLe6acZpgJ0BSWs28QLp36rWrp
         FWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Dp5soMSHrCjUpZswZvxQlzWraT5prbwHNht9WSOKHdU=;
        b=lcuqbxv7iIBKmJ+PX3bZwYhfbzAiqQ8Q9wXR7pPUoAIqKQjft9KcxiOXuwooi7vkxS
         XtB2VeuOZlgnC4M1ov53QmldJLAUKXaiiQi4Eeev/6ul2W1Fnp4DxzRTO4XNZ54cRpzI
         3n8UnLUaE4MCuuWUcWN/OzkgnFDIFCY2gE7ZnKInkLRCULCDuUyDhefJnZDT09kwtKTO
         kMyvOx7cNxQTkiH+ykzIqHL1GnmLvWIAI/BtC3Z8byxuzCWTDBHx1btfQSGe0hqo9wBy
         4hwQXT+92VjufdVFuybz2L/RF0s6zIVe3Bta4srxVb7qPmQZyKNfzzP/axV7EpsR6W/h
         b3TA==
X-Gm-Message-State: AOAM5300DMlX2iwsal271wqRJ5YZjaWZiaG0V5isl0u/fbWmQA1H1UJR
        CCS9stLXNQaIQE+xmCQo/TDGMg==
X-Google-Smtp-Source: ABdhPJzXZ2rLHed9dHeg++2oXfMdblWD/tNtJgseyi7VT0TiwoVdMN6raG3OS1rGa7EyWVGVdoT5Eg==
X-Received: by 2002:a17:90a:7bc1:: with SMTP id d1mr3050762pjl.183.1620285383384;
        Thu, 06 May 2021 00:16:23 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a7sm9807684pjm.0.2021.05.06.00.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 00:16:22 -0700 (PDT)
Date:   Thu, 06 May 2021 00:16:22 -0700 (PDT)
X-Google-Original-Date: Thu, 06 May 2021 00:16:21 PDT (-0700)
Subject:     Re: [PATCH] riscv: Consistify protect_kernel_linear_mapping_text_rodata() use
In-Reply-To: <b89a090317cf26bbe1caaa3cfa513a789ece1b19.1619708711.git.geert+renesas@glider.be>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        vitaly.wool@konsulko.com, alex@ghiti.fr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert+renesas@glider.be
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     geert+renesas@glider.be
Message-ID: <mhng-b16d1d5a-0ddf-4717-bde7-114e49d508e1@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2021 08:10:04 PDT (-0700), geert+renesas@glider.be wrote:
> The various uses of protect_kernel_linear_mapping_text_rodata() are
> not consistent:
>   - Its definition depends on "64BIT && !XIP_KERNEL",
>   - Its forward declaration depends on MMU,
>   - Its single caller depends on "STRICT_KERNEL_RWX && 64BIT && MMU &&
>     !XIP_KERNEL".
>
> Fix this by settling on the dependencies of the caller, which can be
> simplified as STRICT_KERNEL_RWX depends on "MMU && !XIP_KERNEL".
> Provide a dummy definition, as the caller is protected by
> "IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)" instead of "#ifdef
> CONFIG_STRICT_KERNEL_RWX".
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Only tested on K210 (SiPeed MAIX BiT).
> ---
>  arch/riscv/include/asm/set_memory.h | 7 ++++++-
>  arch/riscv/kernel/setup.c           | 2 --
>  arch/riscv/mm/init.c                | 2 +-
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> index a9c56776fa0e74d6..086f757e8ba3cc69 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -17,7 +17,6 @@ int set_memory_x(unsigned long addr, int numpages);
>  int set_memory_nx(unsigned long addr, int numpages);
>  int set_memory_rw_nx(unsigned long addr, int numpages);
>  void protect_kernel_text_data(void);
> -void protect_kernel_linear_mapping_text_rodata(void);
>  #else
>  static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
>  static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
> @@ -27,6 +26,12 @@ static inline void protect_kernel_text_data(void) {}
>  static inline int set_memory_rw_nx(unsigned long addr, int numpages) { return 0; }
>  #endif
>
> +#if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
> +void protect_kernel_linear_mapping_text_rodata(void);
> +#else
> +static inline void protect_kernel_linear_mapping_text_rodata(void) {}
> +#endif
> +
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
>  bool kernel_page_present(struct page *page);
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 7b31779101f662e4..03901d3a8b027343 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -293,9 +293,7 @@ void __init setup_arch(char **cmdline_p)
>
>  	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
>  		protect_kernel_text_data();
> -#if defined(CONFIG_64BIT) && defined(CONFIG_MMU) && !defined(CONFIG_XIP_KERNEL)
>  		protect_kernel_linear_mapping_text_rodata();
> -#endif
>  	}
>
>  #ifdef CONFIG_SWIOTLB
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 3ebc0f5d2b73b42b..6cc0421a5d0ef4a3 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -646,7 +646,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>  #endif
>  }
>
> -#if defined(CONFIG_64BIT) && !defined(CONFIG_XIP_KERNEL)
> +#if defined(CONFIG_64BIT) && defined(CONFIG_STRICT_KERNEL_RWX)
>  void protect_kernel_linear_mapping_text_rodata(void)
>  {
>  	unsigned long text_start = (unsigned long)lm_alias(_start);

Thanks, this is on for-next.
