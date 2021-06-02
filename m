Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE763987DA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 13:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhFBLTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 07:19:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231730AbhFBLTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 07:19:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F234961159;
        Wed,  2 Jun 2021 11:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622632672;
        bh=9XgnjJyMgrfhJOYp/Bh6hZ1lr0KTwAcdyxI+kI1Tu+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jnSO0wecaOp4sz/E0D8SpdGLyiJvlk5I0nbuKmqOvyT3H792XqOo3rCcf0/NI5zRD
         OXL0tqn8R2P1tM/syGxslDIZB1BSK9diGP/BihpCD1IJXk16YhfJd8njUIvQ4oLDRp
         8C6kwsdLu2790OOPtL+t6MWgbcJiobv8UmXl9Dxuxj5n4ZQaD/431NvlmC+TCnvW9B
         YNpumYsK7Za7dIYiUEl6GBHjlQ+1COq5U5F+67WJd0lvIrpOGiSveimnGi8lgqIi+s
         oXLMPLoaZUeuPA/g4ec7srs4jJxxPAbd0wydZ4Xk7mpP9NacMcO/i6jDi48sbKbJDl
         UD5Q4e7u16LLw==
Date:   Wed, 2 Jun 2021 16:47:48 +0530
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
Message-ID: <YLdo3P94dLmUNV5B@vkoul-mobl>
References: <20210521124946.3617862-1-vkoul@kernel.org>
 <20210521124946.3617862-5-vkoul@kernel.org>
 <31b06821-a25d-7864-4e6e-448710203bef@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31b06821-a25d-7864-4e6e-448710203bef@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-05-21, 13:29, Dmitry Baryshkov wrote:
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
> > diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > index 8a10e4343281..864d3c655e73 100644
> > --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> > +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > @@ -156,6 +156,7 @@ struct msm_dsi_host {
> >   	struct regmap *sfpb;
> >   	struct drm_display_mode *mode;
> > +	struct msm_display_dsc_config *dsc;
> >   	/* connected device info */
> >   	struct device_node *device_node;
> > @@ -1744,6 +1745,168 @@ static int dsi_host_parse_lane_data(struct msm_dsi_host *msm_host,
> >   	return -EINVAL;
> >   }
> > +static u32 dsi_dsc_rc_buf_thresh[DSC_NUM_BUF_RANGES - 1] = {
> > +	0x0e, 0x1c, 0x2a, 0x38, 0x46, 0x54, 0x62,
> > +	0x69, 0x70, 0x77, 0x79, 0x7b, 0x7d, 0x7e
> > +};
> 
> I think we should move this table to a generic place. AMD and Intel DSC code
> uses the same table, shifted by 6 (and both of those drivers shift it before
> writing to the HW). Intel modifies this table for 6bpp case. AMD seems to
> use it as is.
> 
> > +
> > +/* only 8bpc, 8bpp added */
> > +static char min_qp[DSC_NUM_BUF_RANGES] = {
> > +	0, 0, 1, 1, 3, 3, 3, 3, 3, 3, 5, 5, 5, 7, 13
> > +};
> > +
> > +static char max_qp[DSC_NUM_BUF_RANGES] = {
> > +	4, 4, 5, 6, 7, 7, 7, 8, 9, 10, 11, 12, 13, 13, 15
> > +};
> > +
> > +static char bpg_offset[DSC_NUM_BUF_RANGES] = {
> > +	2, 0, 0, -2, -4, -6, -8, -8, -8, -10, -10, -12, -12, -12, -12
> > +};
> 
> And these parameters seem to be generic too. Intel DSC code contains them in
> a bit different form. Should we probably move them to the drm_dsc.c and use
> the tables the generic location?
> 
> AMD drivers uses a bit different values at the first glance, so let's stick
> with Intel version.

Yeah I think this is a good suggestion. I did look into and had this in
my todo. Yes drm_dsc.c would be apt for the move..

-- 
~Vinod
