Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4613C5ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 17:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbhGLPJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 11:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbhGLPJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 11:09:15 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CACC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 08:06:25 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id z25so11369718qto.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9baPyoe19aSY4gVB/3oWJMLdAbb4C4qxIoTSkRWfKs=;
        b=fidzIvRNZBVUP6B/wA+TNckKJdtJ2HpsB1mzlLN7JAky5Ot74bN92JSMLxrLzKzeii
         YiD5iB6nv8GuuasMmsdQnfr41naE74briTafCcpO5TLXEpLSvNgHGU7nJj0YreVHLLhx
         N26O5dgEWa36eceGc7lm6KtBS3TOObj6FmlJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9baPyoe19aSY4gVB/3oWJMLdAbb4C4qxIoTSkRWfKs=;
        b=ugVRR1uTSEeeHWtvzgwE0xIvUDOaP8JVvpew0ttfIXkc22tna6Jvld20jDoDkP1vMF
         81lfr4MX9A83Qct+1IITfrxlB8BtfnUxairLsWpqetueI1fNpVeAvs+Ey5LZvg3s9lRF
         VIKWApASYjNLfUww61Nf+R3ZeYEsKYIEIfVpvJZB5pJ5/KeZSvR+LKnTCPbmzqxqFFHp
         DiEB3k85L75QCsMZs24fZ5R0cunhkWc7Trrd8kiSnHKLpUAo5wQur2GDAZxngm0P0mzX
         5GqwaGbryvauB4fB7eGTtXuBKiA7qn6Q2KYuAu5CidIGebxujVkSOo3AlLXp2DaYBDpX
         hfMA==
X-Gm-Message-State: AOAM531TxQFxSl5jN6tgZksFqpD0Ij3NpV2c8pVF7cF5oFgF2LS/k1NK
        EIYVYuGEQAqmKs4PfRr0HmwEIzXjllKn2Q==
X-Google-Smtp-Source: ABdhPJy0Tqemm+mD4UcnGADegueH+5TOiXqE7p3VZksACGHRQYK+Z/yAO0t8wpSO7mq3r6BlyD5AsQ==
X-Received: by 2002:ac8:147:: with SMTP id f7mr931961qtg.350.1626102384968;
        Mon, 12 Jul 2021 08:06:24 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id n184sm6602370qkb.22.2021.07.12.08.06.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 08:06:23 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id g19so29486322ybe.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 08:06:23 -0700 (PDT)
X-Received: by 2002:a25:80d4:: with SMTP id c20mr65334614ybm.345.1626102382992;
 Mon, 12 Jul 2021 08:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210709152909.1.I23eb4cc5a680341e7b3e791632a635566fa5806a@changeid>
 <67ff22da55104dda57a0015e073cdfcc@codeaurora.org>
In-Reply-To: <67ff22da55104dda57a0015e073cdfcc@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 12 Jul 2021 08:06:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UOmJpX1Jwkc+U9_S9f1G8Ta46WXPmu0YRT1YadO6rYOA@mail.gmail.com>
Message-ID: <CAD=FV=UOmJpX1Jwkc+U9_S9f1G8Ta46WXPmu0YRT1YadO6rYOA@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: Move panel DP AUX backlight support to drm_dp_helper
To:     Rajeev Nandan <rajeevny@codeaurora.org>
Cc:     Lyude Paul <lyude@redhat.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Robert Foss <robert.foss@linaro.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 10, 2021 at 3:29 AM <rajeevny@codeaurora.org> wrote:
>
> > @@ -209,18 +208,11 @@ static inline int
> > of_drm_get_panel_orientation(const struct device_node *np,
> >  #if IS_ENABLED(CONFIG_DRM_PANEL) &&
> > (IS_BUILTIN(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
> >       (IS_MODULE(CONFIG_DRM) && IS_MODULE(CONFIG_BACKLIGHT_CLASS_DEVICE)))
>
> Thanks, for the fix. Changes look good to me. I checked this on Trogdor
> Lazor device.
>
> I have one small doubt, shouldn't we add above (or similar) check around
> drm_panel_dp_aux_backlight() in drm_dp_helper source & header files?
> This function is using devm_backlight_device_register() that needs
> CONFIG_BACKLIGHT_CLASS_DEVICE for compilation.
>
> If that's not an issue,
> Reviewed-by: Rajeev Nandan <rajeevny@codeaurora.org>

Indeed you are correct. I tried trying off the
CONFIG_BACKLIGHT_CLASS_DEVICE and it was unhappy. I've posted a v2
which I think fixes this [1]. I left your review tag off to give you a
chance to confirm I didn't goof anything else up in the v2. Thanks!

[1] https://lore.kernel.org/lkml/20210712075933.v2.1.I23eb4cc5a680341e7b3e791632a635566fa5806a@changeid/

-Doug
