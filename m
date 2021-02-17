Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6163231D3FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 03:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhBQCjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 21:39:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229480AbhBQCjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 21:39:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613529473;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ymf1HU9nSebLHz+sw3Cz18sTeGUfVV8Ce4bVTmep3n0=;
        b=Q6tTYvc2Fw/ys//Cb6tB4oou59MGl+9jhtlcldM1b0DTSZBxQ2b3ypc9bNfnRQjiaXt4rK
        4iVNYTtQ7uzObZR6/2xnbsMplVIR6I35lgYk1GaO264/mZlegiSPYimL9J+2vGWeMFgI4P
        HJW3+MvojP1JBnTcRR1byCGhFatwdx8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-avXKES49OIWfuc9XYL8ncg-1; Tue, 16 Feb 2021 21:37:51 -0500
X-MC-Unique: avXKES49OIWfuc9XYL8ncg-1
Received: by mail-qt1-f198.google.com with SMTP id f3so9144491qtx.18
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 18:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=ymf1HU9nSebLHz+sw3Cz18sTeGUfVV8Ce4bVTmep3n0=;
        b=CGgUm5jsOPsbCyXFn0B+tn1Hf2h9K6DLpW3lhQ4vg7HeTAVyfLVa9tQsPFUFpyffqD
         15Oh8oEhmyonL5PyceOBEBzDwnwZswrQZj4akb0npXHNm9nn+wGsHlP5vgf1tkFBSYTg
         LXpOm7wECEoGzhgBfYwiV+xwJDPUJcsHlVbuRkchi/A6Jts4ttLf4EoekhQvhNykfWjl
         DQhsFd/ovwMN+mLkER8zqmUgTQ6HXQNJ1DHCpxlrAT/WZvspYN4aDI2hxcZnxU7J66hO
         cPcxPk77h/EpmQkI1I3drHU4w9+5CasChgihw5bJgUgvURHmJ/oErA26uZ1bmKais6qQ
         xxNg==
X-Gm-Message-State: AOAM5327vLIyfNd/VYa9qdouCPjZU/m9+h230aruOJGPAikuNl11A/pP
        gzko0gjaRAXOkcle3CpEXmDb3FLq5xdGdnab/+KwOEuVDu48uGkmIue4VCgGQ31zb+OZF5jT6/q
        ngpoQfeYYuRyjmgK+tSNxmtoM
X-Received: by 2002:ad4:4cd2:: with SMTP id i18mr22321884qvz.43.1613529471004;
        Tue, 16 Feb 2021 18:37:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqkeT6MuTfLC7i60D7MbFpmhESrj5fZMXN/pPbY61BBiluvIuCG5CaaEtlWPpcJFlDYlW7fg==
X-Received: by 2002:ad4:4cd2:: with SMTP id i18mr22321873qvz.43.1613529470733;
        Tue, 16 Feb 2021 18:37:50 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id n67sm700353qkb.35.2021.02.16.18.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 18:37:50 -0800 (PST)
Message-ID: <2a4cf58d63c7c34aeaa0392c1eac2ae08f95bf1d.camel@redhat.com>
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915/gen9bc: Handle TGP PCH during
 suspend/resume
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     imre.deak@intel.com
Cc:     intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Date:   Tue, 16 Feb 2021 21:37:49 -0500
In-Reply-To: <de45c8434b35ba9c712edf615bea4f86131aaf1a.camel@redhat.com>
References: <20210212185053.1689716-1-lyude@redhat.com>
         <20210216180825.GA420119@ideak-desk.fi.intel.com>
         <de45c8434b35ba9c712edf615bea4f86131aaf1a.camel@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-02-16 at 21:36 -0500, Lyude Paul wrote:
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
> > > * Add TODO comment about figuring out if we can move this workaround -
> > > imre
> > > 
> > > Cc: Matt Roper <matthew.d.roper@intel.com>
> > > Signed-off-by: Tejas Upadhyay <
> > > tejaskumarx.surendrakumar.upadhyay@intel.com>
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
> > > +           (INTEL_PCH_TYPE(dev_priv) >= PCH_TGP &&
> > > INTEL_PCH_TYPE(dev_priv)
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
> > > +           (INTEL_PCH_TYPE(dev_priv) >= PCH_TGP &&
> > > INTEL_PCH_TYPE(dev_priv)
> > > < PCH_DG1))
> > > +               cnp_irq_post_reset(dev_priv);
> > >  }
> > >  
> > >  static void gen11_irq_reset(struct drm_i915_private *dev_priv)
> > > @@ -3474,6 +3487,9 @@ static void spt_hpd_irq_setup(struct
> > > drm_i915_private
> > > *dev_priv)
> > >         ibx_display_interrupt_update(dev_priv, hotplug_irqs,
> > > enabled_irqs);
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
> Could you please check :)? I don't work at Intel so you have far more access
> to
> this information then I do. 
> 
> FWIW the code -looks- mostly equivalent to me (SHOTPLUG_CTL_DDI and
> SHOTPLUG_CTL_TC seem to be equivalent registers to what's set in
> spt_hpd_irq_setup()), but the icelake point codepath enables an additional
> port,
> and changes an additional register called SHPD_FILTER_CNT. I'll update it to
> use
> this in the next patch, but please definitely confirm this. I would very much
> like to avoid potentially breaking unrelated ICP systems with this.

JFYI I misspoke on the SHPD_FILTER_CNT, somehow my eyes missed it when I was
looking at spt_hpd_irq_setup(). Still definitely confirm this correct if you can
though

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

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

