Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C3D331592
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhCHSMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:12:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:42396 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230124AbhCHSMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:12:05 -0500
IronPort-SDR: MlVFMD8NfVcvAsPv5eNF35hNAVjsQYqN3xJ4Cv33P/LdMmwCvkffu3GmyjA9Ek4738IqHP3ufD
 uCbLyWaZmEcA==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="273107368"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="273107368"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 10:12:05 -0800
IronPort-SDR: DfPMBFzFEKHdCWhqZbEQB2LcN0JAYGDns9h8unSbx3gApMGpHRFxCPDmscA/xnu63loafLOG4o
 kVCu+4WNTmpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="598959700"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 08 Mar 2021 10:12:04 -0800
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.57])
        by linux.intel.com (Postfix) with ESMTP id B4B7D580866;
        Mon,  8 Mar 2021 10:12:04 -0800 (PST)
Message-ID: <0069177abd6654eb36258cb089bc643e575b5ba7.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: intel_pmc: Ignore GBE LTR on Tiger Lake
 platforms
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Cc:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "sasha.neftin@intel.com" <sasha.neftin@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Date:   Mon, 08 Mar 2021 10:12:04 -0800
In-Reply-To: <SA1PR19MB49260612D4BEC9AA3FCA85A3FA939@SA1PR19MB4926.namprd19.prod.outlook.com>
References: <20210305190608.1834164-1-david.e.box@linux.intel.com>
         <SA1PR19MB49261823693E915E7D646B07FA939@SA1PR19MB4926.namprd19.prod.outlook.com>
         <CAE2upjT1SabzsEtxnVzFV9hVDVm-KuqXP9QEQqO6HHKVS0-HZg@mail.gmail.com>
         <SA1PR19MB49260612D4BEC9AA3FCA85A3FA939@SA1PR19MB4926.namprd19.prod.outlook.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-03-08 at 18:02 +0000, Limonciello, Mario wrote:
> 
> 
> > -----Original Message-----
> > From: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
> > Sent: Monday, March 8, 2021 11:32
> > To: Limonciello, Mario
> > Cc: David E. Box; hdegoede@redhat.com; mgross@linux.intel.com;
> > sasha.neftin@intel.com; platform-driver-x86@vger.kernel.org; linux-
> > kernel@vger.kernel.org; intel-wired-lan@lists.osuosl.org
> > Subject: Re: [PATCH] platform/x86: intel_pmc: Ignore GBE LTR on
> > Tiger Lake
> > platforms
> > 
> > 
> > [EXTERNAL EMAIL]
> > 
> > On Mon, Mar 8, 2021 at 12:20 PM Limonciello, Mario
> > <Mario.Limonciello@dell.com> wrote:
> > > 
> > > > 
> > > > [EXTERNAL EMAIL]
> > > > 
> > > > Due to a HW limitation, the Latency Tolerance Reporting (LTR)
> > > > value
> > > > programmed in the Tiger Lake GBE controller is not large enough
> > > > to allow
> > > > the platform to enter Package C10, which in turn prevents the
> > > > platform
> > from
> > > > achieving its low power target during suspend-to-idle.  Ignore
> > > > the GBE LTR
> > > > value on Tiger Lake. LTR ignore functionality is currently
> > > > performed
> > solely
> > > > by a debugfs write call. Split out the LTR code into its own
> > > > function that
> > > > can be called by both the debugfs writer and by this work
> > > > around.
> > > > 
> > > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > > Reviewed-by: Sasha Neftin <sasha.neftin@intel.com>
> > > > Cc: intel-wired-lan@lists.osuosl.org
> > > > ---
> > > >  drivers/platform/x86/intel_pmc_core.c | 55
> > > > ++++++++++++++++++++-------
> > > >  1 file changed, 42 insertions(+), 13 deletions(-)
> > > 
> > > I feel like this driver change causes a weak reference between
> > > e1000e and
> > intel_pmc_core.
> > > It would mean significantly different behavior if you use e1000e
> > > but don't
> > have PMC module
> > > available for any reason.
> > 
> > Can you elaborate what would change significantly? This is a FW/HW
> > issue and the driver is just doing a work around to let the
> > platform
> > enter a deep idle state beyond PC10. If the system could enter PC10
> > and was denied entry by PMC only because of a bad LAN LTR, then
> > that's
> > purely an e1000e driver/GBE fw issue.
> > 
> Because the workaround is in pmc driver, the platform behavior
> becomes tied
> to whether this driver was enabled.  Before this the driver was
> mostly for debugging
> purpose and really not necessary.  Now it has a functional purpose.
> 
> As such I think it should be made apparent that you need it now for
> some systems.

Agreed. This is not the first fix either. The driver needs to be built
for all platforms we add support for. I'll change the Kconfig.

David

> 
> > > 
> > > In this case does it maybe make sense to at least use "imply" in
> > > the Kconfig
> > for e1000e so
> > > that selecting e1000e gets intel-pmc-core enabled too?
> > 
> > This change would tell PMC to ignore GBE LTR, regardless of which
> > GBE
> > driver is selected. This doesn't bind e1000e.
> 
> Yeah, that's a good point.
> 
> Maybe my suggestion can be to take this into documentation somewhere
> instead.
> 
> > 
> > > 
> > > > 
> > > > diff --git a/drivers/platform/x86/intel_pmc_core.c
> > > > b/drivers/platform/x86/intel_pmc_core.c
> > > > index ee2f757515b0..ab31eb646a1a 100644
> > > > --- a/drivers/platform/x86/intel_pmc_core.c
> > > > +++ b/drivers/platform/x86/intel_pmc_core.c
> > > > @@ -863,34 +863,45 @@ static int pmc_core_pll_show(struct
> > > > seq_file *s,
> > void
> > > > *unused)
> > > >  }
> > > >  DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
> > > > 
> > > > -static ssize_t pmc_core_ltr_ignore_write(struct file *file,
> > > > -                                      const char __user
> > > > *userbuf,
> > > > -                                      size_t count, loff_t
> > > > *ppos)
> > > > +static int pmc_core_write_ltr_ignore(u32 value)
> > > >  {
> > > >       struct pmc_dev *pmcdev = &pmc;
> > > >       const struct pmc_reg_map *map = pmcdev->map;
> > > > -     u32 val, buf_size, fd;
> > > > -     int err;
> > > > -
> > > > -     buf_size = count < 64 ? count : 64;
> > > > -
> > > > -     err = kstrtou32_from_user(userbuf, buf_size, 10, &val);
> > > > -     if (err)
> > > > -             return err;
> > > > +     u32 fd;
> > > > +     int err = 0;
> > > > 
> > > >       mutex_lock(&pmcdev->lock);
> > > > 
> > > > -     if (val > map->ltr_ignore_max) {
> > > > +     if (fls(value) > map->ltr_ignore_max) {
> > > >               err = -EINVAL;
> > > >               goto out_unlock;
> > > >       }
> > > > 
> > > >       fd = pmc_core_reg_read(pmcdev, map->ltr_ignore_offset);
> > > > -     fd |= (1U << val);
> > > > +     fd |= value;
> > > >       pmc_core_reg_write(pmcdev, map->ltr_ignore_offset, fd);
> > > > 
> > > >  out_unlock:
> > > >       mutex_unlock(&pmcdev->lock);
> > > > +
> > > > +     return err;
> > > > +}
> > > > +
> > > > +static ssize_t pmc_core_ltr_ignore_write(struct file *file,
> > > > +                                      const char __user
> > > > *userbuf,
> > > > +                                      size_t count, loff_t
> > > > *ppos)
> > > > +{
> > > > +     u32 buf_size, val;
> > > > +     int err;
> > > > +
> > > > +     buf_size = count < 64 ? count : 64;
> > > > +
> > > > +     err = kstrtou32_from_user(userbuf, buf_size, 10, &val);
> > > > +     if (err)
> > > > +             return err;
> > > > +
> > > > +     err = pmc_core_write_ltr_ignore(1U << val);
> > > > +
> > > >       return err == 0 ? count : err;
> > > >  }
> > > > 
> > > > @@ -1189,6 +1200,15 @@ static int quirk_xtal_ignore(const
> > > > struct
> > dmi_system_id
> > > > *id)
> > > >       return 0;
> > > >  }
> > > > 
> > > > +static int quirk_ltr_ignore(u32 val)
> > > > +{
> > > > +     int err;
> > > > +
> > > > +     err = pmc_core_write_ltr_ignore(val);
> > > > +
> > > > +     return err;
> > > > +}
> > > > +
> > > >  static const struct dmi_system_id pmc_core_dmi_table[]  = {
> > > >       {
> > > >       .callback = quirk_xtal_ignore,
> > > > @@ -1244,6 +1264,15 @@ static int pmc_core_probe(struct
> > > > platform_device
> > *pdev)
> > > >       pmcdev->pmc_xram_read_bit =
> > > > pmc_core_check_read_lock_bit();
> > > >       dmi_check_system(pmc_core_dmi_table);
> > > > 
> > > > +     /*
> > > > +      * On TGL, due to a hardware limitation, the GBE LTR
> > > > blocks PC10
> > when
> > > > +      * a cable is attached. Tell the PMC to ignore it.
> > > > +      */
> > > > +     if (pmcdev->map == &tgl_reg_map) {
> > > > +             dev_dbg(&pdev->dev, "ignoring GBE LTR\n");
> > > > +             quirk_ltr_ignore(1U << 3);
> > > > +     }
> > > > +
> > > >       pmc_core_dbgfs_register(pmcdev);
> > > > 
> > > >       device_initialized = true;
> > > > --
> > > > 2.25.1
> > > 
> > 
> > 
> > --
> > Thanks,
> > Rajneesh


