Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC59366C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242606AbhDUNVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:21:00 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33230 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbhDUNRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:17:47 -0400
Received: from maud (unknown [IPv6:2600:8800:8c03:4000::11ea])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B8F551F42E3B;
        Wed, 21 Apr 2021 14:17:09 +0100 (BST)
Date:   Wed, 21 Apr 2021 09:17:04 -0400
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        fshao@chromium.org, hsinyi@chromium.org, hoegsberg@chromium.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        boris.brezillon@collabora.com, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v13 4/4] drm/panfrost: Add mt8183-mali compatible string
Message-ID: <YIAl0HRoAKD58C0R@maud>
References: <20210421052855.1279713-1-drinkcat@chromium.org>
 <20210421132841.v13.4.I5f6b04431828ec9c3e41e65f3337cec6a127480d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421132841.v13.4.I5f6b04431828ec9c3e41e65f3337cec6a127480d@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not that you need it but this patch is Reviewed-by: Alyssa Rosenzweig
<alyssa.rosenzweig@collabora.com>

On Wed, Apr 21, 2021 at 01:28:55PM +0800, Nicolas Boichat wrote:
> Add support for MT8183's G72 Bifrost.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>
> ---
> 
> (no changes since v7)
> 
> Changes in v7:
>  - Fix GPU ID in commit message
> 
> Changes in v6:
>  - Context conflicts, reflow the code.
>  - Use ARRAY_SIZE for power domains too.
> 
> Changes in v5:
>  - Change power domain name from 2d to core2.
> 
> Changes in v4:
>  - Add power domain names.
> 
> Changes in v3:
>  - Match mt8183-mali instead of bifrost, as we require special
>    handling for the 2 regulators and 3 power domains.
> 
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 83a461bdeea8..ca07098a6141 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -665,6 +665,15 @@ static const struct panfrost_compatible amlogic_data = {
>  	.vendor_quirk = panfrost_gpu_amlogic_quirk,
>  };
>  
> +const char * const mediatek_mt8183_supplies[] = { "mali", "sram" };
> +const char * const mediatek_mt8183_pm_domains[] = { "core0", "core1", "core2" };
> +static const struct panfrost_compatible mediatek_mt8183_data = {
> +	.num_supplies = ARRAY_SIZE(mediatek_mt8183_supplies),
> +	.supply_names = mediatek_mt8183_supplies,
> +	.num_pm_domains = ARRAY_SIZE(mediatek_mt8183_pm_domains),
> +	.pm_domain_names = mediatek_mt8183_pm_domains,
> +};
> +
>  static const struct of_device_id dt_match[] = {
>  	/* Set first to probe before the generic compatibles */
>  	{ .compatible = "amlogic,meson-gxm-mali",
> @@ -681,6 +690,7 @@ static const struct of_device_id dt_match[] = {
>  	{ .compatible = "arm,mali-t860", .data = &default_data, },
>  	{ .compatible = "arm,mali-t880", .data = &default_data, },
>  	{ .compatible = "arm,mali-bifrost", .data = &default_data, },
> +	{ .compatible = "mediatek,mt8183-mali", .data = &mediatek_mt8183_data },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, dt_match);
> -- 
> 2.31.1.368.gbe11c130af-goog
> 
