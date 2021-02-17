Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B680331E141
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 22:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbhBQVVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 16:21:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38885 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232371AbhBQVVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 16:21:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613596775;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBMyArAKf4mpgQyvFkqw/42F48Y7NN6P7Dp+VCh0VH4=;
        b=GEDavZ8MnseRs0HNbGx+z2G59P5nQ0v/ix2ewZhM7O2WBUuy3k2qdmQM8lLcq8pTI5lzpD
        kG5/rP0vKMSHt+PVfi7UiEybDYpvfk3d4eA08EK0HCErGcYSyjrFF424ezF3uP7ooJq3zt
        TYCrffq2gsUeNAiS2fF6JhZJojKnIgo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-cUcreWDIO2OuAIH2axwRlQ-1; Wed, 17 Feb 2021 16:19:31 -0500
X-MC-Unique: cUcreWDIO2OuAIH2axwRlQ-1
Received: by mail-qt1-f197.google.com with SMTP id f5so11007509qtf.15
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 13:19:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=xBMyArAKf4mpgQyvFkqw/42F48Y7NN6P7Dp+VCh0VH4=;
        b=qJQAPoBvlBIgg3hpB7Rp3C4ufPYNpee+v7+BGyP57H1yKLSe4WUfC1R6aLKOOXAFZ0
         UpjLt0Dpirmi6PiphHf2GXuVfozMKZu0Oj5YAl4iOg9/MPQE3WiCRx9bc0TlPhMUpUSg
         K40tgm2SUU2tLkJCQoVk9dg1TsrdwDNcNfDz1RXECWZuTryS1UamF+eJ8IzmXSmPdkGt
         rSXEQQaPFhmgLDBBF16tCJCve9Kq1LZTS147+moo4F9m/Zvqt4PEJZaiUPy7Hx89S1sd
         RvscszEglan2njGeWG25PUncLvLyxzVzB3mT5O2/MoATYJoGvdHX75DzoZs/QNpziU/G
         oLFw==
X-Gm-Message-State: AOAM533NSuZPGuEPyeHXknKhcIg1dPepXSuqOZv/+26j/VTEahKx0zO1
        5obEzGCCicc1u5MaYMlLt8pF8EFufanJPNP5hvU2A3MCoRyjKAgnaux9Op3CenalSZXh7+vdD+G
        wUAijV29F8mashb72B9GwLD7F
X-Received: by 2002:a05:620a:5e3:: with SMTP id z3mr1298127qkg.82.1613596771221;
        Wed, 17 Feb 2021 13:19:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPSYxeA8g2iE40CK7FvkDEZG3iHDG4i+DK7dA2OIu1Fj2bHEppjVJXZjSCy3KXYHo6ADRVaA==
X-Received: by 2002:a05:620a:5e3:: with SMTP id z3mr1298100qkg.82.1613596770966;
        Wed, 17 Feb 2021 13:19:30 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id 18sm1938054qtw.70.2021.02.17.13.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 13:19:30 -0800 (PST)
Message-ID: <a55af9a9f4454f07e34c984cc2ef0e31b38fcbf1.camel@redhat.com>
Subject: Re: [PATCH v4] drm/i915/gen9bc: Handle TGP PCH during suspend/resume
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     imre.deak@intel.com
Cc:     intel-gfx@lists.freedesktop.org,
        Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 17 Feb 2021 16:19:29 -0500
In-Reply-To: <20210217211802.GC558393@ideak-desk.fi.intel.com>
References: <20210217025337.1929015-1-lyude@redhat.com>
         <20210217180016.1937401-1-lyude@redhat.com>
         <20210217211802.GC558393@ideak-desk.fi.intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-02-17 at 23:18 +0200, Imre Deak wrote:
> On Wed, Feb 17, 2021 at 01:00:16PM -0500, Lyude Paul wrote:
> > From: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> > 
> > For Legacy S3 suspend/resume GEN9 BC needs to enable and
> > setup TGP PCH.
> > 
> > v2:
> > * Move Wa_14010685332 into it's own function - vsyrjala
> > * Add TODO comment about figuring out if we can move this workaround - imre
> > v3:
> > * Rename cnp_irq_post_reset() to cnp_display_clock_wa()
> > * Add TODO item mentioning we need to clarify which platforms this
> >   workaround applies to
> > * Just use ibx_irq_reset() in gen8_irq_reset(). This code should be
> >   functionally equivalent on gen9 bc to the code v2 added
> > * Drop icp_hpd_irq_setup() call in spt_hpd_irq_setup(), this looks to be
> >   more or less identical to spt_hpd_irq_setup() minus additionally enabling
> >   one port. Will update i915 to use icp_hpd_irq_setup() for ICP in a
> >   separate patch.
> > v4:
> > * Revert Wa_14010685332 system list in comments to how it was before
> > * Add back HAS_PCH_SPLIT() check before calling ibx_irq_reset()
> > 
> > Cc: Matt Roper <matthew.d.roper@intel.com>
> > Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> 
> Thanks, looks ok to me:
> Reviewed-by: Imre Deak <imre.deak@intel.com>
> 
> nit: cnp_display_clock_gating_wa() would be an even better name, could
> be renamed while applying.

Sure thing. JFYI - I'm going to hold off on pushing this patch until I've got
confirmation from the OEMs this is for that these patches still fix their issues
(since I unfortunately don't have any access to this hardware).

> 
> > ---
> >  drivers/gpu/drm/i915/i915_irq.c | 49 +++++++++++++++++++++------------
> >  1 file changed, 32 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/i915/i915_irq.c
> > b/drivers/gpu/drm/i915/i915_irq.c
> > index 98145a7f28a4..9b56a8f81e1a 100644
> > --- a/drivers/gpu/drm/i915/i915_irq.c
> > +++ b/drivers/gpu/drm/i915/i915_irq.c
> > @@ -3040,6 +3040,24 @@ static void valleyview_irq_reset(struct
> > drm_i915_private *dev_priv)
> >         spin_unlock_irq(&dev_priv->irq_lock);
> >  }
> >  
> > +static void cnp_display_clock_wa(struct drm_i915_private *dev_priv)
> > +{
> > +       struct intel_uncore *uncore = &dev_priv->uncore;
> > +
> > +       /*
> > +        * Wa_14010685332:cnp/cmp,tgp,adp
> > +        * TODO: Clarify which platforms this applies to
> > +        * TODO: Figure out if this workaround can be applied in the s0ix
> > suspend/resume handlers as
> > +        * on earlier platforms and whether the workaround is also needed
> > for runtime suspend/resume
> > +        */
> > +       if (INTEL_PCH_TYPE(dev_priv) == PCH_CNP ||
> > +           (INTEL_PCH_TYPE(dev_priv) >= PCH_TGP && INTEL_PCH_TYPE(dev_priv)
> > < PCH_DG1)) {
> > +               intel_uncore_rmw(uncore, SOUTH_CHICKEN1,
> > SBCLK_RUN_REFCLK_DIS,
> > +                                SBCLK_RUN_REFCLK_DIS);
> > +               intel_uncore_rmw(uncore, SOUTH_CHICKEN1,
> > SBCLK_RUN_REFCLK_DIS, 0);
> > +       }
> > +}
> > +
> >  static void gen8_irq_reset(struct drm_i915_private *dev_priv)
> >  {
> >         struct intel_uncore *uncore = &dev_priv->uncore;
> > @@ -3063,6 +3081,8 @@ static void gen8_irq_reset(struct drm_i915_private
> > *dev_priv)
> >  
> >         if (HAS_PCH_SPLIT(dev_priv))
> >                 ibx_irq_reset(dev_priv);
> > +
> > +       cnp_display_clock_wa(dev_priv);
> >  }
> >  
> >  static void gen11_display_irq_reset(struct drm_i915_private *dev_priv)
> > @@ -3104,15 +3124,7 @@ static void gen11_display_irq_reset(struct
> > drm_i915_private *dev_priv)
> >         if (INTEL_PCH_TYPE(dev_priv) >= PCH_ICP)
> >                 GEN3_IRQ_RESET(uncore, SDE);
> >  
> > -       /* Wa_14010685332:cnp/cmp,tgp,adp */
> > -       if (INTEL_PCH_TYPE(dev_priv) == PCH_CNP ||
> > -           (INTEL_PCH_TYPE(dev_priv) >= PCH_TGP &&
> > -            INTEL_PCH_TYPE(dev_priv) < PCH_DG1)) {
> > -               intel_uncore_rmw(uncore, SOUTH_CHICKEN1,
> > -                                SBCLK_RUN_REFCLK_DIS,
> > SBCLK_RUN_REFCLK_DIS);
> > -               intel_uncore_rmw(uncore, SOUTH_CHICKEN1,
> > -                                SBCLK_RUN_REFCLK_DIS, 0);
> > -       }
> > +       cnp_display_clock_wa(dev_priv);
> >  }
> >  
> >  static void gen11_irq_reset(struct drm_i915_private *dev_priv)
> > @@ -3764,9 +3776,19 @@ static void gen8_de_irq_postinstall(struct
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
> > @@ -3775,13 +3797,6 @@ static void gen8_irq_postinstall(struct
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
> 

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

