Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852CF350265
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbhCaOdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 10:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236064AbhCaOcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 10:32:31 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A256AC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 07:32:30 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id z10so19471519qkz.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 07:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i5wECuC5weZgjdPi3xLPpPAVwy9+CVkNbVRnPB22rV4=;
        b=Cb1kQzuwRvV8yJG2PLXhPjMlw/q8NuMLEfvdtsAcm9Hb41ToBl/n+b4hL0HBxKy2i/
         leYphrDJFXbTdKb8aRPx+K+wqzaQBnHyonEd1P1gmCBoIUhXmpdP/cI9wzWFC9LwNxHR
         7eLWNY4hAwXmzzSt0QeXdkggESIdeZ5jlp/wQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i5wECuC5weZgjdPi3xLPpPAVwy9+CVkNbVRnPB22rV4=;
        b=Uu5kE2/jHyEsMeG5Rdu/kUUu16oGVdw/yMtjJXEZMLNY6iTgUwi3Z+Jjc109nBIvGX
         MfWCyVb89XPQblCxJP8RpSm/M1ro3pUO2MYotS1uG2+sAi2XzreSRiCurxKpCxNz+mwx
         ly1wCF6rhcFPtwwemS2xJSnLebbkHBwZ74cv+Af7/R0qT+O8U/iBlP7LZ+QVvCLN4ExH
         ccb9CXNGtCEU2C8IpMpFthv1N8ir0RRHDq8oJMennjp0k510LxDxgrXFWTYtWO30d5W/
         vHlquNrwYPa35PjPHnY/5V5YKyDPLkn1v3S+nVP2LEXr1J31f4AeZbOQNWDbF9D4jCd9
         OO6Q==
X-Gm-Message-State: AOAM530+aC/NruJhK/4QEzPUxrN4iomMZvUR3v4Grauj+VB1OqA2s09B
        mKOGpBo+PDE1pVQmOdU2y/KYugSIvzwD9g==
X-Google-Smtp-Source: ABdhPJwTvNlZxc7L2CL3v53/tdJz37xq/fy2w9ybM/uFRmFHWRbfC0iWv9+oaj3qj5rc2I2qHtOaRA==
X-Received: by 2002:ae9:e518:: with SMTP id w24mr3349831qkf.78.1617201149183;
        Wed, 31 Mar 2021 07:32:29 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id d23sm1497621qka.125.2021.03.31.07.32.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 07:32:28 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id w8so21415509ybt.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 07:32:27 -0700 (PDT)
X-Received: by 2002:a25:4092:: with SMTP id n140mr5092311yba.276.1617201144211;
 Wed, 31 Mar 2021 07:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210330025345.3980086-1-dianders@chromium.org>
 <CGME20210330025443eucas1p1e53f4fb8623c3dc2ae8ce514e3009bc5@eucas1p1.samsung.com>
 <20210329195255.v2.10.Ida6151df6bfc71df77afee1d72bb7eb0a443f327@changeid> <26d73f36-e150-57ec-d957-4b7bda6b366e@samsung.com>
In-Reply-To: <26d73f36-e150-57ec-d957-4b7bda6b366e@samsung.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 31 Mar 2021 07:32:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W6SABggAaBbw9LXdf5sHOGGQzZJp8YFmYcWG1yf1rW5w@mail.gmail.com>
Message-ID: <CAD=FV=W6SABggAaBbw9LXdf5sHOGGQzZJp8YFmYcWG1yf1rW5w@mail.gmail.com>
Subject: Re: [PATCH v2 10/14] drm/bridge: ti-sn65dsi86: Stop caching the EDID ourselves
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Steev Klimaszewski <steev@kali.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Robert Foss <robert.foss@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Mar 31, 2021 at 3:12 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
>
> W dniu 30.03.2021 o 04:53, Douglas Anderson pisze:
> > Now that we have the patch ("drm/edid: Use the cached EDID in
> > drm_get_edid() if eDP") we no longer need to maintain our own
> > cache. Drop this code.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Note that unless the advice given to me changes, I'm dropping
${SUBJECT} patch on the next spin and putting the EDID cache back in
the bridge driver. See:

https://lore.kernel.org/r/YGMvO3PNDCiBmqov@intel.com/


-Doug
