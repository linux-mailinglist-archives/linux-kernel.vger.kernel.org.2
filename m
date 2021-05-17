Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CE33827CA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 11:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhEQJHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 05:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhEQJHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 05:07:22 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3278C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:06:05 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id c16so5475133ilo.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 02:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hhBsFoPhptVa9URs6mSG4ZbNLPUTyIwgN05U7hJwC9Y=;
        b=I18S2Ws4GXN8FkRQGVN44p70lrOeDbCwwxy2JNL33usq6DMThhDbsztztNkzxy2ECD
         SIbJ9IJ1vXEkm5dkOfwL49+pjRR9jvx+hkuHiTCaSxb7CgVu+xH46ree6wwllUvzcFwD
         wlj0ogH4TPJXDCYmhQZekW09cWzwAXvB2F2QbG2vfvaGIiRj8eic72eJmMwrV4mzNs35
         xpRKTOjfOm0CsHUvjbfcHYzVOTAOK8wMaSWQ81YPNkZBzGjphwrYAY+smuY+25j2ZQKc
         kaqB4jUyY6r4DQNlkP0GJnHzHEfXXEJewixtP9INqFJIBW0MOKaFRbxIs0d1sYqRAijV
         tYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hhBsFoPhptVa9URs6mSG4ZbNLPUTyIwgN05U7hJwC9Y=;
        b=Q+QojOwxmCoHA626vy9RFvcQj0e1M/UcpB8OZaaeMy4mAYqxUn8BHymVM5DuljOh21
         IQJpAMY3RM9vHAEIXbJaIKWO8XbXMCGCJHS5abTtHZMcGV1haQnLCI5i20d9bgyLUEzq
         upwNVA+0fSL8u4dnUXPUTD7k36lzZfDX3r1JsNazR4N07/R1AD7ROhoHkHhoeQhY4Oi0
         j9KfmpNaZFSMLUTVZmxW54tlXd0JmG8Fx7VmQ9LL5xggrDHObQe7Qehh81rh+beVVbdy
         BKa5O/JB8+BfNKNuzXjLCPSGT9DwG/u0HrTTfS2Tz0f1pZDkoGsbtmwmNT+yUchpxDsb
         pgEQ==
X-Gm-Message-State: AOAM533mwvTZRhiSU2vyqaIqu2LA6oQpFZuusynkqoaAAQc83hukq6ty
        hb8NA7AjaNe+zL9XRHeCGiaQejz/6xYiShlyk83z5Q==
X-Google-Smtp-Source: ABdhPJwFIdD7WIAmMb0ftSFmMfOmbQ2rPnD0CLUqSD5jJWRXpFILUElK+6sgSg7DIonnb5hq79j/mfF6Kn/fdqZe/mk=
X-Received: by 2002:a05:6e02:92f:: with SMTP id o15mr5689524ilt.127.1621242365082;
 Mon, 17 May 2021 02:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210517063553.554955-1-pihsun@chromium.org> <20210517063553.554955-2-pihsun@chromium.org>
In-Reply-To: <20210517063553.554955-2-pihsun@chromium.org>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 17 May 2021 17:05:54 +0800
Message-ID: <CA+Px+wWRqpsF+P8wZXfN1LAEEb2pAUc5S9KJvaP=yEeevUDtyw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] drm/bridge: anx7625: add suspend / resume hooks
To:     Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Xin Ji <xji@analogixsemi.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2021 at 2:36 PM Pi-Hsun Shih <pihsun@chromium.org> wrote:
>
> Add suspend / resume hooks for anx7625 driver, that power off the device
> on suspend and power on the device on resume if it was previously
> powered.
>
> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@google.com>
