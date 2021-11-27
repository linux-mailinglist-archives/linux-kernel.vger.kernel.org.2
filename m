Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE07D460132
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 20:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbhK0TcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 14:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356112AbhK0TaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 14:30:06 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93F0C06175D
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 11:26:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id c4so26557075wrd.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 11:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=89TQIfFMi5YcjZndEermwrf0AkyDoyzUG6bDIxitI4Y=;
        b=HUJpYejgaxfyWI6FpnqGcfAhCMCEr2D6LDN0gcB4SuTSnAZuS1UNAbVqizSg7xc9g+
         Zmyt0bmyMWVJoZN4k6IzzYdJeHUSjvQprh+lRLGW2rHb9n2J8uU01p7MpxstS101R1f/
         D4u6RmxDVDugEaSME+2QZDhm2CszDNgJ3e+Mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=89TQIfFMi5YcjZndEermwrf0AkyDoyzUG6bDIxitI4Y=;
        b=dpyggTqwNwjxVj5ibjwXnC+yN5KUujvbvfH/cO4hq/HTjGcvXPWvn9v9U/VuJy2Jji
         3IZvBem7SVQ1uZbs+M4hy6GuAwE55Wr5Q3T2HQKrJgAHJAkC7oHlDCnu+7yGbdiiMT1p
         Thko5Bf3itxVq9/Fu1FBv8FeOwitKW5T9oN06VJ1SJ4dNg3fMJBAx0fv/avzlELgaYRU
         MaLrRaw2kC6+G5SqPWdvKwOPJWvJwadIzl83XFZ/6gq4ku0NY8hSXYFeaLMSVELSWgax
         tu9VS690tk/Exbj9138KAUquA/0OGfm7it97zbn8co2dcdugW0tJ1PI0AO98Mpza8r9d
         BDxA==
X-Gm-Message-State: AOAM5314loGXjMlG9itHq04wE7pt5v8xsFm+DDv+OmTfXkK1CXeN+aWK
        slUtj5J+d5t2Lz55O9zA10FA7A==
X-Google-Smtp-Source: ABdhPJxgeqxmYvRq4/UvvikJwlN1aQmyd/Q4yh/D789U9or7uv4rdJy+HLzB9k4Tp7otyhxN440x7Q==
X-Received: by 2002:a5d:6347:: with SMTP id b7mr23300469wrw.36.1638041210365;
        Sat, 27 Nov 2021 11:26:50 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p12sm9122810wro.33.2021.11.27.11.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 11:26:49 -0800 (PST)
Date:   Sat, 27 Nov 2021 20:26:48 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Fix build error caused by missing drm_nomodeset.o
Message-ID: <YaKGeKU7HJOgEu9r@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
References: <20211127191910.709356-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211127191910.709356-1-javierm@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 08:19:10PM +0100, Javier Martinez Canillas wrote:
> The patch for commit ("6a2d2ddf2c34 drm: Move nomodeset kernel parameter
> to the DRM subsystem") was generated with config 'diff.noprefix true'.
> 
> But later was applied using 'cat nomodeset.mbox | dim apply-branch' on a
> machine with 'diff.noprefix false'. And command 'git am --scissors -3' as

Huh that's a dangerous setting, I guess a dim patch to check for this and
very loudly complain would be good? Care to type that up?  It's no big
deal because strange git settings for dim is pretty much a game of
whack-a-mole, but we should tackle them when they pop up.

> used by the dim tool doesn't handle that case well, since the 3-way merge
> wrongly resolves the path for new file drivers/gpu/drm/drm_nomodeset.c as
> gpu/drm/drm_nomodeset.c instead.
> 
> It led to the following build error as reported by the kernel test robot:
> 
>   make[4]: *** No rule to make target 'drivers/gpu/drm/drm_nomodeset.o', needed by 'drivers/gpu/drm/built-in.a'.
> 
> Fixes: ("6a2d2ddf2c34 drm: Move nomodeset kernel parameter to the DRM subsystem")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Build testing before pushing should be done, not the other way round :-)

Also this is pretty much why we want gitlab CI and real branches.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
> 
>  {gpu => drivers/gpu}/drm/drm_nomodeset.c | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename {gpu => drivers/gpu}/drm/drm_nomodeset.c (100%)
> 
> diff --git a/gpu/drm/drm_nomodeset.c b/drivers/gpu/drm/drm_nomodeset.c
> similarity index 100%
> rename from gpu/drm/drm_nomodeset.c
> rename to drivers/gpu/drm/drm_nomodeset.c
> -- 
> 2.33.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
