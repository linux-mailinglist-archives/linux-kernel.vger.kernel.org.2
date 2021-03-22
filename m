Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0D2343A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 08:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhCVH1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 03:27:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhCVH0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:26:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF1D260295;
        Mon, 22 Mar 2021 07:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616398012;
        bh=7ZZ16k2IQrPSZWmtn+IDkZglcyLIqxtZ8LynJyOxnAI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GavvwMsZOqyYXx2TYUVFtfYpBgn0KxveSIZ1Ynq9vG2WsufcR9JkDlqsaJRkE7CAN
         cbGqtcsYBl+8LAKpJZEzZPZlVY8RcwlcYkMd768Y2vX6/JWQPoqHtWm4U1HWQEkLmt
         SQC3pRm4ORGv8RlRl2L1xIjFJ/s81nQyTC+4yrNd0sJJx1ynljFcOHKKguhmRToFVk
         eD9OSpzu7ZUAYP9Pa+wLb0fSrQdTgYnsKXxaQxVkshZ+l7HKSVGlfQmkP3uszCvb0f
         qjxoFmJczBElazis7AwZgV+HKDIKq3DycacSDdJvgll5Y026hpQ5i6CRvuGFHHROqg
         gTysvdOwO8doA==
Subject: Re: [PATCH v2 3/3] drm/tilcdc: fix pixel clock setting warning
 message
To:     Dario Binacchi <dariobin@libero.it>, linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Jyri Sarha <jyri.sarha@iki.fi>, dri-devel@lists.freedesktop.org
References: <20210321083153.2810-1-dariobin@libero.it>
 <20210321083153.2810-4-dariobin@libero.it>
From:   Tomi Valkeinen <tomba@kernel.org>
Message-ID: <0d8770b6-755d-8fc7-4e52-2d745971876d@kernel.org>
Date:   Mon, 22 Mar 2021 09:26:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210321083153.2810-4-dariobin@libero.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2021 10:31, Dario Binacchi wrote:
> The warning message did not printed the LCD pixel clock rate but the LCD
> clock divisor input rate. As a consequence, the required and real pixel
> clock rates are now passed to the tilcdc_pclk_diff().
> 
> Signed-off-by: Dario Binacchi <dariobin@libero.it>
> 
> ---
> 
> Changes in v2:
> - The patch has been added in version 2.
> 
>   drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> index ac6228cb04d9..c0792c52dc02 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> @@ -203,7 +203,7 @@ static void tilcdc_crtc_set_clk(struct drm_crtc *crtc)
>   	struct drm_device *dev = crtc->dev;
>   	struct tilcdc_drm_private *priv = dev->dev_private;
>   	struct tilcdc_crtc *tilcdc_crtc = to_tilcdc_crtc(crtc);
> -	unsigned long clk_rate, real_rate, real_pclk_rate, pclk_rate;
> +	unsigned long clk_rate, real_pclk_rate, pclk_rate;
>   	unsigned int clkdiv;
>   	int ret;
>   
> @@ -239,12 +239,12 @@ static void tilcdc_crtc_set_clk(struct drm_crtc *crtc)
>   		 * 5% is an arbitrary value - LCDs are usually quite tolerant
>   		 * about pixel clock rates.
>   		 */
> -		real_rate = clkdiv * pclk_rate;
> +		real_pclk_rate = clk_rate / clkdiv;
>   
> -		if (tilcdc_pclk_diff(clk_rate, real_rate) > 5) {
> +		if (tilcdc_pclk_diff(pclk_rate, real_pclk_rate) > 5) {
>   			dev_warn(dev->dev,
>   				 "effective pixel clock rate (%luHz) differs from the calculated rate (%luHz)\n",
> -				 clk_rate, real_rate);
> +				 pclk_rate, real_pclk_rate);

Aren't these backwards? "Effective" is the real one in the HW. I'm not 
sure what "calculated" means here, I guess it should be "requested".

  Tomi
