Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A02D3A1213
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236405AbhFILKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:10:37 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:46932 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbhFILKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:10:35 -0400
Received: by mail-lj1-f179.google.com with SMTP id e11so31096412ljn.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hO3vEEVdO0DPz+vO9KJvLBSJTaoPQXnru30sw8j8V+k=;
        b=tJ+IxUQX6y8nk471bg47+iouc2pnb5EzeCVGDMgfLNBUUydydIFqq6lhq/QTCdnxoi
         ETRyEs14qkwYFBNvb/vRgeiQw8SxbBcHxjYav9X1GrSQ3qaKSPkupNdkqkY/jwC+RDY7
         7A3o3Z4V/nSi5iyqhEr9hxnBtloNMkYSXpM+UjFwtN7Kz2HvnQ7P3YjmM5M0Q8/qTVHG
         3yVusC9NM0uIaOxkCxGe3ccLUlb59nfqak4qCXCkPmnMrkt4HxL+ZVO/zYUPfdsmP94r
         9cHO2x7EITXWT1XtHoIwzIklwSrrsHteBwexobdOewu31/N/V/hyIE6+7nbIgvvxrEUB
         CfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hO3vEEVdO0DPz+vO9KJvLBSJTaoPQXnru30sw8j8V+k=;
        b=LAWN/AW0qQx0Q/0asedZsL2zdj1WLpxktULmQRsiOe0p4EWUslMVw4wuVS3iZi+Qda
         59BiBTN8UJgi0rYp+fsfRbxoB4NWf81mH6H5yBrhVcbai26YjsTj095wsV+j/YidznUt
         er/SkNxkYZXsB094rt2cb1AfiMBAZZg/UWS2Vs+OGzOEMexbEQGU+m8rHlYPbQOQJW+K
         PJPoopIaz4XfAL5HHSV9LY3xPX7qadZELvnBQxYJv8j+A0TrEPWYK/jwv/9xb9QL4Y1e
         lKZk1yyssB5skTIBldZ3kElT8MxAsDT5FI6Z0/JvrJ+WzR7KYMP3fdCBrzmv8w5E4vAW
         4lOQ==
X-Gm-Message-State: AOAM530vSTTJbnWHOn7zadmC1Iuz1iaiFFmMdZZj5g/S2i85SN5PfEnn
        QLDE4QbMC0UVWSbK6wS83hqEDN8ij3xD7NcePKW1+Q==
X-Google-Smtp-Source: ABdhPJxL1/o/55M4zUInEECGJ8JlN2FQ3cBr/0HO5voXevIvLQKWpjpiW9USKNXD1KKnOZdv1T7oDDPbAU6x4fmJssI=
X-Received: by 2002:a2e:22c3:: with SMTP id i186mr22139779lji.273.1623236859907;
 Wed, 09 Jun 2021 04:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210607170555.4006050-1-dianders@chromium.org> <20210607100234.v9.6.I18e60221f6d048d14d6c50a770b15f356fa75092@changeid>
In-Reply-To: <20210607100234.v9.6.I18e60221f6d048d14d6c50a770b15f356fa75092@changeid>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Jun 2021 13:07:29 +0200
Message-ID: <CACRpkdaa=1LsyESZenDWv91mTX4H_AhwzGnSO2b9v8zXRMAvzw@mail.gmail.com>
Subject: Re: [PATCH v9 06/11] drm/panel: panel-simple: Stash DP AUX bus; allow
 using it for DDC
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
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 7:06 PM Douglas Anderson <dianders@chromium.org> wrote:

> If panel-simple is instantiated as a DP AUX bus endpoint then we have
> access to the DP AUX bus. Let's stash it in the panel-simple
> structure, leaving it NULL for the cases where the panel is
> instantiated in other ways.
>
> If we happen to have access to the DP AUX bus and we weren't provided
> the ddc-i2c-bus in some other manner, let's use the DP AUX bus for it.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
