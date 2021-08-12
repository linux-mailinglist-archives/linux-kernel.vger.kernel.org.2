Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40113E9F58
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 09:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhHLHS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 03:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhHLHS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 03:18:58 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CC9C061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:18:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so13877109pjs.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 00:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=qamAtbGqWd2cz3VbtrXxIyEPlw8SFc6ZDxX7MvG+W3k=;
        b=zf+RkLQNlJpLGNavfDu7X/k6Cq70FSMcrYQKDa9qkRevTCjHCGMk/Q14gYTiU0HACP
         AZlyi2LK8FHt0NnkU2zWLK6PxMIAckf1nnPbbHyZABELRmCPWE2W3VG+AJ/zkf4lGxvS
         6V1Xw8YJJlBY1nDr+BspV0Uz9VyiiO+Vm8BUy2XglPZ0r9HMy0Xq64/gLxD/FQFKx1/w
         o1T2qVFNSbdUsfm/ICd87bdBZpPJpq+dnqeyZoNHK19LP0t8f1N1CVTGHQBodOum9j12
         iAq4KkiEeTWJzo4ztAIVyxHxAKZS1oQXSoNR9V0w5uVjRss1lB0zwf09FJ8nrB6t8bUV
         l5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=qamAtbGqWd2cz3VbtrXxIyEPlw8SFc6ZDxX7MvG+W3k=;
        b=ddApHeAeRTlL6Qzc655UOg/gvE+gwsP4r/ltArWi/AGqW3rz8ZJXORSlrdCxXohQbv
         MEXFoV2ij3YZ4Cs4EjRzaziEUB7QCaxyeqkUdX+37AMoFuPYgzBcVvgMwjXv3ENsUoeq
         HdhLqy+yEmVnkoIpkCGOqxRgpSUSoBYQwGr0iCkmjPKNm5xWvNwEXtjEUrYScUirFpg3
         jZD5OFcFcZLsu4apfYfVyJCzFn2uCVE8ZSZt32dWxiqrMgndHNIcmp/N4gZj+QqKLhW6
         rDWij80fG0V9EHgPUmROiuJcXb7tTn/U9YnNByMJawV3yoYou6EC0TfNwiL2k8WC/VNB
         2XeA==
X-Gm-Message-State: AOAM530/P5vxBOQby9rQcupNkVjUpDhFY6zHUK+FVj4vaC91nRhtm1Y5
        6R3X3KOidjwfQKDjTlroKg0agw==
X-Google-Smtp-Source: ABdhPJzEJibdgL8k2XScMKYi/Z59QGIavIA1WuSVqv+zB7YI97mhxl/IUgLJcNlgHo+OHA16rheyAQ==
X-Received: by 2002:a17:90a:5416:: with SMTP id z22mr2929072pjh.183.1628752713307;
        Thu, 12 Aug 2021 00:18:33 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v20sm2305847pgi.39.2021.08.12.00.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 00:18:32 -0700 (PDT)
Date:   Thu, 12 Aug 2021 00:18:32 -0700 (PDT)
X-Google-Original-Date: Wed, 11 Aug 2021 23:41:26 PDT (-0700)
Subject:     Re: [PATCH 0/5] Small cleanup for mm/init.c and address conversion macros
In-Reply-To: <20210723130128.47664-1-alex@ghiti.fr>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        alex@ghiti.fr
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     alex@ghiti.fr
Message-ID: <mhng-f4204e85-d2a5-4112-85d6-3f118d1167f1@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2021 06:01:23 PDT (-0700), alex@ghiti.fr wrote:
> The first patch allows to have only one definition of the address
> conversion macros for all kernel types.
>
> The following patches bring small cleanups to mm/init.c and the last
> patch makes the size of the DTB early mapping consistent between 32-bit
> and 64-bit kernels.
>
> Alexandre Ghiti (5)
>   riscv: Introduce va_kernel_pa_offset for 32-bit kernel
>   riscv: Get rid of map_size parameter to create_kernel_page_table
>   riscv: Use __maybe_unused instead of #ifdefs around variable
>     declarations
>   riscv: Simplify BUILTIN_DTB device tree mapping handling
>   riscv: Move early fdt mapping creation in its own function
>
>  arch/riscv/include/asm/page.h |  15 +----
>  arch/riscv/mm/init.c          | 121 +++++++++++++++-------------------
>  2 files changed, 54 insertions(+), 82 deletions(-)

Thanks, these are on for-next.  There were some minor merge conflicts, 
let me know if I missed anything.
