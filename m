Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D18426E4F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243220AbhJHQC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243100AbhJHQC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:02:57 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC25C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 09:01:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so8138162pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 09:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mJr70vtcSbn8HkbIjoqrY+nokUtRVQIO9WTnKtmG5ik=;
        b=qJIOqw5PCw7aJXLpxzhrrCUO7UnCMmPBBpJADmTgebLKqc3R6Yt9mvPXF1qhp+cFxK
         UKFkMylm0fZz+4vhhL46VoJoaHCQf6J86LAi2zcTqDw8018Q3pNJZRy5rGH92gCw74E9
         3oYDDVIwGKvrQjIdEmNpiRH+x9iw3B0d6RHRCGVnwaj7bbYXyb85MrFfOgNUKvPN/5Bh
         EaAR6lHa0EZPg+sw283+W9qmw1ljfzMnFYajJE5gsoPfM+ErTIVcQWYUis6l3dC8VlB1
         6EimFCaCIuEbt1SGFHI6Ou3TSJDaVwItfIwxhYLWlYGq9p6sr9zdT4q6Y5+BQF9Qqfbh
         sgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mJr70vtcSbn8HkbIjoqrY+nokUtRVQIO9WTnKtmG5ik=;
        b=KjderrTf99nA88KDqZ9fckqp1vVhejQ4ha4nea+aFq3YY54kDCUj8sDbCjqj61cj/H
         toNxILXJHlI00taMk4237ZASzg4R/A6XN/b96HOghxRt49A4xWiQLghMhiPMjXjnF18N
         WMbjDruU80ijdIC/bPIPP2HSFS59m2ZQpc/C1z5t2juKy6ROOV0tHqW0eoZvWm4uRu7H
         HFFPXnbDyFZb13tmAkmt4Pv0CXZkmYUHxQhPzYyVCiFb1EUEOUfuyjSxrz8rRmaWnHxP
         SJvT5b4KTebypkRoIc9F/dNg36IsgKMzvpTKvhmuIsqqBUrFwp7u/biorFDqRZZFfb2K
         eyhQ==
X-Gm-Message-State: AOAM533FU+zYCsRTySFxQBzLbGCACt7nf9b+TrvGBjJpmQMT95O7Qvw+
        K5kd6UBDssXeMi4mprv0krAg38lutl6b35fMFtTTlL8jqvelaPf1
X-Google-Smtp-Source: ABdhPJw2mT/8VUBkZuHdEM/x3If4KXMLcmxLKFmb5zR9aK5AH+CfwKfkE7xSLXja/Ljm5kmIqRq/mfjTrsf50IcgMZ4=
X-Received: by 2002:a17:90b:1644:: with SMTP id il4mr9831056pjb.179.1633708861847;
 Fri, 08 Oct 2021 09:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211007094723.202330-1-allen.chen@ite.com.tw>
In-Reply-To: <20211007094723.202330-1-allen.chen@ite.com.tw>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 8 Oct 2021 18:00:50 +0200
Message-ID: <CAG3jFyu-nG8jttSfkZ-ZZAg7W9SRFFDWsA9=g7Z1JbNhxBLuyw@mail.gmail.com>
Subject: Re: [PATCH v9] drm/bridge: add it6505 driver
To:     allen <allen.chen@ite.com.tw>
Cc:     Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@google.com>,
        Hsin-yi Wang <hsinyi@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Allen,

I was running the pre-merge checks, and hit some build issues. This
was built against todays drm-misc-next branch, which I would like you
to rebase your patch against.

drivers/gpu/drm/bridge/ite-it6505.c: In function =E2=80=98it6505_bridge_ato=
mic_enable=E2=80=99:
drivers/gpu/drm/bridge/ite-it6505.c:2919:15: error: implicit
declaration of function =E2=80=98drm_bridge_new_crtc_state=E2=80=99; did yo=
u mean
=E2=80=98drm_atomic_get_new_crtc_state=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
 2919 |  crtc_state =3D drm_bridge_new_crtc_state(bridge, old_state);
      |               ^~~~~~~~~~~~~~~~~~~~~~~~~
      |               drm_atomic_get_new_crtc_state
drivers/gpu/drm/bridge/ite-it6505.c:2919:13: warning: assignment to
=E2=80=98const struct drm_crtc_state *=E2=80=99 from =E2=80=98int=E2=80=99 =
makes pointer from integer
without a cast [-Wint-conversion]
 2919 |  crtc_state =3D drm_bridge_new_crtc_state(bridge, old_state);
      |             ^
