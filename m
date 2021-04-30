Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8001536F37B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 03:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhD3B0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 21:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhD3B0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 21:26:06 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42DFC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 18:25:18 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id u48-20020a4a97330000b02901fa060b8066so428624ooi.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 18:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1QnMHl1bv4GYjD2nKUUJjqSbgwtkE7PlJ3sqyWNs7Y=;
        b=PtHlsQZOZ+E4ykn+R3l13RBajbWKW9bc5n0CxdJOHTPMz4PSUer/AJh9vCysr5UYOv
         SuCTrQprrgY+vi68vThE0YH88YfY2vB8BtuvkvLHFzNcfsD3Qo++eWfTMmQBN66+qcZx
         YA3c9pl9Lat5hMK3NWhl/lTgmlPl8zmEwFMKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1QnMHl1bv4GYjD2nKUUJjqSbgwtkE7PlJ3sqyWNs7Y=;
        b=Heys2vRbcKARvUeoM9/udEYWn3xGLbxcj6STLUWvZjB3QWcN2N7JTc2vMQ8IZpRxln
         84s/cxe2mySZ+gZkFiYelmekq54WOXnY0XFUuVILMtm4TScACC0/ALHM1e82IQO5oZ+i
         gqKPcVH45IKLDe4yErpsHhWoc7NnThsVUpNUgGeHcusG1XJcAqS9I6KX4l8EB53h+/fG
         y1wxMR+aBncVwxlO6PdkAn8iINIUBs1rIngzEhcp9Rdn+rMqBoJt2N3Y1QfG6I0VXUAJ
         WDvoZBWyIlwIif7bRHBYANloUDLEbYrJeNUtKevXbCSnGB69VepYYpdYxxcaNoNZutOF
         BfTA==
X-Gm-Message-State: AOAM5308HiRpNwTfytoEXwoUMlNHMEFe4JgbFtmbPGGP0AU8SqH+/+gl
        bNrpEEpajMdpvUscncUZvTZBh9nVegx6vg==
X-Google-Smtp-Source: ABdhPJyuC4fcv3NNraUgCNDDbHgiU9cKah/xwNV+N8Fts4Fdo5zrcfj7DY2VbE1rJIJX3hFkxUt9lg==
X-Received: by 2002:a4a:e386:: with SMTP id l6mr2249671oov.81.1619745917921;
        Thu, 29 Apr 2021 18:25:17 -0700 (PDT)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com. [209.85.210.43])
        by smtp.gmail.com with ESMTPSA id l7sm359977oov.5.2021.04.29.18.25.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 18:25:17 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id v23-20020a9d60570000b02902a53bac99a3so8344669otj.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 18:25:17 -0700 (PDT)
X-Received: by 2002:a25:80d4:: with SMTP id c20mr3510159ybm.345.1619745906527;
 Thu, 29 Apr 2021 18:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210423165906.2504169-1-dianders@chromium.org>
 <20210423095743.v5.1.I9e6af2529d6c61e5daf86a15a1211121c5223b9a@changeid> <CACRpkdYkRFLvCRPSYNzYQG58QgPfhvjtHb+FBQZadyrnjC8=1A@mail.gmail.com>
In-Reply-To: <CACRpkdYkRFLvCRPSYNzYQG58QgPfhvjtHb+FBQZadyrnjC8=1A@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Apr 2021 18:24:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UX683grZ=poTwKXxSqYBCLdLAOCxOPhE_xVVgKbe36Mw@mail.gmail.com>
Message-ID: <CAD=FV=UX683grZ=poTwKXxSqYBCLdLAOCxOPhE_xVVgKbe36Mw@mail.gmail.com>
Subject: Re: [PATCH v5 01/20] drm/panel: panel-simple: Add missing
 pm_runtime_disable() calls
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sam Ravnborg <sam@ravnborg.org>, Wolfram Sang <wsa@kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Steev Klimaszewski <steev@kali.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 29, 2021 at 5:58 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Apr 23, 2021 at 6:59 PM Douglas Anderson <dianders@chromium.org> wrote:
>
> > In commit 3235b0f20a0a ("drm/panel: panel-simple: Use runtime pm to
> > avoid excessive unprepare / prepare") we started using pm_runtime, but
> > my patch neglected to add the proper pm_runtime_disable(). Doh! Add
> > them now.
> >
> > Fixes: 3235b0f20a0a ("drm/panel: panel-simple: Use runtime pm to avoid excessive unprepare / prepare")
> > Reported-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> This patch as such:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Notice however: you turn on pm runtime pm_runtime_enable()
> in panel_simple_probe() but are you ever turning it off in
> panel_simple_remove()?
>
> I think pm_runtime_disable(); need to be added there?

I'm a bit confused. You're saying that I need to add
pm_runtime_disable() to panel_simple_remove()? Doesn't this patch do
that? This patch adds two calls to pm_runtime_disable(). One of those
is in the probe error path and the other one is in
panel_simple_remove().

-Doug
