Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DA737071E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 14:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhEAMIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 08:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbhEAMIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 08:08:09 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39234C06138B
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 05:07:19 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j4so1160825lfp.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 05:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cShhxOov7yPyGv2gqNT9J0Wvb5A03fZum4wVgMZcev0=;
        b=bovKm0NsrMUQ92+ShbG6eIgqrhlAYcOckDEUfVkF9aUE77zfmA0yY6m+pLbCntRryr
         xmy6WV+CNWATAVNw548V3+baVqI5Aw1ZD4yWFGZgZCKjp/OolvYQ+zYKPS4eWd4CqbsH
         RNaJmOYvOmdBRpQ8pPqsc69ddxVh6zVjS5jbgLSWXLHypgeucOjGHK2BmGdqDSlZ/hy1
         IAu5Tje2Qaygt85s7veL9m5QZVblRiVtz8wcaTLabRbdUM23JMSNz0U4DKEumaHys10d
         N+fsdhCHPYKuN3fgTdy3cy6CHzWn1jPJs0aGmBAFw8Ps0W/7B1raJyLy4oz1y8osYOMI
         RQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cShhxOov7yPyGv2gqNT9J0Wvb5A03fZum4wVgMZcev0=;
        b=ND/aCFLH1Ug20vImRbSGAfQ0CLBiDHwiPyhqN2ghi68dpr/hH2dZlvXbZTnQ2VQbrJ
         7k8at+q5m4w1YKzhGotpSmI4yGkTO81BvMM3VUtQmGbV79JRs2RmlZ5An0qyaG/HIIOg
         uQGIvKlemmO1Hsem3i0Vl0JxNxpqfjQwOi9G4vPqimqaAhB4WtIymnI0PZWafAmOJLYC
         kVlCuz+17VOsTuUgxM+8BOFp9jio6OayD/3QibJV4Zg8NvlZkQxcF3q8UhvtEFqKDBMv
         ukzG2KSIjylhJP/X2bNt/YWEPadothf/N+WBTJm+PMtLhYdMpcWbVnHrX40uMS5uXsnh
         siRw==
X-Gm-Message-State: AOAM531PBBCBH2gtLHYt8/CLwnqpHHdZ3b7lfuj43MDxRlAaPRyeOpNL
        ZieolCeHtETmCP5eOZIKTRMDvKyCpJu9cGMIdhfBEg==
X-Google-Smtp-Source: ABdhPJyBwdw5C0bHiY+W+PETkYMvzi+/Aa+5T0VzdotioKXyHm1/7V5opQjGZkISSW+Ddx6ZdzyULKJ0smN/s3mnWKE=
X-Received: by 2002:a05:6512:149:: with SMTP id m9mr6205501lfo.157.1619870837611;
 Sat, 01 May 2021 05:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210423165906.2504169-1-dianders@chromium.org>
 <20210423095743.v5.1.I9e6af2529d6c61e5daf86a15a1211121c5223b9a@changeid>
 <CACRpkdYkRFLvCRPSYNzYQG58QgPfhvjtHb+FBQZadyrnjC8=1A@mail.gmail.com>
 <CAD=FV=UX683grZ=poTwKXxSqYBCLdLAOCxOPhE_xVVgKbe36Mw@mail.gmail.com>
 <CACRpkdYfugrJ4WGn=w+viGXE6s5cdHjLC++jHPLVy_QH09KA8Q@mail.gmail.com> <CAD=FV=XXxTz8hi92y6p3hX7iVEHuqKHsrKPSnX_a__WCEQRAKw@mail.gmail.com>
In-Reply-To: <CAD=FV=XXxTz8hi92y6p3hX7iVEHuqKHsrKPSnX_a__WCEQRAKw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 1 May 2021 14:07:06 +0200
Message-ID: <CACRpkdZVH=h37hSjvjcNmRwV-RoBB-nvUbrOT80DoLr7n81R3Q@mail.gmail.com>
Subject: Re: [PATCH v5 01/20] drm/panel: panel-simple: Add missing
 pm_runtime_disable() calls
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
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
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Fri, Apr 30, 2021 at 11:04 PM Doug Anderson <dianders@chromium.org> wrote:

> Pushed this one patch. Rest of the series is pending adult
> supervision. Overall summary:
>
> 1. I could probably push some of the early sn65dsi86 cleanup patches
> in this series since they have Bjorn's review and are pretty much
> no-ops / simple cleanups, but there's probably not tons gained for
> shoving those in early.

Those look good to me as well. I'd say just apply them.

To me it looks like up until and including patch 18?
Feel free to add my
Acked-by: Linus Walleij <linus.walleij@linaro.org>

On these.

> 2. The whole concept of breaking up the patch into sub-drivers has no
> official Reviewed-by tags yet. Presumably Bjorn will give those a
> re-review when he has time again.

It looks good to me so I sent an explicit ACK on that patch.

> 3. Laurent and I had a big discussion on #dri-devel yesterday about
> the EDID reading. He's not totally convinced with the idea of doing
> this in the panel when the bridge could just do it by itself, but it
> sounded like he might be coming around. Right now this is waiting on
> Laurent to have time to get back to this.

I dare not speak of this. Laurent has the long and tedious experience
with panels and pretty much anything related so if Laurent is
hesitant then I am hesitant too. His buy-in is absolutely required.

But IIUC that is just for patch 19+20?

It'd be good to apply the rest and get down the stack.

Just to keep you busy and make sure you don't run out of work
(haha) I noticed that the gpio_chip in this driver can use
the new GPIO_REGMAP helper library with the fixes just
landed in Torvald's tree.

At your convenience and when you think there is too little
stuff in your sn65dsi86 TODO, check out
pinctrl-bcm63xx.c for an example of select GPIO_REGMAP
made very simple (this works fine as long as they are bit
offsets starting from 0).

Yours,
Linus Walleij
