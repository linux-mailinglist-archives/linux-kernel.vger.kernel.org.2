Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A1A45EB60
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353256AbhKZK2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:28:22 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48138 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347899AbhKZK0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:26:17 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3C2961F46711
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637922183; bh=tC0SyAbEYha2W5DuJX/94Auu6fwRk+YS3BdMTsOqCdQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UxZ/ODblNQq6rPMmMzGLyqXXC0AE0V/nQ+htGUUpwUEQH0D779nSlUlFsHQNi307j
         juPEvS65RPTmfd/UjwP/UH8YE8coYc2sIJxyqdvF8pIjNOCHzKrkxn0jCmZ0WAFP+e
         e7UwH6W89PnouveUvnuxq1Tf/qdVrWOmAuxVbR/j3nroA1nkkERAE8fvQZKoxygEVk
         SVhFI2B9T2F4rGPmrgf7dj7j0bcplou6T7frX3lZjBvzriKau62r6WhbtLoFVct5vZ
         Wb9bNsUUWpigBdW2bqk6rMKPiCthm6xxEUH4rrYvi6SrfNChFgKfA4B3FpGsdSmgee
         VO72zcFnUhEEQ==
Subject: Re: [PATCH v6 5/7] drm/mediatek: dpi: Add dpintf support
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211110130623.20553-1-granquet@baylibre.com>
 <20211110130623.20553-6-granquet@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <d7e5e360-0a0e-344e-0c96-8209403aad88@collabora.com>
Date:   Fri, 26 Nov 2021 11:23:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211110130623.20553-6-granquet@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/11/21 14:06, Guillaume Ranquet ha scritto:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> dpintf is the displayport interface hardware unit. This unit is similar
> to dpi and can reuse most of the code.
> 
> This patch adds support for mt8195-dpintf to this dpi driver. Main
> differences are:
>   - Some features/functional components are not available for dpintf
>     which are now excluded from code execution once is_dpintf is set
>   - dpintf can and needs to choose between different clockdividers based
>     on the clockspeed. This is done by choosing a different clock parent.
>   - There are two additional clocks that need to be managed. These are
>     only set for dpintf and will be set to NULL if not supplied. The
>     clk_* calls handle these as normal clocks then.
>   - Some register contents differ slightly between the two components. To
>     work around this I added register bits/masks with a DPINTF_ prefix
>     and use them where different.
> 
> Based on a separate driver for dpintf created by
> Jason-JH.Lin <jason-jh.lin@mediatek.com>.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>


Hello Guillaume, Markus



Strictly speaking about functionality, the entire series is totally fine,

however, I cannot give you a R-b on patches 6 and 7, since this code should

*really* make use of phy_get(), like suggested by Vinod.



In any case, for this patch:



Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

