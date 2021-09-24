Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5207417D58
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344128AbhIXWAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 18:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344020AbhIXWAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 18:00:19 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5693DC061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:58:46 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id b8so11930240ilh.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=69bjUxd0RSwLVJJ5pHki/PEG52ZQR8S8G5aZawWTWAE=;
        b=bFTIzSROv4wRwSesV3HIvC7HamOkX4V5NdJsUi2LYgB3tqhHnYTNuLSwzqehf28pBG
         4CFNjtHN6Bt3oQqEbMJ4Ssse6VAs3HqPy20pn4mbkZ3Hjbk0miqpu98swKR2aj4TFS6F
         Eh70EFpyzmPdzWotzeFw3MbhtzUa4rtKHTi2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=69bjUxd0RSwLVJJ5pHki/PEG52ZQR8S8G5aZawWTWAE=;
        b=kboP3tNXql6dRru+tpv03CLjkApLz9ucBHADhnbow7Gh/g+kaLezzV6Mk4wz/NUC1O
         KKaDpAFg3/t8PWecveV/HbLsHsrbwSQjcV8mY7OYJpTOeKAZlSVkkOVM/QF6pQCYkqjl
         beLX7IzWH05vCpUrk/0jdy0C+mrMHlosCNGXnQ9mBaH7mYX4uG6XlG+KrhwFs8/CEqiu
         xOKwd/NC5PmMGtEnJCEMoJe+OyCu//PaeGzTbXdRCc3+0Ki7oRsx15PxmhAtniY/m76C
         APKDJ7yRwdkOjm3vQQbblN4IbfP0mRtNaSxHQUpvHDRyGCEpkoLOvnbK5kMBjnTq2kbj
         m9TA==
X-Gm-Message-State: AOAM533n25VGtHGr2c6FgFBcJjv1gHOT72RqPImLQ4rEj9sGoD/EWzGe
        3wS08k5YHVEsquegS8CrdmiOKg3IkrqC4A==
X-Google-Smtp-Source: ABdhPJwSB+QKUntlohJXXRGjwJ7sqomZPb1Bu84B0C9a1e+W+TQgLSSGrEXoZ5tY93xeuAsLmxZw3w==
X-Received: by 2002:a92:db0b:: with SMTP id b11mr10189453iln.275.1632520725658;
        Fri, 24 Sep 2021 14:58:45 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id x5sm4449898ioa.35.2021.09.24.14.58.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 14:58:45 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id n71so14623608iod.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:58:44 -0700 (PDT)
X-Received: by 2002:a5d:8b4b:: with SMTP id c11mr11114257iot.98.1632520724643;
 Fri, 24 Sep 2021 14:58:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210924075317.1.I1e58d74d501613f1fe7585958f451160d11b8a98@changeid>
In-Reply-To: <20210924075317.1.I1e58d74d501613f1fe7585958f451160d11b8a98@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Sep 2021 14:58:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XMMYjmzxSTE3EgjhdcNX9zpuMzqOHZYAnFXspz+HTJ6w@mail.gmail.com>
Message-ID: <CAD=FV=XMMYjmzxSTE3EgjhdcNX9zpuMzqOHZYAnFXspz+HTJ6w@mail.gmail.com>
Subject: Re: [PATCH] drm/edid: Fix EDID quirk compile error on older compilers
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Srikanth Myakam <smyakam@microsoft.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        LinusW <linus.walleij@linaro.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 24, 2021 at 7:53 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> Apparently some compilers [1] cannot handle doing math on dereferenced
> string constants at compile time. This has led to reports [2] of
> compile errors like:
>
>   In file included from drivers/gpu/drm/drm_edid.c:42:0:
>   ./include/drm/drm_edid.h:525:2: error: initializer element is not constant
>     ((((u32)((vend)[0]) - '@') & 0x1f) << 26 | \
>
> Go back to the syntax I used in v4 of the patch series [3] that added
> this code instead of what landed (v5). This syntax is slightly uglier
> but should be much more compatible with varied compilers.
>
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69960#c18
> [2] https://lore.kernel.org/r/874kaabdt5.fsf@intel.com/
> [3] https://lore.kernel.org/r/20210909135838.v4.4.I6103ce2b16e5e5a842b14c7022a034712b434609@changeid/
>
> Fixes: d9f91a10c3e8 ("drm/edid: Allow querying/working with the panel ID from the EDID")
> Reported-by: Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>
> Reported-by: Srikanth Myakam <smyakam@microsoft.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  drivers/gpu/drm/drm_edid.c        | 121 +++++++++++++++---------------
>  drivers/gpu/drm/panel/panel-edp.c |  23 +++---
>  include/drm/drm_edid.h            |  14 ++--
>  3 files changed, 81 insertions(+), 77 deletions(-)

Landed in drm-misc-next:

7d1be0a09fa6 drm/edid: Fix EDID quirk compile error on older compilers
