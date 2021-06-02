Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87483987AE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhFBLI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232106AbhFBLIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:08:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F359A613B8;
        Wed,  2 Jun 2021 11:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622631997;
        bh=1pg+MG37+fS5YicaXP0xD9f9S1lKkaW87BxtuaVzwvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=abv8LMc142JlLjtSs6HPx5+vRInJT+MQ2tf/b2CPy4kexX5J5IP9ju3DxlGqsSVaq
         t2XwUHN2uF9OluciFmOeImhgMSYjN9mBeQcPXV6ryDL+X82HL9SnreYTmTBAqjRM5B
         q9vpKyjI3gp4lbYDnlIp4T5jjrznwrC8R7d8vFDNmgvdi8+CzPjYfaYNoxa8Ki2Yxy
         SFVmIpJ9gDeIodCeku8L4WwDN7P9bv+7OtZ3Ob+c6K8j6YWx0ciWAoxnWwHChMTa7I
         Axcm5C5Q0l55DxiyIMwvKIMIap2gURNPWQfT3YNur0ztEGPwT9HO5v2k1Gneq2nDjP
         iLAImxNUDVQjw==
Date:   Wed, 2 Jun 2021 16:36:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [RFC PATCH 03/13] drm/msm/dsi: add support for dsc data
Message-ID: <YLdmOibbas3xunu3@vkoul-mobl>
References: <20210521124946.3617862-1-vkoul@kernel.org>
 <20210521124946.3617862-5-vkoul@kernel.org>
 <73815f0b-b6d1-f6f3-d7aa-f77492861967@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73815f0b-b6d1-f6f3-d7aa-f77492861967@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-05-21, 02:45, Dmitry Baryshkov wrote:
> On 21/05/2021 15:49, Vinod Koul wrote:
> > DSC needs some configuration from device tree, add support to read and
> > store these params and add DSC structures in msm_drv
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >   drivers/gpu/drm/msm/dsi/dsi_host.c | 170 +++++++++++++++++++++++++++++
> >   drivers/gpu/drm/msm/msm_drv.h      |  32 ++++++
> >   2 files changed, 202 insertions(+)
> > 
> 
> 
> [skipped]
> 
> 
> >   		DRM_DEV_ERROR(dev, "%s: invalid lane configuration %d\n",
> > diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> > index 2668941df529..26661dd43936 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.h
> > +++ b/drivers/gpu/drm/msm/msm_drv.h
> > @@ -30,6 +30,7 @@
> >   #include <drm/drm_plane_helper.h>
> >   #include <drm/drm_probe_helper.h>
> >   #include <drm/drm_fb_helper.h>
> > +#include <drm/drm_dsc.h>
> >   #include <drm/msm_drm.h>
> >   #include <drm/drm_gem.h>
> > @@ -70,6 +71,16 @@ enum msm_mdp_plane_property {
> >   #define MSM_GPU_MAX_RINGS 4
> >   #define MAX_H_TILES_PER_DISPLAY 2
> > +/**
> > + * enum msm_display_compression_type - compression method used for pixel stream
> > + * @MSM_DISPLAY_COMPRESSION_NONE:	Pixel data is not compressed
> > + * @MSM_DISPLAY_COMPRESSION_DSC:	DSC compresison is used
> > + */
> > +enum msm_display_compression_type {
> > +	MSM_DISPLAY_COMPRESSION_NONE,
> > +	MSM_DISPLAY_COMPRESSION_DSC,
> > +};
> > +
> 
> Seems to be unused

Yeah this was started from downstream which used this and I seem to have
not cleared this up, thanks for pointing. Will remove..

-- 
~Vinod
