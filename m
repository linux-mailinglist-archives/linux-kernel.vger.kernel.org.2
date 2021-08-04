Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF683E0A2A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhHDVvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:51:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:49152 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231342AbhHDVvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:51:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="214005994"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="214005994"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 14:51:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; 
   d="scan'208";a="512245283"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2021 14:51:29 -0700
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id E6CD458090B;
        Wed,  4 Aug 2021 14:51:28 -0700 (PDT)
Message-ID: <7308291f26a3f225fca069461d9ac26170f0ba66.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: intel_pmc_core: Prevent possibile overflow
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Evgeny Novikov <novikov@ispras.ru>, irenic.rajneesh@gmail.com,
        gayatri.kammela@intel.com, hdegoede@redhat.com,
        mgross@linux.intel.com, andy.shevchenko@gmail.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 04 Aug 2021 14:51:28 -0700
In-Reply-To: <159dec07-9f05-3a92-8b7d-3d2f27448f70@ispras.ru>
References: <facd47b64a5efa4e0e70cd29586173e44a8929c2.camel@linux.intel.com>
         <20210804003039.359138-1-david.e.box@linux.intel.com>
         <159dec07-9f05-3a92-8b7d-3d2f27448f70@ispras.ru>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evgeny,

On Wed, 2021-08-04 at 13:48 +0300, Evgeny Novikov wrote:
> Hi David,
> 
> Your patch fixes the out of bound issue, but I have another concern 
> regarding possible incomplete initialization of first 8 elements of
> the 
> lpm_priority array that is declared on the stack and is not
> initialized, 
> say, with zeroes. Yet again due to some invalid values coming from
> the 
> register, it is not guaranteed that something meaningful will be 
> assigned for all first 8 elements of lpm_priority in the first cycle
> in 
> pmc_core_get_low_power_modes(). In the second cycle this function 
> accesses all these elements from lpm_priority. Though there is test 
> "!(BIT(mode) & lpm_en)", it can pass accidentally, thus some
> unexpected 
> values can be stored to "pmcdev->lpm_en_modes[i++]" and exposed
> later.

I sent out a v2 that validates the priority levels are within bounds
and meaningful before reordering them to set the lpm_en_modes. Thanks.

David

> 
> 
> Best regards,
> Evgeny Novikov
> 
> 
> On 04.08.2021 03:30, David E. Box wrote:
> > Low Power Mode (LPM) priority is encoded in 4 bits. Yet, this value
> > is used
> > as an index to an array whose element size was less than 16,
> > leading to the
> > possibility of overflow should we read a larger than expected
> > priority. Set
> > the array size to 16 to prevent this.
> > 
> > Reported-by: Evgeny Novikov <novikov@ispras.ru>
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> >   drivers/platform/x86/intel_pmc_core.c | 2 +-
> >   drivers/platform/x86/intel_pmc_core.h | 1 +
> >   2 files changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/platform/x86/intel_pmc_core.c
> > b/drivers/platform/x86/intel_pmc_core.c
> > index b0e486a6bdfb..2a761fe98277 100644
> > --- a/drivers/platform/x86/intel_pmc_core.c
> > +++ b/drivers/platform/x86/intel_pmc_core.c
> > @@ -1451,7 +1451,7 @@ DEFINE_SHOW_ATTRIBUTE(pmc_core_pkgc);
> >   
> >   static void pmc_core_get_low_power_modes(struct pmc_dev *pmcdev)
> >   {
> > -       u8 lpm_priority[LPM_MAX_NUM_MODES];
> > +       u8 lpm_priority[LPM_MAX_PRI];
> >         u32 lpm_en;
> >         int mode, i, p;
> >   
> > diff --git a/drivers/platform/x86/intel_pmc_core.h
> > b/drivers/platform/x86/intel_pmc_core.h
> > index e8dae9c6c45f..b98c2b44c938 100644
> > --- a/drivers/platform/x86/intel_pmc_core.h
> > +++ b/drivers/platform/x86/intel_pmc_core.h
> > @@ -190,6 +190,7 @@ enum ppfear_regs {
> >   #define LPM_MAX_NUM_MODES                     8
> >   #define GET_X2_COUNTER(v)                     ((v) >> 1)
> >   #define LPM_STS_LATCH_MODE                    BIT(31)
> > +#define LPM_MAX_PRI                            16      /* size of
> > 4 bits */
> >   
> >   #define TGL_PMC_SLP_S0_RES_COUNTER_STEP               0x7A
> >   #define TGL_PMC_LTR_THC0                      0x1C04


