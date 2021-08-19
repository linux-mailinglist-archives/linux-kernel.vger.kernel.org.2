Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70E73F1F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhHSRsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhHSRsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:48:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F5FC061575;
        Thu, 19 Aug 2021 10:47:25 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id x4so6587012pgh.1;
        Thu, 19 Aug 2021 10:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MsSykb7a1meDN6Q2YdAV3fzLY/Hr5ssQQNISUwM4JXY=;
        b=VdIn36A2LBD+Q3OcPD9bqzSDILY6SqkwypqYtkykFkhaPSaeu2fPNKALukkbN8wvpd
         4r5wPfNuD0vDz9Sbg64WZckb1/FTtVlQmOh3fwEZUPXqRkMX2L+TLkuNq5oZkIWAeErz
         g4ztdq3275BCZLE1pYV/UEtlwDLneXLiGPIU6N2/jdcqTdVn9OsEPWkR9KJ7zzSwmdei
         u1i4tU+csd44v+Z6kBjAiQ7CKIWUqrYNbfPbs++GOZ+t/DHj+7xCG+JhOAIGVNQ7YMFk
         /XoBWOSUcDATaWcRfO9O/Bd5Ymz7rXySmswI0CtzLnVMPyauHT/ZFCSifzgLGn/Yp2mJ
         KhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MsSykb7a1meDN6Q2YdAV3fzLY/Hr5ssQQNISUwM4JXY=;
        b=kjrd/nSYSB941pibqwuz9d3gkI7tzbtnjdmJWLyfpkFJfGm+YWGhiIbFxI0lVrdC9s
         Z3j4nFtajB+CYc1Xuw54SwTQGj40Kvr65Emtru2lZzbnNMn+sWmxTuMnD1CqlijecCrH
         1MZ7n6G5k3vug/W0CMbCYsCKxFq8gmv8WVALFsoWcAaDvJX8uS27eyuRuTSX0EYBNQFi
         Of36bJdKVAkG7R5vAkjYd2/SzH0/AbqTq/BDqnX0BMICkEo3TtITnSxQj/L+YsUKkXTm
         yTtsWa0qv8R04V3izhyJw4mbJMTQF40jhCfN+NuBtEc/1Upwa6wU8hLxId2uVwMcJ7h8
         dGfQ==
X-Gm-Message-State: AOAM533adEeOVO8I0wVJ2+OzQ8VqJDzaYMdLbehtSX4ZbmHVrhpyuO0C
        1AjBcAMwmJeOqmdgIcKf6Y1Ovg+jphIAzu/D2Nk=
X-Google-Smtp-Source: ABdhPJwRhOqz/FztXwWXzrr+goOARPShBRc7ZKiqNOxK+GbUHuldr5GcgrRKB4hHZ1H+tvGKtYW2A5s4B6bwU82Uk10=
X-Received: by 2002:aa7:800b:0:b029:330:455f:57a8 with SMTP id
 j11-20020aa7800b0000b0290330455f57a8mr15468309pfi.7.1629395244430; Thu, 19
 Aug 2021 10:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 19 Aug 2021 20:46:45 +0300
Message-ID: <CAHp75VemfL0tA+Z_gqu62wPRFADhOmZG=0o+9eFRLfu+1GO1aQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/21] platform/x86: Intel platform driver code movement
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Kate Hsuan <hpa@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Dell.Client.Kernel@dell.com, Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 7:38 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> This is v4 of the Intel drivers move on in the source tree.
> v3 has been done by Kate:
> https://lore.kernel.org/platform-driver-x86/20210819033001.20136-1-hpa@redhat.com/
>
> I have taken the initial set from review-hans branch and removed Hans' SoB
> along with Link, while leaving others' tags.

So, I have noticed the report about SCU and taking into account IPS
header deferred move, I think those two should be excluded from the
series and sent after rc1, it will also eliminate trampoline move for
IPS header, since we may send one patch which includes DRM changes.

Hans, what do you think?

> Changelog v4:
> - spelled fully the driver names in the commit messages
> - fixed SCU *.ko module names
> - dropped extra prefix in PMC files
> - dropped stray changes within the series
> - removed confusing comments in Makefile and Kconfig files
> - embedded a few of Kconfig improvements here and there (ordering, spelling)
> - split miscellaneous group
> - added a patch to fix kernel doc issue in SCU IPC code
>
> Andy Shevchenko (1):
>   platform/x86/intel: scu: Fix doc of
>     intel_scu_ipc_dev_command_with_size()
>
> Kate Hsuan (20):
>   platform/x86: intel_bxtwc_tmu: Move to intel sub-directory
>   platform/x86: intel_chtdc_ti_pwrbtn: Move to intel sub-directory
>   platform/x86: intel_mrfld_pwrbtn: Move to intel sub-directory
>   platform/x86: intel_punit_ipc: Move to intel sub-directory
>   platform/x86: intel_pmc_core: Move to intel sub-directory
>   platform/x86: intel_scu: Move to intel sub-directory
>   platform/x86: intel_telemetry: Move to intel sub-directory
>   platform/x86: intel_ips: Move to intel sub-directory
>   platform/x86: intel-rst: Move to intel sub-directory
>   platform/x86: intel-smartconnect: Move to intel sub-directory
>   platform/x86: intel_turbo_max_3: Move to intel sub-directory
>   platform/x86: intel-uncore-frequency: Move to intel sub-directory
>   platform/x86: intel_speed_select_if: Move to intel sub-directory
>   platform/x86: intel_atomisp2: Move to intel sub-directory
>   platform/x86: intel-hid: Move to intel sub-directory
>   platform/x86: intel_int0002_vgpio: Move to intel sub-directory
>   platform/x86: intel_oaktrail: Move to intel sub-directory
>   platform/x86: intel-vbtn: Move to intel sub-directory
>   platform/x86: intel-wmi-sbl-fw-update: Move to intel sub-directory
>   platform/x86: intel-wmi-thunderbolt: Move to intel sub-directory
>
>  MAINTAINERS                                   |  24 +-
>  drivers/platform/x86/Kconfig                  | 288 ------------------
>  drivers/platform/x86/Makefile                 |  31 --
>  drivers/platform/x86/intel/Kconfig            | 158 ++++++++++
>  drivers/platform/x86/intel/Makefile           |  40 +++
>  drivers/platform/x86/intel/atomisp2/Kconfig   |  43 +++
>  drivers/platform/x86/intel/atomisp2/Makefile  |   9 +
>  .../atomisp2/led.c}                           |   0
>  .../atomisp2/pm.c}                            |   0
>  .../{intel_bxtwc_tmu.c => intel/bxtwc_tmu.c}  |   0
>  .../chtdc_ti_pwrbtn.c}                        |   0
>  .../platform/x86/{intel-hid.c => intel/hid.c} |   2 +-
>  .../int0002_vgpio.c}                          |   0
>  .../platform/x86/{intel_ips.c => intel/ips.c} |   3 +-
>  .../mrfld_pwrbtn.c}                           |   0
>  .../{intel_oaktrail.c => intel/oaktrail.c}    |   0
>  drivers/platform/x86/intel/pmc/Kconfig        |  25 ++
>  drivers/platform/x86/intel/pmc/Makefile       |   9 +
>  .../{intel_pmc_core.c => intel/pmc/core.c}    |   2 +-
>  .../{intel_pmc_core.h => intel/pmc/core.h}    |   0
>  .../pmc/pltdrv.c}                             |   0
>  .../{intel_punit_ipc.c => intel/punit_ipc.c}  |   0
>  .../platform/x86/{intel-rst.c => intel/rst.c} |   0
>  drivers/platform/x86/intel/scu/Kconfig        |  51 ++++
>  drivers/platform/x86/intel/scu/Makefile       |  15 +
>  .../x86/{intel_scu_ipc.c => intel/scu/ipc.c}  |   2 +-
>  .../scu/ipcutil.c}                            |   0
>  .../scu/pcidrv.c}                             |   0
>  .../scu/pltdrv.c}                             |   0
>  .../x86/{intel_scu_wdt.c => intel/scu/wdt.c}  |   0
>  .../smartconnect.c}                           |   0
>  .../speed_select_if}/Kconfig                  |   0
>  .../speed_select_if}/Makefile                 |   0
>  .../speed_select_if}/isst_if_common.c         |   0
>  .../speed_select_if}/isst_if_common.h         |   0
>  .../speed_select_if}/isst_if_mbox_msr.c       |   0
>  .../speed_select_if}/isst_if_mbox_pci.c       |   0
>  .../speed_select_if}/isst_if_mmio.c           |   0
>  drivers/platform/x86/intel/telemetry/Kconfig  |  16 +
>  drivers/platform/x86/intel/telemetry/Makefile |  11 +
>  .../telemetry/core.c}                         |   0
>  .../telemetry/debugfs.c}                      |   0
>  .../telemetry/pltdrv.c}                       |   0
>  .../turbo_max_3.c}                            |   0
>  .../uncore-frequency.c}                       |   0
>  .../x86/{intel-vbtn.c => intel/vbtn.c}        |   2 +-
>  drivers/platform/x86/intel/wmi/Kconfig        |  31 ++
>  drivers/platform/x86/intel/wmi/Makefile       |   9 +
>  .../wmi/sbl-fw-update.c}                      |   0
>  .../wmi/thunderbolt.c}                        |   0
>  50 files changed, 435 insertions(+), 336 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/atomisp2/Kconfig
>  create mode 100644 drivers/platform/x86/intel/atomisp2/Makefile
>  rename drivers/platform/x86/{intel_atomisp2_led.c => intel/atomisp2/led.c} (100%)
>  rename drivers/platform/x86/{intel_atomisp2_pm.c => intel/atomisp2/pm.c} (100%)
>  rename drivers/platform/x86/{intel_bxtwc_tmu.c => intel/bxtwc_tmu.c} (100%)
>  rename drivers/platform/x86/{intel_chtdc_ti_pwrbtn.c => intel/chtdc_ti_pwrbtn.c} (100%)
>  rename drivers/platform/x86/{intel-hid.c => intel/hid.c} (99%)
>  rename drivers/platform/x86/{intel_int0002_vgpio.c => intel/int0002_vgpio.c} (100%)
>  rename drivers/platform/x86/{intel_ips.c => intel/ips.c} (99%)
>  rename drivers/platform/x86/{intel_mrfld_pwrbtn.c => intel/mrfld_pwrbtn.c} (100%)
>  rename drivers/platform/x86/{intel_oaktrail.c => intel/oaktrail.c} (100%)
>  create mode 100644 drivers/platform/x86/intel/pmc/Kconfig
>  create mode 100644 drivers/platform/x86/intel/pmc/Makefile
>  rename drivers/platform/x86/{intel_pmc_core.c => intel/pmc/core.c} (99%)
>  rename drivers/platform/x86/{intel_pmc_core.h => intel/pmc/core.h} (100%)
>  rename drivers/platform/x86/{intel_pmc_core_pltdrv.c => intel/pmc/pltdrv.c} (100%)
>  rename drivers/platform/x86/{intel_punit_ipc.c => intel/punit_ipc.c} (100%)
>  rename drivers/platform/x86/{intel-rst.c => intel/rst.c} (100%)
>  create mode 100644 drivers/platform/x86/intel/scu/Kconfig
>  create mode 100644 drivers/platform/x86/intel/scu/Makefile
>  rename drivers/platform/x86/{intel_scu_ipc.c => intel/scu/ipc.c} (99%)
>  rename drivers/platform/x86/{intel_scu_ipcutil.c => intel/scu/ipcutil.c} (100%)
>  rename drivers/platform/x86/{intel_scu_pcidrv.c => intel/scu/pcidrv.c} (100%)
>  rename drivers/platform/x86/{intel_scu_pltdrv.c => intel/scu/pltdrv.c} (100%)
>  rename drivers/platform/x86/{intel_scu_wdt.c => intel/scu/wdt.c} (100%)
>  rename drivers/platform/x86/{intel-smartconnect.c => intel/smartconnect.c} (100%)
>  rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/Kconfig (100%)
>  rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/Makefile (100%)
>  rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_common.c (100%)
>  rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_common.h (100%)
>  rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_mbox_msr.c (100%)
>  rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_mbox_pci.c (100%)
>  rename drivers/platform/x86/{intel_speed_select_if => intel/speed_select_if}/isst_if_mmio.c (100%)
>  create mode 100644 drivers/platform/x86/intel/telemetry/Kconfig
>  create mode 100644 drivers/platform/x86/intel/telemetry/Makefile
>  rename drivers/platform/x86/{intel_telemetry_core.c => intel/telemetry/core.c} (100%)
>  rename drivers/platform/x86/{intel_telemetry_debugfs.c => intel/telemetry/debugfs.c} (100%)
>  rename drivers/platform/x86/{intel_telemetry_pltdrv.c => intel/telemetry/pltdrv.c} (100%)
>  rename drivers/platform/x86/{intel_turbo_max_3.c => intel/turbo_max_3.c} (100%)
>  rename drivers/platform/x86/{intel-uncore-frequency.c => intel/uncore-frequency.c} (100%)
>  rename drivers/platform/x86/{intel-vbtn.c => intel/vbtn.c} (99%)
>  create mode 100644 drivers/platform/x86/intel/wmi/Kconfig
>  create mode 100644 drivers/platform/x86/intel/wmi/Makefile
>  rename drivers/platform/x86/{intel-wmi-sbl-fw-update.c => intel/wmi/sbl-fw-update.c} (100%)
>  rename drivers/platform/x86/{intel-wmi-thunderbolt.c => intel/wmi/thunderbolt.c} (100%)
>
> --
> 2.32.0
>


-- 
With Best Regards,
Andy Shevchenko
