Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C98D3BF68D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 09:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhGHH7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 03:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhGHH7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 03:59:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C3AC061574;
        Thu,  8 Jul 2021 00:56:51 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ie21so3090379pjb.0;
        Thu, 08 Jul 2021 00:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H49TTePA4MNINpDUvjXg8h5z2g+u65TAF2/0pD6oCxk=;
        b=hvF+73nRlvnE1hgKnSaKV0tVVnWAIKzmi9O3fpjvbgdkw8t+6Z9Y0/f7dBtgx0lpTy
         /dqsoKFZpn+mMd4pJ3Uuqx3eDEXWDx7YDVx8RKBBtonycdEcfClY/0t5m1VQFd4zWE79
         E8UouTeu+kfi+zVoYkJ41CBtq0Qf6Y4/dI63COg9FdeicNzHar1gWCjerJk+R01UtvWl
         sfUgOoHVGs4FA0jSn43vMEJF5Cv5hTOiAmf7AUau9j2obm50/aTD80sKpxjUr80jJpHD
         RQNiVGhzVH2M6XEzuy5pgm0VtChTYNxjI+DB0O47EkHCgAEvdpDc3e+ZnSXdvqPoOeJR
         h1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H49TTePA4MNINpDUvjXg8h5z2g+u65TAF2/0pD6oCxk=;
        b=n4ED3CzdDFVBK8RvXH/s1Mcn0zodTSZwsJA9WFgUpyrLVFyu+0fL3vE1q+4KSs0Uzk
         rl4QlKUddm/tKBtC1oToAGVV6z+TTqwpGwDJDHdlbo5mVKoKiWms91TTr+PJfGHF6/eI
         +PFk/vTUvrVdiPlpWAhq7o4+FGL+0h1kNDaWEoZ7ux4r1xEl3ljL5wps4/lKQwTbJu9i
         MdJKf9uqqrnrDkF2unijaSuCBwMC2CI4Pmo0NoBdndtYuLWhEWx4hTnPkPJKKVjxWToK
         9QaogKOuyTZmePhk8qYCeDVsx5KketFT+sPk5btm5CHrm4lXIhQTk+JHUvCCGZkmixta
         l+BA==
X-Gm-Message-State: AOAM531+wcIzuSQG4Syr93MDKwdnkJWEkErlleYdLu0o0k8k6csnDINW
        b8NV7W05NMivmUMqLaTdDgmE4+Fm4OIvhgC03SE=
X-Google-Smtp-Source: ABdhPJw8qkV/I1wIeO5JvBSngmjoJiLuq8SqSkTXhW3YeDaPn1KIaeruOvoW5CrAWEo24Egkia9SYF+sJ31tLc5NGxk=
X-Received: by 2002:a17:90b:85:: with SMTP id bb5mr18488396pjb.228.1625731011208;
 Thu, 08 Jul 2021 00:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1625709047.git.gayatri.kammela@intel.com> <ffbbbc22605014d0de6eabaf7f1441a761456cb2.1625709047.git.gayatri.kammela@intel.com>
In-Reply-To: <ffbbbc22605014d0de6eabaf7f1441a761456cb2.1625709047.git.gayatri.kammela@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 8 Jul 2021 10:56:15 +0300
Message-ID: <CAHp75VdFpJBEWBJMJexK3muvWt+EEqMMyVtxMvm9sSXhkysaww@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] platform/x86/intel: intel_pmc_core: Move
 intel_pmc_core* files to pmc subfolder
To:     Gayatri Kammela <gayatri.kammela@intel.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tamar Mashiah <tamar.mashiah@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 8, 2021 at 5:10 AM Gayatri Kammela
<gayatri.kammela@intel.com> wrote:
>
> As part of collecting Intel x86 specific drivers in their own
> folder, move intel_pmc_core* files to its own subfolder there.

I'm fine with this, it is also possible I think to drop intel_pmc_
prefix from the file names (core.c, core.h, pltdrv.c). In any case it
may be done later on.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
> Cc: David Box <david.e.box@intel.com>
> Cc: You-Sheng Yang <vicamo.yang@canonical.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
> ---
>  drivers/platform/x86/Kconfig                  | 21 ------------------
>  drivers/platform/x86/Makefile                 |  1 -
>  drivers/platform/x86/intel/Kconfig            |  1 +
>  drivers/platform/x86/intel/Makefile           |  1 +
>  drivers/platform/x86/intel/pmc/Kconfig        | 22 +++++++++++++++++++
>  drivers/platform/x86/intel/pmc/Makefile       |  5 +++++
>  .../x86/{ => intel/pmc}/intel_pmc_core.c      |  0
>  .../x86/{ => intel/pmc}/intel_pmc_core.h      |  0
>  .../{ => intel/pmc}/intel_pmc_core_pltdrv.c   |  0
>  9 files changed, 29 insertions(+), 22 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/pmc/Kconfig
>  create mode 100644 drivers/platform/x86/intel/pmc/Makefile
>  rename drivers/platform/x86/{ => intel/pmc}/intel_pmc_core.c (100%)
>  rename drivers/platform/x86/{ => intel/pmc}/intel_pmc_core.h (100%)
>  rename drivers/platform/x86/{ => intel/pmc}/intel_pmc_core_pltdrv.c (100%)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 7d385c3b2239..cae72922f448 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1184,27 +1184,6 @@ config INTEL_MRFLD_PWRBTN
>           To compile this driver as a module, choose M here: the module
>           will be called intel_mrfld_pwrbtn.
>
> -config INTEL_PMC_CORE
> -       tristate "Intel PMC Core driver"
> -       depends on PCI
> -       depends on ACPI
> -       help
> -         The Intel Platform Controller Hub for Intel Core SoCs provides access
> -         to Power Management Controller registers via various interfaces. This
> -         driver can utilize debugging capabilities and supported features as
> -         exposed by the Power Management Controller. It also may perform some
> -         tasks in the PMC in order to enable transition into the SLPS0 state.
> -         It should be selected on all Intel platforms supported by the driver.
> -
> -         Supported features:
> -               - SLP_S0_RESIDENCY counter
> -               - PCH IP Power Gating status
> -               - LTR Ignore / LTR Show
> -               - MPHY/PLL gating status (Sunrisepoint PCH only)
> -               - SLPS0 Debug registers (Cannonlake/Icelake PCH)
> -               - Low Power Mode registers (Tigerlake and beyond)
> -               - PMC quirks as needed to enable SLPS0/S0ix
> -
>  config INTEL_PMT_CLASS
>         tristate
>         help
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 7ee369aab10d..43d36f8c36f1 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -128,7 +128,6 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)             += intel-uncore-frequency.o
>  obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)     += intel_bxtwc_tmu.o
>  obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)    += intel_chtdc_ti_pwrbtn.o
>  obj-$(CONFIG_INTEL_MRFLD_PWRBTN)       += intel_mrfld_pwrbtn.o
> -obj-$(CONFIG_INTEL_PMC_CORE)           += intel_pmc_core.o intel_pmc_core_pltdrv.o
>  obj-$(CONFIG_INTEL_PMT_CLASS)          += intel_pmt_class.o
>  obj-$(CONFIG_INTEL_PMT_TELEMETRY)      += intel_pmt_telemetry.o
>  obj-$(CONFIG_INTEL_PMT_CRASHLOG)       += intel_pmt_crashlog.o
> diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
> index f2eef337eb98..8ca021785f67 100644
> --- a/drivers/platform/x86/intel/Kconfig
> +++ b/drivers/platform/x86/intel/Kconfig
> @@ -18,5 +18,6 @@ if X86_PLATFORM_DRIVERS_INTEL
>
>  source "drivers/platform/x86/intel/int33fe/Kconfig"
>  source "drivers/platform/x86/intel/int3472/Kconfig"
> +source "drivers/platform/x86/intel/pmc/Kconfig"
>
>  endif # X86_PLATFORM_DRIVERS_INTEL
> diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
> index 0653055942d5..49962f4dfdec 100644
> --- a/drivers/platform/x86/intel/Makefile
> +++ b/drivers/platform/x86/intel/Makefile
> @@ -6,3 +6,4 @@
>
>  obj-$(CONFIG_INTEL_CHT_INT33FE)                += int33fe/
>  obj-$(CONFIG_INTEL_SKL_INT3472)                += int3472/
> +obj-$(CONFIG_INTEL_PMC_CORE)           += pmc/
> diff --git a/drivers/platform/x86/intel/pmc/Kconfig b/drivers/platform/x86/intel/pmc/Kconfig
> new file mode 100644
> index 000000000000..b4c955a35674
> --- /dev/null
> +++ b/drivers/platform/x86/intel/pmc/Kconfig
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config INTEL_PMC_CORE
> +       tristate "Intel PMC Core driver"
> +       depends on PCI
> +       depends on ACPI
> +       help
> +         The Intel Platform Controller Hub for Intel Core SoCs provides access
> +         to Power Management Controller registers via various interfaces. This
> +         driver can utilize debugging capabilities and supported features as
> +         exposed by the Power Management Controller. It also may perform some
> +         tasks in the PMC in order to enable transition into the SLPS0 state.
> +         It should be selected on all Intel platforms supported by the driver.
> +
> +         Supported features:
> +               - SLP_S0_RESIDENCY counter
> +               - PCH IP Power Gating status
> +               - LTR Ignore / LTR Show
> +               - MPHY/PLL gating status (Sunrisepoint PCH only)
> +               - SLPS0 Debug registers (Cannonlake/Icelake PCH)
> +               - Low Power Mode registers (Tigerlake and beyond)
> +               - PMC quirks as needed to enable SLPS0/S0ix
> diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
> new file mode 100644
> index 000000000000..633a7598d6d6
> --- /dev/null
> +++ b/drivers/platform/x86/intel/pmc/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +
> +obj-$(CONFIG_INTEL_PMC_CORE)   += intel_pmc_core.o
> +obj-$(CONFIG_INTEL_PMC_CORE)   += intel_pmc_core_pltdrv.o
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel/pmc/intel_pmc_core.c
> similarity index 100%
> rename from drivers/platform/x86/intel_pmc_core.c
> rename to drivers/platform/x86/intel/pmc/intel_pmc_core.c
> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel/pmc/intel_pmc_core.h
> similarity index 100%
> rename from drivers/platform/x86/intel_pmc_core.h
> rename to drivers/platform/x86/intel/pmc/intel_pmc_core.h
> diff --git a/drivers/platform/x86/intel_pmc_core_pltdrv.c b/drivers/platform/x86/intel/pmc/intel_pmc_core_pltdrv.c
> similarity index 100%
> rename from drivers/platform/x86/intel_pmc_core_pltdrv.c
> rename to drivers/platform/x86/intel/pmc/intel_pmc_core_pltdrv.c
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
