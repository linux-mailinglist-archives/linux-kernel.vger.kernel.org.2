Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAACB3308F3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhCHHt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 02:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbhCHHt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:49:26 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5B5C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 23:49:25 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id h18so8028883ils.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 23:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gth1gCIISQPIGjYHZ5BXNzBqWi8Mkfc8Kbu+mcOAfPE=;
        b=HfZFvF2XSNRVonufal1kc0DvF2p3Gh66nT+pbDsujddQ9p/g4kU2dSwCtpCX2/d6HL
         QlQcj/VchwYR2eeplb1yErSjR9ZwimwkyAmF7YqgoZlqi/UxkIlW1XqHMkRND6IfmdEJ
         mxCNs3S3xLYBPrhogpbQMxNnDAl63fiV7nJbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gth1gCIISQPIGjYHZ5BXNzBqWi8Mkfc8Kbu+mcOAfPE=;
        b=ARe1TLY9kiGA3UChlNq23SHrtqsiQom91GEKZwwhB9iosOOImfPd3954yAMKYLCL6J
         LIajWXSqeVT3MO7hSoj7Q/AWgDd4a75vJ3W//mLIVQlSPAo2oqt9UQ0GGtLBeTp7/iuq
         sFLhHDZKr+XL5W+xSPpDrvGjngYmd5aOHkrzy+2CwpqY4QhtsmxurjDC1UBKc3jZZ5NC
         A04P+9v/5luVm0hFx7zFzKeX0V7fEXwRsaKDQXH//I5TLNowbApPjAfKj5YOxhCNKbVI
         I8XSRcls+ShJvb7wlTGvABeSDjxcgSQnkUmNdMhMB12wD/Xe4RN5Au2wAb59aeGWLRje
         wc0g==
X-Gm-Message-State: AOAM5330Ct8e8rtpjxCZ8unoDlJEcftFQ0T7w+ArU0YtOStHe54yyne8
        X+9jeMzK3EIFBX/kOh5xwbrVAh/qa256ivCCWOVN
X-Google-Smtp-Source: ABdhPJxjAor9yYjsUhdBV/HVCCasEmP9AYPH14lOkpHfYjd6oMChV1iQqlGLualYluoFy/YUURtEudLOLn6020KRlk4=
X-Received: by 2002:a92:b50e:: with SMTP id f14mr18173718ile.77.1615189764326;
 Sun, 07 Mar 2021 23:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20210306054801.18263-1-xypron.glpk@gmx.de> <CAAhSdy08=ffPe+fYWX9ds4wNSMU3uzT8OENk0o93xpfZOKtYig@mail.gmail.com>
In-Reply-To: <CAAhSdy08=ffPe+fYWX9ds4wNSMU3uzT8OENk0o93xpfZOKtYig@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Sun, 7 Mar 2021 23:49:13 -0800
Message-ID: <CAOnJCUKSf7tyz+56apVOqxNgnR_eYoidYw5=M2si753t4K71UQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] RISC-V: correct enum sbi_ext_rfence_fid
To:     Anup Patel <anup@brainfault.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
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

On Sat, Mar 6, 2021 at 4:12 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Sat, Mar 6, 2021 at 11:19 AM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > The constants in enum sbi_ext_rfence_fid should match the SBI
> > specification. See
> > https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc#78-function-listing
> >
> > | Function Name               | FID | EID
> > | sbi_remote_fence_i          |   0 | 0x52464E43
> > | sbi_remote_sfence_vma       |   1 | 0x52464E43
> > | sbi_remote_sfence_vma_asid  |   2 | 0x52464E43
> > | sbi_remote_hfence_gvma_vmid |   3 | 0x52464E43
> > | sbi_remote_hfence_gvma      |   4 | 0x52464E43
> > | sbi_remote_hfence_vvma_asid |   5 | 0x52464E43
> > | sbi_remote_hfence_vvma      |   6 | 0x52464E43
> >
> > Fixes: ecbacc2a3efd ("RISC-V: Add SBI v0.2 extension definitions")
> > Reported-by: Sean Anderson <seanga2@gmail.com>
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>
> Good catch.
>
> I guess we never saw any issues because these calls are only used by
> KVM RISC-V which is not merged yet. Further for KVM RISC-V, the HFENCE
> instruction is emulated as flush everything on FPGA, QEMU, and Spike so
> we did not notice any issue with KVM RISC-V too.
>

OpenSBI & Xvisor also define the same order as Linux kernel. The
existing order(in Linux kernel)
makes more sense w.r.to Lexicographic order as well.

Should we just fix the spec instead ?

> Looks good to me.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> Regards,
> Anup
>
> > ---
> >  arch/riscv/include/asm/sbi.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > index 99895d9c3bdd..d7027411dde8 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -51,10 +51,10 @@ enum sbi_ext_rfence_fid {
> >         SBI_EXT_RFENCE_REMOTE_FENCE_I = 0,
> >         SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
> >         SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
> > -       SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
> >         SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
> > -       SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
> > +       SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
> >         SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
> > +       SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
> >  };
> >
> >  enum sbi_ext_hsm_fid {
> > --
> > 2.30.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
