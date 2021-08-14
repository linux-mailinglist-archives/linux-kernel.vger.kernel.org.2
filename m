Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9093EC1C4
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 11:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbhHNJvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 05:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhHNJvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 05:51:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B0CC06175F;
        Sat, 14 Aug 2021 02:51:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id nt11so18979080pjb.2;
        Sat, 14 Aug 2021 02:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HQfuO2pI9uFYWxwEDte8cxNRbaiuAcZuYVvJlMnd/rg=;
        b=PezVZdqH9GAKZUNcEc1cqJDutVYelOfyOcDe5nUqfB0Yv04r1TDd62qtVw2qNzC84W
         UlvuSnyjuFg45Ocj5mc1nuFRjADNdaISYCdb06WH/8BwNzK1l7DsO/Yv6WBJJyAtYwOv
         EyO34ABM+PlW2HlN54qHpmGYcO4yHhV7e4vn1CRHr4gy7DlRWBzIJSxyHJ+SarrksI03
         aJGIohDrQMoY7NTiz7NP4KOkzrhcI3hjHVGu+RSp5RGOfsZ4cAUapL7kUVht4zlT/+2P
         8hmQFHbt8hcFjK8FEwkmKe2dUIMksZ3uy6CJUGX/JZhLIxrygg1f/sECKY9ayWcTNVUs
         A+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HQfuO2pI9uFYWxwEDte8cxNRbaiuAcZuYVvJlMnd/rg=;
        b=VYSrjb2sd0EC1W7BsRlyniBxS3GgMYYYBUPs/Gi0OHNODUpuToCyoLpJ9GUilCgdeE
         z7Ux8hGXifjHK6+qnoZ+/CvL/lus+hcrw5pm1xjWxVo1ECB3iHWd4/kUqHHX1CN4ex2W
         veM81siPl530xC9ypwBREdnOdSjFEAsr6wR8BK0ucee3hcJkUGt2uHWLaPfuOWzPIFbB
         kFBVV0gA/i+Dn4Y88UouHs/CfBf3CK+JVydcu4x/p8roq3yIBW/VIfg+GOsB4B/5CJRs
         kQ0NHhLi1IIlI2b+A6HLSkQoL4PEtPR//ERkpisdapmR5T8Gmhcnc3p+5eD6XjKaCRFj
         VHeg==
X-Gm-Message-State: AOAM533a8bdjPTW2pKVrFnSBUIwb2KqBJzEV8YMk9hkgubW76xDKl+pQ
        IBK76fvdhd5oKs4Ntw4/dDu20mN/CBxGlH7NBe4=
X-Google-Smtp-Source: ABdhPJyyUAnuSomcRieIpZYmEFGJ9Ld4LgqT2KYgi+uHK7zrALGlFCkP7P1cBom/dfoybs96X+NADs2AEVHrUc17CHk=
X-Received: by 2002:a63:cf0a:: with SMTP id j10mr6271475pgg.4.1628934666309;
 Sat, 14 Aug 2021 02:51:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210814014728.520856-1-david.e.box@linux.intel.com>
In-Reply-To: <20210814014728.520856-1-david.e.box@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 14 Aug 2021 12:50:30 +0300
Message-ID: <CAHp75Ve0G=Bh-D710R6CcdkVMrud82sw8Y4zvu7sdt=ZF4r-+A@mail.gmail.com>
Subject: Re: [PATCH v3] platform/x86: intel_pmc_core: Prevent possibile overflow
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Evgeny Novikov <novikov@ispras.ru>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 4:49 AM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> Substate priority levels are encoded in 4 bits in the LPM_PRI register.
> This value was used as an index to an array whose element size was less
> than 16, leading to the possibility of overflow should we read a larger
> than expected priority.  In addition to the overflow, bad values could lead
> to incorrect state reporting.  So rework the priority code to prevent the
> overflow and perform some validation of the register. Use the priority
> register values if they give an ordering of unique numbers between 0 and
> the maximum number of states.  Otherwise, use a default ordering instead.

Thanks! Looks much better now. A couple of minor comments below. With
or without them being addressed
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Reported-by: Evgeny Novikov <novikov@ispras.ru>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> v3:     Modifying Andy's suggestion, just place the entire verification
>         in a separate function. If it fails, then keep the default
>         ordering. If it passes, overwrite with the verified ordering.
>
>         Fix error in default order array.
>
>         Also fix spelling noted by Andy drop the size comment since
>         the array size is set when declared.
>
> v2:     Remove lpm_priority size increase. Instead, remove that array and
>         create 2 new local arrays, one to save priority levels in mode order,
>         and one to save modes in priority order. Use the mode_order list to
>         validate that no priority level is above the maximum and to validate
>         that they are all unique values. Then we can safely create a
>         priority_order list that will be the basis of how we report substate
>         information.
>
>  drivers/platform/x86/intel_pmc_core.c | 65 +++++++++++++++++++++------
>  drivers/platform/x86/intel_pmc_core.h |  2 +
>  2 files changed, 53 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index b0e486a6bdfb..ae410a358ffe 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -1449,9 +1449,42 @@ static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc);
>
> -static void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
> +static bool pmc_core_pri_verify(u32 lpm_pri, u8 *mode_order)
>  {
> -       u8 lpm_priority[LPM_MAX_NUM_MODES];
> +       int i, j;
> +
> +       if (!lpm_pri)
> +               return false;
> +       /*
> +        * Each byte contains the priority level for 2 modes (7:4 and 3:0).
> +        * In a 32 bit register this allows for describing 8 modes. Store the
> +        * levels and look for values out of range.
> +        */
> +       for (i = 0; i < 8; i++) {
> +               int level = lpm_pri & GENMASK(3, 0);
> +
> +               if (level >= LPM_MAX_NUM_MODES)
> +                       return false;
> +
> +               mode_order[i] = level;
> +               lpm_pri >>= 4;
> +       }

> +       /* Check that we have unique values */
> +       for (i = 0; i < LPM_MAX_NUM_MODES - 1; i++)
> +               for (j = i + 1; j < LPM_MAX_NUM_MODES; j++)
> +                       if (mode_order[i] == mode_order[j])
> +                               return false;

There are ways to optimize this from O(n^2) to O(n), but it's not critical here.

> +       return true;
> +}
> +
> +static void pmc_core_get_low_power_modes(struct platform_device *pdev)
> +{
> +       struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
> +       u8 pri_order[LPM_MAX_NUM_MODES] = LPM_DEFAULT_PRI;
> +       u8 mode_order[LPM_MAX_NUM_MODES];
> +       u32 lpm_pri;
>         u32 lpm_en;
>         int mode, i, p;
>
> @@ -1462,24 +1495,28 @@ static void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
>         lpm_en = pmc_core_reg_read(pmcdev, pmcdev->map->lpm_en_offset);
>         pmcdev->num_lpm_modes = hweight32(lpm_en);
>
> -       /* Each byte contains information for 2 modes (7:4 and 3:0) */
> -       for (mode = 0; mode < LPM_MAX_NUM_MODES; mode += 2) {
> -               u8 priority = pmc_core_reg_read_byte(pmcdev,
> -                               pmcdev->map->lpm_priority_offset + (mode / 2));
> -               int pri0 = GENMASK(3, 0) & priority;
> -               int pri1 = (GENMASK(7, 4) & priority) >> 4;
> +       /* Read 32 bit LPM_PRI register */
> +       lpm_pri = pmc_core_reg_read(pmcdev, pmcdev->map->lpm_priority_offset);
>
> -               lpm_priority[pri0] = mode;
> -               lpm_priority[pri1] = mode + 1;
> -       }
>
>         /*
> -        * Loop though all modes from lowest to highest priority,
> +        * If lpm_pri value passes verification, then override the default
> +        * modes here. Otherwise stick with the default.
> +        */
> +       if (pmc_core_pri_verify(lpm_pri, mode_order))
> +               /* Get list of modes in priority order */
> +               for (mode = 0; mode < LPM_MAX_NUM_MODES; mode++)
> +                       pri_order[mode_order[mode]] = mode;
> +       else
> +               dev_warn(&pdev->dev, "Assuming a default substate order for this platform\n");
> +
> +       /*
> +        * Loop through all modes from lowest to highest priority,
>          * and capture all enabled modes in order
>          */
>         i = 0;
>         for (p = LPM_MAX_NUM_MODES - 1; p >= 0; p--) {
> -               int mode = lpm_priority[p];
> +               int mode = pri_order[p];
>
>                 if (!(BIT(mode) & lpm_en))
>                         continue;
> @@ -1675,7 +1712,7 @@ static int pmc_core_probe(struct platform_device *pdev)
>         mutex_init(&pmcdev->lock);
>
>         pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit(pmcdev);
> -       pmc_core_get_low_power_modes(pmcdev);
> +       pmc_core_get_low_power_modes(pdev);
>         pmc_core_do_dmi_quirks(pmcdev);
>
>         if (pmcdev->map == &tgl_reg_map)
> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
> index e8dae9c6c45f..b9bf3d3d6f7a 100644
> --- a/drivers/platform/x86/intel_pmc_core.h
> +++ b/drivers/platform/x86/intel_pmc_core.h
> @@ -188,6 +188,8 @@ enum ppfear_regs {
>  #define ICL_PMC_SLP_S0_RES_COUNTER_STEP                0x64
>
>  #define LPM_MAX_NUM_MODES                      8
> +#define LPM_DEFAULT_PRI                                { 7, 6, 2, 5, 4, 1, 3, 0 }

What I meant here is to add static_assert() to avoid ARRAY_SIZE() != NUM_MODES.

>  #define GET_X2_COUNTER(v)                      ((v) >> 1)
>  #define LPM_STS_LATCH_MODE                     BIT(31)


-- 
With Best Regards,
Andy Shevchenko
