Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F5C394E6C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 00:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhE2Wqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 18:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhE2Wqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 18:46:40 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7DEC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 15:45:03 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v12so3331106plo.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 15:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=fi0vV/kF+CsBKSccmeD5rhECNTR0UPRdkNUxlQCOu6o=;
        b=i6A/A7Wom+6pM1tUHC83JTgbW35vAvfXx8K69AJbPi1Hu/Vb0nH15InB2zoG8ZDzdQ
         wyTBY3U0HJRoTiWmeiELkZo8IlIEQpbtxhPLlDwbwTu5KrE2OZK6I9i4TquPmiDzLKaZ
         lWaUa6IiJZ4IdVi4mMrObXbQxU+uFt/0xoo6VREZafKrAi8RhlSA2l/0g0f1E7BQprVc
         LUBKUKXZVmPO42ZwXG36UdQdpYQDxr//afSU5dtEAOqeLHHGSGBSksTq3rke61+tSSdV
         TJUFnuj/q+8xLHDGp7pIK7VmhyuBz6JN3dgmiB2eMZZ8ib50W6AoMcDGRzX/zruYiNmO
         qKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=fi0vV/kF+CsBKSccmeD5rhECNTR0UPRdkNUxlQCOu6o=;
        b=WiUgSNkob8l2VhXjRHzUFuMK0Xk6mkZKsoG9OqZX0yDLwmN4mtUFPtRyifiSmgozHZ
         4bdqqWCCXgBkqvT5+7YCPjoKtxNcbFLBUomNdD9yiUZLfpAT1nI6N0jpoIP2OAFlpRCo
         mi5ilPj5sOEKF7eJsaxYLC40gAnNx//k/yOqqftNS5dWNYxnSsfq5LnzOEufHaZQc5mT
         93yjVeqSzKoX6TBYOyyVYLDZpSSZLpkg8cGoXcLzkm96f+Rj7ZGhzajgX31n1QV77XS0
         jf310doHUcwKDMrlX1gU+qHclZ86tarSqemTy2v4zyW02jp+2KITofFq3JmkkcX32Opt
         0bbQ==
X-Gm-Message-State: AOAM532+MbjYzKbLcyO7/oJtL4Pa8zk9Tv5tqunvmVkSMQG7dAYinmRI
        Aom70PavGznJwGjAwLtcMNbkxw==
X-Google-Smtp-Source: ABdhPJxEkcHSt/r0RUtDB7tfrUNpUFiVQ7CCqmPtNOJYrpOwquBntTt3/OkdihRXgW+frUet54s5gQ==
X-Received: by 2002:a17:90a:9411:: with SMTP id r17mr11310055pjo.49.1622328303013;
        Sat, 29 May 2021 15:45:03 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m24sm7313476pfa.125.2021.05.29.15.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 15:45:02 -0700 (PDT)
Date:   Sat, 29 May 2021 15:45:02 -0700 (PDT)
X-Google-Original-Date: Sat, 29 May 2021 15:37:56 PDT (-0700)
Subject:     Re: [PATCH] docs: kernel-parameters: mark numa=off is supported by a bundle of architectures
In-Reply-To: <20210524051715.13604-1-song.bao.hua@hisilicon.com>
CC:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, will@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, song.bao.hua@hisilicon.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     song.bao.hua@hisilicon.com
Message-ID: <mhng-145d2f8a-0697-4fff-a579-bce952033f25@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2021 22:17:15 PDT (-0700), song.bao.hua@hisilicon.com wrote:
> risc-v and arm64 support numa=off by common arch_numa_init()
> in drivers/base/arch_numa.c. x86, ppc, mips, sparc support it
> by arch-level early_param.
> numa=off is widely used in linux distributions. it is better
> to document it.
>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index cb89dbdedc46..a388fbdaa2ec 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3513,6 +3513,9 @@
>
>  	nr_uarts=	[SERIAL] maximum number of UARTs to be registered.
>
> +	numa=off 	[KNL, ARM64, PPC, RISCV, SPARC, X86] Disable NUMA, Only
> +			set up a single NUMA node spanning all memory.
> +
>  	numa_balancing=	[KNL,ARM64,PPC,RISCV,S390,X86] Enable or disable automatic
>  			NUMA balancing.
>  			Allowed values are enable and disable

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!
