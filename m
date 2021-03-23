Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE13346629
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbhCWRUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:20:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59791 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229730AbhCWRT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616519998;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NporAmmj4L3RcGRFRknw2IvghUGU1cT9aJdVv6NKWMw=;
        b=R4mGwpSqp3UK6cArqDrxolcrhh3hRypLkMvraxdTLEwR/T6APIn8l652zJEeazafR+Wdld
        blpYAPV+Ztjf5kVbko5phhIqrF4lk/0SaOCvRyKXikkHFD1SL4hbEVOPy+xm4EtBToYmBt
        YkwFLtG4K2IkxLcLpeNMkEOrBT5n+74=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-Hlr9eeV5Oie2MhtUqxU3iQ-1; Tue, 23 Mar 2021 13:19:56 -0400
X-MC-Unique: Hlr9eeV5Oie2MhtUqxU3iQ-1
Received: by mail-qt1-f200.google.com with SMTP id t5so1655859qti.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 10:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=NporAmmj4L3RcGRFRknw2IvghUGU1cT9aJdVv6NKWMw=;
        b=GiWOpw7zj0lhyGwbZsRJzyQwbwjIDLU8g90RrXoduaVY4FZMq2NDxtm9LUe5Z1uBBa
         PSv4R88Dimv3TJ+dhBM729tttOeBjEeOcYqollw9Q3pFqfhpL1+6o/l1egqPxqQT4PuI
         tbsbl17qcmGCpMHeeby65lvtHBhgh6vG2s0iBHPKNF/YFIfl0bu19pipvdsxJ5H1y6Mn
         ljgaU3xxBnqVm5ghG5wcFhWWGxSoaSTtrZxir3c0b7E63NxUQoX54E8feAONiyeqv2BV
         fnbljg5qrGV3S3RqOm3TjPkXZQ4NkvDK7j0uSZlt+Bo6b0MOcRmmCfnD2qbJOhYblOtx
         yBLg==
X-Gm-Message-State: AOAM532+tbXQK5h6bMSMyWIeDBVUniHNB+BeBFRPBioIFOegSQprBdJL
        ci+dnH0RKCBMwXgEwKTHTiQyx0UnfnEFc2uZv5uaT6tXx4jsU3LwRIVbyWjuL/3Lh9NZYvgsQ7z
        QE+IOCkCDDs58v+3AvXpnEPh+
X-Received: by 2002:ac8:1405:: with SMTP id k5mr5442893qtj.262.1616519995036;
        Tue, 23 Mar 2021 10:19:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiLznM9M+kk+bDsK0zDhwCbPTH1MxTleA2r2FpQmjUe9jLcoI66vGcNor+jHw3s4hmjHGqPA==
X-Received: by 2002:ac8:1405:: with SMTP id k5mr5442877qtj.262.1616519994809;
        Tue, 23 Mar 2021 10:19:54 -0700 (PDT)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id f136sm14236517qke.24.2021.03.23.10.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 10:19:54 -0700 (PDT)
Message-ID: <4b95f72806c07348e4d26f1770326223b40fa845.camel@redhat.com>
Subject: Re: [PATCH] drm/i915/dpcd_bl: Don't try vesa interface unless
 specified by VBT
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Aaron Ma <aaron.ma@canonical.com>,
        Dave Airlie <airlied@redhat.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Tue, 23 Mar 2021 13:19:53 -0400
In-Reply-To: <87k0py3qya.fsf@intel.com>
References: <20210318170204.513000-1-lyude@redhat.com>
         <dfec442a4888c8387a6002b0424415ee5d8be343.camel@redhat.com>
         <87k0py3qya.fsf@intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-03-23 at 16:06 +0200, Jani Nikula wrote:
> On Thu, 18 Mar 2021, Lyude Paul <lyude@redhat.com> wrote:
> > Actually-NAK this. I just realized I've been misreading the bug and that
> > this
> > doesn't actually seem to be fixed. Will resend once I figure out what's
> > going on
> 
> Well, I think there are actually multiple issues on multiple
> machines. This fixes the issue on ThinkPad X1 Titanium Gen1 [1].
> 
> I suspect reverting 98e497e203a5 ("drm/i915/dpcd_bl: uncheck PWM_PIN_CAP
> when detect eDP backlight capabilities") would too. But then that would
> break *other* machines that claim support for *both* eDP PWM pin and
> DPCD backlight control, I think.
> 
> I think there are issues with how we try setup DPCD backlight if the GOP
> has set up PWM backlight. For example, we don't set the backlight
> control mode correctly until the next disable/enable sequence. However,
> I tried to fix this, and I think I was doing all the right things, and
> DPCD reads seemed to confirm this, yet I was not able to control
> brightness using DPCD. I don't know what gives, but I do know eDP PWM
> pin control works.

Should we go ahead and push the VESA fix for this then? If you're willing to
test future patches on that machine, we could give another shot at enabling this
in the future if we find reason to.

> 
> 
> BR,
> Jani.
> 
> 
> [1] https://gitlab.freedesktop.org/drm/intel/-/issues/3158
> 
> 
> > 
> > On Thu, 2021-03-18 at 13:02 -0400, Lyude Paul wrote:
> > > Looks like that there actually are another subset of laptops on the market
> > > that don't support the Intel HDR backlight interface, but do advertise
> > > support for the VESA DPCD backlight interface despite the fact it doesn't
> > > seem to work.
> > > 
> > > Note though I'm not entirely clear on this - on one of the machines where
> > > this issue was observed, I also noticed that we appeared to be rejecting
> > > the VBT defined backlight frequency in
> > > intel_dp_aux_vesa_calc_max_backlight(). It's noted in this function that:
> > > 
> > > /* Use highest possible value of Pn for more granularity of brightness
> > >  * adjustment while satifying the conditions below.
> > >  * ...
> > >  * - FxP is within 25% of desired value.
> > >  *   Note: 25% is arbitrary value and may need some tweak.
> > >  */
> > > 
> > > So it's possible that this value might just need to be tweaked, but for
> > > now
> > > let's just disable the VESA backlight interface unless it's specified in
> > > the VBT just to be safe. We might be able to try enabling this again by
> > > default in the future.
> > > 
> > > Fixes: 2227816e647a ("drm/i915/dp: Allow forcing specific interfaces
> > > through
> > > enable_dpcd_backlight")
> > > Cc: Jani Nikula <jani.nikula@intel.com>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Bugzilla: https://gitlab.freedesktop.org/drm/intel/-/issues/3169
> > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > ---
> > >  drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > index 651884390137..4f8337c7fd2e 100644
> > > --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> > > @@ -646,7 +646,6 @@ int intel_dp_aux_init_backlight_funcs(struct
> > > intel_connector *connector)
> > >                         break;
> > >                 case INTEL_BACKLIGHT_DISPLAY_DDI:
> > >                         try_intel_interface = true;
> > > -                       try_vesa_interface = true;
> > >                         break;
> > >                 default:
> > >                         return -ENODEV;
> 

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

