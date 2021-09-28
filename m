Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F46C41AF5D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240808AbhI1Muy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240685AbhI1Mux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:50:53 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE86C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:49:13 -0700 (PDT)
Received: from [IPv6:::1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 15F728312F;
        Tue, 28 Sep 2021 14:49:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1632833348;
        bh=HjmkWr+4r7r/atswVfbKvnliuyMeP34ao4ebbIjZUtM=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=IOUnQ3AXIukz2Q6cbalRMcafkhbVnnKHazpvZGHH8S8s3UisQ5pNlZLcMSlIkgQis
         LpLOZqzqcfLGef6vV0ovLFia7jJVRey1BTtYpQhuUReCDKZQ2srX2/962ii8r86Rvs
         dxEBhTY7Vx9GE1UVaCNkubjzXF00BJggQU0e31pgUHZ9RY18UMKlWT+Q3rLIiDkgox
         yz2RGAPIXUfQ8zBBAXjK3lDwIrMgQt4Avg3RpejNmAYMbwSB47TLHJQsGC97JmG7R4
         sVPCt03h45R7EQZQusYaZPZby88qY6JlHbeGto+1aW9Z87Mw9wRRCyEVne4iidRRUy
         uXxwGxkc+TDXg==
Subject: Re: [PATCH v1 2/5] drm: mxsfb: Set proper default bus format when
 using a bridge
To:     =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
References: <cover.1632828477.git.agx@sigxcpu.org>
 <1fd5457b925249bce77315663adabecdd29ec0f3.1632828477.git.agx@sigxcpu.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ondrej Jirman <megous@megous.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
From:   Marek Vasut <marex@denx.de>
Message-ID: <67e6056a-6157-795d-908d-d65cc803c03d@denx.de>
Date:   Tue, 28 Sep 2021 14:49:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1fd5457b925249bce77315663adabecdd29ec0f3.1632828477.git.agx@sigxcpu.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/21 2:16 PM, Guido Günther wrote:
> If a bridge doesn't do any bus format handling MEDIA_BUS_FMT_FIXED is
> returned. Fallback to a reasonable default (MEDIA_BUS_FMT_RGB888_1X24) in
> that case.
> 
> This unbreaks e.g. using mxsfb with the nwl bridge and mipi panels.
> 
> Fixes: b776b0f00f24 ("drm: mxsfb: Use bus_format from the nearest bridge if present")
> 
> Reported-by: Martin Kepplinger <martink@posteo.de>
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
>   drivers/gpu/drm/mxsfb/mxsfb_kms.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> index d6abd2077114..f4be16f5c20b 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> @@ -369,6 +369,11 @@ static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
>   			drm_atomic_get_new_bridge_state(state,
>   							mxsfb->bridge);
>   		bus_format = bridge_state->input_bus_cfg.format;
> +		if (bus_format == MEDIA_BUS_FMT_FIXED) {
> +			dev_warn_once(drm->dev,
> +				      "Bridge does not provide bus format. Please fix.");

Fix what ? Oh ... the bridge driver ?

Maybe such a hint should be in the warning message. And it might be 
useful to explain how to fix that bridge driver, or at least provide 
some reference to an example (like this nwl patch series).

> +			bus_format = MEDIA_BUS_FMT_RGB888_1X24;

The warning should also mention that the driver is falling back to this 
mode.
