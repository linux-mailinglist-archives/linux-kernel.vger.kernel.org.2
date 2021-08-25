Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE7F3F6E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 06:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhHYEpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 00:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhHYEpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 00:45:46 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67312C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 21:45:01 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id x4so21872886pgh.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 21:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=7An1qOKhb0/BJH1XFWypIzS3gCOZ53jVfEc4mO5wsk4=;
        b=v5mcuMrttY/PcyEkupueYaA4dl1TeGKkRQ3e72JC3lpG3D4457cMIhWBU7Wu+SUumr
         0IvTqzap7e7rQPDpnuEZGu5ef4izlONypoQrGH8SqmjSMATYLk0q8FGys6EWCsFPgqji
         wtMiqNGr5TX5D0OGV/Fg8k8IEY4qzqSWmypEIjkyIu5RIjNe7p+JXFZvhcpD7K2LDgQm
         X5OKoYgORg3L3dsZka+ILXDnfh+pWC+jEB37us2atFQqzGOu40ij/n1RduGtj8Kg2fGq
         Y6pzkmyqbamdKxO3iAG7lqyDr7Z18KZgtfj/lKItw1UXel98tcRIuhcrbE7FW2ONU5Cp
         jqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=7An1qOKhb0/BJH1XFWypIzS3gCOZ53jVfEc4mO5wsk4=;
        b=U+U5DEbIiYa69Lx+C2H1BmBhCN8+yetPyTqriGeUIONRz+qv+DJ9/YoOgdl2IBmFoS
         FGFaiiPPhyihIFMp9L/wDU6T7G1MqKmPkcBqFeAPMD1oCeJawLMV/kkgj+ofcPzccTE2
         ZIctKGgOyK7QDVpphbDkyqR9lxBA4L7ahkXySWBk+CigVC+5tQs8wJZ7ORLk8Rf73WMH
         Bc33PWHodeG+6IMjmo4HDew+LZavYaNd7lO+i+zTtATk9qJVi0/tcekvlz2aYrnF8ddE
         o91hVGPZeZ6KZXyQSD+xsY9VK/2xsi5c950rt2oaMb8bFeo0nOL/9/8yAegRhYDvrNug
         OXsQ==
X-Gm-Message-State: AOAM531ctA+JUhCiFpxjR2TxrWLZqwnE+6fpwHOujV0WRBlh2Sze2gp4
        xz8pCUAve/35R6s7qOuK8s0nTw==
X-Google-Smtp-Source: ABdhPJz2UhBzkG7qw4W+QaoVEOJjcZGHzARg3VkcsQb/5AcJ3CjIPcjzDqFty4Q1XcX1r2OVWJ2c8Q==
X-Received: by 2002:a05:6a00:2405:b0:3e1:9f65:9703 with SMTP id z5-20020a056a00240500b003e19f659703mr42768559pfh.6.1629866700873;
        Tue, 24 Aug 2021 21:45:00 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id pj14sm3597913pjb.35.2021.08.24.21.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 21:45:00 -0700 (PDT)
Date:   Tue, 24 Aug 2021 21:45:00 -0700 (PDT)
X-Google-Original-Date: Tue, 24 Aug 2021 21:44:56 PDT (-0700)
Subject:     Re: [PATCH] riscv: Enable Undefined Behavior Sanitizer UBSAN
In-Reply-To: <20210805003059.26b03ec0@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-9d810d01-99cd-4e1c-8642-d9caf3e0a9bc@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Aug 2021 09:30:59 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> Select ARCH_HAS_UBSAN_SANITIZE_ALL in order to allow the user to
> enable CONFIG_UBSAN_SANITIZE_ALL and instrument the entire kernel for
> ubsan checks.
>
> VDSO is excluded because its build doesn't include the
> __ubsan_handle_*() functions from lib/ubsan.c, and the VDSO has no
> sane way to report errors even if it has definitions of these functions.
>
> Passed lib/test_ubsan.c test.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/Kconfig              | 1 +
>  arch/riscv/kernel/vdso/Makefile | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index f133ac72572f..cccb95bf8331 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -28,6 +28,7 @@ config RISCV
>  	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
>  	select ARCH_HAS_STRICT_MODULE_RWX if MMU && !XIP_KERNEL
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> +	select ARCH_HAS_UBSAN_SANITIZE_ALL
>  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
>  	select ARCH_STACKWALK
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index 24d936c147cd..30a5335bd317 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -36,6 +36,7 @@ CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
>  GCOV_PROFILE := n
>  KCOV_INSTRUMENT := n
>  KASAN_SANITIZE := n
> +UBSAN_SANITIZE := n
>
>  # Force dependency
>  $(obj)/vdso.o: $(obj)/vdso.so

Thanks, this is on for-next.
