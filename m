Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6608E3A1218
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbhFILMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:12:46 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:38537 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbhFILMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:12:44 -0400
Received: by mail-lj1-f177.google.com with SMTP id s22so10695946ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UEmEhJRy3OP1xPt4yLPOXzII4gM5OzUq9kkp8l/Xvok=;
        b=ugy7xZQ+7+93G7dUIr6Hp2icQgcsPO/2hueMIo7Fi/D1w5oYszoADHu+HcJqnz1gEk
         aofijq0inLtV8T7Qw1drJwn56L+FGAmO2oQbMCdJq+0myJyuqs7/af90+c+t6sl4Zr+v
         vxb96PuuPSS3fCBq0RXADxmo4SmJozgOETR0V/onsQ0zPHgOJlxq4xBzVM27mQhG6MA8
         URhH1QGEF7hKNaFQM5QGYwzC6K9xVmkMAPMBjwLnu1vpBOE0u2ObDFt7w1PLCdFsmsO5
         OIeWhoyDFP2BIRcZehpWxV3K6xl++n+H34hi7ud9xLXqn624vxbJpC+IOM+5kmAb/mC4
         X4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UEmEhJRy3OP1xPt4yLPOXzII4gM5OzUq9kkp8l/Xvok=;
        b=YcA0hTEe+VH1jLFRH8koAde9iTkOrup3LgyIDPS/yfB1D+vVHoPdf4ts6xNmF99LxH
         caH8bjFLH1fepUl2Jh4By+sd3n9sM2gJIb17hcZ4uWwOZo7gp2qNPS2NAvdvf5uBmmSw
         Y4eQ6MAb/obqkkPSZixGWtzo6ibpNzoCcldODtTn64nidlfMZ8LEgVuJuEB1FjxkxuEk
         FWM2Mn6Z5Ud0gYu6WWK3+qCxP7h4z9FOUzdtlYg4fTIU3l8r9GzDPiQVZTeduupBw/vy
         aS6ZM77Q5OYPTEFGrWPK9xnmhMqZ23Tc/lRmB9LlpvhTTbV3c9RELJ4zawkqAeyxtoGU
         hilg==
X-Gm-Message-State: AOAM530FEWZi7K3BK3d6Lx/PbqhhkH0Jb0a6/yvcc0Llf7kYwyZb826z
        Y9CwGsCwbw6zJGGV+EiM1vIz/7htmwZ1vHn1mXcmCg==
X-Google-Smtp-Source: ABdhPJyMLoBLDIRG5xKEy7bVqMqGX94w0qiryrDa8by3M6lJ0F89j5oh2ybqvmg8q+DMNwfB6uBVIWMg1Zh3OeLMHwY=
X-Received: by 2002:a05:651c:1501:: with SMTP id e1mr22737718ljf.74.1623236989363;
 Wed, 09 Jun 2021 04:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210607170555.4006050-1-dianders@chromium.org> <20210607100234.v9.10.I24bba069e63b1eea84443eef0c8535fd032a6311@changeid>
In-Reply-To: <20210607100234.v9.10.I24bba069e63b1eea84443eef0c8535fd032a6311@changeid>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Jun 2021 13:09:38 +0200
Message-ID: <CACRpkdZq6XX7zKbdQU1GhaMGvWSC7isO4UoO1iVqs-4An0FQKg@mail.gmail.com>
Subject: Re: [PATCH v9 10/11] drm/bridge: ti-sn65dsi86: Improve probe errors
 with dev_err_probe()
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Clark <robdclark@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Steev Klimaszewski <steev@kali.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Lyude Paul <lyude@redhat.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 7:06 PM Douglas Anderson <dianders@chromium.org> wrote:

> As I was testing to make sure that the DEFER path worked well with my
> patch series, I got tired of seeing this scary message in my logs just
> because the panel needed to defer:
>   [drm:ti_sn_bridge_probe] *ERROR* could not find any panel node
>
> Let's use dev_err_probe() which nicely quiets this error and also
> simplifies the code a tiny bit. We'll also update other places in the
> file which can use dev_err_probe().
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
