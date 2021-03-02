Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7D932A178
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577393AbhCBGVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 01:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236705AbhCBELG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 23:11:06 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8458C06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 20:09:38 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id d15so3148999wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 20:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UCeThmfIe2FMGTwXvgjfzTMdkfhIc6RQTvnKJCcY5ww=;
        b=LNxuVnPiqlYI2Cx/+1uZU4/zNU60ZGkrfkAKcoAm5JIJhyLMktvkzk0UxUxTLTcI62
         xTW87eL1gCXwBvU8WDbErA5qHRvowXR7ujNi/lM/n6mlzvIO3o9KaMxp7qd/D+BtbQHs
         5ewCRTCf3QOfcHSjynbUjqyHxHAXq/n6v8/MuI64uA/mxJ60ocIY4nwzN76+h2sOAQP1
         wdIlaVF/tWe/GR0RWvBDiJ8WwPkqoH9JuOIvZ32liz1vup8CKghAWtwQv+Ibsjh74f3c
         1NZgpFMCZSxhTADVjoKdhBo0kPIeh4okPjgXsMDbrK3eoDdgDjkonbeEZG4huVSs6viL
         W2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UCeThmfIe2FMGTwXvgjfzTMdkfhIc6RQTvnKJCcY5ww=;
        b=S8Ay7FPajQhFExgCVL6eGh13X07tBz4TlMHMG4llbsDo0wLsTtH4LF2r9DhMsi2g4d
         5yFZ6cMahEkyCdVuPi8DSPtB+ANw2QpOJ6/Zs2nwcI9U+V4FeQv5rLzhtYypiEGTvedZ
         zhyopu9YEkN59huTL+GYJXo/mbpPmyyz/mHLjHePKA6OTRY1l2o1FY6U7GDqYVoq1N5C
         YkY9S4cN95GYEqoCIqe2iiwTZe1d9/S/fCd55+rfI5h4eTK3fGdgodNZXCBZWiY//097
         reLgNTHapY586LO+6YVoScFCrJTRshCH61JYqbRpx3UrDeV4HGt48CA2Fj2D7Gdmc98U
         fG8Q==
X-Gm-Message-State: AOAM533NtZo+LgR7DfQlaAXViFw2cwAnzqkmGD6X4IOKVW7A1A/jNd7g
        PLgGGxCIi/sJchXNTtCEZWC7n7Ufd4jIZNeLcl9x9w==
X-Google-Smtp-Source: ABdhPJzijNchW1FMIfoiLAJ0Ttpyzpbys0MHDzxBDPZkoOMnfy4ukVWMfctUZImukgxlah95MvrEo9XOk88RgshTCDg=
X-Received: by 2002:adf:d236:: with SMTP id k22mr12735707wrh.144.1614658177426;
 Mon, 01 Mar 2021 20:09:37 -0800 (PST)
MIME-Version: 1.0
References: <20210301115833.382364-1-anup.patel@wdc.com>
In-Reply-To: <20210301115833.382364-1-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 2 Mar 2021 09:39:26 +0530
Message-ID: <CAAhSdy1hR8v6UL_sLo367M90AcxVz8RXt03ccBdvqByTbt3qfw@mail.gmail.com>
Subject: Re: [PATCH v4] RISC-V: Use SBI SRST extension when available
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

On Mon, Mar 1, 2021 at 5:29 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> The SBI SRST extension provides a standard way to poweroff and
> reboot the system irrespective to whether Linux RISC-V S-mode
> is running natively (HS-mode) or inside Guest/VM (VS-mode).
>
> The SBI SRST extension is available in latest SBI v0.3-draft
> specification at: https://github.com/riscv/riscv-sbi-doc.
>
> This patch extends Linux RISC-V SBI implementation to detect
> and use SBI SRST extension.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---

I missed adding changelog here so here it is ...

Changes since v3:
 - Rebased on Linux-5.12-rc1
 - Check SBI spec version when probing for SRST extension
Changes since v2:
 - Rebased on Linux-5.10-rc5
 - Updated patch as-per SBI SRST extension available in the latest
   SBI v0.3-draft specification
Changes since v1:
 - Updated patch as-per latest SBI SRST extension draft spec where
   we have only one SBI call with "reset_type" parameter

Regards,
Anup

>  arch/riscv/include/asm/sbi.h | 16 ++++++++++++++
>  arch/riscv/kernel/sbi.c      | 41 +++++++++++++++++++++++++++++++++---
>  2 files changed, 54 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 99895d9c3bdd..8add0209c9c7 100644
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
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index f4a7db3d309e..49155588e56c 100644
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
> @@ -577,22 +604,30 @@ void __init sbi_init(void)
>                         sbi_get_firmware_id(), sbi_get_firmware_version());
>                 if (sbi_probe_extension(SBI_EXT_TIME) > 0) {
>                         __sbi_set_timer = __sbi_set_timer_v02;
> -                       pr_info("SBI v0.2 TIME extension detected\n");
> +                       pr_info("SBI TIME extension detected\n");
>                 } else {
>                         __sbi_set_timer = __sbi_set_timer_v01;
>                 }
>                 if (sbi_probe_extension(SBI_EXT_IPI) > 0) {
>                         __sbi_send_ipi  = __sbi_send_ipi_v02;
> -                       pr_info("SBI v0.2 IPI extension detected\n");
> +                       pr_info("SBI IPI extension detected\n");
>                 } else {
>                         __sbi_send_ipi  = __sbi_send_ipi_v01;
>                 }
>                 if (sbi_probe_extension(SBI_EXT_RFENCE) > 0) {
>                         __sbi_rfence    = __sbi_rfence_v02;
> -                       pr_info("SBI v0.2 RFENCE extension detected\n");
> +                       pr_info("SBI RFENCE extension detected\n");
>                 } else {
>                         __sbi_rfence    = __sbi_rfence_v01;
>                 }
> +               if (sbi_probe_extension(SBI_EXT_SRST) > 0 &&
> +                   sbi_minor_version() >= 3) {
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
