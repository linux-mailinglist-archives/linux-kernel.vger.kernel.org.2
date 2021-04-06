Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760AD354AE5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 04:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243373AbhDFCfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 22:35:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232271AbhDFCfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 22:35:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 753F7611C0;
        Tue,  6 Apr 2021 02:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617676506;
        bh=f9B2Cj+hZMbB5RuZ1sOGqngVS1EXgeT4YM4yx3FshDQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yom7z9fZfosZgKwqFBu1VcNKC2tWYb+vxAk/gfPCqtCFQT/LJfRFXN8Alqvz6sMnW
         18LyYQJ88id/3NsvwzFOkaET6QhrhL3EaWKIdF4HzsO5bdvHCKtWJ7cQ7O9UJdKfEJ
         dbQFUKf0jxpZ1h/7/8iyJdmx+RSdZJ+F+BosQhFPUDmG+3/rp5kDjzyiNnDDD2eXHA
         JDRt4Wid4Q/m7RrLOkqmtG6PueQGEjnYd4kzqgDUKORsulJ/sjeYpPzagHaInBE2jL
         jJlCyGoWqrFUONkqJmDGHbKavWEKzeKvZOzBfKXGzoZkzCo4E+9oVxPPdN82s97tGV
         i5sKYWXGJPMjQ==
Received: by mail-lf1-f52.google.com with SMTP id n138so20338593lfa.3;
        Mon, 05 Apr 2021 19:35:06 -0700 (PDT)
X-Gm-Message-State: AOAM530zG5s3zpilvWCuL+ONq7Rug0QDvtsxes4E3SvMbofFsbZQxV71
        q/HhLl2h8UdIpHGrKob/8qcuMxezpWRnyeZhX7g=
X-Google-Smtp-Source: ABdhPJwkNqq3eNyWXjNY6FLAzSJ3Xq4BbMccPyJ1XTpHu76xQ2eqW+tnmCtDjTLnjfKKj522KdjfQH1WnRWnwTsTbg8=
X-Received: by 2002:ac2:5e26:: with SMTP id o6mr19862530lfg.355.1617676504847;
 Mon, 05 Apr 2021 19:35:04 -0700 (PDT)
MIME-Version: 1.0
References: <1617673695-102193-1-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1617673695-102193-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 6 Apr 2021 10:34:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRuW=TP6jZSAkDCNyq5aeEsbhZFpOQFTiCoapN3EU0ydw@mail.gmail.com>
Message-ID: <CAJF2gTRuW=TP6jZSAkDCNyq5aeEsbhZFpOQFTiCoapN3EU0ydw@mail.gmail.com>
Subject: Re: [PATCH] csky: remove unused including <linux/version.h>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked by

On Tue, Apr 6, 2021 at 9:48 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Fix the following versioncheck warnings:
> ./arch/csky/include/asm/io.h: 8 linux/version.h not needed.
> ./arch/csky/include/asm/uaccess.h: 14 linux/version.h not needed.
> ./arch/csky/kernel/process.c: 5 linux/version.h not needed.
> ./arch/csky/mm/dma-mapping.c: 12 linux/version.h not needed.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/csky/include/asm/io.h      | 1 -
>  arch/csky/include/asm/uaccess.h | 1 -
>  arch/csky/kernel/process.c      | 1 -
>  arch/csky/mm/dma-mapping.c      | 1 -
>  4 files changed, 4 deletions(-)
>
> diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
> index f826540..ed53f0b 100644
> --- a/arch/csky/include/asm/io.h
> +++ b/arch/csky/include/asm/io.h
> @@ -5,7 +5,6 @@
>
>  #include <linux/pgtable.h>
>  #include <linux/types.h>
> -#include <linux/version.h>
>
>  /*
>   * I/O memory access primitives. Reads are ordered relative to any
> diff --git a/arch/csky/include/asm/uaccess.h b/arch/csky/include/asm/uaccess.h
> index 3dec272..841e421 100644
> --- a/arch/csky/include/asm/uaccess.h
> +++ b/arch/csky/include/asm/uaccess.h
> @@ -11,7 +11,6 @@
>  #include <linux/types.h>
>  #include <linux/sched.h>
>  #include <linux/string.h>
> -#include <linux/version.h>
>  #include <asm/segment.h>
>
>  static inline int access_ok(const void *addr, unsigned long size)
> diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
> index 3d0ca22..5de0470 100644
> --- a/arch/csky/kernel/process.c
> +++ b/arch/csky/kernel/process.c
> @@ -2,7 +2,6 @@
>  // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
>
>  #include <linux/module.h>
> -#include <linux/version.h>
>  #include <linux/sched.h>
>  #include <linux/sched/task_stack.h>
>  #include <linux/sched/debug.h>
> diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> index c3a775a..8244702 100644
> --- a/arch/csky/mm/dma-mapping.c
> +++ b/arch/csky/mm/dma-mapping.c
> @@ -9,7 +9,6 @@
>  #include <linux/mm.h>
>  #include <linux/scatterlist.h>
>  #include <linux/types.h>
> -#include <linux/version.h>
>  #include <asm/cache.h>
>
>  static inline void cache_op(phys_addr_t paddr, size_t size,
> --
> 1.8.3.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
