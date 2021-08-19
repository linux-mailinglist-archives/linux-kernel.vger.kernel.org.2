Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF3B3F1AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 15:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240175AbhHSNwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 09:52:04 -0400
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:46198 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238498AbhHSNwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 09:52:03 -0400
Received: from omf01.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id D56531801BD9B;
        Thu, 19 Aug 2021 13:51:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id ED88A17276;
        Thu, 19 Aug 2021 13:51:24 +0000 (UTC)
Message-ID: <0a2ea4e54d7bfd61b45cc070eee6b62e8da82190.camel@perches.com>
Subject: Re: [PATCH] drm/bridge/tc358767: make the array ext_div static
 const, makes object smaller
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 19 Aug 2021 06:51:23 -0700
In-Reply-To: <20210819133839.10745-1-colin.king@canonical.com>
References: <20210819133839.10745-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: ED88A17276
X-Spam-Status: No, score=1.31
X-Stat-Signature: xtq9wskgg9q5yk38hqm1ujdryh91ffcd
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18LudW2irYBHTNEvn3FXoPtQaMsnxKJhc4=
X-HE-Tag: 1629381084-16190
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-08-19 at 14:38 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array ext_div on the stack but instead it
> static const. Makes the object code smaller by 118 bytes:
> 
> Before:
>    text    data    bss     dec    hex filename
>   39449   17500    128   57077   def5 ./drivers/gpu/drm/bridge/tc358767.o
> 
> After:
>    text    data    bss     dec    hex filename
>   39235   17596    128   56959   de7f ./drivers/gpu/drm/bridge/tc358767.o

Why is text smaller and data larger with this change?

> 
> (gcc version 10.3.0)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/bridge/tc358767.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
> index 23a6f90b694b..599c23759400 100644
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
> @@ -468,7 +468,7 @@ static int tc_pxl_pll_en(struct tc_data *tc, u32 refclk, u32 pixelclock)
>  	int div, best_div = 1;
>  	int mul, best_mul = 1;
>  	int delta, best_delta;
> -	int ext_div[] = {1, 2, 3, 5, 7};
> +	static const int ext_div[] = {1, 2, 3, 5, 7};
>  	int best_pixelclock = 0;
>  	int vco_hi = 0;
>  	u32 pxl_pllparam;


