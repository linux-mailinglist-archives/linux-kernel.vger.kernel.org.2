Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4D13E7E32
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 19:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbhHJR2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 13:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhHJR2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 13:28:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD251C0613C1;
        Tue, 10 Aug 2021 10:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=kUui8BWXY4e2j37mNdqf2l/VmZtRa/E/2wWiGmAd+Hc=; b=JYaXhZuXfqnSwcCGUvCEdVKAQd
        VUve/B/KcDuttQ4kDfMY2UQrXqbzCr18a98Hc/h8UEv7oS6+mPd+kAVFOpNk/L5W4+RLrT9Ho9Sh3
        mqo8SpfLtJmesAso1cl7BxhiqHMvFV/9/oHk6pJnz5/dLEPyBMxVSUIHLoeu5XCoC86U9IaQsMAS5
        XhBKyfz/DtG2tkl94K7mBhrv7lSVK4+Ays/HzGrbKgumJyThj46e57fFw+zg9ukk7ROPQl6f0pF46
        7MXHpVFkZGZv9wcvtNdByAPRO3iUjqiVMf7ox+uRyKyn4mc97HPD15oCltLsbPrqcxcsaHLzsJoKO
        Tje3u6Fw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDVYE-004XL5-Ve; Tue, 10 Aug 2021 17:28:31 +0000
Subject: Re: [PATCH 00/20] Move Intel platform drivers to intel directory to
 improve readability.
To:     david.e.box@linux.intel.com, Kate Hsuan <hpa@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Alex Hung <alex.hung@canonical.com>,
        Sujith Thomas <sujith.thomas@intel.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>,
        David E Box <david.e.box@intel.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        AceLan Kao <acelan.kao@canonical.com>,
        Jithu Joseph <jithu.joseph@intel.com>,
        Maurice Ma <maurice.ma@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Scally <djrscally@gmail.com>,
        linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Cc:     platform-driver-x86@vger.kernel.org
References: <20210810095832.4234-1-hpa@redhat.com>
 <9a142d180bffa7524bb36ccdba1c866f8b084720.camel@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c6a90704-5080-d479-0022-58e5d106c026@infradead.org>
Date:   Tue, 10 Aug 2021 10:28:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <9a142d180bffa7524bb36ccdba1c866f8b084720.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/21 10:03 AM, David E. Box wrote:
> Hi,
> 
> On Tue, 2021-08-10 at 17:58 +0800, Kate Hsuan wrote:
>> All the intel platform specific drivers are moved to intel/.
>> It makes more clear file structure to improve the readability.
>>
> 
> A lot of subfolders for single files. Is this necessary? I'm submitting
> a single driver soon, unrelated to anything else. I was just going to
> drop it in /intel.
> 

Ugh, surely not necessary. Not even desirable IMO.

Thanks for bringing that up.

> 
>> Kate Hsuan (20):
>>    Move Intel hid of pdx86 to intel directory to improve readability.
>>    Move Intel WMI driver of pdx86 to intel/ directory to improve
>>      readability.
>>    Move Intel bxtwc driver of pdx86 to intel/ directory to improve
>>      readability.
>>    Move Intel chtdc_ti driver of pdx86 to improve readability.
>>    Move MRFLD power button driver of pdx86 to intel directory to
>> improve
>>      readability.
>>    Move Intel PMC core of pdx86 to intel/ directory to improve
>>      readability.
>>    Move Intel PMT driver of pdx86 to intel/ to improve readability.
>>    Move Intel P-Unit of pdx86 to intel/ directory to improve
>> readability.
>>    Move Intel SCU IPC of pdx86 to intel directory to increase
>>      readability.
>>    Move Intel SoC telemetry driver to intel directory to improve
>>      readability.
>>    Move Intel IPS driver of pdx86 to improve readability.
>>    Move Intel RST driver of pdx86 to intel directory to improve
>>      readability.
>>    Move Intel smartconnect driver of pdx86 to intel/ directory to
>> improve
>>      readability.
>>    Move Intel SST driver to intel/ directory to improve readability.
>>    Move Intel turbo max 3 driver to intel/ directory to improve
>>      readability.
>>    Move Intel uncore freq driver to intel/ directory to improve
>>      readability.
>>    Move Intel int0002 vgpio driver to intel/ directory to inprove
>>      readability.
>>    Move Intel thermal driver for menlow platform driver to intel/
>>      directory to improve readability.
>>    Move OakTrail driver to the intel/ directory to improve
>> readability.
>>    Move Intel virtual botton driver to intel/ directory to improve
>>      readability.
>>
>>   drivers/platform/x86/Kconfig                  | 297 ----------------
>> --
>>   drivers/platform/x86/Makefile                 |  34 +-
>>   drivers/platform/x86/intel/Kconfig            |  21 ++
>>   drivers/platform/x86/intel/Makefile           |  31 ++
>>   drivers/platform/x86/intel/bxtwc/Kconfig      |  15 +
>>   drivers/platform/x86/intel/bxtwc/Makefile     |   6 +
>>   .../x86/{ => intel/bxtwc}/intel_bxtwc_tmu.c   |   0
>>   drivers/platform/x86/intel/chtdc_ti/Kconfig   |  16 +
>>   drivers/platform/x86/intel/chtdc_ti/Makefile  |   7 +
>>   .../chtdc_ti}/intel_chtdc_ti_pwrbtn.c         |   0
>>   drivers/platform/x86/intel/hid/Kconfig        |  17 +
>>   drivers/platform/x86/intel/hid/Makefile       |   7 +
>>   .../platform/x86/{ => intel/hid}/intel-hid.c  |   0
>>   drivers/platform/x86/intel/int0002/Kconfig    |  23 ++
>>   drivers/platform/x86/intel/int0002/Makefile   |   6 +
>>   .../{ => intel/int0002}/intel_int0002_vgpio.c |   0
>>   .../{ => intel}/intel_speed_select_if/Kconfig |   0
>>   .../intel_speed_select_if/Makefile            |   0
>>   .../intel_speed_select_if/isst_if_common.c    |   0
>>   .../intel_speed_select_if/isst_if_common.h    |   0
>>   .../intel_speed_select_if/isst_if_mbox_msr.c  |   0
>>   .../intel_speed_select_if/isst_if_mbox_pci.c  |   0
>>   .../intel_speed_select_if/isst_if_mmio.c      |   0
>>   drivers/platform/x86/intel/ips/Kconfig        |  14 +
>>   drivers/platform/x86/intel/ips/Makefile       |   6 +
>>   .../platform/x86/{ => intel/ips}/intel_ips.c  |   0
>>   .../platform/x86/{ => intel/ips}/intel_ips.h  |   0
>>   drivers/platform/x86/intel/menlow/Kconfig     |  14 +
>>   drivers/platform/x86/intel/menlow/Makefile    |   6 +
>>   .../x86/{ => intel/menlow}/intel_menlow.c     |   0
>>   drivers/platform/x86/intel/mrfld/Kconfig      |  17 +
>>   drivers/platform/x86/intel/mrfld/Makefile     |   6 +
>>   .../{ => intel/mrfld}/intel_mrfld_pwrbtn.c    |   0
>>   drivers/platform/x86/intel/oaktrail/Kconfig   |  15 +
>>   drivers/platform/x86/intel/oaktrail/Makefile  |   6 +
>>   .../x86/{ => intel/oaktrail}/intel_oaktrail.c |   0
>>   drivers/platform/x86/intel/pmc_core/Kconfig   |  26 ++
>>   drivers/platform/x86/intel/pmc_core/Makefile  |   6 +
>>   .../x86/{ => intel/pmc_core}/intel_pmc_core.c |   0
>>   .../x86/{ => intel/pmc_core}/intel_pmc_core.h |   0
>>   .../pmc_core}/intel_pmc_core_pltdrv.c         |   0
>>   drivers/platform/x86/intel/pmt/Kconfig        |  41 +++
>>   drivers/platform/x86/intel/pmt/Makefile       |   9 +
>>   .../x86/{ => intel/pmt}/intel_pmt_class.c     |   0
>>   .../x86/{ => intel/pmt}/intel_pmt_class.h     |   0
>>   .../x86/{ => intel/pmt}/intel_pmt_crashlog.c  |   0
>>   .../x86/{ => intel/pmt}/intel_pmt_telemetry.c |   0
>>   drivers/platform/x86/intel/punit/Kconfig      |  10 +
>>   drivers/platform/x86/intel/punit/Makefile     |   6 +
>>   .../x86/{ => intel/punit}/intel_punit_ipc.c   |   0
>>   drivers/platform/x86/intel/rst/Kconfig        |  16 +
>>   drivers/platform/x86/intel/rst/Makefile       |   6 +
>>   .../platform/x86/{ => intel/rst}/intel-rst.c  |   0
>>   drivers/platform/x86/intel/scu/Kconfig        |  52 +++
>>   drivers/platform/x86/intel/scu/Makefile       |  11 +
>>   .../x86/{ => intel/scu}/intel_scu_ipc.c       |   0
>>   .../x86/{ => intel/scu}/intel_scu_ipcutil.c   |   0
>>   .../x86/{ => intel/scu}/intel_scu_pcidrv.c    |   0
>>   .../x86/{ => intel/scu}/intel_scu_pltdrv.c    |   0
>>   .../x86/{ => intel/scu}/intel_scu_wdt.c       |   0
>>   .../platform/x86/intel/smartconnect/Kconfig   |  18 ++
>>   .../platform/x86/intel/smartconnect/Makefile  |   6 +
>>   .../smartconnect}/intel-smartconnect.c        |   0
>>   drivers/platform/x86/intel/telemetry/Kconfig  |  16 +
>>   drivers/platform/x86/intel/telemetry/Makefile |   9 +
>>   .../telemetry}/intel_telemetry_core.c         |   0
>>   .../telemetry}/intel_telemetry_debugfs.c      |   0
>>   .../telemetry}/intel_telemetry_pltdrv.c       |   0
>>   .../platform/x86/intel/turbo_max_3/Kconfig    |  14 +
>>   .../platform/x86/intel/turbo_max_3/Makefile   |   6 +
>>   .../turbo_max_3}/intel_turbo_max_3.c          |   0
>>   .../platform/x86/intel/uncore_freq/Kconfig    |  15 +
>>   .../platform/x86/intel/uncore_freq/Makefile   |   6 +
>>   .../uncore_freq}/intel-uncore-frequency.c     |   0
>>   drivers/platform/x86/intel/vbtn/Kconfig       |  16 +
>>   drivers/platform/x86/intel/vbtn/Makefile      |   6 +
>>   .../x86/{ => intel/vbtn}/intel-vbtn.c         |   0
>>   drivers/platform/x86/intel/wmi/Kconfig        |  26 ++
>>   drivers/platform/x86/intel/wmi/Makefile       |   7 +
>>   .../{ => intel/wmi}/intel-wmi-sbl-fw-update.c |   0
>>   .../{ => intel/wmi}/intel-wmi-thunderbolt.c   |   0
>>   81 files changed, 562 insertions(+), 330 deletions(-)
>>   create mode 100644 drivers/platform/x86/intel/bxtwc/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/bxtwc/Makefile
>>   rename drivers/platform/x86/{ => intel/bxtwc}/intel_bxtwc_tmu.c
>> (100%)
>>   create mode 100644 drivers/platform/x86/intel/chtdc_ti/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/chtdc_ti/Makefile
>>   rename drivers/platform/x86/{ =>
>> intel/chtdc_ti}/intel_chtdc_ti_pwrbtn.c (100%)
>>   create mode 100644 drivers/platform/x86/intel/hid/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/hid/Makefile
>>   rename drivers/platform/x86/{ => intel/hid}/intel-hid.c (100%)
>>   create mode 100644 drivers/platform/x86/intel/int0002/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/int0002/Makefile
>>   rename drivers/platform/x86/{ =>
>> intel/int0002}/intel_int0002_vgpio.c (100%)
>>   rename drivers/platform/x86/{ =>
>> intel}/intel_speed_select_if/Kconfig (100%)
>>   rename drivers/platform/x86/{ =>
>> intel}/intel_speed_select_if/Makefile (100%)
>>   rename drivers/platform/x86/{ =>
>> intel}/intel_speed_select_if/isst_if_common.c (100%)
>>   rename drivers/platform/x86/{ =>
>> intel}/intel_speed_select_if/isst_if_common.h (100%)
>>   rename drivers/platform/x86/{ =>
>> intel}/intel_speed_select_if/isst_if_mbox_msr.c (100%)
>>   rename drivers/platform/x86/{ =>
>> intel}/intel_speed_select_if/isst_if_mbox_pci.c (100%)
>>   rename drivers/platform/x86/{ =>
>> intel}/intel_speed_select_if/isst_if_mmio.c (100%)
>>   create mode 100644 drivers/platform/x86/intel/ips/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/ips/Makefile
>>   rename drivers/platform/x86/{ => intel/ips}/intel_ips.c (100%)
>>   rename drivers/platform/x86/{ => intel/ips}/intel_ips.h (100%)
>>   create mode 100644 drivers/platform/x86/intel/menlow/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/menlow/Makefile
>>   rename drivers/platform/x86/{ => intel/menlow}/intel_menlow.c (100%)
>>   create mode 100644 drivers/platform/x86/intel/mrfld/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/mrfld/Makefile
>>   rename drivers/platform/x86/{ => intel/mrfld}/intel_mrfld_pwrbtn.c
>> (100%)
>>   create mode 100644 drivers/platform/x86/intel/oaktrail/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/oaktrail/Makefile
>>   rename drivers/platform/x86/{ => intel/oaktrail}/intel_oaktrail.c
>> (100%)
>>   create mode 100644 drivers/platform/x86/intel/pmc_core/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/pmc_core/Makefile
>>   rename drivers/platform/x86/{ => intel/pmc_core}/intel_pmc_core.c
>> (100%)
>>   rename drivers/platform/x86/{ => intel/pmc_core}/intel_pmc_core.h
>> (100%)
>>   rename drivers/platform/x86/{ =>
>> intel/pmc_core}/intel_pmc_core_pltdrv.c (100%)
>>   create mode 100644 drivers/platform/x86/intel/pmt/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/pmt/Makefile
>>   rename drivers/platform/x86/{ => intel/pmt}/intel_pmt_class.c (100%)
>>   rename drivers/platform/x86/{ => intel/pmt}/intel_pmt_class.h (100%)
>>   rename drivers/platform/x86/{ => intel/pmt}/intel_pmt_crashlog.c
>> (100%)
>>   rename drivers/platform/x86/{ => intel/pmt}/intel_pmt_telemetry.c
>> (100%)
>>   create mode 100644 drivers/platform/x86/intel/punit/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/punit/Makefile
>>   rename drivers/platform/x86/{ => intel/punit}/intel_punit_ipc.c
>> (100%)
>>   create mode 100644 drivers/platform/x86/intel/rst/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/rst/Makefile
>>   rename drivers/platform/x86/{ => intel/rst}/intel-rst.c (100%)
>>   create mode 100644 drivers/platform/x86/intel/scu/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/scu/Makefile
>>   rename drivers/platform/x86/{ => intel/scu}/intel_scu_ipc.c (100%)
>>   rename drivers/platform/x86/{ => intel/scu}/intel_scu_ipcutil.c
>> (100%)
>>   rename drivers/platform/x86/{ => intel/scu}/intel_scu_pcidrv.c
>> (100%)
>>   rename drivers/platform/x86/{ => intel/scu}/intel_scu_pltdrv.c
>> (100%)
>>   rename drivers/platform/x86/{ => intel/scu}/intel_scu_wdt.c (100%)
>>   create mode 100644 drivers/platform/x86/intel/smartconnect/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/smartconnect/Makefile
>>   rename drivers/platform/x86/{ => intel/smartconnect}/intel-
>> smartconnect.c (100%)
>>   create mode 100644 drivers/platform/x86/intel/telemetry/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/telemetry/Makefile
>>   rename drivers/platform/x86/{ =>
>> intel/telemetry}/intel_telemetry_core.c (100%)
>>   rename drivers/platform/x86/{ =>
>> intel/telemetry}/intel_telemetry_debugfs.c (100%)
>>   rename drivers/platform/x86/{ =>
>> intel/telemetry}/intel_telemetry_pltdrv.c (100%)
>>   create mode 100644 drivers/platform/x86/intel/turbo_max_3/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/turbo_max_3/Makefile
>>   rename drivers/platform/x86/{ =>
>> intel/turbo_max_3}/intel_turbo_max_3.c (100%)
>>   create mode 100644 drivers/platform/x86/intel/uncore_freq/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/uncore_freq/Makefile
>>   rename drivers/platform/x86/{ => intel/uncore_freq}/intel-uncore-
>> frequency.c (100%)
>>   create mode 100644 drivers/platform/x86/intel/vbtn/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/vbtn/Makefile
>>   rename drivers/platform/x86/{ => intel/vbtn}/intel-vbtn.c (100%)
>>   create mode 100644 drivers/platform/x86/intel/wmi/Kconfig
>>   create mode 100644 drivers/platform/x86/intel/wmi/Makefile
>>   rename drivers/platform/x86/{ => intel/wmi}/intel-wmi-sbl-fw-
>> update.c (100%)
>>   rename drivers/platform/x86/{ => intel/wmi}/intel-wmi-thunderbolt.c
>> (100%)
>>
> 
> 


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
https://people.kernel.org/tglx/notes-about-netiquette
