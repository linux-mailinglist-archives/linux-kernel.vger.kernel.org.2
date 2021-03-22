Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C74B3447A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhCVOoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:44:39 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:42785 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhCVOn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:43:59 -0400
Received: by mail-vs1-f54.google.com with SMTP id b5so7583568vsl.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=774bKKZoTYGcoc/Le9OSHYdVSPTCoe+uLV/vgU44wII=;
        b=hfuht6ij+w8zPrnk60FUEmp6Q5amvQY7ccXA4hblpwMLLsmm7lUiCtIhU/2UsAmxog
         /zwW/uIQa//rcBYAvgAaMm9QeY0m9ja53DPoJ5MHMZWcxZCm0bsbUlSgZYZdA4eGLlMC
         4jh7cxPXlcGIph1dCZI01uPlkxArZsGgzIrNGSYVNw6NQnDYKEtf0nYiMZgWvfhPJSNC
         5LsYbjJxlZCl8YDsfh8HStn9tQLLfal9ziT+NcJl352TIQJJ12IGnM64EYLx5fFjL3xi
         WPYJ9RUs7uqMtlUSz64Oxl+WnImg6ruvShb0p1+UsomTopuMJ65QCqozZnoLqxB/SY3G
         DeHw==
X-Gm-Message-State: AOAM530HU/PSiuJLRfv6ZfZeoaFSKhwGI0Z665Y2FMI2rgsNj7O3zAkt
        V6YUwU+HNEZSLfVG+ZTcnsyo2dsOZHUjq79qhwyxtADNYxc=
X-Google-Smtp-Source: ABdhPJywyJKb0gjcxY0LRKIfM1O6u4fLaHWi5CAkdj94OJ52lwNB+oaKhpjcDYuRsztD1B6JzmE825MHdCQmsIJCuus=
X-Received: by 2002:a67:ef0e:: with SMTP id j14mr41333vsr.40.1616424238569;
 Mon, 22 Mar 2021 07:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210322141417.1062111-1-geert@linux-m68k.org>
In-Reply-To: <20210322141417.1062111-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 22 Mar 2021 15:43:47 +0100
Message-ID: <CAMuHMdVvCGa6SaumOOA-hM=WDEb7WHgXTNRsTrU=BnCXGqcr2g@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.12-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Gary Guo <gary@garyguo.net>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        linux-um <linux-um@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 3:16 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.12-rc4[1] to v5.12-rc3[3], the summaries are:
>   - build errors: +6/-2

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b/ (all 192 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/1e28eed17697bcf343c6743f0028cc3b5dd88bf0/ (all 192 configs)

> 6 error regressions:
>   + error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
>   + error: modpost: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emaclite.ko] undefined!:  => N/A
>   + error: modpost: "devm_of_iomap" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
>   + error: modpost: "devm_platform_ioremap_resource" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
>   + error: modpost: "devm_platform_ioremap_resource_byname" [drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A

x86_64/um-allmodconfig

>   + error: rk3399_gru_sound.c: relocation truncated to fit: R_NDS32_WORD_9_PCREL_RELA against `.text':  => (.text+0x6a8)

nds32le-gcc8/nds32-allyesconfig

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
