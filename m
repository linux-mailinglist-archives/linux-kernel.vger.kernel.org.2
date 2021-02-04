Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E9530FC4B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbhBDTLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:11:35 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:42766 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbhBDTLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:11:02 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 43447EE;
        Thu,  4 Feb 2021 20:10:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1612465816;
        bh=AgYkKVrP4DKAR+xgr3fDWPdr8Po/TcC1JbCsIsCLFyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q7l7iNVxlIO85iPTlgW3DXj+tMxwENTog2YffK6XGZYkXn+m7gDc7mn1T3mOKWNpp
         eKrDQw9yFiHrnAF+aZ2p5Fw1nTQgiBs4mW7ktyzsH2LFC8eUicvC+0rYaGH1iOTtm4
         IKY5oDxciFpreUxfz/ln6ZecdRgryRnkDNTAubtc=
Date:   Thu, 4 Feb 2021 21:09:53 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: make a const array static, makes object
 smaller
Message-ID: <YBxGgRh4ckgbI0Z/@pendragon.ideasonboard.com>
References: <20210204183344.110078-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210204183344.110078-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Thank you for the patch.

On Thu, Feb 04, 2021 at 06:33:44PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the const array frs_limits on the stack but instead make
> it static. Makes the object code smaller by 128 bytes:
> 
> Before:
>    text    data     bss     dec     hex filename
>   24845    7440      64   32349    7e5d ./drivers/gpu/drm/bridge/tc358768.o
> 
> After:
>    text    data     bss     dec     hex filename
>   24749    7408      64   32221    7ddd ./drivers/gpu/drm/bridge/tc358768.o
> 
> (gcc version 10.2.0)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/bridge/tc358768.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index 8ed8302d6bbb..2495ea46b091 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -291,7 +291,7 @@ static int tc358768_calc_pll(struct tc358768_priv *priv,
>  			     const struct drm_display_mode *mode,
>  			     bool verify_only)
>  {
> -	const u32 frs_limits[] = {
> +	static const u32 frs_limits[] = {
>  		1000000000,
>  		500000000,
>  		250000000,

-- 
Regards,

Laurent Pinchart
