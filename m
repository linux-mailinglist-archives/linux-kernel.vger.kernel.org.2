Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428AC35B70F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 23:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhDKVlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 17:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhDKVlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 17:41:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C60C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 14:41:08 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id a85so7458175pfa.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=+fiWyB9PhZA7feIGTFUmyxbY9Jp7+5HLpxk5Rc5dRkU=;
        b=Dlc6xfKWjgDIFi8sgGz/DQzY3fGMErdoWktMMh2I7bKW3HOC++m9k0hKMf1TpHKENW
         3dT+5Xwy8YYs9vRD8qiBjSTAvNwC7fF6aMLSFr7vq1ygd/ZvhKbUGtHm+Y/Ns3biyx3a
         roUGSfKjF/hmk77vyhAOs++JApJtogogA6TdoiNrUXcafNT3KnVCOtc/BZJPY+H1B3aq
         ggNjA+QUya21b1PUEwecWpFw5K0As+ixltg6UopS+azSDbGsVzGHV602DQVEOxJGphgc
         iG+Aj0vglgDYCO53mbd0njbjoLg7StSovqJSKFFDYM/4pUqHlXgIxs502CEB0e9ZZqgq
         EG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=+fiWyB9PhZA7feIGTFUmyxbY9Jp7+5HLpxk5Rc5dRkU=;
        b=XZGua5HIBebX2I7jzZPiGV3Z6SUR6Sz3JLSOp9Y/V6d9msW7jY74YqDdYVeD1cTSCx
         iuZZO19CiVu+XStPPQA33JkC6FBO5hhov26TB7wvfxv4jgn8vyc8C5UX5LnB2/2r1Bhg
         C69wcPSELNgdVymb3QToI9WkdIQ1oXCqRHh/6bpUM9pdpZb1zcVLhPOfotBhE23LrRgN
         ihGaH9ukgA6IvrwsPykEtbtkhOr57Bj9zvFxhEAAt/ztW2JEMh1aLSNhH9eUqVAv6mzJ
         xddtBXdc1p0wpXJRajYKtk1A4DdYOmBsuBf9Ege91gIqDl2Wzps9AttLoWeWvJSXvg9m
         ZQ/A==
X-Gm-Message-State: AOAM5325jBX5CExHcZgT2MFDSJ45Ba6wXLkcVpLvPu6x4rBsbmtND8Kx
        btWnDyARB3lF5BwA9AYU6LZQfw==
X-Google-Smtp-Source: ABdhPJz+f0azA3WHUJPvxLvvsVHFC2p159IkByFsI6fDdDCKC6kai/pYaObykVjFOqOqGAHJoTg8lA==
X-Received: by 2002:a65:5282:: with SMTP id y2mr24123536pgp.293.1618177267560;
        Sun, 11 Apr 2021 14:41:07 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 92sm8635526pjz.7.2021.04.11.14.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 14:41:07 -0700 (PDT)
Date:   Sun, 11 Apr 2021 14:41:07 -0700 (PDT)
X-Google-Original-Date: Sun, 11 Apr 2021 14:40:50 PDT (-0700)
Subject:     Re: [PATCH] implement flush_cache_vmap and flush_cache_vunmap for RISC-V
In-Reply-To: <20210329015510.44110-1-liu@jiuyang.me>
CC:     alex@ghiti.fr, liu@jiuyang.me, waterman@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, akpm@linux-foundation.org,
        geert@linux-m68k.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     liu@jiuyang.me
Message-ID: <mhng-92e28f5c-ced0-4a92-949f-0fd865c0bbf5@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Mar 2021 18:55:09 PDT (-0700), liu@jiuyang.me wrote:
> This patch implements flush_cache_vmap and flush_cache_vunmap for
> RISC-V, since these functions might modify PTE. Without this patch,
> SFENCE.VMA won't be added to related codes, which might introduce a bug
> in some out-of-order micro-architecture implementations.
>
> Signed-off-by: Jiuyang Liu <liu@jiuyang.me>
> ---
>  arch/riscv/include/asm/cacheflush.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index 23ff70350992..4adf25248c43 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -8,6 +8,14 @@
>
>  #include <linux/mm.h>
>
> +/*
> + * flush_cache_vmap and flush_cache_vunmap might modify PTE, needs SFENCE.VMA.
> + * - flush_cache_vmap is invoked after map_kernel_range() has installed the page table entries.
> + * - flush_cache_vunmap is invoked before unmap_kernel_range() deletes the page table entries

These should have line breaks.

> + */
> +#define flush_cache_vmap(start, end) flush_tlb_all()

We shouldn't need cache flushes for permission upgrades: the ISA allows 
the old mappings to be visible until a fence, but the theory is that 
window will be sort for reasonable architectures so the overhead of 
flushing the entire TLB will overwhelm the extra faults.  There are a 
handful of places where we preemptively flush, but those are generally 
because we can't handle the faults correctly.

If you have some benchmark that demonstrates a performance issue on real 
hardware here then I'm happy to talk about this further, but this 
assumption is all over arch/riscv so I'd prefer to keep things 
consistent for now.

> +#define flush_cache_vunmap(start, end) flush_tlb_all()

This one does seem necessary.

> +
>  static inline void local_flush_icache_all(void)
>  {
>  	asm volatile ("fence.i" ::: "memory");
