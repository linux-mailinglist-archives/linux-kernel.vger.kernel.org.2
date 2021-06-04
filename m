Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5989B39C2CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbhFDVqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbhFDVqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:46:39 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763D5C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 14:44:52 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id f12so13388105ljp.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GjsAN50ddWQm0VC6qlRfoB/dT6P+8ZqVwoy/BYE0lSw=;
        b=ZHc08C+7Ibj69IVBB82goPegus+bAv9YuQoOVi9q9e+hDWENTWGrYTASzVNJNr28ii
         Y7E/XifFGi5YsoiMtuln3nFJzi2+VJCSGQifDJJetuD0tsRwjsUij7KR3i4O/1s7/3zi
         NClVAgpjP25K3UUqeUWYveb0ihfXIfOH8FXpzYyYITm9evxiETFUQQyyz1+dWm+nDBF9
         UGnPUZMzC41fMqye9lXdyLOk94SDBWRCYO2+bTTfW/RSjLuVtL3W3yZXtW3bi4ayGkTn
         oATemphAWOJ1r8/n4NB/XtZY3Udzt9Me9nva7gNm8ZzkEcvIV122BSG5Zrs89Wj4tWxA
         hrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GjsAN50ddWQm0VC6qlRfoB/dT6P+8ZqVwoy/BYE0lSw=;
        b=PpdZGNGaAoDk1VriNdQAfFKe0D/6DmvRSrDiCssO3dAG8D1+SwDbMXsqP6H03ibUjW
         5fwGxDx41+iyYHm2Lrn5OjRiOVwpxv7EuI4eEXQ1b/NiWqbV825FUx0OFiaKWvYY4a6H
         DnOpdxZ7fsNVImYOxKUGPMK4CZbCtGVwHI4aZIs/b5RX0WyqDxBL18t5aOaMmqebxlu9
         PgsbdUp9aRMDABjqhH0KYLct63rirK4Rrd1J9VvG0i4cAZ5e+w0TlvkGvCKYye+lQMPe
         wu8ve+FcYBTAQTCbhR+74LHbcXPR5P0Ksh3vLN+ktSdO4ibxSnFy9kjvS4HmioqIwmEJ
         CI+A==
X-Gm-Message-State: AOAM530sJxZHEmFwEdx166pNJThfD1aPZf6foMBJRUzudY46r8/nrO1T
        uo7oZTtHrUsqzMhv5GoI4KK4WycoNFwllDKvlUuRXA==
X-Google-Smtp-Source: ABdhPJyTRsaaVHVr9ofHVNMandAQLLoQSDxGJmUjBgJVRYEe9VRABdJWRzIKKzECxAYGWrgvTi3XmPiP37aKMIkjmIU=
X-Received: by 2002:a2e:889a:: with SMTP id k26mr4923550lji.438.1622843090808;
 Fri, 04 Jun 2021 14:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210524131852.263883-1-maxime@cerno.tech>
In-Reply-To: <20210524131852.263883-1-maxime@cerno.tech>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 4 Jun 2021 23:44:39 +0200
Message-ID: <CACRpkdbpfJ6Kc-W3jQNKZqwqy+utSV02NC26KEEA14eXtk9vMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/vc4: hdmi: Fix error path of hpd-gpios
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Eric Anholt <eric@anholt.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 3:19 PM Maxime Ripard <maxime@cerno.tech> wrote:

> If the of_get_named_gpio_flags call fails in vc4_hdmi_bind, we jump to
> the err_unprepare_hsm label. That label will then call
> pm_runtime_disable and put_device on the DDC device.
>
> We just retrieved the DDC device, so the latter is definitely justified.
> However at that point we still haven't called pm_runtime_enable, so the
> call to pm_runtime_disable is not supposed to be there.
>
> Fixes: 10ee275cb12f ("drm/vc4: prepare for CEC support")
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
