Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAE836330B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 03:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbhDRB7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 21:59:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:59257 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhDRB7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 21:59:54 -0400
IronPort-SDR: xf70rJCTf1FBtnQucdiSvYl/lqedDLza9M+hooKDdS9oG6YBenMRNWv3eaHFiS32Xrrxu3y9HV
 b8SCU5K40PRQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9957"; a="175302009"
X-IronPort-AV: E=Sophos;i="5.82,230,1613462400"; 
   d="scan'208";a="175302009"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2021 18:59:26 -0700
IronPort-SDR: 66UtvVCH4OqrCKK6NcDYSW60N3Gi2ZPTJQN7srtmbd0wMISUHaxeBNurduKbGm7vfMniQZ1pSp
 mfMRq2HJrvPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,230,1613462400"; 
   d="scan'208";a="383393487"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 17 Apr 2021 18:59:26 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.174])
        by linux.intel.com (Postfix) with ESMTP id 6C47A5808AE;
        Sat, 17 Apr 2021 18:59:26 -0700 (PDT)
Message-ID: <d4a29e5f6c80d3382f7f082e758ae9c41ef8cc04.camel@linux.intel.com>
Subject: Re: [PATCH V2 5/9] platform/x86: intel_pmc_core: Get LPM
 requirements for Tiger Lake
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>, irenic.rajneesh@gmail.com,
        mgross@linux.intel.com, gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 17 Apr 2021 18:59:26 -0700
In-Reply-To: <a2c2cca5-3984-6554-040a-3ffe74c0ca0c@redhat.com>
References: <20210417031252.3020837-1-david.e.box@linux.intel.com>
         <20210417031252.3020837-6-david.e.box@linux.intel.com>
         <a2c2cca5-3984-6554-040a-3ffe74c0ca0c@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-04-17 at 10:52 +0200, Hans de Goede wrote:
> Hi David,
> 
> On 4/17/21 5:12 AM, David E. Box wrote:
> > From: Gayatri Kammela <gayatri.kammela@intel.com>
> > 
> > Platforms that support low power modes (LPM) such as Tiger Lake
> > maintain
> > requirements for each sub-state that a readable in the PMC.
> > However, unlike
> > LPM status registers, requirement registers are not memory mapped
> > but are
> > available from an ACPI _DSM. Collect the requirements for Tiger
> > Lake using
> > the _DSM method and store in a buffer.
> > 
> > Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
> > Co-developed-by: David E. Box <david.e.box@linux.intel.com>
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Erm, I did not give my "Reviewed-by: Hans de Goede < 
> hdegoede@redhat.com>"
> for this patch, because it still needed some work.
> 
> Next time please only add my Reviewed-by to patches where I
> explicitly replied with a Reviewed-by.

Sure thing. Sorry about that.

David

> The same goes for patch 7/9
> 
> Regards,
> 
> Hans
> 
> 
> 
> > ---
> > 
> > V2:     - Move buffer allocation so that it does not need to be
> > freed
> >           (which was missing anyway) when an error is encountered.
> >         - Use label to free out_obj after errors
> >         - Use memcpy instead of memcpy_fromio for ACPI memory
> > 
> >  drivers/platform/x86/intel_pmc_core.c | 56
> > +++++++++++++++++++++++++++
> >  drivers/platform/x86/intel_pmc_core.h |  2 +
> >  2 files changed, 58 insertions(+)
> > 
> > diff --git a/drivers/platform/x86/intel_pmc_core.c
> > b/drivers/platform/x86/intel_pmc_core.c
> > index 0e59a84b51bf..97efe9a6bd01 100644
> > --- a/drivers/platform/x86/intel_pmc_core.c
> > +++ b/drivers/platform/x86/intel_pmc_core.c
> > @@ -23,7 +23,9 @@
> >  #include <linux/slab.h>
> >  #include <linux/suspend.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/uuid.h>
> >  
> > +#include <acpi/acpi_bus.h>
> >  #include <asm/cpu_device_id.h>
> >  #include <asm/intel-family.h>
> >  #include <asm/msr.h>
> > @@ -31,6 +33,9 @@
> >  
> >  #include "intel_pmc_core.h"
> >  
> > +#define ACPI_S0IX_DSM_UUID             "57a6512e-3979-4e9d-9708-
> > ff13b2508972"
> > +#define ACPI_GET_LOW_MODE_REGISTERS    1
> > +
> >  /* PKGC MSRs are common across Intel Core SoCs */
> >  static const struct pmc_bit_map msr_map[] = {
> >         {"Package C2",                  MSR_PKG_C2_RESIDENCY},
> > @@ -590,6 +595,53 @@ static const struct pmc_reg_map tgl_reg_map =
> > {
> >         .etr3_offset = ETR3_OFFSET,
> >  };
> >  
> > +static void pmc_core_get_tgl_lpm_reqs(struct platform_device
> > *pdev)
> > +{
> > +       struct pmc_dev *pmcdev = platform_get_drvdata(pdev);
> > +       const int num_maps = pmcdev->map->lpm_num_maps;
> > +       size_t lpm_size = LPM_MAX_NUM_MODES * num_maps * 4;
> > +       union acpi_object *out_obj;
> > +       struct acpi_device *adev;
> > +       guid_t s0ix_dsm_guid;
> > +       u32 *lpm_req_regs, *addr;
> > +
> > +       adev = ACPI_COMPANION(&pdev->dev);
> > +       if (!adev)
> > +               return;
> > +
> > +       guid_parse(ACPI_S0IX_DSM_UUID, &s0ix_dsm_guid);
> > +
> > +       out_obj = acpi_evaluate_dsm(adev->handle, &s0ix_dsm_guid,
> > 0,
> > +                                   ACPI_GET_LOW_MODE_REGISTERS,
> > NULL);
> > +       if (out_obj && out_obj->type == ACPI_TYPE_BUFFER) {
> > +               int size = out_obj->buffer.length;
> > +
> > +               if (size != lpm_size) {
> > +                       acpi_handle_debug(adev->handle,
> > +                               "_DSM returned unexpected buffer
> > size,"
> > +                               " have %d, expect %ld\n", size,
> > lpm_size);
> > +                       goto free_acpi_obj;
> > +               }
> > +       } else {
> > +               acpi_handle_debug(adev->handle,
> > +                                 "_DSM function 0 evaluation
> > failed\n");
> > +               goto free_acpi_obj;
> > +       }
> > +
> > +       addr = (u32 *)out_obj->buffer.pointer;
> > +
> > +       lpm_req_regs = devm_kzalloc(&pdev->dev, lpm_size *
> > sizeof(u32),
> > +                                    GFP_KERNEL);
> > +       if (!lpm_req_regs)
> > +               goto free_acpi_obj;
> > +
> > +       memcpy(lpm_req_regs, addr, lpm_size);
> > +       pmcdev->lpm_req_regs = lpm_req_regs;
> > +
> > +free_acpi_obj:
> > +       ACPI_FREE(out_obj);
> > +}
> > +
> >  static inline u32 pmc_core_reg_read(struct pmc_dev *pmcdev, int
> > reg_offset)
> >  {
> >         return readl(pmcdev->regbase + reg_offset);
> > @@ -1424,10 +1476,14 @@ static int pmc_core_probe(struct
> > platform_device *pdev)
> >                 return -ENOMEM;
> >  
> >         mutex_init(&pmcdev->lock);
> > +
> >         pmcdev->pmc_xram_read_bit =
> > pmc_core_check_read_lock_bit(pmcdev);
> >         pmc_core_get_low_power_modes(pmcdev);
> >         pmc_core_do_dmi_quirks(pmcdev);
> >  
> > +       if (pmcdev->map == &tgl_reg_map)
> > +               pmc_core_get_tgl_lpm_reqs(pdev);
> > +
> >         /*
> >          * On TGL, due to a hardware limitation, the GBE LTR blocks
> > PC10 when
> >          * a cable is attached. Tell the PMC to ignore it.
> > diff --git a/drivers/platform/x86/intel_pmc_core.h
> > b/drivers/platform/x86/intel_pmc_core.h
> > index aa44fd5399cc..64fb368f40f6 100644
> > --- a/drivers/platform/x86/intel_pmc_core.h
> > +++ b/drivers/platform/x86/intel_pmc_core.h
> > @@ -294,6 +294,7 @@ struct pmc_reg_map {
> >   * @s0ix_counter:      S0ix residency (step adjusted)
> >   * @num_lpm_modes:     Count of enabled modes
> >   * @lpm_en_modes:      Array of enabled modes from lowest to
> > highest priority
> > + * @lpm_req_regs:      List of substate requirements
> >   *
> >   * pmc_dev contains info about power management controller device.
> >   */
> > @@ -310,6 +311,7 @@ struct pmc_dev {
> >         u64 s0ix_counter;
> >         int num_lpm_modes;
> >         int lpm_en_modes[LPM_MAX_NUM_MODES];
> > +       u32 *lpm_req_regs;
> >  };
> >  
> >  #define pmc_for_each_mode(i, mode, pmcdev)             \
> > 
> 


