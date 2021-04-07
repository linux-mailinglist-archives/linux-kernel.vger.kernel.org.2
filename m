Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E464735702E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353499AbhDGPZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236449AbhDGPZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:25:37 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE02C061756;
        Wed,  7 Apr 2021 08:25:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id x7so18411827wrw.10;
        Wed, 07 Apr 2021 08:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4RgM93a6tYKXcyiTiJHlpahR03/dCqSyHqFDXgF8iIg=;
        b=BpPdWddIqtH3YR7dC2l/Mnml+6sM09qqJtOmHYUQxoI0ceSzBBNQphooZUR+z+l/ic
         lQc5lvjFUGAcTokeSqK8TVdXPRKKkxBDDLO9lvfQgfoBv2biQlX3Wt04f5LzRx4biSC3
         AjMLefqycxunl8RubuaigQoUNVEdzS/e0qKCKcflGGRvqJ/oMTmlUuWMiHgOKDgYp6Ll
         UW9pTozF0/zcCI0DlMheMoMQWCEXKPutuHowR2CmKVH++Ho59opnp0wNfaUgA+h13Ate
         qv4nEWYk9isvjMpcMvxrSscXbMQ+3WV480CvT/aoZj3C3ctg68t23EPiZ/lVGk6Zl6Sz
         J7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4RgM93a6tYKXcyiTiJHlpahR03/dCqSyHqFDXgF8iIg=;
        b=f/CUcPuPTT0YhVv6GmSUx/6dI4z+4MwkSqqW1lEjdsF3bcR+RyksBmS/jg/7vCSe+o
         +7nE1nGZJKMqDicE9lupcDeuXYDvGrUefoY9ZRLoAML2DJImX7nzp/8ks2fde0YCuepK
         9/8CtZJOq/h31LQhm7SAWnuVVCJHxB9izwg0hAOzwuuHVDB4zosFmUbH/ZwfmSMDe1nl
         yfVv6dkgindHFvYwLb2m86yQi3u30rYb0RNPcchlB61P/JO4V3YvDZJ+3phfQiuUtARo
         I7eI6POR1oAFOAGq9WmUBgj2gniizk19PxHXTrYlBYQ0ic2Miv6tfUyTJa/ZzKzOfWN9
         mLxw==
X-Gm-Message-State: AOAM531kl/bY+dwtvXkMYfJ1RMuDf1Dvd+T+1Qs1A88iJqWJoYmg3CYz
        l5Plzr4+ge4E0S4dPfx1rU46BX/odV+Go57oGB74b6SRmij24w==
X-Google-Smtp-Source: ABdhPJyDSqp4M7F3fXHz45Erxa0xz+GlX3qsktsxqwjBCfnt8xzvrITiJHRAtclcYXGXlH3HKD3rkhiVMHoN4vcxrMU=
X-Received: by 2002:adf:e4c9:: with SMTP id v9mr5133291wrm.342.1617809125761;
 Wed, 07 Apr 2021 08:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210401030558.2301621-1-david.e.box@linux.intel.com> <20210401030558.2301621-5-david.e.box@linux.intel.com>
In-Reply-To: <20210401030558.2301621-5-david.e.box@linux.intel.com>
From:   Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Date:   Wed, 7 Apr 2021 11:24:59 -0400
Message-ID: <CAE2upjRO1Uy4m9Y9qVnSmGg12d_ZjcGg=bzShg_6Knugi9Aj7Q@mail.gmail.com>
Subject: Re: [PATCH 4/9] platform/x86: intel_pmc_core: Show LPM residency in microseconds
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>

On Wed, Mar 31, 2021 at 11:06 PM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> From: Gayatri Kammela <gayatri.kammela@intel.com>
>
> Modify the low power mode (LPM or sub-state) residency counters to display
> in microseconds just like the slp_s0_residency counter. The granularity of
> the counter is approximately 30.5us per tick. Double this value then divide
> by two to maintain accuracy.
>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 14 ++++++++++++--
>  drivers/platform/x86/intel_pmc_core.h |  3 +++
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index ce300c2942d0..ba0db301f07b 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -578,6 +578,7 @@ static const struct pmc_reg_map tgl_reg_map = {
>         .pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
>         .ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
>         .lpm_num_maps = TGL_LPM_NUM_MAPS,
> +       .lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
>         .lpm_en_offset = TGL_LPM_EN_OFFSET,
>         .lpm_priority_offset = TGL_LPM_PRI_OFFSET,
>         .lpm_residency_offset = TGL_LPM_RESIDENCY_OFFSET,
> @@ -1026,17 +1027,26 @@ static int pmc_core_ltr_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_ltr);
>
> +static inline u64 adjust_lpm_residency(struct pmc_dev *pmcdev, u32 offset,
> +                                      const int lpm_adj_x2)
> +{
> +       u64 lpm_res = pmc_core_reg_read(pmcdev, offset);
> +
> +       return GET_X2_COUNTER((u64)lpm_adj_x2 * lpm_res);
> +}
> +
>  static int pmc_core_substate_res_show(struct seq_file *s, void *unused)
>  {
>         struct pmc_dev *pmcdev = s->private;
> +       const int lpm_adj_x2 = pmcdev->map->lpm_res_counter_step_x2;
>         u32 offset = pmcdev->map->lpm_residency_offset;
>         int i, mode;
>
>         seq_printf(s, "%-10s %-15s\n", "Substate", "Residency");
>
>         pmc_for_each_mode(i, mode, pmcdev) {
> -               seq_printf(s, "%-10s %-15u\n", pmc_lpm_modes[mode],
> -                          pmc_core_reg_read(pmcdev, offset + (4 * mode)));
> +               seq_printf(s, "%-10s %-15llu\n", pmc_lpm_modes[mode],
> +                          adjust_lpm_residency(pmcdev, offset + (4 * mode), lpm_adj_x2));
>         }
>
>         return 0;
> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
> index 5a4e3a49f5b1..3800c1ba6fb7 100644
> --- a/drivers/platform/x86/intel_pmc_core.h
> +++ b/drivers/platform/x86/intel_pmc_core.h
> @@ -188,9 +188,11 @@ enum ppfear_regs {
>  #define ICL_PMC_SLP_S0_RES_COUNTER_STEP                0x64
>
>  #define LPM_MAX_NUM_MODES                      8
> +#define GET_X2_COUNTER(v)                      ((v) >> 1)
>
>  #define TGL_NUM_IP_IGN_ALLOWED                 22
>  #define TGL_PMC_SLP_S0_RES_COUNTER_STEP                0x7A
> +#define TGL_PMC_LPM_RES_COUNTER_STEP_X2                61      /* 30.5us * 2 */
>
>  /*
>   * Tigerlake Power Management Controller register offsets
> @@ -263,6 +265,7 @@ struct pmc_reg_map {
>         const u32 pm_vric1_offset;
>         /* Low Power Mode registers */
>         const int lpm_num_maps;
> +       const int lpm_res_counter_step_x2;
>         const u32 lpm_en_offset;
>         const u32 lpm_priority_offset;
>         const u32 lpm_residency_offset;
> --
> 2.25.1
>


-- 
Thanks,
Rajneesh
