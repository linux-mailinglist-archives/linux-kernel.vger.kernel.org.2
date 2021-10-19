Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54EC4332CF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 11:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbhJSJto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 05:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbhJSJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 05:49:41 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEC8C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:47:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s1so11480314plg.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 02:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AW90+0ECu0jFh8CdzlWHccywuwAGlUm3CUlVVFXdqic=;
        b=fyP+7f/LVSu4Rs1PK5OiJMYlJXG9EEqWapYe/TDCTrJuP9To2ZJGCDg53mMkw/gxmM
         Fs9rJ1aGjQOmebk7RZuHNnhP6ABDlUjI7cyHSPd5SnRleJCceeF45ffEdhrIT2rs0nx7
         qMGITGCV00y6jzAQ/zaXQDqp+hoC3wGQEu4NVXEBOQHzSErshgK8R4q+RqvuFEeMcj44
         mt89gEcQ+XCXuCpsmT+9MNLSQnKxciyM6wyrtkE3XokIvdFofa4RxI47sJH5ToFPrXJF
         xLrPO0Ajp2XmD/ZAqDlfWvhDAPYEXLghaAGoVidVf0R0UIa2RKvk/noKjZx1hJ+E6QDz
         A7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AW90+0ECu0jFh8CdzlWHccywuwAGlUm3CUlVVFXdqic=;
        b=qS3aOQ4rB4N/aMe3kYmopDg9Ymw5bdpRSy0V1yQs9199yfcyICSr/pp/8JpRn4xskq
         AcLEOEYHEN5bRPl4qTIOltjOSn3eSO9EMs+Lag9/KSinEoVr3duWeU6X/dcwG5DCOX8p
         Hfn7hhH5Ty/MgtFCc49vX5MKG/e3/SCuxbPxD+M38C/7wYn2SumE29SpTj8d7rzZOSNO
         XJ8VGEh5oJwHjFc8ztj+cHdMju1JAqZWe471WJHu6wartHgeQKj5gDbCM3OgBa0YnroD
         lKwOCuCe5XORPdOFCElg+ERCXqZmFv418fpR6aGEYRp4gj6G2q0U56NdFgTLLq2l+ByB
         1PFQ==
X-Gm-Message-State: AOAM533LS6v/1/wT9S6q/zY4b0TfUSb1BFIAoKh5oXSnlpU8yWN+iP4E
        L05IskwJxwUGeOKJ08NKAOD6sBgEAEYOLa1VV4iTTQ==
X-Google-Smtp-Source: ABdhPJwP1HHCKcZxy6X+e0Bms/h1VpcsmX+KoWgwv5qu2dKntHFdMmYf/e2mEICECkUkU1kdjL37Qs8iz/0it4SvqNQ=
X-Received: by 2002:a17:902:c94e:b0:13f:1b02:e539 with SMTP id
 i14-20020a170902c94e00b0013f1b02e539mr32133251pla.72.1634636848802; Tue, 19
 Oct 2021 02:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211002233447.1105-1-digetx@gmail.com>
In-Reply-To: <20211002233447.1105-1-digetx@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 19 Oct 2021 11:47:17 +0200
Message-ID: <CAG3jFysa8G_fuGDfSLze-ovft3=gc5PXLaPtwTkC2_e0itQYNw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Improvements for TC358768 DSI bridge driver
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Andreas Westman Dorcsak <hedmoo@yahoo.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next

On Sun, 3 Oct 2021 at 01:35, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> This series adds couple improvements to the TC358768 DSI bridge driver,
> enabling Panasonic VVX10F004B00 DSI panel support. This panel is used by
> ASUS Transformer TF700T tablet, which is ready for upstream kernel and
> display panel support is the biggest missing part.
>
> Dmitry Osipenko (5):
>   drm/bridge: tc358768: Enable reference clock
>   drm/bridge: tc358768: Support pulse mode
>   drm/bridge: tc358768: Calculate video start delay
>   drm/bridge: tc358768: Disable non-continuous clock mode
>   drm/bridge: tc358768: Correct BTACNTRL1 programming
>
>  drivers/gpu/drm/bridge/tc358768.c | 94 +++++++++++++++++++++++--------
>  1 file changed, 71 insertions(+), 23 deletions(-)
>
> --
> 2.32.0
>
