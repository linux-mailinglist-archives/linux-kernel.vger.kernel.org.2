Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EA03F33EE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 20:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbhHTSjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 14:39:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45222 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229927AbhHTSjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629484721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JAkE9dw5nw4AoSHq24fVTDHYd4yCF4qEaK9JbE07S7c=;
        b=eBTQCODEWp+3egu/9za1j1Fzw9E1ae5nJ010g6DWwouqynDNDZGHY0irK0F16FcAbVW240
        5rQrp3UpxEmfU13BxfUVM03qFLKFHLqnTy83bnkkBZXIGf8/aHNLeQ4DZ2C8sd3+E/jF2X
        Rrqgl/aqf1rmkX/nDxZArY94bXhba3w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-063TjBD2NJ-PKAekFJRgJw-1; Fri, 20 Aug 2021 14:38:40 -0400
X-MC-Unique: 063TjBD2NJ-PKAekFJRgJw-1
Received: by mail-ej1-f69.google.com with SMTP id z5-20020a1709067e4500b005c2512038bcso2093295ejr.19
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 11:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JAkE9dw5nw4AoSHq24fVTDHYd4yCF4qEaK9JbE07S7c=;
        b=rOXtjuFo2fFfeMyCSo7pUZCH5F1BqHlEBP2NCFJb/sTdIJLuvlpJi4AONdIuPBeynM
         JBgE5nfEDJWBZzI6XyHkkxfHmTzwHKxPPNtSgw7fpOPikmehQzFomsVqlJhZEsiL6ZX+
         T0kY452Kr3qiFyvmas81IKYMjNEENtK+gNKpi1XcQTr/txvYzhTp8pxRDp8GLyrjAmS2
         +rMaqJ0FmJCbbb07EFnjL4N/AWAElJ7aSn5qFf/UPdf5HhH2TY20gA5sx7uOHZy6wobO
         Aon9SmnshvuCmxu52bxoj2V8ST64C2C8aTSbk+drCI+EfF8DwA7YOmZcItBOkkuaHN4b
         U4Pw==
X-Gm-Message-State: AOAM533lWiYO4pKNv16vUUzpobOolnufPSLj84IJgOD2EG25O7q4/WwZ
        rVwc93HtSUWM6C5qUt8EjCPHlp/htEbmCbaZgIvTSHbGeOV/rjP+PA9HIyVtuKYcQF8Zv4SINLL
        17QnPy1Ei7tCertY+6Zn2gdaT
X-Received: by 2002:a17:906:6011:: with SMTP id o17mr22669027ejj.157.1629484719315;
        Fri, 20 Aug 2021 11:38:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8MnoviMUxtgOFJxiQk/ic8BxfXCsKwZNzaQUSrV4NxwN0HeCKTjBCN523fkLlULgTaEED4A==
X-Received: by 2002:a17:906:6011:: with SMTP id o17mr22669008ejj.157.1629484719135;
        Fri, 20 Aug 2021 11:38:39 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id v6sm3205529ejk.117.2021.08.20.11.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 11:38:38 -0700 (PDT)
Subject: Re: [PATCH v5 00/20] platform/x86: Intel platform driver code
 movement
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Dell.Client.Kernel@dell.com
Cc:     Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>
References: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <6ddeac3f-b06e-8f07-0e34-9bbe4da3967c@redhat.com>
Date:   Fri, 20 Aug 2021 20:38:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210820110458.73018-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/20/21 1:04 PM, Andy Shevchenko wrote:
> This is v5 of the Intel drivers move on in the source tree.
> v4: https://lore.kernel.org/platform-driver-x86/20210819163735.81803-1-andriy.shevchenko@linux.intel.com/
> v3 has been done by Kate:
> https://lore.kernel.org/platform-driver-x86/20210819033001.20136-1-hpa@redhat.com/
> 
> I have taken the initial set from review-hans branch and removed Hans' SoB
> along with Link, while leaving others' tags.
> 
> Changelog v5:
> - dropped SCU and IPS patches since there are somehow problematic
> - added Intel Atom PMC driver move
> - moved SCU kernel doc fix to be first in the series

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I've also re-added the pmc-core Alder Lake support patches from:
https://lore.kernel.org/platform-driver-x86/cover.1629091915.git.gayatri.kammela@intel.com/
Now that the pmc rename is in place.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> 
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
> Andy Shevchenko (2):
>   platform/x86: intel_scu_ipc: Fix doc of
>     intel_scu_ipc_dev_command_with_size()
>   platform/x86: pmc_atom: Move to intel sub-directory
> 
> Kate Hsuan (18):
>   platform/x86: intel_bxtwc_tmu: Move to intel sub-directory
>   platform/x86: intel_chtdc_ti_pwrbtn: Move to intel sub-directory
>   platform/x86: intel_mrfld_pwrbtn: Move to intel sub-directory
>   platform/x86: intel_punit_ipc: Move to intel sub-directory
>   platform/x86: intel_pmc_core: Move to intel sub-directory
>   platform/x86: intel_telemetry: Move to intel sub-directory
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
>  MAINTAINERS                                   |  22 +-
>  drivers/platform/x86/Kconfig                  | 236 ------------------
>  drivers/platform/x86/Makefile                 |  23 --
>  drivers/platform/x86/intel/Kconfig            | 152 +++++++++++
>  drivers/platform/x86/intel/Makefile           |  38 +++
>  drivers/platform/x86/intel/atomisp2/Kconfig   |  43 ++++
>  drivers/platform/x86/intel/atomisp2/Makefile  |   9 +
>  .../atomisp2/led.c}                           |   0
>  .../atomisp2/pm.c}                            |   0
>  .../{intel_bxtwc_tmu.c => intel/bxtwc_tmu.c}  |   0
>  .../chtdc_ti_pwrbtn.c}                        |   0
>  .../platform/x86/{intel-hid.c => intel/hid.c} |   2 +-
>  .../int0002_vgpio.c}                          |   0
>  .../mrfld_pwrbtn.c}                           |   0
>  .../{intel_oaktrail.c => intel/oaktrail.c}    |   0
>  drivers/platform/x86/intel/pmc/Kconfig        |  25 ++
>  drivers/platform/x86/intel/pmc/Makefile       |   9 +
>  .../{intel_pmc_core.c => intel/pmc/core.c}    |   2 +-
>  .../{intel_pmc_core.h => intel/pmc/core.h}    |   0
>  .../pmc/pltdrv.c}                             |   0
>  drivers/platform/x86/{ => intel}/pmc_atom.c   |   0
>  .../{intel_punit_ipc.c => intel/punit_ipc.c}  |   0
>  .../platform/x86/{intel-rst.c => intel/rst.c} |   0
>  .../smartconnect.c}                           |   0
>  .../speed_select_if}/Kconfig                  |   0
>  .../speed_select_if}/Makefile                 |   0
>  .../speed_select_if}/isst_if_common.c         |   0
>  .../speed_select_if}/isst_if_common.h         |   0
>  .../speed_select_if}/isst_if_mbox_msr.c       |   0
>  .../speed_select_if}/isst_if_mbox_pci.c       |   0
>  .../speed_select_if}/isst_if_mmio.c           |   0
>  drivers/platform/x86/intel/telemetry/Kconfig  |  16 ++
>  drivers/platform/x86/intel/telemetry/Makefile |  11 +
>  .../telemetry/core.c}                         |   0
>  .../telemetry/debugfs.c}                      |   0
>  .../telemetry/pltdrv.c}                       |   0
>  .../turbo_max_3.c}                            |   0
>  .../uncore-frequency.c}                       |   0
>  .../x86/{intel-vbtn.c => intel/vbtn.c}        |   2 +-
>  drivers/platform/x86/intel/wmi/Kconfig        |  31 +++
>  drivers/platform/x86/intel/wmi/Makefile       |   9 +
>  .../wmi/sbl-fw-update.c}                      |   0
>  .../wmi/thunderbolt.c}                        |   0
>  drivers/platform/x86/intel_scu_ipc.c          |   2 +-
>  44 files changed, 358 insertions(+), 274 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/atomisp2/Kconfig
>  create mode 100644 drivers/platform/x86/intel/atomisp2/Makefile
>  rename drivers/platform/x86/{intel_atomisp2_led.c => intel/atomisp2/led.c} (100%)
>  rename drivers/platform/x86/{intel_atomisp2_pm.c => intel/atomisp2/pm.c} (100%)
>  rename drivers/platform/x86/{intel_bxtwc_tmu.c => intel/bxtwc_tmu.c} (100%)
>  rename drivers/platform/x86/{intel_chtdc_ti_pwrbtn.c => intel/chtdc_ti_pwrbtn.c} (100%)
>  rename drivers/platform/x86/{intel-hid.c => intel/hid.c} (99%)
>  rename drivers/platform/x86/{intel_int0002_vgpio.c => intel/int0002_vgpio.c} (100%)
>  rename drivers/platform/x86/{intel_mrfld_pwrbtn.c => intel/mrfld_pwrbtn.c} (100%)
>  rename drivers/platform/x86/{intel_oaktrail.c => intel/oaktrail.c} (100%)
>  create mode 100644 drivers/platform/x86/intel/pmc/Kconfig
>  create mode 100644 drivers/platform/x86/intel/pmc/Makefile
>  rename drivers/platform/x86/{intel_pmc_core.c => intel/pmc/core.c} (99%)
>  rename drivers/platform/x86/{intel_pmc_core.h => intel/pmc/core.h} (100%)
>  rename drivers/platform/x86/{intel_pmc_core_pltdrv.c => intel/pmc/pltdrv.c} (100%)
>  rename drivers/platform/x86/{ => intel}/pmc_atom.c (100%)
>  rename drivers/platform/x86/{intel_punit_ipc.c => intel/punit_ipc.c} (100%)
>  rename drivers/platform/x86/{intel-rst.c => intel/rst.c} (100%)
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

