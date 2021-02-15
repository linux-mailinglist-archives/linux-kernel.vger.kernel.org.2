Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA63531BAC1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 15:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhBOOJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 09:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhBOOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 09:09:04 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38865C061574
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 06:08:23 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v15so9047786wrx.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 06:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3URxrbkLowbse0Bw5vEVRcpGHmUKz+8FSOA0/o7IkI=;
        b=BXJ+9SBsa87yHuLuSFYFnFwHQtTsRqxANjyq8RFmBXc9B6RBruqNQNpLJRTnWtSELf
         BlzJM1BAHaVTF5gotDXUHLj2sEanpwLCT4gi3fb5uVivppTIvWemfCKTJOLmxqo8i4a7
         6gzMM5f1+ai55+HkP99EMRREPX5oH4fg4I5/NEoFuDZ13IzF2ijT90Llqykro/hXjL9B
         vFok0F1wI9jQ7kUM26uvVyBzFttEuXpZI1mZPKnBH3k/ViPuEsUtBIQb+ctXnzYDSWB2
         gz9I/V6/z2cwkITEEAHZtmYy5o4loapBIH6womuvvAAKTyekGikRyLzQc6qRUTTIQKE0
         aQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3URxrbkLowbse0Bw5vEVRcpGHmUKz+8FSOA0/o7IkI=;
        b=uiOR4Ut6by2XGkJjJTRDKq1PsUGBnqI8HTEbC1DnUs3isuPnfZEudhYF9xVKnj5jYT
         hywlMPuDulBoYOxrYSY3ygKiVg0huO66t4BhGMqyAnhVNSROTlYALtPSOHNxig8rrKCg
         HwN78DG5+859bZiYRQUq4fGh2VRxfcBB8M6EKA+kL35gZAQ0YrnufhC7T3nI5W5978HJ
         xU68/oeTMSdQ/hiOeyO/B+sbV1IzEJyS/v0t3+MaWyivwmz+Dlw5enNe5Ix5CzrRtaM0
         N28LzaurAWMt2NOGE7aJqCp3msbaw5qJbIrzn7JCiBV6Vnbf0O205mtdfd+O4C3irvbR
         akzw==
X-Gm-Message-State: AOAM533IxbfBBEdfOv1LWJPqBpeLCGZ4hBLLKCKuia+ci1pIhrvfa8Y6
        hqzwLTNUMuRyW29cf/DFZS1lzZM/QDpBftcyivc/iw==
X-Google-Smtp-Source: ABdhPJzyxXBROzcVUYeUO3igsTYl7j1ZIs899itaNfrf5emWkjI82Wyr4QdPMIgxpwe/GyH1f69pXTDTOufeblauB+E=
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr18406511wrm.178.1613398101907;
 Mon, 15 Feb 2021 06:08:21 -0800 (PST)
MIME-Version: 1.0
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com> <1611737738-1493-4-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1611737738-1493-4-git-send-email-anshuman.khandual@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 15 Feb 2021 14:08:11 +0000
Message-ID: <CAJ9a7VgPkDMaDKa3LSV3aL+_GsH3SsvVR_Whp3b2jP+eS7cq0A@mail.gmail.com>
Subject: Re: [PATCH V3 03/14] coresight: etm4x: Add support for PE OS lock
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: mike.leach <mike.leach@linaro.org>


On Wed, 27 Jan 2021 at 08:55, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> ETE may not implement the OS lock and instead could rely on
> the PE OS Lock for the trace unit access. This is indicated
> by the TRCOLSR.OSM == 0b100. Add support for handling the
> PE OS lock
>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 50 ++++++++++++++++++----
>  drivers/hwtracing/coresight/coresight-etm4x.h      | 15 +++++++
>  2 files changed, 56 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 473ab74..9edf8be 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -114,30 +114,59 @@ void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
>         }
>  }
>
> -static void etm4_os_unlock_csa(struct etmv4_drvdata *drvdata, struct csdev_access *csa)
> +static void etm_detect_os_lock(struct etmv4_drvdata *drvdata,
> +                              struct csdev_access *csa)
>  {
> -       /* Writing 0 to TRCOSLAR unlocks the trace registers */
> -       etm4x_relaxed_write32(csa, 0x0, TRCOSLAR);
> -       drvdata->os_unlock = true;
> +       u32 oslsr = etm4x_relaxed_read32(csa, TRCOSLSR);
> +
> +       drvdata->os_lock_model = ETM_OSLSR_OSLM(oslsr);
> +}
> +
> +static void etm_write_os_lock(struct etmv4_drvdata *drvdata,
> +                             struct csdev_access *csa, u32 val)
> +{
> +       val = !!val;
> +
> +       switch (drvdata->os_lock_model) {
> +       case ETM_OSLOCK_PRESENT:
> +               etm4x_relaxed_write32(csa, val, TRCOSLAR);
> +               break;
> +       case ETM_OSLOCK_PE:
> +               write_sysreg_s(val, SYS_OSLAR_EL1);
> +               break;
> +       default:
> +               pr_warn_once("CPU%d: Unsupported Trace OSLock model: %x\n",
> +                            smp_processor_id(), drvdata->os_lock_model);
> +               fallthrough;
> +       case ETM_OSLOCK_NI:
> +               return;
> +       }
>         isb();
>  }
>
> +static inline void etm4_os_unlock_csa(struct etmv4_drvdata *drvdata,
> +                                     struct csdev_access *csa)
> +{
> +       WARN_ON(drvdata->cpu != smp_processor_id());
> +
> +       /* Writing 0 to OS Lock unlocks the trace unit registers */
> +       etm_write_os_lock(drvdata, csa, 0x0);
> +       drvdata->os_unlock = true;
> +}
> +
>  static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
>  {
>         if (!WARN_ON(!drvdata->csdev))
>                 etm4_os_unlock_csa(drvdata, &drvdata->csdev->access);
> -
>  }
>
>  static void etm4_os_lock(struct etmv4_drvdata *drvdata)
>  {
>         if (WARN_ON(!drvdata->csdev))
>                 return;
> -
> -       /* Writing 0x1 to TRCOSLAR locks the trace registers */
> -       etm4x_relaxed_write32(&drvdata->csdev->access, 0x1, TRCOSLAR);
> +       /* Writing 0x1 to OS Lock locks the trace registers */
> +       etm_write_os_lock(drvdata, &drvdata->csdev->access, 0x1);
>         drvdata->os_unlock = false;
> -       isb();
>  }
>
>  static void etm4_cs_lock(struct etmv4_drvdata *drvdata,
> @@ -906,6 +935,9 @@ static void etm4_init_arch_data(void *info)
>         if (!etm4_init_csdev_access(drvdata, csa))
>                 return;
>
> +       /* Detect the support for OS Lock before we actuall use it */
> +       etm_detect_os_lock(drvdata, csa);
> +
>         /* Make sure all registers are accessible */
>         etm4_os_unlock_csa(drvdata, csa);
>         etm4_cs_unlock(drvdata, csa);
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 0af6057..0e86eba 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -506,6 +506,20 @@
>                                          ETM_MODE_EXCL_USER)
>
>  /*
> + * TRCOSLSR.OSLM advertises the OS Lock model.
> + * OSLM[2:0] = TRCOSLSR[4:3,0]
> + *
> + *     0b000 - Trace OS Lock is not implemented.
> + *     0b010 - Trace OS Lock is implemented.
> + *     0b100 - Trace OS Lock is not implemented, unit is controlled by PE OS Lock.
> + */
> +#define ETM_OSLOCK_NI          0b000
> +#define ETM_OSLOCK_PRESENT     0b010
> +#define ETM_OSLOCK_PE          0b100
> +
> +#define ETM_OSLSR_OSLM(oslsr)  ((((oslsr) & GENMASK(4, 3)) >> 2) | (oslsr & 0x1))
> +
> +/*
>   * TRCDEVARCH Bit field definitions
>   * Bits[31:21] - ARCHITECT = Always Arm Ltd.
>   *                * Bits[31:28] = 0x4
> @@ -897,6 +911,7 @@ struct etmv4_drvdata {
>         u8                              s_ex_level;
>         u8                              ns_ex_level;
>         u8                              q_support;
> +       u8                              os_lock_model;
>         bool                            sticky_enable;
>         bool                            boot_enable;
>         bool                            os_unlock;
> --
> 2.7.4
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
