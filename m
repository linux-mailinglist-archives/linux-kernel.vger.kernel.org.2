Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB0F3F1786
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 12:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238020AbhHSKwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 06:52:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236149AbhHSKwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 06:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629370337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hw9PckAa7IseurJu5iFQJHE3wRHOR/AClhnKKZL8eDc=;
        b=h2DrS9lntzCORCwKn7UUD0AaPikRRxzf4OSi3cX66h410v4MKJ2HOkgUsVzyB0/ZZUn0iV
        TpMicyuL5aB6ENIF6o+kQ6/UUIDLrWSb7vVOvCD3EFqHBYavxt5OOwg3WRpPpYaJEp+7np
        GLL1ZUKDK2F5eCs6M7RXtRpV4qw3lGo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-pMn00imgNZC38Cddiv3-ng-1; Thu, 19 Aug 2021 06:52:16 -0400
X-MC-Unique: pMn00imgNZC38Cddiv3-ng-1
Received: by mail-ed1-f71.google.com with SMTP id di3-20020a056402318300b003bebf0828a2so2638082edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 03:52:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hw9PckAa7IseurJu5iFQJHE3wRHOR/AClhnKKZL8eDc=;
        b=n6OHb8uQnLjY97qLV336B48coEIQhCUkIs+pioJkwuiWhoi2FpeieXeeF82Dva7wy0
         M3atjr7Y1oep9NxfShs7E0zeABcV7RvXdUYt+cgrEoOD6kJBNo1/crwdz18M2RuqLiIN
         npnmL9mhJacWw10SCooK91rVtf2ItvtxDJGRy0Lbj1blWstJptcyL4hmOQbV5y1EMaly
         eT9ulrtYyxVwaCeGy40oDW3vASn7NC4frWN/kAuj20f1wwRUaY6WZoMxYhxgvh56Bybg
         8GqXTxOCp5KQ+aMHelyPqZ76Ilu1A6DdkW1ITg8JXFZTeHHqlSjAv9raU1NgrZfWFf2G
         2dyA==
X-Gm-Message-State: AOAM533OyEiBrcESDEZydUTYIoZIfcGNehueQ37gYF7/6hjgJS1YXWJb
        j7yLUQE6pgYWbqt59gdmOjtwXVthVjOmrWap5O6UPf3F0BLu2xz4eXA4fToXQXqVnIgPxKYCglB
        XNZkMTtIFNG9GGbbcqdyWn+s3
X-Received: by 2002:a17:906:87c2:: with SMTP id zb2mr15018315ejb.322.1629370335028;
        Thu, 19 Aug 2021 03:52:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7exK4Qc1P3sggnGXNMp02LdfKWvEdApUhwWzydKCxlvP+2wVXDQE1uX5i2UCz5d2HjwA78w==
X-Received: by 2002:a17:906:87c2:: with SMTP id zb2mr15018288ejb.322.1629370334839;
        Thu, 19 Aug 2021 03:52:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id bf15sm1518790edb.83.2021.08.19.03.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Aug 2021 03:52:14 -0700 (PDT)
Subject: Re: [PATCH v7 1/5] platform/x86/intel: intel_pmc_core: Move
 intel_pmc_core* files to pmc subfolder
From:   Hans de Goede <hdegoede@redhat.com>
To:     Gayatri Kammela <gayatri.kammela@intel.com>,
        platform-driver-x86@vger.kernel.org, Kate Hsuan <hpa@redhat.com>
Cc:     mgross@linux.intel.com, irenic.rajneesh@gmail.com,
        andriy.shevchenko@linux.intel.com, vicamo.yang@canonical.com,
        srinivas.pandruvada@intel.com, david.e.box@intel.com,
        chao.qin@intel.com, linux-kernel@vger.kernel.org,
        tamar.mashiah@intel.com, gregkh@linuxfoundation.org,
        rajatja@google.com, Shyam-sundar.S-k@amd.com,
        Alexander.Deucher@amd.com, mlimonci@amd.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <cover.1629091915.git.gayatri.kammela@intel.com>
 <81b6292e50af54fb7eeabfefde6f4a3d283b0b96.1629091915.git.gayatri.kammela@intel.com>
 <c07aa6a9-2cf9-db15-bf8c-9e6ac536a521@redhat.com>
Message-ID: <7ceef504-085b-3146-6ca7-3f6b8ff3280a@redhat.com>
Date:   Thu, 19 Aug 2021 12:52:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c07aa6a9-2cf9-db15-bf8c-9e6ac536a521@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/17/21 8:47 PM, Hans de Goede wrote:
> Hi,
> 
> On 8/16/21 6:58 PM, Gayatri Kammela wrote:
>> As part of collecting Intel x86 specific drivers in their own
>> folder, move intel_pmc_core* files to its own subfolder there.
>>
>> Cc: Chao Qin <chao.qin@intel.com>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
>> Cc: David Box <david.e.box@intel.com>
>> Cc: You-Sheng Yang <vicamo.yang@canonical.com>
>> Cc: Hans de Goede <hdegoede@redhat.com>
>> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
>> ---
>>  MAINTAINERS                                   |  2 +-
>>  drivers/platform/x86/Kconfig                  | 21 ------------------
>>  drivers/platform/x86/Makefile                 |  1 -
>>  drivers/platform/x86/intel/Kconfig            |  1 +
>>  drivers/platform/x86/intel/Makefile           |  1 +
>>  drivers/platform/x86/intel/pmc/Kconfig        | 22 +++++++++++++++++++
>>  drivers/platform/x86/intel/pmc/Makefile       |  6 +++++
>>  .../{intel_pmc_core.c => intel/pmc/core.c}    |  2 +-
>>  .../{intel_pmc_core.h => intel/pmc/core.h}    |  0
>>  .../pmc/core_platform.c}                      |  0
>>  10 files changed, 32 insertions(+), 24 deletions(-)
>>  create mode 100644 drivers/platform/x86/intel/pmc/Kconfig
>>  create mode 100644 drivers/platform/x86/intel/pmc/Makefile
>>  rename drivers/platform/x86/{intel_pmc_core.c => intel/pmc/core.c} (99%)
>>  rename drivers/platform/x86/{intel_pmc_core.h => intel/pmc/core.h} (100%)
>>  rename drivers/platform/x86/{intel_pmc_core_pltdrv.c => intel/pmc/core_platform.c} (100%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fd25e4ecf0b9..5e118faf8018 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9477,7 +9477,7 @@ M:	David E Box <david.e.box@intel.com>
>>  L:	platform-driver-x86@vger.kernel.org
>>  S:	Maintained
>>  F:	Documentation/ABI/testing/sysfs-platform-intel-pmc
>> -F:	drivers/platform/x86/intel_pmc_core*
>> +F:	drivers/platform/x86/intel/pmc/core*
>>  
>>  INTEL PMIC GPIO DRIVERS
>>  M:	Andy Shevchenko <andy@kernel.org>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index d12db6c316ea..c4ee38eba44b 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -1187,27 +1187,6 @@ config INTEL_MRFLD_PWRBTN
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called intel_mrfld_pwrbtn.
>>  
>> -config INTEL_PMC_CORE
>> -	tristate "Intel PMC Core driver"
>> -	depends on PCI
>> -	depends on ACPI
>> -	help
>> -	  The Intel Platform Controller Hub for Intel Core SoCs provides access
>> -	  to Power Management Controller registers via various interfaces. This
>> -	  driver can utilize debugging capabilities and supported features as
>> -	  exposed by the Power Management Controller. It also may perform some
>> -	  tasks in the PMC in order to enable transition into the SLPS0 state.
>> -	  It should be selected on all Intel platforms supported by the driver.
>> -
>> -	  Supported features:
>> -		- SLP_S0_RESIDENCY counter
>> -		- PCH IP Power Gating status
>> -		- LTR Ignore / LTR Show
>> -		- MPHY/PLL gating status (Sunrisepoint PCH only)
>> -		- SLPS0 Debug registers (Cannonlake/Icelake PCH)
>> -		- Low Power Mode registers (Tigerlake and beyond)
>> -		- PMC quirks as needed to enable SLPS0/S0ix
>> -
>>  config INTEL_PMT_CLASS
>>  	tristate
>>  	help
>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>> index 7ee369aab10d..43d36f8c36f1 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -128,7 +128,6 @@ obj-$(CONFIG_INTEL_UNCORE_FREQ_CONTROL)		+= intel-uncore-frequency.o
>>  obj-$(CONFIG_INTEL_BXTWC_PMIC_TMU)	+= intel_bxtwc_tmu.o
>>  obj-$(CONFIG_INTEL_CHTDC_TI_PWRBTN)	+= intel_chtdc_ti_pwrbtn.o
>>  obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
>> -obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
> 
> This Makefile line will build 2 separate .ko files: intel_pmc_core.ko and
> intel_pmc_core_pltdrv.ko when CONFIG_INTEL_PMC_CORE=m
> 
>>  obj-$(CONFIG_INTEL_PMT_CLASS)		+= intel_pmt_class.o
>>  obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+= intel_pmt_telemetry.o
>>  obj-$(CONFIG_INTEL_PMT_CRASHLOG)	+= intel_pmt_crashlog.o
> 
> <snip>
> 
>> diff --git a/drivers/platform/x86/intel/pmc/Makefile b/drivers/platform/x86/intel/pmc/Makefile
>> new file mode 100644
>> index 000000000000..c92e66846a4a
>> --- /dev/null
>> +++ b/drivers/platform/x86/intel/pmc/Makefile
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +#
>> +
>> +obj-$(CONFIG_INTEL_PMC_CORE)	+= intel_pmc_core.o
>> +intel_pmc_core-objs		:= core.o \
>> +				   core_platform.o
> 
> Whereas this will now build a single intel_pmc_core.ko containing both object files,
> but the 2 .c files have:
> 
> module_platform_driver(pmc_core_driver);
> (which is a macro expanding to a module_init + module_exit function)
> 
> resp.
> 
> module_init(pmc_core_platform_init);
> module_exit(pmc_core_platform_exit);
> 
> So now we have 2 module_init (and _exit) functions in a single .ko
> file and the build will fail, not good.

Kate's big intel driver rename series also had a rename patch
for the pmc_core code in there. Since that did not have this
issue I've applied that one instead (otherwise I also would have
trouble applying the rest of Kate's patch-series).

With the rename issue resolved I can apply the rest of the series
on top of Kate's rename. I will go and do that right away, so
there is no need to send a new version.

###

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



