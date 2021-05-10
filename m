Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B113379899
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 22:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhEJUyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 16:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhEJUyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 16:54:43 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792AAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 13:53:35 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso14894959ots.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 13:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8aGDENpgNashF/y8nRQW6I2Y6zZGucstKVzqHjRFsU=;
        b=vSRh8f/TMD4wVjW+c+f86SHk9GFhpJ+6iMoCKIMHjn113P4xdqZSwfS19Udk/r1yzQ
         Vt1OpNUD36T61Abgo2OnxJon2RFxlH5e7yvcTVLn5XK5UFTqVzo5AX/qxMAWrh0xg1JI
         jipd/HrleT1roAeXnFo+c3N0P4het9NEfc4u8SrOx1jCCCn8bmAJsMs8nMUKuPiMQVeK
         bXoqtpbH7FcaT6mPznQBOQjuZAkTvChafyaX2prLczg9rtKJlFbtPCyAZCzCPEggckl5
         vTbI5Csfqcz78PohiKz/6wjOnCQ8YoG0bn+rQw3JzpYUnYtlwkPc2sbqKWekrgQ4Jlyv
         JmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8aGDENpgNashF/y8nRQW6I2Y6zZGucstKVzqHjRFsU=;
        b=kqMJnJJ7UfQmGm7DFJlZC/RiTUb8E7xMFCXqH5OvMaV1RnYTgQulRPgm/vxqnO7GhX
         rpywEHcjP4rJIvsx03BGNQNv5p0EPIQRVBSzUkkTjvHyKR19Ik0BDwHVFVZKpJ4dRVai
         YqhNHqoV0JCn84RpGwBwApBTRPBkYGHYmoo9ZXt2sidoaBIQGGRs3VSPzcEeafuqIUqG
         WOkneJFPiKYT700oB1K74UdZiVQ6apKA2lL80dDqLB72QI6vy8wHfQIVeYKi8Kb/Ruh5
         3IGqxgBXZK/Pz3VCKIb2TlP0++ZecDcKZAvCgJ7fUJvgXE2vzdOR5bDtB713SLmBdmDx
         0gpQ==
X-Gm-Message-State: AOAM530jd1CJ3tB8+rm57owYRo7etbLymX6yR4rclz2hqmal5CiHQW5B
        Ge2c7Kdf9s/jbd97YglP27icHaNR+UKYSQXJhIE=
X-Google-Smtp-Source: ABdhPJwCb3vb7rKVDNtAIbgy79+ccr1fhI2rzYQ0RcwwX+h6D4sSoRtQ7PbSiSJUrpVgZ7H2RyvU6sUBTQy/zPGHyOw=
X-Received: by 2002:a9d:51c6:: with SMTP id d6mr16606054oth.311.1620680014960;
 Mon, 10 May 2021 13:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210508181951.129548-1-rouven@czerwinskis.de>
In-Reply-To: <20210508181951.129548-1-rouven@czerwinskis.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 10 May 2021 16:53:23 -0400
Message-ID: <CADnq5_O0CF43q7BqhytoCp2c-bFSNri5_SEJosLdrWgwVA6-xA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove unused function dc_link_perform_link_training
To:     Rouven Czerwinski <rouven@czerwinskis.de>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sun, May 9, 2021 at 11:42 AM Rouven Czerwinski <rouven@czerwinskis.de> wrote:
>
> This function is not used anywhere, remove it. It was added in
> 40dd6bd376a4 ("drm/amd/display: Linux Set/Read link rate and lane count
> through debugfs") and moved in fe798de53a7a ("drm/amd/display: Move link
> functions from dc to dc_link"), but a user is missing.
>
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 13 -------------
>  drivers/gpu/drm/amd/display/dc/dc_link.h      |  3 ---
>  2 files changed, 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 3fb0cebd6938..55c5cf2264b3 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -3553,19 +3553,6 @@ void dc_link_set_drive_settings(struct dc *dc,
>         dc_link_dp_set_drive_settings(dc->links[i], lt_settings);
>  }
>
> -void dc_link_perform_link_training(struct dc *dc,
> -                                  struct dc_link_settings *link_setting,
> -                                  bool skip_video_pattern)
> -{
> -       int i;
> -
> -       for (i = 0; i < dc->link_count; i++)
> -               dc_link_dp_perform_link_training(
> -                       dc->links[i],
> -                       link_setting,
> -                       skip_video_pattern);
> -}
> -
>  void dc_link_set_preferred_link_settings(struct dc *dc,
>                                          struct dc_link_settings *link_setting,
>                                          struct dc_link *link)
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
> index fc5622ffec3d..45c927cd27ab 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_link.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
> @@ -363,9 +363,6 @@ bool dc_link_is_hdcp22(struct dc_link *link, enum signal_type signal);
>  void dc_link_set_drive_settings(struct dc *dc,
>                                 struct link_training_settings *lt_settings,
>                                 const struct dc_link *link);
> -void dc_link_perform_link_training(struct dc *dc,
> -                                  struct dc_link_settings *link_setting,
> -                                  bool skip_video_pattern);
>  void dc_link_set_preferred_link_settings(struct dc *dc,
>                                          struct dc_link_settings *link_setting,
>                                          struct dc_link *link);
> --
> 2.31.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
