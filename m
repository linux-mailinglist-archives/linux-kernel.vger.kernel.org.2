Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B14416715
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 23:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243213AbhIWVKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 17:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243174AbhIWVKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 17:10:33 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBA8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:09:01 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h20so8039596ilj.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkU/dtmrPkLlNRfdPptlfZzv/FhZk/4ZvW2hk6zURpI=;
        b=n4ZVMkZSH0hixxB2pfEOXMKJlfyYXsX+oDaRcNKXuC9SXVD3Ug6P0u9jmcow7/hNgF
         preIQcQFKUe0KIv9iCdJ5N08JEbJr6f8uG4lEcN7iLSwixMV2/ZuzMX8ln0JdUapl+Pg
         DCoAHAPIlDIn3e9UIRo9gfsjcltUG6NUBvhdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkU/dtmrPkLlNRfdPptlfZzv/FhZk/4ZvW2hk6zURpI=;
        b=J1aBOnVBEGp6Etag+izFUcAIS1wFq17im0Zg2xz9Mymae6aRDZK5vCl31xnJMnOhzo
         a9Io46fp4x3rU28jjeAgal6kITfR5/HW6SQQg3+aKUTMPyHRjA2uFJDmoJRELbz9x+4W
         xHWQsNNxNA3gVilRp1k+dvoqKapZIwm2AWoe/0j0wwWhuAMx3nqIfuDSPBbwXCgWrjw0
         tFWoGhwKJEDfMCHVzfstvFFVbrEk4lXz/mUmqDdt6F4jpdasntnptW/19m+zp+lm4QTY
         wFH0SdVWrbeCad1Wxv0vERBkwXV+N0Ve/Ei5YNfv2bToscxXtAwTMq101zBi9zvk3Emk
         VNQA==
X-Gm-Message-State: AOAM530JAT4GoSrzCx0ukarPY5q9uieom37xsf8xIcAEzvwvVaJzrLiY
        QkgHlg8aEkaAUqlnYSu7JCMplpkupDlOPA==
X-Google-Smtp-Source: ABdhPJyLtkOVKfpeX2iuWGglb8epgoMIpbb30Q8cuPRkSM/yiIJUebEGFaxIOs+yJuiSPfbLE6xxFg==
X-Received: by 2002:a05:6e02:1a6b:: with SMTP id w11mr5398716ilv.21.1632431341154;
        Thu, 23 Sep 2021 14:09:01 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id f5sm3164545ils.3.2021.09.23.14.09.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 14:09:01 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id x2so8048804ila.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 14:09:01 -0700 (PDT)
X-Received: by 2002:a92:da0c:: with SMTP id z12mr5199978ilm.120.1632430953826;
 Thu, 23 Sep 2021 14:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210921110556.v6.1.I2351df94f18d5d8debc22d4d100f36fac560409a@changeid>
In-Reply-To: <20210921110556.v6.1.I2351df94f18d5d8debc22d4d100f36fac560409a@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 23 Sep 2021 14:02:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XNSb-ZNoHzjUQJ2JntF3D4nAoKQ_OLo_7jLomnvdFJ6Q@mail.gmail.com>
Message-ID: <CAD=FV=XNSb-ZNoHzjUQJ2JntF3D4nAoKQ_OLo_7jLomnvdFJ6Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] drm/bridge: parade-ps8640: Use regmap APIs
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 21, 2021 at 11:06 AM Philip Chen <philipchen@chromium.org> wrote:
>
> Replace the direct i2c access (i2c_smbus_* functions) with regmap APIs,
> which will simplify the future update on ps8640 driver.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Philip Chen <philipchen@chromium.org>
> ---
>
> (no changes since v4)
>
> Changes in v4:
> - Remove excessive error logging from the probe function
>
> Changes in v3:
> - Fix the nits from v2 review
>
> Changes in v2:
> - Add separate reg map config per page
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 94 ++++++++++++++++++--------
>  1 file changed, 64 insertions(+), 30 deletions(-)

Pushed both patches to drm-misc-next:

13afcdd7277e drm/bridge: parade-ps8640: Add support for AUX channel
692d8db0a5ca drm/bridge: parade-ps8640: Use regmap APIs

I made a few whitespace fixes reported by `dim apply-branch` (DRM
committer tool) and also re-arranged your Signed-off-by to be above
the Reviews/Acks.

-Doug
