Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9A74560EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 17:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbhKRQzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 11:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhKRQzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 11:55:06 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEF1C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 08:52:06 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id q25so15723198oiw.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 08:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Md/3/5JKM+oVwuA7MgVwTq9uvS3LFmGmmFvpu2uaZik=;
        b=fj/+3S7DMb744W00SwXLVIK5nOQSESv3guuqih+RelIQ/bpTyiWCAyLOQSOjwPi/42
         zQlujAW2Yge8V1MDhzPhZND2RhySDzxgd3FZctXrbSjoOncX7Eu73soKd9at7zHyHjwm
         xoZjGgmnkJrwyVnCBkhB7gjkaoA2tPI8f88jiFyvcOh838rqQllNhTaelZxEv5BqTouD
         X/HExseYUpwzu9BqrHElSVUdv8AMTKVH6Xf27g4w+DEt8qyqGUmhkdhHkNVnrNc2FVKS
         mv8gMEayxVE8RsihX1eCkg58nZOB/R63S4SMp2uanplrtKZ0Mgn7hOpFlPjYzQ7uj/dB
         p8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Md/3/5JKM+oVwuA7MgVwTq9uvS3LFmGmmFvpu2uaZik=;
        b=TYH4sj8rYyAD+V4dOw+42YxvsmCWvaX2xFzYVRKATXAJhMuj8bc72uOjKtQXJHkX0y
         IU1PP4OY7YOA5d9NvvfaH2VkRKCpVzcSnMTpKsa4YJfaapunns+Xb3ZOloW9eVHLTK9N
         /ct/gehMCupjd9fqdRmsfZukHjQjc2OC/rY0hdxLm49SYvGQzRNPccy5CJvJjUKq3wIo
         T0ZQZzHy/6X+vUyiQ1WwzK81VqWyg1xpoksd4J46De+0OEn27BtXsDI/vcAJhER2X5mb
         G2bNG3KxbPdbJVFIzFF8QpEArT84xiZYl12eU1Q9l87WSbYCbt+WVNZ3CteFs6p7pRdk
         HVLQ==
X-Gm-Message-State: AOAM533EknH60vWdZP20ROPecLHLGaziOQtD9M0LS77t6ygKeBW6kCr9
        TgdPor9HBh3do6RY39iKGrc=
X-Google-Smtp-Source: ABdhPJwuRuQAtJTKuR72U4ZLce/J4haR8WuBB/b4O9pQAxD8GnIG++dPDeEtMkI3GrP+bTLzTeC9Xw==
X-Received: by 2002:a05:6808:1482:: with SMTP id e2mr8654698oiw.45.1637254325830;
        Thu, 18 Nov 2021 08:52:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h3sm60851ooe.13.2021.11.18.08.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 08:52:05 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 18 Nov 2021 08:52:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Fix edid_read break case in
 sp_tx_edid_read()
Message-ID: <20211118165203.GA1721588@roeck-us.net>
References: <20211112112433.942075-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112112433.942075-1-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 07:24:33PM +0800, Hsin-Yi Wang wrote:
> edid_read() was assumed to return 0 on success. After
> 7f16d0f3b8e2("drm/bridge: anx7625: Propagate errors from sp_tx_rst_aux()"),
> the function can return >= 0 for successful case. Fix the g_edid_break
> condition in sp_tx_edid_read().
> 
> Fixes: 7f16d0f3b8e2("drm/bridge: anx7625: Propagate errors from sp_tx_rst_aux()")
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 1a871f6b6822ee..392203b576042b 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -826,7 +826,7 @@ static int sp_tx_edid_read(struct anx7625_data *ctx,
>  				g_edid_break = edid_read(ctx, offset,
>  							 pblock_buf);
>  
> -				if (g_edid_break)
> +				if (g_edid_break < 0)
>  					break;

g_edid_break is declared u8 and thus never < 0. The break; statement
doesn't indicate an error but that a break was encountered, and the
value of g_edid_break == 1 is used elsewhere in the function to indicate
that condition.  It also doesn't break out of the outer loop, but only
out of the switch statement.

With this patch in place, g_edid_break will have a more or less random
value after an error, and the behavior of this function will be undefined.

Guenter
