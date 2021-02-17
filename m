Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3894E31D5E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 08:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbhBQHx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 02:53:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:53570 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229659AbhBQHxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 02:53:23 -0500
IronPort-SDR: t/yUvuH8xGdCxW0Rf1VHBMehTPPl+eU9Qh3nl4xErbeDEZlIHxvrQ/ieLnXbpik8u2G7phYr1h
 H80Y4cl18Lmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="170789653"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="170789653"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 23:52:38 -0800
IronPort-SDR: QamDVHfuHKpUWK5Ain2txL+Q+vOWtjCWIdgijbyTI99BJ+fql48HcPVwatT11/sPvPJEX+HWqJ
 vIzZ5t+1B0ew==
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="493911989"
Received: from ideak-desk.fi.intel.com ([10.237.68.141])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 23:52:36 -0800
Date:   Wed, 17 Feb 2021 09:52:33 +0200
From:   Imre Deak <imre.deak@intel.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915/gen9bc: Handle TGP PCH during
 suspend/resume
Message-ID: <20210217075233.GA443835@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <20210212185053.1689716-1-lyude@redhat.com>
 <20210216180825.GA420119@ideak-desk.fi.intel.com>
 <de45c8434b35ba9c712edf615bea4f86131aaf1a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de45c8434b35ba9c712edf615bea4f86131aaf1a.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 09:36:01PM -0500, Lyude Paul wrote:
> On Tue, 2021-02-16 at 20:08 +0200, Imre Deak wrote:
> > Hi,
> > 
> > thanks for respinning this patchset, some comments below.
> > 
> > On Fri, Feb 12, 2021 at 01:50:53PM -0500, Lyude Paul wrote:
> > > From: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> > > 
> > > For Legacy S3 suspend/resume GEN9 BC needs to enable and
> > > setup TGP PCH.
> > > 
> > > v2:
> > > * Move Wa_14010685332 into it's own function - vsyrjala
> > > * Add TODO comment about figuring out if we can move this workaround - imre
> > > 
> > > Cc: Matt Roper <matthew.d.roper@intel.com>
> > > Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > ---
> > >  drivers/gpu/drm/i915/i915_irq.c | 53 ++++++++++++++++++++++-----------
> > >  1 file changed, 36 insertions(+), 17 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/i915_irq.c
> > > b/drivers/gpu/drm/i915/i915_irq.c
> > > index 98145a7f28a4..7d912aa950ee 100644
> > > --- a/drivers/gpu/drm/i915/i915_irq.c
> > > +++ b/drivers/gpu/drm/i915/i915_irq.c
> > > @@ -3040,6 +3040,19 @@ static void valleyview_irq_reset(struct
> > > drm_i915_private *dev_priv)
> > >         spin_unlock_irq(&dev_priv->irq_lock);
> > >  }
> > >  
> > > +static void cnp_irq_post_reset(struct drm_i915_private *dev_priv)
> > 
> > Maybe a better name is cnp_display_clock_wa.
> > 
> > > +{
> > > +       struct intel_uncore *uncore = &dev_priv->uncore;
> > > +
> > > +       /*
> > > +        * Wa_14010685332:cnp/cmp,tgp,adp
> > 
> > Bspec says this WA applies ICL onwards and it's not PCH specific, for
> > instance I haven't found the GEN9/CNP/CMP WA entries for it. Please also
> > add a 'clarify platforms where this applies' todo item.
> > 
> > > +        * TODO: Figure out if this workaround can be applied in the s0ix
> > > suspend/resume handlers as
> > > +        * on earlier platforms and whether the workaround is also needed
> > > for runtime suspend/resume
> > > +        */
> > > +       intel_uncore_rmw(uncore, SOUTH_CHICKEN1, SBCLK_RUN_REFCLK_DIS,
> > > SBCLK_RUN_REFCLK_DIS);
> > > +       intel_uncore_rmw(uncore, SOUTH_CHICKEN1, SBCLK_RUN_REFCLK_DIS, 0);
> > > +}
> > > +
> > >  static void gen8_irq_reset(struct drm_i915_private *dev_priv)
> > >  {
> > >         struct intel_uncore *uncore = &dev_priv->uncore;
> > > @@ -3061,8 +3074,14 @@ static void gen8_irq_reset(struct drm_i915_private
> > > *dev_priv)
> > >         GEN3_IRQ_RESET(uncore, GEN8_DE_MISC_);
> > >         GEN3_IRQ_RESET(uncore, GEN8_PCU_);
> > >  
> > > -       if (HAS_PCH_SPLIT(dev_priv))
> > > +       if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
> > 
> > It was mentioned already earlier, why is this check necessary and can't we
> > just call ibx_irq_reset() for all PCHs?
> > 
> > > +               GEN3_IRQ_RESET(uncore, SDE);
> > > +       else if (HAS_PCH_SPLIT(dev_priv))
> > >                 ibx_irq_reset(dev_priv);
> > > +
> > > +       if (INTEL_PCH_TYPE(dev_priv) == PCH_CNP ||
> > > +           (INTEL_PCH_TYPE(dev_priv) >= PCH_TGP && INTEL_PCH_TYPE(dev_priv)
> > > < PCH_DG1))
> > 
> > The check could be also moved to the helper.
> > 
> > > +               cnp_irq_post_reset(dev_priv);
> > >  }
> > >  
> > >  static void gen11_display_irq_reset(struct drm_i915_private *dev_priv)
> > > @@ -3104,15 +3123,9 @@ static void gen11_display_irq_reset(struct
> > > drm_i915_private *dev_priv)
> > >         if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
> > >                 GEN3_IRQ_RESET(uncore, SDE);
> > >  
> > > -       /* Wa_14010685332:cnp/cmp,tgp,adp */
> > >         if (INTEL_PCH_TYPE(dev_priv) == PCH_CNP ||
> > > -           (INTEL_PCH_TYPE(dev_priv) >= PCH_TGP &&
> > > -            INTEL_PCH_TYPE(dev_priv) < PCH_DG1)) {
> > > -               intel_uncore_rmw(uncore, SOUTH_CHICKEN1,
> > > -                                SBCLK_RUN_REFCLK_DIS,
> > > SBCLK_RUN_REFCLK_DIS);
> > > -               intel_uncore_rmw(uncore, SOUTH_CHICKEN1,
> > > -                                SBCLK_RUN_REFCLK_DIS, 0);
> > > -       }
> > > +           (INTEL_PCH_TYPE(dev_priv) >= PCH_TGP && INTEL_PCH_TYPE(dev_priv)
> > > < PCH_DG1))
> > > +               cnp_irq_post_reset(dev_priv);
> > >  }
> > >  
> > >  static void gen11_irq_reset(struct drm_i915_private *dev_priv)
> > > @@ -3474,6 +3487,9 @@ static void spt_hpd_irq_setup(struct drm_i915_private
> > > *dev_priv)
> > >         ibx_display_interrupt_update(dev_priv, hotplug_irqs, enabled_irqs);
> > >  
> > >         spt_hpd_detection_setup(dev_priv);
> > > +
> > > +       if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
> > > +               icp_hpd_irq_setup(dev_priv);
> > 
> > This doesn't look correct, icp_hpd_irq_setup() redoes the interrupt
> > setup done already earlier in this function and
> > spt_hpd_detection_setup() is probably also not correct on ICP+. Looks
> > like for ICP+ we need to call icp_hpd_irq_setup() instead of
> > spt_hpd_irq_setup(), but haven't checked in detail.
> 
> Could you please check :)? I don't work at Intel so you have far more access to
> this information then I do. 
> 
> FWIW the code -looks- mostly equivalent to me (SHOTPLUG_CTL_DDI and
> SHOTPLUG_CTL_TC seem to be equivalent registers to what's set in
> spt_hpd_irq_setup()), but the icelake point codepath enables an additional port,
> and changes an additional register called SHPD_FILTER_CNT.

The register definitions for SHOTPLUG_CTL_DDI wrt. PCH_PORT_HOTPLUG and
SHOTPLUG_CTL_TC wrt. PCH_PORT_HOTPLUG2 are different even though their
addresses match.

> I'll update it to use this in the next patch, but please definitely
> confirm this. I would very much like to avoid potentially breaking
> unrelated ICP systems with this.
> 
> > 
> > >  }
> > >  
> > >  static u32 ilk_hotplug_enables(struct drm_i915_private *i915,
> > > @@ -3764,9 +3780,19 @@ static void gen8_de_irq_postinstall(struct
> > > drm_i915_private *dev_priv)
> > >         }
> > >  }
> > >  
> > > +static void icp_irq_postinstall(struct drm_i915_private *dev_priv)
> > > +{
> > > +       struct intel_uncore *uncore = &dev_priv->uncore;
> > > +       u32 mask = SDE_GMBUS_ICP;
> > > +
> > > +       GEN3_IRQ_INIT(uncore, SDE, ~mask, 0xffffffff);
> > > +}
> > > +
> > >  static void gen8_irq_postinstall(struct drm_i915_private *dev_priv)
> > >  {
> > > -       if (HAS_PCH_SPLIT(dev_priv))
> > > +       if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
> > > +               icp_irq_postinstall(dev_priv);
> > > +       else if (HAS_PCH_SPLIT(dev_priv))
> > >                 ibx_irq_postinstall(dev_priv);
> > >  
> > >         gen8_gt_irq_postinstall(&dev_priv->gt);
> > > @@ -3775,13 +3801,6 @@ static void gen8_irq_postinstall(struct
> > > drm_i915_private *dev_priv)
> > >         gen8_master_intr_enable(dev_priv->uncore.regs);
> > >  }
> > >  
> > > -static void icp_irq_postinstall(struct drm_i915_private *dev_priv)
> > > -{
> > > -       struct intel_uncore *uncore = &dev_priv->uncore;
> > > -       u32 mask = SDE_GMBUS_ICP;
> > > -
> > > -       GEN3_IRQ_INIT(uncore, SDE, ~mask, 0xffffffff);
> > > -}
> > >  
> > >  static void gen11_irq_postinstall(struct drm_i915_private *dev_priv)
> > >  {
> > > -- 
> > > 2.29.2
> > > 
> > > _______________________________________________
> > > Intel-gfx mailing list
> > > Intel-gfx@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> > 
> 
> -- 
> Sincerely,
>    Lyude Paul (she/her)
>    Software Engineer at Red Hat
>    
> Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
> asked me a question, are waiting for a review/merge on a patch, etc. and I
> haven't responded in a while, please feel free to send me another email to check
> on my status. I don't bite!
> 
