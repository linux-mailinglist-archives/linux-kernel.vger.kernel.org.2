Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B8A3AFC2E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 06:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbhFVEtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 00:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhFVEtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 00:49:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E833C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 21:46:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j1so4767827wrn.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 21:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=09Mfm1QM7/L+YWTPoynwJ162O0xIkLcgOUTr2j77MJE=;
        b=eciAZMzp8OuK9xwqbf2bWae+j4AomXEqEH8ws5wJB4X2J8QHdnN8n+ttl0n3Zhc2w5
         aJawqO1XzErTC2bTG7IHEiJ43uOodfx86Auc9W5gLEVzj5zTZ+gxHjV/43XeP+25Gcqq
         qSxDMzos4RE1lKIrK8numyVqt5mUG0gKX/4i2w1nYpV8MhMz49v3A7qY9YBAnqADmA56
         et3XJbq3RBHQoJOjJSibanCuwaul4i5U0uo8pdit5/7wEoM3IEuTNveYwBp/4XQK8TRR
         PgJLLnkH6wE1rHqFLRrHCMUBjPsj05eiAksJ4AZsMT86tx66KAuJwT5bwwYcleyg3VOM
         mKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=09Mfm1QM7/L+YWTPoynwJ162O0xIkLcgOUTr2j77MJE=;
        b=Q90dmXQaujYyB0a1CQpALeUNdh51cla6WTR5EwjmG2Gn/K/tUO73q6Iv+NoiLRdGez
         pORvRnLPYGnO+rlLjxEZoJENQcrrZ/JU9O9op1i2mPs5vzhDiP4xpKTvAS92X60Tgr2w
         olbJhDsUitzUeii/F4AvXGPaV+VzcqHuSBQaOBceOxc1lKDmA+3hZM5BV3aEjTZfPuK5
         AXOu+1mVDXwxId+awyOSxnR53r6bdPKY1j38RjiZm1VoysrBvFUEIM54rXQIa3799PnP
         luwZsOPo2McIsas9tikvci5tHXAFdd2uORUMfaGTVGcVVLO4wPLbG45JAXaXNPxFpD+O
         1JXg==
X-Gm-Message-State: AOAM532Noqc1rnPQKLxfXVy4Pql80shalT3ycrc84IpBYshujWHMNbsd
        SSBClYqRAiVn312JzyZ9ErTIKeckUNSLjkrucjIB4A==
X-Google-Smtp-Source: ABdhPJz878r0AELnDsJ1BHAGAJffJ+yGk/L69nROJ/0UgWAZrPJmL9WkN4lZ/FB3rLHeilxbAHF6R0vAz9+VXZnW4Ms=
X-Received: by 2002:a5d:4a49:: with SMTP id v9mr2220857wrs.128.1624337217873;
 Mon, 21 Jun 2021 21:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210609121322.3058-1-anup.patel@wdc.com> <20210609121322.3058-2-anup.patel@wdc.com>
In-Reply-To: <20210609121322.3058-2-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 22 Jun 2021 10:16:46 +0530
Message-ID: <CAAhSdy0=XANwm4Vr5qbpvJdqwYNCfDRNTDf3cyAOGp-NuqF_Ag@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] RISC-V: Use SBI SRST extension when available
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Wed, Jun 9, 2021 at 5:43 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> The SBI SRST extension provides a standard way to poweroff and
> reboot the system irrespective to whether Linux RISC-V S-mode
> is running natively (HS-mode) or inside Guest/VM (VS-mode).
>
> The SBI SRST extension is available in the SBI v0.3 specification.
> (Refer, https://github.com/riscv/riscv-sbi-doc/releases/tag/v0.3.0-rc1)

Can you please consider this patch for Linux-5.14-rc1 ?

The SBI v0.3 spec is already frozen and this patch has been
floating on LKML for quite a few months now.

Regards,
Anup

>
> This patch extends Linux RISC-V SBI implementation to detect
> and use SBI SRST extension.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/sbi.h | 24 ++++++++++++++++++++++++
>  arch/riscv/kernel/sbi.c      | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 0d42693cb65e..289621da4a2a 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -27,6 +27,7 @@ enum sbi_ext_id {
>         SBI_EXT_IPI = 0x735049,
>         SBI_EXT_RFENCE = 0x52464E43,
>         SBI_EXT_HSM = 0x48534D,
> +       SBI_EXT_SRST = 0x53525354,
>  };
>
>  enum sbi_ext_base_fid {
> @@ -70,6 +71,21 @@ enum sbi_hsm_hart_status {
>         SBI_HSM_HART_STATUS_STOP_PENDING,
>  };
>
> +enum sbi_ext_srst_fid {
> +       SBI_EXT_SRST_RESET = 0,
> +};
> +
> +enum sbi_srst_reset_type {
> +       SBI_SRST_RESET_TYPE_SHUTDOWN = 0,
> +       SBI_SRST_RESET_TYPE_COLD_REBOOT,
> +       SBI_SRST_RESET_TYPE_WARM_REBOOT,
> +};
> +
> +enum sbi_srst_reset_reason {
> +       SBI_SRST_RESET_REASON_NONE = 0,
> +       SBI_SRST_RESET_REASON_SYS_FAILURE,
> +};
> +
>  #define SBI_SPEC_VERSION_DEFAULT       0x1
>  #define SBI_SPEC_VERSION_MAJOR_SHIFT   24
>  #define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
> @@ -148,6 +164,14 @@ static inline unsigned long sbi_minor_version(void)
>         return sbi_spec_version & SBI_SPEC_VERSION_MINOR_MASK;
>  }
>
> +/* Make SBI version */
> +static inline unsigned long sbi_mk_version(unsigned long major,
> +                                           unsigned long minor)
> +{
> +       return ((major & SBI_SPEC_VERSION_MAJOR_MASK) <<
> +               SBI_SPEC_VERSION_MAJOR_SHIFT) | minor;
> +}
> +
>  int sbi_err_map_linux_errno(int err);
>  #else /* CONFIG_RISCV_SBI */
>  static inline int sbi_remote_fence_i(const unsigned long *hart_mask) { return -1; }
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index 7402a417f38e..9a84f0cb5175 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -7,6 +7,7 @@
>
>  #include <linux/init.h>
>  #include <linux/pm.h>
> +#include <linux/reboot.h>
>  #include <asm/sbi.h>
>  #include <asm/smp.h>
>
> @@ -501,6 +502,32 @@ int sbi_remote_hfence_vvma_asid(const unsigned long *hart_mask,
>  }
>  EXPORT_SYMBOL(sbi_remote_hfence_vvma_asid);
>
> +static void sbi_srst_reset(unsigned long type, unsigned long reason)
> +{
> +       sbi_ecall(SBI_EXT_SRST, SBI_EXT_SRST_RESET, type, reason,
> +                 0, 0, 0, 0);
> +       pr_warn("%s: type=0x%lx reason=0x%lx failed\n",
> +               __func__, type, reason);
> +}
> +
> +static int sbi_srst_reboot(struct notifier_block *this,
> +                          unsigned long mode, void *cmd)
> +{
> +       sbi_srst_reset((mode == REBOOT_WARM || mode == REBOOT_SOFT) ?
> +                      SBI_SRST_RESET_TYPE_WARM_REBOOT :
> +                      SBI_SRST_RESET_TYPE_COLD_REBOOT,
> +                      SBI_SRST_RESET_REASON_NONE);
> +       return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block sbi_srst_reboot_nb;
> +
> +static void sbi_srst_power_off(void)
> +{
> +       sbi_srst_reset(SBI_SRST_RESET_TYPE_SHUTDOWN,
> +                      SBI_SRST_RESET_REASON_NONE);
> +}
> +
>  /**
>   * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
>   * @extid: The extension ID to be probed.
> @@ -608,6 +635,14 @@ void __init sbi_init(void)
>                 } else {
>                         __sbi_rfence    = __sbi_rfence_v01;
>                 }
> +               if ((sbi_spec_version >= sbi_mk_version(0, 3)) &&
> +                   (sbi_probe_extension(SBI_EXT_SRST) > 0)) {
> +                       pr_info("SBI SRST extension detected\n");
> +                       pm_power_off = sbi_srst_power_off;
> +                       sbi_srst_reboot_nb.notifier_call = sbi_srst_reboot;
> +                       sbi_srst_reboot_nb.priority = 192;
> +                       register_restart_handler(&sbi_srst_reboot_nb);
> +               }
>         } else {
>                 __sbi_set_timer = __sbi_set_timer_v01;
>                 __sbi_send_ipi  = __sbi_send_ipi_v01;
> --
> 2.25.1
>
