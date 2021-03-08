Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370AB3313E8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 17:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhCHQzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 11:55:16 -0500
Received: from mga05.intel.com ([192.55.52.43]:35534 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229701AbhCHQyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 11:54:49 -0500
IronPort-SDR: 4RWQouOYGzigpI+Pa0K72WZjrh8dTy1cMBFJn1lom/h07IwWaqXjE84w6Kkaao9U60GhYXJnRz
 R1vOF3vwNrcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="273092829"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="273092829"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 08:54:49 -0800
IronPort-SDR: Trw/5aTMvGAFqeiIo160flGwHnaiashiTtosgP00ou/m8m5r7qZJpwuIMgat/nXBn1KDzmewyH
 DEkAp6rBw0XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="598932051"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 08 Mar 2021 08:54:49 -0800
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.57])
        by linux.intel.com (Postfix) with ESMTP id 23BAD580866;
        Mon,  8 Mar 2021 08:54:49 -0800 (PST)
Message-ID: <46331047a90e25a83972f5cf856f027e9c43da46.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: intel_pmc: Ignore GBE LTR on Tiger Lake
 platforms
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        sasha.neftin@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Date:   Mon, 08 Mar 2021 08:54:49 -0800
In-Reply-To: <CAE2upjSkN6R_MNxNOwT+sTREGXRq0RVehnG3gCD5Wx9_-D41vg@mail.gmail.com>
References: <20210305190608.1834164-1-david.e.box@linux.intel.com>
         <CAE2upjSkN6R_MNxNOwT+sTREGXRq0RVehnG3gCD5Wx9_-D41vg@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajneesh,

On Mon, 2021-03-08 at 09:04 -0500, Rajneesh Bhardwaj wrote:
> Hi David
> 
> Overall, it looks like the right thing to do but i have a few
> comments. See below.
> 
> On Fri, Mar 5, 2021 at 2:07 PM David E. Box <
> david.e.box@linux.intel.com> wrote:
> > 
> > Due to a HW limitation, the Latency Tolerance Reporting (LTR) value
> > programmed in the Tiger Lake GBE controller is not large enough to
> > allow
> > the platform to enter Package C10, which in turn prevents the
> > platform from
> > achieving its low power target during suspend-to-idle.  Ignore the
> > GBE LTR
> > value on Tiger Lake. LTR ignore functionality is currently
> > performed solely
> > by a debugfs write call. Split out the LTR code into its own
> > function that
> > can be called by both the debugfs writer and by this work around.
> > 
> 
> I presume this must be the last resort to use such quirk and you've
> already considered a user space tuning program or fw patch is not an
> option on this generation of SOCs.

This was the suggested work around by the LAN team. A FW solution may
be considered for future products but is not in the works for TGL.

> 
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Reviewed-by: Sasha Neftin <sasha.neftin@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org
> > ---
> >  drivers/platform/x86/intel_pmc_core.c | 55 ++++++++++++++++++++---
> > ----
> >  1 file changed, 42 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/intel_pmc_core.c
> > b/drivers/platform/x86/intel_pmc_core.c
> > index ee2f757515b0..ab31eb646a1a 100644
> > --- a/drivers/platform/x86/intel_pmc_core.c
> > +++ b/drivers/platform/x86/intel_pmc_core.c
> > @@ -863,34 +863,45 @@ static int pmc_core_pll_show(struct seq_file
> > *s, void *unused)
> >  }
> >  DEFINE_SHOW_ATTRIBUTE(pmc_core_pll);
> > 
> > -static ssize_t pmc_core_ltr_ignore_write(struct file *file,
> > -                                        const char __user
> > *userbuf,
> > -                                        size_t count, loff_t
> > *ppos)
> > +static int pmc_core_write_ltr_ignore(u32 value)
> 
> This sounds a bit confusing with pmc_core_ltr_ignore_write.

Ack

> 
> >  {
> >         struct pmc_dev *pmcdev = &pmc;
> >         const struct pmc_reg_map *map = pmcdev->map;
> > -       u32 val, buf_size, fd;
> > -       int err;
> > -
> > -       buf_size = count < 64 ? count : 64;
> > -
> > -       err = kstrtou32_from_user(userbuf, buf_size, 10, &val);
> > -       if (err)
> > -               return err;
> > +       u32 fd;
> 
> lets just call it value

Yeah, I'll clean it up the names. It was just moved without changing
it.

> 
> > +       int err = 0;
> > 
> >         mutex_lock(&pmcdev->lock);
> > 
> > -       if (val > map->ltr_ignore_max) {
> > +       if (fls(value) > map->ltr_ignore_max) {
> 
> I am not sure why you're considering a bit position here. We rather
> use absolute value for this and we already preserve (OR) previously
> programmed LTR while changing to the new desired value.  Current
> modification would allow users to supply even bigger values than the
> MAX IP ignore allowed. This can be useful when you want to ignore
> more
> than 1 IP at a time but that's not how we usually use it for debug.
> This is more for a user space debug script to deal with.

This was unintentionally added. The line should not have changed at
all. Thanks for catching.

>   
> https://01.org/blogs/rajneesh/2019/using-power-management-controller-drivers-debug-low-power-platform-states
> 
> >                 err = -EINVAL;
> >                 goto out_unlock;
> >         }
> > 
> >         fd = pmc_core_reg_read(pmcdev, map->ltr_ignore_offset);
> > -       fd |= (1U << val);
> > +       fd |= value;
> >         pmc_core_reg_write(pmcdev, map->ltr_ignore_offset, fd);
> > 
> >  out_unlock:
> >         mutex_unlock(&pmcdev->lock);
> > +
> > +       return err;
> > +}
> > +
> > +static ssize_t pmc_core_ltr_ignore_write(struct file *file,
> > +                                        const char __user
> > *userbuf,
> > +                                        size_t count, loff_t
> > *ppos)
> > +{
> > +       u32 buf_size, val;
> > +       int err;
> > +
> > +       buf_size = count < 64 ? count : 64;
> > +
> > +       err = kstrtou32_from_user(userbuf, buf_size, 10, &val);
> > +       if (err)
> > +               return err;
> > +
> > +       err = pmc_core_write_ltr_ignore(1U << val);
> > +
> >         return err == 0 ? count : err;
> >  }
> > 
> > @@ -1189,6 +1200,15 @@ static int quirk_xtal_ignore(const struct
> > dmi_system_id *id)
> >         return 0;
> >  }
> > 
> > +static int quirk_ltr_ignore(u32 val)
> > +{
> > +       int err;
> > +
> > +       err = pmc_core_write_ltr_ignore(val);
> > +
> > +       return err;
> > +}
> > +
> >  static const struct dmi_system_id pmc_core_dmi_table[]  = {
> >         {
> >         .callback = quirk_xtal_ignore,
> > @@ -1244,6 +1264,15 @@ static int pmc_core_probe(struct
> > platform_device *pdev)
> >         pmcdev->pmc_xram_read_bit = pmc_core_check_read_lock_bit();
> >         dmi_check_system(pmc_core_dmi_table);
> > 
> > +       /*
> > +        * On TGL, due to a hardware limitation, the GBE LTR blocks
> > PC10 when
> > +        * a cable is attached. Tell the PMC to ignore it.
> > +        */
> > +       if (pmcdev->map == &tgl_reg_map) {
> > +               dev_dbg(&pdev->dev, "ignoring GBE LTR\n");
> > +               quirk_ltr_ignore(1U << 3);
> 
> Can this be made a part of *_reg_map itself if intended to be used
> for
> more future platforms? Otherwise we just leave it as a one time
> quirk.

The intent right now is not to use this for future platforms. We'll see
if that can happen.

David

> 
> > +       }
> > +
> >         pmc_core_dbgfs_register(pmcdev);
> > 
> >         device_initialized = true;
> > --
> > 2.25.1
> > 
> 
> 


