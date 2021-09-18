Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4DD410261
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 02:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241474AbhIRAYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 20:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhIRAY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 20:24:29 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3418C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 17:23:06 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id a13so7523075qvo.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 17:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=9Yquok3keWXfxx1SiuD1jwnkkyU1hJz6lsD8Jb2t7dM=;
        b=d42kuUk8yxoPLefw3t9P28WutVmZcarF1jMBLyzJm3JhVCj4bT619dR1RfKzCfqO/5
         sKbUtkflgLEt0UHbUT7Z/HFbLxB6L5rAcXMIj6J+fLbU1H0A/InqGwFg0TF94JENYcsx
         0Ep1Ha5HultYLgX5eMK9/5q6RfNL+i7/EPtiIRgQh/mgPgD/NQm6DHHUdLkkZ19ElNNr
         D7/qGd9xaG69LqXFEfZLfVtfa0IVzDimSj/PfwsdiEj3/ApeyjqsxyAZvY4zeO97b5Ic
         btJ1Db914qS0RrJFaLuo3CqwjfNRnXu3zjX5zRW93cslclN8QWLy41tSebA8Ti/0906o
         MjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=9Yquok3keWXfxx1SiuD1jwnkkyU1hJz6lsD8Jb2t7dM=;
        b=TOxdnXxyO8RrWZRTD+yiQUsEkjs4rMPM7Iyrhu5iNGNGAZUGmY+eapYkgxteuKIoyb
         osiaANkzp3Du/77lvuXXIAvw0Ued2VZiBFQN39hs/rBMIh94BxIHUcV1JRgmvDqucS7G
         Pe/VIUWQqUypfhi0ov1Kz3absaozZli1dFrVvKPGLe2xsIuN0ML/flUcUQ1Gfker0VTu
         xFz6VDvyMEOwYIIIHqiTXb5BDH2xoJTRJKtlVm5TOaMU4eTWbxaRO1Xlu/aXEoid7bPW
         8n8Xc8K9Md+iJI00kqULhMsNV75jYckP0cQcc+bgOv11srd06G9PnxV2FUyg1e8fa8KY
         khLQ==
X-Gm-Message-State: AOAM531hIART81ViYvfDE+vpxBNMJfDHW8AVlvUltUu3dUGpld7gtFx/
        bN4g1IuV2HOhfqdRody5dnXxhw==
X-Google-Smtp-Source: ABdhPJyRHWIUO2zN1P+ypsRiH1k5HgRa4I4DMeMdztx9Has1Y8+Rpe9dOhM/0bQmeoGaZNC818niWg==
X-Received: by 2002:a05:6214:12ad:: with SMTP id w13mr14133087qvu.13.1631924585764;
        Fri, 17 Sep 2021 17:23:05 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v24sm5698326qkv.11.2021.09.17.17.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 17:23:05 -0700 (PDT)
Date:   Fri, 17 Sep 2021 17:22:51 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Brost <matthew.brost@intel.com>
cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Sujaritha Sundaresan <sujaritha.sundaresan@intel.com>,
        John Harrison <John.C.Harrison@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Pavel Machek <pavel@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: 5.15-rc1 i915 blank screen booting on ThinkPads
In-Reply-To: <20210917232906.GA5729@jons-linux-dev-box>
Message-ID: <96deb75-9a48-29a8-1a7-6d48b3e8b6dc@google.com>
References: <9e1a6f3b-5e64-be91-ba54-9b5d135ef638@google.com> <9e4c1c68-8d1e-ee2c-99bf-320046130775@linux.intel.com> <87mtocx1rm.fsf@intel.com> <1f955bff-fd9e-d2ee-132a-f758add9e9cb@google.com> <20210917213032.GA34270@jons-linux-dev-box> <87k0jevmpr.fsf@intel.com>
 <20210917232906.GA5729@jons-linux-dev-box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2021, Matthew Brost wrote:
> On Sat, Sep 18, 2021 at 01:52:48AM +0300, Jani Nikula wrote:
> > On Fri, 17 Sep 2021, Matthew Brost <matthew.brost@intel.com> wrote:
> > > On Fri, Sep 17, 2021 at 02:26:48PM -0700, Hugh Dickins wrote:
> > >> On Thu, 16 Sep 2021, Jani Nikula wrote:
> > >> > On Thu, 16 Sep 2021, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com> wrote:
> > >> > > On 16/09/2021 05:37, Hugh Dickins wrote:
> > >> > >> Two Lenovo ThinkPads, old T420s (2011), newer X1 Carbon 5th gen (2017):
> > >> > >> i915 working fine on both up to 5.14, but blank screens booting 5.15-rc1,
> > >> > >> kernel crashed in some way.
> > >> ...
> > >> > > Kernel logs with drm.debug=0xe, with the broken black screen state, 
> > >> > > would probably answer a lot of questions if you could gather it from 
> > >> > > both machines?
> > >> > 
> > >> > And for that, I think it's best to file separate bugs at [1] and attach
> > >> > the logs there. It helps keep the info in one place. Thanks.
> > >> > 
> > >> > BR,
> > >> > Jani.
> > >> > 
> > >> > [1] https://gitlab.freedesktop.org/drm/intel/issues/new
> > >> 
> > >> Thanks for the quick replies: but of course, getting kernel logs was
> > >> the difficult part, this being bootup, with just a blank screen, and
> > >> no logging to disk at this stage.  I've never needed it before, but
> > >> netconsole to the rescue.
> > >> 
> > >> Problem then obvious, both machines now working,
> > >> please let me skip the bug reports, here's a patch:
> > >> 
> > >
> > > Thanks for finding / fixing this Hugh. I will post this patch in a way
> > > our CI system can understand.
> > 
> > Thanks indeed!
> > 
> > Matt, please get rid of the BUG_ON while at it, and make it a
> > WARN. Oopsing doesn't do anyone any good.
> > 
> 
> Sure. Will do. Long term we should just look to rip out crap this (i.e.
> stealing bits from aligned addresses for flags).

It just crossed my mind, that I never did due diligence on _other_
callers of i915_sw_fence_init().  In fact they're okay, but that's
because their fence functions are all declared with the
#define __i915_sw_fence_call __aligned(4)
from i915_sw_fence.h, which I had not seen when I sent the patch.

I'm not going to resend, but if I were you, I'd quietly edit that
patch to use __i915_sw_fence_call in place of my __aligned(4).

Thanks,
Hugh

> 
> Matt
> 
> > BR,
> > Jani.
> > 
> > >
> > > Matt 
> > >
> > >> [PATCH] drm/i915: fix blank screen booting crashes
> > >> 
> > >> 5.15-rc1 crashes with blank screen when booting up on two ThinkPads
> > >> using i915.  Bisections converge convincingly, but arrive at different
> > >> and surprising "culprits", none of them the actual culprit.
> > >> 
> > >> netconsole (with init_netconsole() hacked to call i915_init() when
> > >> logging has started, instead of by module_init()) tells the story:
> > >> 
> > >> kernel BUG at drivers/gpu/drm/i915/i915_sw_fence.c:245!
> > >> with RSI: ffffffff814d408b pointing to sw_fence_dummy_notify().
> > >> I've been building with CONFIG_CC_OPTIMIZE_FOR_SIZE=y, and that
> > >> function needs to be 4-byte aligned.
> > >> 
> > >> Fixes: 62eaf0ae217d ("drm/i915/guc: Support request cancellation")
> > >> Signed-off-by: Hugh Dickins <hughd@google.com>
> > >> ---
> > >> 
> > >>  drivers/gpu/drm/i915/gt/intel_context.c |    1 +
> > >>  1 file changed, 1 insertion(+)
> > >> 
> > >> --- a/drivers/gpu/drm/i915/gt/intel_context.c
> > >> +++ b/drivers/gpu/drm/i915/gt/intel_context.c
> > >> @@ -362,6 +362,7 @@ static int __intel_context_active(struct
> > >>  	return 0;
> > >>  }
> > >>  
> > >> +__aligned(4)	/* Respect the I915_SW_FENCE_MASK */
> > >>  static int sw_fence_dummy_notify(struct i915_sw_fence *sf,
> > >>  				 enum i915_sw_fence_notify state)
> > >>  {
> > 
> > -- 
> > Jani Nikula, Intel Open Source Graphics Center
