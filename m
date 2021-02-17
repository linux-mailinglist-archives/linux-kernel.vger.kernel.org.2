Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9400731D3FA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 03:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhBQChh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 21:37:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37741 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhBQChf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 21:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613529367;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bFQ4nst+7KF+HK76K9IxQcs7xQsF3hReGqq+Ff9J1dA=;
        b=GVPRENqAE6lML//Ud+5XUkU23ujCrgpFGXqEhUlIH6B/jN/0Oeymmssk54JD5QShBloY//
        IR6rAy5Setm8Vwjsw6JwJQZiWGqkr+BJVKp/37U9UVJ5IyMfFG05RxEQskgavJULc3VPhM
        wuD3cl49tHO9kyA7BJJM99YB9OIt3UU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-0wOMAXx0MC6tEcbRDboiCQ-1; Tue, 16 Feb 2021 21:36:04 -0500
X-MC-Unique: 0wOMAXx0MC6tEcbRDboiCQ-1
Received: by mail-qv1-f71.google.com with SMTP id h10so9108221qvf.19
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 18:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=bFQ4nst+7KF+HK76K9IxQcs7xQsF3hReGqq+Ff9J1dA=;
        b=sIrztnLzOtoj8khgIqsm5pM8Tngjx9PZl6wWN+YvniIGQLYa90mMknd2U6Y4PnSXDU
         ErLT5uo7pfZsBMinSyTZ+XcyvqStZSZhYJydbd1Xz5qrN/SLMhxYx91Jrd+rZuGJPIF6
         JeBfGaCPa/MzXEUzGALnNblqSoiixbkErQxDRrHQJOgyn2cshqKqjHc7gE+J97iJnzSG
         5DL0jsaGctPpRrQAGM3haAl2rFGQpxhUam/QqfJIbFJWtaddrNPMh94Ex/T78MPYFig5
         NP268xKcru0/8xFQJRLMyjKapzmE4R4aEc7T1/ndoWZLBmXVCmbEOOkc9wOzHXr4Rzws
         3wzw==
X-Gm-Message-State: AOAM531z0NT1eZ86h4wk7lcN+SzrdlLpUeSYJyeIMpfIPl7IAYQj6B1n
        jExRR8bFhc39gdXh/azCDs3kjLQe6HpwWztb/AgmgSYmYdjcg/RgtOTsyTeuzhCepm8wM/0RZ8j
        frgHj/3xgYNEe42GhlgmLnOsQ
X-Received: by 2002:a05:622a:44b:: with SMTP id o11mr21133284qtx.229.1613529363679;
        Tue, 16 Feb 2021 18:36:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2UPWoYV+dIGcKJzZyDIC15zAk0mVxmsG1L6tmGo8be/BXQZPSWP2xPV6R1649BUania/puA==
X-Received: by 2002:a05:622a:44b:: with SMTP id o11mr21133273qtx.229.1613529363320;
        Tue, 16 Feb 2021 18:36:03 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id o3sm640533qke.132.2021.02.16.18.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 18:36:02 -0800 (PST)
Message-ID: <de45c8434b35ba9c712edf615bea4f86131aaf1a.camel@redhat.com>
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915/gen9bc: Handle TGP PCH during
 suspend/resume
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     imre.deak@intel.com
Cc:     intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Date:   Tue, 16 Feb 2021 21:36:01 -0500
In-Reply-To: <20210216180825.GA420119@ideak-desk.fi.intel.com>
References: <20210212185053.1689716-1-lyude@redhat.com>
         <20210216180825.GA420119@ideak-desk.fi.intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-02-16 at 20:08 +0200, Imre Deak wrote:
> Hi,
> 
> thanks for respinning this patchset, some comments below.
> 
> On Fri, Feb 12, 2021 at 01:50:53PM -0500, Lyude Paul wrote:
> > From: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> > 
> > For Legacy S3 suspend/resume GEN9 BC needs to enable and
> > setup TGP PCH.
> > 
> > v2:
> > * Move Wa_14010685332 into it's own function - vsyrjala
> > * Add TODO comment about figuring out if we can move this workaround - imre
> > 
> > Cc: Matt Roper <matthew.d.roper@intel.com>
> > Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/i915/i915_irq.c | 53 ++++++++++++++++++++++-----------
> >  1 file changed, 36 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/i915_irq.c
> > b/drivers/gpu/drm/i915/i915_irq.c
> > index 98145a7f28a4..7d912aa950ee 100644
> > --- a/drivers/gpu/drm/i915/i915_irq.c
> > +++ b/drivers/gpu/drm/i915/i915_irq.c
> > @@ -3040,6 +3040,19 @@ static void valleyview_irq_reset(struct
> > drm_i915_private *dev_priv)
> >         spin_unlock_irq(&dev_priv->irq_lock);
> >  }
> >  
> > +static void cnp_irq_post_reset(struct drm_i915_private *dev_priv)
> 
> Maybe a better name is cnp_display_clock_wa.
> 
> > +{
> > +       struct intel_uncore *uncore = &dev_priv->uncore;
> > +
> > +       /*
> > +        * Wa_14010685332:cnp/cmp,tgp,adp
> 
> Bspec says this WA applies ICL onwards and it's not PCH specific, for
> instance I haven't found the GEN9/CNP/CMP WA entries for it. Please also
> add a 'clarify platforms where this applies' todo item.
> 
> > +        * TODO: Figure out if this workaround can be applied in the s0ix
> > suspend/resume handlers as
> > +        * on earlier platforms and whether the workaround is also needed
> > for runtime suspend/resume
> > +        */
> > +       intel_uncore_rmw(uncore, SOUTH_CHICKEN1, SBCLK_RUN_REFCLK_DIS,
> > SBCLK_RUN_REFCLK_DIS);
> > +       intel_uncore_rmw(uncore, SOUTH_CHICKEN1, SBCLK_RUN_REFCLK_DIS, 0);
> > +}
> > +
> >  static void gen8_irq_reset(struct drm_i915_private *dev_priv)
> >  {
> >         struct intel_uncore *uncore = &dev_priv->uncore;
> > @@ -3061,8 +3074,14 @@ static void gen8_irq_reset(struct drm_i915_private
> > *dev_priv)
> >         GEN3_IRQ_RESET(uncore, GEN8_DE_MISC_);
> >         GEN3_IRQ_RESET(uncore, GEN8_PCU_);
> >  
> > -       if (HAS_PCH_SPLIT(dev_priv))
> > +       if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
> 
> It was mentioned already earlier, why is this check necessary and can't we
> just call ibx_irq_reset() for all PCHs?
> 
> > +               GEN3_IRQ_RESET(uncore, SDE);
> > +       else if (HAS_PCH_SPLIT(dev_priv))
> >                 ibx_irq_reset(dev_priv);
> > +
> > +       if (INTEL_PCH_TYPE(dev_priv) == PCH_CNP ||
> > +           (INTEL_PCH_TYPE(dev_priv) >= PCH_TGP && INTEL_PCH_TYPE(dev_priv)
> > < PCH_DG1))
> 
> The check could be also moved to the helper.
> 
> > +               cnp_irq_post_reset(dev_priv);
> >  }
> >  
> >  static void gen11_display_irq_reset(struct drm_i915_private *dev_priv)
> > @@ -3104,15 +3123,9 @@ static void gen11_display_irq_reset(struct
> > drm_i915_private *dev_priv)
> >         if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
> >                 GEN3_IRQ_RESET(uncore, SDE);
> >  
> > -       /* Wa_14010685332:cnp/cmp,tgp,adp */
> >         if (INTEL_PCH_TYPE(dev_priv) == PCH_CNP ||
> > -           (INTEL_PCH_TYPE(dev_priv) >= PCH_TGP &&
> > -            INTEL_PCH_TYPE(dev_priv) < PCH_DG1)) {
> > -               intel_uncore_rmw(uncore, SOUTH_CHICKEN1,
> > -                                SBCLK_RUN_REFCLK_DIS,
> > SBCLK_RUN_REFCLK_DIS);
> > -               intel_uncore_rmw(uncore, SOUTH_CHICKEN1,
> > -                                SBCLK_RUN_REFCLK_DIS, 0);
> > -       }
> > +           (INTEL_PCH_TYPE(dev_priv) >= PCH_TGP && INTEL_PCH_TYPE(dev_priv)
> > < PCH_DG1))
> > +               cnp_irq_post_reset(dev_priv);
> >  }
> >  
> >  static void gen11_irq_reset(struct drm_i915_private *dev_priv)
> > @@ -3474,6 +3487,9 @@ static void spt_hpd_irq_setup(struct drm_i915_private
> > *dev_priv)
> >         ibx_display_interrupt_update(dev_priv, hotplug_irqs, enabled_irqs);
> >  
> >         spt_hpd_detection_setup(dev_priv);
> > +
> > +       if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
> > +               icp_hpd_irq_setup(dev_priv);
> 
> This doesn't look correct, icp_hpd_irq_setup() redoes the interrupt
> setup done already earlier in this function and
> spt_hpd_detection_setup() is probably also not correct on ICP+. Looks
> like for ICP+ we need to call icp_hpd_irq_setup() instead of
> spt_hpd_irq_setup(), but haven't checked in detail.

Could you please check :)? I don't work at Intel so you have far more access to
this information then I do. 

FWIW the code -looks- mostly equivalent to me (SHOTPLUG_CTL_DDI and
SHOTPLUG_CTL_TC seem to be equivalent registers to what's set in
spt_hpd_irq_setup()), but the icelake point codepath enables an additional port,
and changes an additional register called SHPD_FILTER_CNT. I'll update it to use
this in the next patch, but please definitely confirm this. I would very much
like to avoid potentially breaking unrelated ICP systems with this.

> 
> >  }
> >  
> >  static u32 ilk_hotplug_enables(struct drm_i915_private *i915,
> > @@ -3764,9 +3780,19 @@ static void gen8_de_irq_postinstall(struct
> > drm_i915_private *dev_priv)
> >         }
> >  }
> >  
> > +static void icp_irq_postinstall(struct drm_i915_private *dev_priv)
> > +{
> > +       struct intel_uncore *uncore = &dev_priv->uncore;
> > +       u32 mask = SDE_GMBUS_ICP;
> > +
> > +       GEN3_IRQ_INIT(uncore, SDE, ~mask, 0xffffffff);
> > +}
> > +
> >  static void gen8_irq_postinstall(struct drm_i915_private *dev_priv)
> >  {
> > -       if (HAS_PCH_SPLIT(dev_priv))
> > +       if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
> > +               icp_irq_postinstall(dev_priv);
> > +       else if (HAS_PCH_SPLIT(dev_priv))
> >                 ibx_irq_postinstall(dev_priv);
> >  
> >         gen8_gt_irq_postinstall(&dev_priv->gt);
> > @@ -3775,13 +3801,6 @@ static void gen8_irq_postinstall(struct
> > drm_i915_private *dev_priv)
> >         gen8_master_intr_enable(dev_priv->uncore.regs);
> >  }
> >  
> > -static void icp_irq_postinstall(struct drm_i915_private *dev_priv)
> > -{
> > -       struct intel_uncore *uncore = &dev_priv->uncore;
> > -       u32 mask = SDE_GMBUS_ICP;
> > -
> > -       GEN3_IRQ_INIT(uncore, SDE, ~mask, 0xffffffff);
> > -}
> >  
> >  static void gen11_irq_postinstall(struct drm_i915_private *dev_priv)
> >  {
> > -- 
> > 2.29.2
> > 
> > _______________________________________________
> > Intel-gfx mailing list
> > Intel-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/intel-gfx
> 

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

