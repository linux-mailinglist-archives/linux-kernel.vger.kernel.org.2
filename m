Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9B3309BB3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 12:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhAaLkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 06:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhAaKGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 05:06:16 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2634DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 02:05:36 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id o18so10079692qtp.10
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 02:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6XPpC5iWPkqaZeLnJgI3weALZbBUAEPVHmKrFmfIhV4=;
        b=goNRaFYmTaG8BUEpJjI5+D7VkeSS8Vw3WCidmfh7z5F69eEYlCKPWjUYHKSNv4LlXW
         aA2wsdAZdn9Sn2JGUVVGTU1c2msJ9juf4It0P+1DcEF0Mh3MGD3mlp50tKxp3iZ0uL/z
         jmveZhNa4lNCDoakWYshbC2J/EpSiqo70LqMu5Fg6DOLLRcu83ookO0uLUlAasEfSKCm
         +ba3ahzhHF/IqcVnkG+BHkxjKv1fPtUGwLoUr91HM6N2pRJQgfcMHnu5xR0TBFf4uZZj
         7iJTQKy48bkQfOcHJqGeTqA4rosGZkxoKQm4X4cXagGcZaIyK3lS6cptn3beUVZge2Mq
         PLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6XPpC5iWPkqaZeLnJgI3weALZbBUAEPVHmKrFmfIhV4=;
        b=lS9jo55i56Rcc19AGObXnJi9UdM0BF1u/gYrMh+WWq0c5YS0jX0YqDyuMTzuxXoI1t
         QfsAS/ZJmYY+Li9lt+NV+ASBJRmNYMmU/l7ZM03aMuKifbBUMBd1L20RNPmupsdkykQd
         9h0ohfClLIDJ6Q3/VmaErw8ARausb0mHg+YvyLRTvVghkbjv+8wRJPH+BPGyI1OHXeQh
         SBQHpSC0M0xiAsS09TSCS4oX5ZZ0nw7WvncZEBz11iCWAyPChA/Z7SmW+Quwhg/DVC1r
         mKsVcZG+kFoSdJ8R7vkyoJkLJT2jaZ0hP38A8iyn3Ipt9vxyVjYT6sIRHJY+H2W/Lec6
         ecjw==
X-Gm-Message-State: AOAM532zqgpvDVEui0jHAVN4miUv+0APPGz+oJQM5LbthOiiIdH6Pqip
        rFvGHp212GmpgmYFh3eH9EE8MScUl5su7jG8QriG+hG58CqFUA==
X-Google-Smtp-Source: ABdhPJyph78/rd4/9XFp9fgx0ClwAtxtwK4JgD43nV7zUeghphf7AbgfoQLqOnuLWNHg1FTsBjTrgrmBk1kBkls7FQY=
X-Received: by 2002:a37:2716:: with SMTP id n22mr11570565qkn.265.1612087224408;
 Sun, 31 Jan 2021 02:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20210129173105.22020-1-alex@ghiti.fr>
In-Reply-To: <20210129173105.22020-1-alex@ghiti.fr>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 31 Jan 2021 11:00:12 +0100
Message-ID: <CACT4Y+bPy-XpynfRvUbE-wSXnGe_AitusJ=2cANdb-O0ONtgtw@mail.gmail.com>
Subject: Re: [PATCH] riscv: virt_addr_valid must check the address belongs to
 linear mapping
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 6:31 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> virt_addr_valid macro checks that a virtual address is valid, ie that
> the address belongs to the linear mapping and that the corresponding
>  physical page exists.
>
> Add the missing check that ensures the virtual address belongs to the
> linear mapping, otherwise __virt_to_phys, when compiled with
> CONFIG_DEBUG_VIRTUAL enabled, raises a WARN that is interpreted as a
> kernel bug by syzbot.

Thanks, Alexandre. Much appreciated.

> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>  arch/riscv/include/asm/page.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> index 2d50f76efe48..64a675c5c30a 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -135,7 +135,10 @@ extern phys_addr_t __phys_addr_symbol(unsigned long x);
>
>  #endif /* __ASSEMBLY__ */
>
> -#define virt_addr_valid(vaddr) (pfn_valid(virt_to_pfn(vaddr)))
> +#define virt_addr_valid(vaddr) ({                                              \
> +       unsigned long _addr = (unsigned long)vaddr;                             \
> +       (unsigned long)(_addr) >= PAGE_OFFSET && pfn_valid(virt_to_pfn(_addr)); \
> +})
>
>  #define VM_DATA_DEFAULT_FLAGS  VM_DATA_FLAGS_NON_EXEC
>
> --
> 2.20.1
>
