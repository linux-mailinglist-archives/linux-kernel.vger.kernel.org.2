Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6125F3A8F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 05:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhFPD0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 23:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFPD0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 23:26:18 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44434C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 20:24:13 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id h3so1053660ilc.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 20:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YA26c0WgklFmOg82MgKTjTjO0sY3gVklMj2bO9rVAu0=;
        b=iGdaSoSqd739RMNj/eJqEo/MweI9jtwL6wVaavwiCjDiNWAdx6gqWhcuxzbDtaLJNJ
         EODVwiegDPjxOdWfWXkQ8nABhkep8R+VX4VHU+ckRvVM5HknT8eflIu0vrSWXJZamVby
         gx+GUsS4hC1JWCO73V41VG1id7HqYCZRRuZZdqGB6hRg056SgCRALq3/ikTGlnF/t7H4
         ke6d3ueyWiavRXzq1q/ycl8/8dxtpoYbOS0Oakvz7zWQDCcYPId00cSBUQVjWAzJlGNy
         HsH62v9Rz9EpQtEoiD5rdgPRF95CZz3408ViZ1wpvdSd6shNBLBe1JOUb6w5aHXxqC3l
         zFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YA26c0WgklFmOg82MgKTjTjO0sY3gVklMj2bO9rVAu0=;
        b=IxJy0BqyIhliAGUpTvIW969YJXqbL5aonITnkiJMYWonCeGNnYgA43MeSjdULfAuGA
         gFYfEiCuxiYWzENknftgOHDjd8Fgg0qS7grfrSW+FMHHONohTV9K2mqW/5gA9OwqJt9f
         Lxo7bmX1SNnfUhSk63rSsHSczu9skpfjYMGv+tE7o32sPgjrViG9wMkigwtSkDDHtBq3
         +e1/ZJIu1upsoDasyjftW5YNnitM1zkQqplFdmbI9Th5OyAXtFNk8nHikwanp/bZgvtE
         yGpuo6hgpCVgVH8Uu9hDuiZ4Gkm7VNZ7eakFaWMz8LQ7CmJ5lqWAX0SBo9HntyolaETC
         EshQ==
X-Gm-Message-State: AOAM531MNk3/X+U3kCqxXHILyHXq4eSgeVyqTXXbmfVmJpUSIFHv9PGM
        pZRoL31cU3nFK79iFiQbDrZdisgPShTPiGeksZyr1g==
X-Google-Smtp-Source: ABdhPJyyxyeuaYtFnpr6WfgOhJUwLEYE24GDaFa2bQr+xy41jlzLnrwK5ivjrzCB63+CCfmwtVA9FwnJJW2H1wIa12I=
X-Received: by 2002:a05:6e02:5a3:: with SMTP id k3mr2039637ils.302.1623813852429;
 Tue, 15 Jun 2021 20:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210615032937.2328468-1-pihsun@chromium.org>
In-Reply-To: <20210615032937.2328468-1-pihsun@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Wed, 16 Jun 2021 11:24:01 +0800
Message-ID: <CA+Px+wXsb69fyQ41aX9T0jXzKFoF+6Y0zO+QJcLkxfTJJNa1hQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Make hpd workqueue freezable
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
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

On Tue, Jun 15, 2021 at 11:29 AM Pi-Hsun Shih <pihsun@chromium.org> wrote:
> Fixes: 409776fa3c42 ("drm/bridge: anx7625: add suspend / resume hooks")
>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
