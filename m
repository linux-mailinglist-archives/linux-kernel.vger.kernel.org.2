Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C16430FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 07:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhJRFd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 01:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhJRFdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 01:33:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8152C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 22:31:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id y3so39199673wrl.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 22:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kalz1nB74nozhEOhe3SpsXwwy/AUBS/hhCESynMhNCg=;
        b=vcm8kDbjfXcP+AsgYBDSK0JwgDRDUKU8iV6wkORf60lcgB+4553Zw9mxIyEuTT+LRR
         N2alooVlhn4UFgX4r09/HpuGxakyiIevsH0F95QXCDEyVBWdaA3A8T0u1VDeGZt0IftK
         5L0sjEgKhVHRD4XE9WDsYZyaSYQa/dw9nE5Kfi6W9XsBcEWiqkS4HTtOmFgcpqBxb9+S
         lPT7a08caCnGFa6qOtK6usXZuD//rIrWyfSpcYXU+W0Knj74pMiCKf3mgbyiO14ZXNrO
         fjQUtfZcAxOI+SEK9PrJ573FueEuFzlXw8XBjMPmTqBX+wLS8DKmBYEvbqeEMvmbkBDt
         SRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kalz1nB74nozhEOhe3SpsXwwy/AUBS/hhCESynMhNCg=;
        b=hVqc9hY2/9ZTSRf7aoDsyxObFVQzT5ocsFDxuOCQGh/retLOsT+tSm0FFzPnEySeSs
         a4BjA/ZufDEFasiyLERZ7842waPvS6k7wYF78JxAWVy81D2JHK4tqeLxPIn4gA6JhBMn
         mG6K3HRVG41TQxu5iqb9oKmGn4YqMMWSUBNJEcqjscDzeHluVd9X5m5EVpN12sf77UB8
         kKK9GI4iNL5foUQYvWRJd9KtH9nr0A2fbAQWYxW+IHTBEmS65atn72N3QK7CXwOeT3Na
         By+JbJp+MaaKwuVdNKiTOEeF3UtCR7OLVDXL+e6Uuq2NRr2RC+zwsN/CC2sxmUpqDye5
         m0mA==
X-Gm-Message-State: AOAM530ykNouehE8gZiwlCoi6XnHa2bLoXmWwsIT+Th2MSNEZXS37HP4
        izd1gm+CINBX7pkok0CaNlLpOMaF/gtwksXIKXbD6g==
X-Google-Smtp-Source: ABdhPJwk8c07pKaRMyt6V2ad1dl0e3RpJwQZ4NmkrRHE0QTXVoEocZD651tPbUlpLVG18tBS8aFKk9CL8zyHqFQhh9I=
X-Received: by 2002:adf:e60a:: with SMTP id p10mr32309485wrm.306.1634535100133;
 Sun, 17 Oct 2021 22:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20211018052238.522905-1-181250012@smail.nju.edu.cn>
In-Reply-To: <20211018052238.522905-1-181250012@smail.nju.edu.cn>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 18 Oct 2021 11:01:28 +0530
Message-ID: <CAAhSdy3-hgdSH-B1cfO6C+5Fi-_DX8-ycRHi_ovVOzae1sRGzA@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix misalgned trap vector base address
To:     Chen Lu <181250012@smail.nju.edu.cn>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Sean Anderson <seanga2@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Zihao Yu <yuzihao@ict.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 10:52 AM Chen Lu <181250012@smail.nju.edu.cn> wrote:
>
> * The trap vector marked by label .Lsecondary_park should align on a
>   4-byte boundary. If not, CSR_TVEC may be set to an incorrect address.
> * This bug is introduced at commit e011995e826f8 ("RISC-V: Move relocate
>   and few other functions out of __init").
> * This bug is exposed with an educational emualtor.
>

Please add "Fixes:" line here.

> Signed-off-by: Chen Lu <181250012@smail.nju.edu.cn>

Otherwise it looks good to me.

Reviewed-by: Anup Patel <anup.patel@wdc.com>

Regards,
Anup

> ---
>  arch/riscv/kernel/head.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index fce5184b22c3..52c5ff9804c5 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -193,6 +193,7 @@ setup_trap_vector:
>         csrw CSR_SCRATCH, zero
>         ret
>
> +.align 2
>  .Lsecondary_park:
>         /* We lack SMP support or have too many harts, so park this hart */
>         wfi
> --
> 2.30.2
>
>
>
