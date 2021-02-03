Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D415330D7D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 11:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbhBCKm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 05:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbhBCKmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 05:42:52 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA53C061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 02:42:11 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 190so4980326wmz.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 02:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=zOUCxvKfNLh9LXY5HAhXD0ADP7iay2Tk0x7+iDeR2XY=;
        b=UmKeC0lviQEflCNxco15aoGnRyrd0ymp8yVsir7RnaZ6GdDbH7bdbkj+yCfh7fuS7Z
         IZKxLxh2zgKuVFyymVuKOxL89XZGH3ywNw9RDhFaVvDMelRV/ydFgN4xJLGpq+QJAaDJ
         x3/iwRQCmTxUNm364An6c77JfICf4bN9nWQk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=zOUCxvKfNLh9LXY5HAhXD0ADP7iay2Tk0x7+iDeR2XY=;
        b=oxsGLRmYHgs1edJfBqdiwadUZPjo6EFXyK6o59YOg2VNuqAlBALkdOw9MsV8xl7JE8
         w5FlRd7aHgx2AclnzjcoQaV3zzn2bENbeChMKg/ZOpOGykdWirLv2Mrc6NkGqdO3Y1eZ
         6m2HyjJZAA1EKtD8Bt2/flrwTn83kk+c8xx3kbyC+yxBBectAKd1mupJ64jr0lhhJJLI
         IB1bwYTlZc2xMK7Osj+Q1X6Gjvij54n5CS4fqrkEK/JF0FSIqMPwRM0AXum69Sforr3w
         x5NuA8TKmw1xIDMWY7MZcEj1l7bNBqClbu7LY9p/Y/csWiLtu+pxZX1I6ytfu8rugQ3/
         29zw==
X-Gm-Message-State: AOAM532MQZ/NkjGbxM2vO3TVkK6jje4JwjdN/4iojylaLCQJ8EuTLwz+
        oE/am2GiAKxA0IRSYsCa36GP3w==
X-Google-Smtp-Source: ABdhPJxA/ksjmhexnFn7txkr6EHLKnN9HIdUdnHVkgqUS6cdKoMgPe24RwLJ1+AoMN5G1m3vTsOkcQ==
X-Received: by 2002:a05:600c:21cb:: with SMTP id x11mr2220918wmj.29.1612348930296;
        Wed, 03 Feb 2021 02:42:10 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c9sm3282269wrw.76.2021.02.03.02.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 02:42:09 -0800 (PST)
Date:   Wed, 3 Feb 2021 11:42:07 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     quanyang.wang@windriver.com
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michal Simek <michal.simek@xilinx.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/xlnx: fix kmemleak by sending vblank_event in
 atomic_disable
Message-ID: <YBp9/14pnnJr+A+W@phenom.ffwll.local>
Mail-Followup-To: quanyang.wang@windriver.com,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Michal Simek <michal.simek@xilinx.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210202064121.173362-1-quanyang.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202064121.173362-1-quanyang.wang@windriver.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 02:41:21PM +0800, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> When running xrandr to change resolution of DP, the kmemleak as below
> can be observed:
> 
> unreferenced object 0xffff00080a351000 (size 256):
>   comm "Xorg", pid 248, jiffies 4294899614 (age 19.960s)
>   hex dump (first 32 bytes):
>     98 a0 bc 01 08 00 ff ff 01 00 00 00 00 00 00 00  ................
>     ff ff ff ff 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000e0bd0f69>] kmemleak_alloc+0x30/0x40
>     [<00000000cde2f318>] kmem_cache_alloc+0x3d4/0x588
>     [<0000000088ea9bd7>] drm_atomic_helper_setup_commit+0x84/0x5f8
>     [<000000002290a264>] drm_atomic_helper_commit+0x58/0x388
>     [<00000000f6ea78c3>] drm_atomic_commit+0x4c/0x60
>     [<00000000c8e0725e>] drm_atomic_connector_commit_dpms+0xe8/0x110
>     [<0000000020ade187>] drm_mode_obj_set_property_ioctl+0x1b0/0x450
>     [<00000000918206d6>] drm_connector_property_set_ioctl+0x3c/0x68
>     [<000000008d51e7a5>] drm_ioctl_kernel+0xc4/0x118
>     [<000000002a819b75>] drm_ioctl+0x214/0x448
>     [<000000008ca4e588>] __arm64_sys_ioctl+0xa8/0xf0
>     [<0000000034e15a35>] el0_svc_common.constprop.0+0x74/0x190
>     [<000000001b93d916>] do_el0_svc+0x24/0x90
>     [<00000000ce9230e0>] el0_svc+0x14/0x20
>     [<00000000e3607d82>] el0_sync_handler+0xb0/0xb8
>     [<000000003e79c15f>] el0_sync+0x174/0x180
> 
> This is because there is a scenario that a drm_crtc_commit commit is
> allocated but not freed. The drm subsystem require/release references
> to a CRTC commit by calling drm_crtc_commit_get/put, and when
> drm_crtc_commit_put find that commit.ref.refcount is zero, it will
> call __drm_crtc_commit_free to free this CRTC commit. Among these
> drm_crtc_commit_get/put pairs, there is a drm_crtc_commit_get in
> drm_atomic_helper_setup_commit as below:
> 
> ...
> new_crtc_state->event->base.completion = &commit->flip_done;
> new_crtc_state->event->base.completion_release = release_crtc_commit;
> drm_crtc_commit_get(commit);
> ...
> 
> This reference to the CRTC commit should be released at the function
> release_crtc_commit by calling e->completion_release(e->completion) in
> drm_send_event_locked. So we need to call drm_send_event_locked at
> two places: handling vblank event in the irq handler and the crtc disable
> helper. But in zynqmp_disp_crtc_atomic_disable, it only marks the flip
> is done and not call drm_crtc_commit_put. This result that the refcount
> of this commit is always non-zero and this commit will never be freed.
> 
> Since the function drm_crtc_send_vblank_event has operations both sending
> a flip_done signal and releasing reference to the CRTC commit, let's use
> it instead.
> 
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>

Yeah that's the way to do it, not the hack. Thanks for your patch, I'll
push it to drm-misc-fixes with Cc: stable@vger.kernel.org

Cheers, Daniel


> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index 68cc4ffff969..ee7657a48e6a 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -1396,19 +1396,11 @@ static void zynqmp_disp_enable(struct zynqmp_disp *disp)
>   */
>  static void zynqmp_disp_disable(struct zynqmp_disp *disp)
>  {
> -	struct drm_crtc *crtc = &disp->crtc;
> -
>  	zynqmp_disp_audio_disable(&disp->audio);
>  
>  	zynqmp_disp_avbuf_disable_audio(&disp->avbuf);
>  	zynqmp_disp_avbuf_disable_channels(&disp->avbuf);
>  	zynqmp_disp_avbuf_disable(&disp->avbuf);
> -
> -	/* Mark the flip is done as crtc is disabled anyway */
> -	if (crtc->state->event) {
> -		complete_all(crtc->state->event->base.completion);
> -		crtc->state->event = NULL;
> -	}
>  }
>  
>  static inline struct zynqmp_disp *crtc_to_disp(struct drm_crtc *crtc)
> @@ -1499,6 +1491,13 @@ zynqmp_disp_crtc_atomic_disable(struct drm_crtc *crtc,
>  
>  	drm_crtc_vblank_off(&disp->crtc);
>  
> +	spin_lock_irq(&crtc->dev->event_lock);
> +	if (crtc->state->event) {
> +		drm_crtc_send_vblank_event(crtc, crtc->state->event);
> +		crtc->state->event = NULL;
> +	}
> +	spin_unlock_irq(&crtc->dev->event_lock);
> +
>  	clk_disable_unprepare(disp->pclk);
>  	pm_runtime_put_sync(disp->dev);
>  }
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
