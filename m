Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11373AC5B8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 10:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhFRIHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 04:07:24 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:10029 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhFRIHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624003514; x=1655539514;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RQal2gD0iwrHc9ZppKiQ+W3oXPHMjyF8tv8gePj7iNs=;
  b=mOrzaIK9R0VTLIzKw7yIzllOydeIk0Ld5wvZ2NW6+SVUVBYhJGgAfjEC
   VmhNOMXLLZXMv0el1P8MarKMlyaALWS1MHIZc7RJNvlhAxkt6Wszx4F25
   POyu6BpsFwoPfV82s89E60CmTGjVndvB8NvW1662roO9Im2bXUdDFu8uA
   yWfWRb/5puRh/Y6t8ytHmiTLeVMaMo5AvqTwcg49CO+5bDTpbGKDzJUMx
   lFou2OSNFDk0jpfqJ7uZbCRtDA0DfGfm7MZ5CwiaWD/WYQF/eVn5EwuYI
   m8NxOp0dy8/5AUXhyRQUWHFq3vJ2DBiTOFCSLiPABs8LRwb4X0G4cOpDE
   A==;
IronPort-SDR: MZ69SXR9w1lN7HEuHcGZ7QiBogbYQnTsZ4y1ME3u3U96aAl47xYEMtEXITp60Y3yj92C/yQ8JA
 Ih9dLXt7xIQIi+e9BGUBTy6luqPsWKh4lD+N+ipR3lMBWKXU3HO67Tw+IunWHrztG/zSc9ZhoB
 b0QG3TtPU6MoTnLby1aEQ4xylski3UC+wDgOGuP8nVDHHwUTQzKMXhiF+o/Tybo8gqvCJb4Ot6
 nOzlRkfyQ6LEWkUaq32t3CzSYfpCBTKGGKdAK+FuTImZabNVgsP3kkG543fBLOpC+wPWzOfVP6
 P0I=
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="125790287"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jun 2021 01:05:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 01:05:14 -0700
Received: from [10.12.73.56] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Fri, 18 Jun 2021 01:05:12 -0700
Subject: Re: [PATCH] drm:atmel: Enable the crtc vblank prior to crtc usage.
To:     Dan Sneddon <dan.sneddon@microchip.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
References: <20210602160846.5013-1-dan.sneddon@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
Message-ID: <72ac51ca-a7df-c6ce-ba10-5dd26369e137@microchip.com>
Date:   Fri, 18 Jun 2021 10:05:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210602160846.5013-1-dan.sneddon@microchip.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel, Sam,

On 02/06/2021 at 18:08, Dan Sneddon wrote:
> 'commit eec44d44a3d2 ("drm/atmel: Use drm_atomic_helper_commit")'
> removed the home-grown handling of atomic commits and exposed an issue
> in the crtc atomic commit handling where vblank is expected to be
> enabled but hasn't yet, causing kernel warnings during boot.  This patch
> cleans up the crtc vblank handling thus removing the warning on boot.
> 
> Fixes: eec44d44a3d2 ("drm/atmel: Use drm_atomic_helper_commit")
> 
> Signed-off-by: Dan Sneddon <dan.sneddon@microchip.com>

Is this fix need more input from us, is there something missing (aka ping)?

Regards,
   Nicolas


> ---
>   drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> index 05ad75d155e8..cfe4fc69277e 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> +++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
> @@ -232,7 +232,6 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
>   
>   	pm_runtime_put_sync(dev->dev);
>   
> -	drm_crtc_vblank_on(c);
>   }
>   
>   #define ATMEL_HLCDC_RGB444_OUTPUT	BIT(0)
> @@ -343,8 +342,17 @@ static int atmel_hlcdc_crtc_atomic_check(struct drm_crtc *c,
>   
>   static void atmel_hlcdc_crtc_atomic_begin(struct drm_crtc *c,
>   					  struct drm_atomic_state *state)
> +{
> +	drm_crtc_vblank_on(c);
> +}
> +
> +static void atmel_hlcdc_crtc_atomic_flush(struct drm_crtc *c,
> +					  struct drm_atomic_state *state)
>   {
>   	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(c);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&c->dev->event_lock, flags);
>   
>   	if (c->state->event) {
>   		c->state->event->pipe = drm_crtc_index(c);
> @@ -354,12 +362,7 @@ static void atmel_hlcdc_crtc_atomic_begin(struct drm_crtc *c,
>   		crtc->event = c->state->event;
>   		c->state->event = NULL;
>   	}
> -}
> -
> -static void atmel_hlcdc_crtc_atomic_flush(struct drm_crtc *crtc,
> -					  struct drm_atomic_state *state)
> -{
> -	/* TODO: write common plane control register if available */
> +	spin_unlock_irqrestore(&c->dev->event_lock, flags);
>   }
>   
>   static const struct drm_crtc_helper_funcs lcdc_crtc_helper_funcs = {
> 


-- 
Nicolas Ferre
