Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60483D71D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 11:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbhG0JU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 05:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbhG0JU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:20:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF10DC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 02:20:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b128so7088652wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 02:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yvx7FUb+PO9K9tu4D9agXVqaQ0PZBo5xaT5yPpMKIms=;
        b=SIunivkJ3uBUWFL+MmqRwoRt2Ec13tI5ReuRrYPHU6v1ozJHB0RqmiXR2kJtHg7UkK
         kQHeIhOqy40affcu0iFYZjipx4Rj7mvXor6+msSm/jLTCD0shhRncWpbA8dQZkMdDKxG
         CY2f7wiJ4ZZW/66YmNtctsKo4S5yBfyNtbbac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Yvx7FUb+PO9K9tu4D9agXVqaQ0PZBo5xaT5yPpMKIms=;
        b=ih0wWU2iLWHUmmvo7NAKfae4wPXmDeX7GKrWOM4ywBB4H5ZD3zdptiUB0zE1fgnxTh
         BNyGinjrdjzUyIacigz7mt66Xs4vzTNFFsPYwS3asm4r1xJwrsQyfprk+G7KprQ93PyS
         II5TJXnfSOth5PhJsS+3r8FtnHftZoz6plIKIiqPU6pnuwEWD+Sj56CBzDgGo8OgUWkj
         zZlsmr6p1sE3kVYvTnvevFX4bhTHZBPNWXg1/WrqM9vdpYQklmJvWbWyqQL9JCUeLSJS
         53L49rXN1H8G/BYResVloz14VQpJ+WWqrW+LYDAhFGy2MJWm0E0UIaJ8sxkMwy2KI/nV
         +5UQ==
X-Gm-Message-State: AOAM532zQ2uVmgIhehgE5TNSm0SVtrC11u7XVpFxX+dLbMv5JTG4QZvx
        FD3+Yw9X/V0Cm/vv35z5N4b4Yw==
X-Google-Smtp-Source: ABdhPJysqoczxFjCBoJFO3VIH1BODqUjcyDz8tshadU8bwCX8Ub+Bjigbsxk+srbu2FSB8xv5JCr8A==
X-Received: by 2002:a05:600c:1c0d:: with SMTP id j13mr21332335wms.34.1627377657192;
        Tue, 27 Jul 2021 02:20:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q19sm2002588wmq.38.2021.07.27.02.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 02:20:56 -0700 (PDT)
Date:   Tue, 27 Jul 2021 11:20:54 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 04/10] drm/bridge: Document the probe issue with MIPI-DSI
 bridges
Message-ID: <YP/P9rJrZyk6zjsT@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <maxime@cerno.tech>,
        Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>, Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20210720134525.563936-1-maxime@cerno.tech>
 <20210720134525.563936-5-maxime@cerno.tech>
 <YPgNbVoNnq3fTMN2@phenom.ffwll.local>
 <20210726151657.c46qmkdvqfhlg6ox@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726151657.c46qmkdvqfhlg6ox@gilmour>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 05:16:57PM +0200, Maxime Ripard wrote:
> Hi Daniel,
> 
> On Wed, Jul 21, 2021 at 02:05:01PM +0200, Daniel Vetter wrote:
> > On Tue, Jul 20, 2021 at 03:45:19PM +0200, Maxime Ripard wrote:
> > > Interactions between bridges, panels, MIPI-DSI host and the component
> > > framework are not trivial and can lead to probing issues when
> > > implementing a display driver. Let's document the various cases we need
> > > too consider, and the solution to support all the cases.
> > > 
> > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > 
> > I still have this dream that eventually we resurrect a patch to add
> > device_link to bridges/panels (ideally automatically), to help with some
> > of the suspend/resume issues around here.
> > 
> > Will this make things worse?
> > 
> > I think it'd be really good to figure that out with some coding, since if
> > we have incompatible solution to handle probe issues vs suspend/resume
> > issues, we're screwed.
> > 
> > Atm the duct-tape is to carefully move things around between suspend and
> > suspend_early hooks (and resume and resume_late) and hope it all works ...
> 
> My initial idea to fix this was indeed to use device links. I gave up
> after a while since it doesn't look like there's a way to add a device
> link before either the bridge or encoder probes.
> 
> Indeed the OF-Graph representation is device-specific, so it can't be
> generic, and if you need to probe to add that link, well, it's already
> too late for the probe ordering :)

But don't we still need the device_link for suspend/resume and module
reload? All very annoying indeed anyway.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
