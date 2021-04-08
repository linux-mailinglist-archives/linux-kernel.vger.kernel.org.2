Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755DA35819C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhDHLUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhDHLUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:20:36 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EEFC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 04:20:23 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id w7-20020a1cdf070000b0290125f388fb34so227271wmg.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 04:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=p9/vcGnQMibF9rkDWZtUMCI7BNJHmwZHzupvVKqVu3E=;
        b=YnHMsaO2s1KNWHEyZA+FBnXLbzo0kKMYlmU9l9iP1g4DGl7O4FRzWyFDCE5BWmlipe
         byHjyxws/nm6+Um0woHg/dDHbRJEKezIUFT3iWU5a8w1PU2e7m+WM6pVFy2MfWlfxoAa
         LoEdm8nFSDszG2vkXnarWkoZ7cVvGd0uGCunY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=p9/vcGnQMibF9rkDWZtUMCI7BNJHmwZHzupvVKqVu3E=;
        b=n1VJ54x0WGQ5JJ0/Yj01jaE27ms0iD018HCcEaeGhuEkkxW4s46fPeSDUcq+S0syKo
         i5I01mOYXCc/b6M2eP8kN7BrzgJUk1Ed3bfy69k5wP70yEcwLwXmMf/9122h9E7lNsm9
         Ic0TLW6Pzty8ff2Lh26k4DC1fmcK46sRstxh9ibG9tDLllBV1X55aj2dHPwBck5LOrhm
         +6Zse1tB+4TUSJoMH9Tl0b2paXAFcpawDr4NR1MCPQbYZtweiwFvN/tRtW01KjDaooZA
         /iZ1U9utJdJEpmMPKxY0jITmvb8p/KLMGEYRFfypxZ/sdAeGHEaBEdMscOT2wpj4F04V
         AXUQ==
X-Gm-Message-State: AOAM530DYJ0UTbDvVkAY41pee3lKjzOKVgaGsavyddasjf1DWAF9IWAj
        xoPkyd5ICLHeopD8ZG+l61CCDw==
X-Google-Smtp-Source: ABdhPJyGIebRl0LCNGA8cQnrb+fYGQT/Pf+/l14E/xAG36Cx4IwUC+NrIjreWsTLESHVxP3rRmlSCQ==
X-Received: by 2002:a05:600c:4fd0:: with SMTP id o16mr7872267wmq.123.1617880821826;
        Thu, 08 Apr 2021 04:20:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c16sm55234757wrs.81.2021.04.08.04.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 04:20:21 -0700 (PDT)
Date:   Thu, 8 Apr 2021 13:20:19 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Huang Guobin <huangguobin4@huawei.com>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] gma500: Use DEFINE_SPINLOCK() for spinlock
Message-ID: <YG7m8z5n223DqDht@phenom.ffwll.local>
Mail-Followup-To: Huang Guobin <huangguobin4@huawei.com>,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1617710114-48071-1-git-send-email-huangguobin4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617710114-48071-1-git-send-email-huangguobin4@huawei.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 07:55:14PM +0800, Huang Guobin wrote:
> From: Guobin Huang <huangguobin4@huawei.com>
> 
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Guobin Huang <huangguobin4@huawei.com>

Applied to drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/gma500/power.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/gma500/power.c b/drivers/gpu/drm/gma500/power.c
> index 56ef88237ef6..f07641dfa5a4 100644
> --- a/drivers/gpu/drm/gma500/power.c
> +++ b/drivers/gpu/drm/gma500/power.c
> @@ -36,7 +36,7 @@
>  #include <linux/pm_runtime.h>
>  
>  static struct mutex power_mutex;	/* Serialize power ops */
> -static spinlock_t power_ctrl_lock;	/* Serialize power claim */
> +static DEFINE_SPINLOCK(power_ctrl_lock);	/* Serialize power claim */
>  
>  /**
>   *	gma_power_init		-	initialise power manager
> @@ -55,7 +55,6 @@ void gma_power_init(struct drm_device *dev)
>  	dev_priv->display_power = true;	/* We start active */
>  	dev_priv->display_count = 0;	/* Currently no users */
>  	dev_priv->suspended = false;	/* And not suspended */
> -	spin_lock_init(&power_ctrl_lock);
>  	mutex_init(&power_mutex);
>  
>  	if (dev_priv->ops->init_pm)
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
