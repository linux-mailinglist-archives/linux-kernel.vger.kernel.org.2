Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9D042FEFE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 01:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbhJOXrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 19:47:04 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:20806 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbhJOXq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 19:46:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634341492; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=jJ/9pFPB6gmJ0baQgefAhJuGAxI+QH/7x+kb0x64v+I=;
 b=sv7gbHnudXLenbum8sCE5G/qT/2uHh5ejVF6tpvI2JMxXZ7FJSQ3OTXqzqEXVAt66HtOduYQ
 qQ3Phds3jmAdBsZpF11/tWkN1Ehje7zuEmla5LBDXc4u958119+hCithQ6WQNGcPJ9EJmGRz
 lPVnoVqzFIfCx/e7JkFFZwrLA0M=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 616a1265835b7947c15badcc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 15 Oct 2021 23:44:37
 GMT
Sender: abhinavk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9E6D8C4361A; Fri, 15 Oct 2021 23:44:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: abhinavk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 909C7C4338F;
        Fri, 15 Oct 2021 23:44:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 15 Oct 2021 16:44:35 -0700
From:   abhinavk@codeaurora.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kuogee Hsieh <khsieh@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [Freedreno] [PATCH] drm/msm/dp: Only create debugfs for PRIMARY
 minor
In-Reply-To: <20211015231307.1784165-1-bjorn.andersson@linaro.org>
References: <20211015231307.1784165-1-bjorn.andersson@linaro.org>
Message-ID: <48f35ef1f90bc7c23599e98a5c1e2c09@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-15 16:13, Bjorn Andersson wrote:
> dpu_kms_debugfs_init() and hence dp_debug_get() gets invoked for each
> minor being registered. But dp_debug_get() will allocate a new struct
> dp_debug for each call and this will be associated as dp->debug.
> 
> As such dp_debug will create debugfs files in both the PRIMARY and the
> RENDER minor's debugfs directory, but only the last reference will be
> remembered.
> 
> The only use of this reference today is in the cleanup path in
> dp_display_deinit_sub_modules() and the dp_debug_private object does
> outlive the debugfs entries in either case, so there doesn't seem to be
> any adverse effects of this, but per the code the current behavior is
> unexpected, so change it to only create dp_debug for the PRIMARY minor.
> 

If i understand correctly, today because of this, we get redundant 
debugfs nodes right?

/sys/kernel/debug/dri/<minor_x>/dp_debug
/sys/kernel/debug/dri/<minor_y>/dp_debug

Both of these will hold the same information as they are for the same DP 
controller right?
In that case, this is true even for the other DPU kms information too.

Why not move this check one level up to dpu_kms_debugfs_init?

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c
> b/drivers/gpu/drm/msm/dp/dp_display.c
> index 3aa67c53dbc0..06773b58bb60 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -10,6 +10,7 @@
>  #include <linux/component.h>
>  #include <linux/of_irq.h>
>  #include <linux/delay.h>
> +#include <drm/drm_file.h>
>  #include <drm/drm_panel.h>
> 
>  #include "msm_drv.h"
> @@ -1463,6 +1464,10 @@ void msm_dp_debugfs_init(struct msm_dp
> *dp_display, struct drm_minor *minor)
>  	dp = container_of(dp_display, struct dp_display_private, dp_display);
>  	dev = &dp->pdev->dev;
> 
> +	/* Only create one set of debugfs per DP instance */
> +	if (minor->type != DRM_MINOR_PRIMARY)
> +		return;
> +
>  	dp->debug = dp_debug_get(dev, dp->panel, dp->usbpd,
>  					dp->link, dp->dp_display.connector,
>  					minor);
