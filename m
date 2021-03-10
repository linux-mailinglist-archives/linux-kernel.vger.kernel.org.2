Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC89333453
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 05:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhCJEUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 23:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhCJETp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 23:19:45 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2BCC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 20:19:45 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id e10so20829854wro.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 20:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/p0KuSPe4AewqG1pG39BWFzJEi5DTd/uGT8+3t0pQ4s=;
        b=wzSOWnFqoa+NuVB4+F33FDM9Uy0WyHMqhhjElM7FyAAMNWbxEnRiRlsoY5O7Et2eBL
         CSV5hAf3l0XTGGv8dTwGo/Jk+f78zd0x/7X/X6pWgRHSmg/+zVyBCU+o1T4cq8yhvw0z
         3YdHIXKOQS6MqSuVZ4Gf/DVGX51+OSlyuETJUkt186kvPJ9xhGRrEeOLHroxnzAPVaKN
         598UwszJRzw+F16sTqUnW7c21eW/QQe+qjZouLl832JJ8VN5UzApGL/6I71D0kZEOscP
         XDP+6MS+rXaBN9h3vPzdlrWGRWfGAa4MjMTKNhZ95VNobjHRSHn0av4RIF2uXuitE0Vl
         JBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/p0KuSPe4AewqG1pG39BWFzJEi5DTd/uGT8+3t0pQ4s=;
        b=LjymKt3+pTHXNigLzWpsoS/nPUb0e5Ijj217dlSkLRQZMhZfN9QCxvjmGzg3LSzQdq
         SF+ivSpu6PLzWJ9wWSxNod3TQ0PzEfeMkY/IIhWw8Ddoju89+CDb1qvzcIA79k0ywsHL
         W0q+BdhIDREYfGzFNAyJys4Rkl1Wd4SkWYswfcYjXIZXiDzfKx1ZYcs1RPrgMXLpCb6v
         r5t5v3cLvbBV64n5o9TQyj044qxOXoaiL1FYuomXuO9YF9F6tD7nMdIZ9/t3gMHxXrQ7
         Ie8EdPYgcb+9imguj4eNbPEFyisF2ahxsK3bEMcNdIGKb/if/CAbsv4iZfHTvpHsrhV5
         DqNQ==
X-Gm-Message-State: AOAM533BbYjDZlFPH+CHlbDE6bOYjZQlAj/gqQ/jyyVb4eiRHuao3Fco
        azUc1xIPr5ggQRyVBxfGxd5mqpkST/9PlkjN5vpTow==
X-Google-Smtp-Source: ABdhPJwuCSK4f2a+l4f8GIZ/CJCl/ameu8S9lv1R6o/2kFPYQA/m+ZJ9odXGzgKg/6WMvkhYdb53GzUPC2qkrJ+N04k=
X-Received: by 2002:adf:8545:: with SMTP id 63mr1197067wrh.128.1615349983905;
 Tue, 09 Mar 2021 20:19:43 -0800 (PST)
MIME-Version: 1.0
References: <20210301115833.382364-1-anup.patel@wdc.com> <mhng-c42c46e0-4715-4630-9a28-02a1515dbcb0@penguin>
In-Reply-To: <mhng-c42c46e0-4715-4630-9a28-02a1515dbcb0@penguin>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 10 Mar 2021 09:49:32 +0530
Message-ID: <CAAhSdy2EHpbXXzA_7C4kvdmkkfX=G2jarARv3eimp3oQ+ywUvg@mail.gmail.com>
Subject: Re: [PATCH v4] RISC-V: Use SBI SRST extension when available
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 8:31 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Mon, 01 Mar 2021 03:58:33 PST (-0800), Anup Patel wrote:
> > The SBI SRST extension provides a standard way to poweroff and
> > reboot the system irrespective to whether Linux RISC-V S-mode
> > is running natively (HS-mode) or inside Guest/VM (VS-mode).
> >
> > The SBI SRST extension is available in latest SBI v0.3-draft
> > specification at: https://github.com/riscv/riscv-sbi-doc.
> >
> > This patch extends Linux RISC-V SBI implementation to detect
> > and use SBI SRST extension.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  arch/riscv/include/asm/sbi.h | 16 ++++++++++++++
> >  arch/riscv/kernel/sbi.c      | 41 +++++++++++++++++++++++++++++++++---
> >  2 files changed, 54 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > index 99895d9c3bdd..8add0209c9c7 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -27,6 +27,7 @@ enum sbi_ext_id {
> >       SBI_EXT_IPI = 0x735049,
> >       SBI_EXT_RFENCE = 0x52464E43,
> >       SBI_EXT_HSM = 0x48534D,
> > +     SBI_EXT_SRST = 0x53525354,
> >  };
> >
> >  enum sbi_ext_base_fid {
> > @@ -70,6 +71,21 @@ enum sbi_hsm_hart_status {
> >       SBI_HSM_HART_STATUS_STOP_PENDING,
> >  };
> >
> > +enum sbi_ext_srst_fid {
> > +     SBI_EXT_SRST_RESET = 0,
> > +};
> > +
> > +enum sbi_srst_reset_type {
> > +     SBI_SRST_RESET_TYPE_SHUTDOWN = 0,
> > +     SBI_SRST_RESET_TYPE_COLD_REBOOT,
> > +     SBI_SRST_RESET_TYPE_WARM_REBOOT,
> > +};
> > +
> > +enum sbi_srst_reset_reason {
> > +     SBI_SRST_RESET_REASON_NONE = 0,
> > +     SBI_SRST_RESET_REASON_SYS_FAILURE,
> > +};
> > +
> >  #define SBI_SPEC_VERSION_DEFAULT     0x1
> >  #define SBI_SPEC_VERSION_MAJOR_SHIFT 24
> >  #define SBI_SPEC_VERSION_MAJOR_MASK  0x7f
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index f4a7db3d309e..49155588e56c 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -7,6 +7,7 @@
> >
> >  #include <linux/init.h>
> >  #include <linux/pm.h>
> > +#include <linux/reboot.h>
> >  #include <asm/sbi.h>
> >  #include <asm/smp.h>
> >
> > @@ -501,6 +502,32 @@ int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
> >  }
> >  EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
> >
> > +static void sbi_srst_reset(unsigned long type, unsigned long reason)
> > +{
> > +     sbi_ecall(SBI_EXT_SRST, SBI_EXT_SRST_RESET, type, reason,
> > +               0, 0, 0, 0);
> > +     pr_warn("%s: type=0x%lx reason=0x%lx failed\n",
> > +             __func__, type, reason);
> > +}
> > +
> > +static int sbi_srst_reboot(struct notifier_block *this,
> > +                        unsigned long mode, void *cmd)
> > +{
> > +     sbi_srst_reset((mode == REBOOT_WARM || mode == REBOOT_SOFT) ?
> > +                    SBI_SRST_RESET_TYPE_WARM_REBOOT :
> > +                    SBI_SRST_RESET_TYPE_COLD_REBOOT,
> > +                    SBI_SRST_RESET_REASON_NONE);
> > +     return NOTIFY_DONE;
> > +}
> > +
> > +static struct notifier_block sbi_srst_reboot_nb;
> > +
> > +static void sbi_srst_power_off(void)
> > +{
> > +     sbi_srst_reset(SBI_SRST_RESET_TYPE_SHUTDOWN,
> > +                    SBI_SRST_RESET_REASON_NONE);
> > +}
> > +
> >  /**
> >   * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
> >   * @extid: The extension ID to be probed.
> > @@ -577,22 +604,30 @@ void __init sbi_init(void)
> >                       sbi_get_firmware_id(), sbi_get_firmware_version());
> >               if (sbi_probe_extension(SBI_EXT_TIME) > 0) {
> >                       __sbi_set_timer = __sbi_set_timer_v02;
> > -                     pr_info("SBI v0.2 TIME extension detected\n");
> > +                     pr_info("SBI TIME extension detected\n");
> >               } else {
> >                       __sbi_set_timer = __sbi_set_timer_v01;
> >               }
> >               if (sbi_probe_extension(SBI_EXT_IPI) > 0) {
> >                       __sbi_send_ipi  = __sbi_send_ipi_v02;
> > -                     pr_info("SBI v0.2 IPI extension detected\n");
> > +                     pr_info("SBI IPI extension detected\n");
>
> These aren't really part of the reset stuff and should be split into a separate
> patch.

Yes, this should be in a separate patch. Thanks for catching.

>
> >               } else {
> >                       __sbi_send_ipi  = __sbi_send_ipi_v01;
> >               }
> >               if (sbi_probe_extension(SBI_EXT_RFENCE) > 0) {
> >                       __sbi_rfence    = __sbi_rfence_v02;
> > -                     pr_info("SBI v0.2 RFENCE extension detected\n");
> > +                     pr_info("SBI RFENCE extension detected\n");
> >               } else {
> >                       __sbi_rfence    = __sbi_rfence_v01;
> >               }
> > +             if (sbi_probe_extension(SBI_EXT_SRST) > 0 &&
> > +                 sbi_minor_version() >= 3) {
> > +                     pr_info("SBI SRST extension detected\n");
> > +                     pm_power_off = sbi_srst_power_off;
> > +                     sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
> > +                     sbi_srst_reboot_nb.priority = 192;
> > +                     register_restart_handler(&sbi_srst_reboot_nb);
> > +             }
> >       } else {
> >               __sbi_set_timer = __sbi_set_timer_v01;
> >               __sbi_send_ipi  = __sbi_send_ipi_v01;
>
> This is fine, but I don't want to take things for draft SBI versions until
> they're at least tagged.

Sure, no problem. The SBI v0.3-rc1 release is quite close so hopefully
in next 1-2 months it will be tagged.

Regards,
Anup
