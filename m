Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F918315C08
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhBJBRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbhBIWUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:20:13 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B46C0698E4
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 13:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
        In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YYEZ2wEiCYmA0LWqHCD7zvMT/VIYTEjeg2vRMJxSuvg=; b=MePaVHAsFDdj9YFvPrfEO9PvCM
        OKl59gt6WZAJ+pLzzNthwBrv4J5mjAYdjUqlChjWzOyfRGYwxE3HmwtRDQfuZWtnUHNUHN49bhY2F
        n+WDMfIRwbU20oQAM/QH2o0QkLaF0mB1kSuQFXOJzJWSB+Na7YdQlVL/QZq9zJRbh9uHLpJqRswTH
        Cs5tUqHFC103+ISedJNszwXEefUQSBaQSOZfQW9m7ZLnc3WXarfbQanSG8c7bpVKCBnjhi1h9zDGr
        MuOBzZSvG4LNWvcQt9As2Nz9QjYFersefXv9xaXCIvAvVAxgz2lJcTGuQh0zYa7SBev57TVctTrWi
        eqMWEEtw==;
Received: from webng-gw.kapsi.fi ([91.232.154.200] helo=roundcube.kapsi.fi)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <jyri.sarha@iki.fi>)
        id 1l9ahv-0001os-K0; Tue, 09 Feb 2021 23:38:03 +0200
MIME-Version: 1.0
Date:   Tue, 09 Feb 2021 23:38:01 +0200
From:   Jyri Sarha <jyri.sarha@iki.fi>
To:     quanyang.wang@windriver.com
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][PATCH] drm/tilcdc: send vblank event when disabling crtc
In-Reply-To: <20210209082415.382602-1-quanyang.wang@windriver.com>
References: <20210209082415.382602-1-quanyang.wang@windriver.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <f4c657ab37c4ce127c960b0698a0ffcf@iki.fi>
X-Sender: jyri.sarha@iki.fi
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 91.232.154.200
X-SA-Exim-Mail-From: jyri.sarha@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-09 10:24, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> When run xrandr to change resolution on Beaglebone Black board, it will
> print the error information:
> 
> root@beaglebone:~# xrandr -display :0 --output HDMI-1 --mode 720x400
> [drm:drm_crtc_commit_wait] *ERROR* flip_done timed out
> [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* [CRTC:32:tilcdc
> crtc] commit wait timed out
> [drm:drm_crtc_commit_wait] *ERROR* flip_done timed out
> [drm:drm_atomic_helper_wait_for_dependencies] *ERROR*
> [CONNECTOR:34:HDMI-A-1] commit wait timed out
> [drm:drm_crtc_commit_wait] *ERROR* flip_done timed out
> [drm:drm_atomic_helper_wait_for_dependencies] *ERROR*
> [PLANE:31:plane-0] commit wait timed out
> tilcdc 4830e000.lcdc: already pending page flip!
> 
> This is because there is operation sequence as below:
> 
> drm_atomic_connector_commit_dpms(mode is DRM_MODE_DPMS_OFF):
>     ...
>     drm_atomic_helper_setup_commit <- 
> init_completion(commit_A->flip_done)
>     drm_atomic_helper_commit_tail
>         tilcdc_crtc_atomic_disable
>         tilcdc_plane_atomic_update <- drm_crtc_send_vblank_event in
> tilcdc_crtc_irq
>                                       is skipped since 
> tilcdc_crtc->enabled is 0
>         tilcdc_crtc_atomic_flush   <- drm_crtc_send_vblank_event is
> skipped since
>                                       crtc->state->event is set to be 
> NULL in
>                                       tilcdc_plane_atomic_update
> drm_mode_setcrtc:
>     ...
>     drm_atomic_helper_setup_commit <- 
> init_completion(commit_B->flip_done)
>     drm_atomic_helper_wait_for_dependencies
>         drm_crtc_commit_wait   <- wait for commit_A->flip_done 
> completing
> 
> Just as shown above, the steps which could complete commit_A->flip_done
> are all skipped and commit_A->flip_done will never be completed. This 
> will
> result a time-out ERROR when drm_crtc_commit_wait check the 
> commit_A->flip_done.
> So add drm_crtc_send_vblank_event in tilcdc_crtc_atomic_disable to
> complete commit_A->flip_done.
> 
> Fixes: cb345decb4d2 ("drm/tilcdc: Use standard 
> drm_atomic_helper_commit")
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>

Reviewed-by: Jyri Sarha <jyri.sarha@iki.fi>
Tested-by: Jyri Sarha <jyri.sarha@iki.fi>

Thanks a lot! I think I have bumbed into this once or twice, but latelu 
I have had time to look into this. I'll merge this to drm-misc-next 
soon.

Best regards,
Jyri

> ---
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> index 30213708fc99..d99afd19ca08 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_crtc.c
> @@ -515,6 +515,15 @@ static void tilcdc_crtc_off(struct drm_crtc
> *crtc, bool shutdown)
> 
>  	drm_crtc_vblank_off(crtc);
> 
> +	spin_lock_irq(&crtc->dev->event_lock);
> +
> +	if (crtc->state->event) {
> +		drm_crtc_send_vblank_event(crtc, crtc->state->event);
> +		crtc->state->event = NULL;
> +	}
> +
> +	spin_unlock_irq(&crtc->dev->event_lock);
> +
>  	tilcdc_crtc_disable_irqs(dev);
> 
>  	pm_runtime_put_sync(dev->dev);
