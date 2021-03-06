Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D17E32FA73
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 13:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhCFMMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 07:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhCFMMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 07:12:17 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6381CC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 04:12:16 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id m11so7879676lji.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 04:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6SCt4Ui+oWB0RLaz7Uoac380htVeaF4ZyeG6ZlsBEco=;
        b=qfWkCZuD2BO4ofIxVsNQP5WrvWYTObPEsUcMNlZWxwwg+35XoltNPXcJPnjtSKJOoK
         dQaCUQ+zt9CnUXReJXpUGv/8CsURgGFdc/Qybwmon/0K2QU6hOo9VAVQ1DtR6EllPJS1
         R7lwXk7y6mo4J3GyAjeRJ61XM25j7uVNUI8wqrGr6noXL/dwyzEDmLjizZpVk5bQGcyo
         KcodKupdksLk3XKqFtpJezNxReg0J2DDGMAlcsjlYddCX+iFoTVms3TiK4VER2pTPOXK
         RfCYgmWGRFHDcAYLPTduWQTGooNMSxQbbJaecWotoXv3/i0nj9jC2pGRsozckKhfU4QJ
         oYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6SCt4Ui+oWB0RLaz7Uoac380htVeaF4ZyeG6ZlsBEco=;
        b=DXYqApwAK2taeRLkhHrXlcKhYdXzwU/XFdOiJEN1U8tSz64UaZNgBHit7e4KO+iQJc
         WrEWJBP/NImrVQoxTIpkG5OHPPTQNxZ8xUaHwgRUBfcU9Led5+ZCPsMQZQnnN4lGLOh3
         jQvtnD/wmuHoGL5Wx0kgvtWhvh56/deXgD8ZKxi3QXY7yUDz1buAA6tmHXS1XZ8v8YWf
         JUI4EUv6Ev2btS4mA4Yx8eR67OJ3NFCvrAsmwRF/uCts7TJRdNWkB83Nim8WpujU5fRU
         Gk5iRY07c6eq5SiKBlAzRbLm1zrlfV/tB5ALA1c6Z9G3GH+DIc9fYfd9My7IclWXJpWl
         k7rA==
X-Gm-Message-State: AOAM533ew1fIVOCzEGFY6JMpA0cR4LaD7oExcpBK4nwwJoNAxz3Y4GFC
        GbM8ey7mUutICUskFhx764KUv2Hw580ve5Lcjdj5/IAdbUw=
X-Google-Smtp-Source: ABdhPJxPpRrEZQliL+YGDZbV1sZiRba3nFEAEVdEh/J9SksORZ6w0Sev0ZM9XKRdfSOGSEAhN8lREi2We5AiXXbZj6k=
X-Received: by 2002:a2e:9250:: with SMTP id v16mr8217453ljg.162.1615032733450;
 Sat, 06 Mar 2021 04:12:13 -0800 (PST)
MIME-Version: 1.0
References: <20210306054801.18263-1-xypron.glpk@gmx.de>
In-Reply-To: <20210306054801.18263-1-xypron.glpk@gmx.de>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 6 Mar 2021 17:42:01 +0530
Message-ID: <CAAhSdy08=ffPe+fYWX9ds4wNSMU3uzT8OENk0o93xpfZOKtYig@mail.gmail.com>
Subject: Re: [PATCH 1/1] RISC-V: correct enum sbi_ext_rfence_fid
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 6, 2021 at 11:19 AM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> The constants in enum sbi_ext_rfence_fid should match the SBI
> specification. See
> https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc#78-function-listing
>
> | Function Name               | FID | EID
> | sbi_remote_fence_i          |   0 | 0x52464E43
> | sbi_remote_sfence_vma       |   1 | 0x52464E43
> | sbi_remote_sfence_vma_asid  |   2 | 0x52464E43
> | sbi_remote_hfence_gvma_vmid |   3 | 0x52464E43
> | sbi_remote_hfence_gvma      |   4 | 0x52464E43
> | sbi_remote_hfence_vvma_asid |   5 | 0x52464E43
> | sbi_remote_hfence_vvma      |   6 | 0x52464E43
>
> Fixes: ecbacc2a3efd ("RISC-V: Add SBI v0.2 extension definitions")
> Reported-by: Sean Anderson <seanga2@gmail.com>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Good catch.

I guess we never saw any issues because these calls are only used by
KVM RISC-V which is not merged yet. Further for KVM RISC-V, the HFENCE
instruction is emulated as flush everything on FPGA, QEMU, and Spike so
we did not notice any issue with KVM RISC-V too.

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/include/asm/sbi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 99895d9c3bdd..d7027411dde8 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -51,10 +51,10 @@ enum sbi_ext_rfence_fid {
>         SBI_EXT_RFENCE_REMOTE_FENCE_I = 0,
>         SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
>         SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
> -       SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
>         SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
> -       SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
> +       SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
>         SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
> +       SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
>  };
>
>  enum sbi_ext_hsm_fid {
> --
> 2.30.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
