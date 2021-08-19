Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D2A3F201B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 20:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbhHSSq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 14:46:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50450 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233673AbhHSSqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 14:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629398778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mp6JRODDOMDULbgwkWwWxXlqpM0gMNdzNPF7+WaaEQI=;
        b=LuZkDcAmqb6aKa3GA4rk+WYOeUST4Oi/75SHwFnmcftkPwL2jXbruqgDuTqtwQHpcA+A5Q
        OVuYPEOZKEm91mMEBFjd27i8SqbiMzl6i9/G28b+ZeA8ejuLi3Tj6iHszyYv/wGtgObn83
        8oV3SRTHZnr9puujaBblNbuCcFwhDoM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-RgVDWtdxO4Ojzy4SnGahaw-1; Thu, 19 Aug 2021 14:46:16 -0400
X-MC-Unique: RgVDWtdxO4Ojzy4SnGahaw-1
Received: by mail-ed1-f70.google.com with SMTP id x24-20020aa7dad8000000b003bed477317eso3293948eds.18
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 11:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mp6JRODDOMDULbgwkWwWxXlqpM0gMNdzNPF7+WaaEQI=;
        b=EqQ4Vhx4k7AcKlA7xFg7P+OWFp8KOUkoeXhyRGROjiDHpPkumUx2LUUanLPOPy89Cy
         CR+P0ilHWtudz992lOYbHvCFYHNwuioH3hkjltoN9gLA8G5kOKOs3D4KpsS/IHKA9RKn
         dmOSlmtuo206IfS/65jfYhdcCrFwFM9nKBhM7anOj5hhmdNzQranixV4Jz0aGRq4kFt7
         CyOUXfFMAnoApXv00jnK+0AtSyGu89OLLv88B/i7AXOktY8pPsv9+1i4ahOxooiDtCgy
         rgXg+jG3I3FD9I/dskkMiZ1TKc+R9erexl4+t1uvqFlvu+ztWIbJAjFuvnGym+HeN5lR
         wvnA==
X-Gm-Message-State: AOAM531Eg0J/np5oT97vfC10MX8l9I7kK2WcZrmGDtxgJ3m1qaq7sXuy
        9NW9CKVLdS2uJp0ZYH9wr1JdCAdamS6/KcN/8P9HK7SgURfltC4Spa1AVBoup0kvYHQI7BdPlAI
        rAOpIUD+m6UAuKhje7TeBBnFV
X-Received: by 2002:a17:906:481b:: with SMTP id w27mr17095134ejq.151.1629398775678;
        Thu, 19 Aug 2021 11:46:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFiEAN27wwP+WjiGXN/yyFsjo+zlLxw1o9i5oNthyRq2o9rvrzCJQ1ZvCVACOdqToR33L5jQ==
X-Received: by 2002:a17:906:481b:: with SMTP id w27mr17095121ejq.151.1629398775508;
        Thu, 19 Aug 2021 11:46:15 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id s13sm1101632edd.12.2021.08.19.11.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 11:46:15 -0700 (PDT)
Subject: Re: [PATCH v4 00/21] platform/x86: Intel platform driver code
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
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>
References: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b152a497-9cbe-83fa-e04a-f5d2a5b875f3@redhat.com>
Date:   Thu, 19 Aug 2021 20:46:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819163735.81803-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/19/21 6:37 PM, Andy Shevchenko wrote:
> This is v4 of the Intel drivers move on in the source tree.
> v3 has been done by Kate:
> https://lore.kernel.org/platform-driver-x86/20210819033001.20136-1-hpa@redhat.com/
> 
> I have taken the initial set from review-hans branch and removed Hans' SoB
> along with Link, while leaving others' tags.
> 
> Changelog v4:
> - spelled fully the driver names in the commit messages
> - fixed SCU *.ko module names

Actually I checked this during review and
CONFIG_INTEL_SCU_IPC, CONFIG_INTEL_SCU_PCI and CONFIG_INTEL_SCU_WDT
are booleans, iow if enabled they are always builtin so the
drivers/platform/x86/intel/scu/Makefile from v3 was correct.

Since the v3 Makefile is more simple I prefer that version,
but if you prefer to keep the v4 version that is fine too.

> - dropped extra prefix in PMC files
> - dropped stray changes within the series
> - removed confusing comments in Makefile and Kconfig files
> - embedded a few of Kconfig improvements here and there (ordering, spelling)
> - split miscellaneous group
> - added a patch to fix kernel doc issue in SCU IPC code

Thanks, I've not (re)reviewed things, but this all sounds good.

> So, I have noticed the report about SCU and taking into account IPS
> header deferred move, I think those two should be excluded from the
> series and sent after rc1, it will also eliminate trampoline move for
> IPS header, since we may send one patch which includes DRM changes.
> 
> Hans, what do you think?

Fixing the SCU thing will require coordination with / an 
ack from the MFD maintainer (Lee) so yeah dropping that for
now and doing the SCU move next cycle is probably the best.

Dropping the IPS move for now is fine with me too.

Can you send a v5 with those 2 patches dropped ?

We can still fix the SCU doc, just in the old place...

Regards,

Hans






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

