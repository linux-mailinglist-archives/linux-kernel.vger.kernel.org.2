Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876033572FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354794AbhDGRUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:20:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:31641 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347825AbhDGRUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:20:06 -0400
IronPort-SDR: azUgPGWD4t4kPwu1IzeJjzcGXOjEN2H+GHYXiuypUxK7Vrt+y+PP3LO+8p5KKitVzB4cFBwm3N
 gdqel0onkaOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="172832722"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="172832722"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 10:19:57 -0700
IronPort-SDR: 52FBhprN5vpgOemVA6lqNZcF+UQmRVPnZubZLWKVRmWE7iWi5jn04mu2BLfasfV6n6vFUb4XLN
 yqnNWHMv9BIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="519515767"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 07 Apr 2021 10:19:56 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.27])
        by linux.intel.com (Postfix) with ESMTP id C8BBC5808F1;
        Wed,  7 Apr 2021 10:19:56 -0700 (PDT)
Message-ID: <509e0ab82af2c037cbb24aae9f701d9d9ec51767.camel@linux.intel.com>
Subject: Re: [PATCH 7/9] platform/x86: intel_pmc_core: Add option to
 set/clear LPM mode
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>, irenic.rajneesh@gmail.com,
        mgross@linux.intel.com, gayatri.kammela@intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 07 Apr 2021 10:19:56 -0700
In-Reply-To: <bc8f42ab-7664-4f5e-d9b0-1cf474c21ea2@redhat.com>
References: <20210401030558.2301621-1-david.e.box@linux.intel.com>
         <20210401030558.2301621-8-david.e.box@linux.intel.com>
         <bc8f42ab-7664-4f5e-d9b0-1cf474c21ea2@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans.

Ack on your comments for this series. Questions answered below.

On Wed, 2021-04-07 at 16:37 +0200, Hans de Goede wrote:
> Hi,
> 
> On 4/1/21 5:05 AM, David E. Box wrote:
> > By default the Low Power Mode (LPM or sub-state) status registers
> > will
> > latch condition status on every entry into Package C10. This is
> > configurable in the PMC to allow latching on any achievable sub-
> > state. Add
> > a debugfs file to support this.
> > 
> > Also add the option to clear the status registers to 0. Clearing
> > the status
> > registers before testing removes ambiguity around when the current
> > values
> > were set.
> > 
> > The new file, latch_lpm_mode, looks like this:
> > 
> >         [c10] S0i2.0 S0i3.0 S0i2.1 S0i3.1 S0i3.2 clear
> > 
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >  drivers/platform/x86/intel_pmc_core.c | 94
> > +++++++++++++++++++++++++++
> >  drivers/platform/x86/intel_pmc_core.h | 20 ++++++
> >  2 files changed, 114 insertions(+)
> > 
> > diff --git a/drivers/platform/x86/intel_pmc_core.c
> > b/drivers/platform/x86/intel_pmc_core.c
> > index 0b47a1da5f49..458c0056e7a1 100644
> > --- a/drivers/platform/x86/intel_pmc_core.c
> > +++ b/drivers/platform/x86/intel_pmc_core.c
> > @@ -584,6 +584,8 @@ static const struct pmc_reg_map tgl_reg_map = {
> >         .ltr_ignore_max = TGL_NUM_IP_IGN_ALLOWED,
> >         .lpm_num_maps = TGL_LPM_NUM_MAPS,
> >         .lpm_res_counter_step_x2 = TGL_PMC_LPM_RES_COUNTER_STEP_X2,
> > +       .etr3_offset = TGL_ETR3_OFFSET,
> > +       .lpm_sts_latch_en_offset = TGL_LPM_STS_LATCH_EN_OFFSET,
> >         .lpm_en_offset = TGL_LPM_EN_OFFSET,
> >         .lpm_priority_offset = TGL_LPM_PRI_OFFSET,
> >         .lpm_residency_offset = TGL_LPM_RESIDENCY_OFFSET,
> > @@ -1202,6 +1204,95 @@ static int
> > pmc_core_substate_req_regs_show(struct seq_file *s, void *unused)
> >  }
> >  DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_req_regs);
> >  
> > +static int pmc_core_lpm_latch_mode_show(struct seq_file *s, void
> > *unused)
> > +{
> > +       struct pmc_dev *pmcdev = s->private;
> > +       bool c10;
> > +       u32 reg;
> > +       int idx, mode;
> > +
> > +       reg = pmc_core_reg_read(pmcdev, pmcdev->map-
> > >lpm_sts_latch_en_offset);
> > +       if (reg & BIT(LPM_STS_LATCH_MODE_BIT)) {
> > +               seq_puts(s, "c10");
> > +               c10 = false;
> > +       } else {
> > +               seq_puts(s, "[c10]");
> > +               c10 = true;
> > +       }
> > +
> > +       pmc_for_each_mode(idx, mode, pmcdev) {
> > +               if ((BIT(mode) & reg) && !c10)
> > +                       seq_printf(s, " [%s]",
> > pmc_lpm_modes[mode]);
> > +               else
> > +                       seq_printf(s, " %s", pmc_lpm_modes[mode]);
> > +       }
> 
> So this either shows [c10] selected, or it shows which s0ix modes
> are selected, that is a bit weird.

One bit controls whether c10 or substate latching is enabled. A
different register sets the substate to latch and applies iff substate
latching is enabled. If c10 latching is enabled, any selected substates
are ignored by hardware so we don't show them. In the write function
when a substate is selected, substate latching is also enabled.

> 
> I realize this is a debugfs interface, but can we still get some docs
> in this, at a minimum some more explanation in the commit message ?

I'll describe this better in the commit message. We also maintain S0ix
documentation on 01.org. I'll add a patch that links to this site in
Documentation.

Thanks

David

> 
> 
> > +
> > +       seq_puts(s, " clear\n");
> > +
> > +       return 0;
> > +}
> > +
> > +static ssize_t pmc_core_lpm_latch_mode_write(struct file *file,
> > +                                            const char __user
> > *userbuf,
> > +                                            size_t count, loff_t
> > *ppos)
> > +{
> > +       struct seq_file *s = file->private_data;
> > +       struct pmc_dev *pmcdev = s->private;
> > +       bool clear = false, c10 = false;
> > +       unsigned char buf[10] = {0};
> > +       size_t ret;
> > +       int mode;
> > +       u32 reg;
> > +
> > +       ret = simple_write_to_buffer(buf, 10, ppos, userbuf,
> > count);
> > +       if (ret < 0)
> > +               return ret;
> 
> You are using C-string functions on buf below, so you must guarantee
> that it is 0 terminated. To guarantee the buffer's size must be 1
> larger
> then the size which you pass to simple_write_to_buffer()
> 
> > +
> > +       mode = sysfs_match_string(pmc_lpm_modes, buf);
> > +       if (mode < 0) {
> > +               if (strncmp("clear", buf, 5) == 0)
> > +                       clear = true;
> > +               else if (strncmp("c10", buf, 3) == 0)
> > +                       c10 = true;
> 
> Ugh, no. Now it will not just accept "clear" and "clear\n" but
> also "clear foobar everything else I write now does not matter"
> as "clear" string. This misuse of strncmp for sysfs / debugfs write
> functions seems to be some sort of anti-pattern in the kernel.
> 
> Please use sysfs_streq() here so that only "clear" and "clear\n"
> are accepted (and the same for the "c10" check).
> 
> 
> 
> > +               else
> > +                       return mode;
> > +       }
> > +
> > +       if (clear) {
> > +               mutex_lock(&pmcdev->lock);
> > +
> > +               reg = pmc_core_reg_read(pmcdev, pmcdev->map-
> > >etr3_offset);
> > +               reg |= BIT(ETR3_CLEAR_LPM_EVENTS_BIT);
> > +               pmc_core_reg_write(pmcdev, pmcdev->map-
> > >etr3_offset, reg);
> > +
> > +               mutex_unlock(&pmcdev->lock);
> > +
> > +               return count;
> > +       }
> > +
> > +       if (c10) {
> > +               mutex_lock(&pmcdev->lock);
> > +
> > +               reg = pmc_core_reg_read(pmcdev, pmcdev->map-
> > >lpm_sts_latch_en_offset);
> > +               reg &= ~BIT(LPM_STS_LATCH_MODE_BIT);
> > +               pmc_core_reg_write(pmcdev, pmcdev->map-
> > >lpm_sts_latch_en_offset, reg);
> > +
> > +               mutex_unlock(&pmcdev->lock);
> > +
> > +               return count;
> > +       }
> > +
> > +       /*
> > +        * For LPM mode latching we set the latch enable bit and
> > selected mode
> > +        * and clear everything else.
> > +        */
> > +       reg = BIT(LPM_STS_LATCH_MODE_BIT) | BIT(mode);
> > +       pmc_core_reg_write(pmcdev, pmcdev->map-
> > >lpm_sts_latch_en_offset, reg);
> > +
> > +       return count;
> > +}
> > +DEFINE_PMC_CORE_ATTR_WRITE(pmc_core_lpm_latch_mode);
> > +
> >  static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
> >  {
> >         struct pmc_dev *pmcdev = s->private;
> > @@ -1320,6 +1411,9 @@ static void pmc_core_dbgfs_register(struct
> > pmc_dev *pmcdev)
> >                 debugfs_create_file("substate_live_status_registers
> > ", 0444,
> >                                     pmcdev->dbgfs_dir, pmcdev,
> >                                    
> > &pmc_core_substate_l_sts_regs_fops);
> > +               debugfs_create_file("lpm_latch_mode", 0644,
> > +                                   pmcdev->dbgfs_dir, pmcdev,
> > +                                   &pmc_core_lpm_latch_mode_fops);
> >         }
> >  
> >         if (pmcdev->lpm_req_regs) {
> > diff --git a/drivers/platform/x86/intel_pmc_core.h
> > b/drivers/platform/x86/intel_pmc_core.h
> > index 81d797feed33..f41f61aa7008 100644
> > --- a/drivers/platform/x86/intel_pmc_core.h
> > +++ b/drivers/platform/x86/intel_pmc_core.h
> > @@ -189,6 +189,8 @@ enum ppfear_regs {
> >  
> >  #define LPM_MAX_NUM_MODES                      8
> >  #define GET_X2_COUNTER(v)                      ((v) >> 1)
> > +#define ETR3_CLEAR_LPM_EVENTS_BIT              28
> > +#define LPM_STS_LATCH_MODE_BIT                 31
> >  
> >  #define TGL_NUM_IP_IGN_ALLOWED                 22
> >  #define TGL_PMC_SLP_S0_RES_COUNTER_STEP                0x7A
> > @@ -197,6 +199,8 @@ enum ppfear_regs {
> >  /*
> >   * Tigerlake Power Management Controller register offsets
> >   */
> > +#define TGL_ETR3_OFFSET                                0x1048
> > +#define TGL_LPM_STS_LATCH_EN_OFFSET            0x1C34
> >  #define TGL_LPM_EN_OFFSET                      0x1C78
> >  #define TGL_LPM_RESIDENCY_OFFSET               0x1C80
> >  
> > @@ -266,6 +270,8 @@ struct pmc_reg_map {
> >         /* Low Power Mode registers */
> >         const int lpm_num_maps;
> >         const int lpm_res_counter_step_x2;
> > +       const u32 etr3_offset;
> > +       const u32 lpm_sts_latch_en_offset;
> >         const u32 lpm_en_offset;
> >         const u32 lpm_priority_offset;
> >         const u32 lpm_residency_offset;
> > @@ -313,4 +319,18 @@ struct pmc_dev {
> >              i < pmcdev->num_modes;                     \
> >              i++, mode = pmcdev->lpm_en_modes[i])
> >  
> > +#define
> > DEFINE_PMC_CORE_ATTR_WRITE(__name)                             \
> > +static int __name ## _open(struct inode *inode, struct file
> > *file)     \
> > +{                                                                 
> >      \
> > +       return single_open(file, __name ## _show, inode-
> > >i_private);    \
> > +}                                                                 
> >      \
> > +                                                                  
> >      \
> > +static const struct file_operations __name ## _fops =
> > {                        \
> > +       .owner          =
> > THIS_MODULE,                                  \
> > +       .open           = __name ##
> > _open,                              \
> > +       .read           =
> > seq_read,                                     \
> > +       .write          = __name ##
> > _write,                             \
> > +       .release        =
> > single_release,                               \
> > +}
> > +
> >  #endif /* PMC_CORE_H */
> > 
> 
> Regards,
> 
> Hans
> 


