Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D6C34344E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 20:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhCUTLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 15:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhCUTKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 15:10:45 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E94C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
        In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=q0FS/C96/vfAihejESN8OfLxNkKjCCDPfyVrgBI7WZI=; b=ktiMTTvhY/xlB5EDVdM5t2WrP9
        GEodEAO9KLkL9Bhdp16uj3q2nE2a5pvz210mI1lnpkCBuLIa/vNcZND8V4yvX6neG2ndHxHK3yT8k
        aRpX9m+SZSV85cXuuB4FGNPsYS/WEUWRfVoMiklOJ/7+YXzZf2VsbbqvkoptX1yoeSbydVM7Di+Nc
        OX2aQ18HBvs8j43RihsF7w95LEdzvCQOokzbYtoPS9Y5X0RTCZO8RIABBQ0C9nHr9r5nb9sK8k0B2
        1Zfp9lnUzKGRjKTCvMSqkxavSjcTG86m36k7/QjdQJp9aKb8055lNMQgnnxTlk96IW5ANZ+oxcFv0
        ba0ENzgw==;
Received: from webng-gw.kapsi.fi ([91.232.154.200] helo=roundcube.kapsi.fi)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <jyri.sarha@iki.fi>)
        id 1lO3TC-0006d0-Vm; Sun, 21 Mar 2021 21:10:39 +0200
MIME-Version: 1.0
Date:   Sun, 21 Mar 2021 21:10:36 +0200
From:   Jyri Sarha <jyri.sarha@iki.fi>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     tomba@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tilcdc: panel: fix platform_no_drv_owner.cocci
 warnings
In-Reply-To: <1614762267-98454-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1614762267-98454-1-git-send-email-yang.lee@linux.alibaba.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <0c5ff308f0bc71b847c805851a6f727c@iki.fi>
X-Sender: jyri.sarha@iki.fi
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.232.154.200
X-SA-Exim-Mail-From: jyri.sarha@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-03 11:04, Yang Li wrote:
> ./drivers/gpu/drm/tilcdc/tilcdc_panel.c:402:3-8: No need to set .owner
> here. The core will do it.
> 
> Remove .owner field if calls are used which set it automatically
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Jyri Sarha <jyri.sarha@iki.fi>

I'll merge this soon to drm-misc-next.

Best regards,
Jyri

> ---
>  drivers/gpu/drm/tilcdc/tilcdc_panel.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> index 00efc30..4235780 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_panel.c
> @@ -399,7 +399,6 @@ static int panel_remove(struct platform_device 
> *pdev)
>  	.probe = panel_probe,
>  	.remove = panel_remove,
>  	.driver = {
> -		.owner = THIS_MODULE,
>  		.name = "tilcdc-panel",
>  		.of_match_table = panel_of_match,
>  	},
