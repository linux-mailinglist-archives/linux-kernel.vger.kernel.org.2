Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41E933EA90A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbhHLRDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbhHLRC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:02:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E294C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:02:32 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w6so1095697plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ajRQDl/gOVwvNbWEBhu//WfevoY6tePub/nv6KPeW3I=;
        b=aSb8j96vLHuOXO0FBSyas19kl6IAsLIMwmg3ku9T8nvfjewVuGPM33mLbilyC6rB8B
         tiQN+uh+75AyIBwHMJ2HEFtzZMiOGvWBIbRJ+QNJD9JmeqfkQ2t6nCwa69MOyn7D28MT
         srIZF9FLnI3BIgjTludpaGZhO7pBF+Wbbl2uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ajRQDl/gOVwvNbWEBhu//WfevoY6tePub/nv6KPeW3I=;
        b=iu1cRAXMAt9KISrNDz/jvVbi2zzlCmjsXu6A5ng0rD43p1+OffDLr5Qm80VKoJeFO0
         zTPzqYFuI1lgtgKp4v/+RpOBeq9CsMdQj6OHQNo7D+hDHplRyb5rUmkey2Cm5ZjMFq9n
         varfn7aRiKCwffYn0IasjsxQ1GLH3nmW9aaflnadQUmfo+e6G1gE3N60NuX2GV7u7U/i
         K6synHT+MjGxxhf+f7cb9cfxXeTS9c01lpURGJngcrIHq3J34oZfvobjiPgIkxDVbjEw
         VcdlWGdl0osJ4o8VHV7we0IWI7IsFQno2Fp1GsiOUrVPrm2Y633X1b1cxRldYXfrjrOy
         7C/Q==
X-Gm-Message-State: AOAM530/1YxYKJMOWWCEXrMCwIEhEEd2oYBtASH3iVHYNJFkF1Uq0pHm
        91IzZ4jFCdthDORGZDuxvWjeaUVbtOsgMw==
X-Google-Smtp-Source: ABdhPJxWi8ZinjQIAI3pE4+jos85ABaj+vTB+IZS3u0hnMhbyu6dup/E/Ju7oiRGX0Z8gSRjLwBIIg==
X-Received: by 2002:a62:154d:0:b029:3b9:e5df:77a6 with SMTP id 74-20020a62154d0000b02903b9e5df77a6mr4960073pfv.18.1628787751763;
        Thu, 12 Aug 2021 10:02:31 -0700 (PDT)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com. [209.85.216.42])
        by smtp.gmail.com with ESMTPSA id r78sm4293190pfc.206.2021.08.12.10.02.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 10:02:31 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso16252361pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:02:31 -0700 (PDT)
X-Received: by 2002:a92:a008:: with SMTP id e8mr3510493ili.187.1628787310662;
 Thu, 12 Aug 2021 09:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210811235253.924867-1-robdclark@gmail.com> <20210811235253.924867-2-robdclark@gmail.com>
In-Reply-To: <20210811235253.924867-2-robdclark@gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 12 Aug 2021 09:54:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V8RjS3+3L=_NxeuE8vGoFpPnK2NP+QT9WUYExDG_GY-g@mail.gmail.com>
Message-ID: <CAD=FV=V8RjS3+3L=_NxeuE8vGoFpPnK2NP+QT9WUYExDG_GY-g@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/bridge: ti-sn65dsi86: Avoid creating multiple connectors
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jagan Teki <jagan@amarulasolutions.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 11, 2021 at 4:51 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> If we created our own connector because the driver does not support the
> NO_CONNECTOR flag, we don't want the downstream bridge to *also* create
> a connector.  And if this driver did pass the NO_CONNECTOR flag (and we
> supported that mode) this would change nothing.
>
> Fixes: 4e5763f03e10 ("drm/bridge: ti-sn65dsi86: Wrap panel with panel-bridge")
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

I'm going to apply this one to drm-misc/drm-misc-next and push since
it's a fix and we're before -rc6, then I'll take a look at the later
patches in the series.

-Doug
