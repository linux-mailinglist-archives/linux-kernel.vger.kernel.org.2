Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EEA417D5E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344224AbhIXWBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 18:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344195AbhIXWBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 18:01:02 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4BFC061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:59:29 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id q205so14502165iod.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2sQbzmqOLaa21D/rAV+moo+kYzU+T5wGBoSvZFQoujo=;
        b=k8yvuVRCC6FqRS0v1P7blOuRsgBy/yhKtUdUiAyralseuHTygqFpQOclrMrBx950dS
         cyoM2vDSrBMyBhKnByXnYt/lccbFvLZY3dxRImMEKXVnIKGMGelfV86vJzL1OrlnkQdv
         aLiPXYuPZgWgI4nQUU1FgEwVIpGgnsyvcBZF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2sQbzmqOLaa21D/rAV+moo+kYzU+T5wGBoSvZFQoujo=;
        b=LBaClAx6lqEkaiG2/onyspcp8uIxD3Tcm6p1YfbXgXfZ2n7vUVHx7xMhz5KnqiytPF
         qLTfM8Uf9Zm3vF+swp6k8r7Zo0dNEUxDLm6rdlQtoA6rVsNHO/QbwqWSpOI7x8Ud4tc/
         RyeejrgMHH7VncelbulT2uJ1lOXmacocEvV+KmPALH/g2iybgS6YyTmLu5vHtHr8hnVv
         cdWwGcVNRFrGB5yfQLm90cM9umdkd5oY8Bywwl19sCT0HpDn6RftIpTeSJO13Zc7J6OD
         VZpGes51p8+sQOpXzbxGr6jB2EdgxtPO8bftVfJEfgAieUwdpcBnEx4CZCtlIVwh4ze7
         sgEw==
X-Gm-Message-State: AOAM533T3k2m8Wp6xeG1U42Cb1OjAwWT++29CP+aCYL4/0cMF4HIAyOM
        I4cuHu7psVrStU4Ssnr/aLc8GZbM/K0zlA==
X-Google-Smtp-Source: ABdhPJwopgKhmskf5dGbCVVskhxhtsOr10eGyiErxBa2ZtPG243dk7FDCrDaGgJBdYKbdwyxG5pf7w==
X-Received: by 2002:a5d:9cd4:: with SMTP id w20mr11274755iow.172.1632520768417;
        Fri, 24 Sep 2021 14:59:28 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id h1sm4175958iow.12.2021.09.24.14.59.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 14:59:28 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id b8so11931846ilh.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:59:27 -0700 (PDT)
X-Received: by 2002:a05:6e02:1b0c:: with SMTP id i12mr10210513ilv.27.1632520767633;
 Fri, 24 Sep 2021 14:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210921082757.RFC.1.Ibd82d98145615fa55f604947dc6a696cc82e8e43@changeid>
In-Reply-To: <20210921082757.RFC.1.Ibd82d98145615fa55f604947dc6a696cc82e8e43@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Sep 2021 14:59:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UMkkSrCQHfsUwkc_W8BmG-doH8jmNC1ckrh4w1rYbcxA@mail.gmail.com>
Message-ID: <CAD=FV=UMkkSrCQHfsUwkc_W8BmG-doH8jmNC1ckrh4w1rYbcxA@mail.gmail.com>
Subject: Re: [RFC PATCH] drm/print: Add deprecation notes to DRM_...() functions
To:     dri-devel <dri-devel@lists.freedesktop.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 21, 2021 at 8:28 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> It's hard for someone (like me) who's not following closely to know
> what the suggested best practices are for error printing in DRM
> drivers. Add some hints to the header file.
>
> In general, my understanding is that:
> * When possible we should be using a `struct drm_device` for logging
>   and recent patches have tried to make it more possible to access a
>   relevant `struct drm_device` in more places.
> * For most cases when we don't have a `struct drm_device`, we no
>   longer bother with DRM-specific wrappers on the dev_...() functions
>   or pr_...() functions and just encourage drivers to use the normal
>   functions.
> * For debug-level functions where we might want filtering based on a
>   category we'll still have DRM-specific wrappers, but we'll only
>   support passing a `struct drm_device`, not a `struct
>   device`. Presumably most of the cases where we want the filtering
>   are messages that happen while the system is in a normal running
>   state (AKA not during probe time) and we should have a `struct
>   drm_device` then. If we absolutely can't get a `struct drm_device`
>   then these functions begrudgingly accept NULL for the `struct
>   drm_device` and hopefully the awkwardness of having to manually pass
>   NULL will keep people from doing this unless absolutely necessary.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  include/drm/drm_print.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Landed in drm-misc-next:

306589856399 drm/print: Add deprecation notes to DRM_...() functions
