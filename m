Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD0533DED7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 21:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbhCPUdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 16:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhCPUc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 16:32:59 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE58DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 13:32:58 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7CCEAD8B;
        Tue, 16 Mar 2021 21:32:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1615926776;
        bh=k8tM2NOiK7JhC0RBT3aIvWY7N+SOv2q0Ygeh8ZxmVgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZTzTvYeM+dB5B60dksSpa+fn2RM+0k4ySkkysvbX+Tv8Qy/f9uzFIG+wqFIGGVpd
         TEPzHoJu9vDzN2aVAvvKjqOzgQaD0jA177OSiT3JJfXs7s6Qp2R1697Mt5KfSfoDwq
         +Bv2Jd6lpWoTfVv45j2RH/OOYwdCb3USFDETF+Os=
Date:   Tue, 16 Mar 2021 22:32:21 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     quanyang.wang@windriver.com
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: xlnx: call pm_runtime_get_sync before setting pixel
 clock
Message-ID: <YFEV1ehZfivgBoKn@pendragon.ideasonboard.com>
References: <20210310045945.3034364-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210310045945.3034364-1-quanyang.wang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quanyang,

Thank you for the patch.

On Wed, Mar 10, 2021 at 12:59:45PM +0800, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> The Runtime PM subsystem will force the device "fd4a0000.zynqmp-display"
> to enter suspend state while booting if the following conditions are met:
> - the usage counter is zero (pm_runtime_get_sync hasn't been called yet)
> - no 'active' children (no zynqmp-dp-snd-xx node under dpsub node)
> - no other device in the same power domain (dpdma node has no
> 		"power-domains = <&zynqmp_firmware PD_DP>" property)
> 
> So there is a scenario as below:
> 1) DP device enters suspend state   <- call zynqmp_gpd_power_off
> 2) zynqmp_disp_crtc_setup_clock	    <- configurate register VPLL_FRAC_CFG
> 3) pm_runtime_get_sync		    <- call zynqmp_gpd_power_on and clear previous
> 				       VPLL_FRAC_CFG configuration
> 4) clk_prepare_enable(disp->pclk)   <- enable failed since VPLL_FRAC_CFG
> 				       configuration is corrupted
> 
> From above, we can see that pm_runtime_get_sync may clear register
> VPLL_FRAC_CFG configuration and result the failure of clk enabling.
> Putting pm_runtime_get_sync at the very beginning of the function
> zynqmp_disp_crtc_atomic_enable can resolve this issue.

Isn't this an issue in the firmware though, which shouldn't clear the
previous VPLLF_FRAC_CFG ?

> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>

Nonetheless, this change looks good to me, I actually had the same patch
in my tree while investigation issues related to the clock rate, so

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I was hoping it would solve the issue I'm experiencing with the DP
clock, but that's not the case :-( In a nutshell, when the DP is first
started, the clock frequency is incorrect. The following quick & dirty
patch fixes the problem:

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 74ac0a064eb5..fdbe1b0640aa 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -1439,6 +1439,10 @@ zynqmp_disp_crtc_atomic_enable(struct drm_crtc *crtc,

 	pm_runtime_get_sync(disp->dev);

+	ret = clk_prepare_enable(disp->pclk);
+	if (!ret)
+		clk_disable_unprepare(disp->pclk);
+
 	zynqmp_disp_crtc_setup_clock(crtc, adjusted_mode);

 	ret = clk_prepare_enable(disp->pclk);

The problem doesn't seem to be in the kernel, but on the TF-A or PMU
firmware side. Have you experienced this by any chance ?

> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index 148add0ca1d6..909e6c265406 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -1445,9 +1445,10 @@ zynqmp_disp_crtc_atomic_enable(struct drm_crtc *crtc,
>  	struct drm_display_mode *adjusted_mode = &crtc->state->adjusted_mode;
>  	int ret, vrefresh;
>  
> +	pm_runtime_get_sync(disp->dev);
> +
>  	zynqmp_disp_crtc_setup_clock(crtc, adjusted_mode);
>  
> -	pm_runtime_get_sync(disp->dev);
>  	ret = clk_prepare_enable(disp->pclk);
>  	if (ret) {
>  		dev_err(disp->dev, "failed to enable a pixel clock\n");

-- 
Regards,

Laurent Pinchart
