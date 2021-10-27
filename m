Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F9A43D5B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 23:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhJ0Va6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 17:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbhJ0Vaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:30:35 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459D5C0431B6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 14:22:25 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h193so4274044pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 14:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Cg/j8P5uXcrTRk8plQU0l3GmOiPBDd+Pj7xWYOIDOEI=;
        b=VBNZsF6NQ/ixkGxYASj3KC/GEuP/y6W6CeLxaRis7vuzluAaL6G/w5E5vMRHPhrx8i
         dld3o18CI4Dc4Zdty9h7juuD08X/s7KtxKBElkdClTA46jAqYTo/OX6cybIMvoYsCMtk
         SF0aZUSuBjvp/yyjfTdF+qzqoZpOF2aTTy2QrugdZU7sWsaJspce9kW6CPrQ0WgQzFSM
         ponX13Hk+O+ndH/cBZk8LL66ZTm+IEdY/ZTN34X1GsodG71xjzY2Nu47zvqqzsiOSrxf
         OzWnl42d5ZveG2FvNY7uBIzZG4JD6Zzp0bmBPnQQsZ/guIHwtGo8VyH14B6kY1c5CSB9
         Ywng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Cg/j8P5uXcrTRk8plQU0l3GmOiPBDd+Pj7xWYOIDOEI=;
        b=AgqK1UCL39ReNMHOmZ90+fNitPiqlP/ne0iyk+k0Delpf8G1IEWGEQK+Gr6ojeYUwm
         hSgRASVUeWJjbH6pMiSPiI41qiKepHzmbwV/z0MAheiM8MsuMxW1KTs+K68+H9LyyoJb
         vlfUXTp3RZGQuUu+RsBa9llN3FoEXTwSPsH/k+SgepA/ue+v9ObDIll7obnhlDwX1OBQ
         12cOhry9QO8AO1AqufuEtOZo2/v0D2swzNminti6cCqvq4ER4EqQu4tF2iIdG46Ud/5/
         njOCM4AgH1SB4hgzoQKkRW2qM9PMFiuvESQyHNEd8yH/yJCqFzq+AwbdSk349cr5Q+28
         vgKA==
X-Gm-Message-State: AOAM530S+CYpGxmUO5xnej6QngPYC0zz48mKPSKmATeOHRjp7rHGXAM4
        hKRZtwYV3gD4+KFeiJKiJQYmdw==
X-Google-Smtp-Source: ABdhPJwlysZ71JpZ1NP3hVtYloRcJHriqqc67RvJogbCqmKB8hmG0g5dJe7cBf/N99WVwxSAx5uJ6g==
X-Received: by 2002:a05:6a00:1945:b0:44c:a955:35ea with SMTP id s5-20020a056a00194500b0044ca95535eamr99825pfk.85.1635369744673;
        Wed, 27 Oct 2021 14:22:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:5e10:d96b:421d:2a73:9190])
        by smtp.gmail.com with ESMTPSA id z22sm928252pfe.1.2021.10.27.14.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:22:24 -0700 (PDT)
Date:   Wed, 27 Oct 2021 14:22:24 -0700 (PDT)
X-Google-Original-Date: Wed, 27 Oct 2021 14:12:08 PDT (-0700)
Subject:     Re: [PATCH] riscv: fix misalgned trap vector base address
In-Reply-To: <20211018052238.522905-1-181250012@smail.nju.edu.cn>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        alex@ghiti.fr, vitaly.wool@konsulko.com, anup@brainfault.org,
        seanga2@gmail.com, wangkefeng.wang@huawei.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        yuzihao@ict.ac.cn, 181250012@smail.nju.edu.cn
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     181250012@smail.nju.edu.cn
Message-ID: <mhng-fca625ce-8f29-4e27-8f66-bc70e7cff555@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2021 22:22:38 PDT (-0700), 181250012@smail.nju.edu.cn wrote:
> * The trap vector marked by label .Lsecondary_park should align on a
>   4-byte boundary. If not, CSR_TVEC may be set to an incorrect address.
> * This bug is introduced at commit e011995e826f8 ("RISC-V: Move relocate
>   and few other functions out of __init").
> * This bug is exposed with an educational emualtor.
>
> Signed-off-by: Chen Lu <181250012@smail.nju.edu.cn>
> ---
>  arch/riscv/kernel/head.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index fce5184b22c3..52c5ff9804c5 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -193,6 +193,7 @@ setup_trap_vector:
>  	csrw CSR_SCRATCH, zero
>  	ret
>
> +.align 2
>  .Lsecondary_park:
>  	/* We lack SMP support or have too many harts, so park this hart */
>  	wfi

Thanks, this is on fixes (with some commit message cleanups).
