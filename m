Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCD741187D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbhITPkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241891AbhITPkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:40:03 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08695C061766
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:38:37 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id w64-20020a9d3646000000b0054716b40005so3066834otb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M1GmJpImkQw6oqUdA7Cxs3NXEIJfwV+W0nlaojmq7tY=;
        b=QPxf4kJ5Ecxw0ZhOqGUAdQ7Ax8ylYAiHGSWFEbcpIwwvziliONhZSZLTch3/pPVUmD
         7ft4TT1TUMptaxzyQ38U8PudQq8OwP7KhwuYxcpUbpe9/qmI0tqLCRmN+gz/syb7qh5G
         8MCM28jfgjU0s1B1oBuQOJyAHkBI4iYVwlRJcsauYwgo7/WsrLMbjhXP+csQchrPQqji
         +q54I/YaNTG2NqQAHiyC4z+ViRhZjdTmwIfzgmNKfu0IMvyB3dKjhmKZzHis2M4Ys24m
         epSXUmHZoLcAaf1lZ8HZzqb7YrKQvXROp6no8Ph7DxWS+vLqbAHh4n9NtJ3AtaK9KEZ+
         S4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M1GmJpImkQw6oqUdA7Cxs3NXEIJfwV+W0nlaojmq7tY=;
        b=1hyIzh+zh8+U3JNz16FK1zVA8CiIt62Uuk2J5doBewmpKbfDjlPiR6aV1ItGL8/f8n
         wLyWIh7sQBLBwTemTAWu3VWnHCO1bYXqImvKGktmXFJiudzWrAzyHtE84Tvnxa6T14u/
         p03+JiqVdn58UuOTYAO8NvAJEd0mWd+wHAvCPhF3BLOt+RP9Ma2CqkIm6EwfP/Uf89yy
         rlsN1+dOkW81QuOKc8Y+XveZgtqrLUeKKHThcQAXomql/UJSL9k5rafASZkyr9T5jwh4
         V4+Z2o5m+T+C7ZYiqb1BGGrKWVWogApGKVZDOF6enawJjqq5mvPor+YsBh4g6pjJX6Q0
         7tDg==
X-Gm-Message-State: AOAM5315NX1ekNMeTQybLtI8VS2RAFHorZVT21glEUwi9fqg0uWSoZTR
        96Vqko2xvhgFfxmjCu5g+ceX4I5yfdPjbNyPyhQ=
X-Google-Smtp-Source: ABdhPJy5kOwJ6xdBRJAAsXYaF0mSVvfdpNm+jirzOurESWCqJYxLKJqTU4BcWjJZbRoFRsAPBFY8QsdmMD5jok1+jq0=
X-Received: by 2002:a05:6830:214c:: with SMTP id r12mr21753938otd.200.1632152316355;
 Mon, 20 Sep 2021 08:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210920121606.93700-1-arnd@kernel.org>
In-Reply-To: <20210920121606.93700-1-arnd@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 20 Sep 2021 11:38:23 -0400
Message-ID: <CADnq5_NDpx8HOgZKx2qx=fh-j-MYtcZifBR5LFMVWvzwhENKqw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix empty debug macros
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Zhan Liu <zhan.liu@amd.com>,
        Ashley Thomas <Ashley.Thomas2@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, Jun Lei <Jun.Lei@amd.com>,
        Wesley Chalmers <Wesley.Chalmers@amd.com>,
        Lee Jones <lee.jones@linaro.org>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Wyatt Wood <wyatt.wood@amd.com>, Jude Shih <shenshih@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 8:16 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Using an empty macro expansion as a conditional expression
> produces a W=1 warning:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c: In function 'dce_aux_transfer_with_retries':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:775:156: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   775 |                                                                 "dce_aux_transfer_with_retries: AUX_RET_SUCCESS: AUX_TRANSACTION_REPLY_I2C_OVER_AUX_DEFER");
>       |                                                                                                                                                            ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.c:783:155: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   783 |                                                                 "dce_aux_transfer_with_retries: AUX_RET_SUCCESS: AUX_TRANSACTION_REPLY_I2C_OVER_AUX_NACK");
>       |                                                                                                                                                           ^
>
> Expand it to "do { } while (0)" instead to make the expression
> more robust and avoid the warning.
>
> Fixes: 56aca2309301 ("drm/amd/display: Add AUX I2C tracing.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_aux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> index e14f99b4b0c3..3c3347341103 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
> @@ -42,7 +42,7 @@
>  #define DC_LOGGER \
>         engine->ctx->logger
>
> -#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
> +#define DC_TRACE_LEVEL_MESSAGE(...) do { } while (0)
>  #define IS_DC_I2CAUX_LOGGING_ENABLED() (false)
>  #define LOG_FLAG_Error_I2cAux LOG_ERROR
>  #define LOG_FLAG_I2cAux_DceAux LOG_I2C_AUX
> @@ -76,7 +76,7 @@ enum {
>  #define DEFAULT_AUX_ENGINE_MULT   0
>  #define DEFAULT_AUX_ENGINE_LENGTH 69
>
> -#define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
> +#define DC_TRACE_LEVEL_MESSAGE(...) do { } while (0)
>
>  static void release_engine(
>         struct dce_aux *engine)
> --
> 2.29.2
>
