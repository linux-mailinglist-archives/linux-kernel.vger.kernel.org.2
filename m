Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625F6357013
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353461AbhDGPXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhDGPXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:23:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DB9C061756;
        Wed,  7 Apr 2021 08:23:07 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o20-20020a05600c4fd4b0290114265518afso1391287wmq.4;
        Wed, 07 Apr 2021 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qL1k1ud75xannhNTqtOLFcdBQWw5uyDx1ptyyKd8RBs=;
        b=da34YqiceDqC4hxAmKCRVE15Cs7x67KnMYn2Gm6fE/IRWWKGDLD1TTNBr26BFVaMdG
         N7Cx+ko7Qo40BkiojKlqP6537vsWwUqszlzlnToxeec6xerh0n95u6kWAZrRRgdbH0+i
         fHLXHgl/Av/6vJCnE9NyMid03vJN2k/X44ntVdEw3AB/ESKORcTWd+xy563ZH32nH99F
         3ObLvTSA+6MWKtt+o1q0nG7FRaXeikf8zWZ2DDASOo6Wqx2SZhgjdIR6eab209U4LxFg
         AhkSIvm3yBabVDG7rY5dwfDCQfcWwFYUXxuNyr1+o6+gX1DhbdjWOQXsCDS3n6OKhDJr
         bd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qL1k1ud75xannhNTqtOLFcdBQWw5uyDx1ptyyKd8RBs=;
        b=I9qUQHhlL3B0zajqnqr6zgakE8kP6rvHaomVpHhOkLG+yB2xP/X5zGZPJeH8an14B4
         SLTc7wyaG9IBFXG+R3FOOi9QZdkUzCa24vuvcvIBjJJ0G7xgaKkhLJLRMA1hhAfBz+ru
         aTJf0syKo7gTEqsNxKCjHmOOY7GMd9qLLUka5ZOjQQQXleN8wiJrF7VK2z6D4BUgdW08
         gpsu3hulc/3ec1lkFEzqIrcsLnr/A6LktxGTd0lcr8+kZcs+tdz/nQHRyB8cTuh7gvmK
         IsaawUHHO8sla4SMV78s+Om9EIDCNhgaVOXlaDBkv7yCZRT0Liq48vl3PO030DN3WQXI
         8gNA==
X-Gm-Message-State: AOAM5314gscyW28FWgL6fL1DXby8axP2CtVX/Q/S+fqi4rRwh8nwszaw
        IAA5Vcaz6jPSBdrDoTOT5w6jbJsXiIBXRlIlnTA=
X-Google-Smtp-Source: ABdhPJxlbaCKWibLAKApis6946bXfzKH7F1nI2xNspAufKTjZakDmYUWNuxfaBTzKtVnc1SEmMw84QalsRP3/qCkHes=
X-Received: by 2002:a05:600c:3556:: with SMTP id i22mr3651536wmq.116.1617808985913;
 Wed, 07 Apr 2021 08:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210401030558.2301621-1-david.e.box@linux.intel.com> <20210401030558.2301621-4-david.e.box@linux.intel.com>
In-Reply-To: <20210401030558.2301621-4-david.e.box@linux.intel.com>
From:   Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Date:   Wed, 7 Apr 2021 11:22:40 -0400
Message-ID: <CAE2upjTZ6s7qFojfi3B=3uT_tH9BcS78LL1ZKa2hm+jFP0p6Ng@mail.gmail.com>
Subject: Re: [PATCH 3/9] platform/x86: intel_pmc_core: Handle sub-states generically
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A minor suggestion, num_modes should be called num_lpm_modes since
it's a pmcdev's property.

Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>


On Wed, Mar 31, 2021 at 11:06 PM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> From: Gayatri Kammela <gayatri.kammela@intel.com>
>
> The current implementation of pmc_core_substate_res_show() is written
> specifically for Tiger Lake. However, new platforms will also have
> sub-states and may support different modes. Therefore rewrite the code to
> handle sub-states generically.
>
> Read the number and type of enabled states from the PMC. Use the Low
> Power Mode (LPM) priority register to store the states in order from
> shallowest to deepest for displaying. Add a for_each macro to simplify
> this. While changing the sub-state display it makes sense to show only the
> "enabled" sub-states instead of showing all possible ones. After this
> patch, the debugfs file looks like this:
>
> Substate   Residency
> S0i2.0     0
> S0i3.0     0
> S0i2.1     9329279
> S0i3.1     0
> S0i3.2     0
>
> Suggested-by: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 59 ++++++++++++++++++++++-----
>  drivers/platform/x86/intel_pmc_core.h | 18 +++++++-
>  2 files changed, 64 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index 5ca40fe3da59..ce300c2942d0 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -577,8 +577,9 @@ static const struct pmc_reg_map tgl_reg_map = {
>         .pm_cfg_offset = CNP_PMC_PM_CFG_OFFSET,
>         .pm_read_disable_bit = CNP_PMC_READ_DISABLE_BIT,
>         .ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
> -       .lpm_modes = tgl_lpm_modes,
> +       .lpm_num_maps = TGL_LPM_NUM_MAPS,
>         .lpm_en_offset = TGL_LPM_EN_OFFSET,
> +       .lpm_priority_offset = TGL_LPM_PRI_OFFSET,
>         .lpm_residency_offset = TGL_LPM_RESIDENCY_OFFSET,
>         .lpm_sts = tgl_lpm_maps,
>         .lpm_status_offset = TGL_LPM_STATUS_OFFSET,
> @@ -1028,18 +1029,14 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_ltr);
>  static int pmc_core_substate_res_show(struct seq_file *s, void *unused)
>  {
>         struct pmc_dev *pmcdev = s->private;
> -       const char **lpm_modes = pmcdev->map->lpm_modes;
>         u32 offset = pmcdev->map->lpm_residency_offset;
> -       u32 lpm_en;
> -       int index;
> +       int i, mode;
>
> -       lpm_en = pmc_core_reg_read(pmcdev, pmcdev->map->lpm_en_offset);
> -       seq_printf(s, "status substate residency\n");
> -       for (index = 0; lpm_modes[index]; index++) {
> -               seq_printf(s, "%7s %7s %-15u\n",
> -                          BIT(index) & lpm_en ? "Enabled" : " ",
> -                          lpm_modes[index], pmc_core_reg_read(pmcdev, offset));
> -               offset += 4;
> +       seq_printf(s, "%-10s %-15s\n", "Substate", "Residency");
> +
> +       pmc_for_each_mode(i, mode, pmcdev) {
> +               seq_printf(s, "%-10s %-15u\n", pmc_lpm_modes[mode],
> +                          pmc_core_reg_read(pmcdev, offset + (4 * mode)));
>         }
>
>         return 0;
> @@ -1091,6 +1088,45 @@ static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc);
>
> +static void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
> +{
> +       u8 lpm_priority[LPM_MAX_NUM_MODES];
> +       u32 lpm_en;
> +       int mode, i, p;
> +
> +       /* Use LPM Maps to indicate support for substates */
> +       if (!pmcdev->map->lpm_num_maps)
> +               return;
> +
> +       lpm_en = pmc_core_reg_read(pmcdev, pmcdev->map->lpm_en_offset);
> +       pmcdev->num_modes = hweight32(lpm_en);
> +
> +       /* Each byte contains information for 2 modes (7:4 and 3:0) */
> +       for (mode = 0; mode < LPM_MAX_NUM_MODES; mode += 2) {
> +               u8 priority = pmc_core_reg_read_byte(pmcdev,
> +                               pmcdev->map->lpm_priority_offset + (mode / 2));
> +               int pri0 = GENMASK(3, 0) & priority;
> +               int pri1 = (GENMASK(7, 4) & priority) >> 4;
> +
> +               lpm_priority[pri0] = mode;
> +               lpm_priority[pri1] = mode + 1;
> +       }
> +
> +       /*
> +        * Loop though all modes from lowest to highest priority,
> +        * and capture all enabled modes in order
> +        */
> +       i = 0;
> +       for (p = LPM_MAX_NUM_MODES - 1; p >= 0; p--) {
> +               int mode = lpm_priority[p];
> +
> +               if (!(BIT(mode) & lpm_en))
> +                       continue;
> +
> +               pmcdev->lpm_en_modes[i++] = mode;
> +       }
> +}
> +
>  static void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
>  {
>         debugfs_remove_recursive(pmcdev->dbgfs_dir);
> @@ -1267,6 +1303,7 @@ static int pmc_core_probe(struct platform_device *pdev)
>
>         mutex_init(&pmcdev->lock);
>         pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(pmcdev);
> +       pmc_core_get_low_power_modes(pmcdev);
>         pmc_core_do_dmi_quirks(pmcdev);
>
>         /*
> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
> index f33cd2c34835..5a4e3a49f5b1 100644
> --- a/drivers/platform/x86/intel_pmc_core.h
> +++ b/drivers/platform/x86/intel_pmc_core.h
> @@ -187,6 +187,8 @@ enum ppfear_regs {
>  #define ICL_PMC_LTR_WIGIG                      0x1BFC
>  #define ICL_PMC_SLP_S0_RES_COUNTER_STEP                0x64
>
> +#define LPM_MAX_NUM_MODES                      8
> +
>  #define TGL_NUM_IP_IGN_ALLOWED                 22
>  #define TGL_PMC_SLP_S0_RES_COUNTER_STEP                0x7A
>
> @@ -199,8 +201,10 @@ enum ppfear_regs {
>  /* Tigerlake Low Power Mode debug registers */
>  #define TGL_LPM_STATUS_OFFSET                  0x1C3C
>  #define TGL_LPM_LIVE_STATUS_OFFSET             0x1C5C
> +#define TGL_LPM_PRI_OFFSET                     0x1C7C
> +#define TGL_LPM_NUM_MAPS                       6
>
> -const char *tgl_lpm_modes[] = {
> +const char *pmc_lpm_modes[] = {
>         "S0i2.0",
>         "S0i2.1",
>         "S0i2.2",
> @@ -258,8 +262,9 @@ struct pmc_reg_map {
>         const u32 ltr_ignore_max;
>         const u32 pm_vric1_offset;
>         /* Low Power Mode registers */
> -       const char **lpm_modes;
> +       const int lpm_num_maps;
>         const u32 lpm_en_offset;
> +       const u32 lpm_priority_offset;
>         const u32 lpm_residency_offset;
>         const u32 lpm_status_offset;
>         const u32 lpm_live_status_offset;
> @@ -278,6 +283,8 @@ struct pmc_reg_map {
>   * @check_counters:    On resume, check if counters are getting incremented
>   * @pc10_counter:      PC10 residency counter
>   * @s0ix_counter:      S0ix residency (step adjusted)
> + * @num_modes:         Count of enabled modes
> + * @lpm_en_modes:      Array of enabled modes from lowest to highest priority
>   *
>   * pmc_dev contains info about power management controller device.
>   */
> @@ -292,6 +299,13 @@ struct pmc_dev {
>         bool check_counters; /* Check for counter increments on resume */
>         u64 pc10_counter;
>         u64 s0ix_counter;
> +       int num_modes;
> +       int lpm_en_modes[LPM_MAX_NUM_MODES];
>  };
>
> +#define pmc_for_each_mode(i, mode, pmcdev)             \
> +       for (i = 0, mode = pmcdev->lpm_en_modes[i];     \
> +            i < pmcdev->num_modes;                     \
> +            i++, mode = pmcdev->lpm_en_modes[i])
> +
>  #endif /* PMC_CORE_H */
> --
> 2.25.1
>


-- 
Thanks,
Rajneesh
