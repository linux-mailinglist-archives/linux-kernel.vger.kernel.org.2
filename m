Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807B140B0C5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhINOfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233437AbhINOfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:35:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185B9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:34:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m9so20633123wrb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=umuxgc7vOkVRRThGNSeYBWaUdtkpW3a8Wcpiqh4MYbc=;
        b=jD8ytdC9p3Oynfkv/tjifDU0me0iiGMF/3m6ml50oggD+O0K3DOQyfqsmqlDIQDoCH
         VwUYp0Wb4PDbLm7l1Rss7xsPk7TETZWw1YT27aWApJa4xAgZAyp649HE8fcODei/OAa8
         jR3n5M6hKglM0yOeQkIKKlBnFvQX45NxCLTRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=umuxgc7vOkVRRThGNSeYBWaUdtkpW3a8Wcpiqh4MYbc=;
        b=oX0F8MVNPef9MIRWqBlaB2BYjGiLDwQonNef4+tV7cn9WIGslr3X3dP5sc/k5pDURA
         7uUCVjV6irP7aV5oGtEpcuYgKEkCXUJfQ4ahoEaYeXbMOWP8fmv3K2Eet9XDPSF8K8yP
         c9rrj/FsrDhw2wh9aOlQh2GqymH+5S91mmYJdGy2Bp9j8CzAvSNs5cSxsMv7iskg+PoE
         ja/R/MRoNL+nPMcKfefmTRgqSSaAZKIfk3uNk5r/LNjdrN9/LYLqdM7CVPKjENcCP4lv
         5gE8lCgxphtcJURXqyEHmw2ybaCyQa6hSUOymZ84Ay5zUFMuPvmFS2+ziYlIuRZfxKK1
         vAGQ==
X-Gm-Message-State: AOAM533tO+UL4JgD6KPJh0mTpeRYZ4WXFXpCVdy2fHIga45y8rQcfsg1
        jFm8doU1bXs7oPlCVBEbFwlRSQ==
X-Google-Smtp-Source: ABdhPJyNO/LULB90/yEEwF9ND2QwLBtsq4PXK/5714kKpXeCbJIv1rAbuAXKev+VHEAfFBzqOw58yg==
X-Received: by 2002:adf:e349:: with SMTP id n9mr19840313wrj.326.1631630051643;
        Tue, 14 Sep 2021 07:34:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d9sm13255576wrb.36.2021.09.14.07.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 07:34:11 -0700 (PDT)
Date:   Tue, 14 Sep 2021 16:34:08 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>,
        linux-rpi-kernel@lists.infradead.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/vc4: hdmi: Actually check for the connector
 status in hotplug
Message-ID: <YUCy4AmYDFD2jtG6@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Emma Anholt <emma@anholt.net>, linux-rpi-kernel@lists.infradead.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>, Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
References: <20210914101724.266570-1-maxime@cerno.tech>
 <20210914101724.266570-3-maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914101724.266570-3-maxime@cerno.tech>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:17:24PM +0200, Maxime Ripard wrote:
> The drm_helper_hpd_irq_event() documentation states that this function
> is "useful for drivers which can't or don't track hotplug interrupts for
> each connector." and that "Drivers which support hotplug interrupts for
> each connector individually and which have a more fine-grained detect
> logic should bypass this code and directly call
> drm_kms_helper_hotplug_event()". This is thus what we ended-up doing.
> 
> However, what this actually means, and is further explained in the
> drm_kms_helper_hotplug_event() documentation, is that
> drm_kms_helper_hotplug_event() should be called by drivers that can
> track the connection status change, and if it has changed we should call
> that function.
> 
> This underlying expectation we failed to provide is that the caller of
> drm_kms_helper_hotplug_event() should call drm_helper_probe_detect() to
> probe the new status of the connector.
> 
> Since we didn't do it, it meant that even though we were sending the
> notification to user-space and the DRM clients that something changed we
> never probed or updated our internal connector status ourselves.
> 
> This went mostly unnoticed since the detect callback usually doesn't
> have any side-effect. Also, if we were using the DRM fbdev emulation
> (which is a DRM client), or any user-space application that can deal
> with hotplug events, chances are they would react to the hotplug event
> by probing the connector status eventually.
> 
> However, now that we have to enable the scrambler in detect() if it was
> enabled it has a side effect, and an application such as Kodi or
> modetest doesn't deal with hotplug events. This resulted with a black
> screen when Kodi or modetest was running when a screen was disconnected
> and then reconnected, or switched off and on.

Uh, why are you running this scrambler restore in your probe function? I
guess it works, but most drivers that do expensive hotplug restore to
handle the "no black screen for replug" use-case handle that in their own
dedicated code.

But those also tend to have per-output hpd interrupt sources, so maybe
that's why?
-Daniel

> 
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/gpu/drm/vc4/vc4_hdmi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
> index a3dbd1fdff7d..d9e001b9314f 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -1578,10 +1578,11 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
>  static irqreturn_t vc4_hdmi_hpd_irq_thread(int irq, void *priv)
>  {
>  	struct vc4_hdmi *vc4_hdmi = priv;
> -	struct drm_device *dev = vc4_hdmi->connector.dev;
> +	struct drm_connector *connector = &vc4_hdmi->connector;
> +	struct drm_device *dev = connector->dev;
>  
>  	if (dev && dev->registered)
> -		drm_kms_helper_hotplug_event(dev);
> +		drm_connector_helper_hpd_irq_event(connector);
>  
>  	return IRQ_HANDLED;
>  }
> -- 
> 2.31.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
