Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A0D34A279
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 08:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhCZHWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 03:22:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230006AbhCZHVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 03:21:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36E3F61A18;
        Fri, 26 Mar 2021 07:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616743308;
        bh=BGRR36ccL5GWDF9Q8BHWhizHme3WDeUjirfIggnlBuI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ebh89u+11fnx6NG2uVsb/Hj3RD4LGwa+KuDvP4sslHy+3DWXdhts5u9rSgJek1ag0
         CQa3VMlMqVABdlLTwPjyL+38ovR1eZFQIVN00+te9FQqzpN9n4pOzjqAadOeKiumYm
         gK5wYLOIXsXYWkyRsU9PxIhc1cmIQqv8zZ/XZN2XiBGK1ISsMIuy2JWsNEL9yuXbvC
         v7fPT1v3aVJJj/+QqBnQrQpDAr4zoVAsW2Lc0tP7zGqRgKg6gyYEBPedzSH35N6D7Z
         dV3JFwr1hLLkXAMTkRwuvuR1A0RHYP1U7REKhpRQyY2z3CBwVNS2abdZWdkhUG0RNd
         pttvD1/2zejXA==
Subject: Re: [PATCH] drm/omap: fix misleading indentation in pixinc()
To:     Arnd Bergmann <arnd@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jyri Sarha <jsarha@ti.com>, Tony Lindgren <tony@atomide.com>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210322164203.827324-1-arnd@kernel.org>
From:   Tomi Valkeinen <tomba@kernel.org>
Message-ID: <1c385d8d-224b-3484-e539-d791512dd88f@kernel.org>
Date:   Fri, 26 Mar 2021 09:21:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210322164203.827324-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2021 18:41, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> An old patch added a 'return' statement after each BUG() in this driver,
> which was necessary at the time, but has become redundant after the BUG()
> definition was updated to handle this properly.
> 
> gcc-11 now warns about one such instance, where the 'return' statement
> was incorrectly indented:
> 
> drivers/gpu/drm/omapdrm/dss/dispc.c: In function ‘pixinc’:
> drivers/gpu/drm/omapdrm/dss/dispc.c:2093:9: error: this ‘else’ clause does not guard... [-Werror=misleading-indentation]
>   2093 |         else
>        |         ^~~~
> drivers/gpu/drm/omapdrm/dss/dispc.c:2095:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the ‘else’
>   2095 |                 return 0;
>        |                 ^~~~~~
> 
> Address this by removing the return again and changing the BUG()
> to be unconditional to make this more intuitive.
> 
> Fixes: c6eee968d40d ("OMAPDSS: remove compiler warnings when CONFIG_BUG=n")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/omapdrm/dss/dispc.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
> index f4cbef8ccace..5619420cc2cc 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dispc.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
> @@ -2090,9 +2090,8 @@ static s32 pixinc(int pixels, u8 ps)
>   		return 1 + (pixels - 1) * ps;
>   	else if (pixels < 0)
>   		return 1 - (-pixels + 1) * ps;
> -	else
> -		BUG();
> -		return 0;
> +
> +	BUG();
>   }
>   
>   static void calc_offset(u16 screen_width, u16 width,

Thanks, I'll pick this up.

  Tomi
