Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015A6308D0F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 20:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhA2TGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 14:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhA2TFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 14:05:54 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6069FC061573
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 11:05:07 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id 16so10432693ioz.5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 11:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P0Q2YwM0Q9fPfFhBWrEuMIdGapoLcfD0AryeJ6s3IjA=;
        b=rV5CaW3gbUWl2EwFuZNzJH9+C49eSAIPUGnQnQWRxa08+o1vgTkEv94GH2IOOYFr+6
         BgseBWLTOxUpQ4F4J04LoV0VbQ23nuiIdWRmQtqc1g95VDFzQlYtc1FShMsuMflOYyyv
         +UGjKjSgnmrKGfj/h9kJD+l7RNcUyxWNIDGMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P0Q2YwM0Q9fPfFhBWrEuMIdGapoLcfD0AryeJ6s3IjA=;
        b=sGTwrFg/NsiAm3qK5eSN6agyxypFrKIhwYgy9l9ko+Xol2MlIY5xuA/sY430JYDKl5
         sQ9paRTp7y9ELVaE6bo6mxjIOQR+oU4jOpIFDxEGWMwRqlSsGL/PLQrnheWCtXMCaftW
         Qp8auDP8+7Z1TiNzB6cLIKu+4uTmDPORdCK1LxENyoq+IyYJ5eWOKhtBmqedkzdgR5ej
         ykd4DR7MXjYc41k3uCqBSlTNvyvl5CmmS9PaQpmt+dqN9pDWUYoIzBPNhbTDvNZXKb9W
         vQo302a3aZ24l7uOOiqH9ZZxepFX7oHL1FBXyw/D5rOTea1M0dTC5/vfK6vGCJxUKWaE
         IazQ==
X-Gm-Message-State: AOAM5321lb+udUUxlHPuEW0CA7aqtNDXG4CR/HyuSNY+3D2Pkf5eCtD8
        wXgQzxz0f8TgaF85WbM/7MpPJLn6u2AaT6L+4zEn
X-Google-Smtp-Source: ABdhPJy1ZbZ+tYdJvQM/DTMXF/T+OYg3kxT2NHTvjsN873ujwbydFJMZoCZB5Svu3gDfqjiVljSyWsNwtjYDn6b6S7U=
X-Received: by 2002:a05:6638:13c6:: with SMTP id i6mr4682079jaj.141.1611947105409;
 Fri, 29 Jan 2021 11:05:05 -0800 (PST)
MIME-Version: 1.0
References: <20210129173105.22020-1-alex@ghiti.fr>
In-Reply-To: <20210129173105.22020-1-alex@ghiti.fr>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 29 Jan 2021 11:04:54 -0800
Message-ID: <CAOnJCUJ3q3uiO__VsfwcmOFhvE6L4=Ht7-KBDuLFfvC8ndSwqA@mail.gmail.com>
Subject: Re: [PATCH] riscv: virt_addr_valid must check the address belongs to
 linear mapping
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, dvyukov@google.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 9:31 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> virt_addr_valid macro checks that a virtual address is valid, ie that
> the address belongs to the linear mapping and that the corresponding
>  physical page exists.
>
> Add the missing check that ensures the virtual address belongs to the
> linear mapping, otherwise __virt_to_phys, when compiled with
> CONFIG_DEBUG_VIRTUAL enabled, raises a WARN that is interpreted as a
> kernel bug by syzbot.
>
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
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
