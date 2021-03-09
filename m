Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72472332F01
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 20:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhCIT3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 14:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhCIT2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 14:28:50 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4324C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 11:28:50 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id o9so15212777iow.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 11:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nRYlUnr4w7NdPjwA3KubW4AmoT2UPgChOLUTL/VtfPk=;
        b=mDWExY0WeRXBWotEc5uhp04JfsILSL83l5gzcO5ozwbdx+tNRC2Laxeiuq3wXWniPp
         ZLay7OdgkMkNqiTs7pwLT4+NmtICkqcCnYGjjRFtZwyZvdMfhdYMGze2N3oGbYdt4qlN
         TpJMQoyTTaMZpyleyudvwlHN0EcxA819hFLEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nRYlUnr4w7NdPjwA3KubW4AmoT2UPgChOLUTL/VtfPk=;
        b=FERRNMlzN6m02QUopS2dSOTMWJRlkG3UjnOJ3YpD2Kj1VhJ+Cm21XgGTdmUvvlGz3z
         T1wT0z7l8M3VcR1FsIZY/twxAS8lXPP6N536Mts6tASVw0PmzIiwP+o+4yQI6VVw16F6
         CwbfgLwm8AamIetMnqGU3U6aZv42qKs1My3NFqiGQ6V1AXrZEe30DeFp+9UxzN/rSGwK
         QhYHA1CUUEJQJSlCD/shfyCsuyG2kinfc5EdpnhKBJZngSSaa2KQz3EjMqJjDBY0gtjs
         KKnEhCE17teFieeXG5qp2rEuTtMhpjnYmRZWIuNyVBPuj5XC//VTtse5Fy35YNJ0AlDK
         EGVQ==
X-Gm-Message-State: AOAM5307VtY+he6C7kGtIip2qtSXLtPELxsxD0HWyFDpJJw4aQOMaazw
        NsGu4FPE5KVuvNvMssFUzsUNnEDaKx3Tn6r3kTl1
X-Google-Smtp-Source: ABdhPJwIBdQakNebnCSBhk098vcMEWn4jLnzAAmDr517Q+l5TiLHXWdQ/qgox1OAsDHx/ECJ9CC4xacN27xLm298AZQ=
X-Received: by 2002:a6b:3c1a:: with SMTP id k26mr24050777iob.113.1615318130243;
 Tue, 09 Mar 2021 11:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20210306054801.18263-1-xypron.glpk@gmx.de> <CAAhSdy08=ffPe+fYWX9ds4wNSMU3uzT8OENk0o93xpfZOKtYig@mail.gmail.com>
 <CAOnJCUKSf7tyz+56apVOqxNgnR_eYoidYw5=M2si753t4K71UQ@mail.gmail.com> <CAAhSdy0BK9-cG=rQNadbkzDWdXJgpiJ1QEywTgpBxr0NVa7cVQ@mail.gmail.com>
In-Reply-To: <CAAhSdy0BK9-cG=rQNadbkzDWdXJgpiJ1QEywTgpBxr0NVa7cVQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 9 Mar 2021 11:28:39 -0800
Message-ID: <CAOnJCULZFHPPXhL5ZyH9qNfb5BgUHos1PU2q6Khb7uT=N-7a3w@mail.gmail.com>
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

On Mon, Mar 8, 2021 at 2:55 AM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Mar 8, 2021 at 1:19 PM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Sat, Mar 6, 2021 at 4:12 AM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Sat, Mar 6, 2021 at 11:19 AM Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > >
> > > > The constants in enum sbi_ext_rfence_fid should match the SBI
> > > > specification. See
> > > > https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc#78-function-listing
> > > >
> > > > | Function Name               | FID | EID
> > > > | sbi_remote_fence_i          |   0 | 0x52464E43
> > > > | sbi_remote_sfence_vma       |   1 | 0x52464E43
> > > > | sbi_remote_sfence_vma_asid  |   2 | 0x52464E43
> > > > | sbi_remote_hfence_gvma_vmid |   3 | 0x52464E43
> > > > | sbi_remote_hfence_gvma      |   4 | 0x52464E43
> > > > | sbi_remote_hfence_vvma_asid |   5 | 0x52464E43
> > > > | sbi_remote_hfence_vvma      |   6 | 0x52464E43
> > > >
> > > > Fixes: ecbacc2a3efd ("RISC-V: Add SBI v0.2 extension definitions")
> > > > Reported-by: Sean Anderson <seanga2@gmail.com>
> > > > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > >

Reviewed-by: Atish Patra <atish.patra@wdc.com>

> > > Good catch.
> > >
> > > I guess we never saw any issues because these calls are only used by
> > > KVM RISC-V which is not merged yet. Further for KVM RISC-V, the HFENCE
> > > instruction is emulated as flush everything on FPGA, QEMU, and Spike so
> > > we did not notice any issue with KVM RISC-V too.
> > >
> >
> > OpenSBI & Xvisor also define the same order as Linux kernel. The
> > existing order(in Linux kernel)
> > makes more sense w.r.to Lexicographic order as well.
> >
> > Should we just fix the spec instead ?
>
> I would not recommend that because RFENCE is part of the released SBI v0.2 spec.
>

Fair enough.

> We have to be more careful in software to follow the spec correctly.
>

Agreed. Apologies for the slip up.

> Regards,
> Anup
>
> >
> > > Looks good to me.
> > >
> > > Reviewed-by: Anup Patel <anup@brainfault.org>
> > >
> > > Regards,
> > > Anup
> > >
> > > > ---
> > > >  arch/riscv/include/asm/sbi.h | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > > > index 99895d9c3bdd..d7027411dde8 100644
> > > > --- a/arch/riscv/include/asm/sbi.h
> > > > +++ b/arch/riscv/include/asm/sbi.h
> > > > @@ -51,10 +51,10 @@ enum sbi_ext_rfence_fid {
> > > >         SBI_EXT_RFENCE_REMOTE_FENCE_I = 0,
> > > >         SBI_EXT_RFENCE_REMOTE_SFENCE_VMA,
> > > >         SBI_EXT_RFENCE_REMOTE_SFENCE_VMA_ASID,
> > > > -       SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
> > > >         SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA_VMID,
> > > > -       SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
> > > > +       SBI_EXT_RFENCE_REMOTE_HFENCE_GVMA,
> > > >         SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
> > > > +       SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA,
> > > >  };
> > > >
> > > >  enum sbi_ext_hsm_fid {
> > > > --
> > > > 2.30.1
> > > >
> > > >
> > > > _______________________________________________
> > > > linux-riscv mailing list
> > > > linux-riscv@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
> > --
> > Regards,
> > Atish



-- 
Regards,
Atish
