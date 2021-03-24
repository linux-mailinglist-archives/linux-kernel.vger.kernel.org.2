Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91971347008
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 04:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbhCXDOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 23:14:43 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:51052 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbhCXDOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 23:14:25 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D6B51580;
        Wed, 24 Mar 2021 04:14:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1616555664;
        bh=sBJb6TLMoCXie6Cz1KwQP/tND9xgZh/+QqXpqwmXWOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=max4LQ1tsmmi+q0VA47yv0xGMVojlAwja6LVEHrlOSEmndQVeB7aIQ3pgKGvWXVVT
         e4DUPuelaSftaEpkAzG+hJuL+9eemD/ws871eXW3nAl+g8OwmQOFemrQX8KC5TU4rL
         Ds6vFytwO1AjhwNsxWlXH7/fPwbf/P301Ji+T94o=
Date:   Wed, 24 Mar 2021 05:13:41 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     quanyang.wang@windriver.com
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [V2][PATCH] drm: xlnx: zynqmp: release reset to DP controller
 before accessing DP registers
Message-ID: <YFquZaW4JTTM7ogS@pendragon.ideasonboard.com>
References: <20210323025501.1568039-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210323025501.1568039-1-quanyang.wang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quanyang,

Thank you for the patch.

On Tue, Mar 23, 2021 at 10:55:01AM +0800, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> When insmod zynqmp-dpsub.ko after rmmod it, system will hang with the
> error log as below:
> 
> root@xilinx-zynqmp:~# insmod zynqmp-dpsub.ko
> [   88.391289] [drm] Initialized zynqmp-dpsub 1.0.0 20130509 for fd4a0000.display on minor 0
> [   88.529906] Console: switching to colour frame buffer device 128x48
> [   88.549402] zynqmp-dpsub fd4a0000.display: [drm] fb0: zynqmp-dpsubdrm frame buffer device
> [   88.571624] zynqmp-dpsub fd4a0000.display: ZynqMP DisplayPort Subsystem driver probed
> root@xilinx-zynqmp:~# rmmod zynqmp_dpsub
> [   94.023404] Console: switching to colour dummy device 80x25
> root@xilinx-zynqmp:~# insmod zynqmp-dpsub.ko
> 	<hang here>
> 
> This is because that in zynqmp_dp_probe it tries to access some DP
> registers while the DP controller is still in the reset state. When
> running "rmmod zynqmp_dpsub", zynqmp_dp_reset(dp, true) in
> zynqmp_dp_phy_exit is called to force the DP controller into the reset
> state. Then insmod will call zynqmp_dp_probe to program the DP registers,
> but at this moment the DP controller hasn't been brought out of the reset
> state yet since the function zynqmp_dp_reset(dp, false) is called later and
> this will result the system hang.
> 
> Releasing the reset to DP controller before any read/write operation to it
> will fix this issue. And for symmetry, move zynqmp_dp_reset() call from
> zynqmp_dp_phy_exit() to zynqmp_dp_remove().
> 
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> V2:
> According to Laurent's comments:
> - add zynqmp_dp_reset(dp, true) in error path in zynqmp_dp_probe
> - move the zynqmp_dp_reset() call from zynqmp_dp_phy_exit() to zynqmp_dp_remove() 
> 
> ---
>  drivers/gpu/drm/xlnx/zynqmp_dp.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 99158ee67d02..337adf0769ad 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -402,10 +402,6 @@ static int zynqmp_dp_phy_init(struct zynqmp_dp *dp)
>  		}
>  	}
>  
> -	ret = zynqmp_dp_reset(dp, false);
> -	if (ret < 0)
> -		return ret;
> -
>  	zynqmp_dp_clr(dp, ZYNQMP_DP_PHY_RESET, ZYNQMP_DP_PHY_RESET_ALL_RESET);
>  
>  	/*
> @@ -441,8 +437,6 @@ static void zynqmp_dp_phy_exit(struct zynqmp_dp *dp)
>  				ret);
>  	}
>  
> -	zynqmp_dp_reset(dp, true);
> -
>  	for (i = 0; i < dp->num_lanes; i++) {
>  		ret = phy_exit(dp->phy[i]);
>  		if (ret)
> @@ -1682,9 +1676,13 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub, struct drm_device *drm)
>  		return PTR_ERR(dp->reset);
>  	}
>  
> +	ret = zynqmp_dp_reset(dp, false);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = zynqmp_dp_phy_probe(dp);
>  	if (ret)
> -		return ret;
> +		goto err_reset;
>  
>  	/* Initialize the hardware. */
>  	zynqmp_dp_write(dp, ZYNQMP_DP_TX_PHY_POWER_DOWN,
> @@ -1696,7 +1694,7 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub, struct drm_device *drm)
>  
>  	ret = zynqmp_dp_phy_init(dp);
>  	if (ret)
> -		return ret;
> +		goto err_reset;
>  
>  	zynqmp_dp_write(dp, ZYNQMP_DP_TRANSMITTER_ENABLE, 1);
>  
> @@ -1708,15 +1706,18 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub, struct drm_device *drm)
>  					zynqmp_dp_irq_handler, IRQF_ONESHOT,
>  					dev_name(dp->dev), dp);
>  	if (ret < 0)
> -		goto error;
> +		goto err_phy_exit;
>  
>  	dev_dbg(dp->dev, "ZynqMP DisplayPort Tx probed with %u lanes\n",
>  		dp->num_lanes);
>  
>  	return 0;
>  
> -error:
> +err_phy_exit:
>  	zynqmp_dp_phy_exit(dp);
> +err_reset:
> +	zynqmp_dp_reset(dp, true);
> +
>  	return ret;
>  }
>  
> @@ -1734,4 +1735,5 @@ void zynqmp_dp_remove(struct zynqmp_dpsub *dpsub)
>  	zynqmp_dp_write(dp, ZYNQMP_DP_INT_DS, 0xffffffff);
>  
>  	zynqmp_dp_phy_exit(dp);
> +	zynqmp_dp_reset(dp, true);
>  }

-- 
Regards,

Laurent Pinchart
