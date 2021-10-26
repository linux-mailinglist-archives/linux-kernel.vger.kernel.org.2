Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B52243AA5B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 04:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbhJZCi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 22:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbhJZCi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 22:38:57 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826B9C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 19:36:34 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id x123so13800388qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 19:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0WMeSWB8rpl9OD9K4iGbTmC/396k4C7y2b8GYI2C4Ok=;
        b=gLoP/eE1oj2bVGRPfSFWrxiiJwjbRxfkKGR6/Mn+2qyyGAFHGSQ41QpeNWkOeU7vwQ
         Ehi7bPaR1Omp4VHrIjn3gxNqHOjAqsvFDW2JIowqspwVMLppqzaOMFX7J252ghpSaeru
         fznOG1OUIeks61lGkVrj2mHudP7bzj7TRNoVf+5hRHcOYj5BQcn+paqAEYOGyG4cCUbA
         Fx5LKNJVheJ8j5XsL4J+9YtVkILLs3KwJro54TSSqgbsqCo9Sm8765820N6IlIg5Kuaq
         C6Dxjil9Drtjqur5cvD6OtQf9/WTdOQEfhx4o5xxmXyvS29wOY6zHuuRGwSs219zZFJZ
         Is7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0WMeSWB8rpl9OD9K4iGbTmC/396k4C7y2b8GYI2C4Ok=;
        b=ONduC0AtDMt72za89OxiCR4oYad60FKrU998zOBsL5D0DqdFPTPL7NDexkCUcA5VNi
         Z/s97FZKn5Z4Ykv62LCdfdmuprPmBH3WYxf0CUBV00a83LkKfp+JXk6HIxTdka7HMClG
         mWxw0d6pL0E03plYeePI1ctF5SFXKBjtimw8C3lOXmnJnhv1uz3umNe8bxlMd91rtTx5
         YGQg+TZQOXo6xIdT5N1K2/5wzWdOWOrT/dcLVaRbCo1EQigslr3bgsjTE5kRPAgbQGHO
         daO9CVup7Ci0UVLFcVf5H2JSSjT1it1Zxvc8KGslaG0YWgL3f958ucepGTrBb8XiBjzq
         91Yw==
X-Gm-Message-State: AOAM5336f7O8nM4fjzREHTMnoruHUDhLrsEGFDHkgYOLdEzDyrq9xyRi
        tTVTRDkY2weTAQ1xCFXmautziS5joWNmZEA/lX8=
X-Google-Smtp-Source: ABdhPJxAIRACc/l4LXZdfvM4XQCLAip164dixWDF2yMu9E/ExcUQ3WTAYXOYh1HtrQ9P/eGymml0Zg==
X-Received: by 2002:a05:620a:298d:: with SMTP id r13mr16214942qkp.428.1635215793595;
        Mon, 25 Oct 2021 19:36:33 -0700 (PDT)
Received: from ubuntu-mate-laptop.localnet ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id t22sm4487568qtw.21.2021.10.25.19.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 19:36:33 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     robert.foss@linaro.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, jagan@amarulasolutions.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: bridge: fix unmet dependency on DRM_KMS_HELPER for DRM_PANEL_BRIDGE
Date:   Mon, 25 Oct 2021 22:36:32 -0400
Message-ID: <4188280.18OdhQZZCD@ubuntu-mate-laptop>
In-Reply-To: <YXcrRDNylQ896ypx@pendragon.ideasonboard.com>
References: <20211025174202.32396-1-julianbraha@gmail.com> <2172694.EMfidFSxsr@ubuntu-mate-laptop> <YXcrRDNylQ896ypx@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 25, 2021 6:10:12 PM EDT you wrote:
> Hi Julian,
> 
> On Mon, Oct 25, 2021 at 02:51:47PM -0400, Julian Braha wrote:
> > On Monday, October 25, 2021 1:47:35 PM EDT you wrote:
> > > On Mon, Oct 25, 2021 at 01:42:02PM -0400, Julian Braha wrote:
> > > > When DRM_CHIPONE_ICN6211 is selected, and DRM_KMS_HELPER is not selected,
> > > > Kbuild gives the following warning:
> > > > 
> > > > WARNING: unmet direct dependencies detected for DRM_PANEL_BRIDGE
> > > >   Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && DRM_KMS_HELPER [=n]
> > > >   Selected by [y]:
> > > >   - DRM_CHIPONE_ICN6211 [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_BRIDGE [=y] && OF [=y]
> > > > 
> > > > This is because DRM_CHIPONE_ICN6211 selects DRM_PANEL_BRIDGE
> > > > without depending on or selecting DRM_KMS_HELPER,
> > > > despite DRM_PANEL_BRIDGE depending on DRM_KMS_HELPER.
> > > > 
> > > > This unmet dependency bug was detected by Kismet,
> > > > a static analysis tool for Kconfig.
> > > > Please advise if this is not the appropriate solution.
> > > 
> > > Shouldn't DRM_PANEL_BRIDGE select DRM_KMS_HELPER instead of depending on
> > > it ?
> > > 
> > > > Fixes: ce517f18944e ("drm: bridge: Add Chipone ICN6211 MIPI-DSI to RGB bridge")
> > > > Reviewed-by: Robert Foss <robert.foss@linaro.org>
> > > > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> > > > ---
> > > >  drivers/gpu/drm/bridge/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > > > index 431b6e12a81f..a630cb8fd1c8 100644
> > > > --- a/drivers/gpu/drm/bridge/Kconfig
> > > > +++ b/drivers/gpu/drm/bridge/Kconfig
> > > > @@ -30,6 +30,7 @@ config DRM_CDNS_DSI
> > > >  config DRM_CHIPONE_ICN6211
> > > >  	tristate "Chipone ICN6211 MIPI-DSI/RGB Converter bridge"
> > > >  	depends on OF
> > > > +  select DRM_KMS_HELPER
> > > >  	select DRM_MIPI_DSI
> > > >  	select DRM_PANEL_BRIDGE
> > > >  	help
> > 
> > Hi Laurent,
> > 
> > Either a "select" or a "depends" will resolve this issue,
> 
> Mixing "select" and "depends" usually lead to be results. DRM_KMS_HELPER
> is a symbol that is mostly selected (I think there are a handful of
> occurrences of "depends", which should probably be fixed).
> 
> > but most similar devices in this Kconfig file select DRM_KMS_HELPER.
> > Is there something different about DRM_CHIPONE_ICN6211 that I have missed?
> 
> There isn't anything fundamentally different, but because DRM_KMS_HELPER
> is meant to be selected and not depended on, I think we should fix that
> for DRM_PANEL_BRIDGE, and it will fix the issue with
> DRM_CHIPONE_ICN6211. The dependency on the KMS helpers come from
> drm_panel_bridge.c, not from chipone-icn6211.c as far as I can tell, so
> it would also be more correct.
> 
> 

Hi Laurent,

I appreciate your feedback! I will make your suggested change,
and resubmit.

- Julian Braha



