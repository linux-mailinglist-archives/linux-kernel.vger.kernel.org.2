Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2538C41AB84
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbhI1JKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:10:43 -0400
Received: from phobos.denx.de ([85.214.62.61]:33960 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239712AbhI1JKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:10:42 -0400
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2EC8D82E88;
        Tue, 28 Sep 2021 11:08:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1632820140;
        bh=I1ENllMnE/kun7HNTxG3cN2RKJcBJbIGHuLqvk8y4vM=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=EoP2uEmArfCpIqIL5Y6NKNiBDFYD6nEezc4n4atw2Vcqapa7DSzlO1B3aFuu45N4f
         2lr+B0yTuVtLWFyvY5Fyc/BvnFzBesOO/yC4cNYSTTBWJiKNrgvixZl3Xkd9FBd2LX
         XQqkwfwCNAmjV7JiGN5wAzGoTtlcGdoyd2bM4v5WB7F0B7gYTqYOXNvfZO4SQBrr8T
         qZB3xRWFx46orY35lP9/uAkOx3310rGpdjM7HbDOD0zMHuTfsGyZzm8dI3+mPg/bCF
         92jMuoPfYb2pV/xw32vprhUfKnrXb3411TYX37dTR/e9sYGCc7b9M0YKx9Anpyt18G
         xRk054C5OB/fw==
Subject: Re: [PATCH] drm: mxsfb: Set proper default bus format when using a
 bridge
To:     =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>
References: <YVLYh/SgBritG/RJ@qwark.sigxcpu.org>
Cc:     Stefan Agner <stefan@agner.ch>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <1fda3b80-7df2-2ce3-b049-6773e849e9dc@denx.de>
Date:   Tue, 28 Sep 2021 11:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVLYh/SgBritG/RJ@qwark.sigxcpu.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/21 10:55 AM, Guido Günther wrote:
> If a bridge doesn't do any bus format handling MEDIA_BUS_FMT_FIXED is
> returned. Fallback to a reasonable default (MEDIA_BUS_FMT_RGB888_1X24) in
> that case.
> 
> This unbreaks e.g. using mxsfb with the nwl bridge and mipi panels.
> 
> Fixes: b776b0f00f24 ("drm: mxsfb: Use bus_format from the nearest bridge if present")
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> ---
> 
> I'll look at what needs to be done in nwl separately but this also
> unbreaks other bridge seupts that don't to format negotiation yet.
> 
>   drivers/gpu/drm/mxsfb/mxsfb_kms.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> index af6c620adf6e..4ef94cf686b0 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> @@ -369,6 +369,8 @@ static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
>   			drm_atomic_get_new_bridge_state(state,
>   							mxsfb->bridge);
>   		bus_format = bridge_state->input_bus_cfg.format;
> +		if (bus_format == MEDIA_BUS_FMT_FIXED)
> +			bus_format = MEDIA_BUS_FMT_RGB888_1X24;

Shouldn't the NWL bridge return the correct format ?
