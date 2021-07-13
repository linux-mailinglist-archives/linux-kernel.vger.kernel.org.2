Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDCF3C682B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 03:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhGMBlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 21:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhGMBll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 21:41:41 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5709EC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 18:38:52 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id h5so11346379vsg.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 18:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gVRoZz+2KZUE01RCl0zcI7r1nciW52XhEXHIAydI07s=;
        b=usFkAnZeCrSGtXvu1Y8dMHuJA2eouw7ILheGbnV+sFCegmKn5HTPJAPen3DsFLR6BP
         zLozZPA6LqWpdACeZI9kQYLd3smukMrdawmnBRRV+POXT1N7CUoCELlqwZ6SUlzBVO5N
         lXnBQJyZfqezmP5vzr6O2ZXPiqvD+Dl1iwJ23vTnBRFQWlaw8tVEIqnn+hCDNtgHRoM0
         z5fxtLrcfNk0qx8+anefIjthpGgPNZsJXDGnlp4XR2rdd+NvgzpnWxkMJlUI/i05Zkdm
         tdCMsZEkP0EPZ0Rykte/7HYCflhoSxXjb1uF0tsrf+sj8Mec8ds8tP2ufVwbbszCcdag
         jl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gVRoZz+2KZUE01RCl0zcI7r1nciW52XhEXHIAydI07s=;
        b=jkUI7eernji2Ih0GRlz802ndCLj4xWCDlrkbi8zfyAAOvDVykO0WeG9R+ufLzr45Ez
         cyJyhyly1eQZI8GA1Kv1qyTKUHDTW5liqg9Ie+UNoVP7H5AFs/55MUosfqiB5ChgsXvL
         rUF/D2sDdr2F8zxvh45qYrEABrpFKVwsDIXpmib6HjXYEu3V8OIlSyeqJHE63AGUsJv6
         +DkMW8wfZl3iEuYTs4yrNPXJE2khmr1OsUmMxygyEOUeRwSJmz3r2C19rTmcsRQaK8u4
         SqZVFLp7Gf6cr1tq0e8dI/zS2cxU9eBWq67R6ntzrNE1MHa8xMZD4v9vxx4nbqwIk6Qd
         8YdQ==
X-Gm-Message-State: AOAM532S9Dz36eFg71BrTSUYdwTAxHNABwHnBsYSPQDIoCxKlWspfW/j
        aVbQtjyavcrlgoWBs0wJ3ZDbIWtmCG1h0ifR38I=
X-Google-Smtp-Source: ABdhPJwiJvHoN1KeOA+yHTm5cOf0dNXY5PwMTenqd7lD/48NL0Y5MQRaddEnECPmspaIE+NqPRaUpkqa0nCvi1EXLPU=
X-Received: by 2002:a05:6102:732:: with SMTP id u18mr2935020vsg.14.1626140331187;
 Mon, 12 Jul 2021 18:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210711055003.528167-1-jim.cromie@gmail.com> <20210711055003.528167-2-jim.cromie@gmail.com>
 <e9f8186b3b96ba909f156fd750ba0aaf3d60a5fa.camel@perches.com>
In-Reply-To: <e9f8186b3b96ba909f156fd750ba0aaf3d60a5fa.camel@perches.com>
From:   jim.cromie@gmail.com
Date:   Mon, 12 Jul 2021 19:38:25 -0600
Message-ID: <CAJfuBxyRvPbjBQ0dVL5g9SL=hRgKxNKaadb5cxeEoEWt56k-Gg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] drm_print.h: rewrap __DRM_DEFINE_DBG_RATELIMITED
 macro
To:     Joe Perches <joe@perches.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, Jason Baron <jbaron@akamai.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2021 at 10:17 AM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2021-07-10 at 23:49 -0600, Jim Cromie wrote:
> > whitespace only, to diff-minimize a later commit.
> > no functional changes
> []
> > diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> []
> > @@ -524,19 +524,24 @@ void __drm_err(const char *format, ...);
> >  #define DRM_DEBUG_DP(fmt, ...)                                               \
> >       __drm_dbg(DRM_UT_DP, fmt, ## __VA_ARGS__)
> >
> >
> > -#define __DRM_DEFINE_DBG_RATELIMITED(category, drm, fmt, ...)                                        \
> > -({                                                                                           \
> > -     static DEFINE_RATELIMIT_STATE(rs_, DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);\
> > -     const struct drm_device *drm_ = (drm);                                                  \
> > -                                                                                             \
> > -     if (drm_debug_enabled(DRM_UT_ ## category) && __ratelimit(&rs_))                        \
> > -             drm_dev_printk(drm_ ? drm_->dev : NULL, KERN_DEBUG, fmt, ## __VA_ARGS__);       \
> > +#define __DRM_DEFINE_DBG_RATELIMITED(category, drm, fmt, ...)                \
> > +({                                                                   \
> > +     static DEFINE_RATELIMIT_STATE(rs_,                              \
> > +                                   DEFAULT_RATELIMIT_INTERVAL,       \
> > +                                   DEFAULT_RATELIMIT_BURST);         \
> > +     const struct drm_device *drm_ = (drm);                          \
> > +                                                                     \
> > +     if (drm_debug_enabled(DRM_UT_ ## category)                      \
> > +         && __ratelimit(&rs_))                                       \
>
> Though I don't really see the need for the change, the typical style
> has the logical continuation at the end of the test.
>

yes I caught that late, old habit, hard to break.
That if-statement is altered as part of HEAD+2
    drm: RFC add choice to use dynamic debug in drm-debug

which replaces drm_dev_printk with drm_dev_dbg
(which calls pr_debug in DRM_USE_DYNAMIC_DEBUG)


>         if (drm_debug_enabled(DRM_UT_ ## category) &&                   \
>             __ratelimit(&rs_))                                          \
>
>
