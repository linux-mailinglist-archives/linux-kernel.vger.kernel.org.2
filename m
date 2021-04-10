Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC72035ACF7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 13:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhDJLde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 07:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhDJLdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 07:33:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B666C061762
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:33:18 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso4298393wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 04:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fvdzUEOBZnrRgws5JVo7yfOmTexEa+PsOPP655oivsE=;
        b=UBP1bbhv47oJHLt6G6DWDz4KPZiLYyi/H7xlN2PMJM4kHddpto3q+cnuXfnWKHjSbo
         e3Obl7L368/7VqTBSrXJXF9WjGLRhDUVqps8KOoZXsfThB0T+JuqhZmhtqOkUxiJUTwL
         3zkLNhMDaoMAfcx8uI7bMwfHQAJc1VXfF0OzQ8F7vnm9X68SNwrSLn0pGxv6CQ0eh65z
         KLQilvSfiVQzSQwWHy4eonhQ9YClUaIAQCToc8Vw6GOshEYwmYdclgW3s04UOPk7Dtzz
         jhK8cOHvuLB71U2/ozCZouAoAte34UFuOwdGDo0JkoJ/G+7ZFxyNqWcSYeMW+PPyS3Oy
         ARIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fvdzUEOBZnrRgws5JVo7yfOmTexEa+PsOPP655oivsE=;
        b=OcxTMojYYAYagxFZ5Y8gU2whXDsZUJ9GNQCQcaOOIKWKZkd79hCeUVcuBtTPdVKZYu
         doLnjPdgS9B8Yvw8k43B0yOqyAbGjQBDup+7F+hq2+jQ4MEC+E8i6ZySQKT8000DOqpR
         AgalAkAm3gChXnLXs/0z4UGNCnMtgr6ouXmVDn7o7pTta4uVvDF5tdijjOxj0A9cvqam
         z1qCZ0Ci/qTnJgDl8mut/5m92tliOxmfa6a6hD9UP20FitMXuj+Z0rVdlRTipaILGw63
         UAmfLoyXfKb9R29XxgzIWEpOaBZA8fP4l7Gh3R4hGNxmrAXsxGfy0AxYSNS154bok+Q2
         jwSw==
X-Gm-Message-State: AOAM532UCu6SaHUjIAvF/JhYZ9I7aw0Z9tIEbkYxvsUvuIz85P80CwuY
        jKgiQjHxVvTv4KBc6wNG4S3EXtQf/Rs=
X-Google-Smtp-Source: ABdhPJy5M4zou8GJe5SFLivC59/pu7Ie4GkBi5tmaEVlo+EhWnaCDMuIqzYiqMey8Gg6U9IGVgn5pA==
X-Received: by 2002:a1c:804d:: with SMTP id b74mr2980631wmd.15.1618054397124;
        Sat, 10 Apr 2021 04:33:17 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id w22sm7576006wmc.13.2021.04.10.04.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 04:33:16 -0700 (PDT)
Date:   Sat, 10 Apr 2021 08:33:09 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
Cc:     rodrigosiqueiramelo@gmail.com, hamohammed.sa@gmail.com,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/2] drm/vkms: Refactor vkms_composer_worker() to prep
 for virtual_hw mode
Message-ID: <20210410113309.4tgdkqgooixgou3q@smtp.gmail.com>
References: <cover.1617602076.git.sylphrenadin@gmail.com>
 <ab3492843ea631c51a3ff8dcf8e3f7af96aaed60.1617602076.git.sylphrenadin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3492843ea631c51a3ff8dcf8e3f7af96aaed60.1617602076.git.sylphrenadin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05, Sumera Priyadarsini wrote:
> Add two new functions vkms_composer_common() and vkms_crtc_composer().
> The actual plane composition work has been moved to the helper function,
> vkms_composer_common() which is called by both vkms_composer_worker()
> and vkms_crtc_composer(). vkms_crtc_composer() can be used when we
> implement virtual_hw mode.

Hi Sumera,

At this point, vkms_crtc_composer is never called. You should move this
function to the patch where you actually add virtual_hw mode, giving
meaning to create a different function (suitable for composition on
vblank-less mode). keep here only the prep work to add virtual hardware.

Thanks,

Melissa

> 
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
> ---
> Changes in V4:
> - Fix warning
> Changes in V3:
> - Refactor patchset (Melissa)
> Change in V2:
> - Add vkms_composer_common() (Daniel)
> ---
>  drivers/gpu/drm/vkms/vkms_composer.c | 88 +++++++++++++++++-----------
>  drivers/gpu/drm/vkms/vkms_drv.h      |  3 +
>  2 files changed, 58 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
> index 66c6842d70db..0d2bad3ff849 100644
> --- a/drivers/gpu/drm/vkms/vkms_composer.c
> +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> @@ -169,6 +169,44 @@ static int compose_planes(void **vaddr_out,
>  	return 0;
>  }
>  
> +int vkms_composer_common(struct vkms_crtc_state *crtc_state,
> +			 struct vkms_output *out, bool wb_pending, uint32_t *crc32)
> +{
> +	struct vkms_composer *primary_composer = NULL;
> +	struct vkms_composer *cursor_composer = NULL;
> +	void *vaddr_out = NULL;
> +	int ret;
> +
> +	if (crtc_state->num_active_planes >= 1)
> +		primary_composer = crtc_state->active_planes[0]->composer;
> +	if (crtc_state->num_active_planes == 2)
> +		cursor_composer = crtc_state->active_planes[1]->composer;
> +	if (!primary_composer)
> +		return -EINVAL;
> +	if (wb_pending)
> +		vaddr_out = crtc_state->active_writeback;
> +
> +	ret = compose_planes(&vaddr_out, primary_composer, cursor_composer);
> +	if (ret) {
> +		if (ret == -EINVAL && !wb_pending)
> +			kfree(vaddr_out);
> +		return -EINVAL;
> +	}
> +
> +	*crc32 = compute_crc(vaddr_out, primary_composer);
> +
> +	if (wb_pending) {
> +		drm_writeback_signal_completion(&out->wb_connector, 0);
> +		spin_lock_irq(&out->composer_lock);
> +		crtc_state->wb_pending = false;
> +		spin_unlock_irq(&out->composer_lock);
> +	} else {
> +		kfree(vaddr_out);
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * vkms_composer_worker - ordered work_struct to compute CRC
>   *
> @@ -185,12 +223,9 @@ void vkms_composer_worker(struct work_struct *work)
>  						composer_work);
>  	struct drm_crtc *crtc = crtc_state->base.crtc;
>  	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
> -	struct vkms_composer *primary_composer = NULL;
> -	struct vkms_composer *cursor_composer = NULL;
>  	bool crc_pending, wb_pending;
> -	void *vaddr_out = NULL;
> -	u32 crc32 = 0;
>  	u64 frame_start, frame_end;
> +	u32 crc32 = 0;
>  	int ret;
>  
>  	spin_lock_irq(&out->composer_lock);
> @@ -210,36 +245,9 @@ void vkms_composer_worker(struct work_struct *work)
>  	if (!crc_pending)
>  		return;
>  
> -	if (crtc_state->num_active_planes >= 1)
> -		primary_composer = crtc_state->active_planes[0]->composer;
> -
> -	if (crtc_state->num_active_planes == 2)
> -		cursor_composer = crtc_state->active_planes[1]->composer;
> -
> -	if (!primary_composer)
> -		return;
> -
> -	if (wb_pending)
> -		vaddr_out = crtc_state->active_writeback;
> -
> -	ret = compose_planes(&vaddr_out, primary_composer, cursor_composer);
> -	if (ret) {
> -		if (ret == -EINVAL && !wb_pending)
> -			kfree(vaddr_out);
> +	ret = vkms_composer_common(crtc_state, out, wb_pending, &crc32);
> +	if (ret == -EINVAL)
>  		return;
> -	}
> -
> -	crc32 = compute_crc(vaddr_out, primary_composer);
> -
> -	if (wb_pending) {
> -		drm_writeback_signal_completion(&out->wb_connector, 0);
> -		spin_lock_irq(&out->composer_lock);
> -		crtc_state->wb_pending = false;
> -		spin_unlock_irq(&out->composer_lock);
> -	} else {
> -		kfree(vaddr_out);
> -	}
> -
>  	/*
>  	 * The worker can fall behind the vblank hrtimer, make sure we catch up.
>  	 */
> @@ -247,6 +255,20 @@ void vkms_composer_worker(struct work_struct *work)
>  		drm_crtc_add_crc_entry(crtc, true, frame_start++, &crc32);
>  }
>  
> +void vkms_crtc_composer(struct vkms_crtc_state *crtc_state)
> +{
> +	struct drm_crtc *crtc = crtc_state->base.crtc;
> +	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
> +	u32 crc32 = 0;
> +	int ret;
> +
> +	ret = vkms_composer_common(crtc_state, out, crtc_state->wb_pending, &crc32);
> +	if (ret == -EINVAL)
> +		return;
> +
> +	drm_crtc_add_crc_entry(crtc, true, 0, &crc32);
> +}
> +
>  static const char * const pipe_crc_sources[] = {"auto"};
>  
>  const char *const *vkms_get_crc_sources(struct drm_crtc *crtc,
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
> index 35540c7c4416..538315140585 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -125,8 +125,11 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *source_name,
>  			   size_t *values_cnt);
>  
>  /* Composer Support */
> +int vkms_composer_common(struct vkms_crtc_state *crtc_state, struct vkms_output *out,
> +			 bool wb_pending, uint32_t *crcs);
>  void vkms_composer_worker(struct work_struct *work);
>  void vkms_set_composer(struct vkms_output *out, bool enabled);
> +void vkms_crtc_composer(struct vkms_crtc_state *crtc_state);
>  
>  /* Writeback */
>  int vkms_enable_writeback_connector(struct vkms_device *vkmsdev);
> -- 
> 2.25.1
> 
