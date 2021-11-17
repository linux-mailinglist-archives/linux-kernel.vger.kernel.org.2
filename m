Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CE7454B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 17:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbhKQQxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 11:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhKQQw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 11:52:56 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30129C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:49:58 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id v23so4023163iom.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=81zghY8ilRWKTudyGP6JsOkrppbpNH0CaOi9j8PUljw=;
        b=oLkzkYBuHoPUuoqD3iFsTInCMvKmSNBQa6shdWUG+EiqyJjtKk3ZohZ2+6L7h4YxLy
         CoXyJfD+sriT5aNAHjkwBBTMqUvnp63+rFblrFZ1M0uoYKRx8EAiSMwcbMOEWYHo2alw
         zQcypyVDn8l2+FyM3FVFUYp7TRvhTTFkrkLR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=81zghY8ilRWKTudyGP6JsOkrppbpNH0CaOi9j8PUljw=;
        b=gDPAl4poMHUbcBCFgDzJA7GvJYcHlsNr4Cdegpc3LS+oZzV1N61CQURDUzypdT1qBG
         TCP1bzJ1cHEbhZc55muiRaxAxtOciYdY7Ddy5AcF4YPmlgUIu6RR0q0GXbDDTyVbJNtG
         3IOPZseAGom8d64o1lXpsPmlvyit4dJWKiSfEazoPHfSxZUP+r7Q85Az8Fqr196A2TQi
         BS5BP/nysrfN6dOJQ1BOhuo+JPIVMwypmIxV9pJG20JVoaeQILY4XRuiIt1M7IBNbX2b
         ztA8JtUFaOSUFJGjhOhI9/XlgmtSi8x7Vi6vmcCNSyJ0z+zQ6wMk+4EnEBdMUCk2c3iU
         PQLg==
X-Gm-Message-State: AOAM532SRkoexOVYb6rPOPYe3S3aNNR6Ydw5kd9OkNVrgthh4pyL4S37
        q7QxxWw3ac0jmsr/OtDT71gC1Ty6WLC9QQ==
X-Google-Smtp-Source: ABdhPJxUo9Qe32AemYN0XRxsg422x5RvaYgVDTecNajphv+CQLS+oe6Zc5kxLYLYI6B+FBm7slTdyQ==
X-Received: by 2002:a02:734d:: with SMTP id a13mr14643437jae.113.1637167797298;
        Wed, 17 Nov 2021 08:49:57 -0800 (PST)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id c9sm176618iom.9.2021.11.17.08.49.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 08:49:55 -0800 (PST)
Received: by mail-io1-f41.google.com with SMTP id z18so4054065iof.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 08:49:55 -0800 (PST)
X-Received: by 2002:a05:6602:2d84:: with SMTP id k4mr12229047iow.168.1637167794919;
 Wed, 17 Nov 2021 08:49:54 -0800 (PST)
MIME-Version: 1.0
References: <20211117163239.529781-1-kieran.bingham+renesas@ideasonboard.com>
In-Reply-To: <20211117163239.529781-1-kieran.bingham+renesas@ideasonboard.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 17 Nov 2021 08:49:43 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VM9H8Fow49V2eLs2Jfv6DmPYpDGNyHicc_802RksTZYQ@mail.gmail.com>
Message-ID: <CAD=FV=VM9H8Fow49V2eLs2Jfv6DmPYpDGNyHicc_802RksTZYQ@mail.gmail.com>
Subject: Re: [PATCH] gpu: drm: panel-edp: Fix edp_panel_entry documentation
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 17, 2021 at 8:32 AM Kieran Bingham
<kieran.bingham+renesas@ideasonboard.com> wrote:
>
> The edp_panel_entry members 'delay' and 'name' are documented, but
> without the correct syntax for kernel doc.
>
> This generates the following warnings:
>
> drivers/gpu/drm/panel/panel-edp.c:204: warning: Function parameter or member 'delay' not described in 'edp_panel_entry'
> drivers/gpu/drm/panel/panel-edp.c:204: warning: Function parameter or member 'name' not described in 'edp_panel_entry'
>
> Fix them accordingly.
>
> Fixes: 5540cf8f3e8d ("drm/panel-edp: Implement generic "edp-panel"s probed by EDID")
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks! Pushed to drm-misc-next (though technically it's a fix, it
didn't seem urgent enough to go through -fixes. Hopefully this is OK).

1e66f04c14ab gpu: drm: panel-edp: Fix edp_panel_entry documentation

-Doug
