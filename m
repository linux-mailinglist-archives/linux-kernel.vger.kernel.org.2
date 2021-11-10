Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6F644C1CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 14:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhKJNFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 08:05:09 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33180 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhKJNFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 08:05:08 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: dafna)
        with ESMTPSA id C97371F45597
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1636549340; bh=ErvxNUWA0REJ9i7yu5E9ch2/zI4aNi+H1FtFhszYxCU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Rl32QoZdJoq1jrOWWYZa33XgRssbyOydx6xd6dMtNNJ2UzT7z2O9KQjcHFDhhWQYw
         yV2NNImuezONHu5VKY8DKRQRWZioTnuDXlip3c+EV8HN56nRoHjuqCBL6YVQmB6Z42
         g5WMif+TKBWr2fQMMD4EH9HeIkb6AU/4jOBU9itrHwUfN9j3DRyupyadbaVr1rJ7gN
         iOjW+nYibc1RsD2D4DRq5hzApS6qfITJ27zb46C8FvXlyoPBg1HAEgM7qVPB1hm0zV
         8xEPwqdAEQyyg7Z8Q2vqLsdUpYUEKlAHvWTPLjHDXgJCYbFg0TG6ANfoSdEW9M0WGq
         knostVF9UGwNQ==
Subject: Re: [PATCH] drm/bridge: parade-ps8640: Assign drm_device to dp aux
 channel
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, a.hajda@samsung.com
Cc:     narmstrong@baylibre.com, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org
References: <20211104102035.243305-1-angelogioacchino.delregno@collabora.com>
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Message-ID: <feb2ebef-5859-db38-8243-a4396770d736@collabora.com>
Date:   Wed, 10 Nov 2021 15:02:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211104102035.243305-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04.11.21 12:20, AngeloGioacchino Del Regno wrote:
> As it was done with other bridge drivers and to solve a warning coming
> from drm_dp_aux_register(), add a backpointer to drm_device in the
> drm_dp_aux that we're registering.
> 

it is common to dump the exact warning in the commit log so people can locate it later.
Maybe also add 'Fixes' tag?

apart of that

Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>


> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   drivers/gpu/drm/bridge/parade-ps8640.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
> index 191cc196c9d1..20d8e606d543 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -455,6 +455,7 @@ static int ps8640_bridge_attach(struct drm_bridge *bridge,
>   		goto err_dsi_attach;
>   	}
>   
> +	ps_bridge->aux.drm_dev = bridge->dev;
>   	ret = drm_dp_aux_register(&ps_bridge->aux);
>   	if (ret) {
>   		dev_err(dev, "failed to register DP AUX channel: %d\n", ret);
> 
