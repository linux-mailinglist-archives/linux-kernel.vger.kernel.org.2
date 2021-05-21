Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA4B38CA1B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 17:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbhEUPaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 11:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhEUPav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 11:30:51 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB8AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:29:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so7659720wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 08:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=lQZa3nF5KuYnerm4GLvju2DxCctG/p2J7D9NyuUkBqM=;
        b=dt1qnNiTnNH8FRdvLy1J/0tKQBFSQ3uYooI2fCgW3aJZqXUdbGz1sD0/Ycw3WiWQ7D
         tIEdeIg6H8Q51Kpxw4zMfOsDDeoyVeFkIowCThTaqaDhz38YNpr0BbtntTJ3M3izxMTh
         SxtALgBMTKAKnU/tJRQ/8ktg6DuDTMVBrPq9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=lQZa3nF5KuYnerm4GLvju2DxCctG/p2J7D9NyuUkBqM=;
        b=P8xcHYnquGu6w7HoL49zi1d8MBHDHd5JTlUyQTuauySOEhnFeslkpe+R6N+1lzH6Lr
         r7tvwFVynTWvoIezbm1wlDzTwFfe/9aGNMhQePOFd3IZLB1Sf+tXxPtrzJne7hkba5Vo
         vggIMrRguZo3Ri/3U9NPgywE604x6WtydwIa77j10zTjHAYLfMe8cID8zwOM8hQAf0me
         p+1+zjNpbSi4WjLJAWvB3TY5Mm/GHG2Q9ozkz5KvrWBS5dHv5OCnNhyaHqVjxmI7MWdp
         RKKZGcMskYlAV1kftw/FP0V8vX7RE6slwqff0aIcTHierMIPznpCPmmqFHfy3rKd7cRQ
         CNGQ==
X-Gm-Message-State: AOAM532j2C7SLsydrX8VbjhchCvprSXaWp/lj0YSaEYahmczIJWnCNWl
        XMQsFVsSlwnPDwTEHh+RsFdTVw==
X-Google-Smtp-Source: ABdhPJyXe0znQ5LDPzXI9ISS+1RysJAiGcv2EjlURPsfwLAa62NVbU2C5NMOIKrc6RPMqRg406Z4sg==
X-Received: by 2002:a7b:cd16:: with SMTP id f22mr9489300wmj.8.1621610966950;
        Fri, 21 May 2021 08:29:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id x4sm12492047wmj.17.2021.05.21.08.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 08:29:26 -0700 (PDT)
Date:   Fri, 21 May 2021 17:29:24 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: Re: [RFC PATCH 01/13] drm/dsc: Add dsc pps header init function
Message-ID: <YKfR1BGWa/CVYg9w@phenom.ffwll.local>
Mail-Followup-To: Vinod Koul <vkoul@kernel.org>,
        Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>, Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20210521124946.3617862-1-vkoul@kernel.org>
 <20210521124946.3617862-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521124946.3617862-2-vkoul@kernel.org>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 06:19:30PM +0530, Vinod Koul wrote:
> We required a helper to create and set the dsc_dce_header, so add the
> dsc_dce_header and API drm_dsc_dsi_pps_header_init
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/gpu/drm/drm_dsc.c | 11 +++++++++++
>  include/drm/drm_dsc.h     | 16 ++++++++++++++++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_dsc.c b/drivers/gpu/drm/drm_dsc.c
> index ff602f7ec65b..0c1b745090e2 100644
> --- a/drivers/gpu/drm/drm_dsc.c
> +++ b/drivers/gpu/drm/drm_dsc.c
> @@ -49,6 +49,17 @@ void drm_dsc_dp_pps_header_init(struct dp_sdp_header *pps_header)
>  }
>  EXPORT_SYMBOL(drm_dsc_dp_pps_header_init);
>  
> +void drm_dsc_dsi_pps_header_init(struct dsc_dce_header *dsc_header)

Kerneldoc for anything exported to drivers please, also ideally for all
the structures.

Thanks, Daniel
> +{
> +	memset(dsc_header, 0, sizeof(*dsc_header));
> +
> +	dsc_header->bp0 = 0x0A;
> +	dsc_header->bp1 = 1;
> +	dsc_header->bp4 = 10;
> +	dsc_header->bp6 = 128;
> +}
> +EXPORT_SYMBOL(drm_dsc_dsi_pps_header_init);
> +
>  /**
>   * drm_dsc_dp_rc_buffer_size - get rc buffer size in bytes
>   * @rc_buffer_block_size: block size code, according to DPCD offset 62h
> diff --git a/include/drm/drm_dsc.h b/include/drm/drm_dsc.h
> index bbe120f461e5..5a3bbeb3e12f 100644
> --- a/include/drm/drm_dsc.h
> +++ b/include/drm/drm_dsc.h
> @@ -602,8 +602,24 @@ struct drm_dsc_pps_infoframe {
>  	struct drm_dsc_picture_parameter_set pps_payload;
>  } __packed;
>  
> +struct dsc_dce_header {
> +	u8 bp0;
> +	u8 bp1;
> +	u8 bp2;
> +	u8 bp3;
> +	u8 bp4;
> +	u8 bp5;
> +	u8 bp6;
> +} __packed;
> +
> +struct drm_dsi_dsc_infoframe {
> +	struct dsc_dce_header dsc_header;
> +	struct drm_dsc_picture_parameter_set pps_payload;
> +} __packed;
> +
>  void drm_dsc_dp_pps_header_init(struct dp_sdp_header *pps_header);
>  int drm_dsc_dp_rc_buffer_size(u8 rc_buffer_block_size, u8 rc_buffer_size);
> +void drm_dsc_dsi_pps_header_init(struct dsc_dce_header *dsc_header);
>  void drm_dsc_pps_payload_pack(struct drm_dsc_picture_parameter_set *pps_sdp,
>  				const struct drm_dsc_config *dsc_cfg);
>  int drm_dsc_compute_rc_parameters(struct drm_dsc_config *vdsc_cfg);
> -- 
> 2.26.3
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
