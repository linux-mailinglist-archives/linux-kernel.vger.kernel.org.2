Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E17454DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 20:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbhKQTPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 14:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbhKQTP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 14:15:26 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE909C061764
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:12:27 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id t23so8593511oiw.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 11:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8poPPwRgM2gaVTV5trUbBXO75bFqyuZii+WWGUFhSUc=;
        b=N+xC7yXKAWA9x8ahmu3oKmzKLStvcsJhqk2y6WTGCbT0Va+XoOZ9Z6S4MIwhDwszVf
         vzjkO5FuVdIv7eWc7/ciUCtfTHJSoJpRnVjQAN5y0dgTj6sr3S7SmUh/veJrJTXoE1iY
         q1bcFdQOLqgR4oa1VQm+boj0ZJxEKjQ2NAjWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8poPPwRgM2gaVTV5trUbBXO75bFqyuZii+WWGUFhSUc=;
        b=akGiFWO22JWt5fS7gPSRzis4wgDnexzF+8/ItkkO/lmM3MhhUEOFB7iyRvNAMrYsYp
         WHb2qAgPGTDm6tvlR7uhqg5tSk5IDwVFn/rZjkPAch8k2a3p/4DQsvuD1GPp2CedBkke
         OWHjhaWZkmhHV8VF8bKFQlRWG3B4liAc38pY7bumtQc2zFgIWLli+8K5pdGOCOT0WHOX
         kFgnXD2i9zk9uxJ1hb+gOu8Vgb75WsdFDPqCFkeRlGVEH8LZE/0m50tnFAatH7pCbZ3v
         O4dtl4NP7QmT/kLATmPwYjRkqU1m7pxA/XQoyjJYea0hZPCDmqulXHIPv2M+CqdzOf64
         7jiw==
X-Gm-Message-State: AOAM532Cv/UYysIOqaYFqq+tvfFDf1zqPxgAlXjIKgYrUzRNejdPd6do
        pCBmnoOJ9rLL/bgr5zyPM2nWW57WuNtwyyhGcDQkKg==
X-Google-Smtp-Source: ABdhPJyGQbPU5Q2n6iY9zBti9tKr6yqheIXyLucNvCVq5fT3KcHHtRF6zxqDf3nc+NDzuABlXJfAK4gi9CHqBBTkryU=
X-Received: by 2002:a05:6808:1413:: with SMTP id w19mr2063094oiv.128.1637176347058;
 Wed, 17 Nov 2021 11:12:27 -0800 (PST)
MIME-Version: 1.0
References: <20211103234018.4009771-1-briannorris@chromium.org> <20211103164002.2.Ie6c485320b35b89fd49e15a73f0a68e3bb49eef9@changeid>
In-Reply-To: <20211103164002.2.Ie6c485320b35b89fd49e15a73f0a68e3bb49eef9@changeid>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 17 Nov 2021 20:12:15 +0100
Message-ID: <CAKMK7uHGNrgqjQh3DX4gChpNt+xhB_39sVrhdA3BFqnoW-ue2w@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/self_refresh: Disable self-refresh on input events
To:     Brian Norris <briannorris@chromium.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        linux-rockchip@lists.infradead.org,
        "Kristian H . Kristensen" <hoegsberg@google.com>,
        Doug Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 4, 2021 at 12:40 AM Brian Norris <briannorris@chromium.org> wrote:
>
> To improve panel self-refresh exit latency, we speculatively start
> exiting when we
> receive input events. Occasionally, this may lead to false positives,
> but most of the time we get a head start on coming out of PSR. Depending
> on how userspace takes to produce a new frame in response to the event,
> this can completely hide the exit latency.
>
> In local tests on Chrome OS (Rockchip RK3399 eDP), we've found that the
> input notifier gives us about a 50ms head start over the
> fb-update-initiated exit.
>
> Leverage a new drm_input_helper library to get easy access to
> likely-relevant input event callbacks.
>
> Inspired-by: Kristian H. Kristensen <hoegsberg@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Can you pls resend with dri-devel on cc? scripts/get_maintainers.pl
should pick this up, you have all the maintainers but not the list.
-Daniel

> ---
> This was in part picked up from:
>
>   https://lore.kernel.org/all/20180405095000.9756-25-enric.balletbo@collabora.com/
>   [PATCH v6 24/30] drm/rockchip: Disable PSR on input events
>
> with significant rewrites/reworks:
>
>  - moved to common drm_input_helper and drm_self_refresh_helper
>    implementation
>  - track state only through crtc->state->self_refresh_active
>
> Note that I'm relatively unfamiliar with DRM locking expectations, but I
> believe access to drm_crtc->state (which helps us track redundant
> transitions) is OK under the locking provided by
> drm_atomic_get_crtc_state().
>
>  drivers/gpu/drm/drm_self_refresh_helper.c | 54 ++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_self_refresh_helper.c b/drivers/gpu/drm/drm_self_refresh_helper.c
> index dd33fec5aabd..dcab061cc90a 100644
> --- a/drivers/gpu/drm/drm_self_refresh_helper.c
> +++ b/drivers/gpu/drm/drm_self_refresh_helper.c
> @@ -15,6 +15,7 @@
>  #include <drm/drm_connector.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_device.h>
> +#include <drm/drm_input_helper.h>
>  #include <drm/drm_mode_config.h>
>  #include <drm/drm_modeset_lock.h>
>  #include <drm/drm_print.h>
> @@ -58,17 +59,17 @@ DECLARE_EWMA(psr_time, 4, 4)
>  struct drm_self_refresh_data {
>         struct drm_crtc *crtc;
>         struct delayed_work entry_work;
> +       struct work_struct exit_work;
> +       struct drm_input_handler input_handler;
>
>         struct mutex avg_mutex;
>         struct ewma_psr_time entry_avg_ms;
>         struct ewma_psr_time exit_avg_ms;
>  };
>
> -static void drm_self_refresh_helper_entry_work(struct work_struct *work)
> +static void drm_self_refresh_transition(struct drm_self_refresh_data *sr_data,
> +                                       bool enable)
>  {
> -       struct drm_self_refresh_data *sr_data = container_of(
> -                               to_delayed_work(work),
> -                               struct drm_self_refresh_data, entry_work);
>         struct drm_crtc *crtc = sr_data->crtc;
>         struct drm_device *dev = crtc->dev;
>         struct drm_modeset_acquire_ctx ctx;
> @@ -95,6 +96,9 @@ static void drm_self_refresh_helper_entry_work(struct work_struct *work)
>                 goto out;
>         }
>
> +       if (crtc->state->self_refresh_active == enable)
> +               goto out;
> +
>         if (!crtc_state->enable)
>                 goto out;
>
> @@ -107,8 +111,8 @@ static void drm_self_refresh_helper_entry_work(struct work_struct *work)
>                         goto out;
>         }
>
> -       crtc_state->active = false;
> -       crtc_state->self_refresh_active = true;
> +       crtc_state->active = !enable;
> +       crtc_state->self_refresh_active = enable;
>
>         ret = drm_atomic_commit(state);
>         if (ret)
> @@ -129,6 +133,15 @@ static void drm_self_refresh_helper_entry_work(struct work_struct *work)
>         drm_modeset_acquire_fini(&ctx);
>  }
>
> +static void drm_self_refresh_helper_entry_work(struct work_struct *work)
> +{
> +       struct drm_self_refresh_data *sr_data = container_of(
> +                               to_delayed_work(work),
> +                               struct drm_self_refresh_data, entry_work);
> +
> +       drm_self_refresh_transition(sr_data, true);
> +}
> +
>  /**
>   * drm_self_refresh_helper_update_avg_times - Updates a crtc's SR time averages
>   * @state: the state which has just been applied to hardware
> @@ -223,6 +236,20 @@ void drm_self_refresh_helper_alter_state(struct drm_atomic_state *state)
>  }
>  EXPORT_SYMBOL(drm_self_refresh_helper_alter_state);
>
> +static void drm_self_refresh_helper_exit_work(struct work_struct *work)
> +{
> +       struct drm_self_refresh_data *sr_data = container_of(
> +                       work, struct drm_self_refresh_data, exit_work);
> +
> +       drm_self_refresh_transition(sr_data, false);
> +}
> +
> +static void drm_self_refresh_input_event(void *data)
> +{
> +       struct drm_self_refresh_data *sr_data = data;
> +
> +       schedule_work(&sr_data->exit_work);
> +}
>  /**
>   * drm_self_refresh_helper_init - Initializes self refresh helpers for a crtc
>   * @crtc: the crtc which supports self refresh supported displays
> @@ -232,6 +259,7 @@ EXPORT_SYMBOL(drm_self_refresh_helper_alter_state);
>  int drm_self_refresh_helper_init(struct drm_crtc *crtc)
>  {
>         struct drm_self_refresh_data *sr_data = crtc->self_refresh_data;
> +       int ret;
>
>         /* Helper is already initialized */
>         if (WARN_ON(sr_data))
> @@ -243,6 +271,7 @@ int drm_self_refresh_helper_init(struct drm_crtc *crtc)
>
>         INIT_DELAYED_WORK(&sr_data->entry_work,
>                           drm_self_refresh_helper_entry_work);
> +       INIT_WORK(&sr_data->exit_work, drm_self_refresh_helper_exit_work);
>         sr_data->crtc = crtc;
>         mutex_init(&sr_data->avg_mutex);
>         ewma_psr_time_init(&sr_data->entry_avg_ms);
> @@ -256,8 +285,19 @@ int drm_self_refresh_helper_init(struct drm_crtc *crtc)
>         ewma_psr_time_add(&sr_data->entry_avg_ms, SELF_REFRESH_AVG_SEED_MS);
>         ewma_psr_time_add(&sr_data->exit_avg_ms, SELF_REFRESH_AVG_SEED_MS);
>
> +       sr_data->input_handler.callback = drm_self_refresh_input_event;
> +       sr_data->input_handler.priv = sr_data;
> +       ret = drm_input_handle_register(crtc->dev, &sr_data->input_handler);
> +       if (ret)
> +               goto err;
> +
>         crtc->self_refresh_data = sr_data;
> +
>         return 0;
> +
> +err:
> +       kfree(sr_data);
> +       return ret;
>  }
>  EXPORT_SYMBOL(drm_self_refresh_helper_init);
>
> @@ -275,7 +315,9 @@ void drm_self_refresh_helper_cleanup(struct drm_crtc *crtc)
>
>         crtc->self_refresh_data = NULL;
>
> +       drm_input_handle_unregister(&sr_data->input_handler);
>         cancel_delayed_work_sync(&sr_data->entry_work);
> +       cancel_work_sync(&sr_data->exit_work);
>         kfree(sr_data);
>  }
>  EXPORT_SYMBOL(drm_self_refresh_helper_cleanup);
> --
> 2.34.0.rc0.344.g81b53c2807-goog
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
