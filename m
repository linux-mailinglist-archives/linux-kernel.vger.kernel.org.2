Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A06356F85
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 16:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348948AbhDGO7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 10:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353277AbhDGO7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 10:59:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90005C061756;
        Wed,  7 Apr 2021 07:59:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f12so12339933wro.0;
        Wed, 07 Apr 2021 07:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HcxVXaj0ur+VUEHgjw1TAUWAFw7hXltz+jRWOfq7Tpo=;
        b=Tr85yM87/ql0J6nVxDNoDxEuyJlgM7SnEVJq3hbBYsHvKkT2okKJNrGSrWKyxc4sKd
         vzksMPmFw122mXSEuLbrrauUsqkTy2Amsk+I9GAekRj4AAiehrh2Ru288OAqDSpd7DZI
         LGTA3oXNuWHsPaqwcThQB5lwKmYYTCwrkYNH/1jjVZkmxNGLNEiDd8ORbKx3Ee2wGb86
         OAV7jPK7k+AULOUC0VnBdmVMWATYCUAD4NW3+XUiDHP9pnXokK1lGijFIPR/GucfwR/P
         kWML6sfAsPpL57pnJpk+QDAlUqnUEWobI1eqgmjazAEZC916HeNcD6tfCjkDkt+5dtiE
         6gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HcxVXaj0ur+VUEHgjw1TAUWAFw7hXltz+jRWOfq7Tpo=;
        b=Ympd33Z4ffNmspAD1IHZeoomeCKBpd2nIUcEXJPEI8XOdVGenRobvqpLKcsQjpIhhR
         HPOZEKmrf9HcXAqRgu9drf6ofhscUHR4BWpeMhk3Gz8En2DNE5KNm/Z25W0Y46JEC9fy
         uVf89xhD76tCS6VXQ5fxHaXt6KbMFTiZnQBTPxyMDzmqe3cC3tkOUmr9AAatJRBuqs/i
         v50ozD1kMREarTu10qPbFG2YnUWz5yfZIuWIpise8w6dfcbCM0wrRoAUKDhdfeoZ/4EV
         w3HWW2XZ24XGm52Q6oGaafupcp4wC55SWU+z9FSwTUKCkoL0nX+98HObKd4PLR2RiQta
         oXjw==
X-Gm-Message-State: AOAM530JSeYoJOeB4+NNo+ojuAnFnJkpVEJzUcTCjij2qn+I/ArD7wPI
        cEcNrDKIHEYvnYVdNUhRChS6VMT4GuC7gnCe7/ilwy6Mt3s=
X-Google-Smtp-Source: ABdhPJyy6fsMNznMhrbfQxXHOPOa4XWU+Z+EZhl7G5i0EiP5Oaz3RZrDs4MQioO4RNIsGkGfzmS8di4zz2CXA9ZJ9U0=
X-Received: by 2002:a5d:6a0b:: with SMTP id m11mr5010464wru.108.1617807543162;
 Wed, 07 Apr 2021 07:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210401030558.2301621-1-david.e.box@linux.intel.com> <20210401030558.2301621-2-david.e.box@linux.intel.com>
In-Reply-To: <20210401030558.2301621-2-david.e.box@linux.intel.com>
From:   Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Date:   Wed, 7 Apr 2021 10:58:37 -0400
Message-ID: <CAE2upjT143Co-e6G6Hjxr4VcnmFXbHm=nz7fF3Yg54ZK1Xx-oQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] platform/x86: intel_pmc_core: Don't use global pmcdev
 in quirks
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
> The DMI callbacks, used for quirks, currently access the PMC by getting
> the address a global pmc_dev struct. Instead, have the callbacks set a
> global quirk specific variable. In probe, after calling dmi_check_system(),
> pass pmc_dev to a function that will handle each quirk if its variable
> condition is met. This allows removing the global pmc_dev later.
>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index b5888aeb4bcf..260d49dca1ad 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -1186,9 +1186,15 @@ static const struct pci_device_id pmc_pci_ids[] = {
>   * the platform BIOS enforces 24Mhz crystal to shutdown
>   * before PMC can assert SLP_S0#.
>   */
> +static bool xtal_ignore;
>  static int quirk_xtal_ignore(const struct dmi_system_id *id)
>  {
> -       struct pmc_dev *pmcdev = &pmc;
> +       xtal_ignore = true;
> +       return 0;
> +}
> +
> +static void pmc_core_xtal_ignore(struct pmc_dev *pmcdev)
> +{
>         u32 value;
>
>         value = pmc_core_reg_read(pmcdev, pmcdev->map->pm_vric1_offset);
> @@ -1197,7 +1203,6 @@ static int quirk_xtal_ignore(const struct dmi_system_id *id)
>         /* Low Voltage Mode Enable */
>         value &= ~SPT_PMC_VRIC1_SLPS0LVEN;
>         pmc_core_reg_write(pmcdev, pmcdev->map->pm_vric1_offset, value);
> -       return 0;
>  }
>
>  static const struct dmi_system_id pmc_core_dmi_table[]  = {
> @@ -1212,6 +1217,14 @@ static const struct dmi_system_id pmc_core_dmi_table[]  = {
>         {}
>  };
>
> +static void pmc_core_do_dmi_quirks(struct pmc_dev *pmcdev)
> +{
> +       dmi_check_system(pmc_core_dmi_table);
> +
> +       if (xtal_ignore)
> +               pmc_core_xtal_ignore(pmcdev);
> +}
> +
>  static int pmc_core_probe(struct platform_device *pdev)
>  {
>         static bool device_initialized;
> @@ -1253,7 +1266,7 @@ static int pmc_core_probe(struct platform_device *pdev)
>         mutex_init(&pmcdev->lock);
>         platform_set_drvdata(pdev, pmcdev);
>         pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
> -       dmi_check_system(pmc_core_dmi_table);
> +       pmc_core_do_dmi_quirks(pmcdev);
>
>         /*
>          * On TGL, due to a hardware limitation, the GBE LTR blocks PC10 when
> --
> 2.25.1
>


-- 
Thanks,
Rajneesh
