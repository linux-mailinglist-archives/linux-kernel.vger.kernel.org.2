Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD745357374
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354939AbhDGRre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:47:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:46900 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348347AbhDGRrc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:47:32 -0400
IronPort-SDR: Dde14vc2vtiT1csGrkybK6NAAr0v1hHl+dRfQBhss68cmOkVyBzosTilFIaQ7QCV5g8duPK4R0
 thVYlmgtyLZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="193407519"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="193407519"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 10:47:22 -0700
IronPort-SDR: nGgmK1qyn7/l7moB6WrUsZuJ0r58toV3Lq3JPIp8ib7M6aatvjx6evX4I0VAV4EFEZgsO1ygX7
 F/ft4BSA+6kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="598441116"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 07 Apr 2021 10:47:22 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.27])
        by linux.intel.com (Postfix) with ESMTP id 08CAA5808F1;
        Wed,  7 Apr 2021 10:47:22 -0700 (PDT)
Message-ID: <5e397222e452d909cf81326b4303532b18562fac.camel@linux.intel.com>
Subject: Re: [PATCH 6/9] platform/x86: intel_pmc_core: Add requirements file
 to debugfs
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 07 Apr 2021 10:47:21 -0700
In-Reply-To: <CAE2upjR2062tGztm15NVTTKOACtrO-Rc4PH7t=_t-Bm5RGzVhw@mail.gmail.com>
References: <20210401030558.2301621-1-david.e.box@linux.intel.com>
         <20210401030558.2301621-7-david.e.box@linux.intel.com>
         <CAE2upjR2062tGztm15NVTTKOACtrO-Rc4PH7t=_t-Bm5RGzVhw@mail.gmail.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-04-07 at 11:45 -0400, Rajneesh Bhardwaj wrote:
> On Wed, Mar 31, 2021 at 11:06 PM David E. Box
> <david.e.box@linux.intel.com> wrote:
> > 
> > From: Gayatri Kammela <gayatri.kammela@intel.com>
> > 
> > Add the debugfs file, substate_requirements, to view the low power
> > mode
> > (LPM) requirements for each enabled mode alongside the last latched
> > status
> > of the condition.
> > 
> > After this patch, the new file will look like this:
> > 
> >                     Element |    S0i2.0 |    S0i3.0 |    S0i2.1
> > |    S0i3.1 |    S0i3.2 |    Status |
> >             USB2PLL_OFF_STS |  Required |  Required |  Required | 
> > Required |  Required |           |
> > PCIe/USB3.1_Gen2PLL_OFF_STS |  Required |  Required |  Required | 
> > Required |  Required |           |
> >        PCIe_Gen3PLL_OFF_STS |  Required |  Required |  Required | 
> > Required |  Required |       Yes |
> >             OPIOPLL_OFF_STS |  Required |  Required |  Required | 
> > Required |  Required |       Yes |
> >               OCPLL_OFF_STS |  Required |  Required |  Required | 
> > Required |  Required |       Yes |
> >             MainPLL_OFF_STS |           |  Required |           | 
> > Required |  Required |           |
> > 
> > Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
> > Co-developed-by: David E. Box <david.e.box@linux.intel.com>
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >  drivers/platform/x86/intel_pmc_core.c | 86
> > +++++++++++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> > 
> > diff --git a/drivers/platform/x86/intel_pmc_core.c
> > b/drivers/platform/x86/intel_pmc_core.c
> > index 0ec26a4c715e..0b47a1da5f49 100644
> > --- a/drivers/platform/x86/intel_pmc_core.c
> > +++ b/drivers/platform/x86/intel_pmc_core.c
> > @@ -1122,6 +1122,86 @@ static int
> > pmc_core_substate_l_sts_regs_show(struct seq_file *s, void *unused)
> >  }
> >  DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_l_sts_regs);
> > 
> > +static void pmc_core_substate_req_header_show(struct seq_file *s)
> > +{
> > +       struct pmc_dev *pmcdev = s->private;
> > +       int i, mode;
> > +
> > +       seq_printf(s, "%30s |", "Element");
> > +       pmc_for_each_mode(i, mode, pmcdev)
> > +               seq_printf(s, " %9s |", pmc_lpm_modes[mode]);
> > +
> > +       seq_printf(s, " %9s |\n", "Status");
> > +}
> > +
> > +static int pmc_core_substate_req_regs_show(struct seq_file *s,
> > void *unused)
> > +{
> > +       struct pmc_dev *pmcdev = s->private;
> > +       const struct pmc_bit_map **maps = pmcdev->map->lpm_sts;
> > +       const struct pmc_bit_map *map;
> > +       const int num_maps = pmcdev->map->lpm_num_maps;
> > +       u32 sts_offset = pmcdev->map->lpm_status_offset;
> > +       u32 *lpm_req_regs = pmcdev->lpm_req_regs;
> > +       int mp;
> > +
> > +       /* Display the header */
> > +       pmc_core_substate_req_header_show(s);
> > +
> > +       /* Loop over maps */
> > +       for (mp = 0; mp < num_maps; mp++) {
> > +               u32 req_mask = 0;
> > +               u32 lpm_status;
> > +               int mode, idx, i, len = 32;
> > +
> > +               /*
> > +                * Capture the requirements and create a mask so
> > that we only
> > +                * show an element if it's required for at least
> > one of the
> > +                * enabled low power modes
> > +                */
> > +               pmc_for_each_mode(idx, mode, pmcdev)
> > +                       req_mask |= lpm_req_regs[mp + (mode *
> > num_maps)];
> > +
> > +               /* Get the last latched status for this map */
> > +               lpm_status = pmc_core_reg_read(pmcdev, sts_offset +
> > (mp * 4));
> > +
> > +               /*  Loop over elements in this map */
> > +               map = maps[mp];
> > +               for (i = 0; map[i].name && i < len; i++) {
> > +                       u32 bit_mask = map[i].bit_mask;
> > +
> > +                       if (!(bit_mask & req_mask))
> > +                               /*
> > +                                * Not required for any enabled
> > states
> > +                                * so don't display
> > +                                */
> > +                               continue;
> > +
> > +                       /* Display the element name in the first
> > column */
> > +                       seq_printf(s, "%30s |", map[i].name);
> > +
> > +                       /* Loop over the enabled states and display
> > if required */
> > +                       pmc_for_each_mode(idx, mode, pmcdev) {
> > +                               if (lpm_req_regs[mp + (mode *
> > num_maps)] & bit_mask)
> > +                                       seq_printf(s, " %9s |",
> > +                                                  "Required");
> > +                               else
> > +                                       seq_printf(s, " %9s |", "
> > ");
> > +                       }
> > +
> > +                       /* In Status column, show the last captured
> > state of this agent */
> > +                       if (lpm_status & bit_mask)
> > +                               seq_printf(s, " %9s |", "Yes");
> > +                       else
> > +                               seq_printf(s, " %9s |", " ");
> 
> Why is this left blank, maybe NA (Not Available)?

The last column shows that last latched state of that agent. So if
anything it would be "Not Seen". But a blank space makes it visually
easier to parse.

David

> 
> > +
> > +                       seq_puts(s, "\n");
> > +               }
> > +       }
> > +
> > +       return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(pmc_core_substate_req_regs);
> > +
> >  static int pmc_core_pkgc_show(struct seq_file *s, void *unused)
> >  {
> >         struct pmc_dev *pmcdev = s->private;
> > @@ -1241,6 +1321,12 @@ static void pmc_core_dbgfs_register(struct
> > pmc_dev *pmcdev)
> >                                     pmcdev->dbgfs_dir, pmcdev,
> >                                    
> > &pmc_core_substate_l_sts_regs_fops);
> >         }
> > +
> > +       if (pmcdev->lpm_req_regs) {
> > +               debugfs_create_file("substate_requirements", 0444,
> > +                                   pmcdev->dbgfs_dir, pmcdev,
> > +                                  
> > &pmc_core_substate_req_regs_fops);
> > +       }
> >  }
> > 
> >  static const struct x86_cpu_id intel_pmc_core_ids[] = {
> > --
> > 2.25.1
> > 
> 
> 


