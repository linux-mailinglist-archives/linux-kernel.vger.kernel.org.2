Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0D64312C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 11:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhJRJND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 05:13:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:32397 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231149AbhJRJNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 05:13:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10140"; a="228087115"
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="228087115"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 02:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,381,1624345200"; 
   d="scan'208";a="443330095"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga006.jf.intel.com with SMTP; 18 Oct 2021 02:10:41 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 18 Oct 2021 12:10:40 +0300
Date:   Mon, 18 Oct 2021 12:10:40 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        =?iso-8859-1?Q?D=E1vid_Bolvansk=FD?= <david.bolvansky@gmail.com>
Subject: Re: [PATCH] drm/i915: Avoid bitwise vs logical OR warning in
 snb_wm_latency_quirk()
Message-ID: <YW06ED6XvTcrD9wP@intel.com>
References: <20211014211916.3550122-1-nathan@kernel.org>
 <CAKwvOdmSFP98Mc1u2b+=_Dux9eB_yumRvxOx7UTXuyXOYzG3uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmSFP98Mc1u2b+=_Dux9eB_yumRvxOx7UTXuyXOYzG3uA@mail.gmail.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 02:21:43PM -0700, Nick Desaulniers wrote:
> On Thu, Oct 14, 2021 at 2:19 PM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > A new warning in clang points out a place in this file where a bitwise
> > OR is being used with boolean types:
> >
> > drivers/gpu/drm/i915/intel_pm.c:3066:12: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
> >         changed = ilk_increase_wm_latency(dev_priv, dev_priv->wm.pri_latency, 12) |
> >                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > This construct is intentional, as it allows every one of the calls to
> > ilk_increase_wm_latency() to occur (instead of short circuiting with
> > logical OR) while still caring about the result of each call.
> >
> > To make this clearer to the compiler, use the '|=' operator to assign
> > the result of each ilk_increase_wm_latency() call to changed, which
> > keeps the meaning of the code the same but makes it obvious that every
> > one of these calls is expected to happen.

Sure, why not.

> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1473
> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> 
> Thanks for the patch!
> Suggested-by: Dávid Bolvanský <david.bolvansky@gmail.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 

Thanks for the patch+review. Applied to drm-intel-next.

> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  drivers/gpu/drm/i915/intel_pm.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
> > index f90fe39cf8ca..aaa3a0998e4c 100644
> > --- a/drivers/gpu/drm/i915/intel_pm.c
> > +++ b/drivers/gpu/drm/i915/intel_pm.c
> > @@ -3050,9 +3050,9 @@ static void snb_wm_latency_quirk(struct drm_i915_private *dev_priv)
> >          * The BIOS provided WM memory latency values are often
> >          * inadequate for high resolution displays. Adjust them.
> >          */
> > -       changed = ilk_increase_wm_latency(dev_priv, dev_priv->wm.pri_latency, 12) |
> > -               ilk_increase_wm_latency(dev_priv, dev_priv->wm.spr_latency, 12) |
> > -               ilk_increase_wm_latency(dev_priv, dev_priv->wm.cur_latency, 12);
> > +       changed = ilk_increase_wm_latency(dev_priv, dev_priv->wm.pri_latency, 12);
> > +       changed |= ilk_increase_wm_latency(dev_priv, dev_priv->wm.spr_latency, 12);
> > +       changed |= ilk_increase_wm_latency(dev_priv, dev_priv->wm.cur_latency, 12);
> >
> >         if (!changed)
> >                 return;
> >
> > base-commit: d73b17465d6da0a94bc0fcc86b150e1e923e8f71
> > --
> > 2.33.1.637.gf443b226ca
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers

-- 
Ville Syrjälä
Intel
