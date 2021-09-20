Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABDD412B05
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 04:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242594AbhIUCFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 22:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235952AbhIUBsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:48:24 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D52C0612E4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 14:38:05 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 194so22747649qkj.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 14:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z0sMXVJD/qM1ZuMvbaI6gTOYJ9VpknbVlhhM0u7mejc=;
        b=dqxJA24uvAfZPUBpFHKmJEIZgdzPyGPS0Sq6uvZjU0gc6erEbkuQ4zhpwP4QD8z72u
         sw1LryOdbgCoGAlU671GWf8D56poCdkftvi5n9UVH0kydllWBUbg1UpLhPhtIlsWyTEf
         1ut3yazIIgePgREspkn/NXAfNWrUlqhMj1SEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z0sMXVJD/qM1ZuMvbaI6gTOYJ9VpknbVlhhM0u7mejc=;
        b=FdKy5PZwU4mqh9CMk4/kL4MRHV5qxpD5TnookNnsvC79IO2fSDPtMWiUz5q7o0PMou
         mtl6KbjIqOk/ZqHSP2SYYU4VH9/Uvm51U9LjiJL5JjRTYEwV7JIhvKI7FHUwywwPqCTg
         1HpMqgCQtI4bnkChKeNU2kcs3Y0LFcBIBsEESJTtoL4fScgC0ZRokAwaQ4KMAxR2Pr1B
         PazFgHU1x4EsxvsUV4w4A55CdTnAHgnFU8B0YeL/OcIe/H5xqOu6cJt9o8tA+ShdEKLG
         JZijVVMrp1wWoZeYoySAQ7E1b8gqxsBFe9FVIwWq3DxYuPf6oDmXuuuHfVAW0NuquUm+
         Bq6A==
X-Gm-Message-State: AOAM531ee/Dwl0FhCShVTvqTNOk9cClo1yQwIVP/J8reP0jNtecorvZY
        VFzBYbdBjrA7kzdQz5zPBC1DWBq4zokvkUQf2AuaTA==
X-Google-Smtp-Source: ABdhPJyQjSb2H6udbpCD2GbTsqMT8sJOFWWkAqxky55HqdLzQrvRxx7S/aqKxyKWBV2AQNiIWArMAu4QAzyNU6Trgt8=
X-Received: by 2002:a25:2f42:: with SMTP id v63mr34378682ybv.388.1632173884292;
 Mon, 20 Sep 2021 14:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210918102058.v5.1.I2351df94f18d5d8debc22d4d100f36fac560409a@changeid>
 <20210918102058.v5.2.Ifcb5df5de5b1cead7c99e0f37b044ef5cfc69eda@changeid> <YUZMNIYbT7KL3qJR@ravnborg.org>
In-Reply-To: <YUZMNIYbT7KL3qJR@ravnborg.org>
From:   Philip Chen <philipchen@chromium.org>
Date:   Mon, 20 Sep 2021 14:37:53 -0700
Message-ID: <CA+cxXh=OixYPzE_ui=22seumFpKigTcK3hvNtrfN4oa0SFdtOw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] drm/bridge: parade-ps8640: Add support for AUX channel
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
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

Hi Sam,

On Sat, Sep 18, 2021 at 1:29 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Philip,
> On Sat, Sep 18, 2021 at 10:21:17AM -0700, Philip Chen wrote:
> > Implement the first version of AUX support, which will be useful as
> > we expand the driver to support varied use cases.
> >
> > Signed-off-by: Philip Chen <philipchen@chromium.org>
>
> Patch is:
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>
> please consider a few follow-up patches:
> 1) Replace deprecated drm_bridge_funcs with the _atomic_ variants.
> 2) Replace the deprecated drm_bridge_chain_pre_enable() with the atomic
>    variant.
> 3) Use pr_() and dev_() logging in favour of DRM_ logging.
>    DRM_ logging is deprecated these days and do not belong in bridge
>    drivers anyway.
>
> Maxime has a few patches pending for this driver - it would be great if
> you could look them up and review them.
> Maybe you can get some review in feedback.

Yes, I'll do.
Thanks for reviewing.

>
>         Sam
>
