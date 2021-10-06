Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B5E4235B1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 04:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbhJFCJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 22:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbhJFCJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 22:09:20 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81614C06174E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 19:07:29 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so1256275ota.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 19:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CrVBBqJo2epRhzfOSwmtPnE+jaau9WoqXfOx/wMgsG8=;
        b=XbZBV5L4bjbORSuP6sKW8LZqAJvVAIDHLzU/TbhCcS7uG1tpd42wSTEISVOj5ycNUg
         8qVuRPT0Hrdh+8Z+sam3k/QzD3vLhQW91iZ7LN6dwSDuE1fKmKdBScflKyg6VEmBgoas
         HccR/FDxImnhwJ7Hx9GLspv718ofYoNRuaPeYFIGUk39m+/SGTI/+MDkzpj1ly5heEcs
         48zUxUpzTpbmdD1wUe91Jkb0erjJKdCkNv6m7jdHBP+BJQbKpoDKBQ92Rtrg8qLZmo0C
         gEsW0E9e7RNzQiUOJQLt1Xgc4r76hsATBe0AJgYlGnmqRxxioICuv01XuALY4K7CUfGl
         pSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CrVBBqJo2epRhzfOSwmtPnE+jaau9WoqXfOx/wMgsG8=;
        b=zXJxbmqkJXigqIuTuw6z51OZaEeAip190lNB8jEIue9epELUztxusntiRA5qhtTi8W
         IuzthPe+lqxHnb/K68WJ2wHoP3vGU30TksrMXGW6C6vWhlK/SkPhNzhbEV7YRQAxInC2
         eCPHq9SvRg/8bFYP9QCn4VyxQ7XRzl3EB+O5qiNLw7Wjnsz9Fe8lkU+VgFBFL/fwjOc1
         S9TbqNHzLzOQ9iw1/ThPLoBKJZDs3QOQWCcdBVG0ruu7SMQIPgZiJ/ImffMtZvHa4S3K
         4WBtv9T8I0J1V+ar0XV7U4IJHg/RE80hXiDlQ4LfFakSyBRmtoxvP+UWxPEE7zbgWBdx
         eyew==
X-Gm-Message-State: AOAM5309D2fJ1HFYooBWi/GEZJ82gQS1NCzRr6R9UOXHMKeU6Wkk2Kv3
        IuRs28hr9m/+nUBG+yUKaKgYZ2fXQHtHrw==
X-Google-Smtp-Source: ABdhPJx88dIjAmyxt4ncghxAx5jtIdZezVOwche/I29Oe8a3F45UAWCyjpVl6EPrdFMAZgOWKhTdPg==
X-Received: by 2002:a05:6830:165a:: with SMTP id h26mr17831844otr.301.1633486048693;
        Tue, 05 Oct 2021 19:07:28 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id v1sm3861969otj.70.2021.10.05.19.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 19:07:28 -0700 (PDT)
Date:   Tue, 5 Oct 2021 19:09:10 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     abhinavk@codeaurora.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [Freedreno] [PATCH v4 4/7] drm/msm/dp: Allow attaching a
 drm_panel
Message-ID: <YV0FRvYS8vQYKLI2@ripper>
References: <20211005231323.2663520-1-bjorn.andersson@linaro.org>
 <20211005231323.2663520-5-bjorn.andersson@linaro.org>
 <28fbd8f5b2d6bae7bedfc7e81e3fddd9@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28fbd8f5b2d6bae7bedfc7e81e3fddd9@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05 Oct 17:35 PDT 2021, abhinavk@codeaurora.org wrote:

> Hi Bjorn
> 
> On 2021-10-05 16:13, Bjorn Andersson wrote:
> > eDP panels might need some power sequencing and backlight management,
> > so make it possible to associate a drm_panel with an eDP instance and
> > prepare and enable the panel accordingly.
> > 
> > Now that we know which hardware instance is DP and which is eDP,
> > parser->parse() is passed the connector_type and the parser is limited
> > to only search for a panel in the eDP case.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v3:
> > - Previously posted separately, now added to series
> > - Make the search for a panel conditional on it being an eDP connector
> > - Move the search to of_graph port 1 (was 2 to distinguish from DP
> > link to USB-C connector)
> > 
> >  drivers/gpu/drm/msm/dp/dp_display.c |  9 ++++++---
> >  drivers/gpu/drm/msm/dp/dp_display.h |  1 +
> >  drivers/gpu/drm/msm/dp/dp_drm.c     | 11 +++++++++++
> >  drivers/gpu/drm/msm/dp/dp_parser.c  | 30 ++++++++++++++++++++++++++++-
> >  drivers/gpu/drm/msm/dp/dp_parser.h  |  3 ++-
> >  5 files changed, 49 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.c
> > b/drivers/gpu/drm/msm/dp/dp_display.c
> > index eaf08f9e7d87..bdaf227f05dc 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_display.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/component.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/delay.h>
> > +#include <drm/drm_panel.h>
> > 
> >  #include "msm_drv.h"
> >  #include "msm_kms.h"
> > @@ -230,12 +231,14 @@ static int dp_display_bind(struct device *dev,
> > struct device *master,
> >  	priv = drm->dev_private;
> >  	priv->dp = &(dp->dp_display);
> > 
> > -	rc = dp->parser->parse(dp->parser);
> > +	rc = dp->parser->parse(dp->parser, dp->dp_display.connector_type);
> >  	if (rc) {
> >  		DRM_ERROR("device tree parsing failed\n");
> >  		goto end;
> >  	}
> > 
> > +	dp->dp_display.panel_bridge = dp->parser->panel_bridge;
> > +
> >  	dp->aux->drm_dev = drm;
> >  	rc = dp_aux_register(dp->aux);
> >  	if (rc) {
> > @@ -822,7 +825,7 @@ static int dp_display_set_mode(struct msm_dp
> > *dp_display,
> >  	return 0;
> >  }
> > 
> > -static int dp_display_prepare(struct msm_dp *dp)
> > +static int dp_display_prepare(struct msm_dp *dp_display)
> >  {
> >  	return 0;
> >  }
> > @@ -896,7 +899,7 @@ static int dp_display_disable(struct
> > dp_display_private *dp, u32 data)
> >  	return 0;
> >  }
> > 
> > -static int dp_display_unprepare(struct msm_dp *dp)
> > +static int dp_display_unprepare(struct msm_dp *dp_display)
> >  {
> >  	return 0;
> >  }
> > diff --git a/drivers/gpu/drm/msm/dp/dp_display.h
> > b/drivers/gpu/drm/msm/dp/dp_display.h
> > index 02999408c052..24aefca66029 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_display.h
> > +++ b/drivers/gpu/drm/msm/dp/dp_display.h
> > @@ -15,6 +15,7 @@ struct msm_dp {
> >  	struct device *codec_dev;
> >  	struct drm_connector *connector;
> >  	struct drm_encoder *encoder;
> > +	struct drm_bridge *panel_bridge;
> >  	bool is_connected;
> >  	bool audio_enabled;
> >  	bool power_on;
> > diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c
> > b/drivers/gpu/drm/msm/dp/dp_drm.c
> > index f33e31523f56..76856c4ee1d6 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> > @@ -5,6 +5,7 @@
> > 
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_atomic.h>
> > +#include <drm/drm_bridge.h>
> >  #include <drm/drm_crtc.h>
> > 
> >  #include "msm_drv.h"
> > @@ -160,5 +161,15 @@ struct drm_connector
> > *dp_drm_connector_init(struct msm_dp *dp_display)
> > 
> >  	drm_connector_attach_encoder(connector, dp_display->encoder);
> > 
> > +	if (dp_display->panel_bridge) {
> > +		ret = drm_bridge_attach(dp_display->encoder,
> > +					dp_display->panel_bridge, NULL,
> > +					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> > +		if (ret < 0) {
> > +			DRM_ERROR("failed to attach panel bridge: %d\n", ret);
> > +			return ERR_PTR(ret);
> > +		}
> > +	}
> > +
> >  	return connector;
> >  }
> > diff --git a/drivers/gpu/drm/msm/dp/dp_parser.c
> > b/drivers/gpu/drm/msm/dp/dp_parser.c
> > index 4d6e047f803d..eb6bbfbea484 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_parser.c
> > +++ b/drivers/gpu/drm/msm/dp/dp_parser.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/of_gpio.h>
> >  #include <linux/phy/phy.h>
> > 
> > +#include <drm/drm_of.h>
> >  #include <drm/drm_print.h>
> > 
> >  #include "dp_parser.h"
> > @@ -263,7 +264,28 @@ static int dp_parser_clock(struct dp_parser
> > *parser)
> >  	return 0;
> >  }
> > 
> > -static int dp_parser_parse(struct dp_parser *parser)
> > +static int dp_parser_find_panel(struct dp_parser *parser)
> > +{
> > +	struct device *dev = &parser->pdev->dev;
> > +	struct drm_panel *panel;
> > +	int rc;
> > +
> > +	rc = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &panel, NULL);
> > +	if (rc) {
> > +		DRM_ERROR("failed to acquire DRM panel: %d\n", rc);
> > +		return rc;
> > +	}
> > +
> > +	parser->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
> > +	if (IS_ERR(parser->panel_bridge)) {
> > +		DRM_ERROR("failed to create panel bridge\n");
> > +		return PTR_ERR(parser->panel_bridge);
> > +	}
> 
> When we add a bridge using devm_drm_panel_bridge_add(), it will register
> with default bridge functions which is fine
> because we need the panel power to be controlled here.
> 
> 
> 140 static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
> 141 	.attach = panel_bridge_attach,
> 142 	.detach = panel_bridge_detach,
> 143 	.pre_enable = panel_bridge_pre_enable,
> 144 	.enable = panel_bridge_enable,
> 145 	.disable = panel_bridge_disable,
> 146 	.post_disable = panel_bridge_post_disable,
> 147 	.get_modes = panel_bridge_get_modes,
> 
> But what about the EDID related things, the DP/eDP driver already reads the
> EDID and gets the modes so we need to skip
> that in this case as otherwise it will end up calling the panel_get_modes in
> the eDP panel which will be redundant.
> 
> Let me know if I am missing something in this proposal.
> 

I'm slightly lost when it comes to these types, so can you please help
me understand why the panel_bridge_bridge_funcs->get_modes() would be
invoked with the proposed patches.

Because adding a log print in panel_bridge_get_modes() shows that it's
not invoked.


So I think we have the opposite problem, rather than having two
redundant get_modes we only support relying on the EDID information
directly in the DP driver, at this point.

So unless I'm missing something critical, this works and provides panel
and backlight controls and the additional work to move the EDID read out
to the panel driver would better be done after this initial support
lands?

Regards,
Bjorn

> > +
> > +	return 0;
> > +}
> > +
> > +static int dp_parser_parse(struct dp_parser *parser, int
> > connector_type)
> >  {
> >  	int rc = 0;
> > 
> > @@ -284,6 +306,12 @@ static int dp_parser_parse(struct dp_parser
> > *parser)
> >  	if (rc)
> >  		return rc;
> > 
> > +	if (connector_type == DRM_MODE_CONNECTOR_eDP) {
> > +		rc = dp_parser_find_panel(parser);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> >  	/* Map the corresponding regulator information according to
> >  	 * version. Currently, since we only have one supported platform,
> >  	 * mapping the regulator directly.
> > diff --git a/drivers/gpu/drm/msm/dp/dp_parser.h
> > b/drivers/gpu/drm/msm/dp/dp_parser.h
> > index dac10923abde..3172da089421 100644
> > --- a/drivers/gpu/drm/msm/dp/dp_parser.h
> > +++ b/drivers/gpu/drm/msm/dp/dp_parser.h
> > @@ -123,8 +123,9 @@ struct dp_parser {
> >  	struct dp_display_data disp_data;
> >  	const struct dp_regulator_cfg *regulator_cfg;
> >  	u32 max_dp_lanes;
> > +	struct drm_bridge *panel_bridge;
> > 
> > -	int (*parse)(struct dp_parser *parser);
> > +	int (*parse)(struct dp_parser *parser, int connector_type);
> >  };
> > 
> >  /**
