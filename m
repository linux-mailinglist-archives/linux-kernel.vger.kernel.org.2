Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E3E455EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbhKRO44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:56:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhKRO4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:56:55 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB50C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 06:53:54 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so8397331pju.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 06:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00/NWBiXDMIwTA2wxI59iuasKKaexVRD/MgwjjpMNtY=;
        b=PQKOVFgLa4dXcJbx1KgwRmt+rTPDI0UAmCo43eoJDn0dXmS3OERtXNkwvUSDwtsexL
         4gZOC6lI9TeLsiecL0ABkcWatE90NTwp4ISl6tDiXrScVr/PcZkS4OrOr22pCgyODRaM
         sb4pPU3jkGOr0wq5XHOdRmNZ6tcbz6bA2k2jXclwOsG7AiEfvd8V3b4XWtRVpDgXdlmG
         2ju0aNbMaixRvYx3/MdF3qM9rN4d3X6J/kz0hTvTW39sgWvpoEpfGzHFixnJ/MtUBXKa
         uGCr54Q37jvDomNAzMZc8dv3z7zzzcGtm6q7AzHFEyRxEf5QjDKrO6gc7X99qaGbJA7F
         nHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00/NWBiXDMIwTA2wxI59iuasKKaexVRD/MgwjjpMNtY=;
        b=UhHXNhocMrUVNLnc9XxopAGbPZSAL7zyGBGPr/BT0CH4DaiOSUUsEH814Nmme8uhX5
         +zPOkSnog0rIk1CWAQmDGlT1qi5Kqi1eN6eJKNtR1TkEUYScIYWC8lg6lhtgqoK6N5un
         XUvqlZjOo1BBMlXIE7NlN0PGvRU+ZfPkjH8FpeZzLj/VxGBAVrBU3+1rtxXBqHM4/9rI
         vWteEdAQJMOcvgjxm1BeMtxnEzecCIqVYBcxYEJS1wgw26AR+T/Wx1G6AqwVUncDNzAD
         2UZshV+pGJlgBSnNHqJBRY2rMFiocYjdph8YaYQogesuXOG4iTtwsfqKmWrYf8d/x6xV
         IqaA==
X-Gm-Message-State: AOAM5325SOcdqIRJXFeB8RKlKAgysJdmj/BwyuthWX7s0ra7iZxclbYx
        uGwNHUfrPuRrZFwd4ai+fbD3Eu2Pgc+zW4zgxbr++A==
X-Google-Smtp-Source: ABdhPJy/yXtGCmRA0aJzW6HarUsG1nwCHbSHk0dZn1p5TvpTB66YkOcGNLY8thYYlrjSODVvyDJjR9SOcaB75LGsl9U=
X-Received: by 2002:a17:903:2443:b0:142:1e92:1d19 with SMTP id
 l3-20020a170903244300b001421e921d19mr66821454pls.24.1637247234084; Thu, 18
 Nov 2021 06:53:54 -0800 (PST)
MIME-Version: 1.0
References: <20211112112433.942075-1-hsinyi@chromium.org>
In-Reply-To: <20211112112433.942075-1-hsinyi@chromium.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Thu, 18 Nov 2021 15:53:42 +0100
Message-ID: <CAG3jFyvznd2FD7=fxkEYrck0P3iu4qyKUc326yRHN1Wf90TRXw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Fix edid_read break case in sp_tx_edid_read()
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Xin Ji <xji@analogixsemi.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Hsin-Yi,

Thanks for catching this.

checkpatch --strict is throwing an error for this patch. With that,
feel free to add my r-b.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

On Fri, 12 Nov 2021 at 12:24, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> edid_read() was assumed to return 0 on success. After
> 7f16d0f3b8e2("drm/bridge: anx7625: Propagate errors from sp_tx_rst_aux()"),
> the function can return >= 0 for successful case. Fix the g_edid_break
> condition in sp_tx_edid_read().
>
> Fixes: 7f16d0f3b8e2("drm/bridge: anx7625: Propagate errors from sp_tx_rst_aux()")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 1a871f6b6822ee..392203b576042b 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -826,7 +826,7 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
>                                 g_edid_break = edid_read(ctx, offset,
>                                                          pblock_buf);
>
> -                               if (g_edid_break)
> +                               if (g_edid_break < 0)
>                                         break;
>
>                                 memcpy(&pedid_blocks_buf[offset],
> --
> 2.34.0.rc1.387.gb447b232ab-goog
>
