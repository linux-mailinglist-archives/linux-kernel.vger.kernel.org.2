Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD37423C6B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 13:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbhJFLPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 07:15:47 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:45508
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238365AbhJFLPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 07:15:13 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9D6053FFD9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 11:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633518800;
        bh=FQo5Kx8XCwauwMhzMY/SvsywDQBLFcLxvkhl3IdJs2w=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ULaUQ5yCODt/1km9uDq332f2layZUPs5dyKAdFGY/lItiNGv0Zl46TZC/tDWf/Vis
         YiePZCvoyc/dudSluJHF040ntMrVQl6ScNNSAeDbGi55lJ9TD1q9Knni7PVMT0ab9i
         +Cg+Slih7l4uRoesOFEYHtZVcRfasg05CEU8vElzjVFxLMSn4/hqhr9BAYqm2eh/g/
         tuoWSsyYFsuXWknOdfL9Ay3YE8BLj5RhyKPbh2nu97RcAiSK/tmHFktwhxsYOeGi8Z
         2IwDQZyIQOzA2EtOhi7Tz2RjZv9lc6rIsldFMybR7dZTv6ilVRzqi3atgrckbdeKBJ
         0blUu1hfwahLQ==
Received: by mail-ed1-f70.google.com with SMTP id x5-20020a50f185000000b003db0f796903so2270002edl.18
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 04:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQo5Kx8XCwauwMhzMY/SvsywDQBLFcLxvkhl3IdJs2w=;
        b=dDLwoL3O2Je9j81vl46+V5kGT6reMfK0eYWIniMsRZvW6ZCCax9YCY4Co+J9DlbK0z
         co4qr4vvVswE37Qk+6SvGHkGhse62I46VZe18tn2fWy7RajSpEZ2hWJ6hDuH8lLTPOkU
         4flX6/MEHxbSy+E21r02nyDe4jkgfE3Y19Ec5v96Jt/SBVoS5LSMO4CVdqPixIMAhrZ7
         qpSFsfxGEcQO/g8q3rNfOQPt/L8274BYqSYBVFRZlEcjfpSBInbs0dZN0OtNln3WzL9e
         yoNNVpEj+cixX7eXRsQWXWxFTR345I5MWYP1GoIMQ6NrGkM7uyVShOUzy7JtWyXhSt/5
         kEYg==
X-Gm-Message-State: AOAM531LTeEIGzAprDa1PxRAhowpD6J142eoEfhEE62MRBEibYGd/G/x
        5k6JpCUVaf/SNyragCCGUlLDFmy8d1s+2k+mxiPYAhHpJYNnQt/VK3cNofvREHZXLH6/9F4hj1j
        9kmTDDWeuYuRj0RJ7oFvooQ5reDpsbmNeqrpMLpIkXUhqj5uKSb29hAnmPw==
X-Received: by 2002:a17:906:158f:: with SMTP id k15mr32331936ejd.241.1633518799064;
        Wed, 06 Oct 2021 04:13:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw56RUWH3Ln9NmpWaSYjcwQWjjBmf/3L/T9WfjOSw9pUapVbZEPGUuOtn1C5DuHF6x0/CwjRTyEfj884yGdH28=
X-Received: by 2002:a17:906:158f:: with SMTP id k15mr32331806ejd.241.1633518797854;
 Wed, 06 Oct 2021 04:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211002122026.1451269-1-mick@ics.forth.gr>
In-Reply-To: <20211002122026.1451269-1-mick@ics.forth.gr>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Wed, 6 Oct 2021 13:13:07 +0200
Message-ID: <CA+zEjCtJqNVrtr_Wkij2c=3+P5kL6jJN5RPULfZj2c5mGzCVjw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Don't use va_pa_offset on kdump
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 2, 2021 at 2:23 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> On kdump instead of using an intermediate step to relocate the kernel, that
> lives in a "control buffer" outside the current kernel's mapping, we jump
> to the crash kernel directly by calling riscv_kexec_norelocate(). The
> current implementation uses va_pa_offset while switching to physical
> addressing, however since we moved the kernel outside the linear mapping
> this won't work anymore since riscv_kexec_norelocate() is part of the
> kernel mapping and we should use kernel_map.va_kernel_pa_offset, and also
> take XIP kernel into account.
>
> We don't really need to use va_pa_offset on riscv_kexec_norelocate, we can
> just set STVEC to the physical address of the new kernel instead and let
> the hart jump to the new kernel on the next instruction after setting
> SATP to zero. This fixes kdump and is also simpler/cleaner.
>
> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> ---
>  arch/riscv/kernel/kexec_relocate.S | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/arch/riscv/kernel/kexec_relocate.S b/arch/riscv/kernel/kexec_relocate.S
> index a80b52a74..e2f34196e 100644
> --- a/arch/riscv/kernel/kexec_relocate.S
> +++ b/arch/riscv/kernel/kexec_relocate.S
> @@ -159,25 +159,15 @@ SYM_CODE_START(riscv_kexec_norelocate)
>          * s0: (const) Phys address to jump to
>          * s1: (const) Phys address of the FDT image
>          * s2: (const) The hartid of the current hart
> -        * s3: (const) kernel_map.va_pa_offset, used when switching MMU off
>          */
>         mv      s0, a1
>         mv      s1, a2
>         mv      s2, a3
> -       mv      s3, a4
>
>         /* Disable / cleanup interrupts */
>         csrw    CSR_SIE, zero
>         csrw    CSR_SIP, zero
>
> -       /* Switch to physical addressing */
> -       la      s4, 1f
> -       sub     s4, s4, s3
> -       csrw    CSR_STVEC, s4
> -       csrw    CSR_SATP, zero
> -
> -.align 2
> -1:
>         /* Pass the arguments to the next kernel  / Cleanup*/
>         mv      a0, s2
>         mv      a1, s1
> @@ -214,6 +204,11 @@ SYM_CODE_START(riscv_kexec_norelocate)
>         csrw    CSR_SCAUSE, zero
>         csrw    CSR_SSCRATCH, zero
>
> +       /* Switch to physical addressing */
> +       csrw    CSR_STVEC, a2
> +       csrw    CSR_SATP, zero
> +
> +       /* This will trigger a jump to CSR_STVEC anyway */
>         jalr    zero, a2, 0

The last jump to a2 can be removed since the fault will be triggered
before even reaching this instruction.

>  SYM_CODE_END(riscv_kexec_norelocate)
>
> --
> 2.32.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

This patch fixes a regression introduced when moving the kernel to the
end of the address space, so we should add:
Fixes: 2bfc6cd81bd1 ("riscv: Move kernel mapping outside of linear mapping")

And it should be backported to 5.13 and 5.14. It seems that the
following tags should be enough:

Cc: <stable@vger.kernel.org> # 5.13
Cc: <stable@vger.kernel.org> # 5.14

And finally, you can add:

Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>

Thanks,

Alex
