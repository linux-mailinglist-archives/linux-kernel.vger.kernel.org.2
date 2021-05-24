Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F9A38F132
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 18:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbhEXQLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 12:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236753AbhEXQEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 12:04:36 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6376FC026BD4
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 08:15:15 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id c17so5980070vke.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 08:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hiXKO119GSaKQpX+psN+usfMuDJQ/GOJx+xCi36V10=;
        b=U/Ic0oyql6VSf1zMHtEy4mFLp+v9j8wB4h0j/Vp8yHCVYnaly6d7tpSDvlo8G1uHBG
         onMLvowml45t3Phb7Bu7NbF6vxIoTKOpA8zY6VOsOpeZPNaRe3LNzlYisU6IV8eLRjaT
         +IRU0yWNE2MZiNO9ukMoaEt1eOKN9HLESVPHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hiXKO119GSaKQpX+psN+usfMuDJQ/GOJx+xCi36V10=;
        b=V+hYH0S1fNtrkxG2k7WPtJ9ZN6UlkcjVYKM57w7bDO7rhwYYXd1CoxY3qXUX33Wfpq
         tGJ5u3UFZ0naVaKuTQ0Rh+GedXNWilSDAlngSiWmlfQEoXhtRtGadyNCoje/4MmWnZNW
         6eQitO4q7vbtrWZ2AajYSg4mpu4pLcB2mZdfX8Hr+syGu+FexZ95dLmHVULaJKADXGCn
         G6jWhouGoUai/v0GztPIKbxJMqP3JR4vJvIJBWvmQwE0MWsY7synTChnvtVJRaF+y6tT
         wZ3m0Qo+5/T3PViGrBkLq9LlmP3e757OYJwMpOSLxBGpjURSlLs9iqoganFnUf381BbS
         2X8w==
X-Gm-Message-State: AOAM531+t0mlSr6wR2jhtIM3kk6Xe13b2Xz+It3vMK8Hk5IBtVMDiZLH
        UWcS/aOBIvuXZjQXHm1Y5VfOR0vj8LDu4g==
X-Google-Smtp-Source: ABdhPJyMO5yY2HO6QRIuXudIdYUCevqKHE/0+mrZjnbZW8glQiYUV0KDpATSYHKDtTqna/5lpTvbQQ==
X-Received: by 2002:a05:6122:152:: with SMTP id r18mr21741251vko.11.1621869313920;
        Mon, 24 May 2021 08:15:13 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id h137sm1173828vka.27.2021.05.24.08.15.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 08:15:13 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id o192so14393327vsd.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 08:15:11 -0700 (PDT)
X-Received: by 2002:a05:6102:3239:: with SMTP id x25mr21095761vsf.47.1621869311242;
 Mon, 24 May 2021 08:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210517200907.1459182-1-dianders@chromium.org> <2536404ca2ab0e7b785a104ec6b4efb48943a438.camel@redhat.com>
In-Reply-To: <2536404ca2ab0e7b785a104ec6b4efb48943a438.camel@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 May 2021 08:14:59 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WqM6fTuk3g4Rt9D+Fn=P1aUQwM3Cjz-K2BXurMB2AQ5A@mail.gmail.com>
Message-ID: <CAD=FV=WqM6fTuk3g4Rt9D+Fn=P1aUQwM3Cjz-K2BXurMB2AQ5A@mail.gmail.com>
Subject: Re: [PATCH v7 00/10] drm: Fix EDID reading on ti-sn65dsi86 by
 introducing the DP AUX bus
To:     Lyude Paul <lyude@redhat.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus W <linus.walleij@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Andy Gross <agross@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 21, 2021 at 4:07 PM Lyude Paul <lyude@redhat.com> wrote:
>
> For patches 5, and 6:
>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
>
> This week got really busy so I wasn't able to look at the rest of them, but next
> week is going to be a lot less busy so I should be able to look at them then

Thanks for your review on the two patches and for letting me know your
plans. I know that I still need to spin the bindings patches with Rob
Herring's feedback, but I won't do that until I know you're done
reviewing just to avoid spamming everyone an extra time. Assuming no
emergency comes around and slams me, I should be able to react/respond
fairly quickly this week M-Th, though I'm taking Friday off.

BTW: if anyone reading this happens to have 10 minutes, I'd sorta like
to get patch #1 in this series landed sooner rather than later and
it's a dead-simple fix. If I see a review of that one, I'll apply it
to drm-misc before sending out the next version of the series. ;-)

-Doug
