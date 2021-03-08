Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A59330920
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhCHIEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhCHIDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:03:54 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485B0C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 00:03:54 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id z9so8059111iln.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 00:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35KjzI8H1oyETbm3EJBElOyyMkIyjKEhTf5PaBQsSuc=;
        b=N440It6ZjtVHQoZ0CL+Skb7nhMpnbFvAXTNuFhabhdfJ6oi6sNGZh1UBsx2X4Lfx/s
         h73OpZMkI74nnbntL7In8jM9f2ba8jGZt3vUiF7ZmwQHyemFf5FIwzI6XWrXq6jvcxSo
         y9UtMF+emMvGtGG246bTOyq+xAIENGVbUmGFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35KjzI8H1oyETbm3EJBElOyyMkIyjKEhTf5PaBQsSuc=;
        b=thzmeytXBT6aXMtz4iJxIjRhkfIP89C+TsNLPKop6REOnLumuxdmspe1+5MyYOxF7B
         mp6+EEqgUHvVNC+kVFom+jCZMsTOGS9GxV9V4s959tAG5GuJBeHLC4Yl3SyBYXlJlZIO
         1jxHnvtRy/YXBRZhkU/fZw3EL+pZpERwCLwKg/2IMCyuZEPDYSrwljIM+NuMTjfFjHFF
         c/uUhIy0wAqbuwOUvfQGRoWV2+ZekNaCHbPn/ChlA0a9fKgJ7FTs0vtLQLcFYLbedxsD
         oL+THfLFxvPPKz/WRzMqdNjHOTMENIX4kI8zD7Vq5jZnwmLU/jKQNleXFiNAaZc73Wko
         bLBA==
X-Gm-Message-State: AOAM532S6X+YbSyMj692qFVTc0qS+UJDR2ZtiobYMgwiRwe2X3bMLM0V
        m9Nk76LeuALyNmIBUM0YfkVg5a9gVypP/NQrWCJG
X-Google-Smtp-Source: ABdhPJyWpeO8xW7/Io1AOnJjSnmTXn9rSBGoNREMgoCgZXrtTCvVBdNLrTJboM9G2FxkyI6+OfF2FEHsPleeKbk2ySk=
X-Received: by 2002:a05:6e02:1a68:: with SMTP id w8mr18952717ilv.147.1615190633454;
 Mon, 08 Mar 2021 00:03:53 -0800 (PST)
MIME-Version: 1.0
References: <20210306054801.18263-1-xypron.glpk@gmx.de> <CAAhSdy08=ffPe+fYWX9ds4wNSMU3uzT8OENk0o93xpfZOKtYig@mail.gmail.com>
 <CAOnJCUKSf7tyz+56apVOqxNgnR_eYoidYw5=M2si753t4K71UQ@mail.gmail.com>
In-Reply-To: <CAOnJCUKSf7tyz+56apVOqxNgnR_eYoidYw5=M2si753t4K71UQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 8 Mar 2021 00:03:42 -0800
Message-ID: <CAOnJCU+NKwFdkg3X75opcDK1WHwcaK-MczyJhKCuECf5ydp9rg@mail.gmail.com>
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

On Sun, Mar 7, 2021 at 11:49 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Sat, Mar 6, 2021 at 4:12 AM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Sat, Mar 6, 2021 at 11:19 AM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > The constants in enum sbi_ext_rfence_fid should match the SBI
> > > specification. See
> > > https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc#78-function-listing
> > >
> > > | Function Name               | FID | EID
> > > | sbi_remote_fence_i          |   0 | 0x52464E43
> > > | sbi_remote_sfence_vma       |   1 | 0x52464E43
> > > | sbi_remote_sfence_vma_asid  |   2 | 0x52464E43
> > > | sbi_remote_hfence_gvma_vmid |   3 | 0x52464E43
> > > | sbi_remote_hfence_gvma      |   4 | 0x52464E43
> > > | sbi_remote_hfence_vvma_asid |   5 | 0x52464E43
> > > | sbi_remote_hfence_vvma      |   6 | 0x52464E43
> > >
> > > Fixes: ecbacc2a3efd ("RISC-V: Add SBI v0.2 extension definitions")
> > > Reported-by: Sean Anderson <seanga2@gmail.com>
> > > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> >
> > Good catch.
> >
> > I guess we never saw any issues because these calls are only used by
> > KVM RISC-V which is not merged yet. Further for KVM RISC-V, the HFENCE
> > instruction is emulated as flush everything on FPGA, QEMU, and Spike so
> > we did not notice any issue with KVM RISC-V too.
> >
>
> OpenSBI & Xvisor also define the same order as Linux kernel. The
> existing order(in Linux kernel)
> makes more sense w.r.to Lexicographic order as well.
>
> Should we just fix the spec instead ?
>

We do need to notify RustSBI & Diosix authors about this change in
case we decide to do so.
However, RustSBI added rfence support a few weeks back only [1]. I
could not find any rfence reference in Diosix.
Thus, the impact should be very minimal if the spec is fixed.

[1] https://github.com/luojia65/rustsbi/commit/6e06b4e8e96e05b69157dd5477d433cc932c8a64
> > Looks good to me.
> >
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> >
> > Regards,
> > Anup
> >
> > > ---
> > >  arch/riscv/include/asm/sbi.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > > index 99895d9c3bdd..d7027411dde8 100644
> > > --- a/arch/riscv/include/asm/sbi.h
> > > +++ b/arch/riscv/include/asm/sbi.h
> > > @@ -51,10 +51,10 @@ enum sbi_ext_rfence_fid {
> > >         SBI_EXT_RFENCE_REMOTE_FENCE_I = 0,
> > >         SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
> > >         SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
> > > -       SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
> > >         SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
> > > -       SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
> > > +       SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
> > >         SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
> > > +       SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
> > >  };
> > >
> > >  enum sbi_ext_hsm_fid {
> > > --
> > > 2.30.1
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>
>
> --
> Regards,
> Atish



-- 
Regards,
Atish
