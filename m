Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C59447C91
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbhKHJOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 04:14:09 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:23213 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235636AbhKHJOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 04:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636362682; x=1667898682;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GKmvQ0YzJVJJf3GiuzIdaQ3zB09E/HmPpB23h9p8LjM=;
  b=hUh1Anmz+eRrV9E0j1jPIRRet6HJR29ImAA6UqIOXpNkxMvBPnU0r4sr
   o6DAW4QNMo4o8HqGWubOmL9qwWkb2dv4jc3LjHEEoHvKINJuLfLBLbx1U
   4hGWrxvjS9H0QMK0+2Z3mWLTkdY7LCiSE4DcGh6iuLsCdnanjVq5CoD9j
   9tY0bvdQqR6xK8mKrTFWwcTYzDJbBELs7pytgCVEFWhbsBz7/kujSnQCU
   pgc5xbhvkYoJ7pLHpM8QaanChIPDTPoDfzN00cos1k3vBeU69I0tnZW+4
   CPvBTqpwaobX9+N6vTKwLm/AC2MSl+DFuQp6yGfY/gR5g1E/eo5idDhuV
   w==;
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="20371389"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Nov 2021 10:11:21 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 08 Nov 2021 10:11:21 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 08 Nov 2021 10:11:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1636362681; x=1667898681;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GKmvQ0YzJVJJf3GiuzIdaQ3zB09E/HmPpB23h9p8LjM=;
  b=QVahdumsgc6ZJyUvXE9Fu8r0hvL9dsIJFuSxwhsBa6Hgrvn+VyXZLubr
   87lYxGSmVn4653i1H9auI0JzWhFGqC5Vks2nR6JKMfQtCLO7di1eTe/MT
   h5L4CyTTswijEO9hH/UypwMui8ZRoIYnbeTSlqg7lqms5P4LdSa1PsQYY
   0hP7jdQxIUpTJ/+XJGskqR1GCG+M3bN3R27fb3dvNfM2FiZMyKXgCmiMZ
   boQfjePPflbYu4cZC0IkDL/qpS9UQnPCPWWxT8ZpiOa9yczSYm7EfHLid
   UcHJuj7Fke0KpMUdIn/aRvTwsFo31guFH42ld/TXGyySqtLdMq+Pj8Ash
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="20371388"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Nov 2021 10:11:21 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id ACF50280065;
        Mon,  8 Nov 2021 10:11:21 +0100 (CET)
Message-ID: <ab3c62c9b4fa8f4507050a4b329ea30d9c7dcddb.camel@ew.tq-group.com>
Subject: Re: [PATCH v2] drm: fsl-dcu: enable PIXCLK on LS1021A
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Nov 2021 10:11:21 +0100
In-Reply-To: <20211005141041.2988-1-matthias.schiffer@ew.tq-group.com>
References: <20211005141041.2988-1-matthias.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-05 at 16:10 +0200, Matthias Schiffer wrote:
> The PIXCLK needs to be enabled in SCFG before accessing the DCU on LS1021A,
> or the access will hang.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Hi,
what is the status of this patch? I found it "archived" in the dri-
devel patchwork, should I be looking somewhere else?




> ---
> 
> v2:
> - rebase
> - remove unnecessary argument of fsl_dcu_scfg_config_ls1021a()
> 
> 
>  drivers/gpu/drm/fsl-dcu/Kconfig           |  1 +
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c | 25 +++++++++++++++++++++++
>  drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h |  3 +++
>  3 files changed, 29 insertions(+)
> 
> diff --git a/drivers/gpu/drm/fsl-dcu/Kconfig b/drivers/gpu/drm/fsl-dcu/Kconfig
> index d7dd8ba90e3a..9e5a35e7c00c 100644
> --- a/drivers/gpu/drm/fsl-dcu/Kconfig
> +++ b/drivers/gpu/drm/fsl-dcu/Kconfig
> @@ -8,6 +8,7 @@ config DRM_FSL_DCU
>  	select DRM_PANEL
>  	select REGMAP_MMIO
>  	select VIDEOMODE_HELPERS
> +	select MFD_SYSCON if SOC_LS1021A
>  	help
>  	  Choose this option if you have an Freescale DCU chipset.
>  	  If M is selected the module will be called fsl-dcu-drm.
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> index 660fe573db96..b6b1cb75fc41 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> @@ -50,6 +50,23 @@ static const struct regmap_config fsl_dcu_regmap_config = {
>  	.volatile_reg = fsl_dcu_drm_is_volatile_reg,
>  };
>  
> +static int fsl_dcu_scfg_config_ls1021a(void)
> +{
> +	struct regmap *scfg;
> +
> +	scfg = syscon_regmap_lookup_by_compatible("fsl,ls1021a-scfg");
> +	if (IS_ERR(scfg))
> +		return PTR_ERR(scfg);
> +
> +	/*
> +	 * For simplicity, enable the PIXCLK unconditionally. It might
> +	 * be possible to disable the clock in PM or on unload as a future
> +	 * improvement.
> +	 */
> +	return regmap_update_bits(scfg, SCFG_PIXCLKCR, SCFG_PIXCLKCR_PXCEN,
> +				  SCFG_PIXCLKCR_PXCEN);
> +}
> +
>  static void fsl_dcu_irq_reset(struct drm_device *dev)
>  {
>  	struct fsl_dcu_drm_device *fsl_dev = dev->dev_private;
> @@ -108,6 +125,14 @@ static int fsl_dcu_load(struct drm_device *dev, unsigned long flags)
>  		return ret;
>  	}
>  
> +	if (of_device_is_compatible(fsl_dev->np, "fsl,ls1021a-dcu")) {
> +		ret = fsl_dcu_scfg_config_ls1021a();
> +		if (ret < 0) {
> +			dev_err(dev->dev, "failed to enable pixclk\n");
> +			goto done_vblank;
> +		}
> +	}
> +
>  	ret = drm_vblank_init(dev, dev->mode_config.num_crtc);
>  	if (ret < 0) {
>  		dev_err(dev->dev, "failed to initialize vblank\n");
> diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> index e2049a0e8a92..566396013c04 100644
> --- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> @@ -160,6 +160,9 @@
>  #define FSL_DCU_ARGB4444		12
>  #define FSL_DCU_YUV422			14
>  
> +#define SCFG_PIXCLKCR			0x28
> +#define SCFG_PIXCLKCR_PXCEN		BIT(31)
> +
>  #define VF610_LAYER_REG_NUM		9
>  #define LS1021A_LAYER_REG_NUM		10
>  

