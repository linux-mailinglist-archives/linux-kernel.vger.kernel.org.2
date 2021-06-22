Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7A43B066B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 16:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhFVOGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 10:06:04 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:47039 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhFVOGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 10:06:03 -0400
Received: by mail-ua1-f43.google.com with SMTP id t22so6061403uar.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 07:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0DhiBJqgLPI4mq7rTlL2ewwRyBrH0IFpl65vmKyq+QM=;
        b=i46YOgh0qDiuhEVVpofCB/Okcpbqy3ehgpHNZI7IGrCz8Ux5MMw6kBWZCaQ1Bbwt5U
         HHa0ozWmPA88PSu09wSAQ/UlB9TG4FbIrgyJcnF8cWIOkPMPoYHiZtf5E3iVQw5BslWy
         hk3M8NMIhxTj6AMLWm6ALtQdkbEnJ7zJvDKRmUyx2LzrLtf7wy3gt1NeZdKHbVoIy6pF
         Xf2AH6Skkq+FPXxtpiunyV4D3Fxyc69w8QuBBsd+IQrByeMG4BP4D8IRhZEljelmhrDw
         T7IVTBwYFIjeevY8VsNALrZ7NdmsIRzY9CUenU/6noM91QT3bWPGC6f/v4DvTobDQKWH
         yhyw==
X-Gm-Message-State: AOAM532DpKaiBy4+btxNwClznNjXOjT1RoeQR/fwIMCvUTuw9glTxcTQ
        o6h7Q6Lf4hAD+HZaKxcBvzQeJnQc/P9/IHxmp4Q=
X-Google-Smtp-Source: ABdhPJzQv09D4jymRC3aBNx7ZtOolbMBnl9c7deoMJlJV4fHFTlR4u2FiwP7APo9Br/AdiKJF5V3XZTDCBRUIYDQvGw=
X-Received: by 2002:ab0:3734:: with SMTP id s20mr3756611uag.106.1624370627124;
 Tue, 22 Jun 2021 07:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210617095831.2398438-1-sunnanyong@huawei.com>
In-Reply-To: <20210617095831.2398438-1-sunnanyong@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Jun 2021 16:03:35 +0200
Message-ID: <CAMuHMdU6ngi50vXn--fNDy6BCOz=U34FDhw7iHvqKrNQqSHw-w@mail.gmail.com>
Subject: Re: [PATCH v2 -next] riscv: mm: fix build errors caused by mk_pmd()
To:     Nanyong Sun <sunnanyong@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Atish Patra <atish.patra@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 11:28 AM Nanyong Sun <sunnanyong@huawei.com> wrote:
> With "riscv: mm: add THP support on 64-bit", mk_pmd() function
> introduce build errors,
> 1.build with CONFIG_ARCH_RV32I=y:
> arch/riscv/include/asm/pgtable.h: In function 'mk_pmd':
> arch/riscv/include/asm/pgtable.h:513:9: error: implicit declaration of function 'pfn_pmd';
>  did you mean 'pfn_pgd'? [-Werror=implicit-function-declaration]
>
> 2.build with CONFIG_SPARSEMEM=y && CONFIG_SPARSEMEM_VMEMMAP=n
> arch/riscv/include/asm/pgtable.h: In function 'mk_pmd':
> include/asm-generic/memory_model.h:64:14: error: implicit declaration of function 'page_to_section';
>  did you mean 'present_section'? [-Werror=implicit-function-declaration]
>
> Move the definition of mk_pmd to pgtable-64.h to fix the first error.
> Use macro definition instead of inline function for mk_pmd
> to fix the second problem. It is similar to the mk_pte macro.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>

Thanks, this fixes my rv32 build.
Works fine with litex-rebase on VexRiscv.
No regression on BeagleV Starlight-beta.

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
