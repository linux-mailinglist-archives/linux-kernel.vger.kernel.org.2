Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB22330BD3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 11:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbhCHKzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 05:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhCHKzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 05:55:13 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AC0C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 02:55:13 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id d15so10947547wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 02:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDjtQNZmAQRPgQIJYVRtA4TD1wRJeRY/dIfm2pzVt5g=;
        b=TSg+/m/5UJGeJ9QQlUITU26UTedPS5x8JOFoSSBWAHRXgDJ7pYCIHhPRe2W5FnvzyF
         q1Dib0oqd1htD8PjdT9JjI5ZcsgeBtbxZqeCRHOfcb9PFw9IY1SAc7NNHAvCgUsq9JPP
         gUluhBJCV6iaBSFN6BCdx1ZXRoOL1X5E43wLU/G3PtaByAW5Xy7MUf4iHBb53XZHVoD0
         bV9cdkJY9gERa3yDgr+stdLQFNJ2kTVWC09m+c8xgqRwyomAONNoTlznS180sj2TK6V1
         6pHvK3xMjVfZ1PcWAF5bP81dgxmjy2ppGJ0FC1PGbMP7Xcn5EGPLw0TxdXEEJSFQF+PG
         jVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDjtQNZmAQRPgQIJYVRtA4TD1wRJeRY/dIfm2pzVt5g=;
        b=VugCpYCF3cCz4HZlLqvfhYSeJu8uVhElkfUP+XqyD8OmHAylhUntBqz9qzEGlCWH60
         2MaUJoCucVTyX9NeIVucEBY4243skBlCaXYFsF+Q4ueAlCcS3FBYTb/qhKtXWEZXItoo
         ogOgVvAdJq3UfcTTGmBTsBv1l9UaWRX+L6NARqdahSohWN3JKH9UiLIDjB+3stydGDKe
         +ylaaUzlfw9hzbIpCwf4r4DsmHv6OEkRQ1l6SXvuODhrRfLee7EQtaz7SdrAWzrMP2kq
         k+enPeeipCRlHkMiPgNkNmNpmdWcVJA3H3pg44M2dFkBgKQZVthE6n1kuxQdV73vRUzw
         c/ZQ==
X-Gm-Message-State: AOAM532wxNbc48apDNLL1i6UC7NwDZ6efeToopd1gJus3XIq/jhYhCdi
        znLLdgqc3QXhCpRDI6oNX9+gKla1dDXilMLWGvtWaA==
X-Google-Smtp-Source: ABdhPJygCB3fUFIehXjPU8MeAgxahflyzP+92sMDWJ6zTyOenQjK7gp6Cc16xo7AGfaG4zK3TMJqmTo0XiPAZpxoBnQ=
X-Received: by 2002:adf:d236:: with SMTP id k22mr22289991wrh.144.1615200911703;
 Mon, 08 Mar 2021 02:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20210306054801.18263-1-xypron.glpk@gmx.de> <CAAhSdy08=ffPe+fYWX9ds4wNSMU3uzT8OENk0o93xpfZOKtYig@mail.gmail.com>
 <CAOnJCUKSf7tyz+56apVOqxNgnR_eYoidYw5=M2si753t4K71UQ@mail.gmail.com>
In-Reply-To: <CAOnJCUKSf7tyz+56apVOqxNgnR_eYoidYw5=M2si753t4K71UQ@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 8 Mar 2021 16:25:00 +0530
Message-ID: <CAAhSdy0BK9-cG=rQNadbkzDWdXJgpiJ1QEywTgpBxr0NVa7cVQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] RISC-V: correct enum sbi_ext_rfence_fid
To:     Atish Patra <atishp@atishpatra.org>
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

On Mon, Mar 8, 2021 at 1:19 PM Atish Patra <atishp@atishpatra.org> wrote:
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

I would not recommend that because RFENCE is part of the released SBI v0.2 spec.

We have to be more careful in software to follow the spec correctly.

Regards,
Anup

>
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
