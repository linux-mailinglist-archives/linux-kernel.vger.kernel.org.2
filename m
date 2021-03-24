Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734EC347C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 16:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbhCXPVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 11:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbhCXPVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 11:21:20 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBDDC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:21:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id n138so32547841lfa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 08:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3XcQtBW2pWb3U+df3ex1+Hhi50G51wTIprzcAH+EBJQ=;
        b=CDl64vzfljKg43qIelbz0cgBgakJdVgrQU91jH5/QDV5ZussvDriYPMSLrINiJzE9h
         fC6WnXJ5dNjcMeQh9E9PJmdPf7kSnO2kH8FwcQerVDRP9vyO8yqXubTzIJjQumFEsbiU
         dwN5vA/4omeE1nbR2sgTaU/VeKGpNe+ijGTo0uCQLOqBlOb2D73h6SUsS8cjw8epSuSd
         0KBXxutsRHn4qeJrz5spQHcN6sBIhizC4JdPKqTW01hx93uI2oFz13UUPFd5HgrvN3Fu
         p+WigmTCnUSPaFG/l5XEOZmf4JQtwtxQaUNVKpCy1QxSdHAy3OUXwZ8wC+BRfyiLJlmK
         V9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3XcQtBW2pWb3U+df3ex1+Hhi50G51wTIprzcAH+EBJQ=;
        b=ELUlVF1XKax9sY+XhuIpZSSYrtvIa3D2+gq2d+A9g+DsPFt946Iz+3m6J2DOTx+4CB
         ltwgB8LefVVMQy5Ho4X5FaFFejkY65xks4TsiK7jhdVM+oEVUEQBKC4efueLePMpgOVz
         G2zISnBcWXMOVL0JxCKInazh/YBlgjNPpRL26LW3s1mbRF1ZlSjdXRDK7mqUPDZfb8CX
         k4r7NTLXx3HSB/bih9KURwlFZ/dZWPBg450sUYf5GKrToMBHfPvxzrgQUicKVrpmco6E
         9cm+R5DyhFJTi3O0QNsk/z/30hxx+bpA3birnwPmDiISafq3aLGznKHohLJBeny3Tu4I
         4OWw==
X-Gm-Message-State: AOAM532svPbbI2SaoQLBmWUiS63VrIqjY6VYhmv/NiN2Q0YdTcALyxCK
        SAOJIVKRIbABmcUh90vrknWTF44mdJzkOIm1nGKWzg==
X-Google-Smtp-Source: ABdhPJwFHy/BR75zWE4kd73NiY96ZW993iszaMZ//vKc+0dkRh8vhv8zydS7tEGsS/+YcXIHE3UVELb7j70okvWkdBc=
X-Received: by 2002:ac2:5a0b:: with SMTP id q11mr2273174lfn.391.1616599278269;
 Wed, 24 Mar 2021 08:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210324150312.20535-1-changbin.du@gmail.com>
In-Reply-To: <20210324150312.20535-1-changbin.du@gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 24 Mar 2021 20:51:06 +0530
Message-ID: <CAAhSdy19Tpf1D0Q4V7CF0ZOvksHMXxA2fF3L3J2f_Ka8NZgVAQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: Do not invoke early_init_dt_verify() twice
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 8:33 PM Changbin Du <changbin.du@gmail.com> wrote:
>
> In the setup_arch() of riscv, function early_init_dt_verify() has
> been done by parse_dtb(). So no need to call it again. Just directly
> invoke unflatten_device_tree().
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  arch/riscv/kernel/setup.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index f8f15332caa2..2a3d487e1710 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -255,10 +255,7 @@ void __init setup_arch(char **cmdline_p)
>  #if IS_ENABLED(CONFIG_BUILTIN_DTB)
>         unflatten_and_copy_device_tree();
>  #else
> -       if (early_init_dt_verify(__va(dtb_early_pa)))
> -               unflatten_device_tree();
> -       else
> -               pr_err("No DTB found in kernel mappings\n");
> +       unflatten_device_tree();
>  #endif

The early_init_dt_verify() set he DTB base address in Linux OF.

When parse_dtb() calls early_init_dt_verify(), MMU is enabled but
we have temporary mapping for DTB (i.e. dtb_early_va).

After paging_init(), we have moved to final swapper_pg_dir so
temporary mapping for DTB does not exists anymore but DTB
is at same physical address so update DTB base address in
Linux OF by calling early_init_dt_verify() again.

Based on above, NACK to this patch.

Regards,
Anup

>         misc_mem_init();
>
> --
> 2.30.2
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
