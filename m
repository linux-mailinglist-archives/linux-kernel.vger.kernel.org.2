Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE884198D1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235454AbhI0QZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhI0QZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:25:24 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E45C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:23:46 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h3so18269173pgb.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GrJG+rwDoaYG7HFW8GCZPuZNJMWLA/Q3Bhmee7Qx6+Q=;
        b=nDkeCEeP/JnEXHtclCNjpgccysiO9z5+1qsvWdza+YdXdRzWVM8VpwMJOqaWO8Lv6f
         yVgyPZxKBFT/xMah8M5RXQr04lLRWPPD18RH7rfUumFbV2eXqu49oskx5rqJNLRaoy26
         Gu5A9XBRje0GDqgHWZv2XPw/ycZqDy/v8Lf3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GrJG+rwDoaYG7HFW8GCZPuZNJMWLA/Q3Bhmee7Qx6+Q=;
        b=gEIA4zKVV/kb2YpBCrLmu4TbW8GFmhViz6GguZFv9rkh83LeDXU/v0nNO8D7cnjIHn
         StyLLMDFtGgymYqKjNKWLO2gLJxbDfmA9uPf5I8AZQ9/0WRXI81XuEC/dcqpPWM1IGVI
         9Ve2kZy+kAriPbfz2V0y1JnmBgNGbpYjN3ir48xzkRpIT4F9GUQ6OJAr8WwXTrvzEISI
         uE97YPSnpz27HUWA4kCzodlGd+Yt6gQIS2BYiDBtZbtfrf43dnkJppapJSkj2v4NlhUK
         LldMQd+/r+fz8pIIdJxpriicbV5BKpbIBejiLuml2w6cQZW6pBVu/kDV044Wmw0p9MPV
         BAUg==
X-Gm-Message-State: AOAM531WOEcvfOM2gSEz8d4j4wO9o3x3mnv1vyD832PULtSbKzOsfCBD
        BHC40pEstPt7mp6ThYpR/gDh6g==
X-Google-Smtp-Source: ABdhPJxgip2RoIeiUy0OKwHW6HRCTe1Y1Iw84My0njAXIF+cR6eK9S/VGJsCSQIsay9o/bzTXSvBZA==
X-Received: by 2002:a62:8688:0:b0:44b:38cd:c2b8 with SMTP id x130-20020a628688000000b0044b38cdc2b8mr790332pfd.12.1632759826508;
        Mon, 27 Sep 2021 09:23:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w18sm18561806pff.39.2021.09.27.09.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:23:46 -0700 (PDT)
Date:   Mon, 27 Sep 2021 09:23:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] drm: fb_helper: fix CONFIG_FB dependency
Message-ID: <202109270923.97AFDE89DB@keescook>
References: <20210927142816.2069269-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927142816.2069269-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 04:28:02PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With CONFIG_FB=m and CONFIG_DRM=y, we get a link error in the fb helper:
> 
> aarch64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_alloc_fbi':
> (.text+0x10cc): undefined reference to `framebuffer_alloc'
> 
> Tighten the dependency so it is only allowed in the case that DRM can
> link against FB.
> 
> Fixes: f611b1e7624c ("drm: Avoid circular dependencies for CONFIG_FB")
> Link: https://lore.kernel.org/all/20210721152211.2706171-1-arnd@kernel.org/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for fixing this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
