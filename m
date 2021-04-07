Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905D53570BD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353738AbhDGPqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353705AbhDGPqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:46:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2489C061756;
        Wed,  7 Apr 2021 08:45:57 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u11so6056694wrp.4;
        Wed, 07 Apr 2021 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jGBFXOvLGMSZviZxbm30epWCygLIhUM6cpx63lkaaRA=;
        b=qg5+BMZmpBYLOt5baQoODnuhF65Vpkt6ZN/T13ukIjPy3BS6DsiSkjxQYv9NX2jU9w
         ST0CVgXkQbyLnCRXHM2MF7ageeuSXqLMGfVcsNF0FtuXeCKXyjtn4nSTc5l9B1XYiFhG
         1T8lt3/h7OHz0Mhm41McMOg/WZ5GWHIEVNMPouZZdILYI2VcldGtSl+tpcxQV2FiTzBn
         Bsd2PXLzUgV7kpvSN/pxd+pmD6OYKOoUvgLJvBJRyN+7nfyOZScs9sLzJgD2BM5DDR2q
         EE6rAA75XJTzdH3KYkbsmYg9B2st9lzuErFNBasfOAfFSryPokYmUm/HKz5kKRosvaMF
         +TXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGBFXOvLGMSZviZxbm30epWCygLIhUM6cpx63lkaaRA=;
        b=S6NpJsX8YiLkFjfDgQF48m+tmEOiJHuaqVH5PEGIm5wNQG0gPQ1L1VqF6cqtK7OTBv
         O5TyqFEQFbwMCxOuS9RBvWzkaxGwD8i1jgK//3qV4OmjqZud+GR95KL0AC841GAIFO0k
         4t8F1aBCor62ahwlM/cv/1cDcQj1es9Rl77JPBF364ox46pGFI1ePFmr+D7b2ynclYV8
         MEEo4qOLLQj6JfPv3WXgIBTqs5KXGFMehmTppBfNwcwBBzargq22SwMoaiADXGleabLe
         jmyp4FSaxcY9aCnuxpzwYMi/nc5olrPKbm6yrV0YxGSL3CjNdRuSmdKGGozKkTDUCZ/X
         VgGg==
X-Gm-Message-State: AOAM533HDnQ/OwPdCRPOPcX37pImam1PQhRDqrWvnMDVs1u0O429jzUw
        OrlsUDiTBbU+njxXa4Tbzwv2yjRbYf4zQHu719K8bZFa+28=
X-Google-Smtp-Source: ABdhPJyYjSKFqR3DnlSH2JvI7O2ybR5BfTLazWkUIY2AHclFwgUYsiohC0qZVCeP49OPkasBVyIjo8QupEeQ6KeWdiw=
X-Received: by 2002:a5d:6a0b:: with SMTP id m11mr5265157wru.108.1617810356088;
 Wed, 07 Apr 2021 08:45:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210401030558.2301621-1-david.e.box@linux.intel.com> <20210401030558.2301621-7-david.e.box@linux.intel.com>
In-Reply-To: <20210401030558.2301621-7-david.e.box@linux.intel.com>
From:   Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Date:   Wed, 7 Apr 2021 11:45:30 -0400
Message-ID: <CAE2upjR2062tGztm15NVTTKOACtrO-Rc4PH7t=_t-Bm5RGzVhw@mail.gmail.com>
Subject: Re: [PATCH 6/9] platform/x86: intel_pmc_core: Add requirements file
 to debugfs
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
> Add the debugfs file, substate_requirements, to view the low power mode
> (LPM) requirements for each enabled mode alongside the last latched status
> of the condition.
>
> After this patch, the new file will look like this:
>
>                     Element |    S0i2.0 |    S0i3.0 |    S0i2.1 |    S0i3.1 |    S0i3.2 |    Status |
>             USB2PLL_OFF_STS |  Required |  Required |  Required |  Required |  Required |           |
> PCIe/USB3.1_Gen2PLL_OFF_STS |  Required |  Required |  Required |  Required |  Required |           |
>        PCIe_Gen3PLL_OFF_STS |  Required |  Required |  Required |  Required |  Required |       Yes |
>             OPIOPLL_OFF_STS |  Required |  Required |  Required |  Required |  Required |       Yes |
>               OCPLL_OFF_STS |  Required |  Required |  Required |  Required |  Required |       Yes |
>             MainPLL_OFF_STS |           |  Required |           |  Required |  Required |           |
>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
> Co-developed-by: David E. Box <david.e.box@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 86 +++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index 0ec26a4c715e..0b47a1da5f49 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -1122,6 +1122,86 @@ static int pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_l_sts_regs);
>
> +static void pmc_core_substate_req_header_show(struct seq_file *s)
> +{
> +       struct pmc_dev *pmcdev = s->private;
> +       int i, mode;
> +
> +       seq_printf(s, "%30s |", "Element");
> +       pmc_for_each_mode(i, mode, pmcdev)
> +               seq_printf(s, " %9s |", pmc_lpm_modes[mode]);
> +
> +       seq_printf(s, " %9s |\n", "Status");
> +}
> +
> +static int pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
> +{
> +       struct pmc_dev *pmcdev = s->private;
> +       const struct pmc_bit_map **maps = pmcdev->map->lpm_sts;
> +       const struct pmc_bit_map *map;
> +       const int num_maps = pmcdev->map->lpm_num_maps;
> +       u32 sts_offset = pmcdev->map->lpm_status_offset;
> +       u32 *lpm_req_regs = pmcdev->lpm_req_regs;
> +       int mp;
> +
> +       /* Display the header */
> +       pmc_core_substate_req_header_show(s);
> +
> +       /* Loop over maps */
> +       for (mp = 0; mp < num_maps; mp++) {
> +               u32 req_mask = 0;
> +               u32 lpm_status;
> +               int mode, idx, i, len = 32;
> +
> +               /*
> +                * Capture the requirements and create a mask so that we only
> +                * show an element if it's required for at least one of the
> +                * enabled low power modes
> +                */
> +               pmc_for_each_mode(idx, mode, pmcdev)
> +                       req_mask |= lpm_req_regs[mp + (mode * num_maps)];
> +
> +               /* Get the last latched status for this map */
> +               lpm_status = pmc_core_reg_read(pmcdev, sts_offset + (mp * 4));
> +
> +               /*  Loop over elements in this map */
> +               map = maps[mp];
> +               for (i = 0; map[i].name && i < len; i++) {
> +                       u32 bit_mask = map[i].bit_mask;
> +
> +                       if (!(bit_mask & req_mask))
> +                               /*
> +                                * Not required for any enabled states
> +                                * so don't display
> +                                */
> +                               continue;
> +
> +                       /* Display the element name in the first column */
> +                       seq_printf(s, "%30s |", map[i].name);
> +
> +                       /* Loop over the enabled states and display if required */
> +                       pmc_for_each_mode(idx, mode, pmcdev) {
> +                               if (lpm_req_regs[mp + (mode * num_maps)] & bit_mask)
> +                                       seq_printf(s, " %9s |",
> +                                                  "Required");
> +                               else
> +                                       seq_printf(s, " %9s |", " ");
> +                       }
> +
> +                       /* In Status column, show the last captured state of this agent */
> +                       if (lpm_status & bit_mask)
> +                               seq_printf(s, " %9s |", "Yes");
> +                       else
> +                               seq_printf(s, " %9s |", " ");

Why is this left blank, maybe NA (Not Available)?

> +
> +                       seq_puts(s, "\n");
> +               }
> +       }
> +
> +       return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_req_regs);
> +
>  static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
>  {
>         struct pmc_dev *pmcdev = s->private;
> @@ -1241,6 +1321,12 @@ static void pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
>                                     pmcdev->dbgfs_dir, pmcdev,
>                                     &pmc_core_substate_l_sts_regs_fops);
>         }
> +
> +       if (pmcdev->lpm_req_regs) {
> +               debugfs_create_file("substate_requirements", 0444,
> +                                   pmcdev->dbgfs_dir, pmcdev,
> +                                   &pmc_core_substate_req_regs_fops);
> +       }
>  }
>
>  static const struct x86_cpu_id intel_pmc_core_ids[] = {
> --
> 2.25.1
>


-- 
Thanks,
Rajneesh
