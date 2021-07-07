Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774C53BF455
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 05:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhGHDyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 23:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhGHDyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 23:54:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1452FC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 20:52:01 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id a13so5609137wrf.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 20:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=duMlAvykKtJsd1YyxKA8stEOfpUjQ4ZLog6TaI0hHCQ=;
        b=VUUXccn1x1bPJmxS+l1ZGcBft3knuFXtb9bL6VTB42ta7crZCYR2qLrHYQ6r0V14il
         5EpGqSTGZ70YuPKT3+69ZfvzQRfIrqk7GwZw72aQEPtIeng50mXiqXGZrxrzjtck4qtU
         n/RCbhL9NDJRIFFaY1gpcN9dYtW5Z6PsnNnBkppqCtyMuZjzoBQvQFKMdbKHoJUNGd2+
         mDF2m9FhRAaOTSlWAlAq7kitJQoMfjYZRq0z2JVk1o6eoSZniODz0EswikwHVD1u/WZU
         EtmdNa5uLhkTNfXrjI5Pj4EZctNSy+/Skf1zmhIMVwAjHT2nudxKZwtYO4ofKb0hD2kZ
         +nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duMlAvykKtJsd1YyxKA8stEOfpUjQ4ZLog6TaI0hHCQ=;
        b=fOOD3AzeM3BE8mWE2IuINA1n2ZGcdhAgUGMZURVK1aYJWutk+GrisH1hx8SOSxwtVw
         Zq7Lp079eqh/VkkPwhxZJOgOvhcduM/9qBP//Ehfvj8jev7XxxRbQJYv6baISCUrOeBe
         /YFHudQSqzHdqH6+sk1Er0ChZsoqjWR6Ksm9OakUA2Id1dI1yMF5qyiUAARha+2Sz6TM
         TEs3w+rN3q0EvHgIHbcfqflKs5ZwuT/+LHJzPlE8OkHnqSgchxa1BdbXfvBN4/K+TWNJ
         PN7M78nfcMdtdmHPrQ1IK5hEDoLNcWHRlqTRXsR50Wfx1PNxJ2gUqfoc4sP+ZJEgJfmf
         R59g==
X-Gm-Message-State: AOAM533Y79sT5VQkOnBRDijAPGSpcy0dVKzbwUaHn6qYLi4Z7EYfFGDv
        WNLVKkws2NAFW25iUpK4zQwdni0JpbyFpwhDS5J4DA==
X-Google-Smtp-Source: ABdhPJy1YpF8rafiUI7/iw1GjU67ogfuTO6JIWE6V8Bp6LLJMFIngdHJNtQzAPFvXBi71daTyLbohMmteyX9oPwCsIQ=
X-Received: by 2002:a5d:4d4b:: with SMTP id a11mr7735425wru.325.1625716320438;
 Wed, 07 Jul 2021 20:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhSdy0=XANwm4Vr5qbpvJdqwYNCfDRNTDf3cyAOGp-NuqF_Ag@mail.gmail.com>
 <mhng-b2af24ea-608a-4e2c-af51-6dc7e415bf30@palmerdabbelt-glaptop>
In-Reply-To: <mhng-b2af24ea-608a-4e2c-af51-6dc7e415bf30@palmerdabbelt-glaptop>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 7 Jul 2021 21:19:46 +0530
Message-ID: <CAAhSdy2TcESa_zfO28VGPuOH6+7T+U-Pa25G959LvMCmU49pJA@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] RISC-V: Use SBI SRST extension when available
To:     Palmer Dabbelt <palmerdabbelt@google.com>
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

On Wed, Jul 7, 2021 at 1:57 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Mon, 21 Jun 2021 21:46:46 PDT (-0700), anup@brainfault.org wrote:
> > Hi Palmer,
> >
> > On Wed, Jun 9, 2021 at 5:43 PM Anup Patel <anup.patel@wdc.com> wrote:
> >>
> >> The SBI SRST extension provides a standard way to poweroff and
> >> reboot the system irrespective to whether Linux RISC-V S-mode
> >> is running natively (HS-mode) or inside Guest/VM (VS-mode).
> >>
> >> The SBI SRST extension is available in the SBI v0.3 specification.
> >> (Refer, https://github.com/riscv/riscv-sbi-doc/releases/tag/v0.3.0-rc1)
> >
> > Can you please consider this patch for Linux-5.14-rc1 ?
> >
> > The SBI v0.3 spec is already frozen and this patch has been
> > floating on LKML for quite a few months now.
>
> I didn't realize that SBI-0.3 had been frozed.  That link is to a RC,
> the cooresponding v0.3.0 tag isn't in that repo.  Can you give me a
> pointer to the frozen spec?

Here's the link to SBI v0.3.0 tag:
https://github.com/riscv/riscv-sbi-doc/releases/tag/v0.3.0

We treat RC tags as frozen in SBI spec because no functional
changes are done in SBI spec after it is tagged as RC. We only
do typo fixes and clarifications on SBI spec RC release.

Regards,
Anup

>
> >
> > Regards,
> > Anup
> >
> >>
> >> This patch extends Linux RISC-V SBI implementation to detect
> >> and use SBI SRST extension.
> >>
> >> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> >> Reviewed-by: Atish Patra <atish.patra@wdc.com>
> >> ---
> >>  arch/riscv/include/asm/sbi.h | 24 ++++++++++++++++++++++++
> >>  arch/riscv/kernel/sbi.c      | 35 +++++++++++++++++++++++++++++++++++
> >>  2 files changed, 59 insertions(+)
> >>
> >> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> >> index 0d42693cb65e..289621da4a2a 100644
> >> --- a/arch/riscv/include/asm/sbi.h
> >> +++ b/arch/riscv/include/asm/sbi.h
> >> @@ -27,6 +27,7 @@ enum sbi_ext_id {
> >>         SBI_EXT_IPI = 0x735049,
> >>         SBI_EXT_RFENCE = 0x52464E43,
> >>         SBI_EXT_HSM = 0x48534D,
> >> +       SBI_EXT_SRST = 0x53525354,
> >>  };
> >>
> >>  enum sbi_ext_base_fid {
> >> @@ -70,6 +71,21 @@ enum sbi_hsm_hart_status {
> >>         SBI_HSM_HART_STATUS_STOP_PENDING,
> >>  };
> >>
> >> +enum sbi_ext_srst_fid {
> >> +       SBI_EXT_SRST_RESET = 0,
> >> +};
> >> +
> >> +enum sbi_srst_reset_type {
> >> +       SBI_SRST_RESET_TYPE_SHUTDOWN = 0,
> >> +       SBI_SRST_RESET_TYPE_COLD_REBOOT,
> >> +       SBI_SRST_RESET_TYPE_WARM_REBOOT,
> >> +};
> >> +
> >> +enum sbi_srst_reset_reason {
> >> +       SBI_SRST_RESET_REASON_NONE = 0,
> >> +       SBI_SRST_RESET_REASON_SYS_FAILURE,
> >> +};
> >> +
> >>  #define SBI_SPEC_VERSION_DEFAULT       0x1
> >>  #define SBI_SPEC_VERSION_MAJOR_SHIFT   24
> >>  #define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
> >> @@ -148,6 +164,14 @@ static inline unsigned long sbi_minor_version(void)
> >>         return sbi_spec_version & SBI_SPEC_VERSION_MINOR_MASK;
> >>  }
> >>
> >> +/* Make SBI version */
> >> +static inline unsigned long sbi_mk_version(unsigned long major,
> >> +                                           unsigned long minor)
> >> +{
> >> +       return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
> >> +               SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
> >> +}
> >> +
> >>  int sbi_err_map_linux_errno(int err);
> >>  #else /* CONFIG_RISCV_SBI */
> >>  static inline int sbi_remote_fence_i(const unsigned long *hart_mask) { return -1; }
> >> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> >> index 7402a417f38e..9a84f0cb5175 100644
> >> --- a/arch/riscv/kernel/sbi.c
> >> +++ b/arch/riscv/kernel/sbi.c
> >> @@ -7,6 +7,7 @@
> >>
> >>  #include <linux/init.h>
> >>  #include <linux/pm.h>
> >> +#include <linux/reboot.h>
> >>  #include <asm/sbi.h>
> >>  #include <asm/smp.h>
> >>
> >> @@ -501,6 +502,32 @@ int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
> >>  }
> >>  EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
> >>
> >> +static void sbi_srst_reset(unsigned long type, unsigned long reason)
> >> +{
> >> +       sbi_ecall(SBI_EXT_SRST, SBI_EXT_SRST_RESET, type, reason,
> >> +                 0, 0, 0, 0);
> >> +       pr_warn("%s: type=0x%lx reason=0x%lx failed\n",
> >> +               __func__, type, reason);
> >> +}
> >> +
> >> +static int sbi_srst_reboot(struct notifier_block *this,
> >> +                          unsigned long mode, void *cmd)
> >> +{
> >> +       sbi_srst_reset((mode == REBOOT_WARM || mode == REBOOT_SOFT) ?
> >> +                      SBI_SRST_RESET_TYPE_WARM_REBOOT :
> >> +                      SBI_SRST_RESET_TYPE_COLD_REBOOT,
> >> +                      SBI_SRST_RESET_REASON_NONE);
> >> +       return NOTIFY_DONE;
> >> +}
> >> +
> >> +static struct notifier_block sbi_srst_reboot_nb;
> >> +
> >> +static void sbi_srst_power_off(void)
> >> +{
> >> +       sbi_srst_reset(SBI_SRST_RESET_TYPE_SHUTDOWN,
> >> +                      SBI_SRST_RESET_REASON_NONE);
> >> +}
> >> +
> >>  /**
> >>   * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
> >>   * @extid: The extension ID to be probed.
> >> @@ -608,6 +635,14 @@ void __init sbi_init(void)
> >>                 } else {
> >>                         __sbi_rfence    = __sbi_rfence_v01;
> >>                 }
> >> +               if ((sbi_spec_version >= sbi_mk_version(0, 3)) &&
> >> +                   (sbi_probe_extension(SBI_EXT_SRST) > 0)) {
> >> +                       pr_info("SBI SRST extension detected\n");
> >> +                       pm_power_off = sbi_srst_power_off;
> >> +                       sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
> >> +                       sbi_srst_reboot_nb.priority = 192;
> >> +                       register_restart_handler(&sbi_srst_reboot_nb);
> >> +               }
> >>         } else {
> >>                 __sbi_set_timer = __sbi_set_timer_v01;
> >>                 __sbi_send_ipi  = __sbi_send_ipi_v01;
> >> --
> >> 2.25.1
> >>
