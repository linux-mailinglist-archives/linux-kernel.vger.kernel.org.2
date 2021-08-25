Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189F53F6E89
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 06:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbhHYEp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 00:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbhHYEp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 00:45:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D64C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 21:44:43 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id oc2-20020a17090b1c0200b00179e56772d6so3281218pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 21:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=HQb1qPKPVQv8i2sQtSNBJbfKt3KpoSGtp9yhja3ONfM=;
        b=da7vg+SZq/t3BfPYQw8YZOFbshDhxnvL4qQmVe3n/Vwq+sKt2/xeRm42ZekP+MgxoZ
         CeOeiqbyq6fugqqtRsTrsBA3/mj+qf91j6TKcpbkWS0z97waN6tzym2cnS+KeO/6tC8l
         H+RdDqXUj18VXpRzkOz5nuBmmWgUz6LXcj920HGddbltWG38a0ffFOGx8vC8tgyyI2pk
         GU5rK4F0r7K7az4iEO2TIELNX+q9J9bn7XrY9TPFEtpBw31fsWFWcfZR+4f4DnsaSfta
         g/UyRr1fRQPLREpETfYfEytjNWWMSy9f0FX3t/gMHUc3St2MLSwrdot/Vjdf6m/NnI0T
         qONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=HQb1qPKPVQv8i2sQtSNBJbfKt3KpoSGtp9yhja3ONfM=;
        b=aV5J2pMCtf1N+edkmV0vB4YTj86MRZaBrRvR4LYXa9D68Yp9ffvmDfFR/2cDXEJZ/2
         mtOjBGKlQiRRMuFtEEq+LjR6ZHBWAAeLJf3hn0nTJVY4O2UgRIUMuTTd3Zz99OA/nqSz
         OPQQAKaA/kposGyTOV/IeIlFlaKXNoLncLV2n0gjCSsBfGQHmhC3ErUE3MOdA1iuRfhU
         DvuIKYkGEb9nnoggKgatPZIXuIGkML40R4Nb4laVe1DggBQj2f2YjtnOYbAFpgiVgCfk
         Jd564CYntxF/tyIyfeEk4zDySpNh/Lv1Zjbna0tBC+7n9j46+qUkXjbONdrp6KhqVIW3
         35Pw==
X-Gm-Message-State: AOAM531bEflhydjX9LRFwbAga18oq7x7bFot6RkMn47dNHczL6Gz42ay
        EoURYZhmxdbqY/H9CL2jCQY0j9oADkcmW6N5
X-Google-Smtp-Source: ABdhPJxOM/2YGAEIgMwLGRY1pn58De9xkTf6LI9HnwGc+e+OCaed3fTdkvB6pVx0RQb+YRFDkn/OkQ==
X-Received: by 2002:a17:90a:eb0d:: with SMTP id j13mr6812463pjz.163.1629866682543;
        Tue, 24 Aug 2021 21:44:42 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id t42sm8940750pfg.30.2021.08.24.21.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 21:44:41 -0700 (PDT)
Date:   Tue, 24 Aug 2021 21:44:41 -0700 (PDT)
X-Google-Original-Date: Tue, 24 Aug 2021 20:58:40 PDT (-0700)
Subject:     Re: [PATCH] riscv: Keep the riscv Kconfig selects sorted
In-Reply-To: <20210805002908.2597836f@xhacker>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     jszhang3@mail.ustc.edu.cn
Message-ID: <mhng-43c0a2a8-fbd8-47bf-a9c4-4ac01333b6b0@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Aug 2021 09:29:08 PDT (-0700), jszhang3@mail.ustc.edu.cn wrote:
> From: Jisheng Zhang <jszhang@kernel.org>
>
> Move three Kconfig selects: ARCH_STACKWALK, ARCH_SUPPORTS_ATOMIC_RMW
> and ARCH_SUPPORTS_DEBUG_PAGEALLOC to the right place.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 8fcceb8eda07..f133ac72572f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -13,9 +13,6 @@ config 32BIT
>  config RISCV
>  	def_bool y
>  	select ARCH_CLOCKSOURCE_INIT
> -	select ARCH_SUPPORTS_ATOMIC_RMW
> -	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
> -	select ARCH_STACKWALK
>  	select ARCH_HAS_BINFMT_FLAT
>  	select ARCH_HAS_DEBUG_VM_PGTABLE
>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
> @@ -33,6 +30,9 @@ config RISCV
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
> +	select ARCH_STACKWALK
> +	select ARCH_SUPPORTS_ATOMIC_RMW
> +	select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
>  	select ARCH_SUPPORTS_HUGETLBFS if MMU
>  	select ARCH_USE_MEMTEST
>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU

Thanks, this is on for-next.
