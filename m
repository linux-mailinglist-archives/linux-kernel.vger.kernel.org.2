Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D5132A263
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376776AbhCBHv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376408AbhCBH2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 02:28:19 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149B4C061793
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 23:27:29 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id g9so17147269ilc.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 23:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YyJJmG45HuiOpTe3KS8/Kny2Qa3JXa3ZKeSCLG7Df38=;
        b=Gm7E5U3pj7X0UpmdWSTIE50SqvIEOKeLn5TVJJrhULf/AErySgURrnxoMtNjg268Lj
         3YvOczQpBzEpYa2pCKqSGTcwXXopnK3YIKq4o8ZRzAsQwv8T6r9t0O5T4RZVYC3IOiis
         kcWbRkribO58Xe+LKpazf51/JYO9pk+BDLVQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YyJJmG45HuiOpTe3KS8/Kny2Qa3JXa3ZKeSCLG7Df38=;
        b=AdHfiUk7SMHHfHmzKzQFpLlkQL72IbnBxoq28Jz5CaRzeCEqAEsY5TRQCatR7tIElq
         jfX8A/AaYzoEVKdM8fv7MKrNdQYckTyxBZtye+6ghhyC5KVcIfSfRPg1IiFhDjA+Fflq
         ykQ25caooE878jybFggVGtB8xe/8YWNGa+IoznOxcB4NJy0j7svKE72eUaa7oeZYcmgn
         Z3gLDCk8FcEalIH+5LJZPuiWemhQqKNJh9pUuvTw0tYjMwP947CLpZhHI1aiZSz5JST3
         BSUj1BiQu3n8+t33mJMXLuqh1ESbVoqsct7BiXiqJP1HA1cFwn1KiRIpkhKAh2aKKmZ4
         lHLw==
X-Gm-Message-State: AOAM533aR+oCukHqxexYMVt6mPensryO1W83S8fGFZdEMROYBwfKgzYH
        WNkoOSZ/su1zKcu++qG8LFvFtRuMaaVw6oLEcF/v
X-Google-Smtp-Source: ABdhPJz19DQ/+z+HW9t2F32PbcdzVpguuklDxZgL53BrCaXL51VDwPjtnjiiB2OctZ3RI403Zh53R3gXY9RTCbmPTG4=
X-Received: by 2002:a05:6e02:11a3:: with SMTP id 3mr16109742ilj.126.1614670048537;
 Mon, 01 Mar 2021 23:27:28 -0800 (PST)
MIME-Version: 1.0
References: <20210301115833.382364-1-anup.patel@wdc.com>
In-Reply-To: <20210301115833.382364-1-anup.patel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 1 Mar 2021 23:27:17 -0800
Message-ID: <CAOnJCU+71QoE7uVH+j557z8GEXMG4nLXr1u=x-QrmeaPbTTbKg@mail.gmail.com>
Subject: Re: [PATCH v4] RISC-V: Use SBI SRST extension when available
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 3:59 AM Anup Patel <anup.patel@wdc.com> wrote:
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
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
