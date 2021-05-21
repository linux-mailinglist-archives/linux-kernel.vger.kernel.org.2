Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0AB038D05C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 23:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhEUV6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 17:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhEUV6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 17:58:35 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63823C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:57:12 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 80-20020a9d08560000b0290333e9d2b247so8807428oty.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 14:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=Pd7ky5cxDb+qxzJPiCzfS73ME9CuHoqRQM37v+k83B4=;
        b=hEWVM/nvf00TFCvYEtUvgRbGojwxiR3Xlb4OIR6nUJv/kcZu76ZTGZ7ogyUEeilbIC
         tZYDOwLEzD9l2dpBfqePGUkwUp2OYTw16Kip9gbdyR0H1OKM42auzXMCFM+47ulZUuph
         6Lym33huSHkbIkeNSWu3+jZgbAA1er/HDgAug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=Pd7ky5cxDb+qxzJPiCzfS73ME9CuHoqRQM37v+k83B4=;
        b=Vbz2QtP5b1NOiR2HoVComR5wlcLIGbLfAToXY9Gd0K+IvT+ZlQC12IW5hgMqUTZlNm
         6GblSkY8ujv7lxKanR+bKFxMTRvD1dqT0hpP9J67ukEC1KFpOzeB4ZFHAlIBIntKITnn
         uUieIBmLiZNgVipFVlMKIrSL21/inHqUPGgiSIIAE935ofw5wxRO6+1cKudJ33lwRTIC
         XARj5LVItWXk7OK70469VpAsPhSEy1DKAT6rw2f8mYMNeWkj8oCa42h2NyNjsDYePDbH
         EXogCdjM3n+34pXHHfYDwxkWfDKHEAyddLQ9a5VXfkh5hkNW7wVebHK4mtbUGWkgGJoY
         wreA==
X-Gm-Message-State: AOAM5309dMQA2Ww5DWLraMyDaUwZe35T6OEqt9v5bm2q47rBEmqU8hvh
        Wg2KIIk9waIYtwtu5z9HAN76UE0ZLhDKCYTU/2YuoA==
X-Google-Smtp-Source: ABdhPJyjbsrGqouAWtP/zueb6T/6vS7R8/wyCxfqpPAl8atKW0srTtbu4Y125oTZNM8SGNMwKaikdSMQ7jjhuRI9rTw=
X-Received: by 2002:a05:6830:4a1:: with SMTP id l1mr10235034otd.25.1621634231832;
 Fri, 21 May 2021 14:57:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 May 2021 14:57:11 -0700
MIME-Version: 1.0
In-Reply-To: <20210507212505.1224111-1-swboyd@chromium.org>
References: <20210507212505.1224111-1-swboyd@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Fri, 21 May 2021 14:57:11 -0700
Message-ID: <CAE-0n53jA7xPctEU9TkBf=eot4SGs85gpGMjUiDn_ZiMvVLvKw@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/msm/dp: Simplify aux code
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>, aravindh@codeaurora.org,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2021-05-07 14:25:02)
> Here's a few patches that simplify the aux handling code and bubble up
> timeouts and nacks to the upper DRM layers. The goal is to get DRM to
> know that the other side isn't there or that there's been a timeout,
> instead of saying that everything is fine and putting some error message
> into the logs.
>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Abhinav Kumar <abhinavk@codeaurora.org>
> Cc: Kuogee Hsieh <khsieh@codeaurora.org>
> Cc: aravindh@codeaurora.org
> Cc: Sean Paul <sean@poorly.run>
>

Kuogee, have you had a change to review this series?

> Stephen Boyd (3):
>   drm/msm/dp: Simplify aux irq handling code
>   drm/msm/dp: Shrink locking area of dp_aux_transfer()
>   drm/msm/dp: Handle aux timeouts, nacks, defers
>
>  drivers/gpu/drm/msm/dp/dp_aux.c     | 181 ++++++++++++----------------
>  drivers/gpu/drm/msm/dp/dp_aux.h     |   8 --
>  drivers/gpu/drm/msm/dp/dp_catalog.c |   2 +-
>  drivers/gpu/drm/msm/dp/dp_catalog.h |   2 +-
>  4 files changed, 80 insertions(+), 113 deletions(-)
>
>
> base-commit: 51595e3b4943b0079638b2657f603cf5c8ea3a66
> --
> https://chromeos.dev
>
