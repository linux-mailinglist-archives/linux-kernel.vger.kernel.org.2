Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9D035708D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344111AbhDGPjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236121AbhDGPja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:39:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0744CC061756;
        Wed,  7 Apr 2021 08:39:21 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so2743690wmq.1;
        Wed, 07 Apr 2021 08:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3c06dT5yQzLlRXaO8yKXXRgU1FZveuehbKiQHk775qU=;
        b=WKnDcr9z5gZKsGq3pQGMlnr09CxdBekJ1uK724PsRa+7JzyklEXA24x+7h+Ep+lfD3
         4EsZI+XG7MLqBJU9Uyw73/jdMI/+gU6hjJc1OOMVveUT3sWt8mEViIwOMjI2cRU2B3mI
         Fadx2OxwnIpEh266kAkI1Ind5bH0kJgbL9ML07h2Uba4uwI30+1Zxi0GJHgkXBRqzckZ
         TNu2UKtqCDGCOe0fu2j9oqq27gEVg77KPwWC1NAsUI1K5wR1Qp81TPrkDj+PCPdIdEKK
         +/3+YMRP/6du7+kyBUvXnRg6fy3Da8QPyjiKUbE+NNpQ9OF3Sc34RVh3PCFv/qUQw00G
         9ATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3c06dT5yQzLlRXaO8yKXXRgU1FZveuehbKiQHk775qU=;
        b=WxiB+5QaZkPJ6aOf1vh13Y2cLm2UN2JtLoFDvVXgDDbdca8tyJUTpieql9kMq8weYv
         xD/OetU6wKaCAhq3LM1yw/OCCNG14h4f5nAE/BlzDsBOGPuSPRp6loW9Pzwh5zB7Ah7N
         tMJxioIWCbCumbfJp96NsCkjcESKA5oQsyRzWiaFqmv/7ZtoRSBI1jRCp4G3srT7e8NQ
         zNCJlVRPO3MuqcMjf7X6bK9NZCi7X320SfZ0+bhGGXIElIE64yts3W2cewdTAc3pkx0J
         Z0SRYITvLOYAs2og5e19CWFyZyQuMe9sxpmzNfNe4Frj40+lB99WswUGF30ab0bavVjk
         ptmA==
X-Gm-Message-State: AOAM532kqTZR3lAaKYkuMWPx2EtIfi4o3za8PW63l6adPAPU1/VhNZC9
        bn88pCJBH4JnVo9LRlbXTUWTlLK4KkSblggFZ3k=
X-Google-Smtp-Source: ABdhPJwKTup1qPARxJlRmSFbnSUiZp2q7PYUQlRHptnIWfHDIHzbtnxf/puwhOrhIT055IwbM14bkNgWNF5C5A5zNU8=
X-Received: by 2002:a1c:f701:: with SMTP id v1mr3715170wmh.69.1617809959664;
 Wed, 07 Apr 2021 08:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210401030558.2301621-1-david.e.box@linux.intel.com> <20210401030558.2301621-6-david.e.box@linux.intel.com>
In-Reply-To: <20210401030558.2301621-6-david.e.box@linux.intel.com>
From:   Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Date:   Wed, 7 Apr 2021 11:38:53 -0400
Message-ID: <CAE2upjQ596=iBff4s0nMkSD8jUyPpqC3bTRvVhysftJnHaOYbA@mail.gmail.com>
Subject: Re: [PATCH 5/9] platform/x86: intel_pmc_core: Get LPM requirements
 for Tiger Lake
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 11:06 PM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> From: Gayatri Kammela <gayatri.kammela@intel.com>
>
> Platforms that support low power modes (LPM) such as Tiger Lake maintain
> requirements for each sub-state that a readable in the PMC. However, unlike
> LPM status registers, requirement registers are not memory mapped but are
> available from an ACPI _DSM. Collect the requirements for Tiger Lake using
> the _DSM method and store in a buffer.
>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
> Co-developed-by: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 49 +++++++++++++++++++++++++++
>  drivers/platform/x86/intel_pmc_core.h |  2 ++
>  2 files changed, 51 insertions(+)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index ba0db301f07b..0ec26a4c715e 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -23,7 +23,9 @@
>  #include <linux/slab.h>
>  #include <linux/suspend.h>
>  #include <linux/uaccess.h>
> +#include <linux/uuid.h>
>
> +#include <acpi/acpi_bus.h>
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #include <asm/msr.h>
> @@ -31,6 +33,9 @@
>
>  #include "intel_pmc_core.h"
>
> +#define ACPI_S0IX_DSM_UUID             "57a6512e-3979-4e9d-9708-ff13b2508972"
> +#define ACPI_GET_LOW_MODE_REGISTERS    1
> +
>  /* PKGC MSRs are common across Intel Core SoCs */
>  static const struct pmc_bit_map msr_map[] = {
>         {"Package C2",                  MSR_PKG_C2_RESIDENCY},
> @@ -587,6 +592,46 @@ static const struct pmc_reg_map tgl_reg_map = {
>         .lpm_live_status_offset = TGL_LPM_LIVE_STATUS_OFFSET,
>  };
>
> +static void pmc_core_get_tgl_lpm_reqs(struct platform_device *pdev)
> +{
> +       struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
> +       const int num_maps = pmcdev->map->lpm_num_maps;
> +       size_t lpm_size = LPM_MAX_NUM_MODES * num_maps * 4;
> +       union acpi_object *out_obj;
> +       struct acpi_device *adev;
> +       guid_t s0ix_dsm_guid;
> +       u32 *lpm_req_regs;
> +
> +       adev = ACPI_COMPANION(&pdev->dev);
> +       if (!adev)
> +               return;
> +
> +       lpm_req_regs = devm_kzalloc(&pdev->dev, lpm_size * sizeof(u32),
> +                                    GFP_KERNEL);
> +       if (!lpm_req_regs)
> +               return;
> +
> +       guid_parse(ACPI_S0IX_DSM_UUID, &s0ix_dsm_guid);
> +
> +       out_obj = acpi_evaluate_dsm(adev->handle, &s0ix_dsm_guid, 0,
> +                                   ACPI_GET_LOW_MODE_REGISTERS, NULL);
> +       if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
> +               u32 *addr = (u32 *)out_obj->buffer.pointer;
> +               int size = out_obj->buffer.length;
> +
> +               if (size != lpm_size)
> +                       return;
> +
> +               memcpy_fromio(lpm_req_regs, addr, lpm_size);

this is not __iomem* so why are you using this? Simple memcpy should work here.

> +       } else
> +               acpi_handle_debug(adev->handle,
> +                                 "_DSM function 0 evaluation failed\n");
> +
> +       ACPI_FREE(out_obj);
> +
> +       pmcdev->lpm_req_regs = lpm_req_regs;
> +}
> +
>  static inline u32 pmc_core_reg_read(struct pmc_dev *pmcdev, int reg_offset)
>  {
>         return readl(pmcdev->regbase + reg_offset);
> @@ -1312,10 +1357,14 @@ static int pmc_core_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         mutex_init(&pmcdev->lock);
> +
>         pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(pmcdev);
>         pmc_core_get_low_power_modes(pmcdev);
>         pmc_core_do_dmi_quirks(pmcdev);
>
> +       if (pmcdev->map == &tgl_reg_map)
> +               pmc_core_get_tgl_lpm_reqs(pdev);
> +
>         /*
>          * On TGL, due to a hardware limitation, the GBE LTR blocks PC10 when
>          * a cable is attached. Tell the PMC to ignore it.
> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
> index 3800c1ba6fb7..81d797feed33 100644
> --- a/drivers/platform/x86/intel_pmc_core.h
> +++ b/drivers/platform/x86/intel_pmc_core.h
> @@ -288,6 +288,7 @@ struct pmc_reg_map {
>   * @s0ix_counter:      S0ix residency (step adjusted)
>   * @num_modes:         Count of enabled modes
>   * @lpm_en_modes:      Array of enabled modes from lowest to highest priority
> + * @lpm_req_regs:      List of substate requirements
>   *
>   * pmc_dev contains info about power management controller device.
>   */
> @@ -304,6 +305,7 @@ struct pmc_dev {
>         u64 s0ix_counter;
>         int num_modes;
>         int lpm_en_modes[LPM_MAX_NUM_MODES];
> +       u32 *lpm_req_regs;
>  };
>
>  #define pmc_for_each_mode(i, mode, pmcdev)             \
> --
> 2.25.1
>


-- 
Thanks,
Rajneesh
