Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45B3439EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 20:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhJYS5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 14:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhJYS5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 14:57:37 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78001C061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 11:55:15 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id bp7so12627072qkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 11:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HDteQAJp2aIROEGGp0KcnNgAZwd/BE0UnUAaYmDuyDM=;
        b=ltHB326iGW0+5JSm9vx48aVLM+zcn0/RuG2SV+o9FQTIEPZ7/yAzNSh8CKXBDfCBTl
         xqGKUWMDNSUovREO+v8gmoi3CxVajwIst6ajszLY53pXLfIsHAfjyTgjmfxSUmPUm2PY
         V09wsOCc/Q0pIkPdOwZUCMY/fjJeheci/TUYFe9cEajsfLQV5tpME93uxLYh/NUdx5rl
         2Dnq7nMCTxhMfhbvN0qK2xBS0JlNfdCGsQRd3gNSz0jL0GQF9YFWbfaOX7/4kr/uWmW9
         5s6q9GP7eRhEjec6ld6S/UsCUgobZyq/qdQaw7QycVa+uUnDmwQbfsz091E/G+B4OuLT
         zadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HDteQAJp2aIROEGGp0KcnNgAZwd/BE0UnUAaYmDuyDM=;
        b=m836bVh9wdcueI+mJvhH+aIT6Q+k/JuwIBipeqIlsiTMy5NrIFeK5egQoVs0lX6juP
         eKhx7XFc/E1iKZuZIJzOLis4z7Yx/kE/zRWoDyfl4FRY970tClPDCj1wKOjMpHszZwcT
         jNceC/U2eE7SNaFMGRfCXMDP8GSIhsPlYjh+RYE77SoKKczpWyj4n9fiRw3gMn6tHhVV
         r39ilDwSf/jIOGxQjWdmTh1mdrtDqwYp/qyRBgPUWLPkFagB8TVTvySV5e0+iKh9o7sc
         LVzPObMMA7mYZxxF4GyrSFnsg9gJvc+sUkGrAECwxciHx3W+BFReEsqKqJ2N/+Ibrtjh
         la1A==
X-Gm-Message-State: AOAM530u8XOd2sWi0dmPCxiGF46dol5h0s4vOPFvdrWQbMJPg83rxvke
        8L+jpl2zjEaj75EyVleDQgI=
X-Google-Smtp-Source: ABdhPJylh95SolmSbWZAYOGsLMsebWtcBCa5XKF2BX1/CRE/aPmZCyqTcJ9cM8a1LJ/VMljKaSLb3w==
X-Received: by 2002:ae9:ea19:: with SMTP id f25mr14864525qkg.341.1635188114579;
        Mon, 25 Oct 2021 11:55:14 -0700 (PDT)
Received: from ubuntu-mate-laptop.localnet ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id c6sm8998904qkg.85.2021.10.25.11.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 11:55:14 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     robert.foss@linaro.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, jonas@kwiboo.se, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, jagan@amarulasolutions.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: bridge: fix unmet dependency on DRM_KMS_HELPER for DRM_PANEL_BRIDGE
Date:   Mon, 25 Oct 2021 14:51:47 -0400
Message-ID: <2172694.EMfidFSxsr@ubuntu-mate-laptop>
In-Reply-To: <YXbtt2M+I41qH2ME@pendragon.ideasonboard.com>
References: <20211025174202.32396-1-julianbraha@gmail.com> <YXbtt2M+I41qH2ME@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, October 25, 2021 1:47:35 PM EDT you wrote:
> Hi Julian,
> 
> Thank you for the patch.
> 
> On Mon, Oct 25, 2021 at 01:42:02PM -0400, Julian Braha wrote:
> > When DRM_CHIPONE_ICN6211 is selected, and DRM_KMS_HELPER is not selected,
> > Kbuild gives the following warning:
> > 
> > WARNING: unmet direct dependencies detected for DRM_PANEL_BRIDGE
> >   Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && DRM_KMS_HELPER [=n]
> >   Selected by [y]:
> >   - DRM_CHIPONE_ICN6211 [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_BRIDGE [=y] && OF [=y]
> > 
> > This is because DRM_CHIPONE_ICN6211 selects DRM_PANEL_BRIDGE
> > without depending on or selecting DRM_KMS_HELPER,
> > despite DRM_PANEL_BRIDGE depending on DRM_KMS_HELPER.
> > 
> > This unmet dependency bug was detected by Kismet,
> > a static analysis tool for Kconfig.
> > Please advise if this is not the appropriate solution.
> 
> Shouldn't DRM_PANEL_BRIDGE select DRM_KMS_HELPER instead of depending on
> it ?
> 
> > Fixes: ce517f18944e ("drm: bridge: Add Chipone ICN6211 MIPI-DSI to RGB bridge")
> > Reviewed-by: Robert Foss <robert.foss@linaro.org>
> > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> > index 431b6e12a81f..a630cb8fd1c8 100644
> > --- a/drivers/gpu/drm/bridge/Kconfig
> > +++ b/drivers/gpu/drm/bridge/Kconfig
> > @@ -30,6 +30,7 @@ config DRM_CDNS_DSI
> >  config DRM_CHIPONE_ICN6211
> >  	tristate "Chipone ICN6211 MIPI-DSI/RGB Converter bridge"
> >  	depends on OF
> > +  select DRM_KMS_HELPER
> >  	select DRM_MIPI_DSI
> >  	select DRM_PANEL_BRIDGE
> >  	help
> 
> 

Hi Laurent,

Either a "select" or a "depends" will resolve this issue, but
most similar devices in this Kconfig file select DRM_KMS_HELPER.
Is there something different about DRM_CHIPONE_ICN6211 that I have missed?

- Julian Braha



