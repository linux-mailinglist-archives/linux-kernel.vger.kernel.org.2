Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC4743E50A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 17:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhJ1P0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 11:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbhJ1P0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:26:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCFDC061745
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 08:24:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u18so10890062wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 08:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=tv2oay0BJwn9J4qOktOFDlX3UCtKb/zY1x+VfaeHlvA=;
        b=PqYOXRiakc6910z5E0b0jhDIseWTs/ati5gqTU2+KetsIuYl+LCKRSuA9DnUF04DTG
         a3Tb+crbiPS8wQY10mICkzNWU3BwKVElwV0Xu51Np4GyP/K37nlp6VuGsNB/3vBr+hWO
         wPGvjGXCGyoRsCmBnz3uBRYuNqYbbaK562IXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=tv2oay0BJwn9J4qOktOFDlX3UCtKb/zY1x+VfaeHlvA=;
        b=o3l0JbjH2bGcq9uxWBMe/ISL7IKMsJyZHMcjvKs5DyXrAQw9gYQApU8Teg0/BFlXBX
         D72ufPrEwuTjF7tJwZYBGSPK+rGZeZOV1od0bcFPHtSedSF9Kb38ZJNYDzCPLcwWEMJM
         jkgKUFLVVzBmT1HJQLnOvOL/X7xrRoy/oO1U4n/Jt3sqA7uXjxh/Iw7D9MMnJwBa+5wc
         hszUsB5ak7TM4BH+cOOwWhxyM2wZxc4UtaIFGTv5Q8T0RfXBTfGdJw0fabxHQvPmq2iG
         rBbDVE8/xJflQN8yVS+O0NDUb9q/RT1l5aAeDnrg6VriSFOaL/rHzdzhFfG4nG9ZdMTJ
         wMAg==
X-Gm-Message-State: AOAM531jYr5nOAiQPF8Z4HQVhbQYjYAdafDxO3FzrBLv1Z5chjYnb17b
        X6f2nqYKdCsqT3ScOE0nhEZIwA==
X-Google-Smtp-Source: ABdhPJyoOV0TArYwFSys/pEgfWguKwZVtXaxh2rVmLpBFDFOkvNOyx2RNdVA2wiYCMc2yoJTXJQT8A==
X-Received: by 2002:a05:6000:15cc:: with SMTP id y12mr6643371wry.333.1635434654399;
        Thu, 28 Oct 2021 08:24:14 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n68sm6474347wmn.13.2021.10.28.08.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 08:24:13 -0700 (PDT)
Date:   Thu, 28 Oct 2021 17:24:11 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RESEND] drm: fb_helper: fix CONFIG_FB dependency
Message-ID: <YXrAm6d6ALx0aciQ@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210927142816.2069269-1-arnd@kernel.org>
 <202109270923.97AFDE89DB@keescook>
 <YVXJLE8UqgcUNIKl@phenom.ffwll.local>
 <878ryeit9i.fsf@intel.com>
 <CAK8P3a0EG_C6OvG00Dg8SQacirNztLFjVonb5t2xQj9aFZ47Vg@mail.gmail.com>
 <ca11cd15-3877-468b-c6b7-9022b6b11824@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca11cd15-3877-468b-c6b7-9022b6b11824@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 03:19:34PM +0200, Javier Martinez Canillas wrote:
> On 10/27/21 14:18, Arnd Bergmann wrote:
> 
> [snip]
> 
> > Right, how about this change on top?
> > 
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -117,9 +117,8 @@ config DRM_DEBUG_MODESET_LOCK
> > 
> >  config DRM_FBDEV_EMULATION
> >         bool "Enable legacy fbdev support for your modesetting driver"
> > -       depends on DRM
> > -       depends on FB=y || FB=DRM
> > -       select DRM_KMS_HELPER
> > +       depends on DRM_KMS_HELPER
> > +       depends on FB=y || FB=DRM_KMS_HELPER
> >         select FB_CFB_FILLRECT
> >         select FB_CFB_COPYAREA
> >         select FB_CFB_IMAGEBLIT
> > 
> > That would probably make it work for DRM=y, FB=m, DRM_KMS_HELPER=m,
> > but it needs more randconfig testing, which I can help with.
> 
> Looks good to me as well.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Is the mess I created sorted now, or something for me to do? I'm terribly
burried in stuff :-/
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
