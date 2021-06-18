Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987173ACAC5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhFRM2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhFRM2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:28:11 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED2CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:26:01 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f10so2463765plg.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtvRSpK7Pxq8m04Oitu7ZY1AFuH4Tsebb6LT2aC3kXk=;
        b=MMbWdywBw/P4HbxDiNgJhorMDPwOu9wbDxQ5Uxfbg0KoNzvKjyMs8UCelWuPXQi7Tg
         k/n4AgTTVfzb5mzdRIBnMQmSVgoRL2ys88LucvNZSvU/dLT3Bh2DIfiBMBkQ9iWU8vER
         fj/VU2fklavyP+QjqM/Tg8ojzn98NguHsBxR6hdokDfsEnBZp6jBrrVEUm4CWWJHaqHO
         SEn4szK6CxGwY6wc/m1TmAgaKYSDE/YtLenunwh0/MptBc9wkkjEUH67PWtZtrmSzKy+
         c0JuOcpbhfgUt4c3DPoxtfCpH0Hlg7iYMrHAnlLv9qg+aXSYiZ45mKlH9Icqv+IuALpA
         pg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtvRSpK7Pxq8m04Oitu7ZY1AFuH4Tsebb6LT2aC3kXk=;
        b=RZ+P6svUejITvLXtxEmBRL204qGSiCGqqepfry52Fm4wNbp06RFTDgE7NO5K5t2QMX
         HtpcaBaL8F7wiDZkFiAKPMUGIOTvGHAkBXTtAnYJMx8U5Udd+Yes7z01KsgC9zMAAxDe
         cEdKaiytiPIvs6b5Ivee5kdTGy8/ETqV/VPBYuUMEBpqyLN09Jbw41UBiLDNvNtzRe+9
         6vAXIAqWHC8FqsEpIzD6+Dz8EJFbgXkHpT8SV8ftkpEysNbWxMvB46VN8TrTdrBglwrl
         orW/Bz/Zdi2GEHbgZpvcZWwbqkf6+m6iVLriINw1lrs6H1igclMXyY4fABohoWxR4UIY
         +D2g==
X-Gm-Message-State: AOAM531EAp6lTRe1z7uYn7gO1f38XcV8zNd7WUtxu9/3BmOmUv6xUNq8
        FioUBePOUzmfgS3SWGDuQU5qjNwozf9kZZMgr00qHg==
X-Google-Smtp-Source: ABdhPJxmtC/wiE6zI2cJLpRdGM3FaqouAZvoriEKYQhaiLJ8O/RWEvL+Xx961UWRC3wvThhX2uahmDye4vjmobAhwOo=
X-Received: by 2002:a17:90a:c394:: with SMTP id h20mr14178061pjt.222.1624019161098;
 Fri, 18 Jun 2021 05:26:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210615032937.2328468-1-pihsun@chromium.org> <CA+Px+wXsb69fyQ41aX9T0jXzKFoF+6Y0zO+QJcLkxfTJJNa1hQ@mail.gmail.com>
In-Reply-To: <CA+Px+wXsb69fyQ41aX9T0jXzKFoF+6Y0zO+QJcLkxfTJJNa1hQ@mail.gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Fri, 18 Jun 2021 14:25:49 +0200
Message-ID: <CAG3jFyvNzgmpNYUi0EWocdn9enjNJAwpdBRZEDbL1afTM=59LQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Make hpd workqueue freezable
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed checkpatch --strict issue and pushed to drm-misc-next.

https://cgit.freedesktop.org/drm/drm-misc/commit/?id=f03ab6629c7b410d874151cf1d8570899a65fdda
