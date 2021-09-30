Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D3341DC38
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349693AbhI3O2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348233AbhI3O2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:28:39 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8522CC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:26:56 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id q2so525861wrc.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=xCUW4DYpcvfuZtuU3plFLnVjCTEdDK5f8kHlUi+qoUE=;
        b=kqGLwx12cDUzoC3iVNA+NJM4OhqKmVGWb+hkz/24TW+SqnZyjX4yHnJMTUGXjJhhrw
         h2BmwKqV0WCPe/V8yNYQ7hjO+NER31wCIwxWNQMRKUE98UAzpMQ7rzPDlLVxuIhcFPuG
         af1WBWnfuOzPTg+Stbh8+dP0FEJKH48b/M52E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=xCUW4DYpcvfuZtuU3plFLnVjCTEdDK5f8kHlUi+qoUE=;
        b=7rWngQ7+M7GlDD9Ghvay6KSiiOykBwyPgbMzf2FoKjBP+oRh+dYfmmnEvFWBrMM0wx
         wyceATC85HA9XxJ78gzX4AjGdtDhDmdheWzuXuf48FOG6jvIPeOYiqdtRUeDVr8tJZJm
         Tb2FbvNymRedbd0AEx3CJZUE/pDQm8z9Oqaz67yW3jH43joCcjBM+9D9xGdjRtE8ekbr
         Vtneq3qfXXRDgfYYdt9wdGX3jlEsjJALofcUp3QtTTeL8RyzXLRjbMiYwpy36/p6T3U/
         OlmbT0Kq8VN7NiKX3Zt6uy4HR8M8NXO0wqXLRvfEuNmg1w5rGG/5uKV0cziwhUPlyP/h
         VFtw==
X-Gm-Message-State: AOAM532kpHJ9muv74xALAP2ydT12UXLRXf5bFm/InN9PJKQ9By4UZWlY
        FTm+RQfeF5BfAqJZpTIq1M1SYA==
X-Google-Smtp-Source: ABdhPJyM/Mb9G9Dw6E28dIKZojOERdji8EqoOdbiAVKePmWDkfGwO6V7NnENfyHJOM3wI39vpQhC9A==
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr6512514wrb.274.1633012015165;
        Thu, 30 Sep 2021 07:26:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u5sm3443501wrg.57.2021.09.30.07.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:26:54 -0700 (PDT)
Date:   Thu, 30 Sep 2021 16:26:52 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] drm: fb_helper: fix CONFIG_FB dependency
Message-ID: <YVXJLE8UqgcUNIKl@phenom.ffwll.local>
Mail-Followup-To: Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210927142816.2069269-1-arnd@kernel.org>
 <202109270923.97AFDE89DB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109270923.97AFDE89DB@keescook>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 09:23:45AM -0700, Kees Cook wrote:
> On Mon, Sep 27, 2021 at 04:28:02PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > With CONFIG_FB=m and CONFIG_DRM=y, we get a link error in the fb helper:
> > 
> > aarch64-linux-ld: drivers/gpu/drm/drm_fb_helper.o: in function `drm_fb_helper_alloc_fbi':
> > (.text+0x10cc): undefined reference to `framebuffer_alloc'
> > 
> > Tighten the dependency so it is only allowed in the case that DRM can
> > link against FB.
> > 
> > Fixes: f611b1e7624c ("drm: Avoid circular dependencies for CONFIG_FB")
> > Link: https://lore.kernel.org/all/20210721152211.2706171-1-arnd@kernel.org/
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks for fixing this!
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Stuffed into drm-misc-next.

Arnd, I guess I still can't volunteer you for commit rights so I don't
have to bother with this anymore? It's nice to be lazy and comfy :-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
