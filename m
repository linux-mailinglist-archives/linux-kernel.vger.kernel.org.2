Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357C3327A90
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 10:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhCAJRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 04:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbhCAJRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 04:17:18 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20332C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 01:16:38 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i9so12500689wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 01:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=BDZK3/Jecgbl6c72+BPODYFw86hxqlmJoWNM2d07L7Y=;
        b=Rz8I0GIzG042rZP2WgTjrTtpiq0U16qby1TWqVuM60+7lnV8bePMxqjIUoHfGaO8aU
         mhv79AsdRE6CRAlev7XrABetEDuP3EvcpUXud2XU3bQMCjHGTZi3wNG9ICWMvkOzmjAi
         jyWSdlmE7WbT3ksd77SHKhoZlUTlhuvuZOzZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=BDZK3/Jecgbl6c72+BPODYFw86hxqlmJoWNM2d07L7Y=;
        b=OUw3pEPgpW0aj4BoqwTNhi5q34Y5P7EXPPVGSBDtKR0QR/iVMRkkty6EhjHIhMhgef
         Z//IX6llvqI3yhdkeujrDlCOLZNnh7UI+UlO3DsVz4DTY3Bq+7+Ilff+/UDMAuNFAo8k
         tIxKpASyYe/4nLUdFuiCqXEgkSkqMF8M2ePe6lOtdiDZYxXTuj8luLx8kehjWxyxJ0C9
         9Ay8V5bG+Y6l6x/b8b0qkk1jZQWlb5xvIETcdwPclpNBoP3oiX6C7qTJww4vH13abHCI
         yWuFHZKTHgxkOfYbu/mQcWOXppgPaNXG/u7Zt/Bv6IvZl8rlrgHELOSO9zl0Ah9a+kEi
         2DDA==
X-Gm-Message-State: AOAM532FXtjRCifL+d0V1xSkv1ScyuL0XiZ7yjgBvKGWrrsUTOQFvxO4
        Zjs6gNVDOJ5KfORc+q72E0ExO0FhaKA/HA==
X-Google-Smtp-Source: ABdhPJwPJdwI7s/qwnxVsg+l4wa8VRMCHlsOE0EJJlsqKHv5LAs9S/Q2QcEg9ul4uhhEMEihWEmLgA==
X-Received: by 2002:a05:600c:6d4:: with SMTP id b20mr5639876wmn.142.1614590196937;
        Mon, 01 Mar 2021 01:16:36 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id s124sm20885503wms.40.2021.03.01.01.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 01:16:36 -0800 (PST)
Date:   Mon, 1 Mar 2021 10:16:34 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: make drm_send_event_helper static
Message-ID: <YDyw8pmfBpDLP+gU@phenom.ffwll.local>
Mail-Followup-To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1614586790-130683-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614586790-130683-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 04:19:50PM +0800, Jiapeng Chong wrote:
> Fix the following sparse warning:
> 
> drivers/gpu/drm/drm_file.c:789:6: warning: symbol
> 'drm_send_event_helper' was not declared. Should it be static?
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/drm_file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index 7efbccf..23d8ad4 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -786,8 +786,8 @@ void drm_event_cancel_free(struct drm_device *dev,
>   * The timestamp variant of dma_fence_signal is used when the caller
>   * sends a valid timestamp.
>   */
> -void drm_send_event_helper(struct drm_device *dev,
> -			   struct drm_pending_event *e, ktime_t timestamp)
> +static void drm_send_event_helper(struct drm_device *dev, struct drm_pending_event *e,
> +				   ktime_t timestamp)

For static inline functions we also remove the kerneldoc, there's not
really anything important in there. Can you pls do that and respin your
patch?

Thanks, Daniel

>  {
>  	assert_spin_locked(&dev->event_lock);
>  
> -- 
> 1.8.3.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
